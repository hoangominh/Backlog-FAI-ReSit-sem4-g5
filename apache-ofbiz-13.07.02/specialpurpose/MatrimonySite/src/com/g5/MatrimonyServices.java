package com.g5;

import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

import org.ofbiz.base.crypto.HashCrypt;
import org.ofbiz.base.util.Debug;
import org.ofbiz.base.util.UtilMisc;
import org.ofbiz.base.util.UtilProperties;
import org.ofbiz.base.util.UtilValidate;
import org.ofbiz.entity.Delegator;
import org.ofbiz.entity.GenericEntityException;
import org.ofbiz.entity.GenericValue;
import org.ofbiz.entity.condition.EntityCondition;
import org.ofbiz.entity.condition.EntityJoinOperator;
import org.ofbiz.entity.transaction.GenericTransactionException;
import org.ofbiz.entity.transaction.TransactionUtil;
import org.ofbiz.entity.util.EntityFindOptions;
import org.ofbiz.entity.util.EntityUtil;
import org.ofbiz.service.DispatchContext;
import org.ofbiz.service.LocalDispatcher;
import org.ofbiz.service.ServiceUtil;

import javolution.util.FastList;
import javolution.util.FastMap;

public class MatrimonyServices {
	public static final String module = MatrimonyServices.class.getName();
    public static final String resource = "MatrimonySiteUiLabels";
    
	public static Map<String, Object> getGeoData(DispatchContext ctx, Map<String, ? extends Object> context)
			throws GenericEntityException {
		Map<String, Object> result = FastMap.newInstance();
		Delegator delegator = ctx.getDelegator();
		String geoTypeId = (String) context.get("geoTypeId");
		List<EntityCondition> conditions = FastList.newInstance();
		conditions.add(EntityCondition.makeCondition(UtilMisc.toMap("geoTypeId", geoTypeId)));
		List<GenericValue> listGeoAssoc = delegator.findList("GeoAssoc",
				EntityCondition.makeCondition(UtilMisc.toMap("geoId", "VNM")), UtilMisc.toSet("geoIdTo"), null, null, false);
		List<String> listGeoIdTo = EntityUtil.getFieldListFromEntityList(listGeoAssoc, "geoIdTo", true);
		conditions.add(EntityCondition.makeCondition("geoId", EntityJoinOperator.IN, listGeoIdTo));
		EntityFindOptions options = new EntityFindOptions();
		List<GenericValue> listGeo = delegator.findList("Geo", EntityCondition.makeCondition(conditions, EntityJoinOperator.AND),
				UtilMisc.toSet("geoId", "geoName"), UtilMisc.toList("geoId ASC"), options, false);
		result.put("listGeo", listGeo);
		return result;
	}
	public static Map<String, Object> getCaste(DispatchContext ctx, Map<String, ? extends Object> context)
			throws GenericEntityException {
		Map<String, Object> result = FastMap.newInstance();
		Delegator delegator = ctx.getDelegator();
		List<GenericValue> listCaste = delegator.findList("Caste", null, null, null, null, false);
		result.put("listCaste", listCaste);
		return result;
	}
	public static Map<String, Object> createAccount(DispatchContext ctx, Map<String, ? extends Object> context) throws GenericTransactionException {
		Map<String, Object> result = ServiceUtil.returnSuccess();
		Delegator delegator = ctx.getDelegator();
		LocalDispatcher dispatcher = ctx.getDispatcher();
		Long birthDateL = (Long) context.get("birthDate");
		java.sql.Date birthDate = null;
		if (UtilValidate.isNotEmpty(birthDateL)) {
			birthDate = new java.sql.Date(birthDateL);
		}
		boolean beganTx = TransactionUtil.begin(7200);
		try {
//			createPerson
			Map<String, Object> resultCreatePerson = dispatcher.runSync("createPerson",
					UtilMisc.toMap("firstName", context.get("firstName"), "middleName", context.get("middleName"), "lastName", context.get("lastName"),
							"gender", context.get("gender"), "maritalStatus", context.get("maritalStatus"), "height", context.get("height"),
							"motherTongue", context.get("motherTongue"), "religion", context.get("religion"), "casteId", context.get("casteId"),
							"birthDate", birthDate, "statusId", "PARTY_ENABLED", "comments", context.get("payment")));
			String partyId = (String) resultCreatePerson.get("partyId");
//			createUserLogin
			boolean useEncryption = "true".equals(UtilProperties.getPropertyValue("security.properties", "password.encrypt"));
			String currentPassword = (String) context.get("currentPassword");
			currentPassword = useEncryption ? HashCrypt.cryptUTF8(getHashType(), null, currentPassword) : currentPassword;
			GenericValue userLogin = delegator.makeValue("UserLogin",
					UtilMisc.toMap("userLoginId", context.get("userLoginId"), "enabled", "Y", "currentPassword", currentPassword,
							"requirePasswordChange", "N", "partyId", partyId));
			delegator.create(userLogin);
//			UserLoginSecurityGroup
			delegator.create("UserLoginSecurityGroup",
					UtilMisc.toMap("userLoginId", context.get("userLoginId"), "groupId", "SUPER", "fromDate", new Timestamp(System.currentTimeMillis())));
//			createTelecomNumber
			Map<String, Object> resultCreateTelecomNumber = dispatcher.runSync("createTelecomNumber",
					UtilMisc.toMap("contactNumber", context.get("contactNumber"), "askForName", context.get("firstName"), "userLogin", userLogin));
			String contactMechId = (String) resultCreateTelecomNumber.get("contactMechId");
//			createPartyContactMech TELECOM_NUMBER
			dispatcher.runSync("createPartyContactMech",
					UtilMisc.toMap("partyId", partyId, "contactMechId", contactMechId, "allowSolicitation", "Y", "userLogin", userLogin));
//			createPartyContactMechPurpose TELECOM_NUMBER
			dispatcher.runSync("createPartyContactMechPurpose",
					UtilMisc.toMap("partyId", partyId, "contactMechId", contactMechId, "contactMechPurposeTypeId", "PRIMARY_PHONE", "userLogin", userLogin));
			
//			createPartyContactMech EMAIL_ADDRESS
			Map<String, Object> resultCreateEmail = dispatcher.runSync("createPartyContactMech",
					UtilMisc.toMap("partyId", partyId, "contactMechTypeId", "EMAIL_ADDRESS", "infoString", context.get("email"),
							"allowSolicitation", "Y", "userLogin", userLogin));
			contactMechId = (String) resultCreateEmail.get("contactMechId");
//			createPartyContactMechPurpose EMAIL_ADDRESS
			dispatcher.runSync("createPartyContactMechPurpose",
					UtilMisc.toMap("partyId", partyId, "contactMechId", contactMechId, "contactMechPurposeTypeId", "PRIMARY_EMAIL", "userLogin", userLogin));
			Map<String, Object> resultCreatePostalAddress = dispatcher.runSync("createPostalAddress",
					UtilMisc.toMap("toName", context.get("firstName"), "city", context.get("city"), "stateProvinceGeoId", context.get("city"),
							"address1", context.get("city"), "postalCode", "70000", "userLogin", userLogin));
			contactMechId = (String) resultCreatePostalAddress.get("contactMechId");
//			createPartyContactMech POSTAL_ADDRESS
			dispatcher.runSync("createPartyContactMech",
					UtilMisc.toMap("partyId", partyId, "contactMechId", contactMechId, "allowSolicitation", "Y", "userLogin", userLogin));
//			createPartyContactMechPurpose POSTAL_ADDRESS
			dispatcher.runSync("createPartyContactMechPurpose",
					UtilMisc.toMap("partyId", partyId, "contactMechId", contactMechId, "contactMechPurposeTypeId", "PRIMARY_LOCATION", "userLogin", userLogin));
		} catch (Exception e) {
			TransactionUtil.rollback(beganTx, e.getMessage(), e);
			e.printStackTrace();
		}
		TransactionUtil.commit(beganTx);
		return result;
	}
	public static String getHashType() {
        String hashType = UtilProperties.getPropertyValue("security.properties", "password.encrypt.hash.type");

        if (UtilValidate.isEmpty(hashType)) {
            Debug.logWarning("Password encrypt hash type is not specified in security.properties, use SHA", module);
            hashType = "SHA";
        }

        return hashType;
    }
}

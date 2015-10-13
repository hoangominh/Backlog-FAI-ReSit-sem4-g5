package com.g5;

import java.sql.Timestamp;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Locale;
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
import org.ofbiz.entity.condition.EntityOperator;
import org.ofbiz.entity.transaction.GenericTransactionException;
import org.ofbiz.entity.transaction.TransactionUtil;
import org.ofbiz.entity.util.EntityFindOptions;
import org.ofbiz.entity.util.EntityUtil;
import org.ofbiz.service.DispatchContext;
import org.ofbiz.service.GenericServiceException;
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
		Long thruDateL = (Long) context.get("thruDate");
		java.sql.Date birthDate = null;
		Timestamp thruDate = null;
		if (UtilValidate.isNotEmpty(birthDateL)) {
			birthDate = new java.sql.Date(birthDateL);
		}
		if (UtilValidate.isNotEmpty(thruDateL)) {
			thruDate = new Timestamp(thruDateL);
		}
		boolean beganTx = TransactionUtil.begin(7200);
		try {
//			createPerson
			Map<String, Object> resultCreatePerson = dispatcher.runSync("createPerson",
					UtilMisc.toMap("firstName", context.get("firstName"), "middleName", context.get("middleName"), "lastName", context.get("lastName"),
							"gender", context.get("gender"), "maritalStatus", context.get("maritalStatus"), "height", context.get("height"),
							"motherTongue", context.get("motherTongue"), "religion", context.get("religion"), "casteId", context.get("casteId"),
							"birthDate", birthDate, "statusId", "PARTY_ENABLED", "comments", context.get("comments")));
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
//			createPostalAddress POSTAL_ADDRESS
			Map<String, Object> resultCreatePostalAddress = dispatcher.runSync("createPostalAddress",
					UtilMisc.toMap("toName", context.get("firstName"), "city", context.get("city"), "stateProvinceGeoId", context.get("city"),
							"address1", context.get("city"), "postalCode", "70000", "userLogin", userLogin));
			contactMechId = (String) resultCreatePostalAddress.get("contactMechId");
//			createPartyContactMech POSTAL_ADDRESS
			dispatcher.runSync("createPartyContactMech",
					UtilMisc.toMap("partyId", partyId, "contactMechId", contactMechId, "allowSolicitation", "Y", "userLogin", userLogin));
//			createPartyContactMechPurpose PRIMARY_LOCATION
			dispatcher.runSync("createPartyContactMechPurpose",
					UtilMisc.toMap("partyId", partyId, "contactMechId", contactMechId, "contactMechPurposeTypeId", "PRIMARY_LOCATION", "userLogin", userLogin));
			GenericValue admin = delegator.findOne("UserLogin", UtilMisc.toMap("userLoginId", "admin"), false);
//			createPartyRole FRIEND for customer
			dispatcher.runSync("createPartyRole",
					UtilMisc.toMap("partyId", partyId, "roleTypeId", "FRIEND", "userLogin", admin));
//			createPartyRole CUSTOMER for customer
			dispatcher.runSync("createPartyRole",
					UtilMisc.toMap("partyId", partyId, "roleTypeId", "CUSTOMER", "userLogin", admin));
//			createPartyRelationship between person and corporation
				dispatcher.runSync("createPartyRelationship",
						UtilMisc.toMap("partyIdFrom", "Company", "partyIdTo", partyId, "roleTypeIdFrom", "INTERNAL_ORGANIZATIO",
								"roleTypeIdTo", "CUSTOMER", "partyRelationshipTypeId", "CUSTOMER_REL", "thruDate", thruDate, "userLogin", admin));
		} catch (Exception e) {
			TransactionUtil.rollback(beganTx, e.getMessage(), e);
			e.printStackTrace();
		}
		TransactionUtil.commit(beganTx);
		return result;
	}
	public static Map<String, Object> updateAccount(DispatchContext ctx, Map<String, ? extends Object> context) throws GenericEntityException {
		Map<String, Object> result = ServiceUtil.returnSuccess();
		Delegator delegator = ctx.getDelegator();
		LocalDispatcher dispatcher = ctx.getDispatcher();
		Long birthDateL = (Long) context.get("birthDate");
		java.sql.Date birthDate = null;
		if (UtilValidate.isNotEmpty(birthDateL)) {
			birthDate = new java.sql.Date(birthDateL);
		}
		String partyId = (String) context.get("partyId");
		GenericValue admin = delegator.findOne("UserLogin", UtilMisc.toMap("userLoginId", "admin"), false);
		boolean beganTx = TransactionUtil.begin(7200);
		try {
//			updatePerson
			dispatcher.runSync("updatePerson",
					UtilMisc.toMap("partyId", partyId, "firstName", context.get("firstName"), "middleName", context.get("middleName"), "lastName", context.get("lastName"),
							"gender", context.get("gender"), "maritalStatus", context.get("maritalStatus"), "height", context.get("height"),
							"motherTongue", context.get("motherTongue"), "religion", context.get("religion"), "casteId", context.get("casteId"), "comments", context.get("comments"),
							"birthDate", birthDate, "userLogin", admin));
//			update PRIMARY_PHONE
			GenericValue TelecomNumber = delegator.makeValue("TelecomNumber", UtilMisc.toMap("contactMechId", context.get("contactNumberCMI"),
					"contactNumber", context.get("contactNumber"), "askForName", context.get("firstName")));
			delegator.createOrStore(TelecomNumber);
			
//			update PRIMARY_EMAIL
			GenericValue ContactMech = delegator.makeValue("ContactMech", UtilMisc.toMap("contactMechId", context.get("emailCMI"),
					"infoString", context.get("email")));
			delegator.createOrStore(ContactMech);
			
//			update PRIMARY_LOCATION
			GenericValue PostalAddress = delegator.makeValue("PostalAddress", UtilMisc.toMap("contactMechId", context.get("cityCMI"),
					"toName", context.get("firstName"), "city", context.get("city"), "stateProvinceGeoId", context.get("city"),
					"address1", context.get("city")));
			delegator.createOrStore(PostalAddress);
			
		} catch (Exception e) {
			TransactionUtil.rollback(beganTx, e.getMessage(), e);
			e.printStackTrace();
		}
		TransactionUtil.commit(beganTx);
		return result;
	}
	public static Map<String, Object> renewalsAccount(DispatchContext ctx, Map<String, ? extends Object> context) throws GenericEntityException {
		Map<String, Object> result = ServiceUtil.returnSuccess();
		Delegator delegator = ctx.getDelegator();
		LocalDispatcher dispatcher = ctx.getDispatcher();
		GenericValue admin = delegator.findOne("UserLogin", UtilMisc.toMap("userLoginId", "admin"), false);
		Long thruDateL = (Long) context.get("thruDate");
		Timestamp thruDate = null;
		if (UtilValidate.isNotEmpty(thruDateL)) {
			thruDate = new Timestamp(thruDateL);
		}
		Long fromDateL = (Long) context.get("fromDate");
		Timestamp fromDate = null;
		if (UtilValidate.isNotEmpty(fromDateL)) {
			fromDate = new Timestamp(fromDateL);
		}
		boolean beganTx = TransactionUtil.begin(7200);
		if (UtilValidate.isEmpty(fromDate)) {
			fromDate = new Timestamp(System.currentTimeMillis());
			try {
//				createPartyRole CUSTOMER
				dispatcher.runSync("createPartyRole",
						UtilMisc.toMap("partyId", context.get("partyId"), "roleTypeId", "CUSTOMER", "userLogin", admin));
//				createPartyRelationship between person and corporation
					dispatcher.runSync("createPartyRelationship",
							UtilMisc.toMap("partyIdFrom", "Company", "partyIdTo", context.get("partyId"), "roleTypeIdFrom", "INTERNAL_ORGANIZATIO",
									"roleTypeIdTo", "CUSTOMER", "partyRelationshipTypeId", "CUSTOMER_REL", "thruDate", thruDate, "userLogin", admin));
			} catch (Exception e) {
				TransactionUtil.rollback(beganTx, e.getMessage(), e);
				e.printStackTrace();
			}
		} else {
			try {
//				updatePartyRelationship
				dispatcher.runSync("updatePartyRelationship",
						UtilMisc.toMap("partyIdFrom", "Company", "partyIdTo", context.get("partyId"), "roleTypeIdFrom", "INTERNAL_ORGANIZATIO",
								"roleTypeIdTo", "CUSTOMER", "partyRelationshipTypeId", "CUSTOMER_REL", "thruDate", thruDate,
								"fromDate", fromDate, "userLogin", admin));
			} catch (Exception e) {
				TransactionUtil.rollback(beganTx, e.getMessage(), e);
				e.printStackTrace();
			}
		}
		result.put("thruDate", thruDate.getTime());
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
	public static Map<String, Object> loadProfile(DispatchContext ctx, Map<String, ? extends Object> context)
			throws GenericEntityException {
		Map<String, Object> result = FastMap.newInstance();
		Map<String, Object> profile = FastMap.newInstance();
		Delegator delegator = ctx.getDelegator();
		Locale locale = (Locale) context.get("locale");
		GenericValue userLogin = (GenericValue) context.get("userLogin");
		String partyId = (String) context.get("partyId");
		if (UtilValidate.isEmpty(partyId)) {
			partyId = userLogin.getString("partyId");
		}
//		get basic info
		GenericValue person = delegator.findOne("PersonAndCaste", UtilMisc.toMap("partyId", partyId), false);
		if (UtilValidate.isEmpty(person)) {
			return result;
		}
		profile.put("partyId", person.getString("partyId"));
		profile.put("partyFullName", person.getString("partyFullName"));
		profile.put("firstName", person.getString("firstName"));
		profile.put("middleName", person.getString("middleName"));
		profile.put("lastName", person.getString("lastName"));
		profile.put("gender", person.getString("gender"));
		profile.put("genderDetails", UtilProperties.getMessage(resource, person.getString("gender"), locale));
		profile.put("maritalStatus", person.getString("maritalStatus"));
		profile.put("maritalStatusDetails", UtilProperties.getMessage(resource, person.getString("maritalStatus"), locale));
		profile.put("motherTongue", person.getString("motherTongue"));
		profile.put("religion", person.getString("religion"));
		profile.put("casteId", person.getString("casteId"));
		profile.put("casteName", person.getString("casteName"));
		profile.put("comments", person.getString("comments"));
		profile.put("birthDate", person.getDate("birthDate").toString());
		profile.put("height", person.getDouble("height"));
		
//		get account info
		List<GenericValue> userLogins = delegator.findList("UserLogin", 
				EntityCondition.makeCondition(UtilMisc.toMap("partyId", partyId)), UtilMisc.toSet("userLoginId"), null, null, false);
		if (UtilValidate.isNotEmpty(userLogins)) {
			profile.putAll(EntityUtil.getFirst(userLogins));
		}
//		get expired date account
		List<GenericValue> partyRelationships = delegator.findList("PartyRelationship", 
				EntityCondition.makeCondition(UtilMisc.toMap("partyIdFrom", "Company", "partyIdTo", partyId, "roleTypeIdFrom", "INTERNAL_ORGANIZATIO",
						"roleTypeIdTo", "CUSTOMER", "partyRelationshipTypeId", "CUSTOMER_REL")), null, null, null, false);
		if (UtilValidate.isNotEmpty(partyRelationships)) {
			profile.put("thruDate", EntityUtil.getFirst(partyRelationships).getTimestamp("thruDate"));
			profile.put("fromDate", EntityUtil.getFirst(partyRelationships).getTimestamp("fromDate"));
		} else {
			profile.put("thruDate", "N_A");
		}
//		get contact info
		List<EntityCondition> conditions = FastList.newInstance();
		conditions.add(EntityCondition.makeCondition(EntityUtil.getFilterByDateExpr()));
		conditions.add(EntityCondition.makeCondition(UtilMisc.toMap("partyId", partyId)));
		List<GenericValue> partyContactMechPurposes = delegator.findList("PartyContactMechPurpose", 
				EntityCondition.makeCondition(conditions), null, null, null, false);
		for (GenericValue x : partyContactMechPurposes) {
			String contactMechPurposeTypeId = x.getString("contactMechPurposeTypeId");
			String contactMechId = x.getString("contactMechId");
			switch (contactMechPurposeTypeId) {
			case "PRIMARY_PHONE":
				GenericValue telecomNumber = delegator.findOne("TelecomNumber", UtilMisc.toMap("contactMechId", contactMechId), false);
				if (UtilValidate.isNotEmpty(telecomNumber)) {
					profile.put("contactNumber", telecomNumber.getString("contactNumber"));
					profile.put("contactNumberCMI", contactMechId);
				}
				break;
			case "PRIMARY_EMAIL":
				GenericValue contactMech = delegator.findOne("ContactMech", UtilMisc.toMap("contactMechId", contactMechId), false);
				if (UtilValidate.isNotEmpty(contactMech)) {
					profile.put("email", contactMech.getString("infoString"));
					profile.put("emailCMI", contactMechId);
				}
				break;
			case "PRIMARY_LOCATION":
				GenericValue postalAddress = delegator.findOne("PostalAddress", UtilMisc.toMap("contactMechId", contactMechId), false);
				if (UtilValidate.isNotEmpty(postalAddress)) {
					profile.put("city", postalAddress.getString("stateProvinceGeoId"));
					profile.put("cityCMI", contactMechId);
					GenericValue geo = delegator.findOne("Geo", UtilMisc.toMap("geoId", postalAddress.getString("stateProvinceGeoId")), false);
					if (UtilValidate.isNotEmpty(geo)) {
						profile.put("cityDetails", geo.getString("geoName"));
					}
				}
				break;
			default:
				break;
			}
		}
		result.put("profile", profile);
		return result;
	}
	public static Map<String, Object> listFriendsMayKnow(DispatchContext ctx, Map<String, ? extends Object> context)
			throws GenericEntityException, GenericServiceException {
		Map<String, Object> result = FastMap.newInstance();
		Delegator delegator = ctx.getDelegator();
		Locale locale = (Locale) context.get("locale");
		String userLoginPartyId = (String) context.get("userLoginPartyId");
		String partyFullName = (String) context.get("partyFullName");
		String gender = (String) context.get("gender");
		String city = (String) context.get("city");
		String casteId = (String) context.get("casteId");
		String maritalStatus = (String) context.get("maritalStatus");
		
		List<Map<String, Object>> listFriendsMayKnow = FastList.newInstance();
		List<String> allCustomerIds = getPartiesByRolesAndPartyFromAndStatusRelationShip("Company", "INTERNAL_ORGANIZATIO", "CUSTOMER", delegator, true);
//		TODO: now get friendIds by All customer but will get friendIds by conditions of user
		List<String> friendIds = allCustomerIds;
		friendIds.remove(userLoginPartyId);
		List<EntityCondition> conditions = FastList.newInstance();
		conditions.add(EntityCondition.makeCondition("partyId", EntityJoinOperator.IN, friendIds));
		if (UtilValidate.isNotEmpty(partyFullName)) {
			conditions.add(EntityCondition.makeCondition("partyFullName", EntityJoinOperator.LIKE, "%" + partyFullName + "%"));
		}
		if (UtilValidate.isNotEmpty(gender)) {
			conditions.add(EntityCondition.makeCondition("gender", EntityJoinOperator.EQUALS, gender));
		}
		if (UtilValidate.isNotEmpty(city)) {
			List<String> partiesInCity = getPartiesByCity(delegator, city);
			conditions.add(EntityCondition.makeCondition("partyId", EntityJoinOperator.IN, partiesInCity));
		}
		if (UtilValidate.isNotEmpty(casteId)) {
			conditions.add(EntityCondition.makeCondition("casteId", EntityJoinOperator.EQUALS, casteId));
		}
		if (UtilValidate.isNotEmpty(maritalStatus)) {
			conditions.add(EntityCondition.makeCondition("maritalStatus", EntityJoinOperator.EQUALS, maritalStatus));
		}
		List<GenericValue> person = delegator.findList("PersonAndCaste",
				EntityCondition.makeCondition(conditions), UtilMisc.toSet("partyId", "partyFullName", "casteName", "gender", "comments"), UtilMisc.toList("firstName"), null, false);
		List<Map<String, Object>> listOncePage = FastList.newInstance();
		int subPage = 0;
		for (GenericValue x : person) {
			Map<String, Object> statusRelationShip = getStatusRelationShip(delegator, userLoginPartyId, x.getString("partyId"));
			String statusId = (String) statusRelationShip.get("statusId");
			String partyIdTo = (String) statusRelationShip.get("partyIdTo");
			if (UtilValidate.isNotEmpty(statusId)) {
				if (UtilMisc.toList("BLOCKING", "ACCEPTED", "CANCEL").contains(statusId) || userLoginPartyId.equals(partyIdTo)) {
					continue;
				}
			}
			Map<String, Object> mapOncePage = FastMap.newInstance();
			mapOncePage.putAll(x);
//			FIXME: hardcode image url /MatrimonySite/images/image/noavatar.jpg
			mapOncePage.put("avatar", "/MatrimonySite/images/image/noavatar.jpg");
			mapOncePage.put("city", getCityByPartyId(delegator, x.getString("partyId")));
			mapOncePage.put("genderDetails", UtilProperties.getMessage(resource, x.getString("gender"), locale));
			mapOncePage.put("statusId", statusId);
			mapOncePage.put("comments", x.getString("comments"));
			if ((subPage%3) == 0) {
				subPage = 0;
				listOncePage = FastList.newInstance();
				Map<String, Object> mapFriendsMayKnow = FastMap.newInstance();
				mapFriendsMayKnow.put("friends", listOncePage);
				listFriendsMayKnow.add(mapFriendsMayKnow);
			}
			subPage += 1;
			listOncePage.add(mapOncePage);
		}
		result.put("listFriendsMayKnow", listFriendsMayKnow);
		return result;
	}
	public static Map<String, Object> listFriendRequest(DispatchContext ctx, Map<String, ? extends Object> context)
			throws GenericEntityException, GenericServiceException {
		Map<String, Object> result = FastMap.newInstance();
		Delegator delegator = ctx.getDelegator();
		Locale locale = (Locale) context.get("locale");
		String userLoginPartyId = (String) context.get("userLoginPartyId");
		List<Map<String, Object>> listFriendRequest = FastList.newInstance();
		List<String> allCustomerIds = getPartiesByRolesAndPartyFromAndStatusRelationShip("Company", "INTERNAL_ORGANIZATIO", "CUSTOMER", delegator, true);
//		TODO: now get friendIds by All customer but will get friendIds by conditions of user
		List<String> friendIds = allCustomerIds;
		friendIds.remove(userLoginPartyId);
		List<EntityCondition> conditions = FastList.newInstance();
		conditions.add(EntityCondition.makeCondition("partyId", EntityJoinOperator.IN, friendIds));
		List<GenericValue> person = delegator.findList("PersonAndCaste",
				EntityCondition.makeCondition(conditions), UtilMisc.toSet("partyId", "partyFullName", "casteName", "gender", "comments"), UtilMisc.toList("firstName"), null, false);
		List<Map<String, Object>> listOncePage = FastList.newInstance();
		int subPage = 0;
		for (GenericValue x : person) {
			Map<String, Object> statusRelationShip = getStatusRelationShip(delegator, x.getString("partyId"), userLoginPartyId);
			String statusId = (String) statusRelationShip.get("statusId");
			String partyIdTo = (String) statusRelationShip.get("partyIdTo");
			if (!"REQUESTED".equals(statusId) || !userLoginPartyId.equals(partyIdTo)) {
				continue;
			}
			Map<String, Object> mapOncePage = FastMap.newInstance();
			mapOncePage.putAll(x);
//			FIXME: hardcode image url /MatrimonySite/images/image/noavatar.jpg
			mapOncePage.put("avatar", "/MatrimonySite/images/image/noavatar.jpg");
			mapOncePage.put("city", getCityByPartyId(delegator, x.getString("partyId")));
			mapOncePage.put("genderDetails", UtilProperties.getMessage(resource, x.getString("gender"), locale));
			mapOncePage.put("statusId", statusId);
			mapOncePage.put("comments", x.getString("comments"));
			mapOncePage.put("fromDate", statusRelationShip.get("fromDate"));
			if ((subPage%3) == 0) {
				subPage = 0;
				listOncePage = FastList.newInstance();
				Map<String, Object> mapFriendRequest = FastMap.newInstance();
				mapFriendRequest.put("friends", listOncePage);
				listFriendRequest.add(mapFriendRequest);
			}
			subPage += 1;
			listOncePage.add(mapOncePage);
		}
		result.put("listFriendRequest", listFriendRequest);
		return result;
	}
	public static Map<String, Object> listFriends(DispatchContext ctx, Map<String, ? extends Object> context)
			throws GenericEntityException, GenericServiceException {
		Map<String, Object> result = FastMap.newInstance();
		Delegator delegator = ctx.getDelegator();
		Locale locale = (Locale) context.get("locale");
		String userLoginPartyId = (String) context.get("userLoginPartyId");
		List<Map<String, Object>> listFriends = FastList.newInstance();
		List<String> friendIds = getPartiesByRolesAndPartyFromAndStatusRelationShip("Company", "INTERNAL_ORGANIZATIO", "CUSTOMER", delegator, true);
		friendIds.remove(userLoginPartyId);
		List<EntityCondition> conditions = FastList.newInstance();
		conditions.add(EntityCondition.makeCondition("partyId", EntityJoinOperator.IN, friendIds));
		List<GenericValue> person = delegator.findList("PersonAndCaste",
				EntityCondition.makeCondition(conditions), UtilMisc.toSet("partyId", "partyFullName", "casteName", "gender", "comments"), UtilMisc.toList("firstName"), null, false);
		List<Map<String, Object>> listOncePage = FastList.newInstance();
		int subPage = 0;
		for (GenericValue x : person) {
			Map<String, Object> statusRelationShip = getStatusRelationShip(delegator, x.getString("partyId"), userLoginPartyId);
			String statusId = (String) statusRelationShip.get("statusId");
			if (!"ACCEPTED".equals(statusId)) {
				continue;
			}
			Map<String, Object> mapOncePage = FastMap.newInstance();
			mapOncePage.putAll(x);
//			FIXME: hardcode image url /MatrimonySite/images/image/noavatar.jpg
			mapOncePage.put("avatar", "/MatrimonySite/images/image/noavatar.jpg");
			mapOncePage.put("city", getCityByPartyId(delegator, x.getString("partyId")));
			mapOncePage.put("genderDetails", UtilProperties.getMessage(resource, x.getString("gender"), locale));
			mapOncePage.put("statusId", statusId);
			mapOncePage.put("comments", x.getString("comments"));
			mapOncePage.put("fromDate", statusRelationShip.get("fromDate"));
			if ((subPage%3) == 0) {
				subPage = 0;
				listOncePage = FastList.newInstance();
				Map<String, Object> mapFriends = FastMap.newInstance();
				mapFriends.put("friends", listOncePage);
				listFriends.add(mapFriends);
			}
			subPage += 1;
			listOncePage.add(mapOncePage);
		}
		result.put("listFriends", listFriends);
		return result;
	}
	private static Map<String, Object> getStatusRelationShip(Delegator delegator, String partyIdFrom, String partyIdTo) throws GenericEntityException {
		Map<String, Object> result = FastMap.newInstance();
		List<EntityCondition> conditions = FastList.newInstance();
		conditions.add(EntityCondition.makeCondition(EntityUtil.getFilterByDateExpr()));
		conditions.add(EntityCondition.makeCondition(UtilMisc.toMap("roleTypeIdFrom", "FRIEND", "roleTypeIdTo", "FRIEND")));
		conditions.add(EntityCondition.makeCondition(UtilMisc.toList(
				EntityCondition.makeCondition(UtilMisc.toMap("partyIdFrom", partyIdFrom, "partyIdTo", partyIdTo)),
				EntityCondition.makeCondition(UtilMisc.toMap("partyIdFrom", partyIdTo, "partyIdTo", partyIdFrom))
				), EntityJoinOperator.OR));
		List<GenericValue> partyRelationships = delegator.findList("PartyRelationship",
				EntityCondition.makeCondition(conditions), UtilMisc.toSet("statusId", "fromDate", "partyIdFrom", "partyIdTo"), null, null, false);
		if (UtilValidate.isNotEmpty(partyRelationships)) {
			result.put("partyIdFrom", EntityUtil.getFirst(partyRelationships).getString("partyIdFrom"));
			result.put("partyIdTo", EntityUtil.getFirst(partyRelationships).getString("partyIdTo"));
			result.put("statusId", EntityUtil.getFirst(partyRelationships).getString("statusId"));
			result.put("fromDate", EntityUtil.getFirst(partyRelationships).getTimestamp("fromDate"));
		}
		return result;
	}
	private static List<String> getPartiesByCity(Delegator delegator, String stateProvinceGeoId) throws GenericEntityException {
		List<GenericValue> postalAddresses = delegator.findList("PostalAddress",
				EntityCondition.makeCondition("stateProvinceGeoId", EntityJoinOperator.EQUALS, stateProvinceGeoId),
				UtilMisc.toSet("contactMechId"), null, null, false);
		List<String> contactMechIds = EntityUtil.getFieldListFromEntityList(postalAddresses, "contactMechId", true);
		List<EntityCondition> conditions = FastList.newInstance();
		conditions.add(EntityCondition.makeCondition("contactMechId", EntityJoinOperator.IN, contactMechIds));
		conditions.add(EntityCondition.makeCondition("contactMechPurposeTypeId", EntityJoinOperator.EQUALS, "PRIMARY_LOCATION"));
		List<GenericValue> partyContactMechPurposes = delegator.findList("PartyContactMechPurpose",
				EntityCondition.makeCondition(conditions), UtilMisc.toSet("partyId"), null, null, false);
		if (UtilValidate.isNotEmpty(partyContactMechPurposes)) {
			return EntityUtil.getFieldListFromEntityList(partyContactMechPurposes, "partyId", true);
		}
		return null;
	}
	private static String getCityByPartyId(Delegator delegator, String partyId) throws GenericEntityException {
		List<EntityCondition> conditions = FastList.newInstance();
		conditions.add(EntityCondition.makeCondition(EntityUtil.getFilterByDateExpr()));
		conditions.add(EntityCondition.makeCondition(UtilMisc.toMap("partyId", partyId, "contactMechPurposeTypeId", "PRIMARY_LOCATION")));
		List<GenericValue> partyContactMechPurposes = delegator.findList("PartyContactMechPurpose", 
				EntityCondition.makeCondition(conditions), null, null, null, false);
		if (UtilValidate.isNotEmpty(partyContactMechPurposes)) {
			String contactMechId = EntityUtil.getFirst(partyContactMechPurposes).getString("contactMechId");
			GenericValue postalAddress = delegator.findOne("PostalAddress", UtilMisc.toMap("contactMechId", contactMechId), false);
			if (UtilValidate.isNotEmpty(postalAddress)) {
				GenericValue geo = delegator.findOne("Geo", UtilMisc.toMap("geoId", postalAddress.getString("stateProvinceGeoId")), false);
				if (UtilValidate.isNotEmpty(geo)) {
					return geo.getString("geoName");
				}
			}
		}
		return null;
	}
	public static List<String> getPartiesByRolesAndPartyFromAndStatusRelationShip(String partyIdFrom, String roleTypeIdFrom, String roleTypeIdTo, Delegator delegator, boolean filterByDateExpr) throws GenericEntityException{
		List<String> listParties = FastList.newInstance();
		List<EntityCondition> conditions = FastList.newInstance();
		if (filterByDateExpr) {
			conditions.add(EntityCondition.makeCondition(EntityUtil.getFilterByDateExpr()));
		}
		conditions.add(EntityCondition.makeCondition(UtilMisc.toMap("partyIdFrom", partyIdFrom, "roleTypeIdFrom", roleTypeIdFrom, "roleTypeIdTo", roleTypeIdTo)));
		List<GenericValue> listPartyRelationship = delegator.findList("PartyRelationship",
				EntityCondition.makeCondition(conditions, EntityJoinOperator.AND), null, null, null, false);
		for (GenericValue x : listPartyRelationship) {
			listParties.add(x.getString("partyIdTo"));
		}
		return listParties;
	}
	public static List<String> getPartiesByRolesAndPartyTo(String partyIdTo, String roleTypeIdFrom, String roleTypeIdTo, Delegator delegator, boolean filterByDateExpr) throws GenericEntityException{
		List<String> listParties = FastList.newInstance();
		List<EntityCondition> conditions = FastList.newInstance();
		if (filterByDateExpr) {
			conditions.add(EntityCondition.makeCondition(EntityUtil.getFilterByDateExpr()));
		}
		conditions.add(EntityCondition.makeCondition(UtilMisc.toMap("partyIdTo", partyIdTo, "roleTypeIdFrom", roleTypeIdFrom, "roleTypeIdTo", roleTypeIdTo)));
		List<GenericValue> listPartyRelationship = delegator.findList("PartyRelationship",
				EntityCondition.makeCondition(conditions, EntityJoinOperator.AND), null, null, null, false);
		for (GenericValue x : listPartyRelationship) {
			listParties.add(x.getString("partyIdFrom"));
		}
		return listParties;
	}
	@SuppressWarnings("unchecked")
	public static Map<String, Object> addFriend(DispatchContext ctx, Map<String, ? extends Object> context) throws GenericTransactionException{
		Map<String, Object> result = FastMap.newInstance();
		Delegator delegator = ctx.getDelegator();
		LocalDispatcher dispatcher = ctx.getDispatcher();
		Locale locale = (Locale) context.get("locale");
		boolean beganTx = TransactionUtil.begin(7200);
		try {
			GenericValue admin = delegator.findOne("UserLogin", UtilMisc.toMap("userLoginId", "admin"), false);
//			createPartyRelationship between two persons
			dispatcher.runSync("createPartyRelationship",
					UtilMisc.toMap("partyIdFrom", context.get("userLoginPartyId"), "partyIdTo", context.get("partyId"), "roleTypeIdFrom", "FRIEND",
							"roleTypeIdTo", "FRIEND", "partyRelationshipTypeId", "FRIEND", "statusId", "REQUESTED", "userLogin", admin));
			Map<String, Object> partnerProfile = dispatcher.runSync("loadProfile",
					UtilMisc.toMap("partyId", context.get("partyId"), "userLogin", admin));
			Map<String, Object> profile = (Map<String, Object>) partnerProfile.get("profile");
			String sendTo = (String) profile.get("email");
			String partyFullName = (String) profile.get("partyFullName");
			String body = partyFullName + " " + UtilProperties.getMessage(resource, "MSFriendRequestSent", locale) +
					"<br/><a href='https://localhost:8443/MatrimonySite/control/TimeLine'>Matrimony Site</a>";
			sendMail(dispatcher, sendTo, UtilProperties.getMessage(resource, "MSFriendRequestSent", locale),
					body, (String) context.get("userLoginPartyId"), admin);
		} catch (Exception e) {
			TransactionUtil.rollback(beganTx, e.getMessage(), e);
			e.printStackTrace();
		}
		result.put("partyId", context.get("partyId"));
		TransactionUtil.commit(beganTx);
		return result;
	}
	@SuppressWarnings("unchecked")
	public static Map<String, Object> acceptFriend(DispatchContext ctx, Map<String, ? extends Object> context) throws GenericTransactionException{
		Map<String, Object> result = FastMap.newInstance();
		Delegator delegator = ctx.getDelegator();
		LocalDispatcher dispatcher = ctx.getDispatcher();
		Locale locale = (Locale) context.get("locale");
		Long fromDateL = (Long) context.get("fromDate");
		Timestamp fromDate = null;
		if (UtilValidate.isNotEmpty(fromDateL)) {
			fromDate = new Timestamp(fromDateL);
		}
		boolean beganTx = TransactionUtil.begin(7200);
//		createPartyRelationship between two persons
		try {
			GenericValue admin = delegator.findOne("UserLogin", UtilMisc.toMap("userLoginId", "admin"), false);
			dispatcher.runSync("updatePartyRelationship",
					UtilMisc.toMap("partyIdFrom", context.get("partyId"), "partyIdTo", context.get("userLoginPartyId"), "roleTypeIdFrom", "FRIEND",
							"roleTypeIdTo", "FRIEND", "partyRelationshipTypeId", "FRIEND", "statusId", "ACCEPTED", "fromDate", fromDate, "userLogin", admin));
			
			Map<String, Object> partnerProfile = dispatcher.runSync("loadProfile",
					UtilMisc.toMap("partyId", context.get("partyId"), "userLogin", admin));
			Map<String, Object> profile = (Map<String, Object>) partnerProfile.get("profile");
			String sendTo = (String) profile.get("email");
			String partyFullName = (String) profile.get("partyFullName");
			String body = partyFullName + " " + UtilProperties.getMessage(resource, "MSFriendRequestWasAccepted", locale) +
							"<br/><a href='https://localhost:8443/MatrimonySite/control/TimeLine'>Matrimony Site</a>";
			sendMail(dispatcher, sendTo, UtilProperties.getMessage(resource, "MSFriendRequestWasAccepted", locale),
					body, (String) context.get("userLoginPartyId"), admin);
		} catch (Exception e) {
			TransactionUtil.rollback(beganTx, e.getMessage(), e);
			e.printStackTrace();
		}
		result.put("partyId", context.get("partyId"));
		TransactionUtil.commit(beganTx);
		return result;
	}
	public static Map<String, Object> cancelFriend(DispatchContext ctx, Map<String, ? extends Object> context)
			throws GenericEntityException, GenericServiceException {
		Map<String, Object> result = FastMap.newInstance();
		Delegator delegator = ctx.getDelegator();
		LocalDispatcher dispatcher = ctx.getDispatcher();
		GenericValue admin = delegator.findOne("UserLogin", UtilMisc.toMap("userLoginId", "admin"), false);
		Long fromDateL = (Long) context.get("fromDate");
		Timestamp fromDate = null;
		if (UtilValidate.isNotEmpty(fromDateL)) {
			fromDate = new Timestamp(fromDateL);
		}
//		createPartyRelationship between two persons
		dispatcher.runSync("updatePartyRelationship",
				UtilMisc.toMap("partyIdFrom", context.get("partyId"), "partyIdTo", context.get("userLoginPartyId"), "roleTypeIdFrom", "FRIEND",
						"roleTypeIdTo", "FRIEND", "partyRelationshipTypeId", "FRIEND", "statusId", "CANCEL", "fromDate", fromDate, "userLogin", admin));
		result.put("partyId", context.get("partyId"));
		return result;
	}
	public static Map<String, Object> listCustomers(DispatchContext ctx, Map<String, ? extends Object> context)
			throws GenericEntityException, GenericServiceException {
		Map<String, Object> result = FastMap.newInstance();
		Delegator delegator = ctx.getDelegator();
		Locale locale = (Locale) context.get("locale");
		List<String> allCustomerIds = getPartiesByRolesAndPartyFromAndStatusRelationShip("Company", "INTERNAL_ORGANIZATIO", "CUSTOMER", delegator, true);
		List<EntityCondition> conditions = FastList.newInstance();
		conditions.add(EntityCondition.makeCondition("partyId", EntityJoinOperator.IN, allCustomerIds));
		List<GenericValue> people = delegator.findList("PersonAndCaste",
				EntityCondition.makeCondition(conditions), null, UtilMisc.toList("firstName"), null, false);
		List<Map<String, Object>> listCustomers = FastList.newInstance();
		for (GenericValue x : people) {
			Map<String, Object> person = FastMap.newInstance();
			person.putAll(x);
			person.put("birthDate", x.getDate("birthDate").toString());
			person.put("city", getCityByPartyId(delegator, x.getString("partyId")));
			person.put("genderDetails", UtilProperties.getMessage(resource, x.getString("gender"), locale));
			listCustomers.add(person);
		}
		result.put("listCustomers", listCustomers);
		return result;
	}
	@SuppressWarnings("static-access")
	public static Map<String, Object> loadCustomersDataChart(DispatchContext ctx, Map<String, ? extends Object> context)
			throws GenericEntityException, GenericServiceException {
		Map<String, Object> result = FastMap.newInstance();
		Delegator delegator = ctx.getDelegator();
//		{ Day: 'Monday', Total: 30, HasFriends: 10, NotHasFriends: 25 },
		Long fromL = (Long) context.get("from");
		Long toL = (Long) context.get("to");
		Date fromD = new Date(fromL);
		Date toD = new Date(toL);
		Calendar calStart = Calendar.getInstance();
		calStart.setTime(fromD);
		Calendar calEnd = Calendar.getInstance();
		calEnd.setTime(toD);
		calEnd.add(Calendar.DATE, + 1);
		List<Map<String, Object>> listCustomers = FastList.newInstance();
		int max = 0;
		while (calStart.before(calEnd)) {
			Map<String, Object> user = FastMap.newInstance();
			Timestamp fromDate = new Timestamp(calStart.getTimeInMillis());
			user.put("Day", calStart.get(calStart.DATE));
			user.put("Total", getTotal(delegator, fromDate));
			user.put("RequestFriend", getRequestFriend(delegator, fromDate));
			calStart.add(Calendar.DATE, + 1);
			listCustomers.add(user);
			max += 1;
			if (max == 30) {
				break;
			}
		}
		result.put("listCustomers", listCustomers);
		return result;
	}
	private static int getTotal(Delegator delegator, Timestamp fromDate) throws GenericEntityException {
		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date(fromDate.getTime()));
		
		cal.set(Calendar.HOUR_OF_DAY, 0);
		cal.set(Calendar.MINUTE, 0);
		cal.set(Calendar.SECOND, 0);
		cal.set(Calendar.MILLISECOND, 0);
		Timestamp startDay = new Timestamp(cal.getTimeInMillis());
		cal.set(Calendar.HOUR_OF_DAY, 23);
		cal.set(Calendar.MINUTE, 59);
		cal.set(Calendar.SECOND, 59);
		cal.set(Calendar.MILLISECOND, 999);
		Timestamp endDay = new Timestamp(cal.getTimeInMillis());
		
		List<EntityCondition> conditions = FastList.newInstance();
		conditions.add(EntityCondition.makeCondition("fromDate", EntityOperator.GREATER_THAN_EQUAL_TO, startDay));
		conditions.add(EntityCondition.makeCondition("fromDate", EntityOperator.LESS_THAN_EQUAL_TO, endDay));
		
		conditions.add(EntityCondition.makeCondition(UtilMisc.toMap("partyIdFrom", "Company", "roleTypeIdFrom", "INTERNAL_ORGANIZATIO", "roleTypeIdTo", "CUSTOMER")));
		List<GenericValue> listPartyRelationship = delegator.findList("PartyRelationship",
				EntityCondition.makeCondition(conditions, EntityJoinOperator.AND), null, null, null, false);
		return listPartyRelationship.size();
	}
	private static int getRequestFriend(Delegator delegator, Timestamp fromDate) throws GenericEntityException {
		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date(fromDate.getTime()));
		
		cal.set(Calendar.HOUR_OF_DAY, 0);
		cal.set(Calendar.MINUTE, 0);
		cal.set(Calendar.SECOND, 0);
		cal.set(Calendar.MILLISECOND, 0);
		Timestamp startDay = new Timestamp(cal.getTimeInMillis());
		cal.set(Calendar.HOUR_OF_DAY, 23);
		cal.set(Calendar.MINUTE, 59);
		cal.set(Calendar.SECOND, 59);
		cal.set(Calendar.MILLISECOND, 999);
		Timestamp endDay = new Timestamp(cal.getTimeInMillis());
		
		List<EntityCondition> conditions = FastList.newInstance();
		conditions.add(EntityCondition.makeCondition("fromDate", EntityOperator.GREATER_THAN_EQUAL_TO, startDay));
		conditions.add(EntityCondition.makeCondition("fromDate", EntityOperator.LESS_THAN_EQUAL_TO, endDay));
		
		conditions.add(EntityCondition.makeCondition(UtilMisc.toMap("roleTypeIdFrom", "FRIEND", "roleTypeIdTo", "FRIEND")));
		List<GenericValue> listPartyRelationship = delegator.findList("PartyRelationship",
				EntityCondition.makeCondition(conditions, EntityJoinOperator.AND), null, null, null, false);
		return listPartyRelationship.size();
	}
	private static void sendMail(LocalDispatcher dispatcher, String sendTo, String subject, String body, String partyId, GenericValue admin) throws GenericServiceException {
		Map<String, Object> email = FastMap.newInstance();
		email.put("authUser", "matrimonynetwork@gmail.com");
		email.put("sendFrom", "matrimonynetwork@gmail.com");
		email.put("authPass", "ngominhhoa");
		email.put("sendTo", sendTo);
		email.put("subject", subject);
		email.put("body", body);
		email.put("partyId", partyId);
		email.put("userLogin", admin);
		dispatcher.runSync("sendMail", email);
	}
}

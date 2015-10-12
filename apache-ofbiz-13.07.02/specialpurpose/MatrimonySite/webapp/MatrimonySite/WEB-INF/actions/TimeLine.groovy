import org.ofbiz.base.util.UtilMisc;


def partyId = userLogin.getString("partyId");
Map<String, Object> personProfile = dispatcher.runSync("loadProfile",
		UtilMisc.toMap("partyId", partyId, "userLogin", userLogin));
Map<String, Object> person = (Map<String, Object>) personProfile.get("profile");
context.person = person;
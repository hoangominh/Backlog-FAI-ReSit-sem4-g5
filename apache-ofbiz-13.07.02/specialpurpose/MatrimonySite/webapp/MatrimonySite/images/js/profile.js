$(document).ready(function() {
	BaseLayer.init();
});
if (typeof (BaseLayer) == "undefined") {
	var BaseLayer = (function() {
		var loadProfile = function() {
			var data = DataAccess.getData({
						url: "loadProfile",
						data: {},
						source: "profile"});
			AccountLayer.setValue(data);
			BasicLayer.setValue(data);
			return data;
		};
		return {
			init: function() {
				loadProfile();
			},
			loadProfile: loadProfile
		}
	})();
}
if (typeof (AccountLayer) == "undefined") {
	var AccountLayer = (function() {
		var setValue = function(data) {
			if (!_.isEmpty(data)) {
				$("#txtEmailID").text(data.email);
				$("#txtUsername").text(data.userLoginId);
			}
		};
		return {
			setValue: setValue
		};
	})();
}
if (typeof (BasicLayer) == "undefined") {
	var BasicLayer = (function() {
		var setValue = function(data) {
			if (!_.isEmpty(data)) {
				$("#txtFirstName").text(data.firstName);
				$("#txtMiddleName").text(data.middleName);
				$("#txtLastName").text(data.lastName);
				if (data.birthDate) {
					$("#txtBirthDate").text((new Date(data.birthDate)).toTimeStandard());
				}
				$("#txtGender").text(data.genderDetails);
				$("#txtHeight").text(data.height);
				$("#txtContactNumber").text(data.contactNumber);
				$("#txtCity").text(data.cityDetails);
				$("#txtMotherTongue").text(data.motherTongue);
				$("#txtReligion").text(data.religion);
				$("#txtCaste").text(data.casteId);
				$("#txtMaritalStatus").text(data.maritalStatusDetails);
			}
		};
		return {
			setValue: setValue
		};
	})();
}
if (typeof (DataAccess) == "undefined") {
	var DataAccess = (function() {
		var getData = function(parameters) {
			var result;
			$.ajax({
		        url: parameters.url?parameters.url:"",
		        type: "POST",
		        data: parameters.data?parameters.data:"",
		        async: false,
				dataType: "json",
		        success: function() {}
		    }).done(function(res) {
		    	result = res[parameters.source?parameters.source:""];
			});
			return result;
		};
		var execute = function(parameters) {
			var result;
			$.ajax({
		        url: parameters.url?parameters.url:"",
		        type: "POST",
		        data: parameters.data?parameters.data:"",
		        async: false,
				dataType: "json",
		        success: function() {}
		    }).done(function(res) {
		    	if(res["_ERROR_MESSAGE_"] || res["_ERROR_MESSAGE_LIST_"]){
		    		var errorMessage = res["_ERROR_MESSAGE_"];
		    		if (res["_ERROR_MESSAGE_LIST_"]) {
		    			errorMessage?errorMessage=res["_ERROR_MESSAGE_LIST_"][0]:errorMessage;
					}
		    		$.notify(multiLang.CreateError + ": " + errorMessage, { className: "error" });
		    	} else {
		    		$.notify(multiLang.CreateSuccess, { className: "success" });
				}
			});
			return result;
		}
		return {
			getData: getData,
			execute: execute
		};
	})();
}
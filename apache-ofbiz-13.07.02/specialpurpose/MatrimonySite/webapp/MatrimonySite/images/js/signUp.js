$(document).ready(function() {
	BaseLayer.init();
});
if (typeof (BaseLayer) == "undefined") {
	var BaseLayer = (function() {
		var initValidator = function() {
			$('#signUp').jqxValidator({
			    rules: [{ input: '#txtUsername', message: multiLang.FieldRequired, action: 'change, blur', rule: 'required'},
			            { input: '#txtEmailID', message: multiLang.FieldRequired, action: 'change, blur', rule: 'required'},
			            { input: '#txtPassword', message: multiLang.FieldRequired, action: 'change, blur', rule: 'required'},
			            { input: '#txtLastName', message: multiLang.FieldRequired, action: 'change, blur', rule: 'required'},
			            { input: '#txtFirstName', message: multiLang.FieldRequired, action: 'change, blur', rule: 'required'},
			            { input: '#txtContactNumber', message: multiLang.FieldRequired, action: 'change, blur', rule: 'required'},
		                { input: '#txtBirthDate', message: multiLang.MSOver18, action: 'valueChanged', 
		                	rule: function (input, commit) {
		                		var currentTime = new Date().getFullYear();
		                		var value = 0;
		                		input.jqxDateTimeInput('getDate')?value=input.jqxDateTimeInput('getDate').getFullYear():value;
		                		if ((currentTime - value) > 18) {
		                			return true;
								}
		                		return false;
		                	}
		                },
		                { input: '#txtCity', message: multiLang.FieldRequired, action: 'change, open', 
		                	rule: function (input, commit) {
		                		var value = input.val();
		                		if (value) {
		                			return true;
		                		}
		                		return false;
		                	}
		                },
		                { input: '#txtCaste', message: multiLang.FieldRequired, action: 'change, open', 
		                	rule: function (input, commit) {
		                		var value = input.val();
		                		if (value) {
		                			return true;
		                		}
		                		return false;
		                	}
		                },
		                { input: '#txtChargesForRegistration', message: multiLang.FieldRequired, action: 'change, open', 
		                	rule: function (input, commit) {
		                		var value = input.val();
		                		if (value) {
		                			return true;
		                		}
		                		return false;
		                	}
		                },
		                { input: '#txtGender', message: multiLang.FieldRequired, action: 'change, open', 
		                	rule: function (input, commit) {
		                		var value = input.val();
		                		if (value) {
		                			return true;
		                		}
		                		return false;
		                	}
		                }]
			});
		};
		var handlerEvents = function() {
			$("#btnCreate").click(function () {
			    if ($('#signUp').jqxValidator('validate')) {
			    	var totalData = new Object();
			    	totalData = _.extend(AccountLayer.getValue(), BasicLayer.getValue(), PaymentLayer.getValue());
			    	DataAccess.execute({
							url: "createAccount",
							data: totalData})
			    }
			});
		};
		return {
			init: function() {
				BasicLayer.init();
				PaymentLayer.init();
				initValidator();
				handlerEvents();
			}
		}
	})();
}
if (typeof (AccountLayer) == "undefined") {
	var AccountLayer = (function() {
		var getValue = function() {
			var value = new Object();
			value.userLoginId = $("#txtUsername").val();
			value.email = $("#txtEmailID").val();
			value.currentPassword = $("#txtPassword").val();
			return value;
		};
		return {
			getValue: getValue
		};
	})();
}
if (typeof (BasicLayer) == "undefined") {
	var BasicLayer = (function() {
		var initJqxElements = function() {
			$("#txtBirthDate").jqxDateTimeInput({theme: "energyblue", width: 162, height: 28 });
//			$('#txtBirthDate ').jqxDateTimeInput('setDate', null);
			$("#txtHeight").jqxNumberInput({ width: 162, height: 28, inputMode: 'simple', spinButtons: true, decimalDigits: 0 });
			var listGender = [{value: 'M', label: multiLang.male}, {value: 'F', label: multiLang.female}];
			$("#txtGender").jqxDropDownList({ theme: 'energyblue', width: 162, height: 28, source: listGender,
				displayMember: "label", valueMember: "value", placeHolder: multiLang.filterchoosestring, autoDropDownHeight: true});
			var listMaritalStatus = [{value: 'NeverMarried', label: multiLang.NeverMarried},
			                         {value: 'Divorced', label: multiLang.Divorced},
			                         {value: 'Widowed', label: multiLang.Widowed}];
			$("#txtMaritalStatus").jqxDropDownList({ theme: 'energyblue', width: 162, height: 28, source: listMaritalStatus,
				displayMember: "label", valueMember: "value", placeHolder: multiLang.filterchoosestring, autoDropDownHeight: true});
			$("#txtCity").jqxDropDownList({
				source: DataAccess.getData({
								url: "getGeoData",
								data: {geoTypeId: "PROVINCE"},
								source: "listGeo"}),
				theme: "energyblue",
				displayMember: "geoName",
				valueMember: "geoId",
				width: 162,
				height: 28,
				autoDropDownHeight: true,
				placeHolder: multiLang.filterchoosestring
			});
			$("#txtCaste").jqxDropDownList({
				source: DataAccess.getData({
					url: "getCaste",
					data: {},
					source: "listCaste"}),
				theme: "energyblue",
				displayMember: "casteName",
				valueMember: "casteId",
				width: 162,
				height: 28,
				autoDropDownHeight: true,
				placeHolder: multiLang.filterchoosestring
			});
		};
		var handlerEvents = function() {
			
		};
		var getValue = function() {
			var value = new Object();
			value.firstName = $("#txtFirstName").val();
			value.middleName = $("#txtMiddleName").val();
			value.lastName = $("#txtLastName").val();
			var birthDate;
			$("#txtBirthDate").jqxDateTimeInput('getDate')?birthDate=$("#txtBirthDate").jqxDateTimeInput('getDate').getTime():birthDate;
			value.birthDate = birthDate;
			value.gender = $("#txtGender").jqxDropDownList('val');
			value.height = $("#txtHeight").jqxNumberInput('val');
			value.contactNumber = $("#txtContactNumber").val();
			value.city = $("#txtCity").jqxDropDownList('val');
			value.motherTongue = $("#txtMotherTongue").val();
			value.religion = $("#txtReligion").val();
			value.comments = $("#txtIntroduction").val();
			value.casteId = $("#txtCaste").jqxDropDownList('val');
			value.maritalStatus = $("#txtMaritalStatus").jqxDropDownList('val');
			return value;
		};
		return {
			init: function() {
				initJqxElements();
				handlerEvents();
			},
			getValue: getValue
		};
	})();
}
if (typeof (PaymentLayer) == "undefined") {
	var PaymentLayer = (function() {
		var initJqxElements = function() {
			var listPayment = [{value: 'Monthly', label: multiLang.Monthly}, {value: 'Yearly', label: multiLang.Yearly}];
			$("#txtChargesForRegistration").jqxDropDownList({ theme: 'energyblue', width: 162, height: 28, source: listPayment,
				displayMember: "label", valueMember: "value", placeHolder: multiLang.filterchoosestring, autoDropDownHeight: true});
		};
		var getValue = function() {
			var value = new Object();
			value.payment = $("#txtChargesForRegistration").jqxDropDownList('val');
			var thruDate;
			var currentDate = new Date().getTime();
			switch (value.payment) {
			case "Monthly":
				thruDate = (new Date(86400000 * 30 + currentDate)).getTime();
				break;
			case "Yearly":
				thruDate = (new Date(86400000 * 365 + currentDate)).getTime();
				break;
			default:
				break;
			}
			if (thruDate) {
				value.thruDate = thruDate;
			}
			return value;
		};
		return {
			init: function() {
				initJqxElements();
			},
			getValue: getValue
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
		    		setTimeout(function() {
		    			window.location.href = 'TimeLine';
					}, 300);
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
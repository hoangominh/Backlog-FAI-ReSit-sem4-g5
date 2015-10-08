$(document).ready(function() {
	BaseLayer.init();
});
if (typeof (BaseLayer) == "undefined") {
	var BaseLayer = (function() {
		var initValidator = function() {
			$('#signUp').jqxValidator({
			    rules: [{ input: '#txtEmailID', message: multiLang.FieldRequired, action: 'change, blur', rule: 'required'},
			            { input: '#txtLastName', message: multiLang.FieldRequired, action: 'change, blur', rule: 'required'},
			            { input: '#txtFirstName', message: multiLang.FieldRequired, action: 'change, blur', rule: 'required'},
			            { input: '#txtContactNumber', message: multiLang.FieldRequired, action: 'change, blur', rule: 'required'},
		                { input: '#txtBirthDate', message: multiLang.NotValid, action: 'valueChanged', 
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
			$("#btnUpdate").click(function () {
			    if ($('#signUp').jqxValidator('validate')) {
			    	var totalData = new Object();
			    	totalData = _.extend(AccountLayer.getValue(), BasicLayer.getValue(), _extendId());
			    	DataAccess.execute({
							url: "updateAccount",
							data: totalData});
			    }
			});
		};
		var extendId;
		var loadProfile = function() {
			var data = DataAccess.getData({
						url: "loadProfile",
						data: {},
						source: "profile"});
			AccountLayer.setValue(data);
			BasicLayer.setValue(data);
			if (data) {
				extendId = {
						fromDate: data.fromDate,
						contactNumberCMI: data.contactNumberCMI,
						emailCMI: data.emailCMI,
						cityCMI: data.cityCMI,
						partyId: data.partyId
				};
			}
		};
		var _extendId = function() {
			return extendId;
		};
		var _partyId = function() {
			return partyId;
		};
		return {
			init: function() {
				AccountLayer.init();
				BasicLayer.init();
				initValidator();
				handlerEvents();
				loadProfile();
			},
			loadProfile: loadProfile,
			_extendId: _extendId,
		}
	})();
}
if (typeof (AccountLayer) == "undefined") {
	var AccountLayer = (function() {
		var initJqxElements = function() {
			$("#jqxwindowRenewals").jqxWindow({ theme: 'energyblue', width: 400, maxWidth: 1845, height: 130, resizable: false,
				isModal: true, autoOpen: false, cancelButton: $("#cancelRenewals"), modalOpacity: 0.7 });
			
			var listPayment = [{value: 'Monthly', label: multiLang.Monthly}, {value: 'Yearly', label: multiLang.Yearly}];
			$("#txtRenewals").jqxDropDownList({ theme: 'energyblue', width: 162, height: 28, source: listPayment, selectedIndex: 0,
				displayMember: "label", valueMember: "value", placeHolder: multiLang.filterchoosestring, autoDropDownHeight: true});
		};
		var handlerEvents = function() {
			$("#imagePreview").click(function() {
				$("#txtFile").click();
			});
			$("#txtFile").change(function(){
			    readURL(this);
			});
			$("#renewals").click(function() {
				$("#jqxwindowRenewals").jqxWindow('open');
			});
			$("#saveRenewals").click(function () {
				var payment = $("#txtRenewals").jqxDropDownList('val');
				var thruDate;
				var currentDate;
				if (new Date($("#txtExpiredDate").text()) == 'Invalid Date') {
					currentDate = new Date();
				} else {
					currentDate = new Date(($("#txtExpiredDate").text()).toMilliseconds());
				}
				currentDate = currentDate.getTime();
				switch (payment) {
				case "Monthly":
					thruDate = (new Date(86400000 * 30 + currentDate)).getTime();
					break;
				case "Yearly":
					thruDate = (new Date(86400000 * 365 + currentDate)).getTime();
					break;
				default:
					break;
				}
//				renewalsAccount
				var fromDate;
				if (BaseLayer._extendId().fromDate) {
					fromDate = BaseLayer._extendId().fromDate.time;
				}
				DataAccess.execute({
					url: "renewalsAccount",
					data: {
						partyId: BaseLayer._extendId().partyId,
						fromDate: fromDate,
						thruDate: thruDate
						}
					}, AccountLayer.reloadAccountExpiredDate, "thruDate");
				
				$("#jqxwindowRenewals").jqxWindow('close');
			});
		};
		var readURL = function(input) {
			if (input.files && input.files[0]) {
		        var reader = new FileReader();
		        reader.onload = function (e) {
		            $('#imagePreview').attr('src', e.target.result);
		        }
		        reader.readAsDataURL(input.files[0]);
		    }
		}
		var getFileImage = function() {
			if ($('#txtFile').val()) {
	    		var imageName = $('#txtFile').prop('files')[0].name;
				var hashName = imageName.split(".");
				var extended = hashName.pop().toLowerCase();
				if (extended == "jpg" || extended == "jpeg" || extended == "gif" || extended == "png") {
					var form_data= new FormData();
					form_data.append("uploadedFile", $('#txtFile').prop('files')[0]);
					return form_data;
				}
			}
		};
		var reloadAccountExpiredDate = function(thruDate) {
			if (thruDate) {
				$("#txtExpiredDate").text((new Date(thruDate)).toTimeStandard());
			}
		};
		var getValue = function() {
			var value = new Object();
			value.email = $("#txtEmailID").val();
			return value;
		};
		var setValue = function(data) {
			if (!_.isEmpty(data)) {
				$("#txtEmailID").val(data.email);
				$("#txtUsername").text(data.userLoginId);
				if (data.thruDate) {
					$("#txtExpiredDate").text((new Date(data.thruDate.time)).toTimeStandard());
				}
			}
		};
		return {
			init: function() {
				initJqxElements();
				handlerEvents();
			},
			getValue: getValue,
			setValue: setValue,
			getFileImage: getFileImage,
			reloadAccountExpiredDate: reloadAccountExpiredDate
		};
	})();
}
if (typeof (BasicLayer) == "undefined") {
	var BasicLayer = (function() {
		var initJqxElements = function() {
			$("#txtBirthDate").jqxDateTimeInput({theme: "energyblue", width: 162, height: 28 });
			$('#txtBirthDate ').jqxDateTimeInput('setDate', null);
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
		var setValue = function(data) {
			if (!_.isEmpty(data)) {
				$("#txtFirstName").val(data.firstName);
				$("#txtMiddleName").val(data.middleName);
				$("#txtLastName").val(data.lastName);
				if (data.birthDate) {
					$("#txtBirthDate").jqxDateTimeInput('setDate', new Date(data.birthDate));
				}
				$("#txtGender").jqxDropDownList('val', data.gender);
				$("#txtHeight").jqxNumberInput('val', data.height);
				$("#txtContactNumber").val(data.contactNumber);
				$("#txtCity").jqxDropDownList('val', data.city);
				$("#txtMotherTongue").val(data.motherTongue);
				$("#txtReligion").val(data.religion);
				$("#txtIntroduction").val(data.comments);
				$("#txtCaste").jqxDropDownList('val', data.casteId);
				$("#txtMaritalStatus").jqxDropDownList('val', data.maritalStatus);
			}
		};
		return {
			init: function() {
				initJqxElements();
				handlerEvents();
			},
			getValue: getValue,
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
		var execute = function(parameters, callback, keySource) {
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
		    		$.notify(multiLang.UpdateError + ": " + errorMessage, { className: "error" });
		    	} else {
		    		$.notify(multiLang.UpdateSuccess, { className: "success" });
				}
		    	if (typeof (callback) == "function") {
		    		callback(res[keySource]);
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
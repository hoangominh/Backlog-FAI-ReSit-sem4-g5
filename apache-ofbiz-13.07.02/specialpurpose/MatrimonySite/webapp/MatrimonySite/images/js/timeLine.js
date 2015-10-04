$(document).ready(function () {
    FriendsMayKnow.init();
});
if (typeof (FriendsMayKnow) == "undefined") {
	var FriendsMayKnow = (function() {
		var initJqxElements = function() {
			var data = DataAccess.getData({
				url: "loadFriendsMayKnow",
				data: {userLoginPartyId: userLoginPartyId},
				source: "listFriendsMayKnow"});
			data = null;
			var source =
		    {
		        localData: data,
		        dataType: "array"
		    };
		    var dataAdapter = new $.jqx.dataAdapter(source);
		    $("#friendsMayKnowDataTable").jqxDataTable({
		    	localization: getLocalization(),
		        width: '100%',
		        theme: "energyblue",
		        source: dataAdapter,
		        sortable: true,
		        pageable: true,
		        pageSize: 1,
		        enableHover: true,
		        rendered: function () {},
		        columns: [
		              {text: multiLang.MSFriendsMayKnow, align: 'left', dataField: 'model',
		                  cellsRenderer: function (row, column, value, rowData) {
		                      var friends = rowData.friends;
		                      var container = "<div>";
		                      for (var i = 0; i < friends.length; i++) {
		                          var friend = friends[i];
		                          var item = "<div style='float: left; width: 210px; overflow: hidden; white-space: nowrap; height: 265px;'>";
		                          var image = "<div style='margin: 5px; margin-bottom: 3px;'>";
		                          var imgurl = friend.avatar;
		                          var img = '<img width=160 height=120 style="display: block;" src="' + imgurl + '"/>';
		                          image += img;
		                          image += "</div>";
		                          var info = "<div style='margin: 5px; margin-left: 10px; margin-bottom: 3px;'>";
		                          info += "<div><label class='blue'>" + friend.partyFullName + "</label></div>";
		                          info += "<div>" + multiLang.MSCaste + ": <label class='green-mini'>" + friend.casteName + "</label></div>";
		                          info += "<div><i class='fa fa-venus-mars'></i>: " + friend.genderDetails + "</div>";
		                          info += "<div><i class='fa fa-map-marker'></i>: " + friend.city + "</div>";
		                          info += "</div>";
		                          item += image;
		                          item += info;
		                          item += "</div>";
		                          container += item;
		                      }
		                      container += "</div>";
		                      return container;
		                  }
		              }
		        ]
		    });
		    $("#divOptions").jqxExpander({ width: '100%', theme: "energyblue", expanded: true });
		    var listGender = [{value: 'M', label: multiLang.male}, {value: 'F', label: multiLang.female}];
			$("#txtGender").jqxDropDownList({ theme: 'energyblue', width: 162, height: 28, source: listGender,
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
			var listMaritalStatus = [{value: 'NeverMarried', label: multiLang.NeverMarried},
			                         {value: 'Divorced', label: multiLang.Divorced},
			                         {value: 'Widowed', label: multiLang.Widowed}];
			$("#txtMaritalStatus").jqxDropDownList({ theme: 'energyblue', width: 162, height: 28, source: listMaritalStatus,
				displayMember: "label", valueMember: "value", placeHolder: multiLang.filterchoosestring, autoDropDownHeight: true});
		};
		var handlerEvents = function() {
			$("#btnSearch").click(function() {
				var conditions = new Object();
				conditions.partyFullName = $("#txtFirstName").val();
				conditions.gender = $("#txtGender").jqxDropDownList('val');
				conditions.city = $("#txtCity").jqxDropDownList('val');
				conditions.casteId = $("#txtCaste").jqxDropDownList('val');
				conditions.maritalStatus = $("#txtMaritalStatus").jqxDropDownList('val');
				conditions.userLoginPartyId = userLoginPartyId;
				var data = DataAccess.getData({
					url: "loadFriendsMayKnow",
					data: conditions,
					source: "listFriendsMayKnow"});
				reloadDataTable(data);
			});
		};
		var reloadDataTable = function(data) {
			var source =
		    {
		        localData: data,
		        dataType: "array"
		    };
		    var dataAdapter = new $.jqx.dataAdapter(source);
		    $("#friendsMayKnowDataTable").jqxDataTable({source: dataAdapter});
		};
		return {
			init: function() {
				initJqxElements();
				handlerEvents();
			},
		}
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
$(document).ready(function () {
    FriendRequestLayer.init();
    Friends.init();
});
if (typeof (FriendRequestLayer) == "undefined") {
	var FriendRequestLayer = (function() {
		var initJqxElements = function() {
			var data = DataAccess.getData({
				url: "loadFriendRequest",
				data: {userLoginPartyId: userLoginPartyId},
				source: "listFriendRequest"});
			var source =
		    {
		        localData: data,
		        dataType: "array"
		    };
		    var dataAdapter = new $.jqx.dataAdapter(source);
		    $("#friendRequestDataTable").jqxDataTable({
		    	localization: getLocalization(),
		        width: '100%',
		        theme: "energyblue",
		        source: dataAdapter,
		        sortable: true,
		        pageable: true,
		        pageSize: 1,
		        enableHover: true,
		        rendered: function () {
		        	var rows = $("#friendRequestDataTable").jqxDataTable('getRows');
		        	for ( var x in rows) {
		        		var friends = rows[x].friends;
		        		for ( var z in friends) {
			        		$("#div" + friends[z].partyId).jqxTooltip({ content: friends[z].comments, position: 'mouse'});
						}
					}
		        },
		        columns: [
		              {text: multiLang.MSFriendRequests, align: 'left', dataField: 'model',
		                  cellsRenderer: function (row, column, value, rowData) {
		                      var friends = rowData.friends;
		                      var container = "<div>";
		                      for (var i = 0; i < friends.length; i++) {
		                          var friend = friends[i];
		                          var item = "<div id='div" + friend.partyId + "' style='float: left; width: 210px; overflow: hidden; white-space: nowrap; height: 275px;'>";
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
		                          info += "<div><button onclick='FriendRequestLayer.acceptFriend(" + friend.partyId + "," + friend.fromDate.time + ")' class='btn btn-primary form-action-button'>" + multiLang.CommonSubmit + "</button>";
		                          info += "<button onclick='FriendRequestLayer.cancelFriend(" + friend.partyId + "," + friend.fromDate.time + ")' class='btn btn-primary form-action-button'>" + multiLang.MSCancel + "</button></div>";
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
		};
		var acceptFriend = function(partyId, fromDate) {
			DataAccess.execute({
				url: "acceptFriend",
				data: {
					partyId: partyId,
					fromDate: fromDate,
					userLoginPartyId: userLoginPartyId}
				}, FriendRequestLayer.reloadDataTable, "partyId");
		}
		var cancelFriend = function(partyId, fromDate) {
			DataAccess.execute({
				url: "cancelFriend",
				data: {
					partyId: partyId,
					fromDate: fromDate,
					userLoginPartyId: userLoginPartyId}
				}, FriendRequestLayer.reloadDataTable, "partyId");
		}
		var reloadDataTable = function() {
			var data = DataAccess.getData({
				url: "loadFriendRequest",
				data: {userLoginPartyId: userLoginPartyId},
				source: "listFriendRequest"});
			var source =
		    {
		        localData: data,
		        dataType: "array"
		    };
		    var dataAdapter = new $.jqx.dataAdapter(source);
		    $("#friendRequestDataTable").jqxDataTable({source: dataAdapter});
		    Friends.reloadDataTable();
		};
		return {
			init: function() {
				initJqxElements();
			},
			acceptFriend: acceptFriend,
			cancelFriend: cancelFriend,
			reloadDataTable: reloadDataTable
		}
	})();
}
if (typeof (Friends) == "undefined") {
	var Friends = (function() {
		var initJqxElements = function() {
			var data = DataAccess.getData({
				url: "loadFriends",
				data: {userLoginPartyId: userLoginPartyId},
				source: "listFriends"});
			var source =
			{
					localData: data,
					dataType: "array"
			};
			var dataAdapter = new $.jqx.dataAdapter(source);
			$("#friendsDataTable").jqxDataTable({
				localization: getLocalization(),
				width: '100%',
				theme: "energyblue",
				source: dataAdapter,
				sortable: true,
				pageable: true,
				pageSize: 1,
				enableHover: true,
				rendered: function () {
					var rows = $("#friendsDataTable").jqxDataTable('getRows');
		        	for ( var x in rows) {
		        		var friends = rows[x].friends;
		        		for ( var z in friends) {
			        		$("#div" + friends[z].partyId).jqxTooltip({ content: friends[z].comments, position: 'mouse'});
						}
					}
				},
				columns: [
				          {text: multiLang.MSFriends, align: 'left', dataField: 'model',
				        	  cellsRenderer: function (row, column, value, rowData) {
				        		  var friends = rowData.friends;
				        		  var container = "<div>";
				        		  for (var i = 0; i < friends.length; i++) {
				        			  var friend = friends[i];
				        			  var item = "<div id='div" + friend.partyId + "' style='float: left; width: 210px; overflow: hidden; white-space: nowrap; height: 275px;'>";
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
				        			  info += "<button onclick='Friends.viewProfile(" + friend.partyId + ")' class='btn btn-primary form-action-button'>" + multiLang.MSViewProfile + "</button></div>";
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
		};
		var message = function(partyId) {
			console.log(partyId);
		}
		var viewProfile = function(partyId) {
			window.location.href = 'Profile?partyId=' + partyId;
		}
		var reloadDataTable = function() {
			var data = DataAccess.getData({
				url: "loadFriends",
				data: {userLoginPartyId: userLoginPartyId},
				source: "listFriends"});
			var source =
			{
					localData: data,
					dataType: "array"
			};
			var dataAdapter = new $.jqx.dataAdapter(source);
			$("#friendsDataTable").jqxDataTable({source: dataAdapter});
		};
		return {
			init: function() {
				initJqxElements();
			},
			message: message,
			viewProfile: viewProfile,
			reloadDataTable: reloadDataTable
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
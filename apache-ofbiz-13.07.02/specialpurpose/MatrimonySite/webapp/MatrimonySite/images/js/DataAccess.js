//var data = DataAccess.getData({
//				url: "loadFriends",
//				data: {userLoginPartyId: userLoginPartyId},
//				source: "listFriends"});
//
//DataAccess.execute({
//	url: "cancelFriend",
//	data: {
//		partyId: partyId,
//		fromDate: fromDate,
//		userLoginPartyId: userLoginPartyId}
//	}, FriendRequestLayer.reloadDataTable);

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
		    	if (parameters.source == "*") {
		    		result = res;
				} else {
					result = res[parameters.source?parameters.source:""];
				}
			});
			return result;
		};
		var execute = function(parameters, callback) {
			var result;
			$.ajax({
		        url: parameters.url?parameters.url:"",
		        type: parameters.type?parameters.type:"POST",
		        data: parameters.data?parameters.data:"",
		        async: false,
				dataType: parameters.dataType?parameters.dataType:"json",
		        success: function() {}
		    }).done(function(res) {
		    	if(res["_ERROR_MESSAGE_"] || res["_ERROR_MESSAGE_LIST_"]){
		    		result = false;
		    	} else {
		    		result = true;
				}
		    	if (typeof (callback) == "function") {
		    		callback(res);
				}
			});
			return result;
		};
		return {
			getData: getData,
			execute: execute
		};
	})();
}
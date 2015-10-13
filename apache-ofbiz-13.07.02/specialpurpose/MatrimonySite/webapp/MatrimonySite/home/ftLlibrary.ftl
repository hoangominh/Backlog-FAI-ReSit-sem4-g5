<script type="text/javascript" src="/MatrimonySite/images/jqwidgets/scripts/jquery-2.0.2.min.js"></script>
<script type="text/javascript" src="/MatrimonySite/images/jqwidgets/jqwidgets/jqx-all.js"></script>
<script type="text/javascript" src="/MatrimonySite/images/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/MatrimonySite/images/js/Underscore1.8.3.js"></script>
<script type="text/javascript" src="/MatrimonySite/images/js/notify.js"></script>
<script type="text/javascript" src="/MatrimonySite/images/js/miscUtil.js"></script>
<script type="text/javascript" src="/MatrimonySite/images/js/jquery.cookie.js"></script>

<link rel="stylesheet" type="text/css" href="/MatrimonySite/images/css/matrimonySite.css">
<link rel="stylesheet" type="text/css" href="/MatrimonySite/images/css/bootstrap-responsive.min.css">
<!-- <link rel="stylesheet" type="text/css" href="/MatrimonySite/images/css/bootstrap.min.css"> -->
<link rel="stylesheet" type="text/css" href="/MatrimonySite/images/Font-Awesome-master/css/font-awesome.min.css">
<link rel="stylesheet" type="text/css" href="/MatrimonySite/images/jqwidgets/jqwidgets/styles/jqx.base.css">
<link rel="stylesheet" type="text/css" href="/MatrimonySite/images/jqwidgets/jqwidgets/styles/jqx.energyblue.css">

<script>
	$(document).ready(function() {
		$("#liLanguage")
		.mouseenter(function() {
			setTimeout(function() {
				$("#liLanguage").addClass("open");
			}, 300);
		})
		.mouseleave(function() {
			setTimeout(function() {
				$("#liLanguage").removeClass("open");
			}, 500);
		});
	});
	var multiLang = {
			male: "${StringUtil.wrapString(uiLabelMap.M)}",
			female: "${StringUtil.wrapString(uiLabelMap.F)}",
			filterchoosestring: "${StringUtil.wrapString(uiLabelMap.MSFilterchoosestring)}",
			FieldRequired: "${StringUtil.wrapString(uiLabelMap.MSFieldRequired)}",
			NotValid: "${StringUtil.wrapString(uiLabelMap.MSNotValid)}",
			NeverMarried: "${StringUtil.wrapString(uiLabelMap.NeverMarried)}",
			Divorced: "${StringUtil.wrapString(uiLabelMap.Divorced)}",
			Widowed: "${StringUtil.wrapString(uiLabelMap.Widowed)}",
			Monthly: "${StringUtil.wrapString(uiLabelMap.Monthly)}",
			Yearly: "${StringUtil.wrapString(uiLabelMap.Yearly)}",
			CreateError: "${StringUtil.wrapString(uiLabelMap.CreateError)}",
			CreateSuccess: "${StringUtil.wrapString(uiLabelMap.CreateSuccess)}",
			UpdateError: "${StringUtil.wrapString(uiLabelMap.UpdateError)}",
			UpdateSuccess: "${StringUtil.wrapString(uiLabelMap.UpdateSuccess)}",
			MSFriendsMayKnow: "${StringUtil.wrapString(uiLabelMap.MSFriendsMayKnow)}",
			MSFriendRequests: "${StringUtil.wrapString(uiLabelMap.MSFriendRequests)}",
			MSCaste: "${StringUtil.wrapString(uiLabelMap.MSCaste)}",
			MSAddFriend: "${StringUtil.wrapString(uiLabelMap.MSAddFriend)}",
			MSFriendRequestSent: "${StringUtil.wrapString(uiLabelMap.MSFriendRequestSent)}",
			CommonSubmit: "${StringUtil.wrapString(uiLabelMap.CommonSubmit)}",
			MSCancel: "${StringUtil.wrapString(uiLabelMap.MSCancel)}",
			MSMessage: "${StringUtil.wrapString(uiLabelMap.MSMessage)}",
			MSViewProfile: "${StringUtil.wrapString(uiLabelMap.MSViewProfile)}",
			MSFriends: "${StringUtil.wrapString(uiLabelMap.MSFriends)}",
			MSFirstName: "${StringUtil.wrapString(uiLabelMap.MSFirstName)}",
			MSPartyId: "${StringUtil.wrapString(uiLabelMap.MSPartyId)}",
			MSCity: "${StringUtil.wrapString(uiLabelMap.MSCity)}",
			MSGender: "${StringUtil.wrapString(uiLabelMap.MSGender)}",
			MSMaritalStatus: "${StringUtil.wrapString(uiLabelMap.MSMaritalStatus)}",
			MSBirthDate: "${StringUtil.wrapString(uiLabelMap.MSBirthDate)}",
			MSRegisteredUsers: "${StringUtil.wrapString(uiLabelMap.MSRegisteredUsers)}",
			MSStatisticsTheNumberOfPeopleRegisteredInTheWeek: "${StringUtil.wrapString(uiLabelMap.MSStatisticsTheNumberOfPeopleRegisteredInTheWeek)}",
			MSOver18: "${StringUtil.wrapString(uiLabelMap.MSOver18)}",
			MSQuantity: "${StringUtil.wrapString(uiLabelMap.MSQuantity)}",
	};
	var getLocalization = function () {
        var localizationobj = {};
        localizationobj.pagergotopagestring = "${StringUtil.wrapString(uiLabelMap.wgpagergotopagestring)}:";
        localizationobj.pagershowrowsstring = "${StringUtil.wrapString(uiLabelMap.wgpagershowrowsstring)}:";
        localizationobj.pagerrangestring = " ${StringUtil.wrapString(uiLabelMap.wgpagerrangestring)} ";
        localizationobj.pagernextbuttonstring = "${StringUtil.wrapString(uiLabelMap.wgpagernextbuttonstring)}";
        localizationobj.pagerpreviousbuttonstring = "${StringUtil.wrapString(uiLabelMap.wgpagerpreviousbuttonstring)}";
        localizationobj.sortascendingstring = "${StringUtil.wrapString(uiLabelMap.wgsortascendingstring)}";
        localizationobj.sortdescendingstring = "${StringUtil.wrapString(uiLabelMap.wgsortdescendingstring)}";
        localizationobj.sortremovestring = "${StringUtil.wrapString(uiLabelMap.wgsortremovestring)}";
        localizationobj.emptydatastring = "${StringUtil.wrapString(uiLabelMap.wgemptydatastring)}";
        localizationobj.filterselectstring = "${StringUtil.wrapString(uiLabelMap.wgfilterselectstring)}";
        localizationobj.filterselectallstring = "${StringUtil.wrapString(uiLabelMap.wgfilterselectallstring)}";
        localizationobj.filterchoosestring = "${StringUtil.wrapString(uiLabelMap.filterchoosestring)}";
        localizationobj.groupsheaderstring = "${StringUtil.wrapString(uiLabelMap.wgdragDropToGroupColumn)}";
        localizationobj.todaystring = "${StringUtil.wrapString(uiLabelMap.wgtodaystring)}";
        localizationobj.clearstring = "${StringUtil.wrapString(uiLabelMap.wgclearstring)}";
        return localizationobj;
	};
	var colors = {
		      "danger-color": "#e74c3c",
		      "success-color": "#81b53e",
		      "warning-color": "#f0ad4e",
		      "inverse-color": "#2c3e50",
		      "info-color": "#2d7cb5",
		      "default-color": "#6e7882",
		      "default-light-color": "#cfd9db",
		      "purple-color": "#9D8AC7",
		      "mustard-color": "#d4d171",
		      "lightred-color": "#e15258",
		      "body-bg": "#f6f6f6"
		    };
    var config = {
		      theme: "social-2",
		      skins: {
		        "default": {
		          "primary-color": "#16ae9f"
		        },
		        "orange": {
		          "primary-color": "#e74c3c"
		        },
		        "blue": {
		          "primary-color": "#4687ce"
		        },
		        "purple": {
		          "primary-color": "#af86b9"
		        },
		        "brown": {
		          "primary-color": "#c3a961"
		        },
		        "default-nav-inverse": {
		          "color-block": "#242424"
		        }
		      }
    };
</script>
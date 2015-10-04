<script type="text/javascript" src="/MatrimonySite/images/jqwidgets/scripts/jquery-2.0.2.min.js"></script>
<script type="text/javascript" src="/MatrimonySite/images/jqwidgets/jqwidgets/jqx-all.js"></script>
<script type="text/javascript" src="/MatrimonySite/images/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/MatrimonySite/images/js/Underscore1.8.3.js"></script>
<script type="text/javascript" src="/MatrimonySite/images/js/notify.js"></script>
<script type="text/javascript" src="/MatrimonySite/images/js/miscUtil.js"></script>

<link rel="stylesheet" type="text/css" href="/MatrimonySite/images/css/matrimonySite.css">
<link rel="stylesheet" type="text/css" href="/MatrimonySite/images/css/bootstrap-responsive.min.css">
<link rel="stylesheet" type="text/css" href="/MatrimonySite/images/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="/MatrimonySite/images/Font-Awesome-master/css/font-awesome.min.css">
<link rel="stylesheet" type="text/css" href="/MatrimonySite/images/jqwidgets/jqwidgets/styles/jqx.base.css">
<link rel="stylesheet" type="text/css" href="/MatrimonySite/images/jqwidgets/jqwidgets/styles/jqx.energyblue.css">

<script>
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
</script>
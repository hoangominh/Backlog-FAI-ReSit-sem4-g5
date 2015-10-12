<#include "component://MatrimonySite/webapp/MatrimonySite/home/ftLlibrary.ftl"/>
<#include "component://MatrimonySite/webapp/MatrimonySite/home/decorator.ftl"/>
<script type="text/javascript" src="/MatrimonySite/images/js/dashboard.js"></script>
<script type="text/javascript" src="/MatrimonySite/images/js/DataAccess.js"></script>
<a href="logout">${StringUtil.wrapString(uiLabelMap.Logout)}</a>
Admin

<div class="span12 no-left-margin boder-all-profile">
<span class="text-header">${uiLabelMap.MSCustomersChart}</span>
	<div id='chartContainer' style="width: 100%; height:500px"></div>
</div>

<div class="span12 no-left-margin boder-all-profile">
<span class="text-header">${uiLabelMap.MSCustomersList}</span>
	<div class='row-fluid'>
		<a id="clearFilter" title="Ctrl + F" style="float: right;cursor: pointer;"><i class="fa fa-filter"></i> ${StringUtil.wrapString(uiLabelMap.MSClearFilter)}</a>
		<div id="gridCustomer"></div>
	</div>
</div>
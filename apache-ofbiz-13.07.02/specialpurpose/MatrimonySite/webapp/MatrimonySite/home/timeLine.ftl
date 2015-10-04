<#include "component://MatrimonySite/webapp/MatrimonySite/home/ftLlibrary.ftl"/>
<#include "component://MatrimonySite/webapp/MatrimonySite/home/decorator.ftl"/>
<script type="text/javascript" src="/MatrimonySite/images/js/timeLine.js"></script>

<#assign userLoginPartyId=userLogin.getString("partyId") />

<head>
	<title>MatrimonySite: ${StringUtil.wrapString(uiLabelMap.TimeLine)}</title>
	<style>
		.span12 {
		    width: 94%;
		}
	</style>
	<script>
		var userLoginPartyId = "${userLoginPartyId?if_exists}";
	</script>
</head>
<a href="logout">${StringUtil.wrapString(uiLabelMap.Logout)}</a>
<a href="Profile">${StringUtil.wrapString(uiLabelMap.MSProfile)}</a>
Hello customer


<div class="container">
	<button type="button" class="btn btn-info" data-toggle="collapse" data-target="#divFriendsMayKnow">${uiLabelMap.MSRelationshipcenter}</button>
	<div id='divFriendsMayKnow' class="collapse">
		<div id='divOptions'>
		<div>${uiLabelMap.MSOptions}</div>
			<div>
				<div class='row-fluid'>
					<div class='span12'>
						<div class='span5'>
							<div class='row-fluid margin-top10'>
								<div class='span5'><label class='text-right'>${uiLabelMap.MSFirstName}</label></div>
								<div class='span7'><input type='text' class="medium-size-input" id="txtFirstName" /></div>
							</div>
							<div class='row-fluid'>
								<div class='span5'><label class='text-right'>${uiLabelMap.MSGender}</label></div>
								<div class='span7'><div id="txtGender"></div></div>
							</div>
							<div class='row-fluid margin-top10'>
								<div class='span5'><label class='text-right'>${uiLabelMap.MSCaste}</label></div>
								<div class='span7'><div id="txtCaste"></div></div>
							</div>
						</div>
						<div class='span6'>
							<div class='row-fluid margin-top10'>
								<div class='span5'></div>
								<div class='span7'></div>
							</div>
							<div class='row-fluid margin-top10'>
								<div class='span5'><label class='text-right'>${uiLabelMap.MSCity}</label></div>
								<div class='span7'><div id="txtCity"></div></div>
							</div>
							<div class='row-fluid margin-top10'>
								<div class='span5'><label class='text-right'>${uiLabelMap.MSMaritalStatus}</label></div>
								<div class='span7'><div id="txtMaritalStatus"></div></div>
							</div>
						</div>
					</div>
				</div>
				<div class="row-fluid margin-top10">
					<div class="span12">
						<button id='btnSearch' class="btn btn-primary form-action-button pull-right"><i class='icon-ok'></i>${uiLabelMap.MSSearch}</button>
					</div>
				</div>
			</div>
		</div>
		<div id="friendsMayKnowDataTable"></div>
	</div>
</div>
<div class="container">
	<button type="button" class="btn btn-info" data-toggle="collapse" data-target="#divFriendRequest">${uiLabelMap.MSFriendRequests}</button>
	<div id='divFriendRequest' class="collapse">
		<div id="friendRequestDataTable"></div>
	</div>
</div>
<div class="container">
	<button type="button" class="btn btn-info" data-toggle="collapse" data-target="#divFriends">${uiLabelMap.MSFriends}</button>
	<div id='divFriends' class="collapse in">
		<div id="friendsDataTable"></div>
	</div>
</div>
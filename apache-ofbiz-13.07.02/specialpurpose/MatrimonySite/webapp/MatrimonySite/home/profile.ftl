<#include "component://MatrimonySite/webapp/MatrimonySite/home/ftLlibrary.ftl"/>
<#include "component://MatrimonySite/webapp/MatrimonySite/home/decorator.ftl"/>
<script type="text/javascript" src="/MatrimonySite/images/js/profile.js"></script>
<head>
	<title>MatrimonySite: ${StringUtil.wrapString(uiLabelMap.MSProfile)}</title>
</head>
<a href="TimeLine">${StringUtil.wrapString(uiLabelMap.TimeLine)}</a>

<#assign userLoginPartyId=userLogin.getString("partyId") />
<#assign partyId=parameters.partyId?if_exists />

<#if partyId == "">
	<a href="UpdateProfile">${StringUtil.wrapString(uiLabelMap.MSUpdateProfile)}</a>
<#else>
	<#if userLoginPartyId == partyId>
		<a href="UpdateProfile">${StringUtil.wrapString(uiLabelMap.MSUpdateProfile)}</a>
	</#if>
</#if>

<div id="signUp">
	<div class="span12 no-left-margin boder-all-profile">
	<span class="text-header">${uiLabelMap.MSAccountDetails}</span>
		<div class='row-fluid'>
			<div class='span8'>
				<div class='row-fluid margin-bottom10'>
					<div class='span5'><label class='text-right'>${uiLabelMap.MSUsername}:</label></div>
					<div class='span7'><label class='green' id="txtUsername"></label></div>
				</div>
				<div class='row-fluid margin-bottom10'>
					<div class='span5'><label class='text-right'>${uiLabelMap.MSEmailID}:</label></div>
					<div class='span7'><label class='green' id="txtEmailID"></label></div>
				</div>
			</div>
			<div class='span4'>
				<div class='row-fluid margin-bottom10'>
					<div class='span4'><label class='text-right'>${uiLabelMap.MSAvatar}</label></div>
					<div class='span7'>
						<div id="productImageViewerTotal">
							<img src="/MatrimonySite/images/image/noavatar.jpg" id="imagePreview" height="180" width="95%" style="max-width: none;"/>
						</div>
					</div>
					<div class='span1 no-left-margin'>
						<input type="file" id="txtFile" style="visibility:hidden;" />
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<div class="span12 no-left-margin boder-all-profile">
	<span class="text-header">${uiLabelMap.MSBasicDetails}</span>
		<div class='row-fluid'>
			<div class='span4'>
				<div class='row-fluid margin-bottom10'>
					<div class='span5'><label class='text-right'>${uiLabelMap.MSLastName}:</label></div>
					<div class='span7'><label class='green' id="txtLastName"></label></div>
				</div>
				<div class='row-fluid margin-bottom10'>
					<div class='span5'><label class='text-right'>${uiLabelMap.MSBirthDate}:</label></div>
					<div class='span7'><label class='green' id="txtBirthDate"></label></div>
				</div>
				<div class='row-fluid' style="margin-top: 10px;">
					<div class='span5'><label class='text-right'>${uiLabelMap.MSContactNumber}:</label></div>
					<div class='span7'><label class='green' id="txtContactNumber"></label></div>
				</div>
				<div class='row-fluid margin-bottom10'>
					<div class='span5'><label class='text-right'>${uiLabelMap.MSReligion}:</label></div>
					<div class='span7'><label class='green' id="txtReligion"></label></div>
				</div>
			</div>
			<div class='span4'>
				<div class='row-fluid margin-bottom10'>
					<div class='span5'><label class='text-right'>${uiLabelMap.MSMiddleName}:</label></div>
					<div class='span7'><label class='green' id="txtMiddleName"></label></div>
				</div>
				<div class='row-fluid margin-bottom10'>
					<div class='span5'><label class='text-right'>${uiLabelMap.MSGender}:</label></div>
					<div class='span7'><label class='green' id="txtGender"></label></div>
				</div>
				<div class='row-fluid' style="margin-top: 10px;">
					<div class='span5'><label class='text-right'>${uiLabelMap.MSCity}:</label></div>
					<div class='span7'><label class='green' id="txtCity"></label></div>
				</div>
				<div class='row-fluid' style="margin-top: 10px;">
					<div class='span5'><label class='text-right'>${uiLabelMap.MSCaste}:</label></div>
					<div class='span7'><label class='green' id="txtCaste"></label></div>
				</div>
			</div>
			<div class='span4'>
				<div class='row-fluid margin-bottom10'>
					<div class='span5'><label class='text-right'>${uiLabelMap.MSFirstName}:</label></div>
					<div class='span7'><label class='green' id="txtFirstName"></label></div>
				</div>
				<div class='row-fluid margin-bottom10'>
					<div class='span5'><label class='text-right'>${uiLabelMap.MSHeight}:</label></div>
					<div class='span7'><label class='green' id="txtHeight"></label></div>
				</div>
				<div class='row-fluid' style="margin-top: 10px;">
					<div class='span5'><label class='text-right'>${uiLabelMap.MSMotherTongue}:</label></div>
					<div class='span7'><label class='green' id="txtMotherTongue"></label></div>
				</div>
				<div class='row-fluid margin-bottom10'>
					<div class='span5'><label class='text-right'>${uiLabelMap.MSMaritalStatus}:</label></div>
					<div class='span7'><label class='green' id="txtMaritalStatus"></label></div>
				</div>
			</div>
		</div>
	</div>
</div>
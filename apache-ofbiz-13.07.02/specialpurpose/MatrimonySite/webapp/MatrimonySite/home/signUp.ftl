<#include "component://MatrimonySite/webapp/MatrimonySite/home/ftLlibrary.ftl"/>
<#include "component://MatrimonySite/webapp/MatrimonySite/home/decorator.ftl"/>
<script type="text/javascript" src="/MatrimonySite/images/js/signUp.js"></script>
<head>
	<title>MatrimonySite: ${StringUtil.wrapString(uiLabelMap.MSSignUp)}</title>
</head>
<a href="TimeLine">${StringUtil.wrapString(uiLabelMap.MSSignIn)}</a>
<div id="signUp">
	<div class="span12 no-left-margin boder-all-profile">
	<span class="text-header">${uiLabelMap.MSAccountDetails}</span>
		<div class='row-fluid'>
			<div class='span12'>
				<div class='row-fluid margin-bottom10'>
					<div class='span5'><label class='text-right asterisk'>${uiLabelMap.MSUsername}</label></div>
					<div class='span7'><input type='text' id="txtUsername" /></div>
				</div>
				<div class='row-fluid margin-bottom10'>
					<div class='span5'><label class='text-right asterisk'>${uiLabelMap.MSEmailID}</label></div>
					<div class='span7'><input type='text' id="txtEmailID" /></div>
				</div>
				<div class='row-fluid margin-bottom10'>
					<div class='span5'><label class='text-right asterisk'>${uiLabelMap.MSPassword}</label></div>
					<div class='span7'><input type='password' id="txtPassword" /></div>
				</div>
			</div>
		</div>
	</div>
	
	<div class="span12 no-left-margin boder-all-profile">
	<span class="text-header">${uiLabelMap.MSBasicDetails}</span>
		<div class='row-fluid'>
			<div class='span4'>
				<div class='row-fluid margin-bottom10'>
					<div class='span5'><label class='text-right asterisk'>${uiLabelMap.MSLastName}</label></div>
					<div class='span7'><input type='text' class="medium-size-input" id="txtLastName" /></div>
				</div>
				<div class='row-fluid margin-bottom10'>
					<div class='span5'><label class='text-right asterisk'>${uiLabelMap.MSBirthDate}</label></div>
					<div class='span7'><div id="txtBirthDate"></div></div>
				</div>
				<div class='row-fluid' style="margin-top: 10px;">
					<div class='span5'><label class='text-right asterisk'>${uiLabelMap.MSContactNumber}</label></div>
					<div class='span7'><input type='text' class="medium-size-input" id="txtContactNumber" /></div>
				</div>
				<div class='row-fluid margin-bottom10'>
					<div class='span5'><label class='text-right'>${uiLabelMap.MSReligion}&nbsp;&nbsp;</label></div>
					<div class='span7'><input type='text' class="medium-size-input" id="txtReligion" /></div>
				</div>
			</div>
			<div class='span4'>
				<div class='row-fluid margin-bottom10'>
					<div class='span5'><label class='text-right'>${uiLabelMap.MSMiddleName}&nbsp;&nbsp;</label></div>
					<div class='span7'><input type='text' class="medium-size-input" id="txtMiddleName" /></div>
				</div>
				<div class='row-fluid margin-bottom10'>
					<div class='span5'><label class='text-right asterisk'>${uiLabelMap.MSGender}</label></div>
					<div class='span7'><div id="txtGender"></div></div>
				</div>
				<div class='row-fluid' style="margin-top: 10px;">
					<div class='span5'><label class='text-right asterisk'>${uiLabelMap.MSCity}</label></div>
					<div class='span7'><div id="txtCity"></div></div>
				</div>
				<div class='row-fluid' style="margin-top: 10px;">
					<div class='span5'><label class='text-right asterisk'>${uiLabelMap.MSCaste}</label></div>
					<div class='span7'><div id="txtCaste"></div></div>
				</div>
			</div>
			<div class='span4'>
				<div class='row-fluid margin-bottom10'>
					<div class='span5'><label class='text-right asterisk'>${uiLabelMap.MSFirstName}</label></div>
					<div class='span7'><input type='text' class="medium-size-input" id="txtFirstName" /></div>
				</div>
				<div class='row-fluid margin-bottom10'>
					<div class='span5'><label class='text-right'>${uiLabelMap.MSHeight}&nbsp;&nbsp;</label></div>
					<div class='span7'><div id="txtHeight"></div></div>
				</div>
				<div class='row-fluid' style="margin-top: 10px;">
					<div class='span5'><label class='text-right'>${uiLabelMap.MSMotherTongue}&nbsp;&nbsp;</label></div>
					<div class='span7'><input type='text' class="medium-size-input" id="txtMotherTongue" /></div>
				</div>
				<div class='row-fluid margin-bottom10'>
					<div class='span5'><label class='text-right'>${uiLabelMap.MSMaritalStatus}&nbsp;&nbsp;</label></div>
					<div class='span7'><div id="txtMaritalStatus"></div></div>
				</div>
			</div>
		</div>
	</div>
	
	<div class="span12 no-left-margin boder-all-profile">
	<span class="text-header">${uiLabelMap.MSChargesForRegistration}</span>
		<div class='row-fluid'>
			<div class='span4'>
				<div class='row-fluid margin-bottom10'>
					<div class='span5'><label class='text-right asterisk'>${uiLabelMap.MSChargesForRegistration}</label></div>
					<div class='span7'><div id="txtChargesForRegistration"></div></div>
				</div>
			</div>
		</div>
	</div>
</div>

<div class="span12 margin-top10">
	<button id='btnCreate' class="btn btn-primary"><i class='icon-ok'></i>${uiLabelMap.MSCreate}</button>
</div>
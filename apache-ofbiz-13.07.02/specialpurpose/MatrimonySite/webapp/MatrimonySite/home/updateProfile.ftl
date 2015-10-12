<#include "component://MatrimonySite/webapp/MatrimonySite/home/ftLlibrary.ftl"/>
<script type="text/javascript" src="/MatrimonySite/images/js/updateProfile.js"></script>
<#assign userLoginPartyId=userLogin.getString("partyId") />
<#assign partyId=parameters.partyId?if_exists />

<html class="st-layout ls-top-navbar ls-bottom-footer show-sidebar sidebar-l2" lang="en">
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <meta name="description" content="">
  <meta name="author" content="">
  <title>MatrimonySite: ${StringUtil.wrapString(uiLabelMap.MSProfile)}</title>
  <link href="/MatrimonySite/images/themes/social-2/css/vendor/all.css" rel="stylesheet">
  <link href="/MatrimonySite/images/themes/social-2/css/app/app.css" rel="stylesheet">
</head>

<body>

  <div class="st-container">

    <div class="navbar navbar-main navbar-primary navbar-fixed-top" role="navigation">
      <div class="container-fluid">
        <div class="navbar-header">
          <a href="#sidebar-menu" data-effect="st-effect-1" data-toggle="sidebar-menu" class="toggle pull-left visible-xs"><i class="fa fa-ellipsis-v"></i></a>
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#main-nav">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a href="#sidebar-chat" data-toggle="sidebar-menu" data-effect="st-effect-1" class="toggle pull-right visible-xs"><i class="fa fa-comments"></i></a>
          <a class="navbar-brand" href="TimeLine">Matrimony Site</a>
        </div>

        <div class="collapse navbar-collapse" id="main-nav">
          <ul class="nav navbar-nav navbar-right">
            <li class="dropdown">
              <a href="#" class="dropdown-toggle user" data-toggle="dropdown">
                <img src="/MatrimonySite/images/themes/social-2/images/people/110/guy-6.jpg" alt="${(person.partyFullName)?if_exists}" class="img-circle" width="40" /> ${(person.partyFullName)?if_exists} <span class="caret"></span>
              </a>
              <ul class="dropdown-menu" role="menu">
                <li><a href="UpdateProfile">${uiLabelMap.MSUpdateProfile}</a></li>
                
                <li class="dropdown" id="liLanguage">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">${uiLabelMap.MSLanguage} <span class="caret"></span></a>
	                <ul class="dropdown-menu" role="menu">
	                  <li><a href="setSessionLocale?newLocale=en">${uiLabelMap.MSEnglish}</a></li>
	                  <li><a href="setSessionLocale?newLocale=vi">${uiLabelMap.MSVietnamese}</a></li>
	                </ul>
                </li>
                
                <li><a href="logout">${uiLabelMap.Logout}</a></li>
              </ul>
            </li>
          </ul>
        </div>
      </div>
    </div>

    <div class="sidebar left sidebar-size-2 sidebar-offset-0 sidebar-visible-desktop sidebar-visible-mobile sidebar-skin-dark" id="sidebar-menu">
      <div data-scrollable>
        <div class="sidebar-block">
          <div class="profile">
            <img src="/MatrimonySite/images/themes/social-2/images/people/110/guy-6.jpg" alt="people" class="img-circle" />
            <h4>${(person.partyFullName)?if_exists}</h4>
          </div>
        </div>
        <div class="category">${uiLabelMap.MSAbout}</div>
        <div class="sidebar-block">
          <ul class="list-about">
            <li><i class="fa fa-map-marker"></i> ${(person.cityDetails)?if_exists}</li>
            <li><i class="fa fa-phone"></i> <a href="#">${(person.contactNumber)?if_exists}</a></li>
            <li><i class="fa fa-user"></i> <a href="#">${(person.casteName)?if_exists}</a></li>
          </ul>
        </div>
      </div>
    </div>

    
    <div class="st-pusher" id="content">
      <div class="st-content">

        <div class="st-content-inner">

          <nav class="navbar navbar-subnav navbar-static-top margin-bottom-none" role="navigation">
            <div class="container-fluid">
              <div class="collapse navbar-collapse" id="subnav">
                <ul class="nav navbar-nav ">
                  <li><a href="TimeLine"><i class="fa fa-fw icon-ship-wheel"></i> ${uiLabelMap.TimeLine}</a></li>
                  <li class="active"><a href="Profile"><i class="fa fa-fw icon-user-1"></i> ${uiLabelMap.MSAbout}</a></li>
                  <li><a href="Friends"><i class="fa fa-fw fa-users"></i> ${uiLabelMap.MSFriends}</a></li>
                </ul>
              </div>
            </div>
          </nav>
          <div class="cover overlay cover-image-full height-300-lg">
            <img src="/MatrimonySite/images/themes/social-2/images/profile-cover.jpg" alt="cover" />
            <div class="overlay overlay-full"></div>
          </div>
          <div class="container-fluid" id="signUp">
			
			<div class="panel panel-default">
              <div class="panel-heading panel-heading-gray">
                <i class="fa fa-info"></i> ${uiLabelMap.MSAccountDetails}
              </div>
              <div class="panel-body">
              	
	              <div class='row-fluid'>
		              <div class='span4'>
						<div class='row-fluid margin-bottom10'>
							<div class='span5'><label class='text-right asterisk'>${uiLabelMap.MSUsername}</label></div>
							<div class='span7'><label class='green' id="txtUsername"></label></div>
						</div>
						<div class='row-fluid margin-bottom10'>
							<div class='span5'><label class='text-right asterisk'>${uiLabelMap.MSEmailID}</label></div>
							<div class='span7'><input type='text' id="txtEmailID" /></div>
						</div>
						<div class='row-fluid margin-bottom10'>
							<div class='span5'><label class='text-right asterisk'>${uiLabelMap.MSExpiredDate}</label></div>
							<div class='span7' style="margin-top: 5px;">
								<label class='green' id="txtExpiredDate" style="display: inline;"></label>
								<a id="renewals">(${StringUtil.wrapString(uiLabelMap.MSRenewals)})</a>
							</div>
						</div>
					</div>
		  		</div>
              
              </div>
            </div>
            
            <div class="panel panel-default">
            <div class="panel-heading panel-heading-gray">
            <i class="fa fa-info-circle"></i> ${uiLabelMap.MSBasicDetails}
            </div>
            <div class="panel-body">
            
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
					<div class='row-fluid margin-bottom10'>
						<div class='span5'><label class='text-right asterisk'>${uiLabelMap.MSContactNumber}</label></div>
						<div class='span7'><input type='text' class="medium-size-input" id="txtContactNumber" /></div>
					</div>
					<div class='row-fluid margin-bottom10'>
						<div class='span5'><label class='text-right'>${uiLabelMap.MSReligion}&nbsp;&nbsp;</label></div>
						<div class='span7'><input type='text' class="medium-size-input" id="txtReligion" /></div>
					</div>
					<div class='row-fluid margin-bottom10'>
						<div class='span5'><label class='text-right'>${uiLabelMap.MSIntroduction}&nbsp;&nbsp;</label></div>
						<div class='span7'><textarea id="txtIntroduction" style="resize: none;width: 273%;" ></textarea></div>
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
					<div class='row-fluid margin-bottom10'>
						<div class='span5'><label class='text-right asterisk'>${uiLabelMap.MSCity}</label></div>
						<div class='span7'><div id="txtCity"></div></div>
					</div>
					<div class='row-fluid margin-bottom10'>
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
					<div class='row-fluid margin-bottom10'>
						<div class='span5'><label class='text-right'>${uiLabelMap.MSMotherTongue}&nbsp;&nbsp;</label></div>
						<div class='span7'><input type='text' class="medium-size-input" id="txtMotherTongue" /></div>
					</div>
					<div class='row-fluid margin-bottom10'>
						<div class='span5'><label class='text-right'>${uiLabelMap.MSMaritalStatus}&nbsp;&nbsp;</label></div>
						<div class='span7'><div id="txtMaritalStatus"></div></div>
					</div>
				</div>
			</div>
            
			<div class="span11 margin-top10">
				<button id='btnUpdate' class="btn btn-primary" style="float: right;margin-right: 31px;"><i class='icon-ok'></i>${uiLabelMap.MSUpdate}</button>
			</div>
			
			</div>
            </div>
            
          </div>
        </div>
      </div>
    </div>
    <footer class="footer">
    <strong>ThemeKit</strong> v4.0.0 &copy; Copyright 2015
  </footer>
  </div>
  
<div id="jqxwindowRenewals" style="display:none;">
	<div>${uiLabelMap.MSRenewals}</div>
	<div style="overflow-x: hidden;">
		<div class="row-fluid">
			<div class="span12">
				<div class='span4'><label class='text-right asterisk'>${uiLabelMap.MSRenewals}</label></div>
				<div class='span8'><div id="txtRenewals"></div></div>
			</div>
		</div>
		<hr style="margin: 10px 0px 8px 0px; border-top: 1px solid grey;">
		<div class="row-fluid margin-top10">
			<div class="span12">
				<button id='cancelRenewals' class="btn btn-danger form-action-button pull-right"><i class='icon-remove'></i>${uiLabelMap.CommonCancel}</button>
				<button id='saveRenewals' class="btn btn-primary form-action-button pull-right"><i class='icon-ok'></i>${uiLabelMap.MSRenewals}</button>
			</div>
		</div>
	</div>
</div>
  
  <script>
    var userLoginPartyId = "${userLoginPartyId?if_exists}";
    var partyIdFromParameters = "${partyId?if_exists}";
  </script>
</body>
</html>
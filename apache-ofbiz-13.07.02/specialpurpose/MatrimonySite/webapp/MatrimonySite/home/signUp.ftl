<#include "component://MatrimonySite/webapp/MatrimonySite/home/ftLlibrary.ftl"/>
<script type="text/javascript" src="/MatrimonySite/images/js/signUp.js"></script>
<html class="st-layout ls-top-navbar ls-bottom-footer show-sidebar sidebar-l2" lang="en">
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <meta name="description" content="">
  <meta name="author" content="">
  <title>MatrimonySite: ${StringUtil.wrapString(uiLabelMap.TimeLine)}</title>
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
      </div>
    </div>

    <div class="sidebar left sidebar-size-2 sidebar-offset-0 sidebar-visible-desktop sidebar-visible-mobile sidebar-skin-dark" id="sidebar-menu">
      <div data-scrollable>
        <div class="sidebar-block">
          <div class="profile">
            <img style="width: 104%;" src="/MatrimonySite/images/image/Heart.jpg" alt="people" class="img-circle" />
          </div>
        </div>
      </div>
    </div>

    
    <div class="st-pusher" id="content">
      <div class="st-content">

        <div class="st-content-inner">
          <div class="cover overlay cover-image-full height-300-lg" style="margin-top: -14px;height: 214px !important;">
            <img src="/MatrimonySite/images/image/network.jpg" alt="cover" />
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
            
            </div>
            </div>
            
            <div class="panel panel-default">
            <div class="panel-heading panel-heading-gray">
            <i class="fa fa-money"></i> ${uiLabelMap.MSChargesForRegistration}
            </div>
            <div class="panel-body">
            
	            <div class='row-fluid'>
					<div class='span4'>
						<div class='row-fluid margin-bottom10'>
							<div class='span5'><label class='text-right asterisk'>${uiLabelMap.MSChargesForRegistration}</label></div>
							<div class='span7'><div id="txtChargesForRegistration"></div></div>
						</div>
					</div>
				</div>
            
				<div class="span11 margin-top10">
		        	<button id='btnCreate' class="btn btn-primary" style="float: right;margin-right: 31px;"><i class='icon-ok'></i>${uiLabelMap.MSCreate}</button>
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
</body>
</html>

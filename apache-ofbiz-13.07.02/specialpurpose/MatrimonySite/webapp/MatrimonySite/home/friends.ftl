<#include "component://MatrimonySite/webapp/MatrimonySite/home/ftLlibrary.ftl"/>
<script type="text/javascript" src="/MatrimonySite/images/js/friends.js"></script>

<#assign userLoginPartyId=userLogin.getString("partyId") />

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
                  <li><a href="Profile"><i class="fa fa-fw icon-user-1"></i> ${uiLabelMap.MSAbout}</a></li>
                  <li class="active"><a href="Friends"><i class="fa fa-fw fa-users"></i> ${uiLabelMap.MSFriends}</a></li>
                </ul>
              </div>
            </div>
          </nav>
          <div class="cover overlay cover-image-full height-300-lg">
            <img src="/MatrimonySite/images/themes/social-2/images/profile-cover.jpg" alt="cover" />
            <div class="overlay overlay-full"></div>
          </div>
          <div class="container-fluid">
			
			<div class="panel panel-default">
              <div class="panel-heading panel-heading-gray">
                <i class="fa fa-heart"></i> ${uiLabelMap.MSFriendRequests}
              </div>
              <div class="panel-body">
              	
              <div id="friendRequestDataTable"></div>
              
              </div>
            </div>
			
            <div class="panel panel-default">
            <div class="panel-heading panel-heading-gray">
            <i class="fa fa-users"></i> ${uiLabelMap.MSFriends}
            </div>
            <div class="panel-body">
            
            <div id="friendsDataTable"></div>
            
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
  <script>
    var userLoginPartyId = "${userLoginPartyId?if_exists}";
  </script>
</body>
</html>

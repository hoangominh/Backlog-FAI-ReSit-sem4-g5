<#include "component://MatrimonySite/webapp/MatrimonySite/home/ftLlibrary.ftl"/>
<script type="text/javascript" src="/MatrimonySite/images/js/dashboard.js"></script>
<script type="text/javascript" src="/MatrimonySite/images/js/DataAccess.js"></script>

<html class="st-layout ls-top-navbar ls-bottom-footer show-sidebar sidebar-l2" lang="en">
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <meta name="description" content="">
  <meta name="author" content="">
  <title>Administrator: Dashboard</title>
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
          <a class="navbar-brand" href="TimeLine">Administrator</a>
        </div>
        
        <div class="collapse navbar-collapse" id="main-nav">
	        <ul class="nav navbar-nav navbar-right">
	          <li class="dropdown">
	            <a href="#" class="dropdown-toggle user" data-toggle="dropdown">
	              <img src="/MatrimonySite/images/themes/social-2/images/people/110/guy-5.jpg" alt="Administrator" class="img-circle" width="40" /> Administrator <span class="caret"></span>
	            </a>
	            <ul class="dropdown-menu" role="menu">
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
    
	    <div style="margin-left: 55px;margin-top: 25px;">
		    <div class='row-fluid margin-top10'>
		    	<div class='span1'></div>
				<div class='span2'><label class='text-right'>${uiLabelMap.MSRangeTime}</label></div>
				<div class='span2'><div id="rangeTime"></div></div>
			</div>
		
		    <div class="span12 boder-all-profile">
		    <span class="text-header">${uiLabelMap.MSCustomersChart}</span>
		    	<div id='chartContainer' style="width: 100%; height:500px"></div>
		    </div>
		
		    <div class="span12 boder-all-profile">
		    <span class="text-header">${uiLabelMap.MSCustomersList}</span>
		    	<div class='row-fluid'>
		    		<a id="clearFilter" title="Ctrl + F" style="float: right;cursor: pointer;"><i class="fa fa-filter"></i> ${StringUtil.wrapString(uiLabelMap.MSClearFilter)}</a>
		    		<div id="gridCustomer"></div>
		    	</div>
		    </div>
	    </div>
    </div>
    
    <footer class="footer">
    <strong>Matrimony Site</strong> v4.0.0 &copy; Copyright 2015
  </footer>
  </div>
</body>
</html>

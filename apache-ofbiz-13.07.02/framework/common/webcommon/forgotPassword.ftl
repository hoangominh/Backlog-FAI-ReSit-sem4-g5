<link href="/MatrimonySite/images/themes/social-2/css/app/app.css" rel="stylesheet">
<link href="/MatrimonySite/images/themes/social-2/css/vendor/all.css" rel="stylesheet">
<body class="login">
<div id="content">
<div class="container-fluid">

  <div class="lock-container">
    <h1>${uiLabelMap.CommonForgotYourPassword}?</h1>
    <div class="panel panel-default text-center">
      <img src="/MatrimonySite/images/themes/social-2/images/people/110/guy-5.jpg" class="img-circle">
      <div class="panel-body">
      
      <form method="post" action="<@ofbizUrl>forgotPassword${previousParams?if_exists}</@ofbizUrl>" name="forgotpassword">
      <input class="form-control" type="text" name="USERNAME" placeholder="Username" name="USERNAME" value="<#if requestParameters.USERNAME?has_content>${requestParameters.USERNAME}<#elseif autoUserLogin?has_content>${autoUserLogin.userLoginId}</#if>">
      <input type="submit" class="btn btn-primary" name="EMAIL_PASSWORD" class="smallSubmit" value="${uiLabelMap.CommonEmailPassword}"/>
      <a class="forgot-password" href='<@ofbizUrl>main</@ofbizUrl>' class="button">${uiLabelMap.CommonGoBack}</a>
      <input type="hidden" name="JavaScriptEnabled" value="N"/>
    </form>
      
      </div>
    </div>
  </div>

</div>
</div>
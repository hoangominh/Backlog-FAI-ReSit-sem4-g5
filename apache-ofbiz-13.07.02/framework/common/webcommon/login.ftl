<#if requestAttributes.uiLabelMap?exists><#assign uiLabelMap = requestAttributes.uiLabelMap></#if>
<#assign useMultitenant = Static["org.ofbiz.base.util.UtilProperties"].getPropertyValue("general.properties", "multitenant")>

<#assign username = requestParameters.USERNAME?default((sessionAttributes.autoUserLogin.userLoginId)?default(""))>
<#if username != "">
  <#assign focusName = false>
<#else>
  <#assign focusName = true>
</#if>

<link href="/MatrimonySite/images/themes/social-2/css/app/app.css" rel="stylesheet">
<link href="/MatrimonySite/images/themes/social-2/css/vendor/all.css" rel="stylesheet">
<body class="login">
<div id="content">
<div class="container-fluid">

  <div class="lock-container">
    <h1>Account Access</h1>
    <div class="panel panel-default text-center">
      <img src="/MatrimonySite/images/themes/social-2/images/people/110/guy-5.jpg" class="img-circle">
      <div class="panel-body">
      <form method="post" action="<@ofbizUrl>login</@ofbizUrl>" name="loginform">
        <input class="form-control" type="text" name="USERNAME" placeholder="Username">
        <input class="form-control" type="password" name="PASSWORD" placeholder="Enter Password">
        <input type="hidden" name="JavaScriptEnabled" value="N"/>
        <input type="submit" class="btn btn-primary" value="${uiLabelMap.CommonLogin}"/>
    	<a href="SignUp" class="forgot-password">${StringUtil.wrapString(uiLabelMap.MSSignUp)}</a>
    	<a href="<@ofbizUrl>forgotPassword</@ofbizUrl>" class="forgot-password">${uiLabelMap.CommonForgotYourPassword}?</a>
        </form>
      </div>
    </div>
  </div>

</div>
</div>
<script language="JavaScript" type="text/javascript">
document.loginform.JavaScriptEnabled.value = "Y";
<#if focusName>
  document.loginform.USERNAME.focus();
<#else>
  document.loginform.PASSWORD.focus();
</#if>
</script>
</body>
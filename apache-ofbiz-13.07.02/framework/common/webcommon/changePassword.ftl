<#assign username = requestParameters.USERNAME?default((sessionAttributes.autoUserLogin.userLoginId)?default(""))>
<#assign tenantId = requestParameters.tenantId!>

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
      	  <input type="hidden" name="requirePasswordChange" value="Y"/>
          <input type="hidden" name="USERNAME" value="${username}"/>
          <input type="hidden" name="tenantId" value="${tenantId!}"/>
      		<h4>${username}</h4>
      
        <input class="form-control" type="password" name="PASSWORD" placeholder="${uiLabelMap.CommonCurrentPassword}">
        <input class="form-control" type="password" name="newPassword" placeholder="${uiLabelMap.CommonNewPassword}">
        	<input class="form-control" type="password" name="newPasswordVerify" placeholder="${uiLabelMap.CommonNewPasswordVerify}">
        <input type="submit" class="btn btn-primary" value="${uiLabelMap.CommonSubmit}"/>
        </form>
      </div>
    </div>
  </div>

</div>
</div>

<script language="JavaScript" type="text/javascript">
  document.loginform.PASSWORD.focus();
</script>

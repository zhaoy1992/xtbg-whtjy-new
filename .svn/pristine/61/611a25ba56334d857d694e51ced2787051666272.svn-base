<%@ page language="java" contentType="text/html; charset=gb2312"%>
<%@include file="/epp/eppTemplate/login_control.jsp" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
		<title>电子政务应用支撑平台</title>
		<link href="<%=contextPath%>/epp/css/cms.css" rel="stylesheet" type="text/css">
		<script language="JavaScript" src="<%=contextPath%>/purviewmanager/scripts/func.js" type="text/javascript"></script>
		<style type="text/css">
<!--
.input_text {border:1px #77849E solid;height:18px; width:120px; font-family:Verdana;font-size: 12px; color:#566682
}
.copyrightbox{margin-top:8px; font-family:Verdana, Arial, Helvetica, sans-serif; color:#E1E9F0; text-align:center}
.copyrightbox a:link{ text-decoration:none;color:#ffffff;}
.copyrightbox a:visited{ text-decoration:none;color:#ffffff;}
.copyrightbox a:hover{ text-decoration:underline;color:#EAE2CD;}
-->
</style>		
	</head>
	<%@ include file="/epp/css/cssControl.jsp"%>
	<body onload="savepass();">
		<form name="loginForm" action="login_body.jsp" method="post">
			<input type="hidden" name="app_id" value="">			
			<div style="background:url(<%=contextPath%>/epp/eppTemplate/images/login_Bottom_bg.jpg);margin-top:-3px;padding-top:100px;padding-bottom:70px" align="center">
				<div style="background:url(<%=contextPath%>/epp/eppTemplate/images/zh.jpg) no-repeat; height:413px; width:776px; margin:0 auto;">
					<table width="60%" align="right" cellspacing="10" style="margin-top:200px" class="pass">
						<tr>
							<td align="right">
								用户名：
							</td>
							<td align="left">
								<input name="userName" type="text" size="15" class="input_text" maxlength="<%=userNamelength%>" onkeydown="if (event.keyCode==13)saveName();" onchange="showpass();">
							</td>
						</tr>
						<tr>
							<td align="right">
								密&nbsp;&nbsp;码：
							</td>
							<td align="left">
								<input name="password" type="password" size="15" class="input_text" onkeydown="if (event.keyCode==13)saveName();">
							</td>
						</tr>
						<tr>
							<td align="right">								
							</td>
							<td align="left">
								<input name="savepass" type="checkbox" >记住密码
							</td>
						</tr>
						<tr>
							<td></td>
							<td align="left">
								<img src="<%=contextPath%>/epp/eppTemplate/images/logon_03.gif" width="58" height="22" border="0" onclick="saveName();" style="cursor: hand;" onmousemove="this.style.position='relative'; this.style.top='1px';" onmouseout="this.style.top='0px';" />
								&nbsp;
								<img src="<%=contextPath%>/epp/eppTemplate/images/logon_05.gif" width="58" height="22" border="0" onclick="userName.value=password.value='';" style="cursor: hand;" onmousemove="this.style.position='relative'; this.style.top='1px';" onmouseout="this.style.top='0px';" />
							</td>
						</tr>
					</table>
					<div style="margin-top:390px; text-align:center; color:#FFFFFF">
						<a href="http://www.chinacreator.com"><font color="#FFFFFF">湖南科创信息技术股份有限公司</font> </a> CopyRight 2008
					</div>
				</div>

			</div>
		</form>
	</body>	
	<script type="text/javascript">
		function savepass(){
			var form = document.loginForm;
			form.savepass.checked = readcookie("savepass");
			/*
			if(form.userName.value == readcookie("userck")){
				form.password.value = readcookie("passck");
			}*/
			// modified by yaohui.luo	2008-8-16
			form.userName.value = readcookie("userck");
			form.password.value = readcookie("passck");	
		}

		function showpass(){
			var form = document.loginForm;
			if(form.userName.value == readcookie("userck")){
				form.password.value = readcookie("passck");
			}
		}
	</script>
</html>

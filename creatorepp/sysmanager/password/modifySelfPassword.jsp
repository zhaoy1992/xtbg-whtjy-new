<%@ page contentType="text/html; charset=GBK" %>
<%@page import="com.chinacreator.security.AccessControl"%>
<%
	AccessControl accessControl = AccessControl.getInstance();
    accessControl.checkAccess(request,response);
%>
<title>个人密码修改</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<link rel="stylesheet" type="text/css" href="../css/windows.css">
<link rel="stylesheet" type="text/css" href="../css/contentpage.css">
<link rel="stylesheet" type="text/css" href="../css/tab.winclassic.css">
<script language="JavaScript" SRC="../scripts/validateForm.js"></script>
<script language="javascript">
function validateInput(formObj){
           	
      		if(validateForm(formObj)){
                 	var PASSWORD = formObj.passWord;
                  	var PASSWORD_VALIDATE = formObj.passWordConfirm;
                  	if(PASSWORD.value.length < PASSWORD.minLength){
                        	alert("用户密码不能少于 \"6\" 位有效字符，请您重新输入！");
                              	PASSWORD.focus();
                              	return false;
                  	}

                  	if(PASSWORD.value != PASSWORD_VALIDATE.value){
                         	alert("\"用户密码\"和\"确认密码\"不符，请您重新输入！");
                              	PASSWORD_VALIDATE.focus();
                              	return false;
                        }

                        if(confirm("您确认要修改您自己的系统登陆密码吗？")){
                        	return true;						
                     	}
                       	else{
                                 return false;
                       	}
            	}else{  return false; }
	}
	
function init() {
  document.cacForm.oldPassword.focus();
}

function resetpwd(){
	
	document.forms[0].oldPassword.value="";
	document.forms[0].passWord.value="";
	document.forms[0].passWordConfirm.value="";
}
</script>

<%@ include file="/epp/css/cssControl.jsp"%><body  onload="init()">   	
<form name="cacForm" action="saveModifySelfPWD.jsp" target="backgroundDealFrame"
              onsubmit="return validateInput(cacForm)">             
<table border="0" align="center" width="100%" cellpadding="0" cellspacing="0">
<tr>
<td width="100%" align="left" ></td>
</tr>
<tr>
<td width="100%" align="left" ><table border='0' align="left" width="100%" cellpadding='0' cellspacing='0'>
<tr><td><table border='0' align="left" width="100%" cellpadding='0' cellspacing='0'>
  <tr height='24px'>    <td width='100%' height='27px' background='../../images/oa_r7_c7.jpg' class='form_title'>
&nbsp;&nbsp;个人密码修改</td>
</table></td></tr>

<tr><td><table width="100%" align="left" class="form_body" cellspacing="0" cellpadding="0" >
<tr>
<td width="100%" align="left" ><table border='1' align="left" width="100%"  cellpadding='0' cellspacing='0'><tr><td>
<table width="60%" align="center"   cellpadding="0" cellspacing="0" >


<tr>
<td width="30%" align="right" >&nbsp;</td>
<td width="70%" align="center" >&nbsp;</td>
</tr>
<tr>
<td width="30%" align="center">&nbsp;旧密码:</td>
<td width='*'><input type="password" name="oldPassword"   size="25" labelClass="label" ></td>
</tr>

<tr>
<td width="30%" align="center" >&nbsp;</td>
<td width="70%" align="center" >&nbsp;</td>
</tr>

<tr>
<td width="30%" align="center" >&nbsp;新密码:</td>
<td width='*'><input type="password" name="passWord"  size="25" validator="stringLegal" cnname="登陆密码" minLength="6" maxlength="25"  labelClass="label" ></td>
</tr>

<tr>
<td width="30%" align="center" >&nbsp;</td>
<td width="70%" align="center" >&nbsp;</td>
</tr>

<tr>
<td width="30%" align="center" >&nbsp;确认密码:</td>
<td width='*'><input type="password" name="passWordConfirm"  size="25"  labelClass="label" ></td>
</tr>

<tr>
<td width="30%" align="center" >&nbsp;</td>
<td width="70%" align="center" >&nbsp;</td>
</tr>
</table>
</td></tr></table>
</td>
</tr>
<tr>
<td width="100%" align="center" ><hr width="100%">
<table border='0' align="center" width="100%" cellpadding='0' cellspacing='0'>
<tr><td height='60' align='center'>
<input type="submit" name="save" value="确   定"   class="input"  >&nbsp;
<!--<input type="button" name="label2" value="关   闭"   class="form_button" onclick="window.close()" >-->
<input type="button" name="label2" value="重   置"   class="input" onclick="resetpwd()">
&nbsp;</td></tr></table></td>
</tr>
</table>
</td></tr></table>
</td>
</tr>
</table>


</SCRIPT>
<table width="100%" align="center" border="0" cellpadding="0" cellspacing="0">
</table>
</form>
<iframe id="backgroundDealFrame" border="0" frameborder="0" framespacing="0" marginheight="0" marginwidth="0"
             name="backgroundDealFrame" noResize scrolling="auto" vspale="0" width="0" height="0"
             src="" memo="本页面需要隐式的执行一些页面，为了不新开浏览窗口，所有隐式执行的页面都在此处执行">
</iframe>

</body>
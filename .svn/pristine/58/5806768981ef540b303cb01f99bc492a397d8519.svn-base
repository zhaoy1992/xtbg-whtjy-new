<%@ page contentType="text/html; charset=GBK" %>
<%@page import="com.chinacreator.security.AccessControl"%>
<%
	AccessControl accessControl = AccessControl.getInstance();
    accessControl.checkManagerAccess(request,response);
%>
<title>用户密码修改</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<link rel="stylesheet" type="text/css" href="../css/windows.css">
<link rel="stylesheet" type="text/css" href="../css/contentpage.css">
<link rel="stylesheet" type="text/css" href="../css/tab.winclassic.css">
<script language="JavaScript" SRC="../scripts/validateForm.js"></script>
<script language="javascript">
	function validateInput(formObj){
            var loginName = formObj.loginName.value;
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

                        if(confirm("您确认要修改登陆名为："+loginName+"的用户的密码吗？")){
                        	return true;
                        }
                       	else{
                                 return false;
                       	}
                    }else{  return false; }
	}
function init() {
  document.cacForm.loginName.focus();
}
function randgen(){
	document.forms[0].generatepassword.value=(Math.random().toString()).substr(2,6);
	genpwd.style.display="block";  
	document.forms[0].passWord.value=document.forms[0].generatepassword.value;
	document.forms[0].passWordConfirm.value=document.forms[0].generatepassword.value;
}
function resetpwd(){
	genpwd.style.display="none";
	document.forms[0].passWord.value="";
	document.forms[0].passWordConfirm.value="";
}

function openChoose(){
	
	var v = window.showModalDialog("chooseOrgUser.jsp",window,"dialogWidth:900px;dialogHeight:550px;help:no;scroll:auto;status:no");
	if(v!="undefined" && v!=null){
		cacForm.loginName.value = v;
	}
	
}
</script>

<%@ include file="/epp/css/cssControl.jsp"%><body  onload="init()">   	
<form name="cacForm" action="saveModifyUserPWD.jsp" 
              onsubmit="return validateInput(cacForm)">     
     <input type="hidden" name="orgId" id="orgId" value="" />        
<table border="0" align="center" width="100%" cellpadding="0" cellspacing="0">
<tr>
<td width="100%" align="left" ></td>
</tr>
<tr>
<td width="100%" align="left" ><table border='0' align="left" width="100%" cellpadding='0' cellspacing='0'>
<tr><td><table border='0' align="left" width="100%" cellpadding='0' cellspacing='0'>
  <tr height='24px'>    <td width='100%' height='27px' background='../../images/oa_r7_c7.jpg' class='form_title'>
&nbsp;&nbsp;用户密码修改</td>
</table></td></tr>

<tr><td><table width="100%" align="left" class="form_body" cellspacing="0" cellpadding="0" >
<tr>
<td width="100%" align="left" ><table border='1' align="left" width="100%"  cellpadding='0' cellspacing='0'><tr><td>
<table width="60%" align="center"   cellpadding="0" cellspacing="0" >


<tr>
<td width="30%" align="center" >&nbsp;</td>
<td width="30%" align="center" >&nbsp;</td>
<td width="40%" align="center" >&nbsp;</td>
</tr>
<tr>
<td width="30%" align="center">&nbsp;登陆名:</td>
<td width='30%' align="center"><input type="text" name="loginName" validator="stringLegal" cnname="登陆名" size="25" labelClass="label" ></td>
<td width="40%" align="left" ><a href="#" onclick="openChoose()">选取用户</a></td>
</tr>

<tr>
<td width="30%" align="center" >&nbsp;</td>
<td width="30%" align="center" >&nbsp;</td>
<td width="40%" align="center" >&nbsp;</td>
</tr>

<tr>
<td width="30%" align="center" >&nbsp;新密码:</td>
<td width="30%" align="center"><input type="password" name="passWord"  size="25" validator="stringLegal" cnname="登陆密码" minLength="6" maxlength="25"  labelClass="label" > </td>                         
<td width="40%" align="center"><div id='genpwd' class='label' style="display:none"><input type="text" name="generatepassword" value=""> </div> </td>
</tr>

<tr>
<td width="30%" align="center" >&nbsp;</td>
<td width="30%" align="center" >&nbsp;</td>
<td width="40%" align="center" >&nbsp;</td>
</tr>

<tr>
<td width="30%" align="center" >&nbsp;确认密码:</td>
<td width="30%" align="center"><input type="password" name="passWordConfirm"  size="25"  labelClass="label" ></td>
<td width="40%" align="center" >&nbsp;</td>
</tr>

<tr>
<td width="30%" align="center" >&nbsp;</td>
<td width="30%" align="center" >&nbsp;</td>
<td width="40%" align="center" >&nbsp;</td>
</tr>

<!-- tr>
<td width="30%" align="center" >&nbsp;是否短信告知用户:</td>
<td width="30%" align="left">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" name="isnoticeuser"></td>
<td width="40%" align="center" >&nbsp;</td>
</tr -->

<tr>
<td width="30%" align="center" >&nbsp;</td>
<td width="30%" align="center" >&nbsp;</td>
<td width="40%" align="center" >&nbsp;</td>
</tr>

</table>
</td></tr></table>
</td>
</tr>
<tr>
<td width="100%" align="center" >
<hr width="100%">
<table border='0' align="center" width="100%" cellpadding='0' cellspacing='0'>
	<tr>
		<td height='60'  align='center'>
			<input type="submit" name="save" value="确   定"   class="input" >&nbsp;
			<input type="button" name="label2" value="取   消"   class="input" onclick="resetpwd()">&nbsp;
			<input type="button" name="label3" value="密码生成" onclick="randgen()"  class="input"  >&nbsp;
		</td>
	</tr>
</table>
</td>
</tr>
</table>
</td></tr></table>
</td>
</tr>
</table>
<table width="100%" align="center" border="0" cellpadding="0" cellspacing="0">
</table>
</form>
<iframe id="backgroundDealFrame" border="0" frameborder="0" framespacing="0" marginheight="0" marginwidth="0"
             name="backgroundDealFrame" noResize scrolling="auto" vspale="0" width="0" height="0"
             src="" memo="本页面需要隐式的执行一些页面，为了不新开浏览窗口，所有隐式执行的页面都在此处执行">
</iframe>
	<%@ include file="../sysMsg.jsp"%>
</body>


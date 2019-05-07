<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.chinacreator.security.authorization.AccessException"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.workbench.cache.WorkbenchConfCache" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title><%=WorkbenchConfCache.getSystemBean().getSys_name() %></title>
<%
	String path = request.getContextPath();
	String fullPath = "http://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath();
	String successRedirect = request.getParameter("successRedirect");
	String flag = request.getParameter("flag"); //是否触发提交
	boolean islogin = false;
	
	if (flag != null){
		String userName = "";
		String password = "";
		userName = request.getParameter("userName");
		password = request.getParameter("password");
		String errorMessage = null;
		if (userName != null) {
			try {
				AccessControl.getInstance().login(request, response, userName, password);
				String subsystem = request.getParameter("subsystem_id");
				if (subsystem == null) {
					subsystem = "module";
				}
				if (successRedirect == null) {
					successRedirect = "oaindex.jsp";
				}
				islogin = true;
			} catch (AccessException ex) {
				errorMessage = ex.getMessage();
				if (errorMessage != null) {
					errorMessage = errorMessage.replaceAll("\\n","\\\\n");
					errorMessage = errorMessage.replaceAll("\\r","\\\\r");
				}
%>
				<script language="javascript">
	            var msg =  "<%=errorMessage%>";
	            if(msg=="null"){
	                		alert("登录失败，请确保输入的用户名和口令是否正确！");
	                	}else{
	                		alert("登录失败，请确保输入的用户名和口令是否正确！");
	                    	//alert(msg);
	            }
	               
				</script>
<%
			} catch (Exception ex) {
				errorMessage = ex.getMessage();
%>
				<script language="javascript">
	                <!--
	                    alert("<%=errorMessage%>"+ "登录失败，请确保输入的用户名和口令是否正确！");
	                //-->
	            </script>
<%
			}
		}
	}
%>

<%if(islogin){%>
<script language="javascript">
    <!--
    window.top.location="<%=successRedirect%>";
    //-->
</script>
<%}%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>科创协同及移动办公云平台</title>
<script src="ccapp/oa/resources/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="ccapp/oa/resources/plug/jquery1.7/jquery-1.7.1.min.js"></script>
<script type="text/javascript"src="ccapp/oa/resources/plug/ifrom/js/ifrom-tools.1.1.js"></script>
<script type="text/javascript"src="ccapp/oa/resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<link href="ccapp/oa/login/resources/css/css2.css" rel="stylesheet" type="text/css" />
<style type="text/css">
a:link {text-decoration:underline; color:#fff;}
a:visited {text-decoration:underline; color:#fff;}
a:active {text-decoration:underline; color:#fff;}
a:hover {text-decoration:underline; color:#fff;}
</style>

<script type="text/javascript">


$(document).keydown(function(){
	var elementObj;
	if(window.event){
		elementObj = event.srcElement
	}else{
		elementObj = event.target;
	}
	if(event.keyCode == 13){
		if($(elementObj).attr("class")!="_alert_div_edit_ok"){
			login(true);
		}
	}
});



	$(function(){
		/*
		 * 为账号输入框绑定焦点事件Start
		 */
		$("#userName").bind("focus",function(){
			$("#userName").removeClass();
			if($("#userName").val() == null || $("#userName").val() == ''){
				$("#userName").addClass("xin_denglu_k12");
			} else {
				$("#userName").addClass("xin_denglu_k13");
			}
			
		});
		$("#userName").bind("keydown",function(){
			$("#userName").removeClass();
			$("#userName").addClass("xin_denglu_k13");
		});
		$("#password").bind("keydown",function(){
			$("#password").removeClass();
			$("#password").addClass("xin_denglu_k23");
		});
		$("#userName").bind("focusout",function(){
			$("#userName").removeClass();
			if($("#userName").val() == null || $("#userName").val() == ''){
				$("#userName").addClass("xin_denglu_k11");
			} else {
				$("#userName").addClass("xin_denglu_k13");
			}
		});
		
		$("#password").bind("focus",function(){
			$("#password").removeClass();
			if($("#password").val() == null || $("#password").val() == ''){
				$("#password").addClass("xin_denglu_k22");
			}
			else{
				$("#password").addClass("xin_denglu_k23");
			}
			
		});
		$("#password").bind("focusout",function(){
			$("#password").removeClass();
			if($("#password").val() == null || $("#password").val() == ''){
				$("#password").addClass("xin_denglu_k21");
			}
			else{
				$("#password").addClass("xin_denglu_k23");
			}
		});
		 
		 //初始化
		$('#password').focus();
		$('#userName').focus();
		setCookie("OACONTEXTPATH", "<%=fullPath%>", "", "", null);
	})
	
		//获取IE版本
	function getInternetExplorerVersion()  
	{  
	  var rv = -1; // Return value assumes failure.   
	  if (navigator.appName == 'Microsoft Internet Explorer')  
	  {  
	    var ua = navigator.userAgent;  
	    var re  = new RegExp("MSIE ([0-9]{1,}[/.0-9]{0,})");  
	    if (re.exec(ua) != null)  
	      rv = parseFloat( RegExp.$1 );  
	  }  
	  return rv;  
	}  

	var ca_login_path = "https://59.231.28.149:4443/loginca.jsp";

	function certificate(){
		window.location.href = ca_login_path;
	}


	//登录事件，flag是否需要验证用户名及密码是否为空，true-是，flase-否
	function login(flag){
		if(flag) {
			loginForm.userName.value = $('#userName').val();
			var userName = loginForm.userName.value
			if(userName == ""){
				alert("请输入用户名！");
				loginForm.userName.focus();
				return false;
			}
			
			if(userName != "" && $('#password').val() == ""){
				alert("请输入密码！");
				loginForm.password.focus();
				return false;
			}
			if($('#vcode').is(':visible')&&$("#vcode").val().toLowerCase()!=$("#showvcode").val().toLowerCase()){
				alert("验证码不正确");
				return false;
			}
		}

		if($("#savepass").attr("checked")) {

			setCookie("USERNAME", loginForm.userName.value, "PASSWORD", loginForm.password.value, 14);
		} else {
			setCookie("USERNAME", loginForm.userName.value, "", "", null);
		}
		document.loginForm.submit();
	}
	
	//根据name从cookie中取出值
	function getCookie(c_name) {
		if (document.cookie.length > 0) {
			var c_start = document.cookie.indexOf(c_name + "=")
			if (c_start != -1) { 
				c_start = c_start + c_name.length + 1;
				var c_end = document.cookie.indexOf("^",c_start);
				if (c_end==-1) {
					c_end=document.cookie.length;
				}
				return unescape(document.cookie.substring(c_start,c_end));
			} 
		}
		return "";
	}
	
	//设置cookie
	function setCookie(c_name, n_value, p_name, p_value, expiredays) {
		var exdate = new Date();
		exdate.setDate(exdate.getDate() + expiredays);
		document.cookie = c_name + "=" + escape(n_value) + "^" + p_name + "=" + escape(p_value) 
			+ ((expiredays == null) ? "" : "^;expires=" + exdate.toGMTString());
	}
	
	//从cookie获取用户名和密码并复制给对应的输入框
	function setValue(c_name, p_name) {
		var username = getCookie(c_name);
		var password = getCookie(p_name);
		if(username != null && username != "") {
			$('#userName').val(username);
			$("#userName").removeClass();
			$("#userName").addClass("xin_denglu_k13");
		}
		if(password != null && password != "") {
			$('#password').val(password);
			$("#savepass").attr("checked",true);
			$("#password").removeClass();
			$("#password").addClass("xin_denglu_k13");
		}
	}
</script>
<script type="text/javascript">
function controlLoad(){
	var url = "<%=path%>/index_controlLoad.jsp";
	var s = new $.alertWindows('index_controlLoad',url,'下载中心',800,330,'25%','20%',false,false,false,true);
	s.init();
}
function lodad1(){
	var url ="<%=path %>/epp/eppTemplate/plugins/Setup.exe";
	location.href=url;
}

</script>
</head>
 
<body onload="setValue('USERNAME','PASSWORD')" style="background:#04495d;">
<form name="loginForm" action="login.jsp" method="post">
<input type="hidden" name="app_id" value="">
<input type="hidden" name="flag" value="yes">
<table width="1024" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td background="ccapp/oa/login/resources/images/kechuang.jpg"><table width="1024" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td height="225" colspan="2">&nbsp;</td>
        </tr>
      <tr>
        <td width="732" rowspan="5">&nbsp;</td>
        <td width="292" height="50"><input name="userName" id="userName" type="text" class="xin_denglu_k11" value="" /></td>
      </tr>
      <tr>
        <td height="50"><input name="password" id="password" type="password" class="xin_denglu_k21" value="" /></td>
      </tr>
      <tr>
        <td height="40"><input style="vertical-align:middle;" name="savepass" id="savepass" type="checkbox" value="" /> <span class="fontfff12">记住密码</span></td>
      </tr>
      <tr>
        <td height="50"><input name="" type="button" value="" class="xin_denglu_k2" onmouseover="this.style.backgroundImage='url(ccapp/oa/login/resources/images/xin_denglu_k21.gif)'" onmouseout="this.style.backgroundImage='url(ccapp/oa/login/resources/images/xin_denglu_k2.gif)'" onclick="login(true)"/></td>
      </tr>
      <tr>
         <!-- <td style="line-height:26px;"><a href="javascript:lodad1()">没有安装控件？</a><br />
          <a href="	<%=request.getContextPath()%>/epp/eppTemplate/help/help_zjj.doc">帮助中心</a></td> -->
          <td style="line-height:26px;">
         	 <br />
          	&nbsp;
          </td>
      </tr>
      <tr>
        <td height="40" colspan="2">&nbsp;</td>
      </tr>
      <tr>
        <td height="30" colspan="2" style="color:#51a3b9; font-size:14px; padding-left:285px;">版权所有：湖南科创信息技术股份有限公司</td>
        </tr>
    </table></td>
  </tr>
</table>
</form>
</body>
</html>

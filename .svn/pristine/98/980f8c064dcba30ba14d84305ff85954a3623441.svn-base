<%@page import="com.chinacreator.business.common.tools.CacheCommonManage"%>
<%@page import="com.chinacreator.sysmgrcore.entity.User"%>
<%@page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>
<%@page import="com.chinacreator.security.authorization.AccessException"%>
<%@page import="com.chinacreator.ca.CookieProperties"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.ca.CAManager"%>
<%@page import="com.chinacreator.ca.CaProperties"%>
<%@page import="com.chinacreator.config.ConfigManager"%>
<%@page import="com.chinacreator.xtbg.pub.util.StringUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>湖北省特检院办公自动化系统</title>

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
	                    alert("<%=errorMessage%>"+ "登录失败，请确保输入的用户名和口令是否正确！");
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
<script src="ccapp/xtbg/resources/js/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="ccapp/xtbg/resources/plug/jquery1.6/jquery-1.6.min.js"></script>
<script type="text/javascript"src="ccapp/oa/resources/plug/ifrom/js/ifrom-tools.1.1.js"></script>
<script type="text/javascript"src="ccapp/oa/resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript"src="ccapp/oa/resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<link href="ccapp/xtbg/resources/plug/ifrom/css/ifrom-ui-core.css" rel="stylesheet" type="text/css" >
<link href="ccapp/xtbg/tjy/login/resources/css/css2.css" rel="stylesheet" type="text/css" />
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
			login();
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
	function login(){
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
		//if($("#savepass").attr("checked")) {
		if(document.getElementsByName("savepass")[0].checked==true) {
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
	

</script>
<script type="text/javascript">
function controlLoad(){
	var url = "<%=path%>/index_controlLoad.jsp";
	var s = new $.alertWindows('index_controlLoad',url,'下载中心',800,330,'25%','20%',false,false,false,true);
	s.init();
}
function lodad1(){
	var url ="<%=path %>/epp/eppTemplate/plugins/allpluginsInt.exe";
	location.href=url;
}
function lodad2(){
	var url ="<%=path %>/epp/eppTemplate/plugins/allpluginsExt.exe";
	location.href=url;
}


</script>
</head>
 
<body onload="setValue('USERNAME','PASSWORD');" style="background:#fffced;">
<form name="loginForm" action="login.jsp" method="post">
<input type="hidden" name="app_id" value="">
<input type="hidden" name="flag" value="yes">
<table width="1024" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td background="ccapp/xtbg/tjy/login/resources/images/jiaoyu_denglu.jpg"><table width="1024" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td height="225" colspan="2">&nbsp;</td>
        </tr>
      <tr>
        <td width="390" rowspan="5">&nbsp;</td>
        <td width="629" height="50"><input name="userName" id="userName" type="text" class="xin_denglu_k11" value="" /></td>
      </tr>
      <tr>
        <td height="50"><input name="password" id="password" type="password" class="xin_denglu_k21" value="" />&nbsp;&nbsp;<input style="vertical-align:middle;" name="savepass" id="savepass" type="checkbox" value="" /> <span class="fontfff12">记住密码</span></td>
      </tr>
      <tr>
        <td height="40">
        	<input class='worktime'  id='work' type='button' onclick='addStarttime(1)'/>&nbsp;&nbsp;<input class='endtime'  id='nowork'  type='button' onclick='addEndtime(2)'/>
        </td>
      </tr>
      
      <tr>
        <td height="50"><input name="" type="button" value="" class="xin_denglu_k2" onmouseover="this.style.backgroundPosition='0px -288px'" onmouseout="this.style.backgroundPosition='0px -240px'" onclick="login()"/></td>
      </tr>
      <tr>
        <td style="line-height:26px;"><span style="color:#0a4a00;">没有安装控件？请下载(</span><a href="javascript:lodad1()" style="color:#0a4a00;">内网安装包</a><span style="color:#0a4a00;">)或(</span><a href="javascript:lodad2()" style="color:#0a4a00;">外网安装包</a><span style="color:#0a4a00;">)</span><br />
        <!-- 
          <a href="	<%=request.getContextPath()%>/epp/eppTemplate/help/help.zip">帮助中心</a>
          <a href="http://172.18.103.131:800/creatorapp/version/MobileOA1.1.apk">手机客户端下载</a>
          -->
          </td>
      </tr>
      <tr>
        <td height="38" colspan="2">&nbsp;</td>
      </tr>
      <tr>
        <td height="30" colspan="2" style="color:#002b97; font-size:14px; padding-left:385px;">版权所有：湖北省特检院办公自动化系统</td>
        </tr>
		<tr>
       		<table style=" width: 100%;" align="center">
				<tr>
				  <td width="43%"><div align="center"><span style="color: white;background-color:#002c9b;">安卓版二维码扫描处</span></div></td>
				  <td width="14%"><div align="center" class="STYLE7">
				   	    </div>
				   </td>
				   <td width="43%" height="15"><div align="center"><span style="color: white;background-color:#084800;">苹果版二维码扫描处</span></div></td>
				</tr>
				  <tr>
				    <td><div align="center"><img src="<%=request.getContextPath()%>/ccapp/oa/common/resources/images/apk.jpg" width="100" height="100"></div></td>
				    <td><div align="center" class="STYLE7">
				      <div align="center"><span style="width:100%; color: #51a3b9">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></div>
				    </div>	      
				      <div align="center"><span class="STYLE7">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span> </div>
			        <div align="center"></div></td>
				    <td><div align="center"><span class="STYLE7"><img src="<%=request.getContextPath()%>/ccapp/oa/common/resources/images/pingguo.jpg" width="100" height="100"></span></div></td>
				  </tr>
			</table>
        </tr>
    </table></td>
  </tr>
</table>

</form>
<form id="onlyFrom" name="onlyFrom" method="post" action="<%=path%>/ccapp/xtbg/suxian/electroniccheck/jsp/addloadworktimedo.jsp" target="filebaselisthiddenFrame">
<input type="hidden" id="workUser_name" name="workUser_name" />
</form>
<iframe name="filebaselisthiddenFrame" width=0 height=0></iframe>

<form id="only2From" name="only2From" method="post" action="<%=path%>/ccapp/xtbg/suxian/electroniccheck/jsp/addloadendtimedo.jsp" target="filebaselisthiddenFrame2">
<input type="hidden" id="endUser_name" name="endUser_name" />
</form>
<iframe name="filebaselisthiddenFrame2" width=0 height=0></iframe>
</body>

<script type="text/javascript">
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

/*
函数:  addStarttime
说明:  添加考勤上班信息
参数:   无
返回值: 无
*/
var addStarttime = function(isSwitch) {
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
	loginCheck(isSwitch);
}

/*
函数:  addEndtime
说明:  添加考勤下班信息
参数:   无
返回值: 无
*/
var addEndtime = function(isSwitch) {
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
	loginCheck(isSwitch);
}

function loginCheck(isSwitch){
	var url="<%=path%>/loginCheck.jsp";
	var userName = $('#userName').val();
	var password = $('#password').val();
	var params =  {userName:userName,password:password};
	jQuery.ajax({
		url: url,
		type: 'POST',
		dataType:'json',
		data: params,
		async:false,
		success: function(data){
			if(data.success==true){
				if(isSwitch=="1"){
					$("#workUser_name").val(userName);
					$("#onlyFrom").submit();
				}
				if(isSwitch=="2"){
					$("#endUser_name").val(userName);
					$("#only2From").submit();
				}
				
			} else {
				 alert("登录失败，请确保输入的用户名和口令是否正确！");
			}
		},
		error: function(jqXHR, textStatus, errorThrown){
			
		}
	})
} 


</script>
</html>

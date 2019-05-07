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
<%@include file="../../../../../epp/eppTemplate/login_control.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%

String path = request.getContextPath(); 
String userArea=CacheCommonManage.getInstance().getSystemParam("CURSYSTEMCODE"); //区域编码
%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>湖北省特检院办公自动化系统</title>
<script src="../../../resources/js/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../../../resources/plug/jquery1.6/jquery-1.6.min.js"></script>
<script type="text/javascript"src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js"></script>
<script type="text/javascript"src="../../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript"src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<link href="../../../resources/plug/ifrom/css/ifrom-ui-core.css" rel="stylesheet" type="text/css" >
<link href="../resources/css/css2.css" rel="stylesheet" type="text/css" />
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
			saveName();
		}
	}
});



	$(function(){
		debugger;
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
 
<body onload="savepass();" style="background:#fffced;">
<form name="loginForm" action="login_body.jsp" method="post">
<input type="hidden" name="app_id" value="">
<table width="1024" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td background="../resources/images/jiaoyu_denglu.jpg"><table width="1024" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td height="225" colspan="2">&nbsp;</td>
        </tr>
      <tr>
        <td width="390" rowspan="5">&nbsp;</td>
        <td width="629" height="50"><input name="userName" id="userName" type="text" class="xin_denglu_k11" value="" onChange="showpass();"/></td>
      </tr>
      <tr>
        <td height="50"><input name="password" id="password" type="password" class="xin_denglu_k21" value="" /></td>
      </tr>
      <tr>
        <td height="40"><input style="vertical-align:middle;" name="savepass" type="checkbox" value="" /> <span class="fontfff12">记住密码</span></td>
      </tr>
      <tr>
        <td height="50"><input name="" type="button" value="" class="xin_denglu_k2" onmouseover="this.style.backgroundImage='url(../resources/images/xin_denglu_k21.gif)'" onmouseout="this.style.backgroundImage='url(../resources/images/xin_denglu_k2.gif)'" onclick="saveName()"/></td>
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
</body>
<script type="text/javascript">
function savepass(){
	if("<%=CA_LOGIN_SERVER%>"=="false"){
		var form = document.loginForm;
		form.savepass.checked = readcookie("savepass");
		/*
		if(form.userName.value == readcookie("userck")){
			form.password.value = readcookie("passck");
		}*/
		// modified by yaohui.luo	2008-8-16
		if(form.savepass.checked){
			form.userName.value = readcookie("userck");
			form.password.value = readcookie("passck");	
		}
		
		if($("#password").val() == null || $("#password").val() == ''){
			//$("#password").removeClass();
			$("#password").addClass("input_password_over");
		}
		if($("#userName").val() == null || $("#userName").val() == ''){
			//$("#userName").removeClass();
			$("#userName").addClass("input_login_over");
		}
	}
}

function showpass(){
	var form = document.loginForm;
	if(form.userName.value == readcookie("userck")){
		form.password.value = readcookie("passck");
	}
}
	</script>
</html>

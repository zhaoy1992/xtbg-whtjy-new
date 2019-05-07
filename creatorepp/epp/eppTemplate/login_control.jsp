<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@page
	import="com.chinacreator.security.AccessControl,com.chinacreator.security.authorization.AccessException,com.chinacreator.config.ConfigManager,com.chinacreator.epp.applymanager.dbmanager.ApplyManager,java.util.List,java.util.ArrayList,com.chinacreator.epp.applymanager.vo.Apply"%>
<%@page import="com.chinacreator.ca.CaProperties"%>
<%@page import="com.chinacreator.ca.CAManager"%>
<%@page import="com.chinacreator.ca.CookieProperties"%>
<%@page import="com.chinacreator.sysmgrcore.entity.User"%>
<%@page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>

<%
	String contextPath = request.getContextPath();
	String flag = request.getParameter("flag"); //是否触发提交
	//登陆名称的长度
	String userNamelength = ConfigManager.getInstance().getConfigValue(
			"userNameLength");
	//密码是否有效，0无效，1有效
	String pwdValid = "1";
	//是否使用数字认证中心服务
	boolean CA_LOGIN_SERVER = CaProperties.CA_LOGIN_SERVER;
	boolean isCert = true;
	String certUserName = null;
	String certUserPassword = null;
	Integer isValid = null; //记录用户状态
	boolean isStop = false; //记录用户是否停用
	if (CA_LOGIN_SERVER) {
		isCert = CAManager.checkCertSn(request);
		if (isCert) {
			certUserName = CAManager.getUserName(request);
			certUserPassword = CAManager.getUserPassword(request);
		}
	}

	String subsystem = request.getParameter("subsystem_id") != null
			? request.getParameter("subsystem_id")
			: "";

	String isLogin = "false";
	String savepass = request.getParameter("savepass") != null
			? request.getParameter("savepass")
			: "";
	String userName = null;
	String password = null;
	if (flag == null) {

	} else {

		userName = request.getParameter("userName");
		password = request.getParameter("password");

		userName = userName.replace("'", "‘");

	

			String errorMessage = null;
			if (userName != null) {
				try {
					AccessControl.getInstance().login(request,
							response, userName, password);
					if (!isCert) {
						CAManager.updateUserCERT_SN(request, userName);
					}
					if (CA_LOGIN_SERVER)
						request.getSession().setAttribute(
								CookieProperties.CERT_SN,
								CAManager.getCookieValue(request,
										CookieProperties.CERT_SN));

					if (subsystem.trim().equals("")) {
						subsystem = "module";
					}
					isLogin = "true";
					%>
					<script language="javascript">
					setCookie("errotimes","0");
					function setCookie(c_name,times)
					{
						document.cookie=c_name+ "=" +times
					}
					
					</script>
					<%
					//System.out.print("adsfasdffffffffffffffffff");
				} catch (AccessException ex) {
					errorMessage = ex.getMessage();
					System.out.print(errorMessage);

					//2010-8-25修改 by peng.cao 登录失败时，根据用户是否停用显示不同登录失败的提示信息
					//isvalid的值为:0：删除，1：申请，2：开通，3：停用
					//isValid = AccessControl.getInstance().getIsValid(userName);
					User user = SecurityDatabase.getUserManager().getUserByName(userName);
					if (user != null)
						isValid = user.getUserIsvalid();
					if (isValid != null)
						isStop = isValid.intValue() == 3 ? true : false;
					if (isStop) {
%>
<script language="javascript">
	                <!--	                	
	                   alert("对不起，您的帐号已经停用。");
	                    window.top.location="<%=contextPath%>/login.jsp";	                    
	                -->
	    </script>
<%
	} else {
%>
<script language="javascript">

	                   alert("登陆失败，请确保输入的用户名和口令是否正确。");
	                   window.top.location="<%=contextPath%>/login.jsp";
	                    
</script>
<%
	}

				} catch (Exception ex) {
					errorMessage = ex.getMessage();
					System.out.print(errorMessage);
%>
<script language="javascript">
	                <!--	
	                    alert("<%=errorMessage%>");
	                    window.top.location="<%=contextPath%>/login.jsp";					
	                //-->
	     </script>
<%
	}
			}
		}
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<!-- 引入jQuery -->

<!-- dwr begin-->
<script language="javascript" type="text/javascript"
	src='<%=request.getContextPath()%>/dwr/engine.js'> </script>
<script language="javascript" type="text/javascript"
	src='<%=request.getContextPath()%>/dwr/util.js'> </script>
<script language="javascript" type="text/javascript"
	src='<%=request.getContextPath()%>/dwr/interface/applyChange.js'></script>
<!-- dwr end -->
<script type="text/javascript">
	$(function(){
		//alert(111);
		var pwdValid="<%=pwdValid%>";
		if("0"==pwdValid){
			parent.frames[0].editpassword();
		}
	})
	var savepass = "false";

	//判断是否正确登录
	if("true"=="<%=isLogin%>"){	
	
		//记住密码
		if("true" == "<%=savepass%>"){
			var Then = new Date()
			Then.setTime(Then.getTime() + 90*24*60*60*1000 ) //保存有效期三个月
			var userck = "userck=<%=userName%>";
			var passck = "passck=<%=password%>";			
			document.cookie= userck + ";expires="+ Then.toGMTString();  // 将保存到客户机中					
			document.cookie= passck + ";expires="+ Then.toGMTString();  // 将保存到客户机中
			document.cookie= "savepass=true" + ";expires="+ Then.toGMTString();  // 将保存到客户机中					
		}else{
			if(readcookie("userck") == "<%=userName%>"){
				document.cookie= "userck=" + ";expires=0";  // 将保存到客户机中					
				document.cookie= "passck=" + ";expires=0";  // 将保存到客户机中
				document.cookie= "savepass=" + ";expires=0";  // 将保存到客户机中							
			}
		}
		//特检院OA   登录界面    2014-01-08
		window.top.location="<%=contextPath%>/oaindex.jsp?subsystem_id=<%=subsystem%>";		
	}
		
	//回调函数，提交表单并跳转应用相应登录页面
	function saveNameCallback(obj){
		if($('#vcode').is(':visible')&&$("#vcode").val().toLowerCase()!=$("#showvcode").val().toLowerCase()){
			alert("验证码不正确");
			return false;
		}
		//隐含form对象
		var myform = document.login_control_form;
		//login_body.jsp页面form对象
		var form = document.forms[1];
		//用户名
		var username = form.elements[1].value;
		//密码
		var password = form.elements[2].value;

		//记住密码
		/* alert(form.elements[3].name) */
		var savepass = form.elements[3].checked;
	
		if(savepass){
			var Then = new Date()
			Then.setTime(Then.getTime() + 90*24*60*60*1000 ) //保存有效期三个月
			var userck = "userck="+username;
			var passck = "passck="+password;			
			document.cookie= userck + ";expires="+ Then.toGMTString();  // 将保存到客户机中					
			document.cookie= passck + ";expires="+ Then.toGMTString();  // 将保存到客户机中
			document.cookie= "savepass=true" + ";expires="+ Then.toGMTString();  // 将保存到客户机中
		}else{
			if(readcookie("userck") == username){
				document.cookie= "userck=" + ";expires=0";  // 将保存到客户机中					
				document.cookie= "passck=" + ";expires=0";  // 将保存到客户机中
				document.cookie= "savepass=" + ";expires=0";  // 将保存到客户机中							
			}
		}
		// 非空则保存
		if (trim(username).length == 0)   
		{	
			alert("请输入用户名");					
		}else
		if(trim(password).length == 0){
			alert("请输入密码");	
		}
		else{
		
			if(typeof(form.elements[3]) != "undefined"){
				if(form.elements[3].checked){
					myform.savepass.value = "true";
				}
			}
							
			//用户名			
			myform.userName.value = username;
			//密码
			myform.password.value = password;		
			//应用ID
			myform.subsystem_id.value = getApp_id();
			//提交路径			
			obj = "/epp/eppTemplate/login_control.jsp"
			myform.action = "<%=contextPath%>"+obj;
			myform.submit();
			
		}		
	}
	
	//通过调用后台java类，按不同应用显示不同登录页面
	function saveName(){

			applyChange.getLoginIndex(getApp_id(),saveNameCallback);

	}
	
	//检测版本
	function checkVersion(falg){  
	  //var msg = "系统检测到您目前使用的不是IE浏览器，可能会影响系统某些功能的使用";  
	  var ver = getInternetExplorerVersion();  
	  
	  if ( ver > -1 )  
	  {  
	    if ( ver < 7.0 )
	    {   
	      msg = "系统检测到您目前使用的浏览器版本过低，可能会影响系统某些功能的使用，建议对浏览器进行升级,你确定下载IE8吗?";
		  if(confirm(msg)) {
			  window.location.href="<%=contextPath%>/epp/eppTemplate/plugins/IE8-WindowsXP-x86-CHS.exe";
		  }
		  falg = false;
	    }  
	  }
	  return falg;
	} 
	
	function getApp_id(){
		//login_body.jsp页面form对象
		//var form = document.forms[1];
		//login_top.jsp页面对象		
		//var frame = self.parent.frames[0];	
		//body页面应用ID
		//var app_id = form.elements[0].value;
		//如果应用ID为空
		//if(trim(app_id).length == 0){
			//如果加载了top页面，则取top页入口值
			//if(typeof(frame) != "undefined"){							
				//app_id = frame.loginForm.subsystem_id.value;
			//}else{
				app_id = "module";
			//}
		//}
		return app_id;
	}
	
	//去除字符串空格
			function trim(string){
				var temp="";
				string = ''+string;
				splitstring = string.split(" ");
				for(i=0;i<splitstring.length;i++){
					temp += splitstring[i];
				} 
				return temp;
			}
			
	//根据name从cookie中取出值
	function readcookie(name) 
	{ 
	  var mycookie = document.cookie;	
	  var start1 = mycookie.indexOf(name + "="); 
	  if (start1!= -1) 
	  { 
		  start=mycookie.indexOf("=",start1)+1;
		  var end = mycookie.indexOf(";",start);
		  if (end==-1) 
		  { 
			  end=mycookie.length;
		  } 
		  var value=unescape(mycookie.substring(start,end)); 
		  if (value!=null)
		  	return value; 
		  else return "";
	  }
	  else return ""; 
	 }	
</script>
</head>
<div style="display: none;">
	<form name="login_control_form" method="post">
		<input type="hidden" name="userName"> <input type="hidden"
			name="password"> <input type="hidden" name="flag" value="yes">
		<input type="hidden" name="subsystem_id"> <input type="hidden"
			name="savepass">
	</form>
</div>
</html>

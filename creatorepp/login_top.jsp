<%@ page language="java" contentType="text/html; charset=gb2312"%>
<%@page import="com.chinacreator.security.AccessControl,com.chinacreator.security.authorization.AccessException,com.chinacreator.config.ConfigManager,com.chinacreator.epp.applymanager.dbmanager.ApplyManager,java.util.List,java.util.ArrayList,com.chinacreator.epp.applymanager.vo.Apply"%>
<%
	String contextPath = request.getContextPath();

	String subsystem = request.getParameter("subsystem_id") != null ? request
			.getParameter("subsystem_id")
			: "";

	//获取激活状态的应用列表
	ApplyManager applyManager = new ApplyManager();
	List applyList = applyManager.getEnableApplyList(true);
	if (applyList == null) {
		applyList = new ArrayList();
	}
	//获取已选中的系统
	String applySelected = request.getParameter("subsystem_id");
	if (applySelected == null) {
		applySelected = "module";
	}
%>
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

		<!-- dwr begin-->
		<script language="javascript" type="text/javascript" src='<%=request.getContextPath()%>/dwr/engine.js'> </script>
		<script language="javascript" type="text/javascript" src='<%=request.getContextPath()%>/dwr/util.js'> </script>
		<script language="javascript" type="text/javascript" src='<%=request.getContextPath()%>/dwr/interface/applyChange.js'></script>
		<!-- dwr end -->

		<script language="JavaScript">
	var subsystem = "<%=subsystem%>";
	
	//页面加载时，判断是否有应用ID，如果没有，从cookie中读出信息	
	function getName(){			
		if(subsystem!=""){
			showLogin();
			return;
		}else{							
			loginForm.subsystem_id.value = readcookie("subsystem_id")!=""?readcookie("subsystem_id"):"module";
			showLogin();
		}			
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
	
	//设置默认入口
	function saveid(){
		var v=loginForm.subsystem_id.value;		
		if (v!="")   // 非空则保存
		{
			var Then = new Date() 
			Then.setTime(Then.getTime() + 90*24*60*60*1000 ) //保存有效期三个月
			v="subsystem_id="+v;			
			document.cookie=v + ";expires="+ Then.toGMTString();  // 将保存到客户机中					
			alert('设置成功');	
		}
	}	
	
	//通过调用后台java类，按不同应用显示不同登录页面
	function showLogin(){		
		applyChange.getLoginIndex(loginForm.subsystem_id.value,showLoginCallback);
	}
	//回调函数，跳转应用相应登录页面
	function showLoginCallback(obj){
		var frame = self.parent.frames["body"];							
		frame.location.href="<%=contextPath%>"+obj;
	}
	//密码修改
	function editpassword(){
		openWin('<%=contextPath%>/editpassword.jsp',screen.availWidth-320,screen.availHeight-200);
	}
	
	//插件安装
	function download_plugins(){
		openWin('<%=contextPath%>/plugins.jsp',screen.availWidth-320,screen.availHeight-200);
	}
</script>
	</head>

	<%@ include file="/epp/css/cssControl.jsp"%>
	<body onload="getName()">
		<form name="loginForm" action="login.jsp" method="post">
			<div style="background:url(<%=contextPath%>/epp/eppTemplate/images/logon_01.gif) repeat-x; height:32px">
				<table width="40%" border="0" align="left" cellpadding="0" cellspacing="0" style="text-align:center">
					<tr>
						<td>
							<img src="<%=contextPath%>/epp/eppTemplate/images/logon_01.gif" width="8" height="32" />
						</td>
						<td>
							<img src="<%=contextPath%>/epp/eppTemplate/images/logon_06.gif" width="21" height="32" />
						</td>
						<td style="color:#000">
							入口：
						</td>
						<td>
							<select name="subsystem_id" class="cms_select" onchange="showLogin();">
								<option value="module">
									平台管理
								</option>
								<%
										for (int i = 0; i < applyList.size(); i++) {
										Apply apply = (Apply) applyList.get(i);
										if (apply != null) {
											String app_id = apply.getApp_id();
											if("module".equals(app_id.trim())){
												continue;
											}
											String app_name = apply.getApp_name();
											if (applySelected.equals(app_id)) {
								%>
								<option value="<%=app_id%>" selected>
									<%=app_name%>
								</option>
								<%
								} else {
								%>
								<option value="<%=app_id%>">
									<%=app_name%>
								</option>
								<%
										}
										}
									}
								%>
							</select>

						</td>
						<td>
							<img src="<%=contextPath%>/epp/eppTemplate/images/logon_04.gif" width="4" height="32" />
						</td>
						<td>
							<img src="<%=contextPath%>/epp/eppTemplate/images/logon_08.gif" width="90" height="32" border="0" style="cursor: hand;" onmousemove="this.style.position='relative'; this.style.top='1px';" onmouseout="this.style.top='0px';" onclick="saveid();" />
						</td>
					</tr>
				</table>
				<div style="float:right; width:300px">
					<img src="<%=contextPath%>/epp/eppTemplate/images/logon_07.gif" width="94" height="32" border="0" style="cursor: hand;" onmousemove="this.style.position='relative'; this.style.top='1px';" onmouseout="this.style.top='0px';" onclick="editpassword();" />
					<img src="<%=contextPath%>/epp/eppTemplate/images/logon_02.gif" width="94" height="32" border="0" style="cursor: hand;" onmousemove="this.style.position='relative'; this.style.top='1px';" onmouseout="this.style.top='0px';" onclick="download_plugins();" />
					<img src="<%=contextPath%>/epp/eppTemplate/images/logon_10.gif" width="52" height="32" border="0" style="cursor: hand;" onmousemove="this.style.position='relative'; this.style.top='1px';" onmouseout="this.style.top='0px';" />
				</div>
			</div>
		</form>
	</body>
</html>
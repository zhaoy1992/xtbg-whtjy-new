<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@page import="com.chinacreator.message.util.MessageAppDao"%>
<%@page import="com.chinacreator.message.util.MsgConfig"%>
<%@page import="com.chinacreator.config.ConfigManager"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ taglib uri="/WEB-INF/treetag.tld" prefix="tree"%>
<%@ page import="com.chinacreator.message.util.MessageTools
				,com.chinacreator.resource.ResourceManager
				,com.chinacreator.config.model.ResourceInfo
				,java.util.List
				,java.util.Iterator
				,com.chinacreator.security.AccessControl
				,com.chinacreator.epp.applymanager.dbmanager.ApplyManager
				,com.chinacreator.message.factory.MessageDaoFactory
				"%>
<%
	//测试
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	//用户信息（用户真实名称：用户帐号[用户ID]）
	String userInfo =  accesscontroler.getUserAttribute("userAccount")+":"+accesscontroler.getUserAttribute("userName")+"["+accesscontroler.getUserAttribute("userID")+"]  ";
	//操作的ip地址
	String remoteAddr = request.getRemoteAddr();

	//应用ID
	String app_id = request.getParameter("app_id") != null ? request
			.getParameter("app_id") : "";
	//是否修改状态	 "true"	可修改
	String isEdit = request.getParameter("isEdit") != null ? request
			.getParameter("isEdit") : "";
	//取消状态，是否取消时注销应用 "true" 可注销
	String isCancel = request.getParameter("isCancel") != null ? request
			.getParameter("isCancel")
			: "";
	//	判断消息组件是否启用
	boolean isUseMmessage = ConfigManager.getInstance().getConfigBooleanValue("usemessage");
	
			
	//boolean isSms = MessageTools.MessageisExistFromXML("sms");
	//	判断邮件是否启用		
	//boolean isSys = MessageTools.MessageisExistFromXML("sys");
	//	判断rtx是否启用		
	//boolean isRtx = MessageTools.MessageisExistFromXML("rtx");
%>
<head>
	<title>高级</title>
	<style type="text/css">
<!--
.style1 {color: #CC0000}
-->
</style>
	<link href="../../css/windows.css" rel="stylesheet" type="text/css">
	<link href="../../css/tab.winclassic.css" rel="stylesheet"
		type="text/css">
	<link href="../../css/contentpage.css" rel="stylesheet" type="text/css">
	<link href="sysmanager/css/windows.css" rel="stylesheet"
		type="text/css">
	<link href="sysmanager/css/tab.winclassic.css" rel="stylesheet"
		type="text/css">
	<link href="sysmanager/css/contentpage.css" rel="stylesheet"
		type="text/css">
	<base target="_self">
	<script language="JavaScript"
		src="<%=request.getContextPath()%>/purviewmanager/scripts/func.js"
		type="text/javascript"></script>

	<!-- dwr begin-->
	<script language="javascript" type="text/javascript"
		src='<%=request.getContextPath()%>/dwr/engine.js'> </script>
	<script language="javascript" type="text/javascript"
		src='<%=request.getContextPath()%>/dwr/util.js'> </script>
	<script language="javascript" type="text/javascript"
		src='<%=request.getContextPath()%>/dwr/interface/applyChange.js'></script>
	<!-- dwr end -->

	<!-- 提交后页面变灰 -->
	<script language="javascript" type="text/javascript"
		src="../pageGrey.js" />

</head>
<html>

	<SCRIPT language="JavaScript" SRC="sysmanager/scripts/validateForm.js"></SCRIPT>
	<SCRIPT LANGUAGE="JavaScript"> 
	//应用ID
	var app_id = "<%=app_id%>";
	//是否修改状态		
	var isEdit = "<%=isEdit%>";	
	//取消状态，是否取消时删除应用
	var isCancel = "<%=isCancel%>";
	
	//如果是修改状态,给页面赋值
	if(isEdit=="true"){
		fillDate();
	}
	
	//调用后台JAVA类,通过应用ID得到应用参数
	function fillDate(){
		applyChange.getApply(app_id,showDate);
	}
	
	//回调函数,通过返回参数给页面赋值
	function showDate(objs){
		if(objs!=null){
			var form = document.forms[0];							
				form.applybackground.value = objs[9];
				form.applyLogo.value = objs[10];
				form.applycsstype.value = objs[14];
			
				if("<%=isUseMmessage%>"=="true"){
				 	var mes = document.getElementsByName("mes");				 	
					mes[0].checked = (objs[12]==0)?false:true;
				}
			/*var sms = document.getElementsByName("sms");
				if(objs[11].length>0){
					sms[0].checked = objs[11].charAt(0)=="1"?true:false;
				}
			var sys = document.getElementsByName("sys");
				if(objs[11].length>1){
					sys[0].checked = objs[11].charAt(1)=="1"?true:false;
				}
			var rtx = document.getElementsByName("rtx");
				if(objs[11].length>2){
					rtx[0].checked = objs[11].charAt(2)=="1"?true:false;
				}*/
				
			if(objs[13]!=null){
				var restemp = objs[13].split("<%=AccessControl.ESPECIAL_SEPARATOR%>");				
				var rescheck = false;
				for(i=0;i<restemp.length;i++){
					if("biztype"==restemp[i]){
						rescheck = true;
					}
				}
				var biztype = document.getElementById("biztype");
				if(null!=biztype)
				biztype.checked = rescheck;
			}		
		}
	}
	
	
		////调用后台JAVA类,保存数据
		function appmanagerset1(isSave)
		{
			var form = document.forms[0];
			var applyLogo = form.applyLogo.value;
			var applybackground = form.applybackground.value;
			var applycsstype = form.applycsstype.value;
			var msgTypes =  document.getElementsByName("msgType");
			var messlist="";
			var mes="";
			var isshow =0;
			<% if(isUseMmessage){%>
			for(i =0 ;i<msgTypes.length;i++){
				messlist+=msgTypes[i].checked?(msgTypes[i].id+","):"";
			}
			messlist = messlist.substring(0,messlist.length-1);
			mes = document.getElementsByName("mes");
		   	/*var sms = document.getElementsByName("sms");				
			var sys = document.getElementsByName("sys");				
			var rtx = document.getElementsByName("rtx");
			var mes = document.getElementsByName("mes");*/
		   //	var messlist =	(sms[0].checked?"1":"0") + (sys[0].checked?"1":"0") + (rtx[0].checked?"1":"0");
		   	 isshow = mes[0].checked?"1":"0";
		   	<%}%>
		   	var resArr = form.resid;
		   	var resids = "";
		   	for(var i=0; i<resArr.length; i++) {
		   		if (resArr[i].checked)	resids += resArr[i].value + "<%=AccessControl.ESPECIAL_SEPARATOR%>";
		   	}
		   	
		   	if (resids) {
		   		resids = resids.substring(0, resids.length-1);
		   	}

			//提交后页面变灰
			popSignFlow(1);			
			applyChange.addApplyLogo(applyLogo,applybackground,applycsstype,messlist,isshow,resids,app_id,isSave,"<%=userInfo%>","<%=remoteAddr%>",appmanagerset2);
		}
		
		function appmanagerset2()
		{
			//页面变灰恢复正常
			cancelSign();
			
			if(isEdit=="true"){
				alert("修改成功！");
			}else if(isEdit=="creat"){				
				alert("应用注册成功！");
				document.location.assign("<%=request.getContextPath()%>/eppissue/appupdate/appupdatedeploy.jsp");
				return;
			}else{				
				alert("应用注册成功！");
			}
			
			winClose();
		}
		
		//上一步
		function backApply()
		{
			document.location.assign("addapplytab4.jsp?app_id="+app_id+"&&isCancel="+isCancel+'&&isEdit='+isEdit);
		}
		
		//弹出消息对话框，通过应用ID调用后台JAVA类注销应用
		function logoutApply()
		{	
			if(confirm("确认取消吗?\r取消同时将注销该应用!")){
				var app_id_arr = new Array;
				app_id_arr[0] = app_id;
				applyChange.updateApplyStatus(app_id_arr,0,"<%=userInfo%>","<%=remoteAddr%>",winClose);			
			}
		}
		
		//关闭模态窗口并刷新父页面
		function winClose(){
				window.close();
				window.returnValue="refresh";
		}
		
		//判断取消状态是否需要注销应用
		function cancel(){
			if(isCancel=="true"){
				logoutApply();
			}else{
				winClose();
			}				
		}
		
		//按下关闭按钮时刷新父窗口
		function window.onbeforeunload()
		{
		    if(event.clientX>360&&event.clientY<0||event.altKey)
		    {
		       if(isCancel=="true"&&app_id!=""){
					logoutApply();
				}else{
					winClose();
				}
		    }
		}
		
		//上传图片
		function logoUpLoad(){
			openWin('<%=request.getContextPath()%>/sysmanager/applymanager/applywork/applylogoupload.jsp?app_id=<%=app_id%>',screen.availWidth-320,screen.availHeight-200);
		}
		
		//选择图片
		function selectLogo(obj){
			var type = obj.id;			
			var ww = openWin('<%=request.getContextPath()%>/sysmanager/applymanager/applywork/showmain.jsp?app_id=<%=app_id%>&&app_type='+type,screen.availWidth-320,screen.availHeight-200);
			if(ww){
				obj.value = ww;
			}
		}
		
		//选择样式
		function selectCssType(obj){
			var ww = openWin('<%=request.getContextPath()%>/sysmanager/applymanager/applywork/showcss.jsp?app_id=<%=app_id%>&&css='+obj.value,screen.availWidth-320,screen.availHeight-200);
			if(ww){
				obj.value = ww;
			}
		}
		
		//预览
		function preview(){
			var form = document.forms[0];							
			var applybackground = form.applybackground.value;
			var applylogo =	form.applyLogo.value;
			var url = "<%=request.getContextPath()%>/sysmanager/applymanager/applywork/preview.jsp?applybackground="+applybackground+"&&applylogo="+applylogo;
			window.open(url,"_blank");
		}
		
</SCRIPT>
	<%@ include file="/epp/css/cssControl.jsp"%><body class="contentbodymargin" scroll="yes">
		<div align="center">
			<br />
			<form action="" method="post">
				<input type="hidden" name="app_id" value="<%=app_id%>">
				<pg:beaninfo requestKey="Apply">

					<fieldset style="width: 90%;">
						<LEGEND align=center>
							<FONT size="2">样式定义</FONT>
						</LEGEND>
						<br />
						<table width="85%" height="35" border="0" align="center"
							cellpadding="0" cellspacing="1" class="thin">
							<tr>
								<td width="20%" height="35" class="detailtitle">
									应用Logo
								</td>
								<td nowrap="NOWRAP" class="detailcontent">
									<input name="applyLogo" id="applyLogo" type="text" size="40"
										maxlength="100" readonly />
									<input class="input" type="button" value="选择..."
										onclick="selectLogo(applyLogo);" />
									<input type="button" class="input" value="清除"
										onclick='applyLogo.value="";' />
									&nbsp;&nbsp;&nbsp;&nbsp;
									<span id="applyLogo_message" class="style1" />
								</td>
							</tr>
							<tr>
								<td height="35" class="detailtitle">
									表头背景
								</td>
								<td class="detailcontent">
									<input name="applybackground" id="applybackground" type="text"
										size="40" maxlength="100" readonly />
									<input class="input" type="button" value="选择..."
										onclick="selectLogo(applybackground);" />
									<input type="button" class="input" value="清除"
										onclick='applybackground.value="";' />
								</td>
							</tr>
							<tr>
								<td height="35" class="detailtitle">
									样式选择
								</td>
								<td class="detailcontent">
									<input name="applycsstype" id="applycsstype" type="text"
										size="40" maxlength="100" value="default" readonly />
									<input class="input" type="button" value="选择..."
										onclick="selectCssType(applycsstype);" />
									<input type="button" class="input" value="清除"
										onclick='applycsstype.value="default";' />
								</td>
							</tr>
						</table>						
						<input class="input" type="button" value="上传图片..."
							onclick="logoUpLoad()" />
						<input class="input" type="button" value="预览..."
							onclick="preview()" />
						<br />
					</fieldset>
					<br />
					<br />
					<%
						
						if(isUseMmessage){
					 %>
					<fieldset style="width: 90%;">
						<LEGEND align=center>
							<FONT size="2">消息管理配置</FONT>
						</LEGEND>
						<br />
						<table width="85%" height="35" border="0" align="center"
							cellpadding="0" cellspacing="1">
							<tr>
								<td width="30%" height="25" class="detailtitle">
								
								</td>
								<td height="25" class="detailtitle" align="left">
								<%
									boolean hasSame = false;
									String functionList = MessageAppDao.getInstance().getFunctionList(app_id);
									String[] functionArr = functionList.split(MsgConfig.getProperties("delim"));
									String [][] dictNoStr =MessageDaoFactory.getMessageDict().getDictNo();
									
									for(int j = 0;j<dictNoStr.length;j++){
										String[] no = dictNoStr[j];
										for(int i = 0;i<functionArr.length;i++){
										hasSame =false;
											if(functionArr[i].equals(no[0])){
												hasSame = true;
												//functionArr[i]="";
												break;
											}
										}
										if(MessageTools.MessageisExistFromXML(no[0])){
									%>
									<input type="checkbox" id =<%=no[0]%> <%if(hasSame){%>checked<%}%> name='msgType' /><%=no[1] %>
									<% 
									}else{
									%>
									<input type="checkbox" id =<%=no[0]%> name ='msgType' disabled="disabled" /><%=no[1] %>
									<% 
										}
									}
									%>
								</td>
							</tr>
							<tr>
								<td width="30%" height="25" class="detailtitle">
								</td>
								<td height="25" class="detailtitle" align="left">
									<input type="checkbox" name="mes" checked />
									显示消息中心
								</td>
							</tr>
						</table>						
					</fieldset>
					<%} %>
					<br />
					<br />
					<fieldset style="width: 90%;">
						<LEGEND align=center>
							<FONT size="2">资源配置</FONT>
						</LEGEND>
						<br />
						<table width="85%" height="35" border="0" align="center"
							cellpadding="0" cellspacing="1">							
							<tr><%
									ApplyManager applyManager = new ApplyManager();
									ResourceManager resManager = new ResourceManager();
									List list = resManager.getResourceInfos();
									int i = 0;
									//for (Object obj : list) {										
									//	ResourceInfo rsi = (ResourceInfo)obj;
									Iterator ite = list.iterator();
									while (ite.hasNext()) {
										ResourceInfo rsi = (ResourceInfo)ite.next();
										if (!rsi.isAuto()) {
											continue;
										}
										i++;
								%>
								<td width="20%" height="35" class="detailtitle" 
									style="white-space:nowrap;text-overflow:ellipsis" 
									align="left" title="<%=rsi.getName() %>">
									<input id="<%=rsi.getId() %>" name="resid" value="<%=rsi.getId() %>" 
									<%if(applyManager.hasResource(rsi.getId(), app_id) || rsi.isDefaultResourceInfo()) { %>
									 checked
									<%} %>
									<%if(rsi.isDefaultResourceInfo()) { %>
									disabled
									<%} %>
									type="checkbox"><%=rsi.getName() %>								
								</td>
								<%
										if(i % 5 == 0) {
											%></tr><tr><%
										}
									}
									for (int j=0; j<5-i%5; j++) {
										%><td></td><%
									}
								%>
							</tr>
						</table>						
					</fieldset>					
					<br />
					<div align="center">
						<table width="35%" border="0" align="right" cellpadding="0"
							cellspacing="0">
							<tr>
								<td>
									<div align="left">
										<%
										if (isEdit.equals("true")) {
										%>
										<input name="Submit" type="button" class="input" value="修改"
											onClick="appmanagerset1('edit')">
										<%
										} else {
										%>
										<input name="back" type="button" class="input" value="上一步"
											onclick="backApply();">
										<input name="Submit" type="button" class="input" value="保存"
											onClick="appmanagerset1('save')">
										<%
										}
										%>
										<input name="rsset" type="button" class="input" value="重置"
											onclick="fillDate();document.location=document.location;">
										<input name="button" type="button" class="input" value="取消"
											onClick="cancel()">
									</div>
								</td>
							</tr>
						</table>
					</div>
				</pg:beaninfo>
			</form>
		</div>
	</body>
</html>

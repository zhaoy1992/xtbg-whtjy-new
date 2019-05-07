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
	//����
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	//�û���Ϣ���û���ʵ���ƣ��û��ʺ�[�û�ID]��
	String userInfo =  accesscontroler.getUserAttribute("userAccount")+":"+accesscontroler.getUserAttribute("userName")+"["+accesscontroler.getUserAttribute("userID")+"]  ";
	//������ip��ַ
	String remoteAddr = request.getRemoteAddr();

	//Ӧ��ID
	String app_id = request.getParameter("app_id") != null ? request
			.getParameter("app_id") : "";
	//�Ƿ��޸�״̬	 "true"	���޸�
	String isEdit = request.getParameter("isEdit") != null ? request
			.getParameter("isEdit") : "";
	//ȡ��״̬���Ƿ�ȡ��ʱע��Ӧ�� "true" ��ע��
	String isCancel = request.getParameter("isCancel") != null ? request
			.getParameter("isCancel")
			: "";
	//	�ж���Ϣ����Ƿ�����
	boolean isUseMmessage = ConfigManager.getInstance().getConfigBooleanValue("usemessage");
	
			
	//boolean isSms = MessageTools.MessageisExistFromXML("sms");
	//	�ж��ʼ��Ƿ�����		
	//boolean isSys = MessageTools.MessageisExistFromXML("sys");
	//	�ж�rtx�Ƿ�����		
	//boolean isRtx = MessageTools.MessageisExistFromXML("rtx");
%>
<head>
	<title>�߼�</title>
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

	<!-- �ύ��ҳ���� -->
	<script language="javascript" type="text/javascript"
		src="../pageGrey.js" />

</head>
<html>

	<SCRIPT language="JavaScript" SRC="sysmanager/scripts/validateForm.js"></SCRIPT>
	<SCRIPT LANGUAGE="JavaScript"> 
	//Ӧ��ID
	var app_id = "<%=app_id%>";
	//�Ƿ��޸�״̬		
	var isEdit = "<%=isEdit%>";	
	//ȡ��״̬���Ƿ�ȡ��ʱɾ��Ӧ��
	var isCancel = "<%=isCancel%>";
	
	//������޸�״̬,��ҳ�渳ֵ
	if(isEdit=="true"){
		fillDate();
	}
	
	//���ú�̨JAVA��,ͨ��Ӧ��ID�õ�Ӧ�ò���
	function fillDate(){
		applyChange.getApply(app_id,showDate);
	}
	
	//�ص�����,ͨ�����ز�����ҳ�渳ֵ
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
	
	
		////���ú�̨JAVA��,��������
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

			//�ύ��ҳ����
			popSignFlow(1);			
			applyChange.addApplyLogo(applyLogo,applybackground,applycsstype,messlist,isshow,resids,app_id,isSave,"<%=userInfo%>","<%=remoteAddr%>",appmanagerset2);
		}
		
		function appmanagerset2()
		{
			//ҳ���һָ�����
			cancelSign();
			
			if(isEdit=="true"){
				alert("�޸ĳɹ���");
			}else if(isEdit=="creat"){				
				alert("Ӧ��ע��ɹ���");
				document.location.assign("<%=request.getContextPath()%>/eppissue/appupdate/appupdatedeploy.jsp");
				return;
			}else{				
				alert("Ӧ��ע��ɹ���");
			}
			
			winClose();
		}
		
		//��һ��
		function backApply()
		{
			document.location.assign("addapplytab4.jsp?app_id="+app_id+"&&isCancel="+isCancel+'&&isEdit='+isEdit);
		}
		
		//������Ϣ�Ի���ͨ��Ӧ��ID���ú�̨JAVA��ע��Ӧ��
		function logoutApply()
		{	
			if(confirm("ȷ��ȡ����?\rȡ��ͬʱ��ע����Ӧ��!")){
				var app_id_arr = new Array;
				app_id_arr[0] = app_id;
				applyChange.updateApplyStatus(app_id_arr,0,"<%=userInfo%>","<%=remoteAddr%>",winClose);			
			}
		}
		
		//�ر�ģ̬���ڲ�ˢ�¸�ҳ��
		function winClose(){
				window.close();
				window.returnValue="refresh";
		}
		
		//�ж�ȡ��״̬�Ƿ���Ҫע��Ӧ��
		function cancel(){
			if(isCancel=="true"){
				logoutApply();
			}else{
				winClose();
			}				
		}
		
		//���¹رհ�ťʱˢ�¸�����
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
		
		//�ϴ�ͼƬ
		function logoUpLoad(){
			openWin('<%=request.getContextPath()%>/sysmanager/applymanager/applywork/applylogoupload.jsp?app_id=<%=app_id%>',screen.availWidth-320,screen.availHeight-200);
		}
		
		//ѡ��ͼƬ
		function selectLogo(obj){
			var type = obj.id;			
			var ww = openWin('<%=request.getContextPath()%>/sysmanager/applymanager/applywork/showmain.jsp?app_id=<%=app_id%>&&app_type='+type,screen.availWidth-320,screen.availHeight-200);
			if(ww){
				obj.value = ww;
			}
		}
		
		//ѡ����ʽ
		function selectCssType(obj){
			var ww = openWin('<%=request.getContextPath()%>/sysmanager/applymanager/applywork/showcss.jsp?app_id=<%=app_id%>&&css='+obj.value,screen.availWidth-320,screen.availHeight-200);
			if(ww){
				obj.value = ww;
			}
		}
		
		//Ԥ��
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
							<FONT size="2">��ʽ����</FONT>
						</LEGEND>
						<br />
						<table width="85%" height="35" border="0" align="center"
							cellpadding="0" cellspacing="1" class="thin">
							<tr>
								<td width="20%" height="35" class="detailtitle">
									Ӧ��Logo
								</td>
								<td nowrap="NOWRAP" class="detailcontent">
									<input name="applyLogo" id="applyLogo" type="text" size="40"
										maxlength="100" readonly />
									<input class="input" type="button" value="ѡ��..."
										onclick="selectLogo(applyLogo);" />
									<input type="button" class="input" value="���"
										onclick='applyLogo.value="";' />
									&nbsp;&nbsp;&nbsp;&nbsp;
									<span id="applyLogo_message" class="style1" />
								</td>
							</tr>
							<tr>
								<td height="35" class="detailtitle">
									��ͷ����
								</td>
								<td class="detailcontent">
									<input name="applybackground" id="applybackground" type="text"
										size="40" maxlength="100" readonly />
									<input class="input" type="button" value="ѡ��..."
										onclick="selectLogo(applybackground);" />
									<input type="button" class="input" value="���"
										onclick='applybackground.value="";' />
								</td>
							</tr>
							<tr>
								<td height="35" class="detailtitle">
									��ʽѡ��
								</td>
								<td class="detailcontent">
									<input name="applycsstype" id="applycsstype" type="text"
										size="40" maxlength="100" value="default" readonly />
									<input class="input" type="button" value="ѡ��..."
										onclick="selectCssType(applycsstype);" />
									<input type="button" class="input" value="���"
										onclick='applycsstype.value="default";' />
								</td>
							</tr>
						</table>						
						<input class="input" type="button" value="�ϴ�ͼƬ..."
							onclick="logoUpLoad()" />
						<input class="input" type="button" value="Ԥ��..."
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
							<FONT size="2">��Ϣ��������</FONT>
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
									��ʾ��Ϣ����
								</td>
							</tr>
						</table>						
					</fieldset>
					<%} %>
					<br />
					<br />
					<fieldset style="width: 90%;">
						<LEGEND align=center>
							<FONT size="2">��Դ����</FONT>
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
										<input name="Submit" type="button" class="input" value="�޸�"
											onClick="appmanagerset1('edit')">
										<%
										} else {
										%>
										<input name="back" type="button" class="input" value="��һ��"
											onclick="backApply();">
										<input name="Submit" type="button" class="input" value="����"
											onClick="appmanagerset1('save')">
										<%
										}
										%>
										<input name="rsset" type="button" class="input" value="����"
											onclick="fillDate();document.location=document.location;">
										<input name="button" type="button" class="input" value="ȡ��"
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

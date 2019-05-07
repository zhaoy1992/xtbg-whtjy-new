
<%
	 /*
	 * <p>Title: �����û�ҳ��</p>
	 * <p>Description: �����û�ҳ��</p>
	 * <p>Copyright: Copyright (c) 2008</p>
	 * <p>Company: chinacreator</p>
	 * @Date 2008-3-20
	 * @author liangbing.tao
	 * @version 1.0
	 */
%>

<%@ page language="java" contentType="text/html; charset=GBK"%>

<%@ page import="com.chinacreator.sysmgrcore.orgmanager.OrgManAction"%>
<%@ page import="com.chinacreator.sysmgrcore.entity.Organization"%>
<%@ page import="com.chinacreator.sysmgrcore.entity.*"%>
<%@ page import="com.chinacreator.sysmgrcore.web.struts.form.*"%>
<%@ page import="com.chinacreator.security.*"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.db.OrgCacheManager"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityConstants"%>
<%@ page
	import="com.chinacreator.sysmgrcoreext.manager.IUserManagerExt"%>
<%@ page import="org.frameworkset.spi.BaseSPIManager"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>
<%@ page import="com.chinacreator.config.ConfigManager"%>
<%@ page import="java.sql.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="com.frameworkset.util.StringUtil"%>
<%@page
	import="com.chinacreator.sysmgrcore.purviewmanager.GenerateServiceFactory,java.util.*"%>
<%@ page import="com.chinacreator.epp.applymanager.dbmanager.ApplyManager"%>
<%@ page import="com.chinacreator.epp.applymanager.vo.Apply"%>
<%@ page import="com.chinacreator.epp.applymanager.dbmanager.OrgUserManager"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ taglib uri="/WEB-INF/dictionary.tld" prefix="dict"%>

<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkManagerAccess(request, response);

	//�û���¼��ʽ true-֧���û�����¼�����û�ʵ��ͬʱ��¼��ʽ false-��֧���û���¼��ʽ
	String userloginmode = ConfigManager.getInstance().getConfigValue(
			"userloginmode");

	boolean isUserRealnameExist = false;

	//�Ƿ����  "�Ƿ�˰��Ա" ��ѡ��
	boolean istaxmanager = ConfigManager.getInstance()
			.getConfigBooleanValue("istaxmanager", false);
	//��ȡ��ǰϵͳ��ʱ�� ����ʽ��
	//baowen.liu
	java.util.Date date = new java.util.Date();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	String datestr = sdf.format(date);

	//�û���¼���ĳ���--order by gao.tang
	String userNamelength = ConfigManager.getInstance().getConfigValue(
			"userNameLength");
	String currOrgId = request.getParameter("orgId");

	if (currOrgId == null) {
		currOrgId = (String) request.getAttribute("orgId");
	}

	Organization org = OrgCacheManager.getInstance().getOrganization(
			currOrgId);


	// ���ͬ��Ӧ�ù���
	// ��ʢ 2011-7-12
	String sel_appid = request.getParameter("sel_appid");
	StringBuffer synappmess = new StringBuffer();
	synappmess.append("ƽ̨��ӳɹ���");
	boolean isSynApp = false;

	//action start
	if ("true".equals(request.getParameter("isNewUser"))) {
		//�½��û���ʼ��action
		request.setAttribute("currUser", null);
		request.setAttribute("reFlush", "false");
		request.getSession().setAttribute("currUserId", null);
		request.setAttribute("isNew", "1");
	}
	String newUserName = "";
	//�Ƿ��Զ������û���
	boolean isAutoUserName = GenerateServiceFactory
			.getGenerateService().enableUserNameGenerate();
	//������Ϣ
	String errorMessage = "";
	if ("true".equals(request.getParameter("storeUser"))) {
		//�����û�
		User user = new User();
		if (isAutoUserName) {
			try {
		Map map = new HashMap();
		map.put("orgId", currOrgId);
		user.setUserName(GenerateServiceFactory
				.getGenerateService().generateUserName(map));
			} catch (Exception e) {
		e.printStackTrace();
			}
		} else {
			user.setUserName(StringUtil.replaceNull(
			request.getParameter("userName")).trim());
		}
		user.setUserPassword(request.getParameter("userPassword"));
		user.setUserRealname(StringUtil.replaceNull(
		request.getParameter("userRealname")).trim());
		try{
		user.setUserSn(new Integer(request.getParameter("userSn")));
		}catch(Exception e){
		user.setUserSn(new Integer(0));		
		}
		user.setUserSex(request.getParameter("userSex"));
		user.setUserIsvalid(new Integer(request
		.getParameter("userIsvalid")));
		user.setUserHometel(request.getParameter("homePhone"));
		user.setUserMobiletel1(request.getParameter("mobile"));
		user.setUserPostalcode(request.getParameter("postalCode"));
		user.setRemark2(request.getParameter("shortMobile"));
		user.setUserEmail(request.getParameter("mail"));
		user.setUserMobiletel2(request.getParameter("userMobiletel2"));
		user.setRemark1(request.getParameter("remark1"));
		user.setRemark3(request.getParameter("remark3"));
		user.setRemark4(request.getParameter("remark4"));
		user.setRemark5(request.getParameter("remark5"));

		user.setUserType(request.getParameter("userType"));
		user.setUserPinyin(request.getParameter("userPinyin"));

		user.setUserWorktel(request.getParameter("userWorktel"));
		user.setUserFax(request.getParameter("userFax"));
		user.setUserOicq(request.getParameter("userOicq"));
		if (!"".equals(request.getParameter("userBirthday")))
			user.setUserBirthday(Date.valueOf(request
			.getParameter("userBirthday")));

		user.setUserAddress(request.getParameter("userAddress"));
		user.setUserLogincount(new Integer(request
		.getParameter("userLogincount")));
		user.setUserIdcard(request.getParameter("userIdcard"));
		if (!"".equals(request.getParameter("userRegdate")))
			user.setUserRegdate(Date.valueOf(request
			.getParameter("userRegdate")));
		if (request.getParameter("istaxmanager") == null) {
			user.setIstaxmanager(0);
		} else {
			user.setIstaxmanager(Integer.valueOf(
			request.getParameter("istaxmanager")).intValue());
		}

		IUserManagerExt userManager = (IUserManagerExt) BaseSPIManager
		.getProvider(SecurityConstants.USER_MANAGEMENT_TYPE);

		// ���������ӣ��ж��û��Ƿ���ڣ�������ת�����ʧ��ҳ��
		// ��ΰ���޸ģ� ��������ʾ�û���½���ظ�������ԭҳ�棬��յ�½��

		boolean isUserExist = false;
		if (userManager.isUserExist(user)) {
			request.setAttribute("isUserExist", "true");
			request.setAttribute("reFlush", "false");

			isUserExist = true;
		}

		//֧�����ĵ�¼
		//��ʢ 2009-5-18		

		//���֧���û�����¼�����û�ʵ��ͬʱ��¼��ʽ����ô�û�ʵ���������ظ�
		if (!isUserExist && "true".equals(userloginmode.trim())) {			
			if (userManager.isUserRealnameExist(user)) {
		request.setAttribute("isUserRealnameExist", "true");
		request.setAttribute("reFlush", "false");

		isUserRealnameExist = true;
			}
		}

		//System.out.println("isUserExist = " + isUserExist);
		if (isUserExist == false && isUserRealnameExist == false)//�û������ڲ������û�
		{
			newUserName = user.getUserName();
			try {
		if (newUserName != null && !"".equals(newUserName)) {
			userManager.creatorUser(user, currOrgId, "1");
			
			// ���ͬ��Ӧ�ù���
			// ��ʢ 2011-7-12
			OrgUserManager orgUserManager = new OrgUserManager();
			isSynApp = orgUserManager.synAppInsertUser(newUserName,currOrgId,sel_appid,synappmess);
		} else {
			if (isAutoUserName) {
				errorMessage = "ϵͳ�Զ����ɵ�½���쳣��";
			} else {
				errorMessage = "��½��Ϊnull��";
			}
		}
			} catch (Exception e) {
		e.printStackTrace();
		errorMessage = e.getMessage();
		if (errorMessage != null && !"".equals(errorMessage)) {
			errorMessage = errorMessage.replaceAll("\\n",
			"\\\\n");
			errorMessage = errorMessage.replaceAll("\\r",
			"\\\\r");
		}
			}
		}
	}

	//action end

	String orgName = org.getRemark5();
	String userSn = String.valueOf(OrgManAction
			.getMaxOrgUserSn(currOrgId));
	String reFlush = "true";
	if (request.getAttribute("reFlush") != null) {
		reFlush = "false";
	}
	String isUserExist = "false";
	if (request.getAttribute("isUserExist") != null) {
		isUserExist = "true";
	}

	UserInfoForm user = (UserInfoForm) request.getAttribute("currUser");
	String userid = "";
	if (user == null) {
		user = new UserInfoForm();
	} else {
		userid = user.getUserId();
	}

	String isNew = (String) request.getAttribute("isNew");
	if (isNew == null) {
		isNew = "0";
	}
	
	// ���ͬ��Ӧ�ù���
	// ��ʢ 2011-7-12		
	// ��ȡ����Ӧ�ö���
	ApplyManager applyManager = new ApplyManager();
	List applyList = null;
	try{
		applyList = applyManager.getApplyList();
	}catch(Exception e){
	}
	boolean isApply = null!=applyList && !applyList.isEmpty();
%>

<html>
	<head>
		<title>�����û�</title>
		<script language="JavaScript" src="../../scripts/calender_date.js"></script>
		<script language="JavaScript" src="../../scripts/common.js"
			type="text/javascript"></script>
		<script language="javascript" src="../../scripts/selectTime.js"></script>
		<SCRIPT language="JavaScript" SRC="../../scripts/validateForm.js"></SCRIPT>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<link rel="stylesheet" type="text/css" href="../../css/windows.css">
		<style type="text/css">
			.notice_STYLE{color: #FF0000;display : none }
			.STYLE1 {color: #FF0000}
        </style>
		<script language="JavaScript">
			var jsAccessControl = new JSAccessControl("#ff0000","#ffffff","#eeeeee");
			var reFlush = "<%=reFlush%>";
			var userErr = 0;
				
			function userInfo(userName){ 
				var winbasic;
				var url="autoUserName.jsp?userName="+userName;
				window.showModalDialog(url,window,"dialogWidth:"+(200)+"px;dialogHeight:"+(150)+"px;scroll=yes;status=no;titlebar=no;toolbar=no;maximize=yes;minimize=0;");
			
			}
			
			var isUserExist = "<%=isUserExist%>";
			var isUserRealnameExist = "<%=isUserRealnameExist%>";
			if ( isUserExist == "true"){
				<%
					if(isAutoUserName){
				%>
					alert("�Զ����ɵ��ʺ��г�ͻ�����ʺ��Ѿ����ڣ������´����û���");
				<%
					}else{
				%>
					alert("�û����Ѵ��ڣ�����������һ�����û���!");
				<%
					}
				%>
				parent.divProcessing.style.display="none";
			   	parent.document.getElementsByName("resave")[0].disabled = false;
			   	parent.document.getElementsByName("Submit31")[0].disabled = false;
			   	parent.document.getElementsByName("Submit32")[0].disabled = false;
			}else{
				if(isUserRealnameExist == "true"){
					alert("��ʵ�����Ѵ��ڣ�����������һ���µ���ʵ���ƣ�");
					parent.divProcessing.style.display="none";
				   	parent.document.getElementsByName("resave")[0].disabled = false;
				   	parent.document.getElementsByName("Submit31")[0].disabled = false;
				   	parent.document.getElementsByName("Submit32")[0].disabled = false;
				}else{
					var flag = <%=request.getParameter("flag")%>
					if(flag=="2"){
					<%
						if(isAutoUserName){
							if(errorMessage != null && !"".equals(errorMessage)){
							%>
								alert("����ʧ��!ԭ�����£�\n<%=errorMessage%>");
							<%			
							}else{
								if(isApply){
					%>
								var newUserName = "<%=newUserName%>";
								alert("�����û��ɹ���");
								userInfo(newUserName);
					<%
								}else{
					%>
								var newUserName = "<%=newUserName%>";
								alert("<%=synappmess%>");
								userInfo(newUserName);
					<%
								}
							}
						}else{
							if(errorMessage != null && !"".equals(errorMessage)){
							%>
								alert("����ʧ��!ԭ�����£�\n<%=errorMessage%>");
							<%			
							}else{
								if(isApply){
					%>
								alert("�����û��ɹ���");
						<%
								}else{
						%>
								alert("<%=synappmess%>");
						<%
								}
							}
						}
					%>
						parent.divProcessing.style.display="none";
					   	parent.document.getElementsByName("resave")[0].disabled = false;
					   	parent.document.getElementsByName("Submit31")[0].disabled = false;
					   	parent.document.getElementsByName("Submit32")[0].disabled = false; 
					} 	
				}
			}
			
			
			function trim(string){
			  var temp="";
			  string = ''+string;
			  splitstring = string.split(" ");
			  for(i=0;i<splitstring.length;i++){
			    temp += splitstring[i];
			  } 
			  return temp;
			 }
			function storeUser()
			{
				
				document.UserInfoForm.userName.disabled = false;
				
				if(document.UserInfoForm.userName.value.search(/^[a-zA-Z]{1}\w*$/)==-1 ){
					alert("��½��ֻ������ĸ��ͷ���������֡���ĸ���»������!");
					document.UserInfoForm.userName.focus();
					return false;
				}								
				if (validateForm(UserInfoForm) )
				{
					var userName= document.forms[0].userName.value;
					if (trim(userName).length == 0 ){
			    		alert("�������½����"); 
			    		return false;
			    	} 
			    	if(document.UserInfoForm.remark3.checked)
			    		document.UserInfoForm.remark3.value="��";
					else 
						document.UserInfoForm.remark3.value="��";
					
					if(document.UserInfoForm.istaxmanager.checked)
						document.UserInfoForm.istaxmanager.value="1";
					else
						document.UserInfoForm.istaxmanager.value="0";
						
					if("true"=="<%=userloginmode%>"){	
						if(document.UserInfoForm.userRealname.value.search(/^[a-zA-Z0-9_\u4e00-\u9fa5]+$/)!=-1){
							if(document.UserInfoForm.userRealname.value.search(/[\u4e00-\u9fa5]{1}/)!=-1){
								if(!confirm("�û��������½������ʵ���ƽ��޷��޸ģ��Ƿ񴴽���")){
									return false;
								}
							}else{
								alert("�û���ʵ���Ʊ����������һ�������ַ���");
								document.UserInfoForm.userRealname.focus();
								return false;
							}
						}else{
							alert("�û���ʵ����ֻ��Ϊ���ġ����֡���ĸ���»���!");
							document.UserInfoForm.userRealname.focus();
							return false;
						}
					}
			   		document.UserInfoForm.sel_appid.value = getSelAppid();
			   		divProcessing.style.display="";
			   		document.getElementsByName("resave")[0].disabled = true;
			   		document.getElementsByName("Submit31")[0].disabled = true;
			   		document.getElementsByName("Submit32")[0].disabled = true;
			   		
			   		document.UserInfoForm.target = "saveuser";
					document.UserInfoForm.action="../user/userInfo.jsp?storeUser=true&flag=2";
					document.UserInfoForm.submit();
					
				}
			}
			
			function back()
			{
				window.close();
				window.returnValue = "ok";
			}
			
			function setDisable(v){
				v.disabled = false;
				if  ( document.UserInfoForm.userId.value != "" )
				{
					v.disabled = true;
				}
			}
			
			function window_onload() 
			{
				notice.style.display="none";  
			}
			
			var http_request = false;
			//��ʼ����ָ������ĺ�������������ĺ���
			function send_request(url){
				http_request = false;
				//��ʼ��ʼ��XMLHttpRequest����
				if(window.XMLHttpRequest){//Mozilla
					http_request = new XMLHttpRequest();
					if(http_request.overrideMimeType){//����MIME���
						http_request.overrideMimeType("text/xml");						
					}
				}
				else if(window.ActiveXObject){//IE
					try{
						http_request = new ActiveXObject("Msxml2.XMLHTTP");
					}catch(e){
						try{
							http_request = new ActiveXObject("Microsoft.XMLHTTP");							
						}catch(e){
						}
					}
				}
				if(!http_request){
					alert("���ܴ���XMLHttpRequest����");
					return false;
				}
				http_request.onreadystatechange = processRequest;
				http_request.open("GET",url,true);
				http_request.send(null);
			}
			
			function processRequest(){
				if(http_request.readyState == 4){
					if(http_request.status == 200){
						if(http_request.responseText == 0){
							//alert("�û����Ѵ���");
							notice.style.display="block";  
						}
						else{
							userErr = 1;
							notice.style.display="none";  
							}
						
					}
					else{
						alert("�Բ��𣬷���������");
					}
				}
			}
			
			function checkUser(){
				var userName = document.forms[0].userName.value;
				send_request('checkUser.jsp?userName='+userName);
			}
			
			
			window.onload=function setDefaultValue(){
	    		if(document.all("userSn").value==""){
	        		document.all("userSn").value="<%=userSn%>"
	    		}
			}
			// ��ȡѡ��ͬ����Ӧ��ID
			function getSelAppid(){
				var selappid = "";
				if("true"=="<%=isApply%>"){
					var checkboxselappid = document.getElementsByName("checkbox_sel_appid");
					for(var i=0;i<checkboxselappid.length;i++)
					{
						if(checkboxselappid[i].checked)
						{
							selappid += checkboxselappid[i].value+",";
						}
					}	
				}
				return selappid;
			}
		</script>
	</head>
	<%@ include file="/epp/css/cssControl.jsp"%>
	<body class="info" onload="window_onload()">
		<form name="UserInfoForm" method="post">
			<pg:beaninfo requestKey="currUser">
				<input type="hidden" name="remark1"
					value="<pg:cell colName="remark1"  defaultValue=""/>" />
				<table width="100%" height="25" border="0" cellpadding="0"
					cellspacing="1" class="thin">
					<tr>
						<td height="25" class="detailtitle" width="23%">
							��½��
						</td>
						<td height="25">
							<%
									if (GenerateServiceFactory.getGenerateService()
									.enableUserNameGenerate()) {
							%>
							<input type="hidden" name="userName" value="1">
							��ϵͳ�Զ�����
							<%
							} else {
							%>
							<input type="text" name="userName" onchange="checkUser()"
								value="" validator="string" cnname="��½��"
								maxlength="<%=userNamelength%>" onfocus="setDisable(this)">

							<span class="STYLE1">*</span>
							<div id=notice class="notice_STYLE">
								�û����Ѵ���
							</div>
							<%
							}
							%>
						</td>
						<td height="25" class="detailtitle" width="20%">
							��ʵ����
						</td>
						<td height="25">
							<input type="text" name="userRealname"
								value="<pg:cell colName="userRealname"  defaultValue=""/>"
								validator="string" cnname="��ʵ����" maxlength="100">
							<span class="STYLE1">*</span>
						</td>
					</tr>

					<tr>
						<td height="25" class="detailtitle">
							����
						</td>
						<td height="25">
							<input type="password" name="userPassword"
								value="<pg:cell colName="userPassword"  defaultValue="123456"/>"
								validator="string" cnname="����" maxlength="40">
							<span class="STYLE1">*ȱʡ����Ϊ123456</span>
						</td>
						<td height="25" class="detailtitle">
							���֤����
						</td>
						<td height="25">
							<input type="text" name="userIdcard"
								value="<pg:cell colName="userIdcard"  defaultValue=""/>"
								validator="intNull" cnname="���֤����" maxlength="18">
						</td>
					</tr>
					<tr>
						<td height="25" class="detailtitle">
							��λ�绰
						</td>
						<td height="25">
							<input type="text" name="userWorktel"
								value="<pg:cell colName="userWorktel"  defaultValue=""/>"
								validator="phone" cnname="��λ�绰" maxlength="13">
						</td>
						<td height="25" class="detailtitle">
							�Ա�
						</td>
						<td height="25">
							<dict:select type="sex" name="userSex" expression="{userSex}" />
					</tr>

					<tr>
						<td height="25" class="detailtitle">
							��ͥ�绰
						</td>
						<td height="25">
							<input type="text" name="homePhone"
								value="<pg:cell colName="homePhone"  defaultValue=""/>"
								validator="phone" cnname="��ͥ�绰" maxlength="13">
						</td>
						<td height="25" class="detailtitle">
							�����ʼ�
						</td>
						<td height="25">
							<input type="text" name="mail"
								value="<pg:cell colName="mail"  defaultValue=""/>"
								validator="emailNull" cnname="�����ʼ�" maxlength="40">
						</td>
					</tr>

					<tr>
						<td height="25" class="detailtitle">
							�ƶ��绰1
						</td>
						<td height="25">
							<input type="text" name="mobile"
								value="<pg:cell colName="mobile"  defaultValue=""/>"
								validator="phone" cnname="�ƶ��绰" maxlength="13">
						</td>
						<td height="25" class="detailtitle">
							�ƶ��绰1������
						</td>
						<td height="25">
							<input type="text" name="remark4"
								value="<pg:cell colName="remark4"  defaultValue=""/>"
								validator="stringNull" cnname="�ƶ��绰1������" maxlength="100">
						</td>
					</tr>

					<tr>
						<td height="25" class="detailtitle">
							�ƶ��绰2
						</td>
						<td height="25">
							<input type="text" name="userMobiletel2"
								value="<pg:cell colName="userMobiletel2"  defaultValue=""/>"
								validator="phone" cnname="�ƶ��绰2" maxlength="13">
						</td>
						<td height="25" class="detailtitle">
							�ƶ��绰2������
						</td>
						<td height="25">
							<input type="text" name="remark5"
								value="<pg:cell colName="remark5"  defaultValue=""/>"
								validator="stringNull" cnname="�ƶ��绰2������" maxlength="100">
						</td>
					</tr>
					<tr>
						<td height="25" class="detailtitle">
							��֯����
						</td>
						<td height="25">
							<input readonly="true" type="text" name="ou"
								value="<pg:cell colName="ou"  defaultValue="<%=orgName%>"/>"
								validator="stringNull" cnname="��֯����" maxlength="100">
						</td>
						<td height="25" class="detailtitle">
							ƴ��
						</td>
						<td height="25">
							<input type="text" name="userPinyin"
								value="<pg:cell colName="userPinyin"  defaultValue=""/>"
								validator="stringNull" cnname="ƴ��" maxlength="100">
						</td>
					</tr>
					<tr>
						<td height="25" class="detailtitle">
							�û�����
						</td>
						<td height="25">
							<dict:select type="userType" name="userType"
								expression="{userType}" />
						</td>
						<td height="25" class="detailtitle">
							��������
						</td>
						<td height="25">
							<input type="text" name="postalCode"
								value="<pg:cell colName="postalCode"  defaultValue=""/>"
								validator="intNull" cnname="��������" maxlength="7">
						</td>
					</tr>
					<tr>
						<td height="25" class="detailtitle">
							����
						</td>
						<td height="25">
							<input type="text" name="userFax"
								value="<pg:cell colName="userFax"  defaultValue=""/>"
								validator="phone" cnname="����" maxlength="40">
						</td>
						<td height="25" class="detailtitle">
							OICQ
						</td>
						<td height="25">
							<input type="text" name="userOicq"
								value="<pg:cell colName="userOicq"  defaultValue=""/>"
								validator="intNull" cnname="OICQ" maxlength="13">
						</td>
					</tr>
					<tr>
						<td height="25" class="detailtitle">
							����
						</td>
						<td height="25">
							<input type="text" name="userBirthday"
								onclick="showdate(document.all('userBirthday'))" readonly="true"
								value="<pg:cell colName="userBirthday"  defaultValue=""  />"
								validator="stringNull" cnname="����" maxlength="40">
						</td>
						<td height="25" class="detailtitle">
							�û���ַ
						</td>
						<td height="25">
							<input type="text" name="userAddress"
								value="<pg:cell colName="userAddress"  defaultValue=""/>"
								validator="stringNull" cnname="�û���ַ" maxlength="200">
						</td>
					</tr>
					<tr>
						<td height="25" class="detailtitle">
							��¼����
						</td>
						<td height="25">
							<input type="text" name="userLogincount"
								value="<pg:cell colName="userLogincount"  defaultValue="0"/>"
								validator="intNull" readonly cnname="��¼����" maxlength="40">
						</td>
						<td height="25" class="detailtitle">
							�Ƿ���Ч
						</td>
						<td height="25">
							<dict:select type="isvalid" name="userIsvalid"
								expression="{userIsvalid}" />
						</td>
					</tr>
					<tr>
						<td height="25" class="detailtitle">
							ע������
						</td>
						<td height="25">
							<input type="text" name="userRegdate" readonly="true"
								value="<%=datestr%>" validator="stringNull" cnname="ע������"
								maxlength="40">
						</td>
						<td height="25" class="detailtitle">
							�ֻ��̺���
						</td>
						<td height="25">
							<input type="text" name="shortMobile"
								value="<pg:cell colName="shortMobile"  defaultValue=""/>"
								validator="phone" cnname="�ֻ��̺���" maxlength="40">
						</td>
					</tr>
					<tr>
						<td height="25" class="detailtitle">
							�û������
						</td>
						<td height="25">
							<input type="text" name="userSn"
								value="<pg:cell colName="userSn"  defaultValue="" />"
								validator="stringNull" cnname="�û������" maxlength="40">
						</td>
						<td height="25" class="detailtitle" colspan="2">
							<table width="100%" border="0" cellpadding="0" cellspacing="0">
								<tr>
									<td width='10%'>
										<input type="checkbox" name="remark3"
											<pg:equal colName="remark3" value="��">checked</pg:equal>>
									</td>
									<td width='150px'>
										������Ϣ�Ƿ���
									</td>
								</tr>
							</table>
						</td>

					</tr>
					<%
					if (istaxmanager) {
					%>
					<tr>
						<td height="25" class="detailtitle" colspan="2">
							<table width="100%" border="0" cellpadding="0" cellspacing="0">
								<tr>
									<td width='10%'>
										<input type="checkbox" name="istaxmanager"
											<pg:equal colName="istaxmanager" value="1">checked</pg:equal>>
									</td>
									<td width='150px'>
										�Ƿ�˰��Ա
									</td>
								</tr>
							</table>
						</td>
					</tr>
					<%
					} else {
					%>
					<input type="hidden" name="istaxmanager" value="0" checked="false">
					<input type="hidden" name="sel_appid" value=""/>
					<%
					}
					%>
					<%
							// ���ͬ��Ӧ�ù���
							// ��ʢ 2011-7-12
							if (isApply) {
						%>
						<tr>
							<td align="left" class="detailtitle">
								ͬ��Ӧ��
							</td>
							<td class="detailcontent" colspan="3">
							<table align="center">
						<%
									Apply apply = null;
									String app_id = null;
									String app_name = null;
									int enablestatus = 0;
									int sum = 0;
									for (int i = 0; i < applyList.size(); i++) {
										apply = (Apply)applyList.get(i);
										if(null!=apply){
											app_id = apply.getApp_id();
											app_name = apply.getApp_name();
											enablestatus = apply.getEnablestatus();
											if(null==app_id || 
												"".equals(app_id.trim()) || 
												"module".equalsIgnoreCase(app_id.trim()) ||
												0==enablestatus){
												continue;
											}else{
											sum++;
											if(sum%5==1){
						%>	
							<tr>	
						<%} %>
								<td style="border: 0px;">
									<input type="checkbox" value="<%=app_id %>" id="checkbox_sel_appid" name="checkbox_sel_appid"><%=app_name %>
								</td>
						<%					if(sum%5==0){
						%>
							</tr>
						<%}
											}											
										}
									}
						%></table>
							</td>
						</tr>
						<%		
								}
						%>
					<input type="hidden" name="userId"
						value="<pg:cell colName="userId"  defaultValue=""/>" />
					<input name="orgId" value="<%=currOrgId%>" type="hidden" height="0">
				</table>
		</form>

		<hr width="100%">
		<table width="100%" cellpadding="2" cellspacing="0">
			<tr>
				<td>
					<table width="35%" border="0" align="right" cellpadding="0"
						cellspacing="0">
						<tr>
							<td>
								<div align="center">
									<%
											if (!isNew.equals("0")
											|| accesscontroler.getUserID().equals(userid)
											|| accesscontroler.checkPermission(currOrgId,
													"edituser", AccessControl.ORGUNIT_RESOURCE)) {
									%>
									<input name="resave" type="button" class="input" value="����"
										onClick="storeUser()">
									<%
									}
									%>
								</div>
							</td>
							<td>
								<div align="center">
									<input name="Submit31" type="button" class="input" value="ȫ�����"
										onClick="UserInfoForm.reset();">
								</div>
							</td>
							<td>
								<div align="center">
									<input name="Submit32" type="submit" class="input" value="����"
										onClick="back()">
								</div>
							</td>

						</tr>
					</table>
				</td>
			</tr>
		</table>
		</pg:beaninfo>
		<iframe name="saveuser" height="0" width="0"></iframe>

		<div id=divProcessing
			style="width:200px;height:30px;position:absolute;left:300px;top:450px;display:none">
			<table border=0 cellpadding=0 cellspacing=1 bgcolor="#000000"
				width="100%" height="100%">
				<tr>
					<td bgcolor=#3A6EA5>
						<marquee align="middle" behavior="alternate" scrollamount="5">
							<font color=#FFFFFF>...������...��ȴ�...</font>
						</marquee>
					</td>
				</tr>
			</table>
		</div>
	</body>
</html>

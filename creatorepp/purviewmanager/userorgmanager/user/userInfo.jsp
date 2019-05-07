
<%
	 /*
	 * <p>Title: 新增用户页面</p>
	 * <p>Description: 新增用户页面</p>
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

	//用户登录方式 true-支持用户名登录名与用户实名同时登录方式 false-仅支持用户登录方式
	String userloginmode = ConfigManager.getInstance().getConfigValue(
			"userloginmode");

	boolean isUserRealnameExist = false;

	//是否出现  "是否税管员" 复选框
	boolean istaxmanager = ConfigManager.getInstance()
			.getConfigBooleanValue("istaxmanager", false);
	//获取当前系统的时间 并格式化
	//baowen.liu
	java.util.Date date = new java.util.Date();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	String datestr = sdf.format(date);

	//用户登录名的长度--order by gao.tang
	String userNamelength = ConfigManager.getInstance().getConfigValue(
			"userNameLength");
	String currOrgId = request.getParameter("orgId");

	if (currOrgId == null) {
		currOrgId = (String) request.getAttribute("orgId");
	}

	Organization org = OrgCacheManager.getInstance().getOrganization(
			currOrgId);


	// 添加同步应用功能
	// 彭盛 2011-7-12
	String sel_appid = request.getParameter("sel_appid");
	StringBuffer synappmess = new StringBuffer();
	synappmess.append("平台添加成功！");
	boolean isSynApp = false;

	//action start
	if ("true".equals(request.getParameter("isNewUser"))) {
		//新建用户初始化action
		request.setAttribute("currUser", null);
		request.setAttribute("reFlush", "false");
		request.getSession().setAttribute("currUserId", null);
		request.setAttribute("isNew", "1");
	}
	String newUserName = "";
	//是否自动生成用户名
	boolean isAutoUserName = GenerateServiceFactory
			.getGenerateService().enableUserNameGenerate();
	//报错信息
	String errorMessage = "";
	if ("true".equals(request.getParameter("storeUser"))) {
		//保存用户
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

		// 吴卫雄增加：判断用户是否存在，存在则转入操作失败页面
		// 潘伟林修改， 存在则提示用户登陆名重复，返回原页面，清空登陆名

		boolean isUserExist = false;
		if (userManager.isUserExist(user)) {
			request.setAttribute("isUserExist", "true");
			request.setAttribute("reFlush", "false");

			isUserExist = true;
		}

		//支持中文登录
		//彭盛 2009-5-18		

		//如果支持用户名登录名与用户实名同时登录方式，那么用户实名不可以重复
		if (!isUserExist && "true".equals(userloginmode.trim())) {			
			if (userManager.isUserRealnameExist(user)) {
		request.setAttribute("isUserRealnameExist", "true");
		request.setAttribute("reFlush", "false");

		isUserRealnameExist = true;
			}
		}

		//System.out.println("isUserExist = " + isUserExist);
		if (isUserExist == false && isUserRealnameExist == false)//用户名存在不保存用户
		{
			newUserName = user.getUserName();
			try {
		if (newUserName != null && !"".equals(newUserName)) {
			userManager.creatorUser(user, currOrgId, "1");
			
			// 添加同步应用功能
			// 彭盛 2011-7-12
			OrgUserManager orgUserManager = new OrgUserManager();
			isSynApp = orgUserManager.synAppInsertUser(newUserName,currOrgId,sel_appid,synappmess);
		} else {
			if (isAutoUserName) {
				errorMessage = "系统自动生成登陆名异常！";
			} else {
				errorMessage = "登陆名为null！";
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
	
	// 添加同步应用功能
	// 彭盛 2011-7-12		
	// 获取所有应用对象
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
		<title>新增用户</title>
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
					alert("自动生成的帐号有冲突，该帐号已经存在，请重新创建用户！");
				<%
					}else{
				%>
					alert("用户名已存在，请重新输入一个新用户名!");
				<%
					}
				%>
				parent.divProcessing.style.display="none";
			   	parent.document.getElementsByName("resave")[0].disabled = false;
			   	parent.document.getElementsByName("Submit31")[0].disabled = false;
			   	parent.document.getElementsByName("Submit32")[0].disabled = false;
			}else{
				if(isUserRealnameExist == "true"){
					alert("真实名称已存在，请重新输入一个新的真实名称！");
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
								alert("新增失败!原因如下：\n<%=errorMessage%>");
							<%			
							}else{
								if(isApply){
					%>
								var newUserName = "<%=newUserName%>";
								alert("新增用户成功！");
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
								alert("新增失败!原因如下：\n<%=errorMessage%>");
							<%			
							}else{
								if(isApply){
					%>
								alert("新增用户成功！");
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
					alert("登陆名只能以字母开头，且由数字、字母和下划线组成!");
					document.UserInfoForm.userName.focus();
					return false;
				}								
				if (validateForm(UserInfoForm) )
				{
					var userName= document.forms[0].userName.value;
					if (trim(userName).length == 0 ){
			    		alert("请输入登陆名！"); 
			    		return false;
			    	} 
			    	if(document.UserInfoForm.remark3.checked)
			    		document.UserInfoForm.remark3.value="是";
					else 
						document.UserInfoForm.remark3.value="否";
					
					if(document.UserInfoForm.istaxmanager.checked)
						document.UserInfoForm.istaxmanager.value="1";
					else
						document.UserInfoForm.istaxmanager.value="0";
						
					if("true"=="<%=userloginmode%>"){	
						if(document.UserInfoForm.userRealname.value.search(/^[a-zA-Z0-9_\u4e00-\u9fa5]+$/)!=-1){
							if(document.UserInfoForm.userRealname.value.search(/[\u4e00-\u9fa5]{1}/)!=-1){
								if(!confirm("用户创建后登陆名与真实名称将无法修改！是否创建？")){
									return false;
								}
							}else{
								alert("用户真实名称必须包含至少一个中文字符！");
								document.UserInfoForm.userRealname.focus();
								return false;
							}
						}else{
							alert("用户真实名称只能为中文、数字、字母和下划线!");
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
			//初始化，指定处理的函数，发送请求的函数
			function send_request(url){
				http_request = false;
				//开始初始化XMLHttpRequest对象
				if(window.XMLHttpRequest){//Mozilla
					http_request = new XMLHttpRequest();
					if(http_request.overrideMimeType){//设置MIME类别
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
					alert("不能创建XMLHttpRequest对象");
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
							//alert("用户名已存在");
							notice.style.display="block";  
						}
						else{
							userErr = 1;
							notice.style.display="none";  
							}
						
					}
					else{
						alert("对不起，服务器错误");
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
			// 获取选择同步的应用ID
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
							登陆名
						</td>
						<td height="25">
							<%
									if (GenerateServiceFactory.getGenerateService()
									.enableUserNameGenerate()) {
							%>
							<input type="hidden" name="userName" value="1">
							由系统自动生成
							<%
							} else {
							%>
							<input type="text" name="userName" onchange="checkUser()"
								value="" validator="string" cnname="登陆名"
								maxlength="<%=userNamelength%>" onfocus="setDisable(this)">

							<span class="STYLE1">*</span>
							<div id=notice class="notice_STYLE">
								用户名已存在
							</div>
							<%
							}
							%>
						</td>
						<td height="25" class="detailtitle" width="20%">
							真实名称
						</td>
						<td height="25">
							<input type="text" name="userRealname"
								value="<pg:cell colName="userRealname"  defaultValue=""/>"
								validator="string" cnname="真实名称" maxlength="100">
							<span class="STYLE1">*</span>
						</td>
					</tr>

					<tr>
						<td height="25" class="detailtitle">
							口令
						</td>
						<td height="25">
							<input type="password" name="userPassword"
								value="<pg:cell colName="userPassword"  defaultValue="123456"/>"
								validator="string" cnname="口令" maxlength="40">
							<span class="STYLE1">*缺省口令为123456</span>
						</td>
						<td height="25" class="detailtitle">
							身份证号码
						</td>
						<td height="25">
							<input type="text" name="userIdcard"
								value="<pg:cell colName="userIdcard"  defaultValue=""/>"
								validator="intNull" cnname="身份证号码" maxlength="18">
						</td>
					</tr>
					<tr>
						<td height="25" class="detailtitle">
							单位电话
						</td>
						<td height="25">
							<input type="text" name="userWorktel"
								value="<pg:cell colName="userWorktel"  defaultValue=""/>"
								validator="phone" cnname="单位电话" maxlength="13">
						</td>
						<td height="25" class="detailtitle">
							性别
						</td>
						<td height="25">
							<dict:select type="sex" name="userSex" expression="{userSex}" />
					</tr>

					<tr>
						<td height="25" class="detailtitle">
							家庭电话
						</td>
						<td height="25">
							<input type="text" name="homePhone"
								value="<pg:cell colName="homePhone"  defaultValue=""/>"
								validator="phone" cnname="家庭电话" maxlength="13">
						</td>
						<td height="25" class="detailtitle">
							电子邮件
						</td>
						<td height="25">
							<input type="text" name="mail"
								value="<pg:cell colName="mail"  defaultValue=""/>"
								validator="emailNull" cnname="电子邮件" maxlength="40">
						</td>
					</tr>

					<tr>
						<td height="25" class="detailtitle">
							移动电话1
						</td>
						<td height="25">
							<input type="text" name="mobile"
								value="<pg:cell colName="mobile"  defaultValue=""/>"
								validator="phone" cnname="移动电话" maxlength="13">
						</td>
						<td height="25" class="detailtitle">
							移动电话1归属地
						</td>
						<td height="25">
							<input type="text" name="remark4"
								value="<pg:cell colName="remark4"  defaultValue=""/>"
								validator="stringNull" cnname="移动电话1归属地" maxlength="100">
						</td>
					</tr>

					<tr>
						<td height="25" class="detailtitle">
							移动电话2
						</td>
						<td height="25">
							<input type="text" name="userMobiletel2"
								value="<pg:cell colName="userMobiletel2"  defaultValue=""/>"
								validator="phone" cnname="移动电话2" maxlength="13">
						</td>
						<td height="25" class="detailtitle">
							移动电话2归属地
						</td>
						<td height="25">
							<input type="text" name="remark5"
								value="<pg:cell colName="remark5"  defaultValue=""/>"
								validator="stringNull" cnname="移动电话2归属地" maxlength="100">
						</td>
					</tr>
					<tr>
						<td height="25" class="detailtitle">
							组织机构
						</td>
						<td height="25">
							<input readonly="true" type="text" name="ou"
								value="<pg:cell colName="ou"  defaultValue="<%=orgName%>"/>"
								validator="stringNull" cnname="组织机构" maxlength="100">
						</td>
						<td height="25" class="detailtitle">
							拼音
						</td>
						<td height="25">
							<input type="text" name="userPinyin"
								value="<pg:cell colName="userPinyin"  defaultValue=""/>"
								validator="stringNull" cnname="拼音" maxlength="100">
						</td>
					</tr>
					<tr>
						<td height="25" class="detailtitle">
							用户类型
						</td>
						<td height="25">
							<dict:select type="userType" name="userType"
								expression="{userType}" />
						</td>
						<td height="25" class="detailtitle">
							邮政编码
						</td>
						<td height="25">
							<input type="text" name="postalCode"
								value="<pg:cell colName="postalCode"  defaultValue=""/>"
								validator="intNull" cnname="邮政编码" maxlength="7">
						</td>
					</tr>
					<tr>
						<td height="25" class="detailtitle">
							传真
						</td>
						<td height="25">
							<input type="text" name="userFax"
								value="<pg:cell colName="userFax"  defaultValue=""/>"
								validator="phone" cnname="传真" maxlength="40">
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
							生日
						</td>
						<td height="25">
							<input type="text" name="userBirthday"
								onclick="showdate(document.all('userBirthday'))" readonly="true"
								value="<pg:cell colName="userBirthday"  defaultValue=""  />"
								validator="stringNull" cnname="生日" maxlength="40">
						</td>
						<td height="25" class="detailtitle">
							用户地址
						</td>
						<td height="25">
							<input type="text" name="userAddress"
								value="<pg:cell colName="userAddress"  defaultValue=""/>"
								validator="stringNull" cnname="用户地址" maxlength="200">
						</td>
					</tr>
					<tr>
						<td height="25" class="detailtitle">
							登录次数
						</td>
						<td height="25">
							<input type="text" name="userLogincount"
								value="<pg:cell colName="userLogincount"  defaultValue="0"/>"
								validator="intNull" readonly cnname="登录次数" maxlength="40">
						</td>
						<td height="25" class="detailtitle">
							是否有效
						</td>
						<td height="25">
							<dict:select type="isvalid" name="userIsvalid"
								expression="{userIsvalid}" />
						</td>
					</tr>
					<tr>
						<td height="25" class="detailtitle">
							注册日期
						</td>
						<td height="25">
							<input type="text" name="userRegdate" readonly="true"
								value="<%=datestr%>" validator="stringNull" cnname="注册日期"
								maxlength="40">
						</td>
						<td height="25" class="detailtitle">
							手机短号码
						</td>
						<td height="25">
							<input type="text" name="shortMobile"
								value="<pg:cell colName="shortMobile"  defaultValue=""/>"
								validator="phone" cnname="手机短号码" maxlength="40">
						</td>
					</tr>
					<tr>
						<td height="25" class="detailtitle">
							用户排序号
						</td>
						<td height="25">
							<input type="text" name="userSn"
								value="<pg:cell colName="userSn"  defaultValue="" />"
								validator="stringNull" cnname="用户排序号" maxlength="40">
						</td>
						<td height="25" class="detailtitle" colspan="2">
							<table width="100%" border="0" cellpadding="0" cellspacing="0">
								<tr>
									<td width='10%'>
										<input type="checkbox" name="remark3"
											<pg:equal colName="remark3" value="是">checked</pg:equal>>
									</td>
									<td width='150px'>
										个人信息是否保密
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
										是否税管员
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
							// 添加同步应用功能
							// 彭盛 2011-7-12
							if (isApply) {
						%>
						<tr>
							<td align="left" class="detailtitle">
								同步应用
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
									<input name="resave" type="button" class="input" value="保存"
										onClick="storeUser()">
									<%
									}
									%>
								</div>
							</td>
							<td>
								<div align="center">
									<input name="Submit31" type="button" class="input" value="全部清空"
										onClick="UserInfoForm.reset();">
								</div>
							</td>
							<td>
								<div align="center">
									<input name="Submit32" type="submit" class="input" value="返回"
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
							<font color=#FFFFFF>...处理中...请等待...</font>
						</marquee>
					</td>
				</tr>
			</table>
		</div>
	</body>
</html>

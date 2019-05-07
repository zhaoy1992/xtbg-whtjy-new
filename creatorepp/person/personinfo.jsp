<%@ page language="java" contentType="text/html;charset=GBK" %>
<%@ taglib prefix="tab" uri="/WEB-INF/tabpane-taglib.tld" %>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ taglib uri="/WEB-INF/dictionary.tld" prefix="dict"%>
<%@ page import="com.chinacreator.sysmgrcore.entity.*"%>
<%@ page import="com.chinacreator.security.AccessControl" %>
<%@ page import="com.chinacreator.sysmgrcore.manager.db.UserManagerImpl
				,com.chinacreator.config.ConfigManager" %>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
    accesscontroler.checkAccess(request,response);
    
    String userId = accesscontroler.getUserID();
    
    
   User user = new UserManagerImpl().getUserById(userId);
   //String pwd = EncrpyPwd.decodePassword(user.getUserPassword());
	//user.setUserPassword(pwd);
		
    request.setAttribute("userinfo",user);
    Organization mainorg = accesscontroler.getChargeOrg();
    
    java.util.List secondOrgs = (java.util.List)accesscontroler.getUserObjectAttribute("secondOrgs");
    String mainorgname = "";
    if(mainorg != null)
    {
    	mainorgname = mainorg.getRemark5();
    	
    }
   for(int i = 0; secondOrgs != null && i < secondOrgs.size(); i ++)
    {
    	Object obj = secondOrgs.get(i);
    	if(obj instanceof Organization){
		   	Organization secondorg = (Organization)obj;
		   	if(mainorgname.trim().equals(""))
		   	{
		   		mainorgname = secondorg.getRemark5();
		   	}
		   	else
		  	{
		   		mainorgname += "," + secondorg.getRemark5();
		   	}
	   	}if(obj instanceof ChargeOrg){
	   		ChargeOrg chargeOrg = (ChargeOrg)obj;
	   		if(mainorgname.trim().equals(""))
		   	{
		   		mainorgname = chargeOrg.getOrgName();
		   	}
		   	else
		  	{
		   		mainorgname += "," + chargeOrg.getOrgName();
		   	}
	   	}
    }
	
	String rootpath = request.getContextPath();
%>
<html>
	<head>
		<link rel="stylesheet" type="text/css" href="../sysmanager/css/windows.css">
		<link rel="stylesheet" type="text/css" href="../sysmanager/css/contentpage.css">
		<link rel="stylesheet" type="text/css" href="../sysmanager/css/tab.winclassic.css">
		<script language="JavaScript" src="<%=request.getContextPath()%>/sysmanager/jobmanager/common.js" type="text/javascript"></script>		
		<script language="javascript" src="../scripts/selectTime.js"></script>
		<script language="JavaScript" src="../include/pager.js" type="text/javascript"></script>
		<script src="../inc/js/func.js"></script>
		<script language="JavaScript" src="<%=request.getContextPath()%>/public/datetime/calender_date.js" ></script>
		<script language="JavaScript" src="../../sysmanager/scripts/selectTime.js" type="text/javascript"></script>
		<script type="text/javascript" src="../../public/datetime/calender.js" language="javascript"></script>
		<script type="text/javascript" src="../../public/datetime/calender_date.js" language="javascript"></script>
		<script language="JavaScript">
		
			function storeUser()
			{
				document.UserInfoForm.userSex.disabled=false;
				document.UserInfoForm.userType.disabled=false;
				if(document.UserInfoForm.remark3.checked)document.UserInfoForm.remark3.value="��";
				else document.UserInfoForm.remark3.value="��";
				if(document.UserInfoForm.istaxmanager.checked)document.UserInfoForm.istaxmanager.value = 1;
				else document.UserInfoForm.istaxmanager.value = 0;
			   	document.UserInfoForm.isvalid.disabled=false;
			   	document.UserInfoForm.istaxmanager.disabled=false;
				document.UserInfoForm.action="<%=rootpath%>/person/userInfoHandle.jsp?action=storeUser";
				UserInfoForm.submit();
				//window.parent.frames[1].location.reload();
			}
		</SCRIPT>
		<title>������ϸ��Ϣ</title>
	<tab:tabConfig/>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<link rel="stylesheet" type="text/css" href="../css/windows.css">
		<link rel="stylesheet" type="text/css" href="../css/contentpage.css">
		<link rel="stylesheet" type="text/css" href="../css/tab.winclassic.css">
	</head>
	<%@ include file="/epp/css/cssControl.jsp"%><body  ENCTYPE="multipart/form-data">
	
	<tab:tabContainer id="userinfo-bar-container" selectedTabPaneId="userInfo">
		<tab:tabPane id="userInfo" tabTitle="������ϸ��Ϣ" >
		<pg:beaninfo requestKey="userinfo">
		<form id="UserInfoForm" method="post" name="UserInfoForm" target="saveInfoFrame">
				<input type="hidden" name="userId" value="<pg:cell colName="userId" defaultValue=""/>" />
				<table border="0" align="center" width="100%" cellpadding="0" cellspacing="0">
					<tr>
						<td width="100%" align="left">
							<table border='0' align="left" width="100%" cellpadding='0' cellspacing='0'>
								<tr>
									<td>
										<table border='0' align="left" width="100%" cellpadding='0' cellspacing='0'>
											<tr height='24px'>
												<td width='100%' height='27px' background='../sysmanager/images/oa_r7_c7.jpg' class='form_title'>
													
												</td>
											</tr>
										</table>
									</td>
								</tr>
								
								<tr>
									<td>
										<table width="100%" align="left" class="form_body" cellspacing="0" cellpadding="0">
											<tr>
												<td width="100%" align="left">
													<table width="100%" border="0" align="left" cellpadding="0" cellspacing="1" class="thin">
														<tr>
															<td  width="15%">
																��½��<input type="hidden" name="userSn" value="<pg:cell colName="userSn" defaultValue=""/>"/>
															</td>
															<td width="35%">
																<input type="text" name="userName" value="<pg:cell colName="userName" defaultValue=""/>" readonly="true"  style="width:70%">
															</td>
															<td width="15%">
																��ʵ����
															</td>
															<td width="35%">
																<input type="text" name="userRealname" value="<pg:cell colName="UserRealname" defaultValue=""/>"  labelClass="label" style="width:70%" onlyDate="false">
															</td>
														</tr>
														<tr>
															<td width='90'>
																����
															</td>
															<td width='*'>
																<input type="password" name="password" value="<pg:cell colName="UserPassword" defaultValue=""/>"  readonly="true" labelClass="label" style="width:70%">
															</td>
															<td>
																���֤����
															</td>
															<td width='*'>

																<input type="text" name="userIdcard" value="<pg:cell colName="UserIdcard" defaultValue=""/>" validator="intNull" cnname="���֤����" maxlength="18" style="width:70%">

															</td>
														</tr>
														<tr>
															<td>
																��λ�绰
															</td>
															<td width='*'>
																<input type="text" name="userWorktel" value="<pg:cell colName="UserWorktel" defaultValue=""/>" validator="intNull" cnname="��λ�绰" maxlength="13" style="width:70%">
															</td>
															<td width='130'>
																�Ա�
															</td>
															<td width='*'>
																<dict:select type="sex" name="userSex" expression="{UserSex}" style="width:70%"/>
															</td>
														</tr>
														<tr>
															<td width='90'>
																��ͥ�绰
															</td>
															<td width='*'>
																<input type="text" name="homePhone" value="<pg:cell colName="UserHometel" defaultValue=""/>"  validator="intNull" cnname="��ͥ�绰" maxlength="13" style="width:70%">
															</td>
															<td width='130'>
																�����ʼ�
															</td>
															<td width='*'>
																<input type="text" name="mail" value="<pg:cell colName="UserEmail" defaultValue=""/>"  labelClass="label" style="width:70%">
															</td>
														</tr>
														<tr>
															<td width='90'>
																�ƶ��绰1
															</td>
															<td width='*'>
																<input type="text" name="mobile" value="<pg:cell colName="UserMobiletel1" defaultValue=""/>" validator="intNull" cnname="�ƶ��绰" maxlength="13" style="width:70%">
															</td>
															<td width='130'>
																�ƶ��绰1������
															</td>
															<td width='*'>
																<input type="text" name="remark4" value="<pg:cell colName="Remark4" defaultValue=""/>"  labelClass="label" style="width:70%">
															</td>
														</tr>
														<tr>
															<td width='90'>
																�ƶ��绰2
															</td>
															<td width='*'>
																<input type="text" name="userMobiletel2" value="<pg:cell colName="UserMobiletel2" defaultValue=""/>" validator="intNull" cnname="�ƶ��绰2" maxlength="13" style="width:70%">
															</td>
															<td width='130'>
																�ƶ��绰2������
															</td>
															<td width='*'>
																<input type="text" name="remark5" value="<pg:cell colName="Remark5" defaultValue=""/>"  labelClass="label" style="width:70%">
															</td>
														</tr>
														<tr>
															<td>
																��֯����
															</td>
															<td width='*'>
																<input type="text" name="ou" value="<%=mainorgname%>"  readonly="true" labelClass="label" style="width:70%">
															</td>
															<td>
																ƴ��
															</td>
															<td width='*'>
																<input type="text" name="userPinyin" value="<pg:cell colName="UserPinyin" defaultValue=""/>"  labelClass="label" style="width:70%">
															</td>
														</tr>
														<tr>
															<td>
																�û�����
															</td>
															<td width='*'>
																<dict:select type="userType" name="userType" disabled="true" expression="{UserType}"  style="width:70%"/>
															</td>
															<td width='130'>
																��������
															</td>
															<td width='*'>
																<input type="text" name="postalCode" maxlength="6" value="<pg:cell colName="UserPostalcode" defaultValue=""/>"  labelClass="label" style="width:70%">
															</td>
														</tr>
														<tr>
															<td width='90'>
																����
															</td>
															<td width='*'>
																<input type="text" name="userFax" value="<pg:cell colName="UserFax" defaultValue=""/>"  labelClass="label" style="width:70%">
															</td>
															<td width='130'>
																OICQ
															</td>
															<td width='*'>
																<input type="text" name="userOicq" maxlength="16" value="<pg:cell colName="UserOicq" defaultValue=""/>"  labelClass="label" style="width:70%">
															</td>
														</tr>
														<tr>
															<td width='90'>
																����
															</td>
															<td width='*'>
																<input type="text" name="userBirthday" value="<pg:cell colName="UserBirthday" defaultValue="" />"  onclick="showdate(document.all('userBirthday'))" readonly="true" labelClass="label" style="width:70%">
															</td>
															<td>
																�û���ַ
															</td>
															<td width='*'>
																<input type="text" name="userAddress" value="<pg:cell colName="UserAddress" defaultValue=""/>"  labelClass="label" style="width:70%">
															</td>
														</tr>
														<tr>
															<td>
																��¼����
															</td>
															<td width='*'>
																<input type="text" name="userLogincount" value="<pg:cell colName="UserLogincount" defaultValue="0"/>"  readonly="true" labelClass="label" style="width:70%">
															</td>
															<td width='130'>
																�Ƿ���Ч
															</td>
															<td width='*'>
																<dict:select type="isvalid" disabled="true" name="isvalid" expression="{UserIsvalid}"  style="width:70%"/>
															</td>
														</tr>



														<tr>
															<td width='90'>
																ע������
															</td>
															<td width='*'>
																<input type="text" name="userRegdate" value="<pg:cell colName="UserRegdate" defaultValue=""/>"  readonly="true" labelClass="label" style="width:70%">
															</td>
															<td width='130'>
																�ֻ��̺���
															</td>
															<td width='*'>
																<input type="text" name="shortMobile" value="<pg:cell colName="Remark2" defaultValue=""/>"  labelClass="label" style="width:70%">
															</td>
														</tr>
														<tr>
															<td>
															
																<input type="checkbox" name="remark3" value="<pg:cell colName="Remark3" defaultValue=""/>" <pg:equal colName="Remark3" value="��">checked</pg:equal>>
															
															</td>
															<td width='*'>
																������Ϣ�Ƿ���
															</td>
															<td width='130'>
																<input type="checkbox" name="istaxmanager"  disabled
																	value="<pg:cell colName="istaxmanager" defaultValue="0"/>"
																		<pg:equal colName="istaxmanager" value="1">checked</pg:equal>>
															</td>
															<td width='*'>
																�Ƿ�˰��Ա
															</td>
														</tr>
														<!--<tr>-->
														<!--<td  width="70%" align="left" ><table width="100%" border="0" cellpadding="0" cellspacing="0"><tr>-->
														<!--<td width='10%'><input type="checkbox" name="remark3" <pg:equal colName="remark3" value="��">checked</pg:equal>></td>-->
														<!--<td width='150px'>������Ϣ�Ƿ���</td></tr></table></td>-->
														<!--    -->
														<!--<td width="70%" align="left" >&nbsp;</td>-->
														<!--</tr>-->
													</table>
												</td>
											</tr>
											<tr>
												<td width="100%" align="right">
													<hr width="100%">
													<table width="100%">
														<tr>
															<td align='center'>
																<input type="button" name="save" value="��    ��" class="input" onclick="storeUser()">
																&nbsp;
																<input type="reset" name="label2" value="��    ��" class="input">
																&nbsp;
															</td>
														</tr>
													</table>
												</td>
											</tr>
										</table>
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
				<table width="100%" align="center" border="0" cellpadding="0" cellspacing="0">
					<IFRAME name="saveInfoFrame" id="saveInfoFrame" height="0" width="0"></IFRAME>
				</table>
		</form>
		</pg:beaninfo>
	</tab:tabPane>
	<tab:tabPane id="res_list" tabTitle="��Դ�鿴" lazeload="true">
		<% String temppath = rootpath+"/sysmanager/resmanager/res_queryframe.jsp?isUserRes=is&typeName=USER" ;%>
		<tab:iframe id="res_list_iframe" src="<%=temppath%>" frameborder="0" width="100%" height="100%"></tab:iframe>
	</tab:tabPane>
	
	<%
	if(ConfigManager.getInstance().getConfigBooleanValue("enablejobfunction", false))
	{
	%>
	<tab:tabPane id="job_list" tabTitle="��λ�鿴" lazeload="true" >
		<% String temppath = rootpath+"/person/userjob_list.jsp" ;%>
		<tab:iframe id="job_list_iframe" src="<%=temppath%>" frameborder="0" width="100%" height="100%"></tab:iframe>
	</tab:tabPane>
	<%
	}
	%>
	
	<tab:tabPane id="role_list" tabTitle="��ɫ�鿴" lazeload="true" >
		<% String temppath = rootpath+"/person/userrole_do.jsp" ;%>
		<tab:iframe id="role_list_iframe" src="<%=temppath%>" frameborder="0" width="100%" height="100%"></tab:iframe>
	</tab:tabPane>
	
	</tab:tabContainer>
	
	</body>
</html>

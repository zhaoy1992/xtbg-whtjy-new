<%-- 
	��������ɫ�����ѯ�������
	���ߣ�����ƽ
	�汾��1.0
	���ڣ�2013-05-30
 --%>
<%@page import="com.chinacreator.config.ConfigManager"%>

<%     
	response.setHeader("Cache-Control", "no-cache"); 
	response.setHeader("Pragma", "no-cache"); 
	response.setDateHeader("Expires", -1);  
	response.setDateHeader("max-age", 0); 
%>

<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.security.AccessControl,
				com.chinacreator.sysmgrcore.manager.RoleManager,
				com.chinacreator.sysmgrcore.manager.SecurityDatabase,
				com.chinacreator.sysmgrcore.entity.Role"%>

<%@ taglib prefix="tab" uri="/WEB-INF/tabpane-taglib.tld" %>				

<%
	AccessControl accessControl = AccessControl.getInstance();
	accessControl.checkManagerAccess(request,response);
	
	String roleId = (String) request.getParameter("roleId");
	RoleManager roleManager = SecurityDatabase.getRoleManager();
	Role role = roleManager.getRoleById(roleId);
	String roleName = role.getRoleName();
	
	
	//��ɫ�û���ѯ�б�
	String roleuserquery = "roleuserquery.jsp?roleId=" + roleId ;
	
	//��ɫ������ѯ�б�
	String roleorgquery = "roleorgquery.jsp?roleId=" + roleId ;

%>
<html>
	<head>
		<title>�����ɫ��<%=roleName %>����ѯ</title>
		<link rel="stylesheet" type="text/css" href="../../css/treeview.css">
		<link rel="stylesheet" type="text/css" href="../../css/windows.css">
	</head> 
	<tab:tabConfig/>
	<%@ include file="/epp/css/cssControl.jsp"%><body  bgcolor="#F7F8FC" >
		<table width="100%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td colspan="1">	
					<tab:tabContainer id="role-grant" selectedTabPaneId="user-grant">
						<tab:tabPane id="user-grant" tabTitle="��ɫ�����û��б�" lazeload="true">
							<tab:iframe id="usergrant" src="<%=roleuserquery%>" frameborder="0" scrolling="no" width="100%" height="540">
							</tab:iframe>
						</tab:tabPane>
						<% 
							if(ConfigManager.getInstance().getConfigBooleanValue("enableorgrole",false)){
						%>
						<tab:tabPane id="org-grant" tabTitle="��ɫ��������б�" lazeload="true">
							<tab:iframe id="orggrant" src="<%=roleorgquery%>" frameborder="0" scrolling="no" width="100%" height="540">
							</tab:iframe>
						</tab:tabPane>
						<% 
							}
						%>
						
						
					</tab:tabContainer>
				</td>
			</tr>
		</table>
	</body>
</html>

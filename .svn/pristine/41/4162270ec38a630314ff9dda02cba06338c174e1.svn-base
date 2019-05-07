
<%@page import="com.chinacreator.config.ConfigManager"%><%
/*
 * <p>Title: 角色授予查询操作框架</p>
 * <p>Description: 角色授予查询操作框架</p>
 * <p>Copyright: Copyright (c) 2008</p>
 * <p>Company: chinacreator</p>
 * @Date 2008-4-14
 * @author liangbing.tao
 * @version 1.0
 */
 %>
 

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
	
	
	//角色用户查询列表
	String roleuserquery = "roleuserquery.jsp?roleId=" + roleId ;
	
	//角色机构查询列表
	String roleorgquery = "roleorgquery.jsp?roleId=" + roleId ;
	
	//角色用户组查询列表
	String rolegroupquery = "rolegroupquery.jsp?roleId=" + roleId;
	
	//角色机构岗位查询列表
	String roleOrgJobQuery = "roleOrgJobQuery.jsp?roleId=" + roleId;
%>
<html>
	<head>
		<title>授予角色【<%=roleName %>】查询</title>
		<link rel="stylesheet" type="text/css" href="../../css/treeview.css">
		<link rel="stylesheet" type="text/css" href="../../css/windows.css">
	</head> 
	<tab:tabConfig/>
	<%@ include file="/epp/css/cssControl.jsp"%><body  bgcolor="#F7F8FC" >
		<table width="100%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td colspan="1">	
					<tab:tabContainer id="role-grant" selectedTabPaneId="user-grant">
						<tab:tabPane id="user-grant" tabTitle="角色授予用户列表" lazeload="true">
							<tab:iframe id="usergrant" src="<%=roleuserquery%>" frameborder="0" scrolling="no" width="100%" height="540">
							</tab:iframe>
						</tab:tabPane>
						<% 
							if(ConfigManager.getInstance().getConfigBooleanValue("enableorgrole",false)){
						%>
						<tab:tabPane id="org-grant" tabTitle="角色授予机构列表" lazeload="true">
							<tab:iframe id="orggrant" src="<%=roleorgquery%>" frameborder="0" scrolling="no" width="100%" height="540">
							</tab:iframe>
						</tab:tabPane>
						<% 
							}
						%>
						<%
							if(ConfigManager.getInstance().getConfigBooleanValue("enablergrouprole", false)){   
						%>
						<tab:tabPane id="group-grant" tabTitle="角色授予用户组列表" lazeload="true">
							<tab:iframe id="groupgrant" src="<%=rolegroupquery%>" frameborder="0" scrolling="no" width="100%" height="540">
							</tab:iframe>
						</tab:tabPane>
						<% 
							}
						%>
						<%
							if(ConfigManager.getInstance().getConfigBooleanValue("enablejobfunction", false)){
						%>
						<tab:tabPane id="orgjob-grant" tabTitle="角色授予机构岗位列表" lazeload="true">
							<tab:iframe id="orgjobgrant" src="<%=roleOrgJobQuery%>" frameborder="0" scrolling="no" width="100%" height="540">
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

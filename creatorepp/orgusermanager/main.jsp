<%@page contentType="text/html; charset=GBK"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="java.util.*" %>
<%@ taglib uri="/WEB-INF/dictionary.tld" prefix="dict"%>
<%@ taglib prefix="tab" uri="/WEB-INF/tabpane-taglib.tld" %>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ page import="com.chinacreator.config.ConfigManager,
				com.chinacreator.sysmgrcore.manager.db.OrgAdministratorImpl,
				com.chinacreator.sysmgrcore.manager.OrgAdministrator,com.chinacreator.epp.util.ResetCache"%>
<%
	AccessControl control = AccessControl.getInstance();
	control.checkManagerAccess(request,response);
	
	//new ResetCache().reset();
	
	String curSystem = control.getCurrentSystem();
	
	OrgAdministrator orgAdministrator = new OrgAdministratorImpl();
	String curUserId = control.getUserID();
	List list = orgAdministrator.getManagerOrgsOfUserByID(curUserId);
	boolean isAdminOrOrgManager = false;//当前登陆用户是否具有部门管理员角色或者超级管理员角色
	if(list.size() > 0 || control.isAdmin()){//判断是否是部门管理员和拥有超级管理员角色
      	  isAdminOrOrgManager = true;
	}
	
	// 判断是否平台
	boolean isEgp = control.getCurrentSystemID().equals("module")?true:false;
%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=GBK" />
	<link href="../inc/css/cms.css" rel="stylesheet" type="text/css">
	<tab:tabConfig/>
	<title>权限管理</title>
</head>
<%@ include file="/epp/css/cssControl.jsp"%><body   bgcolor="#F7F8FC" >

	<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0" align="center">
		<tr>
			<td colspan="2">
			<% 
			if(isAdminOrOrgManager){
			%>
			
				<tab:tabContainer id="user-manage-update" selectedTabPaneId="org-manage">
					<tab:tabPane id="org-manage" tabTitle="用户和机构管理" lazeload="true">
						<tab:iframe id="orgmanage" src="userorgmanager/org/org_main.jsp" frameborder="0" scrolling="no" width="100%" height="95%">
						</tab:iframe>
					</tab:tabPane>
					<%if(!isEgp){ %>
					<tab:tabPane id="role-manage" tabTitle="角色管理" lazeload="true">
						<tab:iframe id="rolemanage" src="rolemanager/role.jsp" frameborder="0" scrolling="no" width="99%" height="95%">
						</tab:iframe>
					</tab:tabPane>
					<%} %>
					<!-- 岗位管理开关   2008-4-2 baowen.liu -->
					<%
						if(ConfigManager.getInstance().getConfigBooleanValue("enablejobfunction", false) && !isEgp)
						{
					%>
					<tab:tabPane id="job-manage" tabTitle="岗位管理" lazeload="true">
						<tab:iframe id="jobmanage" src="jobmanager/jobinfo.jsp" frameborder="0" scrolling="no" width="99%" height="95%">
						</tab:iframe>
					</tab:tabPane>
					<%
						}
					%>
					
					<!-- 用户组开关-->
					<%
						if(ConfigManager.getInstance().getConfigBooleanValue("enablergrouprole", false) && !isEgp)
						{   
					%>
					<tab:tabPane id="group-manage" tabTitle="用户组管理" lazeload="true">
						<tab:iframe id="groupmanager" src="groupmanager/group_main.jsp" frameborder="0" scrolling="no" width="99%" height="95%">
						</tab:iframe>
					</tab:tabPane>
					<%
						}
					%>
					
					<!-- 资源管理开关 -->
					<% 
						if(ConfigManager.getInstance().getConfigBooleanValue("enablerresmanaer", false) && !isEgp)
						{
					%>
					<tab:tabPane id="res-manage" tabTitle="资源管理" lazeload="true">
						<tab:iframe id="resmanage" src="resmanager/res_main.jsp" frameborder="0" scrolling="no" width="99%" height="95%" >
						</tab:iframe>
					</tab:tabPane>
					<% 
						}
					%>
					</tab:tabContainer>		
				
			<% 
			}else{
			%>
			<div align="center">没有权限！请与系统管理员联系</div>
			<% 
			}	
			%>	
			
			</td>
		</tr>
  </table>	
<iframe name="exeman" width="0" height="0" style="display:none"></iframe>
</body>
</html>

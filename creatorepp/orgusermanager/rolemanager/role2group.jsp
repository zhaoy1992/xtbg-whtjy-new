<%
/*
 * <p>Title: 角色授予用户组框架页面</p>
 * <p>Description: 角色授予用户组框架页面</p>
 * <p>Copyright: Copyright (c) 2008</p>
 * <p>Company: chinacreator</p>
 * @Date 2008-3-25
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

<%
	AccessControl control = AccessControl.getInstance();
	control.checkManagerAccess(request,response);
	
	String roleId=request.getParameter("roleId");
	RoleManager roleManager = SecurityDatabase.getRoleManager();
	Role role = roleManager.getRoleById(roleId);
	String roleName = role.getRoleName();

%>
<html>
	<head>
		<title>授予角色【<%=roleName %>】给用户组</title>
		<link rel="stylesheet" type="text/css" href="../css/treeview.css">
		<link rel="stylesheet" type="text/css" href="../css/windows.css">
	</head> 
	<frameset name="frame1" cols="30,70" frameborder="no" border="0" framespacing="0" >
	  <frame src="groupTree.jsp?roleId=<%=roleId%>" name="groupTree" id="groupTree" />
	  <frame src="noGroup.jsp" name="groupList" scrolling="No" noresize="noresize" id="groupList" />
	</frameset>
	<noframes>
		<%@ include file="/epp/css/cssControl.jsp"%><body >
		</body>
	</noframes>
</html>

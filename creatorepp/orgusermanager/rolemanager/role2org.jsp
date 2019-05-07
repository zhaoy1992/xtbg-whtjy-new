
<%@page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>
<%@page import="com.chinacreator.sysmgrcore.manager.RoleManager"%>
<%@page import="com.chinacreator.sysmgrcore.entity.Role"%><%
/*
 * <p>Title: 角色授予主机构框架</p>
 * <p>Description: 角色授予机构框架</p>
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
<%@ page import="com.chinacreator.security.AccessControl"%>

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
		<title>将角色【<%=roleName %>】设置给机构</title>
		<link rel="stylesheet" type="text/css" href="../css/treeview.css">
		<link rel="stylesheet" type="text/css" href="../css/windows.css">
	</head> 
	<frameset name="frame1" cols="30,70" frameborder="no" border="0" framespacing="0">
	  <frame src="orgTree1.jsp?roleId=<%=roleId%>" name="orgTree" id="orgTree" />
	  <frame src="roleconferorg_ajax.jsp?roleId=<%=roleId%>" name="orgList" scrolling="No" noresize="noresize" id="orgList" />
	</frameset>
	<noframes>
		<%@ include file="/epp/css/cssControl.jsp"%><body >
		</body>
	</noframes>
</html>

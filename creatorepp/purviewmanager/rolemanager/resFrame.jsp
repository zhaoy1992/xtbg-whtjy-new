<%
/*
 * <p>Title: Ȩ��������ҳ��</p>
 * <p>Description: Ȩ��������ҳ��</p>
 * <p>Copyright: Copyright (c) 2008</p>
 * <p>Company: chinacreator</p>
 * @Date 2008-3-19
 * @author liangbing.tao
 * @version 1.0
 */
%>

<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.security.AccessControl,
				com.chinacreator.sysmgrcore.manager.*,
				com.chinacreator.sysmgrcore.entity.Role,
				com.chinacreator.sysmgrcore.manager.SecurityDatabase"
			%>


<%			
			AccessControl control = AccessControl.getInstance();
			control.checkManagerAccess(request,response);
			String roleId = request.getParameter("roleId");

			RoleManager roleManager = SecurityDatabase.getRoleManager();
			Role role = roleManager.getRoleById(roleId);
			String rolename = role.getRoleName();
%>

<html>
	<head>
		<title>:::::��ɫ(<%=rolename%>)Ȩ������</title>
		<link rel="stylesheet" type="text/css" href="../css/treeview.css">
		<link rel="stylesheet" type="text/css" href="../css/windows.css">
	</head>
	<frameset name="frame1" cols="30,70" frameborder="no" border="0" framespacing="0">
		<frame src="resdefault.jsp?roleId=<%=roleId%>" name="orgTree" id="orgTree" />
		<frame src="operdefault.jsp" 
					name="operList" scrolling="No" noresize="noresize" id="orgList"/>
	</frameset>
	<noframes>
		<%@ include file="/epp/css/cssControl.jsp"%><body >
		</body>
	</noframes>
</html>

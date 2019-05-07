<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.RoleManager"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>
<%@ page import="com.chinacreator.sysmgrcore.entity.Role"%>

<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkManagerAccess(request,response);
	
	String roleId = request.getParameter("roleId");
	RoleManager roleManager = SecurityDatabase.getRoleManager();
	Role role = roleManager.getRoleById(roleId);
	String roleName = role.getRoleName();
%>

<HTML>
 <HEAD>
   <title>角色[<%=roleName%>]资源权限查询</title>
 </HEAD>
  <frameset rows="30,*" border=0>
	<frame frameborder=0  noResize scrolling="no" marginWidth=0 name="forQuery" src="roleres_query.jsp?roleId=<%=roleId%>"></frame>		
	<frame frameborder=0  noResize scrolling="auto" marginWidth=0 name="forDocList" src="roleres_querylist.jsp?roleId=<%=roleId%>"></frame>
	</frameset>	
</HTML>
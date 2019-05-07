<%
/**
 * 
 * <p>Title: 用户自定义资源frame页面</p>
 *
 * <p>Description: 用户自定义资源frame页面，右边显示自定义资源树，右边显示明细</p>
 *
 * <p>Copyright: Copyright (c) 2007</p>
 *
 * <p>Company: chinacreator</p>
 * @Date 2006-9-15
 * @author gao.tang
 * @version 1.0
 */
 %>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase" %>
<%@ page import="com.chinacreator.sysmgrcore.manager.UserManager" %>
<%@ page import="com.chinacreator.sysmgrcore.entity.User" %>
<%@page import="com.frameworkset.common.poolman.DBUtil,
				com.chinacreator.security.AccessControl" %>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkManagerAccess(request,response);
	String currRoleId = request.getParameter("currRoleId");
	String currOrgId = request.getParameter("currOrgId");
	String role_type = request.getParameter("role_type");
	
%>
<html>
<frameset name="dictFrame" cols="30,70" frameborder="no" border="0" framespacing="0" >
  	<frame src="resoucesetTree.jsp?resTypeId=rescustom&currRoleId=<%=currRoleId%>&currOrgId=<%=currOrgId%>&role_type=<%=role_type%>" name="globalOperList" id="globalOperList" scrolling="No" noresize="noresize" />
  	<frame src="operdefault.jsp" name="operList" scrolling="No" noresize="noresize" id="orgList" />
</frameset>
<noframes>
<%@ include file="/epp/css/cssControl.jsp"%><body >
</body>
</noframes>
</html>
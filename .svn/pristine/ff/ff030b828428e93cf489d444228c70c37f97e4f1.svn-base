
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase" %>
<%@ page import="com.chinacreator.sysmgrcore.manager.UserManager" %>
<%@ page import="com.chinacreator.sysmgrcore.entity.User" %>
<%@page import="com.frameworkset.common.poolman.DBUtil"%>

<%
	String currRoleId = request.getParameter("currRoleId");
	String currOrgId = request.getParameter("currOrgId");
	String role_type = request.getParameter("role_type");
	String resTypeId = request.getParameter("resTypeId");
	
%>
<html>
<frameset name="siteFrame" cols="30,70" frameborder="no" border="0" framespacing="0" >
  	<frame src="channelSetTree.jsp?resTypeId=<%=resTypeId%>&currRoleId=<%=currRoleId%>&currOrgId=<%=currOrgId%>&role_type=<%=role_type%>" name="globalOperList" id="globalOperList" scrolling="auto"/>
  	<frame src="operdefault.jsp" name="operList" scrolling="auto"  id="orgList" />
</frameset>
<noframes>
<%@ include file="/epp/css/cssControl.jsp"%><body >
</body>
</noframes>
</html>
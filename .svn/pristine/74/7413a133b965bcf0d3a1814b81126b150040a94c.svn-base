

<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@page import="com.chinacreator.security.AccessControl"%>

<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkManagerAccess(request,response);
	
	String orgId = request.getParameter("orgId");
	
	String siteUrl = "../../grantmanager/siteTree.jsp?resTypeId=template&currRoleId="+orgId+"&currOrgId="+orgId+"&role_type=organization";

%>
<html>
<frameset name="templateFrame" cols="30,70" frameborder="no" border="0" framespacing="0" >
  	<frame src="<%=siteUrl%>" name="globalOperList" id="globalOperList" scrolling="No" noresize="noresize" />
  	<frame src="operdefault.jsp" name="operList" scrolling="No" noresize="noresize" id="orgList" />
</frameset>
<noframes>
<%@ include file="/epp/css/cssControl.jsp"%><body >
</body>
</noframes>
</html>
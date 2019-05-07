<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request, response);	
	
	String app_id = request.getParameter("app_id");
	
	String app_type = request.getParameter("app_type");
	
	String path = request.getContextPath()+"/sysmanager/applymanager/applywork/showapplylogo.jsp?app_id="+app_id+"&&app_type="+app_type;
%>
<html>
<head>
<title>Ó¦ÓÃ²Ù×÷</title>
</head>
<%@ include file="/epp/css/cssControl.jsp"%><body>
<iframe src=<%=path%> width=" 100%" height="100%"></iframe>
</body>
</html>

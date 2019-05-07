<%@page contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.frameworkset.util.StringUtil"%>
<%
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request, response);
 %>
<html>
	<head>
		<title>用户调动</title>
	</head>
	<%@ include file="/epp/css/cssControl.jsp"%>
	<body>
		<iframe id="menuissuemain" src="<%=request.getContextPath() %>/purviewmanager/userorgmanager/org/usercheckorg/userCheckInOrgBySecondEndUser.jsp" width="100%" height="100%" frameborder="0" scrolling="no"></iframe>
	</body>
</html>

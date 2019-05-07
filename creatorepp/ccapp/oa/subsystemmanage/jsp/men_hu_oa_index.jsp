<%--
描述：???的代办列表
作者：邹拓
版本：1.0
日期：2013-11-28
--%>
<%@page contentType="text/html; charset=utf-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%
AccessControl accesscontroler = AccessControl.getInstance();
String userName = StringUtil.deNull(request.getParameter("userName"));
String password = StringUtil.deNull(request.getParameter("password"));
accesscontroler.login(request,response,userName,password);
String path = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<script>
window.onload=function(){
	window.location.href="<%=path%>/oaindex.jsp";
};
</script>
</head>
<body>
</body>
</html>
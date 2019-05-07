<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%
AccessControl accesscontroler = AccessControl.getInstance();
accesscontroler.checkAccess(request, response);
	String path = request.getContextPath();
	String loginUserID = accesscontroler.getUserID();
%>
<%@page import="com.chinacreator.security.AccessControl"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>公共通讯录权限管理</title>

<!-- 引入jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>

<script type="text/javascript">
function getTempValue(url){
	$("#ifbook").attr("src",url);
}
</script>
</head>
<body style="overflow-y: hidden;">

<table width="100%" cellpadding="0" cellspacing="0" border="0">

<tr>
<td width="200px">
<iframe src="../../tree/jsp/orgtree4publicaddressbookroleruser.jsp" scrolling="no" width="220px" height="680" frameborder="0"></iframe>
</td>

<td>
<iframe id="ifbook" src="publicaddressbook4roleuser.jsp" scrolling="no" width="100%" height="680" frameborder="0"></iframe>
</td>
</tr>

</table>

</body>
</html>
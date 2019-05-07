<%-- 
描述：用户组管理主页面
作者：肖杰
版本：1.0
日期：2013-08-01
 --%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%
AccessControl accesscontroler = AccessControl.getInstance();
accesscontroler.checkAccess(request, response);
%>
<%@page import="com.chinacreator.security.AccessControl"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>用户组管理</title>

<!-- 引入jQuery -->
<script type="text/javascript" src="../../resources/plug/jquery1.7/jquery-1.7.1.min.js"></script>

<script type="text/javascript">
function getTempValue(url){
	$("#ifuserlist").attr("src",url);
}
function getGroupValue(url){
	$("#ifgrouptree").attr("src",url);
}
</script>
</head>
<body style="overflow-y: hidden;">
	<table width="100%" cellpadding="0" cellspacing="0" border="0">
		<tr>
			<td width="200px">
				<iframe id="ifgrouptree" src="grouptree.jsp" scrolling="no" width="220px" height="900" frameborder="0"></iframe>
			</td>
			<td>
				<iframe id="ifuserlist" src="grouplist.jsp" scrolling="no" width="100%" height="900" frameborder="0"></iframe>
			</td>
		</tr>
	</table>
</body>
</html>
<%-- 
描述：机构和用户管理主页面
作者：黄艺平
版本：1.0
日期：2013-04-24
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
<title>机构和用户管理主页面</title>

<!-- 引入jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery1.7/jquery-1.7.1.min.js"></script>

<script type="text/javascript">
function getTempValue(url){
	$("#ifuserlist").attr("src",url);
}
</script>
</head>
<body style="overflow-y: hidden;">
	<table width="100%" cellpadding="0" cellspacing="0" border="0">
		<tr>
			<td width="200px">
				<iframe src="org_tree.jsp" scrolling="no" width="220px" height="550" frameborder="0"></iframe>
			</td>
			<td>
				<iframe id="ifuserlist" src="org_userlist.jsp" scrolling="no" width="100%" height="550px" frameborder="0"></iframe>
			</td>
		</tr>
	</table>
</body>
</html>
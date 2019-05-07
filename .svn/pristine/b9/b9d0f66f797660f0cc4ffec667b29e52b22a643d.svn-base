
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="org.python.modules.re"%>
<%
AccessControl accesscontroler = AccessControl.getInstance();
accesscontroler.checkAccess(request, response);

String classify = request.getParameter("classify");
String type = request.getParameter("type");
%>
<%@page import="com.chinacreator.security.AccessControl"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>固定资产类别查看主页面</title>

<!-- 引入jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery1.7/jquery-1.7.1.min.js"></script>

<script type="text/javascript">
function getTempValue(url){
	$("#list").attr("src",url);
}
function setLeftIframeSrc(url){
	$("#tree").attr("src",url);
}
</script>
</head>
<body style="overflow-y: hidden;">
	<table width="100%" cellpadding="0" cellspacing="0" border="0">
		<tr>
			<td width="200px">
				<iframe id="tree" src="accounttypetree.jsp?type=<%=type %>" scrolling="no" width="220px" height="550" frameborder="0"></iframe>
			</td>
			<td>
				<iframe id="list" src="accountlist.jsp?classify=<%=classify %>" scrolling="no" width="100%" height="550px" frameborder="0"></iframe>
			</td>
		</tr>
	</table>
</body>
</html>
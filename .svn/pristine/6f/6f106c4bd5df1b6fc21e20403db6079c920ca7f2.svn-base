<%--
	描述：数据字典
	作者：肖杰
	版本：1.0
	日期：2013-7-23
--%>
<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@page import="com.chinacreator.security.AccessControl"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
	String path = request.getContextPath();
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);

%>
<title>数据字典</title>
<style type="text/css">
HTML{overflow: hidden;}
</style>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script type="text/javascript">

function getTempValue(url){
	$("#dict").attr("src",url);
}
</script>
</head>
<body style="overflow-y: hidden;">
	<table width="100%">
		<tr>
			<td width="200px">
				<iframe id="dicttypetree" name="dicttypetree" src="dicttypetree.jsp" scrolling="no" width="220px" height="450" style="padding:0px;margin-top: 20px;" frameborder="0"></iframe>
			</td>
			<td>
				<iframe id="dict" src="dictdataviewmain.jsp" scrolling="no" width="100%" height="450" frameborder="0"></iframe>
			</td>
		</tr>
	</table>
</body>
</html>
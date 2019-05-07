<%--
	描述：人员档案管理
	作者：戴连春
	版本：1.0
	日期：2013-5-27
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

	String readonly = request.getParameter("readonly");	//是否只读，1：只读，0：可编辑
%>
<title>JGRID</title>
<style type="text/css">
HTML{overflow: hidden;}
</style>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script type="text/javascript">

function getTempValue(url){
	$("#ifdirectory").attr("src",url);
}
</script>
</head>
<body style="overflow-y: hidden;">
	<table width="100%">
		<tr>
			<td width="200px">
				<iframe src="directoryseeztree.jsp?readonly=<%=readonly%>" scrolling="no" width="220px" height="680" style="padding:0px;" frameborder="0"></iframe>
			</td>
			<td class="td_tree_border_c3d0de">
				<iframe id="ifdirectory" src="directoryseelist.jsp?readonly=<%=readonly%>" scrolling="no" width="100%" height="680" frameborder="0"></iframe>
			</td>
		</tr>
	</table>
</body>
</html>
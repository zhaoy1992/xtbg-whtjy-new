<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.pub.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.pub.directory.dao.DirectoryDao"%>
<%@page import="com.chinacreator.xtbg.pub.util.DaoImplClassUtil"%>
<%@page import="java.util.List"%>
<%@page import="com.chinacreator.xtbg.pub.directory.entity.ListShowUtilBean"%><html xmlns="http://www.w3.org/1999/xhtml">
<head>
<style type="text/css">
HTML{overflow: hidden;}
</style>
<%
	String path = request.getContextPath();
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);

	String orgid = StringUtil.deNull(request.getParameter("orgid"));
	DirectoryDao directoryDao = (DirectoryDao)DaoImplClassUtil.getDaoImplClass("directoryDaoImpl");
	List<ListShowUtilBean> firstCodeList = directoryDao.getFirstCodeShowInfo(orgid);
%>
<title>JGRID</title>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<%
AccessControl accesscontrolerAccessControl = AccessControl.getAccessControl();
accesscontroler.checkAccess(request, response);
String org_id = request.getParameter("orgid");
%>
<script type="text/javascript">
function getTempValue(url){
	//alert(url)
	$("#ifdirectory").attr("src",url);
}

</script>
</head>
<body style="overflow-y: hidden;">
<table width="100%">
<tr>

<td width="200px">
<iframe src="directoryztree.jsp?orgid=<%=org_id %>" scrolling="yes" width="220px" height="600px" frameborder="0"></iframe>
</td>

<td>
<iframe id="ifdirectory" src="directorylist.jsp?orgid=<%=org_id %>" scrolling="yes" width="100%" height="600px" frameborder="0"></iframe>
</td>

</tr>
</table>

</body>
</html>
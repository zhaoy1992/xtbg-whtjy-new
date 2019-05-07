<%-- 
描述：单位接收人处理
作者：黄艺平
版本：1.0
日期：2013-07-15
 --%>
<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="java.util.List"%>

<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
	String path = request.getContextPath();
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	String orgid = StringUtil.deNull(request.getParameter("orgid"));
%>
<title>JGRID</title>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script type="text/javascript">
$(function(){
	$("iframe").attr("style","height:"+($(window).height()*1-7)+"px;");
})

function getTempValue(url){
	$("#ifdirectory").attr("src",url);
}
</script>
</head>
<body >
<table >
<tr >
<td width="10%">
<iframe src="orgtree.jsp" scrolling="no"  frameborder="0"></iframe>
</td>
<td width="90%"><iframe id="ifdirectory" src="orgresonconfig.jsp"  width="100%" height="100%" frameborder="0"></iframe></td>
</tr>
</table>
</body>
</html>
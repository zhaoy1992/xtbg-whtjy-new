<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base>

    <title></title>

	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
  </head>
<%
String name = request.getParameter("name");
String rname = request.getParameter("rname");
String raq = request.getParameter("raq");
out.print(raq);
 %>
  <body>
   <iframe src="showJasperReport_swf.jsp?raq=<%=raq %>&name=<%=name %>&rname=<%=rname %>" width="100%" height="100%" frameborder="0">
   </iframe>
  </body>
</html>

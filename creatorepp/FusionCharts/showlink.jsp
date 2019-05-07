<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String url = request.getParameter("dataurl");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title><%=url %></title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
  </head>
   <iframe width="100%" height="92%" src="<%=url %>" frameborder="no" border="0" marginwidth="0" marginheight="0">
   
   </iframe>
   <div align="center"><input type="button" value="   ¹Ø±Õ   " onclick="javascript:window.close();"/></div>
</html>

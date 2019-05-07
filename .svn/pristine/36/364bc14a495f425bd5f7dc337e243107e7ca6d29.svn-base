<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<%@ page import="com.chinacreator.security.AccessControl,org.apache.commons.lang.StringUtils"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>报表树</title>
</head>
<%
String showmode = StringUtils.defaultString(request.getParameter("showmode"));
%>
<frameset rows="*" cols="30%,70%" framespacing="0" frameborder="no" border="0">
  <frame src="eformClassTab.jsp?showmode=<%=showmode %>" name="leftFrame" noresize="noresize" id="leftFrame" title="leftFrame" />
  <frame src="report_show.jsp?showmode=<%=showmode %>" name="mainFrame" id="mainFrame" title="mainFrame" />
</frameset>
<noframes><body>
</body>
</noframes>
</html>

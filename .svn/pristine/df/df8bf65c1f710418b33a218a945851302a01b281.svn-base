<%@ page language="java" contentType="text/html; charset=gb2312"%>
<%@ page
	import="com.chinacreator.security.AccessControl"%>
<%
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request, response);	
	String iconpath = request.getParameter("iconpath");
%>
<frameset>
	<frame name="body" src="itemconfigicon.jsp?iconpath=<%=iconpath %>" frameborder="0" framespacing="0" scrolling="yes" noresize>
</frameset>

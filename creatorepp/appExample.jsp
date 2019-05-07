<%@page contentType="text/html; charset=GBK"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request,response);	
%><font style="font-size:12px; line-height:150% ">&nbsp;&nbsp;&nbsp;&nbsp;欢迎您！
这里是第一个应用的首页。
应用的名字是：<%=control.getCurrentSystemName().toString()%>。
应用的ID是：<%=control.getCurrentSystemID().toString()%>。</font>
<center>
<div style="margin-top:50px"><img src="sysmanager/images/main.jpg"></div>
</center>

<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="com.frameworkset.util.StringUtil"%>
<%@page import="com.SynPortalUser"%>
<%
	
	String isSyn = StringUtil.replaceNull(request.getParameter("isSyn"),"");
	
	if("true".equals(isSyn)){
		SynPortalUser.addUser();
	}

%>
<html>
<head><title></title></head>

<%@ include file="/epp/css/cssControl.jsp"%><body >

<form action="initportaluser.jsp" method="post">
<input type="hidden" name="isSyn" value="true" >
<table>
<tr><td><input type="submit" class="input" value="初始化同步portal用户数据库" >
</td></tr>
</table>
</form>

</body>

</html>
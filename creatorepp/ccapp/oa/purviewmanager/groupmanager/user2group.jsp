<%
/*
 * <p>Title: 用户隶属组界面</p>
 * <p>Description: 用户隶属组界面</p>
 * <p>Copyright: Copyright (c) 2008</p>
 * <p>Company: chinacreator</p>
 * @Date 2008-3-18
 * @author liangbing.tao
 * @version 1.0
 */
%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%
AccessControl accesscontroler = AccessControl.getInstance();
accesscontroler.checkAccess(request, response);
String userId=request.getParameter("userId");  
String orgId=request.getParameter("orgId"); 
String subid=request.getParameter("subid");
System.out.println(orgId+"---"+userId);
%>
<%@page import="com.chinacreator.security.AccessControl"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>用户组管理</title>

<!-- 引入jQuery -->
<script type="text/javascript" src="../../resources/plug/jquery1.7/jquery-1.7.1.min.js"></script>

<script type="text/javascript">
function getTempValue(url){
	$("#ifuserlist").attr("src",url);
}

</script>
</head>
<body style="overflow-y: hidden;">
	<table width="100%" cellpadding="0" cellspacing="0" border="0">
		<tr>
			<td width="200px">
				<iframe id="ifgrouptree" src="showgrouptree.jsp?subid=<%=subid %>&userId=<%=userId%>&orgId=<%=orgId%>" scrolling="no" width="220px" height="900" frameborder="0"></iframe>
			</td>
			<td>
				<iframe id="ifuserlist" src="nogroup.jsp" scrolling="no" width="100%" height="900" frameborder="0"></iframe>
			</td>
		</tr>
	</table>
</body>
</html>
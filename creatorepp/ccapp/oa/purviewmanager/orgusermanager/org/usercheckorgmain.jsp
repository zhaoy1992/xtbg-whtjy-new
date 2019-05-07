<%@page contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.frameworkset.util.StringUtil"%>
<%
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request, response);
	
	String userID = StringUtil.replaceNull(request.getParameter("checkBoxOne"),"");
	String orgID = StringUtil.replaceNull(request.getParameter("orgId"),"");
 %>
<html>
	<head>
		<title>用户调动</title>
	</head>
	<%@ include file="/epp/css/cssControl.jsp"%>
	<body>
		<% if(control.isAdmin()){ %>
			<iframe id="menuissuemain" src="usercheckorgselect.jsp?userID=<%=userID %>&&orgID=<%=orgID %>" width="100%" height="100%" frameborder="0" scrolling="no"></iframe>
		<%}else{ %>
		<table width="100%" border="0">
  			<tr>
    			<td align="center" nowrap="nowrap" style="color: #FF0000;">
    			<br /><br /><br /><br /><br /><br /><br /><br /><br /><br />
    			对不起！权限不够，请用系统管理员身份登录！
    			<br /><br />
	    			<input type="button" class="input" value="关闭窗口" onclick="window.close();"> 
    			</td>
  			</tr>
		</table>
		<%} %>
	</body>
</html>

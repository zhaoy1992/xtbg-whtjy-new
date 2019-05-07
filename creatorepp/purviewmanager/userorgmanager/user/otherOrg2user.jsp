<%@ include file="../../../sysmanager/include/global1.jsp"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="../../../sysmanager/base/scripts/panes.jsp"%>
<%@ page import="com.chinacreator.sysmgrcore.web.struts.form.UserOrgManagerForm" %>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase" %>
<%@ page import="com.chinacreator.sysmgrcore.manager.UserManager" %>
<%@ page import="com.chinacreator.sysmgrcore.entity.User" %>
<%@page import="com.frameworkset.common.poolman.DBUtil"%>

<%@ page import="com.chinacreator.security.AccessControl" %>
<%
	AccessControl control = AccessControl.getInstance();
	control.checkManagerAccess(request,response);
	String userId = request.getParameter("userId");
	String orgId = request.getParameter("orgId");
	UserManager userManager = SecurityDatabase.getUserManager();
	User user = userManager.getUserById(userId);	
	String userName = user.getUserRealname();
%>

<html>
<head>
<title>用户【<%=userName%>】权限复制</title>
<link rel="stylesheet" type="text/css" href="../../../sysmanager/css/treeview.css">
<link rel="stylesheet" type="text/css" href="../../../sysmanager/css/windows.css">

</head> 
<frameset  name="userId" value="<%=userId%>" cols="30,70,0" frameborder="no" border="0" framespacing="0" >
  <frame src="otherOrgTreecopy.jsp?userId=<%=userId%>&orgId=<%=orgId%>" name="orgTree" id="orgTree" />
  <frame src="noOrg.jsp" name="userList" scrolling="No" noresize="noresize" id="orgList" />
  <frame src="#" name="orgId" value="<%=orgId%>" />
</frameset>

<noframes>
<%@ include file="/epp/css/cssControl.jsp"%><body >
</body>
</noframes>
</html>

<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="../../sysmanager/base/scripts/panes.jsp"%>
<%@ page import="com.chinacreator.security.AccessControl,com.chinacreator.sysmgrcore.manager.*,
com.chinacreator.sysmgrcore.entity.Organization,com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>
<%

	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request,response);	
	String orgId = request.getParameter("orgId");
	
	OrgManager orgManager = SecurityDatabase.getOrgManager();
	Organization org = orgManager.getOrgById(orgId);
	String orgName = org.getOrgName();
%>
<html>
<head>
<title>:::::����(<%=orgName%>)Ȩ������</title>
<link rel="stylesheet" type="text/css" href="../../sysmanager/css/treeview.css">
<link rel="stylesheet" type="text/css" href="../../sysmanager/css/windows.css">

</head> 
<frameset name="frame1" cols="30,70" frameborder="no" border="0" framespacing="0" >
  <frame src="orgResdefault.jsp?orgId=<%=orgId%>" name="orgTree" id="orgTree" />
  <frame src="../../sysmanager/accessmanager/role/operdefault.jsp" name="operList" scrolling="No" noresize="noresize" id="orgList" />
</frameset>
<noframes>
<body>
</body>
</noframes>
</html>

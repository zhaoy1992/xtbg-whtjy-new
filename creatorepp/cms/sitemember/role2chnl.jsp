<%@ include file="../../sysmanager/include/global1.jsp"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="../../sysmanager/base/scripts/panes.jsp"%>
<%@ page import="com.chinacreator.sysmgrcore.web.struts.form.UserOrgManagerForm" %>
<html>
<head>
<title>ϵͳ����</title>
<link rel="stylesheet" type="text/css" href="../../sysmanager/css/treeview.css">
<link rel="stylesheet" type="text/css" href="../../sysmanager/css/windows.css">
<%
	String roleId = request.getParameter("roleId");
	session.setAttribute("roleTabId","3");
	session.setAttribute("currRoleId",roleId);
	session.setAttribute("role_type","role");
	UserOrgManagerForm s = (UserOrgManagerForm)request.getAttribute("userOrgForm");	
	String oid = "";
	String uid = "";
	if(s != null){
    	oid =  s.getOrgId();
    	uid = s.getUserId();
    }   
   
   
  
%>
</head> 
<frameset name="frame1" cols="30,70" frameborder="no" border="0" framespacing="0" oid="<%=oid%>" uid="<%=uid%>">
  <frame src="../sitemember/resChannelTree.jsp?resTypeId=channel" name="orgTree" id="orgTree" />
  <frame src="../../sysmanager/accessmanager/role/operdefault.jsp" name="userList" scrolling="No" noresize="noresize" id="orgList" />
</frameset>
<noframes>
<body>
</body>
</noframes>
</html>

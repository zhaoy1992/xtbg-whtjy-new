<%@ include file="../../include/global1.jsp"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="../../base/scripts/panes.jsp"%>
<%@ page import="com.chinacreator.sysmgrcore.web.struts.form.UserOrgManagerForm" %>
<html>
<head>
<title>系统管理</title>
<link rel="stylesheet" type="text/css" href="../../css/treeview.css">
<link rel="stylesheet" type="text/css" href="../../css/windows.css">
<%
	String roleId=request.getParameter("roleId");
	UserOrgManagerForm s = (UserOrgManagerForm)request.getAttribute("userOrgForm");	
	String oid = "";
	String uid = "";
	if(s != null){
    	oid =  s.getOrgId();
    	uid = s.getUserId();
    }   
    session.setAttribute("roleTabId", "6"); 
      
%>
</head> 
<frameset name="frame1" cols="30,70" frameborder="no" border="0" framespacing="0" oid="<%=oid%>" uid="<%=uid%>">
  <frame src="orgTree1.jsp?roleId=<%=roleId%>" name="orgTree" id="orgTree" />
  <frame src="roleconferorg_ajax.jsp" name="orgList" scrolling="No" noresize="noresize" id="orgList" />
</frameset>
<noframes>
<%@ include file="/epp/css/cssControl.jsp"%><body >
</body>
</noframes>
</html>

<%@ include file="../include/global1.jsp"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="../base/scripts/panes.jsp"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase" %>
<%@ page import="com.chinacreator.sysmgrcore.manager.UserManager" %>
<%@ page import="com.chinacreator.sysmgrcore.entity.User" %>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	String did = request.getParameter("did");
%>
	
<html>
	<head>
	<title>数据字典数据项</title>
	<link rel="stylesheet" type="text/css" href="../css/treeview.css">
	<link rel="stylesheet" type="text/css" href="../css/windows.css">
	
	</head> 
	<frameset name="dictdata"  cols="25,75" frameborder="no" border="0" framespacing="0" >
	  <frame src="dictdataTree.jsp?did=<%=did%>" name="dictdataTree" id="dictdataTree" />
	  <frame src="newDictdata.jsp?did=<%=did%>" name="newDictdata" scrolling="yes" noresize="noresize" id="newDictdata" />
	</frameset>
	<noframes>
	<%@ include file="/epp/css/cssControl.jsp"%><body >
	</body>
	</noframes>
</html>


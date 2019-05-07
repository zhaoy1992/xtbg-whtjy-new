<%@ include file="../include/global1.jsp"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="../base/scripts/panes.jsp"%>
<%@ page import="com.chinacreator.sysmgrcore.web.struts.form.UserOrgManagerForm" %>
<%
	String displayNameInput=request.getParameter("displayNameInput");
	String displayValueInput=request.getParameter("displayValueInput");
	String userNames = request.getParameter("userNames")==null?"":request.getParameter("userNames");
	
%>
<html>
<head>
<title>—°‘Ò»À</title>
<link rel="stylesheet" type="text/css" href="../css/treeview.css">
<link rel="stylesheet" type="text/css" href="../css/windows.css">

</head> 
<frameset name="frame1" cols="0,30,70" frameborder="no" border="0" framespacing="0" >
  <frame src="frame_bridge.jsp" name="frame_bridge" scrolling="No" noresize="noresize" id="frame_bridge" />
  <frame src="orgTree.jsp" name="orgTree" id="orgTree" />
  <frame src="userList.jsp?displayNameInput=<%=displayNameInput%>&displayValueInput=<%=displayValueInput%>&userNames=<%=userNames%>" name="userList" scrolling="No" noresize="noresize" id="userList" />  
</frameset>
<noframes>
<%@ include file="/epp/css/cssControl.jsp"%><body >
</body>
</noframes>
</html>

<%@ include file="../include/global1.jsp"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="../base/scripts/panes.jsp"%>
<html>
<head>
<title>主管机构处室</title>
<link rel="stylesheet" type="text/css" href="../css/treeview.css">
<link rel="stylesheet" type="text/css" href="../css/windows.css">
<%
		String orgId = request.getParameter("orgId");
		
  
%>
</head> 
<frameset name="frame1" cols="30,70" frameborder="no" border="0" framespacing="0" >
  <frame src="resOrgJobTree.jsp?orgId=<%=orgId%>" name="orgTree" id="orgTree" />
  <frame src="nocharge.jsp" name="userList" scrolling="No" noresize="noresize" id="orgList" />
</frameset>
<noframes>
<%@ include file="/epp/css/cssControl.jsp"%><body >
</body>
</noframes>
</html>

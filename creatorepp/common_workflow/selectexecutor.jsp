<%@ include file="/sysmanager/include/global1.jsp"%>
<%@ include file="/sysmanager/base/scripts/panes.jsp"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%
	String displayNameInput=request.getParameter("displayNameInput");
	String displayValueInput=request.getParameter("displayValueInput");
%> 
<html>  
<head>
<title>—°‘Ò»À</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/sysmanager/css/windows.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/sysmanager/css/contentpage.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/sysmanager/css/tab.winclassic.css">

</head> 
<frameset name="frame1" cols="0,30,70" frameborder="no" border="0" framespacing="0" >
  <frame src="frame_bridge.jsp" name="frame_bridge" scrolling="No" noresize="noresize" id="frame_bridge" />
  <frame src="orgTree.jsp" name="orgTree" id="orgTree" />
  <frame src="userList.jsp?displayNameInput=<%=displayNameInput%>&displayValueInput=<%=displayValueInput%>" name="userList" scrolling="No" noresize="noresize" id="userList" />  
</frameset>
<noframes>
<%@ include file="/epp/css/cssControl.jsp"%><body>
</body>
</noframes>
</html>

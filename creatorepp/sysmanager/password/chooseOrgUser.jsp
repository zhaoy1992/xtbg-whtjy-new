<%@ include file="../include/global1.jsp"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="../base/scripts/panes.jsp"%>
<html>
<head>
<title>选择机构下的用户</title>
<link rel="stylesheet" type="text/css" href="../css/treeview.css">
<link rel="stylesheet" type="text/css" href="../css/windows.css">

</head> 
<frameset name="urFrame" value="" cols="200,*" border="1" framespacing="2" >
	<frame src="orgTree.jsp" name="orgTree" id="orgTree" marginWidth=0 marginHeight=0 />
	<!-- frame src="sreachUser.jsp" name="sreachUser" id="sreachUser" marginWidth=0 marginHeight=0/-->
	<frame src="userList.jsp" name="userList" id="userList" marginWidth=0 marginHeight=0 />
</frameset>
<noframes>
<%@ include file="/epp/css/cssControl.jsp"%><body >
</body>
</noframes>
</html>

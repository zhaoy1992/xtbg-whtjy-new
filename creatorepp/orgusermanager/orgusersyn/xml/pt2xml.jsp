
<%@ page contentType="text/html; charset=GBK" language="java"%>
<%@ page import="com.chinacreator.security.*"%>
<%AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
%>
<html>
	<head>
		<link rel="stylesheet" type="text/css" href="../../css/windows.css">
		<link rel="stylesheet" type="text/css" href="../../css/treeview.css">
		<title>组织机构管理</title>
	</head>
		<frameset name="userOrgFrame" cols="25%,*" border=0 framespacing="0">
			<frame frameborder=1 scrolling="yes" name="org_tree" src="pt_tree.jsp" marginWidth=0 marginHeight=0 >
			</frame>
			<frame frameborder=0 scrolling="yes" name="ptuser_list" src="ptuser_list.jsp" marginWidth=0 marginHeight=0 >
			</frame>
		</frameset>
</html>

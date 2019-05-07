
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="../../sysmanager/base/scripts/panes.jsp"%>
<%@ page import="com.chinacreator.security.AccessControl,com.chinacreator.sysmgrcore.manager.*,
com.chinacreator.sysmgrcore.entity.User,com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>
<%

	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request,response);
%>
<html>
<head>
<title>:::::CMS菜单权限设置</title>
<link rel="stylesheet" type="text/css" href="/sysmanager/css/treeview.css">
<link rel="stylesheet" type="text/css" href="/sysmanager/css/windows.css">

</head> 
<frameset name="frame1" cols="30,70" frameborder="no" border="0" framespacing="0" >
  <frame src="resColumnCmsTree.jsp" name="menuTree" id="menuTree" />
  <frame src="default_right.jsp" name="menuList" scrolling="No" noresize="noresize" id="orgList" />
</frameset>
<noframes>
<%@ include file="/epp/css/cssControl.jsp"%><body >
</body>
</noframes>
</html>

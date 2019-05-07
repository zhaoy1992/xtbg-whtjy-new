<%@ include file="../include/global1.jsp"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="../base/scripts/panes.jsp"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg" %>
<html>
  <head> 
  <title>属性容器</title>
    <script language="JavaScript" src="../scripts/common.js" type="text/javascript"></script>
    <link rel="stylesheet" type="text/css" href="../css/windows.css">
	<link rel="stylesheet" type="text/css" href="../css/contentpage.css">
	<link rel="stylesheet" type="text/css" href="../css/tab.winclassic.css">
	<link rel="stylesheet" type="text/css" href="../sysmanager/css/windows.css">
	<link rel="stylesheet" type="text/css" href="../sysmanager/css/contentpage.css">
	<link rel="stylesheet" type="text/css" href="../sysmanager/css/tab.winclassic.css">
 </head>
  <script language="JavaScript">
  	alert("操作失败，请联系系统管理员！");
  	getPropertiesContent().location.href ="<%=rootpath%>/sysmanager/orgmanager/organsearch.jsp";
	getNavigatorContent().location.href ="<%=rootpath%>/sysmanager/orgmanager/navigator_content.jsp?anchor=0&expand=0&request_scope=session";
  </script>
 </html>
<%@ include file="../../include/global1.jsp"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%
    AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkManagerAccess(request,response);
    
%>
<html>
<head>
<title></title>

<link rel="stylesheet" type="text/css" href="../../css/treeview.css">
<link rel="stylesheet" type="text/css" href="../../css/windows.css">
<link rel="stylesheet" type="text/css" href="../../css/contentpage.css">
<link rel="stylesheet" type="text/css" href="../../css/tab.winclassic.css">

</head>
	<%@ include file="/epp/css/cssControl.jsp"%><body  class="contentbodymargin" scroll="yes">	
	    <br>
	    <p align="center"><strong><--ÇëÑ¡Ôñ×ÖµäÀàÐÍ</strong></p>
	
	</body>
</html>
<%@ page language="java" contentType="text/html;charset=GBK"%>
<%@ taglib prefix="tab" uri="/WEB-INF/tabpane-taglib.tld" %>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@page import="com.chinacreator.security.AccessControl"%>

<%
	AccessControl accesscontroler = AccessControl.getInstance();
    accesscontroler.checkManagerAccess(request, response); 
%>
<html >    
	<head>
		<title>属性容器</title>
		<link rel="stylesheet" type="text/css" href="../css/windows.css">
		<link rel="stylesheet" type="text/css" href="../css/contentpage.css">
		<link rel="stylesheet" type="text/css" href="../css/tab.winclassic.css">
		<link rel="stylesheet" type="text/css" href="../sysmanager/css/windows.css">
		<link rel="stylesheet" type="text/css" href="../sysmanager/css/contentpage.css">
		<link rel="stylesheet" type="text/css" href="../sysmanager/css/tab.winclassic.css">
		<tab:tabConfig/>		
	</head>
	<%@ include file="/epp/css/cssControl.jsp"%><body >
		<tab:tabContainer id="resquery-container" selectedTabPaneId="resQuery" >
			<tab:tabPane id="resQuery" tabTitle="普通资源查询" >
				<tab:iframe id="res_queryframe" src="res_queryframe.jsp" frameborder="0" width="100%" height="550"/>
			</tab:tabPane>
			<tab:tabPane id="special-resQuery" tabTitle="特殊资源查询" lazeload="true" >
				 <tab:iframe id="special_Frame" src="special_Frame.jsp" name="specialRes"  width="100%" height="550" frameborder="0" style="display:inline" />				
			</tab:tabPane>
			
			<tab:tabPane id="special-farresQuery" tabTitle="资源授予情况查询" lazeload="true" >
				 <tab:iframe id="res_farqueryframe" src="far-outerquery/res_queryframe.jsp" name="specialRes"  width="100%" height="550" frameborder="0" style="display:inline" />				
			</tab:tabPane>
	
			
		</tab:tabContainer>
	</body>
</html>

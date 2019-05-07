<%@ page language="java" import="org.apache.commons.lang.StringUtils" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ taglib uri="/WEB-INF/treetag.tld" prefix="tree"%>
<%@ include file="../../sysmanager/include/global1.jsp"%>
<%@ include file="../../sysmanager/base/scripts/panes.jsp"%>
<%
String userid = StringUtils.defaultString(request.getParameter("userid"));
String orgid = StringUtils.defaultString(request.getParameter("orgid"));
String showmode = StringUtils.defaultString(request.getParameter("showmode"));
 %>
<head>
	<title></title>
	<style type="text/css">
<!--
.style1 {color: #CC0000}
-->
</style>
	<link href="/sysmanager/css/windows.css" rel="stylesheet" type="text/css">
	<link href="/sysmanager/css/tab.winclassic.css" rel="stylesheet"
		type="text/css">
	<link href="/sysmanager/css/contentpage.css" rel="stylesheet" type="text/css">
	<link href="/sysmanager/css/windows.css" rel="stylesheet"
		type="text/css">
	<link href="/sysmanager/css/tab.winclassic.css" rel="stylesheet"
		type="text/css">
	<link href="/sysmanager/css/contentpage.css" rel="stylesheet"
		type="text/css">
	<base target="_self">

</head>
<html>
	<body class="contentbodymargin" scroll="yes">		
			<pg:beaninfo requestKey="Apply">
				<fieldset style="width: 100%;">
						<LEGEND align=center>
							<FONT size="2">机构用户</FONT>
						</LEGEND>
						<table width="100%" height="35" border="0" align="left"
							cellpadding="0" cellspacing="1" class="table">								
							<tr>
								<td width="" class="detailcontent"><!-- dynamic="false" mode="static" -->
									<tree:tree tree="app_org_user_tree"
										node="app_org_user_tree.node"
										imageFolder="/sysmanager/images/tree_images/" collapse="true"
										includeRootNode="true" mode="<%=showmode %>">
								<tree:param name="showmode" value="<%=showmode%>"></tree:param>									
										<tree:param name="showmode" value="<%=showmode%>"></tree:param>
										<tree:param name="userid" value="<%=userid%>"></tree:param>
										<tree:param name="orgid" value="<%=orgid%>"></tree:param>											
										<tree:checkbox name="orguser" recursive="true"
											uprecursive="true" />
										<tree:treedata
											treetype="com.chinacreator.eform.systemManager.OrgUserTree1"
											scope="request" rootid="0" rootName="机构用户树" expandLevel="1"
											showRootHref="false" needObserver="false" />
									</tree:tree>
								</td>
							</tr>
						</table>
						<br />
					</fieldset>
				</pg:beaninfo>
	</body>
</html>
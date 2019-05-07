<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.security.AccessControl,org.apache.commons.lang.StringUtils"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ taglib uri="/WEB-INF/treetag.tld" prefix="tree" %>
<%
String showmode = StringUtils.defaultString(request.getParameter("showmode"));
%>
<html>
	<head>
		<title>用户组选择</title>
		<link rel="stylesheet" type="text/css" href="/sysmanager/css/treeview.css">
		<link rel="stylesheet" type="text/css" href="/sysmanager/css/windows.css">
	</head>
	<body class="contentbodymargin" scroll="yes">
		<pg:beaninfo requestKey="Apply">
			<fieldset style="width: 100%;">
				<LEGEND align=center>
					<FONT size="2">用户组选择</FONT>
				</LEGEND>
				<table width="100%" height="35" border="0" align="left"	cellpadding="0" cellspacing="1" class="table">								
					<tr>
				   		<td width="" class="detailcontent">
							<tree:tree tree="group_role_tree_radio" 
									   node="group_role_tree_radio.node" 
									   imageFolder="/sysmanager/images/tree_images/" 
									   collapse="true" 
									   includeRootNode="true" 									
									   target="groupinfo"
									   mode="<%=showmode %>">
								<tree:param name="showmode" value="<%=showmode%>"></tree:param>									
								<tree:radio name="groupid"/>
								<tree:treedata treetype="com.chinacreator.eform.systemManager.GroupAddTreeRadio" 
											   scope="request" rootid="0" 
										       rootName="用户组树" expandLevel="1" 
										       showRootHref="false" 
										       needObserver="false" />
							</tree:tree>
						</td>
					</tr>
				</table>
        	    <br />
			</fieldset>
		</pg:beaninfo>	
	</body>
</html>

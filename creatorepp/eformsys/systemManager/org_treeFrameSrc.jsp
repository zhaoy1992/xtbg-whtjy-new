<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ taglib uri="/WEB-INF/treetag.tld" prefix="tree" %>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.resource.ResourceManager,
                 com.chinacreator.sysmgrcore.manager.db.OrgAdministratorImpl,
                 org.apache.commons.lang.StringUtils"%>
<%
AccessControl accessControl = AccessControl.getInstance();
accessControl.checkAccess(request,response);       
String app_id = StringUtils.defaultString(request.getParameter("app_id"));
String org_ids = StringUtils.defaultString(request.getParameter("org_ids"));
String showmode = StringUtils.defaultString(request.getParameter("showmode"));
%> 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<title>组织机构</title>

<style type="text/css">
<!--
.tdclass_act{
font-size:14px;
}
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
</head>
<body class="contentbodymargin" scroll="yes">
	<pg:beaninfo requestKey="Apply">
		<fieldset style="width: 100%;">
			<LEGEND align=center>
				<FONT size="2">组织机构</FONT>
			</LEGEND>
			<table width="100%" height="35" border="0" align="left"	cellpadding="0" cellspacing="1" class="table">								
				<tr>
					<td width="" class="detailcontent">
						<tree:tree tree="myapp_org_tree"
					    	       node="myapp_org_tree.node"
					    	       imageFolder="/purviewmanager/images/tree_images/"
					    	       collapse="true"
					    		   includeRootNode="true"        			  
					    		   mode="<%=showmode %>">  
								<tree:param name="showmode" value="<%=showmode%>"></tree:param>										    
						    <tree:param name="app_id" value="<%=app_id%>"></tree:param>
						    <tree:param name="org_ids" value="<%=org_ids%>"></tree:param>    			
						    <tree:checkbox name="orgid" recursive="true" uprecursive="true"></tree:checkbox>
						    <tree:treedata treetype="com.chinacreator.eform.systemManager.OrgTree"
						    	           scope="request"
						    	           rootid="0"  
						    	           rootName="组织机构"
						    	           expandLevel="1"
						    	           showRootHref="true"
						    	           needObserver="false"/>					
			    		</tree:tree>
					</td>
				</tr>
			</table>
			<br />
		</fieldset>
	</pg:beaninfo>
</body>
</html>

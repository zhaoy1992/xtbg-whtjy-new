
<%@ page contentType="text/html; charset=GBK"%>

<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ taglib uri="/WEB-INF/treetag.tld" prefix="tree"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.ResManager,com.chinacreator.resource.ResourceManager"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.chinacreator.sysmgrcore.entity.Restype" %>
<%
	
%>
<html>
	<head>
		<title>��������</title>
		<script language="JavaScript" src="changeView.js" type="text/javascript"></script>
		<link rel="stylesheet" type="text/css" href="../css/windows.css">
		<link rel="stylesheet" type="text/css" href="../css/treeview.css">
	<%@ include file="/epp/css/cssControl.jsp"%><body  class="contentbodymargin" scroll="no">
		<div id="contentborder">

				
					<table class="table" width="80%" border="0" cellpadding="0" cellspacing="1">
						
						
						<tr class="tr">
							<td class="td" width="40%" align="center">
								
							</td>
						</tr>
						<tr class="tr">
							<td class="td">

								<tree:tree tree="role_column_tree" node="role_column_tree.node" 
								imageFolder="../images/tree_images/" collapse="true" includeRootNode="true" 
								href="/sysmanager/menumanager/resMenu_tab.jsp" 
								dynamic="false"
								target="menuList">
									<tree:param name="resTypeId"/>

									<tree:treedata treetype="ColumnCmsTree" scope="request" 
									rootid="0" rootName="�˵�����" expandLevel="1" 
									showRootHref="false" 
									sortable="false"
									needObserver="false" refreshNode="false" enablecontextmenu="false"/>
									
								</tree:tree>
							</td>
						</tr>
					</table>
		

		</div>
	</body>
</html>

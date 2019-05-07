<%@ include file="/sysmanager/include/global1.jsp"%>
<%@ include file="/sysmanager/base/scripts/panes.jsp"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ taglib uri="/WEB-INF/treetag.tld" prefix="tree"%>
<%
String href = "/common_workflow/frame_bridge.jsp";			
%>
<html>
	<head>
		<title> Ù–‘»›∆˜</title>
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/sysmanager/css/windows.css">
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/sysmanager/css/contentpage.css">
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/sysmanager/css/tab.winclassic.css">
				
	<%@ include file="/epp/css/cssControl.jsp"%><body class="contentbodymargin" scroll="no">
		<div id="contentborder">

			<form name="OrgJobForm" action="" method="post">
				<table class="table" width="80%" border="0" cellpadding="0" cellspacing="1">
					
					<tr class="tr">
					 <td class="td">
							
							
							<tree:tree tree="common_workflow_orgtree" node="common_workflow_orgtree.node" 
							imageFolder="/sysmanager/images/tree_images/" collapse="true" includeRootNode="false" 
							href="<%=href%>" target="frame_bridge"  mode="static-dynamic">
						
							
								<tree:treedata treetype="com.chinacreator.menu.WorkFlowTree" 
								scope="request" rootid="0" rootName="ª˙ππ ˜" expandLevel="1" 
								showRootHref="false" needObserver="false" refreshNode="false"/>
							</tree:tree>
						</td>
					</tr>
				</table>
			</form>

		</div>
	</body>
</html>

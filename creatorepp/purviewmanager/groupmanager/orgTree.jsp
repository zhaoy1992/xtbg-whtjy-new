<%/*
 * <p>Title: ������</p>
 * <p>Description: ������</p>
 * <p>Copyright: Copyright (c) 2008</p>
 * <p>Company: chinacreator</p>
 * @Date 2008-3-18
 * @author liangbing.tao
 * @version 1.0
 */
%>


<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ taglib uri="/WEB-INF/treetag.tld" prefix="tree"%>
<html>
	<head>
		<title>��������</title>
		<link href="../css/treeview.css" rel="stylesheet" type="text/css">
		<link href="../css/windows.css" rel="stylesheet" type="text/css">
	</head>
	<%@ include file="/epp/css/cssControl.jsp"%><body  class="contentbodymargin" scroll="no">
		<div id="contentborder">
			<center>
				<table class="table" width="80%" border="0" cellpadding="0" cellspacing="1">
					<tr class="tr">
						<td class="td">
							<tree:tree 
									tree="group_org_tree" node="group_org_tree.node" 
									imageFolder="../images/tree_images/" 
									collapse="true" 
									includeRootNode="true" 
									href="userList_ajax.jsp" 
									target="userList"
									mode="static-dynamic"
									>
									
									<tree:param name="uid" />
									
									<tree:treedata treetype="com.chinacreator.sysmgrcore.purviewmanager.menu.OrgTree" 
											scope="request" rootid="0" 
											rootName="������" expandLevel="1" 
											showRootHref="false" 
											needObserver="false" />
							</tree:tree>
						</td>
					</tr>
				</table>
			</center>
		</div>
	</body>
</html>

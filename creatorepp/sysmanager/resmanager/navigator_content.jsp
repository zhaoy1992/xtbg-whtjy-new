<%@ include file="../include/global1.jsp"%>
<%@ taglib uri="/WEB-INF/treetag.tld" prefix="tree" %>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.resource.ResourceManager"%>
<%
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request,response);
%>
<html>
<head>
<title>����������</title>
<script language="javascript">
function action11(){
	getPropertiesContent().location.href="<%=rootpath%>/sysmanager/orgmanager/organsearch.jsp";
}

</script>
<link rel="stylesheet" type="text/css" href="../css/treeview.css">
<link rel="stylesheet" type="text/css" href="../css/windows.css">
</head>
<%@ include file="/epp/css/cssControl.jsp"%><body  class="contentbodymargin" scroll="no">
<div id="contentborder">
	<center>
	<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table">
	<tr class="tr">
		<td class="td">
			<div align="center">
				<a href="resinfolist.jsp" target="base_properties_content">��Դ��ѯ</a>
			</div>
		</td>
	</tr>
	</table>
    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="table">
		<tr class="tr">
		<td class="td">
        <tree:tree tree="res_tree" 
        		node="res_tree.node" imageFolder="../images/tree_images/" 
        		collapse="true" includeRootNode="true" 
        		href="properties_toolbar.jsp" target="base_properties_toolbar">
        		
				<tree:treedata treetype="ResourceTypeTree" scope="session" rootid="0" rootName="��Դ����" expandLevel="1" 
				showRootHref="false" 
				needObserver="false" 
				/>
			</tree:tree>
         </td></tr>
    </table>
    </center>
</div>
</body>
</html>

<%@ taglib uri="/WEB-INF/treetag.tld" prefix="tree" %>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.security.AccessControl" %>
<%@ include file="../../sysmanager/include/global1.jsp"%>
<%@ include file="../../sysmanager/base/scripts/panes.jsp"%>
<%
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request, response);
%>
<html>
<head>

<title></title>
<script language="javascript">
</script>
<script src="../js/fcpub.js"></script>
<link rel="stylesheet" type="text/css" href="../../sysmanager/css/treeview.css">
<link rel="stylesheet" type="text/css" href="../../sysmanager/css/windows.css">
<link rel="stylesheet" type="text/css" href="../../sysmanager/css/contentpage.css">
<link rel="stylesheet" type="text/css" href="../../sysmanager/css/tab.winclassic.css">
<script>
	function toUrl(filePath)
	{
		var sUrl = "file_list.jsp?filePath="+filePath;
		parent.base_properties_toolbar.location.href=sUrl;
	}
</script>
</head>
<%@ include file="/epp/css/cssControl.jsp"%><body class="contentbodymargin" scroll="auto">
<form name="applyform">
		<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table">
        <tr>
        <td>
           <tree:tree tree="file_tree"
    	           node="file_tree.node"
    	           imageFolder="../../sysmanager/images/tree_images/"
    	           collapse="true"
    			   includeRootNode="true"  			  
    			   target="base_properties_toolbar"
    			   dynamic="false"
    			   >     			   
    			   <tree:treedata treetype="com.chinacreator.epp.file.menu.FileTree"
    	                   scope="request"
    	                   rootid="0"  
    	                   rootName="ÎÄ¼þÅäÖÃÊ÷"
    	                   expandLevel="1"
    	                   showRootHref="true"
    	                   needObserver="false"
    	                   enablecontextmenu="true"
    	                   />
    	   </tree:tree>
        </td>
        </tr>
        </table>
</form>
</body>
</html>

<%@ taglib uri="/WEB-INF/treetag.tld" prefix="tree" %>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.security.AccessControl" %>
<%@ include file="../../sysmanager/include/global1.jsp"%>
<%@ include file="../../sysmanager/base/scripts/panes.jsp"%>
<html>
<head>

<title></title>
<script language="javascript">
</script>
<link rel="stylesheet" type="text/css" href="../../sysmanager/css/treeview.css">
<link rel="stylesheet" type="text/css" href="../../sysmanager/css/windows.css">
<link rel="stylesheet" type="text/css" href="../../sysmanager/css/contentpage.css">
<link rel="stylesheet" type="text/css" href="../../sysmanager/css/tab.winclassic.css">
<script>
	function toUrl(class_id,type)
	{
		var sUrl = "report_list.jsp?ec_id="+class_id;
		parent.base_properties_toolbar.location.href=sUrl;
	}
	/*
	function toUniteUrl()
	{
		var sUrl = "jawe_unite_list.jsp?ec_id=0";
		parent.base_properties_toolbar.location.href=sUrl;
	}
	*/
</script>
</head>
<%@ include file="/epp/css/cssControl.jsp"%><body class="contentbodymargin" scroll="no">
<form name="applyform">
		<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table">
        <tr>
        <td>
           <tree:tree tree="report_report_tree_formclass_tree"
    	           node="formclass_tree.node"
    	           imageFolder="../../sysmanager/images/tree_images/"
    	           collapse="true"
    			   includeRootNode="true"
    			   target="base_properties_toolbar"
    			   mode="static-dynamic"
    			   >

    			   <tree:treedata treetype="com.chinacreator.epp.reportmanage.menu.ReportClassTree"
    	                   scope="request"
    	                   rootid="0"
    	                   rootName="报表所属业务类别"
    	                   expandLevel="1"
    	                   showRootHref="true"
    	                   needObserver="false"
    	                   enablecontextmenu="true"
    	                   />
    	   </tree:tree>
        </td>
        </tr>
        </table>

        <br>

</form>
</body>
</html>

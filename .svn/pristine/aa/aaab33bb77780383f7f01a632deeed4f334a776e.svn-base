<%@ taglib uri="/WEB-INF/treetag.tld" prefix="tree" %>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="/sysmanager/include/global1.jsp"%>
<%@ include file="/sysmanager/base/scripts/panes.jsp"%>
<html>
<head>

<title></title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/sysmanager/css/treeview.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/sysmanager/css/windows.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/sysmanager/css/contentpage.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/sysmanager/css/tab.winclassic.css">
<script>
	function toUrl(class_id,type)
	{
		var sUrl = "monitor_workflow_platform_list.jsp?class_id="+class_id;
		getPropertiesContent().location.href=sUrl;
	}
</script>
<!-- script src="<%=request.getContextPath()%>/eformsys/fceform/js/fcpub.js"></script-->
</head>
<%@ include file="/epp/css/cssControl.jsp"%><body class="contentbodymargin" scroll="auto">
<form name="applyform">
		<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table">
        <tr>
        <td>
           <tree:tree tree="common_workflow_navigator_content_tree"
    	           node="common_workflow_navigator_content_tree.node"
    	           imageFolder="../sysmanager/images/tree_images/"
    	           collapse="true"
    			   includeRootNode="true"
    			   target="base_properties_toolbar"
    			   mode="static-dynamic"
    			   > 
    			   
    			   <tree:treedata treetype="com.chinacreator.epp.applymanager.menu.PlatformWatchTree"
    	                   scope="request"
    	                   rootid="0"  
    	                   rootName="Á÷³Ì¼à¿ØÊ÷"
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

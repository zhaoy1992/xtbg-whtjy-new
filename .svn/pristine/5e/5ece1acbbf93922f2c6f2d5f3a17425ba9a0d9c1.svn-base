
<%@ include file="../include/global1.jsp"%>
<%@ include file="../base/scripts/panes.jsp"%>
<%@ taglib uri="/WEB-INF/treetag.tld" prefix="tree" %>
<%@ page language="java" contentType="text/html; charset=GBK"%>

<html>
<head>
<title>流程监控管理</title>

<link rel="stylesheet" type="text/css" href="../css/treeview.css">
<link rel="stylesheet" type="text/css" href="../css/windows.css">
<link rel="stylesheet" type="text/css" href="../css/contentpage.css">
<link rel="stylesheet" type="text/css" href="../css/tab.winclassic.css">

</head>
<%@ include file="/epp/css/cssControl.jsp"%><body  class="contentbodymargin" scroll="no">
<div id="contentborder">
    <table >
    	
    	
        <tr><td>
         <tree:tree tree="package_tree"
    	           node="package_tree.node"
    	           imageFolder="../images/tree_images/"
    	           collapse="true"
    			   includeRootNode="true"    			   
    			   href="properties_content.jsp"    			   
    			   target="base_properties_content"
    			   >                                            

    			   <tree:treedata treetype="PkgTree"
    	                   scope="request"
    	                   rootid="0"  
    	                   rootName="包级别"
    	                   expandLevel="1"
    	                   showRootHref="false"
    	                   needObserver="false"
    	                   />

    	</tree:tree>
         </td></tr>
    </table>
</div>
</body>
</html>


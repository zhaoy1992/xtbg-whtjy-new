
<%@ include file="../include/global1.jsp"%>
<%@ include file="../base/scripts/panes.jsp"%>
<%@ taglib uri="/WEB-INF/treetag.tld" prefix="tree" %>
<%@ page language="java" contentType="text/html; charset=GBK"%>

<html>
<head>

<title>导航器内容</title>

<link rel="stylesheet" type="text/css" href="../css/treeview.css">
<link rel="stylesheet" type="text/css" href="../css/windows.css">
<link rel="stylesheet" type="text/css" href="../css/contentpage.css">
<link rel="stylesheet" type="text/css" href="../css/tab.winclassic.css">

</head>
<%@ include file="/epp/css/cssControl.jsp"%><body  class="contentbodymargin" scroll="no">
<div id="contentborder">
    <table >
    		
    	
        <tr><td align="left">
         <tree:tree tree="usermapping_tree"
    	           node="usermapping_tree.node"
    	           imageFolder="../images/tree_images/"
    	           collapse="true"
    			   includeRootNode="true"    			   
    			   href="usermapping_info.jsp"    			   
    			   target="base_properties_content"
    			   >                                            

    			   <tree:treedata treetype="UsermappingTree"
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


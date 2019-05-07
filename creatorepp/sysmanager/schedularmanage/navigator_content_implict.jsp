<%@ taglib uri="/WEB-INF/treetag.tld" prefix="tree" %>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%
    String path = "menu://sysmenu$root";
    //com.chinacreator.framework.Framework.SUPER_MENU
    String contextPath = request.getContextPath();
    String imagepath = contextPath+"/sysmanager/images/tree_images/";
%>
<html>
<head>

<title>����������</title>


<link rel="stylesheet" type="text/css" href="<%=contextPath%>/sysmanager/css/treeview.css">
<link rel="stylesheet" type="text/css" href="<%=contextPath%>/sysmanager/css/windows.css">
<link rel="stylesheet" type="text/css" href="<%=contextPath%>/sysmanager/css/contentpage.css">
<link rel="stylesheet" type="text/css" href="<%=contextPath%>/sysmanager/css/tab.winclassic.css">
</head>
<%@ include file="/epp/css/cssControl.jsp"%><body  class="contentbodymargin" scroll="no">
<div id="contentborder">
    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="table" >
        <tr><td>
         <tree:tree tree="basecolumn_tree"
    	           node="basecolumn_tree.node"
    	           imageFolder="<%=imagepath%>"
    	           collapse="true"
    			   includeRootNode="true"
    			   nowrap="true"
    			   target="base_properties_content"
    			   >


    			   <tree:treedata treetype="BaseColumnTree"
    	                   scope="session"
    	                   rootid="menu://sysmenu$root/schedularmanager$module"
    	                   rootName="�ճ̹���"
    	                   expandLevel="2"
    	                   showRootHref="false"
    	                   needObserver="false"
                           refreshNode="false"
    	                   />

    	</tree:tree>
         </td></tr>
    </table>
</div>
</body>
</html>

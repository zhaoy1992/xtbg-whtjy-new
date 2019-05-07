<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@page import="com.chinacreator.framework.Framework"%>
<%@ taglib uri="/WEB-INF/treetag.tld" prefix="tree" %>  
<%
    String path = "menu://sysmenu$root";
    //com.chinacreator.framework.Framework.SUPER_MENU
    String contextPath = request.getContextPath();
    com.chinacreator.security.AccessControl accesscontroler_panes = com.chinacreator.security.AccessControl.getInstance();
  	accesscontroler_panes.checkAccess(request,response);
    String currentSystem = accesscontroler_panes.getCurrentSystem();
    String name = Framework.getSubFrameworkName(currentSystem);
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<title></title>

<link rel="stylesheet" type="text/css" href="sysmanager/css/treeview.css">
<link rel="stylesheet" type="text/css" href="sysmanager/css/windows.css">
</head>
<%@ include file="/epp/css/cssControl.jsp"%><body  class="contentbodymargin" scrolling="no">
<div id="contentborder">
    <table >
        <tr><td>
         <tree:tree tree="basecolumn_tree"
    	           node="basecolumn_tree.node"
    	           imageFolder="epp/eppTemplate/treeimages"
    	           collapse="true"
    			   includeRootNode="true"
    			   nowrap="true"
    			   target="perspective_content"
    			   mode="static-dynamic"
    			   >


    			   <tree:treedata treetype="BaseColumnTree"
    	                   scope="request"
    	                   rootid="menu://sysmenu$root"
    	                   rootName="<%=name %>"
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

<%@ include file="../include/global1.jsp"%>
<%@ taglib uri="/WEB-INF/treetag.tld" prefix="tree" %>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.security.AccessControl" %>
<%@ page import="com.chinacreator.sysmgrcore.manager.db.OrgAdministratorImpl" %>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
%>
<html>
<head>
<title>系统管理</title>

<link rel="stylesheet" type="text/css" href="../css/treeview.css">
<link rel="stylesheet" type="text/css" href="../css/windows.css">
<link rel="stylesheet" type="text/css" href="../css/contentpage.css">
<link rel="stylesheet" type="text/css" href="../css/tab.winclassic.css">
 
</head>
<%@ include file="/epp/css/cssControl.jsp"%><body  class="contentbodymargin" scroll="no">
<div id="contentborder">
    <table >
    	<tr class="tr">
			<td class="td" align="center">				
					<!--<a href="discreteUser.jsp" target="base_properties_toolbar">离散用户管理</a>-->
				</td>			
		</tr>
    	
        <tr><td>
         <tree:tree tree="UserOrg_tree"
    	           node="UserOrg_tre.node"
    	           imageFolder="../images/tree_images/"
    	           collapse="true"
    			   includeRootNode="true"    			   
    			   href="userList.jsp"    			   
    			   target="userList"
    			   mode="static"  
    			   >                         
                 

    			   <tree:treedata treetype="com.chinacreator.menu.OrgChargeTree"
    	                   scope="request"
    	                   rootid="0"  
    	                   rootName="机构树"
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

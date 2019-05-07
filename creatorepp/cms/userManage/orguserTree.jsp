
<%@ include file="../../sysmanager/base/scripts/panes.jsp"%>
<%@ taglib uri="/WEB-INF/treetag.tld" prefix="tree" %>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%
	
	String roleId = request.getParameter("roleId");
	String href = "userList_ajax.jsp?roleId="+roleId;
%>
<html>
<head>
<title>ϵͳ����</title>

<link rel="stylesheet" type="text/css" href=".../../sysmanager/css/treeview.css">
<link rel="stylesheet" type="text/css" href="../../sysmanager/css/windows.css">
<link rel="stylesheet" type="text/css" href="../../sysmanager/css/contentpage.css">
<link rel="stylesheet" type="text/css" href="../../sysmanager/css/tab.winclassic.css">
 
</head>
<body class="contentbodymargin" scroll="no">
<div id="contentborder">
    <table >
    	<tr class="tr">
			<td class="td" align="center">				
				
			</td>			
		</tr>
    	
        <tr><td>
         <tree:tree tree="RoleUser_tree"
    	           node="RoleUser_tree.node"
    	           imageFolder="../../sysmanager/images/tree_images/"
    	           collapse="true"
    			   includeRootNode="true"    			   
    			   href="<%=href%>"    			   
    			   target="userList"
    			  mode="static-dynamic"
    			   >                         
              
				   <tree:param name="roleId"/>
    			   <tree:treedata treetype="OrgTree"
    	                   scope="request"
    	                   rootid="0"  
    	                   rootName="������"
    	                   expandLevel="1"
    	                   showRootHref="true"
    	                   needObserver="false"
    	                   refreshNode="false"
    	                   />

    	</tree:tree>
         </td></tr>
    </table>
</div>
</body>
</html>

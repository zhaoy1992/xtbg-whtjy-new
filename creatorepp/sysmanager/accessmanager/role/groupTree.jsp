<%@ include file="../../include/global1.jsp"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="../../base/scripts/panes.jsp"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg" %>
<%@ taglib uri="/WEB-INF/treetag.tld" prefix="tree" %>
<%
	String roleId = request.getParameter("roleId");
	String href = "../../../accessmanager/roleManager.do?method=getGroupListByRoleId&roleId="+roleId;
%>
<html>
<head>    
  <title>��������</title>
  <link rel="stylesheet" type="text/css" href="../../css/windows.css">
  <link rel="stylesheet" type="text/css" href="../../css/treeview.css"> 
<%@ include file="/epp/css/cssControl.jsp"%><body  class="contentbodymargin" scroll="no">
<div id="contentborder">
<center>
<form name="OrgJobForm" action="" method="post" >
<table class="table" width="80%" border="0" cellpadding="0" cellspacing="1"> 
  <tr class="tr" >
     <td  class="td">
     
    <tree:tree tree="group_role_tree"
    	           node="group_role_tree.node"
    	           imageFolder="../../images/tree_images/"
    	           collapse="true"
    			   includeRootNode="true"
    			   href="<%=href%>"
    			   target="groupList"
    			   >                         
				   <tree:param name="roleId"/>	
    			   <tree:treedata treetype="GroupTree"
    	                   scope="request"
    	                   rootid="0"  
    	                   rootName="����"
    	                   expandLevel="1"
    	                   showRootHref="false"
    	                   needObserver="false"
    	                   />
    	</tree:tree>
	</td>				  
  </tr>  
</table>
</form>
</center>
</div>
</body>
</html>

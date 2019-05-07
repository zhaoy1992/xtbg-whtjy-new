<%@ include file="../../../sysmanager/include/global1.jsp"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="../../../sysmanager/base/scripts/panes.jsp"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg" %>
<%@ taglib uri="/WEB-INF/treetag.tld" prefix="tree" %>
<%@ page import="com.chinacreator.security.AccessControl" %>
<%
	AccessControl control = AccessControl.getInstance();
	control.checkManagerAccess(request,response);
	String uid = request.getParameter("userId");
	request.setAttribute("userId",uid);
	String userOrgId = request.getParameter("orgId");
	String orgId = request.getParameter("orgId");
	String href =  "userList_copy.jsp?userId="+uid+"&curOrgId="+orgId+"&userOrgId="+userOrgId;
	
%>
<html>
<head>    
  <title> Ù–‘»›∆˜</title>
  <link rel="stylesheet" type="text/css" href="../../../sysmanager/css/windows.css">
  <link rel="stylesheet" type="text/css" href="../../../sysmanager/css/treeview.css"> 
<%@ include file="/epp/css/cssControl.jsp"%><body  class="contentbodymargin" scroll="no">
<div id="contentborder">

<form name="OrgJobForm" action="" method="post" >
<table class="table" width="100%" border="0" cellpadding="0" cellspacing="1"> 
  <tr class="tr" >
     <td  class="td">
     
    <tree:tree tree="role_org_tree"
    	           node="role_org_tree.node"
    	           imageFolder="../../../sysmanager/images/tree_images/"
    	           collapse="true"
    			   includeRootNode="true"
    			   href="<%=href%>"
    			   target="userList"
    			   dynamic="false"
    			   >                         
                   <tree:param name="userId"/>
                   <tree:param name="orgId"/>
					
    			   <tree:treedata treetype="com.chinacreator.menu.OrgTree"
    	                   scope="request"
    	                   rootid="0"  
    	                   rootName="ª˙ππ ˜"
    	                   expandLevel="1"
    	                   showRootHref="true"
    	                   needObserver="false"
    	                   refreshNode="false"
    	                   />
    	</tree:tree>
	</td>				  
  </tr>  
</table>
</form>

</div>
</body>
</html>

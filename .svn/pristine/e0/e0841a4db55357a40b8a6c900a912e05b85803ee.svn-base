<%-- 
	描述：角色隶属机构树页面
	作者：黄艺平
	版本：1.0
	日期：2013-05-30
 --%>
 
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg" %>
<%@ taglib uri="/WEB-INF/treetag.tld" prefix="tree" %>
<%@ page import="com.chinacreator.security.AccessControl"%>


<%
	AccessControl control = AccessControl.getInstance();
	control.checkManagerAccess(request,response);
	
	
	String roleId = request.getParameter("roleId");
	String href="roleconferorg_ajax.jsp?roleId=" + roleId;
	
%>
<html>
	<head>    
	  <title>属性容器</title>
	  <link rel="stylesheet" type="text/css" href="../css/windows.css">
	  <link rel="stylesheet" type="text/css" href="../css/treeview.css"> 
	 </head>
	<%@ include file="/epp/css/cssControl.jsp"%><body  class="contentbodymargin" scroll="no">
		<div id="contentborder">
			<form name="OrgJobForm" action="" method="post" >
				<table class="table" width="100%" border="0" cellpadding="0" cellspacing="1"> 
				  <tr class="tr" >
				     <td  class="td">
						    <tree:tree tree="role_org_tree"
						    	           node="role_org_tree.node"
						    	           imageFolder="../../../../purviewmanager/images/tree_images/"
						    	           collapse="true"
						    			   includeRootNode="true"
						    			   href="<%=href%>"
						    			   target="orgList"
						    			   mode="static-dynamic"
						    			   >                         
						                   <tree:param name="uid"/>
						                   <tree:param name="roleId"/>
						
						    			   <tree:treedata treetype="com.chinacreator.sysmgrcore.purviewmanager.menu.RoleOrgTree"
						    	                   scope="request"
						    	                   rootid="0"  
						    	                   rootName="机构树"
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

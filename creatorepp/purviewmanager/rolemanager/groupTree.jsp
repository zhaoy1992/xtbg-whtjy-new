<%
/*
 * <p>Title: 用户组树显示页面</p>
 * <p>Description: 用户组树显示页面</p>
 * <p>Copyright: Copyright (c) 2008</p>
 * <p>Company: chinacreator</p>
 * @Date 2008-3-25
 * @author liangbing.tao
 * @version 1.0
 */
%>


<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg" %>
<%@ taglib uri="/WEB-INF/treetag.tld" prefix="tree" %>
<%@ page import="com.chinacreator.security.AccessControl"%>	

<%
	AccessControl control = AccessControl.getInstance();
	control.checkManagerAccess(request,response);

	String roleId = request.getParameter("roleId");
	
	String href = "changeGroup_ajax.jsp?roleId="+roleId;
%>
<html>
	<head>    
	  <title>属性容器</title>
	  <link rel="stylesheet" type="text/css" href="../css/windows.css">
	  <link rel="stylesheet" type="text/css" href="../css/treeview.css"> 
	</head>
	<%@ include file="/epp/css/cssControl.jsp"%><body  class="contentbodymargin" scroll="no">
		<div id="contentborder">
			<center>
				<form name="OrgJobForm" action="" method="post" >
					<table class="table" width="80%" border="0" cellpadding="0" cellspacing="1"> 
					  <tr class="tr" >
					     <td  class="td">
					     
					    <tree:tree tree="group_role_tree"
					    	           node="group_role_tree.node"
					    	           imageFolder="../images/tree_images/"
					    	           collapse="true"
					    			   includeRootNode="true"
					    			   href="<%=href%>"
					    			   target="groupList"
					    			   mode="static"
					    			   >                         
									   <tree:param name="roleId"/>	
					    			   <tree:treedata treetype="com.chinacreator.sysmgrcore.purviewmanager.menu.GroupAddTree"
					    	                   scope="request"
					    	                   rootid="0"  
					    	                   rootName="组树"
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

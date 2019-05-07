<%
/*
 * <p>Title: ��ʾ�û�����</p>
 * <p>Description: ��ʾ�û�����</p>
 * <p>Copyright: Copyright (c) 2008</p>
 * <p>Company: chinacreator</p>
 * @Date 2008-3-18
 * @author liangbing.tao
 * @version 1.0
 */
%>
<%     
	response.setHeader("Cache-Control", "no-cache"); 
	response.setHeader("Pragma", "no-cache"); 
	response.setDateHeader("Expires", -1);  
	response.setDateHeader("max-age", 0); 
%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg" %>
<%@ taglib uri="/WEB-INF/treetag.tld" prefix="tree" %>
<%@ page import="com.chinacreator.security.AccessControl"%>

<%
	
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkManagerAccess(request,response);
	
	String userId = request.getParameter("userId");
	String orgId = request.getParameter("orgId");

	String href = "userGroupManagerAction.jsp?userId=" + userId+"&&orgId="+orgId;	
%>
<html>
	<head>    
	  <title>��������</title>
	  <link rel="stylesheet" type="text/css" href="../../css/windows.css">
	  <link rel="stylesheet" type="text/css" href="../../css/treeview.css"> 
	</head>
	<%@ include file="/epp/css/cssControl.jsp"%><body  class="contentbodymargin" scroll="no">
		<div id="contentborder">
			<center>
				<form name="userGroupForm" action="" method="post" >
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
						    			   mode="static"
						    			   >                         
										   <tree:param name="userId"/>	
						    			   <tree:treedata treetype="com.chinacreator.sysmgrcore.purviewmanager.menu.GroupAddTree"
						    	                   scope="request"
						    	                   rootid="0"  
						    	                   rootName="����"
						    	                   expandLevel="1"
						    	                   showRootHref="false"
						    	                   needObserver="false"
						    	                   refreshNode="false"
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

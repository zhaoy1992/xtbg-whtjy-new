<%
/**
 * <p>Title: ��������Ա������</p>
 * <p>Description: ��������Ա������</p>
 * <p>Copyright: Copyright (c) 2008</p>
 * <p>Company: chinacreator</p>
 * @Date 2008-3-17
 * @author da.wei
 * @version 1.0
 **/
 %>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg" %>
<%@ taglib uri="/WEB-INF/treetag.tld" prefix="tree" %>
<%@ page import="com.chinacreator.security.AccessControl" %>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkManagerAccess(request,response);
	String orgId1 = request.getParameter("orgId1");//���û�������Ա�Ļ���
	String href = "changeOrgAdmin.jsp?orgId1=" + orgId1;
%>
<html>
<head>    
  <title>��������</title>
  <link rel="stylesheet" type="text/css" href="../../css/windows.css">
  <link rel="stylesheet" type="text/css" href="../../css/treeview.css">
<%@ include file="/epp/css/cssControl.jsp"%><body  class="contentbodymargin" scroll="no">
<div id="contentborder">
<form name="OrgJobForm" action="" method="post" >
<table class="table" width="80%" border="0" cellpadding="0" cellspacing="1"> 
  <tr class="tr" >
     <td  class="td">
    <tree:tree tree="role_org_tree"
    	           node="role_org_tree.node"
    	           imageFolder="../../images/tree_images/"
    	           collapse="true"
    			   includeRootNode="false"
    			   href="<%=href%>"
    			   target="userList"
    			   mode="static-dynamic"
    			   >                         
                   <tree:param name="uid"/>
                   <tree:param name="orgId"/>
                   <tree:param name="jobId"/>
                   <tree:param name="orgId1" value="<%=orgId1%>" />

    			   <tree:treedata treetype="com.chinacreator.sysmgrcore.purviewmanager.menu.OrgAdminSelectTree"
    	                   scope="request"
    	                   rootid="0"  
    	                   rootName="������"
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

</div>
</body>
</html>

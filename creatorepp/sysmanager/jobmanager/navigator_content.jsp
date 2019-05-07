<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@page import="com.chinacreator.sysmgrcore.manager.db.OrgAdministratorImpl"%>
<%@ include file="../include/global1.jsp"%>
<%@ taglib uri="/WEB-INF/treetag.tld" prefix="tree" %>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.resource.ResourceManager"%>
<%
AccessControl accessControl = AccessControl.getInstance();
accessControl.checkAccess(pageContext);

//��ǰ�û��Ƿ�ӵ�г�������ԱȨ���벿�Ź���ԱȨ��
boolean isAdminOrOrgManager = false;
//�Ƿ��ǹ���Ա
boolean isOrgManager = new OrgAdministratorImpl().isOrgManager(accessControl.getUserID());
boolean isAdmin = accessControl.isAdmin();
if(isAdmin || isOrgManager){
	isAdminOrOrgManager = true;
}	
%>
<html>
<head>
<title>����������</title>
<script type="text/javascript" src="../dictmanager/js/dictTreeQuery.js"></script>
<script language="javascript">
function action11(){
	getPropertiesContent().location.href="../../jobmanager/A03/jobinfo.jsp";   
}
</script>
<link rel="stylesheet" type="text/css" href="../css/treeview.css">
<link rel="stylesheet" type="text/css" href="../css/windows.css">
<link rel="stylesheet" type="text/css" href="../css/contentpage.css">
<link rel="stylesheet" type="text/css" href="../css/tab.winclassic.css">
</head>

<%@ include file="/epp/css/cssControl.jsp"%><body  class="contentbodymargin" scroll="no" height="100%">
<%if(isAdminOrOrgManager){ %>
<form name="navform">
<div align="center">
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table" >
  <tr>
    <td>
    	<div align="center">
    		<a href="../jobmanager/A03/jobinfo.jsp" target="base_properties_content">��λ��ѯ</a>
    		&nbsp;&nbsp;
    		<%
			ResourceManager resManager = new ResourceManager();
			String resId = resManager.getGlobalResourceid(AccessControl.JOB_RESOURCE);
			if (resId != null && !resId.equals("") && accessControl.checkPermission(resId,
							"add", AccessControl.JOB_RESOURCE))
			{
			%>
			<a href="A03/addjob.jsp" target="base_properties_content">������λ</a>
			<%}%>
    	</div>
    </td>
  </tr>
  <tr>
	<td align="left">
	<input name="blurryValue" type="text" onpropertychange="onBlurryQueryChange()" onkeydown="enterKeydowngo()"/>
	</td>
</tr>
<tr>
<td align="right">
	<input type="button" name="queryBtn" value="��ѯ" onclick="blurryQuary()"  class="input">
	<input style="display:none" name="nextBtn" type="button" value="������һ��" onclick="nextNodes()" class="input">
	</td>
</tr>
</table>
</div>		
<div id="contentborder" style="width:100%;height:89%;overflow:auto">
		<table >
        <tr><td>
         <tree:tree tree="job_tree"
    	           node="test_tree.node"
    	           imageFolder="../images/tree_images/"
    	           collapse="true"
    			   includeRootNode="true"
    			   href="../jobmanager/A03/properties_toolbar.jsp"
    			   target="base_properties_toolbar"
    			   dynamic="false"
    			   >                         
                   <tree:param name=""/>

    			   <tree:treedata treetype="JobTree"
    	                   scope="request"
    	                   rootid="0"  
    	                   rootName="��λ�б�"
    	                   expandLevel="1"
    	                   showRootHref="false"
    	                   needObserver="false"
    	                   
    	                   />

    	</tree:tree>
         </td></tr>
    </table>
</div>
    </form>
<%}else{ %>
<div align="center">û��Ȩ�ޣ�</div>
<%} %>
</body>
</html>
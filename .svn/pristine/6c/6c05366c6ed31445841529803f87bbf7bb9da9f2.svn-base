<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ taglib uri="/WEB-INF/treetag.tld" prefix="tree" %>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%
AccessControl accessControl = AccessControl.getInstance();
accessControl.checkAccess(request,response);	                            
%> 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<title>机构树</title>
<link rel="stylesheet" type="text/css" href="../../orgusermanager/css/windows.css">
<link rel="stylesheet" type="text/css" href="../../orgusermanager/css/treeview.css">
<script>
   	function toUrl(orgId,orgName){
   		var sUrl = "WebOffice_content.jsp?orgID="+orgId+"&orgName="+orgName;
		parent.org_templateList.location.href=sUrl;
	}
</script>
</head>
<%@ include file="/epp/css/cssControl.jsp"%>
<body class="contentbodymargin" scroll="auto">
     <table >
        <tr><td align="left">
         
         <tree:tree tree="fceform_webOffice_org_tree"
    	           node="fceform_webOffice_org_tree.node"
    	           imageFolder="../../sysmanager/images/tree_images/"
    	           collapse="true"
    			   includeRootNode="true"
    			   href="WebOffice_content.jsp" 
    			   target="org_templateList" 
    			   mode="static-dynamic"
    			   >     			    
    			   <tree:treedata treetype=" com.chinacreator.eform.formmanage.dbmanager.WebOfficeTemplateOrgTree"
    	                   scope="request"
    	                   rootid="0"  
    	                   rootName="机构树"
    	                   expandLevel="1"
    	                   showRootHref="true"
    	                   needObserver="false"
    	                   enablecontextmenu="true"
    	           />					
    	</tree:tree>
       </td></tr>
    </table>
</body>
<iframe name="hiddenFrame" width=0 height=0></iframe>
</html>

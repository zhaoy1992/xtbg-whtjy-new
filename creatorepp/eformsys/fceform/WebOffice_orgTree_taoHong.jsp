<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ taglib uri="/WEB-INF/treetag.tld" prefix="tree" %>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%
AccessControl accessControl = AccessControl.getInstance();
accessControl.checkAccess(request,response);
String initFileType = (String)request.getParameter("fileType");	    
%> 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<title>机构树</title>
<link rel="stylesheet" type="text/css" href="../../orgusermanager/css/windows.css">
<link rel="stylesheet" type="text/css" href="../../orgusermanager/css/treeview.css">
</head>
<%@ include file="/epp/css/cssControl.jsp"%>
<body class="contentbodymargin" scroll="auto">
     <table >
        <tr><td align="left">
         
         <tree:tree tree="webOffice_orgTree_taoHong1_org_tree"
    	           node="fceform_webOffice_org_tree.node"
    	           imageFolder="../../sysmanager/images/tree_images/"
    	           collapse="true"
    			   includeRootNode="true"
    			   target="org_templateList" 
    			   dynamic="false"
    			   >     			    
    			   <tree:treedata treetype=" com.chinacreator.eform.formmanage.dbmanager.WebOfficeTemplateOrgTreeTaoHong"
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

<%@ taglib uri="/WEB-INF/treetag.tld" prefix="tree" %>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.security.AccessControl" %>
<%@ include file="../../../sysmanager/include/global1.jsp"%>
<%@ include file="../../../sysmanager/base/scripts/panes.jsp"%>
<html>
<head>

<title></title>
<script language="javascript">
</script>
<script src="../js/fcpub.js"></script>
<link rel="stylesheet" type="text/css" href="../../../sysmanager/css/treeview.css">
<link rel="stylesheet" type="text/css" href="../../../sysmanager/css/windows.css">
<link rel="stylesheet" type="text/css" href="../../../sysmanager/css/contentpage.css">
<link rel="stylesheet" type="text/css" href="../../../sysmanager/css/tab.winclassic.css">
<script>
	function toUrl(class_id,type)
	{
		var sUrl = "useTemplateForm.jsp?class_id="+class_id;
		if(parent.base_properties_toolbar1==null){
			getPropertiesContent().location.href=sUrl+"&showDelete=true";
		}else{
			parent.base_properties_toolbar1.location.href=sUrl;
		}
	}
</script>
</head>
<%@ include file="/epp/css/cssControl.jsp"%>
<body class="contentbodymargin" scroll="auto">
<form name="applyform">
		<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table">
        <tr>
        <td>
           <!-- dynamic="false" -->
           <tree:tree tree="eform_templateNavigator_content_formclass_tree"
    	           node="eform_templateNavigator_content_formclass_tree.node"
    	           imageFolder="../../../sysmanager/images/tree_images/"
    	           collapse="true"
    			   includeRootNode="true"
    			   target="base_properties_toolbar"
    			   mode="static-dynamic"      			   
    			   > 
    			    
    			   <tree:treedata treetype="com.chinacreator.eform.formmanage.menu.FormTree"
    	                   scope="request"
    	                   rootid="0"  
    	                   rootName="模板所属业务类别"
    	                   expandLevel="1"
    	                   showRootHref="true"
    	                   needObserver="false"
    	                   enablecontextmenu="true"
    	                   />
    	   </tree:tree>
        </td>
        </tr>
        </table>
</form>
</body>
</html>

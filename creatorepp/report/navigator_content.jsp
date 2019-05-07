<%@ taglib uri="/WEB-INF/treetag.tld" prefix="tree" %>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="../sysmanager/include/global1.jsp"%>
<%@ include file="../sysmanager/base/scripts/panes.jsp"%>
<html>
<head>
<title></title>
<script language="javascript">
</script>
<script src="report.js"></script>
<link rel="stylesheet" type="text/css" href="../sysmanager/css/treeview.css">
<link rel="stylesheet" type="text/css" href="../sysmanager/css/windows.css">
<link rel="stylesheet" type="text/css" href="../sysmanager/css/contentpage.css">
<link rel="stylesheet" type="text/css" href="../sysmanager/css/tab.winclassic.css">
<script>
	function toUrl(class_id,_class,class_name)
	{
		//var sUrl = "properties_content.jsp?ec_id="+class_id+"&class_name="+class_name;
		var sUrl = "properties_content.jsp?ec_id="+class_id;
		getPropertiesContent().location.href=sUrl;
	}
</script>
</head>
<%@ include file="/epp/css/cssControl.jsp"%><body class="contentbodymargin" scroll="auto">
<form name="applyform">

<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table" >
  <tr>
  <!--
    <td><div align="center"><a href="../sysmanager/applymanager/applywork/applyinfo.jsp" target="base_properties_content">表单分类</a></div></td>
   -->
  </tr>
</table>

		<table >
        <tr><td>
        <!-- href="design/design.htm?tbtype=1" -->
         <tree:tree tree="report_formclass_tree"
    	           node="formclass_tree.node"
    	           imageFolder="../sysmanager/images/tree_images/"
    	           collapse="true"
    			   includeRootNode="true"
    			   target="base_properties_toolbar"
    			   mode="static-dynamic"
    			   >

    			   <tree:treedata treetype="com.chinacreator.epp.reportmanage.menu.ClassTree"
    	                   scope="request"
    	                   rootid="0"
    	                   rootName="报表业务类别"
    	                   expandLevel="1"
    	                   showRootHref="true"
    	                   needObserver="false"
    	                   enablecontextmenu="true"
    	                   />
    	</tree:tree>
         </td></tr>
         </table>
    </form>
</body>
</html>

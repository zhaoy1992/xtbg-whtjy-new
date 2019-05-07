<%@ taglib uri="/WEB-INF/treetag.tld" prefix="tree" %>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="../../sysmanager/include/global1.jsp"%>
<%@ include file="../../sysmanager/base/scripts/panes.jsp"%>
<html>
<head>
<%
String menu_type = request.getParameter("_type");
String rootName = "业务类别";
String allHref = "form_class_home.jsp";
if(menu_type!=null && menu_type.equals("form")){
    rootName = "表单所属业务类别";
    allHref = "form_home.jsp";
}
%>
<title></title>
<script language="javascript">
</script>
<script src="js/fcpub.js"></script>
<link rel="stylesheet" type="text/css" href="../../sysmanager/css/treeview.css">
<link rel="stylesheet" type="text/css" href="../../sysmanager/css/windows.css">
<link rel="stylesheet" type="text/css" href="../../sysmanager/css/contentpage.css">
<link rel="stylesheet" type="text/css" href="../../sysmanager/css/tab.winclassic.css">
<script>
	function deleteForm(djid)
	{
		var retX=SendHttp(location.protocol+"//"+location.host + fcpubdata.servletPath +"/FormTools?op=formDelete&djid="+djid);
		alert(retX);
		window.location.reload();
	}
	function deleteFormClass(app_id,ec_id)
	{
		var retX=SendHttp(location.protocol+"//"+location.host + fcpubdata.servletPath +"/FormTools?op=classDelete&app_id="+app_id+"&ec_id="+ec_id);
		alert(retX);
		window.location.reload();
	}
	function toUrl(class_id,type)
	{
		var sUrl = "properties_toolbar.jsp?class_id=" + class_id + "&_type=<%=menu_type%>";
		//alert(sUrl);
		getPropertiesToolbar().location.href=sUrl;
		//href="properties_toolbar.jsp"
	}
</script>
</head>
<%@ include file="/epp/css/cssControl.jsp"%>
<body class="contentbodymargin" scroll="auto">
<form name="applyform">

<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table" >
  <tr>
  <!-- 
    <td><div align="center"><a href="../../sysmanager/applymanager/applywork/applyinfo.jsp" target="base_properties_content">表单分类</a></div></td>
   -->
  </tr>
</table>
		
		<table >
        <tr><td>
        <!-- href="design/design.htm?tbtype=1" -->
         <tree:tree tree="fceform_formclass_tree"
    	           node="fceform_formclass_tree.node"
    	           imageFolder="../../sysmanager/images/tree_images/"
    	           collapse="true"
    			   includeRootNode="true"
    			   target="base_properties_content"    			   
    			   href="<%=allHref %>"   		
    			   mode="static-dynamic"
    			   > 
    			   <!-- href="form_class_home.jsp" 全局href，包括根结点，类中可以再修改每个node的href-->
    			    
    			   <tree:treedata treetype="com.chinacreator.eform.formmanage.menu.FormTree"
    	                   scope="request"
    	                   rootid="0"  
    	                   rootName="<%=rootName %>"
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

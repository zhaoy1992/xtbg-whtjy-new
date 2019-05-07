<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg" %>
<%@ taglib uri="/WEB-INF/treetag.tld" prefix="tree" %>
<%@ page import="com.chinacreator.sysmgrcore.manager.ResManager,com.chinacreator.resource.ResourceManager"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.chinacreator.sysmgrcore.entity.Restype" %>
<%
	String resTypeId = request.getParameter("resTypeId");
	//ResManager resManager = SecurityDatabase.getResourceManager();
	//Restype resType = new Restype();
	//resType.setRestypeId("0");
	//List list = resManager.getChildResTypeList(resType);
%>
<html>
<head>    
  <title> Ù–‘»›∆˜</title>
  <script language="JavaScript" src="changeView.js" type="text/javascript"></script>
  <script language="javascript">
	function href(){
		var str = "<%=request.getContextPath()%>/sysmanager/accessmanager/role/operList_orgs_ajax.jsp?resTypeId=orgunit";
    	parent.parent.operList.document.location.href = str;
	}
  </script>
  <link rel="stylesheet" type="text/css" href="../../sysmanager/css/windows.css">
  <link rel="stylesheet" type="text/css" href="../../sysmanager/css/treeview.css">
</head>
<body class="contentbodymargin" scroll="auto">
<div id="contentborder">
<form name="theform">
<table class="table" width="80%" border="0" cellpadding="0" cellspacing="1">
  
  
  <tr class="tr" >
     <td  class="td">
     
    <tree:tree tree="role_org_tree"
    	           node="role_org_tree.node"
    	           imageFolder="../../sysmanager/images/tree_images/"
    	           collapse="true"
    			   includeRootNode="true"
    			   href="operList_orgs_ajax.jsp?resTypeId=orgunit"
    			   target="operList"
    			   dynamic="false"
    			   mode="static-dynamic"
    			   >                         
                   <tree:param name="resTypeId"/>
                   
                   <tree:checkbox recursive="true"  name="orgid"  />
    			   <tree:treedata treetype="com.chinacreator.menu.AccreditOrgTree"
    	                   scope="request"
    	                   rootid="0"  
    	                   rootName="ª˙ππ ˜"
    	                   expandLevel="1"
    	                   showRootHref="false"
    	                   needObserver="false"
    	                   refreshNode="true"
    	                   />
    	                   
    	</tree:tree>
	</td>				  
  </tr>  
</table>
</form>
</div>
</body>

</html>

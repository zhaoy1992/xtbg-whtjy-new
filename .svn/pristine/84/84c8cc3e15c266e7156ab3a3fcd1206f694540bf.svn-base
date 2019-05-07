<%@ include file="../../include/global1.jsp"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="../../base/scripts/panes.jsp"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg" %>
<%@ taglib uri="/WEB-INF/treetag.tld" prefix="tree" %>
<%@ page import="com.chinacreator.sysmgrcore.manager.ResManager,com.chinacreator.resource.ResourceManager"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.chinacreator.sysmgrcore.entity.Restype" %>
<%
	String resTypeId = request.getParameter("resTypeId");
	
	
	
%>
<html>
<head>    
  <title> Ù–‘»›∆˜</title>
  <script language="JavaScript" src="changeView.js" type="text/javascript"></script>
  <link rel="stylesheet" type="text/css" href="../../css/windows.css">
  <link rel="stylesheet" type="text/css" href="../../css/treeview.css"> 
<%@ include file="/epp/css/cssControl.jsp"%><body  class="contentbodymargin" scroll="no">
<div id="contentborder">


<table class="table" width="80%" border="0" cellpadding="0" cellspacing="1">
  
  
  <tr class="tr" >
     <td  class="td">
     
    <tree:tree tree="role_org_tree"
    	           node="role_org_tree.node"
    	           imageFolder="../../images/tree_images/"
    	           collapse="true"
    			   includeRootNode="true"
    			   href="/sysmanager/accessmanager/role/operList_tab_ajax.jsp"
    			   target="operList"
    			   dynamic="false"
    			   >                         
                   <tree:param name="resTypeId"/>

    			   <tree:treedata treetype="ResTree"
    	                   scope="request"
    	                   rootid="0"  
    	                   rootName="tab◊ ‘¥ ˜"
    	                   expandLevel="1"
    	                   showRootHref="false"
    	                   needObserver="false"
    	                   refreshNode="false"
    	                   />
    	</tree:tree>
	</td>				  
  </tr>  
</table>


</div>
</body>
</html>

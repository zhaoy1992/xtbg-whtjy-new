<%@ page import="com.frameworkset.dictionary.Data" %>
<%@ page import="com.chinacreator.dictionary.DictManager" %>
<%@ page import="com.chinacreator.dictionary.DictManagerImpl" %>
<%@ taglib uri="/WEB-INF/treetag.tld" prefix="tree" %>
<%@ page language="java" contentType="text/html; charset=gbk"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%
    AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
    String did = request.getParameter("did");
    did = did==null?"":did;
    String dicttype_name = "";
    String description = "";
    Data dtype = null;
    if(did != null){
		DictManager dictManager = new DictManagerImpl();
		dtype = dictManager.getDicttypeById(did);
		description = dtype.getDescription();
		dicttype_name = dtype.getName();
	}
    String rootId = did + ":root:root";
    String rootName = dicttype_name+"-"+description;
%>
<html>
<head>
<title></title>

<link rel="stylesheet" type="text/css" href="../css/treeview.css">
<link rel="stylesheet" type="text/css" href="../css/windows.css">
<link rel="stylesheet" type="text/css" href="../css/contentpage.css">
<link rel="stylesheet" type="text/css" href="../css/tab.winclassic.css">

</head>
<%@ include file="/epp/css/cssControl.jsp"%><body  class="contentbodymargin" scroll="no">
<div id="contentborder">
    <table >
    	
    	
        <tr><td>
         
    	
    	   <tree:tree tree="a_dictdata_tree"
    	           node="a_dict_tree.node"
    	           imageFolder="../images/tree_images/"
    	           collapse="true"
    			   includeRootNode="true"
    			   href="newDictdata.jsp" 
    			   target="newDictdata" 
    			   mode="static-dynamic"
    			   > 
    			   <tree:param name="did"/> 
    			   <tree:treedata treetype="com.chinacreator.dictionary.AccreditDictDataTree"
    	                   scope="request"
    	                   rootid="<%=rootId%>"  
    	                   rootName="<%=rootName%>"
    	                   expandLevel="1"
    	                   showRootHref="true"
    	                   needObserver="true"
    	                   enablecontextmenu="false" 
    	                   refreshNode="false"
    	                   />
					
    	</tree:tree>
         </td></tr>
    </table>
</div>
</body>
</html>


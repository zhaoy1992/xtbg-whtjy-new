<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="com.frameworkset.dictionary.Data" %>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase" %>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityConstants" %>
<%@ page import="com.chinacreator.dictionary.DictManager" %>
<%@ page import="com.chinacreator.dictionary.DictManagerImpl" %>
<%@ page import="org.frameworkset.spi.BaseSPIManager" %>
<%@ page import="java.util.*" %>
<%@ taglib uri="/WEB-INF/treetag.tld" prefix="tree" %>

<%@ page import="com.chinacreator.security.AccessControl"%>
<%
    //??????----------------------------------------------
    AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkManagerAccess(request,response);
    String did = request.getParameter("did");
    String typeName = request.getParameter("typeName");	
    String orgId = request.getParameter("orgId");
	did = did==null?"":did;
	typeName = typeName==null?"":typeName;	
	orgId = orgId==null?"":orgId;
    String dicttype_name = "";
    Data dtype = null;
    if(did != null){
		DictManager dictManager = new DictManagerImpl();
		dtype = dictManager.getDicttypeById(did);
		dicttype_name = dtype.getName();
		typeName = dtype.getDescription().trim();
	}
    String rootId = did + ":root:root";
    String rootName = dicttype_name;
%>
<html>
<head>
<title></title>

<link rel="stylesheet" type="text/css" href="../../css/treeview.css">
<link rel="stylesheet" type="text/css" href="../../css/windows.css">
<link rel="stylesheet" type="text/css" href="../../css/contentpage.css">
<link rel="stylesheet" type="text/css" href="../../css/tab.winclassic.css">

</head>
<%@ include file="/epp/css/cssControl.jsp"%><body >
<p align="center"><font size=2><strong><%=typeName%>(<%=dtype.getDataTableName()%>)</strong></font>
<div id="contentborder">
    <table cellspacing="1" cellpadding="0" border="0"  width=100%  >
        <tr><td>
         <tree:tree tree="dictdata_tree"     			   
    			   node="dict_tree.node" 
    	           imageFolder="../../images/tree_images/" 
    	           collapse="true"
    			   includeRootNode="true"    			   
    			   href="newDictdata.jsp"    			   
    			   target="hiddenFrame"
    			   mode="static-dynamic"
    			   >        
    			   <tree:param name="orgId"/>
    			   <tree:param name="did"/>
    			   <tree:param name="typeName"/>                                     
                   <tree:checkbox recursive="true" partuprecursive="true" name="dictdataValue"/> 
    			   <tree:treedata treetype="com.chinacreator.dictionary.UsualDictDataTree" 
    	                   scope="request"
    	                   rootid="<%=rootId%>"  
    	                   rootName="<%=typeName%>"
    	                   expandLevel="1"
    	                   checkboxValue="true"
    	                   showRootHref="false" 
    	                   needObserver="false"
    	                   refreshNode="false"
    	                   />
    	</tree:tree>    	
       </td></tr>
    </table>
</div>

</body>

</html>
<iframe name="hiddenFrame" width=0 height=0></iframe>

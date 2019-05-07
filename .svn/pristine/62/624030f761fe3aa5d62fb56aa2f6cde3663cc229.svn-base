<%@ include file="../../include/global1.jsp"%>
<%@ include file="../../base/scripts/panes.jsp"%>
<%@ page import="com.frameworkset.dictionary.Data" %>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase" %>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityConstants" %>
<%@ page import="com.chinacreator.dictionary.DictManager" %>
<%@ page import="com.chinacreator.dictionary.DictManagerImpl" %>
<%@ page import="org.frameworkset.spi.BaseSPIManager" %>
<%@ page import="java.util.*" %>
<%@ taglib uri="/WEB-INF/treetag.tld" prefix="tree" %>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%
    AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
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
<%@ include file="/epp/css/cssControl.jsp"%><body  class="contentbodymargin" scroll="yes">

<div id="contentborder">
    <p><%=typeName%>
    <table cellspacing="1" cellpadding="0" border="0"  width=100%  >
    	
    	
        <tr><td>
         <tree:tree tree="dictdata_tree"     			   
    			   node="dict_tree.node" 
    	           imageFolder="../../images/tree_images/" 
    	           collapse="true"
    			   includeRootNode="true"    			   
    			   href="newDictdata.jsp"    			   
    			   target="hiddenFrame"
    			   mode="static"
    			   
    			   >                                            
                   <tree:checkbox uprecursive="true" recursive="true" name="dictdataValue"/> 
    			   <tree:treedata treetype="com.chinacreator.dictionary.UsualDictDataTree" 
    	                   scope="request"
    	                   rootid="<%=rootId%>"  
    	                   rootName="<%=rootName%>"
    	                   expandLevel="1"
    	                   checkboxValue="true"
    	                   showRootHref="true"
    	                   needObserver="false"
    	                   refreshNode="false"
    	                   
    	                   />
    	</tree:tree>    	
         </td></tr>
    </table>
</div>

</body>
<script>
	<%
	    if(!"".equals(did)){
		    List selectedValues = new ArrayList();
			if(!"".equals(orgId) && !"".equals(did)){
			    DictManager dictManager = new DictManagerImpl();    
			    selectedValues = dictManager.getDictdatasByOrgIdAndTypeId2(orgId,did);
			    for(int i=0;i<selectedValues.size();i++){
			        String value = (String)selectedValues.get(i);
	%>
			        var arr = new Array();
			        arr = document.getElementsByName("dictdataValue");
			        for(var j=0;j<arr.length;j++){
			            if(arr[j].value=="<%=value%>"){
			                arr[j].checked = true;
			                break;
			            }
			        }
	<%	        
			    }	    
			}
		}
	
	%>
	</script> 
</html>
<iframe name="hiddenFrame" width=0 height=0></iframe>

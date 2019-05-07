<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ taglib uri="/WEB-INF/treetag.tld" prefix="tree" %>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.resource.ResourceManager,
                 com.chinacreator.sysmgrcore.manager.db.OrgAdministratorImpl,
                 org.apache.commons.lang.StringUtils"%>
<%
AccessControl accessControl = AccessControl.getInstance();
accessControl.checkAccess(request,response);       
String org_ids = StringUtils.defaultString(request.getParameter("org_ids"));
%> 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<title>组织机构</title>
<script language="javascript">

function uf_ok(){
	var orgs = document.getElementsByName("orgid");
	var orgIds = "";
	var orgNames = "";		
	for(var i=0;i<orgs.length;i++){
		if(orgs[i].checked){			
			var arr = new Array();
			arr = orgs[i].value.split(",");
			orgIds = orgIds + arr[0] + ",";
			orgNames = orgNames  + arr[1] + ",";	
		}
	}
	orgIds = orgIds.substring(0,orgIds.length-1);				
	orgNames = orgNames.substring(0,orgNames.length-1);		
	window.close();
	window.returnValue=orgIds+";"+orgNames;
}
</script>
<script type="text/javascript" language="javascript">
//设置树结点的样式
function setTreeNodeClass(){
	var allTd = document.getElementsByTagName("td");
	for(var i = 0;i < allTd.length;i++){	    
		allTd[i].className = "tdclass_act";
	}
}
</script>
<style type="text/css">
<!--
.tdclass_act{
font-size:14px;
}
-->
</style>
	<link href="/sysmanager/css/windows.css" rel="stylesheet" type="text/css">
	<link href="/sysmanager/css/tab.winclassic.css" rel="stylesheet"
		type="text/css">
	<link href="/sysmanager/css/contentpage.css" rel="stylesheet" type="text/css">
	<link href="/sysmanager/css/windows.css" rel="stylesheet"
		type="text/css">
	<link href="/sysmanager/css/tab.winclassic.css" rel="stylesheet"
		type="text/css">
	<link href="/sysmanager/css/contentpage.css" rel="stylesheet"
		type="text/css">
</head>
<body class="contentbodymargin">
<div align="center" style="width:100%;height:90%;overflow:auto;">
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table" >
  <tr height=30>
  <td align="center">
  	机构选择
  </td>  
  </tr>
</table>
    <table >
        <tr><td align="left">
         <tree:tree tree="unrecursive_office_org_tree"
    	           node="unrecursive_office_org_tree.node"
    	           imageFolder="/purviewmanager/images/tree_images/"
    	           collapse="false"
    			   includeRootNode="true"        			  
    			   mode="static-dynamic"
    			   >
    			   <tree:param name="org_ids" value="<%=org_ids%>"></tree:param>    			
    			   <tree:checkbox name="orgid" recursive="false" uprecursive="false"></tree:checkbox>
    			   <tree:treedata treetype="com.chinacreator.eform.systemManager.OrgTreeOffice"
    	                   scope="request"
    	                   rootid="0"  
    	                   rootName="组织机构"
    	                   expandLevel="1"
    	                   showRootHref="true"
    	                   needObserver="false"    	                   
    	                   />					
    	</tree:tree>
         </td></tr>
    </table>
    </div>
    <br/>
    <div align="center">
			<table width="25%" border="0" align="center" cellpadding="0" cellspacing="0">
				<tr>
					<td><div align="left">
					     <input name="Submit" type="button" class="input" value="确定"
											onClick="uf_ok()">
						</div>
					</td>
					<td>
						<div align="left">
						  <input name="cancel" type="button" class="input" value="取消"
											onClick="window.close()">
						</div>
					</td>
				</tr>
			</table>
	</div>
</body>
<script language="JavaScript">
    if(document.getElementsByName("orgid")){
    	var orgusers = document.getElementsByName("orgid");
    	for(var i=0; i<orgusers.length; i++){
        	if(orgusers[i].disabled == true){
            	orgusers[i].style.display = "none";
        	}
   		}
	}
	setTreeNodeClass();
	</script>
</html>

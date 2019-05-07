<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.sysmgrcore.web.struts.form.UserOrgManagerForm" %>
<%@ page import="com.chinacreator.sysmgrcore.manager.UserManager" %>
<%@ page import="com.chinacreator.sysmgrcore.entity.*"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase" %>
<%@ taglib uri="/WEB-INF/treetag.tld" prefix="tree" %>
<%@page import="com.chinacreator.security.AccessControl"%>

<html>
<head>
<title>选择机构</title>
<link rel="stylesheet" type="text/css" href="../css/treeview.css">
<link rel="stylesheet" type="text/css" href="../css/windows.css">
<%
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request,response);
	String orgNames = request.getParameter("orgNames");

%>

<script language="javascript">
function addorg(){
	var orgValues="";
	var orgIds = "";
	var state = false;
	var orgs = document.all.orgIdName;
  	for(var i = 0;i < orgs.length; i++){
  		if(orgs[i].checked){
  		    var values = orgs[i].value
  		    var tmp = values.split(" ");
  			if(state){  			    
  				orgValues += "," + values;
  				if(tmp.length>0){
  					orgIds += "," + tmp[0];
  				}
  			}else{
  				orgValues = values;
  				if(tmp.length>0){
  					orgIds = tmp[0];
  				}
  				state = true;
  			}
  		}
  	}

  	window.returnValue=orgValues + "^" + orgIds;
  	window.close();
}
</script>
</head> 
<%@ include file="/epp/css/cssControl.jsp"%><body  class="contentbodymargin">
<div id="contentborder">
<center>
<form id="OrgJobForm" name="OrgJobForm" action="" method="post" >
<table width="80%" border="0" cellpadding="0" cellspacing="1">
  <tr class="tabletop">
    <td width="40%" align="center"></td>    
  </tr>
  <tr >
     <td >
     
    <tree:tree tree="user_org_tree111"
    	           node="user_org_tree111.node"
    	           imageFolder="../../sysmanager/images/tree_images/"
    	           collapse="true"
    			   includeRootNode="true"
				   href=""
    			   target=""
    			   mode="static"
    			   >   
    			   <tree:param name="checkBoxOne"/>
				   <tree:radio name="orgIdName" />
    			   <tree:treedata treetype="com.chinacreator.menu.DictOrgSelect"
    	                   scope="request"
    	                   rootid="0"  
    	                   rootName="机构树"
    	                   expandLevel="1"
    	                   showRootHref="false"
    	                   needObserver="false"
    	                   refreshNode="false"
    	                   />

    	</tree:tree>
	</td>			 
				  
  </tr>
  <tr>
  <td align="center" >
  <input name="add" type="button" class="input" value="确定" onclick="addorg()">
  <input name="ced" type="button" class="input" value="关闭" onclick="window.close();">
  </td>
  </tr>
<iframe name="getOrg" width="0" height="0" ></iframe>  
</table>
<script>
	var name = "<%=orgNames%>";
	var names = name.split(",");
	for(var i = 0;document.all.orgIdName && i < document.all.orgIdName.length; i++){
  		var org = document.all.orgIdName[i];
  		for(var n = 0; n < names.length; n++){
			if(names[n]==org.value){
				org.checked="true";
			}
		}
  	}
</script>
</form>
</center>
</div>
<IFRAME name="delDisperse" height="0" width="0"></IFRAME>
</body>
</html>

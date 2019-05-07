<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ taglib uri="/WEB-INF/treetag.tld" prefix="tree" %>
<%@page import="com.chinacreator.security.AccessControl"%>
<%
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request,response);	
	String inputName = (String) request.getParameter("inputName");
	String inputValue = (String) request.getParameter("inputValue");
%>
<html>
<head>    
  <title>选择频道</title>
  <script language="JavaScript"> 
  function addorg(){	
  	var chkbx = document.all("channelId");
	//没有选择
  	if(!chkbx){  	
  		alert("您没有选择频道");
  		return;
  	}
	var n=document.all("channelId").length;
	
	var backstring = "";	
	if(!n)
	{
		backstring = chkbx.value;
	}
	else
	{
	
		for(var i= 0;i<n;i++){
			if(chkbx[i].checked){
				var tmp = chkbx[i].value;
				backstring =tmp;
				break;		
			}
		}
	}
	
	
	var id = backstring.slice(0,backstring.indexOf(":"));
	var name = backstring.slice(backstring.indexOf(":")+1,backstring.length);
	
	//alert(backstring);
	//alert(window.dialogArguments.document.URL);
	window.dialogArguments.document.all("<%=inputName%>").value=name;	
	window.dialogArguments.document.all("<%=inputValue%>").value=id;	
	//alert(window.dialogArguments.document.forms[0].ou.value);
	//alert(id);
	//window.dialogArguments.document.forms[0].orgId.value=id;	
	window.close();
	
}
</script>
  <link rel="stylesheet" type="text/css" href="../../sysmanager/css/windows.css">
  <link rel="stylesheet" type="text/css" href="../../sysmanager/css/treeview.css"> 
<body class="contentbodymargin">
<div id="contentborder">
<center>
<form name="OrgJobForm" action="" method="post" >
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
    			   dynamic="false"
    			   >                         
                   <tree:param name="channelName"/>
                   <tree:radio name="channelId" defaultValue=""/>     


    			   <tree:treedata treetype="com.chinacreator.cms.statisticManage.tree.ChannelTree"
    	                   scope="request"
    	                   rootid="0"  
    	                   rootName="频道树"
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
  </td>
  </tr>
<iframe name="getOrg" width="0" height="0"></iframe>  
</table>
</form>
</center>
</div>
</body>
</html>


<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ taglib uri="/WEB-INF/treetag.tld" prefix="tree" %>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%!
	
 %>
<%
AccessControl accessControl = AccessControl.getInstance();
accessControl.checkAccess(request,response);	                          
%> 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<title>平台机构树</title>
<script language="javascript">
function link(orgId,orgName){
	//var userFileUrl = parent.top_bar.document.getElementById("userFileUrl").value;
	//var orgFileUrl = parent.top_bar.document.getElementById("orgFileUrl").value;
	//var orgUserFileUrl = parent.top_bar.document.getElementById("orgUserFileUrl").value;
	//var userJobFileUrl = parent.top_bar.document.getElementById("userJobFileUrl").value;
	var queryString = document.getElementById("queryString").value;
	var org_user_obj = document.getElementById("org_user_obj").value;
	var queryString1 = "";
	if(org_user_obj.indexOf(";"+orgId+":")>=0||org_user_obj.indexOf(orgId+":")==0){
		var org_user_objs = org_user_obj.split(";");
		for(var i=0;i<org_user_objs.length;i++){
			if(org_user_objs[i].indexOf(";"+orgId+":")>=0||org_user_objs[i].indexOf(orgId+":")==0){
				queryString1 = org_user_objs[i].substring(orgId.length+1);
			}
		}
	}
	//document.getElementById("userXml").value=userFileUrl;
	//document.getElementById("orgXml").value=orgFileUrl;
	//document.getElementById("orgUserXml").value=orgUserFileUrl;
	//document.getElementById("userJobXml").value=userJobFileUrl;
	document.getElementById("queryString1").value=queryString1;
	document.getElementById("resName").value=orgName;
	document.getElementById("orgId").value=orgId;
	document.xmluser_list.submit();
	//parent.xmluser_list.location.href = "<%=request.getContextPath()%>/orgusermanager/orguser_tb/xml/xmlfilelist.jsp?userXml="+userFileUrl+"&orgUserXml="+orgUserFileUrl+"&orgXml="+orgFileUrl+"&orgId="+orgId+"&orgName="+orgName;
}
</script>
<link rel="stylesheet" type="text/css" href="../../../css/windows.css">
<link rel="stylesheet" type="text/css" href="../../../css/treeview.css">
</head>
<%@ include file="/epp/css/cssControl.jsp"%><body class="contentbodymargin" scroll="auto">
<table cellspacing="0" cellpadding="0" border="0">

<tr>
<td>
<form name="orgtreeform" action="" method="post"  >
    <table>
    	<%--<tr><td><input type=button name=bt2 value="返回" class="input" onclick="parent.history.go(-1)"/>	</td>
    	</tr>
        --%><tr><td align="left">
         <tree:tree tree="xml_tree"
    	           node="xml_tree.node"
    	           imageFolder="../../images/tree_images"
    	           collapse="true"
    			   includeRootNode="true"
    			   target="xmluser_list"
    			   href="javascript:link('','')" 
    			   mode="static-dynamic"
    			   >     
    			   <tree:treedata treetype="com.chinacreator.epp.util.orgusertb.XmlTree"
    	                   scope="request"
    	                   rootid="0"  
    	                   rootName="平台机构树"
    	                   expandLevel="1"
    	                   showRootHref="true"
    	                   needObserver="false"
    	                   enablecontextmenu="false"
    	                   />				
    	</tree:tree>
         </td></tr>
    </table>
	<input name="org_user_obj" value="" type="hidden">
</form>
<form name="xmluser_list" action="xmluser_list.jsp" target="xmluser_list" method="post">
	<input name="isRefresh" value="true" type="hidden">
	<input name="userJobXml" value="" type="hidden">
	<input name="queryString" value="" type="hidden">
	<input name="queryString1" value="" type="hidden">
	<input name="resName" value="" type="hidden">
	<input name="orgId" value="" type="hidden">
</form>
</td>
</tr>
	</table>
<div id=divProcessing style="width:200px;height:30px;position:absolute;left:200px;top:260px;display:none">
	<table border=0 cellpadding=0 cellspacing=1 bgcolor="#000000" width="100%" height="100%">
		<tr>
			<td bgcolor=#3A6EA5>
				<marquee align="middle" behavior="alternate" scrollamount="5">
					<font color=#FFFFFF>...处理中...请等待...</font>
				</marquee>
			</td>
		</tr>
	</table>
</div>
</body>
<iframe name="hiddenFrame" width=0 height=0></iframe>
</html>

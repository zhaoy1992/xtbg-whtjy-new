
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
	document.getElementById("queryString1").value=queryString;
	document.getElementById("orgName").value=orgName;
	document.ptuser_list.submit();
	//parent.ptuser_list.location.href = "<%=request.getContextPath()%>/orgusermanager/orguser_tb/ptldap/ptuser_list.jsp?queryString="+queryString+"&orgId=&orgName="+orgName+"&queryString1="+queryString;
}
function pttb(type){
	var confirmStr = "";
	if(type=='ptzl2ldap')confirmStr = "确定同步吗？该同步将完成平台机构用户到LDAP的一次性增量同步，对LDAP用户不做删除，直接新增或修改";
	if(type=='ptwq2ldap')confirmStr = "确定同步吗？该同步将完成平台机构用户到LDAP的一次性完全同步，对LDAP用户先做删除，再做同步";
	if(confirm(confirmStr)){
		document.getElementById("type").value = type;
		document.getElementById("pttbfprm").submit();
	}
}
</script>
</head>
<%@ include file="/epp/css/cssControl.jsp"%>
<body class="contentbodymargin" scroll="auto">
<%--<form name="pttbfprm" action="../do.jsp" method="post" target="hiddenFrame">
	<input name="type" value="" type="hidden">
    <table cellspacing="0" cellpadding="0" border="0" bordercolor="#EEEEEE" width=100%>
        <tr><td>
			<input type=button name=bt1 value="平台增量同步LDAP" class="input" onclick="pttb('ptzl2ldap')"/>
			<input type=button name=bt2 value="平台完全同步LDAP" class="input" onclick="pttb('ptwq2ldap')"/>	
        </td></tr>
    </table>
</form>
--%><form name="orgtreeform" action="" method="post"  >

    <table cellspacing="0" cellpadding="0" border="0" bordercolor="#EEEEEE" width=100%>
    	<%--<tr><td><input type=button name=bt2 value="返回" class="input" onclick="parent.history.go(-1)"/>	</td>
    	</tr>
        --%><tr><td align="left">
         <tree:tree tree="pt_tree"
    	           node="pt_tree.node"
    	           imageFolder="../../images/tree_images"
    	           collapse="true"
    			   includeRootNode="true"
    			   target="ldapuser_list" 
    			   mode="static-dynamic"
    			   >     
    			   <tree:treedata treetype="com.chinacreator.epp.util.orgusertb.LdapTree"
    	                   scope="request"
    	                   rootid="0"  
    	                   rootName="平台机构树"
    	                   expandLevel="1"
    	                   showRootHref="true"
    	                   needObserver="false"
    	                   enablecontextmenu="false"
    	                   />				
    	</tree:tree><!-- /orgusermanager/orguser_tb/ldapuser_list.jsp-->
         </td></tr>
    </table>
	<input name="org_user_obj" value="" type="hidden">
</form>
<form name="ptuser_list" action="ptuser_list.jsp" target="ptuser_list" method="post">
	<input name="queryString" value="" type="hidden">
	<input name="queryString1" value="" type="hidden">
	<input name="orgName" value="" type="hidden">
</form>
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

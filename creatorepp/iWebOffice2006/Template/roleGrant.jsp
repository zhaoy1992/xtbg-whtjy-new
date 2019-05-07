<%@ page language="java" contentType="text/html; charset=GBK"%>

<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ taglib uri="/WEB-INF/treetag.tld" prefix="tree"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.RoleManager"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="java.util.List"%>

<%@ page import="com.chinacreator.sysmgrcore.manager.OperManager,com.chinacreator.resource.ResourceManager"%>
<%@ page import="com.chinacreator.sysmgrcore.entity.*,com.chinacreator.sysmgrcore.entity.Roleresop"%>
<%@ page import="java.util.ArrayList"%>
<%
	AccessControl accessControl = AccessControl.getInstance();
	accessControl.checkAccess(pageContext);
	session.setAttribute("roleTabId", "1");
%>

<script type="text/javascript">
<!--
function uf_ok(){
	var roles = document.getElementsByName("roleid");
	var roleIds = "";
	var roleNames = "";		
	for(var i=0;i<roles.length;i++){
		if(roles[i].checked){			
			var arr = new Array();
			arr = roles[i].value.split(",");
			roleIds = roleIds + arr[0] + ",";
			roleNames = roleNames  + arr[1] + ",";	
		}
	}
	roleIds = roleIds.substring(0,roleIds.length-1);				
	roleNames = roleNames.substring(0,roleNames.length-1);		
	window.close();
	window.returnValue=roleIds+";"+roleNames+";role";
}
//-->
</script>
<html>
	<head>
		<title>角色授权</title>
		<link rel="stylesheet" type="text/css" href="/sysmanager/css/windows.css">
		<link rel="stylesheet" type="text/css" href="/sysmanager/css/treeview.css">		
		<link rel="stylesheet" type="text/css" href="/sysmanager/css/contentpage.css">
		<link rel="stylesheet" type="text/css" href="/sysmanager/css/tab.winclassic.css">
	</head>
	<body class="contentbodymargin" scroll="yes">
		<div id="contentborder" align="left">
				<form name="OrgJobForm" action="" method="post">
					<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table">
						<tr>
							<td>
								<div align="center">
									角色选择
									&nbsp;&nbsp;	
								</div>
							</td>
						</tr>
					</table>
					<table >					
						<tr>
							<td>
								<tree:tree tree="roleGrant_tree"
				    	           node="role_tree.node"
				    	           imageFolder="/sysmanager/images/tree_images/"
				    	           collapse="true"
				    			   includeRootNode="true" 			    			      			   
				    			   target="base_properties_toolbar"
				    			   mode="static"
				    			   >				    			
    			                 <tree:checkbox name="roleid"></tree:checkbox>
				    			 <tree:treedata treetype="com.chinacreator.eform.systemManager.RoleTree"
		    	                   scope="request"
		    	                   rootid="0"  
		    	                   rootName="角色"
		    	                   expandLevel="1"
		    	                   showRootHref="false"
		    	                   needObserver="false"
		    	                   />
				    			 </tree:tree>
							</td>
						</tr>
					</table>					
				</form>
				<div align="center">
				<table width="25%" border="0" align="right" cellpadding="0" cellspacing="0">
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
		</div>
	</body>
</html>
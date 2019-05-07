<%@ page language="java" import="org.apache.commons.lang.StringUtils" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ taglib uri="/WEB-INF/treetag.tld" prefix="tree"%>
<%@ include file="../../sysmanager/include/global1.jsp"%>
<%@ include file="../../sysmanager/base/scripts/panes.jsp"%>
<%
String userid = StringUtils.defaultString(request.getParameter("userid"));
%>
<head>
	<title></title>
	<style type="text/css">
<!--
.style1 {color: #CC0000}
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
	<base target="_self">

</head>
<html>
	<SCRIPT LANGUAGE="JavaScript"> 		
		function uf_ok(){
		        var orgusers = document.getElementsByName("orguser");
				var userids = "";
				var userRealNames = "";	
				var orgids = "";					
				for(var i=0;i<orgusers.length;i++){
					if(orgusers[i].checked)
					{						
						//alert(orgusers[i].value);
						if(orgusers[i].value.indexOf("user")!=-1)
						{
							var arr = new Array();							
							var arr = orgusers[i].value.substring(5).split(",");
							userids = userids + arr[0] + ",";
							userRealNames = userRealNames + arr[1] + ",";													
						}
						else if(orgusers[i].value.indexOf("org")!=-1)
						{
							var arr = new Array();							
							var arr = orgusers[i].value.substring(4).split(",");
							orgids = orgids + arr[0] + ",";
							//userRealNames = userRealNames + arr[1] + ",";
						}
					}
				}				
				userids = userids.substring(0,userids.length-1);		
				userRealNames = userRealNames.substring(0,userRealNames.length-1);	
				orgids = orgids.substring(0,orgids.length-1);	
				window.close();
				window.returnValue=userids + ";"+userRealNames+";"+orgids+";user";
		}
		
		//按下关闭按钮时刷新父窗口
		function window.onbeforeunload(){		         
		        	        
		}		
		
</SCRIPT>
	<body class="contentbodymargin" scroll="yes">		
		<div align="center">
			<br />
			<form action="" method="post">
				<pg:beaninfo requestKey="Apply">

					<fieldset style="width: 90%;">
						<LEGEND align=center>
							<FONT size="2">机构用户</FONT>
						</LEGEND>
						<table width="100%" height="35" border="0" align="left"
							cellpadding="0" cellspacing="1" class="table">								
							<tr>
								<td width="" class="detailcontent">
									<tree:tree tree="userGrant_tree"
										node="app_org_user_tree.node"
										imageFolder="/sysmanager/images/tree_images/" collapse="true"
										includeRootNode="true" dynamic="false">
										
										<tree:param name="userid" value="<%=userid%>"></tree:param>										
										<tree:checkbox name="orguser" recursive="true"
											uprecursive="true" />
										<tree:treedata
											treetype="com.chinacreator.eform.systemManager.OrgUserTree1"
											scope="request" rootid="0" rootName="机构用户树" expandLevel="1"
											showRootHref="false" needObserver="false" />
									</tree:tree>
								</td>
							</tr>
						</table>
						<br />
					</fieldset>
					<br />
					<br />
					<div align="center">
						<table width="25%" border="0" align="right" cellpadding="0"
							cellspacing="0">
							<tr>
								<td>
									<div align="left">
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
				</pg:beaninfo>
			</form>
		</div>
	</body>
	<script language="JavaScript">
    if(document.getElementsByName("orguser")){
    	var orgusers = document.getElementsByName("orguser");
    	for(var i=0; i<orgusers.length; i++){
        	if(orgusers[i].disabled == true){
            	orgusers[i].style.display = "none";
        	}
   		}
	}
	</script>
</html>
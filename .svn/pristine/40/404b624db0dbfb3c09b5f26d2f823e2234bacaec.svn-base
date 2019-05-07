<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ taglib uri="/WEB-INF/treetag.tld" prefix="tree"%>
<%@include file="expmenuconfigvo.jsp" %>

<head>
	<title>用户列表</title>
	
	<link href="../../css/windows.css" rel="stylesheet" type="text/css">
	<link href="../../css/tab.winclassic.css" rel="stylesheet" type="text/css">
	<link href="../../css/contentpage.css" rel="stylesheet" type="text/css">
	<link href="sysmanager/css/windows.css" rel="stylesheet" type="text/css">
	<link href="sysmanager/css/tab.winclassic.css" rel="stylesheet" type="text/css">
	<link href="sysmanager/css/contentpage.css" rel="stylesheet" type="text/css">
	<base target="_self">
	<script type="text/javascript">
		function getcheckid(){
			var selid = "";	
				var obj = document.getElementsByName("username");
				for (var i=0;i<obj.length;i++) {								
					if (obj[i].checked){
			       		selid += obj[i].value + ",";			       					       		
				   } 
				}				
				return selid;				
		}
	
	
		function sub(){
			window.returnValue=getcheckid();
			window.close();		
		}		
	</script>
</head>
<html>
	<%@ include file="/epp/css/cssControl.jsp"%>
	<body class="contentbodymargin" scroll="yes">
		<div align="center">
				<br />
				<br />
				<fieldset style="width: 90%;">
						<LEGEND align=center>
							<FONT size="2">创建人选择</FONT>
						</LEGEND>						
			<table width="30%">
				<tr>
					<td>
						<tree:tree tree="app_org_user_tree" node="app_org_user_tree.node" imageFolder="../../../sysmanager/images/tree_images/" collapse="true" includeRootNode="true" dynamic="false" mode="static">


							<tree:checkbox name="username" recursive="true" uprecursive="true" />

							<tree:treedata treetype="com.chinacreator.eppissue.menuissue.expmenu.menu.UserList" scope="request" rootid="0" rootName="机构用户树" expandLevel="1" showRootHref="false" needObserver="false" />
						</tree:tree>
					</td>
				</tr>
			</table>
			</fieldset>
			<input type="button" value="确定" class="input" onclick="sub();">			
		</div>
	</body>
</html>

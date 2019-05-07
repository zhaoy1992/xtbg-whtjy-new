<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ taglib uri="/WEB-INF/treetag.tld" prefix="tree"%>
<%@ page import="com.chinacreator.security.AccessControl"%>

<%
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request, response);
%>
<head>
	<title></title>
	<style type="text/css">
<!--
.style1 {color: #CC0000}
-->
</style>
	<link href="../../css/windows.css" rel="stylesheet" type="text/css">
	<link href="../../css/tab.winclassic.css" rel="stylesheet"
		type="text/css">
	<link href="../../css/contentpage.css" rel="stylesheet" type="text/css">
	<link href="sysmanager/css/windows.css" rel="stylesheet"
		type="text/css">
	<link href="sysmanager/css/tab.winclassic.css" rel="stylesheet"
		type="text/css">
	<link href="sysmanager/css/contentpage.css" rel="stylesheet"
		type="text/css">
	<base target="_self">
	<script language="JavaScript"
			src="<%=request.getContextPath()%>/purviewmanager/scripts/func.js"
			type="text/javascript"></script>


</head>
<html>
	<SCRIPT language="JavaScript" SRC="sysmanager/scripts/validateForm.js"></SCRIPT>
	<SCRIPT LANGUAGE="JavaScript"> 
		function jumpPage(){
		  	document.location.assign("../orgusersyninfo.jsp");
		  }
		function expexecl() 
		{	
			var orgusers = document.getElementsByName("orguser");
			var orguser = "";
			for(var i=0;i<orgusers.length;i++)
			{
				if(orgusers[i].checked)
				{
					orguser = orguser + ";" + orgusers[i].value;
				}
			}
			if(orguser==""){
				alert("请选择需导出的机构用户！");
				return;
			}
			if(confirm("确定导出吗？")){
				document.getElementById("checkorguser").value = orguser;
				document.expexeclform.submit();
			}
		}
	</SCRIPT>
	<%@ include file="/epp/css/cssControl.jsp"%><body class="contentbodymargin" scroll="yes">
		<div align="center">
			<br />
			<form name="expexeclform" action="expexecl_do.jsp"  method="post" target="execlhiddenFrame">
				<input type="hidden" name="checkorguser" id="checkorguser">
					<fieldset style="width: 90%;">
						<LEGEND align=center>
							<FONT size="2">平台导出到EXECL</FONT>
						</LEGEND>
						<table width="100%" height="35" border="0" align="left"
							cellpadding="0" cellspacing="1" class="table">							
							<tr>
								<td width="" class="detailcontent">
									<tree:tree tree="app_org_user_tree"
										node="app_org_user_tree.node"
										imageFolder="../../../sysmanager/images/tree_images/" collapse="true"
										includeRootNode="true" dynamic="false" mode="static">

										<tree:checkbox name="orguser" recursive="true"
											uprecursive="true" />

										<tree:treedata
											treetype="com.chinacreator.epp.ouexcelmanager.manager.ExpExeclTree"
											scope="request" rootid="0" rootName="平台机构用户树" expandLevel="1"
											showRootHref="false" needObserver="false" checkboxValue="0"/>
									</tree:tree>
								</td>
							</tr>
						</table>
						<br />
					</fieldset>
					<div align="right">
					<input type=button name=bt1 value="上一步" class="input" onclick="jumpPage();"/>
					<input type="button" class="input" name="sub" value="导出"
									onclick="expexecl();" />
					<input type="button" value="关闭" class="input"	onclick="window.close();" />
					</div>
			</form>
		</div>
		<iframe name="execlhiddenFrame" width=0 height=0></iframe>
	</body>
</html>

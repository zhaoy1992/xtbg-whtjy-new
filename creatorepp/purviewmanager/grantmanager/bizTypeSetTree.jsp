<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ taglib uri="/WEB-INF/treetag.tld" prefix="tree"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);

	String resTypeId = request.getParameter("resTypeId");
	String currRoleId = request.getParameter("currRoleId");
	String role_type = request.getParameter("role_type");
	String currOrgId = request.getParameter("currOrgId");
	String isBatch = request.getParameter("isBatch");
%>
<html>
	<head>
		<title>属性容器</title>
		<script language="JavaScript" src="changeView.js"
			type="text/javascript"></script>
		<link rel="stylesheet" type="text/css" href="../css/windows.css">
		<link rel="stylesheet" type="text/css" href="../css/treeview.css">
		<script language="Javascript">
		function saveReadorgname(){
			var checkValues = "";
			var un_checkValues = "";
			var arr = document.getElementsByName("checkboxValue");
			if(arr){
				for(var i = 0; i < arr.length; i++){
					if(arr[i].checked){
						if(checkValues==""){
							checkValues = arr[i].value;
						}else{
							checkValues += "," + arr[i].value;
						}
					}else{
						if(un_checkValues==""){
							un_checkValues = arr[i].value;
						}else{
							un_checkValues += "," + arr[i].value;
						}
					}
				}
			}
			document.Form1.checkValues.value = checkValues;
			document.Form1.un_checkValues.value = un_checkValues;
			var url = "saveTreeRoleresop_handle.jsp?resTypeId=<%=resTypeId%>&currRoleId=<%=currRoleId%>&role_type=<%=role_type%>&opId=readbiztype&currOrgId=<%=currOrgId%>&isBatch=<%=isBatch%>";
			document.Form1.target = "saveres";
			document.Form1.action = url;
			document.Form1.submit();
		}
		</script>
	</head>
	<%@ include file="/epp/css/cssControl.jsp"%><body class="contentbodymargin" scroll="no">
		<form name="Form1" method="post">
			<DIV align="center">
				<tr>
					<td>
						<input name="checkValues" value="" type="hidden" />
						<input name="un_checkValues" value="" type="hidden" />
						<input name="saveButton" value="保存" type="button"
							onclick="saveReadorgname()" class="input" />
						<input name="col" value="关闭页面" type="button"
							onclick="parent.window.close();" class="input" />
					</td>
				</tr>
			</DIV>

			<div id="contentborder" style="width:100%;height:530;overflow:auto">
				<table class="table" width="80%" border="0" cellpadding="0"
					cellspacing="1">
					<tr class="tr">
						<td class="td">
							<tree:tree tree="biztype_tree" node="biztype_tree.node"
								imageFolder="../../sysmanager/images/tree_images/"
								collapse="true" includeRootNode="true" href="" target=""
								dynamic="false">

								<tree:param name="resTypeId" />
								<tree:param name="currRoleId" />
								<tree:param name="role_type" />
								<tree:param name="currOrgId" />
								<tree:checkbox name="checkboxValue" recursive="true" uprecursive="true"/>

								<tree:treedata
									treetype="com.chinacreator.sysmgrcore.purviewmanager.menu.ResBizTypeTree"
									scope="request" rootid="0" rootName="业务类别" expandLevel="1"
									showRootHref="false" needObserver="false" refreshNode="true" />
							</tree:tree>
						</td>
					</tr>
				</table>
			</div>
			<iframe name="saveres" width="0" height="0"></iframe>
		</form>
	</body>
</html>

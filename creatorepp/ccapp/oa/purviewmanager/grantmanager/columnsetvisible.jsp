<%--
描述：菜单授权页面
作者：王博
版本：1.0
时间：2013-5-15
 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/WEB-INF/treetag.tld" prefix="tree"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkManagerAccess(request,response);
	
	String resTypeId = StringUtil.deNull(request.getParameter("resTypeId"));
	String currRoleId = StringUtil.deNull(request.getParameter("currRoleId"));
	String role_type = StringUtil.deNull(request.getParameter("role_type"));
	String currOrgId = StringUtil.deNull(request.getParameter("currOrgId"));
	String isBatch = StringUtil.deNull(request.getParameter("isBatch"));

%>
<html>
<head>
	<title>菜单授权</title>
	<!-- 引入jQuery -->
	<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
	<!-- 引入formvValidatetion -->
	<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
	<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script> 
	<script language="Javascript">
		function saveRoleMenu(){
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
			document.Form1.target = "hiddenFrame";
			document.Form1.submit();
		}
	</script>
</head>
<body style="overflow-y:hidden;">
	<form name="Form1" method="post" action="savetreeroleresopdo.jsp">
		<input name="checkValues" value="" type="hidden" />
		<input name="un_checkValues" value="" type="hidden" />
		<input name="resTypeId" value="<%=resTypeId%>" type="hidden" />
		<input name="currRoleId" value="<%=currRoleId%>" type="hidden" />
		<input name="role_type" value="<%=role_type%>" type="hidden" />
		<input name="opId" value="visible" type="hidden" />
		<input name="currOrgId" value="<%=currOrgId%>" type="hidden" />
		<input name="isBatch" value="<%=isBatch%>" type="hidden" />
		<input name="windowId" value="<%=StringUtil.deNull(request.getParameter("windowsId"))%>" type="hidden" />
		<div id="users-contain" style="width: 100%; height: 475; overflow: auto">
			<table class="table" width="80%" border="0" cellpadding="0" cellspacing="1">
				<tr class="tr">
					<td class="td" width="40%" align="center"></td>
				</tr>
				<tr class="tr">
					<td class="td">
						<tree:tree tree="role_column_tree"
							node="role_column_tree.node" imageFolder="../../../../purviewmanager/images/tree_images/"
							collapse="true" includeRootNode="true" href="" target=""
							mode="static">
			
						<tree:param name="resTypeId" />
						<tree:param name="currRoleId" />
						<tree:param name="role_type" />
						<tree:param name="currOrgId" />
						<tree:param name="isBatch" />
			
						<tree:checkbox recursive="true" uprecursive="true"
							partuprecursive="true" name="checkboxValue" />
			
						<tree:treedata
							treetype="com.chinacreator.sysmgrcore.purviewmanager.menu.MenuResTree"
							scope="request" rootid="0" rootName="菜单资源树" expandLevel="1"
							showRootHref="false" needObserver="false" refreshNode="true" />
						</tree:tree>
					</td>
				</tr>
			</table>
		</div>
		<div class="cue_box_foot" style="position: absolute;bottom: 0px;">
			<input class="but_y_01" type="button" value="关闭" onclick="removeAlertWindows('',true)" />
			<input  class="but_y_01" name="saveColumn"  value="保存" type="button" onclick="saveRoleMenu();" />
		</div>
	</form>
<iframe name="hiddenFrame" width="0" height="0"></iframe>
</body>
</html>

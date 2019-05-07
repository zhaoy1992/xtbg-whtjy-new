<%@ page contentType="text/html; charset=GBK"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.frameworkset.common.tag.contextmenu.ContextMenu"%>
<%@ page
	import="com.frameworkset.common.tag.contextmenu.ContextMenuImpl"%>
<%@ page
	import="com.frameworkset.common.tag.contextmenu.Menu,com.frameworkset.util.StringUtil,com.chinacreator.epp.xml.ParseXml,com.chinacreator.config.ConfigManager"%>
<%@ page import="com.chinacreator.framework.Framework"%>
<%
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request, response);

	//应该由当前的应用id获得对应的菜单文件信息
	//菜单文件名格式：module-{currentSystemID}.xml
	String currentSystemID = control.getCurrentSystemID();
	String moduleId = request.getParameter("moduleId");

	String itemId = StringUtil.replaceNull(request
			.getParameter("itemId"));
	String moduleXmlName = Framework.menu_folder+ "module.xml";
	if (currentSystemID != null && !currentSystemID.trim().equals("")
			&& !currentSystemID.trim().equals("module")) {
		moduleXmlName = Framework.menu_folder + "module-" + currentSystemID + ".xml";
	}
	//应该由当前的应用id获得对应的菜单文件信息
	ParseXml px = new ParseXml(moduleXmlName);
	String id = StringUtil.replaceNull(px.getNodePropById(itemId,
			"item", "id"));
	String name = StringUtil.replaceNull(px.getNodePropById(itemId,
			"item", "name"));
	//name = new String(name.getBytes("ISO8859_1"), "GBK");
	String isUsed = StringUtil.replaceNull(px.getNodePropById(itemId,
			"item", "used"));
	String navigatortoolbar = StringUtil.replaceNull(px
			.getNavigatortoolbar(itemId), "");
	String navigatorcontent = StringUtil.replaceNull(px
			.getNavigatorcontent(itemId), "");
	String workspacetoolbar = StringUtil.replaceNull(px
			.getWorkspacetoolbar(itemId), "");
	String workspacecontent = StringUtil.replaceNull(px
			.getWorkspacecontent(itemId), "");
	String moduletype = StringUtil.replaceNull(
			px.getModuletype(itemId), "1");
	String configtype = StringUtil.replaceNull(
			px.getConfigtype(itemId), "1");
	String itemdisicon = StringUtil.replaceNull(px.getItemdisicon(id),"");
			String itemenicon = StringUtil.replaceNull(px.getItemenicon(id),"");
	//修改状态
	String isEdit = "true";
%>
<html>
<head>
<title>菜单操作</title>
</head>
<%@ include file="/epp/css/cssControl.jsp"%><body>
<iframe name="additem" width=" 100%" height="100%"></iframe>
<div style="width: 0px;height: 0px;display: none;" >
	<form name="form" method="post">
		<input type="hidden" name="id" value="<%=id%>" />
		<input type="hidden" name="name" value="<%=name%>" />
		<input type="hidden" name="navigatortoolbar"
			value="<%=navigatortoolbar%>" />
		<input type="hidden" name="navigatorcontent"
			value="<%=navigatorcontent%>" />
		<input type="hidden" name="workspacetoolbar"
			value="<%=workspacetoolbar%>" />
		<input type="hidden" name="workspacecontent"
			value="<%=workspacecontent%>" />
		<input type="hidden" name="isUsed" value="<%=isUsed%>" />
		<input type="hidden" name="moduletype" value="<%=moduletype%>" />
		<input type="hidden" name="configtype" value="<%=configtype%>" />
		<input type="hidden" name="currentSystemID"
			value="<%=currentSystemID%>" />
		<input type="hidden" name="moduleId" value="<%=moduleId%>" />
		<input type="hidden" name="isEdit" value="<%=isEdit%>" />
		<input type="hidden" name="isFill" value="true" />
		<input type="hidden" name="itemdisicon" value="<%=itemdisicon%>" />
		<input type="hidden" name="itemenicon" value="<%=itemenicon%>" />
	</form>
	<script type="text/javascript">
<!--	
		var i = 0;
		if(i==0){
			additem.src="additemtab1.jsp";
			form.target="additem";
			form.action="additemtab1.jsp";	
			form.submit();
			i++;
		}
//-->
</script>
</div>
</body>
</html>

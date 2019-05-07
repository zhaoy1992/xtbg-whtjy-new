<%@ page contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.security.AccessControl,
			com.chinacreator.epp.xml.ParseXml,
			com.frameworkset.util.StringUtil,
			com.chinacreator.config.ConfigManager"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.LogManager"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>
<%@ page import="com.chinacreator.framework.Framework"%>
<%@ page import="com.chinacreator.epp.menuconfigure.ParseXmlAddDS"%>
<%
		try {
		AccessControl control = AccessControl.getInstance();
		control.checkAccess(request, response);
		//		用户信息（用户真实名称：用户帐号[用户ID]）
		String userInfo = control.getUserAttribute("userAccount") + ":"
		+ control.getUserAttribute("userName") + "["
		+ control.getUserAttribute("userID") + "]  ";
		//操作的ip地址
		String remoteAddr = request.getRemoteAddr();

		String currentSystemID = control.getCurrentSystemID();
		String moduleId = request.getParameter("moduleId");
		if (moduleId == null) {
			moduleId = "";
		}
		String isedit_item = StringUtil.replaceNull(request.getParameter("isedit_item"));
		String isdelete = StringUtil.replaceNull(request.getParameter("isdelete"));
		String dsName = StringUtil.replaceNull(request.getParameter("ds_name"));
		String id = StringUtil.replaceNull(request.getParameter("id"));
		String name = StringUtil.replaceNull(request
		.getParameter("name"));
		//name = new String(name.getBytes("ISO8859_1"), "GBK");
		String navigatortoolbar = StringUtil.replaceNull(request
		.getParameter("navigatortoolbar"));
		String navigatorcontent = StringUtil.replaceNull(request
		.getParameter("navigatorcontent"));
		String workspacetoolbar = StringUtil.replaceNull(request
		.getParameter("workspacetoolbar"));
		String workspacecontent = StringUtil.replaceNull(request
		.getParameter("workspacecontent"));
		String isUsed = StringUtil.replaceNull(request
		.getParameter("isUsed"));
		String moduletype = StringUtil.replaceNull(request
		.getParameter("moduletype"), "1");
		String configtype = StringUtil.replaceNull(request
		.getParameter("configtype"), "1");
		String isEdit = StringUtil.replaceNull(request
		.getParameter("isEdit"), "false");
		String itemdisicon = StringUtil.replaceNull(request.getParameter("itemdisicon"));
		String itemenicon = StringUtil.replaceNull(request.getParameter("itemenicon"));	
		
		//应该由当前的应用id获得对应的菜单文件信息
		String menufile = "module.xml";
		if (!currentSystemID.equals("module")) {
			menufile = "module-" + currentSystemID + ".xml";

		}

		//ParseXml px = //new ParseXml(Framework.menu_folder + menufile);
		ParseXmlAddDS px= new ParseXmlAddDS(Framework.menu_folder + menufile);
		if (isEdit.equals("true")) {
			String moduleName = px.getMenuPropByItemId(id, "name");
			//修改菜单项之前需要判断重ID和重名冲突
			if (px.idDuplicate(id, false)) {
%>
	<script language="javascript">
		alert("有模块或菜单项的Id与其重名!");
		window.close();
		window.returnValue="refresh";
	</script>
<%--<%
		} else if (px.nameDuplicate(name, false)) {
%>
	<script language="javascript">
		alert("有模块或菜单项的Name与其重名!");
		window.close();
		window.returnValue="refresh";
	</script>
--%><%
		} else {
			px.updateItem(moduleId, id, name, navigatortoolbar,
				navigatorcontent, workspacetoolbar,
				workspacecontent, isUsed, moduletype,
				configtype,isedit_item,isdelete,dsName,itemdisicon,itemenicon); 
		//		 ********************开始记录日志********************
		// 日志管理接口
		LogManager logMgr = SecurityDatabase.getLogManager();
		// 用户信息
		String operUser = userInfo;
		// 日志内容
		String operContent = userInfo + "  修改子菜单:" + name + "["
				+ id + "]";
		// 日志类型
		String operModule = "菜单管理";
		// 操作的ip地址
		String operSource = remoteAddr;
		// 写入日志
		logMgr.log(operUser, operContent, operModule,
				operSource);
		// ********************日志记录结束********************
%>
	<script language="javascript">
		alert("修改成功!");
		window.close();
		window.returnValue="refresh";
	</script>
<%
		}
		} else {
			//添加菜单项之前需要判断重ID和重名冲突
			if (px.idDuplicate(id, true)) {
%>
	<script language="javascript">
		alert("有模块或菜单项的Id与其重名!");
		window.close();
		window.returnValue="refresh";
	</script>
<%--<%
} else if (px.nameDuplicate(name, true)) {
%>
<script language="javascript">
					alert("有模块或菜单项的Name与其重名!");
					window.close();
					window.returnValue="refresh";
				</script>--%>
<%
		} else {
		px.createItem(moduleId, id, name, navigatortoolbar,
				navigatorcontent, workspacetoolbar,
				workspacecontent, isUsed, moduletype,
				configtype,isedit_item,isdelete,dsName,itemdisicon,itemenicon);

		//		 ********************开始记录日志********************
		// 日志管理接口
		LogManager logMgr = SecurityDatabase.getLogManager();
		// 用户信息
		String operUser = userInfo;
		// 日志内容
		String operContent = userInfo + "  新增子菜单:" + name + "["
				+ id + "]";
		// 日志类型
		String operModule = "菜单管理";
		// 操作的ip地址
		String operSource = remoteAddr;
		// 写入日志
		logMgr.log(operUser, operContent, operModule,
				operSource);
		// ********************日志记录结束********************
%>
	<script language="javascript">
		alert("新增成功!");
		window.close();
		window.returnValue="refresh";
	</script>
<%
		}
		}
	} catch (Exception e) {
		e.printStackTrace();
	}
%>

<script>
    window.onload = function prompt()
    {
        //parent.divProcessing.style.display="none";
        parent.location.reload();
    }
</script>

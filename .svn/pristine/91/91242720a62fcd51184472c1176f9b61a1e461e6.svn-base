<%@ page contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.security.AccessControl,com.chinacreator.epp.xml.ParseXml,com.chinacreator.config.ConfigManager"%>
<%@ include file="../../sysmanager/base/scripts/panes.jsp"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.LogManager"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>
<%@ page import="com.chinacreator.framework.Framework"%>
<%
		try {
		System.out.println("deleteitem_do.jsp");
		AccessControl control = AccessControl.getInstance();
		control.checkAccess(request, response);
		//		用户信息（用户真实名称：用户帐号[用户ID]）
		String userInfo = control.getUserAttribute("userAccount") + ":"
		+ control.getUserAttribute("userName") + "["
		+ control.getUserAttribute("userID") + "]  ";
		//操作的ip地址
		String remoteAddr = request.getRemoteAddr();

		String currentSystemID = control.getCurrentSystemID();
		String itemId = request.getParameter("itemIds");
		if (itemId == null) {
			itemId = "";
		}
		String[] itemIds = itemId.split(";");

		//应该由当前的应用id获得对应的菜单文件信息
		String menufile = "module.xml";
		if (!currentSystemID.equals("module")) {
			menufile = "module-" + currentSystemID + ".xml";
		}
		ParseXml px = new ParseXml(Framework.menu_folder + menufile);

		// 日志管理接口
		LogManager logMgr = SecurityDatabase.getLogManager();
		// 用户信息
		String operUser = userInfo;
		//		 日志类型
		String operModule = "菜单管理";
		// 操作的ip地址
		String operSource = remoteAddr;

		for (int i = 0; i < itemIds.length; i++) {
			//	子菜单名称
			String itemname = px.getElementById("item", itemIds[i])
			.getAttribute("name");

			px.removeNode(itemIds[i], "item");

			//	 ********************开始记录日志********************

			// 日志内容
			String operContent = userInfo + "  删除子菜单:" + itemname + "["
			+ itemIds[i] + "]";

			// 写入日志
			logMgr.log(operUser, operContent, operModule, operSource);
			// ********************日志记录结束********************
		}
%>
<script language="javascript">
			alert("删除成功!");	
			getNavigatorContent().location.href=getNavigatorContent().location.reload();			
		</script>
<%
		} catch (Exception e) {
		e.printStackTrace();
	}
%>

<script>
    window.onload = function prompt()
    {
        parent.divProcessing.style.display="none";
        parent.location.reload();
    }
</script>

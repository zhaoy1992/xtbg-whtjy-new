<%@ page contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.security.AccessControl,com.chinacreator.epp.xml.ParseXml,com.chinacreator.config.ConfigManager"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.LogManager"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>
<%@ page import="com.chinacreator.framework.Framework"%>
<%@ include file="../../sysmanager/base/scripts/panes.jsp"%>
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
		String moduleId = request.getParameter("moduleIds");
		if (moduleId == null) {
			moduleId = "";
		}
		String[] moduleIds = moduleId.split(";");

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
		// 日志类型
		String operModule = "模块管理";//modify by zzz
		// 操作的ip地址
		String operSource = remoteAddr;

		for (int i = 0; i < moduleIds.length; i++) {
			//模块名称
			String modulename = px.getMenuElement(moduleIds[i]).getAttribute("name");

			px.removeNode(moduleIds[i], "module");
			//	 ********************开始记录日志********************
			// 日志内容
			String operContent = userInfo + "  删除模块:" + modulename
			+ "[" + moduleIds[i] + "]";

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

<%@ page contentType="text/html; charset=GBK"%>
<%@ page
	import="com.chinacreator.security.AccessControl,com.chinacreator.epp.xml.ParseXml,com.frameworkset.util.StringUtil,com.chinacreator.config.ConfigManager,java.util.List"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.LogManager"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>
<%@ page import="com.chinacreator.framework.Framework"%>
<%@ page import="com.chinacreator.epp.menuconfigure.ParseXmlAddDS"%>
<%
		try {
		AccessControl control = AccessControl.getInstance();
		control.checkAccess(request, response);
		//用户信息（用户真实名称：用户帐号[用户ID]）
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

		String id = StringUtil.replaceNull(request.getParameter("id"));
		String name = StringUtil.replaceNull(request
		.getParameter("name"));
		//name = new String(name.getBytes("ISO8859_1"), "GBK");
		String used = StringUtil.replaceNull(request
		.getParameter("used"));
		String isedit = StringUtil.replaceNull(request
		.getParameter("isedit"));
		String isdelete = StringUtil.replaceNull(request
		.getParameter("isdelete"));
		String description = StringUtil.replaceNull(request
		.getParameter("description"));
		//add by wen.zhu 20100804
		//增加图标 
		String menudisicon = StringUtil.replaceNull(request
				.getParameter("menudisicon"));
		String menuenicon = StringUtil.replaceNull(request
				.getParameter("menuenicon"));
		//System.out.println("menudisicon="+menudisicon+";\n menuenicon="+menuenicon);
		
		//description = new String(description.getBytes("ISO8859_1"), "GBK");

		//应该由当前的应用id获得对应的菜单文件信息
		String menufile = "module.xml";

		if (!currentSystemID.equals("module")) {
			menufile = "module-" + currentSystemID + ".xml";
		}
		String dsName = StringUtil.replaceNull(request
		.getParameter("ds_name"));
		//ParseXml px = new ParseXml(	Framework.menu_folder + menufile);
		ParseXmlAddDS px = new ParseXmlAddDS(Framework.menu_folder
		+ menufile);
		//添加模块之前需要判断重ID和重名冲突
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
			//px.createModule(moduleId,id, name, used, description);
			px.createModule(moduleId, id, name, used, isedit, isdelete,
			description, dsName,menudisicon,menuenicon);

			//	 ********************开始记录日志********************
			// 日志管理接口
			LogManager logMgr = SecurityDatabase.getLogManager();
			// 用户信息
			String operUser = userInfo;
			// 日志内容
			String operContent = userInfo + "  新增模块:" + name + "[" + id
			+ "]";
			// 日志类型
			String operModule = "模块管理";
			// 操作的ip地址
			String operSource = remoteAddr;
			// 写入日志
			logMgr.log(operUser, operContent, operModule, operSource);
			// ********************日志记录结束********************
%>
<script language="javascript">
		alert("新增成功!");
		window.close();
		window.returnValue="refresh";
	</script>
<%
	}
	} catch (Exception e) {
		e.printStackTrace();
	}
%>
<script language="javascript">
		window.onload = function prompt()
	    {
	        //parent.divProcessing.style.display="none";
	        parent.location.reload();
	    }
</script>

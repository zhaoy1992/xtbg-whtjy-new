<%@page contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.epp.xml.ParseXml"%>
<%@ page import="com.chinacreator.config.ConfigManager"%>
<%@ page import="com.chinacreator.epp.xml.Item"%>
<%@include file="expmenuconfigvo.jsp" %>
<%
	String modulepath = "module.xml";

	String app_id = control.getCurrentSystemID();
	
	String modulename = "";

	if (app_id != null && !app_id.trim().equals("")
			&& !app_id.trim().equals("module")) {
		modulepath = "module-" + app_id + ".xml";
	}

	if (moduleID != null && !moduleID.trim().equals("")) {
		ParseXml px = new ParseXml(ConfigManager.getInstance()
		.getConfigValue("menu.folder")
		+ modulepath);
		
		Item item =	px.getItemById(moduleID);
		
		modulename = item.getName();
	}
	

%>
<html>
	<head>
		<title>"<%=modulename %>"模块配置</title>
	</head>
	<%@ include file="/epp/css/cssControl.jsp"%>
	<body>
		<% if(moduleID!=null && !moduleID.trim().equals("")){ %>
		<iframe id="expmenuconfigmain"
			src="<%=request.getContextPath()%>/eppissue/menuissue/expmenu/expmenuconfiginfo.jsp?isFill=true&&moduleID=<%=moduleID %>"
			width="100%" height="100%" frameborder="0"></iframe>
		<%}else{ %>
			<table width="100%" border="0">
	  			<tr>
	    			<td align="center" nowrap="nowrap" style="color: #FF0000;">
	    			<br /><br /><br /><br /><br /><br /><br /><br /><br /><br />
	    			对不起！参数错误！请关闭窗口重新开始！
	    			<br /><br />
	    			<input type="button" class="input" value="关闭窗口" onclick="window.close();"> 
	    			</td>
	  			</tr>
			</table>
		<%} %>
	</body>
</html>

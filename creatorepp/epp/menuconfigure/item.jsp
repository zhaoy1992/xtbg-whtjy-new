<%@ page contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.frameworkset.util.StringUtil"%>
<%!
	//应该由当前的应用id获得对应的菜单文件信息
	//菜单文件名格式：module-{currentSystemID}.xml
	String currentSystemID = "";
	String moduleId = "";
	
	//菜单项ID
	String id = "";
	//	菜单项名称
	String name = "";	
	//导航区工作条
	String navigatortoolbar = "";
	//	导航区内容区
	String navigatorcontent = "";
	//	工作区工作条
	String workspacetoolbar = "";
	//	工作区内容区
	String workspacecontent = "";
	//	是否使用
	String isUsed = "true";
	//	模型选择
	String moduletype = "1";
	//	配置来源
	String configtype = "1";
	//	修改状态
	String isEdit = "false";
	String itemdisicon = "";
	String itemenicon = "";	
%>
<%
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request, response);
	
	String isFill = request.getParameter("isFill")!=null?request.getParameter("isFill"):"";

	if(isFill.equals("true")){
	//菜单项ID
	id = StringUtil.replaceNull(request.getParameter("id"));
	//	菜单项名称
	name = StringUtil.replaceNull(request.getParameter("name"));
	//name = new String(name.getBytes("ISO8859_1"), "GBK");
	//导航区工作条
	navigatortoolbar = StringUtil.replaceNull(request
			.getParameter("navigatortoolbar"));
	//	导航区内容区
	navigatorcontent = StringUtil.replaceNull(request
			.getParameter("navigatorcontent"));
	//	工作区工作条
	workspacetoolbar = StringUtil.replaceNull(request
			.getParameter("workspacetoolbar"));
	//	工作区内容区
	workspacecontent = StringUtil.replaceNull(request
			.getParameter("workspacecontent"));
	//	是否使用
	isUsed = StringUtil.replaceNull(request
			.getParameter("isUsed"));
	//	模型选择
	moduletype = StringUtil.replaceNull(request
			.getParameter("moduletype"), "1");
	moduletype = moduletype.trim().equals("")?"1":moduletype;
	//	配置来源
	configtype = StringUtil.replaceNull(request
			.getParameter("configtype"), "1");
	configtype = configtype.trim().equals("")?"1":configtype;
	//	修改状态
	isEdit = StringUtil.replaceNull(request
			.getParameter("isEdit"), "false");
	//	应该由当前的应用id获得对应的菜单文件信息
	//菜单文件名格式：module-{currentSystemID}.xml
	currentSystemID = control.getCurrentSystemID();
	moduleId = StringUtil.replaceNull(request
			.getParameter("moduleId"));	
	itemdisicon = StringUtil.replaceNull(request.getParameter("itemdisicon"));
	itemenicon = StringUtil.replaceNull(request.getParameter("itemenicon"));	
	}	
%>

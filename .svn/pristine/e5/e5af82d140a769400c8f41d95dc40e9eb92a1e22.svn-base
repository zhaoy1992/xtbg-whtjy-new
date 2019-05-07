<%@ page contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.frameworkset.util.StringUtil"%>
<%!
	//菜单选择ID
	String moduleID = "";

	//更新方式
	String updateType = "";

	//业务类别
	String workclass = "";

	// 名称
	String sel_name = "";

	// 创建人
	String creator_person = "";

	// 开始日期
	String begin_data = "";

	// 结束日期
	String end_data = "";

	// 排序方式
	String sort = "";

	//选择的表单ID
	String sel_eform_id = "";

	//选择的流程ID
	String sel_jawe_id = "";

	//选择的报表ID
	String sel_report_id = "";

	String isUserDB = "";	
%>
<%
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request, response);

	String isFill = StringUtil.replaceNull(request
			.getParameter("isFill"), "");

	if (isFill.equals("true")) {
		moduleID = StringUtil.replaceNull(request
		.getParameter("moduleID"), "");
		workclass = StringUtil.replaceNull(request
		.getParameter("workclass"), "");
		sel_name = StringUtil.replaceNull(request
		.getParameter("sel_name"), "");
		creator_person = StringUtil.replaceNull(request
		.getParameter("creator_person"), "");
		begin_data = StringUtil.replaceNull(request
		.getParameter("begin_data"), "");
		end_data = StringUtil.replaceNull(request
		.getParameter("end_data"), "");
		sort = StringUtil.replaceNull(request.getParameter("sort"), "");
		sel_eform_id = StringUtil.replaceNull(request
		.getParameter("sel_eform_id"), "");
		sel_jawe_id = StringUtil.replaceNull(request
		.getParameter("sel_jawe_id"), "");
		sel_report_id = StringUtil.replaceNull(request
		.getParameter("sel_report_id"), "");
		isUserDB = StringUtil.replaceNull(request
		.getParameter("isUserDB"), "");
	}
	//System.out.println("moduleID:"+moduleID);
	//System.out.println("workclass:"+workclass);
%>

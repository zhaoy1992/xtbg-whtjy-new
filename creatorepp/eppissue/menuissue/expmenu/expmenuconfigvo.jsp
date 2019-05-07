<%@ page contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.frameworkset.util.StringUtil"%>
<%!//菜单选择ID
	String moduleID = "";

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
	
	//初始选择的表单ID
	String init_sel_eform_id = "";

	//初始选择的流程ID
	String init_sel_jawe_id = "";

	//初始选择的报表ID
	String init_sel_report_id = "";
	
	// 初始选择文件路径 
	String  init_sel_filepath="";

	//默认业务类别
	String default_businessclass_id = "";

	//默认表单ID
	String default_eform_id = "";

	//默认流程ID
	String default_jawe_id = "";

	//默认报表ID
	String default_report_id = "";

	// 选择文件路径 added by 小猪 20100816
	String  sel_filepath="";
	
	//默认文件路径
	String default_filepath = "";%>
<%
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request, response);

	String isFill = StringUtil.replaceNull(request
			.getParameter("isFill"), "");
	
	if ("true".equals(isFill)) {
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
		default_businessclass_id = StringUtil.replaceNull(request
		.getParameter("default_businessclass_id"), "");		
		default_eform_id = StringUtil.replaceNull(request
		.getParameter("default_eform_id"), "");
		default_jawe_id = StringUtil.replaceNull(request
		.getParameter("default_jawe_id"), "");
		default_report_id = StringUtil.replaceNull(request
		.getParameter("default_report_id"), "");
		default_filepath = StringUtil.replaceNull(request
		.getParameter("default_filepath"), "");
		sel_filepath = StringUtil.replaceNull(request
		.getParameter("sel_filepath"), "");
		//temp_eform_id = StringUtil.replaceNull(request
		//		.getParameter("temp_eform_id"), "");
		
		init_sel_eform_id = StringUtil.replaceNull(request
		.getParameter("init_sel_eform_id"), "");
		init_sel_jawe_id = StringUtil.replaceNull(request
		.getParameter("init_sel_jawe_id"), "");
		init_sel_report_id = StringUtil.replaceNull(request
		.getParameter("init_sel_report_id"), "");
		init_sel_filepath = StringUtil.replaceNull(request
		.getParameter("init_sel_filepath"), "");
	}			
%>

<%@ page contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.frameworkset.util.StringUtil"%>
<%!//�˵�ѡ��ID
	String moduleID = "";

	//ҵ�����
	String workclass = "";

	// ����
	String sel_name = "";

	// ������
	String creator_person = "";

	// ��ʼ����
	String begin_data = "";

	// ��������
	String end_data = "";

	// ����ʽ
	String sort = "";

	//ѡ��ı�ID
	String sel_eform_id = "";

	//ѡ�������ID
	String sel_jawe_id = "";

	//ѡ��ı���ID
	String sel_report_id = "";
	
	//��ʼѡ��ı�ID
	String init_sel_eform_id = "";

	//��ʼѡ�������ID
	String init_sel_jawe_id = "";

	//��ʼѡ��ı���ID
	String init_sel_report_id = "";
	
	// ��ʼѡ���ļ�·�� 
	String  init_sel_filepath="";

	//Ĭ��ҵ�����
	String default_businessclass_id = "";

	//Ĭ�ϱ�ID
	String default_eform_id = "";

	//Ĭ������ID
	String default_jawe_id = "";

	//Ĭ�ϱ���ID
	String default_report_id = "";

	// ѡ���ļ�·�� added by С�� 20100816
	String  sel_filepath="";
	
	//Ĭ���ļ�·��
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

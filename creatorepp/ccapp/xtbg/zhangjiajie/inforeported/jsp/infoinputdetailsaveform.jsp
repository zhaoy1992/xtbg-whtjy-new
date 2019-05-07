<%@page import="com.chinacreator.xtbg.pub.util.StringUtil"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">


<%@page import="com.chinacreator.xtbg.zhangjiajie.inforeported.entity.InfoReportBaseInfoBean"%>
<%@page import="com.chinacreator.xtbg.zhangjiajie.inforeported.service.InfoReportServiceIfc"%>
<%@page import="com.chinacreator.xtbg.zhangjiajie.inforeported.service.impl.InfoReportServiceImpl"%>
<%@page import="com.chinacreator.xtbg.zhangjiajie.inforeported.entity.InfoReportAuditIdeaBean"%><html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<title>信息上报保存页面</title>
<%
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	String submittedinfo_id = request.getParameter("submittedinfo_id");
	String submittedinfo_title = request.getParameter("submittedinfo_title");
	String infotype_id = request.getParameter("infotype_id");
	String input_date = request.getParameter("input_date");
	String orgid = accesscontroler.getChargeOrgId();
	String orgname = accesscontroler.getChargeOrgName();
	String department = request.getParameter("department");
	String departmentid = request.getParameter("departmentid");
	String keyword = request.getParameter("keyword");
	String inputuser_name = accesscontroler.getUserName();
	String inputuser_id = accesscontroler.getUserID();
	String operwindowid=request.getParameter("operwindowid");
	String submit_content = request.getParameter("submit_content");
	String submit_content_phone =request.getParameter("edit_content_phone");
	String reportunits = request.getParameter("reportunits");
	String reportuser_name = request.getParameter("reportuser_name");
	String sendauditusers = request.getParameter("sendauditusers");
	String sendaudit_user_name = request.getParameter("sendaudit_user_name");
	String partunits = request.getParameter("partunits");
	String published_user_name = request.getParameter("published_user_name");
	String submittedinfo_typecode = request.getParameter("submittedinfo_typecode");
	String submittedinfo_typecode4getinfouser = request.getParameter("submittedinfo_typecode4getinfouser");
	String submittedinfo_typecode2delete = request.getParameter("submittedinfo_typecode2delete");
	String audit_idea = request.getParameter("audit_idea");
	String relese_time = request.getParameter("relese_time");
	String leadedit_state = StringUtil.deNull(request.getParameter("leadedit_state"));//是否是领导报送
	String windowId = request.getParameter("windowId");
	InfoReportBaseInfoBean infoReportBaseInfoBean = new InfoReportBaseInfoBean();
	if( null == submit_content_phone ||"".equals(submit_content_phone))
	{
		infoReportBaseInfoBean.setSubmit_content_phone(submit_content);
	}
	infoReportBaseInfoBean.setSubmit_content_phone(submit_content_phone);
	infoReportBaseInfoBean.setSubmittedinfo_id(submittedinfo_id);
	infoReportBaseInfoBean.setSubmittedinfo_title(submittedinfo_title);
	infoReportBaseInfoBean.setSubmittedinfo_typecode(submittedinfo_typecode);
	infoReportBaseInfoBean.setSubmittedinfo_typecode4getinfouser(submittedinfo_typecode4getinfouser);
	infoReportBaseInfoBean.setSubmittedinfo_typecode2delete(submittedinfo_typecode2delete);
	infoReportBaseInfoBean.setInfotype_id(infotype_id);
	infoReportBaseInfoBean.setOrg_id(orgid);
	infoReportBaseInfoBean.setOrg_name(orgname);
	infoReportBaseInfoBean.setDepartment(department);
	infoReportBaseInfoBean.setDepartmentid(departmentid);
	infoReportBaseInfoBean.setKeyword(keyword);
	infoReportBaseInfoBean.setInputuser_name(inputuser_name);
	infoReportBaseInfoBean.setInputuser_id(inputuser_id);
	infoReportBaseInfoBean.setSubmit_content(submit_content);
	infoReportBaseInfoBean.setReportunits(reportunits);
	infoReportBaseInfoBean.setReportunitsname(reportuser_name);
	infoReportBaseInfoBean.setSendauditusers(sendauditusers);
	infoReportBaseInfoBean.setSendauditusersname(sendaudit_user_name);
	infoReportBaseInfoBean.setPartunits(partunits);
	infoReportBaseInfoBean.setPartunitsname(published_user_name);
	infoReportBaseInfoBean.setInput_date(input_date);
	infoReportBaseInfoBean.setRelese_time(relese_time);
	infoReportBaseInfoBean.setLeadedit_state(leadedit_state);//是否是领导报送
	InfoReportAuditIdeaBean infoReportAuditIdeaBean = new InfoReportAuditIdeaBean();
	infoReportAuditIdeaBean.setAndit_opinion(audit_idea);
	infoReportAuditIdeaBean.setAndit_person(inputuser_name);
	infoReportAuditIdeaBean.setAndit_person_id(inputuser_id);
	boolean flag = true;
	
	try{
		InfoReportServiceIfc infoReportServiceIfc = new InfoReportServiceImpl();
		infoReportServiceIfc.InfoCommonSave(infoReportBaseInfoBean,infoReportAuditIdeaBean);
	}catch(Exception e){
		flag = false;
	}
	String tablepage = request.getParameter("tablepage");
	String tpage ="";
	if("2".equals(tablepage)){
		tpage = "#tabs-2";
	}else if("3".equals(tablepage)){
		tpage = "#tabs-3";
	}else if("1".equals(tablepage)){
		tpage = "#tabs-1";
	}
%>
</head>
<body>
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script type="text/javascript"
			src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript">
var mes = "";
var bool = true;
if(<%=flag%>){
	mes = "操作成功";
	bool = false;
var submitAlertOK = function(){
	     if("1" =='<%=tablepage%>' || "3" =='<%=tablepage%>' || "2" =='<%=tablepage%>'){
	 		if(removeWindows(''+111,true,false,true)){
	     		window.parent.parent.$("#tabs").tabs('select', '<%=tpage%>');
	     	}
	 	}else{
	 		parent.saveBack();
	 	}
	}
	var p={
			headerText:'操作信息',
			okName:'确认',
	        okFunction:submitAlertOK
	};
	alert('操作成功！',p);
	window.top.getIFrameDOM("_document_body_mian_firstPagerAAAS").location.reload();	
	
}else{
	mes = "操作失败";
	bool = false;
}
</script>
</body>
</html>
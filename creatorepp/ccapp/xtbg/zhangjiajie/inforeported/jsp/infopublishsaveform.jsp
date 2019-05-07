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
<title>信息发布保存页面</title>
<%
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	String submittedinfo_id = request.getParameter("submittedinfo_id");
	String submittedinfo_title = request.getParameter("submittedinfo_title");
	String infotype_id = request.getParameter("infotype_id");
	String orgid = request.getParameter("orgid");
	String orgname = request.getParameter("orgname");
	String keyword = request.getParameter("keyword");
	String inputuser_name = request.getParameter("inputuser_name");
	String inputuser_id = request.getParameter("inputuser_id");
	String submit_content = request.getParameter("submit_content");
	
	InfoReportBaseInfoBean infoReportBaseInfoBean = new InfoReportBaseInfoBean();
	InfoReportAuditIdeaBean infoReportAuditIdeaBean = new InfoReportAuditIdeaBean();
	infoReportBaseInfoBean.setSubmittedinfo_id(submittedinfo_id);
	infoReportBaseInfoBean.setSubmittedinfo_title(submittedinfo_title);
	infoReportBaseInfoBean.setInfotype_id(infotype_id);
	infoReportBaseInfoBean.setOrg_id(orgid);
	infoReportBaseInfoBean.setOrg_name(orgname);
	infoReportBaseInfoBean.setKeyword(keyword);
	infoReportBaseInfoBean.setInputuser_name(inputuser_name);
	infoReportBaseInfoBean.setInputuser_id(inputuser_id);
	infoReportBaseInfoBean.setSubmit_content(submit_content);
	infoReportAuditIdeaBean.setAndit_person(inputuser_name);
	infoReportAuditIdeaBean.setAndit_person_id(inputuser_id);
	boolean flag = true;
	
	try{
		InfoReportServiceIfc infoReportServiceIfc = new InfoReportServiceImpl();
		infoReportServiceIfc.InfoPublished(infoReportBaseInfoBean,infoReportAuditIdeaBean);
	}catch(Exception e){
		flag = false;
	}
%>
</head>
<body>
<script type="text/javascript">
var mes = "";
var bool = true;
if(<%=flag%>){
	mes = "操作成功";
	bool = false;
	parent.backTo();
}else{
	mes = "操作失败"	;
	bool = false;
}
window.parent.JqueryDialog.SubmitCompleted(mes, true, bool);
</script>
</body>
</html>
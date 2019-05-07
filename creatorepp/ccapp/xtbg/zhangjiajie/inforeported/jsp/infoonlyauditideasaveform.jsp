
<%@page import="com.chinacreator.xtbg.pub.util.StringUtil"%>
<%@page import="com.chinacreator.eform.util.Escape"%>
<%@page import="com.chinacreator.xtbg.zhangjiajie.inforeported.entity.InfoSource"%>
<%@page import="com.alibaba.fastjson.JSONObject"%><%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>

<%@page import="com.chinacreator.xtbg.zhangjiajie.inforeported.entity.InfoReportBaseInfoBean"%>
<%@page import="com.chinacreator.xtbg.zhangjiajie.inforeported.service.InfoReportServiceIfc"%>
<%@page import="com.chinacreator.xtbg.zhangjiajie.inforeported.service.impl.InfoReportServiceImpl"%>
<%@page import="com.chinacreator.xtbg.zhangjiajie.inforeported.entity.InfoReportAuditIdeaBean"%>
<%@page import="com.chinacreator.xtbg.zhangjiajie.inforeported.dao.InfoReportManagerDao"%>
<%@page import="com.chinacreator.xtbg.pub.util.DaoImplClassUtil"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%
	String submittedinfo_id = request.getParameter("submittedinfo_id");
	String submittedinfo_code = request.getParameter("submittedinfo_code");
	String submittedinfo_code2delete = request.getParameter("submittedinfo_code2delete");

	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	String inputuser_id = accesscontroler.getUserID();
	String inputuser_name = accesscontroler.getUserName();
	String audit_idea = Escape.unescape(StringUtil.deNull(request.getParameter("audit_idea")));
	
	InfoReportAuditIdeaBean infoReportAuditIdeaBean = new InfoReportAuditIdeaBean();
	InfoReportBaseInfoBean infoReportBaseInfoBean = new InfoReportBaseInfoBean();
	
	infoReportBaseInfoBean.setSubmittedinfo_id(submittedinfo_id);
	infoReportBaseInfoBean.setSubmittedinfo_typecode(submittedinfo_code);
	infoReportBaseInfoBean.setSubmittedinfo_typecode4getinfouser(submittedinfo_code);
	infoReportBaseInfoBean.setSubmittedinfo_typecode2delete(submittedinfo_code2delete);
	
	infoReportAuditIdeaBean.setSubmittedinfo_id(submittedinfo_id);

	infoReportAuditIdeaBean.setAndit_opinion(audit_idea);
	infoReportAuditIdeaBean.setAndit_person(inputuser_name);
	infoReportAuditIdeaBean.setAndit_person_id(inputuser_id);

	
	InfoReportServiceIfc infoReportServiceIfc = new InfoReportServiceImpl();
	infoReportServiceIfc.InfoViewSave(infoReportBaseInfoBean,infoReportAuditIdeaBean);


	JSONObject jsonObj = new JSONObject();
	jsonObj.put("ok",true);
	
	response.getWriter().print(jsonObj);
%>
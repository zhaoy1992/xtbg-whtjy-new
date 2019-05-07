<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.archive.entity.CircularizeBean"%>
<%@page import="com.chinacreator.xtbg.core.archive.service.DispenseService"%>
<%@page import="com.chinacreator.xtbg.core.archive.service.impl.DispenseServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.alibaba.fastjson.JSONObject"%>
<%
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	CircularizeBean bean  = new CircularizeBean();
	String busi_id = request.getParameter("busi_id");
	String ins_id = request.getParameter("ins_id");
	String action_form = request.getParameter("action_form");
	String title = request.getParameter("circularize_title");
	String busiTypeCode = request.getParameter("busiTypeCode");
	String template_id = request.getParameter("template_id");
	//String title  = DataControlUtil.pageUnEscape(request.getParameter("circularize_title"));
	String receive_userid = request.getParameter("receive_userid");
	String send_userid= accesscontroler.getUserID();
	
	DispenseService service = new DispenseServiceImpl();
	boolean result = service.dispense(busi_id, send_userid, receive_userid, title, action_form, ins_id, busiTypeCode, template_id);
	JSONObject jsonObj = new JSONObject();
	jsonObj.put("result",result);
	out.print(jsonObj);

%>

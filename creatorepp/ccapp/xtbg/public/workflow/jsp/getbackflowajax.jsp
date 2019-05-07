
<%@page import="com.chinacreator.xtbg.pub.workflow.service.impl.WorkFlowServiceImpl"%>
<%@page import="com.chinacreator.xtbg.pub.workflow.service.WorkFlowServiceIfc"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.pub.util.DaoImplClassUtil"%>
<%@page import="com.alibaba.fastjson.JSONObject"%>
<%@page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	WorkFlowServiceIfc workFlowServiceIfc = new WorkFlowServiceImpl();
	String actUsername = request.getParameter("actUsername");
	String actInsId = request.getParameter("actInsId");
	String insid = request.getParameter("insid");
	String busiId = request.getParameter("busiId");
	JSONObject jsonObj = new JSONObject();
	//int return1 = workFlowServiceIfc.back(actUsername,actInsId,busiId,"","");
	//jsonObj.put("issucess",return1);
	workFlowServiceIfc.recycle(actUsername,actInsId,busiId,"",insid);
	response.getWriter().print(jsonObj);
%>

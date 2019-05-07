<%@page import="com.chinacreator.xtbg.pub.flowinfoconif.service.impl.FlowInfoConfigServiceImpl"%>
<%@page import="com.chinacreator.xtbg.pub.flowinfoconif.service.FlowInfoConfigServiceIfc"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.alibaba.fastjson.JSONObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	String jsonparam = request.getParameter("jsonparam");
	FlowInfoConfigServiceIfc flowInfoConfigService = new FlowInfoConfigServiceImpl();
	flowInfoConfigService.saveFlowWfactionFormDefInfo(jsonparam);
	JSONObject jsonObj = new JSONObject();
	jsonObj.put("ok",true);
	response.getWriter().print(jsonObj);

%>

<%--
　　描述：保存设置活动环节权限功能页面
　　作者：黄海
　　版本：1.0
　　日期：2013-05-29
--%>
<%@page import="com.chinacreator.xtbg.core.process.processconfig.service.impl.FlowInfoConfigServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.process.processconfig.service.FlowInfoConfigServiceIfc"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.alibaba.fastjson.JSONObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	String jsonparam = request.getParameter("jsonparam");
	boolean flag = true;
	FlowInfoConfigServiceIfc flowInfoConfigService = new FlowInfoConfigServiceImpl();
	try{
		flowInfoConfigService.saveActColStatusForm(jsonparam);
	}catch(Exception e){
		flag = false;
	}
	JSONObject jsonObj = new JSONObject();
	jsonObj.put("data",flag);
	out.print(jsonObj);
%>

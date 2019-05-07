
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.home.service.impl.HomeServiceImpl"%>
<%@page import="com.chinacreator.xtbg.home.service.HomeServiceIfc"%>
<%@page import="com.alibaba.fastjson.JSONObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
AccessControl accesscontroler = AccessControl.getInstance();
accesscontroler.checkAccess(request, response);
	String jsonparam = request.getParameter("jsonparam");
	
	HomeServiceIfc homeServiceIfc = new HomeServiceImpl();
	boolean flag = homeServiceIfc.saveHomeConfig(jsonparam);
	JSONObject jsonObj = new JSONObject();
	jsonObj.put("edit_id",flag);
	
	response.getWriter().print(jsonObj);

%>
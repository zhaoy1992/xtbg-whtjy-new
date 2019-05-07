
<%@page import="com.chinacreator.xtbg.pub.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.pub.util.DaoUtil"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.pub.util.DaoImplClassUtil"%>

<%@page import="com.chinacreator.eform.util.Escape"%>

<%@page import="com.alibaba.fastjson.JSONObject"%><%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);

	String selectSql = request.getParameter("selectSql");

	
	String result = "";
	try{

		result = DaoUtil.SqlToField(selectSql);
	}catch(Exception e){

	}

	JSONObject jsonObj = new JSONObject();

	jsonObj.put("result",result);

	
	response.getWriter().print(jsonObj);

%>
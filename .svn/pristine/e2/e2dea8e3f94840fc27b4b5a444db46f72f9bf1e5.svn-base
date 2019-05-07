
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
	String executeSql = request.getParameter("executeSql");
	
	boolean issucess = true;
	try{
		issucess = DaoUtil.ExecuteSql(executeSql);
	}catch(Exception e){
		issucess = false;
	}
	JSONObject jsonObj = new JSONObject();
	jsonObj.put("issucess",issucess);

	
	response.getWriter().print(jsonObj);

%>
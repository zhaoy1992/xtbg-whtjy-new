
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.pub.util.DaoImplClassUtil"%>
<%@page import="com.chinacreator.xtbg.pub.personwork.dao.PersonInfoDao"%>
<%@page import="com.chinacreator.eform.util.Escape"%>

<%@page import="com.alibaba.fastjson.JSONObject"%><%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
AccessControl accesscontroler = AccessControl.getInstance();
accesscontroler.checkAccess(request, response);
	String userid = request.getParameter("userid");
	String directoryids = request.getParameter("directoryids");
	
	PersonInfoDao personInfodao = (PersonInfoDao)DaoImplClassUtil.getDaoImplClass("personInfoDaoImpl");
	personInfodao.setPersonalDirectoryRelationship(userid,directoryids);
	
	JSONObject jsonObj = new JSONObject();
	jsonObj.put("ok","ok");
	
	response.getWriter().print(jsonObj);

%>
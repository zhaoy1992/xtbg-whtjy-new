<%@page import="com.chinacreator.xtbg.yimingju.mail.dao.MailDao"%>
<%@page import="com.chinacreator.xtbg.yimingju.mail.dao.impl.MailDaoImpl"%>
<%@page import="com.alibaba.fastjson.JSONObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String userids = request.getParameter("userids");
	MailDao mailDao = new MailDaoImpl();

	JSONObject jsonObj = new JSONObject();
	jsonObj.put("memoryIsOverflow",mailDao.checkIsEmailBoxMemoryWillBeOverflow(userids));
	
	response.getWriter().print(jsonObj);
	

%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="../include/global1.jsp"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.UserManager"%>
<%@ page import="com.chinacreator.sysmgrcore.entity.User"%>

<%
	String userName = request.getParameter("userName");	
	UserManager userManager = SecurityDatabase.getUserManager();
	User user = userManager.getUserByName(userName);
	if(user == null){
		out.println("1");
	}
	else{
		out.println("0");
	}
%>


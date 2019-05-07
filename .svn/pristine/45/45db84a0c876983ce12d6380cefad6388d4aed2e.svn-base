<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.pub.util.DictDropDownList"%>
<%@page import="com.chinacreator.xtbg.pub.util.DaoImplClassUtil"%>
<%@page import="com.alibaba.fastjson.JSONObject"%>
<%@page import="com.chinacreator.security.authorization.AccessException"%>
<%@page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String fullPath = "http://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath();
	session.invalidate(); 
	String userName = request.getParameter("userName");
	String password = request.getParameter("password");
	String errorMessage = null;
	JSONObject jsonObj = new JSONObject();
	boolean success = false;
	if (userName != null) {
			try {
				AccessControl.getInstance().login(request, response, userName, password);
				success = true;
			} catch (AccessException ex) {
				errorMessage = ex.getMessage();
				if (errorMessage != null) {
					errorMessage = errorMessage.replaceAll("\\n","\\\\n");
					errorMessage = errorMessage.replaceAll("\\r","\\\\r");
				}
			}
	}
	jsonObj.put("success",success);
	response.getWriter().print(jsonObj);
%>
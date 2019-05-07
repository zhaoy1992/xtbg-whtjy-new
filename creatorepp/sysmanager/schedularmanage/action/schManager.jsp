
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.sysmgrcore.web.struts.action.SchedularAction"%>
<%@ page import="java.lang.reflect.Method"%>
<%@ page import="javax.servlet.http.HttpServletRequest"%>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	String method = request.getParameter("method");
	String redirect = "";

	try{
		SchedularAction schAction = new SchedularAction(accesscontroler, request);
		//set your parameters type here
		Method mo = SchedularAction.class.getDeclaredMethod(method, HttpServletRequest.class);
		redirect = (String)mo.invoke(schAction, request);
		request.getRequestDispatcher(redirect).forward(request,response);
	}catch(Exception e){
		e.printStackTrace();
	}
%>
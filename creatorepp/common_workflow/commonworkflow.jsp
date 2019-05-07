
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.commonworkflow.action.CommonWorkflowAction"%>
<%@ page import="java.lang.reflect.Method"%>
<%@ page import="javax.servlet.http.HttpServletRequest"%>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	String method = request.getParameter("method");
	String redirect = "";

	try{
		CommonWorkflowAction commonWorkflowAction = new CommonWorkflowAction(request);
		//set your parameters type here
		Method mo = CommonWorkflowAction.class.getDeclaredMethod(method, HttpServletRequest.class);
		redirect = (String)mo.invoke(commonWorkflowAction, request);
		request.getRequestDispatcher(redirect).forward(request,response);
	}catch(Exception e){
		e.printStackTrace();
	}
%>
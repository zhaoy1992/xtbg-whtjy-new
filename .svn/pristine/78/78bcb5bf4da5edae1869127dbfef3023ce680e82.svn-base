<%
	//频道定时发布
%>

<%@ page contentType="text/html; charset=GBK" language="java"%>
<%@page import="com.chinacreator.security.AccessControl,
				com.chinacreator.cms.channelmanager.publish.OrderPublishTask"%>

<%

	String user = request.getParameter("user");
	String password = request.getParameter("password");
		
	AccessControl accessControl = AccessControl.getInstance();
	
	boolean isLogin = accessControl.isLogin(user) ;
	
	if(!isLogin)
	{
		isLogin = accessControl.login(request,response,user,password) ;
	}
	
	if(isLogin)
	{
		System.out.println("登录成功!");
		OrderPublishTask.startTask(request,response,pageContext,accessControl) ;								   
		accessControl.logout() ;
	}
	else
	{
		System.out.println("登录失败!");
		return  ;
	}
	
%>


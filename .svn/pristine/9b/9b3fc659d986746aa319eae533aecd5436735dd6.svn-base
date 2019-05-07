<%-- 
	描述：机构排序处理页面
	作者：黄艺平
	版本：1.0
	日期：2013-05-23
 --%>
<%@page import="com.chinacreator.xtbg.core.purviewmanager.service.impl.UserManagerServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.purviewmanager.service.UserManagerServiceIfc"%>
<%@page import="com.chinacreator.xtbg.core.purviewmanager.service.impl.OrgManagerServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.purviewmanager.service.OrgManagerServiceIfc"%>
<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkManagerAccess(request,response);
	String userids = request.getParameter("nodes");
	String orgid=request.getParameter("orgid");
	UserManagerServiceIfc service=new UserManagerServiceImpl();
	boolean flag = service.setUserOrder(userids,orgid);
	try {	
		if(flag){
	        out.print("{\"flag\":\"true\",\"msg\":\"操作成功\"}");
	    }else{
	        out.print("{\"flag\":\"false\",\"msg\":\"移动节点失败\"}");  
	    }
	} catch (Exception e) {
		out.print("{\"flag\":\"false\",\"msg\":\"移动节点失败!\"}");
	} 


	
%>

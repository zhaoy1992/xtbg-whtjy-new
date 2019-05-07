<%-- 
	描述：用户组排序处理页面
	作者：肖杰
	版本：1.0
	日期：2013-08-01
 --%>
<%@page import="com.chinacreator.xtbg.core.purviewmanager.service.impl.OrgManagerServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.purviewmanager.service.OrgManagerServiceIfc"%>
<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkManagerAccess(request,response);
	String orgIds = request.getParameter("nodes");
	
	OrgManagerServiceIfc orgManagerServiceIfc = new OrgManagerServiceImpl();
	boolean flag = orgManagerServiceIfc.sortOrg(orgIds);
	
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

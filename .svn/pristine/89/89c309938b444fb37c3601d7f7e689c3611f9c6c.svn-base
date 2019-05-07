
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.pub.util.DaoImplClassUtil"%>
<%@page import="com.chinacreator.xtbg.zhangjiajie.inforeported.dao.UnitsetupDao"%>
<%@page import="com.alibaba.fastjson.JSONObject"%><%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	String org_id = request.getParameter("org_id");
	
	UnitsetupDao dao = (UnitsetupDao)DaoImplClassUtil.getDaoImplClass("unitsetupDaoImpl");
	boolean isExsit = dao.isExsitUnitsetupInfo4Org(org_id);
	
	JSONObject jsonObj = new JSONObject();
	jsonObj.put("isexsit",isExsit);
	
	response.getWriter().print(jsonObj);
	//response.getWriter().write("name:'0',value:'1'");
%>

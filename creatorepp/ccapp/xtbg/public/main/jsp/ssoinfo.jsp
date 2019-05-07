
<%@page import="com.chinacreator.business.common.tools.CacheCommonManageProxy"%><%@page import="com.chinacreator.xtbg.pub.sso.dao.SSODao"%>
<%@page import="com.chinacreator.xtbg.pub.sso.dao.impl.SSODaoImpl"%>
<%@page import="com.chinacreator.business.common.tools.CacheCommonManage"%>
<%@page import="com.chinacreator.xtbg.pub.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.pub.util.MD5Util"%>
<%@page import="com.alibaba.fastjson.JSONObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String userName = request.getParameter("userName");
	SSODao dao = new SSODaoImpl();
	String iforums = dao.getUserMappingByUserName(userName);
	String url =  CacheCommonManageProxy.getSystemParam("forum-web-url");
	JSONObject jsonObj = new JSONObject();
	if(!StringUtil.isBlank(iforums)){
		//MD5Util.MD5(iforums.split("#")[1])
		url = url + "&username="+iforums.split("#")[0]+"&password="+MD5Util.MD5(iforums.split("#")[1])+"&issso=1";
		jsonObj.put("url",url);
	}else{
		jsonObj.put("url","null");
	
	}
	response.getWriter().print(jsonObj);
%>

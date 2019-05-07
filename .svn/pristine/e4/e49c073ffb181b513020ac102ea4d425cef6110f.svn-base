
<%@page import="com.chinacreator.xtbg.pub.oagwcs.service.SendGwProxy"%>
<%@page import="com.alibaba.fastjson.JSONObject"%>
<%@page import="com.chinacreator.business.common.tools.CacheCommonManage"%>
<%--
描述：调用公文传输接口的异步请求页面
作者：夏天
版本：1.0
日期：2013-4-18
--%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%
	String busi_id = request.getParameter("busi_id");
	//当前用户ID
	String user_id = request.getParameter("user_id");
	JSONObject json = new JSONObject();
	json.put("issucess",SendGwProxy.SendGwToWebService("",busi_id,user_id,""));
	response.getWriter().print(json);
%>

<%@page import="com.chinacreator.xtbg.pub.util.DaoImplClassUtil"%>
<%@page import="com.chinacreator.xtbg.pub.workflow.dao.FlowUtilDao"%>
<%@page import="com.chinacreator.xtbg.pub.util.StringSplitUtil"%>
<%@page import="com.chinacreator.xtbg.pub.util.DaoUtil"%>
<%@page import="com.alibaba.fastjson.JSONObject"%>
<%--
描述：检查是否全部会签完毕的异步请求页面
作者：夏天
版本：1.0
日期：2013-4-18
--%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%
	String ins_id = request.getParameter("ins_id");
	String action_id = request.getParameter("action_id");
	String curr_userid = request.getParameter("curr_userid");
	String order = request.getParameter("order");
	FlowUtilDao flowUtilDao = (FlowUtilDao)DaoImplClassUtil.getDaoImplClass("flowUtilDaoImpl");
	response.getWriter().print(flowUtilDao.checkIsAllSignJoin(ins_id, action_id, curr_userid, order));
%>
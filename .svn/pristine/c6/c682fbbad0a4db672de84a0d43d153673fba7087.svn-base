<%-- 
描述：获取已借阅图书申请表图书处理
作者：童佳
版本：1.0
日期：2014-04-01
 --%>
<%@page import="com.chinacreator.xtbg.caizhengting.ibrary.service.impl.IbraryBookInfoServiceImpl"%>
<%@page import="com.chinacreator.xtbg.caizhengting.ibrary.service.IbraryBookInfoService"%>
<%@page import="com.alibaba.fastjson.JSON"%>
<%@page import="com.alibaba.fastjson.JSONArray"%>
<%@page import="com.alibaba.fastjson.JSONArray"%>
<%@page import="java.util.*"%>
 <%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.alibaba.fastjson.JSONObject"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	String osappitem = request.getParameter("osappitem");
	
	List<Map<String,String>> bookInfoList = new ArrayList<Map<String,String>>();
	IbraryBookInfoService ibraryBookInfoService = new IbraryBookInfoServiceImpl();
	
	bookInfoList = ibraryBookInfoService.queryRegYJYBookBookInfo(osappitem);
	
	String jsonString  = JSON.toJSONString(bookInfoList);
	
	response.getWriter().print(jsonString);
%>

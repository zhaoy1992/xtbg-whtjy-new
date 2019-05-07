<%-- 
描述：获取图书为归还记录条数
作者：童佳
版本：1.0
日期：2014-05-16
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
	
	String num = "0";
	IbraryBookInfoService ibraryBookInfoService = new IbraryBookInfoServiceImpl();
	
	num = ibraryBookInfoService.isHavaNoGuiHuanBook(osappitem);
	
	String jsonString  = JSON.toJSONString(num);
	
	response.getWriter().print(jsonString);
%>

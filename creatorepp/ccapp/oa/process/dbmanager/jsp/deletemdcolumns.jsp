<%--
　　描述：删除列
　　作者：黄海
　　版本：1.0
　　日期：2013-6-5
--%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.xtbg.core.common.startup.LoadSpringContext"%>
<%@ page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.core.process.dbmanager.service.MdServiceIfc" %>
<%@page import="com.chinacreator.xtbg.core.process.dbmanager.service.impl.MdServiceImpl" %>
<%
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	boolean flag =false;
	String mdColunmListData = request.getParameter("mdColunmListData");
	MdServiceIfc service = new MdServiceImpl();
	flag=service.deleteMdColumns(mdColunmListData);
	out.print(flag);
%>

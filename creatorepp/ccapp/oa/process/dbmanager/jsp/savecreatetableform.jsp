<%--
　　描述：保存 新增业务表、新增数据元表、新增数据元字段表
　　作者：黄海
　　版本：1.0
　　日期：2013-06-09
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
	String mdtablejson = request.getParameter("mdtablejson");
	String mdcolumnlistjson = request.getParameter("mdcolumnlistjson");
	boolean flag = true;
	MdServiceIfc service = new MdServiceImpl();
	flag = service.createMdTables(mdtablejson,mdcolumnlistjson);
	out.print(flag);
%>

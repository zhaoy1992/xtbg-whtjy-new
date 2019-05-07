<%--
　　描述：更新新增业务表、新增数据元表、新增数据元字段表
　　作者：肖杰
　　版本：1.0
　　日期：2013-11-27
--%>
<%@page import="com.chinacreator.xtbg.core.pubconfig.service.impl.MdTableAndColumnsServiceIml"%>
<%@page import="com.chinacreator.xtbg.core.pubconfig.service.MdTableAndColumnsService"%>
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
	MdTableAndColumnsService service=new MdTableAndColumnsServiceIml();
	flag = service.updateMdColumnsAndTable(mdtablejson,mdcolumnlistjson);
	out.print(flag);
%>

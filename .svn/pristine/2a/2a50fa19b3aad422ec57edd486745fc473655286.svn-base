<%--
　　描述：删除会议通知表记录
　　作者：黄海
　　版本：1.0
　　日期：2013-06-19
--%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.xtbg.core.common.startup.LoadSpringContext"%>
<%@ page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.core.meeting.service.MeetingServiceIfc" %>
<%@page import="com.chinacreator.xtbg.core.meeting.service.impl.MeetingServiceImpl" %>
<%
    AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	String ids = request.getParameter("ids");
	boolean flag = true;
	MeetingServiceIfc service = new MeetingServiceImpl();
	flag = service.deleteMdTables(ids);
	out.print(flag);
%>

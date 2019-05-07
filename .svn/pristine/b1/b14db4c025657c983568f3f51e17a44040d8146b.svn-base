<%--
　　描述：会议室预定查看处理页面
　　作者：黄艺平
　　版本：1.0
　　日期：2013-06-28
--%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.alibaba.fastjson.JSONObject" %>
<%@page import="com.chinacreator.xtbg.core.meeting.service.impl.MeetingRoomoccupancyServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.meeting.service.MeetingRoomoccupancyServiceIfc"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.ArrayList"%>
<%
    AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	String unit_id = request.getParameter("unit_id");
	String meetingtime = request.getParameter("meetingtime");
	
	List<Map<String, String>> roomOccupancyList = new ArrayList<Map<String, String>>();
	MeetingRoomoccupancyServiceIfc meetingRoomoccupancyServiceIfc = new MeetingRoomoccupancyServiceImpl();
	roomOccupancyList = meetingRoomoccupancyServiceIfc.viewRoomOccupancy(unit_id, meetingtime);
	out.print(JSONObject.toJSON(roomOccupancyList));
%>

<%--
　　描述：会议室是否占用处理页面
　　作者：黄艺平
　　版本：1.0
　　日期：2013-06-29
--%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.alibaba.fastjson.JSONObject" %>
<%@page import="com.chinacreator.xtbg.core.meeting.service.impl.MeetingRoomoccupancyServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.meeting.service.MeetingRoomoccupancyServiceIfc"%>
<%@page import="com.chinacreator.xtbg.core.common.util.*"%>

<%

    AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	boolean flag = false;
	String m_room_id = request.getParameter("m_room_id");
	String m_begin_time = request.getParameter("m_begin_time");
	String m_end_time = request.getParameter("m_end_time");
	String m_ro_id = request.getParameter("m_ro_id");
	String m_notice_id = StringUtil.deNull(request.getParameter("m_notice_id"));
	

	MeetingRoomoccupancyServiceIfc meetingRoomoccupancyServiceIfc = new MeetingRoomoccupancyServiceImpl();
	flag = meetingRoomoccupancyServiceIfc.isRoomOccupancy(m_begin_time, m_end_time, m_room_id, m_ro_id,m_notice_id );
	out.print(JSONObject.toJSON(flag));
%>

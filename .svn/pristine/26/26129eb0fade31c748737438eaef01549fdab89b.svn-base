<%--
　　描述：会议撤销
　　作者：黄海
　　版本：1.0
　　日期：2013-06-28
--%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.xtbg.core.common.startup.LoadSpringContext"%>
<%@ page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.core.meeting.service.MeetingHandleServiceIfc" %>
<%@page import="com.chinacreator.xtbg.core.meeting.service.impl.MeetingHandleServiceImpl" %>
<%@page import="com.chinacreator.xtbg.core.common.util.DataControlUtil" %>
<%@page import="com.chinacreator.xtbg.core.meeting.entity.*" %>
<%@page import="com.alibaba.fastjson.JSONObject" %>
<%@page import="java.util.List"%>
<%@page import="com.chinacreator.eform.util.Escape"%>
<%@page import="com.chinacreator.xtbg.core.meeting.util.MeetingConstants"%>
<%
    AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	String meetingmsglogjson = request.getParameter("meetingmsglogjson");
	String m_notice_id = request.getParameter("m_notice_id");
	String m_user_id = accesscontroler.getUserID();
	String m_user_name = accesscontroler.getUserName();
	MeetingMsgLogBean meetingMsgLogBean = null;
	
	if (!StringUtil.isBlank(meetingmsglogjson) ) {
		meetingmsglogjson = Escape.unescape(DataControlUtil.replaceStr(meetingmsglogjson));
		meetingMsgLogBean = (MeetingMsgLogBean) JSONObject.parseObject(meetingmsglogjson, MeetingMsgLogBean.class);
	}
	
	boolean flag = true;
	MeetingHandleServiceIfc service = new MeetingHandleServiceImpl();
	flag = service.revocationMeeting(m_notice_id, meetingMsgLogBean,m_user_id,m_user_name);
	
	out.print(flag);
%>

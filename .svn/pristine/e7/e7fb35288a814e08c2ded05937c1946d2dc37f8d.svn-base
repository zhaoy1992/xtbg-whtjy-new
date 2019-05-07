<%--
　　描述：会议报名回复
　　作者：黄海
　　版本：1.0
　　日期：2013-06-29
--%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.core.meeting.service.MeetingHandleServiceIfc" %>
<%@page import="com.chinacreator.xtbg.core.meeting.service.impl.MeetingHandleServiceImpl" %>
<%@page import="com.chinacreator.xtbg.core.common.util.DataControlUtil" %>
<%@page import="com.chinacreator.xtbg.core.meeting.entity.*" %>
<%@page import="com.alibaba.fastjson.JSONObject" %>
<%@page import="java.util.List"%>
<%@page import="com.chinacreator.eform.util.Escape"%>
<%@page import="com.chinacreator.xtbg.core.meeting.util.MeetingConstants"%>
<%@page import="com.chinacreator.xtbg.core.common.util.RequestBeanUtils"%>

<%
    AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	String meetingreceiveruserbeanjson = request.getParameter("meetingreceiveruserbeanjson");
	String meetingmsglogjson = request.getParameter("meetingmsglogjson");

	MeetingReceiverUserBean model = null;
	MeetingMsgLogBean meetingMsgLogBean = null;
	
	if (!StringUtil.isBlank(meetingreceiveruserbeanjson) ) {
		meetingreceiveruserbeanjson = Escape.unescape(DataControlUtil.replaceStr(meetingreceiveruserbeanjson));
		model = (MeetingReceiverUserBean) JSONObject.parseObject(meetingreceiveruserbeanjson, MeetingReceiverUserBean.class);
	}
	
	if (!StringUtil.isBlank(meetingmsglogjson) ) {
		meetingmsglogjson = Escape.unescape(DataControlUtil.replaceStr(meetingmsglogjson));
		meetingMsgLogBean = (MeetingMsgLogBean) JSONObject.parseObject(meetingmsglogjson, MeetingMsgLogBean.class);
	}
	
	MeetingHandleServiceIfc service = new MeetingHandleServiceImpl();
	boolean flag = false;
	flag = service.signupMeeting("",model,meetingMsgLogBean);
	out.print(flag);
%>

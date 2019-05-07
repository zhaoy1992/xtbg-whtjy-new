<%--
　　描述：会议审核操作
　　作者：黄海
　　版本：1.0
　　日期：2013-06-09
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
	String meetingnoticejson = request.getParameter("meetingnoticejson");
	String meetingmsglogjson = request.getParameter("meetingmsglogjson");
	String m_check_flag = request.getParameter("m_check_flag"); //会议状态
	String dotype = request.getParameter("dotype"); 
	
	MeetingNoticeBean meetingNoticeBean = null;
	MeetingMsgLogBean meetingMsgLogBean = null;

	if (!StringUtil.isBlank(meetingnoticejson) ) {
		meetingnoticejson = Escape.unescape(DataControlUtil.replaceStr(meetingnoticejson));
		meetingNoticeBean = (MeetingNoticeBean) JSONObject.parseObject(meetingnoticejson, MeetingNoticeBean.class);
	}
	
	if (!StringUtil.isBlank(meetingmsglogjson) ) {
		meetingmsglogjson = Escape.unescape(DataControlUtil.replaceStr(meetingmsglogjson));
		meetingMsgLogBean = (MeetingMsgLogBean) JSONObject.parseObject(meetingmsglogjson, MeetingMsgLogBean.class);
	}
	
	//日期类型转换 begin    
	if(meetingNoticeBean!=null){//会议申请表的
		if(StringUtil.isBlank((String)meetingNoticeBean.getM_begin_time())) {
			meetingNoticeBean.setM_begin_time(null);
		} else {
			meetingNoticeBean.setM_begin_time(StringUtil.convertStringToTimestamp(meetingNoticeBean.getM_begin_time().toString()));
		}
		if(StringUtil.isBlank((String)meetingNoticeBean.getM_end_time())) {
			meetingNoticeBean.setM_end_time(null);
		} else {
			meetingNoticeBean.setM_end_time(StringUtil.convertStringToTimestamp(meetingNoticeBean.getM_end_time().toString()));
		}
		if(StringUtil.isBlank((String)meetingNoticeBean.getM_close_time())) {
			meetingNoticeBean.setM_close_time(null);
		} else {
			meetingNoticeBean.setM_close_time(StringUtil.convertStringToTimestamp(meetingNoticeBean.getM_close_time().toString()));
		}
	}
	boolean flag = false;
	MeetingHandleServiceIfc service = new MeetingHandleServiceImpl();
	if("unpass".equalsIgnoreCase(dotype)){
		flag = service.checkMeeting(m_check_flag, meetingNoticeBean);
	}else if("pass".equalsIgnoreCase(dotype)){
		flag = service.checkreleaseMeeting(m_check_flag, meetingNoticeBean,meetingMsgLogBean);
	}
	out.print(flag);
%>

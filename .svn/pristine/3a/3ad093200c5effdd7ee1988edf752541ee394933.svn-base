<%--
　　描述：会议补发
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
<%@page import="com.chinacreator.xtbg.core.common.util.*"%>
<%
    AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	String m_other_user_input = request.getParameter("m_other_user_input");
	String meetingnoticejson = request.getParameter("meetingnoticejson");
	String meetingmsglogjson = request.getParameter("meetingmsglogjson");
	String reissue_receiver_unit_ids = request.getParameter("reissue_receiver_unit_ids");  
	String reissue_receiver_user_ids = request.getParameter("reissue_receiver_user_ids");  
	String reissue_receiver_unit_names = request.getParameter("reissue_receiver_unit_names");  
	String reissue_receiver_user_names = request.getParameter("reissue_receiver_user_names"); 
	String m_msg_send_flag_name = StringUtil.deNull(request.getParameter("m_msg_send_flag_name"));
	
	String reissue_receiver_other_unit_ids = request.getParameter("reissue_receiver_other_unit_ids");  
	String reissue_receiver_other_user_ids = request.getParameter("reissue_receiver_other_user_ids");  
	String reissue_receiver_other_unit_names = request.getParameter("reissue_receiver_other_unit_names");  
	String reissue_receiver_other_user_names = request.getParameter("reissue_receiver_other_user_names"); 
	
	
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
	//日期类型转换 end
	
	boolean flag = true;
	MeetingHandleServiceIfc service = new MeetingHandleServiceImpl();
	
	if("补发".equalsIgnoreCase(m_msg_send_flag_name)){
		flag = service.reissueMeeting(meetingNoticeBean, reissue_receiver_unit_names, reissue_receiver_user_names, reissue_receiver_unit_ids, reissue_receiver_user_ids, reissue_receiver_other_unit_names, reissue_receiver_other_user_names, reissue_receiver_other_unit_ids, reissue_receiver_other_user_ids, m_other_user_input, meetingMsgLogBean);
	}
	
	out.print(flag);
%>

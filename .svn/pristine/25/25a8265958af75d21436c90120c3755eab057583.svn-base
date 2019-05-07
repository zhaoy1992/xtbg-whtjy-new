<%--
　　描述：保存会议管理tab全部页面
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
<%
    AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	String meetingnoticejson = request.getParameter("meetingnoticejson");
	String meetingtopicjsonlist = request.getParameter("meetingtopicjsonlist");
	String meetingmsglogjson = request.getParameter("meetingmsglogjson");
	
	MeetingNoticeBean meetingNoticeBean = null;
	List<MeetingTopicBean> meetingTopicBeanList = null;
	MeetingMsgLogBean meetingMsgLogBean = null;
	
	if (!StringUtil.isBlank(meetingnoticejson) ) {
		meetingnoticejson = Escape.unescape(DataControlUtil.replaceStr(meetingnoticejson));
		meetingNoticeBean = (MeetingNoticeBean) JSONObject.parseObject(meetingnoticejson, MeetingNoticeBean.class);
	}
	if (!StringUtil.isBlank(meetingtopicjsonlist) ) {
		meetingtopicjsonlist = Escape.unescape(DataControlUtil.replaceStr(meetingtopicjsonlist));
		meetingTopicBeanList= (List<MeetingTopicBean>) JSONObject.parseArray(meetingtopicjsonlist, MeetingTopicBean.class);
	}
	
	if (!StringUtil.isBlank(meetingmsglogjson) ) {
		meetingmsglogjson = Escape.unescape(DataControlUtil.replaceStr(meetingmsglogjson));
		System.out.println("asdf:"+meetingmsglogjson);
		meetingMsgLogBean = (MeetingMsgLogBean) JSONObject.parseObject(meetingmsglogjson, MeetingMsgLogBean.class);
	}
	
	boolean flag = true;
	MeetingHandleServiceIfc service = new MeetingHandleServiceImpl();
	flag = service.sentMeeting(meetingNoticeBean, meetingTopicBeanList,meetingMsgLogBean);
	out.print(flag);
%>

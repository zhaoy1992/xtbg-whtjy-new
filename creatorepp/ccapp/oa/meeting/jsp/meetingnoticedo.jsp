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
<%@page import="com.chinacreator.xtbg.core.meeting.service.MeetingRoomoccupancyServiceIfc" %>
<%@page import="com.chinacreator.xtbg.core.meeting.service.impl.MeetingRoomoccupancyServiceImpl" %>
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
	String meetingnoticejson = request.getParameter("meetingnoticejson");
	String meetingtopicjsonlist = request.getParameter("meetingtopicjsonlist");
	String meetingmsglogjson = request.getParameter("meetingmsglogjson");
	String m_check_flag = request.getParameter("m_check_flag"); //会议状态
	String m_msg_send_flag = request.getParameter("m_msg_send_flag");  //消息日志状态
	
	
	MeetingNoticeBean meetingNoticeBean  = null;
	List<MeetingTopicBean> meetingTopicBeanList = null;
	MeetingMsgLogBean meetingMsgLogBean = null;
	
	if (!StringUtil.isBlank(meetingnoticejson) ) {
		meetingNoticeBean = (MeetingNoticeBean) JSONObject.parseObject(meetingnoticejson, MeetingNoticeBean.class);
		//meetingNoticeBean =  (MeetingNoticeBean) RequestBeanUtils.getValuesByRequestObj(request, meetingNoticeBean,"meetingnoticejson");
	}
	if (!StringUtil.isBlank(meetingtopicjsonlist) ) {
		meetingtopicjsonlist = Escape.unescape(DataControlUtil.replaceStr(meetingtopicjsonlist));
		meetingTopicBeanList= (List<MeetingTopicBean>) JSONObject.parseArray(meetingtopicjsonlist, MeetingTopicBean.class);
	}
	
	if (!StringUtil.isBlank(meetingmsglogjson) ) {
		//meetingmsglogjson = Escape.unescape(DataControlUtil.replaceStr(meetingmsglogjson));
		meetingMsgLogBean = (MeetingMsgLogBean) JSONObject.parseObject(meetingmsglogjson, MeetingMsgLogBean.class);
	}
	//日期类型转换 begin    
	if(meetingNoticeBean!=null){//会议申请表的
		
		//new add begin hai.huang 2013-08-15 -----------------------------------------------------------------
		MeetingNoticeBean bean = new MeetingNoticeBean();
		bean = (MeetingNoticeBean) RequestBeanUtils.getValuesByRequestObj(request, bean,"meetingnoticebean");
		if(bean!=null){
			meetingNoticeBean.setM_djbh(bean.getM_djbh());
			meetingNoticeBean.setM_contents(bean.getM_contents());
		}
		//new add end ----------------------------------------------------------------------------------------
		
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
	if(meetingTopicBeanList!=null){
		for(MeetingTopicBean model :meetingTopicBeanList){
			if(StringUtil.isBlank((String)model.getM_begin_time())) {
				model.setM_begin_time(null);
			} else {
				model.setM_begin_time(StringUtil.convertStringToTimestamp(model.getM_begin_time().toString()));
			}
		}
	}
	
	boolean flag = true;
	
	MeetingRoomoccupancyServiceIfc roomservice = new MeetingRoomoccupancyServiceImpl();
	
	String m_begin_time = meetingNoticeBean.getM_begin_time().toString().substring(0,19);;
	String m_end_time = meetingNoticeBean.getM_end_time().toString().substring(0,19);;
	String m_room_id = meetingNoticeBean.getM_room_id();
	
	boolean isRoomOccupancy = true;//有冲突,为真时没冲突
	if(!StringUtil.nullOrBlank(m_room_id)){//没占用 或会议室为空 的话
		isRoomOccupancy = roomservice.isRoomOccupancy(m_begin_time,m_end_time,m_room_id,"",StringUtil.deNull(meetingNoticeBean.getM_notice_id()));
	}
	
	if(isRoomOccupancy){//true 冲突数为0 可保存
		MeetingHandleServiceIfc service = new MeetingHandleServiceImpl();
		if(MeetingConstants.STATUS_PENDING.equalsIgnoreCase(m_check_flag)){//送审
			flag = service.sentMeeting(meetingNoticeBean, meetingTopicBeanList,meetingMsgLogBean);
		}else if(MeetingConstants.STATUS_DRAFT.equalsIgnoreCase(m_check_flag)){//暂存
			flag = service.tempNotice(meetingNoticeBean, meetingTopicBeanList,meetingMsgLogBean);
		}else if(MeetingConstants.STATUS_PUBLISHED.equalsIgnoreCase(m_check_flag)){//发布
			flag = service.releaseMeeting(meetingNoticeBean, meetingTopicBeanList,meetingMsgLogBean);
		}else if(MeetingConstants.STATUS_REPUBLISHED.equalsIgnoreCase(m_check_flag)){//重新发布
			String m_is_need_resignup = request.getParameter("m_is_need_resignup");
			flag = service.resendNotice(meetingNoticeBean, meetingTopicBeanList, meetingMsgLogBean,m_is_need_resignup);
		}
	}else{
		flag=false;
	}
	
	out.print(flag);
%>

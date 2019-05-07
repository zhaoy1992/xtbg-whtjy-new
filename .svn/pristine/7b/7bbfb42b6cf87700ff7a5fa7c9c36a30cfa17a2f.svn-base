<%-- 
描述：会议室预约处理页面
作者：黄艺平
版本：1.0
日期：2013-06-28
 --%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@ page contentType="text/html; charset=utf-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@page import="com.chinacreator.xtbg.core.notice.entity.NoticeBaseInfoBean"%>
<%@page import="com.chinacreator.xtbg.core.common.util.RequestBeanUtils"%>
<%@page import="com.chinacreator.xtbg.core.notice.service.NoticeHandleServiceIfc"%>
<%@page import="com.chinacreator.xtbg.core.notice.service.impl.NoticeHandleServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.notice.entity.NoticeMsgBean"%>
<%@page import="com.chinacreator.xtbg.core.meeting.entity.MeetingRoomoccupancyBean"%>
<%@page import="com.chinacreator.xtbg.core.meeting.service.MeetingRoomoccupancyServiceIfc"%>
<%@page import="com.chinacreator.xtbg.core.meeting.service.impl.MeetingRoomoccupancyServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%><html>
<head>
<title>会议室预约处理页面</title>
<%
AccessControl accesscontroler = AccessControl.getAccessControl();
accesscontroler.checkAccess(request, response);
String type = request.getParameter("type");
String m_ids = "";
boolean flag = false;
boolean occupancyflag = false;
String m_begin_time = "";
String m_end_time = "";
String m_room_id = "";
String m_ro_id = "";

MeetingRoomoccupancyBean meetingRoomoccupancyBean = new MeetingRoomoccupancyBean();
MeetingRoomoccupancyServiceIfc meetingRoomoccupancyServiceIfc = new MeetingRoomoccupancyServiceImpl();

if("del".equals(type)) {
	m_ids = request.getParameter("m_ids");
	flag = meetingRoomoccupancyServiceIfc.delMeetingRoomoccupancy(m_ids);
} else {
	meetingRoomoccupancyBean = (MeetingRoomoccupancyBean)RequestBeanUtils.getValuesByRequest(request,meetingRoomoccupancyBean);
	meetingRoomoccupancyBean.setM_begin_time(StringUtil.convertStringToTimestamp(meetingRoomoccupancyBean.getM_begin_time().toString()));
	meetingRoomoccupancyBean.setM_end_time(StringUtil.convertStringToTimestamp(meetingRoomoccupancyBean.getM_end_time().toString()));
	
	m_begin_time = meetingRoomoccupancyBean.getM_begin_time().toString().substring(0,19);
	m_end_time = meetingRoomoccupancyBean.getM_end_time().toString().substring(0,19);
	m_room_id = meetingRoomoccupancyBean.getM_room_id();
	m_ro_id = meetingRoomoccupancyBean.getM_ro_id();
	occupancyflag = meetingRoomoccupancyServiceIfc.isRoomOccupancy(m_begin_time, m_end_time, m_room_id, m_ro_id,"" );
	if(occupancyflag) {
		flag = meetingRoomoccupancyServiceIfc.saveMeetingRoomoccupancy(meetingRoomoccupancyBean);
	}
}

%>
<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript">
var mes = "";
var bool = true;
var type = "<%=type %>";
if(<%=flag%>){
	mes = "操作成功";
	if("del" == type) {
		parent.viewRoomOccupancy();
		parent.meetingSearch();
	} else {
		parent.getParentWindow("roomReservation").viewRoomOccupancy(); //增加是在弹出框调用.DO 所以在父页面getParentWindow才能取到
		parent.getParentWindow("roomReservation").meetingSearch();//删除要另外处理 因为是在\viewroomoccupancy.jsp 页面调用的.DO 直接parent.viewRoomOccupancy();
	}
	removeAlertWindows("roomReservation",true);
	alert(mes);
}else{
	mes = "操作失败"	;
	if(<%=occupancyflag %>) {
	} else {
		mes = "会议室被占用"	;
	}
	bool = false;
	window.top.alert(mes)
}
</script>
</head>
<body>
</body> 
</html>
<%-- 
描述：会议通知重发界面
作者：黄海
版本：1.0
日期：2013-06-28
 --%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.core.meeting.util.MeetingConstants"%>
<%
AccessControl accesscontroler = AccessControl.getAccessControl();
accesscontroler.checkAccess(request, response);
String path = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"></meta>
<title>会议通知重发界面</title>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script type="text/javascript">jQuery.noConflict();</script>
<!-- 引入jQuery UI -->
<script src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>
<script src="../../resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<!-- 引入formvValidatetion -->
<link rel="stylesheet" href="../../resources/plug/formvalidation/css/validationEngine.jquery.css" type="text/css" />
<script src="../../resources/plug/formvalidation/jquery.validationEngine-cn.js" type="text/javascript" ></script>
<script src="../../resources/plug/formvalidation/jquery.validationEngine.js" type="text/javascript" ></script>
<!-- 引入其它 -->
<script src="../../resources/util/public.js" type="text/javascript"></script>
<!-- 引入提示 -->
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js" ></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js" ></script>


<script type="text/javascript" src="../../resources/plug/JQuery zTree v3.0/js/jquery.ztree.core-3.0.js"></script>
<script type="text/javascript" src="../../resources/plug/JQuery zTree v3.0/js/jquery.ztree.excheck-3.0.js"></script>
<script type="text/javascript" src="../resources/js/meetingnoticedetail.js"></script>
<script>
jQuery(document).ready(function() {
	jQuery("#table_code").focus();
});
/* 
	函数:  resendMeeting
	说明:  重发
*/
function resendMeeting(){
		
	if (jQuery("#m_msg_type1")[0]==undefined && jQuery("#m_msg_type2")[0]==undefined ){
		var msgFlag = "";
		var noteFlag = "";
	}else{
		var msgFlag  = jQuery("#m_msg_type1")[0].checked;
		var noteFlag = jQuery("#m_msg_type2")[0].checked;
		var str = "";
	}
	
	if (!isSpace(msgFlag) || !isSpace(noteFlag)){//发消息 ，就要判断内容不可为空
		if(isSpace(jQuery('#m_msg_contents').val())){
			alert("注意：提醒内容不能空！");
			return false;
		}
	}else if (!isSpace(jQuery('#m_msg_contents').val()) && isSpace(msgFlag) && isSpace(noteFlag) ){
		alert("注意：提醒方式不能空！");
		return false;
	}		

	var tabwindow = getParentWindow('');
	var m_check_flag = "<%=MeetingConstants.STATUS_REPUBLISHED%>";
	var m_check_flag_name = "重新发布";
	var m_msg_send_flag = '<%=MeetingConstants.MSG_PUBLISHED_SEND%>';
	var m_msg_send_flag_name = "重发";
	
	//重发使用重发界面的消息提醒信息内容
	if (!isSpace(jQuery('#m_msg_contents').val()) && (!isSpace(msgFlag) || !isSpace(noteFlag))) {//发消息 ，就要判断内容不可为空
		var meetingmsglogjson = "{"+getAlertWindowMeetingmsglogJson(m_msg_send_flag,m_msg_send_flag_name,tabwindow.frame1.window.jQuery("#m_notice_id").val())+"}";
	}else{
		var meetingmsglogjson = "";
	}
	
	
	
	var meetingnoticedetailjson = tabwindow.frame1.window.getJson(m_check_flag,m_check_flag_name);//基本信息
	//重发的报名控制在重发页面确定
	meetingnoticedetailjson+=",'m_is_need_signup':'"+ jQuery('input:radio[name="m_is_need_signup"]:checked').val()+"'" ;
    var meetingnoticecontentjson = tabwindow.frame2.window.getJson();//正文 
	/* var meetingnoticejson = "{" +
	    meetingnoticedetailjson +
	    "," + meetingnoticecontentjson +
    "}"; */
    var meetingnoticejson = "{"+meetingnoticedetailjson+"}";//new add 2013-08-15

    var reissue_receiver_unit_ids = "";
    var reissue_receiver_user_ids = "";
    
    
    if (!isSpace(tabwindow.frame3.window.getJson())){
		var meetingtopicjsonlist = "["+tabwindow.frame3.window.getJson()+"]"; 
	}else{
		var meetingtopicjsonlist = ""; 
	}
	var data = {
			meetingnoticejson : descape(escape(meetingnoticejson)),
			meetingtopicjsonlist  : descape(escape(meetingtopicjsonlist)),
			meetingmsglogjson  : descape(escape(meetingmsglogjson)),
			reissue_receiver_unit_ids : reissue_receiver_unit_ids,
			reissue_receiver_user_ids : reissue_receiver_user_ids,
			meetingnoticebean:meetingnoticecontentjson,//new add 2013-08-15
			m_msg_send_flag_name:m_msg_send_flag_name
	}
	var okF = function() {
		url = "meetingreissuedo.jsp";
		jQuery.ajax({
			url : url,
			type : 'POST',
			dataType : 'json',
			data : data,
			async : true,
			success : function(flag) {
				if (flag) {
					alert("操作成功！");
				} else {
					alert("操作失败！");
				}
				getParentWindow('').tomainjsp();
				setTimeout(function(){
					removeAlertWindows('',true);
				},500);
			},
			error : function(jqXHR, textStatus, errorThrown) {
				alert("error:" + textStatus);
				closeform();
			}
		});
	};
	var p = {
		headerText : '提示',
		okName : '确认',
		okFunction : okF,
		cancelName : '取消'
	};
	alert("确定要重发吗？", p);			
}

/* 
	函数:  closeform
	说明:  关闭指定窗口，刷新其父页面列表
	参数:  windowId 窗口id
*/
function closeform(windowId){
    closeAlertWindows(windowId, false, true);
}

/*
	函数:  returnReplaceNoteContents
	说明:  用替代后短信内容设置页面上短信内容的文本域
	参数:  替代后短信内容
*/
function replaceNoteContents(str){
	var tabwindow = getParentWindow('');	
	jQuery("#m_msg_contents").val(tabwindow.frame1.window.returnReplaceNoteContents(str));
}

</script>
</head>
<body onload="">
<form action="" id="form1" name="form1" method="post" >
	<div class="cue_box_top">
		<input class="but_y_01" type="button" value="关闭" onclick="removeAlertWindows('',true)" />
		<input class="but_y_01" type="button" value="重发" onclick="resendMeeting()"/>
	</div>
	<!-- 消息提醒begin -->
	<div class="content_02_box" >
		<div class="content_02_box_title_bg">
			<span>消息提醒</span>
		</div>
		<input type="hidden" id="msg_m_id" name="msg_m_id" value="asd" />
		<input type="hidden" id="" name="" value="" />
		<div class="content_02_box_div">
			<table border="0" cellspacing="0" cellpadding="0" class="content_02_box_div_table">
				<tr>
					<th class="content_02_box_div_table_th" ></th>
					<td class="content_02_box_div_table_td" colspan="5">
						<input type="button" value="选择短信模板" class="but_six" onclick="openmeetingnotetemplatelist()" />
					</td>
				</tr>
				<tr>
					<th class="content_02_box_div_table_th" >提醒方式：</th>
					<td class="content_02_box_div_table_td" colspan="3">
						<input name="m_msg_type" id="m_msg_type1" type="checkbox"   value="<%=MeetingConstants.NOTE %>" />&nbsp;短信
						&nbsp;
						<input name="m_msg_type" id="m_msg_type2" type="checkbox"   value="<%=MeetingConstants.MSG %>" />&nbsp;即时信息
					</td>
					<th class="content_02_box_div_table_th" >是否需要重新报名：</th>
					<td class="content_02_box_div_table_td" >
						<input type="radio" value="0" name="m_is_need_signup" checked="checked"  id="m_is_need_signup"  />
						否 &nbsp;&nbsp;
						<input type="radio" value="1" name="m_is_need_signup" id="m_is_need_signup"  />
						是
					</td>
				</tr>
			</table>
		</div>
		<div class="content_02_box_div">
			<table border="0" cellspacing="0" cellpadding="0" class="content_02_box_div_table">
				<tr>
					<th class="content_02_box_div_table_th" >提醒内容：</th>
					<td class="content_02_box_div_table_td" colspan="5">
						<textarea id="m_msg_contents" name="m_msg_contents" class="validate[required,maxSize[300]] textarea_575" style="width:98%" rows="5" ></textarea>
					</td>
				</tr>
			</table>
		</div>
	</div>
</form>
</body>
</html>
<%-- 
描述：会议通知撤销界面
作者：黄海
版本：1.0
日期：2013-06-24
 --%>
<%@page import="com.chinacreator.xtbg.core.sysparam.util.SysParamConstant"%>
<%@page import="org.apache.ws.commons.schema.constants.Constants.SystemConstants"%>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.chinacreator.xtbg.core.meeting.service.impl.MeetingHandleServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.meeting.service.MeetingHandleServiceIfc"%>
<%@page import="com.chinacreator.xtbg.core.sysparam.util.SysParamUitl"%>
<%@page import="java.util.Map"%>
<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.core.meeting.util.MeetingConstants"%>
<%
AccessControl accesscontroler = AccessControl.getAccessControl();
accesscontroler.checkAccess(request, response);
String path = request.getContextPath();
String m_notice_id = StringUtil.deNull(request.getParameter("m_notice_id"));
String m_id = StringUtil.deNull(request.getParameter("m_id"));

MeetingHandleServiceIfc service = new MeetingHandleServiceImpl();
Map<String, String> map4Msg = new HashMap<String, String>(); 
map4Msg=service.getMeetingNoticeBean(m_notice_id);
String checkpass = SysParamUitl.getSysParamValueIsVALID(MeetingConstants.MEETING_MSG_CANCEL);
String m_msg_contents="";
if(!StringUtil.nullOrBlank(checkpass)){
	m_msg_contents = SysParamUitl.getSysParamValue(checkpass);
	List<Map<String, String>> listmap = SysParamUitl.getSysParamValueDetail(checkpass);
	 if(!StringUtil.nullOrBlank(m_msg_contents) && listmap!=null && listmap.size()>0){
		for (Map<String, String> map1 : listmap){
			//System.out.println("map.get(\"p_value_name\")=="+map.get("p_value_name")+",map.get(\"p_value_code\")==="+map.get("p_value_code")+",kbmDocMap.get(map.get(\"p_value_code\"))=="+kbmDocMap.get(map.get("p_value_code")));
			if(map4Msg!=null && map4Msg.size()>0 && !StringUtil.nullOrBlank(map4Msg.get(map1.get("p_value_code")))){
				m_msg_contents = m_msg_contents.replaceAll("【"+map1.get("p_value_name")+"】","【"+map4Msg.get(map1.get("p_value_code"))+"】");
			}
		}
	}	
}
//判断是否有短信，及时，邮件，站内消息提示
SysParamUitl noticeutil=new SysParamUitl();
Map<String,String> msgmap=noticeutil.getCheckedSystemMsg();
String is_pub_sms=msgmap.get(SysParamConstant.IS_PUB_SMS);
String is_pub_msg=msgmap.get(SysParamConstant.IS_PUB_MSG);
String is_pub_rtx=msgmap.get(SysParamConstant.IS_PUB_RTX);
String is_pub_mail=msgmap.get(SysParamConstant.IS_PUB_MAIL);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"></meta>
<title>会议通知撤销界面</title>
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
var m_msg_contents = "<%=m_msg_contents%>";
jQuery(document).ready(function() {
	jQuery("#m_msg_contents").focus();
});
/*
	函数:  returnReplaceNoteContents
	说明:  用替代后短信内容设置页面上短信内容的文本域
	参数:  替代后短信内容
*/
function replaceNoteContents(str){
	var tabwindow = getParentWindow('');	
	jQuery("#m_msg_contents").val(tabwindow.frame1.window.returnReplaceNoteContents(str));
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
函数:  revocationMeeting
说明:  撤消会议
*/
function revocationMeeting(){
	ischecked();
	var is_sms  = jQuery("#is_sms")[0].checked;
	var is_msg  = jQuery("#is_msg")[0].checked;
	var is_rtx  = jQuery("#is_rtx")[0].checked;
	var is_mail  = jQuery("#is_mail")[0].checked;
	
	if (is_sms || is_msg || is_rtx|| is_mail){//发消息 ，就要判断内容不可为空
		if(isSpace(jQuery('#msg_contents').val())){
			alert("注意：提醒内容不能空！");
			return false;
		}
	}else if (!isSpace(jQuery('#msg_contents').val()) && !is_sms && !is_msg&& !is_rtx&& !is_mail ){
		alert("注意：提醒方式不能空！");
		return false;
	}
	
	
	if (!is_sms && !is_msg&& !is_rtx&& !is_mail ){//不发消息
		var meetingmsglogjson = "";
	}else{
		var meetingmsglogjson = "{"+getMeetingmsglogJson('<%=MeetingConstants.MSG_DRAFT_SEND%>','草稿')+"}";//消息
	}
	
	var m_notice_id = "<%=m_notice_id%>";
	var data = {
			m_notice_id : m_notice_id,
			meetingmsglogjson : meetingmsglogjson
	}
	var okF = function() {
		url = "meetingrevocationdo.jsp";
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
				},300);
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
	alert("确定要撤消吗？", p);		
}
/* 
函数:  setValue4m_msg_contents
说明:  事件响应方法设置短信模板
*/
function setValue4m_msg_contents(id){
	if(id=="model_id"){
		jQuery("#msg_contents").val(m_msg_contents);
	}else{
		 if(jQuery("#"+id).attr("checked")=="checked"  ){
			if(isSpace(jQuery("#msg_contents").val())){
			jQuery("#msg_contents").val(m_msg_contents);//短信模板
		}
	}
}
}

/* 
函数:  closeform
说明:  关闭指定窗口，刷新其父页面列表
参数:  windowId 窗口id
*/
function closeform(windowId){
	closeAlertWindows(windowId, false, true);
}
</script>
</head>
<body onload="">
<form action="" id="form1" name="form1" method="post" >
	<div class="cue_box_top">
		<input class="but_y_01" type="button" value="关闭" onclick="removeAlertWindows('',true)" />
		<input class="but_y_01" type="button" value="会议撤销" onclick="revocationMeeting()"/>
	</div>
	<!-- 消息提醒begin -->
	<%if("1".equals(is_pub_sms) || "1".equals(is_pub_rtx) || "1".equals(is_pub_msg) || "1".equals(is_pub_mail)){ %>
			<div class="content_02_box_title_bg" style="width: 98%;">
				<span>消息提醒</span>
			</div>
			<input type="hidden" id="m_id" name="m_id" value="" />
			<input type="hidden" id="" name="" value="" />
			<div class="content_02_box_div" style="width: 98%;">
				<table border="0" cellspacing="0" cellpadding="0" class="content_02_box_div_table" style="width: 100%;">
					<tr>
						<th class="content_02_box_div_table_th"  style="width:200px;">提醒方式：</th>
						<td class="content_02_box_div_table_td" colspan="3">
							<%if("1".equals(is_pub_sms)){ %>
							<input name="is_sms" id="is_sms" type="checkbox"  value="" onclick="setValue4m_msg_contents(this.id);" />&nbsp;短信
							&nbsp;<%} %>
							<%if("1".equals(is_pub_mail)){ %>
							<input name="is_mail" id="is_mail" type="checkbox" onclick="setValue4m_msg_contents(this.id);"  value="" />&nbsp;邮件&nbsp;
							<%} if("1".equals(is_pub_rtx)){%>
							<input name="is_rtx" id="is_rtx" type="checkbox"  onclick="setValue4m_msg_contents(this.id);" value="" />&nbsp;即时信息&nbsp;
							<%} if("1".equals(is_pub_msg)){%>
							<input name="is_msg" id="is_msg" type="checkbox"  onclick="setValue4m_msg_contents(this.id);" value="" />&nbsp站内信息&nbsp;
							<%} %>
							<span style="float:right;display:block;width: 100px" id="model_id" onclick="setValue4m_msg_contents(this.id);">使用默认模版</span>
							<input type="hidden" id="is_sms"   name="is_sms" value="" />
							<input type="hidden" id="is_mail"   name="is_mail" value="" />
							<input type="hidden" id="is_rtx"   name="is_rtx" value="" />
							<input type="hidden" id="is_msg"   name="is_msg" value="" />
							
						</td>
					</tr>
					<tr>
						<th class="content_02_box_div_table_th" >提醒内容：</th>
						<td class="content_02_box_div_table_td" colspan="5">
							<textarea id="msg_contents" name="msg_contents" class="validate[maxSize[300]] textarea_575" cols="110" rows="2" ></textarea>
						</td>
					</tr>
				</table>
				<table border="0" cellspacing="0" cellpadding="0"><tr><td height=50></td></tr></table>
			</div>
			<%} %>
	<input type="hidden" name="m_notice_id" id="m_notice_id" value="<%=m_notice_id %>" />
</form>
</body>
</html>
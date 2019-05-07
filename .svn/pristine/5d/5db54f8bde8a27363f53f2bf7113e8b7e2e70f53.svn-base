<%-- 
描述：会议通知补发界面
作者：黄海
版本：1.0
日期：2013-06-24
 --%>
<%@page import="com.chinacreator.xtbg.core.sysparam.util.SysParamConstant"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page import="com.chinacreator.xtbg.core.sysparam.util.SysParamUitl"%>
<%@page import="java.util.Map"%>
<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="com.chinacreator.xtbg.core.meeting.entity.MeetingNoticeBean"%>
<%@page import="com.chinacreator.xtbg.core.meeting.service.impl.MeetingHandleServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.meeting.service.MeetingHandleServiceIfc"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.core.meeting.util.MeetingConstants"%>
<%
AccessControl accesscontroler = AccessControl.getAccessControl();
accesscontroler.checkAccess(request, response);
String path = request.getContextPath();
String m_notice_id = StringUtil.deNull(request.getParameter("m_notice_id"));
//add by xiaojie 8-23 重写人员机构树 
MeetingHandleServiceIfc service =new MeetingHandleServiceImpl();
MeetingNoticeBean meetbean= service.getMeetingNoticeBeanById(m_notice_id);
String userids=meetbean.getM_receiver_user_ids();
String unitids=meetbean.getM_receiver_unit_ids();
//---end

//判断是否有短信，及时，邮件，站内消息提示
SysParamUitl noticeutil=new SysParamUitl();
Map<String,String> msgmap=noticeutil.getCheckedSystemMsg();
String is_pub_sms=msgmap.get(SysParamConstant.IS_PUB_SMS);
String is_pub_msg=msgmap.get(SysParamConstant.IS_PUB_MSG);
String is_pub_rtx=msgmap.get(SysParamConstant.IS_PUB_RTX);
String is_pub_mail=msgmap.get(SysParamConstant.IS_PUB_MAIL);

Map<String, String> map4Msg = new HashMap<String, String>(); 
map4Msg=service.getMeetingNoticeBean(m_notice_id);
String checkpass = SysParamUitl.getSysParamValueIsVALID(MeetingConstants.MEETING_MSG);
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
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"></meta>
<title>会议通知补发界面</title>
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
var userids='<%=userids%>';
var unitids='<%=unitids%>';
jQuery(document).ready(function() {
	jQuery("#table_code").focus();
	
	var _documentBodyHeight = window.top.findPageCacheName("_documentBodyHeight");
		jQuery("#maindiv").height(_documentBodyHeight-(_documentBodyHeight-560+50));	
	
});
/*
	函数:  returnReplaceNoteContents
	说明:  用替代后短信内容设置页面上短信内容的文本域
	参数:  替代后短信内容
*/
function replaceNoteContents(str){
	var tabwindow = getParentWindow('');	
	jQuery("#msg_contents").val(tabwindow.frame1.window.returnReplaceNoteContents(str));
}
/* 
	函数:  reissueMeeting
	说明:  会议通知补发，更新接收表，信息发送日志表等
*/
function reissueMeeting(){
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
		
	var tabwindow = getParentWindow('');
	var m_check_flag = tabwindow.frame1.window.getM_check_flag();
	var m_check_flag_name = tabwindow.frame1.window.getM_check_flag_name();;
	var m_msg_send_flag = '<%=MeetingConstants.MSG_ADD_SEND%>';
	var m_msg_send_flag_name = "补发";
	
	
	if (!isSpace(jQuery('#msg_contents').val()) && (is_sms || is_msg || is_rtx|| is_mail)) {//发消息 ，就要判断内容不可为空
		var meetingmsglogjson = "{"+getAlertWindowMeetingmsglogJson(m_msg_send_flag,m_msg_send_flag_name,tabwindow.frame1.window.jQuery("#m_notice_id").val())+"}";
	}else{
		var meetingmsglogjson = "";
	}
	
	
	var meetingnoticedetailjson = tabwindow.frame1.window.getJson(m_check_flag,m_check_flag_name);//基本信息
    var meetingnoticecontentjson = tabwindow.frame2.window.getJson();//正文 
	/* var meetingnoticejson = "{" +
	    meetingnoticedetailjson +
	    "," + meetingnoticecontentjson +
    "}"; */
    var meetingnoticejson = "{"+meetingnoticedetailjson+"}";//new add 2013-08-15

    var reissue_receiver_unit_ids = jQuery("#m_receiver_unit_ids").val();
    var reissue_receiver_user_ids = jQuery("#m_receiver_user_ids").val();
    var reissue_receiver_unit_names = jQuery("#m_receiver_unit_names").val();
    var reissue_receiver_user_names = jQuery("#m_receiver_user_names").val();
    if(isSpace(reissue_receiver_unit_ids) && isSpace(reissue_receiver_user_ids) ){
		//alert("注意：请选择补发的与会单位或与会人员！");
		//return false;
	}
    
	var data = {
			meetingnoticejson : descape(escape(meetingnoticejson)),
			meetingmsglogjson  : descape(escape(meetingmsglogjson)),
			reissue_receiver_unit_ids : reissue_receiver_unit_ids,
			reissue_receiver_user_ids : reissue_receiver_user_ids,
			reissue_receiver_unit_names : reissue_receiver_unit_names,
			reissue_receiver_user_names : reissue_receiver_user_names,
			reissue_receiver_other_unit_ids : jQuery("#m_receiver_other_unit_ids").val(),
			reissue_receiver_other_user_ids : jQuery("#m_receiver_other_user_ids").val(),
			reissue_receiver_other_unit_names : jQuery("#m_receiver_other_unit_names").val(),
			reissue_receiver_other_user_names : jQuery("#m_receiver_other_user_names").val(),
			m_other_user_input : jQuery("#m_other_user_input").val(),
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
					setTimeout(function(){closeform('windowId');},500);
				} else {
					alert("操作失败！");
				}
				
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
	alert("确定要补发吗？", p);			
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
<body>
<div id="maindiv" class="vcenter" style="height:400px;overflow-x:hidden;overflow-y:auto;">
	
	<form action="" id="form1" name="form1" method="post" >
		<div class="cue_box_top">
			<input class="but_y_01" type="button" value="关闭" onclick="removeAlertWindows('',true)" />
			<input class="but_y_01" type="button" value="补发" onclick="reissueMeeting()"/>
		</div>
		<!-- 补发与会单位与人员 begin -->
		<div class="content_02_box_title_bg">
			<span>与会单位与人员</span>
			<div class="content_02_box_add show_content" style="cursor: hand">
				<input type="button" value="选择" class="but_six" onclick="adddeptanduser1('',userids,unitids)" />
			</div>
		</div>
		<div class="content_02_box_div">
			<table border="0" cellspacing="0" cellpadding="0" class="content_02_box_div_table">
				<tr>
					<th class="content_02_box_div_table_th" style="width:191px;">与会单位列表：
						<input type="hidden" id="m_receiver_unit_ids" name="m_receiver_unit_ids" value="" />
						<input type="hidden" id="m_receiver_unit_names" name="m_receiver_unit_names" value="" />
					</th>
					<td class="content_02_box_div_table_td" id="deptTd" colspan="5" >
					</td>
				</tr>
				<tr>
					<th class="content_02_box_div_table_th" style="width:191px;">与会人员列表：
					</th>
					<td class="content_02_box_div_table_td" colspan="5">
						<input type="hidden" id="m_receiver_user_ids" name="m_receiver_user_ids" value="" />
						<input type="hidden" id="m_receiver_user_names" name="m_receiver_user_names" value="" />
						<textarea id="userTd" name= "userTd" class="validate[required,maxSize[500]] textarea_575" 
							style="width:98%"  onclick="adddeptanduser1('',userids,unitids)" rows="5" readonly="readonly"></textarea>
					</td>
				</tr>
			</table>
		</div>
		<!-- 补发与会单位与人员 end -->
		<!-- 选择其他单位与会人员 -------begin----------------------------------------------------------------- -->
		<div class="content_02_box_title_bg">
			<span>其他单位与会人员</span>
			<div class="content_02_box_add show_content" style="cursor: hand">
				<input type="button" value="选择" class="but_six" onclick="adddeptanduser4Other()" />
			</div>
		</div>
		<div class="content_02_box_div">
			<table border="0" cellspacing="0" cellpadding="0" class="content_02_box_div_table" style="width: 100%;">
				<tr>
					<th class="content_02_box_div_table_th" rowspan=2>其他单位与会人员列表：</th>
					<td class="content_02_box_div_table_td" colspan="5">
						<input type="hidden" id="m_receiver_other_unit_ids"   name="m_receiver_other_unit_ids" value="" />
						<input type="hidden" id="m_receiver_other_unit_names" name="m_receiver_other_unit_names" value="" />
						<input type="hidden" id="m_receiver_other_user_ids"   name="m_receiver_other_user_ids"   value="" />
						<input type="hidden" id="m_receiver_other_user_names" name="m_receiver_other_user_names" value="" ></input>
						<textarea id="userTd4Other" name= "userTd4Other"  class="validate[maxSize[5000]] textarea_575"  style="width:98%" rows="5" readonly="readonly" onclick="adddeptanduser4Other()" ></textarea>
					</td>
				</tr>
				<tr>
					<td class="content_02_box_div_table_td" colspan="5"><!-- 手工输入 -->
						<textarea id="m_other_user_input" name="m_other_user_input"  class="validate[maxSize[500]] textarea_575" style="width:98%" rows="5"></textarea>
					</td>
				</tr>
			</table>
		</div>
		<!-- end--------------------------------------------------------------------------------------------------------- -->
			
		<!-- 消息提醒begin -->
	<%if("1".equals(is_pub_sms) || "1".equals(is_pub_rtx) || "1".equals(is_pub_msg) || "1".equals(is_pub_mail)){ %>
			<div class="content_02_box_title_bg" >
				<span>消息提醒</span>
			</div>
			<input type="hidden" id="m_id" name="m_id" value="" />
			<input type="hidden" id="" name="" value="" />
			<div class="content_02_box_div" style="width: 97.5%;">
				<table border="0" cellspacing="0" cellpadding="0" class="content_02_box_div_table" style="width: 100%;">
					<tr>
						<th class="content_02_box_div_table_th"  style="width:191px;">提醒方式：</th>
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
</div>
</body>
</html>
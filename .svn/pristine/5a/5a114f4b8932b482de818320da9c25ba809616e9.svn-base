<%-- 
描述：会议通知报名回复界面
作者：黄海
版本：1.0
日期：2013-06-29
 --%>
<%@page import="com.chinacreator.xtbg.core.sysparam.util.SysParamConstant"%>
<%@page import="java.util.List"%>
<%@page import="com.chinacreator.xtbg.core.sysparam.util.SysParamUitl"%>
<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DictDropDownList"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.core.meeting.util.MeetingConstants"%>
<%@page import="com.chinacreator.xtbg.core.meeting.service.MeetingHandleServiceIfc" %>
<%@page import="com.chinacreator.xtbg.core.meeting.service.impl.MeetingHandleServiceImpl" %>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%
AccessControl accesscontroler = AccessControl.getAccessControl();
accesscontroler.checkAccess(request, response);
String path = request.getContextPath();
String reply = StringUtil.deNull(request.getParameter("reply"));//为1时=view页面打开报名的标识
String m_notice_id = StringUtil.deNull(request.getParameter("m_notice_id"));
String m_user_id = StringUtil.deNull(accesscontroler.getUserID());
String m_user_name = StringUtil.deNull(accesscontroler.getUserName());
Map<String, String> map = new HashMap<String, String>(); 
String m_receiver_id = "";
String m_receiver_user_id = "";
String m_receiver_user_name = "";
String m_is_reply = "";	
String m_reply = "";
String m_is_reply_name = "";
String m_reply_time = "";
String m_is_read = "";
String m_read_time = "";
String m_link_user_id = m_user_id;
String m_link_user_name = m_user_name;
String m_link_tel = StringUtil.deNull(accesscontroler.getUserPhone());
String m_is_log = "";
String m_attender_count = "0";
String m_attender_ids = m_user_id;
String m_attender_names = m_user_name;
String m_create_time = "";
String canUpate="";
MeetingHandleServiceIfc service = new MeetingHandleServiceImpl();
if (!StringUtil.nullOrBlank(m_notice_id) && !StringUtil.nullOrBlank(m_user_id)){
	map = (HashMap <String, String>)service.getMeetingReceiverInfo(m_notice_id,m_user_id);
	if(map.size()>0){
		m_receiver_id = StringUtil.deNull(map.get("m_receiver_id"));
		m_is_reply = StringUtil.deNull(map.get("m_is_reply"));
		m_is_reply_name = StringUtil.deNull(map.get("m_is_reply_name"));
		m_reply = StringUtil.deNull(map.get("m_reply"));
		m_is_read = StringUtil.deNull(map.get("m_is_read"));
		if(!StringUtil.nullOrBlank(map.get("m_link_user_id"))){
			m_link_user_id = StringUtil.deNull(map.get("m_link_user_id")) ;
			m_link_user_name = StringUtil.deNull(map.get("m_link_user_name"));
		}
		if(!StringUtil.nullOrBlank(map.get("m_link_tel"))){
			m_link_tel = StringUtil.deNull(map.get("m_link_tel"));
		}
		if(!StringUtil.nullOrBlank(map.get("m_attender_ids"))){
			m_attender_ids = StringUtil.deNull(map.get("m_attender_ids"));
			m_attender_names = StringUtil.deNull(map.get("m_attender_names"));
		}
		m_is_log = StringUtil.deNull(map.get("m_is_log"));
		m_attender_count = StringUtil.deNull(map.get("m_attender_count"));
		m_create_time = StringUtil.deNull(map.get("m_create_time"));
		if(!StringUtil.nullOrBlank(m_is_reply_name)) {
			canUpate="no";
		}
	}
}

String sql = "select d.dictdata_value, d.dictdata_name,d.dictdata_id  from OA_DICT_DATA d, OA_DICT_TYPE t  where t.dict_code = 'bmqk'    and d.dict_id = t.dict_id    and t.dict_is_valid = 1    and d.dictdata_is_valid = 1 and d.dictdata_value<>'0' order by  d.dictdata_value ";
String m_is_replyselectHtml =DictDropDownList.buildSelect4Expand(sql,"m_is_reply", StringUtil.deNull(m_is_reply), "", true, "","width:140px","class='validate[required]'");

//判断是否有短信，及时，邮件，站内消息提示
SysParamUitl noticeutil=new SysParamUitl();
Map<String,String> msgmap=noticeutil.getCheckedSystemMsg();
String is_pub_sms=msgmap.get(SysParamConstant.IS_PUB_SMS);
String is_pub_msg=msgmap.get(SysParamConstant.IS_PUB_MSG);
String is_pub_rtx=msgmap.get(SysParamConstant.IS_PUB_RTX);
String is_pub_mail=msgmap.get(SysParamConstant.IS_PUB_MAIL);

//Map<String, String> map = new HashMap<String, String>(); 
Map<String, String> map4Msg = new HashMap<String, String>(); 
String checkpass = SysParamUitl.getSysParamValueIsVALID(MeetingConstants.MEETING_MSG_REPLY);
String m_msg_contents="";
String msg_contents="";
if(!StringUtil.nullOrBlank(checkpass)){
	m_msg_contents = SysParamUitl.getSysParamValue(checkpass);
	List<Map<String, String>> listmap = SysParamUitl.getSysParamValueDetail(checkpass);
	 if(!StringUtil.nullOrBlank(m_msg_contents) && listmap!=null && listmap.size()>0){
		for (Map<String, String> map1 : listmap){
			//System.out.println("map.get(\"p_value_name\")=="+map.get("p_value_name")+",map.get(\"p_value_code\")==="+map.get("p_value_code")+",kbmDocMap.get(map.get(\"p_value_code\"))=="+kbmDocMap.get(map.get("p_value_code")));
			if(map4Msg!=null && map4Msg.size()>0 && !StringUtil.nullOrBlank(map4Msg.get(map1.get("p_value_code")))){
				//m_msg_contents = m_contents.replaceAll(map.get("p_value_name"),map4Msg.get(map1.get("p_value_code")));
			}
		}
	}	
}

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"></meta>
<title>会议通知报名回复界面</title>
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
var reply = "<%=reply%>";
jQuery(function(){
	jQuery("#m_reply").focus();
	jQuery("#m_receiver_id").val('<%=m_receiver_id%>');   
	jQuery("#m_is_reply").val('<%=m_is_reply%>'); 
	jQuery("#m_reply").val('<%=m_reply%>');   
	jQuery("#m_is_reply_name").val('<%=m_is_reply_name%>');   
	jQuery("#m_is_read").val('<%=m_is_read%>');   
	jQuery("#m_link_user_id").val('<%=m_link_user_id%>');   
	jQuery("#m_link_user_name").val('<%=m_link_user_name%>');   
	jQuery("#m_link_tel").val('<%=m_link_tel%>');   
	if (!isSpace('<%=m_is_log%>')){ 
    	jQuery('input[name="m_is_log"]').get('<%=m_is_log%>').checked = true;
    }
	jQuery("#m_attender_count").val('<%=m_attender_count%>');	
	   
	jQuery("#m_attender_ids").val('<%=m_attender_ids%>');   
	jQuery("#m_attender_names").val('<%=m_attender_names%>');   
	jQuery("#m_create_time").val('<%=m_create_time%>');  
	if('no'=='<%=canUpate%>'){
		jQuery("#replybutton").hide();
	}
	jQuery("#m_create_time").prop("disabled", true);
	jQuery("#m_link_user_name").prop("disabled", true);
	
	if(jQuery("#m_attender_count").val()==""){
		jQuery("#m_attender_count").val(jQuery("#m_attender_ids").val().split(',').length);
	}
	
	jQuery("#m_is_reply").change(function(){
		if (jQuery("#m_is_reply").val()=='<%=MeetingConstants.REPLY_Leave%>'){
			jQuery("#m_attender_count").val("0");
			jQuery("#m_attender_ids").val("");
			jQuery("#m_attender_names").val("");
			jQuery("#m_attender_names").prop("disabled", true);
		}else{
			if (isSpace(jQuery("#m_attender_ids").val())){
				jQuery("#m_attender_count").val("0");
			}else{
				jQuery("#m_attender_count").val(jQuery("#m_attender_ids").val().split(',').length);
			}
			jQuery("#m_attender_names").prop("disabled", false);
		}
    });
});

/* 
函数:  setValue4m_msg_contents
说明:  事件响应方法设置短信模板
*/
function setValue4m_msg_contents(id){
	var m_msg_contents=changemsg();
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
function changemsg(){
	var m_attender_names=jQuery("#m_attender_names").val();
	var contents=jQuery("#m_msg_contents").val();
	if(!IsSpace(m_attender_names)){
		contents=contents.replaceAll("【参会人员】","【"+m_attender_names+"】");
	}
	
	return contents;
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
函数:  signupMeeting
说明:  报名回复
*/
function signupMeeting(){
	//自动校验
	ischecked();
	var isFlag = jQuery('#form1').validationEngine('validate'); //是否全部验证通过
	if (!isFlag){
		return isFlag;	
	}
	if(isSpace(jQuery("#m_receiver_id").val())){
		alert("数据记录不存在！");
		return;
	}
	if(jQuery("#m_is_reply").val()=="2" || jQuery("#m_is_reply").val()=="3"){//选择了2委托人参会或3安排人参会，要做短信提示的判断
		if (jQuery("#is_sms")[0]==undefined && jQuery("#is_mail")[0]==undefined && jQuery("#is_rtx")[0]==undefined && jQuery("#is_msg")[0]==undefined){
			var is_sms = "";
			var is_mail = "";
			var is_rtx = "";
			var is_msg = "";
		}else{
			var is_sms = jQuery("#is_sms")[0].checked;
			var is_mail = jQuery("#is_mail")[0].checked;
			var is_rtx = jQuery("#is_rtx")[0].checked;
			var is_msg = jQuery("#is_msg")[0].checked;
		}
		
		if (!isSpace(is_sms) || !isSpace(is_mail)|| !isSpace(is_rtx)|| !isSpace(is_msg)){//发消息 ，就要判断内容不可为空
			if(isSpace(jQuery('#msg_contents').val())){
				alert("注意：提醒内容不能空！");
				return false;
			}
		}else if (!isSpace(jQuery('#msg_contents').val()) && isSpace(is_sms) && isSpace(is_mail)&& isSpace(is_rtx)&& isSpace(is_msg) ){
			alert("注意：提醒方式不能空！");
			return false;
		}
	}
	var m_msg_send_flag = '<%=MeetingConstants.MSG_GO_SEND%>';
	var m_msg_send_flag_name = "转发";
	if (!isSpace(jQuery('#m_msg_contents').val()) && (!isSpace(is_sms) || !isSpace(is_mail)|| !isSpace(is_rtx)|| !isSpace(is_msg))) {//发消息 ，就要判断内容不可为空
		var meetingmsglogjson = "{"+getAlertWindowMeetingmsglogJson(m_msg_send_flag,m_msg_send_flag_name,jQuery("#m_notice_id").val())+"}";
	}else{
		var meetingmsglogjson = "";
	}
	
	var meetingreceiveruserbeanjson = "{'m_receiver_id':'"+jQuery("#m_receiver_id").val()+"',"+
				"'m_is_reply':'"+jQuery("#m_is_reply").val()+"',"+
				"'m_reply':'"+jQuery("#m_reply").val()+"',"+
				"'m_notice_id':'"+jQuery("#m_notice_id").val()+"',"+
				"'m_is_reply_name':'"+jQuery("#m_is_reply").find("option:selected").text()+"',"+
				"'m_is_read':'1',"+
				"'m_link_user_id':'"+jQuery("#m_link_user_id").val()+"',"+
				"'m_link_user_name':'"+jQuery("#m_link_user_name").val()+"',"+
				"'m_link_tel':'"+jQuery("#m_link_tel").val()+"',"+
				"'m_is_log':'"+jQuery('input:radio[name="m_is_log"]:checked').val()+"',"+
				"'m_attender_count':'"+jQuery("#m_attender_count").val()+"',"+
				"'m_attender_ids':'"+jQuery("#m_attender_ids").val()+"',"+
				"'m_attender_names':'"+jQuery("#m_attender_names").val()+"'}";	
	var okF = function() {
		url = "meetingsignupdo.jsp";
		jQuery.ajax({
			url : url,
			type : 'POST',
			dataType : 'json',
			data : {
				meetingreceiveruserbeanjson:meetingreceiveruserbeanjson,
				meetingmsglogjson  : descape(escape(meetingmsglogjson))
			},
			async : true,
			success : function(flag) {
				if (flag) {
					alert("操作成功！");
				} else {
					alert("操作失败！");
				}
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
	alert("确定要回复吗？", p);		
}
function onchangemsg(id){
	   if(jQuery("#is_sms").attr("checked")=="checked" || jQuery("#is_rtx").attr("checked")=="checked" || jQuery("#is_msg").attr("checked")=="checked" || jQuery("#is_mail").attr("checked")=="checked" ){
			var contents= changemsg();
			jQuery("#msg_contents").val(contents);
		}
	  }
/*
函数:  returnReplaceNoteContents
说明:  用替代后短信内容设置页面上短信内容的文本域
参数:  替代后短信内容
*/
function replaceNoteContents(str){
	var tabwindow = getParentWindow('');
	if(reply=="1"){
		jQuery("#m_msg_contents").val(tabwindow.window.returnReplaceNoteContents(str));//window.parent=meetingnoticeview.jsp
	}else{
		jQuery("#m_msg_contents").val(tabwindow.frame1.window.returnReplaceNoteContents(str));	
	}
}



</script>
</head>
<body onload="">
<form action="" id="form1" name="form1" method="post" >
<textarea style="display: none" name="m_msg_contents" id="m_msg_contents"  > <%=m_msg_contents %></textarea>
	<div class="cue_box_top">
		<input class="but_y_01" type="button" value="关闭" onclick="removeAlertWindows('windowId',true)" />
		<input id="replybutton" class="but_y_01" type="button" value="确认回复" onclick="signupMeeting()" />
	</div>
	<!-- 回复意见begin -->
	<div class="content_02_box" style="width:98%;">
		<div class="content_02_box_title_bg" style="width:100%;">
			<span>回复意见</span>
		</div>
		<div class="content_02_box_div"  style="width:100%;">
			<table border="0" cellspacing="0" cellpadding="0"   style="width:100%;">
				<tr>
					<th class="content_02_box_div_table_th" style="width:100px;"><span class="color_red">*</span>是否参加：</th>
					<td class="content_02_box_div_table_td" style="width:200px;">
						<%=m_is_replyselectHtml%>
					</td>
					<th class="content_02_box_div_table_th" style="width:100px;"><span class="color_red">*</span>联系人：</th>
					<td class="content_02_box_div_table_td" style="width:200px;">
						<input type="hidden" name="m_link_user_id" id="m_link_user_id"  />
					    <input type="text" id="m_link_user_name" name="m_link_user_name" class="validate[required] xz_89_border" 
					    	onclick="chooseActUsers('m_link_user_id','m_link_user_name','m_link_dept_name','radio')" />
					</td>
					<th class="content_02_box_div_table_th" style="width:100px;"><span class="color_red">*</span>联系电话：</th>
					<td class="content_02_box_div_table_td" style="width:200px;">
						<input type="text"   name="m_link_tel" id="m_link_tel" value="<%=m_link_tel%>" class="validate[custom[phone],required] input_cx_title_120" />
					</td>
				</tr>
				<tr>	
					<th class="content_02_box_div_table_th" >参会人员：</th>
					<td class="content_02_box_div_table_td" colspan=5>
						<input type="hidden" name="m_attender_ids" id="m_attender_ids"  />
					    <input type="text" id="m_attender_names" name="m_attender_names" class="xz_89_border"  style="width:450px;"
					    	onclick="chooseActUsersSetCount('m_attender_ids','m_attender_names','','checkbox')"  />
					</td>
				</tr>
				<tr>
					<th class="content_02_box_div_table_th" >参会人数：</th>
					<td class="content_02_box_div_table_td" >
						<input type="text" name="m_attender_count" id="m_attender_count" value="" class="validate[positiveinteger,maxSize[50]] input_cx_title_120" />
					</td>
					<th class="content_02_box_div_table_th" >接收时间：</th>
					<td class="content_02_box_div_table_td" >
						<input  class="validate[required] date_120 Wdate"
							type="text" id="m_create_time" name="m_create_time"
							onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" />
					</td>
					<th class="content_02_box_div_table_th" >是否关联日程：</th>
					<td class="content_02_box_div_table_td" >
						<input type="radio" value="0" name="m_is_log" id="m_is_log0" checked="checked" />
						否&nbsp;&nbsp;
						<input type="radio" value="1" name="m_is_log" id="m_is_log1"  />
						是
					</td>
				</tr>
				<tr>	
					<th class="content_02_box_div_table_th" >回复意见：</th>
					<td class="content_02_box_div_table_td" colspan=5>
						<textarea id="m_reply" name="m_reply" style="width:98%" rows="5" ></textarea>				
					</td>
				</tr>
				
				
			</table>
		</div>
		<!-- 与会单位与人员 end -->
			<!-- 消息提醒begin -->
			<%if(("1".equals(is_pub_sms) || "1".equals(is_pub_rtx) || "1".equals(is_pub_msg) || "1".equals(is_pub_mail))&& (StringUtil.nullOrBlank(m_is_reply_name))){ %>
			<div class="content_02_box_title_bg" style="width: 100%;">
				<span>消息提醒</span>
			</div>
			<input type="hidden" id="m_id" name="m_id" value="" />
			<input type="hidden" id="" name="" value="" />
			<div class="content_02_box_div" style="width: 100%;">
				<table border="0" cellspacing="0" cellpadding="0" class="content_02_box_div_table" style="width: 100%;">
					<tr>
						<th class="content_02_box_div_table_th"  style="width:200px;">提醒方式：</th>
						<td class="content_02_box_div_table_td" colspan="3">
							<%if("1".equals(is_pub_sms)){ %>
							<input name="m_msg_type" id="is_sms" type="checkbox"  value="" onclick="setValue4m_msg_contents(this.id);" />&nbsp;短信
							&nbsp;<%} %>
							<%if("1".equals(is_pub_mail)){ %>
							<input name="m_msg_type" id="is_mail" type="checkbox" onclick="setValue4m_msg_contents(this.id);"  value="" />&nbsp;邮件&nbsp;
							<%} if("1".equals(is_pub_rtx)){%>
							<input name="m_msg_type" id="is_rtx" type="checkbox"  onclick="setValue4m_msg_contents(this.id);" value="" />&nbsp;即时信息&nbsp;
							<%} if("1".equals(is_pub_msg)){%>
							<input name="m_msg_type" id="is_msg" type="checkbox"  onclick="setValue4m_msg_contents(this.id);" value="" />&nbsp站内信息&nbsp;
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
							<textarea id="msg_contents" name="msg_contents" class="validate[maxSize[300]] textarea_575" cols="110" rows="2" ><%=msg_contents%></textarea>
						</td>
					</tr>
				</table>
				<table border="0" cellspacing="0" cellpadding="0"><tr><td height=50></td></tr></table>
			</div>
			<%} %>
			<!-- 消息提醒end -->
	</div>
	<!-- 回复意见结束 --> 
	<input type="hidden" name="m_notice_id" id="m_notice_id" value="<%=m_notice_id %>" />
	<input type="hidden" name="m_user_id" id="m_user_id" value="<%=m_user_id %>" />
	<input type="hidden" name="m_receiver_id" id="m_receiver_id" value="<%=m_receiver_id %>" />
</form>
</body>
</html>
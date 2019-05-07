<%--
　　描述：会议报名情况列表查询--未报名
　　作者：黄海
　　版本：1.0
　　日期：2013-6-24
--%>
<%@page import="com.chinacreator.xtbg.core.sysparam.util.SysParamConstant"%>
<%@page import="java.util.List"%>
<%@page import="com.chinacreator.xtbg.core.sysparam.util.SysParamUitl"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DaoUtil"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.core.meeting.util.MeetingConstants"%>
<%@page import="com.chinacreator.xtbg.core.meeting.entity.*" %>
<%@page import="com.chinacreator.xtbg.core.meeting.service.MeetingHandleServiceIfc" %>
<%@page import="com.chinacreator.xtbg.core.meeting.service.impl.MeetingHandleServiceImpl" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%
AccessControl accesscontroler = AccessControl.getAccessControl();
accesscontroler.checkAccess(request, response);
String path = request.getContextPath();
String m_notice_id = request.getParameter("m_notice_id");  //会议通知主键
String m_is_reply = request.getParameter("m_is_reply");//未报名

MeetingHandleServiceIfc service = new MeetingHandleServiceImpl();
MeetingNoticeBean mnbean = service.getMeetingNoticeBeanById(m_notice_id);

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

//判断是否有短信，及时，邮件，站内消息提示
SysParamUitl noticeutil=new SysParamUitl();
Map<String,String> msgmap=noticeutil.getCheckedSystemMsg();
String is_pub_sms=msgmap.get(SysParamConstant.IS_PUB_SMS);
String is_pub_msg=msgmap.get(SysParamConstant.IS_PUB_MSG);
String is_pub_rtx=msgmap.get(SysParamConstant.IS_PUB_RTX);
String is_pub_mail=msgmap.get(SysParamConstant.IS_PUB_MAIL);
%>
<meta>
<title>会议报名情况列表查询--未报名</title>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../resources/plug/jquery1.7/jquery-1.7.1.min.js"></script>
<script src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>
<script src="../../resources/plug/jquery.jqGrid-4.3.1/js/i18n/grid.locale-en.js" type="text/javascript"></script>
<script src="../../resources/plug/jquery.jqGrid-4.3.1/js/jquery.jqGrid.min-sp1.js" type="text/javascript"></script>
<!-- 引入其它 -->
<script src="../../resources/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js" ></script>
<script type="text/javascript" src="../resources/js/meetingnoticedetail.js"></script>

<script>
/*
	配置jqGrid，与会单位报名情况列表查询--未报名
*/
var m_msg_contents = "<%=m_msg_contents%>";
$(function() {
	$("#gridTable1").jqGrid({//pubListServlet列表公共的servlet,classNameId在servletBean.xml文件中配置要调用的类,isPage:是否翻页(true,false),默认为true
		url: '<%= path %>' + '/pubListServlet?classNameId=com.chinacreator.xtbg.core.meeting.list.MeetingReceiverUnitList',
		datatype: "json",
		mtype: "POST",
		height: "100%",
		autowidth: true,
		colModel: [ //最重要的数组之一，用于设定各列的参数
        {
			label: '接收表主键id',
			name: 'm_receiver_id',
			index: 'm_receiver_id',
			hidden:true
		},{
			label: '会议通知id',
			name: 'm_notice_id',
			index: 'm_notice_id',
			hidden:true
		},{	
			label: '参会单位名称',
			name: 'm_receiver_unit_name',
			index: 'm_receiver_unit_name',
			width: 100
		},{
			label: '参会人数',
			name: 'm_attender_count',
			index: 'm_attender_count',
			width: 100
		},{
			label: '参加人',
			name: 'm_attender_names',
			index: 'm_attender_names',
			width: 100
		},{
			label: '联系人',
			name: 'm_link_user_name',
			index: 'm_link_user_name',
			width: 100
		},{
			label: '联系电话',
			name: 'm_link_tel',
			index: 'm_link_tel',
			width: 80
		},{
			label: '回复意见',
			name:  'm_reply',
			index: 'm_reply',
			width: 100
		},{
			label: '报名情况',
			name: 'm_is_reply_name',
			index: 'm_is_reply_name',
			width: 100
		},{
			label: '接收时间',
			name: 'm_create_time',
			index: 'm_create_time',
			width: 100
		},{
			label: '回复时间',
			name: 'm_reply_time',
			index: 'm_reply_time',
			width: 100
		}
		],
		sortname: 'm_receiver_unit_name',
		sortorder: 'desc',
		viewrecords: true,
		rowNum: 10,
		rowList: [10, 20, 30],
		gridComplete: function() {
		},
		jsonReader: { //这又是一个数组，用来设定如何解析从Server端发回来的json数据
			repeatitems: false
		},
		onCellSelect:function (id,icol)
		{
			if(icol != 0)
			{
			}
		},
		pagerintoolbar:true,//上面的分页条
		pagerinBottombar:true,//下面的分页条
		search : convertParamJson(),
		prmNames: { //这是一个数组，用于设置jqGrid将要向Server传递的参数名称
			rows: "rows",
			sort: "sidx",
			order: "sord",
			search : "search"
		},
		multiselect: true
	}).navGrid('#gridPager1', {
		edit: false,
		add: false,
		del: false,
		search : false,
		refresh : false
	});
	
	$("#gridTable4User").jqGrid({//pubListServlet列表公共的servlet,classNameId在servletBean.xml文件中配置要调用的类,isPage:是否翻页(true,false),默认为true
		url: '<%= path %>' + '/pubListServlet?classNameId=com.chinacreator.xtbg.core.meeting.list.MeetingReceiverUserList',
		datatype: "json",
		mtype: "POST",
		height: "100%",
		autowidth: true,
		colModel: [ //最重要的数组之一，用于设定各列的参数
        {
			label: '接收表主键id',
			name: 'm_receiver_id',
			index: 'm_receiver_id',
			hidden:true
		},{
			label: '会议通知id',
			name: 'm_notice_id',
			index: 'm_notice_id',
			hidden:true
		},{
			label: 'm_receiver_user_id',
			name: 'm_receiver_user_id',
			index: 'm_receiver_user_id',
			hidden:true
		},{	
			label: '参会单位名称',
			name: 'm_receiver_unit_name',
			index: 'm_receiver_unit_name',
			width: 100
		},{	
			label: '参会人员名称',
			name: 'm_receiver_user_name',
			index: 'm_receiver_user_name',
			width: 100
		},{
			label: '参会人数',
			name: 'm_attender_count',
			index: 'm_attender_count',
			width: 100
		},{
			label: '参加人',
			name: 'm_attender_names',
			index: 'm_attender_names',
			width: 100
		},{
			label: '联系人',
			name: 'm_link_user_name',
			index: 'm_link_user_name',
			width: 100
		},{
			label: '联系电话',
			name: 'm_link_tel',
			index: 'm_link_tel',
			width: 80
		},{
			label: '回复意见',
			name: 'm_reply',
			index: 'm_reply',
			width: 100
		},{
			label: '报名情况',
			name: 'm_is_reply_name',
			index: 'm_is_reply_name',
			width: 100
		},{
			label: '接收时间',
			name: 'm_create_time',
			index: 'm_create_time',
			width: 100
		},{
			label: '回复时间',
			name: 'm_reply_time',
			index: 'm_reply_time',
			width: 100
		}
		],
		sortname: 'm_receiver_unit_name',
		sortorder: 'desc',
		viewrecords: true,
		rowNum: 10,
		rowList: [10, 20, 30],
		gridComplete: function() {
		},
		jsonReader: { //这又是一个数组，用来设定如何解析从Server端发回来的json数据
			repeatitems: false
		},
		onCellSelect:function (id,icol)
		{
			if(icol != 0)
			{
			}
		},
		pagerintoolbar:true,//上面的分页条
		pagerinBottombar:true,//下面的分页条
		search : convertParamJson4User(),
		prmNames: { //这是一个数组，用于设置jqGrid将要向Server传递的参数名称
			rows: "rows",
			sort: "sidx",
			order: "sord",
			search : "search"
		},
		multiselect: true
	}).navGrid('#gridPager4User', {
		edit: false,
		add: false,
		del: false,
		search : false,
		refresh : false
	});
});
/*
	 函数:  convertParamJson
	 说明:  构建要查询的参数
	 参数:   无
	 返回值: 返回要查询的参数
*/
var convertParamJson = function () {
    var str = "{" + 
    	"'m_is_reply':'"  + $("#m_is_reply").val() + "',"+
    	"'m_notice_id':'" + $("#m_notice_id").val() + 
   	"'}";
    return descape(str);
}

/*
	 函数:  refreshGrid
	 说明:  静态加载列表数据，主要供子页面调用和删除字段后调用
	 参数:   无
 */
function refreshGrid() {
	var sdata = { //构建查询需要的参数 
		paramJson : convertParamJson()
	}; //获得当前postData选项的值  
	var postData = $("#gridTable1").jqGrid("getGridParam", "postData"); //将查询参数融入postData选项对象  
	$.extend(postData, sdata);
	$("#gridTable1").jqGrid("setGridParam", {
		search : true
	// 将jqGrid的search选项设为true  
	}).trigger("reloadGrid", [ {
		page : 1
	} ]); //重新载入Grid表格，以使上述设置生效
}

/*
	 函数:  convertParamJson4User
	 说明:  构建要查询的参数
	 参数:   无
	 返回值: 返回要查询的参数
*/
var convertParamJson4User = function () {
    var str = "{" + 
    	"'m_is_reply':'"  + $("#m_is_reply").val() + "',"+
    	"'m_notice_id':'" + $("#m_notice_id").val() + 
   	"'}";
    return descape(str);
}
/*
 函数:  refreshGrid4User
 说明:  静态加载列表数据，主要供子页面调用和删除字段后调用
 参数:   无
 */
function refreshGrid4User() {
	var sdata = { //构建查询需要的参数 
		paramJson : convertParamJson4User()
	}; //获得当前postData选项的值  
	var postData = $("#gridTable4User").jqGrid("getGridParam", "postData"); //将查询参数融入postData选项对象  
	$.extend(postData, sdata);
	$("#gridTable4User").jqGrid("setGridParam", {
		search : true
	// 将jqGrid的search选项设为true  
	}).trigger("reloadGrid", [ {
		page : 1
	} ]); //重新载入Grid表格，以使上述设置生效
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
	函数:  callsendMsg
	说明:  催发
*/
function callsendMsg(){
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
	
	var meetingnoticedetailjson = "{'m_notice_id':'"+m_notice_id+"'}"; 
	var userids="";//人员接收表主键
	var unitids="";//单位接收表主键
	var users="";//要催发的人员
	
	var selectedIds = $("#gridTable1").jqGrid("getGridParam", "selarrrow");
	for ( var i = 0; i < selectedIds.length; i++) {
		var model = jQuery("#gridTable1").jqGrid('getRowData',selectedIds[i]);
		if ("" != unitids) {
			unitids += ",";
		}
		unitids += "'" + model.m_receiver_id + "'";
		//加入单位人员？after do
	}
	
	var selectedIds4User = $("#gridTable4User").jqGrid("getGridParam", "selarrrow");
	for ( var i = 0; i < selectedIds4User.length; i++) {
		var model = jQuery("#gridTable4User").jqGrid('getRowData',selectedIds4User[i]);
		if ("" != userids) {
			userids += ",";
		}
		userids += "'" + model.m_receiver_id + "'";
		users += "'" + model.m_receiver_user_id + "',"
	}
	
	if(isSpace(userids)&&isSpace(unitids)){
		alert("注意：请选择要催发的单位或人员");
		return;
	}
	var m_msg_send_flag = '<%=MeetingConstants.MSG_CALL_SEND%>';
	var m_msg_send_flag_name = "催发";
	
	//重发使用重发界面的消息提醒信息内容
	if (!isSpace(jQuery('#msg_contents').val()) && (is_sms || is_msg || is_rtx|| is_mail)) {//发消息 ，就要判断内容不可为空
		var meetingmsglogjson = "{"+getAlertWindowMeetingmsglogJson(m_msg_send_flag,m_msg_send_flag_name,jQuery("#m_notice_id").val())+"}";
	}else{
		var meetingmsglogjson = "";
	}
    
	var data = {
		meetingmsglogjson  : descape(escape(meetingmsglogjson)),
		meetingnoticedetailjson  : descape(escape(meetingnoticedetailjson)),
		userids : userids,
		unitids : unitids,
		users   : users,
		m_notice_id : $("#m_notice_id").val()
	}
	
	var okF = function() {
		url = "meetingcallsenddo.jsp";
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
	alert("确定要催发吗？", p);			
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
	jQuery("#msg_contents").val(returnReplaceNoteContents(str));
}

/*
函数:  returnReplaceNoteContents
说明:  用模板生成短信内容
参数:  模板内容
返回值: 替代后的模板内容
*/
function returnReplaceNoteContents(str){
	var contents = str;
	var repTitle = delSpace(jQuery("#m_title").val());
	var repAddress = delSpace(jQuery("#m_address").val());
	var repTime = delSpace(jQuery("#m_begin_time").val())+"至"+delSpace(jQuery("#m_end_time").val());
	var strTitle = "【会议名称】";
	var strAddress = "【会议地点】";
	var strTime = "【会议时间】";
	contents = contents.replace(strTitle,repTitle);
	contents = contents.replace(strAddress,repAddress);
	contents = contents.replace(strTime,repTime);
	return (contents);	
}
</script>
</head>
<body style="overflow: hidden;">
<div id="vcenter" style="float:left; width:100%;height:300px">
	<div class="cue_box_top">
		<input class="but_y_01" type="button" value="关闭" onclick="removeAlertWindows('',true)" />
		<input class="but_y_01" type="button" value="催发" onclick="callsendMsg()" />
	</div>
	<div>
	<%if("1".equals(is_pub_sms) || "1".equals(is_pub_rtx) || "1".equals(is_pub_msg) || "1".equals(is_pub_mail)){ %>
		<div class="content_02_box" style="width:99%">
			<div class="content_02_box_title_bg" style="width:99%"><span>消息提醒</span></div>
		</div>
		
		<div class="content_02_box_div_table"  style="width:99%;margin-left:10px;"  >
			<table border="0" cellspacing="0" cellpadding="0" class="content_02_box_div_table" style="width: 99%;">
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
		</div>
		<%} %>
	</div>
	<div class="content_02_box" style="width:99%">
		<div class="content_02_box_title_bg" style="width:99%"><span>单位</span></div>
	</div>
	<div class="content_02_box_div_special" style="width:100%">
		<table id="gridTable1">
		</table>
		<div id="gridPager1">
		</div>
	</div>
	<table>
	    <tr>
	        <td height="10px"></td>
	    </tr>
	</table>
	<div class="content_02_box" style="width:99%">
		<div class="content_02_box_title_bg" style="width:99%"><span>个人</span></div>
	</div>
	<div class="content_02_box_div_special" style="width:100%" >
		<div class="cGridArea">
			<table id="gridTable4User">
			</table>
			<div id="gridPager4User">
			</div>
		</div>
	</div>
	<input type="hidden" name="m_id" id="m_id" value="">
	<input type="hidden" name="m_notice_id" id="m_notice_id" value="<%=m_notice_id %>">
	<input type="hidden" name="m_is_reply" id="m_is_reply" value="<%=m_is_reply %>">
	<input type="hidden" id="m_title" value="<%=mnbean.getM_title() %>">
	<input type="hidden" id="m_begin_time" value="<%=mnbean.getM_begin_time() %>">
	<input type="hidden" id="m_end_time" value="<%=mnbean.getM_end_time() %>">
	<input type="hidden" id="m_address" value="<%=mnbean.getM_address() %>">
</div>
</body>
</html>

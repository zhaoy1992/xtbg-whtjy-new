<%-- 
描述：添加会议室预约页面
作者：黄艺平
版本：1.0
日期：2013-06-28
 --%>
<%@page import="com.chinacreator.xtbg.core.common.cache.UserCache"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DictDropDownList"%>
<%@ page import="java.util.Date"%>
<%
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	String user_id = accesscontroler.getUserID();
	
	UserCacheBean userbean=UserCache.getUserCacheBean(user_id);
	String username="";
	String userphone="";
	String m_unit_id = "";
	if(userbean!=null){
		username=StringUtil.deNull(userbean.getUser_realname());
		userphone=StringUtil.deNull(userbean.getUser_mobiletel1());
		m_unit_id=StringUtil.deNull(userbean.getUnit_id());
	}
	int roomCount = 0;
	String m_room_id = StringUtil.deNull(request.getParameter("m_room_id"));
	String m_id = StringUtil.deNull(request.getParameter("m_id"));
	String meetingType = StringUtil.deNull(Escape.unescape(DataControlUtil.replaceStr(request.getParameter("meetingType"))));
	String meetingtime = StringUtil.deNull(request.getParameter("meetingtime"));
	
	MeetingRoomoccupancyServiceIfc meetingRoomoccupancyServiceIfc = new MeetingRoomoccupancyServiceImpl();
	Map<String, String> viewMap = new HashMap<String, String>();
	StringBuffer sql = new StringBuffer();
	sql.append("select r.m_room_id, r.m_room_name");
	sql.append("  from oa_meeting_room r");
	sql.append(" where m_is_use_flag='1'  and r.m_unit_id = '"+m_unit_id+"' order by r.m_room_name ");
	String roomHtml = DictDropDownList.buildSelectNoDefault(sql.toString(),"m_room_id","","",false,"");//会议室下拉框
	if(!StringUtil.isBlank(m_id)){
		roomCount = meetingRoomoccupancyServiceIfc.isCurRoomAdministrator(m_room_id, user_id);
		viewMap = meetingRoomoccupancyServiceIfc.geteMeetingRoomoccupancyBean(m_id, meetingType);
		
	}else{
		viewMap.put("m_link_userid",user_id);
		viewMap.put("m_link_username",username);
		viewMap.put("m_link_tel",userphone);
	} 
	

%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">


<%@page import="com.chinacreator.xtbg.core.meeting.service.MeetingRoomService"%>
<%@page import="com.chinacreator.xtbg.core.meeting.service.impl.MeetingRoomServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.meeting.service.MeetingRoomoccupancyServiceIfc"%>
<%@page import="com.chinacreator.xtbg.core.meeting.service.impl.MeetingRoomoccupancyServiceImpl"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.chinacreator.eform.util.Escape"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DataControlUtil"%><html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>会议室预约</title>

<!-- 引入jQuery -->
<script type="text/javascript" src="../../resources/plug/jquery1.7/jquery-1.7.1.min.js"></script>
<!-- 引入jQuery UI -->
<script src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>
<!-- 引入其它 -->
<script src="../../resources/util/public.js" type="text/javascript"></script>
<!-- 引入my97时间控件 -->
<script src="../../resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/JQuery zTree v3.0/js/jquery.ztree.core-3.0.js"></script>
<script type="text/javascript" src="../../resources/plug/JQuery zTree v3.0/js/jquery.ztree.excheck-3.0.js"></script>

<!-- 引入formvValidatetion -->
<script src="../../resources/plug/formvalidation/jquery.validationEngine-cn.js" type="text/javascript"></script>
<script src="../../resources/plug/formvalidation/jquery.validationEngine.js" type="text/javascript"></script>

<script type="text/javascript">
var adf= "<%=m_unit_id%>";
var roomCount = <%=roomCount %>;
$(function() {
	jQuery("#m_title").focus();
	if('' != '<%=m_id %>') {
		if(roomCount <= 0 || '会议通知' == '<%=meetingType %>') {
			jQuery("#savemeeting").hide("");
			jQuery("#m_room_viewname").show();
			jQuery("#m_room_id").hide();
		} else {
			jQuery("#m_room_id").val("<%=StringUtil.deNull(viewMap.get("m_room_id")) %>");
			jQuery("#m_room_viewname").hide();
		}
	} else {
		jQuery("#m_room_viewname").hide();
	}
	
});

/*
函数:  saveRoomReservation
说明:  保存会议室预约
参数:   无
*/
function saveRoomReservation() {

	jQuery("#m_room_name").val(jQuery("#m_room_id").find("option:selected").text());
	if(validateForm()){
		var okF = function(){
			$("#form1").attr("action","addroomreservationdo.jsp");
			$("#form1").attr("target","hiddenFrame");
			jQuery('#form1').submit();
		}
		var p={
				headerText:'提示',
				okName:'确认',
				okFunction:okF,
				cancelName:'取消'
		};
		alert('确定要保存会议室预约吗？ ',p)
	}
}


/*
 * description: 验证方法
 * author: 黄艺平
 * date: 2013-05-16
 * param:
 * return:  
 */
function validateForm(){
	if(jQuery("#form1").validationEngine("validateform")) {
		return true;
	} else {
		return false;
	}
}

/*
函数:  checkMeetingRoomOccupancy
说明:  验证会议室是否被点用
*/
function checkMeetingRoomOccupancy(name) {
	var m_begin_time;
	var m_end_time;
	var m_room_id;
	var m_ro_id;
	var params = {
			m_begin_time : jQuery("#m_begin_time").val(),
			m_end_time : jQuery("#m_end_time").val(),
			m_room_id : jQuery("#m_room_id").val(),
			m_ro_id : jQuery("#m_ro_id").val()
	};
	url = "checkroomoccupancydo.jsp";
	$.ajax({
		url : url,
		type : 'POST',
		dataType : 'json',
		data : params,
		async : true,
		success : function(flagStr) {
		  if(flagStr) {
		  } else {
			  alert('会议室被占用');
			  jQuery(name).val('');
		  } 
		  
		},
		error : function(jqXHR, textStatus, errorThrown) {
			alert("error:" + textStatus);
		}
	});
}

</script>

</head>
<body onload="">
<form action="" id="form1" name="form1" method="post">

<input type="hidden" id="m_ro_id" name="m_ro_id" value="<%=StringUtil.deNull(viewMap.get("m_ro_id")) %>"></input>

<div class="content_02_box">
	<div class="content_02_box_title_bg"><span></span></div>
		<div class="content_02_box_div">
			<table width="100%" border="0" cellspacing="0" cellpadding="0" class="content_02_box_div_table_02">
				<tr>
					<th class="content_02_box_div_table_th">
						<font color="red">*</font>会议标题:
					</th>
					<td class="content_02_box_div_table_td">
						<input id="m_title" name="m_title" value="<%=StringUtil.deNull(viewMap.get("m_title")) %>" onkeyup="checkInsert(this)" onbeforepaste="checkPaste()" class="validate[required,maxSize[100]] input_185" />
					</td>
					<th class="content_02_box_div_table_th">
						<font color="red">*</font>会议室名称:
					</th>
					<td class="content_02_box_div_table_td">
						<%=roomHtml %>
						<input class="input_185" id="m_room_viewname" name="m_room_viewname" value="<%=StringUtil.deNull(viewMap.get("m_room_name")) %>" />
						<input type="hidden" id="m_room_name" name="m_room_name" value="" />
					</td>
				</tr>
				<tr>
					<th class="content_02_box_div_table_th" >
						<font color="red">*</font>会议开始时间:
					</th>
					<td class="content_02_box_div_table_td">
						<input class="date_120 Wdate" type="text" id="m_begin_time" name="m_begin_time"  value="<%=StringUtil.deNull(viewMap.get("m_begin_time")) %>"
						onfocus="WdatePicker({onpicked:function(){checkMeetingRoomOccupancy(this)},dateFmt:'yyyy-MM-dd HH:mm'})" />
					</td>
					<th class="content_02_box_div_table_th">
						<font color="red">*</font>会议结束时间:
					</th>
					<td class="content_02_box_div_table_td">
						<input class="date_120 Wdate"  type="text" id="m_end_time" name="m_end_time" value="<%=StringUtil.deNull(viewMap.get("m_end_time")) %>"
							onfocus="WdatePicker({onpicked:function(){checkMeetingRoomOccupancy(this)},minDate:'#F{$dp.$D(\'m_begin_time\')}',dateFmt:'yyyy-MM-dd HH:mm'})"/>
					</td>
				</tr>
				<tr>
					<th class="content_02_box_div_table_th">
						<font color="red">*</font>联系人:
					</th>
					<td class="content_02_box_div_table_td">
						<input type="hidden" id="m_link_userid" name="m_link_userid" value="<%=StringUtil.deNull(viewMap.get("m_link_userid")) %>" ></input>
						<input id="m_link_username" name="m_link_username" onkeyup="checkInsert(this)" onbeforepaste="checkPaste()" value="<%=StringUtil.deNull(viewMap.get("m_link_username")) %>" class="validate[required,maxSize[100]] input_185"></input>
					</td>
					<th class="content_02_box_div_table_th" >
						<font color="red">*</font>联系电话:
					</th>
					<td class="content_02_box_div_table_td">
						<input id="m_link_tel" name="m_link_tel" value="<%=StringUtil.deNull(viewMap.get("m_link_tel")) %>" class="validate[required,custom[onlyNumberSp],maxSize[50]] input_185"></input>
					</td>
				</tr>
			</table>
		</div>
	</div>
	<div class="cue_box_foot">
		<input class="but_y_01" type="reset" id="resert" value="关闭" onclick="removeAlertWindows('roomReservation',true)" />
		<input class="but_y_01" type="button" id="savemeeting" value="确定" onclick="saveRoomReservation()"/>
  	</div>
</form>
<iframe name="hiddenFrame" width="0" height="0"></iframe>
</body>
</html>
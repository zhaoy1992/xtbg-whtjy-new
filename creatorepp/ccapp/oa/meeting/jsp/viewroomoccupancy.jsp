<%--
　　描述：查看会议室预订情况页面
　　作者：黄艺平
　　版本：1.0
　　日期：2013-6-26
--%>
<%@page import="com.chinacreator.security.authorization.AuthRole"%>
<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.common.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.alibaba.fastjson.JSONArray"%>
<%@page import="com.alibaba.fastjson.JSONObject"%>
<%@page import="com.chinacreator.xtbg.core.meeting.service.MeetingRoomService"%>
<%@page import="com.chinacreator.xtbg.core.meeting.service.impl.MeetingRoomServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.meeting.service.MeetingRoomoccupancyServiceIfc"%>
<%@page import="com.chinacreator.xtbg.core.meeting.service.impl.MeetingRoomoccupancyServiceImpl"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.util.Date"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.UserCache"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean"%><html>
<head>
<%
AccessControl accesscontroler = AccessControl.getAccessControl();
accesscontroler.checkAccess(request, response);
String path = request.getContextPath();
String user_id = accesscontroler.getUserID();
String org_id = accesscontroler.getChargeOrgId();
UserCacheBean userCacheBean = UserCache.getUserCacheBean(user_id);
String unit_id = "";
if(userCacheBean != null) {
	unit_id = userCacheBean.getUnit_id();
}
int isRoomAdmin = 0;
String buttonStr = "";
List<Map<String, String>> meetingRoomList = new ArrayList<Map<String, String>>();
Map<String, String> roomMap = null;
List<Map<String, String>> roomOccupancyList = new ArrayList<Map<String, String>>();
MeetingRoomoccupancyServiceIfc meetingRoomoccupancyServiceIfc = new MeetingRoomoccupancyServiceImpl();
isRoomAdmin = meetingRoomoccupancyServiceIfc.isRoomAdministrator(user_id);
meetingRoomList = meetingRoomoccupancyServiceIfc.getMeetingRoomList(unit_id);
String curdate = DateUtil.getCurrentDate();
//角色
AuthRole authRoles[] = accesscontroler.getAllRoleofUser(accesscontroler.getUserAccount());
boolean flag=false;
for(int i=0;i<authRoles.length;i++){
	    if("会议系统管理员".equals(authRoles[i].getRoleName())){
	    	flag=true;
	    	break;
	    }
}
//if(isRoomAdmin > 0) {//去掉 权限的控制 2014-02-17
if(true) {//去掉 权限的控制 2014-02-17
	/* buttonStr = "<input class='but_y_01' id=add type='button' onclick='addRoomReservation()' value='新增'/><input class='but_y_01' id=del type='button' onclick='delRoomReservation()' value='删除'/>"; */
	buttonStr = "<input class='but_y_01' id=add type='button' onclick='addRoomReservation()' value='新增'/><input class='but_y_01' id=del type='button' onclick='deleteRows()' value='删除'/>";
}
%>
<meta>
<title>查看会议室预订情况</title>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../resources/plug/jquery1.7/jquery-1.7.1.min.js"></script>
<script src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>
<script src="../../resources/plug/jquery.jqGrid-4.3.1/js/i18n/grid.locale-en.js" type="text/javascript"></script>
<script src="../../resources/plug/jquery.jqGrid-4.3.1/js/jquery.jqGrid.min.js" type="text/javascript"></script>
<!-- 引入my97时间控件 -->
<script src="<%=path %>/ccapp/oa/resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<!-- 引入其它 -->
<script src="../../resources/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js" ></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>

<link rel="stylesheet" type="text/css" href="../resources/css/meeting.css">
<script type="text/javascript" src="../resources/js/meetingnoticedetail.js"></script>

<style type="text/css">
.SelectBG{
background-color:#ffeeee;
}
</style>
<script>
var user_id = ","+'<%=user_id %>' + ",";
$(function() {
	viewRoomOccupancy();
	//new add 弹出打开页面时的css控制 hai.huang 2013-07-03
	if("<%=StringUtil.deNull(request.getParameter("isAlertOpenFlag"))%>"=="yes"){
		$("#k_top").removeClass("dage_k_top");
		$("#k_top").addClass("dage_k_top_1");
		$("#k_top_title").html("&nbsp;");
	}
	//end 弹出打开页面时的css控制 hai.huang 2013-07-03
});

/*
配置jqGrid，显示会议申请列表查询--未发布
*/
$(function() {
$("#gridTable").jqGrid({
	url: '<%= path %>' + '/pubListServlet?classNameId=com.chinacreator.xtbg.core.meeting.list.MeetingRoomViewList',//pubListServlet列表公共的servlet,classNameId在servletBean.xml文件中配置要调用的类,isPage:是否翻页(true,false),默认为true
	datatype: "json",
	mtype: "POST",
	height: "100%",
	autowidth: true,
	colModel: [ //最重要的数组之一，用于设定各列的参数
	{
		label: '管理员ID',
		name: 'roomadmin',
		index: 'roomadmin',
		hidden: true
	},
	{
		label: '主键ID',
		name: 'm_id',
		index: 'm_id',
		hidden: true
	},
	{
		label: '会议室ID',
		name: 'm_room_id',
		index: 'm_room_id',
		hidden: true
	},
	{
		label: '会议室名称',
		name: 'room',
		index: 'room',
		width: 70
	},{
		label: '会议时间',
		name: 'meetingtime',
		index: 'meetingtime',
		width: 100
	},{
		label: '会议主题',
		name: 'm_title',
		index: 'm_title',
		width: 130
	},
	{
		label: '类型',
		name: 'meetingtype',
		index: 'meetingtype',
		width: 100,
		hidden: true
	},
	{
		label: '处室',
		name: 'orgname',
		index: 'orgname',
		width: 50
	},
	{
		label: '联系人',
		name: 'm_link_username',
		index: 'm_link_username',
		width: 50
	},
	{
		label: '联系电话',
		name: 'm_link_tel',
		index: 'm_link_tel',
		width:60
	},
	{
		label: '与会人员数',
		name: 'm_attender_count',
		index: 'm_attender_count',
		width: 40
	},
	{
		label: '申请人id',
		name: 'm_create_user_id',
		index: 'm_create_user_id',
		hidden: true
	},
	{
		label: '申请人姓名',
		name: 'm_create_user_name',
		index: 'm_create_user_name',
		hidden: true
	}
	],
	sortname: 'm_begin_time',
	sortorder: 'asc',
	viewrecords: true,
	rowNum: 10,
	rowList: [10, 20, 30],
	gridComplete: function() {
		var ids = $("#gridTable").getDataIDs(); //jqGrid('getDataIDs');
		for (var i = 0; i < ids.length; i++) {
			var cl = ids[i];
			var model = jQuery("#gridTable").jqGrid('getRowData', cl);
			//复选框
			if("true"!="<%=flag%>"){
 			var curRowData = jQuery("#gridTable").jqGrid('getRowData', ids[i]);
            var curChk = $("#"+ids[i]+"").find(":checkbox");
			if(model.m_create_user_id!="<%=user_id%>"){
				curChk.hide();
			}
/*          var roomadmin = "," + model.roomadmin + ","; 
 
            if('会议通知' == model.meetingtype){
            	 curChk.hide();
             } else {
	             if(roomadmin.indexOf(user_id) < 0 ) {
		             	curChk.hide();
		         }
             } */
			}
             var be=deleteyear(model.meetingtime);
             jQuery("#gridTable").jqGrid('setRowData', cl, {
            	 meetingtime: be
			});
		}
	},
	jsonReader: { //这又是一个数组，用来设定如何解析从Server端发回来的json数据
		repeatitems: false
	},
	onCellSelect:function (id,icol)
	{
		if(icol != 0)
		{
			updateRoomReservation(id);
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
	<%
	if("yes".equalsIgnoreCase(StringUtil.deNull(request.getParameter("isAlertOpenFlag")))){
	%>
		multiselect: false
	<%
	}else{
	%>	
		toolbar: [true,"top","<%=buttonStr %>"],
		multiselect: true
	<%
	}
	%>
	
}).navGrid('#gridPager', {
	edit: false,
	add: false,
	del: false,
	search : false,
	refresh : false
});
});
//如果是当前年日期,则去掉年份
function deleteyear(date){
	var nowdate=new Date();
	var nowyear=nowdate.getYear();
	var tempdate=date;
	var tempyear=date.substr(0,4);
	var tempyear1=date.substr(0,18);
	if(tempyear==nowyear){
		tempdate=date.substr(5,12)+date.substr(22);
	}
	
	return tempdate;
}

/*
函数:  convertParamJson
说明:  构建要查询的参数
参数:   无
返回值: 返回要查询的参数
*/
var convertParamJson = function() {
var str = "{" + "'m_room_id':'<%=unit_id %>"
		+ "','m_begin_time':'" + $("#meetingtime").val()+ "'}";
return descape(str);
}

/*
函数:  meetingSearch
说明:  查询会议室预约情况
参数:   无
返回值: 
*/
var meetingSearch = function() {
	var sdata = { 
	}; 
	var postData = $("#gridTable").jqGrid("getGridParam", "postData"); //将查询参数融入postData选项对象  
	$.extend(postData, sdata);
	$("#gridTable").jqGrid("setGridParam", {
		search : true,
		userFilters:convertParamJson()
	}).trigger("reloadGrid", [ {
		page : 1
	} ]); //重新载入Grid表格，以使上述设置生效 
	
}

/*
函数:  viewRoomOccupancy
说明:  查询会议室占用情况
*/
function viewRoomOccupancy() {
	//查询时清空div里面的内容
	jQuery("div[id*='time_bar_']").html("");
	colors.counter = -1;
	
	var unit_id;
	var meetingtime;
	var params = {
			unit_id : '<%=unit_id %>',
			meetingtime : jQuery("#meetingtime").val()
	};
	url = "viewroomoccupancydo.jsp";
	$.ajax({
		url : url,
		type : 'POST',
		dataType : 'json',
		data : params,
		async : true,
		success : function(conferences) {
			viewMeetingRoomOccupancy(conferences);
		},
		error : function(jqXHR, textStatus, errorThrown) {
			alert("error:" + textStatus);
		}
	});
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
	var postData = $("#gridTable").jqGrid("getGridParam", "postData"); //将查询参数融入postData选项对象  
	$.extend(postData, sdata);
	$("#gridTable").jqGrid("setGridParam", {
		search : true
	// 将jqGrid的search选项设为true  
	}).trigger("reloadGrid", [ {
		page : 1
	} ]); //重新载入Grid表格，以使上述设置生效
}

var colors = ['#d4b7d5','#fbedbe','#d9edba','#ebada2'];
colors.counter = -1;
colors.nextColor = function() {
    colors.counter = (colors.counter + 1) % colors.length;
    return colors[colors.counter];
};

/*
函数:  viewMeetingRoomOccupancy
说明:  会议室预订查看
参数:   无
*/
function viewMeetingRoomOccupancy(conferences) {
    var room = {};
    var block_width = 1;
    $.each(conferences, function() {
    	var last_block_end = 0;
        if (!room[this.room]) {
            room[this.room] = [];
        } else {
            last_block_end = room[this.room][room[this.room].length - 1].endblock;
        }
        
        room[this.room].push(this);
        
		var marginleft = (this.startblock - last_block_end);
		var width = this.endblock - last_block_end - marginleft - 20//this.blocksize - 20
        var color = colors.nextColor();
        var div_block = $('<div class="time_block" onmouseover="openInfoDiv(this)"></div>');
        div_block.css('margin-left', (marginleft) + 'px');
        div_block.css('width', (width) + 'px');
        div_block.css('background-color', color);
        div_block.attr('title', this.m_title);
        div_block.attr('orgname',this.orgname);
        div_block.attr('m_link_username',this.m_link_username);
        div_block.attr('m_link_tel',this.m_link_tel);
        this.m_title = replaceTitle(width, this.m_title, 12);
        div_block.html(this.m_title);
        $('#time_bar_' + this.m_room_id).append(div_block);
    });
}
//开个一个跟随鼠标的div
function openInfoDiv(obj){
	$("#info").show();
	$(obj).mousemove(function(e){
    	$("#info").css({"position": "absolute","top": e.pageY+20 +"px","left": e.pageX +15+"px"});
    });
   $(obj).mouseout(function(e){
		   $("#info").hide();
	});
	
	var tableHtml="<table style='text-align: center;'>" +
			"<tr><td style='text-align: left;'>【处   室】</td><td>"+ $(obj).attr("orgname")+"</td></tr>" +
			"<tr><td style='text-align: left;'>【联系人】</td><td>"+ $(obj).attr("m_link_username")+"</td></tr>"+
			"<tr><td style='text-align: left;'>【电   话】</td><td>"+ $(obj).attr("m_link_tel")+"</td></tr></table>"
	$("#info").html(tableHtml);
}
/*
函数:  addRoomReservation
说明:  添加会议室预约
参数:   无
*/
function addRoomReservation() {
	var url = '<%= path %>/ccapp/oa/meeting/jsp/meetingnoticetab.jsp?m_notice_id=&issaved=add&from=1';
	window.location.href=url;
	/* openAlertWindows('roomReservation',url,'会议室申请','900','550','15%','5%'); */
}

/*
函数:  updateRoomReservation
说明:  修改会议室预约
参数:   无
*/
function updateRoomReservation(id) {
	var model = jQuery("#gridTable").jqGrid('getRowData', id);
	var url = '<%= path %>/ccapp/oa/meeting/jsp/addroomreservation.jsp?m_id=' + model.m_id+'&meetingType=' + descape(escape(model.meetingtype)) + '&m_room_id=' + model.m_room_id;
	
	openAlertWindows('roomReservation',url,'会议室预约','800','220','25%','25%');
}

/*
函数:  delRoomReservation
说明:  删除会议室预约
参数:   无
*/
function delRoomReservation() {
	var ids = new Array();
	var selectedIds = $("#gridTable").jqGrid("getGridParam", "selarrrow");
	for(var i = 0; i < selectedIds.length; i++) {
		var model = jQuery("#gridTable").jqGrid('getRowData', selectedIds[i]);
/* 		 var roomadmin = "," + model.roomadmin + ",";
		 debugger
		 if('会议通知' != model.meetingtype) {
	         if(roomadmin.indexOf(user_id) >= 0) { */
	        	 ids.push(model.m_id);  
/* 	         }
		 } */
	}
	if (!ids.length) {
		alert("请选择要取消的会议室预约！");
	} else {
		var okF = function(){
			var url = "meetingdeletedo.jsp"
			$("#ids").val(ids.join(","));
			document.all.form1.action = url;
			document.all.form1.target = "hiddenFrame";
			document.all.form1.submit();
		}
		var p={
				headerText:'提示',
				okName:'确认',
		        okFunction:okF,
		        cancelName:'取消'
		};
		alert("确定要取消会议室预约吗？",p);
	}
}

/*
函数:  deleteRows
说明:  删除行
*/
var deleteRows = function() {

	var ids = "";
	var selectedIds = $("#gridTable").jqGrid("getGridParam", "selarrrow");
	for ( var i = 0; i < selectedIds.length; i++) {
		var model = jQuery("#gridTable").jqGrid('getRowData',selectedIds[i]);
		if ("" != ids) {
			ids += ",";
		}
		ids += "'" + model.m_id + "'";
	}
	if (IsSpace(ids)) {
		alert("请选择要删除的记录！");
		return;
	} else {
		var okF = function() {
			var params = {
				ids : ids
			};
			url = "meetingdeletedo.jsp";
			$.ajax({
				url : url,
				type : 'POST',
				dataType : 'json',
				data : params,
				success : function(flag) {
					if (flag) {
						alert("操作成功！");
					} else {
						alert("操作失败！");
					}
					window.location.reload();
				},
				error : function(jqXHR, textStatus, errorThrown) {
					alert("error warning:" + textStatus);
					window.location.reload();
				}
			});
		};
		var p = {
			headerText : '提示',
			okName : '确认',
			okFunction : okF,
			cancelName : '取消'
		};
		alert("确定要删除记录吗？", p);
	}
};


/*
函数:  replaceTitle
说明:  超过长度替换成...
参数:   无
*/
function replaceTitle(weight, text, oneTextWeight) {
	var str = "";
	var textCount = getByteLen(text) / 2;
	if((textCount  * oneTextWeight) > weight) {
		str = text.substring(0,parseInt(weight/oneTextWeight, 10) * 2 - 1) + "...";
	} else {
		str = text;
	}
	return str;
}

/*
函数:  getByteLen
说明:  记数字符的长度
参数:   无
*/
function getByteLen(val) { 
	var len = 0; 
	for (var i = 0; i < val.length; i++) { 
		var str = val.substring(i,i+1);
		if (str.match(/[^x00-xff]/ig) != null){
			len += 2; 
		}else{ 
			len += 1; 
		} 
	}
	return len; 
}
function changeday(type){
	var sysdate= jQuery("#meetingtime").val()
	var yyyy = parseInt(sysdate.substring(0,4),10);
	var MM = parseInt(sysdate.substring(5,7),10)-1;
	var dd = parseInt(sysdate.substring(8,10),10);
	var sysdate = new Date(yyyy, MM, dd);
	if('1'==type){
		sysdate.setDate(sysdate.getDate()-1);
	}else{
		sysdate.setDate(sysdate.getDate()+1);
	}
	var year=sysdate.getYear();
	var month=sysdate.getMonth()+1;
	var day=sysdate.getDate();
	if(month<10){
		month="0"+month;
	}
	if(day<10){
		day="0"+day;
	}
	var time=year+"-"+month+"-"+day;
	jQuery("#meetingtime").val(time);
	viewRoomOccupancy();
	meetingSearch();
}

</script>
</head>
<body style="overflow-x:auto;" class="vcenter" >
<div>
	<div id="info" style="display: none;background-color: #DADADA;"></div>
	<div class="datekuang">
	<div class="dage_k_top" id="k_top">
    	<div class="dage_left" style="width:100px" id="k_top_title">会议室预约查看</div>
		<div class="dage_left" style="width:100px" id="k_top_title">
			 <input class='but_y_01' id=add type='button' onclick='addRoomReservation()' value='新增'/>
		</div>
        <div class="dage_right"  style="width: 190px;float:left;margin-left:200px">
        <a onclick="changeday('1')">上一天</a>
       	  <div  style="display: inline;">日期:
            	<input style="float: none;width: 70px" id="meetingtime" name="meetingtime" type="text" value="<%=curdate %>" onfocus="WdatePicker({minDate:'<%=curdate %>',onpicked:function(){viewRoomOccupancy();meetingSearch();}})"/>
            </div>
            <a onclick="changeday('2')">下一天</a>
        </div>
    </div>
    <div style="clear:both"></div>
    <div class="huiyimingcheng">
    	<div class="huiyi_mc_biaoti">会议室名称</div>
        <div class="shijanduan">
        	<div class="shijiantiao">8</div>
            <div class="shijiantiao">9</div>
            <div class="shijiantiao">10</div>
            <div class="shijiantiao">11</div>
            <div class="shijiantiao">12</div>
            <div class="shijiantiao">13</div>
            <div class="shijiantiao">14</div>
            <div class="shijiantiao">15</div>
            <div class="shijiantiao">16</div>
            <div class="shijiantiao">17</div>
            <div class="shijiantiao">18</div>
            <div class="shijiantiao">19</div>
            <div class="shijiantiao">20</div>
            <div class="shijiantiao">21</div>
            <div class="shijiantiao">22</div>
        </div>
    </div>
    <div style="clear:both"></div>
    
    <%
    	String m_room_name = "";
    	for (int i = 0; i < meetingRoomList.size(); i++) { 
    		roomMap = new HashMap<String,String>();
    		roomMap = meetingRoomList.get(i);
    		m_room_name = StringUtil.deNull(roomMap.get("m_room_name"));
    		if(!StringUtil.isBlank(m_room_name)) {
    			if(m_room_name.length() > 7) {
    				m_room_name = m_room_name.substring(0,7) + "...";
    			} 
    		}
    %>
    <div  class="loushi">
    	<div class="loushi_mc_biaoti" title="<%=StringUtil.deNull(roomMap.get("m_room_name")) %>" ><%=m_room_name %></div>
        <div id="time_bar_<%=StringUtil.deNull(roomMap.get("m_room_id")) %>" class="loushi_right">
        </div>
    </div>
    <% 
    } 
    %>
   <!-- 查询列表区 cGridArea(查询区样式)-->
	 <div class="cGridArea">
		<table id="gridTable">
		</table>
		<div id="gridPager">
		</div> 
	</div>
	<form id="form1" name="form1" method="post" >
	  <input id="m_ids" name="m_ids" type="hidden"/>
	  <input id="type" name="type" type="hidden" value="del"/>
	  <input id="ids" name="ids" type="hidden"/>
	</form>
	<iframe name="hiddenFrame" width="0" height="0"></iframe>
	<!-- 查询列表区 -->
</div>
</div>
</body>
</html>

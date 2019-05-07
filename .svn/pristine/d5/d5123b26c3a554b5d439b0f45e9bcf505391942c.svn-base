<%--
　　描述：会议申请已发布列表页面
　　作者：黄海
　　版本：1.0
　　日期：2013-6-19
--%>
<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DaoUtil"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.core.meeting.util.MeetingConstants"%>
<%@page import="com.chinacreator.xtbg.core.kbm.util.KbmUtil"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%
AccessControl accesscontroler = AccessControl.getAccessControl();
accesscontroler.checkAccess(request, response);
String path = request.getContextPath();
String m_create_user_id = accesscontroler.getUserID();
boolean candel = KbmUtil.isRolesUser(m_create_user_id,MeetingConstants.ROLENAME);
%>
<meta>
<title>会议申请已发布列表页面</title>
<style type="text/css">
.mybtn{ 
	background-color:transparent; /* 背景色透明 */ 
	border:0px; /*border:0px solid #005aa7;边框取消 */ 
	cursor:pointer; 
	color:red;
} 
</style>
<!-- 引入my97时间控件 -->
<script src="<%=path %>/ccapp/oa/resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../resources/plug/jquery1.7/jquery-1.7.1.min.js"></script>
<script src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>
<script src="../../resources/plug/jquery.jqGrid-4.3.1/js/i18n/grid.locale-en.js" type="text/javascript"></script>
<script src="../../resources/plug/jquery.jqGrid-4.3.1/js/jquery.jqGrid.min.js" type="text/javascript"></script>
<!-- 引入其它 -->
<script src="../../resources/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js" ></script>
<script type="text/javascript" src="../resources/js/meetingnoticedetail.js"></script>
<script>
var candel="<%=candel%>";

/*
	配置jqGrid，显示会议申请列表
*/
$(function() {
	jQuery(function() {
		$(document).keydown(function(){
			if(event.keyCode == 13){ 
				refreshGrid();
		    }
		});
	});
	$("#gridTable4published").jqGrid({
		url: '<%= path %>' + '/pubListServlet?classNameId=com.chinacreator.xtbg.core.meeting.list.MeetingNoticeList',//pubListServlet列表公共的servlet,classNameId在servletBean.xml文件中配置要调用的类,isPage:是否翻页(true,false),默认为true
		datatype: "json",
		mtype: "POST",
		height: "100%",
		autowidth: true,
		colModel: [ //最重要的数组之一，用于设定各列的参数
		{
			label: '会议通知id',
			name: 'm_notice_id',
			index: 'm_notice_id',
			hidden:true
		},{
			label: 'm_is_need_signup',
			name: 'm_is_need_signup',
			index: 'm_is_need_signup',
			hidden:true
		},{
			label: '会议室管理员id',
			name: 'm_reg_user_id',
			index: 'm_reg_user_id',
			hidden:true
		},{
			label: '会议室管理员name',
			name: 'm_reg_user_name',
			index: 'm_reg_user_name',
			hidden:true	
		},{
			label: '审核状态id',
			name: 'm_check_flag',
			index: 'm_check_flag',
			hidden: true
		},{
			label: '会议标题',
			name: 'm_title',
			index: 'm_title',
			width: 100
		},{
			label: '会议开始时间',
			name: 'm_begin_time',
			index: 'm_begin_time',
			width: 80,
			formatter:publicFormatterMeetingDate
		},{
			label: '会议室',
			name: 'm_room_name',
			index: 't.m_room_name',
			width: 100
		},{
			label: '主持人',
			name: 'm_master_user_name',
			index: 'm_master_user_name',
			width: 50
		},{
			label: '审核状态',
			name: 'm_check_flag_name',
			index: 'm_check_flag_name',
			width: 60
		},{
			label: '报名率',
			name:  'signup_percent',
			index: 'signup_percent',
			width: 60
		},{
			label: '阅读率',
			width: 60,
			name: 'read_percent',
			index: 'read_percent'
		},{
			label: '申请人',
			name: 'm_create_user_name',
			index: 'm_create_user_name',
			width: 60
		},{
			label: '发布时间',
			name: 'm_current_time',
			index: 'm_current_time',
			width: 100
		},{
			label: '短信发送情况',
			name: 'acb',
			index: 'acb',
			search: false,
			sortable: false,
			editable: false,
			width: 100
		}
		
		],
		sortname: 'm_create_time',
		sortorder: 'desc',
		viewrecords: true,
		rowNum: 10,
		rowList: [10, 20, 30],
		gridComplete: function() {
			if(candel=="false" && jQuery("#del").hide());
	        var ids = $("#gridTable4published").getDataIDs(); 
	        for (var i = 0; i < ids.length; i++) {
	        	//var cl = ids[i];
	            var model = jQuery("#gridTable4published").jqGrid('getRowData', ids[i]);
	            be1 = "<input type=button class='mybtn' id='b1' onclick=openAttender('"+model.m_notice_id+"') value='"+model.signup_percent+"' >";
	            be2 = "<input type=button class='mybtn' id='b2' onclick=openRead('"+model.m_notice_id+"')     value='"+model.read_percent+"' >";
	            be3 = "<input type=button class='mybtn' id='b3' onclick=looktotal('"+model.m_notice_id+"') value='查看' >"; 
	            jQuery("#gridTable4published").jqGrid('setRowData', ids[i], {
	            	signup_percent: be1
	            });
	            jQuery("#gridTable4published").jqGrid('setRowData', ids[i], {
	            	read_percent: be2
	            });
	            jQuery("#gridTable4published").jqGrid('setRowData', ids[i], {
	            	acb: be3
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
				modifyRow(id);
			}
		},
		onSelectRow: function(id) {
			//modifyRow(id);
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
		toolbar: [true,"top","<input class='but_y_01' id='del' type='button' onclick='deleteRows()' value='删除'/>"],
		multiselect: true
	}).navGrid('#gridPager', {
		edit: false,
		add: false,
		del: false,
		search : false,
		refresh : false
	});
});


/*
 函数:  deleteRows
 说明:  删除行
 */
var deleteRows = function() {

	var ids = "";
	var selectedIds = $("#gridTable4published").jqGrid("getGridParam", "selarrrow");
	for ( var i = 0; i < selectedIds.length; i++) {
		var model = jQuery("#gridTable4published").jqGrid('getRowData',
				selectedIds[i]);
		if ("" != ids) {
			ids += ",";
		}
		ids += "'" + model.m_notice_id + "'";
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
					refreshGrid('');
				},
				error : function(jqXHR, textStatus, errorThrown) {
					alert("error warning:" + textStatus);
					refreshGrid('');
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
	函数:  addCellAttr
	说明:  渲染单元格内容
*/
function addCellAttr(rowId, val, rawObject, cm, rdata) 
{  
	return "style='color:red'"; 
} 

/*
	 函数:  convertParamJson
	 说明:  构建要查询的参数
	 参数:   无
	 返回值: 返回要查询的参数
*/
var convertParamJson = function() {
	var str = "{" + "'m_title':'" + $("#m_title").val()
			+ "','m_room_name':'" + $("#m_room_name").val()
			+ "','m_create_user_id':'" + $("#m_create_user_id").val()
			+ "','m_begin_time':'" + getM_begin_time()
			+ "','m_check_flag':'" + $("#m_check_flag").val()
			+ "','m_end_time':'" + getM_end_time() + "'}";
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
	var postData = $("#gridTable4published").jqGrid("getGridParam", "postData"); //将查询参数融入postData选项对象  
	$.extend(postData, sdata);
	$("#gridTable4published").jqGrid("setGridParam", {
		search : true
	// 将jqGrid的search选项设为true  
	}).trigger("reloadGrid", [ {
		page : 1
	} ]); //重新载入Grid表格，以使上述设置生效
}
/*
函数:  modifyMdColumns
说明:  修改
*/
function modifyRow(id) {
	var model = jQuery("#gridTable4published").jqGrid('getRowData', id);
	window.parent.location="meetingnoticetab.jsp?m_notice_id="+model.m_notice_id+ "&issaved=doall&m_check_flag="
			+model.m_check_flag+"&m_check_flag_name="+model.m_check_flag_name+"&m_is_need_signup="+model.m_is_need_signup
			+"&m_reg_user_id="+model.m_reg_user_id+"&m_reg_user_name="+model.m_reg_user_name;
}


/*
	函数:  openAttender
	说明:  打开会议报名情况页面
*/
function openAttender(m_notice_id){
	var url = getCurrentFilePath()+"meetingreceivermain.jsp?m_notice_id="+m_notice_id;
	openAlertWindows('windowId',url,'会议报名情况','950','600','5%','5%');
}

/*
	函数:  openRead
	说明:  打开会议通知阅读情况页面
*/
function openRead(m_notice_id){
	var url = getCurrentFilePath()+"meetingreadmain.jsp?m_notice_id="+m_notice_id;
	openAlertWindows('windowId',url,'会议通知阅读情况','950','600','5%','5%');
}
/**
 	函数:  looktotal
	说明:  打开会议通知短信发送情况页面
 */
 function looktotal(m_notice_id){
	 openAlertWindows('windowId','../../../../xtbg/public/smsSend/smssendtotals.jsp?business_id='+ m_notice_id,'查看详情','65%','400','20%');
 }

</script>
</head>
<body>
<div>
	<input type="hidden" name="m_check_flag" id="m_check_flag" value="<%=MeetingConstants.STATUS_PUBLISHED%>">
	<!--查询条件 begin -->
    <table width="100%">
			<tr>
				<td>
					<!-- 查询条件选区    tabs_search_ctable(查询table样式) -->
					<table width="100%" border="0" cellspacing="0" cellpadding="0"
						class="tabs_search_ctable_box">
						<tr>
							<td>
								<table width="100%" border="0" cellspacing="0" cellpadding="0"
										class="tabs_search_ctable">
									<tr>
										<th width="90" class="input_cx_title_th">会议标题：</th>
										<td width="200" class="cx_title_td"><input
											class="input_cx_title_283" type="text" id="m_title"
											name="m_title" style="width: 133px;" /></td>
										<th width="90" class="input_cx_title_th"></th>
										<td width="200" class="cx_title_td"></td>
										<td></td>
									</tr>
									<tr>
										<th width="90" class="input_cx_title_th">会议时间：</th>
										<td width="200" class="cx_title_td"><input
											class="date_120 Wdate" type="text" id="m_begin_time"
											name="m_begin_time"
											onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'m_end_time\')}',dateFmt:'yyyy-MM-dd'})" />
										</td>
										<th width="90" class="input_cx_title_th">至：</th>
										<td width="200" class="cx_title_td"><input
											class="date_120 Wdate" type="text" id="m_end_time"
											name="m_end_time"
											onfocus="WdatePicker({minDate:'#F{$dp.$D(\'m_begin_time\')}',dateFmt:'yyyy-MM-dd'})" />
										</td>
										<td><input name="Input2" value="搜索" type="button"
											onclick="refreshGrid()" class="but_y_01" />
										</td>
									</tr>
								</table>
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
	<!--查询条件 end -->
	
	<!-- 查询列表区 cGridArea(查询区样式)-->
	<div class="cGridArea" style="width:<%=MeetingConstants.TABLE_WIDTH%>;">
		<table id="gridTable4published">
		</table>
		<div id="gridPager">
		</div>
	</div>
	<!-- 查询列表区 -->
	
	<input type="hidden" name="m_create_user_id" id="m_create_user_id" value="<%=m_create_user_id %>">
</div>
</body>
</html>

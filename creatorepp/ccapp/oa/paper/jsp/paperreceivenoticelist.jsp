<%-- 
描述：约稿通知查询列表界面
作者：肖杰
版本：1.0
日期：2013-09-16
 --%>
<%@page import="com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.UserCache"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DaoUtil"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
	String path = request.getContextPath();
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	String orgname=accesscontroler.getChargeOrgName();
	String userid=accesscontroler.getUserID();
	UserCacheBean userbean= UserCache.getUserCacheBean(userid);
%>
<title>约稿通知列表界面</title>
<!-- 引入jQuery -->
<script type="text/javascript"
	src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<!-- 引入jQuery UI -->
<script
	src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js"
	type="text/javascript"></script>
<!-- 引入jGrid -->
<script
	src="../../resources/plug/jquery.jqGrid-4.3.1/js/i18n/grid.locale-en.js"
	type="text/javascript"></script>
<script
	src="../../resources/plug/jquery.jqGrid-4.3.1/js/jquery.jqGrid.min.js"
	type="text/javascript"></script>
<!-- 引入其它 -->
<script src="../../resources/util/public.js" type="text/javascript"></script>
<script type="text/javascript"
	src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<script type="text/javascript"
	src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<!-- 公共部分引用结束 -->
<!-- 日期控件 -->
<script src="../../resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<style type="text/css">
.mybtn{ 
	background-color:transparent; /* 背景色透明 */ 
	border:0px; /*border:0px solid #005aa7;边框取消 */ 
	cursor:pointer; 
	color:red;
} 
</style>
<script type="text/javascript">
$(function() {
	$(document).keydown(function(){
		if(event.keyCode == 13){ 
			makeNoticeSearch();
		}
	});

	$("#gridTable").jqGrid({
		url: '<%=path%>' + '/pubListServlet?classNameId=com.chinacreator.xtbg.core.paper.list.PaperReceiveList',  
		//jqGrid控件通过这个参数得到需要显示的数据，具体的返回值可以使XML也可以是Json
		datatype: "json",
		//这个参数用于设定将要得到的数据类型。我最常用的是“json”，其余的类型还包括：xml、xmlstring、local、javascript、function
		mtype: "POST",
		//定义使用哪种方法发起请求，GET或者POST
		height: "100%",//270
		//Grid的高度，可以接受数字、%值、auto，默认值为150
		//width ：800, //Grid的宽度，如果未设置，则宽度应为所有列宽的之和；如果设置了宽度，则每列的宽度将会根据shrinkToFit选项的设置，进行设置。
		//shrinkToFit ：true 此选项用于根据width计算每列宽度的算法。默认值为true。如果shrinkToFit为true且设置了width值，则每列宽度会根据width成比例缩放；如果shrinkToFit为false且设置了width值，则每列的宽度不会成比例缩放，而是保持原有设置，而Grid将会有水平滚动条
		autowidth: true,
		//默认值为false。如果设为true，则Grid的宽度会根据父容器的宽度自动重算。重算仅发生在Grid初始化的阶段；如果当父容器尺寸变化了，同时也需要变化Grid的尺寸的话，则需要在自己的代码中调用setGridWidth方法来完成。
		colModel: [ //最重要的数组之一，用于设定各列的参数
		{
			label:"约稿通知ID",
			name: 'p_notice_id',
			index: 'p_notice_id',
			hidden: true
		},
		{
			label:"约稿标题",
			name: 'p_title',
			index: 'p_title',
			width: 400,
			editable: true
		},
		{
			label:"发送单位",
			name: 'p_send_unit_name',
			index: 'p_send_unit_name',
			width: 100,
			editable: true
		},
		{
			label:"发送时间",
			name: 'p_send_time',
			index: 'p_send_time',
			width: 200,
			sortable: false,
			formatter:publicFormatterMeetingDate
		}
		],
		sortname: 'p_send_time',
		//指定默认的排序列，可以是列名也可以是数字。此参数会在被传递到Server端。
		sortorder: 'desc',
		viewrecords: true,
		
		//设置是否在Pager Bar显示所有记录的总数。
		rowNum: 10,
		//用于设置Grid中一次显示的行数，默认值为20。正是这个选项将参数rows（prmNames中设置的）通过url选项设置的链接传递到Server。注意如果Server返回的数据行数超过了rowNum的设定，则Grid也只显示rowNum设定的行数。
		rowList: [10, 20, 30],
		//一个数组，用于设置Grid可以接受的rowNum值。例如[10,20,30]
		gridComplete: function() {
	       
		},
		jsonReader: { //这又是一个数组，用来设定如何解析从Server端发回来的json数据
			repeatitems: false
		},
		pagerintoolbar:true,//上面的分页条
		pagerinBottombar:true,//下面的分页条
		//定义页码控制条Page Bar
		//caption: "接收到的电子公告",
		//设置Grid表格的标题，如果未设置，则标题区域不显示。
		search : toJson(),
		prmNames: { //这是一个数组，用于设置jqGrid将要向Server传递的参数名称
			rows: "rows",
			//表示请求行数的参数名称  
			sort: "sidx",
			//表示用于排序的列名的参数名称  
			order: "sord",
			//表示采用的排序方式的参数名称 
			search : "search"
		},
		toolbar: [true,"top"],
		multiselect: false,
		onCellSelect: function(id,iCol) {
			if(iCol!=0){
				jQuery("#gridTable").setSelection(id,false);
			 	updateMakeNotice(id);
			}
		}
	}).navGrid('#gridPager', {
		edit: false,
		add: false,
		del: false,
		refresh: false,
		search: false
	});
	
	
});
/*
函数:  openRead
说明:  打开约稿通知阅读情况页面
*/
function openRead(p_notice_id){
var url = getCurrentFilePath()+"papernoticemain.jsp?p_notice_id="+p_notice_id;
openAlertWindows('windowId',url,'查阅情况','950','600','5%','5%');
}

/*
函数:  publicFormatterMeetingDate
说明:  格式化时间到分，秒舍去
*/
function publicFormatterMeetingDate(dStr){
	return (isSpace(dStr)||dStr.length!=19)?"": dStr.substring(0,16);
}	 
/*
	 函数:  toJson
	 说明:  构建要查询的参数
	 参数:   无
	 返回值: 返回要查询的参数
	 */
var toJson = function() {
	var str ="{'p_title':'"+$("#p_title").val()
		+"','start_time':'"+$("#start_time").val()
		+"','end_time':'"+$("#end_time").val()
		+"','p_send_unit_name':'"+$("#p_send_unit_name").val()
		+"','p_receive_unit_id':'<%=userbean.getUnit_id()%>'}";
	return descape(escape(str));
}

/*
	 函数:  makeNoticeSearch
	 说明:  查询存放位置信息
	 参数:   无
	 返回值: 全宗号列表
*/
var makeNoticeSearch = function() {
	var sdata = { //构建查询需要的参数 
		paramJson: toJson()
	}; //获得当前postData选项的值  
	var postData = $("#gridTable").jqGrid("getGridParam", "postData"); //将查询参数融入postData选项对象  
	$.extend(postData, sdata);
	$("#gridTable").jqGrid("setGridParam", {
		search: true ,// 将jqGrid的search选项设为true  
		userFilters:toJson()
	}).trigger("reloadGrid", [{
		page: 1
	}]); //重新载入Grid表格，以使上述设置生效 
	
}

/*
	 函数:  clearSearch
	 说明:  重置
	 参数:   无
	 返回值: 无
	 */
var clearSearch = function() {
	resetSingleSearchDialog();
	makeNoticeSearch();
};

/*
	 函数:  resetSingleSearchDialog
	 说明:  清空值查询值
	 参数:   无
	 返回值: 无
	 */
var resetSingleSearchDialog = function() { //$("radio","#singleSearchDialog").attr("checked", false);  
	$("input[type=text]").val("");
	$('#ckzt option:first').attr('selected', 'selected');
};



/*
函数:  addMakeNotice
说明:  添加存放位置
参数:   无
返回值: 无
*/
var addMakeNotice = function() {
	openWindows('addMakeNotice','新增','<%=path%>/ccapp/oa/paper/jsp/papermakenoticeinfo.jsp?subid=addMakeNotice','qzh',false,window);
}
/*
 函数:  updateMakeNotice
 说明:  修改存放位置
 参数:   无
 返回值: 无
*/
var updateMakeNotice = function(id) {
	var model = jQuery("#gridTable").jqGrid('getRowData', id);
	var url = getCurrentFilePath()+"papermakenoticeview.jsp?type=receive&subid=windowId&p_notice_id="+model.p_notice_id;
	openAlertWindows('windowId',url,'详细信息','950','500','5%','5%');
	}
	
	



</script>
</head>
<body>
<div>


<table width="100%">
	<tr>
		<td><!-- 查询条件选区    tabs_search_ctable(查询table样式) -->
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="tabs_search_ctable_box">
			<tr>
				<td><!-- 固定查询 -->
				<table width="100%" border="0" cellspacing="0" cellpadding="0"
					class="tabs_search_ctable">
					<tr>
						<th style="width: 70px" class="input_cx_title_th">约稿标题：</th>
						<td style="width: 250px;"  class="cx_title_td"><input style="width: 228px" class="input_cx_title_150" type="text"  id="p_title" name="p_title" value="" />
						</td>
						<th style="width: 70px" class="input_cx_title_th">发送单位：</th>
						<td class="cx_title_td"><input type="text"  style="width: 228px" class="input_cx_title_150"  id="p_send_unit_name" name="p_send_unit_name" value="" />
						</td>
					</tr>
					<tr>
						<th style="width: 70px" class="input_cx_title_th">发送日期：</th>
                        <td style="width:250px;" class="cx_title_td">
                             <input type="text" class="date_187" id="start_time" name="start_time" value="" style="width:110px;float: left;"
                                    onfocus ="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'start_time\')||\'2099-12-12\'}'})" />
                        <span style="width: 10px;float: left;" class="input_cx_title_th">至</span>
                        
                             <input type="text" class="date_187" id="end_time" name="end_time" value="" style="width:110px;float: left;"
                                    onfocus ="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'end_time\')||\'1980-01-01\'}'})" />
                        </td>
						<td colspan="2" >
						<input name="Input2" value="搜索" type="button" onclick="makeNoticeSearch()" class="but_y_01" />
						<input name="Input2" value="重置" type="button" onclick="clearSearch()" class="but_y_01" />
						</td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>

<!-- 查询列表区 cGridArea(查询区样式)-->
<div class="cGridArea">
<table id="gridTable"></table>
<div id="gridPager"></div>
</div>
<!-- 查询列表区 --></div>
<form id="delForm1" name="delForm1" method="post" action="">
	<input type="hidden" name="action" value="deleteDictdata" />
</form>
<iframe name="hiddenFrame" width="0" height="0"></iframe>
</body>
</html>
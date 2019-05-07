<%@page import="com.chinacreator.security.AccessControl"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="com.chinacreator.xtbg.pub.util.DictDropDownList"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	String path = request.getContextPath();
	String readonly = request.getParameter("readonly");
	if(readonly == null || "".equals(readonly)){
		readonly = "0";
	}
	String sql = "select t.oetype_id,t.oetype_name from ymj_oa_office_equipmenttype t order by t.oetype_no ";
	String infotypeHtml = DictDropDownList.buildSelect(sql,"oetype_id","","",true,"");//信息来源下拉框
%>
<title>办公设备领用</title>
<!-- 公共部分开始 -->
<!-- 引入jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<!-- 引入jQuery UI -->
<script src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>
<!-- 引入my97时间控件 -->
<script src="../../../resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<!-- 引入jGrid -->
<link rel="stylesheet" type="text/css" media="screen" href="../../../resources/plug/jquery.jqGrid-4.3.1/css/ui.jqgrid.css" />
<script src="../../../resources/plug/jquery.jqGrid-4.3.1/js/i18n/grid.locale-en.js" type="text/javascript"></script>
<script src="../../../resources/plug/jquery.jqGrid-4.3.1/js/jquery.jqGrid.min.js" type="text/javascript"></script>
<!-- 引入其它 -->
<script src="../../../resources/js/util/public.js" type="text/javascript"></script>
<script src="../../../resources/js/common/commoncss.js" type="text/javascript"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js"charset="utf-8"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script> 
<script type="text/javascript">
$(function() {
	var readonly = "<%=readonly%>";
	$(document).keydown(function(){
		if(event.keyCode == 13){ 
			userSearch();
		}
		});
//tab2
	$("#gridTable").jqGrid({
		url: '<%= path %>' + '/commonListServlet?classNameId=collarEqStockList',  //commonListServlet列表公共的servlet,classNameId在servletBean.xml文件中配置要调用的类,isPage:是否翻页(true,false),默认为true
		//jqGrid控件通过这个参数得到需要显示的数据，具体的返回值可以使XML也可以是Json
		datatype: "json",
		//这个参数用于设定将要得到的数据类型。我最常用的是“json”，其余的类型还包括：xml、xmlstring、local、javascript、function
		mtype: "POST",
		//定义使用哪种方法发起请求，GET或者POST
		height: "100%",//270
		//Grid的高度，可以接受数字、%值、auto，默认值为150
		//width ："1800", //Grid的宽度，如果未设置，则宽度应为所有列宽的之和；如果设置了宽度，则每列的宽度将会根据shrinkToFit选项的设置，进行设置。
		//shrinkToFit ：true 此选项用于根据width计算每列宽度的算法。默认值为true。如果shrinkToFit为true且设置了width值，则每列宽度会根据width成比例缩放；如果shrinkToFit为false且设置了width值，则每列的宽度不会成比例缩放，而是保持原有设置，而Grid将会有水平滚动条
		autowidth: true,
		//width: "1000",
		//默认值为false。如果设为true，则Grid的宽度会根据父容器的宽度自动重算。重算仅发生在Grid初始化的阶段；如果当父容器尺寸变化了，同时也需要变化Grid的尺寸的话，则需要在自己的代码中调用setGridWidth方法来完成。
		colNames: ['设备ID', '设备名称', '类别','设备编号','型号','领用人','领用处室','领用日期'],
		//字符串数组，用于指定各列的题头文本，与列的顺序是对应的。
		colModel: [ //最重要的数组之一，用于设定各列的参数
		{
			name: 'stock_Id',
			index: 'stock_Id',
			hidden: true
		},
		{
			name: 'eq_name',
			index: 'eq_name',
			width: 180
		},
		{
			name: 'eq_type',
			index: 'type_name',
			width: 180
		},
		{
			name: 'eq_no',
			index: 'eq_no',
			width: 180
		},
		{
			name: 'eq_model',
			index: 'eq_model',
			width: 180
		},
		{
			name: 'collar_userName',
			index: 'collar_userName',
			width: 90
		},
		{
			name: 'collar_departName',
			index: 'collar_departName',
			width: 180
		},
		{
			name: 'collar_date',
			index: 'collar_date',
			width: 100
		}
		],
		sortname: 'oetype_no,stock_Id',
		//指定默认的排序列，可以是列名也可以是数字。此参数会在被传递到Server端。
		sortorder: 'desc',
		viewrecords: true,
		//设置是否在Pager Bar显示所有记录的总数。
		rowNum: 15,
		//用于设置Grid中一次显示的行数，默认值为20。正是这个选项将参数rows（prmNames中设置的）通过url选项设置的链接传递到Server。注意如果Server返回的数据行数超过了rowNum的设定，则Grid也只显示rowNum设定的行数。
		rowList: [10, 20, 30],
		//一个数组，用于设置Grid可以接受的rowNum值。例如[10,20,30]
		gridComplete: function() { // var idss=jQuery("#gridTable").jqGrid('getColNames');
			var ids = $("#gridTable").getDataIDs(); //jqGrid('getDataIDs');
			for (var i = 0; i < ids.length; i++) {
				var cl = ids[i];
								
			}
			if(readonly == "1"){
				$("#add").hide();
			}
		},
		jsonReader: { //这又是一个数组，用来设定如何解析从Server端发回来的json数据
			repeatitems: false
		},
		pagerintoolbar:true,//上面的分页条
		pagerinBottombar:true,//下面的分页条
		//定义页码控制条Page Bar
		//caption: "来文缓急维护",
		//设置Grid表格的标题，如果未设置，则标题区域不显示。
		search:toUserParamJosn(),
		prmNames: { //这是一个数组，用于设置jqGrid将要向Server传递的参数名称
			rows: "rows",
			//表示请求行数的参数名称  
			sort: "sidx",
			//表示用于排序的列名的参数名称  
			order: "sord",
			//表示采用的排序方式的参数名称 
			search : "search"
		},
		toolbar:[true, "top" ,"<input class='but_y_01' id='add' value='领用登记' type='button' onclick='addLevel()'/>"],
		multiselect: false,
		onCellSelect:function (id,iCol)
		{
			if(iCol != 0)
			{
				updateLevel(id);
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
	 函数:  toUserParamJosn
	 说明:  构建要查询的参数
	 参数:   无
	 返回值: 返回要查询的参数
	 */
var toUserParamJosn = function() {
			var str = "{'collar_startTime':'"+$('#input_starttime').val()+"','collar_endTime':'"+$('#input_endtime').val()+"',"+
			"'eq_typeId':'"+$('#oetype_id').val()+"',"+
			"'eq_no':'"+$('#equipment_no').val()+"',"+
			"'eq_name':'"+$('#equipment_name').val()+"',"+
			"'collar_userName':'"+$('#collar_userName').val()+"',"+
			"'collar_departName':'"+$('#collar_depart').val()+"','state':'2'}";
	return descape(escape(str));
}

/*
函数:  userSearch
说明:  查询用户信息
参数:   无
返回值: 用户列表
*/
var userSearch = function() {
	
var sdata = { //构建查询需要的参数 
	paramJson: toUserParamJosn()
}; //获得当前postData选项的值  
var postData = $("#gridTable").jqGrid("getGridParam", "postData"); //将查询参数融入postData选项对象  
$.extend(postData, sdata);
$("#gridTable").jqGrid("setGridParam", {
	search: true, // 将jqGrid的search选项设为true  
	search : toUserParamJosn()
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
	var sdata = {
		paramJson: ""
	};
	var postData = $("#gridTable").jqGrid("getGridParam", "postData");
	$.extend(postData, sdata); //将postData中的查询参数覆盖为空值  
	$("#gridTable").jqGrid("setGridParam", {
		search: false // 将jqGrid的search选项设为false  
	}).trigger("reloadGrid", [{
		page: 1
	}]);
	resetSingleSearchDialog();
};


/*
	 函数:  addLevel
	 说明:  修改缓急程度
	 参数:   无
	 返回值: 无
	 */
var addLevel = function(id) {
	openWindows("windowId","领用登记","../../officeassets/jsp/addCollarEqStock.jsp?widowsid=windowId",'officeEqStockList',false,window);
}
/*
	 函数:  updateLevel
	 说明:  修改缓急程度
	 参数:   无
	 返回值: 无
	 */
var updateLevel = function(id) {
	var model = jQuery("#gridTable").jqGrid('getRowData', id);
	openWindows("windowId","领用登记修改","../../officeassets/jsp/updateCollarEqStock.jsp?widowsid=windowId&stock_Id=" + model.stock_Id,'officeEqStockList',false,window);
}

function exportCsv() {
	alert("正在导出为CSV文件......请稍等");
}

var getCheckBoxValue = function() {
	/*得到所选择的值*/
	var str = "";
	$("[.jqgrow td input][checked]").each(function() {
		str += $(this).val() + ",";
	});
}

window.onload = function () {
	setDataTimeClickShowOrHide('input_starttime',window);
	setDataTimeClickShowOrHide('input_endtime',window);
}
	//Excel数据导出
	function outPutExcel(){
		var title = "办公室物品领用列表";
		var sql = "";
		//对应字段中文含义描叙
		var paramHead = "设备名称,类别,设备编号,型号,领用人,领用处室,领用日期";
	    var columnWidth = "3000,3000,3000,3000,3000,3000,3000";
	
		$("#sql").val(encodeURI(descape(sql)));
		$("#paramHead").val(encodeURI(descape(paramHead)));
		$("#title").val(encodeURI(descape(title)));
		$("#columnWidth").val(columnWidth);
	
		var fm = document.getElementById("excelForm");
		fm.target = "hiddenFrame2";
		fm.submit();
	 } 
</script>
</head>
<body style="overflow-y:auto;">
<div style="width:98%;">

			<!-- 查询条件选区    tabs_search_ctable(查询table样式) -->
			<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tabs_search_ctable_box">
				<tr>
					<td>
						<!-- 固定查询 -->
						<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tabs_search_ctable">
							<tr>
									<th class="input_cx_title_th">领用日期：</th>
								<td  class="cx_title_td">
								<input class="date_120 " type="text" id="input_starttime" name="input_starttime" 
									onFocus="var input_endtime=$dp.$('input_endtime');WdatePicker({onpicked:function(){input_endtime.focus();},dateFmt:'yyyy-MM-dd '})" 
									/>
								<span class="date_120_span">至</span>
								 
								  <input class="date_120 " type="text" id="input_endtime" name="input_endtime" 
								  onfocus="WdatePicker({minDate:'#F{$dp.$D(\'input_starttime\')}',dateFmt:'yyyy-MM-dd '})" 
								  />
								</td>
								<td width="385"  colspan="2" >
								<input name="Input2" value="搜索" type="button" onclick="userSearch()" class="but_y_01"/>
								<span id="selAreaImg" class="all_search_condition"><a onclick="hiddenOrShowSelArea('hiddenArea','selAreaImg')" >更多搜索条件</a></span></td>
							</tr>
						</table>
						<!-- 固定查询 end-->
					</td>
					</tr>
					
					<tr>
					<td>
					<!-- 隐藏查询 -->
						<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tabs_search_ctable" id="hiddenArea" style="display:none">
							<tr>
								<th class="input_cx_title_th">类别：</th>
								<td  class="cx_title_td">
									<%=infotypeHtml %>
								</td>
								<th class="input_cx_title_th">领用处室：</th>
								<td  class="cx_title_td">
									<input class="input_cx_title_283" id="collar_depart" name="collar_depart" type="text" />
								</td>
							</tr>
							<tr>
								<th width="90" class="input_cx_title_th" >设备名称：</th>
									<td width="296"  class="cx_title_td">
										<input class="input_cx_title_283" id="equipment_name" name="equipment_name" type="text" />
								</td>
								<th class="input_cx_title_th">设备编号：</th>
								<td  class="cx_title_td">
									<input class="input_cx_title_283" id="equipment_no" name="equipment_no" type="text" />
								</td>
							</tr>
							<tr>
								<th class="input_cx_title_th">领用人：</th>
								<td  class="cx_title_td">
									<input class="input_cx_title_283" id="collar_userName" name="collar_userName" type="text" />
								</td>
							</tr>
						</table>
						<!-- 隐藏查询 end-->
							</td>
				</tr>
			</table>
		<!-- 查询列表区 cGridArea(查询区样式)-->
		<div class="cGridArea">
		<table id="gridTable"></table>
		<div id="gridPager"></div>
		</div>
		<!-- 查询列表区 -->
</div>
<form id="excelForm" name="paramForm" method="post"	action="../../../public/util/jsp/expexcel.jsp">
	<input type="hidden" name="sql" id="sql" /> 
	<input type="hidden" name="paramHead" id="paramHead" /> 
	<input type="hidden" name="title" id="title" /> 
	<input type="hidden" name="columnWidth" id="columnWidth" />
</form>
<iframe name="hiddenFrame2" width=0 height=0></iframe>
</body>
</html>
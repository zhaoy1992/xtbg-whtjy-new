<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.UserCache"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DaoUtil"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
	String path = request.getContextPath();
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	String userid=accesscontroler.getUserID();
	UserCacheBean userbean= UserCache.getUserCacheBean(userid);
	
	String orgname="";
	String orgid="";
	if(userbean!=null){
		orgname=userbean.getUnit_name();
		orgid=userbean.getUnit_id();
	}
%>
<title>加油管理界面列表</title>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<!-- 引入jQuery UI -->
<script src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>
<!-- 引入jGrid -->
<script src="../../../resources/plug/jquery.jqGrid-4.3.1/js/i18n/grid.locale-en.js" type="text/javascript"></script>
<script src="../../../resources/plug/jquery.jqGrid-4.3.1/js/jquery.jqGrid.min.js" type="text/javascript"></script>
<!-- 引入其它 -->
<script src="../../../../oa/resources/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<!-- 公共部分引用结束 -->
<!-- 当jqGrid列的字过多的时候显示...样式  -->
<!-- 引入my97时间控件 -->
<script src="../../../resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<script type="text/javascript">
$(function() {
	/*
	$(document).keydown(function(){
		if(event.keyCode == 13){ 
			doSearch();
		}
	});
	*/

	$("#gridTable").jqGrid({
		url: '<%= path %>' + '/commonListServlet?classNameId=carManageRefuelmanageYmjList',  //commonListServlet列表公共的servlet,classNameId在servletBean.xml文件中配置要调用的类,isPage:是否翻页(true,false),默认为true
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
			label:"加油详情ID",
			name: 'fuel_id',
			index: 'fuel_id',
			hidden: true
		},
		{
			label:"加油时间",
			name: 'refuel_time',
			index: 'refuel_time',
			width: 340,
			editable: true
		},
		{
			label:"加油人",
			name: 'fuel_name',
			index: 'fuel_name',
			width: 400,
			editable: true
		},
		{
			label:"加油量",
			name: 'fuel_charge',
			index: 'fuel_charge',
			width: 400,
			editable: true
		},
		{
			label:"加油单价",
			name: 'unit_cost',
			index: 'unit_cost',
			width: 400,
			editable: true
		},
		{
			label:"总价",
			name: 'total_price',
			index: 'total_price',
			width: 400,
			editable: true
		},
		{
			label:"车牌号码",
			name: 'car_num',
			index: 'car_num',
			width: 400,
			editable: true
		},
		{
			label:"修改/删除",
			name: 'act',
			index: 'act',
			width: 400,
			editable: true
		}
		],
		sortname: 'refuel_time',
		//指定默认的排序列，可以是列名也可以是数字。此参数会在被传递到Server端。
		sortorder: 'desc',
		viewrecords: true,
		
		//设置是否在Pager Bar显示所有记录的总数。
		rowNum: 10,
		//用于设置Grid中一次显示的行数，默认值为20。正是这个选项将参数rows（prmNames中设置的）通过url选项设置的链接传递到Server。注意如果Server返回的数据行数超过了rowNum的设定，则Grid也只显示rowNum设定的行数。
		rowList: [10, 20, 30],
		//一个数组，用于设置Grid可以接受的rowNum值。例如[10,20,30]
		gridComplete: function() {
			var ids = $("#gridTable").getDataIDs(); //jqGrid('getDataIDs');
			for (var i = 0; i < ids.length; i++) {
				var cl = ids[i];
				var model = jQuery("#gridTable").jqGrid('getRowData', cl);
				updBut = "<input type='button' class='but_y_01' onMouseOver=javascript:$(this).attr('class','but_y_02'); onMouseOut=javascript:$(this).attr('class','but_y_01'); onclick='udateInfo("+cl+")' value = '修改' />";
				delBut = "<input type='button' class='but_y_01' onMouseOver=javascript:$(this).attr('class','but_y_02'); onMouseOut=javascript:$(this).attr('class','but_y_01'); onclick='delInfo("+cl+")' value = '删除' />"
				jQuery("#gridTable").jqGrid('setRowData', ids[i], {
					act : updBut+delBut
				});
			}
		},
		jsonReader: { //这又是一个数组，用来设定如何解析从Server端发回来的json数据
			repeatitems: false
		},
		pagerintoolbar:true,//上面的分页条
		pagerinBottombar:true,//下面的分页条
		//定义页码控制条Page Bar
		//caption: "接收到的电子公告",
		//设置Grid表格的标题，如果未设置，则标题区域不显示。
		search : toSearchParamJson(),
		prmNames: { //这是一个数组，用于设置jqGrid将要向Server传递的参数名称
			rows: "rows",
			//表示请求行数的参数名称  
			sort: "sidx",
			//表示用于排序的列名的参数名称  
			order: "sord",
			//表示采用的排序方式的参数名称 
			search : "search"
		},
		toolbar: [true,"top","<input class='but_y_01' onMouseOver=javascript:$(this).attr('class','but_y_02'); onMouseOut=javascript:$(this).attr('class','but_y_01'); id=add type='button' onclick='addInfo()' value='新增'/>"],//<input class='but_y_01' onMouseOver=javascript:$(this).attr('class','but_y_02'); onMouseOut=javascript:$(this).attr('class','but_y_01'); id=del type='button' value='删除' onclick='delInfo()'/>
		multiselect: false,
		onCellSelect: function(id,iCol) {
			/*if(iCol!=0){
				jQuery("#gridTable").setSelection(id,false);
			 	udateInfo(id);
			}*/
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
	 函数:  toSearchParamJson
	 说明:  构建要查询的参数
	 参数:   无
	 返回值: 返回要查询的参数
	 */
var toSearchParamJson = function() {
	var str = "{'start_time':'"+$('#input_starttime').val()+"','end_time':'"+$('#input_endtime').val()+"'}";
	return descape(escape(str));
}

/*
	 函数:  doSearch
	 说明:  查询程序界面信息
	 参数:   无
	 返回值: 程序界面列表
*/
var doSearch = function() {
	var sdata = { //构建查询需要的参数 
		paramJson: toSearchParamJson()
	}; //获得当前postData选项的值  
	var postData = $("#gridTable").jqGrid("getGridParam", "postData"); //将查询参数融入postData选项对象  
	$.extend(postData, sdata);
	$("#gridTable").jqGrid("setGridParam", {
		search: true ,// 将jqGrid的search选项设为true  
		userFilters:toSearchParamJson()
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
	var sdata = {
		paramJson: toSearchParamJson()
	};
	var postData = $("#gridTable").jqGrid("getGridParam", "postData");
	$.extend(postData, sdata); //将postData中的查询参数覆盖为空值  
	$("#gridTable").jqGrid("setGridParam", {
		search: true // 将jqGrid的search选项设为false  
	}).trigger("reloadGrid", [{
		page: 1
	}]);
	
};

/*
	 函数:  resetSingleSearchDialog
	 说明:  清空值查询值
	 参数:   无
	 返回值: 无
	 */
var resetSingleSearchDialog = function() { //$("radio","#singleSearchDialog").attr("checked", false);  
	$(":text", "#queryTable").val("");
	$('#ckzt option:first').attr('selected', 'selected');
};

/*
函数:  delInfo
说明:  删除程序界面
参数:   无
返回值: 无
*/
var delInfo = function(id) {
	var model = jQuery("#gridTable").jqGrid('getRowData', id);
	var okF = function(){	
		$("#id").val(model.fuel_id);
		var fm = document.getElementById("delForm1");
		fm.target = "hiddenFrame";
		fm.submit();}
		var p={
				headerText:'提示',
				okName:'确认',
		        okFunction:okF,
		        cancelName:'取消'
		};
		alert("确定要删除该信息吗？",p)
}

/*
函数:  addInfo
说明:  添加程序界面
参数:   无
返回值: 无
*/
var addInfo = function() {
	 openWindows('addRefuelmanageInfo_main_page','新增','addRefuelmanageInfo.jsp?opt=add&subId=addRefuelmanageInfo_main_page','addRefuelmanageInfo_main_page',false,window);
}
/*
	 函数:  udateInfo
	 说明:  修改程序界面
	 参数:   无
	 返回值: 无
*/
var udateInfo = function(id) {
	var model = jQuery("#gridTable").jqGrid('getRowData', id);
		openWindows('updRefuelmanageInfo_main_page','查看界面信息','addRefuelmanageInfo.jsp?opt=upd&subId=updRefuelmanageInfo_main_page&id='+model.fuel_id,'updRefuelmanageInfo_main_page',false,window);
	}
		
</script>
</head>
<body>
<div>
			<!-- 查询条件选区    tabs_search_ctable(查询table样式) -->
			<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tabs_search_ctable_box">
				<tr>
					<td>
						<!-- 固定查询 -->
						<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tabs_search_ctable">
							<tr>
								<th class="input_cx_title_th">加油日期：</th>
								<td class="cx_title_td">
								<input class="date_120 " type="text" id="input_starttime" name="input_starttime" 
									onFocus="var input_endtime=$dp.$('input_endtime');WdatePicker({onpicked:function(){input_endtime.focus();},dateFmt:'yyyy-MM-dd '})" />
								<span class="date_120_span">至</span>
								<input class="date_120 " type="text" id="input_endtime" name="input_endtime" 
									onfocus="WdatePicker({minDate:'#F{$dp.$D(\'input_starttime\')}',dateFmt:'yyyy-MM-dd '})" />
								</td>
								<td width="385"  colspan="2" >
									<input name="Input2" value="搜索" type="button" onclick="doSearch()" class="but_y_01"/>
								</td>
							</tr>
						</table>
						<!-- 固定查询 end-->
					</td>
					</tr>
			</table>
			
<!-- 查询列表区 cGridArea(查询区样式)-->
<div class="cGridArea" style="margin-top:29px">
<table id="gridTable"></table>
<div id="gridPager"></div>
</div>
<!-- 查询列表区 --></div>
<form id="delForm1" name="delForm1" method="post" action="addRefuelmanage.jsp">
	<input type="hidden" name="id" id="id" /> 
	<input type="hidden" name="opt" value="del" />
</form>
<iframe name="hiddenFrame" width="0" height="0"></iframe>
</body>
</html>
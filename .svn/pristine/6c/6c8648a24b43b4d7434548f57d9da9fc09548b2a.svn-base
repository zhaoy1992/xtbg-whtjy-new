<%--
描述：固定资产维修列表
作者：夏天
版本：1.0
日期：2014-03-06
--%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="/WEB-INF/archive-taglib.tld" prefix="oa"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<!-- 公共部分开始 -->
<script type="text/javascript" src="${pageContext.request.contextPath}/ccapp/xtbg/resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<!-- 引入jQuery UI -->
<script src="${pageContext.request.contextPath}/ccapp/xtbg/resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>
<!-- 引入jGrid -->
<link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/ccapp/xtbg/resources/plug/jquery.jqGrid-4.3.1/css/ui.jqgrid.css" />
<script src="${pageContext.request.contextPath}/ccapp/xtbg/resources/plug/jquery.jqGrid-4.3.1/js/i18n/grid.locale-en.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/ccapp/xtbg/resources/plug/jquery.jqGrid-4.3.1/js/jquery.jqGrid.min.js" type="text/javascript"></script>
<!-- 引入其它 -->
<script type="text/javascript" src="${pageContext.request.contextPath}/ccapp/xtbg/resources/plug/ifrom/js/ifrom-ui-alert.1.1.js" charset="utf-8"></script>
<script src="${pageContext.request.contextPath}/ccapp/xtbg/resources/js/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/ccapp/xtbg/resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<script src="${pageContext.request.contextPath}/ccapp/xtbg/resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<script type="text/javascript">
$(function() {
	$(document).keydown(function(){
		if(event.keyCode == 13){ 
			userSearch();
		}
		});

	$("#gridTable").jqGrid({
		url: '${pageContext.request.contextPath}/pubListServlet?classNameId=com.chinacreator.xtbg.tjy.detectionsupplies.list.OsupplieRepairList',  //commonListServlet列表公共的servlet,classNameId在servletBean.xml文件中配置要调用的类,isPage:是否翻页(true,false),默认为true
		datatype: "json",
		mtype: "POST",
		height: "100%",//270
		autowidth: true,
		colNames: ['主键ID', '故障位置情况 ','报修时间', '修理时间','报修单位','维修状态'],
		colModel: [ //最重要的数组之一，用于设定各列的参数
		{
			name: 'repair_id',index: 'repair_id',hidden: true
		},
		{
			name: 'place_info',index: 'place_info',width: 170
		},
		{
			name: 'report_time',index: 'report_time',width: 60
		},
		{
			name: 'repair_time',index: 'repair_time',width: 60
		},
		{
			name: 'repair_unitname',index: 'repair_unitname',width: 80
		},
		{
			name: 'deal_status',index: 'deal_status',width: 60
		}
		],
		sortname: 'report_time',
		//指定默认的排序列，可以是列名也可以是数字。此参数会在被传递到Server端。
		sortorder: 'asc',
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
		},
		jsonReader: { //这又是一个数组，用来设定如何解析从Server端发回来的json数据
			repeatitems: false
		},
		pagerintoolbar:true,//上面的分页条
		pagerinBottombar:true,//下面的分页条
		//定义页码控制条Page Bar
		//caption: "来文缓急维护",
		//设置Grid表格的标题，如果未设置，则标题区域不显示。
		search : toUserParamJosn(),
		prmNames: { //这是一个数组，用于设置jqGrid将要向Server传递的参数名称
			rows: "rows",
			//表示请求行数的参数名称  
			sort: "sidx",
			//表示用于排序的列名的参数名称  
			order: "sord",
			//表示采用的排序方式的参数名称 
			search : "search"
		},
		toolbar:[true, "top" ,"<input class='but_y_01' id=add value='报修登记' type='button' onclick='addRepair()' value=''/><input class='but_y_01' value='删除' id=del type='button' onclick='delLevel()' value=''/>"],
		multiselect: true,
		onCellSelect:function (id,iCol)
		{
			if(iCol != 0)
			{
				updateRepair(id);
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
函数:  StringCheck
说明:  做查询时通配符处理问题
参数:   obj 文本框上获得的值
返回值: 返回转换后的值
*/
function StringCheck(obj){
	return obj.replaceAll('%','----').replaceAll('_','----').replaceAll(' ','----');
}
	 
/*
	 函数:  toUserParamJosn
	 说明:  构建要查询的参数
	 参数:   无
	 返回值: 返回要查询的参数
	 */
var toUserParamJosn = function() {
	var str = "{'place_info':'" + StringCheck($("#place_info").val()) +"','repair_type':'assets'}";
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
		search: true // 将jqGrid的search选项设为true  
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
函数:  addRepair
说明:  添加报修登记
参数:   无
返回值: 无
*/
var addRepair = function() {
	var pageName ="报修登记";
	openAlertWindows('windowId',"${pageContext.request.contextPath}/ccapp/xtbg/tjy/detectionsupplies/repair/jsp/repairDeviceDetail.jsp?windowsId=windowId&actionName=insert",pageName,500,430,'25%','25%');
}

/*
函数:  updateRepair
说明:  修改报修登记
参数:   无
返回值: 无
*/
var updateRepair = function(id) {
var model = jQuery("#gridTable").jqGrid('getRowData', id);
var pageName ="修改报修登记";
openAlertWindows('windowId','${pageContext.request.contextPath}/ccapp/xtbg/tjy/detectionsupplies/repair/jsp/repairDeviceDetail.jsp?windowsId=windowId&actionName=update&repair_id='+ model.repair_id,pageName,500,430,'25%','25%');
}

/*
函数:  deleteLevel
说明:  删除缓急程度
参数:   无
返回值: 无
*/
var delLevel = function(id) {
var ids = "";
var selectedIds = $("#gridTable").jqGrid("getGridParam", "selarrrow");
var idsArrTemp = new Array();
$(selectedIds).each(function () {
	var model = jQuery("#gridTable").jqGrid('getRowData', this);
	if(!IsSpace(model.repair_id)){
		idsArrTemp.push("'"+model.repair_id+"'");
	}
});

ids = idsArrTemp.join();

if (IsSpace(ids)) {
	alert("请选择要删除的记录！");
} else {
	var okF = function(){
		$("#delete").val(ids);
		var fm = document.getElementById("delForm2");
		fm.target = "hiddenFrame2";
		fm.submit();
	}
	var p={
				headerText:'提示',
				okName:'确认',
		        okFunction:okF,
		        cancelName:'取消'
		};
	alert("确认后删除该条记录吗？",p)
}
}

afterSubmitFn=function(result){
	try{
		if(result.indexOf("delete")!=-1){
			alert(result.split(",")[1]);
			userSearch();
		}else{
			if(result.split(",").length>1){
					result = result.split(",");
					alert(result[0]);
					userSearch();
			} else {
				alert(result);
				userSearch();
			}
			
		}
	}catch(e){alert(e.description);}
};
</script>
</head>
<body>

 <div>

	<!-- 查询条件选区    tabs_search_ctable(查询table样式) -->
			<table id="queryTable" width="100%" border="0" cellspacing="0" cellpadding="0" class="tabs_search_ctable_box">
				<tr>
					<td>
						<!-- 固定查询 -->
						<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tabs_search_ctable">
							<tr>
							<th width="90" class="input_cx_title_th" >故障位置：</th>
								<td width="296"  class="cx_title_td">
								<input type="text" id="place_info" class="input_cx_title_283" >
								</td>
								<td width="385"  colspan="2"  >
								<input value="搜索" id="sel" type="button" onclick="userSearch()" class="but_y_01"/>
								</td>
							</tr>
						</table>
						<!-- 固定查询 end-->
					</td>
					</tr>
					<tr>
					<td>
			</td></tr>
			
			</table>

		<!-- 查询列表区 cGridArea(查询区样式)-->
		<div class="cGridArea">
		<table id="gridTable"></table>
		<div id="gridPager"></div>
		</div>
		<!-- 查询列表区 -->
</div>
<form id="delForm2" name="delForm2" method="post" action="repairDevicedo.jsp">
	<input type="hidden" name="delete" id="delete"> 
	<input type="hidden" name="action" value="deleteInf">
</form>

<iframe name="hiddenFrame2" width=0 height=0></iframe>
</body>

</html>


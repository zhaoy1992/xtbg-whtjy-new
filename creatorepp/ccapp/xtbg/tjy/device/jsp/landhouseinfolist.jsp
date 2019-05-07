<%--
描述：设备台帐列表管理界面
作者：邱炼
版本：1.0
日期：2014-03-03
--%>
<%@page import="com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.UserCache"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	String GET_LIST_CLASS1="com.chinacreator.xtbg.tjy.device.list.LandHouseInfoList";
	String path = request.getContextPath();
	UserCacheBean userBean= UserCache.getUserCacheBean(accesscontroler.getUserID());
	if(userBean==null){
		userBean = new UserCacheBean();
	}
	//单位ID
	String unit_id ="";
	//单位名称
	String unit_name = userBean.getUnit_name();
	if(!StringUtil.deNull(unit_name).equals("湖北省特检院")){
		unit_id = userBean.getUnit_id();
	}
%>
<title>设备台帐管理</title>
<!-- 公共部分开始 -->
<!-- 引入jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<!-- 引入jQuery UI -->
<script src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>
<!-- 引入my97时间控件 -->
<script src="../../../resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<!-- 引入jGrid -->
<script src="../../../resources/plug/jquery.jqGrid-4.3.1/js/i18n/grid.locale-en.js" type="text/javascript"></script>
<script src="../../../resources/plug/jquery.jqGrid-4.3.1/js/jquery.jqGrid.min.js" type="text/javascript"></script>
<!-- 引入其它 -->
<script src="../../../resources/js/util/public.js" type="text/javascript"></script>
<script src="../../../resources/js/common/commoncss.js" type="text/javascript"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js"charset="utf-8"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script> 
<!-- 公共部分引用结束 -->
<script type="text/javascript">
$(function() {
	$(document).keydown(function(){
		if(event.keyCode == 13){ 
			userSearch();
		}
		});
//tab2
	$("#gridTable").jqGrid({
		url: '<%= path %>' + '/pubListServlet?classNameId=<%=GET_LIST_CLASS1%>',  //commonListServlet列表公共的servlet,classNameId在servletBean.xml文件中配置要调用的类,isPage:是否翻页(true,false),默认为true
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
		colNames: ['主键ID','编号', '名称','面积', '地点','证号','日期','金额','备注'],
		//字符串数组，用于指定各列的题头文本，与列的顺序是对应的。
		colModel: [ //最重要的数组之一，用于设定各列的参数
         {
   			name: 'lh_id',
   			index: 'lh_id',
   			hidden:true
   		},{
			name: 'lh_number',
			index: 'lh_number',
			width: 60
		},
		{
			name: 'lh_name',
			index: 'lh_name',
			width: 60
		},
		{
			name: 'lh_area',
			index: 'lh_area',
			width: 60
		},
		{
			name: 'lh_location',
			index: 'lh_location',
			width: 40
		},
		{
			name: 'lh_identify_code',
			index: 'lh_identify_code',
			width: 60
		},
		{
			name: 'lh_date',
			index: 'lh_date',
			width: 60
		},
		{
			name: 'lh_money',
			index: 'lh_money',
			width: 60
		},
		{
			name: 'lh_remarks',
			index: 'lh_remarks',
			width: 60
		}
		],
		sortname: 'lh_create_time',
		//指定默认的排序列，可以是列名也可以是数字。此参数会在被传递到Server端。
		sortorder: 'desc',
		viewrecords: true,
		
		//设置是否在Pager Bar显示所有记录的总数。
		rowNum: 15,
		//用于设置Grid中一次显示的行数，默认值为20。正是这个选项将参数rows（prmNames中设置的）通过url选项设置的链接传递到Server。注意如果Server返回的数据行数超过了rowNum的设定，则Grid也只显示rowNum设定的行数。
		rowList: [10, 20, 30],
		//一个数组，用于设置Grid可以接受的rowNum值。例如[10,20,30]
		gridComplete: function() { // var idss=jQuery("#gridTable").jqGrid('getColNames');
			//设置工具栏宽度
			$(".t_taoobar_content_left").css("width","420px");
			var ids = $("#gridTable").getDataIDs(); //jqGrid('getDataIDs');
			for (var i = 0; i < ids.length; i++) {
				var cl = ids[i];
				var model = jQuery("#gridTable").jqGrid('getRowData', cl);
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
		toolbar:[true, "top" ,"<input class='but_y_01' id=add value='添加' type='button' onclick='addLevel()'/>"+
		"<input class='but_y_01' id='del' type='button' value='删除' onclick='delLevel()'style='margin-left:5px;'/>"+
		"<input class='but_excelout_01' id='exprot' title='导出excel表格' type='button' onclick='exprotExcel()' style='margin-left:5px;' />"+
		"<input class='but_excelgo_01' id='import' title='导入excel表格' type='button' onclick='importExcel()' style='margin-left:5px;' />"],
		multiselect: true,
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
	var str = "{'lh_number':'" + $("#lh_number").val() + //编号
	"','lh_name':'" + $("#lh_name").val() + //名称
	"','lh_area':'" + $("#lh_area").val() + //面积
	"','lh_location':'" + $("#lh_location").val() +
	"','lh_identify_code':'" + $("#lh_identify_code").val() + //证号
	"','lh_date_start':'" + $("#lh_date_start").val() + //日期
	"','lh_date_end':'" + $("#lh_date_end").val() + //日期
	"','lh_money':'" + $("#lh_money").val() + //金额
	"','unit_id':'<%=unit_id%>'}";
	return descape(escape(str));
}
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
函数:  addlevel
说明:  添加缓急程度
参数:   无
返回值: 无
*/
var addLevel = function() {
	var pageName ="增加土地房屋详情";
	var url = "<%=path%>/ccapp/xtbg/tjy/officesupplies/jsp/handhousedetailinfo.jsp?windowsId=windowId&actionName=insert";
	openAlertWindows('windowId',url,pageName,550,390,'25%','25%');
}

/*
函数:  exprotExcel
说明:  导出Excel表格
参数:   无
返回值: 无
*/
var exprotExcel = function(){
	var url = getCurrentFilePath()+"/ajaxexceLandHouseInfo.jsp?"  +"windowId=windowId_paperPS&sJson="+toUserParamJosn();  
  	
  	if(jQuery("#hiddenFrame").size()==0){
  		jQuery('<iframe id="hiddenFrame"  name="hiddenFrame" width=0 height=0></iframe>'+
		           '<form id="downFrom" name="downFrom" method="post" action="'+url+'" target="hiddenFrame">'+
		           '</form>').appendTo("body").submit();
	}
	if(jQuery("#downFrom").size()>0){
		jQuery("#downFrom").remove();
	}
}

/*
函数:  importExcel
说明:  导入Excel表格
参数:   无
返回值: 无
*/
var importExcel = function(){
	var title = descape(escape('土地房屋信息')); //转码,避免中文传输乱码
	var remark = descape(escape('注意:导入的文件编号是唯一的。')); //转码,避免中文传输乱码
	var url = '${pageContext.request.contextPath}/ccapp/oa/resources/util/excel/excelimport.jsp?excelImplClass=landHouseInfoDaoExcelImpl&excelTemplateFilePath=landhouse_excelTemplateFilePath&title='+title+'&remark='+remark;
	openAlertWindows('windowId',url,
		    '导入excel表格', '455px', '70%', '10%', '40%', function() {
			location.reload();
    });
}

/*
	 函数:  updateLevel
	 说明:  修改土地房屋信息
	 参数:   无
	 返回值: 无
	 */
var updateLevel = function(id) {
	var model = jQuery("#gridTable").jqGrid('getRowData', id);
	var pageName ="修改土地房屋详细页面";
	var url = "<%=path%>/ccapp/xtbg/tjy/officesupplies/jsp/handhousedetailinfo.jsp?windowsId=windowId&actionName=update&lh_id="+model.lh_id;
	openAlertWindows('windowId',url,pageName,550,390,'25%','25%');
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
		if(!IsSpace(model.lh_id)){
			idsArrTemp.push(model.lh_id);
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
		alert("确认删除该条记录吗？",p)
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
</script>
</head>
<body style="overflow-y:auto;">
<div>

	<!-- 查询条件选区    tabs_search_ctable(查询table样式) -->
			<table id="queryTable" width="100%" border="0" cellspacing="0" cellpadding="0" class="tabs_search_ctable_box">
				<tr>
					<td>
						<!-- 固定查询 -->
						<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tabs_search_ctable">
							   <tr>
									<th width="90" class="input_cx_title_th">名称：</th>
									<td width="296"  class="cx_title_td">
										<input type="text" name="lh_name" id="lh_name" class="input_cx_title_283" />
									</td>
									<td width="385"  colspan="2"  >
										<input value="搜索" id="sel" type="button" onclick="userSearch()" class="but_y_01"/>
										<span id="selAreaImg" class="all_search_condition"><a onclick="hiddenOrShowSelArea('hiddenArea','selAreaImg')" >更多搜索条件</a></span>
									</td>
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
									<th width="90" class="input_cx_title_th">编号：</th>
									<td >
										<input type="text" name="lh_number" id="lh_number" class="input_cx_title_283" />
									</td>
									<th width="90" class="input_cx_title_th">面积：</th>
									<td >
										<input type="text" name="lh_area" id="lh_area" class="input_cx_title_283" />
									</td>
							</tr>
							<tr>
									<th width="90" class="input_cx_title_th">地点：</th>
									<td >
										<input type="text" id="lh_location" name="lh_location" class="input_cx_title_283" >
									</td>
									<th width="90" class="input_cx_title_th">证号：</th>
									<td >
										<input type="text" id="lh_identify_code" name="lh_identify_code" class="input_cx_title_283" >
									</td>
							</tr>
							<tr>
									<th width="90" class="input_cx_title_th">日期：</th>
									<td >
										<input id="lh_date_start" name="lh_date_start" type="text"   class="date_120"
											onFocus="var input_endtime=$dp.$('lh_date_end');WdatePicker({onpicked:function(){lh_date_end.focus();},dateFmt:'yyyy-MM-dd'})" 
										/>
										<span class="date_120_span">至</span> 
										<input id="lh_date_end" name="lh_date_end" type="text"  class="date_120"
											onfocus="WdatePicker({minDate:'#F{$dp.$D(\'lh_date_start\')}',dateFmt:'yyyy-MM-dd'})" 
										 />
									</td>
									<th width="90" class="input_cx_title_th">金额：</th>
									<td >
										<input type="text" id="lh_money" name="lh_money" class="input_cx_title_283" >
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
<form id="delForm2" name="delForm2" method="post" action="landhouseinfodo.jsp">
	<input type="hidden" name="delete" id="delete"> 
	<input type="hidden" name="action" value="deleteInf">
</form>

<iframe name="hiddenFrame2" width=0 height=0></iframe>
</body>
</html>
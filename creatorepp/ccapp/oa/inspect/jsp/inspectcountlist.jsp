<%-- 
描述：督查事项统计列表
作者：肖杰
版本：1.0
日期：2013-10-15
 --%>
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
%>
<title>督查事项统计列表</title>
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

</style>
<script type="text/javascript">
$(function() {
	$(document).keydown(function(){
		if(event.keyCode == 13){ 
			inspectSearch();
		}
	});

	$("#gridTable").jqGrid({
		url: '<%=path%>' + '/pubListServlet?classNameId=com.chinacreator.xtbg.core.inspect.list.InspectCountList',  
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
			label:"单位id",
			name: 'org_id',
			index: 'org_id',
			hidden: true
			,sorttype:'int',summaryType:'count', summaryTpl : '合计'
		},
		{
			label:"单位名称",
			name: 'org_name',
			index: 'org_name',
			width: 400,
			sortable: false
			
		},
		{
			label:"任务数量",
			name: 'count1',
			index: 'count1',
			width: 200,
			editable: true
		},
		{
			label:"反馈数量",
			name: 'count2',
			index: 'count2',
			width: 200,
			sortable: false
		},
		{
			label:"完成数量",
			name: 'count3',
			index: 'count3',
			width: 200,
			sortable: false
		}
		,
		{
			label:"未完成数量",
			name: 'count4',
			index: 'count4',
			width: 200,
			sortable: false
		}
		,
		{
			label:"办理中数量",
			name: 'count5',
			index: 'count5',
			width: 200,
			sortable: false
		}
		],
		sortname: 'org_name',
		//指定默认的排序列，可以是列名也可以是数字。此参数会在被传递到Server端。
		sortorder: '',

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
		toolbar: [true,"top","<input class='but_y_01' onMouseOver=javascript:$(this).attr('class','but_y_02'); onMouseOut=javascript:$(this).attr('class','but_y_01'); id=add type='button' onclick='upload()' value='导出'/>"],
		multiselect: false,
		onCellSelect: function(id,iCol) {
			if(iCol!=0){
			 	//updateMakeNotice(id);
			}
		},
		loadComplete: function(){
			var counts1=0;
			var counts2=0;
			var counts3=0;
			var counts4=0;
			var counts5=0;
			var ids = $("#gridTable").getDataIDs();
			if(!isSpace(ids)){
				for (var i = 0; i < ids.length; i++) {
	                var cl = ids[i];
					var model = jQuery("#gridTable").jqGrid('getRowData', cl);
					counts1=counts1+parseInt(model.count1);
					counts2=counts2+parseInt(model.count2);
					counts3=counts3+parseInt(model.count3);
					counts4=counts4+parseInt(model.count4);
					counts5=counts5+parseInt(model.count5);
				}
				$("#gridTable").addRowData("heji",{org_name:'合计',count1:counts1,count2:counts2,count3:counts3,count4:counts4,count5:counts5},"last");
			}
			var ids = $("#gridTable").getDataIDs(); //jqGrid('getDataIDs');
			for (var i = 0; i < ids.length; i++) {
                var cl = ids[i];
				var model = jQuery("#gridTable").jqGrid('getRowData', cl);
                var a=model.count3;
                var b=model.count4;
                var c=model.count5;
				a=a+" ("+((parseInt(model.count3)*100/parseInt(model.count1)).toFixed(0)+"%)");
				b=b+" ("+((parseInt(model.count4)*100/parseInt(model.count1)).toFixed(0)+"%)");
				c=c+" ("+((parseInt(model.count5)*100/parseInt(model.count1)).toFixed(0)+"%)");
				jQuery("#gridTable").jqGrid('setRowData', ids[i], {
					count3:a,
					count4:b,
					count5:c
				});
				if(cl=='heji'){
					jQuery("#gridTable").jqGrid('setRowData', ids[i], {
						org_name:"<strong><span>"+model.org_name+"</span></strong>",
						count1:"<strong><span>"+model.count1+"</span></strong>",
						count2:"<strong><span>"+model.count2+"</span></strong>",
						count3:"<strong><span>"+a+"</span></strong>",
						count4:"<strong><span>"+b+"</span></strong>",
						count5:"<strong><span>"+c+"</span></strong>",
					});
					
				}
			}
		}
	}).navGrid('#gridPager', {
		edit: false,
		add: false,
		del: false,
		refresh: false,
		search: false
	});
	
	jQuery("#gridTable").jqGrid('groupingRemove',true);
	
});

	 
/*
	 函数:  toJson
	 说明:  构建要查询的参数
	 参数:   无
	 返回值: 返回要查询的参数
	 */
var toJson = function() {
	var str ="{'org_name':'"+$("#org_name").val()
		+"','start_time':'"+$("#start_time").val()
		+"','end_time':'"+$("#end_time").val()+"'}";
	return descape(escape(str));
}

/*
	 函数:  inspectSearch
	 说明:  查询
	 参数:   无
	 返回值: 
*/
var inspectSearch = function() {
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
	inspectSearch();
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
函数:  upload
说明:  导出
参数:   无
返回值: 无
*/
var upload = function() {
	var url = getCurrentFilePath()+"/ajaxexceinspectcount.jsp?"  +"windowId=windowId_paperPS&sJson="+toJson(); 
	if(jQuery("#hiddenFrame").size()==0){
  		jQuery('<iframe id="hiddenFrame"  name="hiddenFrame" width=0 height=0></iframe>'+
           '<form id="downFrom" name="downFrom" method="post" action="'+url+'" target="hiddenFrame">'+
           '</form>').appendTo("body").submit();
	}
	if(jQuery("#downFrom").size()>0){
		jQuery("#downFrom").remove();
	}
};

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
						<th style="width: 70px" class="input_cx_title_th">查询日期：</th>
                        <td style="width:110px;" class="cx_title_td">
                             <input type="text" class="date_187" id="start_time" name="start_time" value="" style="width:110px;"
                                    onfocus ="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'end_time\')||\'2099-12-12\'}'})" />
                        </td><th style="width: 10px" class="input_cx_title_th">至</th>
                        <td style="width:110px;" class="cx_title_td">
                             <input type="text" class="date_187" id="end_time" name="end_time" value="" style="width:110px;"
                                    onfocus ="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'start_time\')||\'1980-01-01\'}'})" />
                        </td>
						<th style="width: 70px" class="input_cx_title_th">单位：</th>
						<td width="150" class="cx_title_td"><input class="input_cx_title_150" type="text"  id="org_name" name="org_name" value="" />
						</td>
						<td  >
						<input name="Input2" value="搜索" type="button" onclick="inspectSearch()" class="but_y_01" />
						<!-- <input name="Input2" value="重置" type="button" onclick="clearSearch()" class="but_y_01" /> -->
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
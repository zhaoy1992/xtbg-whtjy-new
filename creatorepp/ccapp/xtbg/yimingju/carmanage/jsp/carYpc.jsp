<%@page import="com.chinacreator.xtbg.pub.util.DictDropDownList"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="com.chinacreator.xtbg.pub.util.DaoUtil" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%
	String path = request.getContextPath();
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	String userid = accesscontroler.getUserID();
	String loginUserName = accesscontroler.getUserAccount();
	
	String sql = "select r.car_id,r.car_num from YMJ_OA_CARMANAGE_CAR r where r.current_state=1";
	String infotypeHtml = DictDropDownList.buildSelect(sql,"car_id","","",true,""); // 车辆下拉框的值 
%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>回车登记-已派车</title>

<!-- 引入jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>

<!-- 引入my97时间控件 -->
<script src="../../../resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>

<!-- 引入jQuery UI -->
<link id="uiThemes" rel="stylesheet" type="text/css" media="screen" href="../../../resources/plug/jquery-ui-1.8.17.custom/css/custom-theme/jquery-ui-1.8.17.custom.css" />
<script src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>

<!-- 引入jGrid -->
<link rel="stylesheet" type="text/css" media="screen" href="../../../resources/plug/jquery.jqGrid-4.3.1/css/ui.jqgrid.css" />
<script src="../../../resources/plug/jquery.jqGrid-4.3.1/js/i18n/grid.locale-en.js" type="text/javascript"></script>
<script src="../../../resources/plug/jquery.jqGrid-4.3.1/js/jquery.jqGrid.min.js" type="text/javascript"></script>

<!-- 引入其它 -->
<script src="../../../resources/js/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-tree.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../public/flowinfoconfig/resources/js/tree.js" charset="utf-8"></script>
<!--  公共部分调用结束 -->
<script type="text/javascript">
var loginUserName='<%=loginUserName%>';
var loginUserID=<%=userid%>;
$(function() {
	
	//查询绑定回车
	$(document).keydown(function(){
		if(event.keyCode == 13){ 
			userSearch();
		}
	})
	//接收表
	$("#gridTable").jqGrid({
		url: '<%= path %>' + '/commonListServlet?classNameId=carYpcYmjList',  //commonListServlet列表公共的servlet,classNameId在servletBean.xml文件中配置要调用的类,isPage:是否翻页(true,false),默认为true
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
		colNames: ['apply_id','申请人ID','用车人','用车人id','用车时间','用车结束时间','申请时间','所用车辆','car_id','驾驶员','状态'],
		//字符串数组，用于指定各列的题头文本，与列的顺序是对应的。
		colModel: [ //最重要的数组之一，用于设定各列的参数
		 {
		  	name: 'apply_id',
		  	index: 'apply_id',
		  	hidden:true,
		  	align:'left'
		 },
		 {
			name: 'apply_personid',
			index: 'apply_personid',
			hidden:true,
			align:'left'
		 },
		 {
	   		name: 'use_name',
	   		index: 'use_name',
	   		edit:false,
	   		width: 80,
	   		sortable: false
	   	},
	    {
	   		name: 'use_id',
	   		index: 'use_id',
	   		edit:false,
	   		hidden:true,
	   		sortable: false
	   	},
		 {
   			name: 'use_starttime',
   			index: 'use_starttime',
   			edit:false,
   			width: 80,
   			sortable: false
   		},
   	 	{
   			name: 'use_endtime',
   			index: 'use_endtime',
   			edit:false,
   			hidden:true,
   			sortable: false
   		},
   		{
   			name: 'sqrq',
   			index: 'sqrq',
   			width: 40,
   			align:'left',
   			sortable: false
    	},
    	{
   			name: 'car_num',
   			index: 'car_num',
   			width: 40,
   			align:'left',
   			sortable: true
    	},
    	{
   			name: 'car_id',
   			index: 'car_id',
   			hidden:true
    	},
    	{
   			name: 'sjname',
   			index: 'sjname',
   			align:'left',
   			width: 50,
   			sortable: false
    	},
    	{
   			name: 'state',
   			index: 'state',
   			width: 30,
   			align:'left',
   			sortable: false
    	}
		],
		sortname: 'userid',
		//指定默认的排序列，可以是列名也可以是数字。此参数会在被传递到Server端。
		sortorder: 'desc',
		viewrecords: true,
		
		//设置是否在Pager Bar显示所有记录的总数。
		rowNum: 10,
		//用于设置Grid中一次显示的行数，默认值为20。正是这个选项将参数rows（prmNames中设置的）通过url选项设置的链接传递到Server。注意如果Server返回的数据行数超过了rowNum的设定，则Grid也只显示rowNum设定的行数。
		//rowList: [10, 20, 30],
		//一个数组，用于设置Grid可以接受的rowNum值。例如[10,20,30]
		gridComplete: function() { // var idss=jQuery("#gridTable").jqGrid('getColNames');
			var ids = $("#gridTable").getDataIDs(); //jqGrid('getDataIDs');
			for (var i = 0; i < ids.length; i++) {
				 var cl = ids[i];
				 var model = jQuery("#gridTable").jqGrid('getRowData', cl);
				 
				 ycsj = model.use_starttime+" 至 "+model.use_endtime;
				
				 jQuery("#gridTable").jqGrid('setRowData', ids[i], {
					use_starttime: ycsj
				});
			}
		},
		
		jsonReader: { //这又是一个数组，用来设定如何解析从Server端发回来的json数据
			repeatitems: false
		},
		//pager: "#gridPager1",
		//定义页码控制条Page Bar
		//caption: "",
		//设置Grid表格的标题，如果未设置，则标题区域不显示。
		pagerintoolbar:true,//上面的分页条
		pagerinBottombar:true,//下面的分页条
		
		/* filterNames:["state"],
		filterOptions:[
		               [
		                ["","状态"],["1","等待车辆分派"],["2","等待审批"],["3","审批未通过"],["4","已派车"],["5","派车结束"]
		               ],//value text 后的值与显不
		              ],
		filterOptionsDefValue:[0,5],  */
		
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
		toolbar: [true,"top","<input type='button' style='display:none;' class='but_y_01' value='用车申请' onclick='addApplyinfo()'/>"],
		multiselect: false,
		onSelectRow : function(id) {
			CarSp(id);
		}
	}).navGrid('#gridPager', {
		edit: false,
		add: false,
		del: false,
		search:false,
		refresh: false
	});
});


/*
函数:  toUserParamJosn
说明:  构建要查询的参数
参数:   无
返回值: 返回要查询的参数
*/
var toUserParamJosn = function() {
	 var str = "{'apply_personid':'" + loginUserID 
	 		+ "','use_starttime':'" + $("#use_starttime").val()+ "','use_endtime':'" 
	 		+ $("#use_endtime").val() + "','car_id':'" + $("#car_id").val()  
	 		//+ "','state':'" + $("#state").val()
	 		+ "','list_type':'"+"carWaitSp'}";
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
		search: true ,// 将jqGrid的search选项设为true  
		userFilters : toUserParamJosn()
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
		paramJson: toUserParamJosn()
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
$("select:first option:first").attr("selected","selected");
};

/**
 * 新增用车申请
 */
var addApplyinfo = function() {
	var url = "<%=path%>/ccapp/xtbg/yimingju/carmanage/jsp/addCarManageApplyinfo.jsp?subid=addApplyinfo";
	location.href = url;
}

/**
 * 车辆管理-车辆申请记录查看
 */
var CarSp = function(id) {
	var model = jQuery("#gridTable").jqGrid('getRowData', id);
	
	var url = "<%=path%>/ccapp/xtbg/yimingju/carmanage/jsp/carYpcInfo.jsp?apply_id="+model.apply_id;
	
	openWindows("sub_ymjpcsp"+id,window,url+"&subid=sub_ymjpcsp"+id,'ymjclgl',false,window);
}

</script>
</head>
<body>
			<!-- 查询条件选区    tabs_search_ctable(查询table样式) -->
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tabs_search_ctable_box" id="queryTable">
		<tr>
			<td>
					<!-- 固定查询 -->
			<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tabs_search_ctable">
				<tr>
					<th class="input_cx_title_th">用车日期：</th>
					<td  class="cx_title_td">
						<input class="date_120 " type="text" id="use_starttime" name="use_starttime" onclick="WdatePicker()"/>
						<span class="date_120_span">至</span>
						<input class="date_120 " type="text" id="use_endtime" name="use_endtime" onclick="WdatePicker({minDate:'#F{$dp.$D(\'use_starttime\')}'})"/>
					</td>
							
					<td width="385"  colspan="2"  >
						<input name="Input2" value="搜索" type="button" onclick="userSearch()" class="but_y_01"/>
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
							<th class="input_cx_title_th">车辆：</th>
							<td  class="cx_title_td">
								<%=infotypeHtml %>
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

	<form id="form1" name="form1" method="post">
			<input id="grinfoid" name="grinfoid" type="hidden" />
	</form>
	
	<iframe name="hiddenFrame" width=0 height=0></iframe>

</body>
</html>

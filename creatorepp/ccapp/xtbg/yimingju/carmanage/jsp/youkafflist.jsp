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
%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>特检院油卡管理</title>

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
<script language="javascript" src="<%=path %>/ccapp/xtbg/resources/plug/Lodop/LodopFuncs.js"></script>
<object id="LODOP" classid="clsid:2105C259-1E0C-4534-8141-A753534CB4CA" width=0 height=0>
	<embed id="LODOP_EM" type="application/x-print-lodop" width=0 height=0 pluginspage="<%=path %>/ccapp/xtbg/resources/plug/Lodop/install_lodop.exe"></embed>
</object> 
<!--  公共部分调用结束 -->
<script type="text/javascript">
$(function() {
	//查询绑定回车
	$(document).keydown(function(){
		if(event.keyCode == 13){ 
			userSearch();
		}
	})
	//接收表
	$("#gridTable").jqGrid({
		url: '<%= path %>' + '/commonListServlet?classNameId=carManageYoukaFafangList',  //commonListServlet列表公共的servlet,classNameId在servletBean.xml文件中配置要调用的类,isPage:是否翻页(true,false),默认为true
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
		colNames: ['t_id','申请事由','车牌号','申请科室','申请人','充值金额','申请日期','油卡号','油卡金额','发放人','发放日期','审批单','操作','action_form','ins_id','busi_id','act_name','template_id','busitype_code'],
		//字符串数组，用于指定各列的题头文本，与列的顺序是对应的。
		colModel: [ //最重要的数组之一，用于设定各列的参数
		 {
		  	name: 't_id',
		  	index: 't_id',
		  	hidden:true
		 },{
		 	name: 'shenqingshiyou',
		 	index: 'shenqingshiyou',
		 	width: 8
		 },{
		 	name: 'car_info',
		 	index: 'car_info',
		 	width: 8
		 },{
		 	name: 'org_name',
		 	index: 'org_name',
		 	width: 8
		 },{
		 	name: 'application',
		 	index: 'application',
		 	width: 8
		 },{
		 	name: 'money',
		 	index: 'money',
		 	width: 8
		 },{
		 	name: 'application_date',
		 	index: 'application_date',
		 	width: 8
		 },{
		 	name: 'youka_no',
		 	index: 'youka_no',
		 	width: 8
		 },{
		 	name: 'yu_e',
		 	index: 'yu_e',
		 	width: 8
		 },{
		 	name: 'fafang_user',
		 	index: 'fafang_user',
		 	width: 8
		 },{
		 	name: 'fafang_date',
		 	index: 'fafang_date',
		 	width: 8
		 },{
		 	name: 'shenpidan',
		 	index: 'shenpidan',
		 	width: 8
		 },{
		 	name: 'caozuo',
		 	index: 'caozuo',
		 	width: 8
		 },{
		  	name: 'action_form',
		  	index: 'action_form',
		  	hidden:true
		 },{
		  	name: 'ins_id',
		  	index: 'ins_id',
		  	hidden:true
		 },{
		  	name: 'busi_id',
		  	index: 'busi_id',
		  	hidden:true
		 },{
		  	name: 'act_name',
		  	index: 'act_name',
		  	hidden:true
		 },{
		  	name: 'template_id',
		  	index: 'template_id',
		  	hidden:true
		 },{
		  	name: 'busitype_code',
		  	index: 'busitype_code',
		  	hidden:true
		 }],
		sortname: 'a.application_date',
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
				be = "<input id='modify' type='button' class='but_y_01' onMouseOver=javascript:$(this).attr('class','but_y_02'); onMouseOut=javascript:$(this).attr('class','but_y_01'); onclick='look("+cl+")' value = '查看' />";
				bi = "<input id='modify' type='button' class='but_y_01' onMouseOver=javascript:$(this).attr('class','but_y_02'); onMouseOut=javascript:$(this).attr('class','but_y_01'); onclick='printFileDetail("+cl+")' value = '打印' />";
				jQuery("#gridTable").jqGrid('setRowData', ids[i], {
					shenpidan: be,
					caozuo: bi
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
		toolbar: [true,"top",""],
		multiselect: false,
		onSelectRow: function(id) {
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
	var str = "{'car_info':'"+$('#car_info').val()+"',"+
		       "'start_time':'"+$('#startSlTime').val()+"',"+
		       "'end_time':'"+$('#endSlTime').val()+"',"+
		       "'org_name':'"+$('#org_name').val()+"',"+
		       "'application':'"+$('#application').val()+"'}";
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

function look(id){ 
    var model = jQuery("#gridTable").jqGrid('getRowData', id);
    var url = '<%=path %>' + model.action_form + "?ins_id="+model.ins_id+"&busi_id="+model.busi_id+"&list_type=worklis&operType=yiban&act_name="+model.act_name+"&actiontype_code=04&busiTypeCode="+model.busitype_code
  			  +"&template_id="+model.template_id+"&Template=word"+model.template_id;
    parent.openForms(url, model.ins_name);//父页面调用打开窗口	
    //window.parent.location = url,"perspective_content";
}


function printFileDetail(id) {
/*判断浏览器的类型并决定采用哪个对象实例，并检测控件是否安装、是否最新版本、并引导安装或升级。  */
	var LODOP=getLodop(document.getElementById('LODOP'),document.getElementById('LODOP_EM'));
	createPrintHtml(LODOP,joinHtml(id));
	LODOP.PREVIEW();  
};

/*创建部分打印内容  */
function createPrintHtml(LODOP,phtml){
/*初始化运行环境，清理异常打印遗留的系统资源，设定打印任务名。  */
	LODOP.PRINT_INIT("打印");
	LODOP.SET_PRINT_STYLEA(0,"FontSize",20);
	LODOP.SET_PRINT_STYLEA(0,"Horient",3);
	LODOP.SET_PRINT_STYLEA(0,"Vorient",3);  
	LODOP.ADD_PRINT_HTM('1.25CM','0.4cm','99%','99%',phtml); 
};

function joinHtml(id){
    var model = jQuery("#gridTable").jqGrid('getRowData', id);
	var html = [
		'<div style="width:100%;">',
	    '<table style="width:100%;font: normal 12px/29px \'宋体\';background-color: #333;" border="0" cellspacing="1" cellpadding="0" >',
	    '<tr>',
	    '<td colspan="4" style="height:70px; width:25%;font: bold;font-size: xx-large;text-align: center;letter-spacing:12px;background-color: #fff">油卡发放回执单</td>',
	    '</tr>',
	    '<tr>',
	    '<td style="width:25%;height:40px;font-size: large;text-align: center;letter-spacing:12px;background-color: #fff">申请人</td>',
	    '<td style="width:25%;height:40px;font-size: large;text-align: center;background-color: #fff">',
	    model.application,
	    '</td>',
	    '<td style="width:25%;height:40px;font-size: large;text-align: center;letter-spacing:12px;background-color: #fff">申请科室</td>',
	    '<td style="width:25%;height:40px;font-size: large;text-align: center;background-color: #fff">',
	    model.org_name,
	    '</td>',
	    '</tr>',
	    '<tr>',
	    '<td style="width:25%;height:40px;font-size: large;text-align: center;letter-spacing:12px;background-color: #fff">申请时间</td>',
	    '<td style="width:25%;height:40px;font-size: large;text-align: center;background-color: #fff">',
	    model.application_date,
	    '</td>',
	    '<td style="width:25%;height:40px;font-size: large;text-align: center;letter-spacing:12px;background-color: #fff">充值金额</td>',
	    '<td style="width:25%;height:40px;font-size: large;text-align: center;background-color: #fff">',
	    model.money,
	    '</td>',
	    '</tr>',
	    '<tr>',
	    '<td style="width:25%;height:40px;font-size: large;text-align: center;letter-spacing:12px;background-color: #fff">申请事由</td>',
	    '<td colspan="3" style="height:40px;width:25%;font-size: large;text-align: center;background-color: #fff">',
	    model.shenqingshiyou,
	    '</td>',
	    '</tr>',
	    '<tr>',
	    '<td style="width:25%;height:40px;font-size: large;text-align: center;letter-spacing:12px;background-color: #fff">油卡号</td>',
	    '<td style="width:25%;height:40px;font-size: large;text-align: center;background-color: #fff">',
	    model.youka_no,
	    '</td>',
	    '<td style="width:25%;height:40px;font-size: large;text-align: center;letter-spacing:12px;background-color: #fff">油卡余额</td>',
	    '<td style="width:25%;height:40px;font-size: large;text-align: center;background-color: #fff">',
	    model.yu_e,
	    '</td>',
	    '</tr>',
	    '<tr>',
	    '<td style="width:25%;height:40px;font-size: large;text-align: center;letter-spacing:12px;background-color: #fff">发放人</td>',
	    '<td style="width:25%;height:40px;font-size: large;text-align: center;background-color: #fff">',
	    model.fafang_user,
	    '</td>',
	    '<td style="width:25%;height:40px;font-size: large;text-align: center;letter-spacing:12px;background-color: #fff">发放时间</td>',
	    '<td style="width:25%;height:40px;font-size: large;text-align: center;background-color: #fff">',
	    model.fafang_date,
	    '</td>',
	    '</tr>',
	    '<tr>',
	    '<td style="width:25%;height:40px;font-size: large;text-align: center;letter-spacing:12px;background-color: #fff">车牌号</td>',
	    '<td style="width:25%;height:40px;font-size: large;text-align: center;background-color: #fff">',
	    model.car_info,
	    '</td>',
	    '<td style="width:25%;height:40px;font-size: large;text-align: center;letter-spacing:12px;background-color: #fff">领用人签名</td>',
	    '<td style="width:25%;height:40px;font-size: large;text-align: center;background-color: #fff">',
	    '</td>',
	    '</tr>',
	    '</table>',
	    '</div> '
	  ];
	return html.join(" ");
}
	
</script>
</head>
<body>
<table width="100%">
	<tr>
		<td>
						
			<!-- 查询条件选区    tabs_search_ctable(查询table样式) -->
			<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tabs_search_ctable_box" >
				<tr>
					<td>
						<!-- 固定查询 -->
						<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tabs_search_ctable">
							<tr>
								<th class="input_cx_title_th">车牌号：</th>
								<td width="385" class="cx_title_td">
									<input id="car_info" name="car_info" type="text" class="input_cx_title_283" />
								</td>
								<td width="385"  colspan="2"  >
									<input name="Input2" value="搜索" type="button" onclick="userSearch()" class="but_y_01"/>
									<span id="selAreaImg" class="all_search_condition">
										<a onclick="hiddenOrShowSelArea('hiddenArea','selAreaImg')" >更多搜索条件</a>
									</span>
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
							<!-- 正规 4列 -->
							<tr>
								<th class="input_cx_title_th">申请科室：</th>
								<td  class="cx_title_td">
									<input id="org_name" name="org_name" type="text" class="input_cx_title_283" 　/> 
								</td>
							</tr>
							<tr>
								<th class="input_cx_title_th">申请人：</th>
								<td  class="cx_title_td">
									<input id="application" name="application" type="text" class="input_cx_title_283" 　/> 
								</td>
							</tr>
							<tr>
								<th class="input_cx_title_th">发放日期：</th>
								<td  class="cx_title_td">
								<input id="startSlTime" name="startSlTime" type="text" class="date_120"　
								onFocus="var input_endtime=$dp.$('endSlTime');WdatePicker({onpicked:function(){endSlTime.focus();},dateFmt:'yyyy-MM-dd '})"   /> 
								<span class="date_120_span">至</span>
								 <input id="endSlTime" name="endSlTime" type="text"  class="date_120" 
								 onfocus="WdatePicker({minDate:'#F{$dp.$D(\'startSlTime\')}',dateFmt:'yyyy-MM-dd '})" />
								</td>
							</tr>
						</table>
						<!-- 隐藏查询 end-->
						
					</td>
				</tr>
			</table>
		<!-- 查询条件选区    tabs_search_ctable(查询table样式) -->
						
		</td>
		</tr>
		<tr>
		<td>
		<!-- 查询列表区 cGridArea(查询区样式)-->
		<div class="cGridArea">
		<table id="gridTable"></table>
		<div id="gridPager"></div>
		</div>
				<!-- 查询列表区 -->
		</td>
	</tr>		
</table>
</body>
</html>

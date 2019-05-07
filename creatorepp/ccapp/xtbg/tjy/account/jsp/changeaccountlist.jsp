<%@page import="com.chinacreator.business.common.tools.CacheCommonManageProxy"%>
<%@page import="com.chinacreator.xtbg.core.file.util.FileUtil"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.UserCache"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="utf-8"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DictDropDownList"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	//当前用户信息
	String user_id = accesscontroler.getUserID();
	//当前用户信息
	String user_name = accesscontroler.getUserAccount();
	//获得当前登录用户所属单位信息
	UserCacheBean usercachebean=UserCache.getUserCacheBean(user_id);
	String unit_id = usercachebean.getUnit_id();
	
	String GET_LIST_CLASS1="com.chinacreator.xtbg.tjy.officesupplies.list.OsAccountDetailList";
	String path = request.getContextPath();
	
	String classify = StringUtil.deNull(request.getParameter("gdzc_classify"));
	String id_num = StringUtil.deNull(request.getParameter("id_num"));
	String m_type = StringUtil.deNull(request.getParameter("m_type"));
	//区分核验、使用管理、报废用
	String type = StringUtil.deNull(request.getParameter("type"));
	String state = "";
	if(m_type.equals("1")||m_type.equals("2")||m_type.equals("3")||m_type.equals("4")||m_type.equals("7")){
		state = "在库正常";
	}else if(m_type.equals("5")){
		state = "借用";
	}else if(m_type.equals("6")){
		state = "领用";
	}else if(m_type.equals("8")){
		state = "出租";
	}
	
%>
<title>台帐详情列表管理</title>
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
		colNames: ['主键ID','编号','内部编号','名称','条形码','机身号','状态','规格型号','生产厂家','投入使用年限','上次检定日期'],
		//字符串数组，用于指定各列的题头文本，与列的顺序是对应的。
		colModel: [ //最重要的数组之一，用于设定各列的参数
		{
			name: 'id',
			index: 'id',
			hidden: true
		},{
			name: 'num',
			index: 'num'
		},{
			name: 'internal_no',
			index: 'internal_no'
		},{
			name: 'name',
			index: 'name'
		},{
			name: 'bar_code',
			index: 'bar_code'
		},{
			name: 'body_no',
			index: 'body_no'
		},{
			name: 'state',
			index: 'state'
		},{
			name: 'it',
			index: 'it',
			hidden: true
		},{
			name: 'manufacturer',
			index: 'manufacturer',
			hidden: true
		},{
			name : 't_trsynx',
			index: 't_trsynx',
			hidden: true
		},{
			name : 'this_calibration_time',
			index : 'this_calibration_time',
			hidden: true
		}],
		sortname: 'num',
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
		toolbar:[true, "top","<input class='but_y_01' value='添加' id=add type='button' onclick='add()' />"],
		multiselect: true,
		onCellSelect:function (id,iCol)
		{
			if(iCol != 0)
			{
				//updateLevel(id);
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
	var str = "{'name':'"+StringCheck($("#name").val())+"',"+
				"'num':'"+StringCheck($("#num").val())+
		"','classify':'<%=classify%>','state' : '<%=state%>','show_baofei' : '1'}";
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

var back = function(){
	removeWindows("windowId",true);
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


/**
 * 新增
 */
var add = function() {
	var type = "<%=type%>";
	if(IsSpace(type)){//报废，使用管理
		var id_num = "<%=id_num%>";
		var selectedIds = $("#gridTable").jqGrid("getGridParam", "selarrrow");
		var model = jQuery("#gridTable").jqGrid('getRowData', selectedIds);
		if(selectedIds.length != 1){
			alert("请选择且最多选择一件物品！");
		}else {
			var okF = function(){
				var parentObject = getParentWindow('windowIds');
				if(IsSpace(id_num)){//报废   維修保養
					parentObject.loadInfo(model.id,model.num,model.name,model.it,model.manufacturer,model.t_trsynx);
				}else{//使用管理
					parentObject.loadInfo(id_num,model.id,model.num,model.internal_no,model.name,model.bar_code,model.body_no,model.state);
				}
				removeAlertWindows('windowIds',true,true,'',false,'','');
			}
			var p={
						headerText:'提示',
						okName:'确认',
				        okFunction:okF,
				        cancelName:'取消'
				};
			alert("确定要选择该物品吗？",p)
		}
	}else{
	 	var selectedIds = jQuery("#gridTable").jqGrid("getGridParam", "selarrrow");
		var idsArrTemp = new Array();
		jQuery(selectedIds).each(function () {
			var model = jQuery("#gridTable").jqGrid('getRowData', this);
			if(!IsSpace(model.id)){
				var myinfo = new Array()
				myinfo[0] = model.id;
				myinfo[1] = model.internal_no;
				myinfo[2] = model.name;
				myinfo[3] = model.it;
				myinfo[4] = model.manufacturer;
				myinfo[5] = model.bar_code;
				myinfo[6] = model.body_no;
				myinfo[7] = model.this_calibration_time;
				idsArrTemp.push(myinfo);
			}
		});
		ids = idsArrTemp.join();
		if (IsSpace(ids)) {
			alert("请选择要待检设备！");
		} else {
			getParentWindow("windowIds1").setDevInfo(idsArrTemp);
			removeAlertWindows('windowIds1',true);
		}
	}
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
								<th width="90" class="input_cx_title_th" >名称：</th>
								<td width="170"  class="cx_title_td">
									<input type="text" id="name" class="input_cx_title_283" >
								</td>
								<th width="90" class="input_cx_title_th" >编号：</th>
								<td width="170"  class="cx_title_td">
									<input type="text" id="num" class="input_cx_title_283" >
								</td>
								<td width="300"  colspan="2"  >
									<input value="搜索" id="sel" type="button" onclick="userSearch()" class="but_y_01"/>
								</td>
							</tr>

		<!-- 查询列表区 cGridArea(查询区样式)-->
		<div class="cGridArea">
		<table id="gridTable"></table>
		<div id="gridPager"></div>
		</div>
		<!-- 查询列表区 -->
</div>

<iframe name="hiddenFrame2" width=0 height=0></iframe>
</body>
</html>
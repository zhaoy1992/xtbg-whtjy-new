

<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%
	String path = request.getContextPath();
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	
	String loginUserName = accesscontroler.getUserAccount();
	String ins_id=StringUtil.deNull(request.getParameter("ins_id"));

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="com.chinacreator.xtbg.core.common.util.DictDropDownList"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<!-- 引入jQuery -->
<script type="text/javascript" src="../resources/plug/jquery1.7/jquery-1.7.1.min.js"></script>

<script src="../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>


<!-- 引入my97时间控件 -->
<script src="../resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>

<!-- 引入jGrid -->
<script src="../resources/plug/jquery.jqGrid-4.3.1/js/i18n/grid.locale-en.js"
	type="text/javascript"></script>
<script src="../resources/plug/jquery.jqGrid-4.3.1/js/jquery.jqGrid.min.js"
	type="text/javascript"></script>

<!-- 引入其它 -->
<script src="../resources/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="../resources/plug/ifrom/js/ifrom-tools.1.1.js" ></script>
<title>待办列表</title>

<script type="text/javascript"><!--
var loginUserName = '<%=loginUserName%>';
jQuery(function() {
	/* var _documentBodyHeight = window.top.findPageCacheName("_documentBodyHeight");
	var width=jQuery(window).width();
	if(width<880){
		jQuery("#maindiv").width(775);
	} */
	jQuery(document).keydown(function(){
		if(event.keyCode == 13){ 
			userSearch();
		}
	
	});
	jQuery("#gridTable").jqGrid({
		url: '<%= path %>' + '/pubListServlet?classNameId=com.chinacreator.xtbg.core.process.flowprocessing.list.FindLsWorkList',  //pubListServlet列表公共的servlet,classNameId在servletBean.xml文件中配置要调用的类,isPage:是否翻页(true,false),默认为true
		//jqGrid控件通过这个参数得到需要显示的数据，具体的返回值可以使XML也可以是Json
		datatype: "json",
		//这个参数用于设定将要得到的数据类型。我最常用的是“json”，其余的类型还包括：xml、xmlstring、local、javascript、function
		mtype: "POST",
		//定义使用哪种方法发起请求，GET或者POST
		height: "300",//270
		//Grid的高度，可以接受数字、%值、auto，默认值为150
		//width ：800, //Grid的宽度，如果未设置，则宽度应为所有列宽的之和；如果设置了宽度，则每列的宽度将会根据shrinkToFit选项的设置，进行设置。
		//shrinkToFit ：true 此选项用于根据width计算每列宽度的算法。默认值为true。如果shrinkToFit为true且设置了width值，则每列宽度会根据width成比例缩放；如果shrinkToFit为false且设置了width值，则每列的宽度不会成比例缩放，而是保持原有设置，而Grid将会有水平滚动条
		autowidth: '100%',
		//默认值为false。如果设为true，则Grid的宽度会根据父容器的宽度自动重算。重算仅发生在Grid初始化的阶段；如果当父容器尺寸变化了，同时也需要变化Grid的尺寸的话，则需要在自己的代码中调用setGridWidth方法来完成。
		colModel: [ //最重要的数组之一，用于设定各列的参数
           {
			label:'流程实例id',
   			name: 'ins_id',
   			index: 'ins_id',
   			width: '0',
   			hidden: true
   		},{
			label:'busi_id',
   			name: 'busi_id',
   			index: 'busi_id',
   			width: '0',
   			hidden: true
   		},{
			label:'insert_order',
   			name: 'insert_order',
   			index: 'insert_order',
   			width: '0',
   			hidden: true
   		},
		{
   			label:'标题',
			name: 'ins_name',
			index: 'ins_name',
			width: '0',
			editable: true,
			hidden: true
		}
   		,
		{
   			label:'流程名称',
			name: 'flow_name',
			index: 'flow_name',
			width: '0',
			editable: true,
			hidden: true
		},
		{
   			label:'分组标题',
			name: 'flow_name_order',
			index: 'flow_name_order',
			width: '0',
   			hidden: true
		},
		{
   			label:'环节名称',
			name: 'action_name',
			index: 'action_name',
			width: '200',
			editable: true
		}
   		,
		{
   			label:'处理人',
			name: 'user_realname',
			index: 'user_realname',
			width: '130',
			editable: true
		},
		{
   			label:'开始时间',
			name: 'tache_begin_time',
			index: 'tache_begin_time',
			width: '170',
			editable: true
		},
		{
   			label:'结束时间',
			name: 'tache_end_time',
			index: 'tache_end_time',
			width: '170',
			editable: true
		},
		{
   			label:'状态',
			name: 'status',
			index: 'status',
			width: '100',
			editable: true
		}
		],
		//sortname: 'last_updatetime',
		//指定默认的排序列，可以是列名也可以是数字。此参数会在被传递到Server端。
		sortname: 'accept_time,insert_order',
		sortorder: '',
		viewrecords: true,
		scroll:true,
	   	grouping:true,
	   	groupingView : {
	   		groupField : ['flow_name_order'],
	   		groupText : ['{0}'],
	   		groupColumnShow:[false]
	   	},
		//设置是否在Pager Bar显示所有记录的总数。
		rowNum: 1000,
		//用于设置Grid中一次显示的行数，默认值为20。正是这个选项将参数rows（prmNames中设置的）通过url选项设置的链接传递到Server。注意如果Server返回的数据行数超过了rowNum的设定，则Grid也只显示rowNum设定的行数。
		//rowList: [10, 20, 30],
		//一个数组，用于设置Grid可以接受的rowNum值。例如[10,20,30]
		gridComplete: function() { // var idss=jQuery("#gridTable").jqGrid('getColNames');
			
		},
		
		jsonReader: { //这又是一个数组，用来设定如何解析从Server端发回来的json数据
			repeatitems: false
		},
		//pager: "#gridPager",
		//定义页码控制条Page Bar
		//caption: "待办列表",
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
		pagerintoolbar:false,//上面的分页条
		pagerinBottombar:false,//下面的分页条
		toolbar: [true,"top"],
		multiselect: false,
		onSelectRow: function(id) {
			//handle(id);
		}
	}).navGrid('#gridPager', {
		edit: false,
		add: false,
		del: false,
		search:false,
		refresh:false
	});
});

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
var postData = jQuery("#gridTable").jqGrid("getGridParam", "postData"); //将查询参数融入postData选项对象  
jQuery.extend(postData, sdata);
jQuery("#gridTable").jqGrid("setGridParam", {
	search: true // 将jqGrid的search选项设为true  
}).trigger("reloadGrid", [{
	page: 1
}]); //重新载入Grid表格，以使上述设置生效 
}

var find=function(ins_id,busi_id){
	 jQuery.ajax({ 
         type: "post", 
         url: "findlslistdo.jsp", 
         contentType: "application/x-www-form-urlencoded; charset=utf-8",
         data : {
        	 ins_id : ins_id,
        	 busi_id:busi_id	
         },
         dataType: "json", 
         success: function(flag){
         	if (flag) {
         		var recordIDs=flag.recordid;
         		var height = window.screen.availHeight;
         		var width = window.screen.availWidth;
         		var url = "<%=path%>/ccapp/oa/archive/iwebofficequery.jsp?windowsId=windowId1&RecordID="+recordIDs;
         		openAlertWindows('windowId2',url,'公文整理',width,height,'0%','0%');
				} else {
					alert("操作失败！");
				}
         }, 
         error: function (XMLHttpRequest, textStatus, errorThrown) { 
             alert("系统异常，请稍后再试！");
         }
      });
	
}
/*
函数:  clearSearch
说明:  重置
参数:   无
返回值: 无
*/
var clearSearch = function() {
var sdata = {
	paramJson: descape(escape("{'username':'"+loginUserName+"'}"))
};
var postData = jQuery("#gridTable").jqGrid("getGridParam", "postData");
jQuery.extend(postData, sdata); //将postData中的查询参数覆盖为空值  
jQuery("#gridTable").jqGrid("setGridParam", {
	search: true // 将jqGrid的search选项设为false  
}).trigger("reloadGrid", [{
	page: 1
}]);
resetSingleSearchDialog();
};

	/*
	 函数:  toUserParamJosn
	 说明:  构建要查询的参数
	 参数:   无
	 返回值: 返回要查询的参数
	 */
var toUserParamJosn = function() {
   	var str = "{'ins_code':'<%=ins_id%>'}";
	return descape(escape(str));
}

/*
函数:  resetSingleSearchDialog
说明:  清空值查询值
参数:   无
返回值: 无
*/
var resetSingleSearchDialog = function() { //$("radio","#singleSearchDialog").attr("checked", false);  
$("text", "#queryTable").val("");
$("select:first option:first").attr("selected","selected");
}

--></script>
</head>
<body>
		<!-- 查询列表区 cGridArea(查询区样式)-->
				<div class="cGridArea">
					<table id="gridTable"></table>
					<div id="gridPager"></div>
				</div>
				<!-- 查询列表区 -->
		
</body>
</html>
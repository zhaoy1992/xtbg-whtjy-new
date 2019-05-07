<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	String userid = accesscontroler.getUserID();	
	
	String sql = "select i.infotype_id, i.infotype_name from ta_oa_infre_info_type i where i.infotype_source = '"+InfoSource.INFORMATION_COLLECTION+"'";
	String infotypeHtml = DictDropDownList.buildSelect(sql,"infotype_id","","",true,"");//信息类型下拉框
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.pub.util.DaoImplClassUtil"%>
<%@page import="com.chinacreator.xtbg.zhangjiajie.inforeported.dao.InfoReportManagerDao"%>
<%@page import="com.chinacreator.xtbg.pub.util.DictDropDownList"%>
<%@page import="com.chinacreator.xtbg.zhangjiajie.inforeported.entity.InfoSource"%>
<%@page import="com.chinacreator.xtbg.zhangjiajie.inforeported.entity.InfoType"%><html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>已上报列表</title>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>

<!-- 引入jQuery UI -->
<link id="uiThemes" rel="stylesheet" type="text/css" media="screen" href="../../../resources/plug/jquery-ui-1.8.17.custom/css/custom-theme/jquery-ui-1.8.17.custom.css" />
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
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<!-- 公共部分引用结束 -->

<script type="text/javascript">

$(function() {
	$(document).keydown(function(){
		if(event.keyCode == 13){ 
			userSearch();
		}
	});
	
	$("#gridTable").jqGrid({
		url: '<%= path %>' + '/commonListServlet?classNameId=infoReportHasBeReportedList',  //commonListServlet列表公共的servlet,classNameId在servletBean.xml文件中配置要调用的类,isPage:是否翻页(true,false),默认为true
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
		colNames: ['报送id', '标题' , '录入时间', '录入者','上报接收人','信息类型', '信息状态','上报时间'],
		//字符串数组，用于指定各列的题头文本，与列的顺序是对应的。
		colModel: [ //最重要的数组之一，用于设定各列的参数
        {
			name: 'submittedinfo_id',
			index: 'submittedinfo_id',
			hidden: true
		},
		{
			name: 'submittedinfo_title',
			index: 'submittedinfo_title',
			width: '100',
			editable: true
		},
		{
			name: 'input_date',
			index: 'input_date',
			width: '30',
			editable: true
		},
		{
			name: 'inputuser_name',
			index: 'inputuser_name',
			width: '30',
			editable: true
		},
		{
			name: 'sbusername',
			index: 'sbusername',
			width: '30',
			editable: true
		},
		{
			name: 'infotype_name',
			index: 'infotype_name',
			width: '50',
			editable: true
		},
		{
			name: 'submittedinfo_typename',
			index: 'submittedinfo_typename',
			width: '20',
			editable: true
		},
		{
			name: 'relese_time',
			index: 'relese_time',
			width: '30',
			editable: true,
			hidden:true
		}
		],
		sortname: 'relese_time',
		//指定默认的排序列，可以是列名也可以是数字。此参数会在被传递到Server端。
		sortorder: 'desc',
		viewrecords: true,
		
		//设置是否在Pager Bar显示所有记录的总数。
		rowNum: 10,
		//用于设置Grid中一次显示的行数，默认值为20。正是这个选项将参数rows（prmNames中设置的）通过url选项设置的链接传递到Server。注意如果Server返回的数据行数超过了rowNum的设定，则Grid也只显示rowNum设定的行数。
		rowList: [10, 20, 30],
		//一个数组，用于设置Grid可以接受的rowNum值。例如[10,20,30]
		gridComplete: function() { 
			// alert(idss);
			var ids = $("#gridTable").getDataIDs(); //jqGrid('getDataIDs');
			for (var i = 0; i < ids.length; i++) {
				var cl = ids[i];

			}
		},
		jsonReader: { //这又是一个数组，用来设定如何解析从Server端发回来的json数据
			repeatitems: false
		},
		//pager: "#gridPager",
		pagerintoolbar:true,//上面的分页条
		pagerinBottombar:true,//下面的分页条
		//定义页码控制条Page Bar
		//caption: "已上报信息",
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
		toolbar: [true,"top"],
		//multiselect: true,
		onSelectRow: function(id) {
			editPerson(id);
		}
	}).navGrid('#gridPager', {
		edit: false,
		add: false,
		del: false,
		search: false,
		refresh: false
	});
	
	
	$("#t_gridTable").append("<div>")

	.append("</div>");


});
/*
	 colModel的重要选项

	 和jqGrid一样colModel也有许多非常重要的选项，在使用搜索、排序等方面都会用到。这里先只说说最基本的。

	 name ：为Grid中的每个列设置唯一的名称，这是一个必需选项，其中保留字包括subgrid、cb、rn。
	 index ：设置排序时所使用的索引名称，这个index名称会作为sidx参数（prmNames中设置的）传递到Server。
	 label ：当jqGrid的colNames选项数组为空时，为各列指定题头。如果colNames和此项都为空时，则name选项值会成为题头。
	 width ：设置列的宽度，目前只能接受以px为单位的数值，默认为150。
	 sortable ：设置该列是否可以排序，默认为true。
	 search ：设置该列是否可以被列为搜索条件，默认为true。
	 resizable ：设置列是否可以变更尺寸，默认为true。
	 hidden ：设置此列初始化时是否为隐藏状态，默认为false。
	 formatter ：预设类型或用来格式化该列的自定义函数名。常用预设格式有：integer、date、currency、number等
	
	 资料:http://www.trirand.com/jqgridwiki/doku.php?id=wiki:common_rules
	 */

	 
/*
	 函数:  toUserParamJosn
	 说明:  构建要查询的参数
	 参数:   无
	 返回值: 返回要查询的参数
	 */
var toUserParamJosn = function() {
	var userid = "<%=userid %>";
	var str = "{'submittedinfo_title':'"+descape($('#submittedinfo_title').val())+"','inputuser_id':'"+userid+"',"+
				"'input_starttime':'"+$('#input_starttime').val()+"','input_endtime':'"+$('#input_endtime').val()+"',"+
				"'infotype_id':'"+$('#infotype_id').val()+"',"+
				"'submittedinfo_typecode':'"+$('#submittedinfo_typecode').val()+"'}";
	return descape(escape(str));
}


/*
函数:  personSearch
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
	userFilters:toUserParamJosn()
}).trigger("reloadGrid", [{
	page: 1
}]); //重新载入Grid表格，以使上述设置生效 
}


var refreshGrid4WfactionInfo = function() {
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
函数:  resetSingleSearchDialog
说明:  清空值查询值
参数:   无
返回值: 无
*/
var resetSingleSearchDialog = function() { 
$(":text", "#queryTable").val("");
$(":hidden", "#queryTable").val("");
$("select").each(function(){
	$(this).find("option:first").attr("selected","selected");
})
};

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
		search: true, // 将jqGrid的search选项设为false  
		userFilters:toUserParamJosn()
	}).trigger("reloadGrid", [{
		page: 1
	}]);

};

var editPerson = function(id) {
	var model = jQuery("#gridTable").jqGrid('getRowData', id);
	var url = "../../inforeported/jsp/infoviewforhasbereported.jsp?submittedinfoId="+model.submittedinfo_id+'&operwindowid=sub_infoviewforhasbereported'+model.submittedinfo_id;
	openWindows('sub_infoviewforhasbereported'+model.submittedinfo_id,'已上报信息',url,'inforeport',false,window);
}

var chooseUser = function (){
	var url = "../../tree/jsp/orgusertree.jsp";

	var orgObj= null;
	 orgObj = window.showModalDialog(url,"","dialogWidth=286px;dialogHeight=596px;center:yes;scroll:no");
	 if(!IsSpace(orgObj)){
		 $('#inputuser_id').val(orgObj.id);
		 $('#inputuser_name').val(orgObj.name);
	 }
}

/**
 * div  none or block
 */
var dianjian = function()
{
	var none = $('#searchTerm').css('display');
	if(none == "none"){
		
		$('#searchTerm').show(); 
		$('#shrink').hide(); 
		$('#open').show();
		}
	else{
		$('#shrink').show(); 
		$('#open').hide();
		$('#searchTerm').hide();
		clearSearch();
	 }
}

window.onload = function () {
	setDataTimeClickShowOrHide('input_starttime',window);
	setDataTimeClickShowOrHide('input_endtime',window);
}
</script>
</head>
<body>
<table width="100%" id="queryTable">
	<tr>
		<td>
						
			<!-- 查询条件选区    tabs_search_ctable(查询table样式) -->
			<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tabs_search_ctable_box">
					<tr>
						<td>
							<!-- 固定查询 -->
							<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tabs_search_ctable">
								<tr>
									<th width="90" class="input_cx_title_th" >标题：</th>
									<td width="296"  class="cx_title_td">
									<input name="submittedinfo_title" id="submittedinfo_title" type="text" class="input_cx_title_283" /></td>
									<td width="385"  colspan="2"  >
									<input name="Input2" value="搜索" type="button" 
									onclick="userSearch()" class="but_y_01"/>
									<span id="selAreaImg" class="all_search_condition">
									<a onclick="hiddenOrShowSelArea('hiddenArea','selAreaImg')" >更多搜索条件
									</a></span></td>
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
								<th class="input_cx_title_th">录入时间：</th>
								<td  class="cx_title_td">
								<input id="input_starttime" name="input_starttime" type="text"  class="date_120" 
								onFocus="var input_endtime=$dp.$('input_endtime');WdatePicker({onpicked:function(){input_endtime.focus();},dateFmt:'yyyy-MM-dd'})"
								/> 
								<span class="date_120_span">至</span> 
								<input id="input_endtime" name="input_endtime" type="text"  class="date_120" 
								
								onfocus="WdatePicker({minDate:'#F{$dp.$D(\'input_starttime\')}',dateFmt:'yyyy-MM-dd'})"
								/>
								</td>
								<th class="input_cx_title_th">信息类型：</th>
								<td  class="cx_title_td">
								<%=infotypeHtml %>
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
	<div class="cGridArea">
		<table id="gridTable"></table>
		<div id="gridPager"></div>
	</div>
	</td>
	</tr>
	</table>
	<!-- 查询列表区 -->
<form id="form1" name="form1" method="post" >
<input id="personids" name="personids" value="" type="hidden"></input>
<input id="groupshowids" name="groupshowids" type="hidden" value=""></input>
</form>
<iframe name="hiddenFrame" width=0 height=0></iframe>
</body>
</html>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@ page contentType="text/html; charset=GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%
AccessControl accesscontroler = AccessControl.getInstance();
accesscontroler.checkAccess(request, response);
String buessid = request.getParameter("buessid");
String path = request.getContextPath();
String lookfj = request.getParameter("lookfj");
%>
<head>
<title>文件上传</title>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>

<!-- 引入jQuery UI -->
<link id="uiThemes" rel="stylesheet" type="text/css" media="screen"
	href="../../resources/plug/jquery-ui-1.8.17.custom/css/redmond/jquery-ui-1.8.17.custom.css" />
<script
	src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js"
	type="text/javascript"></script>

<!-- 引入jGrid -->
<link rel="stylesheet" type="text/css" media="screen"
	href="../../resources/plug/jquery.jqGrid-4.3.1/css/ui.jqgrid.css" />
<script src="../../resources/plug/jquery.jqGrid-4.3.1/js/i18n/grid.locale-en.js"
	type="text/javascript" charset="utf-8"></script>
<script src="../../resources/plug/jquery.jqGrid-4.3.1/js/jquery.jqGrid.min.js"
	type="text/javascript"></script>

<!-- 引入jQuery_dialog -->
<link rel="stylesheet" type="text/css" media="screen"
	href="../../resources/plug/jquery_dialog/jquery_dialog.css" />
<script src="../../resources/plug/jquery_dialog/jquery_dialog.js"></script>

<!-- 引入其它 -->
<script src="../../resources/js/util/public.js" type="text/javascript"></script>

<style type="text/css">
			/*demo page css*/
			body{ font: 62.5% "Trebuchet MS", sans-serif; }
			.demoHeaders { margin-top: 2em; }
			#dialog_link {padding: .4em 1em .4em 20px;text-decoration: none;position: relative;}
			#dialog_link span.ui-icon {margin: 0 5px 0 0;position: absolute;left: .2em;top: 50%;margin-top: -8px;}
			ul#icons {margin: 0; padding: 0;}
			ul#icons li {margin: 2px; position: relative; padding: 4px 0; cursor: pointer; float: left;  list-style: none;}
			ul#icons span.ui-icon {float: left; margin: 0 4px;}
</style>

<script type="text/javascript">
$(function() {
	
				
	$("#gridTable").jqGrid({
			
		url: '<%= path %>' + '/commonListServlet?classNameId=fileList&isPage=false',
		//jqGrid控件通过这个参数得到需要显示的数据，具体的返回值可以使XML也可以是Json
		datatype: "json",
		//这个参数用于设定将要得到的数据类型。我最常用的是“json”，其余的类型还包括：xml、xmlstring、local、javascript、function
		mtype: "POST",
		//定义使用哪种方法发起请求，GET或者POST
		height: "100%",
		//Grid的高度，可以接受数字、%值、auto，默认值为150
		//width: 300, //Grid的宽度，如果未设置，则宽度应为所有列宽的之和；如果设置了宽度，则每列的宽度将会根据shrinkToFit选项的设置，进行设置。
		//shrinkToFit ：true 此选项用于根据width计算每列宽度的算法。默认值为true。如果shrinkToFit为true且设置了width值，则每列宽度会根据width成比例缩放；如果shrinkToFit为false且设置了width值，则每列的宽度不会成比例缩放，而是保持原有设置，而Grid将会有水平滚动条
		autowidth: true,
		//默认值为false。如果设为true，则Grid的宽度会根据父容器的宽度自动重算。重算仅发生在Grid初始化的阶段；如果当父容器尺寸变化了，同时也需要变化Grid的尺寸的话，则需要在自己的代码中调用setGridWidth方法来完成。
		colNames: ['材料ID', '文件名称 ', '添加时间 ', '文件类型 ', '下载 '],
		//字符串数组，用于指定各列的题头文本，与列的顺序是对应的。
		colModel: [ //最重要的数组之一，用于设定各列的参数
		{
			name: 'djsn',
			index: 'djsn',
			width: 20,
			hidden: true
		},
		{
			name: 'filename',
			index: 'filename',
			width: 150,
			editable: true
		},
		{
			name: 'create_date',
			index: 'create_date',
			width: 80,
			search: true
		},
		{
			name: 'extend',
			index: 'extend',
			width: 40,
			search: true
		},
		{
			name: 'act',
			index: 'act',
			width: 67,
			search: false,
			sortable: false,
			editable: false
		}],
		sortname: 'last_updatetime',
		//指定默认的排序列，可以是列名也可以是数字。此参数会在被传递到Server端。

		sortorder: 'desc',
		viewrecords: true,
		//设置是否在Pager Bar显示所有记录的总数。
		rowNum: 10,
		//用于设置Grid中一次显示的行数，默认值为20。正是这个选项将参数rows（prmNames中设置的）通过url选项设置的链接传递到Server。注意如果Server返回的数据行数超过了rowNum的设定，则Grid也只显示rowNum设定的行数。
		rowList: [10, 20, 30],
		//一个数组，用于设置Grid可以接受的rowNum值。例如[10,20,30]
		gridComplete: function() { // var idss=jQuery("#gridTable").jqGrid('getColNames');
			// alert(idss);
			var ids = $("#gridTable").getDataIDs(); //jqGrid('getDataIDs');
			for (var i = 0; i < ids.length; i++) {
				var cl = ids[i];
				be = "<button id='modify' class='ui-button ui-button-text-only ui-widget ui-state-default ui-corner-all' onclick='downFile(" + cl + ")'>" + 
				     "<span class='ui-button-text'>下载</span>" +
					 "</button> ";
					if('<%=lookfj %>'=='ok'){
						ce = "";
					}else{
					ce = "<button id='delid' class='ui-button ui-button-text-only ui-widget ui-state-default ui-corner-all' onclick='delFile(" + cl + ")'>" + 
				     "<span class='ui-button-text'>删除</span>" +
					 "</button> ";
					}
				//be = "<input  type='button' value='编辑' onclick='updateUser(" + cl + ")'/>";
				//ce = "<input type='button' value='删除' onclick='delUser(" + cl + ")'/>";
				jQuery("#gridTable").jqGrid('setRowData', ids[i], {
					act: be + ce
				});
			}
		},
		jsonReader: { //这又是一个数组，用来设定如何解析从Server端发回来的json数据
			repeatitems: false
		},
		//pager: "#gridPager",
		//定义页码控制条Page Bar
		//caption: "jqGrid与Servlet集成",
		//设置Grid表格的标题，如果未设置，则标题区域不显示。
		search : toUserParamJosn(),
		prmNames: { //这是一个数组，用于设置jqGrid将要向Server传递的参数名称
			rows: "rows",
			//表示请求行数的参数名称  
			sort: "sidx",
			//表示用于排序的列名的参数名称  
			order: "sord",
			//表示采用的排序方式的参数名称 
			search: "search"
			
		}, 
		//multiselect: true,
		//
		ondblClickRow: function(id) {
			//updateUser(id);
		}
	}).navGrid('#gridPager', {
		edit: false,
		add: false,
		del: false
	}); //.navButtonAdd('#gridPager',{position:'first',title:'导出为Excel文件',caption:'',onClickButton:exportCsv});
	
	//$("input:submit, a, button", ".demo" ).button();
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
	var str = "{'buessid':'<%=buessid%>'}";
	return descape(str);
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
	 函数:  resetSingleSearchDialog
	 说明:  清空值查询值
	 参数:   无
	 返回值: 无
	 */
var resetSingleSearchDialog = function() { //$("radio","#singleSearchDialog").attr("checked", false);  
	$(":text", "#queryTable").val("");
};

/*
	 函数:  downFile
	 说明:  添加用户
	 参数:   无
	 返回值: 无
	 */
var downFile = function(id) {
	var model = jQuery("#gridTable").jqGrid('getRowData', id);
	var url = "download.jsp?djsn=" + model.djsn;
	location.href = url;
}

/*
	 函数:  updateUser
	 说明:  删除用户
	 参数:   无
	 返回值: 无
	 */
var delFile = function(id) {
	var model = jQuery("#gridTable").jqGrid('getRowData', id);

	if (!confirm("确定要删除文件吗？")) {
		return;
	}
	var fm = document.getElementById("delForm");
	fm.action = "filedel.jsp?djsn=" + model.djsn + "&buessid=<%=buessid%>";
	fm.target = "hiddenFrame";
	fm.submit();

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
</script>
<body>
<div class="demo">
	</div>
	<table width="100%" id="gridTable"></table>
	<!-- <div width="100%" id="gridPager"></div> -->
	<form id="delForm" name="delForm" method="post" >
</form>
<iframe name="hiddenFrame" width=0 height=0></iframe>
</body>

</html>
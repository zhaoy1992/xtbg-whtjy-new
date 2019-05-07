<%@page import="java.util.Iterator"%>
<%@page import="com.chinacreator.xtbg.wangcheng.virtualappmanager.service.impl.AppStoreServiceImpl"%>
<%@page import="com.chinacreator.xtbg.wangcheng.virtualappmanager.service.AppStoreServiceIfc"%>
<%@page import="java.util.HashMap"%>
<%@ page contentType="text/html; charset=utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
	String path = request.getContextPath();
	AppStoreServiceIfc service = new AppStoreServiceImpl();
	//获取应用类别
	HashMap<String, String> appTypeMap = service.getAppTypeMap();
	if (appTypeMap == null) {
		appTypeMap = new HashMap<String, String>();
	}
%>
<title>JGRID</title>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script src="../../../resources/js/util/public.js" type="text/javascript"></script>
<script src="../../../resources/js/common/commoncss.js" type="text/javascript"></script>
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
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>

	

<script type="text/javascript">
$(function() {
		$(document).keydown(function(){
		if(event.keyCode == 13){
		   appStoreSearch();
		}
	});
	$("#gridTable").jqGrid({
		url: '<%=path%>' + '/commonListServlet?classNameId=wc_appstorelist',  //commonListServlet列表公共的servlet,classNameId在servletBean.xml文件中配置要调用的类,isPage:是否翻页(true,false),默认为true
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
		colNames: ['应用ID', '应用名称 ','应用编码 ', '应用类别 ', '最后更新时间 '],
		//字符串数组，用于指定各列的题头文本，与列的顺序是对应的。
		colModel: [ //最重要的数组之一，用于设定各列的参数
		{
			name: 'appid',
			index: 'appid',
			hidden: true
		},
		{
			name: 'name',
			index: 'name',
			width: 180,
			search: true,
			editable: true
		},
		/* {
			name: 'img',
			index: 'img',
			width: 230,
			search: true
		}, */
		/* {
			name: 'description',
			index: 'description',
			search: true
		}, */
		/* {
			name: 'classname',
			index: 'classname',
			search: true
		}, */
		{
			name: 'applocation',
			index: 'applocation',
			search: true
		}, 
		{
			name: 'apptype',
			index: 'apptype'
		},
		{
			name: 'lastupdatetime',
			index: 'lastupdatetime',
			formatter:'date',formatoptions: {newformat:'Y-m-d'}
		},
		],
		sortname: 'lastupdatetime',
		//指定默认的排序列，可以是列名也可以是数字。此参数会在被传递到Server端。
		sortorder: 'desc',
		viewrecords: true,
		
		//设置是否在Pager Bar显示所有记录的总数。
		rowNum: 15,
		//用于设置Grid中一次显示的行数，默认值为20。正是这个选项将参数rows（prmNames中设置的）通过url选项设置的链接传递到Server。注意如果Server返回的数据行数超过了rowNum的设定，则Grid也只显示rowNum设定的行数。
		rowList: [10, 20, 30],
		//一个数组，用于设置Grid可以接受的rowNum值。例如[10,20,30]
		gridComplete: function() { // var idss=jQuery("#gridTable").jqGrid('getColNames');
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
		//caption: "应用商店管理",
		//设置Grid表格的标题，如果未设置，则标题区域不显示。
		search : toAppStoreParamJosn(),
		prmNames: { //这是一个数组，用于设置jqGrid将要向Server传递的参数名称
			rows: "rows",
			//表示请求行数的参数名称  
			sort: "sidx",
			//表示用于排序的列名的参数名称  
			order: "sord",
			//表示采用的排序方式的参数名称 
			search : "search"
		},
		toolbar: [true,"top","<input class='but_y_01' id='add' type='button' onclick='addAppStore()' value='新增'/><input class='but_y_01' id='del' type='button' value='删除' onclick='delAppStore()'/>"],
		multiselect: true,
		ondblClickRow: function(id) {
			updateAppStore(id);
		}
	}).navGrid('#gridPager', {
		edit: false,
		add: false,
		del: false,
		search: false,
		refresh:false
	});
	
	
	//$("#t_gridTable").append("<input class='add' id='add' type='button' onclick='addAppStore()' value='添加'/><input class='del' id=del type='button' onclick='delAppStore()' value='删除'/>");
	
	$("#userReName").datepicker({
		showOn: "button",
		buttonImage: "../../../resources/plug/jquery-ui-1.8.17.custom/development-bundle/demos/images/calendar.gif",
		buttonImageOnly: true,
		dateFormat:"yy-mm-dd"
	});
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
	 函数:  toAppStoreParamJosn
	 说明:  构建要查询的参数
	 参数:   无
	 返回值: 返回要查询的参数
	 */
var toAppStoreParamJosn = function() {
	var str = "{'name':'" + $("#name").val() + "','apptype':'" + $("#apptype").val() + "'}";
	return descape(escape(str));
}

/*
	 函数:  appStoreSearch
	 说明:  查询应用信息
	 参数:   无
	 返回值: 应用列表
	 */
var appStoreSearch = function() {
	var sdata = { //构建查询需要的参数 
		paramJson: toAppStoreParamJosn()
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
	document.getElementById("apptype").options[0].selected = true;
};

/*
	 函数:  addAppStore
	 说明:  添加用户
	 参数:   无
	 返回值: 无
	 */
var addAppStore = function() {
	openWindows('addAppStore','添加应用','../../../wangcheng/virtualappmanager/jsp/addorupdateappstore.jsp?subid=addAppStore','appstorelist',false,window);
	//openAlertWindows('windowId','../../../wangcheng/virtualappmanager/jsp/addorupdateappstore.jsp?subid=appstorelist','添加应用',800,300,'20%','20%');
	//JqueryDialog.Open1('添加应用', 'addorupdateappstore.jsp', 500, 260, true, true, true);
	
}

/*
	 函数:  updateAppStore
	 说明:  修改用户
	 参数:   无
	 返回值: 无
	 */
var updateAppStore = function(id) {
	var model = jQuery("#gridTable").jqGrid('getRowData', id);
	openWindows('updateAppStore','修改应用','../../../wangcheng/virtualappmanager/jsp/addorupdateappstore.jsp?subid=updateAppStore&appid=' + model.appid,false,window);
	//openAlertWindows('windowId','../../../wangcheng/virtualappmanager/jsp/addorupdateappstore.jsp?subid=appstorelist&appid=' + model.appid,'修改应用',800,300,'20%','20%');
	//JqueryDialog.Open('修改应用', 'addorupdateappstore.jsp?appid=' + model.appid, 500, 260, true, true, true);
}

/*
	 函数:  delAppStore
	 说明:  删除用户
	 参数:   无
	 返回值: 无
	 */
var delAppStore = function(id) {
	var ids = "";
	var selectedIds = $("#gridTable").jqGrid("getGridParam", "selarrrow");
	for(var i = 0; i < selectedIds.length; i++) {
		var model = jQuery("#gridTable").jqGrid('getRowData', selectedIds[i]);
		 if("" != ids){			   
			ids += ",";
		 }
		 ids += "'"+model.appid+"'";
		 
	}
	if (IsSpace(ids)) {
		alert("请选择要删除的记录！");
	} else {
		if (!confirm("确定要删除吗？")) {
			return;
		}
		$("#appIds").val(ids);
		var fm = document.getElementById("delForm");
		fm.target = "hiddenFrame";
		fm.submit();
	}
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
		<table width="100%" id="queryTable">
			<tr>
				<td>
					<!-- 查询条件选区    tabs_search_ctable(查询table样式) -->
					<table width="100%" border="0" cellspacing="0" cellpadding="0"
						class="tabs_search_ctable_box">
						<tr>
							<td>
								<!-- 固定查询 -->
								<table width="100%" border="0" cellspacing="0" cellpadding="0"
									class="tabs_search_ctable">
									<tr>
										<th width="90" class="input_cx_title_th">
											应用名称：
										</th>
										<td width="150" class="cx_title_td">
											<input name="name" id="name" type="text" style="width:200px;"
												class="input_cx_title_283" />
										</td>
										
										<th width="90" class="input_cx_title_th">
											应用类别：
										</th>
										<td width="180" class="cx_title_td">
											<select id="apptype" name="apptype" >
												<option value="00">
													--请选择--
												</option>
												<%
													Iterator<String> typeit = appTypeMap.keySet().iterator();
													while (typeit.hasNext()) {
														String keyname = typeit.next();
														String keyvalue = appTypeMap.get(keyname);
												%>
												<option value="<%=keyname%>"><%=keyvalue%></option>
												<%
													}
												%>
											</select>
										</td>
										<td width="385" colspan="2">
											<input name="search" value="搜索" type="button"
												onclick="appStoreSearch()" class="but_y_01" />
											<input name="reset" value="重置" type="button"
												onclick="clearSearch()" class="but_y_01" />
										</td>
									</tr>
								</table>
								<!-- 固定查询 end-->
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
		<form id="delForm" name="delForm" method="post"
			action="../../../wangcheng/virtualappmanager/jsp/addorupdateappstoredo.jsp">
			<input type="hidden" name="appIds" id="appIds" />
			<input type="hidden" name="action" value="del" />
		</form>
		<iframe name="hiddenFrame" width=0 height=0></iframe>
	</body>
</html>
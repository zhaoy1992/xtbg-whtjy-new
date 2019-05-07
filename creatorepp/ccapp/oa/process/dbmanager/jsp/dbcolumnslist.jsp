<%--
　　描述：数据元字段表维护页面
　　作者：黄海
　　版本：1.0
　　日期：2013-6-5
--%>
<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DaoUtil"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%
AccessControl accesscontroler = AccessControl.getAccessControl();
accesscontroler.checkAccess(request, response);
String path = request.getContextPath();
String table_id = request.getParameter("table_id");
String table_code = request.getParameter("table_code");
%>
<meta>
<title>数据元字段表列表</title>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery1.7/jquery-1.7.1.min.js"></script>
<script src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>
<script src="../../../resources/plug/jquery.jqGrid-4.3.1/js/i18n/grid.locale-en.js" type="text/javascript"></script>
<script src="../../../resources/plug/jquery.jqGrid-4.3.1/js/jquery.jqGrid.min.js" type="text/javascript"></script>
<!-- 引入其它 -->
<script src="../../../resources/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js" ></script>
<script type="text/javascript">
/*
	配置jqGrid，显示数据元字段表列表
*/
$(function() {
	$("#gridTable").jqGrid({
		url: '<%= path %>' + '/pubListServlet?classNameId=com.chinacreator.xtbg.core.process.dbmanager.list.MdColumnsList',//pubListServlet列表公共的servlet,classNameId在servletBean.xml文件中配置要调用的类,isPage:是否翻页(true,false),默认为true
		datatype: "json",
		mtype: "POST",
		pageCached:false,
		height: "100%",//270
		autowidth: true,
		colNames: ['表ID','表名','列id', '是否主键', '字段名称 ', '字段全名','字段类型','排序号','长度','可为空'],
		colModel: [ //最重要的数组之一，用于设定各列的参数
		{
			name: 'table_id',
			index: 'table_id',
			width: 50,
			hidden:true
		},
		{
			name: 'table_name',
			index: 'table_name',
			width: 50,
			hidden:true	
		},
		{
			name: 'column_id',
			index: 'column_id',
			width: 50,
			hidden:true
		},
		{
			name: 'ispk',
			index: 'ispk',
			width: 25,
			sortable: true
		},
		{
			name: 'column_code',
			index: 'column_code',
			width: 80,
			sortable: true
		},
		{
			name: 'column_name',
			index: 'column_name',
			width: 80,
			sortable: true
		},
		{
			name: 'data_type',
			index: 'data_type',
			width: 80,
			sortable: true
		},
		{
			name: 'column_sn',
			index: 'column_sn',
			width: 30,
			sortable: true
		},
		{
			name: 'data_length',
			index: 'data_length',
			width: 25,
			sortable: true
		},
		{
			name: 'nullable',
			index: 'nullable',
			width: 25,
			sortable: true
		}
		],
		sortname: 'column_code',
		sortorder: 'desc',
		viewrecords: true,
		rowNum: 10,
		rowList: [10, 20, 30],
		gridComplete: function() {
		},
		jsonReader: { //这又是一个数组，用来设定如何解析从Server端发回来的json数据
			repeatitems: false
		},
		onCellSelect:function (id,icol)
		{
			if(icol != 0)
			{
				modifyMdColumns();
			}
		},
		pagerintoolbar:true,//上面的分页条
		pagerinBottombar:true,//下面的分页条
		search : convertParamJson(),
		prmNames: { //这是一个数组，用于设置jqGrid将要向Server传递的参数名称
			rows: "rows",
			sort: "sidx",
			order: "sord",
			search : "search"
		},
		toolbar: [true,"top","<input class='but_y_01' id=add type='button' onclick='insertMdColumns()' value='新增字段'/><input class='but_y_01' id=del type='button' onclick='deleteMdColumns()' value='删除字段'/>"],
		multiselect: true
	}).navGrid('#gridPager', {
		edit: false,
		add: false,
		del: false,
		search : false,
		refresh : false
	});
});


/*
	 函数:  convertParamJson
	 说明:  构建要查询的参数
	 参数:   无
	 返回值: 返回要查询的参数
*/
var convertParamJson = function() {
	var table_id = "<%=table_id%>";
	var str = "{'table_id':'"+table_id+"'}";
	return descape(str);
}
/*
	函数:  refreshGrid
	说明:  静态加载列表数据，主要供子页面调用和删除字段后调用
	参数:   无
*/
function refreshGrid(){
	var sdata = { //构建查询需要的参数 
		paramJson: convertParamJson()
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
	函数:  deleteMdColumns
	说明:  删除字段
	特别注意：这个判断暂时不要删除，由于drop 不能回滚，
	实现批量删除可是可以，但有一定风险。故前期删除列时每次只能处理一条  
	hai.huang 2013-06-06
*/
var deleteMdColumns = function() {
	var selectedIds = $("#gridTable").jqGrid("getGridParam", "selarrrow");
	if (selectedIds.length>1){
        alert("每次只能操作一条记录！");
        return;
    }else if (selectedIds.length==0){
    	alert("请选择要删除的记录！");
        return;
    }else{
    	var model = jQuery("#gridTable").jqGrid('getRowData', selectedIds[0]);
    	var jsonparam = "{" + 
    						"'column_id':'" + model.column_id + "'," + 
    						"'column_code':'" + model.column_code + "'," + 
    						"'table_name':'" + model.table_name + "'" + 
   						"}";
		
		var okF = function(){
			var params = {
					mdColunmListData: descape(escape(jsonparam))
			};
			url="deletemdcolumns.jsp";
			$.ajax({
				url: url,
				type: 'POST',
				dataType: 'json',
				data: params,
				success: function(flag){
					if(flag){
						alert("操作成功！");
					}
					else{
						alert("操作失败！");
					}
					refreshGrid('');
				},
				error: function(jqXHR, textStatus, errorThrown){
					alert("error warning:"+textStatus);
					refreshGrid('');
				}
			});
		};
		var p={
				headerText:'提示',
				okName:'确认',
		        okFunction:okF,
		        cancelName:'取消'
		};
		alert("确定要删表字段吗？",p);
    }
};
/*
	函数:  insertMdColumns
	说明:  新增字段
*/
function insertMdColumns() {
	var table_id = $('#table_id').val();
	var table_code = $('#table_code').val();
	if(IsSpace(table_id)||IsSpace(table_code)){
		alert("对不起，请先在左边页面框中选取一张表！");
		return;
	}else{
		//getCurrentFilePath 定义于public.js内
	    var url = getCurrentFilePath()+"updatemdcolumnsform.jsp?updatetype=add&table_id="+table_id+"&table_code="+table_code;
	    openAlertWindows('windowId',url,'新增/修改表字段','810','220','20%');
	}
};
/*
	函数:  modifyMdColumns
	说明:  修改字段
*/
function modifyMdColumns() {
	var selectedIds = $("#gridTable").jqGrid("getGridParam", "selarrrow");
	if (selectedIds.length>1){
       alert("每次只能操作一条记录！");
       return;
    }else if (selectedIds.length==0){
    	alert("请选择要修改的记录！");
        return;
    }else{
   		//getCurrentFilePath 定义于public.js内
   		var model = jQuery("#gridTable").jqGrid('getRowData', selectedIds[0]);
	    var url = getCurrentFilePath()+"updatemdcolumnsform.jsp?column_id="+model.column_id+"&updatetype=edit&table_id="+model.table_id+"&table_code="+model.table_name;
	    openAlertWindows('windowId',url,'新增/修改表字段','810','220','20%');
    }
};


</script>
</head>
<body>
	<!-- 查询列表区 cGridArea(查询区样式)-->
	<div class="cGridArea">
		<table id="gridTable">
		</table>
		<div id="gridPager">
	</div>
	<input type="hidden" id="table_id"  name="table_id" value="<%=table_id %>" />
	<input type="hidden" id="table_code" name="table_code" value="<%=table_code %>" />
	</div>
	<!-- 查询列表区 -->
</body>
</html>

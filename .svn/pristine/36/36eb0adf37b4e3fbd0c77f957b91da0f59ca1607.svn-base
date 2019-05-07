<%--  
描述：数据源列表界面
作者：肖杰
版本：1.0
日期：2013-10-29
--%>
<%@ page language="java" contentType="text/html; charset=utf-8"  pageEncoding="utf-8"%>
<%@page import="com.chinacreator.xtbg.core.common.util.*"%>
<%@page import="java.util.*"%>
<%@page import="com.chinacreator.xtbg.core.task.entity.* "%>
<%@page import="com.chinacreator.xtbg.core.task.util.*"%>
<%
	String path = request.getContextPath();
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	String userId = accesscontroler.getUserID();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="com.chinacreator.security.AccessControl"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<!-- 引入jQuery -->
<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<!-- 引入jQuery UI -->
<script src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>
<!-- 引入jGrid -->
<script src="../../resources/plug/jquery.jqGrid-4.3.1/js/i18n/grid.locale-en.js" type="text/javascript"></script>
<script src="../../resources/plug/jquery.jqGrid-4.3.1/js/jquery.jqGrid.min.js" type="text/javascript"></script>

<!-- 引入其它 -->
<script src="../../resources/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>

<title>待办列表</title>
<script type="text/javascript">

$(function() {
	$("#gridTable").jqGrid({
	url: '<%= path %>' + '/pubListServlet?classNameId=com.chinacreator.xtbg.core.datasourcemanage.list.DatasourceList',  
	//jqGrid控件通过这个参数得到需要显示的数据，具体的返回值可以使XML也可以是Json
	datatype: "json",
	//这个参数用于设定将要得到的数据类型。我最常用的是“json”，其余的类型还包括：xml、xmlstring、local、javascript、function
	mtype: "POST",
	//定义使用哪种方法发起请求，GET或者POST
	height: "100%",//270
	//Grid的高度，可以接受数字、%值、auto，默认值为150
	autowidth: true,
	colModel: [ //最重要的数组之一，用于设定各列的参数
		{
			 label : '数据源名字 ',
			name: 'dbname',
			index: 'dbname',
			width: 150,
			editable: true
			
		},
		{
			label : '数据库驱动',
			name: 'driver',
			index: 'driver',
			width: 150,
		},{
            label : '数据库链接地址',
            name: 'url',
            index: 'url',
            width: 200,
            search: true
        },
		{
			label : '数据库用户名',
			name: 'username',
			index: 'username',
			width: 150
		}
	],
	sortname: '',
		
	//指定默认的排序列，可以是列名也可以是数字。此参数会在被传递到Server端。
	sortorder: '',
	
	viewrecords: true,
	
	//设置是否在Pager Bar显示所有记录的总数。
	rowNum: 10,
	jsonReader: { //这又是一个数组，用来设定如何解析从Server端发回来的json数据
		repeatitems: false
	},
	//pager: "#gridPager",
	pagerintoolbar:true,//上面的分页条
	pagerinBottombar:true,//下面的分页条
	search : toParamJosn(),
	caption: "",	
	prmNames: { //这是一个数组，用于设置jqGrid将要向Server传递的参数名称
		rows: "rows",
		//表示请求行数的参数名称  
		sort: "sidx",
		//表示用于排序的列名的参数名称  
		order: "sord",
		//表示采用的排序方式的参数名称 
		search : "search"
	},
	toolbar: [true,"top","<input class='but_y_01' id='add' type='button' onclick='createDatasource()' value='添加'/><input class='but_y_01' id='deletebutton' type='button' onclick='delDatasource();' value='删除'/>"],
	multiselect: true,
	onCellSelect:function(id,iCol){
		if(iCol != 0 )
		{
			updateDatasource(id);
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
函数:  toBriefsParamJosn
说明:  构建要查询的参数
参数:   无
返回值: 返回要查询的参数
*/
var toParamJosn = function(){
	
	return descape(escape(""));
}

/*
函数:  StringCheck
说明:  做查询时通配符处理问题
参数:   obj 文本框上获得的值
返回值: 返回转换后的值
*/
var StringCheck = function(obj){
    return obj.replaceAll('%','---').replaceAll("'","’").replaceAll(":","：");
}

/*
函数:  briefsSearch
说明:  查询信息
参数:   无
返回值: 列表
*/
var paremSearch = function() {
	var sdata = { //构建查询需要的参数 
		paramJson : toParamJosn()
	}; //获得当前postData选项的值  
	var postData = $("#gridTable").jqGrid("getGridParam", "postData"); //将查询参数融入postData选项对象  
	$.extend(postData, sdata);
	$("#gridTable").jqGrid("setGridParam", {
		search : true
	// 将jqGrid的search选项设为true  
	}).trigger("reloadGrid", [ {
		page : 1
	} ]); //重新载入Grid表格，以使上述设置生效 
	 }

	/*
		 函数:  createDatasource
		 说明:  添加
		 参数:   无
		 返回值: 无
		 */
	function createDatasource(){
		openAlertWindows('addWindow', '<%=path%>/ccapp/oa/datasourcemanage/jsp/datasourceinfo.jsp?isEdit=add&subid=addWindow', '添加' ,1020,650,'10%','10%');
	}

	/*
		 函数:  updateDatasource
		 说明:  修改信息
		 参数:   无
		 返回值: 无
		 */
	var updateDatasource = function(id) {
			var model = jQuery("#gridTable").jqGrid('getRowData', id);			
			var url = '<%=path%>/ccapp/oa/datasourcemanage/jsp/datasourceinfo.jsp?subid=updateWindow&isEdit=modify&dbname='+model.dbname;
			openAlertWindows('updateWindow', url, '修改' ,1020,650,'10%','10%');
	}

	
	/*
	    函数:  del
	   说明:  删除
	   参数:  无
	   返回值: 无
	*/
	var delDatasource = function() {
	    var ids = "";
	    var selectedIds = $("#gridTable").jqGrid("getGridParam", "selarrrow");
	    var ids = new Array();
	    $(selectedIds).each(function () {
	        var model = jQuery("#gridTable").jqGrid('getRowData', this);
	        //id不为空
	        ids.push(model.dbname);  
	    });
	        
	    if (!ids.length) {
	        alert("未选中数据，请重新选择要删除的数据！");
	    } else {
	        var okF = function(){
	        	jQuery("#ids").val(ids);
	        	document.all.delForm.target = "hiddenFrame";
				jQuery("#delForm").submit();
	        }
	        var p={
	                    headerText:'提示',
	                    okName:'确认',
	                    okFunction:okF,
	                    cancelName:'取消'
	            };
	        alert("删除后将不能恢复，确定删除吗？",p); 
	    }
	}

</script>
</head>
<body>
<form id="form1" name="form1" method="post" action="">	
		
<input type="hidden" name="testid" id="testid"> 
<table width="100%" id="queryTable">
	<tr>
		<td>
			
		<!-- 查询列表区[开始]-->
		<div class="cGridArea">
			<table id="gridTable"></table>
			<div id="gridPager"></div>
		</div>
		<iframe name="hiddenFrame" width=0 height=0></iframe>
	</td>
	</tr>
</table>
	</form>
	<form id="delForm" name="delForm" method="post" action="datasourcedel.jsp?isEdit=del">
	<input type="hidden" name="ids" id="ids"> 
	</form>	
</body>
</html>
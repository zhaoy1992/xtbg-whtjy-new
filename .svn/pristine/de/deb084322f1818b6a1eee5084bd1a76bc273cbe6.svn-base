<%@page import="com.chinacreator.xtbg.util.DictDropDownList"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%@page import="com.chinacreator.xtbg.util.*"%>
     <%@page import="java.util.*"%>
    <%@page import="com.chinacreator.xtbg.joblog.dao.imploracle.JobTypeDaoImpl"%>
<%@page import="com.chinacreator.xtbg.joblog.dao.JobTypeDao"%>
<%@page import="com.chinacreator.xtbg.tasksassigned.entity.TasksAssignedBean "%>
<%@page import="com.chinacreator.xtbg.tasksassigned.entity.InfoSource"%>
<%
	String path = request.getContextPath();
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	JobTypeDao poeManagerdao = (JobTypeDao)DaoImplClassUtil.getDaoImplClass("jobTypeDaoImpl");
	String userid=accesscontroler.getUserID();
	// List<JoblogIntensiveBean> lst=poeManagerdao.getBriefsTypeBean();
	//String []type_id=jobtypebean.getType_id().split(",");\
	//System.out.println(accesscontroler.getUserID());
		TasksAssignedBean receivesetBean = new TasksAssignedBean();
		String sql = "select i.type_id, i.type_name from ta_oa_tasksassigned_type i where i.type_sort = '"+InfoSource.INFORMATION_DEGREE+"'";
		String sql1 = "select i.type_id, i.type_name from ta_oa_tasksassigned_type i where i.type_sort = '"+InfoSource.INFORMATION_RELEASE+"'";
		String sql2 = "select i.type_id, i.type_name from ta_oa_tasksassigned_type i where i.type_sort = '"+InfoSource.INFORMATION_TYPE+"'";
		String infotypeHtml2="";
		String infotypeHtml="";
	String infotypeHtml1="";
	sql = "select i.type_id, i.type_name from ta_oa_tasksassigned_type i where i.type_sort = '"+InfoSource.INFORMATION_DEGREE+"'";
		
		infotypeHtml = DictDropDownList.buildSelect(sql,"tasksdegree","","",true,"");//信息类型下拉框
sql1 = "select i.type_id, i.type_name from ta_oa_tasksassigned_type i where i.type_sort = '"+InfoSource.INFORMATION_RELEASE+"'";
		
		infotypeHtml1 = DictDropDownList.buildSelect(sql1,"tasksrelease","","",true,"");//信息类型下拉框\
sql2 = "select i.type_id, i.type_name from ta_oa_tasksassigned_type i where i.type_sort = '"+InfoSource.INFORMATION_TYPE+"'";
		
		infotypeHtml2 = DictDropDownList.buildSelect(sql2,"taskstype","","",true,"");//信息类型下拉框
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="com.chinacreator.security.AccessControl"%><html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

<!-- 引入jQuery -->
<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>

<!-- 引入jQuery UI -->
<link id="uiThemes" rel="stylesheet" type="text/css" media="screen" href="../../resources/plug/jquery-ui-1.8.17.custom/css/custom-theme/jquery-ui-1.8.17.custom.css" />
<script src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>

<!-- 引入my97时间控件 -->
<script src="../../resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>

<!-- 引入jGrid -->
<link rel="stylesheet" type="text/css" media="screen" href="../../resources/plug/jquery.jqGrid-4.3.1/css/ui.jqgrid.css" />
<script src="../../resources/plug/jquery.jqGrid-4.3.1/js/i18n/grid.locale-en.js" type="text/javascript"></script>
<script src="../../resources/plug/jquery.jqGrid-4.3.1/js/jquery.jqGrid.min.js" type="text/javascript"></script>

<!-- 引入其它 -->
<script src="../../resources/js/util/public.js" type="text/javascript"></script>
<script src="../../resources/js/common/commoncss.js" type="text/javascript"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js"charset="utf-8"></script>
<!--公共部分结束  -->
<title>待办列表</title>
<script type="text/javascript">



var gridTableObj;			//gridtable对象;
var gridPagerObj;			//gridpager对象;
var t_gridTableObj ;			//t_gridtable对象;	
var queryTableString; 	//queryTable字串
var jQuery_gridTableObj ;


$(function() {
	$(document).keydown(function(){
		if(event.keyCode == 13){ 
			tasksAssignedSearch();
		}
	});
	$( "#tabs" ).tabs(); 
	$("#gridTable").jqGrid({
	url: '<%= path %>' + '/commonListServlet?classNameId=myTasksList',   //commonListServlet列表公共的servlet,classNameId在servletBean.xml文件中配置要调用的类,isPage:是否翻页(true,false),默认为true
	//jqGrid控件通过这个参数得到需要显示的数据，具体的返回值可以使XML也可以是Json
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
		
		colNames: ['负责人id', '任务名称 ', '重要程度','任务状态','开始时间','结束时间','负责人','ID'],
		//字符串数组，用于指定各列的题头文本，与列的顺序是对应的。
		colModel: [ //最重要的数组之一，用于设定各列的参数
		 { 
		   	name: 'user_id',
		   	index: 'user_id',
		   	hidden: true
		 },
		{
			name: 'task_name',
			index: 'task_name',
			width: 350,
			editable: true
		},
	
		{
			name: 'degree_of_importance',
			index: 'degree_of_importance',
			width: 60
			//hidden: true
		},
		{
			name: 'type_name',
			index: 'type_name',
			width: 60,
			search: true
		},
		
		{
			name: 'start_time',
			index: 'start_time',
			//hidden: true
			width: 100
		},
		{
			name: 'end_time',
			index: 'end_time',
			//hidden: true
			width: 100
		},
		{
			name: 'user_name',
			index: 'user_name',
			//hidden: true
			width: 60
		},
		{  
			name: 'tasks_id',
			index: 'tasks_id',
			hidden: true
		}
		],
		sortname: 'start_time',
		
	//指定默认的排序列，可以是列名也可以是数字。此参数会在被传递到Server端。
	sortorder: 'desc',
	viewrecords: true,
	
	//设置是否在Pager Bar显示所有记录的总数。
	rowNum: 10,
	//用于设置Grid中一次显示的行数，默认值为20。正是这个选项将参数rows（prmNames中设置的）通过url选项设置的链接传递到Server。注意如果Server返回的数据行数超过了rowNum的设定，则Grid也只显示rowNum设定的行数。
	rowList: [10, 20, 30],
	gridComplete: function() { // var idss=jQuery("#gridTable").jqGrid('getColNames');
		var ids = $("#gridTable").getDataIDs(); //jqGrid('getDataIDs');
		
	},
	//一个数组，用于设置Grid可以接受的rowNum值。例如[10,20,30]
	jsonReader: { //这又是一个数组，用来设定如何解析从Server端发回来的json数据
		repeatitems: false
	},
	//pager: "#gridPager",
	pagerintoolbar:true,//上面的分页条
	pagerinBottombar:true,//下面的分页条
	search : toTasksParamJosn(),
	caption: "",
	
	//定义页码控制条Page Bar
	//caption: "缓急列表",
	//设置Grid表格的标题，如果未设置，则标题区域不显示。
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
	multiselect:false,
	onCellSelect:function(id,iCol){
		if(iCol != 0 )
		{
			updateInfo(id);
		}
	}
}).navGrid('#gridPager', {
	edit: false,
	add: false,
	del: false,
	refresh: false,
	search: false
});

$("#t_gridTable").append("<div>")

.append("</div>");
});
/*
函数:  toBriefsParamJosn
说明:  构建要查询的参数
参数:   无
返回值: 返回要查询的参数
*/
var toTasksParamJosn = function() {
	
	//alert( $("#tasksrelease").val() );
	var str = "{'status':'6','users':'"+<%=accesscontroler.getUserID()%>+ "','orgid':'<%=accesscontroler.getChargeOrgId()%>'}";
		
		
	return descape(escape(str));
}

/*
函数:  briefsSearch
说明:  查询信息
参数:   无
返回值: 列表
*/
var tasksAssignedSearch = function() {
	var sdata = { //构建查询需要的参数 
		paramJson : toTasksParamJosn()
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
		 函数:  addInfo
		 说明:  添加信息
		 参数:   无
		 返回值: 无
		 */
	var addInfo = function() {
				//JqueryDialog.Open1('添加信息', 'addtasks.jsp', 800, 450, true, true, true);
		var url = 'addtasks.jsp?type=0';
		location.href = url;	
	}

	/*
		 函数:  updateInfo
		 说明:  修改信息
		 参数:   无
		 返回值: 无
		 */
	var updateInfo = function(id) {
		var model = jQuery("#gridTable").jqGrid('getRowData', id);
		var type_name = model.type_name;
		if(type_name =="已完成")
		{
			type_name = "8"
			var url = '../../tasksassigned/jsp/addmytasks.jsp?tasks_id='+model.tasks_id+'&user_id='+model.user_id+'&operwindowid=sub_addmytaske'+model.tasks_id+"&type_name="+type_name;
			openWindows('sub_addmytaske'+model.tasks_id,'汇报我的任务',url,'wdjbrw',false,window);
		}else
		{
		var url = '../../tasksassigned/jsp/addmytasks.jsp?tasks_id='+model.tasks_id+'&user_id='+model.user_id+'&operwindowid=sub_addmytaske'+model.tasks_id;
		openWindows('sub_addmytaske'+model.tasks_id,'汇报我的任务',url,'wdjbrw',false,window);
		}
		//location.href = url;
	}

	
	/*
		 函数:  delInfo
		 说明:  删除信息
		 参数:   无
		 返回值: 无
		 */
	var delInfo = function(id) {
			 //alert(isusetheperiodicalnum());
		var ids = "";
		var user_ids="";
		var selectedIds = $("#gridTable").jqGrid("getGridParam", "selarrrow");
		for ( var i = 0; i < selectedIds.length; i++) {
			var model = jQuery("#gridTable").jqGrid('getRowData',
					selectedIds[i]);
			if ("" != ids) {
				ids += ",";
			}
			if ("" != user_ids) {
				user_ids += ",";
			}
			ids += "'" + model.tasks_id + "'";
		    user_ids +="'" +model.user_id+ "'";

		}
		if (IsSpace(ids)) {
			alert("请选择要删除的记录！");
		} 
		else{
			$("#Ids").val(ids);
			$("#userIds").val(user_ids);
			//var fm = document.getElementById("delForm");
			  var url = "taskseditordrewdo.jsp";
			 	document.all.delForm.action = url;
				document.all.delForm.target = "hiddenFrame";
			//fm.target = "hiddenFrame";
			$("#delForm").submit();
		}
			
		
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
				paramJson: toTasksParamJosn()
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
	$(":hidden", "#queryTable").val("");
	$("select").each(function(){
		$(this).find("option:first").attr("selected","selected");
	})
};

window.onload = function () {
	setDataTimeClickShowOrHide('start_time',window);
	setDataTimeClickShowOrHide('end_time',window);
  }	
</script>
</head>
<body>
		<!-- 查询列表区[开始]-->
		<div class="cGridArea">
			<table id="gridTable"></table>
			<div id="gridPager"></div>
		</div>
</body>
</html>
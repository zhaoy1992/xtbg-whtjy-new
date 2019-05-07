<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DictDropDownList"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%
	String path = request.getContextPath();
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	
	String loginUserName = accesscontroler.getUserAccount();
	String subid = request.getParameter("subid");
	

%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<!-- 引入jQuery -->
<script type="text/javascript" src="../../resources/plug/jquery1.7/jquery-1.7.1.min.js"></script>

<script src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>


<!-- 引入my97时间控件 -->
<script src="../../resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>

<!-- 引入jGrid -->
<script src="../../resources/plug/jquery.jqGrid-4.3.1/js/i18n/grid.locale-en.js"
	type="text/javascript"></script>
<script src="../../resources/plug/jquery.jqGrid-4.3.1/js/jquery.jqGrid.min.js"
	type="text/javascript"></script>

<!-- 引入其它 -->
<script src="../../resources/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js" ></script>
<title>销毁清单</title>

<script type="text/javascript">
$(function() {
	$(document).keydown(function(){
		if(event.keyCode == 13){ 
			userSearch();
		}
	
	});
	$("#gridTable").jqGrid({
		url: '<%= path %>' + '/pubListServlet?classNameId=com.chinacreator.xtbg.core.file.list.FileInventoryList',  //pubListServlet列表公共的servlet,classNameId在servletBean.xml文件中配置要调用的类,isPage:是否翻页(true,false),默认为true
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
		colNames: ['id','ins_id','档号','文件编号','标题','批准人','销毁日期','doc_id','f_destroy_id'],
		//字符串数组，用于指定各列的题头文本，与列的顺序是对应的。
		colModel: [ //最重要的数组之一，用于设定各列的参数
         {
   			name: 'f_detail_id',
   			index: 'f_detail_id',
   			width: '50',
   			hidden: true},
         {
   			name: 'ins_id',
   			index: 'ins_id',
   			hidden: true},
         {
   			name: 'f_file_no',
   			index: 'f_file_no',
   			width: '30',
   		},
   		{
   			name: 'f_doc_num',
   			index: 'f_doc_num',
   			width: '10',
    	},
    	{
   			name: 'f_doc_name',
   			index: 'f_doc_name',
   			width: '40'
    	},
    	{
   			name: 'f_check_username',
   			index: 'f_check_username',
   			width: '10'
    	},
    	{
   			name: 'f_destroy_time',
   			index: 'f_destroy_time',
   			width: '10'
    	},
    	{
   			name: 'f_doc_id',
   			index: 'f_doc_id',
   			width: '20',
   			hidden: true
    	},
    	{
   			name: 'f_destroy_id',
   			index: 'f_destroy_id',
   			width: '20',
   			hidden: true
    	}
		],
		//sortname: 'last_updatetime',
		//指定默认的排序列，可以是列名也可以是数字。此参数会在被传递到Server端。
		sortname: 'f_file_no',
		sortorder: 'asc',
		viewrecords: true,
		
		//设置是否在Pager Bar显示所有记录的总数。
		rowNum: 10,
		//用于设置Grid中一次显示的行数，默认值为20。正是这个选项将参数rows（prmNames中设置的）通过url选项设置的链接传递到Server。注意如果Server返回的数据行数超过了rowNum的设定，则Grid也只显示rowNum设定的行数。
		rowList: [10, 20, 30],
		
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
		/*
		filterNames:["act_name"],
		filterOptions:[
		               [
		                ["xd","name"],[2,"page"],[3,"daf"]],//value text 后的值与显不
		                [
		                 ['王奎',"王奎"],["马坤","马坤"],["文电科","文电科"]
		                 ]
		               ],
		filterOptionsDefValue:[1,2],*/
		pagerintoolbar:true,//上面的分页条
		pagerinBottombar:true,//下面的分页条
		toolbar: [true,"top","<input type='button' value='恢复' class=\"but_y_01\" onclick=\"delFileProgram();\"/>"+
			"<input  type='button' value='导出' class=\"but_y_01\" onclick=\"exportExcel();\"/>"+
			"<input  type='button' value='审批单' class=\"but_y_01\" onclick=\"getfliowinfo();\"//>"],
		multiselect: true,
		onCellSelect:function(rowid,iCol){
			if(iCol>0){
				var model = jQuery("#gridTable").jqGrid('getRowData',rowid);
				handle(model.ins_id);
			}
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


/*
函数:  clearSearch
说明:  重置
参数:   无
返回值: 无
*/
var clearSearch = function() {
	jQuery("#title").val("");
	jQuery("#startSlTime").val("");
	jQuery("#endSlTime").val("");
	userSearch();
};

	/*
	 函数:  toUserParamJosn
	 说明:  构建要查询的参数
	 参数:   无
	 返回值: 返回要查询的参数
	 */
var toUserParamJosn = function() {
	var title = jQuery("#title").val();
	var startSlTime = jQuery("#startSlTime").val();
	var endSlTime = jQuery("#endSlTime").val();
	var str = "{'title':'"+title+"'";
	str += ",'stateime':'"+startSlTime+"'";
	str += ",'endtime':'"+endSlTime+"'";
	str += ",'jsp_type':'spz'";
	str += "}";
	return descape(escape(str));
}
/**
 * 恢复销毁的文件
 */
var delFileProgram = function() {
	 var ids = "";
		var selectedIds = $("#gridTable").jqGrid("getGridParam", "selarrrow");
		for ( var i = 0; i < selectedIds.length; i++) {
			var model = jQuery("#gridTable").jqGrid('getRowData',selectedIds[i]);
			if ("" != ids) {
				ids += ",";
			}
			ids += "'" + model.f_doc_id + "'";
		}		 
	if (IsSpace(ids)) {
		alert("请选择要恢复的文件！");
	} else {
		var okF = function(){	
			$("#f_doc_id").val(ids);
			var fm = document.getElementById("fhForm1");
			fm.target = "hiddenFrame";
			fm.submit();}
			var p={
					headerText:'提示',
					okName:'确认',
			        okFunction:okF,
			        cancelName:'取消'
			};
			alert("确定要恢复该文件吗？",p)
	}
}
	
function handle(id){   

	
}
//导出
var className="com.chinacreator.xtbg.core.file.entity.FileInventoryExport";
function exportExcel(){
			var url = getCurrentFilePath()+"/exportexcel.jsp?windowId=windowId_paperTJ"; 
		    var html = new Array();
		    if(jQuery("#hiddenFrame").size()==0){
				html.push('<iframe id="hiddenFrame"  name="hiddenFrame" width=0 height=0></iframe>');
			}
			if(jQuery("#downFrom").size()>0){
				jQuery("#downFrom").remove();
			}
		    
		    html.push('<form id="downFrom" name="downFrom" method="post" action="'+url+'" target="hiddenFrame">');
	       	html.push("<input type='hidden' name='className' value='"+className+"' /> ");
		    html.push('</form>');
		    //加载到body，提交后再删除
		    jQuery(html.join("")).appendTo("body").submit();
}

function getfliowinfo(){
	var model;
	var selectedIds = $("#gridTable").jqGrid("getGridParam", "selarrrow");
	var busid;
	var count = selectedIds.length;
	if(count==1){
		$(selectedIds).each(function () {
			model = jQuery("#gridTable").jqGrid('getRowData', this);
			if(!IsSpace(model.f_destroy_id)){
				busid=model.f_destroy_id;
			}
		});
	}else{
		alert("请选择一条数据进行操作!");
		return ;
	}
  	 window.location.href = "filedestroyflow.jsp?busi_id="+busid+"&ins_id="+model.ins_id+"&busiTypeCode=uuid-337&jsptype=false&operType=yiban&backurl=fileinventory.jsp";
}
</script>
</head>
<body>
<table width="100%">
	<tr>
		<td>
			<!-- 查询条件选区    tabs_search_ctable(查询table样式) -->
			<table border="0" cellspacing="0" cellpadding="0" class="tabs_search_ctable_box">
				<tr>
					<td>
						<!-- 固定查询 -->
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<th class="input_cx_title_th">标题：</th>
					    <td class="cx_title_td" >
					   	 <input id="title" name="title" style="width: 200px" type="text" class="input_cx_title_283" />
					    </td>
					    <th class="input_cx_title_th">销毁日期：</th>
						<td  class="cx_title_td">
							<input class="date_120 Wdate" type="text" id="startSlTime" name="startSlTime" onFocus="var input_endtime=$dp.$('endSlTime');WdatePicker({onpicked:function(){endSlTime.focus();},dateFmt:'yyyy-MM-dd '})" />
								<span class="date_120_span">至</span>
							<input class="date_120 Wdate" type="text" id="endSlTime" name="endSlTime" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'startSlTime\')}',dateFmt:'yyyy-MM-dd '})" />
						</td>
						
						<td  class="cx_title_td">
							<input value="搜索" type="button" onclick="userSearch()" class="but_y_01" />
	                    	<input value="重置" type="button" onclick="clearSearch()" class="but_y_01" />
						</td>
					</tr>
				</table>
						<!-- 固定查询 end-->
					</td>
					</tr>
			</table>
		<tr>
		<td>
		<!-- 查询列表区 cGridArea(查询区样式)-->
		<div class="cGridArea">
		<table id="gridTable"></table>
		<div id="gridPager"></div>
		</div>
		<!-- 查询列表区 -->
		<form id="fhForm1" name="fhForm1" method="post" action="fileinventorydo.jsp?subid=<%=subid%>">
			<input type="hidden" name="f_doc_id" id="f_doc_id" /> 
			<input type="hidden" name="action" id="action"value="giveback" />
		</form>
			<iframe name="hiddenFrame" width="0" height="0"></iframe>
		</td>
	</tr>
		
</table>
		

</body>
</html>
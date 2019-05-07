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
	String sql = "select i.busitype_code, i.busitype_name from OA_FLOW_BUSITYPE i where i.is_valid = 'Y' ";
	String str = DictDropDownList.buildSelect(sql,"busitype_code","","",true,"");
	String homepage  =request.getParameter("flag");
	String entrance = request.getParameter("entrance");
	String subid = request.getParameter("subid");
	
	//介质类型下拉框
	String sqltype = "select d.dictdata_value, d.dictdata_name from OA_DICT_DATA d, OA_DICT_TYPE t where t.dict_code = 'jzlx' and d.dict_id = t.dict_id and t.dict_is_valid = 1 and d.dictdata_is_valid = 1";
	String selectData = DictDropDownList.buildSelect(sqltype.toString(),"jzlx","","",true,"","");

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
<title>待办列表</title>

<script type="text/javascript">
var loginUserName = '<%=loginUserName%>';
$(function() {
	if('<%=entrance%>' == 'homepage')
	{
		$("#queryTable_search").hide();
	}
	$(document).keydown(function(){
		if(event.keyCode == 13){ 
			userSearch();
		}
	
	});
	$("#gridTable").jqGrid({
		url: '<%= path %>' + '/pubListServlet?classNameId=com.chinacreator.xtbg.core.file.list.FilelendingList',  //pubListServlet列表公共的servlet,classNameId在servletBean.xml文件中配置要调用的类,isPage:是否翻页(true,false),默认为true
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
		colNames: ['借阅详细ID','f_lending_type','f_doc_id','借阅类型','件号','档号','文件标题','应归还日期','借阅人','借阅人所属部门','借出日期','借出经手人','借阅ID'],
		//字符串数组，用于指定各列的题头文本，与列的顺序是对应的。
		colModel: [ //最重要的数组之一，用于设定各列的参数
         {
   			name: 'f_detail_id',
   			index: 'f_detail_id',
   			width: '100',
 			hidden: true
   		},
   		{
   			name: 'f_lending_type',
   			index: 'f_lending_type',
   			width: '20',
   			hidden: true
    	},
    	{
   			name: 'f_doc_id',
   			index: 'f_doc_id',
   			width: '20',
   			hidden: true
    	},
    	{
   			name: 'f_lending_type_name',
   			index: 'f_lending_type_name',
   			width: '20'
    	},
    	{
   			name: 'f_doc_num',
   			index: 'f_doc_num',
   			width: '20'
    	},
    	{
   			name: 'f_file_no',
   			index: 'f_file_no',
   			width: '20'
    	},
    	{
   			name: 'f_docname',
   			index: 'f_docname',
   			width: '20'
    	},
    	{
   			name: 'f_reback_time',
   			index: 'f_reback_time',
   			width: '20'
    	},
    	{
   			name: 'f_lending_userid',
   			index: 'f_lending_userid',
   			width: '20'
    	},
    	{
   			name: 'f_dept_name',
   			index: 'f_dept_name',
   			width: '20'
    	},
    	{
   			name: 'f_lending_time',
   			index: 'f_lending_time',
   			width: '20'
    	},
    	{
   			name: 'f_user_name',
   			index: 'f_user_name',
   			width: '20'
    	},
    	{
   			name: 'f_lending_id',
   			index: 'f_lending_id',
   			width: '20',
   			hidden: true
    	}
		],
		//sortname: 'last_updatetime',
		//指定默认的排序列，可以是列名也可以是数字。此参数会在被传递到Server端。
		sortname: 'f_doc_num',
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
		toolbar: [true,"top","<input type='button' value='归还' class=\"but_y_01\" onclick=\"giveback();\"/>"+
			"<input onclick=\"callForGiveBack();\" value='催还' class=\"but_y_01\" style='margin-left:3px;' type='button'/>"],
		multiselect: true,
		onCellSelect:function(rowid,iCol){
			if(iCol>0){
				var model = jQuery("#gridTable").jqGrid('getRowData',rowid);
				handle(model.f_lending_id);
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
	jQuery("#f_file_no").val("");
	jQuery("#F_DOC_NAME").val("");
	jQuery("#jzlx").val("");
	jQuery("#startSlTime").val("");
	jQuery("#endSlTime").val("");
	jQuery("#f_lending_userid").val("");
	jQuery("#f_dep_name").val("");
	userSearch();
};

	/*
	 函数:  toUserParamJosn
	 说明:  构建要查询的参数
	 参数:   无
	 返回值: 返回要查询的参数
	 */
var toUserParamJosn = function() {
	var f_file_no = jQuery("#f_file_no").val();
	var F_DOC_NAME = jQuery("#F_DOC_NAME").val();
	var jzlx = jQuery("#jzlx").val();
	var startSlTime = jQuery("#startSlTime").val();
	var endSlTime = jQuery("#endSlTime").val();
	var f_lending_userid = jQuery("#f_lending_userid").val();
	var f_dep_name = jQuery("#f_dep_name").val();
	var str = "{'f_lending_userid':'"+f_lending_userid+"'";
	str += ",'f_file_no':'"+f_file_no+"'";
	str += ",'f_docname':'"+F_DOC_NAME+"'";
	str += ",'f_lending_type':'"+jzlx+"'";
	str += ",'f_creator_state_time':'"+startSlTime+"'";
	str += ",'f_creator_end_time':'"+endSlTime+"'";
	str += ",'f_dep_name':'"+f_dep_name+"'";
	str += ",'jsp_type':'boroowing'";
	str += "}";
	return descape(escape(str));
}

var giveback = function(){
	var ids = "";
	var f_lending_types = "";
	var f_doc_ids = "";
	var selectedIds = $("#gridTable").jqGrid("getGridParam", "selarrrow");
	for ( var i = 0; i < selectedIds.length; i++) {
		var model = jQuery("#gridTable").jqGrid('getRowData',selectedIds[i]);
		if ("" != ids) {
			ids += ",";
			f_lending_types += ",";
			f_doc_ids+=",";
		}
		ids += "'" + model.f_detail_id + "'";
		f_lending_types += "'" + model.f_lending_type + "'";
		f_doc_ids+= "'" + model.f_doc_id + "'";
	}		 
	if (IsSpace(ids)) {
		alert("请选择要归还的文件！");
	}else {
		var okF = function(){	
			jQuery("#f_detail_id").val(ids);
			jQuery("#f_lending_types").val(f_lending_types);
			jQuery("#f_doc_ids").val(f_doc_ids);
			
			document.all.giveForm1.target = "hiddenFrame";
			jQuery("#giveForm1").submit();
			}
			var p={
					headerText:'提示',
					okName:'确认',
			        okFunction:okF,
			        cancelName:'取消'
			};
			alert("确定要归还该文件吗？",p)
	}
}

function callForGiveBack(){
	var f_detail_ids = "";
	var selectedIds = $("#gridTable").jqGrid("getGridParam", "selarrrow");
	var dataJson = {};
	for ( var i = 0; i < selectedIds.length; i++) {
		var model = jQuery("#gridTable").jqGrid('getRowData',selectedIds[i]);
		if(model.f_lending_type_name=="电子"){
			alert("借阅电子类型文件，无需催还");
			return;
		}
		//判断用户是否已经在催还中
		if(!dataJson[model.f_detail_id]){
			f_detail_ids += ",";
			f_detail_ids += model.f_detail_id;
			dataJson[model.f_detail_id] = model.f_detail_id;
		}
	}
	if (IsSpace(f_detail_ids)){
		alert("请选择要催还的记录！");
	} else {
		f_detail_ids = f_detail_ids.substr(1,f_detail_ids.length);
		openAlertWindows('windowId','<%=path %>/ccapp/oa/file/jsp/filebackcalluser.jsp?f_detail_ids='+f_detail_ids+'&sendtype=sum','借阅管理',780,250,'25%','25%');
	}
}

function handle(id){
	var url = '<%=path %>' + "/ccapp/oa/file/jsp/filelendinginfo.jsp?windowId=looklending&id=" + id;
	openAlertWindows('looklending',url,'借阅信息','920','300','25%','25%');
}

</script>
</head>
<body>
<table width="100%">
	<tr>
		<td>
			<!-- 查询条件选区    tabs_search_ctable(查询table样式) -->
			<table border="0" cellspacing="0" cellpadding="0" class="tabs_search_ctable_box" style="width: 100%">
				<tr>
					<td>
						<!-- 固定查询 -->
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<th class="input_cx_title_th" style="width:60px;">档号：</th>
					   <td class="cx_title_td" style="width:100px;">
					   	 <input id="f_file_no" name="f_file_no"  style="width: 180px" type="text" class="input_cx_title_283" />
					    </td>
						<th class="input_cx_title_th" style="width:60px;">文件标题：</th>
					    <td class="cx_title_td" style="width:100px;">
					   	 <input id="F_DOC_NAME" name="F_DOC_NAME" style="width: 100px" type="text" class="input_cx_title_283" />
					    </td>
						<th class="input_cx_title_th" style="width:60px;">借阅类型：</th>
					    <td class="cx_title_td" style="width:100px;">
					   		<%=selectData%>
					    </td>
					    <td rowspan="2" align="center" style="width: 100px">
					    	<input value="搜索" type="button" onclick="userSearch()" class="but_y_01" />
	                    	<input value="重置" type="button" onclick="clearSearch()" class="but_y_01" />
					    </td>
					</tr>
					<tr>
					    <th class="input_cx_title_th">申请日期：</th>
						<td  class="cx_title_td">
							<input class="date_120 Wdate" type="text" id="startSlTime" name="startSlTime" style="width: 80px" onFocus="var input_endtime=$dp.$('endSlTime');WdatePicker({onpicked:function(){endSlTime.focus();},dateFmt:'yyyy-MM-dd '})" />
								<span class="date_120_span">至</span>
							<input class="date_120 Wdate" type="text" id="endSlTime" name="endSlTime" style="width: 80px" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'startSlTime\')}',dateFmt:'yyyy-MM-dd '})" />
						</td>
						<th class="input_cx_title_th" style="width:60px;">借阅人：</th>
						<td class="cx_title_td" style="width:100px;">
							<input id="f_lending_userid" name="f_lending_userid"  style="width: 100px" type="text" class="input_cx_title_283" />
						</td>
						<th class="input_cx_title_th" style="width:60px;">所属部门：</th>
						<td class="cx_title_td" style="width:100px;">
							<input id="f_dep_name" name="f_dep_name"  style="width: 100px" type="text" class="input_cx_title_283" />
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
		<!-- 查询列表区 cGridArea(查询区样式)-->
		<div class="cGridArea">
		<table id="gridTable"></table>
		<div id="gridPager"></div>
		</div>
		<!-- 查询列表区 -->
		<form id="giveForm1" name="giveForm1" method="post" action="fileborrowaddDo.jsp?subid=<%=subid%>">
			<input type="hidden" name="f_detail_id" id="f_detail_id" />
			<input type="hidden" name="f_lending_types" id="f_lending_types" /> 
			<input type="hidden" name="f_doc_ids" id="f_doc_ids" /> 
			<input type="hidden" name="action" id="action"value="giveback" />
		</form>
			<iframe name="hiddenFrame" width="0" height="0"></iframe>
		</td>
	</tr>
		
</table>
		

</body>
</html>
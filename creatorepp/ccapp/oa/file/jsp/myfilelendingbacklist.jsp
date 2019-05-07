<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	String userId = accesscontroler.getUserID();
	String loginUserName = accesscontroler.getUserAccount();
	String sql = "select i.busitype_code, i.busitype_name from OA_FLOW_BUSITYPE i where i.is_valid = 'Y' ";
	String str = DictDropDownList.buildSelect(sql,"busitype_code","","",true,"");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="com.chinacreator.xtbg.core.common.util.DictDropDownList"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title></title>
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
<title></title>
<script type="text/javascript">
var loginUserName = '<%=loginUserName%>';
$(function() {
	$(document).keydown(function(){
		if(event.keyCode == 13){ 
			userSearch();
		}
	});
	$("#gridTable").jqGrid({
		url: '<%=path%>/pubListServlet?classNameId=com.chinacreator.xtbg.core.file.list.MyFileLendingForMeAfterList',  //pubListServlet列表公共的servlet,classNameId在servletBean.xml文件中配置要调用的类,isPage:是否翻页(true,false),默认为true
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
		sortname: 'f_lending_time',
		//指定默认的排序列，可以是列名也可以是数字。此参数会在被传递到Server端。
		sortorder: 'desc',
		viewrecords: true,
		colModel : [
        {
        	label : "借阅类型",
        	width:30,
            name : 'f_lending_type_name',
            index : 'f_lending_type_name'
        },{
        	label : "件号",
        	width:30,
            name : 'f_doc_num',
            index : 'f_doc_num'
        }, {
            label : "档号",
            name : 'f_files_no',
            index : 'f_files_no',
            width:80
        },{	
            label : "文件标题",
            width:200,
            name : 'f_doc_name',
            index : 'f_doc_name'
        }, {
            label : "借阅日期",
            name : 'f_lending_time',
            width:50,
            index : 'f_lending_time'
        }, {
            label : "归还日期",
            name : 'f_back_time',
            width:50,
            index : 'f_back_time'
        }, {
            label : "库存数量",
            name : 'f_file_num',
            width:50,
            index : 'f_file_num',
            hidden:true
        }, {	
            label : "借阅人",
            width:80,
            name : 'f_lending_username',
            index : 'f_lending_username',
            hidden:true
        }, {	
            label : "借阅天数",
            width:70,
            name : 'f_lending_day',
            index : 'f_lending_day',
            hidden:true
        }, {	
            label : "借阅人所属部门",
            width:70,
            name : 'f_dept_name',
            index : 'f_dept_name',
            hidden:true
        }, {
            label : "idA",
            width:70,
            name : 'f_detail_id',
            index : 'f_detail_id',
            hidden:true
        }, {
            label : "idAB",
            width:70,
            name : 'f_doc_id',
            index : 'f_doc_id',
            hidden:true
        }, {
            label : "f_type_name",
            width:70,
            name : 'f_type_name',
            index : 'f_type_name',
            hidden:true
        }
        ],
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
				var model = jQuery("#gridTable").jqGrid('getRowData', cl);
				be = "<input id='modify' type='button' class='but_y_01' onMouseOver=javascript:$(this).attr('class','but_y_02'); onMouseOut=javascript:$(this).attr('class','but_y_01'); onclick='showFlowHistory("+cl+")' value = '办件历史' />";
				recoverBut = "<input id='recover' type='button' class='but_y_01' onMouseOver=javascript:$(this).attr('class','but_y_02'); onMouseOut=javascript:$(this).attr('class','but_y_01'); onclick='getbackFlow("+cl+")' value = '追回' />"
				if(model.act_index == '1') {
					be = recoverBut + be;
				}
				jQuery("#gridTable").jqGrid('setRowData', ids[i], {
					act: be
				});
			}
		},
		
		jsonReader: { //这又是一个数组，用来设定如何解析从Server端发回来的json数据
			repeatitems: false
		},
		//pager: "#gridPager",
		pagerintoolbar:true,//上面的分页条
		pagerinBottombar:true,//下面的分页条
		//定义页码控制条Page Bar
		//caption: "已办列表",
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
		multiselect: true,
		toolbar: [true,"top",""],
		onSelectRow: function(id) {
			handle(id);
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
var sdata = {
	paramJson: descape(escape("{'f_lending_userid':'<%=userId%>'}"))
};
var postData = $("#gridTable").jqGrid("getGridParam", "postData");
$.extend(postData, sdata); //将postData中的查询参数覆盖为空值  
$("#gridTable").jqGrid("setGridParam", {
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
		var str = "{'f_type_name':'"+$('#f_type_name').val()+"'"+
				  ",'f_doc_name':'"+$('#f_doc_name').val()+"'"+
				  ",'f_lending_userid':'<%=userId%>'"+
				  ",'f_creator_state_time':'"+$('#startSlTime').val()+"'"+
				  ",'f_creator_end_time':'"+$('#endSlTime').val()+"'}";
	return descape(escape(str));
}
/*
函数:  resetSingleSearchDialog
说明:  清空值查询值
参数:   无
返回值: 无
*/
var resetSingleSearchDialog = function() { //$("radio","#singleSearchDialog").attr("checked", false);  
$(":text", "#queryTable").val("");
$("select:first option:first").attr("selected","selected");
};

var showFlowHistory = function(id) {
	var model = jQuery("#gridTable").jqGrid('getRowData', id);
	showFlowHistoryByInsId(model.ins_id);
}

function handle(id){ 
	
}
function borrowAdd(){ 
    var url = "fileborrowadd.jsp?busi_id=&busiTypeCode=wj-001&subid=windowsId";
    window.parent.location = url,"perspective_content";
}
function borrowOutAndBack(){
	var selectedIds = $("#gridTable").jqGrid("getGridParam", "selarrrow");
	if(selectedIds.length>0){
		var p={headerText:'提示',okName:'确认',okFunction:function(){
			idList = '';
			docList = '';
			for ( var i = 0; i < selectedIds.length; i++){
				model = jQuery("#gridTable").jqGrid('getRowData',
						selectedIds[i]);
				idList+=model.f_detail_id+",";
				docList+=model.f_doc_id+",";
			}
			$("#hidden_action").val("borrowOutAndBack");
			$("#hidden_idList").val(idList);
			$("#hidden_docList").val(docList);
			$("#onlyFrom").submit();
			afterSubmitFn = function(data){
				alert(data);
				userSearch();
			}
		},cancelName:'取消'};
       	alert("确定馆内阅读?",p); 
	}else{
		alert("请选择数据");
	}
}
function borrowOut(){
	var selectedIds = $("#gridTable").jqGrid("getGridParam", "selarrrow");
	if(selectedIds.length>0){
		var p={headerText:'提示',okName:'确认',okFunction:function(){
			idList = '';
			docList='';
			dateList='';
			for ( var i = 0; i < selectedIds.length; i++){
				model = jQuery("#gridTable").jqGrid('getRowData',selectedIds[i]);
				if(!model.f_file_num||model.f_file_num=='0'){
					alert("库存不足"); 
					return;
				}
				idList+=model.f_detail_id+",";
				docList+=model.f_doc_id+",";
				dateList+=model.f_lending_day+",";
			}
			jQuery("#hidden_action").val("borrowOut");
			jQuery("#hidden_idList").val(idList);
			jQuery("#hidden_dateList").val(dateList);
			$("#hidden_docList").val(docList);
			jQuery("#onlyFrom").submit();
			afterSubmitFn = function(data){
				alert(data);
				userSearch();
			}
		},cancelName:'取消'};
       	alert("确定借出?",p); 
	}else{
		alert("请选择数据");
	}
}
var afterSubmitFn = function (){}
/*
函数:  getbackFlow
说明:  追回
参数:   无
返回值: 无
*/
function getbackFlow(id){
	var model = jQuery("#gridTable").jqGrid('getRowData', id);
	var _actInsid = model.act_insid;
	var _ins_id = model.ins_id;
	var _flow_id = model.flow_id;
	var _action_form = model.action_form;
	var url = "getbackflowajax.jsp";
	params = {actInsId:_actInsid,ins_id:_ins_id,flow_id:_flow_id,action_form:_action_form};

	$.ajax({
		url: url,
		type: 'POST',
		dataType: 'json',
		data: params,
		success: function(data){
				alert("追回成功！");
				userSearch();
		},
		error: function(jqXHR, textStatus, errorThrown){
			alert(jqXHR);
			alert(textStatus);
			alert(errorThrown);
		}
	});
}
</script>
</head>
<body>
<table width="100%">
	<tr>
		<td>
			<!-- 查询条件选区    tabs_search_ctable(查询table样式) -->
			<table border="0" cellspacing="0" cellpadding="0" class="tabs_search_ctable_box" style="width: 100%" id="queryTable">
				<tr>
					<td>
						<!-- 固定查询 -->
				<table width="80%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<th class="input_cx_title_th" style="width:40px;">文件分类：</th>
						<td class="cx_title_td" style="width:100px;">
					   	 <input id="f_type_name" name="f_type_name"  style="width: 140px" type="text" class="input_cx_title_283" />
					    </td>
					    <th class="input_cx_title_th" style="width:40px;">借阅日期：</th>
					    <td class="cx_title_td" style="width:100px;">
					   	 	<input class="date_120 Wdate" type="text" id="startSlTime" name="startSlTime" style="width: 90px" onFocus="var input_endtime=$dp.$('endSlTime');WdatePicker({onpicked:function(){endSlTime.focus();},dateFmt:'yyyy-MM-dd '})" />
								<span class="date_120_span">至</span>
							<input class="date_120 Wdate" type="text" id="endSlTime" name="endSlTime" style="width: 90px" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'startSlTime\')}',dateFmt:'yyyy-MM-dd '})" />
						</td>
					</tr>
					<tr>
						<th class="input_cx_title_th" style="width:40px;">文件标题：</th>
					    <td class="cx_title_td" style="width:100px;">
					   	 <input id="f_doc_name" name="f_doc_name" style="width: 140px" type="text" class="input_cx_title_283" />
					    </td>
					    <td class="input_cx_title_th" colspan="2" align="center" style="text-align: center;">
					    	<div style="margin: 0 auto;width:150px;">
					    	<input value="搜索" type="button" onclick="userSearch()" class="but_y_01" />
	                    	<input value="重置" type="button" onclick="clearSearch()" class="but_y_01" />
	                    	</div>
					    </td>
					</tr>
			</table>
		<!-- 查询条件选区    tabs_search_ctable(查询table样式) -->
						
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
		</td>
	</tr>
		
</table>

<iframe name="filewaithiddenFrame" width=0 height=0></iframe>
<form id="onlyFrom" name="onlyFrom" method="post" action="filefilesquerydo.jsp" target="filewaithiddenFrame" >
<input type='hidden' name='action' id="hidden_action"/>
<input type='hidden' name='idList' id="hidden_idList"/>
<input type='hidden' name='docList' id="hidden_docList"/>
<input type='hidden' name='dateList' id="hidden_dateList"/>
</form>
</body>
</html>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DaoUtil"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>

<%
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	String userid = accesscontroler.getUserID();
	String path = request.getContextPath();
	String flow_id_b = request.getParameter("flow_id");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>流程配置列表</title>
<!-- 引入jQuery -->
<script type="text/javascript"
	src="../../../resources/plug/jquery1.7/jquery-1.7.1.min.js"></script>
<script
	src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js"
	type="text/javascript"></script>
<script
	src="../../../resources/plug/jquery.jqGrid-4.3.1/js/i18n/grid.locale-en.js"
	type="text/javascript"></script>
<script
	src="../../../resources/plug/jquery.jqGrid-4.3.1/js/jquery.jqGrid.min.js"
	type="text/javascript"></script>
<!-- 引入其它 -->
<script src="../../../resources/util/public.js" type="text/javascript"></script>
<script type="text/javascript"
	src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript"
	src="../../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript"
	src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js"
	charset="utf-8"></script>
<script type="text/javascript"
	src="../../../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js"
	charset="utf-8"></script>
<script type="text/javascript"
	src="../../../resources/plug/JQuery zTree v3.0/js/jquery.ztree.core-3.0.js"></script>
<script type="text/javascript"
	src="../../../resources/plug/JQuery zTree v3.0/js/jquery.ztree.excheck-3.0.js"></script>
<script type="text/javascript"
	src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js"
	charset="utf-8"></script>
<script type="text/javascript">
$(function() {
	$(document).keydown(function(){
		if(event.keyCode == 13){ 
			userSearch();
		}
	});
	$("#gridTable").jqGrid({
		url: '<%=path%>' + '/pubListServlet?classNameId=com.chinacreator.xtbg.core.process.processconfig.list.FlowInfoList',//pubListServlet列表公共的servlet,classNameId在servletBean.xml文件中配置要调用的类,isPage:是否翻页(true,false),默认为true
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
		colNames: ['','流程ID','类型code','类型编码', '流程名称 ', '机构', '流程时限','是否个性化','创建时间'],
		//字符串数组，用于指定各列的题头文本，与列的顺序是对应的。
		colModel: [ //最重要的数组之一，用于设定各列的参数
        {
   		  	name: 'rr',
   		    index:'rr',
   		   	width: 30,
   			search: false,
   			sortable: false,
   			editable: false
   		},{
			name: 'flow_id',
			index: 'flow_id',
			width: 50,
			editable: true,
			hidden:true
		},
		{
			name: 'busitype_code',
			index: 'busitype_code',
			width: 50,
			editable: true,
			hidden:true
		},
		{
			name: 'busitype_name',
			index: 'busitype_name',
			width: 180,
			editable: true
		},
		{
			name: 'flow_name',
			index: 'flow_name',
			width: 180,
			editable: true,
			sortable: true
		},
		{
			name: 'org_name',
			index: 'org_name',
			width: 180,
			editable: true,
			sortable: true
		},

		{
			name: 'flow_limit',
			index: 'flow_limit',
			width: 60,
			editable: true,
			sortable: true
		},
		{
			name: 'is_indivi',
			index: 'is_indivi',
			width: 60,
			editable: true,
			sortable: true
		},

		{
			name: 'create_time',
			index: 'create_time',
			width: 130,
			editable: true,
			sortable: true
		}
		],
		sortname: 'busitype_name',
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
			/* var ids = $("#gridTable").getDataIDs(); //jqGrid('getDataIDs');
			for (var i = 0; i < ids.length; i++) {
				var cl = ids[i];

			} */
			var ids = jQuery("#gridTable").getDataIDs(); //jqGrid('getDataIDs');
			for (var i = 0; i < ids.length; i++) {
				var cl = ids[i];
				var model = jQuery("#gridTable").jqGrid('getRowData', cl);
				be = "<input type='radio'  name='r1' />";
				
			jQuery("#gridTable").jqGrid('setRowData', ids[i], {
				rr: be
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
		//caption: "流程配置列表",
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
		toolbar: [true,"top","<input class='but_y_01' onMouseOver=javascript:$(this).attr('class','but_y_02'); onMouseOut=javascript:$(this).attr('class','but_y_01'); id=add type='button' onclick='selectFlowInfoConfig()' value='选择'/>"],
		multiselect: false,
		onCellSelect:function (id,icol)
		{
			if(icol != 0)
				{
				//editFlowInfo(id);
				}
		}
	}).navGrid('#gridPager', {
		edit: false,
		add: false,
		del: false,
		search : false,
		refresh : false
	});
	
	$("#userReName").datepicker({
		showOn: "button",
		buttonImage: "../../../resources/plug/jquery-ui-1.8.17.custom/development-bundle/demos/images/calendar.gif",
		buttonImageOnly: true,
		dateFormat:"yy-mm-dd"
	});
});
	 


var getCheckBoxValue = function() {
	/*得到所选择的值*/
	var str = "";
	$("[.jqgrow td input][checked]").each(function() {
		str += $(this).val() + ",";
	});
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
函数:  toUserParamJosn
说明:  构建要查询的参数
参数:   无
返回值: 返回要查询的参数
*/
var toUserParamJosn = function() {
var str = "{'flow_name':'"+$("#flow_name").val()
	+"','org_name':'"+$("#org_name").val()
	+"','flow_id':'<%=flow_id_b%>"
	+"'}";
return descape(escape(str));
}

/*
函数:  clearSearch
说明:  重置
参数:   无
返回值: 无
*/
var clearSearch = function() {
var sdata = {
	paramJson: descape(escape("{'flow_name':''}"))
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
函数:  resetSingleSearchDialog
说明:  清空值查询值
参数:   无
返回值: 无
*/
var resetSingleSearchDialog = function() { //$("radio","#singleSearchDialog").attr("checked", false);  
$(":text", "#queryTable").val("");
$("select:first option:first").attr("selected","selected");
};

var chooseOrg = function (){
	 var s = new $.z_tree();
	  s.treeID='mian';
	  s.isShowSeacher=true;
	  s.treeName="选取单位";
	  s.isType='dept';
	  s.headerName="选取单位";
	  s.item_id = 'org_id';
	  s.selectedIds=$('#org_id').val();
	  s.type='AORG';
	  s.returnFunction=function(orgObj){
		  if(!IsSpace(orgObj)){
				 $('#org_id').val(orgObj.id);
				 $('#org_name').val(orgObj.name);
			 }else{
				 $('#org_id').val("");
				 $('#org_name').val("");
			 }
		 }
	  s.init();
}

var selectFlowInfoConfig = function() {
	var ids = "";
    var j = -1;
    var ids = jQuery("#gridTable").getDataIDs(); //jqGrid('getDataIDs');
    jQuery("input[name=r1]").each(function(i,e){
		if(jQuery(this).is(":checked")){
			j = i;
		}
	})
	var model = jQuery("#gridTable").jqGrid('getRowData',ids[j]);
    
	/* var selectedIds = $("#gridTable").jqGrid("getGridParam", "selarrrow");
	var jSelectedIds = $(selectedIds);
	if(jSelectedIds.size()==1){ */
		//jSelectedIds.each(function(){
		//	var model = jQuery("#gridTable").jqGrid('getRowData', this);
			var flow_id_a = model.flow_id;
			if(!IsSpace(flow_id_a)){
				var okF = function(){
					var url = "<%=path%>/ccapp/oa/form/configparmdo.jsp";
					jQuery("#backHaddle").val("afterCopyFlow");
					jQuery("#flow_id_a").val(flow_id_a);
					jQuery(document.all.form1).attr("action",url);
					document.all.form1.target = "hiddenFrame";
					document.all.form1.submit();
				};
				var p={
						headerText:'提示',
						okName:'确认',
				        okFunction:okF,
				        cancelName:'取消'
				};
				alert("确定复制吗？",p);
			}
		//});
	/* }else if(jSelectedIds.size()==0){
		alert("请先选中一条记录！");
	}else if(jSelectedIds.size()>1){
		alert("每次只能选择一条记录复制!");
	} */
}

/**
 * 修改复制之后
 */
var afterCopyFlow = function(data,a,b,c){
	if(data){
		try{
			getParentWindow("windowId1").refreshGrid4FlowInfo();
			getParentWindow("windowId1").refreshFlowInfo(a,b,c);
		}catch(e){};
		alert("操作成功");
	}else{
		alert("操作失败");
	}
	removeAlertWindows('windowId1',true);
};

</script>
</head>
<body>
<table width="100%" id="queryTable">
	<tr>
		<td><!-- 查询条件选区    tabs_search_ctable(查询table样式) -->
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="tabs_search_ctable_box">
			<tr>
				<td><!-- 固定查询 -->
				<table width="100%" border="0" cellspacing="0" cellpadding="0"
					class="tabs_search_ctable">
					<tr>
						<th class="input_cx_title_th">机构:</th>
						<td class="cx_title_td"><input type="hidden" id="org_id"
							name="org_id" value="" /> <INPUT class="input_170"
							onmouseover="this.title=this.value" id="org_name" name="org_name"
							value="" readOnly onclick='chooseOrg()'> <input name=""
							type="button" value="" class="but_x" onclick="chooseOrg()" /></td>
						<td width="385" colspan="2"><input name="Input2" value="搜索"
							type="button" onclick="userSearch()" class="but_y_01" /> <span
							id="selAreaImg" class="all_search_condition"><a
							onclick="hiddenOrShowSelArea('hiddenArea','selAreaImg')">更多搜索条件</a></span>
						</td>
					</tr>
				</table>
				<!-- 固定查询 end--></td>
			</tr>

			<tr>
				<td><!-- 隐藏查询 -->
				<table width="100%" border="0" cellspacing="0" cellpadding="0"
					class="tabs_search_ctable" id="hiddenArea" style="display: none">

					<tr>
						<th class="input_cx_title_th">流程名称:</th>
						<td class="cx_title_td"><input name="flow_name"
							id="flow_name" type="text" class="input_cx_title_283" /> <input
							type="hidden" id=inputuser_id name=inputuser_id /></td>
						<th colspan="2">
						<table width="100%" border="0" cellspacing="0" cellpadding="0"></table>
						</th>
					</tr>
				</table>
				<!-- 隐藏查询 end--></td>
			</tr>
		</table>
		</td>
	</tr>
</table>


<!-- 查询列表区 cGridArea(查询区样式)-->
<div class="cGridArea">
<table id="gridTable">
</table>
<div id="gridPager"></div>
</div>
<!-- 查询列表区 -->
<form id="form1" name="form1" method="post">
	<input id="flow_id_a" name="flow_id_a" type="hidden"/>
	<input name="action" type="hidden" value ='docopyflow'/>
	<input id="flow_id_b" name="flow_id_b" type="hidden" value='<%=flow_id_b%>'/>
	<input id="backHaddle" name="backHaddle" type="hidden"/>
</form>
<iframe name="hiddenFrame" width="0" height="0"></iframe>
</body>
</html>

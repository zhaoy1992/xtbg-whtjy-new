<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DaoUtil"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>

<%
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	String userid = accesscontroler.getUserID();
	String path = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>流程配置列表</title>
<!-- 引入jQuery -->
<script type="text/javascript"
	src="../resources/plug/jquery1.7/jquery-1.7.1.min.js"></script>
<script
	src="../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js"
	type="text/javascript"></script>
<script
	src="../resources/plug/jquery.jqGrid-4.3.1/js/i18n/grid.locale-en.js"
	type="text/javascript"></script>
<script
	src="../resources/plug/jquery.jqGrid-4.3.1/js/jquery.jqGrid.min.js"
	type="text/javascript"></script>
<!-- 引入其它 -->
<script src="../resources/util/public.js" type="text/javascript"></script>
<script type="text/javascript"
	src="../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript"
	src="../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript"
	src="../resources/plug/ifrom/js/ifrom-tools.1.1.js"
	charset="utf-8"></script>

<script type="text/javascript">
$(function() {
	$(document).keydown(function(){
		if(event.keyCode == 13){ 
			userSearch();
		}
	});
	$("#gridTable").jqGrid({
		url: '<%=path%>' + '/pubListServlet?classNameId=com.chinacreator.xtbg.core.form.list.FormConfigList',//pubListServlet列表公共的servlet,classNameId在servletBean.xml文件中配置要调用的类,isPage:是否翻页(true,false),默认为true
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
		colNames: ['表单ID','表单名称', '表单JSP名称 ', '表单分隔线颜色', '表单宽度','元素间隔PX','元素宽度','元素高度','操作'],
		//字符串数组，用于指定各列的题头文本，与列的顺序是对应的。
		colModel: [ //最重要的数组之一，用于设定各列的参数
		{
			name: 'form_id',
			index: 'form_id',
			hidden:true
		},
		{
			name: 'form_name',
			index: 'form_name',
			width: 80
		},
		{
			name: 'form_jsp_name',
			index: 'form_jsp_name',
			width: 80,
			sortable: true
		},
		{
			name: 'form_background',
			index: 'form_background',
			width: 60,
			sortable: true
		},

		{
			name: 'form_width',
			index: 'form_width',
			width: 60,
			sortable: true
		},
		{
			name: 'tag_margins',
			index: 'tag_margins',
			width: 40,
			sortable: true
		},
		{
			name: 'tag_width',
			index: 'tag_width',
			width: 40,
			sortable: true
		},
		{
			name: 'tag_height',
			index: 'tag_height',
			width: 40,
			sortable: true
		},
		{
			name: 'action_column',
			index: 'action_column',
			width: 40,
			sortable: true
		}
		],
		sortname: 'form_name',
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
			
			var showStr = "<a href='javascript:void(0);' "+
            " onclick='modifyForm(\""+cl
            +"\")' style='font-weight:bold;color:red;'>配置修改</a>";
            
			//重新定义列显示的值
            jQuery("#gridTable").jqGrid('setRowData', ids[i], {
            	action_column : showStr
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
		toolbar: [true,"top","<input class='but_y_01' id=add type='button' onclick='addForm()' value='添加'/><input class='but_y_01' id=del type='button' onclick='delFormInfo()' value='删除'/>"],
		multiselect: true,
		onCellSelect:function (id,icol)
		{
			if(icol != 0)
				{
				formTagConfig(id);
				}
		}
	}).navGrid('#gridPager', {
		edit: false,
		add: false,
		del: false,
		search : false,
		refresh : false
	});
	
	
	//$("#t_gridTable").append("<input class='add' id=add type='button' onclick='addFlow()' /><input class='del' id=del type='button' onclick='deleteFlowInfo()' />");//<input id=addin type='button' value='添加' style='height:20px;font-size:-3'/>
	/*
	$("#addin").button({
        icons: {
            primary: "ui-icon-plus"
        }
     });*/
	
	$("#userReName").datepicker({
		showOn: "button",
		buttonImage: "../../../resources/plug/jquery-ui-1.8.17.custom/development-bundle/demos/images/calendar.gif",
		buttonImageOnly: true,
		dateFormat:"yy-mm-dd"
	});
	//.setDefaults($.datepicker.regional['zh-CN']);
	//$("#datepicker" ).datepicker( "yyyy-mm-dd", "dateFormat", $(this).val() );
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
	var str = "{'item_name':'" + $("#userName").val() + "','version':'" + $("#userReName").val() + "'}";
	return descape(str);
}

//添加表单
var addForm = function() {
	var url = "formconfigdetail.jsp";
	openWindows('sub_formconfigdetail','表单配置','formconfigdetail.jsp?operwindowid=sub_formconfigdetail','',false,window);
}
//修改表单
var modifyForm = function(id){
	var model = jQuery("#gridTable").jqGrid('getRowData', id);
	openWindows('sub_formconfigdetail','表单配置','formconfigdetail.jsp?operwindowid=sub_formconfigdetail&form_id='+model.form_id,'',false,window);
}  
//配置表单
var formTagConfig = function(id) {
	var model = jQuery("#gridTable").jqGrid('getRowData', id);
	url = "fileformadd.jsp?windowid=windowids&form_id="+model.form_id+"&form_name="+model.form_name+"&form_jsp_name="+model.form_jsp_name+"&form_background="+model.form_background;
	url += "&form_width="+model.form_width+"&tag_width="+model.tag_width+"&tag_height="+model.tag_height+"&tag_margins="+model.tag_margins;
	openWindows('windowids','表单配置',url,'',false,window);
}

var getCheckBoxValue = function() {
	/*得到所选择的值*/
	var str = "";
	$("[.jqgrow td input][checked]").each(function() {
		str += $(this).val() + ",";
	});
}

var delFormInfo = function() {
	var ids = "";
	var selectedIds = $("#gridTable").jqGrid("getGridParam", "selarrrow");
	for(var i = 0; i < selectedIds.length; i++) {
		var model = jQuery("#gridTable").jqGrid('getRowData', selectedIds[i]);
		 if("" != ids){			   
			ids += ",";
		 }
		 ids += model.form_id;
		 
	}
	if (IsSpace(ids)) {
		alert("请选择要删除的记录！");
	} else {
		
		var okF = function(){
			 //ajax方式提交数据
            jQuery.ajax({ 
                type: "post", 
                url: "fileformadddo.jsp", 
                contentType: "application/x-www-form-urlencoded; charset=utf-8",
                data : {                   
                	form_ids : ids ,//要删除的id
                	action:"delForm"
                },
                dataType: "json", 
                success: function (data) {         
                    if(data&&data.msg){
                      alert(data.msg);
                    }
                    //如果删除成功，刷新数据
                    if(data&&data.flag&&"true" == data.flag){
                        userSearch();
                    }
                }, 
                error: function (XMLHttpRequest, textStatus, errorThrown) { 
                    alert("系统异常，请稍后再试！");
                }
             });

			
		}
		var p={
				headerText:'提示',
				okName:'确认',
		        okFunction:okF,
		        cancelName:'取消'
		};
	alert("确定要删除表单信息吗？",p)
	}
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
var str = "{'form_name':'"+$("#form_name").val()+"','form_jsp_name':'"+$("#form_jsp_name").val()+"'}";
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
						<th class="input_cx_title_th">表单名称:</th>
						<td class="cx_title_td"><input name="form_name"
							id="form_name" type="text" class="input_cx_title_188" /> </td>
						<th class="input_cx_title_th">页面名称:</th>
						<td class="cx_title_td"><input name="form_jsp_name"
							id="form_jsp_name" type="text" class="input_cx_title_188" /> </td>	
						<td width="385" colspan="2"><input name="Input2" value="搜索"
							type="button" onclick="userSearch()" class="but_y_01" /> <span
							id="selAreaImg" class="all_search_condition"></span>
						</td>
					</tr>
				</table>
				<!-- 固定查询 end--></td>
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
<form id="form1" name="form1" method="post"><input id="flowids"
	name="flowids" type="hidden"></input></form>
<iframe name="hiddenFrame" width="0" height="0"></iframe>
</body>
</html>

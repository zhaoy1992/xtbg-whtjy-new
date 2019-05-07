<%-- 
描述：督查督办的类别维护
作者：肖杰
版本：1.0
日期：2013-11-05
 --%>
<%@page import="com.chinacreator.xtbg.core.common.cache.UserCache"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DaoUtil"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
	String path = request.getContextPath();
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	String userid=accesscontroler.getUserID();
	UserCacheBean userbean= UserCache.getUserCacheBean(userid);
	
	String orgname="";
	String orgid="";
	if(userbean!=null){
		orgname=userbean.getUnit_name();
		orgid=userbean.getUnit_id();
	}
%>
<title>督查督办的类别维护</title>
<!-- 引入jQuery -->
<script type="text/javascript"
	src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<!-- 引入jQuery UI -->
<script
	src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js"
	type="text/javascript"></script>
<!-- 引入jGrid -->
<script
	src="../../resources/plug/jquery.jqGrid-4.3.1/js/i18n/grid.locale-en.js"
	type="text/javascript"></script>
<script
	src="../../resources/plug/jquery.jqGrid-4.3.1/js/jquery.jqGrid.min.js"
	type="text/javascript"></script>
<!-- 引入其它 -->
<script src="../../resources/util/public.js" type="text/javascript"></script>
<script type="text/javascript"
	src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<script type="text/javascript"
	src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<!-- 公共部分引用结束 -->
<!-- 当jqGrid列的字过多的时候显示...样式  -->

<script type="text/javascript">
$(function() {
	$(document).keydown(function(){
		if(event.keyCode == 13){ 
			paramSearch();
		}
	});

	$("#gridTable").jqGrid({
		url: '<%=path%>' + '/pubListServlet?classNameId=com.chinacreator.xtbg.core.inspect.list.InspectTypeList',  //pubListServlet列表公共的servlet,classNameId在servletBean.xml文件中配置要调用的类,isPage:是否翻页(true,false),默认为true
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
		colModel: [ //最重要的数组之一，用于设定各列的参数
		{
			label:"类别主键ID",
			name: 'type_id',
			index: 'type_id',
			hidden: true
		},
		{
			label:"序号",
			name: 'type_order',
			index: 'type_order',
			width: 150,
			editable: true
		},
		{
			label:"类别名称",
			name: 'type_name',
			index: 'type_name',
			width: 250,
			sortable: false
		}
		,
		{
			label:"说明",
			name: 'type_remark',
			index: 'type_remark',
			hidden: false,
			width: 300,
			sortable: false
		}
		],
		sortname: 'type_order',
		//指定默认的排序列，可以是列名也可以是数字。此参数会在被传递到Server端。
		sortorder: '',
		viewrecords: true,
		
		//设置是否在Pager Bar显示所有记录的总数。
		rowNum: 10,
		//用于设置Grid中一次显示的行数，默认值为20。正是这个选项将参数rows（prmNames中设置的）通过url选项设置的链接传递到Server。注意如果Server返回的数据行数超过了rowNum的设定，则Grid也只显示rowNum设定的行数。
		rowList: [10, 20, 30],
		//一个数组，用于设置Grid可以接受的rowNum值。例如[10,20,30]
		gridComplete: function() {
		},
		jsonReader: { //这又是一个数组，用来设定如何解析从Server端发回来的json数据
			repeatitems: false
		},
		pagerintoolbar:true,//上面的分页条
		pagerinBottombar:true,//下面的分页条
		//定义页码控制条Page Bar
		//caption: "接收到的电子公告",
		//设置Grid表格的标题，如果未设置，则标题区域不显示。
		search : toParamJson(),
		prmNames: { //这是一个数组，用于设置jqGrid将要向Server传递的参数名称
			rows: "rows",
			//表示请求行数的参数名称  
			sort: "sidx",
			//表示用于排序的列名的参数名称  
			order: "sord",
			//表示采用的排序方式的参数名称 
			search : "search"
		},
		toolbar: [true,"top","<input class='but_y_01' onMouseOver=javascript:$(this).attr('class','but_y_02'); onMouseOut=javascript:$(this).attr('class','but_y_01'); id=add type='button' onclick='addinspecttype()' value='新增'/><input class='but_y_01' onMouseOver=javascript:$(this).attr('class','but_y_02'); onMouseOut=javascript:$(this).attr('class','but_y_01'); id=del type='button' value='删除' onclick='delinspecttype()'/>"],
		multiselect: true,
		onCellSelect: function(id,iCol) {
			if(iCol!=0){
				jQuery("#gridTable").setSelection(id,false);
			 	updateinspecttype(id);
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
	 函数:  toParamJson
	 说明:  构建要查询的参数
	 参数:   无
	 返回值: 返回要查询的参数
	 */
var toParamJson = function() {
	var str = '{"type_name":"' + $("#type_name").val()+'"}';
	return descape(escape(str));
}

/*
	 函数:  paramSearch
	 说明:  查询程序界面信息
	 参数:   无
	 返回值: 程序界面列表
*/
var paramSearch = function() {
	var sdata = { //构建查询需要的参数 
		paramJson: toParamJson()
	}; //获得当前postData选项的值  
	var postData = $("#gridTable").jqGrid("getGridParam", "postData"); //将查询参数融入postData选项对象  
	$.extend(postData, sdata);
	$("#gridTable").jqGrid("setGridParam", {
		search: true ,// 将jqGrid的search选项设为true  
		userFilters:toParamJson()
	}).trigger("reloadGrid", [{
		page: 1
	}]); //重新载入Grid表格，以使上述设置生效 
	
}


/*
函数:  delinspecttype
说明:  删除
参数:   无
返回值: 无
*/
var delinspecttype = function() {
	 var ids = "";
		var selectedIds = $("#gridTable").jqGrid("getGridParam", "selarrrow");
		for ( var i = 0; i < selectedIds.length; i++) {
			var model = jQuery("#gridTable").jqGrid('getRowData',selectedIds[i]);
			if ("" != ids) {
				ids += ",";
			}
			ids += "'" + model.type_id + "'";
		}		 
	if (IsSpace(ids)) {
		alert("请选择要删除记录！");
	} else {
		var okF = function(){	
			$("#type_id").val(ids);
			var fm = document.getElementById("delForm1");
			fm.target = "hiddenFrame";
			fm.submit();}
			var p={
					headerText:'提示',
					okName:'确认',
			        okFunction:okF,
			        cancelName:'取消'
			};
			alert("确定要删除该信息吗？",p)
	}
}


/*
函数:  addinspecttype
说明:  添加
参数:   无
返回值: 无
*/
var addinspecttype = function() {
	 openWindows('addinspect','新增','<%=path%>/ccapp/oa/inspect/jsp/inspecttypeinfo.jsp?&subid=addinspect','addinspect',false,window);
}
/*
	 函数:  updateinspecttype
	 说明:  修改
	 参数:   无
	 返回值: 无
*/
var updateinspecttype = function(id) {
	var model = jQuery("#gridTable").jqGrid('getRowData', id);
		openWindows('updateinspect','修改','<%=path%>/ccapp/oa/inspect/jsp/inspecttypeinfo.jsp?subid=updateinspect&type_id='
				+ model.type_id,'updateinspect',false,window);
	}
	
	



</script>
</head>
<body>
<div>


<table width="100%">
	<tr>
		<td><!-- 查询条件选区    tabs_search_ctable(查询table样式) -->
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="tabs_search_ctable_box">
			<tr>
				<td><!-- 固定查询 -->
				<table width="100%" border="0" cellspacing="0" cellpadding="0"
					class="tabs_search_ctable">
					<tr>
						<th width="90" class="input_cx_title_th">类别名称：</th>
						<td width="296" class="cx_title_td"><input
							class="input_cx_title_283" type="text" id="type_name" name="type_name" />
						</td>
						<td width="385" colspan="3"><input name="Input2" value="搜索"
							type="button" onclick="paramSearch()" class="but_y_01" />
						</td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td><!-- 隐藏查询 -->
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>

<!-- 查询列表区 cGridArea(查询区样式)-->
<div class="cGridArea">
<table id="gridTable"></table>
<div id="gridPager"></div>
</div>
<!-- 查询列表区 --></div>
<form id="delForm1" name="delForm1" method="post" action="inspecttypedo.jsp">
	<input type="hidden" name="type_id" id="type_id" /> 
	<input type="hidden" name="action" id="action" value="delinspect" />
</form>
<iframe name="hiddenFrame" width="0" height="0"></iframe>
</body>
</html>
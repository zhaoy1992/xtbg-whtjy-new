<%-- 
描述：系统参数值列表
作者：肖杰
版本：1.0
日期：2013-07-18
 --%>
<%@page import="com.chinacreator.xtbg.core.common.util.DataControlUtil"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
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
	String orgname=accesscontroler.getChargeOrgName();
	String orgid=accesscontroler.getChargeOrgId();
	String p_code=StringUtil.deNull(DataControlUtil.pageUnEscape(request.getParameter("p_code")));
	System.out.println(p_code);
	System.out.println(request.getParameter("p_code"));
	String name=StringUtil.deNull(request.getParameter("orgname"));
%>
<title>系统参数值列表</title>
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
			sysParamvalueSearch();
		}
	});

	$("#gridTable").jqGrid({
		url: '<%=path%>' + '/pubListServlet?classNameId=com.chinacreator.xtbg.core.sysparam.list.SysParamvalueList',  //pubListServlet列表公共的servlet,classNameId在servletBean.xml文件中配置要调用的类,isPage:是否翻页(true,false),默认为true
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
			label:"参数值ID",
			name: 'p_value_id',
			index: 'p_value_id',
			hidden: true
		},
		{
			label:"参数值名称",
			name: 'p_value_name',
			index: 'p_value_name',
			width:300,
			editable: true
		},
		{
			label:"参数编号",
			name: 'p_code',
			index: 'p_code',
			width: 200,
			editable: true
		},
		{
			label:"参数值编号",
			name: 'p_value_code',
			index: 'p_value_code',
			width: 300,
			editable: true
		},
		{
			label:"是否有效",
			name: 'p_value_valid',
			index: 'p_value_valid',
			width: 100,
			sortable: false,
			formatter:'select',
			editoptions:{value:"0:否;1:是"}
		},
		{
			label:"创建时间",
			name: 'p_creator_time',
			index: 'p_creator_time',
			width: 300,
			sortable: false
		}
		],
		sortname: 'p_value_id',
		//指定默认的排序列，可以是列名也可以是数字。此参数会在被传递到Server端。
		sortorder: 'desc',
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
		search : toSysParamvalueJson(),
		prmNames: { //这是一个数组，用于设置jqGrid将要向Server传递的参数名称
			rows: "rows",
			//表示请求行数的参数名称  
			sort: "sidx",
			//表示用于排序的列名的参数名称  
			order: "sord",
			//表示采用的排序方式的参数名称 
			search : "search"
		},
		toolbar: [true,"top","<input class='but_y_01' onMouseOver=javascript:$(this).attr('class','but_y_02'); onMouseOut=javascript:$(this).attr('class','but_y_01'); id=add type='button' onclick='addSysParamvalue()' value='新增'/><input class='but_y_01' onMouseOver=javascript:$(this).attr('class','but_y_02'); onMouseOut=javascript:$(this).attr('class','but_y_01'); id=del type='button' value='删除' onclick='delSysParamvalue()'/>"],
		multiselect: true,
		onCellSelect: function(id,iCol) {
			if(iCol!=0){
				jQuery("#gridTable").setSelection(id,false);
			 	updateSysParamvalue(id);
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
	 函数:  toSysParamvalueJson
	 说明:  构建要查询的参数
	 参数:   无
	 返回值: 返回要查询的参数
	 */
var toSysParamvalueJson = function() {
	var str ="{'p_code':'<%=p_code%>','p_value_name':'"+$("#p_value_name").val()+"'}";
	return descape(escape(str));
}

/*
	 函数:  sysParamvalueSearch
	 说明:  查询存放位置信息
	 参数:   无
	 返回值: 全宗号列表
*/
var sysParamvalueSearch = function() {
	var sdata = { //构建查询需要的参数 
		paramJson: toSysParamvalueJson()
	}; //获得当前postData选项的值  
	var postData = $("#gridTable").jqGrid("getGridParam", "postData"); //将查询参数融入postData选项对象  
	$.extend(postData, sdata);
	$("#gridTable").jqGrid("setGridParam", {
		search: true ,// 将jqGrid的search选项设为true  
		userFilters:toSysParamvalueJson()
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
		 resetSingleSearchDialog();
	var sdata = {
		paramJson: toSysParamvalueJson()
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
	$('#ckzt option:first').attr('selected', 'selected');
};

/*
函数:  delSysParamvalue
说明:  删除存放位置
参数:   无
返回值: 无
*/
var delSysParamvalue = function() {
	 var ids = "";
		var selectedIds = $("#gridTable").jqGrid("getGridParam", "selarrrow");
		for ( var i = 0; i < selectedIds.length; i++) {
			var model = jQuery("#gridTable").jqGrid('getRowData',selectedIds[i]);
			if ("" != ids) {
				ids += ",";
			}
			ids += "'" + model.p_value_id + "'";
		}		 
	if (IsSpace(ids)) {
		alert("请选择要删除记录！");
	} else {
		var okF = function(){	
			$("#p_value_id").val(ids);
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
函数:  addSysParamvalue
说明:  添加参数设置
参数:   无
返回值: 无
*/
var addSysParamvalue = function() {
	if(IsSpace('<%=p_code %>')){
		alert("请先填写并保存上面参数基本信息！");
	}else{
		var url = "<%=path%>/ccapp/oa/sysparam/jsp/sysparamvalueinfo.jsp?subid=addsysparamvalue&p_code="+_pub.lang.zwzm('<%=p_code%>');
		openAlertWindows('addsysparamvalue',url,'参数值信息',800,300,'25%','25%');
	}
}
/*
 函数:  updateSysParamvalue
 说明:  修改参数设置
 参数:   无
 返回值: 无
*/
var updateSysParamvalue = function(id) {
	var model = jQuery("#gridTable").jqGrid('getRowData', id);
		openAlertWindows('updatesysparamvalue','<%=path%>/ccapp/oa/sysparam/jsp/sysparamvalueinfo.jsp?subid=updatesysparamvalue&isview=view&p_value_id='
				+ model.p_value_id,'cxjm',800,300,'25%','25%');
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
						<%-- <th width="90" class="input_cx_title_th">单位名称：</th>
						<td width="200" class="cx_title_td">
							<input type="hidden" class="input_cx_title_283" type="text" id="f_org_id" name="f_org_id" value="<%=org_id %>"  />
							<input class="input_cx_title_150" type="text" disabled="disabled" id="f_org_name" name="f_org_name" value="<%=orgname %>" />
						</td> --%>
						<th width="90" class="input_cx_title_th">标题：</th>
						<td width="200" class="cx_title_td"><input
							class="input_cx_title_150" type="text"  id="p_value_name" name="p_value_name" value="" />

						</td>
						
						<td  ><input name="Input2" value="搜索" type="button" onclick="sysParamvalueSearch()" class="but_y_01" />
						</td>
					</tr>
				</table>
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
<form id="delForm1" name="delForm1" method="post" action="sysparamvaluedo.jsp">
	<input type="hidden" name="p_value_id" id="p_value_id" /> 
	<input type="hidden" name="action" value="deleteSysParamvalue" />
</form>
<iframe name="hiddenFrame" width="0" height="0"></iframe>
</body>
</html>
<%--
　　描述：模板列表页面-复制时查询选择页面
　　作者：邹拓
　　版本：1.0
　　日期：2013-11-29
--%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String orgId = StringUtil.deNull(request.getParameter("org_id"));
	String orgName = StringUtil.deNull(request.getParameter("org_name"));
	String template_id_b = StringUtil.deNull(request.getParameter("template_id"));
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%><html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>模板列表</title>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<!-- 引入jQuery UI -->
<script src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>
<!-- 引入my97时间控件 -->
<script src="../../resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<!-- 引入jGrid -->
<script src="../../resources/plug/jquery.jqGrid-4.3.1/js/i18n/grid.locale-en.js" type="text/javascript" ></script>
<script src="../../resources/plug/jquery.jqGrid-4.3.1/js/jquery.jqGrid.min.js" type="text/javascript"></script>
<!-- 引入其它 -->
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script src="../../resources/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js" ></script>

<script type="text/javascript">
	var obj = getParentWindow('windowId1');
	var org_id = "<%=orgId%>";
	var org_name = "<%=orgName%>";
	var path = "<%=path%>";
	var template_id = "<%=template_id_b%>";
	
$(function() {
	$(document).keydown(function(){
		if(event.keyCode == 13){ 
			userSearch();
		}
	});
	$("#gridTable").jqGrid({
		url: path + '/pubListServlet?classNameId=com.chinacreator.xtbg.core.common.iweboffice.list.WordTemplateForCopyList',  
		datatype: "json",
		mtype: "POST",
		height: "100%",
		autowidth: true,
		colModel: [ 
		{
			label:' ',
		  	name: 'rr',
		    index:'rr',
		   	width: 10,
			search: false,
			sortable: false,
			editable: false
		}, {
        	label:"模版id",
			name: 'mb_id',
			index: 'mb_id',
			hidden: true
		},
		{
			label:"名称",
			name: 'mb_mc',
			index: 'mb_mc',
			width: '100',
			editable: true
		},
		{
			label:"创建者",
			name: 'mb_cjz',
			index: 'mb_cjz',
			width: '30',
			editable: true
		},
		{
			label:"创建时间",
			name: 'mb_cjsj',
			index: 'mb_cjsj',
			width: '40',
			editable: true
		},
		{
			label:"备注",
			name: 'mb_remark',
			index: 'mb_remark',
			width: '40',
			editable: true
		},
		{
			label:"序号",
			name: 'template_sn',
			index: 'template_sn',
			width: '30',
			editable: true
		}
		],
		sortname: 'template_sn',
		sortorder: '',
		viewrecords: true,
		
		rowNum: 10,
		rowList: [10, 20, 30],
		gridComplete: function() {
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
		jsonReader: { 
			repeatitems: false
		},
		pagerintoolbar:true,
		pagerinBottombar:true,
		search : toUserParamJosn(),
		filterOptionsDefValue:[0],
		prmNames: {
			rows: "rows",
			sort: "sidx",
			order: "sord",
			search : "search"
		},
		toolbar: [true,"top","<input class='but_y_01' onMouseOver=javascript:$(this).attr('class','but_y_02'); onMouseOut=javascript:$(this).attr('class','but_y_01'); id=add type='button' onclick='selectWordTemplate()' value='选择'/>"],
		multiselect: false,
		onCellSelect:function(id,iCol){
		}
	}).navGrid('#gridPager', {
		edit: false,
		add: false,
		del: false,
		search:false,
		refresh:false
	});
});

var toUserParamJosn = function() {
	var str = "{'org_id':'"+org_id+"','org_name':'"+org_name+"',"+
				"'template_name':'"+$('#mb_mc').val()+"','template_id':'"+template_id+"'}";
	return descape(escape(str));
}

/*
函数:  personSearch
说明:  查询用户信息
参数:   无
返回值: 用户列表
*/
var userSearch = function() {
	
var sdata = { //构建查询需要的参数 
	paramJson: toUserParamJosn()
}; 
var postData = $("#gridTable").jqGrid("getGridParam", "postData"); 
$.extend(postData, sdata);
$("#gridTable").jqGrid("setGridParam", {
	search: true, 
	search : toUserParamJosn()
}).trigger("reloadGrid", [{
	page: 1
}]); 
}
var clearSearch = function() {
	resetSingleSearchDialog();
	var sdata = {
		paramJson: toUserParamJosn()
	};
	var postData = $("#gridTable").jqGrid("getGridParam", "postData");
	$.extend(postData, sdata); //将postData中的查询参数覆盖为空值  
	$("#gridTable").jqGrid("setGridParam", {
		search: true // 将jqGrid的search选项设为false  
	}).trigger("reloadGrid", [{
		page: 1
	}]);
};

function selectWordTemplate() {
	var ids = "";
    var j = -1;
    var ids = jQuery("#gridTable").getDataIDs(); //jqGrid('getDataIDs');
    jQuery("input[name=r1]").each(function(i,e){
		if(jQuery(this).is(":checked")){
			j = i;
		}
	})
	var model = jQuery("#gridTable").jqGrid('getRowData',ids[j]);
		
	var template_id_a = model.mb_id;
	if(!IsSpace(template_id_a)){
		var okF = function(){
			var url = "wordtemplatedo.jsp?operationType=docopywordtextinput&template_id_a="+template_id_a;
			document.all.form1.action = url;
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
	
}

var doReturnOK = function(actionType,mess){
	if(mess){
		//alert("操作成功");
		/* getParentWindow("windowId1").search();
		removeAlertWindows('windowId1',true); */
		obj.parent.frames["rightFrame"].search();
		obj.setDefalutTable(jQuery("#tableparm").val());
		obj.closeAlertWindowFun();
		removeAlertWindows('windowId1',true);
		//removeAlertWindows('windowId1',false,true,'',false,'',true);
	}
};
</script>

</head>
<body>
<form name="form1" method="post">
<table width="100%" id="queryTable">
	<tr>
		<td>
			<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tabs_search_ctable_box">
				<tr>
					<td>
					<table width="100%" border="0" cellspacing="0" cellpadding="0"
						class="tabs_search_ctable">
						<tr>
							<th width="90" class="input_cx_title_th">模版名称：</th>
							<td width="296" class="cx_title_td">
								<input name="mb_mc" id="mb_mc" type="text" class="input_cx_title_283" /></td>
								<input name="template_id_a" id="template_id_a" type="hidden"/></td>
								<input name="template_id_b" id="template_id_b" type="hidden" value="<%=template_id_b%>"/></td>
							<td width="385" colspan="2">
								<input name="Input2" value="搜索" type="button" onclick="userSearch()" class="but_y_01" /></td>
						</tr>
					</table>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td>
		<table id="gridTable"></table>
		</td>
	</tr>
</table>
</form>
<iframe name="hiddenFrame" width="0" height="0"></iframe>
</body>
</html>
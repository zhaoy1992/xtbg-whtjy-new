<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%
	String path = request.getContextPath();
	String template_id = request.getParameter("template_id");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<title></title>
<!-- 引入jQuery -->
<script type="text/javascript" src="../jquery1.6/jquery-1.6.min.js"></script>

<!-- 引入jQuery UI -->
<link id="uiThemes" rel="stylesheet" type="text/css" media="screen"
	href="../jquery-ui-1.8.17.custom/css/custom-theme/jquery-ui-1.8.17.custom.css" />
<script
	src="../jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js"
	type="text/javascript"></script>

<!-- 引入jGrid -->
<link rel="stylesheet" type="text/css" media="screen"
	href="../jquery.jqGrid-4.3.1/css/ui.jqgrid.css" />
<script src="../jquery.jqGrid-4.3.1/js/i18n/grid.locale-en.js"
	type="text/javascript" charset="UTF-8"></script>
<script src="../jquery.jqGrid-4.3.1/js/jquery.jqGrid.min.js"
	type="text/javascript" charset="UTF-8"></script>
	
	
<!-- 引入其它 -->
<script src="../../js/util/public.js" type="text/javascript"></script>
<script src="../../js/common/commoncss.js" type="text/javascript"></script>

<script type="text/javascript">
	var template_id = "<%=template_id %>";//模版ID
	
	$(function() {
		$("#gridTable").jqGrid({
			url: '<%= path %>' + '/commonListServlet?classNameId=wordVariableList',  //commonListServlet列表公共的servlet,classNameId在servletBean.xml文件中配置要调用的类,isPage:是否翻页(true,false),默认为true
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
			colNames: ['名称', '取值' , '默认值', '描述', '变量主键ID'],
			//字符串数组，用于指定各列的题头文本，与列的顺序是对应的。
			colModel: [ //最重要的数组之一，用于设定各列的参数
	        {
				name: 'var_name',
				index: 'var_name',
				width: 190
			},
			{
				name: 'var_value',
				index: 'var_value',
				width: 190,
				editable: true
			},
			{
				name: 'var_defaultvalue',
				index: 'var_defaultvalue',
				width: 100,
				editable: true
			},
			{
				name: 'var_desc',
				index: 'var_desc',
				width: 100,
				editable: true
			},
			{
				name: 'var_id',
				index: 'var_id',
				hidden: true
			},
			
			],
			sortname: 'var_id',
			//指定默认的排序列，可以是列名也可以是数字。此参数会在被传递到Server端。
			sortorder: 'desc',
			viewrecords: true,
			
			//设置是否在Pager Bar显示所有记录的总数。
			rowNum: 10,
			//用于设置Grid中一次显示的行数，默认值为20。正是这个选项将参数rows（prmNames中设置的）通过url选项设置的链接传递到Server。注意如果Server返回的数据行数超过了rowNum的设定，则Grid也只显示rowNum设定的行数。
			//rowList: [10, 20, 30],
			//一个数组，用于设置Grid可以接受的rowNum值。例如[10,20,30]
			gridComplete: function() {

			},
			jsonReader: { //这又是一个数组，用来设定如何解析从Server端发回来的json数据
				repeatitems: false
			},
			pager: "#gridPager",
			//定义页码控制条Page Bar
			//caption: "备用列表",
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
			toolbar: [true,"top"],
			multiselect: true,
			ondblClickRow: function(id) {
				updateBl(id);
			}
		}).navGrid('#gridPager', {
			edit: false,
			add: false,
			del: false,
			search: false,
			refresh: false
		});
		
		
		$("#t_gridTable").append("<div>")
		.append("")
		.append("</div>");

	});
	
	/*
	 函数:  toUserParamJosn
	 说明:  构建要查询的参数
	 参数:   无
	 返回值: 返回要查询的参数
	 */
	var toUserParamJosn = function() {
		var str = "{'template_id':'"+template_id+"'}";
		return descape(escape(str));
	}
	
	if(template_id == "") {
	    //template_id = parent.parent.frames["rightFrame"].$("template_id").value;
	}
	var blId = "";
	
	
	
	function saveBl() {
	    if(!validateBL()){
	        return;
	    }
	    var url = "wordtemplatedo.jsp?operationType=dosavevariable";
	   

	    $('#variableform').attr("action",url);
	    $('#variableform').attr("target","hiddenFrame");
		$('#variableform').submit();
	}
	
	function validateBL() {

	    var bl_mc = $("#var_name").val();
		if(template_id == "" || template_id == "null"){
			template_id = parent.parent.frames["rightFrame"].$("template_id").value;
		}
	    if(template_id == "" || template_id == "null") {
	        alert("模版基本信息未保存，请先保存");
	        return false;
	    }
	    
	    if(bl_mc == "") {
	        alert("变量名称不能为空");
	        return false;
	    }
	    /*
	    if(bl_id == "") {
	        var countNum = Variable.isUnique(template_id,bl_mc);
	        if(parseInt(countNum) != 0) {
	            alert("同一模版中的变量名称相同，请重新输入");
	            return false;
	        }
	    }
	    */
	    return true;
	}	

	function updateBl(id){
		
		var model = jQuery("#gridTable").jqGrid('getRowData', id);
		$("#var_id").val(model.var_id);
		$("#var_name").val(model.var_name);
		$("#var_value").val(model.var_value);
		$("#var_defaultvalue").val(model.var_defaultvalue);
		$("#var_desc").val(model.var_desc);

		
	}
	
		/*
		 函数:  deleteBl
		 说明:  删除变量
		 参数:   无
		 返回值: 无
		 */
	var deleteBl = function(id) {
		var ids = "";
		var selectedIds = $("#gridTable").jqGrid("getGridParam", "selarrrow");
		var idsArrTemp = new Array();
		$(selectedIds).each(function () {
			var model = jQuery("#gridTable").jqGrid('getRowData', this);
			if(!IsSpace(model.var_id)){
				idsArrTemp.push(model.var_id);
			}
		});
		
		ids = idsArrTemp.join();

		if (IsSpace(ids)) {
			alert("请选择要删除的变量！");
		} else {
			if (!confirm("确定要删除变量吗？")) {
				return;
			}
			var url = "wordtemplatedo.jsp?operationType=dodeletevariable&ids="+ids;
			 var fm = document.getElementById("variableform");
			 document.all.variableform.action = url;
			 document.all.variableform.target = "hiddenFrame";
			 $('#variableform').submit();
		}
	}

	var refreshGrid = function() {
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
描述：重置变量
*/
function blReset() {
	
	$("input,textarea",".popTableArea").val("");
	
}

function doReturnOK(operationType){
	if(operationType == "dosavevariable" || operationType == "dodeletevariable" ){
		alert("操作成功");
		refreshGrid();
		//parent.frames["ruleItemSubForm"].document.location.reload();//刷新规则项
	}else if(operationType.split("_isUsed").length > 1){
		alert("变量被控件引用，请先删除控件");
	}
}
</script>
</head>
<body>
<form action="" id="variableform" name="variableform" method="post">
<input type = "hidden" id="var_id" name="var_id" >
<input type = "hidden" name = "template_id" value = "<%=template_id %>">

<TABLE class="cQueryTableArea" cellSpacing=0 cellPadding=0 width="100%" align=center border=0>
		<TR>
			<TD>
			<TABLE  class="popTableArea" height="100%" width="100%" border=0>
					<TR>
						<TD class="poptableLable" width="20%">变量名称<FONT color=red>*</FONT></TD>
						<TD colSpan=3><INPUT class="cText_out" id="var_name" name = "var_name" type="text"></TD>
					</TR>
					<TR>
						<TD class="poptableLable" width="20%">变量取值</TD>
						<TD width="30%"><INPUT class="cText_out" id="var_value" name = "var_value" type="text"></TD>
						<TD class="poptableLable" width="20%">默认值</TD>
						<TD width="30%"><INPUT class="cText_out" id="var_defaultvalue" name = "var_defaultvalue"  type="text"></TD>
					</TR>
					<TR>
						<TD class="poptableLable" width="20%">描述</TD>
						<TD width="80%" colSpan=3><TEXTAREA class="cTextarea" id="var_desc" name = "var_desc" ></TEXTAREA></TD>
					</TR>
			</TABLE>
			</TD>
		</TR>
		<TR>
			<TD align=right>
			<input class="cButton_4text" type="button" name="operation" value="保存" onclick="saveBl()" id="btnSave"/>&nbsp;
			<input class="cButton_4text" type="button" name="operation" value="删除" onclick="deleteBl()" id="btnDelete"/>&nbsp;
			<input class="cButton_4text" type="button" name="operation" value="重置" onclick="blReset()" id="btnReset"/>&nbsp;
			<!-- <input class="cButton_Gray" id=btnSave onclick="saveBl()" value="保存"></input>&nbsp;
			<input class="cButton_Gray" id=btnDelete onclick="deleteBl()" value="删除"></input>&nbsp;
			<input class="cButton_Gray" id=btnReset onclick="blReset()" value="重置"></input>&nbsp; -->
			</TD>
		</TR>
		<TR>
			<TD>
				<div class="cGridArea">
					<table id="gridTable"></table>
					<div id="gridPager"></div>
				</div>	
			</TD>
		</TR>
</TABLE>

</form>
<iframe name="hiddenFrame" width=0 height=0></iframe>
</body>
</html>
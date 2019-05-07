<%@ page language="java" contentType="text/html; charset=gbk"
	pageEncoding="gbk"%>
<%
	String path = request.getContextPath();
	String template_id = request.getParameter("template_id");
	/*
	WordTemplateServiceIfc wordTemplate = new  WordTemplateServiceImpl();
	request.setAttribute("variableSelect",wordTemplate.getVariableSelect(template_id));
	request.setAttribute("datasetSelect",wordTemplate.getDatasetSelect(template_id));*/
	
	String sql = "select v.var_id,v.var_name from ta_oa_word_var v where v.template_id='"+template_id+"'";
	String vartypeHtml = DictDropDownList.buildSelect(sql,"bl_name","","",true,"");//信息类型下拉框
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.chinacreator.xtbg.pub.util.DictDropDownList"%><html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
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
		
<!-- 引入其它 -->
<script src="../../js/util/public.js" type="text/javascript"></script>
<script src="../../js/common/commoncss.js" type="text/javascript"></script>

<script language="javascript"
	src="js/wordtemplateutil.js"> </script>	
	
<script type="text/javascript">



var template_id = "";//creator_getQueryString("template_id")== "null"?"":creator_getQueryString("template_id");//模版ID
if(template_id == "") {
    template_id = parent.parent.frames["rightFrame"].$("#template_id").val();
}
var kj_id = "";
//var webOffice = parent.parent.frames["mainFrame"].$("WebOffice").first();
var webOffice = parent.parent.frames["mainFrame"].document.getElementsByName("WebOffice")[0];

$(function() {
	$("#gridTable").jqGrid({
		url: '<%= path %>' + '/commonListServlet?classNameId=ruleItemList',  //commonListServlet列表公共的servlet,classNameId在servletBean.xml文件中配置要调用的类,isPage:是否翻页(true,false),默认为true
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
		colNames: ['控件名称', '取值类型', '取值类型id' , '取值名称', '取值名称id', '控件类型', '变量主键ID', '控件类型value'],
		//字符串数组，用于指定各列的题头文本，与列的顺序是对应的。
		colModel: [ //最重要的数组之一，用于设定各列的参数
        {
			name: 'ruleitem_name',
			index: 'ruleitem_name',
			width: 190
		},
		{
			name: 'ruleitem_value_typename',
			index: 'ruleitem_value_type',
			width: 100,
			editable: true
		},
		{
			name: 'ruleitem_value_type',
			index: 'ruleitem_value_type',
			hidden: true
		},
		{
			name: 'ruleitem_var_name',
			index: 'ruleitem_var_name',
			width: 100,
			editable: true
		},
		{
			name: 'ruleitem_value',
			index: 'ruleitem_value',
			hidden: true
		},
		{
			name: 'control_type',
			index: 'control_type',
			width: 190,
			editable: true
		},
		{
			name: 'ruleitem_id',
			index: 'ruleitem_id',
			hidden: true
		},
		{
			name: 'control_type_value',
			index: 'control_type_value',
			hidden: true
		}
		
		],
		sortname: 'ruleitem_id',
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
			updateRuleItem(id);
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
函数:  toUserParamJosn
说明:  构建要查询的参数
参数:   无
返回值: 返回要查询的参数
*/
var toUserParamJosn = function() {
	var str = "{'template_id':'"+template_id+"'}";
	return descape(escape(str));
}

function kjSave(){
    if(!validateKJ()){
        return;
    }
    var url = "wordtemplatedo.jsp?operationType=dosaveruleitem";
    //$('#rlueitemform').attr("action",url);
    //$('#rlueitemform').attr("target","hiddenFrame");
    document.all.rlueitemform.action = url;
    document.all.rlueitemform.target = "hiddenFrame";
	$('#rlueitemform').submit();
}
function hshs(){
	alert("dfafdda");
}

function kjDelete() {
	var ids = "";
	var selectedIds = $("#gridTable").jqGrid("getGridParam", "selarrrow");
	var idsArrTemp = new Array();
	$(selectedIds).each(function () {
		var model = jQuery("#gridTable").jqGrid('getRowData', this);
		if(!IsSpace(model.ruleitem_id)){
			idsArrTemp.push("'"+model.ruleitem_id+"'");
		}
	});
	
	
	ids = idsArrTemp.join(",");
	
    if(IsSpace(ids)){
        alert("请选择要删除的记录");
        return;
    }
    var url = "wordtemplatedo.jsp?operationType=dodeleteruleitem&ids="+ids;

    $('#rlueitemform').attr("action",url);
    $('#rlueitemform').attr("target","hiddenFrame");
	$('#rlueitemform').submit();

}

	//重置
	function kjResert() {
	    $("#kj_type").val("-1");
	    $("#kj_name").val("");
	    $("#kj_id").val("");
	    $("#bl_name").val("");
	    $("#sjj_name").val("-1");
		var tmp = $("kj_lx");
		tmp.first().prop("checked",true);
	}

	function validateKJ() {
	    var kj_name = $("#kj_name").val();
	    var kj_id = $("#kj_id").value;
	    var kj_type = $("#kj_type").val();
	    var kj_lx = $("#kj_lx").val();
	
	    var bl_name = $("#bl_name").val();
	    var sjj_name = $("#sjj_name").val();
		if(template_id == "" || template_id == "null"){
			template_id = parent.parent.frames["rightFrame"].$("#template_id").val();
		}
	    if(template_id == "" || template_id =="null") {
	        alert("模版基本信息未保存，请先保存");
	        return false;
	    }
	    if(kj_type == "") {
	        alert("控件类型不能为空");
	        return false;
	    }
	    if(kj_name == "") {
	        alert("控件名称不能为空");
	        return false;
	    }
	    /*
	    if(kj_id == "") {
	        var countNum = WordControl.isUnique(template_id,kj_name);
	        if(parseInt(countNum) != 0) {
	            alert("同一模版中的控件名称相同，请重新输入");
	            return false;
	        }
	    }
	    */
	    if(kj_lx == "") {
	        alert("请选择控件取值");
	        return false;
	    }    
	    if(kj_lx =="1" && bl_name =="") {
	        alert("请选择变量");
	        return false;
	    }
	    if(kj_lx =="2" && sjj_name =="") {
	        alert("请选择数据集");
	        return false;
	    }
	    if(kj_type == "orderlyTable") {
	        var wordSelection = webOffice.WebObject.ActiveWindow.Selection;
	        if (!wordSelection.Information(wdWithInTable)) {
	            alert("请先在WORD模版中创建表格");
	            return false;
	        }
	    }
	    return true;
	}

	var listValue  = new Array();//全局参数，在wordtemplatedo.jsp中赋值 
	var kj_name = "";
	//wordtemplatedo.jsp回调函数
	function doReturnOK(operationType){
		if(operationType == "dosaveruleitem"){
			doReturnSaveRuleItem();
		}else if(operationType == "dodeleteruleitem"){
			doReturnDeleteRuleItem();
		}
		parent.parent.frames["mainFrame"].saveTempletFromRight();
		refreshGrid();			
		//document.location.reload();
	}
	
	function doReturnSaveRuleItem(){

		$("#kj_id").val($("#temp_value").val().split("#")[0])
		kjType = $("#kj_type").val(); 

	    if(kjType == "textInput") {
	    	kj_name = "ti_" + $("#kj_name").val();
	    	var tempValue = $("#temp_value").val().split("#")[1];//wordtemplatedo.jsp中赋值
	    	var options = {
					statusText : $("#kj_flag").val(),
					helpText : $("#kj_help").val(),
					defaultValue : tempValue
			};
	    	createTextInput(webOffice.WebObject,kj_name,options);//创建手工输入文本区域
	    }
	   
		alert("操作成功");
	}
	
	function doReturnDeleteRuleItem(){
		var selectedIds = $("#gridTable").jqGrid("getGridParam", "selarrrow");
		var idsArrTemp = new Array();
		var nameArrTemp = new Array();
		$(selectedIds).each(function () {
			var model = jQuery("#gridTable").jqGrid('getRowData', this);
			idsArrTemp.push(model.ruleitem_id);
			nameArrTemp.push(model.ruleitem_name);
		});

		
		ids = idsArrTemp.join(",");
		kj_name = nameArrTemp.join(",");

	    //if(ids.indexOf("ti_") != -1) {//-----------输入框
	       var kjnameobj = kj_name.split(",");
	       for(var i=0; i<kjnameobj.length; i++) {
				rule_Name = "ti_" + kjnameobj[i];
				var isTrue = deleteTextInput(webOffice.WebObject, rule_Name);//WordReportUtil.js
				if(!isTrue) {
					alert("删除手工输入文本区域错误,请联系管理员");
					return;
				} 
	       }
	    //}
	    	
		alert("删除成功");
	}

	function updateRuleItem(id){
		var model = jQuery("#gridTable").jqGrid('getRowData', id);
		
		$("#kj_type").val(model.control_type_value);
		$("#kj_name").val(model.ruleitem_name);
		$("#kj_lx").first().prop("checked",true);
		$("#bl_name").val(model.ruleitem_value);
		$("#cur_kj_id").val(model.ruleitem_id.split("_")[1]);
		$("#kj_flag").val(model.ruleitem_flag);
		$("#kj_help").val(model.ruleitem_help);
	}
</script>
</head>
<body >
<form action="" name="rlueitemform" id="rlueitemform" method="post">
<input type  ="hidden" name = "template_id" value = "<%=template_id %>">
<input type = "hidden" name = "temp_value" id="temp_value" value = ""/>
<input type = "hidden" name = "cur_kj_id" value = ""/>
<input type = "hidden" name = "kj_flag" value = ""/>
<input type = "hidden" name = "kj_help" value = ""/>

<TABLE class="cQueryTableArea" cellSpacing=0 cellPadding=0 width="100%" align=center border=0>
	<TBODY>
		<TR>
			<TD>
			<TABLE  cellSpacing=0 cellPadding=0 width="100%" border=0>
					<TR>
						<TD width="20%" class="poptableLable_new">控件类型<FONT color=red>*</FONT></TD>
						<TD colSpan=3><SELECT id=kj_type name = "kj_type">
							<OPTION value="-1" selected>--请选择--</OPTION>
							<OPTION value=textInput>输入框</OPTION>
						</SELECT></TD>
					</TR>
					<TR>
						<TD width="20%" class="poptableLable">控件名称<FONT color=red>*</FONT><INPUT id=kj_id
							name="kj_id" type="hidden"></TD>
						<TD colSpan=3><INPUT id=kj_name name = "kj_name" style="WIDTH: 100%" type="text"></TD>
					</TR>
					<TR>
						<TD width="20%" rowSpan=2 class="poptableLable">控件取值<FONT color=red>*</FONT></TD>
						<TD width="20%" class="poptableLable"><INPUT id=kj_bllx type=radio value=1 name=kj_lx checked>变量</TD>
						<TD colSpan=2><%=vartypeHtml %></TD>
					</TR>
			</TABLE>
			</TD>
		</TR>
		<TR>
			<TD align=right>
			<input class="cButton_4text" type="button" name="operation" value="保存" onclick="kjSave()" id="btnSave" title = "将在word的光标处增加规则项"/>&nbsp;
			<input class="cButton_4text" type="button" name="operation" value="删除" onclick="kjDelete()" id="btnDelete"/>&nbsp;
			<input class="cButton_4text" type="button" name="operation" value="重置" onclick="kjResert()" id="btnReset"/>&nbsp;
			</TD>
		</TR>
		<TR>
			<TD>
				<!-- 查询列表区 cGridArea(查询区样式)-->
				<div class="cGridArea">
					<table id="gridTable"></table>
					<div id="gridPager"></div>
				</div>
				<!-- 查询列表区 -->
			</TD>
		</TR>
	</TBODY>
</TABLE>

</form>
<iframe name = "hiddenFrame" width=0 height=0></iframe>
</body>
</html>
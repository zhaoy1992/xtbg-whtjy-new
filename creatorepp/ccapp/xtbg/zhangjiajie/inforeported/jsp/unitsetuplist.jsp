<%@page import="com.chinacreator.xtbg.pub.util.DictDropDownList"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
	String path = request.getContextPath();
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	
	String sql = "select infotype_id, infotype_name from ta_oa_infre_info_type";
	String str = DictDropDownList.buildSelect(sql,"infotype_id","","",true,"");
%>
<title>JGRID</title>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>

<!-- 引入jQuery UI -->
<link id="uiThemes" rel="stylesheet" type="text/css" media="screen"
	href="../../../resources/plug/jquery-ui-1.8.17.custom/css/custom-theme/jquery-ui-1.8.17.custom.css" />
<script
	src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js"
	type="text/javascript"></script>

<!-- 引入jGrid -->
<link rel="stylesheet" type="text/css" media="screen"
	href="../../../resources/plug/jquery.jqGrid-4.3.1/css/ui.jqgrid.css" />
<script src="../../../resources/plug/jquery.jqGrid-4.3.1/js/i18n/grid.locale-en.js"
	type="text/javascript"></script>
<script src="../../../resources/plug/jquery.jqGrid-4.3.1/js/jquery.jqGrid.min.js"
	type="text/javascript"></script>

<!-- 引入jQuery_dialog -->
<link rel="stylesheet" type="text/css" media="screen"
	href="../../../resources/plug/jquery_dialog/jquery_dialog.css" />
<script src="../../../resources/plug/jquery_dialog/jquery_dialog.js"></script>

<!-- 引入其它 -->
<script src="../../../resources/js/util/public.js" type="text/javascript"></script>
<script src="../../../resources/js/common/commoncss.js" type="text/javascript"></script>


<script type="text/javascript">
$(function() {
	$("#gridTable").jqGrid({
		url: '<%= path %>' + '/commonListServlet?classNameId=unitsetuplist',  //commonListServlet列表公共的servlet,classNameId在servletBean.xml文件中配置要调用的类,isPage:是否翻页(true,false),默认为true
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
		colNames: ['单位设置id', '机构id', '信息类型ID', '上报单位 ', '信息类型 ', '类型描述 '],
		//字符串数组，用于指定各列的题头文本，与列的顺序是对应的。
		colModel: [ //最重要的数组之一，用于设定各列的参数
		{
			name: 'unitsetup_id',
			index: 'unitsetup_id',
			hidden: true
		},
		{
			name: 'org_id',
			index: 'org_id',
			hidden: true
		},
		{
			name: 'infotype_id',
			index: 'infotype_id',
			hidden: true
		},
		{
			name: 'unitsetup_name',
			index: 'unitsetup_name',
			width: 180,
			search: true
		},
		{
			name: 'infotype_name',
			index: 'infotype_name',
			width: 230,
			search: true
		},
		{
			name: 'infotype_desc',
			index: 'infotype_desc',
			search: true
		}
		],
		sortname: 'unitsetup_id',
		//指定默认的排序列，可以是列名也可以是数字。此参数会在被传递到Server端。
		sortorder: 'desc',
		viewrecords: true,
		
		//设置是否在Pager Bar显示所有记录的总数。
		rowNum: 10,
		//用于设置Grid中一次显示的行数，默认值为20。正是这个选项将参数rows（prmNames中设置的）通过url选项设置的链接传递到Server。注意如果Server返回的数据行数超过了rowNum的设定，则Grid也只显示rowNum设定的行数。
		rowList: [10, 20, 30],
		//一个数组，用于设置Grid可以接受的rowNum值。例如[10,20,30]
		jsonReader: { //这又是一个数组，用来设定如何解析从Server端发回来的json数据
			repeatitems: false
		},
		pager: "#gridPager",
		//定义页码控制条Page Bar
		//caption: "上报单位列表",
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
			updateUnitsetup(id);
		}
	}).navGrid('#gridPager', {
		edit: false,
		add: false,
		del: false,
		search:false,
		refresh:false
	});
	
	
	//操作按钮区  cOprArea(操作区样式)
	$("#t_gridTable").append("<div>")
							.append("<input class='add' id=add type='button' onclick='addUnitsetup()' value=''/>")
							.append("<input class='del' id=del type='button' onclick='delUnitsetup()' value=''/>")
					 .append("</div>");
	
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
	var str = "{'org_id':'" + $("#org_id").val() + "','infotype_id':'" + $("#infotype_id").val() + "'}";
	return descape(escape(str));
}

/*
	 函数:  unitsetupSearch
	 说明:  查询上报单位
	 参数:   无
	 返回值: 上报单位列表
	 */
var unitsetupSearch = function() {
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

/*
	 函数:  resetSingleSearchDialog
	 说明:  清空值查询值
	 参数:   无
	 返回值: 无
	 */
var resetSingleSearchDialog = function() { 
	$(":text", "#queryTable").val("");
	$(":hidden", "#queryTable").val("");
	$("select:first option:first").attr("selected","selected");
};

/*
	 函数:  addUnitsetup
	 说明:  添加上报单位
	 参数:   无
	 返回值: 无
	 */
var addUnitsetup = function() {
	JqueryDialog.Open1('添加上报单位', 'addorupdateunitsetup.jsp', 500, 250, true, true, true);
}

/*
	 函数:  updateUnitsetup
	 说明:  修改上报单位
	 参数:   无
	 返回值: 无
	 */
var updateUnitsetup = function(id) {
	var model = jQuery("#gridTable").jqGrid('getRowData', id);
	JqueryDialog.Open('修改上报单位', 'addorupdateunitsetup.jsp?unitsetup_id=' + model.unitsetup_id, 500, 200, true, true, true);
}

/*
	 函数:  delUnitsetup
	 说明:  删除上报单位
	 参数:   无
	 返回值: 无
	 */
var delUnitsetup = function(id) {
	var ids = "";
	var selectedIds = $("#gridTable").jqGrid("getGridParam", "selarrrow");
	var idsArrTemp = new Array();
	$(selectedIds).each(function () {
		var model = jQuery("#gridTable").jqGrid('getRowData', this);
		if(!IsSpace(model.infotype_id)){
			idsArrTemp.push(model.unitsetup_id);
		}
	});
	
	ids = idsArrTemp.join();

	if (IsSpace(ids)) {
		alert("请选择要删除上报单位！");
	} else {
		if (!confirm("确定要删除上报单位吗？")) {
			return;
		}
		$("#unitsetup_ids").val(ids);
		var fm = document.getElementById("delForm");
		fm.target = "hiddenFrame";
		fm.submit();
	}
}

var chooseOrg = function (){
	var url = "../../tree/jsp/orgtree.jsp?ischeck=true";

	 var orgObj= null;
	 orgObj = window.showModalDialog(url,"","dialogWidth=286px;dialogHeight=596px;center:yes;scroll:no");
	 if(!IsSpace(orgObj)){
		 $('#org_id').val(orgObj.id);
		 $('#org_name').val(orgObj.name);
	 }
}

</script>
</head>
<body>
<div>
	<table width="100%" >
		<tr>
			<td>
				<!-- 查询条件选区    cQueryTableArea(查询table样式), tableLable(文字td样式),tableValue(文本值样式),cText_out(可输入的文本框样式) -->
				<table  id="queryTable" class="cQueryTableArea">
					<tr>
						<td width="10%" class="tableLable">
							上报单位
						</td>
						<td width="25%" class="tableValue" >
							<input class="cText_out" style="width:80%"
							 id="org_name" name="org_name" 
							value=""
							readOnly size=13 onclick='chooseOrg()'>
					  <input type="hidden" id=org_id name=org_id/>
					  <img
							style="POSITION: static; WIDTH: 18px; HEIGHT: 16px;"
							id=img1  alt=选择受理单位 onclick='chooseOrg()'
							src="../../../resources/images/zoom_in2.gif"></td>
						<td width="15%" class="tableLable" width="20%">信息类型</td>
						<td width="25%" class="tableValue" width="30%">
							<%=str %>
						</td>
						<td width="30%"></td>
					</tr>
					<tr class="cQueryFunArea">
						<td colspan="5">
							<input class="cButton" type="button" id="sel"  value="查询" onclick="unitsetupSearch()" />
							<input class="cButton" type="button" id="resert" value="重置" onclick="clearSearch()" />
						</td>
					</tr>
				</table>
					<!-- 查询条件区 -->
			</td>
			</tr>
				<!-- 查询功能区 cQueryFunArea(查询区样式), cButton(按钮样式)-->
					
			
						<!-- 查询功能区 -->

	</table>
	
	<!-- 查询列表区 cGridArea(查询区样式)-->
	<div class="cGridArea">
		<table id="gridTable"></table>
		<div id="gridPager"></div>
	</div>
	<!-- 查询列表区 -->
	
</div>	
	<form id="delForm" name="delForm" method="post" action="addorupdateunitsetupdo.jsp">
		<input type="hidden" name="unitsetup_ids" id="unitsetup_ids" />
		<input type="hidden" name="action" value="del" />
	</form>
	
	<iframe name="hiddenFrame" width=0 height=0></iframe>
</body>
</html>
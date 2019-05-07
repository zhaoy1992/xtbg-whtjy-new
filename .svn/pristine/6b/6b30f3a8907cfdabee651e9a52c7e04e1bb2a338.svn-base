<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="com.chinacreator.xtbg.zhangjiajie.inforeported.dao.InfoStaDao" %>
<%@ page import="com.chinacreator.xtbg.zhangjiajie.inforeported.dao.imploracle.InfoStaDaoImpl" %>
<%@page import="com.chinacreator.xtbg.pub.util.DaoImplClassUtil"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%
	InfoStaDao infoStaDao = (InfoStaDaoImpl)DaoImplClassUtil.getDaoImplClass("infoStaDaoImpl");
	String getTypeSelectHtml=infoStaDao.getTypeSelectHtml();
	String path = request.getContextPath();
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	String loginUserName = accesscontroler.getUserAccount();
%>
<%@page import="com.chinacreator.security.AccessControl"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" media="screen"
	href="../../../resources/css/testcss.css" />
<link rel="stylesheet" type="text/css" media="screen"
	href="../../../resources/css/Table.css" />
<link rel="stylesheet" type="text/css" media="screen"
	href="../../../resources/css/Element.css" />
<!-- 引入jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>

<!-- 引入jQuery UI -->
<link id="uiThemes" rel="stylesheet" type="text/css" media="screen"
	href="../../../resources/plug/jquery-ui-1.8.17.custom/css/custom-theme/jquery-ui-1.8.17.custom.css" />
<script
	src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js"
	type="text/javascript"></script>
<script
	src="../../../resources/plug/My97DatePicker/WdatePicker.js"
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
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<title>待办列表</title>
<script type="text/javascript">
var loginUserName = '<%=loginUserName%>';
var orgID=null;
$(function() {
	$(document).keydown(function(){
		if(event.keyCode == 13){ 
			userSearch();
		}
	});
	
	$("#gridTable").jqGrid({
		url: '<%= path %>' + '/commonListServlet?classNameId=infoStatisticsList',  //commonListServlet列表公共的servlet,classNameId在servletBean.xml文件中配置要调用的类,isPage:是否翻页(true,false),默认为true
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
		colNames: ['单位名称','上报数量','采编数量','信息类型'],
		//字符串数组，用于指定各列的题头文本，与列的顺序是对应的。
		colModel: [ //最重要的数组之一，用于设定各列的参数
           {
   			name: 'org_name',
   			index: 'org_name',
   		},
   		{
   			name: 'upNum',
   			index: 'upNum',
    	},
    	{
   			name: 'publishNum',
   			index: 'publishNum',
    	},
    	{
   			name: 'infotype',
   			index: 'infotype',
    	},
		],
		sortname: 'org_name',
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
				be = "<button id='modify' class='ui-button ui-button-text-only ui-widget ui-state-default ui-corner-all' onclick='showFlowHistory("+cl+")'>" + 
			     "<span class='ui-button-text'>办件历史</span>" +
				 "</button> ";
				jQuery("#gridTable").jqGrid('setRowData', ids[i], {
					act: be
				});
			}
		},
		
		jsonReader: { //这又是一个数组，用来设定如何解析从Server端发回来的json数据
			repeatitems: false
		},
		pager: "#gridPager",
		//定义页码控制条Page Bar
		//caption: "",
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
		multiselect: false,
		ondblClickRow: function(id) {
			//handle(id);
		}
	}).navGrid('#gridPager', {
		edit: false,
		add: false,
		del: false,
		search:false,
		refresh: false,
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
	paramJson: descape(escape("{'infotype_id':''}"))
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
	var str = "{'username':'"+loginUserName+"','infotype_id':'"+$("#cbox2").val()+"',"+
			  "'org_name':'"+$('#org_name').val()+"','org_id':'"+orgID+"',"+
			  "'input_date':'"+$('#startSlTime').val()+"','end_date':'"+$('#endSlTime').val()+"'}";
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
    var model = jQuery("#gridTable").jqGrid('getRowData', id);
    var url = "";
    if(model.actiontype_code == "01") {
    	url = "../../../resources/plug/workflow/jsp/commonflowstart.jsp?ins_id="+model.ins_id+"&busi_id="+model.busi_id+"&actInsId="+model.actInsId+"&cc_form_instanceid="+model.cc_form_instanceid+"&def_id="+model.def_id+"&procId="+model.procId+"&action_defid="+model.action_defid+"&list_type=worklist&operType=daiban";
    } else if (model.actiontype_code == "02") {
    	url = "../../../resources/plug/workflow/jsp/commonflowapprove.jsp?ins_id="+model.ins_id+"&busi_id="+model.busi_id+"&actInsId="+model.actInsId+"&cc_form_instanceid="+model.cc_form_instanceid+"&def_id="+model.def_id+"&procId="+model.procId+"&action_defid="+model.action_defid+"&list_type=worklist&operType=daiban";
    } else {
    	url = "../../../resources/plug/workflow/jsp/commonflowend.jsp?ins_id="+model.ins_id+"&busi_id="+model.busi_id+"&actInsId="+model.actInsId+"&cc_form_instanceid="+model.cc_form_instanceid+"&def_id="+model.def_id+"&procId="+model.procId+"&action_defid="+model.action_defid+"&list_type=worklist&operType=daiban";
    }
    window.parent.location = url,"perspective_content";
}
function chooseOrg(id){
	var url = "../../tree/jsp/orgtree.jsp";
	 var orgObj= null;
	 orgObj = window.showModalDialog(url,"","dialogWidth=286px;dialogHeight=596px;center:yes;scroll:no");
	 if(!IsSpace(orgObj)){
		 var name=orgObj.name;
			orgID=orgObj.id;
			$("#org_name").val(name);
	 }
	
}

window.onload = function () {
	setDataTimeClickShowOrHide('startSlTime',window);
	setDataTimeClickShowOrHide('endSlTime',window);
}
</script>
</head>
<body>


<table width="100%" class="cQueryTableArea" id="queryTable">
	<tr>
		<td width="79" class="tableLable">上报单位 </td>
	  <td width="350" class="tableValue"><INPUT class="cText_out" style="width:80%"
			 id="org_name" name="org_name" 
			value=""
			size=13 >
      </td>
		<td width="81" class="tableLable">信息类型</td>
	  <TD width="240" class="tableValue" ><%=getTypeSelectHtml%> </TD>
		 <td width="429"></td>
	</tr>
	<tr>
		<td class="tableLable">上报时间</td>
	  <td class="tableValue"><input  type="text" id="startSlTime" name="startSlTime" class="input_date Wdate" onclick="WdatePicker()"/>
	    <span class="tableLable">至
	    <input  type="text" id="endSlTime" name="endSlTime" class="input_date Wdate" onclick="WdatePicker()"/>
	    </span></td>
		<td class="tableLable">&nbsp;</td>
		<td class="tableValue">&nbsp;</td>
		<td></td>
	</tr>
		
		<!-- 查询功能区 cQueryFunArea(查询区样式), cButton(按钮样式)-->
		<tr class="cQueryFunArea" >
			<td colspan="5">
				<input class="cButton" type="button" id="sel"  value="统计" onClick="userSearch()" />
				<input class="cButton" type="button" id="resert" value="重置" onClick="clearSearch()" />			</td>
		</tr>
		
		<!-- 查询功能区 -->
	</table>
	<div class="cGridArea">
		<table id="gridTable"></table>
		<div id="gridPager"></div>
	</div>
</body>
</html>

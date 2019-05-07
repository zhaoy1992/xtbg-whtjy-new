<%@ page contentType="text/html; charset=GBK"%>
<%@page import="com.chinacreator.xtbg.pub.util.StringUtil"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title></title>
<%
	String path = request.getContextPath();
	String orgid = request.getParameter("orgid");
	String orgname = java.net.URLDecoder.decode(StringUtil.deNull(request.getParameter("orgname")),"UTF-8");
	//System.out.println("orgname;::"+orgname);
%>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script src="../../../resources/js/util/public.js" type="text/javascript"></script>
<script src="../../../resources/js/common/commoncss.js" type="text/javascript"></script>
<!-- 引入jQuery UI -->
<link id="uiThemes" rel="stylesheet" type="text/css" media="screen" href="../../../resources/plug/jquery-ui-1.8.17.custom/css/custom-theme/jquery-ui-1.8.17.custom.css" />
<script src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript" ></script>



<!-- 引入jGrid -->
<link rel="stylesheet" type="text/css" media="screen" href="../../../resources/plug/jquery.jqGrid-4.3.1/css/ui.jqgrid.css" charset='utf-8'/>
<script src="../../../resources/plug/jquery.jqGrid-4.3.1/js/i18n/grid.locale-en.js" type="text/javascript" charset='utf-8'></script>
<script src="../../../resources/plug/jquery.jqGrid-4.3.1/js/jquery.jqGrid.min.js" type="text/javascript" charset='utf-8'></script>

<!-- 引入其它 -->
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<script src="../../../resources/js/util/public.js" type="text/javascript"></script>
<script src="../../../resources/js/common/commoncss.js" type="text/javascript"></script>

<script type="text/javascript">
$(function() {
	$("#gridTable").jqGrid({
		url: '<%= path %>' + '/commonListServlet?classNameId=wc_appStoreGrantList',  //commonListServlet列表公共的servlet,classNameId在servletBean.xml文件中配置要调用的类,isPage:是否翻页(true,false),默认为true
		//jqGrid控件通过这个参数得到需要显示的数据，具体的返回值可以使XML也可以是Json
		datatype: "json",
		//这个参数用于设定将要得到的数据类型。我最常用的是“json”，其余的类型还包括：xml、xmlstring、local、javascript、function
		mtype: "POST",
		//定义使用哪种方法发起请求，GET或者POST
		height: "100%",//270
		//Grid的高度，可以接受数字、%值、auto，默认值为150
		//width ：200, //Grid的宽度，如果未设置，则宽度应为所有列宽的之和；如果设置了宽度，则每列的宽度将会根据shrinkToFit选项的设置，进行设置。
		//shrinkToFit ：true 此选项用于根据width计算每列宽度的算法。默认值为true。如果shrinkToFit为true且设置了width值，则每列宽度会根据width成比例缩放；如果shrinkToFit为false且设置了width值，则每列的宽度不会成比例缩放，而是保持原有设置，而Grid将会有水平滚动条
		autowidth: true,
		//默认值为false。如果设为true，则Grid的宽度会根据父容器的宽度自动重算。重算仅发生在Grid初始化的阶段；如果当父容器尺寸变化了，同时也需要变化Grid的尺寸的话，则需要在自己的代码中调用setGridWidth方法来完成。
		colNames: ['应用ID', '应用名称 '],
		//字符串数组，用于指定各列的题头文本，与列的顺序是对应的。
		colModel: [ //最重要的数组之一，用于设定各列的参数
		{
			name: 'appid',
			index: 'appid',
			hidden: true
		},
		{
			name: 'name',
			index: 'name',
			width: 180,
			search: true,
			editable: true
		},
		],
		sortname: 'lastupdatetime',
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
			}
		},
		jsonReader: { //这又是一个数组，用来设定如何解析从Server端发回来的json数据
			repeatitems: false
		},
		//pager: "#gridPager",
		//定义页码控制条Page Bar
		pagerintoolbar:true,//上面的分页条
		pagerinBottombar:true,//下面的分页条	
		caption: "<span style='color:blue'>未分配应用</span>",
		//设置Grid表格的标题，如果未设置，则标题区域不显示。
		search : toAppStoreParamJosn(),
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
			toAddApp(id);
		}
	}).navGrid('#gridPager', {
		edit: false,
		add: false,
		del: false,
		search: false,
		refresh:false
	});
});

/*
函数:  toAppStoreParamJosn
说明:  构建要查询的参数
参数:   无
返回值: 返回要查询的参数
*/
var toAppStoreParamJosn = function() {
	var orgidstr = "<%=orgid%>";
var str = "{'remark':'" + orgidstr + "'}";
return descape(escape(str));
}

//双击添加分配
function toAddApp(id){
	fpAppStore();
}

/*
函数:  fpAppStore
说明:  分配应用
参数:   无
返回值: 无
*/
var fpAppStore = function(id) {
var ids = "";
var selectedIds = $("#gridTable").jqGrid("getGridParam", "selarrrow");
for(var i = 0; i < selectedIds.length; i++) {
	var model = jQuery("#gridTable").jqGrid('getRowData', selectedIds[i]);
	 if("" != ids){			   
		ids += ",";
	 }
	 ids += "'"+model.appid+"'";
	 
}
if (IsSpace(ids)) {
	alert("请选择要分配的记录！");
} else {
	$("#appIds").val(ids);
	var fm = document.getElementById("fpForm");
	fm.target = "hiddenFrame";
	fm.submit();
}
}

/* 已分配列表函数 */
$(function() {
	$("#gridTable_grant").jqGrid({
		url: '<%= path %>' + '/commonListServlet?classNameId=wc_appPermissionList',  //commonListServlet列表公共的servlet,classNameId在servletBean.xml文件中配置要调用的类,isPage:是否翻页(true,false),默认为true
		//jqGrid控件通过这个参数得到需要显示的数据，具体的返回值可以使XML也可以是Json
		datatype: "json",
		//这个参数用于设定将要得到的数据类型。我最常用的是“json”，其余的类型还包括：xml、xmlstring、local、javascript、function
		mtype: "POST",
		//定义使用哪种方法发起请求，GET或者POST
		height: "100%",//270
		//Grid的高度，可以接受数字、%值、auto，默认值为150
		//width ：200, //Grid的宽度，如果未设置，则宽度应为所有列宽的之和；如果设置了宽度，则每列的宽度将会根据shrinkToFit选项的设置，进行设置。
		//shrinkToFit ：true 此选项用于根据width计算每列宽度的算法。默认值为true。如果shrinkToFit为true且设置了width值，则每列宽度会根据width成比例缩放；如果shrinkToFit为false且设置了width值，则每列的宽度不会成比例缩放，而是保持原有设置，而Grid将会有水平滚动条
		autowidth: true,
		//默认值为false。如果设为true，则Grid的宽度会根据父容器的宽度自动重算。重算仅发生在Grid初始化的阶段；如果当父容器尺寸变化了，同时也需要变化Grid的尺寸的话，则需要在自己的代码中调用setGridWidth方法来完成。
		colNames: ['注册ID', '应用名称 '],
		//字符串数组，用于指定各列的题头文本，与列的顺序是对应的。
		colModel: [ //最重要的数组之一，用于设定各列的参数
		{
			name: 'pid',
			index: 'pid',
			hidden: true
		},
		{
			name: 'appname',
			index: 'appname',
			width: 180,
			search: true,
			editable: true
		},
		],
		sortname: 'pid',
		//指定默认的排序列，可以是列名也可以是数字。此参数会在被传递到Server端。
		sortorder: 'asc',
		viewrecords: true,
		
		//设置是否在Pager Bar显示所有记录的总数。
		rowNum: 10,
		//用于设置Grid中一次显示的行数，默认值为20。正是这个选项将参数rows（prmNames中设置的）通过url选项设置的链接传递到Server。注意如果Server返回的数据行数超过了rowNum的设定，则Grid也只显示rowNum设定的行数。
		rowList: [10, 20, 30],
		//一个数组，用于设置Grid可以接受的rowNum值。例如[10,20,30]
		gridComplete: function() { // var idss=jQuery("#gridTable").jqGrid('getColNames');
			// alert(idss);
			var ids = $("#gridTable_grant").getDataIDs(); //jqGrid('getDataIDs');
			for (var i = 0; i < ids.length; i++) {
				var cl = ids[i];
			}
		},
		jsonReader: { //这又是一个数组，用来设定如何解析从Server端发回来的json数据
			repeatitems: false
		},
		//pager: "#gridPager_grant",
		//定义页码控制条Page Bar
		pagerintoolbar:true,//上面的分页条
		pagerinBottombar:true,//下面的分页条	
		caption: "<span style='color:blue'>已分配应用</span>",
		toolbar: [true,"top"],
		//设置Grid表格的标题，如果未设置，则标题区域不显示。
		search :toAppStoreParamJosn(),
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
		ondblClickRow: function(id) {
			toRemoveApp(id);
		}
	}).navGrid('#gridPager_grant', {
		edit: false,
		add: false,
		del: false,
		search: false,
		refresh:false
	});
});

/*
函数:  delAppStore
说明:  取消分配应用
参数:   无
返回值: 无
*/
var delAppStore = function(id) {
var ids = "";
var selectedIds = $("#gridTable_grant").jqGrid("getGridParam", "selarrrow");
for(var i = 0; i < selectedIds.length; i++) {
	var model = jQuery("#gridTable_grant").jqGrid('getRowData', selectedIds[i]);
	 if("" != ids){			   
		ids += ",";
	 }
	 ids += "'"+model.pid+"'";
	 
}
if (IsSpace(ids)) {
	alert("请选择要取消已分配的记录！");
} else {
	$("#pids").val(ids);
	var fm = document.getElementById("delForm");
	fm.target = "hiddenFrame";
	fm.submit();
}
}

//双击移除分配
function toRemoveApp(id){
	delAppStore();
}


</script>

</head>
<body style="margin-top: 20px;overflow:auto;">
    &nbsp;<br/>
	<center><b><font size='5'>虚拟应用注册</font></b></center>
	<p></p>
	机构：<%=orgname%>[<%=orgid %>]	
<div>        
	<table>
	   <tr>
		    <td>
			   	<!-- 查询列表区 cGridArea(查询区样式)-->
			   	
				<div class="cGridArea" style="width: 350px">
					<table id="gridTable"></table>
					<div id="gridPager"></div>
				</div>
				<!-- 查询列表区 -->
			</td>
			<td>&nbsp;</td>
			<td>
				<button onclick="fpAppStore();" class="but_y_01">→</button><br/><br/>
				<button onclick="toRemoveApp();" class="but_y_01">←</button>
			</td>
			<td>&nbsp;</td>
			<td>	
				<!-- 查询列表区 cGridArea_grant(查询区样式)-->
				<div class="cGridArea_grant" style="width: 350px">
					<table id="gridTable_grant">
					<div id="gridPager_grant"></div>
					</table>
				</div>
				<!-- 查询列表区 -->
			</td>
		</tr>
	</table>
</div>	
	<form id="fpForm" name="fpForm" method="post" action="apppermissioncontroldo.jsp">
		<input type="hidden" name="appIds" id="appIds" />
		<input type="hidden" name="orgid" id="orgid"  value="<%=orgid%>"/>
		<input type="hidden" name="orgname" id="orgname" value="<%=orgname%>" />
		<input type="hidden" name="action" value="fp" />
	</form>
	
	<form id="delForm" name="delForm" method="post" action="apppermissioncontroldo.jsp">
		<input type="hidden" name="pids" id="pids" />
		<input type="hidden" name="orgid" id="orgid"  value="<%=orgid%>"/>
		<input type="hidden" name="orgname" id="orgname" value="<%=orgname%>" />
		<input type="hidden" name="action" value="del" />
	</form>
	
	<iframe name="hiddenFrame" width=0 height=0></iframe>
	<input type="hidden" id="name" name="name" />
	<input type="hidden" id="apptype" name="apptype" />
</body>
</html>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%
	String path = request.getContextPath();
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	String t_os_ob_ids = request.getParameter("t_os_ob_ids");//物品明细ID
%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>申购部门申购数量列表</title>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>
<script src="../../../resources/plug/jquery.jqGrid-4.3.1/js/i18n/grid.locale-en.js" type="text/javascript"></script>
<script src="../../../resources/plug/jquery.jqGrid-4.3.1/js/jquery.jqGrid.min.js" type="text/javascript"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js"></script>
<!-- 引入其它 -->
<script src="../../../resources/js/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>

<script type="text/javascript">
$(function() {
	//接收表
	$("#gridTable1").jqGrid({
		url: '<%= path %>' + '/pubListServlet?classNameId=com.chinacreator.xtbg.tjy.officesupplies.list.OSExaShowOrgList',  //commonListServlet列表公共的servlet,classNameId在servletBean.xml文件中配置要调用的类,isPage:是否翻页(true,false),默认为true
		datatype: "json",
		mtype: "POST",
		height: "100%",//270
		width : '300px', //Grid的宽度，如果未设置，则宽度应为所有列宽的之和；如果设置了宽度，则每列的宽度将会根据shrinkToFit选项的设置，进行设置。
		autowidth: true,
		colModel: [ 
		 {
			  label:"机构ID",
			  name: 't_org_id',
			  index: 't_org_id',
			  hidden:true
		 },	
		 {
			label:"申购部门",
   			name: 't_org_name',
   			index: 't_org_name',
   			edit:false,
   			width: '60px'
   		},
   		{
   			label:"申购数量",
   			name: 'counts',
   			index: 'counts',
   			edit:false,
   			width: '80px'
   		}
		],
		sortname: 't_org_id',
		sortorder: 'desc',
		viewrecords: true,
		
		rowNum: 1500,
		//rowList: [10, 20, 30],
		jsonReader: { 
			repeatitems: false
		},
		//pagerintoolbar:true,//上面的分页条
		//pagerinBottombar:true,//下面的分页条
		search : toParamJosn(),
		prmNames: { 
			rows: "rows",
			sort: "sidx",
			order: "sord",
			search : "search"
		},
		//toolbar: [true,"top"],
		multiselect: false
	}).navGrid('#gridPager1', {
		edit: false,
		add: false,
		del: false,
		search:false,
		refresh: false
	});

});

function toParamJosn(){
	var str = "{'t_os_ob_id':'<%=t_os_ob_ids%>'}";
	return escape(str);
}
/*
函数:  clearSearch
说明:  重置
参数:   无
返回值: 无
*/
var clearSearch1 = function() {
	resetSingleSearchDialog();
var sdata = {
	paramJson: toUserParamJosn1()
};
var postData = $("#gridTable1").jqGrid("getGridParam", "postData");
$.extend(postData, sdata); //将postData中的查询参数覆盖为空值  
$("#gridTable1").jqGrid("setGridParam", {
	search: true // 将jqGrid的search选项设为false  
}).trigger("reloadGrid", [{
	page: 1
}]);

};

</script>
</head>
<body style="overflow-y:auto;" class="vcenter">
<table width="100%">
		<tr>
			<td>
				<div class="cGridArea">
					<table id="gridTable1"></table>
					<div id="gridTable1"></div>
				</div>
			</td>
		</tr>
	</table>
</body>
</html>

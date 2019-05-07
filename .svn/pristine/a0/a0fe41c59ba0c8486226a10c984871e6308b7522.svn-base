<%@page import="com.chinacreator.xtbg.core.common.util.DaoUtil"%>
<%@page import="com.chinacreator.xtbg.core.file.util.FileUtil"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	//当前用户信息
	String user_id = accesscontroler.getUserID();
	String user_name = accesscontroler.getUserName();
	//当前用户机构
	String org_id = accesscontroler.getChargeOrgId();
	String orgName = accesscontroler.getChargeOrgName();
	
	
	String GET_LIST_CLASS1="com.chinacreator.xtbg.tjy.detectionsupplies.list.OsofficeAccountList";
	String path = request.getContextPath();
	
	//是否查询本部门固定资产台帐信息
	String sql1 = "select decode((select count(*) from td_sm_organization t where t.org_level = '2' and t.org_id = '"+org_id+"'),'1',org.org_id,'') as counts from td_sm_organization org where org.org_id='"+org_id+"'";
	String orgResult = DaoUtil.sqlToField(sql1);
	String OfficeOrg_id ="";
	if(!StringUtil.isBlank(orgResult)){
		OfficeOrg_id = org_id;
	}
	boolean orgOfficeManage= FileUtil.isRolesUser(user_id,"部门分院台帐管理员");
	boolean adminOfficeManage= FileUtil.isRolesUser(user_id,"台帐管理员");
	if(adminOfficeManage==true){
		OfficeOrg_id="";
	}
%>
<title>固定资产台账管理列表</title>
<!-- 公共部分开始 -->
<!-- 引入jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<!-- 引入jQuery UI -->
<script src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>
<!-- 引入my97时间控件 -->
<script src="../../../resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<!-- 引入jGrid -->
<script src="../../../resources/plug/jquery.jqGrid-4.3.1/js/i18n/grid.locale-en.js" type="text/javascript"></script>
<script src="../../../resources/plug/jquery.jqGrid-4.3.1/js/jquery.jqGrid.min.js" type="text/javascript"></script>
<!-- 引入其它 -->
<script src="../../../resources/js/util/public.js" type="text/javascript"></script>
<script src="../../../resources/js/common/commoncss.js" type="text/javascript"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js"charset="utf-8"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script> 
<!-- 公共部分引用结束 -->
<script type="text/javascript">
//部门/分院台帐管理员
var orgOfficeManage ="<%=orgOfficeManage%>";
//台帐管理员
var adminOfficeManage ="<%=adminOfficeManage%>";
$(function() {
	$(document).keydown(function(){
		if(event.keyCode == 13){ 
			userSearch();
		}
		});
//tab2
	$("#gridTable").jqGrid({
		url: '<%= path %>' + '/pubListServlet?classNameId=<%=GET_LIST_CLASS1%>',  
		datatype: "json",
		mtype: "POST",
		height: "100%",//270
		autowidth: true,
		colNames: ['机构ID ','部门/分院', '最后修改时间','使用资产数量'],
		colModel: [ //最重要的数组之一，用于设定各列的参数
		{
			name: 'org_id',
			index: 'org_id',
			width: 100,
			hidden: true
		},
		{
			name: 'org_name',
			index: 'org_name',
			width: 100
		},
		{
			name: 'receive_day',
			index: 'receive_day',
			width: 100
		},
		{
			name: 'zccount',
			index: 'zccount',
			width: 100
		}
		],
		sortname: 'org_id',
		//指定默认的排序列，可以是列名也可以是数字。此参数会在被传递到Server端。
		sortorder: 'asc',
		viewrecords: true,
		rowNum: 15,
		rowList: [10, 20, 30],
		//一个数组，用于设置Grid可以接受的rowNum值。例如[10,20,30]
		gridComplete: function() { // var idss=jQuery("#gridTable").jqGrid('getColNames');
			var ids = $("#gridTable").getDataIDs(); //jqGrid('getDataIDs');
			for (var i = 0; i < ids.length; i++) {
				var cl = ids[i];
				
			}
		},
		jsonReader: { //这又是一个数组，用来设定如何解析从Server端发回来的json数据
			repeatitems: false
		},
		pagerintoolbar:true,//上面的分页条
		pagerinBottombar:true,//下面的分页条
		//定义页码控制条Page Bar
		//caption: "来文缓急维护",
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
		toolbar:[true, "top" ,""],
		multiselect: false,
		onCellSelect:function (id,iCol)
		{
			if(iCol != 0)
			{
				updateLevel(id);
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
	 函数:  toUserParamJosn
	 说明:  构建要查询的参数
	 参数:   无
	 返回值: 返回要查询的参数
	 */
var toUserParamJosn = function() {
	var str = "{'org_id':'<%=OfficeOrg_id%>','org_name':'" + StringCheck($("#org_name").val()) +
		"'}";
	return descape(escape(str));
}
/*
函数:  StringCheck
说明:  做查询时通配符处理问题
参数:   obj 文本框上获得的值
返回值: 返回转换后的值
*/
function StringCheck(obj){
	return obj.replaceAll('%','----').replaceAll('_','----').replaceAll(' ','----');
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
	 函数:  clearSearch
	 说明:  重置
	 参数:   无
	 返回值: 无
	 */
var clearSearch = function() {
	var sdata = {
		paramJson: ""
	};
	var postData = $("#gridTable").jqGrid("getGridParam", "postData");
	$.extend(postData, sdata); //将postData中的查询参数覆盖为空值  
	$("#gridTable").jqGrid("setGridParam", {
		search: false // 将jqGrid的search选项设为false  
	}).trigger("reloadGrid", [{
		page: 1
	}]);
	resetSingleSearchDialog();
};

/*
	 函数:  updateLevel
	 说明:  修改缓急程度
	 参数:   无
	 返回值: 无
	 */
var updateLevel = function(id) {
	if(orgOfficeManage=="true"||adminOfficeManage=="true"){
		var model = jQuery("#gridTable").jqGrid('getRowData', id);
		var pageName ="台帐详细界面";
		var url ="../../../tjy/detectionsupplies/jsp/officedetaillist.jsp?windowsId=windowId&org_id="+ model.org_id;
		openWindows('windowId',pageName,url,'windowId',false,window);
	}
}

afterSubmitFn=function(result){
	try{
		if(result.indexOf("delete")!=-1){
			alert(result.split(",")[1]);
			userSearch();
		}else{
			if(result.split(",").length>1){
					result = result.split(",");
					alert(result[0]);
					userSearch();
			} else {
				alert(result);
				userSearch();
			}
			
		}
	}catch(e){alert(e.description);}
};
function exportCsv() {
	alert("正在导出为CSV文件......请稍等");
}

var getCheckBoxValue = function() {
	/*得到所选择的值*/
	var str = "";
	$("[.jqgrow td input][checked]").each(function() {
		str += $(this).val() + ",";
	});
}
</script>
</head>
<body style="overflow-y:auto;">
<div>

	<!-- 查询条件选区    tabs_search_ctable(查询table样式) -->
			<table id="queryTable" width="100%" border="0" cellspacing="0" cellpadding="0" class="tabs_search_ctable_box">
				<tr>
					<td>
						<!-- 固定查询 -->
						<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tabs_search_ctable">
							<tr>
								<th width="90" class="input_cx_title_th" >部门/分院：</th>
								<td width="296"  class="cx_title_td">
								<input type="text" id="org_name" class="input_cx_title_283" >
								</td>
								<td width="385"  colspan="2"  >
								<input value="搜索" id="sel" type="button" onclick="userSearch()" class="but_y_01"/>
								</td>
							</tr>
						</table>
						<!-- 固定查询 end-->
					</td>
					</tr>
					<tr>
					<td>
			</td></tr>
			
			</table>

		<!-- 查询列表区 cGridArea(查询区样式)-->
		<div class="cGridArea">
		<table id="gridTable"></table>
		<div id="gridPager"></div>
		</div>
		<!-- 查询列表区 -->
</div>
<form id="delForm2" name="delForm2" method="post" action="officeaccountdo.jsp">
	<input type="hidden" name="delete" id="delete"> 
	<input type="hidden" name="action" value="deleteInf">
</form>

<iframe name="hiddenFrame2" width=0 height=0></iframe>
</body>
</html>
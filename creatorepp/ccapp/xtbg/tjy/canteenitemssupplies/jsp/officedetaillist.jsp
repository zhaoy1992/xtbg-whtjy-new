<%@page import="com.chinacreator.business.common.tools.CacheCommonManageProxy"%>
<%@page import="com.chinacreator.xtbg.core.file.util.FileUtil"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.UserCache"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	//当前用户信息
	String user_id = accesscontroler.getUserID();
	//当前用户信息
	String user_name = accesscontroler.getUserAccount();
	//获得当前登录用户所属单位信息
	UserCacheBean usercachebean=UserCache.getUserCacheBean(userId);
	String unit_id = usercachebean.getUnit_id();
	
	String GET_LIST_CLASS1="com.chinacreator.xtbg.tjy.canteenitemssupplies.list.OfficeDetailList";
	String path = request.getContextPath();
	String org_id = StringUtil.deNull(request.getParameter("org_id"));
	boolean adminOfficeManage= FileUtil.isRolesUser(user_id,"台帐管理员");
	//获取导入的用户名称
	String officeaccount_userName = StringUtil.deNull(CacheCommonManageProxy.getSystemParam("officeaccount_userName"));
%>
<title>台帐详情列表管理</title>
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
$(function() {
	$(document).keydown(function(){
		if(event.keyCode == 13){ 
			userSearch();
		}
		});
//tab2
	$("#gridTable").jqGrid({
		url: '<%= path %>' + '/pubListServlet?classNameId=<%=GET_LIST_CLASS1%>',  //commonListServlet列表公共的servlet,classNameId在servletBean.xml文件中配置要调用的类,isPage:是否翻页(true,false),默认为true
		//jqGrid控件通过这个参数得到需要显示的数据，具体的返回值可以使XML也可以是Json
		datatype: "json",
		//这个参数用于设定将要得到的数据类型。我最常用的是“json”，其余的类型还包括：xml、xmlstring、local、javascript、function
		mtype: "POST",
		//定义使用哪种方法发起请求，GET或者POST
		height: "100%",//270
		//Grid的高度，可以接受数字、%值、auto，默认值为150
		//width ："1800", //Grid的宽度，如果未设置，则宽度应为所有列宽的之和；如果设置了宽度，则每列的宽度将会根据shrinkToFit选项的设置，进行设置。
		//shrinkToFit ：true 此选项用于根据width计算每列宽度的算法。默认值为true。如果shrinkToFit为true且设置了width值，则每列宽度会根据width成比例缩放；如果shrinkToFit为false且设置了width值，则每列的宽度不会成比例缩放，而是保持原有设置，而Grid将会有水平滚动条
		autowidth: true,
		//width: "1000",
		//默认值为false。如果设为true，则Grid的宽度会根据父容器的宽度自动重算。重算仅发生在Grid初始化的阶段；如果当父容器尺寸变化了，同时也需要变化Grid的尺寸的话，则需要在自己的代码中调用setGridWidth方法来完成。
		colNames: ['主键ID', '标识卡编号','名称', '规格/型号','金额','类别','领取时间','领用人','责任人','存放位置','资产用途','报废处理情况','备注'],
		//字符串数组，用于指定各列的题头文本，与列的顺序是对应的。
		colModel: [ //最重要的数组之一，用于设定各列的参数
		{
			name: 'id',
			index: 'id',
			hidden: true
		},
		{
			name: 'code',
			index: 'code',
			width: 70
		},
		{
			name: 'name',
			index: 'name',
			width: 60
		},
		{
			name: 'type',
			index: 'type',
			width: 100
		},
		{
			name: 'money',
			index: 'money',
			width: 100
		},
		{
			name: 'oftype_name',
			index: 'oftype_name',
			width: 100
		},
		{
			name: 'receive_day',
			index: 'receive_day',
			width: 100
		},
		{
			name: 'receive_username',
			index: 'receive_username',
			width: 100
		},
		{
			name: 'blame_username',
			index: 'blame_username',
			width: 100
		},
		{
			name: 'deposit_place',
			index: 'deposit_place',
			width: 100
		},
		{
			name: 'assetsuse',
			index: 'assetsuse',
			width: 100
		},
		{
			name: 'wastedisposal',
			index: 'wastedisposal',
			width: 100
		},
		{
			name: 'remarks',
			index: 'remarks',
			width: 100
		}
		],
		sortname: 'receive_day desc,code ',
		//指定默认的排序列，可以是列名也可以是数字。此参数会在被传递到Server端。
		sortorder: 'asc',
		viewrecords: true,
		
		//设置是否在Pager Bar显示所有记录的总数。
		rowNum: 15,
		//用于设置Grid中一次显示的行数，默认值为20。正是这个选项将参数rows（prmNames中设置的）通过url选项设置的链接传递到Server。注意如果Server返回的数据行数超过了rowNum的设定，则Grid也只显示rowNum设定的行数。
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
		toolbar:[true, "top" ,
		         <%if(adminOfficeManage==true){%>
		        	<%if(user_name.equals(officeaccount_userName)){//测试1用户有导入功能%>
		        		"<input class='but_y_01' id=add value='新增' type='button' onclick='addLevel()'/><input class='but_y_01' value='删除' id=del type='button' onclick='delLevel()'/><input class='but_y_01' value='导入' id=del type='button' onclick='importExcel()' value=''/><input class='but_y_01' value='返回' id=del type='button' onclick='back()' />"
		        	<%} else{%>
		         		"<input class='but_y_01' id=add value='新增' type='button' onclick='addLevel()'/><input class='but_y_01' value='删除' id=del type='button' onclick='delLevel()'/><input class='but_y_01' value='导出' id=del type='button' onclick='exportFile()' value=''/><input class='but_y_01' value='返回' id=del type='button' onclick='back()' />"
		         	<%}%>
		         <%} else{%>
		    	     "<input class='but_y_01' id=add value='新增' type='button' onclick='addLevel()'/><input class='but_y_01' value='删除' id=del type='button' onclick='delLevel()'/><input class='but_y_01' value='返回' id=del type='button' onclick='back()' />"
		         <%}%>
		         ],
		multiselect: true,
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
	var str = "{'org_id':'<%=org_id%>','code':'" + StringCheck($("#code").val()) +
				"','name':'"+StringCheck($("#name").val())+"',"+
				"'type':'"+StringCheck($("#type").val())+"',"+
				"'money':'"+StringCheck($("#money").val())+"',"+
				"'receive_Stime':'"+$("#receive_Stime").val()+"',"+
				"'receive_Etime':'"+$("#receive_Etime").val()+"',"+
				"'money':'"+$("#money").val()+"',"+
				"'blame_username':'"+$("#blame_username").val()+
		"','unit_id':'<%=unit_id%>'}";
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
	 函数:  addlevel
	 说明:  添加缓急程度
	 参数:   无
	 返回值: 无
	 */
var addLevel = function() {
 	var pageName ="台账详细页面登记";
	openAlertWindows('windowId',"../../../tjy/canteenitemssupplies/jsp/officedetailinfo.jsp?windowsId=windowId&actionName=insert&org_id=<%=org_id%>",pageName,550,550,'25%','25%');
}

/*
	 函数:  updateLevel
	 说明:  修改缓急程度
	 参数:   无
	 返回值: 无
	 */
var updateLevel = function(id) {
	var model = jQuery("#gridTable").jqGrid('getRowData', id);
	var pageName ="修改台账详细页面";
	openAlertWindows('windowId','../../../tjy/canteenitemssupplies/jsp/officedetailinfo.jsp?windowsId=windowId&actionName=update&org_id=<%=org_id%>&id='+ model.id,pageName,550,550,'25%','25%');
}

var back = function(){
	removeWindows("windowId",true);
}

/*
	 函数:  deleteLevel
	 说明:  删除缓急程度
	 参数:   无
	 返回值: 无
	 */
var delLevel = function(id) {
	var ids = "";
	var selectedIds = $("#gridTable").jqGrid("getGridParam", "selarrrow");
	var idsArrTemp = new Array();
	$(selectedIds).each(function () {
		var model = jQuery("#gridTable").jqGrid('getRowData', this);
		if(!IsSpace(model.id)){
			idsArrTemp.push(model.id);
		}
	});
	
	ids = idsArrTemp.join();
	
	if (IsSpace(ids)) {
		alert("请选择要删除的记录！");
	} else {
		var okF = function(){
			$("#delete").val(ids);
			var fm = document.getElementById("delForm2");
			fm.target = "hiddenFrame2";
			fm.submit();
		}
		var p={
					headerText:'提示',
					okName:'确认',
			        okFunction:okF,
			        cancelName:'取消'
			};
		alert("确认后删除该条记录吗？",p)
	}
}

/*
函数:  importExcel
说明:  导入Excel表格
参数:   无
返回值: 无
*/
var importExcel = function(){
	var title = descape(escape('固定资产台帐信息')); //转码,避免中文传输乱码
	var remark = descape(escape('注意:导入的部门名称是唯一的。')); //转码,避免中文传输乱码
	var url = '${pageContext.request.contextPath}/ccapp/oa/resources/util/excel/excelimport.jsp?excelImplClass=officedetailDaoExcelImpl2&excelTemplateFilePath=canteenitemsdetail_excelTemplateFilePath&title='+title+'&remark='+remark;
	openAlertWindows('windowId',url,
		    '导入excel表格', '455px', '70%', '10%', '40%', function() {
			location.reload();
    });
}
/**
 * 导出
 */
function exportFile(){
	var url = "${pageContext.request.contextPath}/ccapp/oa/resources/util/excel/ajaxexcel.jsp";
    var html = new Array();
    html.push("<div id='export_excel'>");
    html.push('<iframe id="hiddenFrame"  name="hiddenFrame" width=0 height=0></iframe>');
    html.push('<form id="downFrom" name="downFrom" method="post" action="'+url+'" target="hiddenFrame">');
    html.push("<input type='hidden' name='excelname' value='固定资产台帐信息' /> ");//导出的主题
    html.push("<input type='hidden' name='parmjson' value='"+toUserParamJosn()+"' /> ");
    html.push("<input type='hidden' name='excelImplClass' value='officedetailDaoExcelImpl2' /> ");//导入导出的实现类，要提前在spring中或orcleConfig中配置好
    html.push("<input type='hidden' name='excelTemplateFilePath' value='canteenitemsdetail_excelTemplateFilePath' /> ");//导出的excel模版路径，要提前在系统properties中配置好
    html.push('</form>');
    html.push("</div>");
    //加载到body，提交后再删除
    jQuery(html.join("")).appendTo("body");
    jQuery("#downFrom").submit();
    jQuery("#export_excel").remove();
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
								<th width="90" class="input_cx_title_th" >标示卡编号：</th>
								<td width="296"  class="cx_title_td">
								<input type="text" id="code" class="input_cx_title_283" >
								</td>
								<td width="385"  colspan="2"  >
								<input value="搜索" id="sel" type="button" onclick="userSearch()" class="but_y_01"/>
								<span id="selAreaImg" class="all_search_condition"><a onclick="hiddenOrShowSelArea('hiddenArea','selAreaImg')" >更多搜索条件</a></span>
								</td>
							</tr>
						</table>
						<!-- 固定查询 end-->
					</td>
					</tr>
					<tr>
					<td>
						<!-- 隐藏查询 -->
						<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tabs_search_ctable" id="hiddenArea" style="display:none">
							<tr>
								<th width="90" class="input_cx_title_th">名称：</th>
								<td>
									<input type="text" id="name" class="input_cx_title_283" >	
								</td>
							</tr>
							<tr>
								<td><p style="height: 5px"></p></td>
							</tr>
							<tr>
								<th width="90" class="input_cx_title_th">规格\型号：</th>
								<td><input type="text" name="type" id="type" class="input_cx_title_283"></td>
							</tr>
							<tr>
								<td><p style="height: 5px"></p></td>
							</tr>
							<tr>
								<th width="90" class="input_cx_title_th" >领取起止时间：</th>
								<td class="cx_title_td">
									<input type="text" name="receive_Stime" id=receive_Stime class="date_120 Wdate" onclick="WdatePicker({maxDate:'#F{$dp.$D(\'receive_Etime\')}',dateFmt:'yyyy-MM-dd'})">
									<span class="date_120_span">至</span>
									<input type="text" name="receive_Etime" id="receive_Etime" class="date_120 Wdate" onclick="WdatePicker({minDate:'#F{$dp.$D(\'receive_Stime\')}',dateFmt:'yyyy-MM-dd'})">
								
								</td>
							</tr>
							<tr>
								<td><p style="height: 5px"></p></td>
							</tr>
							<tr>
								<th width="90" class="input_cx_title_th" >金额：</th>
								<td class="cx_title_td">
									<input type="text" name="money" id="money" class="input_cx_title_283">
								</td>
							</tr>
							<tr>
								<td><p style="height: 5px"></p></td>
							</tr>
							<tr>
								<th width="90" class="input_cx_title_th" >责任人：</th>
								<td class="cx_title_td">
									<input type="text" name="blame_username" id="blame_username" class="input_cx_title_283">
								</td>
							</tr>
						</table>
							<!-- 隐藏查询 end-->
					</td>
			
					</tr>
			
			</table>

		<!-- 查询列表区 cGridArea(查询区样式)-->
		<div class="cGridArea">
		<table id="gridTable"></table>
		<div id="gridPager"></div>
		</div>
		<!-- 查询列表区 -->
</div>
<form id="delForm2" name="delForm2" method="post" action="officedetailinfodo.jsp">
	<input type="hidden" name="delete" id="delete"> 
	<input type="hidden" name="action" value="deleteInf">
</form>

<iframe name="hiddenFrame2" width=0 height=0></iframe>
</body>
</html>
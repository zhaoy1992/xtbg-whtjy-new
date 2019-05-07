<%--
描述：易耗品领用列表界面
作者：童佳
版本：1.0
日期：2014-03-13
--%>

<%@page import="com.chinacreator.xtbg.core.common.cache.OASystemCache"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%
	String path = request.getContextPath();
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	
	String loginUserName = accesscontroler.getUserAccount();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="com.chinacreator.security.AccessControl"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<!-- 引入jQuery -->
<script type="text/javascript" src="<%=path%>/ccapp/oa/resources/plug/jquery1.7/jquery-1.7.1.min.js"></script>

<script src="<%=path%>/ccapp/oa/resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>


<!-- 引入my97时间控件 -->
<script src="<%=path%>/ccapp/oa/resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>

<!-- 引入jGrid -->
<script src="<%=path%>/ccapp/oa/resources/plug/jquery.jqGrid-4.3.1/js/i18n/grid.locale-en.js"
	type="text/javascript"></script>
<script src="<%=path%>/ccapp/oa/resources/plug/jquery.jqGrid-4.3.1/js/jquery.jqGrid.min.js"
	type="text/javascript"></script>

<!-- 引入其它 -->
<script src="<%=path%>/ccapp/oa/resources/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="<%=path%>/ccapp/oa/resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="<%=path%>/ccapp/oa/resources/plug/ifrom/js/ifrom-tools.1.1.js" ></script>
<title>易耗品库存列表</title>

<script type="text/javascript">
var loginUserName = '<%=loginUserName%>';
$(function() {
	
	var _documentBodyHeight = window.top.findPageCacheName("_documentBodyHeight");
	var width=jQuery(window).width();
	if(width<880){
		jQuery("#maindiv").width(775);
	}
	$(document).keydown(function(){
		if(event.keyCode == 13){ 
			userSearch();
		}
	
	});
	$("#gridTable").jqGrid({
		url: '<%= path %>' + '/pubListServlet?classNameId=com.chinacreator.xtbg.tjy.canteenitemssupplies.list.OsHavaLingYongobjectList',  //pubListServlet列表公共的servlet,classNameId在servletBean.xml文件中配置要调用的类,isPage:是否翻页(true,false),默认为true
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
		colNames: ['物品领用id','物品ID','物品名称','物品类型ID','物品类型名称','领用数量','规格ID','规格名称 ','领用人ID','领用人','领用ORGID','领用处室','领用时间','数量总和'],
		//字符串数组，用于指定各列的题头文本，与列的顺序是对应的。
		colModel: [ //最重要的数组之一，用于设定各列的参数
           {
   			name: 't_ly_id',
   			index: 't_ly_id',
   			width: '0',
   			hidden: true
   		},
   		{
   			name: 'ofustype_id',
   			index: 'ofustype_id',
   			width: '0',
   			hidden: true
    	},
		{
			name: 'ofustype_name',
			index: 'ofustype_name',
			width: '40',
			search: true
		},
   		{
   			name: 'oftype_id',
   			index: 'oftype_id',
   			width: '0',
   			hidden: true
    	},
		{
			name: 'oftype_name',
			index: 'oftype_name',
			width: '40',
			search: true
		},
    	{
   			name: 't_ly_no',
   			index: 't_ly_no',
   			width: '40',
			search: true
    	},
   		{
   			name: 'it_id',
   			index: 'it_id',
   			width: '0',
   			hidden: true
    	},
		{
			name: 'it_name',
			index: 'it_name',
			width: '40',
			search: true
		},
   		{
   			name: 't_ly_user_id',
   			index: 't_ly_user_id',
   			width: '0',
   			hidden: true
    	},
    	{
   			name: 't_ly_user_name',
   			index: 't_ly_user_name',
   			width: '40',
			search: true
    	},
   		{
   			name: 't_ly_org_id',
   			index: 't_ly_org_id',
   			width: '0',
   			hidden: true
    	},
    	{
   			name: 't_ly_org_name',
   			index: 't_ly_org_name',
   			width: '40',
			search: true
    	},
		{
			name: 't_ly_date',
			index: 't_ly_date',
			width: '100',
			search: true
		},
		{
			name: 'sumNo',
			index: 'sumNo',
			width: '0',
			hidden: true
		}
		],
		//sortname: 'last_updatetime',
		//指定默认的排序列，可以是列名也可以是数字。此参数会在被传递到Server端。
		sortname: 't_ly_date',
		sortorder: 'desc',
		viewrecords: true,
		
		//设置是否在Pager Bar显示所有记录的总数。
		rowNum: 10,
		//用于设置Grid中一次显示的行数，默认值为20。正是这个选项将参数rows（prmNames中设置的）通过url选项设置的链接传递到Server。注意如果Server返回的数据行数超过了rowNum的设定，则Grid也只显示rowNum设定的行数。
		rowList: [10, 20, 30],
		//一个数组，用于设置Grid可以接受的rowNum值。例如[10,20,30]
		gridComplete: function() { // var idss=jQuery("#gridTable").jqGrid('getColNames');
			var ids = $("#gridTable").getDataIDs(); //jqGrid('getDataIDs');
			var sumNo = "0";
			for (var i = 0; i < ids.length; i++) {
				var cl = ids[i];
				var model = jQuery("#gridTable").jqGrid('getRowData', cl);
				if(i==0){
					sumNo = model.sumNo;	
				} else{
					break;
				}
				
			}
			setQryInfo2DIV(sumNo);
		},
		
		jsonReader: { //这又是一个数组，用来设定如何解析从Server端发回来的json数据
			repeatitems: false
		},
		//pager: "#gridPager",
		//定义页码控制条Page Bar
		//caption: "待办列表",
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
		/*
		filterNames:["act_name"],
		filterOptions:[
		               [
		                ["xd","name"],[2,"page"],[3,"daf"]],//value text 后的值与显不
		                [
		                 ['王奎',"王奎"],["马坤","马坤"],["文电科","文电科"]
		                 ]
		               ],
		filterOptionsDefValue:[1,2],*/
		pagerintoolbar:true,//上面的分页条
		pagerinBottombar:true,//下面的分页条
		toolbar: [true,"top",""],
		multiselect: false,
		onSelectRow: function(id) {
		}
	}).navGrid('#gridPager', {
		edit: false,
		add: false,
		del: false,
		search:false,
		refresh:false
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
	paramJson: descape(escape("{'username':'"+loginUserName+"'}"))
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
		 var str = "{'t_ha_iswhat':'2','ofustype_name':'"+jQuery("#ofustype_name").val()
		 			+ "','oftype_name':'" + jQuery("#oftype_name").val()
		 			+ "','it_name':'" + jQuery("#it_name").val()
		   			+ "','t_ly_user_name':'" + jQuery("#t_ly_user_name").val()
		   			+ "','t_ly_org_name':'" + jQuery("#t_ly_org_name").val()
		   			+ "','start_time':'" + jQuery("#start_time").val()
		   			+ "','end_time':'" + jQuery("#end_time").val()
			 		+"'}";
	return descape(escape(str));
}

/*
函数:  resetSingleSearchDialog
说明:  清空值查询值
参数:   无
返回值: 无
*/
var resetSingleSearchDialog = function() { //$("radio","#singleSearchDialog").attr("checked", false);  

}

function addLevel(id){   
	var path ="<%=path%>/ccapp/xtbg/tjy/canteenitemssupplies/jsp/osmoreobjectinfo.jsp?windowsId=windowIds1";
	openAlertWindows('windowIds1',path,'易耗品入库',1024,768,'25%','25%');
}


/**
 * [setQryInfo2DIV 设置查询的显示结果;没有设条件时不显示]
 * @param {[int]}    count        [description]
 */
function setQryInfo2DIV(count,qryText){
	var spanText      = ""; //查询结果文字提示
	var strFormValues = ""; //表单序列值
	qryText           = !IsSpace(qryText) ? qryText : $("#qryText");

	if (!IsSpace(count)) { //显示查询结果
		qryText.parent().show();
		qryText.closest("table").show()
		qryText.text("当前查询的领用总数量为 ：" + count );
	}else{
		qryText.parent().hide();
		qryText.closest("table").hide()
	}
}
</script>
</head>
<body>
<table width="100%" id="queryTable">
	<tr>
		<td>
						
			<!-- 查询条件选区    tabs_search_ctable(查询table样式) -->
			<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tabs_search_ctable_box" >
				<tr>
					<td>
						<!-- 固定查询 -->
						<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tabs_search_ctable">
							<tr>
								<th class="input_cx_title_th">物品名称：</th>
								<td width="385" class="cx_title_td"><input id="ofustype_name" name="ofustype_name" type="text" class="input_cx_title_283" /></td>
								<td width="385"  colspan="2"  ><input name="Input2" value="搜索" type="button" onclick="userSearch()" class="but_y_01"/>
								<span id="selAreaImg" class="all_search_condition"><a onclick="hiddenOrShowSelArea('hiddenArea','selAreaImg')" >更多搜索条件</a></span></td>
							</tr>
						</table>
						<!-- 固定查询 end-->
					</td>
					</tr>
					  
					<tr>
					<td>
					
						<!-- 隐藏查询 -->
						<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tabs_search_ctable" id="hiddenArea" style="display:none">
							<!-- 正规 4列 -->
							<tr>
								<th class="input_cx_title_th">物品类别：</th>
								<td  class="cx_title_td">
									<input id="oftype_name" name="oftype_name" type="text" class="input_cx_title_283" />
								</td>
								<th class="input_cx_title_th">物品规格：</th>
								<td  class="cx_title_td">
									<input id="it_name" name="it_name" type="text" class="input_cx_title_283" />
								</td>
							</tr>
							<tr>
								<th class="input_cx_title_th">领用人：</th>
								<td  class="cx_title_td">
									<input id="t_ly_user_name" name="t_ly_user_name" type="text" class="input_cx_title_283" />
								</td>
								<th class="input_cx_title_th">领用部室：</th>
								<td  class="cx_title_td">
									<input id="t_ly_org_name" name="t_ly_org_name" type="text" class="input_cx_title_283" />
								</td>
							</tr>
							<tr>
								<th class="input_cx_title_th">领用时间：</th>
								<td  class="cx_title_td">
									<input class="date_120 Wdate" type="text" id="start_time" name="start_time" 
									onfocus="WdatePicker({onpicked:function(){$('#end_time').focus();}})"
									/>
									<span class="date_120_span">至</span>
									<input class="date_120 Wdate"  type="text" id="end_time" name="end_time" 
									onfocus="WdatePicker({minDate:'#F{$dp.$D(\'start_time\')}',dateFmt:'yyyy-MM-dd'})"
									/>
								</td>
							</tr>   
						</table>
						<!-- 隐藏查询 end-->
						
					</td>
				</tr>
			</table>
		<!-- 查询条件选区    tabs_search_ctable(查询table样式) -->
						
		</td>
		</tr>

		<tr>
			<td>
					<div id="maindiv" class="cGridArea" style="overflow: auto;">
						<table id="gridTable"></table>
						<div id="gridPager"></div>
					</div>
					<!-- 查询列表区 -->
			</td>
		</tr>	
</table>
<!--查询条件 end -->
<table width="100%" id="qryTextTable">
	<tr>
		<td>
			<div style="margin-left:5px;display:none;">
				<span id="qryText"></span>
			</div>
		</td>
	</tr>
</table>
</body>
</html>
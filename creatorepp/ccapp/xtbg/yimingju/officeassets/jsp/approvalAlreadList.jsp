<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.security.authorization.AuthRole"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	String user_orgname = accesscontroler.getChargeOrgName(); //当前用户所属机构名称
	AuthRole authRoles[] = accesscontroler.getAllRoleofUser(accesscontroler.getUserAccount());
	String path = request.getContextPath();
	String andit_userid = accesscontroler.getUserID();
	String StrRoles="";
	String rolesNames = "";//查询是否为办公室或处室角色
	StringBuffer buf = new StringBuffer();
	for(int i=0;i<authRoles.length;i++){
		buf.append(authRoles[i].toString()+ ",");
	}   
	rolesNames = buf.toString();
	if(rolesNames.length()>0){
		rolesNames = rolesNames.substring(0,rolesNames.length()-1);
	}
	String sRoles = "";
	if(rolesNames.indexOf("处室审批角色")!=-1){
		StrRoles = "room";
	}
	if(rolesNames.indexOf("办公室审批角色")!=-1){
		if("room".equals(StrRoles)){
			//处室审批角色和办公室角色
			sRoles = "combine";
		}
		StrRoles = "office";
	}
	String state="null";//审批状态
	if("room".equals(StrRoles)){
		//采购审批处室已审批
		state="2,3,4,5,6";
	}else if("office".equals(StrRoles)){
		//采购办公室审批已批
		state="4,5,6";
	}
	//处室和办公室
	if("combine".equals(sRoles)){
		state="2,3,4,5,6";
	}
	String whatDo = request.getParameter("whatDo");
	if("detail".equals(whatDo)){
		//采购清单 已采购
		state="6";
	}
%>
<title>采购申请处室已审批</title>
<!-- 公共部分开始 -->
<!-- 引入jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<!-- 引入jQuery UI -->
<link id="uiThemes" rel="stylesheet" type="text/css" media="screen" href="../../resources/plug/jquery-ui-1.8.17.custom/css/custom-theme/jquery-ui-1.8.17.custom.css" />
<script src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>
<!-- 引入my97时间控件 -->
<script src="../../../resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<!-- 引入jGrid -->
<link rel="stylesheet" type="text/css" media="screen" href="../../../resources/plug/jquery.jqGrid-4.3.1/css/ui.jqgrid.css" />
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
		url: '<%= path %>' + '/commonListServlet?classNameId=approvalAlreadRoomList',  //commonListServlet列表公共的servlet,classNameId在servletBean.xml文件中配置要调用的类,isPage:是否翻页(true,false),默认为true
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
		colNames: ['采购申请ID', '申请标题 ', '申请人','申请处室','申请日期','状态'],
		//字符串数组，用于指定各列的题头文本，与列的顺序是对应的。
		colModel: [ //最重要的数组之一，用于设定各列的参数
		{
			name: 'apply_id',
			index: 'apply_id',
			hidden: true
		},
		{
			name: 'apply_title',
			index: 'apply_title',
			width: 180
		},
		{
			name: 'apply_userName',
			index: 'apply_users',
			width: 50
		},
		{
			name: 'apply_room',
			index: 'apply_room',
			width: 90
		},
		{
			name: 'apply_date',
			index: 'apply_date',
			width: 60
		},
		{
			name: 'state',
			index: 'state',
			width: 70
		}
		],
		sortname: 'apply_date',
		//指定默认的排序列，可以是列名也可以是数字。此参数会在被传递到Server端。
		sortorder: 'desc',
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
		search:toUserParamJosn(),
		filterNames:["state"],
		filterOptions:[[["<%=state%>","状态"],["1","等待处室审批"],["2","处室审批通过"],["3","处室审批未通过"],["4","办公室审批通过"],["5","办公室审批未通过"],["6","已采购"]]],//alue text 后的值与显不
		filterOptionsDefValue:[0], 
		prmNames: { //这是一个数组，用于设置jqGrid将要向Server传递的参数名称
			rows: "rows",
			//表示请求行数的参数名称  
			sort: "sidx",
			//表示用于排序的列名的参数名称  
			order: "sord",
			//表示采用的排序方式的参数名称 
			search : "search"
		},
		toolbar:[true, "top"],
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
	if("room"=="<%=StrRoles%>"){
		var str = "{'apply_startdate':'"+$('#input_starttime').val()+"','apply_enddate':'"+$('#input_endtime').val()+"',"+
			"'apply_room':'<%=user_orgname%>','andit_userId':'<%=andit_userid%>','diff_type':'<%=StrRoles%>'}";
	} else{
		var str = "{'apply_startdate':'"+$('#input_starttime').val()+"','apply_enddate':'"+$('#input_endtime').val()+"',"+
		"'apply_room':'"+$('#apply_room').val()+"','andit_userId':'<%=andit_userid%>','diff_type':'<%=StrRoles%>'}";
	}
	if("combine"=="<%=sRoles%>"){
		var str = "{'apply_startdate':'"+$('#input_starttime').val()+"','apply_enddate':'"+$('#input_endtime').val()+"',"+
		"'apply_room':'"+$('#apply_room').val()+"','andit_userId':'<%=andit_userid%>','diff_type':'<%=sRoles%>'}";
	}
	
	return descape(escape(str));
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
	search: true, // 将jqGrid的search选项设为true  
	search : toUserParamJosn()
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
	var model = jQuery("#gridTable").jqGrid('getRowData', id);
	openWindows("windowId","采购已审批","../../officeassets/jsp/SeeApprovalList.jsp?widowsid=windowId&apply_id=" + model.apply_id,'approvalAlreadList',false,window);
}

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

window.onload = function () {
	setDataTimeClickShowOrHide('input_starttime',window);
	setDataTimeClickShowOrHide('input_endtime',window);
}
</script>
</head>
<body style="overflow-y:auto;">
<div style="width:98%;">

			<!-- 查询条件选区    tabs_search_ctable(查询table样式) -->
			<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tabs_search_ctable_box">
				<tr>
					<td>
						<!-- 固定查询 -->
						<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tabs_search_ctable">
							<tr>
								<th width="90" class="input_cx_title_th" >申请处室：</th>
								<td width="296"  class="cx_title_td">
								<input class="input_cx_title_283" id="apply_room" name="apply_room" type="text" />
								</td>
								<td width="385"  colspan="2"  >
								<input name="Input2" value="搜索" type="button" onclick="userSearch()" class="but_y_01"/>
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
							
							<tr>
								<th class="input_cx_title_th">申请日期：</th>
								<td  class="cx_title_td">
								<input class="date_120 " type="text" id="input_starttime" name="input_starttime" 
									onFocus="var input_endtime=$dp.$('input_endtime');WdatePicker({onpicked:function(){input_endtime.focus();},dateFmt:'yyyy-MM-dd '})" 
									/>
								<span class="date_120_span">至</span>
								 
								  <input class="date_120 " type="text" id="input_endtime" name="input_endtime" 
								  onfocus="WdatePicker({minDate:'#F{$dp.$D(\'input_starttime\')}',dateFmt:'yyyy-MM-dd '})" 
								  />
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

<iframe name="hiddenFrame2" width=0 height=0></iframe>
</body>
</html>
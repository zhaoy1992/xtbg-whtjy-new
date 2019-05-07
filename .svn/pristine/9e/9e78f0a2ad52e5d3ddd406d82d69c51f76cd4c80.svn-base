<%-- 
描述：用户组管理列表页面
作者：肖杰
版本：1.0
日期：2013-08-01
 --%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DaoUtil"%>
<%@page import="com.chinacreator.config.ConfigManager"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<%
AccessControl accesscontroler = AccessControl.getAccessControl();
accesscontroler.checkAccess(request, response);
String curUserId = accesscontroler.getUserID();
String path = request.getContextPath();
String org_id = request.getParameter("org_id");
if(StringUtil.isBlank(org_id)) {
	org_id = DaoUtil.sqlToField("select o.org_id from td_sm_organization o where o.parent_id='0'");
}

//岗位操作开关
boolean isJobOpen = ConfigManager.getInstance().getConfigBooleanValue("enablejobfunction", false);

//是否允许用户存在多个机构下
boolean isUserOrgs = ConfigManager.getInstance().getConfigBooleanValue("sys.user.enablemutiorg", false);

//判断是否禁用机构用户增删改菜单开关
//minghua.guo[2010-12-13]
boolean orguser_modify_forbidden = ConfigManager.getInstance().getConfigBooleanValue("orguser.modify.forbidden",false);

//权限是否关联机构
// 彭盛 2011-3-15 
boolean isrolerelatedorg = ConfigManager.getInstance().getConfigBooleanValue("isrolerelatedorg", false);

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.sysmgrcore.purviewmanager.usercheckorg.api.UserCheckOrgFactory"%>

<%@page import="com.chinacreator.sysmgrcore.manager.db.OrgAdministratorImpl"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>用户组列表</title>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../resources/plug/jquery1.7/jquery-1.7.1.min.js"></script>
<script src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>
<script src="../../resources/plug/jquery.jqGrid-4.3.1/js/i18n/grid.locale-en.js" type="text/javascript"></script>
<script src="../../resources/plug/jquery.jqGrid-4.3.1/js/jquery.jqGrid.min.js" type="text/javascript"></script>
<!-- 右键菜单 -->
<script src="../../resources/plug/jquery.jqGrid-4.3.1/menu/jquery.contextmenu.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" media="screen" href="../../resources/plug/jquery.jqGrid-4.3.1/menu/contextmenu.css" />

<!-- 引入其它 -->
<script src="../../resources/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js"></script>
<script type="text/javascript">
var dataId = "";
var rightflag = "";
$(function() {
	$(document).keydown(function(){
		if(event.keyCode == 13){ 
			userSearch();
		}
	});
	$("#gridTable").jqGrid({
		url: '<%= path %>' + '/pubListServlet?classNameId=com.chinacreator.xtbg.core.purviewmanager.list.GroupList',//pubListServlet列表公共的servlet,classNameId在servletBean.xml文件中配置要调用的类,isPage:是否翻页(true,false),默认为true
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
		colNames: ['用户组ID','用户组父ID','用户组名称','用户组描述 ', '创建人 '],
		//字符串数组，用于指定各列的题头文本，与列的顺序是对应的。
		colModel: [ //最重要的数组之一，用于设定各列的参数
		{
			name: 'group_id',
			index: 'group_id',
			width: 50,
			editable: true,
			hidden:true
		},
		{
			name: 'parent_id',
			index: 'parent_id',
			width: 50,
			editable: true,
			hidden:true
		},
		{
			name: 'group_name',
			index: 'group_name',
			width: 180,
			editable: true,
		},
		{
			name: 'group_desc',
			index: 'group_desc',
			width: 180,
			editable: true,
			sortable: false
		},
		{
			name: 'remark5',
			index: 'remark5',
			width: 180,
			editable: true,
			sortable: false
		}
		],
		sortname: 'group_id',
		//指定默认的排序列，可以是列名也可以是数字。此参数会在被传递到Server端。
		sortorder: 'desc',
		viewrecords: true,
		
		//设置是否在Pager Bar显示所有记录的总数。
		rowNum: 10,
		//用于设置Grid中一次显示的行数，默认值为20。正是这个选项将参数rows（prmNames中设置的）通过url选项设置的链接传递到Server。注意如果Server返回的数据行数超过了rowNum的设定，则Grid也只显示rowNum设定的行数。
		rowList: [10, 20, 30],
		//一个数组，用于设置Grid可以接受的rowNum值。例如[10,20,30]
		gridComplete: function() { 
		
		},
		jsonReader: { //这又是一个数组，用来设定如何解析从Server端发回来的json数据
			repeatitems: false
		},
		//pager: "#gridPager",
		pagerintoolbar:true,//上面的分页条
		pagerinBottombar:true,//下面的分页条
		//定义页码控制条Page Bar
		//caption: "流程配置列表",
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
		toolbar: [true,"top",""],
		multiselect: false,
		onRightClickRow: function(id) { //右键事件
			dataId = id;
			rightflag = "1";
		},
		onCellSelect:function (id,icol)
		{
			
		}
	}).navGrid('#gridPager', {
		edit: false,
		add: false,
		del: false,
		search : false,
		refresh : false
	});
});

/*
函数:  toUserParamJosn
说明:  构建要查询的参数
参数:   无
返回值: 返回要查询的参数
*/
var toUserParamJosn = function() {
	
	var str = "{'group_name':'"+$("#group_name").val()+"','group_desc':'"+$("#group_desc").val()+"','remark5':'"+$("#remark5").val()+"'}";
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
		search: true // 将jqGrid的search选项设为true  
	}).trigger("reloadGrid", [{
		page: 1
	}]); //重新载入Grid表格，以使上述设置生效 
}



/*
	函数:  roleUser
	说明:  批量角色赋予
	参数:   无
	返回值: 
*/
function roleUser(type) {
	var ids = "";
	var selectedIds = $("#gridTable").jqGrid("getGridParam", "selarrrow");
	for ( var i = 0; i < selectedIds.length; i++) {
		var model = jQuery("#gridTable").jqGrid('getRowData',selectedIds[i]);
		if ("" != ids) {
			ids += ",";
		}
		ids += model.user_id;

	}

	if(ids.split(",").length > 1) {
		var url ='<%=path %>' + '/ccapp/oa/purviewmanager/orgusermanager/org/alotuserrole.jsp?orgId='+jQuery("#org_id").val()+'&checks=' + ids;
		openAlertWindows('windowId',url,'批量角色授权','810','390','10%');
	} else {
		alert("至少要选择两条记录！");
    	return false;
	}
	
}

/*
	函数:  purviewReclaimUsers
	说明:  批量用户权限回收
	参数:   无
	返回值: 
*/
function purviewReclaimUsers() {

	var ids = "";
	var selectedIds = $("#gridTable").jqGrid("getGridParam", "selarrrow");
	for ( var i = 0; i < selectedIds.length; i++) {
		var model = jQuery("#gridTable").jqGrid('getRowData',selectedIds[i]);
		if ("" != ids) {
			ids += ",";
		}
		ids += model.user_id;

	}

	if(ids.split(",").length > 1) {
		var url ='<%=path %>' + '/ccapp/oa/purviewmanager/reclaimManager/reclaimuserres.jsp?orgId='+jQuery("#org_id").val()+'&userIds=' + ids;
		openAlertWindows('windowId',url,'批量用户权限回收','450','300','10%','30%');
	} else {
		alert("至少要选择两条记录！");
    	return false;
	}
	
}

/*
	函数:  usercheckorg
	说明:  用户调动
	参数:   无
	返回值: 
*/
function usercheckorg(){
	

	var ids = "";
	var selectedIds = $("#gridTable").jqGrid("getGridParam", "selarrrow");
	for ( var i = 0; i < selectedIds.length; i++) {
		var model = jQuery("#gridTable").jqGrid('getRowData',selectedIds[i]);
		if ("" != ids) {
			ids += ",";
		}
		ids += model.user_id;

	}

	var url ='<%=path %>' + '/ccapp/oa/purviewmanager/orgusermanager/org/usercheckorgmain.jsp?orgId='+jQuery("#org_id").val()+'&checkBoxOne=' + ids;
	openAlertWindows('windowId',url,'用户调动','650','650','3%','25%');

}

/*
函数:  refreshcache
说明:  刷新缓存
参数:   无
返回值: 
*/
function refreshcache(type) {
	var params="type="+ type;
	$.ajax({
		url: 'refreshcachedo.jsp',
		type: 'POST',
		dataType: 'json',
		data: params,
		success: function(data) {
			 if(data&&data.msg){
				if(data.flag != 'false') {
					alert(data.msg);
				} else {
					alert(data.msg);
				}
			 } 
		},
		error: function(jqXHR, textStatus, errorThrown){
			alert("刷新失败"+jqXHR+textStatus+errorThrown);
		}
	});

}
/*
函数:  clearInfo
说明:  清空查询值
参数:   无
返回值: 无
*/
var clearInfo=function(){
$("#group_name").val("");
$("#group_desc").val("");
$("#remark5").val("");
}


</script>
</head>
<body>
<input type="hidden" name="org_id" id="org_id" value="<%=org_id %>"></input>
<table width="100%" id="queryTable">
	<tr>
		<td>
		
		</td>
	</tr>
	<tr>
		<td>
			<!-- 查询条件选区    tabs_search_ctable(查询table样式) -->
			<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tabs_search_ctable_box">
				<tr>
					<td>
						<!-- 固定查询 -->
						<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tabs_search_ctable">
							<tr>
								 <th class="input_cx_title_th">用户组名称：</th>
						           <td class="cx_title_td">
						           <INPUT class="input_cx_title_120"  id="group_name" name="group_name" >
						           </td>
						           <th class="input_cx_title_th">用户组描述：</th>
						           <td class="cx_title_td">
						           <INPUT class="input_cx_title_120"  id="group_desc" name="group_desc" >
						           </td>
						           <th class="input_cx_title_th">创建人：</th>
						           <td class="cx_title_td">
						           <INPUT class="input_cx_title_120"  id="remark5" name="remark5" >
						           </td>
								<td width="385"  colspan="2"  >
								<input name="Input2" value="搜索" type="button" onclick="userSearch()" class="but_y_01"/>
								</td>
								<td width="385"  colspan="2"  >
								<input type="button"  value="清空" onclick="clearInfo()"  class="but_y_01"/>
								</td>
							</tr>
						</table>
						<!-- 固定查询 end-->
					</td>
				</tr>
		</table>
		</td>
	</tr>
</table>

<!-- 查询列表区 cGridArea(查询区样式)-->
<div class="cGridArea">
  <table id="gridTable">
  </table>
  <div id="gridPager"></div>
</div>
<form action="" id="form1" name="form1" method="post"></form>

<iframe name="hiddenFrame" width="0" height="0"></iframe>
</body>
</html>

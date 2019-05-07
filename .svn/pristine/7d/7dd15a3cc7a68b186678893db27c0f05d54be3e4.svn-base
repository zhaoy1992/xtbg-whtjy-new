<%-- 
描述：用户管理列表页面
作者：黄艺平
版本：1.0
日期：2013-05-24
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
<title>用户列表</title>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery1.7/jquery-1.7.1.min.js"></script>
<script src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>
<script src="../../../resources/plug/jquery.jqGrid-4.3.1/js/i18n/grid.locale-en.js" type="text/javascript"></script>
<script src="../../../resources/plug/jquery.jqGrid-4.3.1/js/jquery.jqGrid.min.js" type="text/javascript"></script>
<!-- 右键菜单 -->
<script src="../../../resources/plug/jquery.jqGrid-4.3.1/menu/jquery.contextmenu.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" media="screen" href="../../../resources/plug/jquery.jqGrid-4.3.1/menu/contextmenu.css" />

<!-- 引入其它 -->
<script src="../../../resources/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js"></script>
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
		url: '<%= path %>' + '/pubListServlet?classNameId=com.chinacreator.xtbg.core.purviewmanager.list.UserManagerList',//pubListServlet列表公共的servlet,classNameId在servletBean.xml文件中配置要调用的类,isPage:是否翻页(true,false),默认为true
		//jqGrid控件通过这个参数得到需要显示的数据，具体的返回值可以使XML也可以是Json
		datatype: "json",
		//这个参数用于设定将要得到的数据类型。我最常用的是“json”，其余的类型还包括：xml、xmlstring、local、javascript、function
		mtype: "POST",
		pageCached:false,
		//定义使用哪种方法发起请求，GET或者POST
		height: "100%",//270
		//Grid的高度，可以接受数字、%值、auto，默认值为150
		//width ：800, //Grid的宽度，如果未设置，则宽度应为所有列宽的之和；如果设置了宽度，则每列的宽度将会根据shrinkToFit选项的设置，进行设置。
		//shrinkToFit ：true 此选项用于根据width计算每列宽度的算法。默认值为true。如果shrinkToFit为true且设置了width值，则每列宽度会根据width成比例缩放；如果shrinkToFit为false且设置了width值，则每列的宽度不会成比例缩放，而是保持原有设置，而Grid将会有水平滚动条
		autowidth: true,
		//默认值为false。如果设为true，则Grid的宽度会根据父容器的宽度自动重算。重算仅发生在Grid初始化的阶段；如果当父容器尺寸变化了，同时也需要变化Grid的尺寸的话，则需要在自己的代码中调用setGridWidth方法来完成。
		colNames: ['机构ID','用户ID','登录名称 ', '用户实名 ', '用户性别 ', '用户类别 ','当前状态 ','隶属机构 '],
		//字符串数组，用于指定各列的题头文本，与列的顺序是对应的。
		colModel: [ //最重要的数组之一，用于设定各列的参数
		{
			name: 'org_id',
			index: 'org_id',
			width: 50,
			editable: true,
			hidden:true
		},
		{
			name: 'user_id',
			index: 'user_id',
			width: 50,
			editable: true,
			hidden:true
		},
		{
			name: 'user_name',
			index: 'user_name',
			width: 180,
			editable: true,
			sortable: false
		},
		{
			name: 'user_realname',
			index: 'user_realname',
			width: 180,
			editable: true,
			sortable: false
		},
		{
			name: 'user_sex',
			index: 'user_sex',
			width: 90,
			editable: true,
			sortable: false
		},

		{
			name: 'user_type',
			index: 'user_type',
			width: 100,
			editable: true,
			sortable: false
		},
		{
			name: 'user_isvalid',
			index: 'user_isvalid',
			width: 100,
			editable: true,
			sortable: false
		},

		{
			name: 'org_Name',
			index: 'org_Name',
			width: 130,
			editable: true,
			sortable: false
		}
		],
		sortname: 'user_name',
		//指定默认的排序列，可以是列名也可以是数字。此参数会在被传递到Server端。
		sortorder: 'desc',
		viewrecords: true,
		
		//设置是否在Pager Bar显示所有记录的总数。
		rowNum: 10,
		//用于设置Grid中一次显示的行数，默认值为20。正是这个选项将参数rows（prmNames中设置的）通过url选项设置的链接传递到Server。注意如果Server返回的数据行数超过了rowNum的设定，则Grid也只显示rowNum设定的行数。
		rowList: [10, 20, 30],
		//一个数组，用于设置Grid可以接受的rowNum值。例如[10,20,30]
		gridComplete: function() { 
		var ids = $("#gridTable").getDataIDs(); 
		for (var i = 0; i < ids.length; i++) {
			var cl = ids[i];
			var model = jQuery("#gridTable").jqGrid('getRowData', cl);
			if(model.user_sex == 'M'){
				user_sexCol =  '男';
			} else if(model.user_sex == 'F') {
				user_sexCol =  '女';
			} else {
				user_sexCol =  '未知';
			}

			if(model.user_type == '0') {
				user_typeCol =  '系统用户';
			} else {
				user_typeCol =  '外部用户';
			}

			if(model.user_isvalid == '2') {
				user_isvalidCol =  '开通';
			} else {
				user_isvalidCol =  '停用';
			}
			
			jQuery("#gridTable").jqGrid('setRowData', ids[i], {
				user_sex: user_sexCol,
				user_type: user_typeCol,
				user_isvalid: user_isvalidCol
			});
				
		}
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
		multiselect: true,
		onRightClickRow: function(id) { //右键事件
			dataId = id;
			rightflag = "1";
		},
		onCellSelect:function (id,icol)
		{
			if(icol != 0)
				{
				jQuery("#gridTable").setSelection(id,false);
				userInfoupdate(id);
				}
		}
	}).navGrid('#gridPager', {
		edit: false,
		add: false,
		del: false,
		search : false,
		refresh : false
	});
	$("#user_name").focus();
});

//---------右键菜单--------------------//	

$().ready(function() {
		var option = { 
			width: 150, 
			items: [
				{ text: "基本信息查看", icon: "../../resources/images/status_reopened.gif", alias: "1-1", action: userInfoquery},
				{ text: "基本信息修改", icon: "../../resources/images/edit.gif", alias: "1-2", action: userInfoupdate},
				{ text: "权限授予", icon: "../../resources/images/tool-reply.gif", alias: "1-3", action: resGrant},
				{ text: "数据权限", icon: "../../resources/images/tool-reply.gif", alias: "1-4", action: dataConfig},
				{ text: "权限回收", icon: "../../resources/images/recycle.gif", alias: "1-5", action: purviewReclaim },
				{ text: "角色设置", icon: "../../resources/images/tool-forward16.gif", alias: "1-6", action: roleGrant },
				{ text: "可管理部门", icon: "../../resources/images/doc_sh.gif", alias: "1-7", action: userOrg },
				{ text: "权限查询", icon: "../../resources/images/listQuery.gif", alias: "1-8", action: userResList }
			]
			//onShow: applyrule
			
		};

		/*
		function applyrule(menu) {
			menu.applyrule({ 
				name: "dd",
				disable: true,
				items: ['1-1']
			});
		}*/
		
	$("#gridTable").contextmenu(option);
});



/*
	函数:  getRightMenu
	说明:  获得右键菜单
	参数:   无
	返回值: 
*/
function getRightMenu() {

	var arrayItem = new Array();
	var model = jQuery("#gridTable").jqGrid('getRowData', dataId);
	
	var params="user_id="+ model.user_id +"&user_name=" + model.user_name + "&org_id=" + model.org_id;
	$.ajax({
		url: 'getrightmenudo.jsp',
		type: 'POST',
		dataType: 'json',
		data: params,
		success: function(data) {
			 if(data&&data.msg){
				if(data.flag != 'false') {
					if(data.flag != '') {
						var rightstrArr = data.flag.split(",");
						for(var i=0;i<rightstrArr.length;i++) {
							   arrayItem.push(rightstrArr[i]);
						}

						
					}
				} else {
					alert(data.msg);
				}
			 } 
		},
		error: function(jqXHR, textStatus, errorThrown){
			alert("查询失败"+jqXHR+textStatus+errorThrown);
		}
	});

  return arrayItem;
	
}

//---------右键菜单结束--------------------//

/*
函数:  toUserParamJosn
说明:  构建要查询的参数
参数:   无
返回值: 返回要查询的参数
*/
var toUserParamJosn = function() {
	var isOrgManager = jQuery('input[name="isOrgManager"]:checked').size();
	if(isOrgManager == '0') {
		isOrgManager = '';
	}
	var str = "{'user_name':'"+$("#user_name").val()+"','user_realname':'"+$("#user_realname").val()+"','user_type':'"+$("#user_type").val()
		  +"','user_sex':'"+$("#user_sex").val()+"','user_isvalid':'"+$("#user_isvalid").val()+"','intervalType':'"+$("#intervalType").val()
		  +"','isOrgManager':'"+isOrgManager+"','org_id':'"+$("#org_id").val()+"'}";
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
	函数:  newUser
	说明:  添加用户信息
	参数:   无
	返回值: 
*/
function newUser() {
	var url ='<%=path %>' + '/ccapp/oa/purviewmanager/orgusermanager/org/userInfo.jsp?windowId=windowId&org_id='+jQuery("#org_id").val()+'&type=add';
	openAlertWindows('windowId',url,'新增用户','810','380','10%');
}

/*
	函数:  userInfoquery
	说明:  用户基本信息查看
	参数:   无
	返回值: 
*/
function userInfoquery(userId){ 
	var model = jQuery("#gridTable").jqGrid('getRowData', dataId);
	var url ='<%=path %>' + '/ccapp/oa/purviewmanager/orgusermanager/org/userInfo.jsp?org_id='+jQuery("#org_id").val()+'&user_id=' + model.user_id + '&type=view';
	rightflag = "";
	openAlertWindows('windowId',url,'查看用户基本信息','810','380','10%');
	
}

/*
	函数:  userInfoupdate
	说明:  用户基本信息修改 
	参数:   无
	返回值: 
*/
function userInfoupdate(id){ 
	if(rightflag == "1") {
		var model = jQuery("#gridTable").jqGrid('getRowData', dataId);
	} else {
		var model = jQuery("#gridTable").jqGrid('getRowData', id);
	}
	var url ='<%=path %>' + '/ccapp/oa/purviewmanager/orgusermanager/org/userInfo.jsp?org_id='+jQuery("#org_id").val()+'&user_id=' + model.user_id + '&type=update';
	rightflag = "";
	openAlertWindows('windowId',url,'修改用户','810','500','10%');
}

/*
函数:  resGrant
说明:  用户资源操作授予
参数:   无
返回值: 
*/
function resGrant(){
	var model = jQuery("#gridTable").jqGrid('getRowData', dataId);
	//特检院 OA 【权限管理】-【用户和机构管理】点击左侧根节点，右侧应该递归展示所有该单位下属所有人员资料方便通过【登陆名称】、【用户实名】等条件查询修改用户资料
	<%-- var url ='<%=path %>' + '/ccapp/oa/purviewmanager/grantmanager/columnsetvisible.jsp?currOrgId='+jQuery("#org_id").val()+'&currRoleId=' + model.user_id +"&resTypeId=column&role_type=user&isBatch=false"; --%>
	var url ='<%=path %>' + '/ccapp/oa/purviewmanager/grantmanager/columnsetvisible.jsp?currOrgId='+model.org_id+'&currRoleId=' + model.user_id +"&resTypeId=column&role_type=user&isBatch=false";
	rightflag = "";
	openAlertWindows('windowId',url,'用户['+model.user_realname+']'+'资源操作授予',400,550,'5%','30%');
}

/*
	函数:  purviewReclaim
	说明:  权限回收
	参数:   无
	返回值: 
*/
function purviewReclaim(){
	var model = jQuery("#gridTable").jqGrid('getRowData', dataId);
	var url ='<%=path %>' + '/ccapp/oa/purviewmanager/reclaimManager/reclaimuserres.jsp?orgId='+jQuery("#org_id").val()+'&userIds=' + model.user_id;
	rightflag = "";
	openAlertWindows('windowId',url,'用户权限回收','450','300','10%','30%');
}

/*
函数:  roleGrant
说明:  机构下的用户角色授予
参数:   无
返回值: 
*/
function roleGrant(){
	var model = jQuery("#gridTable").jqGrid('getRowData', dataId);
	var url ='<%=path %>' + '/ccapp/oa/purviewmanager/orgusermanager/user/changerole_ajax.jsp?orgId='+jQuery("#org_id").val()+'&userId=' + model.user_id;
	rightflag = "";
	openAlertWindows('windowId',url,'用户角色授予','600','650','1%','30%');
}

/*
函数:  dataConfig
说明:  数据权限配置
参数:   无
返回值: 
*/
function dataConfig() {
	var model = jQuery("#gridTable").jqGrid('getRowData', dataId);
	var url ='<%=path %>' + '/ccapp/oa/purviewmanager/dataresource/jsp/dateresourcestree.jsp?userId=' + model.user_id;
	rightflag = "";
	openAlertWindows('windowId',url,'数据权限配置','600','620','1%','30%');
}
/*
	函数:  userOrg
	说明:  用户可管理的机构列表信息
	参数:   无
	返回值: 
*/
function userOrg(userId){
	var model = jQuery("#gridTable").jqGrid('getRowData', dataId);
	var url ='<%=path %>' + '/ccapp/oa/purviewmanager/orgusermanager/user/managerorg_list.jsp?orgId='+jQuery("#org_id").val()+'&userId=' + model.user_id;
	rightflag = "";
	openAlertWindows('windowId',url,'用户【'+model.user_realname+'】可管理的部门列表','900','650','1%','20%');
}

/*
	函数:  userResList
	说明:  用户权限查询
	参数:   无
	返回值: 
*/
function userResList(userId){
	var model = jQuery("#gridTable").jqGrid('getRowData', dataId);
	var url ='<%=path %>' + '/ccapp/oa/purviewmanager/orgusermanager/user/userres_queryframe.jsp?orgId='+jQuery("#org_id").val()+'&userId=' + model.user_id;
	rightflag = "";
	openAlertWindows('windowId',url,'用户【'+model.user_realname+'】资源权限查询','900','650','1%','20%');
}

/*
	函数:  quiteDelUser
	说明:  彻底删除用户
	参数:   无
	返回值: 
*/
function quiteDelUser() {
	var ids = "";
	var selectedIds = $("#gridTable").jqGrid("getGridParam", "selarrrow");
	for ( var i = 0; i < selectedIds.length; i++) {
		var model = jQuery("#gridTable").jqGrid('getRowData',selectedIds[i]);
		if ("" != ids) {
			ids += ",";
		}
		ids += model.user_id;

	}
	if (IsSpace(ids)) {
		alert("请选择要删除的记录！");
	} else {
		var okF = function(){
			$("#form1").attr("action","quitedeluser.jsp?checks="+ids+"&orgId="+jQuery("#org_id").val());
			$("#form1").attr("target","hiddenFrame");
			jQuery('#form1').submit();
		}
		var p={
					headerText:'提示',
					okName:'确认',
			        okFunction:okF,
			        cancelName:'取消'
			};
		alert("您确认删除吗？（删除后该用户将不存在！）",p)
	}
}


/*
	函数:  orderUser
	说明:  用户排序
	参数:   无
	返回值: 
*/
function orderUser() {
	var url ='<%=path %>' + '/ccapp/oa/purviewmanager/orgusermanager/org/user_order_ajax.jsp?orgId=' + jQuery("#org_id").val();
	openAlertWindows('windowId',url,'用户排序','450','550','10%','25%');
}

/*
函数:  orderUserTree
说明:  用户排序
参数:   无
返回值: 
*/
function orderUserTree() {
	var backFn = function(){window.location.reload();};
	var url ='<%=path %>' + '/ccapp/oa/purviewmanager/orgusermanager/org/user_order_ajax_tree.jsp?orgId=' + jQuery("#org_id").val();
	openAlertWindows('windowId',url,'用户排序','450','550','10%','25%',backFn);
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
函数:  usercheckorgmove
说明:  用户调动拖动
参数:   无
返回值: 
*/
function usercheckorgmove(){
	var backfn=function(){window.location.reload();};
	var url ='<%=path %>' + '/ccapp/oa/purviewmanager/orgusermanager/org/userchangeorgmove.jsp?';
	openAlertWindows('windowId',url,'用户调动','400','650','3%','25%',backfn);

}
function addorg(dealType) 
{
	var ids = "";
	var selectedIds = $("#gridTable").jqGrid("getGridParam", "selarrrow");
	for ( var i = 0; i < selectedIds.length; i++) {
		var model = jQuery("#gridTable").jqGrid('getRowData',selectedIds[i]);
		if ("" != ids) {
			ids += ",";
		}
		ids += model.user_id;

	}
    if(ids != "")
    {
	    if(dealType==1)
	    {
			var winaddorg;
			var url = "<%=path %>" + "/ccapp/oa/purviewmanager/orgusermanager/org/userchangeorg.jsp?subid=windowId&checkBoxOne="+ids + "&orgId=<%=org_id%>";
			openAlertWindows('windowId',url,'用户调出','400','600','3%','25%');
			//winaddorg = window.showModalDialog(url,window,"dialogWidth:"+(400)+"px;dialogHeight:"+(600)+"px;help:no;scroll:auto;status:no;maximize=yes;minimize=0");

			if(winaddorg=="ok")
			{
				window.location.reload();
			}
		}
	}
	else
	{
    	alert("至少要选择一条记录！");
    	return false;
    }
	return false;
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

function excelimport(){
	  openAlertWindows('windowId', '${pageContext.request.contextPath}/ccapp/oa/resources/util/excel/excelimport.jsp?excelImplClass=userExcelToData&excelTemplateFilePath=userinfo_excelTemplateFilePath&title=用户信息&remark=',
	            '导入excel表格', '455px', '70%', '10%', '40%', function() {
	                location.reload();
	            });
}

</script>
</head>
<body>
<input type="hidden" name="org_id" id="org_id" value="<%=org_id %>"></input>
<%if(!StringUtil.isBlank(org_id)) { %>
<table width="100%" id="queryTable">
	<tr>
		<td>
			<table cellspacing="1" cellpadding="0" border="0" bordercolor="#EEEEEE" width="100%">
         				<tr style="align:left">
         					<td height='40' style="align:left" colspan="8">
         					<div align="left">
         					<%
	         					//判断是否禁用机构用户增删改菜单开关
	         				  	//minghua.guo[2010-12-13]
         						if(!orguser_modify_forbidden && accesscontroler.checkPermission("orgunit", "newdeluser", AccessControl.ORGUNIT_RESOURCE)){
         					%>
         						<a onClick="newUser()"><u>新增用户</u></a> |
         						<a onClick="quiteDelUser()"><u>删除用户</u></a> | 
         					<%
         						}
         					%>        						
								<a onClick="orderUser()"><u>用户排序</u></a> |
								<a onClick="orderUserTree()"><u>用户排序tree</u></a> |	
							<%
	         					//判断是否禁用机构用户增删改菜单开关
	         				  	//minghua.guo[2010-12-13]
         						//if(!orguser_modify_forbidden && 
         								//accesscontroler.checkPermission("orgunit","usermanager", AccessControl.ORGUNIT_RESOURCE) && isUserOrgs){
         					%>							
								<%--<a href="#" onClick="foldUser()"><u>用户调入</u></a> |--%>
								<a onClick="addorg(1)"><u>用户调出</u></a> |
								<a onClick="usercheckorgmove()"><u>用户调动拖动</u></a> |
								 <a onClick="usercheckorg()"><u>用户调动</u></a> | 
							<%
								//}
							%>
								<a onClick="roleUser(1)"><u>批量角色授予</u></a> | 
								<%
									if(isJobOpen){
								%>
								<!-- <a href="#" onClick="jobUser(1)"><u>批量岗位授予</u></a> | -->
								<%  }%>
							<%
         						if(accesscontroler.checkPermission("orgunit", "purset", AccessControl.ORGUNIT_RESOURCE)){
         					%>	
								<!--<a href="#" onClick="operUser(1)"><u>批量权限授予</u></a> |-->
								<a onClick="purviewReclaimUsers()"><u>批量权限回收</u></a>	
							<%
								}
							%>		
							<a onClick="refreshcache(1)"><u>机构缓存刷新</u></a>	
							<a onClick="refreshcache(2)"><u>用户缓存刷新</u></a>	
							<a onClick="excelimport()"><u>用户导入</u></a>			 							
							</div>
							</td>
						</tr>
			</table>
		</td>
	</tr>
</table>
<div style="overflow:auto;height: 390px; ">
<table>
	<tr>
		<td>
			<!-- 查询条件选区    tabs_search_ctable(查询table样式) -->
			<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tabs_search_ctable_box">
				<tr>
					<td>
						<!-- 固定查询 -->
						<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tabs_search_ctable">
							<tr>
								 <th class="input_cx_title_th">登录名称：</th>
						           <td class="cx_title_td">
						           <INPUT class="input_170"  id="user_name" name="user_name" >
						           </td>
								<td width="385"  colspan="2"  >
								<input name="Input2" value="搜索" type="button" onclick="userSearch()" class="but_y_01"/>
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
								<th class="input_cx_title_th">用户实名：</th>
								<td><input type="text" name="user_realname" id="user_realname" class="input_cx_title_283"></td>
								<th class="input_cx_title_th">用户类型：</th>
								<td>
									<select name="user_type" id="user_type">
										<option value="" selected>--请选择--</option> 
           								<option value="0">系统用户</option>          						
           								<option value="1">外部用户</option>
								    </select>
								</td>
							</tr>
							<tr>
								<th class="input_cx_title_th">用户性别：</th>
								<td>
									<select name="user_sex" id="user_sex"> 
										<option value="" selected>--请选择--</option> 
           								<option value="M">男</option>          						
           								<option value="F">女</option>
								    </select>
								<th class="input_cx_title_th">当前状态：</th>
								<td>
									<select name="user_isvalid" id="user_isvalid"> 
										<option value="" selected>--请选择--</option> 
           								<option value="2">开通</option>          						
           								<option value="1">停用</option>
								    </select>
								</td>
							</tr>
							<tr>
								<th class="input_cx_title_th">查询方式：</th>
								<td>
									<select name="intervalType" id="intervalType"> 
           								<option value="0" selected>不递归机构查询</option>          						
           								<option value="1">递归机构查询</option>
								    </select>
								</td>
								<th class="input_cx_title_th">管理员查询：</th>
								<td><input type="checkbox" name="isOrgManager" id="isOrgManager"  /></td>
								
							</tr>
						</table>
					<!-- 隐藏查询 end-->
					</td>
				</tr>
		</table>
		</td>
	</tr>
</table>

<!-- 查询列表区 cGridArea(查询区样式)-->
<div class="cGridArea" style="width: 98%;">
  <table id="gridTable">
  </table>
  <div id="gridPager"></div>
</div>
<%} else { %>
    请选择一个机构
<%} %>
</div>
<form action="" id="form1" name="form1" method="post"></form>

<iframe name="hiddenFrame" width="0" height="0"></iframe>
</body>
</html>

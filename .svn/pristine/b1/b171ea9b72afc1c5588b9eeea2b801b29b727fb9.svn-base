<%-- 
描述：用户管理列表页面
作者：黄艺平
版本：1.0
日期：2013-05-24
 --%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.frameworkset.common.tag.contextmenu.Menu"%>
<%@ page import="com.frameworkset.common.tag.contextmenu.ContextMenu"%>
<%@ page import="com.chinacreator.config.ConfigManager"%>
<%@ page import="com.chinacreator.sysmgrcore.entity.Group"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.GroupManager"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>
<%@ page import="com.chinacreator.resource.ResourceManager"%>
<%@ page import="com.frameworkset.common.tag.contextmenu.ContextMenuTag"%>
<%@ page import="com.frameworkset.common.tag.contextmenu.ContextMenuImpl"%>
<%@ page import="com.chinacreator.epp.util.SQLHelper"%>
<%@ page import="com.chinacreator.epp.util.EgpManager"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<%
AccessControl accesscontroler = AccessControl.getAccessControl();
accesscontroler.checkAccess(request, response);
String path = request.getContextPath();
String group_id = request.getParameter("group_id");
//得到当前用户的ID
	String curUserId=accesscontroler.getUserID();
	//得到用户组的创建人
	GroupManager groupManager=SecurityDatabase.getGroupManager();
  Group group=groupManager.getGroupByID(group_id);
  
  String groupowner_id = String.valueOf(group.getOwner_id());
  
	String sql = "";	
	
	String userRealName = SQLHelper.parameterFormat(request.getParameter("userRealName"));
	String userName = SQLHelper.parameterFormat(request.getParameter("userName"));
	
	// 权限是否关联机构
	// 彭盛 2011-3-15 
	boolean isrolerelatedorg = ConfigManager.getInstance().getConfigBooleanValue("isrolerelatedorg", false);
	
	
	if(group_id == null || "".equals(group_id))
	{
		group_id="-1";
		userName = "";
		userRealName = "";
	}
	else
	{		
		//获取用户信息
			sql = "select distinct ";
			if(isrolerelatedorg){
				sql += "o.remark5 || '(' || getuserjobinfos(u.user_id,o.org_id) || ')' as org_name,o.org_id,";
			}else{
				sql += "getUserorgjobinfos(to_char(u.user_id) || '') as org_name,"; 
			}
			sql +="u.user_id,u.user_name,u.user_realname,u.user_mobiletel1 ";
			sql +="from td_sm_group g,td_sm_usergroup ug,td_sm_user u,td_sm_organization o ";
			if(isrolerelatedorg){
				sql += ",td_sm_userjoborg ujo";
			}else{
				sql += ",td_sm_orguser ujo";
			}
			sql +=" where g.group_id = ug.group_id and ug.user_id = u.user_id and u.user_id = ujo.user_id and ujo.org_id = o.org_id "; 
			sql +=" and g.group_id = " + group_id +"";
			if(isrolerelatedorg){
				sql += " and ug.org_id=o.org_id";
			}
			if(userName != null && !userName.equals(""))
			{
				sql +=" and u.user_name like '%" + userName +"%'";
			}
			else
			{
				userName = "";
			}
			
			if(userRealName != null && !userRealName.equals(""))
			{
				sql +=" and u.user_realname like '%" + userRealName +"%'" ;
			}	
			else
			{
				userRealName = "";
			}			
	}

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
		url: '<%= path %>' + '/pubListServlet?classNameId=com.chinacreator.xtbg.core.purviewmanager.list.UserGroupList',//pubListServlet列表公共的servlet,classNameId在servletBean.xml文件中配置要调用的类,isPage:是否翻页(true,false),默认为true
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
		colNames: ['机构ID','用户ID','用户实名 ','登陆名称 ' , '所在机构 ','手机号码 '],
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
			name: 'user_realname',
			index: 'user_realname',
			width: 180,
			editable: true,
			sortable: false
		},
		{
			name: 'user_name',
			index: 'user_name',
			width: 180,
			editable: true,
			sortable: false
		},
		{
			name: 'org_name',
			index: 'org_name',
			width: 130,
			editable: true,
			sortable: false
		},
		{
			name: 'user_mobiletel1',
			index: 'user_mobiletel1',
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
			if(model.user_mobiletel1=='' || model.user_mobiletel1==null){
				user_mobileTel1='没有号码'
			}else{
				user_mobileTel1=model.user_mobiletel1
			}
			jQuery("#gridTable").jqGrid('setRowData', ids[i], {
				user_mobiletel1: user_mobileTel1
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

//---------右键菜单--------------------//	

$().ready(function() {
		var option = { 
			width: 150, 
			items: [
				{ text: "用户信息查看", icon: "../resources/images/edit.gif", alias: "1-1", action: viewUserInfo},
				{ text: "隶属组设置", icon: "../resources/images/edit.gif", alias: "1-2", action: subTeam}
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
function subTeam()
{
//用户隶属组
	var model = jQuery("#gridTable").jqGrid('getRowData', dataId);
	var url ="<%=path %>" + "/ccapp/oa/purviewmanager/groupmanager/user2group.jsp?subid=subteam&userId="+ model.user_id+"&orgId="+model.org_id;
	openAlertWindows('subteam',url,'用户信息查询','800','450','3%','25%');
	
}

function viewUserInfo()
{
//用户基本信息
	var model = jQuery("#gridTable").jqGrid('getRowData', dataId);
	var url ="<%=path %>" + "/ccapp/oa/purviewmanager/groupmanager/userinfo1.jsp?subid=userinfo&userId="+ model.user_id;
	openAlertWindows('userinfo',url,'用户信息查询','800','450','3%','25%');		
	
}
//---------右键菜单结束--------------------//
/*
函数:  toUserParamJosn
说明:  构建要查询的参数
参数:   无
返回值: 返回要查询的参数
*/
var toUserParamJosn = function() {
	var str = "{'remark1':'<%=group_id %>','user_realname':'"+$("#user_realname").val()+"','user_name':'"+$("#user_name").val()+"'}";
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
	函数:  clearInfo
	说明:  清空查询值
	参数:   无
	返回值: 无
 */
var clearInfo=function(){
	$("#user_realname").val("");
	$("#user_name").val("");
}

var groupId = "<%=group_id%>";

//增加子用户组
function addsonGroup()
{
	if(groupId == -1)
	{
		alert("请选择用户组!!!");
		return false ;
	}
	

	var url ="<%=path %>" + "/ccapp/oa/purviewmanager/groupmanager/groupinfo_addson.jsp?subid=addson&groupId="+ groupId;
	openAlertWindows('addson',url,'新增子用户组','800','350','3%','25%');					 
	
}

//修改用户组
function editGroup()
{
	if(groupId == -1)
	{
		alert("请选择用户组!!!");
		return false;
	}
	
	var url ="<%=path %>" + "/ccapp/oa/purviewmanager/groupmanager/groupinfo_edit.jsp?subid=update&groupId="+ groupId;
	openAlertWindows('update',url,'修改用户组','800','350','3%','25%');		 							 
}


//删除用户组
function delGroup()
{
	if(groupId == -1)
	{
		alert("请选择用户组!!!");
		return false;
	}
	var okF = function(){
		var fm = document.getElementById("form1");
		fm.target = "hiddenFrame";
		fm.submit();}
	var p={
		headerText:'提示',
		okName:'确认',
		okFunction:okF,
		cancelName:'取消'
		};  
	alert("你确认要删除这个用户组吗？",p);
	
}

function changeRole()
{
	if(groupId == -1)
	{
		alert("请选择用户组!!!");
		return false;
	}
	
	var url ="<%=path %>" + "/ccapp/oa/purviewmanager/groupmanager/changerole_ajax.jsp?subid=role&groupId="+ groupId;
	openAlertWindows('role',url,'关联角色','800','450','3%','25%');		 
}

function addRole()
{
	if(groupId == -1)
	{
		alert("请选择用户组!!!");
		return false;
	}
	var url ="<%=path %>" + "/ccapp/oa/purviewmanager/groupmanager/group2user.jsp?subid=addrole&groupId="+ groupId;
	openAlertWindows('addrole',url,'隶属用户','800','450','3%','25%');
}

function lookInfo()
{
	if(groupId == -1)
	{
		alert("请选择用户组!!!");
		return false;
	}	
	
	var url ="<%=path %>" + "/ccapp/oa/purviewmanager/groupmanager/usergroupinfo.jsp?subid=look&groupId="+ groupId;
	openAlertWindows('look',url,'查看用户组','850','400','3%','25%');
}

function clearInfo()
{
	document.getElementById("userName").value = '';
	document.getElementById("userRealName").value = '';
}
</script>
</head>
<body >	
			<div id="contentborder" align="center">
				<form name="groupForm" method="post" >	
					<input type="hidden" name="groupId" value="<%=group_id%>"/>
					<table cellspacing="1" cellpadding="0" border="0" bordercolor="#EEEEEE" width=100% class="thin">
						<tr style="align:left">
							<td height='30' style="align:left" colspan=5>
							<%
							//具有超级管理员角色的或者是用户自己创建的用户不加任何控制 
							//2008-4-9 baowen.liu
							if(accesscontroler.isAdmin() || 
								(curUserId.equals(groupowner_id) && accesscontroler.checkPermission("globalgroup",
		                           "groupmanager", AccessControl.GROUP_RESOURCE))){
							%>
							<div align="left">&nbsp;&nbsp;&nbsp;
								<a href="#" onclick="addRole();">
									<u>添加隶属用户</u>
								</a> | 
								
								<a href="#" onclick="changeRole();">
									<u>关联角色</u>
								</a> | 
								
								<a href="#" onclick="editGroup();">
									<u>修改用户组信息</u>
								</a> | 
								
								<a href="#" onclick="delGroup();">
									<u>删除用户组</u>
								</a> | 
								
								<a href="#" onclick="lookInfo();">
									<u>查看用户组信息</u>
								</a> | 
		
								<a href="#" onclick="addsonGroup();">
									<u>新增子组</u>
								</a>						
							</div>
							<%
							}else if(accesscontroler.checkPermission("globalgroup",
		                           "groupmanager", AccessControl.GROUP_RESOURCE)){//查看时候授权用户组全局操作的权限
							%>
							<div align="left">
								<a href="#" onclick="addsonGroup();">
									<u>新增子组</u>
								</a>
							</div>
							<% 
								}
							%>
							</td>
						</tr>
						<tr>
							 <th class="input_cx_title_th">用户实名：</th>
						           <td class="cx_title_td">
						           <INPUT class="input_cx_title_120"  id="user_realname" name="user_realname" >
						           </td>
							<th class="input_cx_title_th">登陆名称：</th>
						           <td class="cx_title_td">
						           <INPUT class="input_cx_title_120"  id="user_name" name="user_name" >
						           </td>
						      	<td width="385"  colspan="2"  >
									<input name="Input2" value="搜索" type="button" onclick="userSearch()" class="but_y_01"/>
									<input type="button"  value="清空" onclick="clearInfo()"  class="but_y_01"/>
								</td>
						</tr>
					</table>
				
				<hr width="100%">
				</form>
		</div>
<div class="cGridArea">
  <table id="gridTable">
  </table>
  <div id="gridPager"></div>
</div>

<form action="submitgroup.jsp?group_id=<%=group_id %>" id="form1" name="form1" method="post">
<input type="hidden" id="action" name="action" value="del" />
</form>
<iframe name="hiddenFrame" width="0" height="0"></iframe>
	</body>
</html>

<%--
描述：角色管理主页面
作者：王博
版本：1.0
时间：2013-5-15
 --%>
<%@page contentType="text/html; charset=UTF-8"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.RoleTypeManager"%>
<%@ page import="com.chinacreator.sysmgrcore.entity.RoleType"%>
<%@ page import="java.util.*"%>
<%
	AccessControl control = AccessControl.getInstance();
	control.checkManagerAccess(request, response);//管理员鉴权，权限管理只有管理员才能进行操作
	
	String path = request.getContextPath();
	
	RoleTypeManager rtm = new RoleTypeManager();
	List<RoleType> typenamelist = (List<RoleType>)rtm.getTypeNameList();
	if(typenamelist == null){
		typenamelist = new ArrayList<RoleType>();
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>角色管理</title>
</head>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../resources/plug/jquery1.7/jquery-1.7.1.min.js"></script>
<script src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>
<!-- 引入jGrid -->
<script src="../../resources/plug/jquery.jqGrid-4.3.1/js/i18n/grid.locale-en.js" type="text/javascript"></script>
<script src="../../resources/plug/jquery.jqGrid-4.3.1/js/jquery.jqGrid.min.js" type="text/javascript"></script>
<!-- 引入其它 -->
<script src="../../resources/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script> 
<!-- 右键菜单 -->
<script src="../../resources/plug/jquery.jqGrid-4.3.1/menu/jquery.contextmenu.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" media="screen" href="../../resources/plug/jquery.jqGrid-4.3.1/menu/contextmenu.css" />


<script type="text/javascript">
var dataId = "";
$(function() {
	
	$(document).keydown(function(){
		if(event.keyCode == 13){//页面中回车事件 做查询 
			roleSearch();
		}
	});
	
	
	$("#gridTable").jqGrid({
		url: '<%=path%>' + '/pubListServlet?classNameId=com.chinacreator.xtbg.core.purviewmanager.list.RoleList',
				datatype : "json",
				mtype : "POST",
				height : "100%",
				autowidth : true,
				colNames : [ '角色id','名称','类型','类型id','描述', '创建人'],
				colModel : [
				{name : 'role_id',hidden : true},
				{name : 'role_name',index : 'role_name',width : 150},
				{name : 'role_type',index : 'role_type',width : 150},
				{name : 'role_type_id',hidden : true},
				{name : 'role_desc',index : 'role_desc',width : 560},
				{name : 'owner_user',index : 'owner_user',width : 150}
				],
				sortname : '',
				sortorder : '',
				viewrecords : true,
				rowNum : 10,
				rowList : [ 10, 20, 30 ],
				jsonReader : {
					repeatitems : false
				},
				pagerintoolbar:true,//上面的分页条
				pagerinBottombar:true,//下面的分页条
				search : toRoleParamJosn(),
				prmNames : { //这是一个数组，用于设置jqGrid将要向Server传递的参数名称
					rows : "rows",
					//表示请求行数的参数名称  
					sort : "sidx",
					//表示用于排序的列名的参数名称  
					order : "sord",
					//表示采用的排序方式的参数名称 
					search : "search"
				},
				toolbar : [ true, "top" ,
				            "<input class='but_y_01' onMouseOver=javascript:$(this).attr('class','but_y_02'); onMouseOut=javascript:$(this).attr('class','but_y_01'); id=add value='添加' type='button' onclick='addRole()' value=''/>"
				           +"<input class='but_y_01' onMouseOver=javascript:$(this).attr('class','but_y_02'); onMouseOut=javascript:$(this).attr('class','but_y_01'); value='删除' id=del type='button' onclick='delRole()' value=''/>"
				           ],
				multiselect : true,
				onRightClickRow: function(id){ //右键事件
					dataId = id;
				},
				beforeSelectRow: function (id, e) {
		        	var $myGrid = $(this),  
		            i = $.jgrid.getCellIndex($(e.target).closest('td')[0]),  
		            cm = $myGrid.jqGrid("getGridParam", "colModel");
		            if(cm[i].name != 'cb'){
		            	editRole(id);
					}
		        	return (cm[i].name == 'cb');  
		    	},
		    	gridComplete: function() {
		    		var ids = $("#gridTable").getDataIDs(); //jqGrid('getDataIDs');
		    		for (var i = 0; i < ids.length; i++) {
						var cl = ids[i];
						var model = jQuery("#gridTable").jqGrid('getRowData', cl);
						//复选框
						 var curRowData = jQuery("#gridTable").jqGrid('getRowData', ids[i]);
		                 var curChk = $("#"+ids[i]+"").find(":checkbox");
		                 if(model.role_id == '1' || model.role_id == '2' || model.role_id == '3' || model.role_id == '4') {
		                 	curChk.hide();
		                 }
					
					}
			    }
			}).navGrid('#gridPager', {
			edit : false,
			add : false,
			del : false,
			refresh: false,
			search: false
		});
	});
	
	//---------右键菜单--------------------//		
	$().ready(function() {
			var option = { 
				width: 150, 
				items: [
					{ text: "菜单资源授予", icon: "../resources/images/status_reopened.gif", alias: "1-1", action: roleMenuPurview },
					{ text: "权限回收", icon: "../resources/images/recycle.gif", alias: "1-2", action: reclaimPurview },
					{ text: "机构授予", icon: "../resources/images/procedure.gif", alias: "1-3", action: rightOrgList },
					{ text: "用户授予", icon: "../resources/images/profile.gif", alias: "1-4", action: rightUserList },
					{ text: "权限查询", icon: "../resources/images/listQuery.gif", alias: "1-5", action: roleResList },
					{ text: "角色授予查询", icon: "../resources/images/milestone.gif", alias: "1-6", action: roleGrantList }
				]
			};
			
		$("#gridTable").contextmenu(option);
	});
	
	//菜单资源授予
	function roleMenuPurview(){
		var model = jQuery("#gridTable").jqGrid('getRowData', dataId);
		var url = '<%=path %>' + "/ccapp/oa/purviewmanager/grantmanager/columnsetvisible.jsp?currRoleId="+model.role_id+"&windowId=windowId&resTypeId=column&role_type=role&isBatch=false";
		openAlertWindows('windowId',url,'['+model.role_name+']'+'菜单资源授予',400,545,'5%','30%');	
	}
	//---------右键菜单结束--------------------//
	
	
	/*
	 函数:  roleSearch
	 说明:  查询角色信息
	 参数:   无
	 返回值: 角色列表
	 */
	var roleSearch = function() {
		var sdata = { //构建查询需要的参数 
			paramJson : toRoleParamJosn()
		}; //获得当前postData选项的值  
		var postData = $("#gridTable").jqGrid("getGridParam", "postData"); //将查询参数融入postData选项对象  
		$.extend(postData, sdata);
		$("#gridTable").jqGrid("setGridParam", {
			search : true
		// 将jqGrid的search选项设为true  
		}).trigger("reloadGrid", [ {
			page : 1
		} ]); //重新载入Grid表格，以使上述设置生效 
	}
	
	/*
	 函数:  toRoleParamJosn
	 说明:  构建要查询的参数
	 参数:   无
	 返回值: 返回要查询的参数
	 */
	var toRoleParamJosn = function() {
		var str = "{'role_name':'" + descape(escape($("#role_name").val())) 
				+ "','role_type':'" + descape(escape($("#role_type").val())) 
				+ "','role_desc':'" + descape(escape($("#role_desc").val())) 
				+ "','owner_user':'" + descape(escape($("#owner_user").val())) 
				+ "'}";
		return descape(str);
	}
	
	/*
	添加角色
	*/
	var addRole = function(){
		openAlertWindows('windowId','<%=path %>' + '/ccapp/oa/purviewmanager/rolemanager/addrole.jsp?windowId=windowId','添加角色',800,270,'25%','25%');		
	}
	
	var editRole = function(id){
		var model = jQuery("#gridTable").jqGrid('getRowData', id);
		url = '<%=path %>' + "/ccapp/oa/purviewmanager/rolemanager/updaterole.jsp?role_id="+model.role_id+"&role_name="+descape(escape(model.role_name))
				+"&role_type_id="+model.role_type_id+"&role_type="+model.role_type+"&role_desc="+descape(escape(model.role_desc))+"&windowId=windowId";
		openAlertWindows('windowId',url,'修改角色',800,270,'25%','25%');		
	}
	
	/*
	删除角色
	*/
	var delRole = function(){
		var ids = "";
		var selectedIds = $("#gridTable").jqGrid("getGridParam", "selarrrow");
		for(var i = 0; i < selectedIds.length; i++) {
			var model = jQuery("#gridTable").jqGrid('getRowData', selectedIds[i]);
			 if("" != ids){			   
				ids += ";";
			 }
			 if(model.role_id == '1' || model.role_id == '2' || model.role_id == '3' || model.role_id == '4') {
			 } else {
			 	ids += model.role_id;
			 }
		}
		if (IsSpace(ids)) {
			alert("请选择要删除的记录！");
		} else {
			var okF = function(){
				var url = "deleterole.jsp";
				$("#role_ids").val(ids);
				document.all.form1.action = url;
				document.all.form1.target = "hiddenFrame";
				document.all.form1.submit();
			}
			var p={
					headerText:'提示',
					okName:'确认',
			        okFunction:okF,
			        cancelName:'取消'
			};
			alert("确定要删除选定的角色吗？",p);
		}
	}

	/*
	 函数:  reclaimPurview
	 说明:  角色回收
	 参数:   无
	 返回值: 
	 */
	function reclaimPurview(){
		var model = jQuery("#gridTable").jqGrid('getRowData', dataId);
		var okF = function(){
			var url = "../reclaimManager/reclaimroleres_do.jsp?roleId="+model.role_id;
			document.all.form1.action = url;
			document.all.form1.target = "hiddenFrame";
			document.all.form1.submit();
		}
		var p={
				headerText:'提示',
				okName:'确认',
		        okFunction:okF,
		        cancelName:'取消'
		};
		alert("确定要回收角色的资源吗?",p);
	}

	/*
	 函数:  rightOrgList
	 说明:  机构授予
	 参数:   无
	 返回值: 
	 */
	function rightOrgList(){
		var model = jQuery("#gridTable").jqGrid('getRowData', dataId);
		url = '<%=path %>' + "/ccapp/oa/purviewmanager/rolemanager/role2org.jsp?roleId="+model.role_id
		openAlertWindows('windowId',url,'机构授予',850,500,'5%','15%');	
	}

	/*
	 函数:  rightUserList
	 说明:  用户授予
	 参数:   无
	 返回值: 
	 */
	function rightUserList(){
		var model = jQuery("#gridTable").jqGrid('getRowData', dataId);
		url = '<%=path %>' + "/ccapp/oa/purviewmanager/rolemanager/role2user.jsp?roleId="+model.role_id
		openAlertWindows('windowId',url,'用户授予',850,500,'5%','15%');	
	}

	/*
	 函数:  roleResList
	 说明:  权限查询
	 参数:   无
	 返回值: 
	 */
	function roleResList(roleId){
		var model = jQuery("#gridTable").jqGrid('getRowData', dataId);
		var typeName = "role";
		url = '<%=path %>' + "/ccapp/oa/purviewmanager/rolemanager/roleres_queryframe.jsp?roleId="+model.role_id + "&typeName=" + typeName
		openAlertWindows('windowId',url,'权限查询',850,500,'5%','25%');	
	}

	/*
	 函数:  roleGrantList
	 说明:  角色授予查询对象（对用户、机构）
	 参数:   无
	 返回值: 
	 */
	function roleGrantList(roleId) {
		var model = jQuery("#gridTable").jqGrid('getRowData', dataId);
		url = '<%=path %>' + "/ccapp/oa/purviewmanager/rolemanager/rolegrantframe.jsp?&roleId="+model.role_id;
		openAlertWindows('windowId',url,'角色权限查询',850,500,'5%','25%');
	}
</script>
</head>
<body>
	<div><!-- 查询条件选区    tabs_search_ctable(查询table样式) -->
		<table id="queryTable" width="100%" border="0" cellspacing="0" cellpadding="0" class="tabs_search_ctable_box">
			<tr>
				<td><!-- 固定查询 -->
					<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tabs_search_ctable">
						<tr>
							<th width="90" class="input_cx_title_th" nowrap>
								名称：
							</th>
							<td width="296" class="cx_title_td">
								<input type="text" id="role_name" class="input_cx_title_283">
							</td>
							<th width="90" class="input_cx_title_th" nowrap>
								类型：
							</th>
							<td class="cx_title_td">
								<select name="role_type" id="role_type">
									<option value="">--请选择--</option>
									<%for(RoleType bean : typenamelist) {%>
										<option value="<%=bean.getTypeName() %>"><%=bean.getTypeName() %></option>
									<%} %>
								</select>
							</td>
							<td  nowrap>
								<input value="搜索" id="sel" type="button" onclick="roleSearch()" class="but_y_01" />
								<span id="selAreaImg" class="all_search_condition">
									<a onclick="hiddenOrShowSelArea('hiddenArea','selAreaImg')">更多搜索条件</a>
								</span>
							</td>
						</tr>
					</table>
				</td>
				<!-- 固定查询 end-->
			</tr>
			<tr>
				<td>
					<table width="100%" border="0" cellspacing="0" cellpadding="0"
							class="tabs_search_ctable" id="hiddenArea" style="display: none">
						<tr>
							<th class="input_cx_title_th" nowrap>描述：</th>
							<td class="cx_title_td"><input type="text" id="role_desc" class="input_cx_title_283"></td>
							<th class="input_cx_title_th" nowrap>创建人：</th>
							<td class="cx_title_td"><input type="text" id="owner_user" class="input_cx_title_283"></td>
			   			</tr>
				  	</table>
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
	<form id="form1" name="form1" method="post" >
	  <input id="role_ids" name="role_ids" type="hidden"/>
	</form>
	<iframe name="hiddenFrame" width=0 height=0></iframe>
</body>
</html>

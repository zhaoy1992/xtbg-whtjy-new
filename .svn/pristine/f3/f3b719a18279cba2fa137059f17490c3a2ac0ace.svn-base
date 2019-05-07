<%--
描述：角色类型管理主页面
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
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>角色类型管理</title>
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


<script type="text/javascript">
$(function() {
	
	$(document).keydown(function(){
		if(event.keyCode == 13){//页面中回车事件 做查询 
			roleTypeSearch();
		}
	});
	
	$("#gridTable").jqGrid({
		url: '<%=path%>' + '/pubListServlet?classNameId=com.chinacreator.xtbg.core.purviewmanager.list.RoleTypeList',
				datatype : "json",
				mtype : "POST",
				height : "100%",
				autowidth : true,
				colNames : [ '角色类型id','类型名称','类型描述', '创建人'],
				colModel : [
				{name : 'type_id',hidden : true},
				{name : 'type_name',index : 'type_name',width : 150},
				{name : 'type_desc',index : 'type_desc',width : 650},
				{name : 'creator_user',index : 'creator_user',width : 150}
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
				search : toRoleTypeParamJosn(),
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
				            "<input class='but_y_01' onMouseOver=javascript:$(this).attr('class','but_y_02'); onMouseOut=javascript:$(this).attr('class','but_y_01'); id=add value='添加' type='button' onclick='addRoleType()' value=''/>"
				           +"<input class='but_y_01' onMouseOver=javascript:$(this).attr('class','but_y_02'); onMouseOut=javascript:$(this).attr('class','but_y_01'); value='删除' id=del type='button' onclick='delRoleType()' value=''/>"
				           ],
				multiselect : true,
				beforeSelectRow: function (id, e) {
		        	var $myGrid = $(this),  
		            i = $.jgrid.getCellIndex($(e.target).closest('td')[0]),  
		            cm = $myGrid.jqGrid("getGridParam", "colModel");
		            if(cm[i].name != 'cb'){
		            	editRoleType(id);
					}
		        	return (cm[i].name == 'cb');  
		    	}
			}).navGrid('#gridPager', {
			edit : false,
			add : false,
			del : false,
			refresh: false,
			search: false
		});
	});
	
	var roleTypeSearch = function() {
		var sdata = { //构建查询需要的参数 
			paramJson : toRoleTypeParamJosn()
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
	
	var toRoleTypeParamJosn = function() {
		var str = "{'type_name':'" + descape(escape($("#type_name").val())) 
				+ "','type_desc':'" + descape(escape($("#type_desc").val())) 
				+ "'}";
		return descape(str);
	}
	
	/*
	添加角色
	*/
	var addRoleType = function(){
		openAlertWindows('windowId',getCurrentFilePath()+'addroletype.jsp?windowId=windowId','添加角色类型',800,400,'25%','25%');		
	}
	
	var editRoleType = function(id){
		var model = jQuery("#gridTable").jqGrid('getRowData', id);
		url = getCurrentFilePath()+"updateroletype.jsp?type_id="+model.type_id+"&type_name="+model.type_name
				+"&type_desc="+model.type_desc+"&windowId=windowId";
		openAlertWindows('windowId',url,'修改角色类型',800,400,'25%','25%');		
	}
	
	/*
	删除角色
	*/
	var delRoleType = function(){
		var ids = "";
		var selectedIds = $("#gridTable").jqGrid("getGridParam", "selarrrow");
		for(var i = 0; i < selectedIds.length; i++) {
			var model = jQuery("#gridTable").jqGrid('getRowData', selectedIds[i]);
			 if("" != ids){			   
				ids += ";";
			 }
			 ids += model.type_id;
		}
		if (IsSpace(ids)) {
			alert("请选择要删除的记录！");
		} else {
			var okF = function(){
				var url = "deleteroletype.jsp";
				$("#type_ids").val(ids);
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
			alert("确定要删除选定的角色类型吗？",p);
		}
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
								类型名称：
							</th>
							<td width="296" class="cx_title_td">
								<input type="text" id="type_name" class="input_cx_title_283">
							</td>
							<th width="90" class="input_cx_title_th" nowrap>
								类型描述：
							</th>
							<td width="296" class="cx_title_td">
								<input type="text" id="type_desc" class="input_cx_title_283">
							</td>
							<td width="10" >
								&nbsp;&nbsp;
							</td>
							<td width="385"  colspan="2"  nowrap>
								<input value="搜索" id="sel" type="button" onclick="roleTypeSearch()" class="but_y_01" />
							</td>
						</tr>
					</table>
				</td>
				<!-- 固定查询 end-->
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
	  <input id="type_ids" name="type_ids" type="hidden"/>
	</form>
	<iframe name="hiddenFrame" width=0 height=0></iframe>
</body>
</html>

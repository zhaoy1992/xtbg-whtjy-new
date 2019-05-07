<%--
描述：司机信息页面
作者：童佳
版本：1.0
日期：2013-10-24
--%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="com.chinacreator.xtbg.yimingju.carmanage.service.DriverSort"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.pub.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
	String path = request.getContextPath();
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	String userid = accesscontroler.getUserID();
	
	DriverSort driverSort = new DriverSort();
	List<Map<String, String>>   sortList = driverSort.getSortList();
%>
<title>JGRID</title>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<!-- 引入jQuery UI -->
<script src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>
<!-- 引入jGrid -->
<script src="../../../resources/plug/jquery.jqGrid-4.3.1/js/i18n/grid.locale-en.js" type="text/javascript"></script>
<script src="../../../resources/plug/jquery.jqGrid-4.3.1/js/jquery.jqGrid.min.js" type="text/javascript"></script>
<!-- 引入my97时间控件 -->
<script src="../../../resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<!-- 引入其它 -->
<script src="../../../resources/js/util/public.js" type="text/javascript"></script>
<script src="../../../resources/js/common/commoncss.js" type="text/javascript"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<!-- 公共部分引用结束 -->
<!-- 当jqGrid列的字过多的时候显示...样式  -->

<script type="text/javascript">
$(function() {
	gridTableObj = $("#gridTable");			//gridtable对象;
	gridPagerObj = $("#gridPager");			//gridpager对象;
	t_gridTableObj = "#queryTable" ;			//t_gridtable对象;	
	queryTableString = $("#gridTable"); 	//queryTable字串
	jQuery_gridTableObj = $("#gridTable");
	$(document).keydown(function(){
		if(event.keyCode == 13){ 
			manuSearch();
		}
	});

	$("#gridTable").jqGrid({
		url: '<%=path%>' + '/commonListServlet?classNameId=fgw_DriverList',  //commonListServlet列表公共的servlet,classNameId在servletBean.xml文件中配置要调用的类,isPage:是否翻页(true,false),默认为true
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
		colNames: ['姓名','年龄','性别 ', '驾照类型 ','驾驶证号', '身份证号 ','司机主键'],
		//字符串数组，用于指定各列的题头文本，与列的顺序是对应的。
		colModel: [ //最重要的数组之一，用于设定各列的参数
		{
			name: 'driver_name',
			index: 'driver_name',
			width: 100,
			search: true
		},
		{
			name: 'age',
			index: 'age',
			width: 100,
			sortable: false
		},
		{
			name: 'driver_sex',
			index: 'driver_sex',
			width: 100,
			editable: true
		},
		{
			name: 'driver_sort_id',
			index: 'driver_sort_id',
			width: 80,
			search: true
			
		},
		{
			name: 'driver_car_no',
			index: 'driver_car_no',
			width: 150,
			search: true
		},
		{
			name: 'driver_no',
			index: 'driver_no',
			width: 150,
			search: true
		},
		
		{
			name: 'driver_id',
			index: 'driver_id',
			width: 30,
			hidden: true
		}
		],
		sortname: 'driver_name',
		//指定默认的排序列，可以是列名也可以是数字。此参数会在被传递到Server端。
		sortorder: 'desc',
		viewrecords: true,
		
		//设置是否在Pager Bar显示所有记录的总数。
		rowNum: 15,
		//用于设置Grid中一次显示的行数，默认值为20。正是这个选项将参数rows（prmNames中设置的）通过url选项设置的链接传递到Server。注意如果Server返回的数据行数超过了rowNum的设定，则Grid也只显示rowNum设定的行数。
		rowList: [10, 20, 30],
		//一个数组，用于设置Grid可以接受的rowNum值。例如[10,20,30]
		
		gridComplete: function() {
			var ids = $("#gridTable").getDataIDs(); //jqGrid('getDataIDs');
			for (var i = 0; i < ids.length; i++) {
				var cl = ids[i];
				var model = jQuery("#gridTable").jqGrid('getRowData', cl);
				
			}
		},
		jsonReader: { //这又是一个数组，用来设定如何解析从Server端发回来的json数据
			repeatitems: false
		},
		pagerintoolbar:true,//上面的分页条
		pagerinBottombar:true,//下面的分页条
		//定义页码控制条Page Bar
		//caption: "电子公告管理",
		//设置Grid表格的标题，如果未设置，则标题区域不显示。
		search : toManuParamJosn(),
		
		
		prmNames: { //这是一个数组，用于设置jqGrid将要向Server传递的参数名称
			rows: "rows",
			//表示请求行数的参数名称  
			sort: "sidx",
			//表示用于排序的列名的参数名称  
			order: "sord",
			//表示采用的排序方式的参数名称 
			search : "search"
		},
		toolbar: [true,"top","<input class='but_y_01' id='del' type='button' value='删除' onclick='delDriver()'/><input class='but_y_01' type='button' value='新增' onclick='addDriver()'/>"],
		multiselect: true,
		onCellSelect:function (id,icol)
		{
			if(icol != 0)
				{
				    updateDriver(id);
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
var toManuParamJosn = function() {
		 var str = "{'driver_name':'" + jQuery("#driver_name").val() + "','driver_sex':'" + jQuery("#driver_sex").val()
			 + "','driver_sort_id':'" + jQuery("#driver_sort_id").val()
			 + "'}";
		return descape(escape(str));
	}

	/*
	 函数:  manuSearch
	 说明:  查询稿件信息
	 参数:   无
	 返回值: 用户列表
	 */
	var manuSearch = function() {
		
		var sdata = { //构建查询需要的参数 
			//paramJson : toManuParamJosn()
		}; //获得当前postData选项的值  
		var postData = $("#gridTable").jqGrid("getGridParam", "postData"); //将查询参数融入postData选项对象  
		$.extend(postData, sdata);
		$("#gridTable").jqGrid("setGridParam", {
			search : true,
			userFilters:toManuParamJosn()
		// 将jqGrid的search选项设为true  
		}).trigger("reloadGrid", [ {
			page : 1
		} ]); //重新载入Grid表格，以使上述设置生效 
		 
	}
	
	/*
	 函数:  clearSearch
	 说明:  重置
	 参数:   无
	 返回值: 无
	 */
	var clearSearch = function() {
		resetSingleSearchDialog();
		var sdata = {
			paramJson : toManuParamJosn()
		};
		var postData = $("#gridTable").jqGrid("getGridParam", "postData");
		$.extend(postData, sdata); //将postData中的查询参数覆盖为空值  
		$("#gridTable").jqGrid("setGridParam", {
			search : true
		// 将jqGrid的search选项设为false  
		}).trigger("reloadGrid", [ {
			page : 1
		} ]);
	};

	/*
	 函数:  resetSingleSearchDialog
	 说明:  清空值查询值
	 参数:   无
	 返回值: 无
	 */
	var resetSingleSearchDialog = function() { //$("radio","#singleSearchDialog").attr("checked", false);  
		$(":text", "#queryTable").val("");
		$('#state option:first').attr('selected', 'selected');

	};


	/*
	 函数:  updateDriver
	 说明:  修改司机信息
	 参数:   无
	 返回值: 无
	 */
	var updateDriver = function(id) {
		var model = jQuery("#gridTable").jqGrid('getRowData', id);
		 openWindows('sub_main_updatedriver','修改司机','../../../yimingju/carmanage/jsp/carDriverInfo.jsp?subid=sub_main_updatedriver&driver_id='+model.driver_id,'fgw_driver',false,window);

	}
	
	
	var addDriver = function(){
		openWindows('sub_main_adddriver','新增司机','../../../yimingju/carmanage/jsp/carDriverInfo.jsp?subid=sub_main_adddriver','fgw_driver',false,window);
	}
	/*
	 函数:  delDriver
	 说明:  删除司机信息
	 参数:   无
	 返回值: 无
	 */
	var delDriver = function(id) {
		 var ids = "";
			var selectedIds = $("#gridTable").jqGrid("getGridParam", "selarrrow");
			for ( var i = 0; i < selectedIds.length; i++) {
				var model = jQuery("#gridTable").jqGrid('getRowData',
						selectedIds[i]);
				
				if ("" != ids) {
					ids += ",";
				}
				ids += "'" + model.driver_id + "'";

			}		 
			if (IsSpace(ids)) {
				alert("请选择要删除的记录！");
			} else {
				var okF = function(){	
				$("#driver_ids").val(ids);
				var fm = document.getElementById("delForm");
				fm.action = "carDriverInfoDo.jsp";
				fm.target = "hiddenFrame";
				fm.submit();}
				var p={
						headerText:'提示',
						okName:'确认',
				        okFunction:okF,
				        cancelName:'取消'
				};
				alert("确定要删除这些信息吗？",p)
			}
	 }


</script>
</head>
<body style="overflow-y:auto;">
<div>
	

		<table width="98%">
			<tr>
		<td>
						<!-- 查询条件选区    tabs_search_ctable(查询table样式) -->
			<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tabs_search_ctable_box">
				<tr>
					<td>
						<!-- 固定查询 -->
						<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tabs_search_ctable">
							<tr>
								<th width="90" class="input_cx_title_th" >姓名：</th>
						<td width="296"  class="cx_title_td">
							<input class="input_cx_title_283" type="text" id="driver_name" name="driver_name" /></td>
							
						<td width="385"  colspan="3"  >
						<input name="Input2" value="搜索" type="button" onclick="manuSearch()" class="but_y_01"/>
						<span id="selAreaImg" class="all_search_condition"><a onclick="hiddenOrShowSelArea('hiddenArea','selAreaImg')" >更多搜索条件</a></span></td>
									</tr>
								</table>
								</td></tr>
					<tr>
					<td>
					
						<!-- 隐藏查询 -->
						<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tabs_search_ctable" id="hiddenArea" style="display:none">
						<tr>
						 <th width="90" class="input_cx_title_th" >性别：</th>
						 <td width="296"  class="cx_title_td">
						 <select id="driver_sex" name="driver_sex">
						   <option value="">--请选择--</option>
						   <option value="男">男</option>
						   <option value="女">女</option>
						 </select>
						 </td>	
						<th width="90" class="input_cx_title_th" >驾照类型：</th>
						 <td width="296"  class="cx_title_td">
						 <select id="driver_sort_id" name="driver_sort_id">
						 <option value="">--请选择--</option>
			            <%for(int i = 0; i < sortList.size(); i++ ){ 
			                 Map<String,String> sortMap = new HashMap<String,String>();
			                 sortMap = sortList.get(i);
			                 String key = ""+(i+1);
			            %>
			            <option value="<%=key %>"><%=sortMap.get(key) %></option>
			           <%  } %>
			            </select>
						 </td>	
						</tr>
						
</table></td></tr></table>
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
	<form id="delForm" name="delForm" method="post" action="">
		<input type="hidden" name="driver_ids" id="driver_ids" />
		<input type="hidden" name="method" value="del" />
	</form>	
	<iframe name="hiddenFrame" width=0 height=0></iframe>
</body>
</html>
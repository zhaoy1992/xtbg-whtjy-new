<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DaoUtil"%>
<%
String path = request.getContextPath();
AccessControl accesscontroler = AccessControl.getAccessControl();
accesscontroler.checkAccess(request, response);
String budget_file_id = request.getParameter("budget_file_id");
String bus_id = request.getParameter("bus_id");	//如果从流程页面过来，没有file_id，只有bus_id,通过bus_id查出来
String flag = "0";	//如果从流程页面过来 flag = 1；否则flag=0
if(budget_file_id == null && bus_id != null ){
	budget_file_id = DaoUtil.sqlToField("select f.id from oa_budget_file f where f.bus_id = '" + bus_id+"'");
	flag = "1";
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <title>拆分记录子列表</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<!-- 引入jQuery -->
	<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
	
	<!-- 引入jQuery UI -->
	<link id="uiThemes" rel="stylesheet" type="text/css" media="screen" href="../../../resources/plug/jquery-ui-1.8.17.custom/css/custom-theme/jquery-ui-1.8.17.custom.css" />
	<script src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>
	
	<!-- 引入jGrid -->
	<link rel="stylesheet" type="text/css" media="screen" href="../../../resources/plug/jquery.jqGrid-4.3.1/css/ui.jqgrid.css" />
	<script src="../../../resources/plug/jquery.jqGrid-4.3.1/js/i18n/grid.locale-en.js" type="text/javascript"></script>
	<script src="../../../resources/plug/jquery.jqGrid-4.3.1/js/jquery.jqGrid.min.js" type="text/javascript"></script>
	
	<!-- 引入其它 -->
	<script src="../../../resources/util/public.js" type="text/javascript"></script>
	<script src="../../../resources/js/common/commoncss.js" type="text/javascript"></script>
	<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
	<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js" charset="utf-8"></script>
	<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
	<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
	<script type="text/javascript">
	var budget_file_id = "<%=budget_file_id%>";
	var ajax_url = "<%=path%>"+"/ccapp/oa/archive/split/jsp/";
	$(function(){
		$(document).keydown(function(){
			if(event.keyCode == 13){
				userSearch();
			}
		});
		if("<%=flag%>" == 1){
			$("#_top").hide();
		}
		$("#gridTable").jqGrid({
			url: '<%= path %>' + '/pubListServlet?classNameId=com.chinacreator.xtbg.core.archive.list.BudgetDetailList',
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
			colNames: ['编号','拆分单位id','拆分单位名称','与公文传输关联机构','文件名','文件相对路径'],
			//字符串数组，用于指定各列的题头文本，与列的顺序是对应的。
			colModel: [ //最重要的数组之一，用于设定各列的参数
		        {
		        	name: 'detail_id',index: 'detail_id',width: '5',sortable:false,hidden:true
				},
				{
		        	name: 'unit_id',index: 'unit_id',width: '10',sortable:false,hidden:true
				},
				{
					name: 'unit_name',index: 'unit_name',width: '10',sortable:false
				},
				{
					name: 'gw_org_name',index: 'gw_org_name',width: '20',sortable:false
				},
				{
					name: 'shown_name',index: 'shown_name',width: '25',sortable:false
				},
				{
					name: 'file_path',index: 'file_path',width: '25',sortable:false,hidden:true
				}
			],
			sortname: '',
			//指定默认的排序列，可以是列名也可以是数字。此参数会在被传递到Server端。
			sortorder: 'desc',
			viewrecords: true,
			
			//设置是否在Pager Bar显示所有记录的总数。
			rowNum: 8,
			//用于设置Grid中一次显示的行数，默认值为20。正是这个选项将参数rows（prmNames中设置的）通过url选项设置的链接传递到Server。注意如果Server返回的数据行数超过了rowNum的设定，则Grid也只显示rowNum设定的行数。
			rowList: [10, 20, 30],
			//一个数组，用于设置Grid可以接受的rowNum值。例如[10,20,30]
			gridComplete: function() { // var idss=jQuery("#gridTable").jqGrid('getColNames');
				// alert(idss);
				var ids = $("#gridTable").getDataIDs(); //jqGrid('getDataIDs');
				for (var i = 0; i < ids.length; i++) {
					var cl = ids[i];
					var model = jQuery("#gridTable").jqGrid('getRowData', cl);
				}
				//隐藏新增按钮
				//if(readonly == "1"){
					//$("#add").css("display","none")
				//}
			},
			jsonReader: { //这又是一个数组，用来设定如何解析从Server端发回来的json数据
				repeatitems: false
			},
			//pager: "#gridPager",
			pagerintoolbar:true,//上面的分页条
			pagerinBottombar:true,//下面的分页条
			//定义页码控制条Page Bar
			//caption: "草稿箱",
			//设置Grid表格的标题，如果未设置，则标题区域不显示。
			search : toParamJosn(),
			prmNames: { //这是一个数组，用于设置jqGrid将要向Server传递的参数名称
				rows: "rows",
				//表示请求行数的参数名称  
				sort: "sidx",
				//表示用于排序的列名的参数名称  
				order: "sord",
				//表示采用的排序方式的参数名称 
				search : "search"
			},
			toolbar: [true,"top","<input value='删除' onclick='deleteData()' type='button' class='but_y_01' />&nbsp;双击数据行下载文件!"],
			multiselect: true,
			onCellSelect:function(rowid,iCol){
				
			},
			ondblClickRow:function(rowid,iCol){				
				if(iCol != 0){
					downloadItem(rowid);
				}
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
	函数:  objectSearch
	说明:  查询用户信息
	参数:   无
	返回值: 用户列表
	*/ 
	var objectSearch = function() {
		var sdata = { //构建查询需要的参数 
			paramJson: toParamJosn()
		}; //获得当前postData选项的值  
		var postData = $("#gridTable").jqGrid("getGridParam", "postData"); //将查询参数融入postData选项对象  
		$.extend(postData, sdata);
		$("#gridTable").jqGrid("setGridParam", {
			search: true // 将jqGrid的search选项设为true  
		}).trigger("reloadGrid", [{
			page: 1
		}]); //重新载入Grid表格，以使上述设置生效 
	}
	function clearData(){	//重置
	 	$("#shown_name").val("");
		objectSearch();
	 }
	function toParamJosn(){
		var str = "{'budget_file_id':'"+descape(budget_file_id)+"','shown_name':'"+descape($("#shown_name").val())+"'}";
		return escape(str);
	}
	
	function downloadItem(rowid){
		var object = $("#gridTable").jqGrid('getRowData', rowid);
		var hrefPath = encodeURI(encodeURI(object.file_path));
		var zwName = encodeURI(encodeURI(object.shown_name));
		$("#impIfr").attr("src","download.jsp?hrefPath="+hrefPath+"&zwName="+zwName);
	}
	function backTo(){
	    removeAlertWindows('windowId',true);
	}
	function deleteData(){
		var ids = "";
		var tempArrs = [];
		var selectedIds = $("#gridTable").jqGrid("getGridParam", "selarrrow");
		$(selectedIds).each(function(){
			var model = jQuery("#gridTable").jqGrid('getRowData', this);
			if(!IsSpace(model.detail_id)){
				tempArrs.push(model.detail_id);
			}
		})
		ids = tempArrs.join();
		if (IsSpace(ids)) {
			alert("请选择要删除的记录！");
		} else {
			var okF = function(){
				$.ajax({
					url:ajax_url+'budgetdetailhandle.jsp',
					type:'post',dataType:'json',
					data:{"method":"deleteById","detail_id":ids},
					success:function(data){
						if(data.code.index == 0){
							alert("删除数据成功！");
							objectSearch();
						} else {
							alert("删除数据失败！errorCode["+data.code.index+"]");
						}
					}
				})
			}
			var p={
				headerText:'提示',
				okName:'确认',
		        okFunction:okF,
		        cancelName:'取消'
			};
			alert("确定要删除吗？",p);
		}
	}
	</script>
  </head>
  
  <body style="overflow-y:auto;margin-top: 0">
  	<!-- table页面跳转 -->
	<div  class="content_02" style="overflow:hidden;" id="_top">
		<!-- 操作-->
		<div class="content_02_top" style="margin-bottom:10px;" >
			<input value="关闭" onclick="backTo()" type="button" class="but_y_01" />
		</div>
	</div>
	<table width="100%" id="queryTable" style="margin-top: 0">
		<tr>
			<td>
				<!-- 查询条件选区    tabs_search_ctable(查询table样式) -->
				<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tabs_search_ctable_box">
						<tr>
							<td>
								<!-- 固定查询 -->
								<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tabs_search_ctable">
									<tr>
										<th width="90" class="input_cx_title_th">拆分文件名：</th>
										<td width="296"  class="cx_title_td">
											<input class="input_cx_title_283 " type="text" id="shown_name"/>
										</td>
										<td>
											<input name="Input2" value="搜索" type="button"	onclick="objectSearch()" class="but_y_01"/>
											<input name="Input2" value="重置" type="button"	onclick="clearData()" class="but_y_01"/>
										</td>
									</tr>
								</table>
							</td>
						</tr>	
				</table>
			</td>
		</tr>
		<tr>
			<td>
				<div class="cGridArea" >
					<table id="gridTable"></table>
					<div id="gridPager"></div>
				</div>
			</td>
		</tr>
	</table>
	<iframe id="impIfr" name="impIfr" width="0" height="0"></iframe>
</body>
</html>
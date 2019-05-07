<%@page import="com.chinacreator.xtbg.suxian.electroniccheck.dao.imploracle.ElectInfoDaoImpl"%>
<%@page import="com.chinacreator.xtbg.core.directory.entity.WorkIPBean"%>
<%@page import="com.chinacreator.security.authorization.AuthRole"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.pub.util.DictDropDownList"%>
<%@page import="com.chinacreator.xtbg.pub.util.*"%>
<%@page import="java.util.*"%>
<%@page import="com.chinacreator.xtbg.suxian.electroniccheck.entity.ElectInfoBean"%>
<%@page import="com.chinacreator.xtbg.suxian.electroniccheck.dao.ElectInfoDao"%>
<%@page import ="java.text.SimpleDateFormat"%>
<%@page import="com.chinacreator.business.common.tools.CacheCommonManage"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
String path = request.getContextPath();
String areacode = CacheCommonManage.getInstance().getSystemParam("CURSYSTEMCODE");
AccessControl accesscontroler = AccessControl.getInstance();
accesscontroler.checkAccess(request, response);
AuthRole authRoles[] = accesscontroler.getAllRoleofUser(accesscontroler.getUserAccount());


%>
<title>JGRID</title>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>

<!-- 引入my97时间控件 -->
<script src="../../../resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
	
<!-- 引入jGrid -->
<link rel="stylesheet" type="text/css" media="screen" href="../../../resources/plug/jquery.jqGrid-4.3.1/css/ui.jqgrid.css" />
<script src="../../../resources/plug/jquery.jqGrid-4.3.1/js/i18n/grid.locale-en.js" type="text/javascript"></script>
<script src="../../../resources/plug/jquery.jqGrid-4.3.1/js/jquery.jqGrid.min.js" type="text/javascript"></script>  

<!-- 引入其它 -->
<script src="../../../resources/js/util/public.js" type="text/javascript"></script>
<script src="../../../resources/js/common/commoncss.js" type="text/javascript"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<!-- 引入提示 -->
 <script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>  
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>

<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<link rel="stylesheet" href="../../../resources/plug/JQuery zTree v3.0/css/zTreeStyle/zTreeStyle.css" type="text/css" />
<script type="text/javascript" src="../../../resources/plug/JQuery zTree v3.0/js/jquery.ztree.core-3.0.js"></script>
<script type="text/javascript" src="../../../resources/plug/JQuery zTree v3.0/js/jquery.ztree.excheck-3.0.js"></script>


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
			electSearch();
		}
		
	
	});
	
	

	$("#gridTable").jqGrid({
		url: '<%= path %>' + '/commonListServlet?classNameId=electWorkIPInfoList',  //commonListServlet列表公共的servlet,classNameId在servletBean.xml文件中配置要调用的类,isPage:是否翻页(true,false),默认为true
		
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
		colNames: ['办公IP主键','开始IP', '结束IP','备注'],
		//字符串数组，用于指定各列的题头文本，与列的顺序是对应的。
		colModel: [ //最重要的数组之一，用于设定各列的参数
		{
			name: 'workip_id',
			index:'workip_id',
			 hidden: true
			//editable: true
		},
		{
			name: 'workip_start_ip',
			index: 'workip_start_ip',
			width: 220,
			editable: true
		},
		{
			name: 'workip_end_ip',
			index: 'workip_end_ip',
			width: 220,
			editable: true
		},
		{
			name: 'workip_remark',
			index: 'workip_remark',
			width: 220,
			editable: true
		}
		],
		sortname: 'workip_id',
		//指定默认的排序列，可以是列名也可以是数字。此参数会在被传递到Server端。
		sortorder: 'desc',
		viewrecords: true,
		
		//设置是否在Pager Bar显示所有记录的总数。
		rowNum: 10,
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
		//定义页码控",
		//设置Grid表格的标题，如果未设置，则标题区域不显示。
		search : toElectParamJosn(),
		
		prmNames: { //这是一个数组，用于设置jqGrid将要向Server传递的参数名称
			rows: "rows",
			//表示请求行数的参数名称  
			sort: "sidx",
			//表示用于排序的列名的参数名称  
			order: "sord",
			//表示采用的排序方式的参数名称 
			search : "search"
		},
		//判断上下班按钮是否置灰
		toolbar: [ true,"top","<input class='but_y_01' id='work' type='button' onclick='addLeave()' value='添加' /><input class='but_y_01' id='delLevel' type='button' onclick='delLevel()' value='删除' />"],
		multiselect: true,

		onCellSelect:function(id,iCol){
				if(iCol != 0 )
				{	
					updateworkip(id);
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
	 函数:  toBriefsParamJosn
	 说明:  构建要查询的参数
	 参数:   无
	 返回值: 返回要查询的参数
	 */
	var toElectParamJosn = function() {
		var str = "";
			
		return descape(escape(str));
	}

	/*
	 函数:  electSearch
	 说明:  查询信息
	 参数:   无
	 返回值: 列表
	 */
	var electSearch = function() {
		var sdata = { //构建查询需要的参数 
			
		}; //获得当前postData选项的值  
		var postData = $("#gridTable").jqGrid("getGridParam", "postData"); //将查询参数融入postData选项对象  
		$.extend(postData, sdata);
		$("#gridTable").jqGrid("setGridParam", {
			search : true,
			userFilters:toElectParamJosn()
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
				paramJson: toBriefsParamJosn()
			};
			var postData = $("#gridTable").jqGrid("getGridParam", "postData");
			$.extend(postData, sdata); //将postData中的查询参数覆盖为空值  
			$("#gridTable").jqGrid("setGridParam", {
				search: true // 将jqGrid的search选项设为false  
			}).trigger("reloadGrid", [{
				page: 1
			}]);
	};
	var onRetparam = function(){
		$("#userid").val('');
		$("#username").val('');
		$("#orgid").val('');
		$("#orgname").val('');
		$("#start_time").val('');
		$("#end_time").val('');
		$("#electstate").val('');
		
	}
	/*
	 函数:  resetSingleSearchDialog
	 说明:  清空值查询值
	 参数:   无
	 返回值: 无
	 */
	var resetSingleSearchDialog = function() { //$("radio","#singleSearchDialog").attr("checked", false);  
		$(":text", "#queryTable").val("");
		$(":hidden", "#queryTable").val("");
		$("select").each(function(){
			$(this).find("option:first").attr("selected","selected");
		})
	};
	/*
	 函数:  addLeave
	 说明:  添加外勤信息
	 参数:   无
	 返回值: 无
	 */
	var addLeave = function(){
		openAlertWindows('windowId','../../../suxian/electroniccheck/jsp/addworkip.jsp','添加办公IP',500,245,'25%','25%');
	}
	
	var updateworkip = function(id) {
		var model = jQuery("#gridTable").jqGrid('getRowData', id);
		var url = "<%=path%>/ccapp/xtbg/suxian/electroniccheck/jsp/addworkip.jsp?subid=windowId&action=update&workip_id="+model.workip_id;
		//openWindows('addinformation','新增图书',url,false,window);
		openAlertWindows('windowId',url,'更新办公IP',500,245,'25%','25%');
		//location.href = url;
	}
	
	/*
	 函数:  deleteLevel
	 说明:  删除办公IP
	 参数:   无
	 返回值: 无
	 */
var delLevel = function(id) {
	var ids = "";
	var selectFlag = false;
	var selectedIds = $("#gridTable").jqGrid("getGridParam", "selarrrow");
	$(selectedIds).each(function () {
		var model = jQuery("#gridTable").jqGrid('getRowData', this);
		if(ids != ""){
			ids += ",";
		}
		ids += model.workip_id;
		
	});
	
	if (IsSpace(ids)) {
		alert("请选择要删除的记录！");
	} else {
		var okF = function(){
			$("#ids").val(ids);
			var fm = document.getElementById("form1");
			fm.target = "hiddenFrame";
			fm.submit();
		}
		var p={
					headerText:'提示',
					okName:'确认',
			        okFunction:okF,
			        cancelName:'取消'
			};
		alert("确定删除这些记录吗？",p);
	} 
}
</script>
</head>
<body>
	
	<div>
		<table width="100%">
			<tr>
		<td>
	</td></tr></table>
		<!-- 查询列表区 cGridArea(查询区样式)-->
	<div class="cGridArea">
		<table id="gridTable"></table>
		<div id="gridPager"></div>
	</div>
	<!-- 查询列表区 -->

	</div>
	
	<form id="form1" name="form1" method="post" action="addorupdaworkipdo.jsp" target="hiddenFrame">
	<input type='hidden' name='dowhat' id="dowhat" value="delete"/>
	<input type='hidden' name='ids' id="ids"/>
	</form>
	
	<iframe name="hiddenFrame" width=0 height=0></iframe>
</body>
</html>
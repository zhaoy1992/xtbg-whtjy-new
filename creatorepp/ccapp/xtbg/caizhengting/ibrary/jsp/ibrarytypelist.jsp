<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.UserCache"%>
<%
	String path = request.getContextPath();
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	UserCacheBean userBean= UserCache.getUserCacheBean(accesscontroler.getUserID());
	String unit_id = userBean.getUnit_id();
	String f_org_name = accesscontroler.getChargeOrgName();
	
	String tree_type_no = request.getParameter("tree_type_no");
	String parentId = request.getParameter("parentId"); //点击左边树 传过来的节点ID
	String parentname = request.getParameter("parentname");
	
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=gbk">
	<title></title>
	<!-- 引入jQuery -->
	<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
	<!-- 引入jQuery UI -->
	<link id="uiThemes" rel="stylesheet" type="text/css" media="screen" href="../../../resources/plug/jquery-ui-1.8.17.custom/css/custom-theme/jquery-ui-1.8.17.custom.css" />
	<script src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>
	<!-- 引入formvValidatetion -->
	<script src="../../../resources/plug/formvalidation/jquery.validationEngine-cn.js" type="text/javascript" charset="utf-8"></script>
	<script src="../../../resources/plug/formvalidation/jquery.validationEngine.js" type="text/javascript" charset="utf-8"></script>
	<!-- 引入其它 -->
	<script src="../../../resources/js/util/public.js" type="text/javascript"></script>
	<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
	<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
	<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js" charset="utf-8"></script>
	<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
	<!-- 引入jGrid -->
	<script src="../../../resources/plug/jquery.jqGrid-4.3.1/js/i18n/grid.locale-en.js"  charset="utf-8" type="text/javascript"></script>
	<script src="../../../resources/plug/jquery.jqGrid-4.3.1/js/jquery.jqGrid.min.js"  charset="utf-8" type="text/javascript"></script>
</head>
<body style="overflow-x: auto;">
<script>
$(function(){
	initTable();
});
/*
 函数:  refreshGrid
 说明:  静态加载列表数据，主要供子页面调用和删除字段后调用
 参数:   无
 */
function refreshGrid() {
	var sdata = { //构建查询需要的参数 
		paramJson : toParamJosn()
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

function btnClickFn(btnObj){
	flag = btnObj.name;
	var tree_type;
	var parentname = '<%=parentname%>';
	var parentId = '<%=parentId%>';
	var tree_type_no ='<%=tree_type_no%>'; 
	if(flag=="AddTwo"){
		tree_type = "1"; 
	}else if(flag=="AddThree"){
		tree_type = "2"; 
	}
	openWindows('treetypeadd','增加信息分类','../../../caizhengting/ibrary/jsp/ibrarytypeinfo.jsp?subid=treetypeadd&tree_type_no='+tree_type+'&parentname='+parentname+'&parentId='+parentId+'&btnhidden=true','treetypeadd',false,window);
}

function delte(){
	 var ids = "";
		var selectedIds = $("#gridTable").jqGrid("getGridParam", "selarrrow");
		for ( var i = 0; i < selectedIds.length; i++) {
			var model = jQuery("#gridTable").jqGrid('getRowData',selectedIds[i]);
			if ("" != ids) {
				ids += ",";
			}
			ids += "'" + model.tree_id + "'";
		}
		if (IsSpace(ids)) {
			alert("请选择要删除的记录！");
		} else {
			var okF = function(){
				jQuery("#tree_id").val(ids);
				var fm = document.getElementById("onlyFrom");
				fm.target = "hiddenFrame";
				fm.submit();
			}
			var p={
					headerText:'提示',
					okName:'确认',
				    okFunction:okF,
				    cancelName:'取消'
				};
			alert('确定要删除吗？',p)
		}
}
</script>
<%--query table end--%>
<table width="100%" style="margin-left: 0" class="tabs_search_ctable_box">
	<tr>
		<td width="100%" align="left" valign="top">
			<input name="AddTwo" value="增加中间层分类" type="button" onclick="btnClickFn(this)" class="but_y_06" style="width:100px;border:1px solid  #dfc07f ;" onmouseover="javascript:jQuery(this).attr('class','but_y_07')" onmouseout="javascript:jQuery(this).attr('class','but_y_06')"  /><span style="width:5px;display:block;float:left;">&nbsp;</span>
			<input name="AddThree" value="增加最低层分类" type="button" onclick="btnClickFn(this)" class="but_y_06" class="but_y_06" style="width:100px;border:1px solid  #dfc07f ;" onmouseover="javascript:jQuery(this).attr('class','but_y_07')" onmouseout="javascript:jQuery(this).attr('class','but_y_06')" /><span style="width:5px;display:block;float:left;">&nbsp;</span>
			<input name="deltree" value="删除" type="button" onclick="delte()" class="but_y_01" /><span style="width:5px;display:block;float:left;">&nbsp;</span>
			<script>
			</script>
		</td>
	</tr>
	<tr>
		<td width="100%" align="left" valign="top">
		<div style="float:left;width:100%;margin-left: -10px" class="cGridArea">
			<table id="gridTable"></table>
			<div id="gridPager"></div>
		</div>
		<script>
		function toParamJosn(){
			var str = "{'tree_parent_id':'<%=parentId%>','unit_id':'<%=unit_id%>'}";
			return descape(escape(str));
		}
		initTable = function (){
		$("#gridTable").jqGrid({
			url: '<%= path %>' + '/commonListServlet?classNameId=czt_ibraryTreeList',  //commonListServlet列表公共的servlet,classNameId在servletBean.xml文件中配置要调用的类,isPage:是否翻页(true,false),默认为true
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
			colNames: ['tree_id','图书分类名称','分类层次','分类代码','备注'],
			//字符串数组，用于指定各列的题头文本，与列的顺序是对应的。
			colModel: [ //最重要的数组之一，用于设定各列的参数
		        {
		        	name: 'tree_id',index: 'tree_id',width: '18',sortable:false,hidden:true
				},
				{
					name: 'tree_name',index: 'tree_name',width: '10',sortable:false
				},
				{
					name: 'tree_type_no',index: 'tree_type_no',width: '10',sortable:false
				},
				{
					name: 'tree_type_code',index: 'tree_type_code',width: '15',sortable:false
				},
				{
					name: 'remark',index: 'remark',width: '15',sortable:false
				}
			],
			viewrecords: true,
			
			//设置是否在Pager Bar显示所有记录的总数。
			rowNum: 10,
			//用于设置Grid中一次显示的行数，默认值为20。正是这个选项将参数rows（prmNames中设置的）通过url选项设置的链接传递到Server。注意如果Server返回的数据行数超过了rowNum的设定，则Grid也只显示rowNum设定的行数。
			rowList: [10, 20, 30],
			//一个数组，用于设置Grid可以接受的rowNum值。例如[10,20,30]
			gridComplete: function() { // var idss=jQuery("#gridTable").jqGrid('getColNames');
				
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
			multiselect: true,
			
			onCellSelect:function(rowid,iCol){
				
			}
		}).navGrid('#gridPager', {
			edit: false,
			add: false,
			del: false,
			search:false,
			refresh:false
		});};
		</script>
		</td>
	</tr>
</table>
<form id="onlyFrom" name="onlyFrom" method="post" action="ibrarytypeinfoDo.jsp" target="hiddenFrame">
	<input type='hidden' name='tree_id' id="tree_id"/>
	<input type='hidden' name='actiontype' id='actiontype' value="del"/>
	<input type='hidden' name='type' id='type' value="treetype"/>
</form>
<iframe name="hiddenFrame" width=0 height=0></iframe>
</body>
</html>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
	String path = request.getContextPath();
	AccessControl accesscontroler = AccessControl.getInstance(); 
	accesscontroler.checkAccess(request, response);
 
%>
<title>JGRID</title>
<!-- 引入jQuery -->
<script type="text/javascript" src="../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script src="../resources/util/public.js" type="text/javascript"></script>
<!-- 引入jQuery UI -->
<link id="uiThemes" rel="stylesheet" type="text/css" media="screen" href="../resources/plug/jquery-ui-1.8.17.custom/css/custom-theme/jquery-ui-1.8.17.custom.css" />
<script src="../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>

<!-- 引入my97时间控件 -->
<script src="../resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>

<!-- 引入jGrid -->
<link rel="stylesheet" type="text/css" media="screen" href="../resources/plug/jquery.jqGrid-4.3.1/css/ui.jqgrid.css" />
<script src="../resources/plug/jquery.jqGrid-4.3.1/js/i18n/grid.locale-en.js" type="text/javascript"></script>
<script src="../resources/plug/jquery.jqGrid-4.3.1/js/jquery.jqGrid.min.js" type="text/javascript"></script>

<!-- 引入其它 -->
<script type="text/javascript" src="../resources/plug/ifrom/js/ifrom-min.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<!-- 公共部分引用结束 -->

<script type="text/javascript">

jQuery(function() {
	gridTableObj = jQuery("#gridTable");			//gridtable对象;
	gridPagerObj = jQuery("#gridPager");			//gridpager对象;
	t_gridTableObj = "#queryTable" ;			//t_gridtable对象;	
	queryTableString = jQuery("#gridTable"); 	//queryTable字串
	jQuery_gridTableObj = jQuery("#gridTable");
	jQuery(document).keydown(function(){
		if(event.keyCode == 13){ 
			//briefsSearch();
		}
	});
	

	jQuery("#gridTable").jqGrid({
		url: '<%= path %>' + '/pubListServlet?classNameId=com.chinacreator.xtbg.core.common.iweboffice.list.WordTemplateList',  //pubListServlet列表公共的servlet,classNameId在servletBean.xml文件中配置要调用的类,isPage:是否翻页(true,false),默认为true
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
		colNames: ['','ID','名称', '创建者','创建时间','备注'],
		//字符串数组，用于指定各列的题头文本，与列的顺序是对应的。
		colModel: [ //最重要的数组之一，用于设定各列的参数
		{
		  	name: 'rr',
		    index:'rr',
		   	width: 20,
			search: false,
			sortable: false,
			editable: false
		},
		 {
			name: 'mb_id',
			index:'template_id',
			 hidden: true
		},
		{
			name: 'mb_mc',
			index: 'template_name',
			width: 120,
			editable: true
		},
		{
			name: 'mb_cjz',
			index:'template_username',
			width: 80, 
			editable: true
		}
		,
		{
			name: 'mb_cjsj',
			index:'template_creatortime',
			width: 100, 
			editable: true
		}
		,
		{
			name: 'mb_remark',
			index:'template_remark',
			width: 100, 
			editable: true
		}
		],
		sortname: 'template_creatortime',
		//指定默认的排序列，可以是列名也可以是数字。此参数会在被传递到Server端。
		sortorder: 'desc',
		viewrecords: true,
		
		//设置是否在Pager Bar显示所有记录的总数。
		rowNum: 10,
		//用于设置Grid中一次显示的行数，默认值为20。正是这个选项将参数rows（prmNames中设置的）通过url选项设置的链接传递到Server。注意如果Server返回的数据行数超过了rowNum的设定，则Grid也只显示rowNum设定的行数。
		rowList: [10, 20, 30],
		//一个数组，用于设置Grid可以接受的rowNum值。例如[10,20,30]
		gridComplete: function() {
			var ids = jQuery("#gridTable").getDataIDs(); //jqGrid('getDataIDs');
			for (var i = 0; i < ids.length; i++) {
				var cl = ids[i];
				var model = jQuery("#gridTable").jqGrid('getRowData', cl);
				be = "<input type='radio'  name='r1' />";
				
			jQuery("#gridTable").jqGrid('setRowData', ids[i], {
				rr: be
			});

			}
		},
		jsonReader: { //这又是一个数组，用来设定如何解析从Server端发回来的json数据
			repeatitems: false
		},
		pagerintoolbar:true,//上面的分页条
		pagerinBottombar:true,//下面的分页条
		//定义页码控",
		//设置Grid表格的标题，如果未设置，则标题区域不显示。
		search : toTemplateParamJosn(),
// 		filterNames:["release_status"],
// 		filterOptions:[[["--请选择--","--请选择--"],["已发布","已发布"],["已暂存","已暂存"]]],//alue text 后的值与显不
// 		filterOptionsDefValue:[0],
		prmNames: { //这是一个数组，用于设置jqGrid将要向Server传递的参数名称
			
			rows: "rows",
			//表示请求行数的参数名称  
			sort: "sidx",
			//表示用于排序的列名的参数名称  
			order: "sord",
			//表示采用的排序方式的参数名称 
			search : "search"
		},
		toolbar: [ true,"top","<input class='but_y_01' id=add value='确定' type='button' onclick='Ok()' value=''/>"],
		multiselect: false,
		onCellSelect:function(id,iCol){
				if(iCol != 0 )
				{	
					
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


//取消
function onCancel() {
	window.returnValue = false;
	window.close();
}

/*
函数: Ok
说明: 确定管理信息
参数:   无
返回值: 无
*/
var Ok = function(id) {
	    var ids = "";
	    var j = -1;
	    var ids = jQuery("#gridTable").getDataIDs(); //jqGrid('getDataIDs');
	    jQuery("input[name=r1]").each(function(i,e){
			if(jQuery(this).is(":checked")){
				j = i;
			}
		})
		var model = jQuery("#gridTable").jqGrid('getRowData',ids[j]);
		
		ids =model.mb_id;
	
	if (IsSpace(ids)) {
		alert("请选择要添加的模板！");
	} else {
	    	var okF=function(){
	    	var obj = getParentWindow('windowId');
	    		//返回差数
	    		obj.backTo2("word"+ids);
	    		//显示金格控件
	    	 	//obj.jQuery("#webofficDiv").show();
	    		removeAlertWindows('',false,true,'操作成功',false,'',true);
	    	}
			
		var p={
			headerText:'提示',
			okName:'确认',
			okFunction:okF,
			cancelName:'取消'
		};
		alert("确定选择该模板吗？",p)
	}	

}
	/*
	 函数:  toTemplateParamJosn
	 说明:  构建要查询的参数
	 参数:   无
	 返回值: 返回要查询的参数
	 */
	var toTemplateParamJosn = function() {
		var str = "{'mb_mc':'" + jQuery("#mb_mc").val()+"'}"; 
			 
		return descape(escape(str));
	}

	/*
	 函数:  templateSearch
	 说明:  查询信息
	 参数:   无
	 返回值: 列表
	 */
	var templateSearch = function() {
		var sdata = { //构建查询需要的参数 
			paramJson : toTemplateParamJosn()
		}; //获得当前postData选项的值  
		var postData = jQuery("#gridTable").jqGrid("getGridParam", "postData"); //将查询参数融入postData选项对象  
		jQuery.extend(postData, sdata);
		jQuery("#gridTable").jqGrid("setGridParam", {
			search : true
			
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
			var postData = jQuery("#gridTable").jqGrid("getGridParam", "postData");
			jQuery.extend(postData, sdata); //将postData中的查询参数覆盖为空值  
			jQuery("#gridTable").jqGrid("setGridParam", {
				search: true // 将jqGrid的search选项设为false  
			}).trigger("reloadGrid", [{
				page: 1
			}]);
	} 

	/*
	 函数:  resetSingleSearchDialog
	 说明:  清空值查询值
	 参数:   无
	 返回值: 无
	 */
	var resetSingleSearchDialog = function() { 
		jQuery(":text", "#queryTable").val("");
		jQuery(":hidden", "#queryTable").val("");
		jQuery("select").each(function(){
			jQuery(this).find("option:first").attr("selected","selected");
		})
	} 



 
function load(dateId) {
	//时间控件事件的问题 开始
	var dataSelectFlag = true;
	jQuery("#"+dateId).click(function(){
		if(dataSelectFlag){
			jQuerydp.dd.style.display = "block";
			dataSelectFlag = false;
		}else{
			jQuerydp.dd.style.display = "none";
			dataSelectFlag = true;
		}
	 });
	jQuery("#"+dateId).hover(function(){
		 dataSelectFlag = true;
	 });
}
//结束
window.onload = function () {
	load('create_time1');
	load('create_time2');
}
</script>
</head>
<body>
	
	<div>
		<!-- 查询列表区 cGridArea(查询区样式)-->
		<div class="cGridArea">
			<table id="gridTable"></table>
			<div id="gridPager"></div>
		</div>
		<!-- 查询列表区 -->

	</div>
	<form id="delForm"  method="post"
		action="" >
		<input type="hidden" name="userIds" id="userIds" />
		 <input type="hidden" name="action1" value="del" />
	</form>
	<form id="xgForm" name="xgForm" method="post"
		action="">
		<input type="hidden" name="userIds1" id="userIds1"/> <input
			type="hidden" name="action" value="xg" />
	</form>
	<iframe name="hiddenFrame" width=0 height=0></iframe>
</body>
</html>
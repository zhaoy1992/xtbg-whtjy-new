<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="com.chinacreator.security.AccessControl" %>

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
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>

<!-- 引入jQuery UI -->
<link id="uiThemes" rel="stylesheet" type="text/css" media="screen" href="../../../resources/plug/jquery-ui-1.8.17.custom/css/custom-theme/jquery-ui-1.8.17.custom.css" />
<script src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>

<!-- 引入jGrid -->
<link rel="stylesheet" type="text/css" media="screen" href="../../../resources/plug/jquery.jqGrid-4.3.1/css/ui.jqgrid.css" />
<script src="../../../resources/plug/jquery.jqGrid-4.3.1/js/i18n/grid.locale-en.js" type="text/javascript" charset="utf-8"></script>
<script src="../../../resources/plug/jquery.jqGrid-4.3.1/js/jquery.jqGrid.min.js" type="text/javascript" charset="utf-8"></script>

<!-- 引入其它 -->
<script src="../../../resources/js/util/public.js" type="text/javascript" charset="utf-8"></script>
<script src="../../../resources/js/common/commoncss.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js" charset="utf-8"></script>

<script type="text/javascript">
$(function() {
		$(document).keydown(function(){
		if(event.keyCode == 13){
		   androidVersionSearch();
		}
	});
	$("#gridTable").jqGrid({
		url: '<%= path %>' + '/commonListServlet?classNameId=wc_androidVersionList',  //commonListServlet列表公共的servlet,classNameId在servletBean.xml文件中配置要调用的类,isPage:是否翻页(true,false),默认为true
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
		colNames: ['版本ID','版本名称', '版本号 ', '版本序号 ','数据库版本序号', '上传时间 ','下载地址'],
		//字符串数组，用于指定各列的题头文本，与列的顺序是对应的。
		colModel: [ //最重要的数组之一，用于设定各列的参数
		{
			name: 'version_id',
			index: 'version_id',
			hidden: true
		},
		{
			name: 'version_name',
			index: 'version_name',
			editable: true
		},
		{
			name: 'version_esn',
			index: 'version_esn',
			editable: true
		},
		{
			name: 'version_sn',
			index: 'version_sn',
			search: true
		},
		{
			name: 'sql_sn',
			index: 'sql_sn',
			hidden: true
		},
		{
			name: 'up_time',
			index: 'up_time',
			search: true
		},
		{
			name: 'act',
			index: 'act',
			search: true,
			hidden: true
		},
		],
		sortname: 'up_time',
		//指定默认的排序列，可以是列名也可以是数字。此参数会在被传递到Server端。
		sortorder: 'desc',
		viewrecords: true,
		
		//设置是否在Pager Bar显示所有记录的总数。
		rowNum: 15,
		//用于设置Grid中一次显示的行数，默认值为20。正是这个选项将参数rows（prmNames中设置的）通过url选项设置的链接传递到Server。注意如果Server返回的数据行数超过了rowNum的设定，则Grid也只显示rowNum设定的行数。
		rowList: [10, 20, 30],
		//一个数组，用于设置Grid可以接受的rowNum值。例如[10,20,30]
		
		
		gridComplete: function() {
			var ids = $("#gridTable").getDataIDs();
			for (var i = 0; i < ids.length; i++) {
				var cl = ids[i];
				var model = jQuery("#gridTable").jqGrid('getRowData', cl);
				be = "<input type='button' id='downFile1' class='cButton' onclick='downFile1(" + cl + ")' value='内网地址'/>";
				be += "<input type='button' id='downFile2' class='cButton' onclick='downFile2(" + cl + ")' value='外网地址'/>";
				jQuery("#gridTable").jqGrid('setRowData', ids[i], {
					act: be
				});
			}
		},

		//
		
		jsonReader: { //这又是一个数组，用来设定如何解析从Server端发回来的json数据
			repeatitems: false
		},
		//pager: "#gridPager",
		//定义页码控制条Page Bar
		//设置Grid表格的标题，如果未设置，则标题区域不显示。
		pagerintoolbar:true,//上面的分页条
		pagerinBottombar:true,//下面的分页条	
		search : toAndroidVersionParamJosn(),
		prmNames: { //这是一个数组，用于设置jqGrid将要向Server传递的参数名称
			rows: "rows",
			//表示请求行数的参数名称  
			sort: "sidx",
			//表示用于排序的列名的参数名称  
			order: "sord",
			//表示采用的排序方式的参数名称 
			search : "search"
		},
		toolbar: [true,"top","<input class='but_y_01' id='add' type='button' onclick='addAndroidVersion()' value='新增'/><input class='but_y_01' id='del' type='button' value='删除' onclick='delAndroidVersion()'/>"],
		multiselect: true,
		ondblClickRow: function(id) {
			updateAndroidVersion(id);
		}
	}).navGrid('#gridPager', {
		edit: false,
		add: false,
		del: false,
		search: false,
		refresh:false
	});
	
	
	//操作按钮区  cOprArea(操作区样式)
	/*$("#t_gridTable").append("<div>")
		.append("<input class='add' id=add type='button' onclick='addAndroidVersion()' value=''/>")
		.append("<input class='del' id=del type='button' onclick='delAndroidVersion()' value=''/>") 
 		.append("</div>");
 		*/
	
});


/**
 * android 安装apk下载
 */

var downFile1 = function(id){
	var model = jQuery("#gridTable").jqGrid('getRowData', id);
	var versionName = model.version_name;
// 	alert(getRootPath()+"/androidversionupload/"+versionName);
	top.location.href=getRootPath()+"/androidversionupload/"+versionName;
}

var downFile2 = function(id){
	var model = jQuery("#gridTable").jqGrid('getRowData', id);
	var versionName = model.version_name;
// 	alert(getRootPath()+"/androidversionupload/"+versionName);
	top.location.href=getRootPath()+"/androidversionupload/178/"+versionName;
}

function getRootPath(){
    //获取当前网址，如： http://localhost:8083/uimcardprj/share/meun.jsp
    var curWwwPath=window.document.location.href;
    //获取主机地址之后的目录，如： uimcardprj/share/meun.jsp
    var pathName=window.document.location.pathname;
    var pos=curWwwPath.indexOf(pathName);
    //获取主机地址，如： http://localhost:8083
    var localhostPaht=curWwwPath.substring(0,pos);
    //获取带"/"的项目名，如：/uimcardprj
    var projectName=pathName.substring(0,pathName.substr(1).indexOf('/')+1);
    return(localhostPaht+projectName);
}

/*
	 函数:  toUserParamJosn
	 说明:  构建要查询的参数
	 参数:   无
	 返回值: 返回要查询的参数
	 */
var toAndroidVersionParamJosn = function() {
	var str = "{'version_name':'" + $("#version_name").val() + "','version_esn':'" + $("#version_esn").val() + "'}";
	return descape(escape(str));
}

/*
	 函数:  
	 说明:  查询
	 参数:   无
	 返回值: 列表
*/
var androidVersionSearch = function() {
	var sdata = { //构建查询需要的参数 
		paramJson: toAndroidVersionParamJosn()
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
	 函数:  clearSearch
	 说明:  重置
	 参数:   无
	 返回值: 无
	 */
var clearSearch = function() {
		 resetSingleSearchDialog();
	var sdata = {
		paramJson: toAndroidVersionParamJosn()
	};
	var postData = $("#gridTable").jqGrid("getGridParam", "postData");
	$.extend(postData, sdata); //将postData中的查询参数覆盖为空值  
	$("#gridTable").jqGrid("setGridParam", {
		search: true // 将jqGrid的search选项设为false  
	}).trigger("reloadGrid", [{
		page: 1
	}]);
	 
};

/*
	 函数:  resetSingleSearchDialog
	 说明:  清空值查询值
	 参数:   无
	 返回值: 无
	 */
var resetSingleSearchDialog = function() { //$("radio","#singleSearchDialog").attr("checked", false);  
	$(":text", "#queryTable").val("");
	$('#state option:first').attr('selected','selected'); 
	
};

/*
	 函数:  
	 说明:  添加
	 参数:   无
	 返回值: 无
	 */
var addAndroidVersion = function() {
	//JqueryDialog.Open1('新增版本', 'androidversionaddordetail.jsp', 420,	 280, true, true, true,true);
	openWindows('addAndroidVersion','新增版本','../../../wangcheng/androidversion/jsp/androidversionaddordetail.jsp?subid=addAndroidVersion','addAndroidVersion',false,window);
}

/*
	 函数:  
	 说明:  修改
	 参数:   无
	 返回值: 无
*/
var updateAndroidVersion = function(id) {
	var model = jQuery("#gridTable").jqGrid('getRowData', id);
	openWindows('updateAndroidVersion','查看/编辑版本','../../../wangcheng/androidversion/jsp/androidversionaddordetail.jsp?subid=updateAndroidVersion&id='+model.version_id,'updateAndroidVersion',false,window);
	//openAlertWindows('windowId','../../../wangcheng/androidversion/jsp/androidversionaddordetail.jsp?subid=appstorelist','查看/编辑版本',800,300,'20%','20%');
	//JqueryDialog.Open1('查看/编辑版本', 'androidversionaddordetail.jsp?id='+model.version_id, 420,280, true, true, true,true);
	//JqueryDialog.Open1('公告内容', 'announcementdrew.jsp?ggbh=' + model.ggbh+'&urls=fby', 800, 420, true, true, true,true);
}

/*
	 函数:  
	 说明:  删除
	 参数:   无
	 返回值: 无
	 */
var delAndroidVersion = function(id) {
	var ids = "";
	var fIds = "";
	var selectedIds = $("#gridTable").jqGrid("getGridParam", "selarrrow");
	for(var i = 0; i < selectedIds.length; i++) {
		var model = jQuery("#gridTable").jqGrid('getRowData', selectedIds[i]);
		 if("" != ids){			   
			ids += ",";
		 }
		 ids += "'"+model.version_id+"'";
		 
		 if("" != fIds){			   
			fIds += ",";
		 }
		 fIds += model.version_name;
			
	}
	if (IsSpace(ids)) {
		alert("请选择要删除的记录！");
	} else {
		if (!confirm("确定要删除该版本吗？")) {
			return;
		}
		$("#userIds").val(ids);
		$("#fileIds").val(fIds);
		var fm = document.getElementById("delForm");
		fm.target = "hiddenFrame";
		fm.submit();
	}
}

</script>
</head>
<body style="overflow-y:auto;">
		<table width="100%" id="queryTable">
			<tr>
				<td>

					<!-- 查询条件选区    tabs_search_ctable(查询table样式) -->
					<table width="100%" border="0" cellspacing="0" cellpadding="0"
						class="tabs_search_ctable_box">
						<tr>
							<td>
								<!-- 固定查询 -->
								<table width="100%" border="0" cellspacing="0" cellpadding="0"
									class="tabs_search_ctable">
									<tr>
										<th width="90" class="input_cx_title_th">
											版本名称：
										</th>
										<td width="150" class="cx_title_td">
											<input name="version_name" id="version_name" type="text" style="width:200px;"
												class="input_cx_title_283" />
										</td>
										<th width="90" class="input_cx_title_th">
											版本号：
										</th>
										<td width="150" class="cx_title_td">
											<input name="version_esn" id="version_esn" type="text" style="width:200px;"
												class="input_cx_title_283" />
										</td>
										<td width="300" colspan="2">
											<input name="search" value="搜索" type="button"
												onclick="androidVersionSearch()" class="but_y_01" />
											<input name="reset" value="重置" type="button"
												onclick="clearSearch()" class="but_y_01" />
										</td>
									</tr>
								</table>
								<!-- 固定查询 end-->
							</td>
						</tr>
					</table>
					<!-- 查询条件选区    tabs_search_ctable(查询table样式) -->
				</td>
			</tr>
			<tr>
				<td>
					<div class="cGridArea">
						<table id="gridTable"></table>
						<div id="gridPager"></div>
					</div>
				</td>
			</tr>
		</table>
		<form id="delForm" name="delForm" method="post"
			action="../../../wangcheng/androidversion/jsp/androidversiondo.jsp">
			<input type="hidden" name="userIds" id="userIds" />
			<input type="hidden" name="fileIds" id="fileIds" />
			<input type="hidden" name="action" value="delete" />
		</form>
		<iframe name="hiddenFrame" width=0 height=0></iframe>
	</body>
</html>
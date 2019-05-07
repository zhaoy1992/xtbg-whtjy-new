<%-- 
描述：通知公告已发布列表
作者：黄艺平
版本：1.0
日期：2013-09-20
 --%>
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
<title>已发布列表</title>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<!-- 引入jQuery UI -->
<script src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>
<!-- 引入jGrid -->
<script src="../../resources/plug/jquery.jqGrid-4.3.1/js/i18n/grid.locale-en.js" type="text/javascript"></script>
<script src="../../resources/plug/jquery.jqGrid-4.3.1/js/jquery.jqGrid_old.min.js" type="text/javascript"></script>
<!-- 引入my97时间控件 -->
<script src="../../resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<!-- 引入其它 -->
<script src="../../resources/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js"></script>

<script type="text/javascript">
$(function() {
	$(document).keydown(function(){
		if(event.keyCode == 13){ 
			noticeSearch();
		}
	});

	$("#gridTable").jqGrid({
		url: '<%=path%>' + '/pubListServlet?classNameId=com.chinacreator.xtbg.core.notice.list.NoticeReleasedList',  //pubListServlet列表公共的servlet,classNameId在servletBean.xml文件中配置要调用的类,isPage:是否翻页(true,false),默认为true
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
		//字符串数组，用于指定各列的题头文本，与列的顺序是对应的。
		colModel: [ //最重要的数组之一，用于设定各列的参数
		{
			label:"公告ID",
			name: 'n_notice_id',
			index: 'n_notice_id',
			hidden: true
		},
		{
			label:"n_type",
			name: 'n_type',
			index: 'n_type',
			hidden: true
		},
		{
			label:"公告标题",
			name: 'n_title',
			index: 'n_title',
			width: 340,
			editable: true
		},
		{
			label:"发布人名称",
			name: 'n_release_username',
			index: 'n_release_username',
			width: 80,
			sortable: false
			
		},
		{
			label:"发布人ID",
			name: 'n_release_userid',
			index: 'n_release_userid',
			hidden: true
		},
		{
			label:"发布时间",
			name: 'n_release_time',
			index: 'n_release_time',
			width: 100
		},
		{
			label:"查看率",
			name: 'viewrate',
			index: 'viewrate',
			width: 60,
			sortable: false,
			hidden: false
		}
		],
		sortname: 'n_release_time',
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
				if(IsSpace(model.n_type)){
					be = "<input class='but_y_01' onMouseOver=javascript:$(this).attr('class','but_y_02'); onMouseOut=javascript:$(this).attr('class','but_y_01'); type='button'  value='查看' onmousedown='doview("+cl+")'>";
					jQuery("#gridTable").jqGrid('setRowData', ids[i], {
						viewrate: be
					});
				}else{
					if(model.n_type=="1") be="<font color=blue><b>院内资讯</b></font>";
					if(model.n_type=="2") be="<font color=green><b>员工天地</b></font>";
					if(model.n_type=="3") be="<font color=blue><b>院内简报</b></font>";
					jQuery("#gridTable").jqGrid('setRowData', ids[i], {
						viewrate: be
					});
				}
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
		search : toNoticeParamJosn(),

		prmNames: { //这是一个数组，用于设置jqGrid将要向Server传递的参数名称
			rows: "rows",
			//表示请求行数的参数名称  
			sort: "sidx",
			//表示用于排序的列名的参数名称  
			order: "sord",
			//表示采用的排序方式的参数名称 
			search : "search"
		},
		toolbar: [true,"top","<input class='but_y_01' onMouseOver=javascript:$(this).attr('class','but_y_02'); onMouseOut=javascript:$(this).attr('class','but_y_01'); id=qxfb type='button' value='取消发布' onclick='cacelRelease()'/>"],
		multiselect: true,
		beforeSelectRow:function (id, e)
		{
		 
			var $myGrid = $(this),  
            i = $.jgrid.getCellIndex($(e.target).closest('td')[0]),  
            cm = $myGrid.jqGrid("getGridParam", "colModel");
            if(cm[i].name != 'cb'){
            	veiwNotice(id);
			}
        	return (cm[i].name === 'cb');  
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
函数:  veiwNotice
说明:  查看通知公告信息
参数:   无
返回值: 无
*/
var veiwNotice = function(id) {
	var model = jQuery("#gridTable").jqGrid('getRowData', id);
	 openWindows('sub_main_updateannouncements','查看基本信息','../../notice/jsp/noticeview.jsp?n_notice_id='+ model.n_notice_id+ '&urls=fby'+'&subid=sub_main_updateannouncements','ggfs',false,window);
}

//接收查看
var doview = function(id){
	var model = jQuery("#gridTable").jqGrid('getRowData', id);
	openAlertWindows('windowId',getCurrentFilePath()+'noticeviewsituationlist.jsp?n_notice_id='+ model.n_notice_id,'查看详情','60%','400','20%');
	
}
var myRead = function(id){
	var model = jQuery("#gridTable").jqGrid('getRowData', id);
	var url = getCurrentFilePath()+'announcementradelist.jsp?id='+model.ggbh;
	openAlertWindows('windowId',url,'查看情况','700px','450px','10%','25%');
}
/*
	 函数:  toNoticeParamJosn
	 说明:  构建要查询的参数
	 参数:   无
	 返回值: 返回要查询的参数
	 */
var toNoticeParamJosn = function() {
	var str = "{'n_title':'" + $("#n_title").val() + "','n_creator_time':'" + $("#n_creator_time").val()
	+ "','n_release_time':'" + $("#n_release_time").val() + "','n_creator_userid':'<%=accesscontroler.getUserID()%>'}";
	return descape(escape(str));
}

	/*
	 函数:  noticeSearch
	 说明:  查询用户信息
	 参数:   无
	 返回值: 用户列表
	 */
	var noticeSearch = function() {
		var sdata = { //构建查询需要的参数 
		}; //获得当前postData选项的值  
		var postData = $("#gridTable").jqGrid("getGridParam", "postData"); //将查询参数融入postData选项对象  
		$.extend(postData, sdata);
		$("#gridTable").jqGrid("setGridParam", {
			search : true,
			userFilters:toNoticeParamJosn()
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
			paramJson : toNoticeParamJosn()
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
	 函数:  cacelRelease
	 说明:  取消发布
	 参数:   无
	 返回值: 无
	 */
	var cacelRelease = function(id) {
		 var ids = "";
			var selectedIds = $("#gridTable").jqGrid("getGridParam", "selarrrow");
			for ( var i = 0; i < selectedIds.length; i++) {
				var model = jQuery("#gridTable").jqGrid('getRowData',selectedIds[i]);
				if ("" != ids) {
					ids += ",";
				}
				ids += model.n_notice_id;
			}		 
			if (IsSpace(ids)) {
				alert("请选择要取消发布的已发布记录！");
			} else {
				var okF = function(){	
					
					$("#calcel_n_notice_ids").val(ids);
					var fm = document.getElementById("cacelReleaseForm");
					fm.target = "hiddenFrame";
					fm.submit();
					}
					var p={
							headerText:'提示',
							okName:'确认',
					        okFunction:okF,
					        cancelName:'取消'
					};
				alert("确定要取消发布该信息吗？",p)
				}
	}
</script>
</head>
<body>
<div>
<table width="100%">
	<tr>
		<td><!-- 查询条件选区    tabs_search_ctable(查询table样式) -->
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="tabs_search_ctable_box">
			<tr>
				<td><!-- 固定查询 -->
				<table width="100%" border="0" cellspacing="0" cellpadding="0"
					class="tabs_search_ctable">
					<tr>
						<th width="90" class="input_cx_title_th">标题：</th>
						<td width="296" class="cx_title_td"><input
							class="input_cx_title_283" type="text" id="n_title" name="n_title" onkeyup="checkInsert(this)" onbeforepaste="checkPaste()"/></td>
						<td width="385" colspan="3"><input name="Input2" value="搜索"
							type="button" onclick="noticeSearch()" class="but_y_01" />
						<span id="selAreaImg" class="all_search_condition"><a
							onclick="hiddenOrShowSelArea('hiddenArea','selAreaImg')">更多搜索条件</a></span></td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td><!-- 隐藏查询 -->
				<table width="100%" border="0" cellspacing="0" cellpadding="0"
					class="tabs_search_ctable" id="hiddenArea" style="display: none">
					<tr>
						<th class="input_cx_title_th">发布时间：</th>
						<td class="cx_title_td"><input class="date_120 Wdate"
							type="text" id="n_creator_time" name="n_creator_time"
							onfocus="WdatePicker({onpicked:function(){$('#n_release_time').focus();}})" />
						<span class="date_120_span">至</span> <input class="date_120 Wdate"
							type="text" id="n_release_time" name="n_release_time"
							onfocus="WdatePicker({minDate:'#F{$dp.$D(\'n_creator_time\')}',dateFmt:'yyyy-MM-dd'})" />
						</td>
					</tr>

				</table>
				</td>
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
<!-- 查询列表区 --></div>
<form id="cacelReleaseForm" name="cacelReleaseForm" method="post" action="noticedo.jsp">
	<input type="hidden" name="calcel_n_notice_ids" id="calcel_n_notice_ids" /> 
	<input type="hidden" name="action" value="cacelRelease" />
</form>
<iframe name="hiddenFrame" width="0" height="0"></iframe>
</body>
</html>
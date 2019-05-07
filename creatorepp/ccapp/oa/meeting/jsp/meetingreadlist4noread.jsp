<%--
　　描述：会议通知阅读情况列表查询--未阅读
　　作者：黄海
　　版本：1.0
　　日期：2013-6-25
--%>
<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DaoUtil"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head> 
<%
AccessControl accesscontroler = AccessControl.getAccessControl();
accesscontroler.checkAccess(request, response);
String path = request.getContextPath();
String m_notice_id = request.getParameter("m_notice_id");  //会议通知主键
String m_is_read = request.getParameter("m_is_read");//未阅读
%>
<meta>
<title>会议通知阅读情况列表查询--未阅读</title>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../resources/plug/jquery1.7/jquery-1.7.1.min.js"></script>
<script src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>
<script src="../../resources/plug/jquery.jqGrid-4.3.1/js/i18n/grid.locale-en.js" type="text/javascript"></script>
<script src="../../resources/plug/jquery.jqGrid-4.3.1/js/jquery.jqGrid.min-sp1.js" type="text/javascript"></script>
<!-- 引入其它 -->
<script src="../../resources/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js" ></script>
<!-- 引入my97时间控件 -->
<script src="<%=path %>/ccapp/oa/resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<script>
/*
	配置jqGrid，与会单位阅读情况列表查询--未阅读
*/
$(function() {
	/* var _documentBodyHeight = window.top.findPageCacheName("_documentBodyHeight");
	jQuery("#maindiv").height(_documentBodyHeight-150);
	 */
	$("#gridTable").jqGrid({//pubListServlet列表公共的servlet,classNameId在servletBean.xml文件中配置要调用的类,isPage:是否翻页(true,false),默认为true
		url: '<%= path %>' + '/pubListServlet?classNameId=com.chinacreator.xtbg.core.meeting.list.MeetingReceiverUnitList',
		datatype: "json",
		mtype: "POST",
		height: "100%",
		autowidth: true,
		colModel: [ //最重要的数组之一，用于设定各列的参数
		{
			label: '接收表主键id',
			name: 'm_receiver_id',
			index: 'm_receiver_id',
			hidden:true
		},{
			label: '会议通知id',
			name: 'm_notice_id',
			index: 'm_notice_id',
			hidden:true
		},{	
			label: '参会单位名称',
			name: 'm_receiver_unit_name',
			index: 'm_receiver_unit_name',
			width: 100
		},{
			label: '联系人',
			name: 'm_link_user_name',
			index: 'm_link_user_name',
			width: 100
		},{
			label: '联系电话',
			name: 'm_link_tel',
			index: 'm_link_tel',
			width: 50
		},{
			label: '接收时间',
			name: 'm_create_time',
			index: 'm_create_time',
			width: 100
		}
		],
		sortname: 'm_receiver_unit_name',
		sortorder: 'desc',
		viewrecords: true,
		rowNum: 10,
		rowList: [10, 20, 30],
		gridComplete: function() {
		},
		jsonReader: { //这又是一个数组，用来设定如何解析从Server端发回来的json数据
			repeatitems: false
		},
		onCellSelect:function (id,icol)
		{
			if(icol != 0)
			{
			}
		},
		pagerintoolbar:true,//上面的分页条
		pagerinBottombar:true,//下面的分页条
		search : convertParamJson(),
		prmNames: { //这是一个数组，用于设置jqGrid将要向Server传递的参数名称
			rows: "rows",
			sort: "sidx",
			order: "sord",
			search : "search"
		},
		multiselect: false
	}).navGrid('#gridPager', {
		edit: false,
		add: false,
		del: false,
		search : false,
		refresh : false
	});
});
/*
	 函数:  convertParamJson
	 说明:  构建要查询的参数
	 参数:   无
	 返回值: 返回要查询的参数
*/
var convertParamJson = function () {
    var str = "{" + 
    	"'m_is_read':'"  + $("#m_is_read").val() + "',"+
    	"'m_notice_id':'" + $("#m_notice_id").val() + 
   	"'}";
    return descape(str);
}
/*
 函数:  refreshGrid
 说明:  静态加载列表数据，主要供子页面调用和删除字段后调用
 参数:   无
 */
function refreshGrid() {
	var sdata = { //构建查询需要的参数 
		paramJson : convertParamJson()
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
	配置jqGrid，与会人员阅读情况列表查询--未阅读
*/
$(function() {
	$("#gridTable4User").jqGrid({//pubListServlet列表公共的servlet,classNameId在servletBean.xml文件中配置要调用的类,isPage:是否翻页(true,false),默认为true
		url: '<%= path %>' + '/pubListServlet?classNameId=com.chinacreator.xtbg.core.meeting.list.MeetingReceiverUserList',
		datatype: "json",
		mtype: "POST",
		height: "100%",
		autowidth: true,
		colModel: [ //最重要的数组之一，用于设定各列的参数
		{
			label: '接收表主键id',
			name: 'm_receiver_id',
			index: 'm_receiver_id',
			hidden:true
		},{
			label: '会议通知id',
			name: 'm_notice_id',
			index: 'm_notice_id',
			hidden:true
		},{	
			label: '参会单位',
			name: 'm_receiver_unit_name',
			index: 'm_receiver_unit_name',
			width: 100
		},{	
			label: '联系人',
			name: 'm_receiver_user_name',
			index: 'm_receiver_user_name',
			width: 100
		},{
			label: '联系电话',
			name: 'm_link_tel',
			index: 'm_link_tel',
			width: 50
		},{
			label: '接收时间',
			name: 'm_create_time',
			index: 'm_create_time',
			width: 100
		}
		],
		sortname: 'm_receiver_unit_name',
		sortorder: 'desc',
		viewrecords: true,
		rowNum: 11,
		rowList: [10, 20, 30],
		gridComplete: function() {
		},
		jsonReader: { //这又是一个数组，用来设定如何解析从Server端发回来的json数据
			repeatitems: false
		},
		onCellSelect:function (id,icol)
		{
			if(icol != 0)
			{
			}
		},
		pagerintoolbar:true,//上面的分页条
		pagerinBottombar:true,//下面的分页条
		search : convertParamJson(),
		prmNames: { //这是一个数组，用于设置jqGrid将要向Server传递的参数名称
			rows: "rows",
			sort: "sidx",
			order: "sord",
			search : "search"
		},
		multiselect: false
	}).navGrid('#gridPager4User', {
		edit: false,
		add: false,
		del: false,
		search : false,
		refresh : false
	});
});
/*
	 函数:  convertParamJson4User
	 说明:  构建要查询的参数
	 参数:   无
	 返回值: 返回要查询的参数
*/
var convertParamJson4User = function () {
    var str = "{" + 
    	"'m_is_read':'"  + $("#m_is_read").val() + "',"+
    	"'m_notice_id':'" + $("#m_notice_id").val() + 
   	"'}";
    return descape(str);
}
/*
 函数:  refreshGrid
 说明:  静态加载列表数据，主要供子页面调用和删除字段后调用
 参数:   无
 */
function refreshGrid4User() {
	var sdata = { //构建查询需要的参数 
		paramJson : convertParamJson4User()
	}; //获得当前postData选项的值  
	var postData = $("#gridTable4User").jqGrid("getGridParam", "postData"); //将查询参数融入postData选项对象  
	$.extend(postData, sdata);
	$("#gridTable4User").jqGrid("setGridParam", {
		search : true
	// 将jqGrid的search选项设为true  
	}).trigger("reloadGrid", [ {
		page : 1
	} ]); //重新载入Grid表格，以使上述设置生效
}

</script>
</head>
<body>   
	<div>
 		<div class="cue_box_top">
			<input class="but_y_01" type="button" value="关闭" onclick="removeAlertWindows('',true)" />
		</div>
		
		<div class="content_02_box" style="width:99%">
			<div class="content_02_box_title_bg" style="width:99%"><span>单位</span></div>
		</div>
		<div class="content_02_box_div_special" style="width:99%">
			<table id="gridTable">
			</table>
			<div id="gridPager">
			</div>
		</div>
		<table>
		    <tr>
		        <td height="10px"></td>
		    </tr>
		</table>
		<div class="content_02_box" style="width:99%">
			<div class="content_02_box_title_bg" style="width:99%"><span>个人</span></div>
		</div>
		<div class="content_02_box_div_special" style="width:99%">
			<table id="gridTable4User">
			</table>
			<div id="gridPager4User">
			</div>
		</div>
		<table>
		    <tr>
		        <td height="20px"><p>&nbsp;</p></td>
		    </tr>
		</table>
		<input type="hidden" name="m_notice_id" id="m_notice_id" value="<%=m_notice_id %>">
		<input type="hidden" name="m_is_read" id="m_is_read" value="<%=m_is_read %>">
	</div>
</body>
</html>
<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.pub.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.pub.directory.dao.DirectoryDao"%>
<%@page import="com.chinacreator.xtbg.pub.util.DaoImplClassUtil"%>
<%@page import="java.util.List"%>
<%@page import="com.chinacreator.xtbg.pub.directory.entity.ListShowUtilBean"%><html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
	String path = request.getContextPath();
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);

	String orgid = StringUtil.deNull(request.getParameter("orgid"));
	DirectoryDao directoryDao = (DirectoryDao)DaoImplClassUtil.getDaoImplClass("directoryDaoImpl");
	List<ListShowUtilBean> firstCodeList = directoryDao.getFirstCodeShowInfo(orgid);
%>
<title>JGRID</title>

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
<script src="../../../resources/js/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>

<script type="text/javascript"
	src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
	<link rel="stylesheet" type="text/css" media="screen" href="../resources/css/testcss.css" />
<!-- 公共部分引用结束 -->


<script type="text/javascript">
var nameindex = "";//拼音首字母

var searchInputValue = "";//搜索框的值

var isInputSearchText = false;//是否正在在查询文本框中输入
$(function() {
	$(document).keydown(function(){
		if(event.keyCode == 13){ 
			userSearch();
		}
	});
	
	var defaultSearchShow = "输入姓名、号码或邮件"
		$("#filters a").click(function (event){
			if($(event.target).html() == "全部"){
				nameindex = "";
				searchInputValue = "";
				$("#searchInput").val(defaultSearchShow);
				  $("#searchInput").addClass("focus");
			}else{
				nameindex = $(event.target).html();
			}
			userSearch();
		})
		$("#btn_Search").bind('click', searchByLikename);

		$("#searchInput").focus(function(){
			isInputSearchText = true;
			if(IsSpace(searchInputValue)){
			  $("#searchInput").removeClass("focus");
			  $("#searchInput").val("");
			}
		});

		$("#searchInput").bind("propertychange",function(){
			if(isInputSearchText){
				searchInputValue = $("#searchInput").val();
			}
		});
		
		$("#searchInput").blur(function(){
			isInputSearchText = false;
			searchInputValue = $("#searchInput").val();
			if(IsSpace($("#searchInput").val())){
			  $("#searchInput").val(defaultSearchShow);
			  $("#searchInput").addClass("focus");
			}
		});
	
	$("#gridTable").jqGrid({
		url: '<%= path %>' + '/commonListServlet?classNameId=directoryList',  //commonListServlet列表公共的servlet,classNameId在servletBean.xml文件中配置要调用的类,isPage:是否翻页(true,false),默认为true
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
		colNames: ['名录id','orgid', '姓名 ', '常用手机 ','职务','政治面貌','民族','籍贯','所在部门'],
		//字符串数组，用于指定各列的题头文本，与列的顺序是对应的。
		colModel: [ //最重要的数组之一，用于设定各列的参数
		{
			name: 'directoryid',
			index: 'directoryid',
			hidden: true
		},
		{
			name: 'orgid',
			index: 'orgid',
			hidden: true
		},
		{
			name: 'directoryname',
			index: 'directoryname',
			width: 180,
			editable: true
		},
		{
			name: 'mobile2',
			index: 'mobile2',
			width: 230,
			search: true
		},
		{
			name: 'post',
			index: 'post',
			width: 230,
			search: true
		},
		{
			name: 'politics',
			index: 'politics',
			width: 230,
			search: true
		},
		{
			name: 'nation',
			index: 'nation',
			width: 230,
			search: true
		},
		{
			name: 'natives',
			index: 'natives',
			width: 230,
			search: true
		},
		{
			name: 'orgname',
			index: 'orgname',
			width: 230,
			search: true
		},
		
		],
		sortname: '',
		//指定默认的排序列，可以是列名也可以是数字。此参数会在被传递到Server端。
		sortorder: 'desc',
		viewrecords: true,
		
		//设置是否在Pager Bar显示所有记录的总数。
		rowNum: 10,
		//用于设置Grid中一次显示的行数，默认值为20。正是这个选项将参数rows（prmNames中设置的）通过url选项设置的链接传递到Server。注意如果Server返回的数据行数超过了rowNum的设定，则Grid也只显示rowNum设定的行数。
		rowList: [10, 20, 30],
		//一个数组，用于设置Grid可以接受的rowNum值。例如[10,20,30]
		gridComplete : function() { // var idss=jQuery("#gridTable").jqGrid('getColNames');
			// alert(idss);
			var ids = $("#gridTable").getDataIDs(); //jqGrid('getDataIDs');
			for ( var i = 0; i < ids.length; i++) {
				var cl = ids[i];
			}
		},
		//一个数组，用于设置Grid可以接受的rowNum值。例如[10,20,30]
		jsonReader: { //这又是一个数组，用来设定如何解析从Server端发回来的json数据
			repeatitems: false
		},
		//pager: "#gridPager",
		//定义页码控制条Page Bar
		pagerintoolbar:true,//上面的分页条
		pagerinBottombar:true,//下面的分页条
		
		//caption: "名录管理",
		//设置Grid表格的标题，如果未设置，则标题区域不显示。
		search : toUserParamJosn(),
		prmNames: { //这是一个数组，用于设置jqGrid将要向Server传递的参数名称
			rows: "rows",
			//表示请求行数的参数名称  
			sort: "sidx",
			//表示用于排序的列名的参数名称  
			order: "sord",
			//表示采用的排序方式的参数名称 
			search : "search"
		},
		//toolbar: [true,"top"],
		toolbar : [ true, "top" ,"<input class='but_y_01' onMouseOver=javascript:$(this).attr('class','but_y_02'); onMouseOut=javascript:$(this).attr('class','but_y_01'); id=add value='添加' type='button' onclick='addUser()'/><input class='but_y_01' onMouseOver=javascript:$(this).attr('class','but_y_02'); onMouseOut=javascript:$(this).attr('class','but_y_01'); value='删除' id=del type='button' onclick='delUser()'/><input class='but_y_01' onMouseOver=javascript:$(this).attr('class','but_y_02'); onMouseOut=javascript:$(this).attr('class','but_y_01'); value='排序' id=del type='button' onclick='orderByUser()'/>"],
		multiselect: true,
		onCellSelect:function (id,iCol)
		{
			if(iCol != 0)
			{
				updateUser(id);
			}
		} 
		
	}).navGrid('#gridPager', {
		edit: false,
		add: false,
		del: false,
		search: false,
		refresh: false
	});
	
	
	//操作按钮区  cOprArea(操作区样式)
	<%-- $("#t_gridTable").append("<div>")
	<%if(!StringUtil.nullOrBlank(orgid)){%>
		.append("<input class='but_y_01' value='添加' id=add type='button' onclick='addUser()'/>")
		.append("<input class='but_h_01' value='删除' id=del type='button' onclick='delUser()'/>")
	<%}%>
 		.append("</div>");
	
	$("#userReName").datepicker({
		showOn: "button",
		buttonImage: "../../../resources/plug/jquery-ui-1.8.17.custom/development-bundle/demos/images/calendar.gif",
		buttonImageOnly: true,
		dateFormat:"yy-mm-dd"
	}); --%>
	
});
	 
/*
	 函数:  toUserParamJosn
	 说明:  构建要查询的参数
	 参数:   无
	 返回值: 返回要查询的参数
	 */
var toUserParamJosn = function() {
	var str = "{'orgid':'<%=orgid %>','likevalue':'" + searchInputValue + "','nameindex':'" + nameindex + "','listtype':'add'}";
	return descape(escape(str));
}

var searchByLikename = function() {
	userSearch();
}

/*
	 函数:  userSearch
	 说明:  查询用户信息
	 参数:   无
	 返回值: 用户列表
	 */
var userSearch = function() {
	var sdata = { //构建查询需要的参数 
		paramJson: toUserParamJosn()
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
	var sdata = {
		paramJson: ""
	};
	var postData = $("#gridTable").jqGrid("getGridParam", "postData");
	$.extend(postData, sdata); //将postData中的查询参数覆盖为空值  
	$("#gridTable").jqGrid("setGridParam", {
		search: false // 将jqGrid的search选项设为false  
	}).trigger("reloadGrid", [{
		page: 1
	}]);
	resetSingleSearchDialog();
};

/*
	 函数:  resetSingleSearchDialog
	 说明:  清空值查询值
	 参数:   无
	 返回值: 无
	 */
var resetSingleSearchDialog = function() { //$("radio","#singleSearchDialog").attr("checked", false);  
	$(":text", "#queryTable").val("");
};

/*
	 函数:  addUser
	 说明:  添加用户
	 参数:   无
	 返回值: 无
	 */
var addUser = function() {
			 if(<%=orgid == ""%>){
				alert("请先选择左边的所属单位!");
				return;
			} 
	<%-- JqueryDialog.Open1('新增名录', 'addorupdatedirectory.jsp?orgid=<%=orgid %>', 900, 440, true, true, true,true);
	openAlertWindows('windowId','../../directory/jsp/addorupdatedirectory.jsp?orgid=<%=orgid %>','新增名录',790,550,'10%','25%'); --%>
	url = "addorupdatedirectory.jsp?widowsid=sub_directorylist&orgid=<%=orgid %>";
	location.href = url;
	<%-- openWindows("sub_directorylist","新增名录","../../directory/jsp/addorupdatedirectory.jsp?widowsid=sub_directorylist&orgid=<%=orgid %>",'mlgl',false,window); --%>
}

/*
	 函数:  updateUser
	 说明:  修改用户
	 参数:   无
	 返回值: 无
	 */
var updateUser = function(id) {
	var model = jQuery("#gridTable").jqGrid('getRowData', id);
	/* openAlertWindows('windowId','../../directory/jsp/addorupdatedirectory.jsp?typeid='+ model.directoryid,'修改名录',790,550,'10%','25%');
	JqueryDialog.Open1('修改名录', 'addorupdatedirectory.jsp?typeid=' + model.directoryid, 900, 440, true, true, true,true); */
	url = "addorupdatedirectory.jsp?typeid= " +model.directoryid+ "&widowsid=sub_directorylist&orgid="+model.orgid;
	location.href = url;
	
	/* openWindows("sub_directorylist","修改名录","../../directory/jsp/addorupdatedirectory.jsp?typeid= " +model.directoryid+ "&widowsid=sub_directorylist",'mlgl',false,window); */
}

/*
	 函数:  updateUser
	 说明:  删除用户
	 参数:   无
	 返回值: 无
	 */
var delUser = function(id) {
		 var ids = "";
			var selectedIds = $("#gridTable").jqGrid("getGridParam", "selarrrow");
			
			for ( var i = 0; i < selectedIds.length; i++) {
				var model = jQuery("#gridTable").jqGrid('getRowData',
						selectedIds[i]);
				if ("" != ids) {
					ids += ",";
				}
				ids += "'" + model.directoryid + "'";

			}
			if (IsSpace(ids)) {
				alert("请选择要删除的记录！");
			} else {
				var okF = function(){
					$("#userIds").val(ids);
					var fm = document.getElementById("delForm");
					fm.target = "hiddenFrame";
					fm.submit();
				}
				var p={
							headerText:'提示',
							okName:'确认',
					        okFunction:okF,
					        cancelName:'取消'
					};
				alert("确定要删除用户信息吗？",p)
			}
	
}

function orderByUser(){
	openAlertWindows('windowId','../../directory/jsp/directoryConfig.jsp?orgid=<%=orgid%>','名录排序',790,555,'10%','15%');
}

</script>
</head>
<body>

<!-- <table class="ColumnTableArea">
      <tr>
        <td class="content_02_box_title_bg">名录管理</td>
        <td>&nbsp;</td>
        <td ></td>
      </tr>
    </table> -->
<!-- 查询列表区 cGridArea(查询区样式)-->
<div class="btn-bar">
<div  class="filters logClass" id="filters" >
	<span  style="width:100px; color:#000">首字母查询：</span>
		<a style="width:30px;" href="javascript:void(0)">全部</a>
		<%for(ListShowUtilBean showBean:firstCodeList){ 
			if(showBean.isExsit){%>
			<a style="width:13px;" href="javascript:void(0)"><%=showBean.getFirstCode() %></a>
		<%}else{ %>
			<span style='width: 13px;'><%=showBean.getFirstCode() %></span>
		<%}} %>
	</div>
</div>
<!-- 条件查询 -->
		<div class="btn-bar">
		<div  class="filters logClass" >
		<span  style="width:100px; color:#000">&nbsp;&nbsp;条件查询：</span>
			<input name="search"  id="searchInput"  style="float:left;" type="text" value="输入姓名、号码或邮件" class="input_cx_title_188" />
			<input name="btn_Search" id="btn_Search" style="float:left;margin-left:5px"  class="but_y_01" value="搜索" type="button"/>
		</div>
		</div>

	<!-- 查询列表区 cGridArea(查询区样式)-->
	<div class="cGridArea">
		<table id="gridTable"></table>
		<div id="gridPager"></div>
	</div>
	<!-- 查询列表区 -->
	

	<form id="delForm" name="delForm" method="post" action="addorupdatedirectorydo.jsp">
		<input type="hidden" name="userIds" id="userIds" />
		<input type="hidden" name="action" value="del" />
	</form>
	
	<iframe name="hiddenFrame" width=0 height=0></iframe>
</body>
</html>
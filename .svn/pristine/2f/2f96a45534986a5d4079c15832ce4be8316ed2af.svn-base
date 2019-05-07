<%@page import="com.chinacreator.business.common.tools.CacheCommonManage"%>
<%@page import="com.chinacreator.xtbg.pub.personwork.entity.PersonSearchBean"%>
<%@page import="com.chinacreator.xtbg.pub.util.DaoUtil"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%
AccessControl accesscontroler = AccessControl.getInstance();
accesscontroler.checkAccess(request, response);
String path = request.getContextPath();
String userid = accesscontroler.getUserID();
String userArea=CacheCommonManage.getInstance().getSystemParam("CURSYSTEMCODE");


String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String absPath = request.getRealPath("").replaceAll(":","@").replaceAll("\\\\","\\\\\\\\");

PersonInfoDao personInfodao = (PersonInfoDao)DaoImplClassUtil.getDaoImplClass("personInfoDaoImpl");

String getGroupSelectHtml = personInfodao.getGroupSelectHtml(userid);

// 递归所有的机构ID
//String orgid = StringUtil.nullOrBlank(request.getParameter("orgid"))?accesscontroler.getChargeOrgId(): StringUtil.deNull(request.getParameter("orgid"));;
String orgid = request.getParameter("orgid");
if("431003".equals(userArea)){
     if (null == orgid){
		orgid = DaoUtil.SqlToField("select org_id from td_sm_organization where parent_id='0'");//查询机构根节点
	 }
}else{
	 orgid = StringUtil.nullOrBlank(request.getParameter("orgid"))?accesscontroler.getChargeOrgId(): StringUtil.deNull(request.getParameter("orgid"));

}
List<ListShowUtilBean> firstCodeList = personInfodao.getFirstCodeShowInfo4PublicAddress(orgid);

String areacode =CacheCommonManage.getInstance().getSystemParam("CURSYSTEMCODE");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.pub.personwork.dao.PersonInfoDao"%>
<%@page import="com.chinacreator.xtbg.pub.util.DaoImplClassUtil"%>
<%@page import="com.chinacreator.xtbg.pub.util.StringUtil"%>
<%@page import="java.util.List"%>
<%@page import="com.chinacreator.xtbg.pub.personwork.entity.ListShowUtilBean"%>
<%@page import="com.chinacreator.cms.driver.jsp.JspFile.Cache"%>
<%@page import="com.chinacreator.business.common.tools.CacheCommonManageProxy"%><html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>个人通讯录</title>

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
<script type="text/javascript"src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js"></script>
<script type="text/javascript"src="../../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript"src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<link rel="stylesheet" type="text/css" media="screen" href="../resources/css/testcss.css" />

<script type="text/javascript"src="../resources/js/multiSelect.js"></script>
<!--模块特殊，不能去掉，去掉字母样式会不显示  -->

<!--公共部分结束  -->
 

<script type="text/javascript">

var nameindex = "";//拼音首字母

var searchInputValue = "";//搜索框的值

var isInputSearchText = false;//是否正在在查询文本框中输入

$(function() {
	$(document).keydown(function(){
		if(event.keyCode == 13){
			searchByLikename();
		}
	});
	<% if("431003".equals(areacode)){ //苏仙没有职位查询 %> 
		var defaultSearchShow = "输入姓名、号码、邮箱或者所在单位";
   	<%} else { %>
   		var defaultSearchShow = "输入姓名、号码、邮箱、职务或者所在单位";
   	<%} %>
	$("#filters a").click(function (event){
		if($(event.target).html() == "全部"){
			nameindex = "";
			searchInputValue = "";
			$("#searchInput").val(defaultSearchShow);
			  $("#searchInput").addClass("focus");
		}else{
			nameindex = $(event.target).html();
		}
		personSearch();
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
		url: '<%= path %>' + '/commonListServlet?classNameId=publicAddressBook4RoleuserList',  //commonListServlet列表公共的servlet,classNameId在servletBean.xml文件中配置要调用的类,isPage:是否翻页(true,false),默认为true
		//jqGrid控件通过这个参数得到需要显示的数据，具体的返回值可以使XML也可以是Json
		datatype: "json",
		//这个参数用于设定将要得到的数据类型。我最常用的是“json”，其余的类型还包括：xml、xmlstring、local、javascript、function
		mtype: "POST",
		//定义使用哪种方法发起请求，GET或者POST
		<%if("410001".equals(areacode)){%>
		height: "270",//270
		<%}else{%>
		height: "100%",//270
		<%}%>
		//Grid的高度，可以接受数字、%值、auto，默认值为150
		//width ：800, //Grid的宽度，如果未设置，则宽度应为所有列宽的之和；如果设置了宽度，则每列的宽度将会根据shrinkToFit选项的设置，进行设置。
		//shrinkToFit ：true 此选项用于根据width计算每列宽度的算法。默认值为true。如果shrinkToFit为true且设置了width值，则每列宽度会根据width成比例缩放；如果shrinkToFit为false且设置了width值，则每列的宽度不会成比例缩放，而是保持原有设置，而Grid将会有水平滚动条
		autowidth: true,
		//默认值为false。如果设为true，则Grid的宽度会根据父容器的宽度自动重算。重算仅发生在Grid初始化的阶段；如果当父容器尺寸变化了，同时也需要变化Grid的尺寸的话，则需要在自己的代码中调用setGridWidth方法来完成。
		<%if("431003".equals(areacode)){%>
		colNames: ['名录id', '姓名 ','职务', '办公手机','办公电话','政治面貌 ','级别', '是否党政一把手','所在单位','是否引用','有无权限','权限隐藏值'],
		<%} else if ("421004".equals(areacode)){%>
		colNames: ['名录id', '姓名 ', '手机号码','办公电话','住宅电话','职务','短号','所在单位','是否引用','有无权限','权限隐藏值'],
		<%} else if("410001".equals(areacode)) {%>
		colNames: ['名录id', '姓名 ', '办公手机','办公电话','手机短码','职务','电子邮箱','所在单位','是否引用','有无权限','权限隐藏值'],
		<%} else {%>
		colNames: ['名录id', '姓名 ', '办公手机','办公电话','常用手机','职务','电子邮箱','所在单位','是否引用','有无权限','权限隐藏值'],
		<%}%>
		//字符串数组，用于指定各列的题头文本，与列的顺序是对应的。
		colModel: [ //最重要的数组之一，用于设定各列的参数
            {
    			name: 'directoryid',
    			index: 'directoryid',
    			hidden: true
    		},
    		{
    			name: 'directoryname',
    			index: 'directoryname',
    			width: 150,
    			editable: true
    		},
    		<%if("431003".equals(areacode)){%>
    		{
    			name: 'post',
    			index: 'post',
    			width: 150,
    			search: true
    		},
    		<%}%>
    		{
    			name: 'mobile',
    			index: 'mobile',
    			width: 150,
    			search: true
    		}
    		,
    		{
    			name: 'workphone',
    			index: 'workphone',
    			width: 150,
    			search: true
    		},
    		<% if(!"431003".equals(areacode)){ %>
    			//教育考试院手机短码
	    		<%if(!"410001".equals(areacode)){%>
	    		{
	    			name: 'mobile2',
	    			index: 'mobile2',
	    			width: 150,
	    			search: true
	    		},
	    		<%} else {%>
	    		{
	    			name: 'remark2',
	    			index: 'remark2',
	    			width: 150,
	    			search: true
	    		},
	    		<%}%>
    		{
    			name: 'post',
    			index: 'post',
    			width: 150,
    			search: true
    		},
	    		<% if("421004".equals(areacode)){ %>
	    		{
	    			name: 'remark2',
	    			index: 'remark2',
	    			width: 200,
	    			search: true
	    		},
	    		<%}else {%>
	    		{
	    			name: 'email',
	    			index: 'email',
	    			width: 200,
	    			search: true
	    		},
	    		<%}%>
    		<%}%>
    		<% if("431003".equals(areacode)){ %>
    		{
    			name: 'politics',
    			index: 'politics',
    			width: 150,
    			search: true
    		},
    		{
    			name: 'directorylevel',
    			index: 'directorylevel',
    			width: 150,
    			search: true
    		},
    		{
    			name: 'department',
    			index: 'department',
    			search: true ,
    			hidden: true
    		},
    		<%}%>    		
    		{
    			name: 'orgname',
    			index: 'orgname',
    			width: 100,
    			search: true
    		},
    		{
    			name: 'is_relation',
    			index: 'is_relation',
    			width: 100,
    			search: true,
    			hidden: true,
    			sortable: false
    		},
    		{
    			name: 'viewrole',
    			index: 'viewrole',
    			search: true,
    			sortable: false,
    			hidden: true
    		},
    		{
    			name: 'ishasviewrole',
    			index: 'ishasviewrole',
    			hidden: true
    		}
		],
		sortname: '',
		//指定默认的排序列，可以是列名也可以是数字。此参数会在被传递到Server端。
		sortorder: 'desc',
		viewrecords: true,
		
		//设置是否在Pager Bar显示所有记录的总数。
		<%if("410001".equals(areacode)){%>
		rowNum: 15,
		<%}else{%>
		rowNum: 10,
		<%}%>
		//用于设置Grid中一次显示的行数，默认值为20。正是这个选项将参数rows（prmNames中设置的）通过url选项设置的链接传递到Server。注意如果Server返回的数据行数超过了rowNum的设定，则Grid也只显示rowNum设定的行数。
		<%if("410001".equals(areacode)){%>
		rowList: [15, 30, 45],
		<%}else{%>
		rowList: [10, 20, 30],
		<%}%>
		//一个数组，用于设置Grid可以接受的rowNum值。例如[10,20,30]
		gridComplete: function() { // var idss=jQuery("#gridTable").jqGrid('getColNames');
			// alert(idss);
			$("#gridTable").setGridWidth($(window).width()*0.98);
			var ids = $("#gridTable").getDataIDs(); //jqGrid('getDataIDs');
			for (var i = 0; i < ids.length; i++) {
				var cl = ids[i];
				var model = jQuery("#gridTable").jqGrid('getRowData', cl);
				if("已引用" == model.is_relation){
					be = "<IMG " +
						"style='POSITION: static; WIDTH: 18px; HEIGHT: 16px;' " +
							"src='../resources/images/yiyinyong.jpg'>";
				}else if("true" == model.ishasviewrole){
					be = "<IMG " +
					"style='POSITION: static; WIDTH: 18px; HEIGHT: 16px;' " +
						"src='../resources/images/yiyinyong.jpg'>";
				}
				else{
					be = "<IMG " +
					"style='POSITION: static; WIDTH: 18px; HEIGHT: 16px;' " +
						"src='../resources/images/weiyinyong.jpg'>";
				}
			//be = "<input  type='button' value='编辑' onclick='updateUser(" + cl + ")'/>";
			//ce = "<input type='button' value='删除' onclick='delUser(" + cl + ")'/>";
			jQuery("#gridTable").jqGrid('setRowData', ids[i], {
				is_relation: be,
				viewrole:be
			});

			}
		},
		jsonReader: { //这又是一个数组，用来设定如何解析从Server端发回来的json数据
			repeatitems: false
		},
		//pager: "#gridPager",
		//定义页码控制条Page Bar
		//caption: "公共通讯录",
		//设置Grid表格的标题，如果未设置，则标题区域不显示。
		pagerintoolbar:true,//上面的分页条
		pagerinBottombar:true,//下面的分页条
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
		toolbar: [true,"top", ""
				<%if(CacheCommonManageProxy.getBooleanSystemParam("personwork.publicAddressBookList_add")){%>
				+"<input type='button' class='but_y_01' onMouseOver=javascript:$(this).attr('class','but_y_02'); onMouseOut=javascript:$(this).attr('class','but_y_02'); value='添加' onclick='openSingleInput()'/>"
				<%}%>
		        <%if(CacheCommonManageProxy.getBooleanSystemParam("personwork.publicAddressBookList_bindDirectToPersonal")){%>
		        +"<input type='button' title='导出到个人通讯录' class='but_infoOut_01' onMouseOver=javascript:$(this).attr('class','but_infoOut_02'); onMouseOut=javascript:$(this).attr('class','but_infoOut_01'); value='' onclick='bindDirectToPersonal()'/>"
		        <%}%>
		        <%if(CacheCommonManageProxy.getBooleanSystemParam("personwork.publicAddressBookList_excelOut")){%>
		        +"<input type='button' class='but_excelout_01' title='导出excel表格' onMouseOver=javascript:$(this).attr('class','but_excelout_02'); onMouseOut=javascript:$(this).attr('class','but_excelout_01');  value='' onclick='exportFile()'/>"
				<%}%>
				<%if(CacheCommonManageProxy.getBooleanSystemParam("personwork.publicAddressBookList_excelGo")){%>
				+"<input type='button' class='but_excelgo_01' title='导入excel表格' onMouseOver=javascript:$(this).attr('class','but_excelgo_02'); onMouseOut=javascript:$(this).attr('class','but_excelgo_01'); value='' onclick='openImport()'/>"
				<%}%>
				<%if(CacheCommonManageProxy.getBooleanSystemParam("personwork.publicAddressBookList_sendEmail")){%>
					<%if(CacheCommonManageProxy.getBooleanSystemParam("mailName")){%>
						+"<input type='button' class='but_y_01' title='发送文件' onMouseOver=javascript:$(this).attr('class','but_y_02'); onMouseOut=javascript:$(this).attr('class','but_y_01');  value='发送文件' onclick='sendEmail()'/>"
					<%}else{%>
						+"<input type='button' class='but_y_01' title='发送邮件' onMouseOver=javascript:$(this).attr('class','but_y_02'); onMouseOut=javascript:$(this).attr('class','but_y_01');  value='发送邮件' onclick='sendEmail()'/>"
					<%}%>
				<%}%>
				<%if(CacheCommonManageProxy.getBooleanSystemParam("personwork.publicAddressBookList_sendSms")){%>
				+"<input type='button' class='but_y_01' title='发送短信' onMouseOver=javascript:$(this).attr('class','but_y_02'); onMouseOut=javascript:$(this).attr('class','but_y_01');  value='发送短信' onclick='sendSms()'/>"
				<%}%>
		        ],
				
				
		multiselect: true,
		beforeSelectRow: function (id, e) {  
        	var $myGrid = $(this),  
            i = $.jgrid.getCellIndex($(e.target).closest('td')[0]),  
            cm = $myGrid.jqGrid("getGridParam", "colModel");
            if(cm[i].name != 'cb'){
            	editPerson(id);
	            }
        	return (cm[i].name === 'cb');  
    }
	}).navGrid('#gridPager', {
		edit: false,
		add: false,
		del: false,
		search: false,
		refresh: false
	});
	
	
	//$("#t_gridTable").append("<div>")
	//.append("<input type='button' class='eab' onclick='bindDirectToPersonal()'/>")
	//.append("</div>");


	/*
	$("#addin").button({
        icons: {
            primary: "ui-icon-plus"
        }
     });*/
	
	$("#userReName").datepicker({
		showOn: "button",
		buttonImage: "../../../resources/plug/jquery-ui-1.8.17.custom/development-bundle/demos/images/calendar.gif",
		buttonImageOnly: true,
		dateFormat:"yy-mm-dd"
	});
	//.setDefaults($.datepicker.regional['zh-CN']);
	//$("#datepicker" ).datepicker( "yyyy-mm-dd", "dateFormat", $(this).val() );
	//$("input:submit, a, button", ".demo" ).button();
	
});
/*
	 colModel的重要选项

	 和jqGrid一样colModel也有许多非常重要的选项，在使用搜索、排序等方面都会用到。这里先只说说最基本的。

	 name ：为Grid中的每个列设置唯一的名称，这是一个必需选项，其中保留字包括subgrid、cb、rn。
	 index ：设置排序时所使用的索引名称，这个index名称会作为sidx参数（prmNames中设置的）传递到Server。
	 label ：当jqGrid的colNames选项数组为空时，为各列指定题头。如果colNames和此项都为空时，则name选项值会成为题头。
	 width ：设置列的宽度，目前只能接受以px为单位的数值，默认为150。
	 sortable ：设置该列是否可以排序，默认为true。
	 search ：设置该列是否可以被列为搜索条件，默认为true。
	 resizable ：设置列是否可以变更尺寸，默认为true。
	 hidden ：设置此列初始化时是否为隐藏状态，默认为false。
	 formatter ：预设类型或用来格式化该列的自定义函数名。常用预设格式有：integer、date、currency、number等
	
	 资料:http://www.trirand.com/jqgridwiki/doku.php?id=wiki:common_rules
	 */


/*
	 函数:  toUserParamJosn
	 说明:  构建要查询的参数
	 参数:   无
	 返回值: 返回要查询的参数
	 */
var toUserParamJosn = function() {
	var department = ""; //是否是党政一把手
	var directorylevel = ""; //级别
	var politics="" ; //政治面貌
	var orgname ="" ; //所在单位
	var radio = $("[name=radio]:checked").val();
		if("undefined" != $("#directorylevel").val()){
			directorylevel = $("#directorylevel").val();
		}
		if("undefined" != $("#politics").val()){
			politics = $("#politics").val();
		}
		if("undefined" != $("#orgname").val()){
			orgname = $("#orgname").val();
		}
	 if($("[name=radio]:checked")){
	 	if(typeof(radio)=="undefined"){
	 		radio="";
	 	}else{
	    department = radio ;
	 	}
	} 
	
	<% if("431003".equals(areacode)){ //苏仙没有职位查询 %> 
		var siv = $("#searchInput").val()=="输入姓名、号码、邮箱或者所在单位" ? "" : $("#searchInput").val();
	<%} else { %>
		var siv = $("#searchInput").val()=="输入姓名、号码、邮箱、职务或者所在单位" ? "" : $("#searchInput").val();
	<%} %>
	var str = "{'orgid':'<%=orgid%>','userid':'<%=userid%>','likevalue':'" + siv + "','nameindex':'" + nameindex + "','listtype':'view','department':'"+department+"','directorylevel':'"+directorylevel+"','orgname':'"+orgname+"','politics':'"+politics+"'}";
	return descape(escape(str));
}


/*
函数:  personSearch
说明:  查询用户信息
参数:   无
返回值: 用户列表
*/
var personSearch = function() {
var sdata = { //构建查询需要的参数 
	paramJson: toUserParamJosn()
};//获得当前postData选项的值

var postData = $("#gridTable").jqGrid("getGridParam", "postData"); //将查询参数融入postData选项对象  
$.extend(postData, sdata);
$("#gridTable").jqGrid("setGridParam", {
	search: true // 将jqGrid的search选项设为true  
}).trigger("reloadGrid", [{
	page: 1
}]); //重新载入Grid表格，以使上述设置生效 
}


var searchByLikename = function() {
	personSearch();
}

var refreshGrid4WfactionInfo = function() {
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


var editPerson = function(id) {
	var model = jQuery("#gridTable").jqGrid('getRowData', id);
	//JqueryDialog.Open1('查看人员信息', 'viewdirectory4publicaddress.jsp?typeid=' + model.directoryid, 600, 300, true, true, false,true);
	if("true" == model.ishasviewrole){
	openAlertWindows('windowId','../../personwork/jsp/viewdirectory4publicaddress.jsp?typeid=' + model.directoryid+'&urls=have','查看人员信息',800,330,'25%','20%');
	}
}

function bindDirectToPersonal() {
	var ids = "";
	var tempArrs = [];
	var selectedIds = $("#gridTable").jqGrid("getGridParam", "selarrrow");
	$(selectedIds).each(function(){
		var model = jQuery("#gridTable").jqGrid('getRowData', this);
		if(!IsSpace(model.directoryid))
		tempArrs.push(model.directoryid);
	})
	ids = tempArrs.join();
	if (IsSpace(ids)) {
		alert("请选择要绑定的记录！");
	} else {
		
		var okF = function(){
			var url = "binddirecttopersonal.jsp";
			var isUse = false;
			params = {
						userid : '<%=userid%>',
						directoryids : ids
					 };
			$.ajax({
				url: url,
				type: 'POST',
				dataType: 'json',
				data: params,
				success: function(data){
					alert("操作成功！");
					refreshGrid4WfactionInfo();
				},
				error: function(jqXHR, textStatus, errorThrown){
					alert("操作失败！");
				}
			});	
		}
		var p={
					headerText:'提示',
					okName:'确认',
			        okFunction:okF,
			        cancelName:'取消'
			};
		alert("确定要绑定到个人通讯录吗？",p)
		
		
	}
}



function sendEmail() {
	var ids = "";
	var tempArrs = [];
	var tempUserNamesArrs = [];
	var selectedIds = $("#gridTable").jqGrid("getGridParam", "selarrrow");
	$(selectedIds).each(function(){
		var model = jQuery("#gridTable").jqGrid('getRowData', this);
		if(!IsSpace(model.directoryid))
		tempArrs.push(model.directoryid);
		if(!IsSpace(model.directoryname))
		tempUserNamesArrs.push(model.directoryname);
	})
	ids = tempArrs.join();
	if (IsSpace(ids)) {
		alert("请选择要发送的人！");
	} else {
		var params = {
				windowId : 'windowId1',
				beSendUserIds : tempArrs.join(),
				beSendUserNames : _pub.lang.zwzm(tempUserNamesArrs.join())
			 };
		var alertUrl = getContextPath() + '/ccapp/xtbg/yimingju/mail/jsp/sendMail.jsp?'+jQuery.param(params);
		<%if(CacheCommonManageProxy.getBooleanSystemParam("mailName")){%>
			openAlertWindows('windowId1',alertUrl,'文件发送','800','670','10%','25%');
		<%}else{%>
			openAlertWindows('windowId1',alertUrl,'邮件发送','800','670','10%','25%');
		<%}%>
		
		
	}
}

/**
 * 发送短信
 */
 function sendSms() {
		var ids = "";
		var tempArrs = [];
		var tempUserNamesArrs = [];
		var selectedIds = $("#gridTable").jqGrid("getGridParam", "selarrrow");
		$(selectedIds).each(function(){
			var model = jQuery("#gridTable").jqGrid('getRowData', this);
			if(!IsSpace(model.directoryid))
			tempArrs.push(model.directoryid);
			if(!IsSpace(model.directoryname))
			tempUserNamesArrs.push(model.directoryname);
		})
		ids = tempArrs.join();
		if (IsSpace(ids)) {
			alert("请选择要发送的人！");
		} else {
			var params = {
					windowId : 'windowId',
					beSendUserIds : tempArrs.join(),
					beSendUserNames : _pub.lang.zwzm(tempUserNamesArrs.join())
				 };
			var alertUrl = getContextPath() + '/ccapp/xtbg/huaihua/messagesend/jsp/addSendSms.jsp?'+jQuery.param(params);
			openAlertWindows('windowId',alertUrl,'短信发送',700,270,'25%','25%');
		}
	} 
 
var getCheckBoxValue = function() {
	/*得到所选择的值*/
	var str = "";
	$("[.jqgrow td input][checked]").each(function() {
		str += $(this).val() + ",";
	});
}

function exportFile(){
	window.open('ajaxexcel.jsp?parmjson='+toUserParamJosn());
}

//打开导入excel页面
function openImport(){
	openAlertWindows('windowId','../../../public/personwork/jsp/addressBookimport.jsp','导入excel表格','455px','70%','10%','40%',function(){
		location.reload();
	});
}
//打开手工添加页面
function openSingleInput(){
	openAlertWindows('windowId','../../../public/personwork/jsp/singleInput.jsp','添加','455px','173px','20%','40%',function(){
		location.reload();
	});
}
//ajax 加载 司机和电话
<%-- function exportFile(){
	var url = "ajaxexcel.jsp?pathurl=<%=absPath%>";
	var isUse = false;
	params = {
			//car_id : id
			 };
	$.ajax({
		url: url,
		type: 'POST',
		dataType: 'json',
		data: params,
		async : false,
		success: function(data){
			
		},
		error: function(jqXHR, textStatus, errorThrown){
			//alert("操作失败！");
		}
	});	
	return isUse;
}
 --%>
</script>
<SCRIPT type=text/javascript>
			
	$(function() {
		setSelect("#politics", "classinput1");
		setSelect("#directorylevel","classinput2");
	});

</SCRIPT>
<style type="text/css">
.optionbox {
	border: 1px solid #5a8dc0;
}

.redbost {
	border: 1px solid #5a8dc0;
	cursor: pointer;
	/* background: url(../resources/images/1.jpg) top right no-repeat;  */
	height: 20px;
	/* padding-right: 17px; */
	width: 175px;
 float:left;
}
</style>
</head>
<body>
	 <!-- 查询列表区 cGridArea(查询区样式)-->
<div class="btn-bar" style="border-top:1px solid #EAEAEA;">
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
		

	<!-- 查询条件选区    tabs_search_ctable(查询table样式) -->
			<table id="queryTable" width="100%" border="0" cellspacing="0" cellpadding="0" class="tabs_search_ctable_box">
				<tr>
					<td>
						<!-- 固定查询 -->
						<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tabs_search_ctable">
							<tr>
								<td width="60px" >条件查询：</td>
								<td class="cx_title_td" >
								<% if("431003".equals(areacode)){ //苏仙没有职位查询 %> 
									<input name="search"  id="searchInput"  style="float:left;" type="text" value="输入姓名、号码、邮箱或者所在单位" class="input_cx_title_240" />
			                   	<%} else { %>
			                   		<input name="search"  id="searchInput"  style="float:left;" type="text" value="输入姓名、号码、邮箱、职务或者所在单位" class="input_cx_title_240" />
			                   	<%} %>
			                    <input name="btn_Search" id="btn_Search" style="float:left; margin-left:5px;"  class="but_y_01" type="button" value="搜索"/>
								</td>
								<% if("431003".equals(areacode)){ %>
								<td width="385"    >
								<span id="selAreaImg" class="all_search_condition"><a onclick="hiddenOrShowSelArea('hiddenArea','selAreaImg')" >更多搜索条件</a></span>
								</td>
								<%} %>
							</tr>
						</table>
						<!-- 固定查询 end-->
					</td>
					</tr>
					  
					<tr>
					<td id="hiddenArea"  style="display:none">
						<!-- 隐藏查询 -->
						<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tabs_search_ctable" >
							<!-- 正规 4列 -->
							<tr>
								<td width="60px" >政治面貌：</td>
								<td align="left" width="348px">
								<P id="pid1" style="position: absolute;margin: 0;z-index:1;width: 200px">
								    <select id='politics' name='politics'  class="redbost" multiple="multiple">
					                <option value=""  type='checkbox' all='11'>&nbsp;全选</option>
					                <option value='1' type='checkbox' name="option">&nbsp;中共党员</option>
					                <option value='2' type='checkbox' >&nbsp;中共预备党员</option>
					                <option value='3' type='checkbox' >&nbsp;共青团员</option>
					                <option value='4' type='checkbox' >&nbsp;民革党员</option>
					                <option value='5' type='checkbox' >&nbsp;民盟盟员</option>
					                <option value='6' type='checkbox' >&nbsp;民建会员</option>
								    <option value='7' type='checkbox' >&nbsp;民进会员</option>
									<option value='8' type='checkbox' >&nbsp;农工党党员</option>
									<option value='9'  type='checkbox' >&nbsp;致公党党员</option>
									<option value='10' type='checkbox' >&nbsp;九三学社社员</option>
									<option value='11' type='checkbox' >&nbsp;台盟盟员</option>
									<option value='12' type='checkbox' >&nbsp;无党派民主人士</option>
									<option value='13' type='checkbox' >&nbsp;群众</option>
								</select>
								</P>&nbsp;
								</td>
								<td width="38px">级别：</td>
								<td align="left">
								<P id="pid2" style="position: absolute;margin: 0;z-index:1; width: 200px">
								<select  name="directorylevel" id='directorylevel' class="redbost" multiple="multiple">
								<option value='' type='checkbox' all='22'>&nbsp;全选</option>
								<option value='副厅级' type='checkbox' name="option">&nbsp;副厅级</option>
								<option value='正处级' type='checkbox' >&nbsp;正处级</option>
								<option value='副处级' type='checkbox' >&nbsp;副处级</option>
								<option value='正科级' type='checkbox' >&nbsp;正科级</option>
								<option value='副科级' type='checkbox' >&nbsp;副科级</option>
								<option value='科员'   type='checkbox' >&nbsp;科员</option>
								<option value='其他'   type='checkbox'>&nbsp;其他</option>
						        </select> 
						        </P>&nbsp;
								</td>
							</tr>
						</table>
						<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tabs_search_ctable"   >
						    <tr>
								<td width="60px">所在单位：</td>
								<td align="left" width="342px">
								<input name="orgname"  id="orgname"  style="float:left;" type="text" class="input_cx_title_188" />
								</td>
								<td width="100px" >是否党政一把手：</td>
								<td class="cx_title_td"  >
								    <input type="radio" name="radio" value="是 "/> 是 
									<input type="radio" name="radio" value="否"/>  否
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
	<!-- 查询列表区 -->

<iframe name="hiddenFrame" width=0 height=0></iframe>
</body>
</html>
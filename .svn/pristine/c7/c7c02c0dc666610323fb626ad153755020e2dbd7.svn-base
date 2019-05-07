<%@page import="com.chinacreator.business.common.tools.CacheCommonManage"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="com.chinacreator.xtbg.pub.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.pub.flowinfoconif.entity.FlowInfoBean"%>
<%@page import="com.chinacreator.xtbg.pub.flowinfoconif.dao.FlowInfoDao"%>
<%@page import="com.chinacreator.xtbg.pub.util.DaoImplClassUtil"%>
<%@page
	import="com.chinacreator.xtbg.pub.flowinfoconif.entity.FlowDefInfoBean"%>
<%@page import="com.chinacreator.xtbg.pub.util.DictDropDownList"%>
<%@ page import="com.chinacreator.xtbg.pub.util.DaoUtil" %>
<html>
<head>
<%
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	String userid = accesscontroler.getUserID();
	String path = request.getContextPath();
	String flow_id = request.getParameter("flow_id");
	FlowInfoBean flowInfoBean = new FlowInfoBean();
	FlowInfoDao flowInfodao = (FlowInfoDao) DaoImplClassUtil
			.getDaoImplClass("flowInfoDaoImpl");
	if (!StringUtil.nullOrBlank(flow_id)) {
		flowInfoBean = flowInfodao.findFlowBaseInfoById(flow_id);
	}

	FlowDefInfoBean flowDefInfoBean = new FlowDefInfoBean();
	flowDefInfoBean = flowInfodao.findFlowDefInfoByFlowId(flow_id);
	String userArea=CacheCommonManage.getInstance().getSystemParam("CURSYSTEMCODE");
	String sql = "select i.BUSITYPE_CODE, i.BUSITYPE_NAME from TA_OA_BUSI_TYPE i where i.is_valid = 'Y' and i.areacode  = '"+userArea+"'";
	String infotypeHtml = DictDropDownList.buildSelect(sql,
			"busitype_code", StringUtil.deNull(flowInfoBean
					.getBusitype_code()), "", false, "","width:190px");//业务类型下拉框
    String theRootOrgid = DaoUtil.SqlToField("select org_id from td_sm_organization where parent_id='0'");
	String type = request.getParameter("type");
	String openwindid= request.getParameter("operwindowid");
%>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js" ></script>
<script src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript" charset="UTF-8"></script>
<!-- 引入jGrid -->
<script src="../../../resources/plug/jquery.jqGrid-4.3.1/js/i18n/grid.locale-en.js" type="text/javascript" ></script>
<script src="../../../resources/plug/jquery.jqGrid-4.3.1/js/jquery.jqGrid.min.js" type="text/javascript" ></script>
<!-- 引入其它 -->
<script src="../../../resources/js/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../../../resources/plug/JQuery zTree v3.0/js/jquery.ztree.core-3.0.js" ></script>
<script type="text/javascript" src="../../../resources/plug/JQuery zTree v3.0/js/jquery.ztree.excheck-3.0.js" ></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-tree.1.1.js" ></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js" ></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js"></script>
<script type="text/javascript" src="../../flowinfoconfig/resources/js/tree.js" ></script>
<script src="../../../resources/plug/formvalidation/jquery.validationEngine-cn.js" type="text/javascript" ></script>
<script src="../../../resources/plug/formvalidation/jquery.validationEngine.js" type="text/javascript" ></script>
<script type="text/javascript">
var typetemp ='<%=type%>';
var did=null;
var idss=null;
function getmodledown(){
	
	if(did<idss){
		did=did*1+1*1;
	}
	var modelup=jQuery("#flowwfactiongridTable").jqGrid('getRowData', did);
	var aid=modelup.action_id;
	return aid;
}

function showcflow(){
	$("#selectButton").css("display","");
	$("#bindButton").css("display","");
}

function judgeshowcflow(){
	var flowId='<%=StringUtil.deNull(flowInfoBean.getFlow_id())%>';
	if(flowId!=""){
		showcflow();
	}
}
function getmodleup(){
	if(did>1){
		did=did*1-1*1
	};
	var modelup=jQuery("#flowwfactiongridTable").jqGrid('getRowData', did)
	var aid=modelup.action_id;
	return aid;
}

function showAndhide()
{	
	var  typeflag = '<%=type%>';
	if(typeflag == 'flag')
	{
		 $('#saveButton').hide();
		 $('#bindButton').hide();
		 $('#selectButton').hide();
		// $('#restoreButton').hide();
	}
}
//流程定义配置列表
$(function() {
	judgeshowcflow();
	$("#flowdefgridTable").jqGrid({
		url: '<%=path%>' + '/commonListServlet?classNameId=flowDefInfoList',  //commonListServlet列表公共的servlet,classNameId在servletBean.xml文件中配置要调用的类,isPage:是否翻页(true,false),默认为true
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
		colNames: ['流程定义主键', '流程定义ID', '流程ID ', '流程版本 ', '流程包 ', '创建时间 ', '是否生效 ','操作'],
		//字符串数组，用于指定各列的题头文本，与列的顺序是对应的。
		colModel: [ //最重要的数组之一，用于设定各列的参数
		{
			name: 'def_id',
			index: 'def_id',
			hidden: true
		},
		{
			name: 'flow_defid',
			index: 'flow_defid',
			width: 180,
			editable: true
		},
		{
			name: 'flow_id',
			index: 'flow_id',
			width: 50,
			search: true
		},
		{
			name: 'flow_version',
			index: 'flow_version',
			search: true
		},
		{
			name: 'package_id',
			index: 'package_id',
			search: true
		},
		{
			name: 'create_time',
			index: 'create_time'
		},
		{
			name: 'is_valid',
			index: 'is_valid',
			search: true
		},
		{
			name: 'act',
			index: 'act',
			width: '100',
			search: false,
			sortable: false,
			editable: false
		}
		],
		sortname: 'def_id',
		//指定默认的排序列，可以是列名也可以是数字。此参数会在被传递到Server端。
		sortorder: 'desc',
		viewrecords: true,
		
		//设置是否在Pager Bar显示所有记录的总数。
		rowNum: 10,
		//用于设置Grid中一次显示的行数，默认值为20。正是这个选项将参数rows（prmNames中设置的）通过url选项设置的链接传递到Server。注意如果Server返回的数据行数超过了rowNum的设定，则Grid也只显示rowNum设定的行数。
		rowList: [10, 20, 30],
		//一个数组，用于设置Grid可以接受的rowNum值。例如[10,20,30]
		gridComplete: function() { // var idss=jQuery("#gridTable").jqGrid('getColNames');
			// alert(idss);
			var ids = $("#flowdefgridTable").getDataIDs(); //jqGrid('getDataIDs');
			for (var i = 0; i < ids.length; i++) {
				var cl = ids[i];
				
					be = "<input class='but_y_01'onMouseOver=javascript:$(this).attr('class','but_y_02'); onMouseOut=javascript:$(this).attr('class','but_y_01');  type='button'  id='modify' value='启用' onclick='startFlow("+cl+")'>";
				jQuery("#flowdefgridTable").jqGrid('setRowData', ids[i], {
					act: be
				});
			}
		},
		
		jsonReader: { //这又是一个数组，用来设定如何解析从Server端发回来的json数据
			repeatitems: false
		},
		//pager: "#flowdefgridPager",
		pagerintoolbar:true,//上面的分页条
		pagerinBottombar:true,//下面的分页条
		//定义页码控制条Page Bar
		//caption: "流程绑定",
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
		toolbar: [true,"top"],
		multiselect: false,
		ondblClickRow: function(id) {
			
		}
	}).navGrid('#flowdefgridPager', {
		edit: false,
		add: false,
		del: false,
		serach:false,
		refresh:false
	});

	

	$("#t_flowdefgridTable").append("<div>")
	.append("流程绑定")
	//.append("<select id='combobox'><option value='1'>组1</option><option value='2'>组2</option><option value='3'>组3</option></select>")	
	.append("</div>");
		
//流程活动配置列表


$("#flowwfactiongridTable").jqGrid({
	url: '<%=path%>' + '/commonListServlet?classNameId=flowWfactionInfoList',  //commonListServlet列表公共的servlet,classNameId在servletBean.xml文件中配置要调用的类,isPage:是否翻页(true,false),默认为true
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
	colNames: ['活动id', '活动名称', '活动别名 ', '时限单位 ', '活动时限 ', '备注 ', '创建时间 '],
	//字符串数组，用于指定各列的题头文本，与列的顺序是对应的。
	colModel: [ //最重要的数组之一，用于设定各列的参数
	{
		name: 'action_id',
		index: 'action_id',
		hidden: false,
		sortable: false
	},
	{
		name: 'action_name',
		index: 'action_name',
		width: 180,
		editable: true,
		sortable: false
	},
	{
		name: 'action_alias',
		index: 'action_alias',
		width: 230,
		search: true,
		sortable: false
	},
	{
		name: 'limit_unit',
		index: 'limit_unit',
		search: true,
		sortable: false
	},
	{
		name: 'action_limit',
		index: 'action_limit',
		search: true,
		sortable: false
	},
	{
		name: 'remark',
		index: 'remark',
		search: true,
		sortable: false
	},
	{
		name: 'create_time',
		index: 'create_time',
			sortable: false
	}
	],
	sortname: 'action_id',
	//指定默认的排序列，可以是列名也可以是数字。此参数会在被传递到Server端。
	sortorder: 'desc',
	viewrecords: true,
	
	//设置是否在Pager Bar显示所有记录的总数。
	rowNum: 10,
	//用于设置Grid中一次显示的行数，默认值为20。正是这个选项将参数rows（prmNames中设置的）通过url选项设置的链接传递到Server。注意如果Server返回的数据行数超过了rowNum的设定，则Grid也只显示rowNum设定的行数。
	rowList: [10, 20, 30],
	//一个数组，用于设置Grid可以接受的rowNum值。例如[10,20,30]
	jsonReader: { //这又是一个数组，用来设定如何解析从Server端发回来的json数据
		repeatitems: false
	},
	//pager: "#flowwfactiongridPager",
	pagerintoolbar:true,//上面的分页条
	pagerinBottombar:true,//下面的分页条
	//定义页码控制条Page Bar
	//caption: "流程活动列表",
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
	toolbar: [true,"top"],
	multiselect: false,
	onSelectRow : function(id) {
		configActionDetail(id);
	}
}).navGrid('#flowwfactiongridPager', {
	edit: false,
	add: false,
	del: false
	
});

$("#t_flowwfactiongridTable").append("<div>")
.append("流程活动列表")
.append("</div>");

});
/*
	 函数:  toUserParamJosn
	 说明:  构建要查询的参数
	 参数:   无
	 返回值: 返回要查询的参数
	 */
var toUserParamJosn = function() {
	var str = "{'flow_id':'"+$('#flow_id').val()+"'}";
	return descape(str);
}

var refreshGrid4FlowInfo = function() {
	var sdata = { //构建查询需要的参数 
			paramJson: toUserParamJosn()
		}; //获得当前postData选项的值  
		var postData = $("#flowdefgridTable").jqGrid("getGridParam", "postData"); //将查询参数融入postData选项对象  
		$.extend(postData, sdata);
		$("#flowdefgridTable").jqGrid("setGridParam", {
			search: true // 将jqGrid的search选项设为true  
		}).trigger("reloadGrid", [{
			page: 1
		}]); //重新载入Grid表格，以使上述设置生效 
	var sdata1 = { //构建查询需要的参数 
			paramJson: toUserParamJosn()
		}; //获得当前postData选项的值  
		var postData1 = $("#flowwfactiongridTable").jqGrid("getGridParam", "postData"); //将查询参数融入postData选项对象  
		$.extend(postData1, sdata1);
		$("#flowwfactiongridTable").jqGrid("setGridParam", {
			search: true // 将jqGrid的search选项设为true  
		}).trigger("reloadGrid", [{
			page: 1
		}]); //重新载入Grid表格，以使上述设置生效 
}

var refreshGrid4WfactionInfo = function() {
	var sdata = { //构建查询需要的参数 
			paramJson: toUserParamJosn()
		}; //获得当前postData选项的值  
		var postData = $("#flowwfactiongridTable").jqGrid("getGridParam", "postData"); //将查询参数融入postData选项对象  
		$.extend(postData, sdata);
		$("#flowwfactiongridTable").jqGrid("setGridParam", {
			search: true // 将jqGrid的search选项设为true  
		}).trigger("reloadGrid", [{
			page: 1
		}]); //重新载入Grid表格，以使上述设置生效
}

var refreshFlowInfo = function(version,packageId,flowdefId){
    $("#flow_version").val(version);
    $("#package_id").val(packageId);
    $("#flow_defid").val(flowdefId);
}

var saveFlowBaseInfo = function() {
	var jsonparam = "{'flow_id':'"+$('#flow_id').val()+"','flow_name':'"+$("#flow_name").val()+"',"+
					"'busitype_code':'"+$('#busitype_code').val()+"','flow_limit':'"+$('#flow_limit').val()+"',"+
					"'limit_unit':'"+$('#limit_unit').val()
					+"','org_id':'"+$('#org_id').val()
					+"','is_valid':'"+$('#is_valid').val()
					+"','is_public':'"+$('#is_public').val()+"'}";
	$("#jsonparam").val(descape(escape(jsonparam)));
	var fm = document.getElementById("form1");
	fm.action = "flowconfigaddorupdateform.jsp?openwindid=<%=openwindid%>";
	fm.target = "hiddenFrame";
	$('#form1').submit();
}

var init = function() {
	showAndhide();
	setSelectValue("busitype_code","<%=flowInfoBean.getBusitype_code()%>");
	setSelectValue("limit_unit","<%=flowInfoBean.getLimit_unit()%>");
	var isvalid="<%=flowInfoBean.getIs_valid()%>";
	$("#is_public option[value='<%=flowInfoBean.getIs_public()%>']").attr("selected","selected");
	if(isvalid=="Y"){
		$('input:radio[value="Y"]').attr("checked",true);
	}else if(isvalid=="N"){
		$('input:radio[value="N"]').attr("checked",true);
	}

}

var startFlow = function(id) {
	var model = jQuery("#flowdefgridTable").jqGrid('getRowData', id);

	if(model.is_valid == "是"){
		alert("此流程已启用");
		return false;
	}
    var processId = model.def_id;
    var flow_id = model.flow_id;
    var is_valid = model.flow_version；
    var jsonparam = "{'flow_id':'"+flow_id+"','def_id':'"+processId+"'}";
        
    var url = "flowinfobangdingform.jsp?type=userflowinfo&def_id="+processId;
    $("#jsonparam").val(descape(escape(jsonparam)));
    document.all.form1.action = url;
    document.all.form1.target = "hiddenFrame";
    $('#form1').submit();
}

var chooseWorkFlow = function(){
	try{
    var url = "../../../../../jawe/jawe_tree/jaweTree.jsp";

    var wfInfo= window.showModalDialog(url,"","dialogWidth=700px;dialogHeight=600px;center:yes");
    var packageId=wfInfo.split("%23")[0];
    var version=wfInfo.split("%23")[1];
    var flowdefId=wfInfo.split("%23")[2];

    $("#flow_version").val(version);
    $("#package_id").val(packageId);
    $("#flow_defid").val(flowdefId);
	}catch(error){}
}


var saveFlowInfo = function(){
    var flowInfo=$("#flow_defid").val();
    if(IsSpace(flowInfo)){
        alert("请选择发布的流程信息");
        return;
    }
    var packageId=$("#package_id").val();
    var version=$("#flow_version").val();
    var flowdefId=$("#flow_defid").val();
    var flow_id = $('#flow_id').val();

    var jsonparam = "{'flow_id':'"+flow_id+"','package_id':'"+packageId+"',"+
    				"'flow_version':'"+version+"','flow_defid':'"+flowdefId+"'}";
        
    var url = "flowinfobangdingform.jsp?type=saveflowinfo";
    $("#jsonparam").val(descape(escape(jsonparam)));
    document.all.form1.action = url;
    document.all.form1.target = "hiddenFrame";
    $('#form1').submit();
}

var extendsflowversion = function(oldFlowId,newFlowId){
    var url = "flowinfobangdingform.jsp?type=extendsflowversion&old_flow_id="+oldFlowId+"&new_flow_id="+newFlowId;
    document.all.form1.action = url;
    document.all.form1.target = "hiddenFrame";
    $('#form1').submit();
}
//actionconfigdetail.jsp参数
var configActionDetail = function(id){
	did=id;
	idss = $("#flowwfactiongridTable").getGridParam("records");
	var model = jQuery("#flowwfactiongridTable").jqGrid('getRowData', id);
	//alert(model.action_id);
	//JqueryDialog.Open1('配置环节', 'actionconfigdetail.jsp?action_id=' + model.action_id, 800, 480, false, false, true);
	//JqueryDialog.BeforeCloseFunction = refreshGrid4WfactionInfo;
	//flowinfoconfig/jsp
	var url ='../../flowinfoconfig/jsp/actionconfigdetail.jsp?action_id='+model.action_id+'&type=<%=type%>';
	//alert(url);
	openAlertWindows('windowId',url,'配置环节','810','480','20%');
	
}
/* 保存成功后返回方法-子页面调用 */
function saveBack(){
	removeWindows('<%=openwindid%>',false);
}


var setFlowIdAfterSave = function (flowid){
	$('#flow_id').val(flowid);
}

//选择机构
var chooseOrg = function (){
	var s = new $.z_tree();
	  s.treeID='mian';
	  s.treetypestr='radio';
	  s.isShowSeacher=true;
	  s.treeName="选取单位";
	  s.isType='dept';
	  s.headerName="选取单位";
	  s.item_id = 'org_id';
	  s.selectedIds=$('#org_id').val();
	  s.type='AORG';
	  s.returnFunction=function(orgObj){
		  if(!IsSpace(orgObj)){
				 $('#org_id').val(orgObj.id);
				 $('#org_name').val(orgObj.name);
			 }else{
				 $('#org_id').val("");
				 $('#org_name').val("");
			 }

		 }
	  s.init();
}

function backparent(){
	var typeflag = '<%=type%>'
	if(typeflag == 'flag')
	{
		var url="flowinfoconfiguserlist.jsp";
		location.href=url;
	}else
	{
		var url="flowinfoconfiglist.jsp";
		location.href=url;
	}
}

</script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>流程信息配置详细表单</title>
</head>
<body onLoad="init();adaptationWH('_top','vcenter',15)" style="overflow-y:hidden;">
<form id="form1" name="form1" method="post" class="formular">
<div  class="content_02" style="overflow:hidden;" >
 <div class="content_02_top" style="margin-bottom:10px;" id="_top">
 		<input id="saveButton" name="saveButton" type="button" class="but_y_01" value="保存" onClick="saveFlowBaseInfo();" />
		<input id="selectButton" name="selectButton" class="but_y_01" type="button" value="选择流程" style="display: none" onClick="chooseWorkFlow()" />
		<input id="bindButton" name="bindButton" class="but_y_01" type="button"value="绑定" style="display: none" onClick="saveFlowInfo()" />
		<input name="restoreButton" type="button" class="but_y_01" value="返回" onclick="backparent()" />
</div>
<div id="vcenter" style="float:left; width:100%; overflow:scroll;overflow-x:hidden;" scrolling="yes">
<div style="float: left; width: 775px; "> 
<div class="content_02_box" >
<div class="content_02_box_title_bg"><span>基本信息</span></div>
<div class="content_02_box_div">
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="content_02_box_div_table_02" >
	<tr>
		<th class="content_02_box_div_table_th"><span style="color: red">*</span>流程名称：</th>
		<td class="content_02_box_div_table_td"><input type="text" name="flow_name" id="flow_name"
			class="input_185"
			value="<%=StringUtil.deNull(flowInfoBean.getFlow_name())%>">
		</td>
		<th class="content_02_box_div_table_th">业务类型：</th>
		<td class="content_02_box_div_table_td"><%=infotypeHtml%></td>
	</tr>
	<tr>
		<th class="content_02_box_div_table_th">流程定义ID：</th>
		<td class="content_02_box_div_table_td"><input class="input_185"
			type="text" disabled="disabled" readonly="readonly"
			value="<%=StringUtil.deNull(flowDefInfoBean.getFlow_defid())%>"
			id="flow_defid" name="flow_defid"/>
			</td>
		<th class="content_02_box_div_table_th">流程版本：</th>
		<td class="content_02_box_div_table_td"><input class="input_185"
			type="text" readonly="readonly"  disabled="disabled" 
			value="<%=StringUtil.deNull(flowDefInfoBean
									.getFlow_version())%>"
			id="flow_version" name="flow_version"/>
			</td>
	</tr>
	<tr>
		<th class="content_02_box_div_table_th"><span style="color: red">*</span>流程期限：</th>
		<td class="content_02_box_div_table_td" ><input class="input_155"
			 type="text"
			value="<%=StringUtil.deNull(flowInfoBean.getFlow_limit())%>"
			id="flow_limit" name="flow_limit"/> 
			<select id="limit_unit" style="height: 20px"
			name="limit_unit">
			<option value="D">日</option>
			<option value="H">小时</option>
		</select></td>
		<th class="content_02_box_div_table_th">流程包ID：</th>
		<td class="content_02_box_div_table_td"><input class="input_185"
			 type="text" readonly="readonly"  disabled="disabled"
			value="<%=StringUtil.deNull(flowDefInfoBean.getPackage_id())%>"
			id="package_id" name="package_id"/>
			</td>
	</tr>

	<tr>
		<th class="content_02_box_div_table_th"><span style="color: red">*</span>所属机构：</th>
		<td class="content_02_box_div_table_td">
			<div style="float: left;">
			<INPUT
				class="input_160"
				onmouseover="this.title=this.value" id="org_name" name="org_name"
				value="<%=StringUtil.deNull(flowInfoBean.getOrg_name())%>" readOnly
				onclick='chooseOrg()'> 
				 </div>
				 <div style="float: left;">
					<input name="" type="button"
					value="" class="but_x" onclick="chooseOrg()" /> 
				</div>
		  
				<input
				type="hidden" id=org_id name=org_id
				value="<%=StringUtil.deNull(flowInfoBean.getOrg_id())%>" />
			
	   </td>
		<th class="content_02_box_div_table_th">是否有效：</th>
		<td class="content_02_box_div_table_td">
		<select id="is_valid" style="width: 186px"
			name="is_valid">
			<option value="Y">是</option>
			<option value="N">否</option>
		</select>
			 <input id="flow_id"
			name="flow_id" type="hidden"
			value="<%=StringUtil.deNull(flowInfoBean.getFlow_id())%>"
			class="cText_out" readonly="readonly" disabled="disabled" /></td>
	</tr>
	<tr>
		<th class="content_02_box_div_table_th">是否为公共流程：</th>
		<td class="content_02_box_div_table_td" colspan="3">
		<select id="is_public" style="width: 186px"
			name="is_public">
			<option value="Y">是</option>
			<option value="N">否</option>
		</select>
	</td>
	</tr>
</table>
</div>
</div>


<table>
	<tr>
		<td height="10px"></td>
	</tr>
</table>
<div class="content_02_box_div_special"><!-- 查询列表区 cGridArea(查询区样式)-->
<div class="cGridArea">
<table id="flowdefgridTable"></table>
<div id="flowdefgridPager"></div>
</div>
</div>

<table>
	<tr>
		<td height="10px"></td>
	</tr>
</table>
<div class="content_02_box_div_special"><!-- 查询列表区 --> <!-- 查询列表区 cGridArea(查询区样式)-->
<div class="cGridArea">
<table id="flowwfactiongridTable"></table>
<div id="flowwfactiongridPager"></div>
</div>
<!-- 查询列表区 -->
</div>
<p>&nbsp;</p>
<input id="jsonparam" name="jsonparam" type="hidden"/>
</div>
</div>
</div>
</form>
<iframe name="hiddenFrame" width=0 height=0/>

</body>
</html>
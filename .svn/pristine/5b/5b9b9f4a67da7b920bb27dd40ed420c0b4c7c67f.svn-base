<%@page import="com.chinacreator.xtbg.tjy.processing.constant.ProFlowBusiConstant"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DaoUtil"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.OASystemCache"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.UserCache"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
 	//获得当前登录的用户信息
	String userId = accesscontroler.getUserID();
	String userName = accesscontroler.getUserName();
	//获得当前登录用户所属单位信息
	UserCacheBean usercachebean=UserCache.getUserCacheBean(userId);
	String unit_id = usercachebean.getUnit_id();
	String unit_name = usercachebean.getUnit_name();
	String loginUserName = accesscontroler.getUserAccount();
	//流程业务类型
	String busitype_codes = request.getParameter("busitype_codes");
	String sql = "select i.busitype_code, i.busitype_name from OA_FLOW_BUSITYPE i where i.is_valid = 'Y'  and i.busitype_code in('"+busitype_codes+"') ";
	String str = DictDropDownList.buildSelect(sql,"busitype_code","","",true,"");
	
	//从配置文件中得到办件历史是否显示列表形式
	String alllist =StringUtil.deNull(OASystemCache.getContextProperty("doneworklist"));
	String document_recordid = StringUtil.deNull(request.getParameter("document_recordid"));
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="com.chinacreator.xtbg.core.common.util.DictDropDownList"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<!-- 引入jQuery -->
<script type="text/javascript" src="<%=path%>/ccapp/oa/resources/plug/jquery1.7/jquery-1.7.1.min.js"></script>

<script src="<%=path%>/ccapp/oa/resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>
<!-- 引入my97时间控件 -->
<script src="<%=path%>/ccapp/oa/resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<script type="text/javascript" src="<%=path%>/ccapp/oa/resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<!-- 引入jGrid -->
<script src="<%=path%>/ccapp/oa/resources/plug/jquery.jqGrid-4.3.1/js/i18n/grid.locale-en.js" type="text/javascript"></script>
<script src="<%=path%>/ccapp/oa/resources/plug/jquery.jqGrid-4.3.1/js/jquery.jqGrid.min.js" type="text/javascript"></script>

<!-- 引入其它 -->
<script src="<%=path%>/ccapp/oa/resources/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="<%=path%>/ccapp/oa/resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<title>已办列表</title>
<script type="text/javascript">
var loginUserName = '<%=loginUserName%>';
$(function() {
	var _documentBodyHeight = window.top.findPageCacheName("_documentBodyHeight");
	var width=jQuery(window).width();
	if(width<800){
		jQuery("#maindiv").width(775);
	}
	$(document).keydown(function(){
		if(event.keyCode == 13){ 
			userSearch();
		}
	});
	$("#gridTable").jqGrid({
		url: '<%= path %>' + '/pubListServlet?classNameId=com.chinacreator.xtbg.tjy.detectionsupplies.list.PlandoneDeWorkList',  //pubListServlet列表公共的servlet,classNameId在servletBean.xml文件中配置要调用的类,isPage:是否翻页(true,false),默认为true
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
		colNames: ['','实例id','业务id','表单','办件编号 ', '标题  ','申购部室','业务类别','业务类型 ', '申请人 ', '申请起止时间 ', '当前环节 ',
		            <%if("uuid_5201".equals(busitype_codes)){%> 
		          	 '审批状态',
		         	<%}%>
		           '状态', '办件历史 ', 'busitype_code', 'act_index','环节实例ID','流程ID','模板ID','流程定义ID'],
		//字符串数组，用于指定各列的题头文本，与列的顺序是对应的。
		colModel: [ //最重要的数组之一，用于设定各列的参数
        {
   			name: 'rr',
   			index: 'rr',
   			width: 8
       	},
		            {
      			name: 'ins_id',
      			index: 'ins_id',
      			hidden: true
       	},
    	{
   			name: 'busi_id',
   			index: 'busi_id',
   			hidden: true
    	},
    	{
   			name: 'action_form',
   			index: 'action_form',
   			hidden: true
    	},
		{
			name: 'ins_code',
			index: 'ins_code',
			width: 90,
			hidden: true
		},
		{
			name: 'ins_name',
			index: 'ins_name',
			width: 100,
			editable: true
		},
		{
			name: 'org_name',
			index: 'orgname',
			width: 100,
			editable: true
		},
		{
			name: 'busitype_type_name',
			index: 'busitype_type_name',
			width: 100,
			hidden: true
		},
		{
			name: 'busitype_name',
			index: 'busitype_name',
			width: 100,
			hidden: true
		},
		{
			name: 'accepter',
			index: 'accepter',
			width: 50,
			search: true
		},
		{
			name: 'accept_time',
			index: 'accept_time',
			width: 80,
			search: true
		},
		{
			name: 'act_name',
			index: 'action_name',
			width: 40,
			search: true
		},
		<%if("uuid_5201".equals(busitype_codes)){%> 
			{
				name: 'planStatus',
				index: 'planStatus',
				width: 40,
				search: true,
				hidden:true
			},
		<%}%>
		{
			name: 'status_name',
			index: 'status_name',
			width: 40,
			search: true
		},
		{
			name: 'act',
			index: 'act',
			width: 100,
			search: false,
			sortable: false,
			editable: false
		},
		{
  			name: 'busitype_code',
  			index: 'busitype_code',
  			hidden: true
   		},
   		{
  			name: 'act_index',
  			index: 'act_index',
  			hidden: true
   		},
   		{
  			name: 'act_insid',
  			index: 'act_insid',
  			hidden: true
   		},
   		{
  			name: 'flow_id',
  			index: 'flow_id',
  			hidden: true
   		},
	   	{
	   		name: 'template_id',
   			index: 'template_id',
   			hidden: true
	   	},
	   	{
	   		name: 'def_id',
   			index: 'def_id',
   			hidden: true
	   	}
		],
		sortname: 'accept_time',
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
			var ids = $("#gridTable").getDataIDs(); //jqGrid('getDataIDs');
			for (var i = 0; i < ids.length; i++) {
				var cl = ids[i];
				var model = jQuery("#gridTable").jqGrid('getRowData', cl);
				be = "<input id='modify' type='button' class='but_y_01' onMouseOver=javascript:$(this).attr('class','but_y_02'); onMouseOut=javascript:$(this).attr('class','but_y_01'); onclick='showFlowHistory("+cl+")' value = '办件历史' />";
				b1 = "<input type='radio'  name='r1' />";
				//recoverBut = "<input id='recover' type='button' class='but_y_01' onMouseOver=javascript:$(this).attr('class','but_y_02'); onMouseOut=javascript:$(this).attr('class','but_y_01'); onclick='getbackFlow("+cl+")' value = '追回' />"
				/* if(model.act_index == '1') {
					be = recoverBut + be;
				} */
				jQuery("#gridTable").jqGrid('setRowData', ids[i], {
					act: be,
					rr: b1
				});
			}
		},
		
		jsonReader: { //这又是一个数组，用来设定如何解析从Server端发回来的json数据
			repeatitems: false
		},
		//pager: "#gridPager",
		pagerintoolbar:true,//上面的分页条
		pagerinBottombar:true,//下面的分页条
		//定义页码控制条Page Bar
		//caption: "已办列表",
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
		//申购计划查询
		<% if("uuid_5201".equals(busitype_codes)){%>
			toolbar: [true,"top","<input type='button' class='but_y_01' title='打印' onMouseOver=javascript:$(this).attr('class','but_y_02'); onMouseOut=javascript:$(this).attr('class','but_y_01');  value='打印' onclick='exportSgFile()' style='margin-left:5px;'/>"],
		//申购审批查询
		<% } else if("uuid_5211".equals(busitype_codes)){%>
			toolbar: [true,"top","<input type='button' class='but_y_01' title='打印' onMouseOver=javascript:$(this).attr('class','but_y_02'); onMouseOut=javascript:$(this).attr('class','but_y_01');  value='打印' onclick='exportSgSPFile()' style='margin-left:5px;'/>"],	
		//易耗领用查询
		<%} else if("uuid_6201".equals(busitype_codes)){%>
			toolbar: [true,"top","<input type='button' class='but_y_01' title='打印' onMouseOver=javascript:$(this).attr('class','but_y_02'); onMouseOut=javascript:$(this).attr('class','but_y_01');  value='打印' onclick='exportLysqFile()' style='margin-left:5px;'/>"],
		//固定资产查询
		<%} else if("uuid_6211".equals(busitype_codes)){%>
			toolbar: [true,"top","<input type='button' class='but_y_01' title='打印' onMouseOver=javascript:$(this).attr('class','but_y_02'); onMouseOut=javascript:$(this).attr('class','but_y_01');  value='打印' onclick='exportGdZcFile()' style='margin-left:5px;'/>"],
		<%} else{%>
			toolbar: [true,"top",""],
		<%}%>
		multiselect: false,
		onSelectRow: function(id) {
			handle(id);
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
	paramJson: descape(escape("{'username':'"+loginUserName+"'}"))
};
var postData = $("#gridTable").jqGrid("getGridParam", "postData");
$.extend(postData, sdata); //将postData中的查询参数覆盖为空值  
$("#gridTable").jqGrid("setGridParam", {
	search: true // 将jqGrid的search选项设为false  
}).trigger("reloadGrid", [{
	page: 1
}]);
resetSingleSearchDialog();
};

	/*
	 函数:  toUserParamJosn
	 说明:  构建要查询的参数
	 参数:   无
	 返回值: 返回要查询的参数
	 */
var toUserParamJosn = function() {
	
	var  busitype_code =$('#busitype_code').val();
		if(busitype_code==''){
			busitype_code = "<%=busitype_codes%>";
	}
	var str = "{'username':'"+loginUserName+"',"+
			  "'busitype_code':'"+busitype_code+"',"+
			  "'org_name':'"+$('#org_name').val()+"',"+
			  "'ins_name':'"+$('#ins_name').val()+
			  "','startSlTime':'"+$('#startSlTime').val()+
			  "','endSlTime':'"+$('#endSlTime').val()+"','userId':'<%=userId%>'}";
				return descape(escape(str));
}

/*
函数:  resetSingleSearchDialog
说明:  清空值查询值
参数:   无
返回值: 无
*/
var resetSingleSearchDialog = function() { //$("radio","#singleSearchDialog").attr("checked", false);  
$(":text", "#queryTable").val("");
$("select:first option:first").attr("selected","selected");
};

var showFlowHistory = function(id) {
	var alllist='<%=alllist%>';
	var model = jQuery("#gridTable").jqGrid('getRowData', id);
	if('alllist'==alllist){
		
		var path ="<%=path%>/ccapp/oa/archive/findlslist.jsp?windowsId=windowIds&ins_id="+model.ins_id;
		openAlertWindows('windowIds',path,'查看历史',810,400,'25%','25%');
	}else{
		var url = "<%=path%>/ccapp/oa/process/flowprocessing/jsp/showflowhistorytiaozhuan.jsp?insid="+model.ins_id;
		var winwidth=(screen.width - 920)/2;
		var winheight=(screen.height - 700)/2-30;
		var freatrues = "height=700,width=920,top="+winheight+"px,left="+winwidth+"px,status=yes,toolbar=no,menubar=no,location=no";
		window.open(url,"",freatrues ); 
	}
}

function handle(id){ 
    var model = jQuery("#gridTable").jqGrid('getRowData', id);
    var url = '<%=path %>' + model.action_form + "?ins_id="+model.ins_id+"&busi_id="+model.busi_id+"&list_type=worklis&operType=yiban&act_name="+model.act_name+"&actiontype_code=04&busiTypeCode="+model.busitype_code
  			  +"&template_id="+model.template_id+"&Template=word"+model.template_id;
   	openForms(url, model.ins_name);//父页面调用打开窗口	
    //window.parent.location = url,"perspective_content";
}

//打开页面
function openForms(url, flowname){
	var width = jQuery(window.top).width();//界面宽度
	var height = jQuery(window.top).height();//界面高度
	
	url= url+"&height="+height;
	url= url+"&width="+width;
	url= url+"&windowsId=newwindows&document_recordid=<%=document_recordid%>"
	//弹出款TOP下移，空出标签页及以上位置，165为TOP图片高度，暂时写死，应该是根据TOP的页面高度去动态获取
	openAlertWindows('newwindows',url,flowname,width,height-86,86,'0%','','',true);
}

/*
函数:  getbackFlow
说明:  追回
参数:   无
返回值: 无
*/
function getbackFlow(id){
	var model = jQuery("#gridTable").jqGrid('getRowData', id);
	var _actInsid = model.act_insid;
	var _ins_id = model.ins_id;
	var _flow_id = model.flow_id;
	var _action_form = model.action_form;
	var _def_id = model.def_id;
	var url = "getbackflowajax.jsp";
	params = {actInsId:_actInsid,ins_id:_ins_id,flow_id:_flow_id,action_form:_action_form,def_id:_def_id};

	$.ajax({
		url: url,
		type: 'POST',
		dataType: 'json',
		data: params,
		success: function(data){
				alert("追回成功！");
				userSearch();
		},
		error: function(jqXHR, textStatus, errorThrown){
			alert(jqXHR);
			alert(textStatus);
			alert(errorThrown);
		}
	});
}

/**
 * 打印物品申购计划表
 */
function exportSgFile(){
	var ids = "";
    var j = -1;
    var ids = jQuery("#gridTable").getDataIDs(); //jqGrid('getDataIDs');
    jQuery("input[name=r1]").each(function(i,e){
		if(jQuery(this).is(":checked")){
			j = i;
		}
	})
	var model = jQuery("#gridTable").jqGrid('getRowData',
			ids[j]);
	
	ids = model.busi_id;
	//var
	if (IsSpace(ids)) {
	    alert("请选择要打印的申购计划信息！");
	} 
	else{
		var url = "${pageContext.request.contextPath}/ccapp/oa/resources/util/excel/ajaxexcel.jsp";
	    var html = new Array();
	    html.push("<div id='export_excel'>");
	    html.push('<iframe id="hiddenFrame"  name="hiddenFrame" width=0 height=0></iframe>');
	    html.push('<form id="downFrom" name="downFrom" method="post" action="'+url+'" target="hiddenFrame">');
	    html.push("<input type='hidden' name='busi_id' value='"+ids+"' /> ");
	    html.push("<input type='hidden' name='excelname' value='申购计划信息' /> ");//导出的主题
	    html.push("<input type='hidden' name='excelImplClass' value='osapplandaoexcelimpl1' /> ");//导入导出的实现类，要提前在spring中或orcleConfig中配置好
	    html.push("<input type='hidden' name='excelTemplateFilePath' value='jchcsgjh_excelTemplateFilePath' /> ");//导出的excel模版路径，要提前在系统properties中配置好
	    html.push('</form>');
	    html.push("</div>");
	    //加载到body，提交后再删除
	    jQuery(html.join("")).appendTo("body");
	    jQuery("#downFrom").submit();
	    jQuery("#export_excel").remove();
	}
}

/**
 * 物品申购审批表
 */
function exportSgSPFile(){
	var ids = "";
    var j = -1;
    var ids = jQuery("#gridTable").getDataIDs(); //jqGrid('getDataIDs');
    jQuery("input[name=r1]").each(function(i,e){
		if(jQuery(this).is(":checked")){
			j = i;
		}
	})
	var model = jQuery("#gridTable").jqGrid('getRowData',
			ids[j]);
	
	ids = model.busi_id;
	//var
	if (IsSpace(ids)) {
	    alert("请选择要打印的物品申购审批表信息！");
	} 
	else{
		var url = "${pageContext.request.contextPath}/ccapp/oa/resources/util/excel/ajaxexcel.jsp";
	    var html = new Array();
	    html.push("<div id='export_excel'>");
	    html.push('<iframe id="hiddenFrame"  name="hiddenFrame" width=0 height=0></iframe>');
	    html.push('<form id="downFrom" name="downFrom" method="post" action="'+url+'" target="hiddenFrame">');
	    html.push("<input type='hidden' name='busi_id' value='"+ids+"' /> ");
	    html.push("<input type='hidden' name='excelname' value='申购审批信息' /> ");//导出的主题
	    html.push("<input type='hidden' name='excelImplClass' value='osexaminationdaoexcelimp1' /> ");//导入导出的实现类，要提前在spring中或orcleConfig中配置好
	    html.push("<input type='hidden' name='excelTemplateFilePath' value='jchcsgspjh_excelTemplateFilePath' /> ");//导出的excel模版路径，要提前在系统properties中配置好
	    html.push('</form>');
	    html.push("</div>");
	    //加载到body，提交后再删除
	    jQuery(html.join("")).appendTo("body");
	    jQuery("#downFrom").submit();
	    jQuery("#export_excel").remove();
	}
}

/**
 * 打印易耗品领用登记表
 */
function exportLysqFile(){
	var ids = "";
    var j = -1;
    var ids = jQuery("#gridTable").getDataIDs(); //jqGrid('getDataIDs');
    jQuery("input[name=r1]").each(function(i,e){
		if(jQuery(this).is(":checked")){
			j = i;
		}
	})
	var model = jQuery("#gridTable").jqGrid('getRowData',
			ids[j]);
	
	ids = model.busi_id;
	//var
	if (IsSpace(ids)) {
	    alert("请选择要打印的领用申请信息！");
	} 
	else{
		var url = "${pageContext.request.contextPath}/ccapp/oa/resources/util/excel/ajaxexcel.jsp";
	    var html = new Array();
	    html.push("<div id='export_excel'>");
	    html.push('<iframe id="hiddenFrame"  name="hiddenFrame" width=0 height=0></iframe>');
	    html.push('<form id="downFrom" name="downFrom" method="post" action="'+url+'" target="hiddenFrame">');
	    html.push("<input type='hidden' name='excelname' value='领用申请信息' /> ");//导出的主题
	    html.push("<input type='hidden' name='busi_id' value='"+ids+"' /> ");
	    html.push("<input type='hidden' name='excelImplClass' value='oshavalydaoexcelimpl1' /> ");//导入导出的实现类，要提前在spring中或orcleConfig中配置好
	    html.push("<input type='hidden' name='excelTemplateFilePath' value='jchclydj_excelTemplateFilePath' /> ");//导出的excel模版路径，要提前在系统properties中配置好
	    html.push('</form>');
	    html.push("</div>");
	    //加载到body，提交后再删除
	    jQuery(html.join("")).appendTo("body");
	    jQuery("#downFrom").submit();
	    jQuery("#export_excel").remove();
	}
}

/**
 * 打印固定资产领用审批表
 */
var exportGdZcFile= function(){
	var ids = "";
    var j = -1;
    var ids = jQuery("#gridTable").getDataIDs(); //jqGrid('getDataIDs');
    jQuery("input[name=r1]").each(function(i,e){
		if(jQuery(this).is(":checked")){
			j = i;
		}
	})
	var model = jQuery("#gridTable").jqGrid('getRowData',
			ids[j]);
	
	ids = model.busi_id;
	//var
	if (IsSpace(ids)) {
	    alert("请选择要打印的固定资产领用审批信息！");
	} 
	else{
		var url = "${pageContext.request.contextPath}/ccapp/oa/resources/util/excel/ajaxexcel.jsp";
	    var html = new Array();
	    html.push("<div id='export_excel'>");
	    html.push('<iframe id="hiddenFrame"  name="hiddenFrame" width=0 height=0></iframe>');
	    html.push('<form id="downFrom" name="downFrom" method="post" action="'+url+'" target="hiddenFrame">');
	    html.push("<input type='hidden' name='excelname' value='固定资产领用审批信息' /> ");//导出的主题
	    html.push("<input type='hidden' name='busi_id' value='"+ids+"' /> ");
	    html.push("<input type='hidden' name='excelImplClass' value='osnomovedaoexceelimpl1' /> ");//导入导出的实现类，要提前在spring中或orcleConfig中配置好
	    html.push("<input type='hidden' name='excelTemplateFilePath' value='jchcgdzcly_excelTemplateFilePath' /> ");//导出的excel模版路径，要提前在系统properties中配置好
	    html.push('</form>');
	    html.push("</div>");
	    //加载到body，提交后再删除
	    jQuery(html.join("")).appendTo("body");
	    jQuery("#downFrom").submit();
	    jQuery("#export_excel").remove();
	}
}
</script>
</head>
<body>
<table width="100%">
	<tr>
		<td>
						
			<!-- 查询条件选区    tabs_search_ctable(查询table样式) -->
			<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tabs_search_ctable_box" >
				<tr>
					<td>
						<!-- 固定查询 -->
						<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tabs_search_ctable">
							<tr>
								<th class="input_cx_title_th">标题：</th>
								<td width="385" class="cx_title_td"><input id="ins_name" name="ins_name" type="text" class="input_cx_title_283" /></td>
								<td width="385"  colspan="2"  ><input name="Input2" value="搜索" type="button" onclick="userSearch()" class="but_y_01"/>
								<span id="selAreaImg" class="all_search_condition"><a onclick="hiddenOrShowSelArea('hiddenArea','selAreaImg')" >更多搜索条件</a></span></td>
							</tr>
						</table>
						<!-- 固定查询 end-->
					</td>
					</tr>
					  
					<tr>
					<td>
					
						<!-- 隐藏查询 -->
						<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tabs_search_ctable" id="hiddenArea" style="display:none">
							<!-- 正规 4列 -->
							<tr>
								<th class="input_cx_title_th">申请起止时间：</th>
								<td  class="cx_title_td">
								<input id="startSlTime" name="startSlTime" type="text" class="date_120"　
								onFocus="var input_endtime=$dp.$('endSlTime');WdatePicker({onpicked:function(){endSlTime.focus();},dateFmt:'yyyy-MM-dd '})"   /> 
								<span class="date_120_span">至</span>
								 <input id="endSlTime" name="endSlTime" type="text"  class="date_120" 
								 onfocus="WdatePicker({minDate:'#F{$dp.$D(\'startSlTime\')}',dateFmt:'yyyy-MM-dd '})" />
								</td>
								<th class="input_cx_title_th" style="display: none;">业务类型：</th>
								<td  class="cx_title_td" style="display: none;">
								<%=str %>
								</td>
								<th class="input_cx_title_th" style="display: none;">业务类型：</th>
								<td  class="cx_title_td" style="display: none;">
								<%=str %>
								</td>
							</tr>
							<tr>
								<th class="input_cx_title_th">申购部室：</th>
								<td  class="cx_title_td">
									<input id="org_name" name="org_name" type="text" class="input_cx_title_283" 　/> 
								</td>
							</tr>
						</table>
						<!-- 隐藏查询 end-->
						
					</td>
				</tr>
			</table>
		<!-- 查询条件选区    tabs_search_ctable(查询table样式) -->
						
		</td>
		</tr>
		<tr>
		<td>
		<!-- 查询列表区 cGridArea(查询区样式)-->
		<div class="cGridArea" id="maindiv">
		<table id="gridTable"></table>
		<div id="gridPager"></div>
		</div>
				<!-- 查询列表区 -->
		</td>
	</tr>
		
</table>
</body>
</html>
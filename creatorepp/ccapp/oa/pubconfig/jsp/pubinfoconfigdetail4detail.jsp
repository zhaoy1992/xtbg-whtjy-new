<%-- 
描述：业务类型详细和环节界面
作者：肖杰
版本：1.0
日期：2013-07-30
 --%>
<%@page import="com.chinacreator.xtbg.core.pubconfig.service.impl.FormBusitypeServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.pubconfig.service.FormBusitypeServiceIfc"%>
<%@page import="com.chinacreator.xtbg.core.pubconfig.entity.FormBusitypebean"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">


<%@page
    import="com.chinacreator.xtbg.core.process.processconfig.entity.*"%>
<%@page
    import="com.chinacreator.xtbg.core.common.startup.LoadSpringContext"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DaoUtil"%>
<%@page
    import="com.chinacreator.security.AccessControl,com.frameworkset.common.poolman.DBUtil"%>
<%@page import="com.chinacreator.xtbg.core.common.commonlist.Constant"%>
<%@page import="java.util.*"%>

<html>
<head>
<%
    AccessControl accesscontroler = AccessControl.getAccessControl();
    accesscontroler.checkAccess(request, response);
    String userid = accesscontroler.getUserID();
    String path = request.getContextPath();
    String busitype_code =StringUtil.deNull(request.getParameter("busitype_code"));
    FormBusitypebean fbb = new FormBusitypebean();

    FormBusitypeServiceIfc fbs=new FormBusitypeServiceImpl();
	if(!StringUtil.isBlank(busitype_code)){
		fbb=fbs.findFormBusitypeInfoById(busitype_code);
	}

    String type =StringUtil.deNull(request.getParameter("type"));
    String openwindid = request.getParameter("operwindowid");


        
%>
<!-- 引入jQuery -->
<script type="text/javascript"
    src="../../resources/plug/jquery1.7/jquery-1.7.1.min.js"></script>
<script
    src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js"
    type="text/javascript"></script>
    
    <script
    src="../../resources/plug/formvalidation/jquery.validationEngine-cn.js"
    type="text/javascript" charset="utf-8"></script>
<script
    src="../../resources/plug/formvalidation/jquery.validationEngine.js"
    type="text/javascript" charset="utf-8">
</script>
<script
    src="../../resources/plug/jquery.jqGrid-4.3.1/js/i18n/grid.locale-en.js"
    type="text/javascript"></script>
<script
    src="../../resources/plug/jquery.jqGrid-4.3.1/js/jquery.jqGrid.min.js"
    type="text/javascript"></script>
<!-- 引入其它 -->
<script src="../../resources/util/public.js" type="text/javascript"></script>
<script type="text/javascript"
    src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript"
    src="../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript"
    src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js"
    charset="utf-8"></script>
<script type="text/javascript"
    src="../../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js"
    charset="utf-8"></script>
<script type="text/javascript"
    src="../../resources/plug/JQuery zTree v3.0/js/jquery.ztree.core-3.0.js"></script>
<script type="text/javascript"
    src="../../resources/plug/JQuery zTree v3.0/js/jquery.ztree.excheck-3.0.js"></script>
<script type="text/javascript"
    src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js"
    charset="utf-8"></script>
   
<script type="text/javascript">
jQuery(document).ready(function() {
    jQuery("#form1").validationEngine();
});
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
    var flowId='<%=StringUtil.deNull(fbb.getBusitype_code())%>';
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


    $("#t_flowdefgridTable").append("<div>")
    .append("流程绑定")
    //.append("<select id='combobox'><option value='1'>组1</option><option value='2'>组2</option><option value='3'>组3</option></select>") 
    .append("</div>");
        
//流程活动配置列表
$(function() {

$("#flowwfactiongridTable").jqGrid({
    url: '<%=path%>' + '/pubListServlet?classNameId=com.chinacreator.xtbg.core.pubconfig.list.FormActionList',  //pubListServlet列表公共的servlet,classNameId在servletBean.xml文件中配置要调用的类,isPage:是否翻页(true,false),默认为true
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
    // add by 黄海  增加操作列 2013-05-28
       colNames: ['活动id', '活动名称', '活动编号 ', '业务类型 ', '业务类型名称 ', '环节描述 ', '是否有效 ', '创建时间 ', '操作'],
    // add end
    //字符串数组，用于指定各列的题头文本，与列的顺序是对应的。
    colModel: [ //最重要的数组之一，用于设定各列的参数
    {
        name: 'action_id',
        index: 'action_id',
        hidden: true,
        sortable: false
    },
    {
        name: 'action_name',
        index: 'action_name',
        width: 130,
        editable: true,
        sortable: false
    },
    {
        name: 'action_code',
        index: 'action_code',
        width: 130,
        search: true,
        sortable: false
    },
    {
        name: 'busitype_code',
        index: 'busitype_code',
        hidden: true,
    },
    {
        name: 'busitype_name',
        index: 'busitype_name',
        width: 130,
        search: true,
        sortable: false
    },
    {
        name: 'action_desc',
        index: 'action_desc',
        search: true,
        width: '200',
        sortable: false
    },
    {
        name: 'is_valid',
        index: 'is_valid',
        search: true,
        width: '80',
        sortable: false,
        formatter:'select',
		editoptions:{value:"0:否;1:是"}
    },
    {
        name: 'create_time',
        index: 'create_time',
        width: '200',
        sortable: false
    },
    // add by 黄海  增加操作列 2013-05-28
    {
        name: 'act_col',
        index: 'act_col',
        width: '100',
        search: false,
        sortable: false,
        editable: false
    },
    // add end
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
    
    gridComplete: function() { 
        // add by 黄海  增加操作列 2013-05-28
        var ids = $("#flowwfactiongridTable").getDataIDs(); 
        for (var i = 0; i < ids.length; i++) {
            var cl = ids[i];
            be = "<input class='but_y_01' onMouseOver=javascript:$(this).attr('class','but_y_02'); onMouseOut=javascript:$(this).attr('class','but_y_01');  type='button'  id='modify' value='配置' onclick='startActColStatus("+cl+")'>";
            jQuery("#flowwfactiongridTable").jqGrid('setRowData', ids[i], {
                act_col: be
            });
        }
        //add end 
    },
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
 
    toolbar: [true,"top" <%if(!"".equals(type)){%>,"<input class='but_y_01' id=add type='button' onclick='addFormAction()' value='添加'/><input class='but_y_01' id=del type='button' onclick='deleteFormAction()' value='删除'/>"<%}%>],
    multiselect: true,
    onCellSelect: function(id,iCol) {
		if(iCol!=0){
			jQuery("#flowwfactiongridTable").setSelection(id,false);
		 	updateFormAction(id);
		}
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

//如果高度不够，重新对外层的ifram赋值一次
var a = setTimeout(function(){
	resizeIfram(a);
	
},3000);


function resizeIfram(a){
	clearTimeout(a);
  var height = jQuery(document).height();
  var iframheight = jQuery("#frame1",window.parent.document);
  if(height>iframheight.height()){
    //重置iframe的高度
	iframheight.height(height);
  }
}
/*
     函数:  toUserParamJosn
     说明:  构建要查询的参数
     参数:   无
     返回值: 返回要查询的参数
     */
var toUserParamJosn = function() {
    var str = "{'busitype_code':'"+$('#busitype_code').val()+"'}";
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

var saveFormBusitypeInfo = function() {
    var isFlag = jQuery('#form1').validationEngine('validate'); //是否全部验证通过
    if(!isFlag){
       return;
    }
    //本地验证
    var nFlag = nativeValidate();
    if(!nFlag){
       return;
    }
    var tableid=$('#table_id').val();
    if(('<%=fbb.getTable_id()%>' !=tableid)&& !<%=StringUtil.isBlank(busitype_code)%>){
    	var okF = function(){
    		var jsonparam = "{'busitype_code':'"+$('#busitype_code').val()+"','busitype_name':'"+$("#busitype_name").val()
            +"','type_desc':'"+$('#type_desc').val()
            +"','table_id':'"+$('#table_id').val()
            +"','is_valid':'"+$('#is_valid').val()+"'}";
		$("#jsonparam").val(descape(escape(jsonparam)));
		var fm = document.getElementById("form1");
		fm.action = "pubconfigaddorupdateform.jsp?openwindid=<%=openwindid%>&busitype_code=<%=busitype_code%>";
		fm.target = "hiddenFrame";
		$('#form1').submit();
    	}
    	 var p={
    		headerText:'提示',
    		okName:'确认',
    	    okFunction:okF,
    	    cancelName:'取消'
    	};
    	alert("修改表将会把相应活动环节删除，你确定要修改他的表？",p);
    }else{
	    var jsonparam = "{'busitype_code':'"+$('#busitype_code').val()+"','busitype_name':'"+$("#busitype_name").val()
	                    +"','type_desc':'"+$('#type_desc').val()
	                    +"','table_id':'"+$('#table_id').val()
	                    +"','is_valid':'"+$('#is_valid').val()+"'}";
	    $("#jsonparam").val(descape(escape(jsonparam)));
	    var fm = document.getElementById("form1");
	    fm.action = "pubconfigaddorupdateform.jsp?openwindid=<%=openwindid%>&busitype_code=<%=busitype_code%>";
	    fm.target = "hiddenFrame";
	    $('#form1').submit();
    }
}
/**
 * 表单验证
 */
function nativeValidate(){

    //业务类型
    if(isSpace(jQuery("#busitype_name").val())){
      alert("业务名称不能为空");
      return false;
    }

    //所属表格
    if(isSpace(jQuery("#table_id").val())){
      alert("所属表格不能为空");
      return false;
    }
    
    return true;    
}

var init = function() {
	showAndhide();
    setSelectValue("table_id","<%=fbb.getTable_id()%>");
    jQuery("#is_valid").val("<%=fbb.getIs_valid() %>");
    

}

var startFlow = function(id) {
    var model = jQuery("#flowdefgridTable").jqGrid('getRowData', id);

    if(model.is_valid == "是"){
        alert("此流程已启用");
        return false;
    }
    var processId = model.def_id;
    var flow_id = model.flow_id;
    var is_valid = model.flow_version;
    var jsonparam = "{'flow_id':'"+flow_id+"','def_id':'"+processId+"'}";
        
    var url = "flowinfobangdingform.jsp?type=userflowinfo&def_id="+processId;
    $("#jsonparam").val(descape(escape(jsonparam)));
    document.all.form1.action = url;
    document.all.form1.target = "hiddenFrame";
    $('#form1').submit();
}

/*
    函数:  startActColStatus
    说明:  弹出配置流程活动表单元素状态的子页面
    作者：  黄海
    日期： 2013-05-29
    参数:  行主键id
    返回值: 无
*/
var startActColStatus = function(id) {
    var model = jQuery("#flowwfactiongridTable").jqGrid('getRowData' , id);
    var action_name = model.action_name;
    try{
        var url = "<%=path%>/ccapp/oa/pubconfig/jsp/formcolstatus.jsp?action_id="+model.action_id+"&action_name="+action_name;
        var window = openAlertWindows('windowId',url,'配置流程活动表单元素','900','700','2%');
    }catch(error){}
    
}

var chooseWorkFlow = function(){
    try{
    var url = "<%=path%>/jawe/jawe_tree/jaweTree.jsp";

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
/**
 * 流程继承
 */
var extendsflowversion = function(oldFlowId,newFlowId){
    var url = "flowinfobangdingform.jsp?type=extendsflowversion&old_flow_id="
        +oldFlowId+"&new_flow_id="+newFlowId+"&oldTableId=<%=StringUtil.deNull(fbb.getTable_id())%>";
    document.all.form1.action = url;
    document.all.form1.target = "hiddenFrame";
    $('#form1').submit();
}
//actionconfigdetail.jsp参数
var configActionDetail = function(id){
    did=id;
    idss = $("#").getGridParam("records");
    var model = jQuery("#").jqGrid('getRowData', id);
    var url ='<%=path%>/ccapp/oa/process/processconfig/jsp/actionconfigdetail.jsp?action_id='
        +model.action_id+'&type=<%=type%>&busitype_code=<%=busitype_code %>';
    openAlertWindows('windowId',url,'配置环节','810','480','20%');
    
}
/*
函数:  deleteFormAction
说明:  删除表单环节定义表
参数:   无
返回值: 无
*/
var deleteFormAction = function() {
	 var ids = "";
		var selectedIds = $("#flowwfactiongridTable").jqGrid("getGridParam", "selarrrow");
		for ( var i = 0; i < selectedIds.length; i++) {
			var model = jQuery("#flowwfactiongridTable").jqGrid('getRowData',selectedIds[i]);
			if ("" != ids) {
				ids += ",";
			}
			ids += "'" + model.action_id + "'";
		}		 
	if (IsSpace(ids)) {
		alert("请选择要删除记录！");
	} else {
		var okF = function(){	
			$("#action_id").val(ids);
			var fm = document.getElementById("delForm1");
			fm.target = "hiddenFrame1";
			fm.submit();}
			var p={
					headerText:'提示',
					okName:'确认',
			        okFunction:okF,
			        cancelName:'取消'
			};
			alert("确定要删除该信息吗？",p)
	}
}


/*
函数:  addFormAction
说明:  添加表单环节定义表
参数:   无
返回值: 无
*/
var addFormAction = function() {
	openAlertWindows('addformaction','<%=path%>/ccapp/oa/pubconfig/jsp/formactioninfo.jsp?subid=addformaction&busitype_code=<%=busitype_code%>&busitype_name=<%=fbb.getBusitype_name()%>&table_id=<%=fbb.getTable_id()%>','表单环节添加',800,300,'25%','25%');
}
/*
 函数:  updateFormAction
 说明:  修改表单环节定义表
 参数:   无
 返回值: 无
*/
var updateFormAction = function(id) {
	var model = jQuery("#flowwfactiongridTable").jqGrid('getRowData', id);
		openAlertWindows('updateformaction','<%=path%>/ccapp/oa/pubconfig/jsp/formactioninfo.jsp?subid=updateformaction&isview=view&action_id='
				+ model.action_id,'表单环节修改',800,300,'25%','25%');
	}
/* 保存成功后返回方法-子页面调用 */
function saveBack(){
    parent.removeWindows('<%=openwindid%>',true);
}


var setFlowIdAfterSave = function (flowid){
    $('#flow_id').val(flowid);
}



function backparent(){
   
        var url="formbusitypelist.jsp";
        location.href=url;
}

</script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>流程信息配置详细表单</title>
</head>
<body onLoad="init();"
    style="overflow: hidden;">
<form id="form1" name="form1" method="post" class="formular">
<div class="content_02" style="overflow: hidden;">

<div id="vcenter"
    style="float: left; width: 100%; overflow: hidden; ">
<div style="float: left; width: 775px;">
<div class="content_02_box" style="overflow: hidden;">
<div class="content_02_box_title_bg"><span>基本信息</span></div>
<div class="content_02_box_div">
<table width="100%" border="0" cellspacing="0" cellpadding="0"
    class="content_02_box_div_table_02">
    <tr>
        <th class="content_02_box_div_table_th"><span style="color: red">*</span>业务名称：</th>
        <td colspan="3" class="content_02_box_div_table_td"><input type="text" style="width: 99%;"
            name="busitype_name" id="busitype_name" onkeyup="checkInsert(this)" onbeforepaste="checkPaste()" class="validate[required,maxSize[50]]  input_185"
            value="<%=StringUtil.deNull(fbb.getBusitype_name())%>">
            <input type="hidden" name="busitype_code" id="busitype_code" value="<%=StringUtil.deNull(fbb.getBusitype_code())%>">
        </td>
    </tr>
    <tr>
        <th class="content_02_box_div_table_th"><span style="color: red">*</span>所属表格：</th>
        <td class="content_02_box_div_table_td"><select name="table_id"
            class="validate[required] select_188_box" id="table_id" style="width: 188px;" onchange="" size="1">
         	 <%
                try {
                    DBUtil dbUtil = new DBUtil();
                    String sqlCondition = "";
                    
                    String hsql = "select t.table_id id,''||t.table_name||'"+
                    "['||t.table_code||']' name from "
                    +"oa_md_table t "
                    +"  "
                    +"order by t.table_id";
                    dbUtil.executeSelect(hsql);
                    String selected = "";
                    for (int i = 0; i < dbUtil.size(); i++) {
                        if (dbUtil.getString(i, "id") == StringUtil.deNull(fbb.getTable_id())){
                            selected = "selected";                            
                    	}
            %>
            <option value="<%=dbUtil.getString(i, "id")%>" <%=selected%>><%=dbUtil.getString(i, "name")%></option>
            <%
                selected = "";
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
            %>
        </select></td>
        <th class="content_02_box_div_table_th">是否有效：</th>
        <td class="content_02_box_div_table_td"><select id="is_valid"
            style="width: 186px" name="is_valid">
            <option value="Y">是</option>
            <option value="N">否</option>
        </select> 
    </tr>
    <tr>
        <th class="content_02_box_div_table_th">业务描述：</th>
        <td colspan="3" class="content_02_box_div_table_td"><textarea 
            name="type_desc" id="type_desc" onkeyup="checkInsert(this)" onbeforepaste="checkPaste()" class="validate[maxSize[100]] input_575 " style="width:99%;height: 80px;"><%=StringUtil.deNull(fbb.getType_desc())%></textarea>
        </td>
    </tr>
    
    <!-- end -->
</table>
</div>
</div>

<table>
    <tr>
        <td height="10px"></td>
    </tr>
</table>
<div class="content_02_box_div_special" style="overflow: hidden;"><!-- 查询列表区 --> <!-- 查询列表区 cGridArea(查询区样式)-->
<div class="cGridArea">
<table id="flowwfactiongridTable"></table>
<div id="flowwfactiongridPager"></div>
</div>
<!-- 查询列表区 --></div>
<p>&nbsp;</p>
<input id="jsonparam" name="jsonparam" type="hidden" /></div></div>
</div>

</form>
<iframe name="hiddenFrame" width=0 height=0 ></iframe>
<form id="delForm1" name="delForm1" method="post" action="formactiondo.jsp">
	<input type="hidden" name="action_id" id="action_id" /> 
	<input type="hidden" name="action" value="deleteFormAction" />
</form>
<iframe name="hiddenFrame1" width="0" height="0"></iframe>
</body>
</html>
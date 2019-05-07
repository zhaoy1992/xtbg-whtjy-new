<%-- 
描述：回退到后续环节
作者：yiping.huang
版本：1.0
日期：2013-10-08
 --%>
<%@page contentType="text/html; charset=utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
AccessControl accesscontroler = AccessControl.getAccessControl();
accesscontroler.checkAccess(request, response);
String path = request.getContextPath();

String msg_txt = request.getParameter("msg_txt");
String isdxtx = request.getParameter("isdxtx");
String isjsxx = request.getParameter("isjsxx");
String isyj = request.getParameter("isyj");
String isznxx = request.getParameter("isznxx");
String busi_id = request.getParameter("busi_id");
%>
<title>环节回退</title>
<!-- 引入jQuery -->
<script type="text/javascript" src="../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" ></script>
<!-- 引入其它 -->
<script src="../resources/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../resources/plug/ifrom/js/ifrom-tools.1.1.js"></script>
<script type='text/javascript' src='../../oa/process/flowprocessing/js/alertworkflow.js'></script>
<script src="../resources/plug/jquery.jqGrid-4.3.1/js/i18n/grid.locale-en.js" type="text/javascript"></script>
<script type="text/javascript" src="../resources/plug/jquery.jqGrid-4.3.1/js/jquery.jqGrid.min.js"></script>

<!-- 当jqGrid列的字过多的时候显示...样式  -->

<script type="text/javascript">
jQuery(function() {
	var pwindows = getParentWindow("windowIds");
	var pparms = pwindows.parms;//获取父页面的流程数据

	if(pparms.flowParmJson.initType!=3){//如果是初始化环节，中间环节
		var flowret = pparms.flowParmJson.flowinfo;
		var SPLIT_CHAR = "@";
		var flowDatas = flowret.split(SPLIT_CHAR);
		jQuery("#ins_id").val(pparms.flowParmJson.ins_id);
		jQuery("#nextActList").val(flowDatas[flowDatas.length-1]);
	} else {
		
	}
	
	jQuery("#gridTable").jqGrid({
		url: '<%=path%>' + '/pubListServlet?classNameId=com.chinacreator.xtbg.core.archive.list.DoBackList',
		datatype: "json",
		mtype: "POST",
		height: "100%",
		autowidth: true,
		colModel: [ 
		{
			label:' ',
		  	name: 'rr',
		    index:'rr',
		   	width: 20,
			search: false,
			sortable: false,
			editable: false
		},{
			label:"实例ID",
			name: 'ins_id',
			index: 'ins_id',
			hidden: true
		},
		{
			label:"下一环节定义ID",
			name: 'next_actdefId',
			index: 'next_actdefId',
			hidden: true
		},
		{
			label:"下一环节用户名称",
			name: 'user_name',
			index: 'user_name',
			hidden: true
		},
		{
			label:"用户名称",
			name: 'user_rename',
			index: 'user_rename',
			width: 200,
			editable: true
		},
		{
			label:"环节名称",
			name: 'next_actName',
			index: 'next_actName',
			width: 300,
			editable: true
		}
		],
		sortname: 'next_actdefId',
		sortorder: 'desc',
		viewrecords: true,
		
		rowNum: 6,
		rowList: [10, 20, 30],
		gridComplete: function() {
			var ids = jQuery("#gridTable").getDataIDs(); //jqGrid('getDataIDs');
			for (var i = 0; i < ids.length; i++) {
				var cl = ids[i];
				var model = jQuery("#gridTable").jqGrid('getRowData', cl);
				if(i==0){
					be = "<input type='radio' checked='checked'   name='r1' />";
				}else{
					be = "<input type='radio'  name='r1' />";
				}
				
				
			jQuery("#gridTable").jqGrid('setRowData', ids[i], {
				rr: be
			});

			}
		},
		jsonReader: { 
			repeatitems: false
		},
		pagerintoolbar:true,//上面的分页条
		pagerinBottombar:true,
		search : toUserParamJosn(),
		
		prmNames: { 
			rows: "rows",
			sort: "sidx",
			order: "sord",
			search : "search"
		},
		multiselect: false,
		onCellSelect: function(id,iCol) {
			
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
	 函数:  toUserParamJosn
	 说明:  构建要查询的参数
	 参数:   无
	 返回值: 返回要查询的参数
	 */
var toUserParamJosn = function() {
	var str = "{'ins_id':'"+jQuery("#ins_id").val()+"','next_actdefId':'"+jQuery("#nextActList").val()+"'}";
	return descape(escape(str));
}

//启动流程
function save(){
	var pwindows = getParentWindow("windowIds");
	var pparms = pwindows.parms;//获取父页面的流程数据
	var dynamicperformer_realname = jQuery("#DYNAMICPERFORMER_REALNAME").val();
	if(pparms.flowParmJson.initType!=3){
		var ids = "";
	    var j = -1;
	    var ids = jQuery("#gridTable").getDataIDs(); //jqGrid('getDataIDs');
	   
	    jQuery("input[name=r1]").each(function(i,e){
			if(jQuery(this).is(":checked")){
				j = i;
			}
		})
	    if(j == -1){
	    	alert("请选择要回退的环节!")
	    	return false;
	    }
		var model = jQuery("#gridTable").jqGrid('getRowData',ids[j]);
	    
	    jQuery('#DYNAMICPERFORMER_ID').val();
		jQuery('#DYNAMICPERFORMER_REALNAME').val(model.user_rename);
		jQuery('#DYNAMICPERFORMER').val(model.user_name);
		jQuery("#xzsp_workflowControl_selectAct").val(model.next_actdefId);
		jQuery("#xzspWorkflowType").val("1");
		
		//获取选择人员
		var DYNAMICPERFORMER_ID = jQuery('#DYNAMICPERFORMER_ID').val();
		var DYNAMICPERFORMER_REALNAME = jQuery('#DYNAMICPERFORMER_REALNAME').val();
		var DYNAMICPERFORMER = jQuery('#DYNAMICPERFORMER').val();
		//获取选择环节类型等信息
		var xzspWorkflowType = jQuery("#xzspWorkflowType").val();
	    var isDynamicSelectAct = jQuery("#isDynamicSelectAct").val();
	    var isDynamicSelectUser = jQuery("#isDynamicSelectUser").val();
	    var isDynamicSelectAndAct = jQuery("#isDynamicSelectAndAct").val();
	    var nextActList = jQuery("#nextActList").val();
	    var xzsp_workflowControl_selectAct =  jQuery("#xzsp_workflowControl_selectAct").val();
		var ret = new Array();
	    ret["xzspWorkflowType"] = xzspWorkflowType;
	    ret["isDynamicSelectAct"] = false;
	    ret["isDynamicSelectUser"] = true;
	    ret["isDynamicSelectAndAct"] = false;
	    ret["xzsp_workflowControl_selectAct"] = xzsp_workflowControl_selectAct;
	    //ret["nextActList"] = nextActList;
	   
	    
		pwindows.setFlowInfo(DYNAMICPERFORMER_ID, DYNAMICPERFORMER_REALNAME, DYNAMICPERFORMER,ret);
		removeAlertWindows('windowIds',true);
		pwindows.removeAlertWindows('windowIds',true);
		/* var ids = "";
		var selectedIds = jQuery("#gridTable").jqGrid("getGridParam", "selarrrow");
		for ( var i = 0; i < selectedIds.length; i++) {
			var model = jQuery("#gridTable").jqGrid('getRowData',selectedIds[i]);
			if ("" != ids) {
				ids += ",";
			}
			ids += "'" + model.next_actdefId + "'";
			jQuery('#DYNAMICPERFORMER_ID').val();
			jQuery('#DYNAMICPERFORMER_REALNAME').val(model.user_rename);
			jQuery('#DYNAMICPERFORMER').val(model.user_name);
			jQuery("#xzsp_workflowControl_selectAct").val(model.next_actdefId);
			jQuery("#xzspWorkflowType").val("1");
		}		 
		if (IsSpace(ids)) {
			alert("请选择要回退的环节");
			return false;
		} else {
			if(selectedIds.length > 1) {
				alert("只能一条记录");
				return false;
			} else {
				//获取选择人员
				var DYNAMICPERFORMER_ID = jQuery('#DYNAMICPERFORMER_ID').val();
				var DYNAMICPERFORMER_REALNAME = jQuery('#DYNAMICPERFORMER_REALNAME').val();
				var DYNAMICPERFORMER = jQuery('#DYNAMICPERFORMER').val();
				//获取选择环节类型等信息
				var xzspWorkflowType = jQuery("#xzspWorkflowType").val();
			    var isDynamicSelectAct = jQuery("#isDynamicSelectAct").val();
			    var isDynamicSelectUser = jQuery("#isDynamicSelectUser").val();
			    var isDynamicSelectAndAct = jQuery("#isDynamicSelectAndAct").val();
			    var nextActList = jQuery("#nextActList").val();
			    var xzsp_workflowControl_selectAct =  jQuery("#xzsp_workflowControl_selectAct").val();
				var ret = new Array();
			    ret["xzspWorkflowType"] = xzspWorkflowType;
			    ret["isDynamicSelectAct"] = false;
			    ret["isDynamicSelectUser"] = true;
			    ret["isDynamicSelectAndAct"] = false;
			    ret["xzsp_workflowControl_selectAct"] = xzsp_workflowControl_selectAct;
			    //ret["nextActList"] = nextActList;
			   
			    
				pwindows.setFlowInfo(DYNAMICPERFORMER_ID, DYNAMICPERFORMER_REALNAME, DYNAMICPERFORMER,ret);
				removeAlertWindows('windowIds',true);
				pwindows.removeAlertWindows('windowIds',true);
			}
		} */
	}
	
	
}

//关闭
function closew(){
	getParentWindow("windowIds").closeAlertWindow();
	removeAlertWindows('windowIds',true);
}
</script>
</head>
<body>

<button id="button1" class="but_y_01" onclick="save()">确定</button>
<button id="button2" class="but_y_01" onclick="closew()">关闭</button>

<div id="vcenter"  >
		<div class="content_02_box">
			<table id="gridTable"></table>
		</div>
</div>

<input id="busi_id" name="busi_id" type="hidden" value =""/>
<input id="SELECT_USER_ID_LIST" name="SELECT_USER_ID_LIST" type="hidden" value =""/>
<input id="TREE_ROLE" name="TREE_ROLE" type="hidden" value =""/>
<input id="xzsp_workflowControl_selectAct" name="xzsp_workflowControl_selectAct" type="hidden" />
<input type="hidden" id="DYNAMICPERFORMER" name="DYNAMICPERFORMER" />
<input type="hidden" id="DYNAMICPERFORMER_ID" name="DYNAMICPERFORMER_ID" />
<input id="xzspWorkflowType" name="xzspWorkflowType" type="hidden" />
<input id="isDynamicSelectAct" name="isDynamicSelectAct" type="hidden" />
<input id="isDynamicSelectAndAct" name="isDynamicSelectAndAct" type="hidden" />
<input id="isDynamicSelectUser" name="isDynamicSelectUser" type="hidden" />
<input id="nextActList" name="nextActList" type="hidden" />
<input id="ins_id" name="ins_id" type="hidden" />
</body>
</html>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.chinacreator.xtbg.pub.util.DictDropDownList"%>
<%@page import="com.chinacreator.business.common.tools.CacheCommonManage"%>

<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	
	String loginUserName = accesscontroler.getUserAccount();
	String userArea = CacheCommonManage.getInstance().getSystemParam("CURSYSTEMCODE");
	String sql = "select i.busitype_code, i.busitype_name from ta_oa_busi_type i where i.is_valid = 'Y' and i.AREACODE ='"+userArea+"'";
	String str = DictDropDownList.buildSelect(sql,"busitype_code","","",true,"");
	if(userArea.equalsIgnoreCase("431000")){
		List<String> list=new ArrayList<String>();
		list.add(0, "收文");
		list.add(0, "发文");
		str=DictDropDownList.buildSelect(sql,"busitype_code","","",true,"",list);
	}
	String homepage  =request.getParameter("flag");
	String entrance = request.getParameter("entrance");

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@page import="com.chinacreator.security.AccessControl"%><html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<!-- 引入jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>

<!-- 引入jQuery UI -->
<script
	src="../../../resources/plug/My97DatePicker/WdatePicker.js"
	type="text/javascript"></script>
<script
	src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js"
	type="text/javascript"></script>

<!-- 引入jGrid -->
<script src="../../../resources/plug/jquery.jqGrid-4.3.1/js/i18n/grid.locale-en.js"
	type="text/javascript"></script>
<script src="../../../resources/plug/jquery.jqGrid-4.3.1/js/jquery.jqGrid.min.js"
	type="text/javascript"></script>

<!-- 引入其它 -->
<script src="../../../resources/js/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<title>待办列表</title>

<script type="text/javascript">
var loginUserName = '<%=loginUserName%>';
$(function() {
	if('<%=entrance%>' == 'homepage')
	{
		$("#queryTable_search").hide();
	}
	$(document).keydown(function(){
		if(event.keyCode == 13){ 
			var str = jQuery("#ins_name").val()+","+jQuery("#accepter").val();
			if(!selectText(str)){
				 return false;
			 }
			userSearch();
		}
	
	});
	$("#gridTable").jqGrid({
		url: '<%= path %>' + '/commonListServlet?classNameId=doWorkList',  //commonListServlet列表公共的servlet,classNameId在servletBean.xml文件中配置要调用的类,isPage:是否翻页(true,false),默认为true
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
		colNames: ['实例id','业务id','环节实例id','ccformid','流程实例ID','活动定义ID','活动类型编号 ','流程ID','办件编号 ',  '标题  ', '业务类型  ','发起人 ', '发起时间  ', '当前环节 ', '办件历史 ','代理人'],
		//字符串数组，用于指定各列的题头文本，与列的顺序是对应的。
		colModel: [ //最重要的数组之一，用于设定各列的参数
           {
   			name: 'ins_id',
   			index: 'ins_id',
   			width: '0',
   			hidden: true
   		},
   		{
   			name: 'busi_id',
   			index: 'busi_id',
   			width: '20',
   			hidden: true
    	},
    	{
   			name: 'actInsId',
   			index: 'actInsId',
   			width: '0',
   			hidden: true
    	},
    	{
   			name: 'cc_form_instanceid',
   			index: 'cc_form_instanceid',
   			width: '0',
   			hidden: true
    	},
    	{
   			name: 'procId',
   			index: 'procId',
   			width: '0',
   			hidden: true
    	},
    	{
   			name: 'action_defid',
   			index: 'action_defid',
   			width: '0',
   			hidden: true
    	},
    	{
   			name: 'actiontype_code',
   			index: 'actiontype_code',
   			width: '0',
   			hidden: true
   			
    	},
    	{
   			name: 'def_id',
   			index: 'def_id',
   			width: '0',
   			hidden: true
    	},
		{
			name: 'ins_code',
			index: 'ins_code',
			width: '100',
			hidden: true
		},
		{
			name: 'ins_name',
			index: 'ins_name',
			width: '120',
			editable: true
		},
		{
			name: 'busitype_name',
			index: 'busitype_name',
			width: '45',
			search: true
		},
		{
			name: 'accepter',
			index: 'accepter',
			width: '60',
			search: true
		},
		{
			name: 'accept_time',
			index: 'accept_time',
			width: '40',
			search: true
		},
		{
			name: 'act_name',
			index: 'act_name',
			width: '40',
			search: true
		},
		{
			name: 'act',
			index: 'act',
			width: '25',
			search: false,
			sortable: false,
			editable: false
		},
		 {
   			name: 'entrust_name',
   			index: 'entrust_name',
   			width: '0',
   			hidden: true
   		}
		],
		sortname: 'accept_time',
		//指定默认的排序列，可以是列名也可以是数字。此参数会在被传递到Server端。
		sortorder: 'desc',
		viewrecords: true,
		
		//设置是否在Pager Bar显示所有记录的总数。
		rowNum: 15,
		//用于设置Grid中一次显示的行数，默认值为20。正是这个选项将参数rows（prmNames中设置的）通过url选项设置的链接传递到Server。注意如果Server返回的数据行数超过了rowNum的设定，则Grid也只显示rowNum设定的行数。
		rowList: [10, 20, 30],
		//一个数组，用于设置Grid可以接受的rowNum值。例如[10,20,30]
		gridComplete: function() { // var idss=jQuery("#gridTable").jqGrid('getColNames');
			var ids = $("#gridTable").getDataIDs(); //jqGrid('getDataIDs');
			for (var i = 0; i < ids.length; i++) {
				var cl = ids[i];
				var model = jQuery("#gridTable").jqGrid('getRowData', cl);
				if(model.entrust_name != ''){
					col = model.ins_name+'<span style="color: red">(代'+model.entrust_name+'办理)</span>';
				}
				if(model.entrust_name == ''){
					col = model.ins_name;
				}
				jQuery("#gridTable").jqGrid('setRowData', ids[i], {
					ins_name: col
				});
					
				be = "<input id='modify' type='button' class='but_y_01' onMouseOver=javascript:$(this).attr('class','but_y_02'); onMouseOut=javascript:$(this).attr('class','but_y_01'); onclick='showFlowHistory("+cl+")' value = '办件历史' />";
				jQuery("#gridTable").jqGrid('setRowData', ids[i], {
					act: be
				});
			}
		},
		
		jsonReader: { //这又是一个数组，用来设定如何解析从Server端发回来的json数据
			repeatitems: false
		},
		//pager: "#gridPager",
		//定义页码控制条Page Bar
		//caption: "待办列表",
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
		/*
		filterNames:["act_name"],
		filterOptions:[
		               [
		                ["xd","name"],[2,"page"],[3,"daf"]],//value text 后的值与显不
		                [
		                 ['王奎',"王奎"],["马坤","马坤"],["文电科","文电科"]
		                 ]
		               ],
		filterOptionsDefValue:[1,2],*/
		pagerintoolbar:true,//上面的分页条
		pagerinBottombar:true,//下面的分页条
		toolbar: [true,"top"],
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
function selectText(TextValue){
	 var txt=new RegExp("[ ,\\`,\\！,\\￥,\\【,\\】,\\~,\\!,\\@,\#,\\$,\\%,\\^,\\+,\\*,\\&,\\\\,\\/,\\?,\\|,\\:,\\.,\\<,\\>,\\{,\\},\\(,\\),\\',\\;,\\=,\"]");
	 var flag = true;
	 var arr = new Array();//取数组
	 arr = TextValue.split(",");
	 for(var i = 0; i < arr.length ; i++){
		flag =  txt.test(arr[i]);
		 if(flag){
			 alert("请不要输入特殊字符!"); 
			 return false;
		 }
	 }
	 return true;
}

/*
函数:  userSearch
说明:  查询用户信息
参数:   无
返回值: 用户列表
*/
var userSearch = function() {
	var str = jQuery("#ins_name").val()+","+jQuery("#accepter").val();
	if(!selectText(str)){
		 return false;
	 }
	
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
		var str="";
		if('<%=homepage%>' =='homepage')
		{
			str = "{'username':'"+loginUserName+"','ins_code':'"+$('#ins_code').val()+"',"+
			  "'ins_name':'"+$('#ins_name').val()+"',"+
			  "'accepter':'"+$('#accepter').val()+"','startSlTime':'"+$('#startSlTime').val()+"','endSlTime':'"+$('#endSlTime').val()+"'}";	
		}else if('<%=homepage%>' =='homepage1')
		{
			str = "{'username':'"+loginUserName+"','ins_code':'"+$('#ins_code').val()+"',"+
			  "'busitype_code':'12','ins_name':'"+$('#ins_name').val()+"',"+
			  "'accepter':'"+$('#accepter').val()+"','startSlTime':'"+$('#startSlTime').val()+"','endSlTime':'"+$('#endSlTime').val()+"'}";	
		}
		else{
	    	var str = "{'username':'"+loginUserName+"','ins_code':'"+$('#ins_code').val()+"',"+
			  "'busitype_code':'"+$('#busitype_code').val()+"','ins_name':'"+$('#ins_name').val()+"',"+
			  "'accepter':'"+$('#accepter').val()+"','startSlTime':'"+$('#startSlTime').val()+"','endSlTime':'"+$('#endSlTime').val()+"'}";
		}
	return descape(escape(str));
}

/*
函数:  resetSingleSearchDialog
说明:  清空值查询值
参数:   无
返回值: 无
*/
var resetSingleSearchDialog = function() { //$("radio","#singleSearchDialog").attr("checked", false);  
$("text", "#queryTable").val("");
$("select:first option:first").attr("selected","selected");
}

var showFlowHistory = function(id) {
	var model = jQuery("#gridTable").jqGrid('getRowData', id);
	showFlowHistoryByInsId(model.ins_id);
}
function handle(id){   
    var model = jQuery("#gridTable").jqGrid('getRowData', id);
    //alert(model.procId);
    var url = "";
    if(model.actiontype_code == "01")
    {
    	url = "../../../resources/plug/workflow/jsp/commonflowstart.jsp?ins_id="+model.ins_id+
    	"&busi_id="+model.busi_id+"&actInsId="+model.actInsId+"&cc_form_instanceid="+model.cc_form_instanceid+
    	"&def_id="+model.def_id+"&procId="+model.procId+
    	"&action_defid="+model.action_defid+"&list_type=worklist&operType=daiban"+"&openwindID=sub_main_viewinfos";
    	
    } 
    else if (model.actiontype_code == "02") 
    {
    	url = "../../../resources/plug/workflow/jsp/commonflowapprove.jsp?ins_id="+model.ins_id+
    	"&busi_id="+model.busi_id+"&actInsId="+model.actInsId+"&cc_form_instanceid="+model.cc_form_instanceid+
    	"&def_id="+model.def_id+"&procId="+model.procId+"&operType=daiban&action_defid="+model.action_defid+
    	"&list_type=worklist&entrance=<%=entrance%>";
    } 
    else {
    	url = "../../../resources/plug/workflow/jsp/commonflowend.jsp?ins_id="+model.ins_id+
    	"&busi_id="+model.busi_id+"&actInsId="+model.actInsId+
    	"&cc_form_instanceid="+model.cc_form_instanceid+"&def_id="+model.def_id+
    	"&procId="+model.procId+"&action_defid="+model.action_defid+
    	"&list_type=worklist&operType=daiban&actiontype_code="+model.actiontype_code;
    	//alert(url);
    }
    	
    	 window.parent.location = url,"perspective_content";
    	 window.top.getIFrameDOM("_document_body_mian_firstPagerAAAS").location.reload();
    //openWindows('sub_main_viewinfos','公文待办',url,'sub_main_todowork',false,window);
}
window.onload = function () {
	setDataTimeClickShowOrHide('startSlTime',window);
	setDataTimeClickShowOrHide('endSlTime',window);
  }


</script>
</head>
<body style="overflow-y:auto;">
<table width="98%" id="queryTable">
	<tr>
		<td>
			<!-- 查询条件选区    tabs_search_ctable(查询table样式) -->
			<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tabs_search_ctable_box" id="queryTable_search">
				<tr>
					<td>
						<!-- 固定查询 -->
						<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tabs_search_ctable">
							<tr>
<!--								<th width="90" class="input_cx_title_th" >公文编号：</th>-->
<!--								<td width="296"  class="cx_title_td">-->
								<input class="input_cx_title_283" id="ins_code" name="ins_code" type="hidden" />
<!--								</td>-->
						<th class="input_cx_title_th">标题：</th>
					    <td class="cx_title_td">
					   	 <input id="ins_name" name="ins_name" type="text" class="input_cx_title_283"  />
					    </td>
								<td width="385"  colspan="2"  >
								<input name="Input2" value="搜索" type="button" onclick="userSearch()" class="but_y_01"/>
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
							  
  
					   <tr>
					   <th class="input_cx_title_th">发起人：</th>
								    <td class="cx_title_td">
								   	 <input  id="accepter" name="accepter" type="text" class="input_cx_title_283" />
								    </td>
					  </tr>
							<tr>
								
								<th class="input_cx_title_th">发起时间：</th>
								<td  class="cx_title_td">
								<input class="date_120 Wdate" type="text" id="startSlTime" name="startSlTime" 
									onFocus="var input_endtime=$dp.$('endSlTime');WdatePicker({onpicked:function(){endSlTime.focus();},dateFmt:'yyyy-MM-dd '})" 
								/>
								<span class="date_120_span">至</span>
								<input class="date_120 Wdate" type="text" id="endSlTime" name="endSlTime" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'startSlTime\')}',dateFmt:'yyyy-MM-dd '})" />
								</td>
						 <th colspan="2">
						    <table width="100%" border="0" cellspacing="0" cellpadding="0">
						      <tr>
						        <td class="input_cx_title_th">业务类型：</td>
						        <td align="left" colspan="2" >
						        	<%=str%>
						         </td>
						       </tr>
						    </table>
						</th>
							</tr>
						</table>
						<!-- 隐藏查询 end-->
							</td>
				</tr>
			</table>
		<!-- 查询列表区 cGridArea(查询区样式)-->
				<div class="cGridArea">
					<table id="gridTable"></table>
					<div id="gridPager"></div>
				</div>
				<!-- 查询列表区 -->
		

</body>
</html>
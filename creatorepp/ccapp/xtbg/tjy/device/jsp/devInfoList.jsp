<%--
描述：设备台帐列表管理界面
作者：邱炼
版本：1.0
日期：2014-03-03
--%>
<%@page import="com.chinacreator.xtbg.core.common.util.DaoUtil"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	String GET_LIST_CLASS1="com.chinacreator.xtbg.tjy.device.list.DevAccountInfoList";
	String path = request.getContextPath();
	//设备库存状态
	String dev_stockflag = request.getParameter("dev_stockflag"); 
	//设备使用状态
	String dev_state = request.getParameter("dev_state");
	//回填到对比设备
	String view = StringUtil.deNull(request.getParameter("view"));
	String action_defid = StringUtil.deNull(request.getParameter("action_defid"));
	String busi_id = StringUtil.deNull(request.getParameter("busi_id"));
	String frompage = request.getParameter("frompage");
	//System.out.println("frompage="+frompage);
	String action_name = "";
	if(!StringUtil.nullOrBlank(action_defid) && !StringUtil.nullOrBlank(busi_id)){
		action_name = DaoUtil.sqlToField("select w.action_name from oa_flow_wfaction w,oa_flow_instance i where i.def_id = w.def_id and i.busi_id ='"+busi_id+"' and w.action_defid = '"+action_defid+"'");
	}
	//System.out.println("action_defid========="+action_defid);
	//System.out.println("busi_id========="+busi_id);
%>
<title>设备台帐管理</title>
<!-- 公共部分开始 -->
<!-- 引入jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<!-- 引入jQuery UI -->
<script src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>
<!-- 引入my97时间控件 -->
<script src="../../../resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<!-- 引入jGrid -->
<script src="../../../resources/plug/jquery.jqGrid-4.3.1/js/i18n/grid.locale-en.js" type="text/javascript"></script>
<script src="../../../resources/plug/jquery.jqGrid-4.3.1/js/jquery.jqGrid.min.js" type="text/javascript"></script>
<!-- 引入其它 -->
<script src="../../../resources/js/util/public.js" type="text/javascript"></script>
<script src="../../../resources/js/common/commoncss.js" type="text/javascript"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js"charset="utf-8"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script> 
<!-- 公共部分引用结束 -->
<script type="text/javascript">
var view = "<%=view%>";
var action_name = "<%=action_name%>";
$(function() {
	$(document).keydown(function(){
		if(event.keyCode == 13){ 
			userSearch();
		}
	});
	
	//类别
	if("devguih"=='<%=frompage%>'){
		$("#stockflag").show();
	}else{
		$("#stockflag").hide();
	}
	
	//设置类别的值
	$("#dev_stockflag").val('<%=dev_stockflag%>');
	
//tab2
	$("#gridTable").jqGrid({
		url: '<%= path %>' + '/pubListServlet?classNameId=<%=GET_LIST_CLASS1%>',  //commonListServlet列表公共的servlet,classNameId在servletBean.xml文件中配置要调用的类,isPage:是否翻页(true,false),默认为true
		//jqGrid控件通过这个参数得到需要显示的数据，具体的返回值可以使XML也可以是Json
		datatype: "json",
		//这个参数用于设定将要得到的数据类型。我最常用的是“json”，其余的类型还包括：xml、xmlstring、local、javascript、function
		mtype: "POST",
		//定义使用哪种方法发起请求，GET或者POST
		height: "270",//270
		//Grid的高度，可以接受数字、%值、auto，默认值为150
		//width ："1800", //Grid的宽度，如果未设置，则宽度应为所有列宽的之和；如果设置了宽度，则每列的宽度将会根据shrinkToFit选项的设置，进行设置。
		//shrinkToFit ：true 此选项用于根据width计算每列宽度的算法。默认值为true。如果shrinkToFit为true且设置了width值，则每列宽度会根据width成比例缩放；如果shrinkToFit为false且设置了width值，则每列的宽度不会成比例缩放，而是保持原有设置，而Grid将会有水平滚动条
		autowidth: true,
		//width: "1000",
		//默认值为false。如果设为true，则Grid的宽度会根据父容器的宽度自动重算。重算仅发生在Grid初始化的阶段；如果当父容器尺寸变化了，同时也需要变化Grid的尺寸的话，则需要在自己的代码中调用setGridWidth方法来完成。
		colNames: ['主键ID','设备编号', '名称','使用部门', '保管人','规格型号','到货日期','设备库存状态','设备使用状态','制造厂家','生产日期','出厂编号','供应商名称','金额','基本参数','设备保管人ID','jieyong_orgmc','jieyonguser','t_lydate','guihid'],
		//字符串数组，用于指定各列的题头文本，与列的顺序是对应的。
		colModel: [ //最重要的数组之一，用于设定各列的参数
         {
   			name: 'id',
   			index: 'id',
   			hidden:true
   		},{
			name: 'dev_code',
			index: 'dev_code',
			width: 80
		},
		{
			name: 'dev_name',
			index: 'dev_name',
			width: 80
		},
		{
			name: 'user_orgname',
			index: 'user_orgname',
			width: 60,
			<%if(!"资产管理员执行".equals(action_name)){%>
				hidden:true
			<%}%>
		},
		{
			name: 'custos_username',
			index: 'custos_username',
			width: 60,
			<%if(!"资产管理员执行".equals(action_name)){%>
				hidden:true
			<%}%>
		},
		{
			name: 'type',
			index: 'type',
			width: 80,
			<%if(!"资产管理员执行".equals(action_name)){%>
				hidden:true
			<%}%>
		},
		{
			name: 'arrive_time',
			index: 'arrive_time',
			width: 60,
			<%if(!"资产管理员执行".equals(action_name)){%>
				hidden:true
			<%}%>
		},
		{
			name: 'dev_stockflag',
			index: 'dev_stockflag',
			width: 50,
			<%if(!"资产管理员执行".equals(action_name)){%>
				hidden:true
			<%}%>
		},
		{
			name: 'dev_state',
			index: 'dev_state',
			width: 50,
			<%if(!"资产管理员执行".equals(action_name)){%>
				hidden:true
			<%}%>
		},
		{
			name: 'make_users',
			index: 'make_users',
			width: 80,
			hidden:true
		},
		{
			name: 'creat_date',
			index: 'creat_date',
			width: 80,
			hidden:true
		},
		{
			name: 'factory_no',
			index: 'factory_no',
			width: 80,
			hidden:true
		},
		{
			name: 'dev_code',
			index: 'dev_code',
			width: 80,
			hidden: true
		},
		{
			name: 'price',
			index: 'price',
			width: 80,
			hidden:true
		},
		{
			name:'technical_parameters',
			index: 'technical_parameters',
			width: 80,
			hidden:true
		},
		{
			name:'custos_userid',
			index: 'custos_userid',
			width: 80,
			hidden:true
		},
		{
			name:'jieyong_orgmc',
			index: 'jieyong_orgmc',
			width: 80,
			hidden:true
		},
		
		{
			name:'jieyonguser',
			index: 'jieyonguser',
			width: 80,
			hidden:true
		}
		,
		{
			name:'t_lydate',
			index: 't_lydate',
			width: 80,
			hidden:true
		}
		,
		{
			name:'guihid',
			index: 'guihid',
			width: 80,
			hidden:true
		}
		],
		sortname: 'creat_time',
		//指定默认的排序列，可以是列名也可以是数字。此参数会在被传递到Server端。
		sortorder: 'asc',
		viewrecords: true,
		
		//设置是否在Pager Bar显示所有记录的总数。
		rowNum: 10,
		//用于设置Grid中一次显示的行数，默认值为20。正是这个选项将参数rows（prmNames中设置的）通过url选项设置的链接传递到Server。注意如果Server返回的数据行数超过了rowNum的设定，则Grid也只显示rowNum设定的行数。
		rowList: [10, 20, 30],
		//一个数组，用于设置Grid可以接受的rowNum值。例如[10,20,30]
		gridComplete: function() { // var idss=jQuery("#gridTable").jqGrid('getColNames');
			var ids = $("#gridTable").getDataIDs(); //jqGrid('getDataIDs');
		},
		jsonReader: { //这又是一个数组，用来设定如何解析从Server端发回来的json数据
			repeatitems: false
		},
		pagerintoolbar:true,//上面的分页条
		pagerinBottombar:true,//下面的分页条
		//定义页码控制条Page Bar
		//caption: "来文缓急维护",
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
		toolbar:[true, "top" ,""],
		multiselect: false,
		onCellSelect:function (id,iCol)
		{
			if(iCol != 0)
			{
				updateLevel(id);
			}
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
	var str = "{'dev_code':'" + $("#dev_code").val() +
	"','type':'" + $("#type").val() +
	"','dev_stockflag':'" + $("#dev_stockflag").val() +
	"','dev_name':'" + $("#dev_name").val() +
	"','dev_state':'<%=dev_state%>','make_users':'" + $("#make_users").val() + 
	"','custos_username':'" + $("#custos_username").val() + 
	"','user_orgname':'" + $("#user_orgname").val() +
	"'}";
	return descape(escape(str));
}
/*
函数:  StringCheck
说明:  做查询时通配符处理问题
参数:   obj 文本框上获得的值
返回值: 返回转换后的值
*/
function StringCheck(obj){
	return obj.replaceAll('%','----').replaceAll('_','----').replaceAll(' ','----');
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
	 函数:  updateLevel
	 说明:  修改缓急程度
	 参数:   无
	 返回值: 无
	 */
var updateLevel = function(id) {
	 var model = jQuery("#gridTable").jqGrid('getRowData', id);
	 var id = model.id;                  				 //主键ID
	 var dev_code = model.dev_code;                     //设备编号
	 var dev_name = model.dev_name;                     //设备名称
	 var dev_stockflag = model.dev_stockflag;           //设备库存状态
	 var type =model.type;								//设备型号
	 var make_users = model.make_users;					//制造厂商
	 var technical_parameters = model.technical_parameters;//基本参数
	 var arrive_time = model.arrive_time;					//到货日期
	 var custos_userid = model.custos_userid;				//设备保管员ID
	 var custos_username = model.custos_username;				//设备保管员名称
	 var user_orgname = model.user_orgname;
	 var user_orgid = model.user_orgid;
	 var guihid = model.guihid;
	 var jieyong_orgmc = model.jieyong_orgmc;
	 var jieyonguser = model.jieyonguser;
	 var t_lydate = model.t_lydate;
	 
	 var parentObject = getParentWindow('windowIds1');
	 if(view=="compare"){
		 parentObject.setDevCompareInfo(id,dev_code,dev_name,dev_stockflag,type,make_users,technical_parameters,arrive_time,custos_userid,custos_username);
	 } else{
	 	parentObject.setDevInfo(id,dev_code,dev_name,dev_stockflag,type,make_users,technical_parameters,arrive_time,custos_userid,custos_username,jieyong_orgmc,jieyonguser,t_lydate,guihid,user_orgname,user_orgid);
	 }
	 removeAlertWindows('windowIds1',true,true,'',false,'','');	 
}


afterSubmitFn=function(result){
	try{
		if(result.indexOf("delete")!=-1){
			alert(result.split(",")[1]);
			userSearch();
		}else{
			if(result.split(",").length>1){
					result = result.split(",");
					alert(result[0]);
					userSearch();
			} else {
				alert(result);
				userSearch();
			}
			
		}
	}catch(e){alert(e.description);}
};
function exportCsv() {
	alert("正在导出为CSV文件......请稍等");
}

var getCheckBoxValue = function() {
	/*得到所选择的值*/
	var str = "";
	$("[.jqgrow td input][checked]").each(function() {
		str += $(this).val() + ",";
	});
}

function setStockFlagVal(){
	$("#dev_stockflag").val($("#dev_stockflag2").val());
}
</script>
</head>
<body style="overflow-y:auto;">
<div>

	<!-- 查询条件选区    tabs_search_ctable(查询table样式) -->
			<table id="queryTable" width="100%" border="0" cellspacing="0" cellpadding="0" class="tabs_search_ctable_box">
				<tr>
					<td>
						<!-- 固定查询 -->
						<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tabs_search_ctable">
							   <tr>
									<th width="90" class="input_cx_title_th">设备编号：</th>
									<td width="296"  class="cx_title_td">
										<input type="text" name="dev_code" id="dev_code" class="input_cx_title_283" />
									</td>
									<td width="385"  colspan="2"  >
										<input value="搜索" id="sel" type="button" onclick="userSearch()" class="but_y_01"/>
										<span id="selAreaImg" class="all_search_condition"><a onclick="hiddenOrShowSelArea('hiddenArea','selAreaImg')" >更多搜索条件</a></span>
									</td>
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
								<th width="90" class="input_cx_title_th">设备名称：</th>
								<td>
									<input type="text" name="dev_name" id="dev_name" class="input_cx_title_283" />
								</td>
							</tr>
							<tr>
								<th width="90" class="input_cx_title_th">规格型号：</th>
								<td>
									<input type="text" name="type" id="type" class="input_cx_title_283" />
								</td>
							</tr>
							<tr>
								<td><p style="height: 5px"></p></td>
							</tr>
							<tr>
								<th width="90" class="input_cx_title_th" >使用部门：</th>
								<td class="cx_title_td">
									<input type="text" id="user_orgname" name="user_orgname" class="input_cx_title_283" >
								</td>
							</tr>
							<tr>
								<th width="90" class="input_cx_title_th" >保管人：</th>
								<td class="cx_title_td">
									<input type="text" id="custos_username" name="custos_username" class="input_cx_title_283" >
								</td>
							</tr>
							<tr id="stockflag" style="display: none;">
								<th width="90" class="input_cx_title_th" >类别：</th>
								<td class="cx_title_td">
									<select id="dev_stockflag2" name="dev_stockflag2" class="input_cx_title_283" onchange="setStockFlagVal()">
										<option value="" selected="selected">--请选择--</option>											
										<option value="3" >出租</option>											
										<option value="2" >借出</option>											
									</select>
									<input type="hidden" name="dev_stockflag" id="dev_stockflag"/>
								</td>
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
</div>
<form id="delForm2" name="delForm2" method="post" action="devaccountinfodo.jsp">
	<input type="hidden" name="delete" id="delete"> 
	<input type="hidden" name="action" value="deleteInf">
</form>

<iframe name="hiddenFrame2" width=0 height=0></iframe>
</body>
</html>
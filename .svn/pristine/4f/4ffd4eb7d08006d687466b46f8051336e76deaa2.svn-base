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
<title>入库台帐</title>
<script type="text/javascript">
var loginUserName = '<%=loginUserName%>';
$(function() {
	getCountDate();
	var _documentBodyHeight = window.top.findPageCacheName("_documentBodyHeight");
	var width=jQuery(window).width();
	if(width<800){
		jQuery("#maindiv").width(775);
	}
	$(document).keydown(function(){
		if(event.keyCode == 13){ 
			userSearch();
			getCountDate();
		}
	});
	$("#gridTable").jqGrid({
		url: '<%= path %>' + '/pubListServlet?classNameId=com.chinacreator.xtbg.tjy.officesupplies.list.OsAppObjectList',  //pubListServlet列表公共的servlet,classNameId在servletBean.xml文件中配置要调用的类,isPage:是否翻页(true,false),默认为true
		//jqGrid控件通过这个参数得到需要显示的数据，具体的返回值可以使XML也可以是Json
		datatype: "json",
		//这个参数用于设定将要得到的数据类型。我最常用的是“json”，其余的类型还包括：xml、xmlstring、local、javascript、function
		mtype: "POST",
		pageCached:false,
		//定义使用哪种方法发起请求，GET或者POST
		height: "100%",//270
		//Grid的高度，可以接受数字、%值、auto，默认值为150
		//width ：800, //Grid的宽度，如果未设置，则宽度应为所有列宽的之和；如果设置了宽度，则每列的宽度将会根据shrinkToFit选项的设置，进行设置。
		//shrinkToFit ：true 此选项用于根据width计算每列宽度的算法。默认值为true。如果shrinkToFit为true且设置了width值，则每列宽度会根据width成比例缩放；如果shrinkToFit为false且设置了width值，则每列的宽度不会成比例缩放，而是保持原有设置，而Grid将会有水平滚动条
		autowidth: true,
		//默认值为false。如果设为true，则Grid的宽度会根据父容器的宽度自动重算。重算仅发生在Grid初始化的阶段；如果当父容器尺寸变化了，同时也需要变化Grid的尺寸的话，则需要在自己的代码中调用setGridWidth方法来完成。
		colNames: ['主键ID','申购计划ID','物品分类ID','物品分类','物品id','物品名称','物品规格id','物品规格','入库人id','入库人','入库时间','入库数量','单价','总价'],
		//字符串数组，用于指定各列的题头文本，与列的顺序是对应的。
		colModel: [ //最重要的数组之一，用于设定各列的参数
        {
   			name: 't_os_ob_id',
   			index: 't_os_ob_id',
   			hidden:true
       	},{
       	   	name: 't_id',
   			index: 't_id',
   			hidden:true
       	},{
       	   	name: 'type_id',
   			index: 'type_id',
   			hidden:true
       	},{
       	   	name: 'type',
   			index: 'type',
   			width: 8
       	},{
       	   	name: 'ofustype_id',
   			index: 'ofustype_id',
   			hidden:true
       	},{
       	   	name: 'ofustype_name',
   			index: 'ofustype_name',
   			width: 8
       	},{
       	   	name: 'it_id',
   			index: 'it_id',
   			hidden:true
       	},{
       	   	name: 'it_name',
   			index: 'it_name',
   			width: 8
       	},{
       	   	name: 'rk_id',
   			index: 'rk_id',
   			hidden:true
       	},{
       	   	name: 'rk_name',
   			index: 'rk_name',
   			width: 8
       	},{
       	   	name: 'rk_date',
   			index: 'rk_date',
   			width: 8
       	},{
       	   	name: 't_os_ob_no',
   			index: 't_os_ob_no',
   			width: 8
       	},{
       	   	name: 'ofustype_money',
   			index: 'ofustype_money',
   			width: 8
       	},{
       	   	name: 'zongjia',
   			index: 'zongjia',
   			width: 8,
   			formatter:function(cellvalue, options, rowObject){
   				return rowObject.t_os_ob_no * rowObject.ofustype_money;
			}
       	}],
		sortname: 'rk_date',
		//指定默认的排序列，可以是列名也可以是数字。此参数会在被传递到Server端。
		sortorder: 'desc',
		viewrecords: true,
		
		//设置是否在Pager Bar显示所有记录的总数。
		rowNum: 10,
		//用于设置Grid中一次显示的行数，默认值为20。正是这个选项将参数rows（prmNames中设置的）通过url选项设置的链接传递到Server。注意如果Server返回的数据行数超过了rowNum的设定，则Grid也只显示rowNum设定的行数。
		rowList: [10, 20, 30],
		//一个数组，用于设置Grid可以接受的rowNum值。例如[10,20,30]
		gridComplete: function() {
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
		toolbar: [true,"top"],
		multiselect: false,
		onSelectRow: function(id) {
			//handle(id);
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
	 函数:  toUserParamJosn
	 说明:  构建要查询的参数
	 参数:   无
	 返回值: 返回要查询的参数
	 */
var toUserParamJosn = function() {
	var str = "{'ofustype_name':'"+$('#ofustype_name').val()+"',"+
		       "'start_time':'"+$('#startSlTime').val()+"',"+
		       "'end_time':'"+$('#endSlTime').val()+"',"+
		       "'rk_name':'"+$('#rk_name').val()+"',"+
		       "'unit_id':'<%=unit_id%>'}";
	return descape(escape(str));
}

function getCountDate(){
	var ofustype_name = jQuery("#ofustype_name").val();
	var start_time = jQuery("#startSlTime").val();
	var end_time = jQuery("#endSlTime").val();
	var rk_name = jQuery("#rk_name").val();
	var unit_id = "<%=unit_id%>";
	$.ajax({
		url:getCurrentFilePath()+'officetzdo.jsp',
		data:{"method":"getCountData",
			"ofustype_name" : ofustype_name,
			"start_time" : start_time,
			"end_time" : end_time,
			"rk_name" : rk_name,
			"unit_id"	: unit_id
		},
		type:'post',dataType:'json',
		contentType:"application/x-www-form-urlencoded;charset=UTF-8",
		success:function(data){
			if(data.code.code == 0){
				jQuery("#count_data").html(data.result.t_os_ob_no);
				jQuery("#count_money").html(data.result.ofustype_money);
			}else{
				jQuery("#count_date").html(0);
				jQuery("#count_money").html(0);
			}
		}
	})
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
								<th class="input_cx_title_th">物品名称：</th>
								<td width="300" class="cx_title_td"><input id="ofustype_name" name="ofustype_name" type="text" class="input_cx_title_283" /></td>
								<td width="600"  colspan="2"  ><input name="Input2" value="搜索" type="button" onclick="userSearch(),getCountDate();" class="but_y_01"/>
								<span id="selAreaImg" class="all_search_condition"><a onclick="hiddenOrShowSelArea('hiddenArea','selAreaImg')" >更多搜索条件</a></span>
								 &nbsp;&nbsp;&nbsp;&nbsp;
								<span style='color: red;'>入库总数：<span id='count_data'></span></span>
								<span style='color: red;'>入库总价：<span id='count_money'></span></span>
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
							<!-- 正规 4列 -->
							<tr>
								<th class="input_cx_title_th">入库时间：</th>
								<td  class="cx_title_td">
								<input id="startSlTime" name="startSlTime" type="text" class="date_120"　
								onFocus="var input_endtime=$dp.$('endSlTime');WdatePicker({onpicked:function(){endSlTime.focus();},dateFmt:'yyyy-MM-dd '})"   /> 
								<span class="date_120_span">至</span>
								 <input id="endSlTime" name="endSlTime" type="text"  class="date_120" 
								 onfocus="WdatePicker({minDate:'#F{$dp.$D(\'startSlTime\')}',dateFmt:'yyyy-MM-dd '})" />
								</td>
							</tr>
							<tr>
								<th class="input_cx_title_th">入库人：</th>
								<td  class="cx_title_td">
									<input id="rk_name" name="rk_name" type="text" class="input_cx_title_283" 　/> 
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
		<td><!-- 查询列表区 cGridArea(查询区样式)-->
		<div class="cGridArea" id="maindiv">
		<table id="gridTable"></table>
		<table width="98%">
   			<tbody>
   				<tr> 
   					<td rowspan="1" colspan="1" align="right">
   						
   					<br></td>
   				</tr>
   			</tbody>
   		</table>
		
		</div>
				<!-- 查询列表区 -->
		<br></td>
	</tr>
		
</table>
</body>
</html>
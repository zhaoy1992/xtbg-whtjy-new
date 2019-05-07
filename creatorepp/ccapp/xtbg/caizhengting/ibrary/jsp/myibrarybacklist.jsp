<%--
描述：我的借阅书籍已借阅界面
作者：童佳
版本：1.0
日期：2014-03-22  
--%>

<%@page import="com.chinacreator.xtbg.core.common.util.DateUtil"%>
<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.UserCache"%>
<%
	String path = request.getContextPath();
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	String user_id = accesscontroler.getUserID();//用户id
	
	String org_id = accesscontroler.getChargeOrgId();
	UserCacheBean userBean= UserCache.getUserCacheBean(accesscontroler.getUserID());
	String dept_id = userBean.getUnit_id();
	
	
	String tree_id = request.getParameter("id"); //图书类型ID 
	
	String nowDateString = DateUtil.getCurrentDate();                    //当前日期
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=gbk">
	<title></title>
	<!-- 引入jQuery -->
	<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
	<!-- 引入jQuery UI -->
	<link id="uiThemes" rel="stylesheet" type="text/css" media="screen" href="../../../resources/plug/jquery-ui-1.8.17.custom/css/custom-theme/jquery-ui-1.8.17.custom.css" />
	<script src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>
	<!-- 引入formvValidatetion -->
	<script src="../../../resources/plug/formvalidation/jquery.validationEngine-cn.js" type="text/javascript" charset="utf-8"></script>
	<script src="../../../resources/plug/formvalidation/jquery.validationEngine.js" type="text/javascript" charset="utf-8"></script>
	<!-- 引入其它 -->
	<script src="../../../resources/js/util/public.js" type="text/javascript"></script>
	<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
	<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
	<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js" charset="utf-8"></script>
	<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
	<!-- 引入jGrid -->
	<script src="../../../resources/plug/jquery.jqGrid-4.3.1/js/i18n/grid.locale-en.js"  charset="utf-8" type="text/javascript"></script>
	<script src="../../../resources/plug/jquery.jqGrid-4.3.1/js/jquery.jqGrid.min.js"  charset="utf-8" type="text/javascript"></script>
		<!--  引入时间控件 -->
	<script src="../../../resources/plug/My97DatePicker/WdatePicker.js"	type="text/javascript"></script>
</head>
<body style="overflow-x: auto;">
<script>
$(function(){
	initTable();
});
/*
 函数:  search
 参数:   无
 */
function search() {
	var sdata = { //构建查询需要的参数 
		paramJson : toParamJosn()
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

var delCarInfo = function(){
	 var ids = "";
		var selectedIds = $("#gridTable").jqGrid("getGridParam", "selarrrow");
		for ( var i = 0; i < selectedIds.length; i++) {
			var model = jQuery("#gridTable").jqGrid('getRowData',selectedIds[i]);
			if ("" != ids) {
				ids += ",";
			}
			ids += "'" + model.book_id + "'";
		}
		if (IsSpace(ids)) {
			alert("请选择要删除的记录！");
		} else {
			var okF = function(){
				jQuery("#book_id").val(ids);
				jQuery("#actiontype").val("del");
				var fm = document.getElementById("form1");
				fm.target = "filetypelisthiddenFrame";
				fm.submit();
			}
			var p={
					headerText:'提示',
					okName:'确认',
				    okFunction:okF,
				    cancelName:'取消'
				};
			alert('确定要删除吗？',p)
		}
}

var updateactuvuty = function(id) {
	var model = jQuery("#gridTable").jqGrid('getRowData', id);
	var url = "<%=path%>/ccapp/xtbg/caizhengting/ibrary/jsp/ibraryborrowadd.jsp?subid=queryinfo&t_regb_id="+model.t_regb_id+"&sqtype="+model.t_regb_sqtype;
	openWindows('queryinfo','图书申请信息',url,'queryinfo',false,window);
	//location.href = url;
}

function reset(){
	$("#jy_start_time").val("");//借阅开始时间
	$("#jy_end_time").val("");//借阅结束时间
	search();//查询
}

function checktime(){
	var booker_start_time = jQuery("#jy_start_time").val();//开始时间
	var booker_end_time = jQuery("#jy_end_time").val();//结束时间
	if(booker_start_time != "" && booker_end_time != ""){
		var start_time = booker_start_time;//开始时间
		start_time = start_time.replace(/-/g,"/");
		start_time = new Date(start_time);
		
		var end_time = booker_end_time;//结束时间
		end_time = end_time.replace(/-/g,"/");
		end_time = new Date(end_time);
		if(start_time>end_time){
			 alert('开始时间大于结束时间，请重新选择');
		}
	}
}
</script>
<%--query table end--%>
<table width="100%" style="margin-left: 0" class="tabs_search_ctable_box">
	<tr>
		<td>
			<!-- 查询条件选区    tabs_search_ctable(查询table样式) -->
			<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tabs_search_ctable_box">
					<tr>
						<td>
							<!-- 固定查询 -->
							<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tabs_search_ctable">
								<tr>
									<th width="90" class="input_cx_title_th" >借阅时间：</th>
									<td class="cx_title_td" colspan="">
									<input type="text" class="date_187" style="width:130px;"
										id="jy_start_time" name="jy_start_time" onchange="checktime()"
										onfocus="WdatePicker({onpicked:function(){jy_end_time.focus();},dateFmt:'yyyy-MM-dd'})" />
										<span class="date_120_span">至</span>
									<input type="text" class="date_187" style="width:130px;"
											id="jy_end_time" name="jy_end_time" onchange="checktime()"
											onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" />
								    </td>
									<td width="385"  colspan="4"  >
									<input name="search" value="搜索" type="button" 
									onclick="search()" class="but_y_01"/>
									<input name="reset" value="重置" type="button" 
									onclick="reset()" class="but_y_01"/>
									<span id="selAreaImg" class="all_search_condition">
									</span></td>
								</tr>
							</table>
							<!-- 固定查询 end-->
						</td>
					</tr>
					
			</table>
		<!-- 查询条件选区    tabs_search_ctable(查询table样式) -->
		</td>
	</tr>
	<tr>
		<td width="100%" align="left" valign="top">
		<div style="float:left;width:100%;margin-left: -10px" class="cGridArea">
			<table id="gridTable"></table>
			<div id="gridPager"></div>
		</div>
		<script>
		function toParamJosn(){
			var jy_start_time = jQuery("#jy_start_time").val();
			var jy_end_time = jQuery("#jy_end_time").val();
			var str = "{'whatTabs':'2','jy_start_time':'"+jy_start_time+"','jy_end_time':'"+jy_end_time+"','t_regb_gh_date':'<%=nowDateString%>','t_regb_user_id':'<%=user_id%>'}";
			return descape(escape(str));
		}
		 /**
		  *计算请假时间
		  */
		  function mathLeaveDays(startTime,endTime){
			  var start_date= new Date(Date.parse(startTime.replace(/-/g,  "/")));  
			  var end_date= new Date(Date.parse(endTime.replace(/-/g,  "/")));  
			  var days = (end_date - start_date)/1000/60/60/24;
			  return days;
		  }
	
		$(document).keydown(function(){
			if(event.keyCode == 13){
			   search();
			}
		});
		initTable = function (){
		$("#gridTable").jqGrid({
			url: '<%= path %>' + '/commonListServlet?classNameId=czt_ibraryRegBookInfoList',  //commonListServlet列表公共的servlet,classNameId在servletBean.xml文件中配置要调用的类,isPage:是否翻页(true,false),默认为true
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
			colNames: ['t_regb_id','t_regb_user_id','申请人','申请类型','图书ids','图书名称','借阅时间','应归还时间','申请状态'],
			//字符串数组，用于指定各列的题头文本，与列的顺序是对应的。
			colModel: [ //最重要的数组之一，用于设定各列的参数
				{
		        	name: 't_regb_id',index: 't_regb_id',width: '60',sortable:false,hidden:true
				},
		        {
		        	name: 't_regb_user_id',index: 't_regb_user_id',width: '40',sortable:false,hidden:true
				},
				{
					name: 't_regb_user_name',index: 't_regb_user_name',width: '40',sortable:true
				},
				{
					name: 't_regb_sqtype',index: 't_regb_sqtype',width: '40',sortable:true
				},
				{
					name: 't_regb_bookids',index: 't_regb_bookids',width: '40',sortable:false,hidden:true
				},
				{
					name: 't_regb_booknames',index: 't_regb_booknames',width: '200',sortable:true
				},
				{
					name: 't_regb_jy_date',index: 't_regb_jy_date',width: '40',sortable:true
				},
				{
					name: 't_regb_gh_date',index: 't_regb_gh_date',width: '30',sortable:true
				},
				{
					name: 't_regb_state',index: 't_regb_state',width: '30',sortable:true
				}
			],
			viewrecords: true,
			sortname:'t_regb_jy_date',
			sortorder:'desc',
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
					
					var days = mathLeaveDays('<%=nowDateString%>',model.t_regb_gh_date);
					if(model.t_regb_state == "6"){
						col = "<strong><span class=rowhighlight>待续借</span></a></strong>";
					}else{
						if(days <= 7) {
							col = "<strong><span class=rowhighlight>待续期</span></a></strong>";
						} else {
							col = "<strong><span class=rowhighlight>已借阅</span></a></strong>";
						}
					}
					jQuery("#gridTable").jqGrid('setRowData', ids[i], {
						t_regb_state: col
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
			//caption: "草稿箱",
			//设置Grid表格的标题，如果未设置，则标题区域不显示。
			search : toParamJosn(),
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
			
			onCellSelect:function(rowid,iCol){
				if(iCol != 0)
				{
					updateactuvuty(rowid);
				}
			}
		}).navGrid('#gridPager', {
			edit: false,
			add: false,
			del: false,
			search:false,
			refresh:false
		});};
		</script>
		</td>
	</tr>
</table>
<form id="form1" name="form1" method="post" action="ibrarybookinfoDo.jsp" target="filetypelisthiddenFrame">
<input type='hidden' name='action' id="hidden_action"/>
<input type='hidden' name='book_id' id="book_id"/>
<input type='hidden' name='actiontype' id="actiontype"/>
</form>
<iframe name="filetypelisthiddenFrame" width=0 height=0></iframe>
</body>
</html>
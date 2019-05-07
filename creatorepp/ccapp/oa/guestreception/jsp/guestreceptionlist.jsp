<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="java.util.Set"%>
<%@ page import="java.util.HashSet"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%
	String path = request.getContextPath();
	String grinfoIds = "";
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	String loginUserName = accesscontroler.getUserAccount();
	String userid = accesscontroler.getUserID();
	String GET_LIST_CLASS="com.chinacreator.xtbg.core.guestreception.list.GuestreceptionList";
%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<!-- 引入jQuery UI -->
<script src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>
<!-- 引入my97时间控件 -->
<script src="../../resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>	
<!-- 引入jGrid -->
<script src="../../resources/plug/jquery.jqGrid-4.3.1/js/i18n/grid.locale-en.js" type="text/javascript"></script>
<script src="../../resources/plug/jquery.jqGrid-4.3.1/js/jquery.jqGrid.min.js" type="text/javascript"></script>
<!-- 引入其它 -->
<script src="../../resources/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<!-- 公共部分引用结束 -->
<title>待办列表</title>
<script type="text/javascript">
var loginUserName = '<%=loginUserName%>';
var loginUserID=<%=userid%>;
var grinfoIds='<%=grinfoIds%>';
var orgID=null;
$(function() {
	//查询绑定回车
	$(document).keydown(function(){
		if(event.keyCode == 13){ 
			userSearch();
		}
	})
	
	
	$("#gridTable").jqGrid({
		url: '<%=path%>' + '/pubListServlet?classNameId=<%=GET_LIST_CLASS%>',  //commonListServlet列表公共的servlet,classNameId在servletBean.xml文件中配置要调用的类,isPage:是否翻页(true,false),默认为true
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
		colNames: ['接待信息id','主题','宾客单位','抵达时间','离开时间','陪同人员','状态'],
		//字符串数组，用于指定各列的题头文本，与列的顺序是对应的。
		colModel: [ //最重要的数组之一，用于设定各列的参数
		 {
		  name: 'grinfo_id',
		  index: 'grinfo_id',
		  hidden:true
		 },	
		 {
   			name: 'grinfo_titile',
   			index: 'grinfo_titile',
   			edit:false,
   			width: '180' ,
   			sortable: false,
   			editable: true
   		},
   		{
   			name: 'grinfo_receptionorg',
   			index: 'grinfo_receptionorg',
   			width: '60',
   			sortable: false
    	},
    	{
   			name: 'grinfo_startime',
   			index: 'grinfo_startime',
   			width: '80',
   			sortable: true,
   			formatter:publicFormatterMeetingDate
    	},
    	{
   			name: 'grinfo_endtime',
   			index: 'grinfo_endtime',
   			width: '80',
   			sortable: false,
   			formatter:publicFormatterMeetingDate
    	},
    	{
   			name: 'accompany',
   			index: 'accompany',
   			width: '60',
   			classes: 'zebra-striped',
   			sortable: false
    	},
    	{
   			name: 'grstatus_name',
   			index: 'grstatus_name',
			width: '40',
   			sortable: false
   			
    	}
		],
		sortname: 'grinfo_startime',
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
				if(model.grstatus_name=="已发布"){
					$("#jqg_gridTable_" + cl).replaceWith("<img src='../resources/images/yincangcheckbox.jpg'/>");
				}
			}
		},
		
		jsonReader: { //这又是一个数组，用来设定如何解析从Server端发回来的json数据
			repeatitems: false
		},
		//pager: "#gridPager",
		pagerintoolbar:true,//上面的分页条
		pagerinBottombar:true,//下面的分页条
		//定义页码控制条Page Bar
		//caption: "",
		//设置Grid表格的标题，如果未设置，则标题区域不显示。
		search : toUserParamJosn(),
		filterNames:["statusname"],
		filterOptions:[[["--发布状态--","--发布状态--"],["未发布","未发布"],["已发布","已发布"]]],//alue text 后的值与显不
		filterOptionsDefValue:[0],
		prmNames: { //这是一个数组，用于设置jqGrid将要向Server传递的参数名称
			rows: "rows",
			//表示请求行数的参数名称  
			sort: "sidx",
			//表示用于排序的列名的参数名称  
			order: "sord",
			//表示采用的排序方式的参数名称 
			search : "search"
		},
		toolbar: [true,"top","<input class='but_y_01' onMouseOver=javascript:$(this).attr('class','but_y_02'); onMouseOut=javascript:$(this).attr('class','but_y_01'); id=add type='button' onclick='addguestinfo()' value='添加' /><input type='button'  onclick='deleteFlowInfo()' class='but_y_01' onMouseOver=javascript:$(this).attr('class','but_y_02'); onMouseOut=javascript:$(this).attr('class','but_y_01'); value='删除' /><input type='button'  onclick='updatestatus()' class='but_y_01' onMouseOver=javascript:$(this).attr('class','but_y_02'); onMouseOut=javascript:$(this).attr('class','but_y_01'); value='发布' />"],
		multiselect: true,
		onCellSelect:function (id,icol)
		{
			if(icol != 0)
				{
				jQuery("#gridTable").setSelection(id,false);
				editguestinfo(id);
				}
		}
		
	}).navGrid('#gridPager', {
		edit: false,
		add: false,
		del: false,
		search:false,
		refresh: false
	});

	
	
	//工具栏按钮
	//$("#t_gridTable").append("<div>")
	//.append("<input class='but_y_01' id=add type='button' onclick='addguestinfo()' value='添加' />")
	//.append("<input type='button'  onclick='deleteFlowInfo()' class='but_y_01' value='删除' />")
	//.append("<input type='button'  onclick='updatestatus()' class='but_y_01' value='发布' />")
	
	//.append("</div>");


});
/**
 * 修改
 */

var editguestinfo = function(id) {
	var status=1;
	var url="";
	var windowName="";
	var model = jQuery("#gridTable").jqGrid('getRowData', id);
	if(model.grstatus_name=='已发布'){
		windowName="来宾接待详细";
		url = "guestreceptionview.jsp?grinfo="+model.grinfo_id+"&loginUserID="+loginUserID+"&from=1";
	}else{
		windowName="来宾接待修改";
		url = "guestreceptionaddnew.jsp?grinfo="+model.grinfo_id+"&statusname="+status;
	}
	openWindows("sub_lbjdmain"+id,windowName,".././jsp/"+url+"&subid=sub_lbjdmain"+id,'lbjdmain',false,window);

}

/**
 * 删除
 */
var deleteFlowInfo = function() {
	var ids = "";
	var selectedIds = $("#gridTable").jqGrid("getGridParam", "selarrrow");
	for(var i = 0; i < selectedIds.length; i++) {
		var model = jQuery("#gridTable").jqGrid('getRowData', selectedIds[i]);
		 if(model.grstatus_name!="已发布"){
			 if("" != ids){			   
					ids += ",";
				 }
			 ids += model.grinfo_id;
		 }
		 
	}
	if (IsSpace(ids)) {
		alert("请选择要删除的记录！");
	} else {
			var okF = function(){	
			//$("#qxids").val(ids);
			//var fm = document.getElementById("qxfbForm");
			//fm.target = "hiddenFrame";
			//fm.submit();
			var url = "guestreceptionadddonew.jsp?whatDo=4";
			$("#grinfo_id").val(ids);
			document.all.form1.action = url;
			document.all.form1.target = "hiddenFrame";
			document.all.form1.submit();
			}
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
函数:  userSearch
说明:  查询用户信息
参数:   无
返回值: 用户列表
*/
var userSearch = function() {
var sdata = { //构建查询需要的参数 
//	paramJson: toUserParamJosn()
}; //获得当前postData选项的值  
var postData = $("#gridTable").jqGrid("getGridParam", "postData"); //将查询参数融入postData选项对象  
$.extend(postData, sdata);
$("#gridTable").jqGrid("setGridParam", {
	search: true ,// 将jqGrid的search选项设为true  
	userFilters : toUserParamJosn()
}).trigger("reloadGrid", [{
	page: 1
}]); //重新载入Grid表格，以使上述设置生效 
}

/*
函数:  publicFormatterMeetingDate
说明:  格式化时间到分，秒舍去
*/
function publicFormatterMeetingDate(dStr){
	return (isSpace(dStr)||dStr.length!=19)?"": dStr.substring(0,16);
}

/*
函数:  clearSearch
说明:  重置
参数:   无
返回值: 无
*/
var clearSearch = function() {
	resetSingleSearchDialog();
var sdata = {
	paramJson: toUserParamJosn()
};
var postData = $("#gridTable").jqGrid("getGridParam", "postData");
$.extend(postData, sdata); //将postData中的查询参数覆盖为空值  
$("#gridTable").jqGrid("setGridParam", {
	search: true // 将jqGrid的search选项设为false  
}).trigger("reloadGrid", [{
	page: 1
}]);

};

	/*
	 函数:  toUserParamJosn
	 说明:  构建要查询的参数
	 参数:   无
	 返回值: 返回要查询的参数
	 */
var toUserParamJosn = function() {
		 //alert(222);
	var str = "{'grinfo_titile':'"+$("#grinfo_titile").val()+"','grinfo_receptionorg':'"+$("#grinfo_receptionorg").val()+"',"+
			  "'grinfo_startime':'"+$('#grinfo_startime').val()+"','grinfo_endtime':'"+$("#grinfo_endtime").val()+"',"+
			  "'grinfo_sendpersonid':'"+loginUserID+"'}";
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
	var model = jQuery("#gridTable").jqGrid('getRowData', id);
	showFlowHistoryByInsId(model.ins_id);
}


function chooseOrg(id){
	var url = "../../tree/jsp/orgtree.jsp?";
	 var orgObj= null;
	 orgObj = window.showModalDialog(url,"","dialogWidth=286px;dialogHeight=596px;center:yes;scroll:no");
	 if(!IsSpace(orgObj)){
		 var name=orgObj.name;
			orgID=orgObj.id;
			$("#org_name").val(name);
	 }
	
}

var addguestinfo = function() {
	openWindows("sub_lbjdmain","来宾接待添加",".././jsp/guestreceptionaddnew.jsp?subid=sub_lbjdmain",'lbjdmain',false,window);
	//var url = "guestreceptionAdd1.jsp";
	//location.href = url;
}

/**
 * 更新发布状态
 */
function updatestatus(){
	var ids = "";
	var selectedIds = $("#gridTable").jqGrid("getGridParam", "selarrrow");
	for(var i = 0; i < selectedIds.length; i++) {
		var model = jQuery("#gridTable").jqGrid('getRowData', selectedIds[i]);
		 if("" != ids){			   
			ids += ",";
		 }
		 ids += model.grinfo_id;
		 
	}
	if (IsSpace(ids)) {
		alert("请选择要发布的记录！");
	} else {
		var okF = function(){	
			//$("#qxids").val(ids);
			//var fm = document.getElementById("qxfbForm");
			//fm.target = "hiddenFrame";
			//fm.submit();
			var url = "guestreceptionadddonew.jsp?whatDo=5";
			$("#grinfo_id").val(ids);
			document.all.form1.action = url;
			document.all.form1.target = "hiddenFrame";
			document.all.form1.submit();
			}
			var p={
					headerText:'提示',
					okName:'确认',
			        okFunction:okF,
			        cancelName:'取消'
			};
		alert("确定要发布该信息吗？",p)
	}
}

window.onload = function () {
	setDataTimeClickShowOrHide('grinfo_startime',window);
	setDataTimeClickShowOrHide('grinfo_endtime',window);
}

</script>
</head>
<body>
	<table width="100%">
		<tr>
			<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="0"
					class="tabs_search_ctable_box" id="queryTable">
					<tr>
						<td>
							<table width="100%" border="0" cellspacing="0" cellpadding="0"
								class="tabs_search_ctable">
								<tr>
									<td>
									<!-- 固定查询 -->
										<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tabs_search_ctable">
											<tr>
												<th width="90" class="input_cx_title_th">主题：</th>
												<td width="296" class="cx_title_td">
													<input name="grinfo_titile" id="grinfo_titile" type="text"
														class="input_cx_title_283" />
												</td>
												<td width="385" colspan="2">
													<input name="Input2" value="搜索" type="button"
														onclick="userSearch()" class="but_y_01" />
													<span id="selAreaImg" class="all_search_condition">
														<a onclick="hiddenOrShowSelArea('hiddenArea','selAreaImg')">更多搜索条件</a>
													</span>
												</td>
											</tr>
										</table>
									<!-- 固定查询 end-->
									</td>
								</tr>
								<tr>
									<td>
									<!-- 隐藏查询 -->
										<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tabs_search_ctable" id="hiddenArea" style="display: none">
											<tr>
												<th class="input_cx_title_th">抵达时间：</th>
												<td class="cx_title_td">
													<input type="text" id="grinfo_startime" name="grinfo_startime"
														class="date_120"
														onclick="WdatePicker({maxDate:'#F{$dp.$D(\'grinfo_endtime\')}',dateFmt:'yyyy-MM-dd'})" />
													<span class="date_120_span">至</span>		
													<input type="text" id="grinfo_endtime" name="grinfo_endtime"
														class="date_120"
														onclick="WdatePicker({minDate:'#F{$dp.$D(\'grinfo_startime\')}',dateFmt:'yyyy-MM-dd'})" />
												</td>
												<th class="input_cx_title_th">宾客单位：</th>
												<td class="cx_title_td">
													<input id="grinfo_receptionorg" name="text" type="text"
														class="input_cx_title_283" />
												</td>
											</tr>
										</table>
									<!-- 隐藏查询 end-->
									</td>
								</tr>
							</table>
							
						</td>
					<tr>
				</table>
			</td>
		</tr>
		<tr>
			<td>
				<div class="cGridArea">
					<table id="gridTable"></table>
					<div id="gridPager"></div>
				</div>
			</td>
		</tr>
	</table>
	<form id="form1" name="form1" method="post" >
  	<input id="grinfo_id" name="grinfo_id" type="hidden"/>
	</form>
	<iframe name="hiddenFrame" width=0 height=0></iframe>

</body>
</html>

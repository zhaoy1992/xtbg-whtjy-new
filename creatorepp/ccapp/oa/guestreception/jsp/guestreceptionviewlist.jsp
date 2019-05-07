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
	String grinfoIds="";
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	String loginUserName = accesscontroler.getUserAccount();
	String userid = accesscontroler.getUserID();
	
	String GET_LIST_CLASS="com.chinacreator.xtbg.core.guestreception.list.GuestreceptionReceiveList";
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
var loginUserID='<%=userid%>';
var grinfoIds='<%=grinfoIds%>';
var orgID=null;
$(function() {
	
	//查询绑定回车
	$(document).keydown(function(){
		if(event.keyCode == 13){ 
			userSearch1();
		}
	})
	//接收表
	$("#gridTable1").jqGrid({
		url: '<%= path %>' + '/pubListServlet?classNameId=<%=GET_LIST_CLASS%>',  //commonListServlet列表公共的servlet,classNameId在servletBean.xml文件中配置要调用的类,isPage:是否翻页(true,false),默认为true
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
		colNames: ['接待信息id','主题','发布人','发布单位','宾客单位','接待时间','结束时间','状态','批示状态'],
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
   			width: '180px',
   			sortable: false
   		},
   		{
   			name: 'user_realname',
   			index: 'user_realname',
   			edit:false,
   			width: '60px',
   			sortable: false
   		},
   		{
   			name: 'grinfo_org',
   			index: 'grinfo_org',
   			edit:false,
   			width: '60px',
   			sortable: false
   		},
   		{
   			name: 'grinfo_receptionorg',
   			index: 'grinfo_receptionorg',
   			sortable: false
    	},
    	{
   			name: 'grinfo_startime',
   			index: 'grinfo_startime',
   			sortable: false
    	},
    	{
   			name: 'grinfo_endtime',
   			index: 'grinfo_endtime',
   			sortable: false
    	},
    	
    	{
   			name: 'grstatus_name',
   			index: 'grstatus_name',
   			sortable: false,
   			width: '60px'
    	},
    	{
   			name: 'static',
   			index: 'static',
   			sortable: false,
   			width: '60px',
   			hidden:true
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
			
			var ids = $("#gridTable1").getDataIDs(); //jqGrid('getDataIDs');
			//alert(ids.length)
			var col="";
			for (var i = 0; i < ids.length; i++) {
				var cl = ids[i];
				var model = jQuery("#gridTable1").jqGrid('getRowData', cl);
				//alert(model.grstatus_name)
				    
				if(model.grstatus_name == '未查看') {
					col = "<strong><span class=rowhighlight>"+model.grstatus_name+"</span></a></strong>";
					 endtime = "<strong><span class=rowhighlight>"+model.grinfo_endtime.substring(0,16)+"</span></a></strong>";
					 startime = "<strong><span class=rowhighlight>"+model.grinfo_startime.substring(0,16)+"</span></a></strong>";
					 tionorg = "<strong><span class=rowhighlight>"+model.grinfo_receptionorg+"</span></a></strong>";
					 titile = "<strong><span class=rowhighlight>"+model.grinfo_titile+"</span></a></strong>";
					 person = "<strong><span class=rowhighlight>"+model.user_realname+"</span></a></strong>";
					 org = "<strong><span class=rowhighlight>"+model.grinfo_org+"</span></a></strong>";
				} else {
					
					col = model.grstatus_name,
					endtime = model.grinfo_endtime.substring(0,16),
					startime = model.grinfo_startime.substring(0,16),
					tionorg = model.grinfo_receptionorg,
					titile = model.grinfo_titile,
					person = model.sendperson,
					org = model.grinfo_org
					
				}
				jQuery("#gridTable1").jqGrid('setRowData', ids[i], {
					grstatus_name: col,
					grinfo_endtime:endtime,
					grinfo_startime : startime,
					grinfo_receptionorg : tionorg,
					grinfo_titile:titile,
					user_realname : person,
					grinfo_org : org
				});
			}
		},
		
		jsonReader: { //这又是一个数组，用来设定如何解析从Server端发回来的json数据
			repeatitems: false
		},
		//pager: "#gridPager1",
		pagerintoolbar:true,//上面的分页条
		pagerinBottombar:true,//下面的分页条
		//定义页码控制条Page Bar
		//caption: "",
		//设置Grid表格的标题，如果未设置，则标题区域不显示。
		search : toUserParamJosn1(),
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
			editguestinfo1(id);
		}
	}).navGrid('#gridPager1', {
		edit: false,
		add: false,
		del: false,
		search:false,
		refresh: false
	});
	
	
	//工具栏按钮
	$("#t_gridTable").append("<div>")
	.append("<input class='add' id=add type='button' onclick='addguestinfo()' />")
	.append("<input type='button'  onclick='deleteFlowInfo()' class='del' />")
	.append("<input type='button'  onclick='updatestatus()' class='publish' />")
	.append("</div>");

	

});
/**
 * 修改
 */

var editguestinfo1 = function(id) {
	
	var status=1;
	var model = jQuery("#gridTable1").jqGrid('getRowData', id);
	if(model.grstatus_name=='已发布'){
		status= 2;
	}
	
	var url = "guestreceptionview.jsp?grinfo="+model.grinfo_id+"&grstatus_name="+status+"&loginUserID="+loginUserID+"&from=2&feedbackStatus="+model.feedbackStatus;
	openWindows("sub_lbjdview"+id,"来宾接待信息查看",".././jsp/"+url+"&subid=sub_lbjdview"+id,'lbjdview',false,window);

}
/**
 * 删除
 */
var deleteFlowInfo = function() {
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
		alert("请选择要删除的记录！");
	} else {
		if (!confirm("确定要删除信息吗？")) {
			return;
		}
		var url = "guestreceptonDelete.jsp";
		$("#grinfoid").val(ids);
		document.all.form1.action = url;
		document.all.form1.target = "hiddenFrame";
		document.all.form1.submit();
	}
}

/*
函数:  publicFormatterMeetingDate
说明:  格式化时间到分，秒舍去
*/
function publicFormatterMeetingDate(dStr){
	return (isSpace(dStr)||dStr.length!=19)?"": dStr.substring(0,16);
}


/*
函数:  userSearch
说明:  查询用户信息
参数:   无
返回值: 用户列表
*/
var userSearch1 = function() {
var sdata = { //构建查询需要的参数 
	paramJson: toUserParamJosn1()
}; //获得当前postData选项的值  
var postData = $("#gridTable1").jqGrid("getGridParam", "postData"); //将查询参数融入postData选项对象  
$.extend(postData, sdata);
$("#gridTable1").jqGrid("setGridParam", {
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
var clearSearch1 = function() {
	resetSingleSearchDialog();
var sdata = {
	paramJson: toUserParamJosn1()
};
var postData = $("#gridTable1").jqGrid("getGridParam", "postData");
$.extend(postData, sdata); //将postData中的查询参数覆盖为空值  
$("#gridTable1").jqGrid("setGridParam", {
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
var toUserParamJosn1 = function() {
	//alert(grinfoIds);
var str = "{'grinfo_titile':'"+$("#guestInfoTitle").val()+"','grinfo_receptionorg':'"+$("#guestorg").val()+"',"+
		  "'grinfo_startime':'"+$('#grinfo_startime').val()+"','grinfo_endtime':'"+$("#grinfo_endtime").val()+"',"+
		  "'grinfo_id':'"+ grinfoIds +"','grinfo_sendpersonid':'"+loginUserID+"'}";
		 // alert(str)
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
	var url = "../../../tree/jsp/orgtree.jsp?";
	 var orgObj= null;
	 orgObj = window.showModalDialog(url,"","dialogWidth=286px;dialogHeight=596px;center:yes;scroll:no");
	 if(!IsSpace(orgObj)){
		 var name=orgObj.name;
			orgID=orgObj.id;
			$("#org_name").val(name);
	 }
	
}

var addguestinfo = function() {
	var url = "guestreceptionadd.jsp";
	location.href = url;
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
		if (!confirm("确定要发布信息吗？")) {
			return;
		}
		var url = "guestreceptonmodifystatus.jsp";
		$("#grinfoid").val(ids);
		document.all.form1.action = url;
		document.all.form1.target = "hiddenFrame";
		document.all.form1.submit();
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
													<input name="guestInfoTitle" id="guestInfoTitle" type="text"
														class="input_cx_title_283" />
												</td>
												<td width="385" colspan="2">
													<input name="Input2" value="搜索" type="button"
														onclick="userSearch1()" class="but_y_01" />
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
													<input id="guestorg" name="text" type="text"
														class="input_cx_title_283" />
												</td>
											</tr>
										</table>
									<!-- 隐藏查询 end-->
									</td>
								</tr>
							</table>
							<!-- 固定查询 end-->
						</td>
					<tr>
				</table>
			</td>
		</tr>
		<tr>
			<td>
				<div class="cGridArea">
					<table id="gridTable1"></table>
					<div id="gridTable1"></div>
				</div>
			</td>
		</tr>
	</table>
	<form id="form1" name="form1" method="post" >
  	<input id="grinfoid" name="grinfoid" type="hidden"/>
	</form>
	<iframe name="hiddenFrame" width=0 height=0></iframe>
</body>
</html>
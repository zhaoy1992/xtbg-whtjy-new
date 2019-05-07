<%@page import="com.chinacreator.xtbg.pub.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.pub.util.DictDropDownList"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="com.chinacreator.xtbg.pub.util.DaoUtil" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%
	String path = request.getContextPath();
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	String userid = accesscontroler.getUserID();
	String loginUserName = accesscontroler.getUserAccount();
	//车辆ID
	String car_id = StringUtil.deNull(request.getParameter("car_id"));
	
%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>特检院油卡使用记录管理</title>

<!-- 引入jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>

<!-- 引入my97时间控件 -->
<script src="../../../resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>

<!-- 引入jQuery UI -->
<link id="uiThemes" rel="stylesheet" type="text/css" media="screen" href="../../../resources/plug/jquery-ui-1.8.17.custom/css/custom-theme/jquery-ui-1.8.17.custom.css" />
<script src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>

<!-- 引入jGrid -->
<link rel="stylesheet" type="text/css" media="screen" href="../../../resources/plug/jquery.jqGrid-4.3.1/css/ui.jqgrid.css" />
<script src="../../../resources/plug/jquery.jqGrid-4.3.1/js/i18n/grid.locale-en.js" type="text/javascript"></script>
<script src="../../../resources/plug/jquery.jqGrid-4.3.1/js/jquery.jqGrid.min.js" type="text/javascript"></script>

<!-- 引入其它 -->
<script src="../../../resources/js/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-tree.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../public/flowinfoconfig/resources/js/tree.js" charset="utf-8"></script>
<!--  公共部分调用结束 -->
<script type="text/javascript">
var loginUserName='<%=loginUserName%>';
var loginUserID=<%=userid%>;
var car_id ="<%=car_id%>"; //车辆ID
$(function() {
	
	//查询绑定回车
	$(document).keydown(function(){
		if(event.keyCode == 13){ 
			userSearch();
		}
	})
	//接收表
	$("#gridTable").jqGrid({
		url: '<%= path %>' + '/commonListServlet?classNameId=fuelcardhistorylist',  //commonListServlet列表公共的servlet,classNameId在servletBean.xml文件中配置要调用的类,isPage:是否翻页(true,false),默认为true
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
		colNames: ['fuelcard_id','car_id','加油\\充值金额','记录类型','登记时间','备注'],
		//字符串数组，用于指定各列的题头文本，与列的顺序是对应的。
		colModel: [ //最重要的数组之一，用于设定各列的参数
          {
  		  	name: 'fuelcard_id',
  		  	index: 'fuelcard_id',
  		  	hidden:true,
  		  	align:'left'
  		 },
         {
		  	name: 'car_id',
		  	index: 'car_id',
		  	hidden:true,
		  	align:'left'
		 },
		 {
			name: 'fuelcard_money',
			index: 'fuelcard_money',
			width: '80px',
			align:'left'
		 },
		 {
	   		name: 'fuelcard_type',
	   		index: 'fuelcard_type',
	   		width: '80px'
	   	},
		 {
	   		name: 'fuelcard_time',
	   		index: 'fuelcard_time',
	   		width: '80px'
	   	},
		 {
	   		name: 'fuelcard_remark',
	   		index: 'fuelcard_remark',
	   		width: '80px'
	   	}
		],
		sortname: 'fuelcard_time',
		//指定默认的排序列，可以是列名也可以是数字。此参数会在被传递到Server端。
		sortorder: 'desc',
		viewrecords: true,
		//设置是否在Pager Bar显示所有记录的总数。
		rowNum: 10,
		//用于设置Grid中一次显示的行数，默认值为20。正是这个选项将参数rows（prmNames中设置的）通过url选项设置的链接传递到Server。注意如果Server返回的数据行数超过了rowNum的设定，则Grid也只显示rowNum设定的行数。
		rowList: [10, 20, 30],
		//一个数组，用于设置Grid可以接受的rowNum值。例如[10,20,30]
		gridComplete: function() { // var idss=jQuery("#gridTable").jqGrid('getColNames');
			var ids = $("#gridTable").getDataIDs(); //jqGrid('getDataIDs');
			for (var i = 0; i < ids.length; i++) {
				 var cl = ids[i];
				 var model = jQuery("#gridTable").jqGrid('getRowData', cl);
				 
				 ycsj = model.use_starttime+" 至 "+model.use_endtime;
				
				 jQuery("#gridTable").jqGrid('setRowData', ids[i], {
					use_starttime: ycsj
				});
			}
		},
		
		jsonReader: { //这又是一个数组，用来设定如何解析从Server端发回来的json数据
			repeatitems: false
		},
		//pager: "#gridPager1",
		//定义页码控制条Page Bar
		//caption: "",
		//设置Grid表格的标题，如果未设置，则标题区域不显示。
		pagerintoolbar:true,//上面的分页条
		pagerinBottombar:false,//下面的分页条
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
		toolbar: [true,"top","<input class='but_y_01' id='add' type='button' value='登记加油' onclick='addOil()'/>"], //<input class='but_y_01' type='button' value='登记充值' onclick='addRecharge()'/>
		multiselect: false,
		onSelectRow: function(id) {
			if(event.srcElement.type!="checkbox"){
				//viewCarinfo(id);
			}
		}
	}).navGrid('#gridPager', {
		edit: false,
		add: false,
		del: false,
		search:false,
		refresh: false
	});
});


/*
函数:  toUserParamJosn
说明:  构建要查询的参数
参数:   无
返回值: 返回要查询的参数
*/
var toUserParamJosn = function() {
	 var str = "{'card_id':'<%=car_id%>'}";
	 return descape(escape(str));
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
		search: true ,// 将jqGrid的search选项设为true  
		userFilters : toUserParamJosn()
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
函数:  resetSingleSearchDialog
说明:  清空值查询值
参数:   无
返回值: 无
*/
var resetSingleSearchDialog = function() { //$("radio","#singleSearchDialog").attr("checked", false);  
	$(":text", "#queryTable").val("");
	$("select:first option:first").attr("selected","selected");
};

/**
 * 车辆管理-车辆申请记录查看
 */
var viewCarinfo = function(id) {
	var model = jQuery("#gridTable").jqGrid('getRowData', id);
	
	var url = "<%=path%>/ccapp/xtbg/yimingju/carmanage/jsp/fuelCarinfo.jsp?car_id=";
	
	openWindows("windowId",window,url+"&windowId=windowId"+id,'windowId',false,window);
}

/**
 * 登记加油 
 */
var addOil = function() {
	var url = "<%=path%>/ccapp/xtbg/yimingju/carmanage/jsp/fuelCarinfoadd.jsp?actionName=insert&car_id=<%=car_id%>&fuelcard_type=0";
	var pageName ="登记加油";
	openAlertWindows('windowId',url,pageName,530,250,'25%','25%');
}


/**
 * 登记充值
 */
var addRecharge = function() {
	var url = "<%=path%>/ccapp/xtbg/yimingju/carmanage/jsp/fuelCarinfoadd.jsp?actionName=insert&car_id=<%=car_id%>&fuelcard_type=1";
	var pageName ="登记充值";
	openAlertWindows('windowId',url,pageName,530,250,'25%','25%');
}


</script>
</head>
<body>
	<!-- 查询列表区 cGridArea(查询区样式)-->
	<div class="cGridArea">
		<table id="gridTable"></table>
		<div id="gridPager"></div>
	</div>

	<form id="delForm" name="delForm" method="post" action="carmanagecarsaveform.jsp">
		<input type="hidden" name="carIds" id="carIds" />
		<input type="hidden" name="action" value="del" />
	</form>
	
	<iframe name="hiddenFrame" width=0 height=0></iframe>

</body>
</html>

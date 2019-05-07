<%--
描述：电子考勤统计列表
作者：邱炼
版本：1.0
日期：2014-06-03
--%>
<%@page import="com.chinacreator.xtbg.core.common.cache.UserCache"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%
    String path = request.getContextPath();
    AccessControl accesscontroler = AccessControl.getInstance();
    accesscontroler.checkAccess(request, response);
    
    String userid = request.getParameter("userid");
    String type_value = request.getParameter("type_value");
    String type = "";
    if(type_value.equals("value1")){
    	type = "年休假";
    }else if(type_value.equals("value2")){
    	type = "婚假";
    }else if(type_value.equals("value3")){
    	type = "工伤假";
    }else if(type_value.equals("value4")){
    	type = "产假";
    }else if(type_value.equals("value5")){
    	type = "计划生育假";
    }else if(type_value.equals("value6")){
    	type = "病（伤）假";
    }else if(type_value.equals("value7")){
    	type = "事假";
    }else if(type_value.equals("value8")){
    	type = "公差假";
    }else if(type_value.equals("value9")){
    	type = "丧假";
    }else if(type_value.equals("value10")){
    	type = "学习培训假";
    }else if(type_value.equals("value11")){
    	type = "陪产假";
    }
    String start_time = request.getParameter("start_time");
    String end_time = request.getParameter("end_time");
    
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

<title>电子考勤统计列表</title>
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
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-min.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>

<style type="text/css">
.mybtn{ 
	background-color:transparent; /* 背景色透明 */ 
	border:0px; /*border:0px solid #005aa7;边框取消 */ 
	cursor:pointer; 
	color:red;
} 
</style>
<script type="text/javascript">

$(function() {
    $(document).keydown(function(){
        if(event.keyCode == 13){ 
        	Search();
        }
    });
    $("#gridTable").jqGrid({
    url: '<%= path %>' + '/commonListServlet?classNameId=detailsList',  
    //jqGrid控件通过这个参数得到需要显示的数据，具体的返回值可以使XML也可以是Json
    datatype: "json",
    //这个参数用于设定将要得到的数据类型。我最常用的是“json”，其余的类型还包括：xml、xmlstring、local、javascript、function
    mtype: "POST",
    //定义使用哪种方法发起请求，GET或者POST
    height: "100%",//270
    //Grid的高度，可以接受数字、%值、auto，默认值为150
    autowidth: true,
    colModel: [ //最重要的数组之一，用于设定各列的参数
         { 
            label : 't_id',
            name: 't_id',
            index: 't_id',
            hidden: true
         },
        {
             label : '部门名称 ',
            name: 't_depart_name',
            index: 't_depart_name',
            width: 150,
            editable: true
        },
        {
        	 label : '人员id',
             name: 't_user_id',
             index: 't_user_id',
             hidden: true
        },
        {
            label : '人员',
            name: 't_name',
            index: 't_name',
            width: 100,
            search: true
        },{
            label : '请假类别',
            name: 't_type',
            index: 't_type',
            width: 100,
            search: true
        },{
            label : '请假事由',
            name: 't_title',
            index: 't_title',
            width: 100,
            search: true
        },{
            label : '请假开始时间',
            name: 't_starttime',
            index: 't_starttime',
            width: 100,
            search: true
        },{
            label : '请假结束时间',
            name: 't_endtime',
            index: 't_endtime',
            width: 100,
            search: true
        },{
            label : '请假天数',
            name: 't_leavetimes',
            index: 't_leavetimes',
            width: 100,
            search: true
        },{
            label : '申请时间',
            name: 't_sq_time',
            index: 't_sq_time',
            hidden:true
        }
    ],
    sortname: 't.t_sq_time',
        
    //指定默认的排序列，可以是列名也可以是数字。此参数会在被传递到Server端。
    sortorder: 'asc',
    viewrecords: true,
    
    //设置是否在Pager Bar显示所有记录的总数。
    rowNum: 10,
    gridComplete: function() { // var idss=jQuery("#gridTable").jqGrid('getColNames');
		var ids = $("#gridTable").getDataIDs(); //jqGrid('getDataIDs');
		for (var i = 0; i < ids.length; i++) {
			var cl = ids[i];
			var model = jQuery("#gridTable").jqGrid('getRowData', cl);
		}
	},
    jsonReader: { //这又是一个数组，用来设定如何解析从Server端发回来的json数据
        repeatitems: false
    },
    pagerintoolbar:true,//上面的分页条
    pagerinBottombar:true,//下面的分页条
    search : toParamJosn(),
    caption: "",    
    prmNames: { //这是一个数组，用于设置jqGrid将要向Server传递的参数名称
        rows: "rows",
        //表示请求行数的参数名称  
        sort: "sidx",
        //表示用于排序的列名的参数名称  
        order: "sord",
        //表示采用的排序方式的参数名称 
        search : "search"
    },
    toolbar: [true,"top","<input class='but_y_01' id='backButton' type='button' onclick='back()' value='返回'/>"],
    multiselect: false,
    onCellSelect:function(id,iCol){
        if(iCol != 0 )
        {
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
函数:  toParamJosn
说明:  构建要查询的参数
参数:   无
返回值: 返回要查询的参数
*/
var toParamJosn = function(){
// 	 if(start_time==""){
// 		 start_time = getCurrentMonthFirst().Format('yyyy-MM-dd');//当月第一天
// 	 }
// 	 if(end_time==""){
// 		 end_time = getCurrentMonthLast().Format('yyyy-MM-dd');//当月最后一天
// 	 }
    var str = "{'t_user_id':'<%=userid%>','t_type':'<%=type%>','t_type_value':'<%=type_value%>','t_starttime':'<%=start_time%>','t_endtime':'<%=end_time%>'}";
    return descape(escape(str));
}

/*
函数:  Search
说明:  查询信息
参数:   无
返回值: 列表
*/
var Search = function() {
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
 
 //返回
function back(){
	window.history.back();
}
</script>
</head>
<body>
<form id="form1" name="form1" method="post" action="">  
	<table width="100%" id="queryTable">
	    <tr>
	        <td>
		        <div class="cGridArea">
		            <table id="gridTable"></table>
		            <div id="gridPager"></div>
		        </div>
	    	</td>
	    </tr>
	</table>
</form>
</body>
</html>
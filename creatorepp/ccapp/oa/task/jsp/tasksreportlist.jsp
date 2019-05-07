<%--
describe: 任务查看的界面
author:dailianchun
date: 2013-7-11
--%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.task.dao.TasksReportDao"%>
<%@page import="com.chinacreator.xtbg.core.task.dao.imploracle.TasksReportDaoImpl"%>

<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@page import="com.chinacreator.xtbg.core.common.util.*"%>
<%@page import="com.chinacreator.xtbg.core.task.util.TaskConstant"%>

<%
    String id = StringUtil.deNull(request.getParameter("id"));//交办任务id
    String status = StringUtil.deNull(request.getParameter("status"));//交办任务状态
    String path = request.getContextPath();

    AccessControl accesscontroler = AccessControl.getInstance();
    accesscontroler.checkAccess(request, response);
    String userId = accesscontroler.getUserID();
    

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

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
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-tree.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<!--公共部分结束  -->
<title></title>
<script type="text/javascript">
var path = "<%=path%>";
var task_id = "<%=id%>";//交办任务 id
var status = "<%=status%>";//任务状态
var userId = "<%=userId%>";//用户id
var unRead = "<%=TaskConstant.UNREAD%>";//未读的标示
jQuery(function() {
    jQuery(document).keydown(function(){
        if(event.keyCode == 13){ 
            briefsSearch();
        }
    });
    
    jQuery("#gridTable").jqGrid({
    url: path + '/pubListServlet?classNameId=com.chinacreator.xtbg.core.task.list.TasksReportList',
    //jqGrid控件通过这个参数得到需要显示的数据，具体的返回值可以使XML也可以是Json
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
        //字符串数组，用于指定各列的题头文本，与列的顺序是对应的。
        colModel: [ //最重要的数组之一，用于设定各列的参数
         { 
            label : "主键id",
            name: 'id',
            index: 'id',
            hidden: true
            
         },
        {
            label : "回复内容 ",
            name: 'report_content',
            index: 'report_content',
            sortable:false,
            width: 200,
            editable: true,
            formatter : fomatterType
        },    
        {
            label : "回复时间",
            name: 'report_time',
            index: 'report_time',
            sortable:false,
            width: 150,
            formatter : fomatterType
            //hidden: true
        },
        {
            label : "回复人",
            name:'user_name',
            index:'user_name',
            sortable:false,
            width: 60,
            formatter : fomatterType
        },
        {
            label : "回复人id",
            name:'user_id',
            index:'user_id',
            sortable:false,
            width: 60,
            hidden: true
        },{
        	label : "阅读状态",
            name:'type',
            index:'type',
            sortable:false,
            hidden : true     	
         }
        ],
        sortname: 'report_time',
        
    //指定默认的排序列，可以是列名也可以是数字。此参数会在被传递到Server端。
    sortorder: 'desc',
    viewrecords: true,    
    //设置是否在Pager Bar显示所有记录的总数。
    rowNum: 5,   
    jsonReader: { //这又是一个数组，用来设定如何解析从Server端发回来的json数据
        repeatitems: false
    },
    pagerintoolbar:true,//上面的分页条
    pagerinBottombar:true,//下面的分页条
    search : toTasksParamJosn(),    
    prmNames: { //这是一个数组，用于设置jqGrid将要向Server传递的参数名称
        rows: "rows",
        //表示请求行数的参数名称  
        sort: "sidx",
        //表示用于排序的列名的参数名称  
        order: "sord",
        //表示采用的排序方式的参数名称 
        search : "search"
    },
    toolbar: [true,"top",(function(flag){
        if(flag == "2"){
            return "<input class='but_y_01' id='add' type='button' onclick='addInfo()' value='回复'/>";
          }
          return "";
       })(status)],
    multiselect:false,
    onCellSelect:function(id,iCol){
        if(iCol != 0 )
        {
            updateInfo(id);
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
函数:  toBriefsParamJosn
说明:  构建要查询的参数
参数:   无
返回值: 返回要查询的参数
*/
var toTasksParamJosn = function() {

    var str = "{'task_id':'"+task_id+"'}"; 
    return descape(escape(str));
}


/*
函数:  briefsSearch
说明:  查询信息
参数:   无
返回值: 列表
*/
var tasksAssignedSearch = function() {
    var sdata = { //构建查询需要的参数 
        paramJson : toTasksParamJosn()
    }; //获得当前postData选项的值  
    var postData = jQuery("#gridTable").jqGrid("getGridParam", "postData"); //将查询参数融入postData选项对象  
    jQuery.extend(postData, sdata);
    jQuery("#gridTable").jqGrid("setGridParam", {
        search : true
    // 将jqGrid的search选项设为true  
    }).trigger("reloadGrid", [ {
        page : 1
    } ]); //重新载入Grid表格，以使上述设置生效 
     }

    /*
         函数:  updateInfo
         说明:  修改信息
         参数:   无
         返回值: 无
         */
    var updateInfo = function(id) {
            var model = jQuery("#gridTable").jqGrid('getRowData', id);
            var url = getCurrentFilePath()+"addtasksreport.jsp?id="+model.id+"&tasks_id="+task_id+"&windowId=update_taskReport";
            openAlertWindows('update_taskReport',url,'汇报任务',500,220,'30%','30%');
    }
    
    var addInfo = function()
    {
        var url = getCurrentFilePath()+"addtasksreport.jsp?task_id="+task_id+"&windowId=add_taskReport";
        openAlertWindows('add_taskReport',url,'汇报任务',500,220,'30%','30%');
    }   

    /**
     *高亮显示未读的列
     */
    function fomatterType(value,column,row){
    	 if(row.user_id != userId && unRead == row.type){
             return "<span style='font-weight:bolder;'>"+value+"</span>";  
           }
           return value;
    }
        
</script> 
</head>
<body>

<table width="100%" >
        <tr>
            <td>
                <!-- 查询条件选区 [开始] -->
                                            
            <form id="form1" name="form1" method="post" action="">  
        
            <input type="hidden" name="testid" id="testid"> 
        
                    <table width="100%">
        
        </table>
        </form>
        <tr>
        <td>
        
        <!-- 查询列表区[开始]-->
        <div class="cGridArea">
            <table id="gridTable"></table>
            <div id="gridPager"></div>
        </div>
        <!-- 查询列表区[结束] -->
        <form id="delForm" name="delForm" method="post" action="taskseditordrewdo.jsp">
        <input type="hidden" name="userIds" id="userIds" />
        <input type="hidden" name="Ids" id="Ids" /> <input
            type="hidden" name="action1" value="del" />
        </form>
        <iframe name="hiddenFrame" width=0 height=0></iframe>
        
        </td>
        </tr>

    </table>

</body>
</html>
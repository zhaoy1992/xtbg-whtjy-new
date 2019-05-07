<%--
描述：任务交办统计列表
作者：童佳
版本：1.0
日期：2014-04-02
--%>
<%@page import="com.chinacreator.xtbg.core.common.cache.UserCache"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%
    String path = request.getContextPath();
    AccessControl accesscontroler = AccessControl.getInstance();
    accesscontroler.checkAccess(request, response);
    String userId = accesscontroler.getUserID();
  //获得当前登录用户所属单位信息
    UserCacheBean usercachebean = UserCache.getUserCacheBean(userId);
    String unit_id = usercachebean.getUnit_id();
    String unit_name = usercachebean.getUnit_name();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

<title>任务交办统计列表</title>
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
<style type="text/css">
.mybtn{ 
	background-color:transparent; /* 背景色透明 */ 
	border:0px; /*border:0px solid #005aa7;边框取消 */ 
	cursor:pointer; 
	color:red;
} 
</style>
<script type="text/javascript">
var userId = "<%=userId%>";

var userids = new Array();//当前列表的用户id的数组
var start_time = "";
var end_time = "";

$(function() {
    $(document).keydown(function(){
        if(event.keyCode == 13){ 
            tasksAssignedSearch();
        }
    });
    $("#gridTable").jqGrid({
    url: '<%= path %>' + '/pubListServlet?classNameId=com.chinacreator.xtbg.core.task.list.TasksTJList',  
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
            label : '负责人id',
            name: 'receive_userid',
            index: 'receive_userid',
            hidden: true
         },
        {
             label : '负责人名称 ',
            name: 'receive_username',
            index: 'receive_username',
            width: 150,
            editable: true
        },
        {
        	 label : '部门id',
             name: 'receive_orgid',
             index: 'receive_orgid',
             hidden: true
        },
        {
            label : '部门名称',
            name: 'receive_orgname',
            index: 'receive_orgname',
            width: 100,
            search: true
        }, {
        	label : '完成数量',
            name: 'overno',
            index: 'overno',
            width: 100,
            search: false
        },
        {
        	label : '完成率',
            name: 'overnumber',
            index: 'overnumber',
            width: 100,
            search: false
        }
    ],
    sortname: 'receive_userid',
        
    //指定默认的排序列，可以是列名也可以是数字。此参数会在被传递到Server端。
    sortorder: 'desc',
    
    viewrecords: true,
    
    //设置是否在Pager Bar显示所有记录的总数。
    rowNum: 10,
    gridComplete: function() { // var idss=jQuery("#gridTable").jqGrid('getColNames');
		// alert(idss);
		var ids = $("#gridTable").getDataIDs(); //jqGrid('getDataIDs');
		for (var i = 0; i < ids.length; i++) {
			var cl = ids[i];
			var model = jQuery("#gridTable").jqGrid('getRowData', cl);
			var be2 = "<input type=button class='mybtn' id='b2' onclick=openRead('"+model.receive_userid+"') value='"+model.overnumber+"' />";
			jQuery("#gridTable").jqGrid('setRowData', ids[i], {
				 overnumber: be2
	        });
			
			userids.push(model.receive_userid);

		}
	},
    jsonReader: { //这又是一个数组，用来设定如何解析从Server端发回来的json数据
        repeatitems: false
    },
    //pager: "#gridPager",
    pagerintoolbar:true,//上面的分页条
    pagerinBottombar:true,//下面的分页条
    search : toTasksParamJosn(),
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
    toolbar: [true,"top","<input class='but_y_01' id='exportButton' type='button' onclick='exportFile()' value='导出'/>"],
    multiselect: false,
    onCellSelect:function(id,iCol){
        if(iCol != 0 )
        {
           // updateInfo(id);
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
var toTasksParamJosn = function(){
	 userids.length = 0;//清空该变量
	 start_time = $("#start_time").val();
	 end_time = $("#end_time").val();
    var str = "{'receive_username':'" + $("#receive_username").val()    
            + "','start_time':'" + $("#start_time").val()
            + "','end_time':'" + $("#end_time").val()
            + "','receive_orgname':'" + $("#receive_orgname").val() 
            + "','unit_id':'<%=unit_id%>'}";
    return descape(escape(str));
}

/*
函数:  StringCheck
说明:  做查询时通配符处理问题
参数:   obj 文本框上获得的值
返回值: 返回转换后的值
*/
var StringCheck = function(obj){
    return obj.replaceAll('%','---').replaceAll("'","’").replaceAll(":","：");
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
    var postData = $("#gridTable").jqGrid("getGridParam", "postData"); //将查询参数融入postData选项对象  
    $.extend(postData, sdata);
    $("#gridTable").jqGrid("setGridParam", {
        search : true
    // 将jqGrid的search选项设为true  
    }).trigger("reloadGrid", [ {
        page : 1
    } ]); //重新载入Grid表格，以使上述设置生效 
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
                paramJson: toTasksParamJosn()
            };
            var postData = $("#gridTable").jqGrid("getGridParam", "postData");
            $.extend(postData, sdata); //将postData中的查询参数覆盖为空值  
            $("#gridTable").jqGrid("setGridParam", {
                search: true // 将jqGrid的search选项设为false  
            }).trigger("reloadGrid", [{
                page: 1
            }]);
    }

    /*
     函数:  resetSingleSearchDialog
     说明:  清空值查询值
     参数:   无
     返回值: 无
     */
var resetSingleSearchDialog = function() { //$("radio","#singleSearchDialog").attr("checked", false);  
    $(":text", "#queryTable").val("");
    $(":hidden", "#queryTable").val("");
    $("select").each(function(){
        $(this).find("option:first").attr("selected","selected");
    });
}
  
    /*
	    函数:  openRead
	     说明:  查看任务完成率
	     参数:   receive_userid
	     返回值: 无
    */
var openRead = function(receive_userid){
    	var url = getCurrentFilePath()+"taskWCLlist.jsp?receive_userid="+receive_userid;
    	openAlertWindows('windowId',url,'任务完成情况','950','600','5%','5%');
} 
    
/**
 * 导出
 */
function exportFile(){
	var url = "${pageContext.request.contextPath}/ccapp/oa/resources/util/excel/ajaxexcel.jsp";
    var html = new Array();
    html.push("<div id='export_excel'>");
    html.push('<iframe id="hiddenFrame"  name="hiddenFrame" width=0 height=0></iframe>');
    html.push('<form id="downFrom" name="downFrom" method="post" action="'+url+'" target="hiddenFrame">');
    html.push("<input type='hidden' name='userids' value='"+userids.join()+"' /> ");
    html.push("<input type='hidden' name='start_time' value='"+start_time+"' /> ");
    html.push("<input type='hidden' name='end_time' value='"+end_time+"' /> ");
    html.push("<input type='hidden' name='excelname' value='任务统计' /> ");//导出的主题
    html.push("<input type='hidden' name='excelImplClass' value='taskTJDaoExcelImpl' /> ");//导入导出的实现类，要提前在spring中或orcleConfig中配置好
    html.push("<input type='hidden' name='excelTemplateFilePath' value='taskTJ_excelTemplateFilePath' /> ");//导出的excel模版路径，要提前在系统properties中配置好
    html.push('</form>');
    html.push("</div>");
    //加载到body，提交后再删除
    jQuery(html.join("")).appendTo("body");
    jQuery("#downFrom").submit();
    jQuery("#export_excel").remove();
}

</script>
</head>
<body>
<form id="form1" name="form1" method="post" action="">  
        
<input type="hidden" name="testid" id="testid"> 
<table width="100%" id="queryTable">
    <tr>
        <td>
            <!-- 查询条件选区    tabs_search_ctable(查询table样式) -->
            <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tabs_search_ctable_box">
                <tr>
                    <td>
                        <!-- 固定查询 -->
                        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tabs_search_ctable">
                            <tr>
                                <th width="90" class="input_cx_title_th" >责任人：</th>
                                <td width="296"  class="cx_title_td">
                                <input  type="text" class="input_cx_title_283" id="receive_username" name="receive_username"/>
                                </td>
                                <td width="385"  colspan="2"  >
                                <input name="Input2" value="搜索" type="button" onclick="tasksAssignedSearch()" class="but_y_01"/>
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
                            <th class="input_cx_title_th">部门名称：</th>
                            <td  class="cx_title_td">
                                <input  type="text" class="input_cx_title_283" id="receive_orgname" name="receive_orgname"/>
                            </td>
							<th class="input_cx_title_th">统计区间：</th>
							<td  class="cx_title_td">
							<input id="start_time" name="start_time" type="text" class="date_120"　
							onFocus="var input_endtime=$dp.$('end_time');WdatePicker({onpicked:function(){end_time.focus();},dateFmt:'yyyy-MM-dd '})"   /> 
							<span class="date_120_span">至</span>
							 <input id="end_time" name="end_time" type="text"  class="date_120" 
							 onfocus="WdatePicker({minDate:'#F{$dp.$D(\'start_time\')}',dateFmt:'yyyy-MM-dd '})" />
							</td>
                            </tr>
                        </table>
                        <!-- 隐藏查询 end-->
                   </td>
                </tr>
            </table>
            
        <!-- 查询列表区[开始]-->
        <div class="cGridArea">
            <table id="gridTable"></table>
            <div id="gridPager"></div>
        </div>
        <iframe name="hiddenFrame" width=0 height=0></iframe>
    </td>
    </tr>
    </table>
    </form>
</body>
</html>
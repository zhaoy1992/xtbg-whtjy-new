<%-- 
描述：代填问卷列表
作者：shuqi.liu
版本：1.0
日期：2013-05-13
 --%> 
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.common.commonlist.Constant"%>
<%@page import="com.chinacreator.xtbg.core.vote.service.VotePaperService" %>
<%@page import="com.chinacreator.xtbg.core.vote.service.impl.VotePaperServiceImpl" %>
<%@page import="java.util.*" %>
<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html >

<head>
<%
AccessControl accesscontroler = AccessControl.getInstance();
accesscontroler.checkAccess(request, response);
    String path = request.getContextPath();
    String userId = accesscontroler.getUserID();
	String paperId = request.getParameter("paperId");//问卷ID
	//paperId= "f609489b-ed41-4162-b772-2e9b16fc24bf";
    
%>
<title>问卷</title>

<!-- 引入jQuery -->
<script type="text/javascript" src="<%=path %>/ccapp/oa/resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<!-- 引入jQuery UI -->
<script src="<%=path %>/ccapp/oa/resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>
<!-- 引入my97时间控件 -->
<script src="<%=path %>/ccapp/oa/resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<!-- 引入jGrid -->
<script src="<%=path %>/ccapp/oa/resources/plug/jquery.jqGrid-4.3.1/js/i18n/grid.locale-en.js" type="text/javascript"></script>
<script src="<%=path %>/ccapp/oa/resources/plug/jquery.jqGrid-4.3.1/js/jquery.jqGrid.min.js" type="text/javascript"></script>
<!-- 引入其它 -->
<script src="<%=path %>/ccapp/oa/resources/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="<%=path %>/ccapp/oa/resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="<%=path %>/ccapp/oa/resources/plug/ifrom/js/ifrom-tools.1.1.js"charset="utf-8"></script>
<script type="text/javascript" src="<%=path %>/ccapp/oa/resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script> 
<!-- 公共部分引用结束 -->
<script type="text/javascript">
jQuery(function() {
    $(document).keydown(function(){
        if(event.keyCode == 13){ 
            search();
        }
        });
    $("#gridTable").jqGrid({
        url: '<%= path %>' + '/pubListServlet?classNameId=com.chinacreator.xtbg.core.vote.list.VoteCompleteList',  //pubListServlet列表公共的servlet,classNameId在servletBean.xml文件中配置要调用的类,isPage:是否翻页(true,false),默认为true
        //jqGrid控件通过这个参数得到需要显示的数据，具体的返回值可以使XML也可以是Json
        datatype: "json",
        //这个参数用于设定将要得到的数据类型。我最常用的是“json”，其余的类型还包括：xml、xmlstring、local、javascript、function
        mtype: "POST",
        //定义使用哪种方法发起请求，GET或者POST
        height: "100%",//270
        //Grid的高度，可以接受数字、%值、auto，默认值为150
        //width ："1800", //Grid的宽度，如果未设置，则宽度应为所有列宽的之和；如果设置了宽度，则每列的宽度将会根据shrinkToFit选项的设置，进行设置。
        //shrinkToFit ：true 此选项用于根据width计算每列宽度的算法。默认值为true。如果shrinkToFit为true且设置了width值，则每列宽度会根据width成比例缩放；如果shrinkToFit为false且设置了width值，则每列的宽度不会成比例缩放，而是保持原有设置，而Grid将会有水平滚动条
        autowidth: true,
        //width: "1000",
        //默认值为false。如果设为true，则Grid的宽度会根据父容器的宽度自动重算。重算仅发生在Grid初始化的阶段；如果当父容器尺寸变化了，同时也需要变化Grid的尺寸的话，则需要在自己的代码中调用setGridWidth方法来完成。
        colNames: ['填报人ID', '考核标题','所属单位','创建人','问卷类型CODE','填写时间'],
        //字符串数组，用于指定各列的题头文本，与列的顺序是对应的。
        colModel: [ //最重要的数组之一，用于设定各列的参数
        {
            name: 'id',
            index: 'id',
            hidden: true
        },
        {
            name: 'title',
            index: 'title',
            width:200
        },
        {
            name : 'org_name',
            index : 'org_name'
        },
        {
            name : 'user_name',
            index : 'user_name'
        },
        {
            name : 'papaer_type_code',
            index : 'papaer_type_code',
            hidden: true
        },
        {
            name : 'creatdate',
            index : 'creatdate',
            hidden: true
        }
        ],
        sortname: 'startdate',
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
            }
        },
        jsonReader: { //这又是一个数组，用来设定如何解析从Server端发回来的json数据
            repeatitems: false
        },
        pagerintoolbar:true,//上面的分页条
        pagerinBottombar:true,//下面的分页条
        //定义页码控制条Page Bar
        //caption: "来文缓急维护",
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
        toolbar:[true, "top" ,""],
        // multiselect: true,
        onCellSelect:function (id,iCol){
            if(iCol != 0){
                modifyVote(id);
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
var toParamJosn = function() {
	  var str = "{'startdate':'" + $("#startdate").val() 
	    + "','enddate':'" + $("#enddate").val() 
	    + "','id':'<%= paperId%>'}";
   	  return descape(escape(str));
}

/*
     函数:  search
     说明:  查询用户信息
     参数:   无
     返回值: 用户列表
     */
var search = function() {
    var sdata = { //构建查询需要的参数 
        paramJson: toParamJosn()
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
     函数:  modifyVote
     说明:  填写VOTE
     参数:   无
     返回值: 无
     */
var modifyVote = function(id) {
   var model = jQuery("#gridTable").jqGrid('getRowData', id);
   var  papaer_type_code = model.papaer_type_code;
   if(papaer_type_code == '<%=Constant.RYCP%>'){
	   openWindows('VoteEvalPaperList','人员测评查看','voteevaloperatedocument.jsp?windowId=VoteEvalPaperList&oper_type=look&status=1&paperId=<%=paperId%>&user_id='+model.id,'windowId',false,window);
   }else{
	   openWindows('VotePaperList','在线投票查看','voteoperatedocument.jsp?windowId=VotePaperList&oper_type=look&status=1&paperId=<%=paperId%>&user_id='+model.id,'windowId',false,window);
   }
   
}
</script>
</head>
<body>
<div>
    <!-- 查询条件选区    tabs_search_ctable(查询table样式) -->
        <table id="queryTable" width="100%" border="0" cellspacing="0" cellpadding="0" class="tabs_search_ctable_box">
                <tr>
                    <td>
                        <!-- 固定查询 -->
                        <table width="100%" style="padding:5px;" cellspacing="0" cellpadding="2" class="tabs_search_ctable">
            <tr>
                <th  class="input_cx_title_th">填写时间：</th>
                <td  class="cx_title_td">
                 <input class="date_120" style="width:150px" type="text" id="startdate" name="startdate" 
                                onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"  />
                <span style="float:left"> &nbsp;至&nbsp;</span>
                 <input class="date_120" style="width:150px" type="text" id="enddate" name="enddate" 
                                onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"  />
                </td>
                <td rowspan="2"><input value="搜索" id="sel" type="button"
					onclick="search()" class="but_y_01" /></td>
            </tr>
        </table>  
                        <!-- 固定查询 end-->
                    </td>
                    </tr>
                    <tr>
                    <td>
            </td></tr>
            
            </table>
        <!-- 查询列表区 cGridArea(查询区样式)-->
        <div class="cGridArea">
        <table id="gridTable"></table>
        <div id="gridPager"></div>
        </div>
        <!-- 查询列表区 -->
</div>
<form id="delForm2" name="delForm2" method="post" action="activityTypeAction.jsp">
    <input type="hidden" name="ids" id="ids" /> 
    <input type="hidden" name="action" value="delete" />
</form>

<iframe name="hiddenFrame2" width=0 height=0></iframe>
</body>
</html>
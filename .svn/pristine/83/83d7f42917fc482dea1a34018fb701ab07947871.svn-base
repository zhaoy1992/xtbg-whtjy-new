<%--
describe:会议纪要接收的列表
author:戴连春
date: 2013-6-27
--%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.common.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%
    AccessControl controler = AccessControl.getAccessControl();
    controler.checkAccess(request, response);
    String path = request.getContextPath();   
    //获得当前登录用户的id
    String userId = controler.getUserID();    
    //会议纪要状态 0：暂存，1：发布
    String flag = StringUtil.deNull(request.getParameter("flag"));
    //没有传入，则设置为1
    flag = StringUtil.nullOrBlank(flag) ? "1" : flag;
    
%>
<title>会议纪要暂存列表</title>
<!-- 公共部分开始 -->
<script type="text/javascript"
    src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>

<!-- 引入jQuery UI -->
<script
    src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js"
    type="text/javascript"></script>

<!-- 引入jGrid -->
<link rel="stylesheet" type="text/css" media="screen"
    href="../../resources/plug/jquery.jqGrid-4.3.1/css/ui.jqgrid.css" />
<script
    src="../../resources/plug/jquery.jqGrid-4.3.1/js/i18n/grid.locale-en.js"
    type="text/javascript"></script>
<script
    src="../../resources/plug/jquery.jqGrid-4.3.1/js/jquery.jqGrid.min.js"
    type="text/javascript"></script>

<!-- 引入其它 -->
<script type="text/javascript"
    src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"
    charset="utf-8"></script>
<script src="../../resources/util/public.js" type="text/javascript"></script>
<script type="text/javascript"
    src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<!-- 日期控件 -->
<script src="../../resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>

<script type="text/javascript">
//当前登录用户所属的机构id
var userId = "<%=userId%>";
//会议纪要状态
var flag = "<%=flag%>";
$(function() {
    
    $(document).keydown(function(){
        if(event.keyCode == 13){ 
            search();
        }
        });
    
    $("#gridTable").jqGrid({
        url: '<%=path%>/pubListServlet?classNameId=com.chinacreator.xtbg.core.meeting.list.MeetingMinutesViewList', 
        //jqGrid控件通过这个参数得到需要显示的数据，具体的返回值可以使XML也可以是Json
        datatype : "json",
        mtype : "POST",//定义使用哪种方法发起请求，GET或者POST
        height : "100%",
        autowidth : true,
       //表头设置       
        colModel : [ 
        {
            label : "会议纪要id",
            name : 'm_minutes_id',
            index : 'm_minutes_id',
            hidden : true
        }, {
            label : "会议标题",
            name : 'm_title',
            index : 'm_title',
            width:300,
            formatter : publicFormatter
        }, {
            label : "会议开始时间",
            name : 'm_begin_time',
            index : 'm_begin_time',
            editable : false,
            formatter : publicFormatter
        },{
            label : "登记人",
            name : 'm_reg_user_name',
            index : 'm_reg_user_name',
            editable : false,
            formatter : publicFormatter
        }, {
            label : "登记时间",
            name : 'm_reg_time',
            index : 'm_reg_time',
            editable : false,
            formatter : publicFormatter
        },{
            label : "状态",
            name : 'm_current_flag',
            index : 'm_current_flag',
            hidden: true 
          
        },{
            label : "状态",
            name : 'm_flag',
            index : 'm_flag',
            formatter : function(value,column,model){
              var msg = "已读";
              if("0"==value){
                  msg = "<span style='font-weight:bold;color:red'>未读</span>";
              }            
            return msg;
           }
        }
        ],
        sortname : 'm_reg_time',
        //指定默认的排序列，可以是列名也可以是数字。此参数会在被传递到Server端。
        sortorder : 'desc',
        //设置是否在Pager Bar显示所有记录的总数。
        viewrecords : true,
        
        rowNum : 10,
        //用于设置Grid中一次显示的行数，默认值为20。正是这个选项将参数rows（prmNames中设置的）通过url选项设置的链接传递到Server。注意如果Server返回的数据行数超过了rowNum的设定，则Grid也只显示rowNum设定的行数。
        rowList : [ 10, 20, 30 ],//一个数组，用于设置Grid可以接受的rowNum值。例如[10,20,30]
        jsonReader : { //这又是一个数组，用来设定如何解析从Server端发回来的json数据
            repeatitems : false
        },
        //定义页码控制条Page Bar
        pagerintoolbar:true,//上面的分页条
        pagerinBottombar:true,//下面的分页条
    
        //设置Grid表格的标题，如果未设置，则标题区域不显示。
        search : toUserParamJosn(),
        prmNames : { //这是一个数组，用于设置jqGrid将要向Server传递的参数名称
            rows : "rows",
            //表示请求行数的参数名称  
            sort : "sidx",
            //表示用于排序的列名的参数名称  
            order : "sord",
            //表示采用的排序方式的参数名称 
            search : "search"
        },
        toolbar : [ true, "top"],
        multiselect : false,
        onCellSelect:function (id,iCol)
        {
           if(iCol != 0)
            {
                var model = jQuery("#gridTable").jqGrid('getRowData', id);
                view(model.m_minutes_id,model.m_flag);
            }
        }
                    
        });
        
    });
   
    /*
     函数:  toUserParamJosn
     说明:  构建要查询的参数
     参数:   无
     返回值: 返回要查询的参数
     */
    var toUserParamJosn = function() {
        var str = "{'m_reg_user_id':'" + userId  
                  + "','m_current_flag':'1" 
                  + "','m_begin_time':'" + jQuery("#m_begin_time_start").val()
                  + "','m_begin_time_end':'" + jQuery("#m_begin_time_end").val()
                   + "','m_title':'" + jQuery("#m_title").val()
                  + "'}";
        return descape(escape(str));
    }

    /*
	     函数:  search
	     说明:  查询
	     参数:   无
	     返回值: 
     */
    var search = function() {
        var sdata = { //构建查询需要的参数 
            paramJson : toUserParamJosn()
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

    /**
     *查看会议纪要信息
     *@param id 会议纪要id
     *@param flag 是否已经阅读的标志
     */
    var view = function(id,flag){
    	 openWindows('update_meetingRoom','查看会议纪要信息'
                 ,'meetingminutesview.jsp?windowId=update_meetingRoom&id='+id+"&m_flag="+flag
                 ,'meetingmanager',false,window);
    }
    /**
     *公用的列格式函数(设置未读加粗)
     *@param value:当前列的值
     *@param column:当前列对象
     *@param 当前行对象
     */
    var publicFormatter = function(value,column,model){        
        if("0"==model.m_flag){
            value = "<span style='font-weight:bolder;'>"+value+"</span>";
        }            
        return value;
    }
   
</script>
<!-- 公共部分结束 -->
</head>
<body>
<div>
    <table id="queryTable" width="100%" border="0" cellspacing="0" cellpadding="0" class="tabs_search_ctable_box">
        <tr>
            <td>
            <!-- 固定查询 -->
                <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tabs_search_ctable">
                    <tr>
                        <th width="90" class="input_cx_title_th">会议标题：</th>
                        <td width="200" class="cx_title_td">
                            <input type="text" id="m_title" name="m_title" class="input_cx_title_283" style="width:200px;"/>
                        </td>
                        <th  class="input_cx_title_th" style="width:110px;">会议开始时间：</th>
                         <td class="cx_title_td">
                             <input type="text"
                                    class="validate[required] date_187" id="m_begin_time_start" name="m_begin_time_start"
                                    value="" style="width:110px;"
                                    onfocus ="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'m_begin_time_end\')||\'2099-12-12\'}'})" />
                             
                        </td>
                        <td>
                            &nbsp;至&nbsp;
                        </td>
                        <td>    
                             <input type="text"
                                    class="validate[required] date_187" id="m_begin_time_end" name="m_begin_time_end"
                                    value="" style="width:110px;"
                                    onfocus ="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'m_begin_time_start\')||\'1980-01-01\'}'})" />
                        </td>
                        <td width="60" >
                            <input value="搜索" id="sel" type="button" onclick="search();" class="but_y_01" />
                        </td>
                    </tr>
                </table>
            <!-- 固定查询 end-->
            </td>
        </tr>
    </table>
    
    
    <!-- 查询列表区 cGridArea(查询区样式)-->
    <div class="cGridArea">
        <table id="gridTable"></table>
        <div id="gridPager"></div>
    </div>
</div>
</body>
</html>
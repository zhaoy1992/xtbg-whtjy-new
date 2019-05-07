<%--
describe:会议通知总查询
author:戴连春
date: 2013-6-27
--%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.common.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
<%@page import="java.util.*"%>
<%@page import="com.chinacreator.xtbg.core.meeting.entity.*"%>
<%@page import="com.chinacreator.xtbg.core.meeting.service.impl.*"%>
<%@page import="com.chinacreator.xtbg.core.meeting.service.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="com.chinacreator.xtbg.core.common.cache.UserCache"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean"%><html>
<head>
<%
    AccessControl controler = AccessControl.getAccessControl();
    controler.checkAccess(request, response);
    String path = request.getContextPath();
    String userId = controler.getUserID();//用户id
    UserCacheBean usercachebean=UserCache.getUserCacheBean(userId);
    
    String orgId = usercachebean.getUnit_id(); 
    //会议纪要状态 0：暂存，1：发布
    String flag = StringUtil.deNull(request.getParameter("flag"));
    //没有传入，则设置为1
    flag = StringUtil.nullOrBlank(flag) ? "1" : flag;
    
    //会议类型数据
    MeetingTypeService typeService = new MeetingTypeServiceImpl();
    //根据机构id查询对应的会议类型数据
    List<MeetingTypeBean> typeList = typeService.queryListMeetingTypeByOrgId(orgId);

%>
<title></title>
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
<script src="../../resources/util/multiSelect.js" type="text/javascript"></script>
<script type="text/javascript">
//当前登录用户所属的机构id
var userId = "<%=userId%>";
var orgId = "<%=orgId%>";
//会议纪要状态
var flag = "<%=flag%>";
var path = "<%=path%>";
$(function() {
    
    $(document).keydown(function(){
        if(event.keyCode == 13){ 
            search();
        }
        });

    //设置多选框
    setSelect("#m_type_id", "classinput1");
    
    $("#gridTable").jqGrid({
        url: '<%=path%>/pubListServlet?classNameId=com.chinacreator.xtbg.core.meeting.list.MeetingNoticeViewList', 
        //jqGrid控件通过这个参数得到需要显示的数据，具体的返回值可以使XML也可以是Json
        datatype : "json",
        mtype : "POST",//定义使用哪种方法发起请求，GET或者POST
        height : "100%",
        autowidth : true,
       //表头设置       
        colModel : [ 
        {
            label : "会议纪要id",
            name : 'm_notice_id',
            index : 'm_notice_id',
            hidden : true
        }, {
            label : "会议标题",
            name : 'm_title',
            index : 'm_title',
            width:200
        }, {
            label : "会议类型",
            name : 'm_type_name',
            index : 'm_type_name',
            editable : false
        }, {
            label : "开始时间",
            name : 'm_begin_time',
            index : 'm_begin_time',
            editable : false
        }, {
            label : "结束时间",
            name : 'm_end_time',
            index : 'm_end_time',
            editable : false
        },{
            label : "地点",
            name : 'm_address',
            index : 'm_address',
            editable : false
        }, {
            label : "主持人",
            name : 'm_master_user_name',
            index : 'm_master_user_name',
            editable : false
        },{
            label : "联系人",
            name : 'm_link_user_name',
            index : 'm_link_user_name',
            editable: false 
          
        },{
            label : "联系部门",
            name : 'm_link_dept_name',
            index : 'm_link_dept_name',
            editable: false 
          
        },{
            label : "与会人数",
            name : 'm_attender_count',
            index : 'm_attender_count',
            editable: false 
          
        },{
            label : "会议纪要",
            index : 'minutes',
            name : 'minutes',
            align:"center",
            formatter : function(value,column,model){
               if(!value || "0" == value){
                  return "无关联数据";
               }
               return "<a style='font-weight:bold;color:red'"
               +" href='javascript:void(0);' "
               +"onclick='view(\""+model.m_notice_id+"\",\""
               +model.minutes+"\",\""+model.m_minute_id+"\")'>查看("+value+"条)</a>";
           }
        },{
            label : "会议纪要id",
            index : 'm_minute_id',
            name : 'm_minute_id',
            hidden : true
        }
        ],
        sortname : 'm_begin_time',
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
        toolbar : [ true, "top","<input class='but_y_01' onMouseOver=javascript:$(this).attr('class','but_y_02'); onMouseOut=javascript:$(this).attr('class','but_y_01'); id=add value='导出' type='button' onclick='exportExcel()' value=''/>"],
        multiselect : false,
        onCellSelect:function (id,iCol)
        {
            
           if(iCol != 10)
           {
                var model = jQuery("#gridTable").jqGrid('getRowData', id);
                viewNotice(model.m_notice_id);
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
        var str = "{'m_create_unit_id':'" + orgId   
                  + "','m_begin_time':'" + jQuery("#m_begin_time_start").val()
                  + "','m_begin_time_end':'" + jQuery("#m_begin_time_end").val()
                   + "','m_title':'" + jQuery("#m_title").val()
                   + "','m_type_id':'" + jQuery("#m_type_id").val().replaceAll(",","(@)")//替换掉“,”号，方便解析
                  + "'}";
        return descape(escape(str));
    }

    /**
     *已对象形式传参
     */
    var toParam = function(objName) {    
        var param = new Object();        
        param[objName+"m_create_unit_id"] = orgId;
        param[objName+"m_begin_time" ] = jQuery("#m_begin_time_start").val();
        param[objName+"m_begin_time_end"] =jQuery("#m_begin_time_end").val();
        param[objName+"m_title"] =jQuery("#m_title").val();
        param[objName+"m_type_id" ] = jQuery("#m_type_id").val().replaceAll(",","(@)");//替换掉“,”号，方便解析
        //转码
        for(var name in param ){
            param[name] = descape(escape(param[name]));
        }              
        return param;
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
    var view = function(id,minutes,minutesId){
        //如果只存在一条数据，则直接显示详细信息的页面
        if("1" == minutes){
            openWindows('showDetail_meetingmenutes','查看会议纪要'
                    ,'meetingminutesadd.jsp?windowId=showDetail_meetingmenutes&flag=1&id='+minutesId
                    ,'meetingmanager',false,window);   
        }else{//存在几条数据，先显示列表
            openWindows('viewMeetingMinuteWindow','查看会议纪要信息'
                    ,'meetingminutelist4general.jsp?windowId=viewMeetingMinuteWindow&m_notice_id='
                    +id+"&m_flag=1",'meetingmanager',false,window);

        }
    }

    /**
     *查看会议详细信息
     */
    var viewNotice = function(id){
        openWindows('showDetail_meetingmenutes','查看会议纪要'
                      ,'meetingnoticetab.jsp?issaved=doquery&windowId=showDetail_meetingmenutes&m_notice_id='+id
                      ,'meetingmanager',false,window);   
    }
   
    /**
     * 导出
     */
    function exportExcel(){
        var url = path+'/ajaxServlet?className=com.chinacreator.xtbg.core.meeting.action.MeetingSearchAction&method=exportMeeting';      
        var html = new Array();
        html.push("<div id='export_excel'>");
        html.push('<iframe id="hiddenFrame"  name="hiddenFrame" width=0 height=0></iframe>');
        html.push('<form id="downFrom" name="downFrom" method="post" action="'+url+'" target="hiddenFrame">');

        var param = toParam("");
        for(var name in param){
           html.push("<input type='hidden' name='bean."+name+"' value='"+param[name]+"' /> ");
        }
        var postData = $("#gridTable").jqGrid("getGridParam", "postData");
        for(var name in postData){
            html.push("<input type='hidden' name='page."+name+"' value='"+postData[name]+"' /> ");
        }
        
        var exportKey = ["m_title", "m_type_name", "m_begin_time",
                         "m_end_time", "m_address",
                         "m_master_user_name","m_link_user_name",
                         "m_link_dept_name","m_attender_count"];
         var exportHeader = ["       会议标题        ", "会议类型", "  开始时间  ", "  结束时间  ",
                              "        地点        ", "主持人", "联系人", "联系部门",
                               "与会人数"];
         var data = {
             exportKey : exportKey.join(","),
             exportHeader : descape(escape(exportHeader.join(",")))
         };
         if(data){
            for(var name in data){
                html.push("<input type='hidden' name='"+name+"' value='"+data[name]+"' /> ");
            }  
       }
        html.push('</form>');
        html.push("</div>");
        //加载到body，提交后再删除
        jQuery(html.join("")).appendTo("body");
        jQuery("#downFrom").submit();
        jQuery("#export_excel").remove();
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
                        <th style="width:90px;" class="input_cx_title_th">会议标题：</th>
                        <td style="width:150px;" class="cx_title_td">
                            <input type="text" id="m_title" name="m_title" class="input_cx_title_283" style="width:150px;"/>
                        </td>
                        <th style="width:90px;" class="input_cx_title_th">会议类型： </th>   
                        <td align="left" class="cx_title_td" valign="top" style="pading:0px;width:150px;">
                         <div style="position: absolute;width:150px;z-index: 1;"> 
                            <select style="width:150px;" multiple="multiple" name ="m_type_id" id= "m_type_id" class ="input_cx_title_283" >
                                 <option  type="checkbox" value='' all='30'>&nbsp;全选</option>
                                <%for(MeetingTypeBean type : typeList){ %>
                                <option type="checkbox" value="<%=StringUtil.deNull(type.getM_type_id()) %>">&nbsp;<%=StringUtil.deNull(type.getM_type_name()) %></option>
                                <%} %>
                            </select>
                      </div>
                      </td>  
                        
                        <td>
                            <input value="搜索" id="sel" type="button" onclick="search();" class="but_y_01" />
                        </td>
                    </tr>
                    <tr>
                         <th  class="input_cx_title_th" style="width:90px;">会议开始时间：</th>
                          <td colspan="3" class="cx_title_td" style="height:40px;width: 400px;" valign="middle">
                          <div >
                          <div style="float: left;">
                             <input type="text"
                                    class="date_187" id="m_begin_time_start" name="m_begin_time_start"
                                    value="" style="width:110px;"
                                    onfocus ="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'m_begin_time_end\')||\'2099-12-12\'}'})" />
                          </div>
                          <div  style="float: left;">
                             &nbsp;至&nbsp;
                          </div>
                          <div  style="float: left;">
                             <input type="text"
                                    class="date_187" id="m_begin_time_end" name="m_begin_time_end"
                                    value="" style="width:110px;float: left;"
                                    onfocus ="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'m_begin_time_start\')||\'1980-01-01\'}'})" />
                          </div>
                        </div>
                        </td>    
                        <td >
                        	<span style="width: 60px;" >&nbsp;</span>
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
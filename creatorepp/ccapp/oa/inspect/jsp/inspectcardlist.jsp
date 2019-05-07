<%--
describe:办理单位发牌
author:dailianchun
date: 2013-11-12
--%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.common.util.*"%>
<%@page import="java.util.*"%>
<%@page import="com.chinacreator.xtbg.core.file.service.*"%>
<%@page import="com.chinacreator.xtbg.core.file.service.impl.*"%>
<%@page import="com.chinacreator.xtbg.core.file.util.FileConstant"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.UserCache"%>
<%@page import="com.chinacreator.xtbg.core.kbm.util.KbmUtil"%>
<%@page import="com.chinacreator.xtbg.core.inspect.service.InspectManageService"%>
<%@page import="com.chinacreator.xtbg.core.inspect.service.impl.InspectManageServiceImpl"%><html>
<head>
<%
    AccessControl controler = AccessControl.getAccessControl();
    controler.checkAccess(request, response);
    String path = request.getContextPath();
    //获得当前登录用户的id
    String userId = controler.getUserID();    
    //获得缓存的机构信息
    UserCacheBean userBean = UserCache.getUserCacheBean(userId);
    String unitId = userBean.getUnit_id();//所属单位id
    String info_id = StringUtil.deNull(request.getParameter("info_id"));//任务状态
    
    //服务接口
    InspectManageService service = new InspectManageServiceImpl();    
    //查询所有分类信息
    List<Map<String,String>> typeList = service.queryAllType();
%>
<title></title>
<!-- 公共部分开始 -->
<script type="text/javascript"
    src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<!-- 日期控件 -->
<script src="../../resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>

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
var path = "<%=path%>";
$(function() {
    $(document).keydown(function(){
        if(event.keyCode == 13){
            search();
        }
        });

    jQuery("#inspect_type").change(function(){
        search();
     });
    jQuery("#inspect_state").change(function(){
        search();
     });
    //重置按钮添加事件
    jQuery("#reset").click(function(){
        clear();
    });
    
    $("#gridTable").jqGrid({
        url: path+"/ajaxServlet?className=com.chinacreator.xtbg.core.inspect."
             +"action.InspectManageAction&method=queryCardList", 
        //jqGrid控件通过这个参数得到需要显示的数据，具体的返回值可以使XML也可以是Json
        datatype : "json",
        mtype : "POST",//定义使用哪种方法发起请求，GET或者POST
        height : "100%",
        autowidth : true,
       //表头设置       
        colModel : [
              {
                  label : "信息主键",
                  name : 'info_id',
                  index : 'info_id',
                  hidden : true
              },{
                  label : "接收主键",
                  name : 'recept_id',
                  index : 'recept_id',
                  hidden : true
              },{
                  label : "发牌",
                  name : 'card',
                  index : 'card',
                  width:30,
                  formatter :function(value,column,row){
                     if(value == "0"){
                        return "<img src='../resources/images/green_light.png' style='height:20px;width:18px;border:0px'></img>";
                     }else if(value == "1"){
                        return "<img src='../resources/images/yellow_light.png' style='height:20px;width:18px;border:0px'></img>";
                     }else if(value == "2"){
                        return "<img src='../resources/images/red_light.png' style='height:20px;width:18px;border:0px'></img>";
                     }else{
                        return "";
                     }
                  }
              },{
                  label : "任务名称",
                  name : 'inspect_name',
                  index : 'inspect_name',
                  editable : false,
                  width:250
              }, {
                  label : "任务类型",
                  name : 'type_name',
                  index : 'type_name',
                  editable : false,
                  width:80
              },{
                  label : "办理单位",
                  name : 'org_name',
                  index : 'org_name',
                  editable : false
              },{
                  label : "交办时间",
                  name : 'send_time',
                  index : 'send_time',
                  editable : false,
                  width:100
              },{
                  label : "指定期限",
                  name : 'plan_endtime',
                  index : 'plan_endtime',
                  editable : false,
                  width:100
              },{
                  label : "反馈状态",
                  name : 'recept_state_name',
                  index : 'recept_state_name',
                  width:50,
                  formatter :function(value,column,row){
                      if(row.recept_state == "0" || row.recept_state == "2"){
                          return "<span style='font-weight:bolder;color:red;'>"+value+"</span>";  
                        }
                        return value;
                  }
              },{
                  label : "任务状态",
                  name : 'inspect_state_name',
                  index : 'inspect_state_name',
                  width:50
              },{
                  label : "任务状态",
                  name : 'inspect_state',
                  index : 'inspect_state',
                  hidden : true
              },{
                  label : "反馈状态",
                  name : 'recept_state',
                  index : 'recept_state',
                  hidden : true
              },{
                  label : "接收id",
                  name : 'recept_id',
                  index : 'recept_id',
                  hidden : true
              }
        ],
        sortname : 'send_time',
        sortorder : 'desc',
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
        postData : toUserParamJosn("bean.",true),
        prmNames : { //这是一个数组，用于设置jqGrid将要向Server传递的参数名称
             page : "page.page",
             rows : "page.rows",
             //表示请求行数的参数名称  
             sort : "page.sortName",
             //表示用于排序的列名的参数名称  
             order : "page.sortOrder"
        },
        emptyrecords : "暂无数据",
        toolbar : [ false, "top",""],
        multiselect : true,
        onCellSelect:function (id,iCol)
        {
           if(iCol != 0)
            {
                var model = jQuery("#gridTable").jqGrid('getRowData', id);
                update(model.info_id,model.inspect_state,model.recept_id,model.recept_state);
            }
        }
                    
        });

    //设置工具栏的宽度
    jQuery("#tool_buttons").width(jQuery("#t_bottombar_contentgridTable").width());
        
    });
   
    /*
         函数:  toUserParamJosn
         说明:  构建要查询的参数
         参数:   无
         返回值: 返回要查询的参数
     */
    var toUserParamJosn = function(){ 
        var param = new Object();      
        param["recept.org_id"]="<%=unitId%>";     
        param["bean.inspect_state" ] = jQuery("#inspect_state").val();    
        param["bean.inspect_name"] = jQuery("#inspect_name").val();
        param["bean.inspect_type"] = jQuery("#inspect_type").val();
        //起始交办时间
        param["bean.plan_endtime"] = jQuery("#plan_endtime").val();
        //用指定期限字段存放“截止交办时间”
        param["bean.send_time"] = jQuery("#send_time").val();    
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
       
        //查询参数
        var sdata = toUserParamJosn("bean.",true); 
        
        var postData = $("#gridTable").jqGrid("getGridParam", "postData"); //将查询参数融入postData选项对象  
        $.extend(postData, sdata);
        $("#gridTable").jqGrid("setGridParam", {
            search : true
        // 将jqGrid的search选项设为true  
        }).trigger("reloadGrid", [{
            page : 1
        } ]); //重新载入Grid表格，以使上述设置生效 
    }

    /**
     *重置查询条件
     */
     var clear = function(){
         //清空输入框的值
        jQuery("input[type=text]").val("");
        jQuery("#searchTable input[type=checkbox]:checked").removeAttr("checked"); 
        jQuery("#f_files_state option[value='']").attr("selected","selected");
        //查询
        search();
     }

       /*
        函数:  update
        说明:  修改 
        参数:  无
        返回值: 无
    */
    var update =  function(id,flag,receptId,recept_state){
        var width = jQuery(document).width();
        var height = window.top.findPageCacheName("_documentBodyHeight"); 
            
        openAlertWindows('update_inspect'
                ,path+'/ccapp/oa/inspect/jsp/inspectview4recept.jsp?windowId=update_inspect'
                +"&id="+id+"&flag="+flag+"&recept_id="+receptId+"&recept_state="+recept_state
                +"&manage=view", 
                '查看任务'
                ,width,height,'5%','10%',reload);        
    }
    /**
     *重新加载数据
     */
    function reload(){
    	 $("#gridTable").trigger("reloadGrid");
    }

</script>
<!-- 公共部分结束 -->
</head>
<body class="vcenter" style="overflow:auto;overflow-x:hidden;">
<div>
    <table id="queryTable" width="100%" border="0" cellspacing="0" cellpadding="0" class="tabs_search_ctable_box">
        <tr>
            <td>
            <!-- 固定查询 -->
                <table id="searchTable" style="width:830px;" border="0" cellspacing="3" cellpadding="0" >
                    <tr>
                        <th style="width:90px;"  class="input_cx_title_th">
                                                                           任务名称 ：
                        </th>
                        <td style="width:120px;"  class="cx_title_td" colspan="3">
                             <input type="text"
                                    class="input_cx_title_283"  style="width:275px;" id="inspect_name" name="inspect_name"/>
                             
                        </td>
                        <th style="width:90px;" class="input_cx_title_th">任务类型：</th>
                        <td  style="width:100px;" class="cx_title_td" >
                           <select  style="width:130px;border:#c6c6c6 1px solid;" id='inspect_type' name="inspect_type">
                                  
                                    <option value="">全部</option>
                                   <%
                                      for(Map<String,String> type : typeList){
                                   %>
                                      <option title="<%=type.get("type_name") %>"
                                         value="<%=type.get("type_id") %>" ><%=type.get("type_name") %></option>
                                   <%}%>
                           </select>
                        </td>                        
                        <td style="width:200px;">
                            <input value="搜索" id="sel" type="button" onclick="search();" class="but_y_01" />
                        </td>
                    </tr>
                    <tr>                          
                          <th class="input_cx_title_th" >交办日期：</th>
                          <td class="cx_title_td">
                              <input class="date_120" type="text" style="width:110px;"
                                id="send_time" name="send_time"
                                onclick="WdatePicker({maxDate:'#F{$dp.$D(\'plan_endtime\'||\'2099-01-01\')}',dateFmt:'yyyy-MM-dd'})"  />
                          </td>
                          <td align="center" >
                               <div style="width:30px;float: left;" align="center">至</div>   
                          </td>
                          <td class="cx_title_td">    
                           <input class="date_120" type="text" style="width:110px;"
                            id="plan_endtime" name="plan_endtime"
                            onclick="WdatePicker({minDate:'#F{$dp.$D(\'send_time\'||\'1980-01-01\')}',dateFmt:'yyyy-MM-dd'})" />
                          </td>
                          <th  class="input_cx_title_th" style="width:90px;">
                                                                                      任务状态：
                          </th>
                          <td valign="top" class="cx_title_td">
                           <select id='inspect_state' name="inspect_state" 
                                style="width:130px;border:#c6c6c6 1px solid;">
                               <option value="">全部</option>
                               <option value="1">办理中</option>                               
                               <option value="2">已完成</option>                               
                               <option value="3">未完成</option>
                            </select>
                           
                          </td>
                          <td >
                            <input value="重置" id="reset" type="button" class="but_y_01" />
                        </td>
                      </tr>
                </table>
            </td>
        </tr>        
        <tr>
        <td style="padding: 0px;">
       
        </td> 
        </tr>
    </table>
    
    <!-- 查询列表区 cGridArea(查询区样式)-->
    <div class="cGridArea">   
     <table id="gridTable" style="position: static"></table>
     <div id="gridPager" ></div>
    </div>
</div>
</body>
</html>
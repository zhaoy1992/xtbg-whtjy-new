<%--
describe:入卷操作的文件列表_照片档案
author:dailianchun
date: 2013-7-24
--%>

<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.common.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="com.chinacreator.xtbg.core.file.entity.FileFilesBean"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.UserCache"%>
<%@page import="com.chinacreator.xtbg.core.file.service.FileFilesService"%>
<%@page import="com.chinacreator.xtbg.core.file.service.impl.FileFilesServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.file.util.FileConstant"%><html>
<head>
<%
    AccessControl controler = AccessControl.getAccessControl();
    controler.checkAccess(request, response);
    String path = request.getContextPath();
    String id = StringUtil.deNull(request.getParameter("id"));//档案id
    String windowId = StringUtil.deNull(request.getParameter("windowId"));//窗口id
    //获得当前登录用户的id
    String userId = controler.getUserID();    
    //获得缓存的机构信息
    UserCacheBean userBean = UserCache.getUserCacheBean(userId);
    String unitId = userBean.getUnit_id();//所属单位id
    //传递过来的参数
    FileFilesBean bean = new FileFilesBean();
    bean = (FileFilesBean) RequestBeanUtils
        .getValuesByRequest(request, bean);//获取表单提交过来的数据
    //服务接口
    FileFilesService service = new FileFilesServiceImpl();    
    //保管期限
    List<Map<String,String>> deadlineList = service.queryDictByCode(FileConstant.DICT_TYPE_BGQX);
    
%>
<title></title>
<!-- 公共部分开始 -->
<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<!-- 引入jQuery UI -->
<script src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>
<!-- 引入jGrid -->
<link rel="stylesheet" type="text/css" media="screen" href="../../resources/plug/jquery.jqGrid-4.3.1/css/ui.jqgrid.css" />
<script src="../../resources/plug/jquery.jqGrid-4.3.1/js/i18n/grid.locale-en.js" type="text/javascript"></script>
<script src="../../resources/plug/jquery.jqGrid-4.3.1/js/jquery.jqGrid.min.js" type="text/javascript"></script>
<!-- 引入其它 -->
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js" charset="utf-8"></script>
<script src="../../resources/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<script src="../../resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<script type="text/javascript">
var path = "<%=path%>";
var windowId = "<%=windowId%>";
//搜索框的控制对象
$(function() {
    
    $(document).keydown(function(){
        if(event.keyCode == 13){ 
            search();
        }
    });
  //选中下拉框
    jQuery("#f_doc_deadline option[value='<%=StringUtil.deNull(bean.getF_doc_deadline())%>']").attr("selected","selected");
    jQuery("#f_doc_deadline").change(function(){
        search();
    });
    $("#gridTable").jqGrid({
        url: '<%=path%>/pubListServlet?classNameId=com.chinacreator.xtbg.core.file.list.FileDocList4AddToFile', 
        //jqGrid控件通过这个参数得到需要显示的数据，具体的返回值可以使XML也可以是Json
        datatype : "json",
        mtype : "POST",//定义使用哪种方法发起请求，GET或者POST
        height : "100%",
        autowidth : true,
       //表头设置       
        colModel : [ 
        {
            label : "f_doc_id",
            name : 'f_doc_id',
            index : 'f_doc_id',
            hidden : true
        }, {
            label : "组号",
            name : 'f_doc_num',
            index : 'f_doc_num'
        },{    
            label : "摄影者",
            name : 'f_shooting_user',
            index : 'f_shooting_user'
        }, {    
            label : "拍摄时间",
            name : 'f_file_formtime',
            index : 'f_file_formtime'
        },{
            label : "题名",
            name : 'f_doc_name',
            index : 'f_doc_name'
        }, {    
            label : "归档状态",
            name : 'f_doc_state_name',
            index : 'f_doc_state_name',
            hidden : true
        },{
            label : "保管期限",
            name : 'f_doc_deadline_name',
            index : 'f_doc_deadline_name'
        },{
            label : "照片张数",
            name : 'f_file_quantity',
            index : 'f_file_quantity'
        }, {    
            label : "所属部门",
            name : 'f_dept_name',
            index : 'f_dept_name'
        }, {    
            label : "地点",
            name : 'f_add',
            index : 'f_add'
        }
        ],
        sortname : 'f_doc_num',
        //指定默认的排序列，可以是列名也可以是数字。此参数会在被传递到Server端。
        sortorder : 'asc',
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
        postData : toUserParamJosn(),
        prmNames : { //这是一个数组，用于设置jqGrid将要向Server传递的参数名称
            rows : "rows",
            //表示请求行数的参数名称  
            sort : "sidx",
            //表示用于排序的列名的参数名称  
            order : "sord",
            //表示采用的排序方式的参数名称 
            search : "search"
        },
        toolbar : [ false, "top" ,""],
        multiselect : true    
        });
        
    });
   
    /*
        函数:  toUserParamJosn
        说明:  构建要查询的参数
        参数:   无
        返回值: 返回要查询的参数
     */
    var toUserParamJosn = function() {
         var param = {
    		 "bean.f_type_id": "<%=StringUtil.deNull(bean.getF_type_id()) %>",
             "bean.f_doc_year":jQuery("#f_doc_year").val(),        
             "bean.f_doc_deadline_name":jQuery("#f_doc_deadline option:selected").text(),
             "bean.f_doc_deadline":jQuery("#f_doc_deadline").val(),   
             "bean.f_doc_name" : jQuery("#f_doc_name").val(),
             "bean.f_org_id" : "<%=unitId%>",
             "bean.f_dept_name" : jQuery("#f_dept_name").val()
         };  
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
  var search = function(){
      var sdata = toUserParamJosn(); //获得当前postData选项的值  
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
 函数:  ajaxSubmit
 说明:  ajax访问后台
 参数:  state 状态 0：暂存，1：发布
 返回值: 无
 */
var ajaxSubmit = function(alertMsg,url){
	var selectedIds = $("#gridTable").jqGrid("getGridParam", "selarrrow");
    var ids = new Array();
    $(selectedIds).each(function () {
         var model = jQuery("#gridTable").jqGrid('getRowData', this);
         //id不为空
         ids.push(model.f_doc_id);  
     });
         
     if (!ids.length) {
         alert("未选记录，请重新选择！");
         return;
     }
     var param = {
           ids : ids.join(","),
           f_files_id : "<%=bean.getF_files_id()%>"

     };
     
    jQuery("#cz_fb_button").attr("disabled","disabled");
    //ajax方式提交数据
    jQuery.ajax({
        type: "post", 
        url: url,
        contentType: "application/x-www-form-urlencoded; charset=utf-8",
        data : param,
        dataType: "json", 
        success: function (data) {
            jQuery("#cz_fb_button").removeAttr("disabled");
            //操作成功，返回上层界面
            if(data && data.flag){
                if("true" == data.flag){
            	//调用父窗口的方法重新加载数据
                var pwindow = window.top.findPageCacheName(windowId).superwindow;
                if(pwindow && pwindow.search){
                    pwindow.search();
                }
              //刷新当前页面列表
                search();     
                alert(data.msg+"<br/>是否继续添加记录",{
                    headerText:'提示',
                    okName:'是',
                    NoName:'否',
                    okFunction:function(){
                       
                    },
                    NoFunction:function(){                    	
                        if(data.flag == "true"){
                            removeAlertWindows(windowId,true);
                         }
                    }                
                    });

                }else{
                   alert(data.msg);
                }  
            }
            
            
        }, 
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            alert("出现异常，请稍后再试！");
        } 
     });            
      
}

/**
 * 关闭弹出框
 */
function closed(){
	
    //新增或修改数据，提示是否保存        
   removeAlertWindows(windowId,true);
}

/*
函数:  Ok
说明:  入卷
参数:   无
返回值: 无
*/
var Ok = function() {   
     
     var url = path+"/ajaxServlet?className=com.chinacreator.xtbg.core.file.action.FileFilesAction&method=addDocToFiles";
     ajaxSubmit("确认提交吗？",url);
   
}
</script>
<!-- 公共部分结束 -->
</head>
<body>
   <table id="searchTable" width="100%" border="0" cellspacing="3" cellpadding="0" class="tabs_search_ctable">
          <tr>
             
              <th  class="input_cx_title_th" style="width:70px;">所属部门 ：</th>
               <td width="200" class="cx_title_td">                       
                   <input type="text"
                          class="input_cx_title_283"  style="width:200px;" 
                          id="f_dept_name" name="f_dept_name" 
                          value="<%=StringUtil.deNull(bean.getF_dept_name()) %>"/>                 
                   
              </td>
              <th style="width:70px;" class="input_cx_title_th">档案年份：</th>
              <td width="100" class="cx_title_td">
                 <input style = "width:100px;;background:url(/xtbg/ccapp/oa/resources/style/blue/images/date_img_year.jpg) right 1px no-repeat;" type="text" class="date_120 Wdate" name="f_doc_year" id="f_doc_year"
                        value="<%=StringUtil.deNull(bean.getF_doc_year()) %>"
                        onclick="WdatePicker({dateFmt:'yyyy'})"/>
              </td>           
              <td style="width:150px;" >
                  <input value="搜索" id="sel" type="button" onclick="search();" 
                  class="but_y_01" />
              </td> 
          </tr>
          <tr>
              <th style="width:70px;" class="input_cx_title_th">题名：</th>
              <td style="width:200px;" class="cx_title_td">
                  <input type="text"
                          class="input_cx_title_283"  
                          style="width:200px;" id="f_doc_name" name="f_doc_name"
                           />
              </td>
              <th  class="input_cx_title_th" style="width:70px;">保管期限：</th>
               <td style="width:200px;" class="cx_title_td" colspan="2">                   
                  <select id="f_doc_deadline" name="f_doc_deadline"
                          style="width:100px;" class ="select_100_box_type"'>                                 
                     <%for(Map<String,String> dead : deadlineList){ 
                       String value = StringUtil.deNull(dead.get("dictdata_value"));
                       String name = StringUtil.deNull(dead.get("dictdata_name"));
                     %>                               
                     <option  value="<%=value %>"><%=name %></option>
                     <%} %>
                  </select>                      
               </td>              
          </tr>
    </table>

    <!-- 查询列表区 cGridArea(查询区样式)-->
    <div class="cGridArea">
        <table id="gridTable"></table>
        <div id="gridPager"></div>
    </div>
   <div class="content_02" style="overflow: hidden;position: absolute;bottom: 0px;" id="_top"><!-- 操作-->
        <div class="content_02_top" style="border-bottom: 0px;border-top:1px solid #9dbfe4;padding-right:5px;">
            <input name="close_button"  value="关闭" onclick="closed()" type="button" class="but_y_01" style="float: right;margin-right: 5px;" />
            <input  name="cz_fb_button" id="cz_fb_button" value="保存" onclick="Ok(this.value);" style="float:right;" type="button" class="but_y_01" /> 
        </div>
    </div>
</body>
</html>
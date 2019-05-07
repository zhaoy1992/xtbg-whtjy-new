<%--
describe:消息列表界面
author:dailianchun
date: 2013-9-11
--%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.common.util.*"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.UserCache"%>
<%@page import="com.chinacreator.xtbg.core.kbm.util.KbmUtil"%><html>
<head>
<%
    AccessControl controler = AccessControl.getAccessControl();
    controler.checkAccess(request, response);
    String path = request.getContextPath();
    //获得当前登录用户的id
    String userId = controler.getUserID();    
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
<script src="../../resources/util/multiSelect.js" type="text/javascript"></script>

<script type="text/javascript">
var path = "<%=path%>";
$(function() {    
    $(document).keydown(function(){
        if(event.keyCode == 13){
            search();
        }
    });

    $("#gridTable").jqGrid({
        url: '<%=path%>/ajaxServlet?className='
             +'com.chinacreator.xtbg.core.common.msgcenter.action.MessageAction'
             +'&method=queryMessageList', 
        //jqGrid控件通过这个参数得到需要显示的数据，具体的返回值可以使XML也可以是Json
        datatype : "json",
        mtype : "POST",//定义使用哪种方法发起请求，GET或者POST
        height : "100%",
        autowidth : true,
       //表头设置       
        colModel : [
                    {
                        label : "消息id",
                        name : 'msg_id',
                        index : 'msg_id',
                        hidden : true
                    },{
                        label : "发送人",
                        name : 'user_name',
                        index : 'user_name',
                        formatter : fomatterType,
                        editable : false
                    }, {
                        label : "内容",
                        name : 'msg_content',
                        index : 'msg_content',
                        formatter : fomatterType,
                        width:400,
                        editable : false
                    },{ 
                        label : "时间",
                        name : 'send_date',
                        index : 'send_date',
                        formatter : fomatterType,
                        editable : false
                    },{ 
                        label : "是否已读",
                        name : 'isread',
                        index : 'isread',
                        hidden : true,
                        editable : false
                    },{ 
                        label : "接收消息id",
                        name : 'recv_id',
                        index : 'recv_id',
                        hidden : true,
                        editable : false
                    }
        ],
        sortname : 'send_date',
        sortorder : 'desc',
        viewrecords : true,
        rowNum : 20,
        //用于设置Grid中一次显示的行数，默认值为20。正是这个选项将参数rows（prmNames中设置的）通过url选项设置的链接传递到Server。注意如果Server返回的数据行数超过了rowNum的设定，则Grid也只显示rowNum设定的行数。
        rowList : [ 10, 20, 30 ],//一个数组，用于设置Grid可以接受的rowNum值。例如[10,20,30]
        jsonReader : { //这又是一个数组，用来设定如何解析从Server端发回来的json数据
            repeatitems : false
        },
        //定义页码控制条Page Bar
        pagerintoolbar:true,//上面的分页条
        pagerinBottombar:true,//下面的分页条
    
        //设置Grid表格的标题，如果未设置，则标题区域不显示。
        postData : toUserParamJosn(),
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
                update(model.recv_id,model.isRead);
            }
        }
                    
        });

    //设置工具栏的宽度
    jQuery("#tool_buttons").width(jQuery("table[class=ui-jqgrid-htable]").width());
        
    });
   
    /*
         函数:  toUserParamJosn
         说明:  构建要查询的参数
         参数:   无
         返回值: 返回要查询的参数
     */
    var toUserParamJosn = function(){
        var param = new Object();
        
        param["rbean.ishidden"] = "0";//默认查询未隐藏的数据
        param["rbean.recv_userid" ] = "<%=userId%>";
       
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
        var sdata = toUserParamJosn("bean."); 
        
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
        函数:  update
        说明:  修改 
        参数:  无
        返回值: 无
    */
    var update = function(recv_id,isread){        
        openAlertWindows('show_messageDetail'
                ,path+'/ccapp/oa/msgcenter/jsp/messagedetail.jsp?'
                +'windowId=show_messageDetail&recv_id='+recv_id+'&isread='+isread, 
                '查看消息'
                ,350,250,'5%','10%',function(){search();});
    }

/*
       函数:  del
      说明:  删除
      参数:  无
      返回值: 无
*/
var del = function() {
       var ids = "";
       var selectedIds = $("#gridTable").jqGrid("getGridParam", "selarrrow");
       var ids = new Array();
       var total = selectedIds.length;//总共选中的记录数       
       $(selectedIds).each(function () {
           var model = jQuery("#gridTable").jqGrid('getRowData', this);
           //id不为空
           ids.push(model.recv_id); 
       });
           
       if (!ids.length) {
           alert("请至少选择一条记录!");
       } else {
           var okF = function(){
               //ajax方式提交数据
               jQuery.ajax({
                   type: "post", 
                   url: '<%=path%>/ajaxServlet?className='
                       +'com.chinacreator.xtbg.core.common.msgcenter.action.MessageAction'
                       +'&method=deleteMessageLogically',  
                   contentType: "application/x-www-form-urlencoded; charset=utf-8",
                   data : {                      
                	   recvIds : ids.join(","), //要删除的id列表      
                	   userId : "<%=userId%>"
                   },
                   dataType: "json", 
                   success: function (data) {
                       if(data){                          
                           //如果删除成功，刷新数据
                           if(data.flag){
                        	   alert(data.msg);;
                               search();
                           }else{
                               if(data.msg){
                                   alert(data.msg);
                               }
                           }
                       }
                   }, 
                   error: function (XMLHttpRequest, textStatus, errorThrown) { 
                      alert("系统异常，请稍后再试！");
                   }
                });
           }
           var p={
                       headerText:'提示',
                       okName:'确认',
                       okFunction:okF,
                       cancelName:'取消'
               };
           alert("删除后将不能恢复，确定删除吗？",p); 
       }
   }

/**
 * 清空所有
 */
  var deleteAll = function(){
	  if(!jQuery("#gridTable").getGridParam("reccount")){
         alert("消息列表为空!");
         return;
	  }
	  var okF = function(){
          //ajax方式提交数据
          jQuery.ajax({
              type: "post", 
              url: '<%=path%>/ajaxServlet?className='
                  +'com.chinacreator.xtbg.core.common.msgcenter.action.MessageAction'
                  +'&method=deleteMessageLogically',  
              contentType: "application/x-www-form-urlencoded; charset=utf-8",
              data : {
                  userId : "<%=userId%>"
              },
              dataType: "json", 
              success: function (data) {
                  if(data){
                      //如果删除成功，刷新数据
                      if(data.flag){
                          alert(data.msg);;
                          search();
                      }else{
                          if(data.msg){
                              alert(data.msg);
                          }
                      }
                  }
              }, 
              error: function (XMLHttpRequest, textStatus, errorThrown) { 
                  alert("系统异常，请稍后再试！");
              }
           });
      }
      var p={
                  headerText:'提示',
                  okName:'确认',
                  okFunction:okF,
                  cancelName:'取消'
          };
      alert("清空后将不能恢复，确定清空吗？",p); 
  }

  /**
   *将记录全部标记为已读
   */
  var updateAllReaded = function(id) {
	     if(!jQuery("#gridTable").getGridParam("reccount")){
	         alert("消息列表为空!");
             return;
		 }
         var ids = "";
         var selectedIds = $("#gridTable").jqGrid("getGridParam", "selarrrow");
         var ids = new Array();
         var total = selectedIds.length;//总共选中的记录数       
         $(selectedIds).each(function (){
             var model = jQuery("#gridTable").jqGrid('getRowData', this);
             //id不为空
             ids.push(model.recv_id); 
         });
                  
         //ajax方式提交数据
         jQuery.ajax({
             type: "post", 
             url: '<%=path%>/ajaxServlet?className='
                 +'com.chinacreator.xtbg.core.common.msgcenter.action.MessageAction'
                 +'&method=updateAllMessageReaded',  
             contentType: "application/x-www-form-urlencoded; charset=utf-8",
             data : {                      
            	 recvIds : ids.join(","),//要标记为已读的id列表                      
            	 userId :  "<%=userId%>"
             },
             dataType: "json", 
             success: function (data){
                 if(data){
                     //成功，刷新数据
                     if(data.flag){
                         alert(data.msg);;
                         search();
                     }else{
                         if(data.msg){
                             alert(data.msg);
                         }
                     }
                 }
             }, 
             error: function (XMLHttpRequest, textStatus, errorThrown) { 
                alert("系统异常，请稍后再试！");
             }
          });
     }
  
	/**
	 *高亮显示未读的列
	 */
	function fomatterType(value,column,row){
	     if(row.isread == "0"){
	         return "<span style='font-weight:bolder;'>"+value+"</span>";  
	       }
	       return value;
	}
</script>
<!-- 公共部分结束 -->
</head>
<body class="vcenter" style="overflow: auto;overflow-x:hidden;">
    <!-- 查询列表区 cGridArea(查询区样式)-->
 
    <div class="cGridArea" style="width:100%;margin-top: 10px;">   
    <div id="tool_buttons" class="ui-jqgrid .ui-userdata ui_t_bottombar_content" 
         style="height:28px;margin-left:10px;margin-bottom:0px;float: none;border: #ebebeb 1px solid;">            
           <input name="deleteButton" id="deleteButton" onclick='del()' value="删除" type="button" class="but_y_01" style="float: left;margin-left: 5px;" />
           <input name="deleteAll" id="deleteAll" onclick='deleteAll()' value="清空" type="button" class="but_y_01" style="float: left;margin-left: 5px;" />
           <input name="updateAllReaded" id="updateAllReaded" onclick='updateAllReaded()' value="全部标记为已读" type="button" class="but_y_03" style="float: left;margin-left: 5px;width:105px;" />
           
   </div>
     <table id="gridTable" style="width:100%"></table>
     <div id="gridPager"></div>
    </div>
    
</body>
</html>
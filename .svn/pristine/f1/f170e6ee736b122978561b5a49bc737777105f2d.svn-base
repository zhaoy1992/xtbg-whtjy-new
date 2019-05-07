<%--
describe:调卷界面
author:dailianchun
date: 2013-8-20
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
<%@page import="com.chinacreator.xtbg.core.file.util.FileConstant"%>
<%@page import="com.chinacreator.eform.util.Escape"%><html>
<head>
<%
    AccessControl controler = AccessControl.getAccessControl();
    controler.checkAccess(request, response);
    String path = request.getContextPath();
    String id = StringUtil.deNull(request.getParameter("id"));//档案id
    String windowId = StringUtil.deNull(request.getParameter("windowId"));//窗口id
    String f_type_id = StringUtil.deNull(request.getParameter("f_type_id"));//类型id
    String columnName = StringUtil.deNull(request.getParameter("columnName"));//图片档案为组号
    if(StringUtil.nullOrBlank(columnName)){
    	columnName = "件号";
    }else{
    	//解码
        columnName =DataControlUtil.replaceStr(columnName);
        columnName = Escape.unescape(columnName);
    }
    //获得当前登录用户的id
    String userId = controler.getUserID();    
    //获得缓存的机构信息
    UserCacheBean userBean = UserCache.getUserCacheBean(userId);
    String unitId = userBean.getUnit_id();//所属单位id
    String orgName = userBean.getOrg_name();//所属部门
    //服务对象
    FileFilesService service = new FileFilesServiceImpl();  
    //保管期限
    List<Map<String,String>> deadlineList =  service.queryDictByCode(FileConstant.DICT_TYPE_BGQX);
    String year = DateUtil.getCurrentYear();//获得当前年
    
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
<link rel="stylesheet" type="text/css" media="screen" href="../resources/css/filefitcss.css" />

<script type="text/javascript">
var path = "<%=path%>";
var windowId = "<%=windowId%>";
var unitId = "<%=unitId%>";
var f_type_id = "<%=f_type_id%>";
//用来判断是否更改的对象
var dataObj = {
    "#fromDiv" : null,
    "#toDiv" : null
		
};
//搜索框的控制对象
$(function() {
	var height = window.top.findPageCacheName("_documentBodyHeight");
	if(height){
		//设置div的高度		
	    jQuery("#fromDiv,#toDiv").height((height-200)<100?100:(height-200));
   }   

	
    jQuery("#f_dept_name").focus();
    $(document).keydown(function(){
        if(event.keyCode == 13){
            search();
        }
    });
    jQuery("#from").change(function(a,b,c){
        changeSelect("#from","#fromDiv");
        //如果元素有变化，则重新加载数据
        if(isMoved("#toDiv")){
           changeSelect("#to","#toDiv");
        }
     });
    jQuery("#to").change(function(){
    	//如果元素有变化，则重新加载数据
        if(isMoved("#fromDiv")){
        	changeSelect("#from","#fromDiv");
        }
        changeSelect("#to","#toDiv");
     }); 
    jQuery("#toDiv").sortable(
            {
                delay:1,
                connectWith : '#fromDiv' ,
                distance : 0,//拖动多少像素才触发排序操作
                opacity: 0.6,//拖拽时的透明度
                dropOnEmpty : true,//是否允许拖拽到一个空的sortable
                scroll : false,
                tolerance : "pointer", //鼠标指针到达其他元素区域就开始执行排序
                helper : "original",//移动时是克隆一个对象还是拖动原始对象  
                receive : function(event,ui){                                        
                    //如果不能调卷，则将移动的对象返回
                    if(!isMoveAble()){
                      jQuery(ui.item).appendTo("#fromDiv");
                      return;
                    }
                    jQuery(ui.item).attr("class","selected");
                }
            }
    ); 
    jQuery("#fromDiv").sortable(
            {
                delay:1,
                connectWith : '#toDiv',//允许拖拽到指定的sortable
                distance : 0,
                opacity: 0.6,//拖拽时的透明度
                dropOnEmpty : true,//是否允许拖拽到一个空的sortable
                scroll : false,
                tolerance : "pointer",
                helper : "original",
                receive : function(event,ui){
	            	//如果不能调卷，则将移动的对象返回
	                if(!isMoveAble()){
	                  jQuery(ui.item).appendTo("#toDiv");
	                  return;
	                }
	                jQuery(ui.item).attr("class","selected");
              }
      }


    );
    //查询数据
    search();

    //设置页面高度
    adaptationWH('','content',65);
    
    });
  /**
   *选择框更改，查询
   */
  function changeSelect(selectId,divId){
      //重置用来判断是否改变的数组
      dataObj[divId+""] = null;
      dataObj[divId+""] = new Array();
      //清空提示信息
      jQuery("#msg").text("");
      
      //没有案卷记录，则不能调卷
      if("---请选择---" == jQuery(selectId).val()){
        jQuery(divId).html("");
        return;
      }
      jQuery(selectId).attr("title",jQuery(selectId+" option:selected").text());
      var data = { 
              filesId :jQuery(selectId).val(),
              rows : "1000",
              //表示请求行数的参数名称  
              sidx : "f_doc_num",
              //表示用于排序的列名的参数名称  
              sord :"asc",
              page : "1"
      };
      searchDoc(data,divId);
  }
  /*
        函数:  toUserParamJosn
        说明:  构建要查询的参数
        参数:   无
        返回值: 返回要查询的参数
   */
    var toUserParamJosn = function() {
         var param = {
             "bean.f_type_id": f_type_id,//类型信息
             "bean.f_doc_year":jQuery("#f_doc_year").val(),
             "bean.f_doc_deadline":jQuery("#f_doc_deadline").val(),   
             "bean.f_dept_name" : jQuery("#f_dept_name").val(),
             "bean.f_org_id" : unitId,//单位id
             "page.page":"1",//由于沿用的列表查询数据的方法，故需传入分页数据
             "page.rows" : "1000",
             "page.sortName":"f_filesno",//按案卷号升序排列
             "page.sortOrder":"asc"
         };  
        //转码
        for(var name in param ){
            param[name] = descape(escape(param[name]));
        }                
        return param;
    }

    /**
     *查询档案列表
     */
   function searchFile(){
	   var url = path+'/ajaxServlet?className=com.chinacreator.xtbg.core.file.action.FileFilesAction&method=queryFilesList';
       var data = toUserParamJosn();
       var backFn = function(data){   
           var rows = data.rows;
           if(rows){
               addOption("#from",rows);
               addOption("#to",rows);
               //触发onchange事件
               jQuery("#from,#to").trigger("change");
           }
           
       };
       publicAjax(url,data,backFn);

   }
  
   /**
    *查询卷内文件
    */ 
   function searchDoc(data,divId){
       var url = path+'/pubListServlet?classNameId=com.chinacreator.xtbg.core.file.list.FileDocListForFiles';
      
       var backFn = function(backData){         
           if(backData && backData.rows){
               addTr(backData.rows,divId);
           }     
       };
       publicAjax(url,data,backFn);
   } 
   /**
    *查询数据
    */
   function search(){	   
       var flag = isMoved("#toDiv");
       if(!flag){
          searchFile();
       }else{
    	   alert("尚未保存更改，是否继续？",{
                    headerText:'提示',
                    okName:'是',
                    okFunction:function(){     
                       searchFile();
                    },
                    cancelName:'否'
           });    
       }
   }

   /**
    *给select添加option
    */
   function addOption(id,rows){
      //首先清空select框
      jQuery(id).html("").attr("title","");
      jQuery(id).html("<option value='---请选择---'>---请选择---</option>");     
      for(var i=0;i<rows.length;i++){
          if(i==0){
              jQuery(id).attr("title",rows[i].f_files_no);  
          }
         jQuery("<option title='"
                 +rows[i].f_files_no+"' value='"+rows[i].f_files_id +"'"+
                 +" f_doc_year ='"+rows[i].f_doc_year+"'"
                 +" f_dept_id ='"+rows[i].f_dept_id+"'"
                 +" f_doc_deadline ='"+rows[i].f_doc_deadline+"'"
                 +">"+rows[i].f_files_no+"</option> ").appendTo(id);
      }
   }

   /**
    *添加行数据 
    */
   function addTr(rows,divId){
       jQuery(divId).html("");//清空数据
       //添加数据
       var htmlArray = new Array();
       
       for(var i=0;i<rows.length;i++){
    	  dataObj[divId+""].push(rows[i].f_doc_id);
          htmlArray.push("<div id='"+divId.substring(1,divId.length-1)+i+"' class='unselected' onClick ='onDivClick(this)'");
          htmlArray.push(" onMouseOver='onMouseOver(this)'");
          htmlArray.push(" onMouseOut='onMouseOut(this)'");
          htmlArray.push(" ondblclick='moveOne(this.id,\""+divId+"\")'"); 
          htmlArray.push(" f_doc_id='"+rows[i].f_doc_id+"'");
          htmlArray.push(" parent_div='"+divId+"'");
          htmlArray.push("><div style='width:10%;float:left;line-height:23px;'");
          htmlArray.push(" title='"+rows[i].f_doc_num+"'>");
          htmlArray.push(rows[i].f_doc_num);
          htmlArray.push("</div><div style='width:90%;float:left;line-height:23px;'");
          htmlArray.push(" title='"+rows[i].f_doc_name+"'>");
          htmlArray.push(rows[i].f_doc_name);
          htmlArray.push("</div></div>");
       }    
       jQuery(divId).html(htmlArray.join(""));
   }

   /**
    *移动
    */
   function move(fromDiv,toDiv,button){
	   var moves = jQuery(fromDiv).find(".selected");
	   jQuery("#msg").text("");
       //选中了记录，且可以移动，才进行移动
       if(moves.length>0 ){
           if(isMoveAble()){
              moves.appendTo(toDiv);
           }
       }else{
           jQuery("#msg").text("提示：请至少选中一条记录！");
           //滚动到底部
           jQuery("#content")[0].scrollTop = jQuery("#content")[0].scrollHeight;
       }
       
       if(button){
         jQuery(button).blur();
       }
   }

   /**
    *移动单个的记录
    */
   function moveOne(id){
	   var moveToDiv = "#toDiv";
	   var parentId = jQuery("#"+id).parent().attr("id");
	   if(parentId=="toDiv"){
		   moveToDiv = "#fromDiv";
	   }
	   if(isMoveAble()){
	      jQuery("#"+id).attr("class","selected").appendTo(moveToDiv);
	   }
   }

   /**
    *判断元素是否有变化
    */
   function isMoved(divId){
     var idArray = dataObj[divId+""];
     if(!idArray){
       return false;
     }
     debugger;
     var divs =  jQuery(divId+">div");
     if(idArray.length != divs.length){
        return true;
     }
     //判断元素是否被移出
     for(var i=0;i<idArray.length;i++){
        var id = idArray[i];
        var isMoveOut = true;//默认为该元素已经被移动
        divs.each(function(){
            if(id == jQuery(this).attr("f_doc_id")){
                //找到该元素，则进入下一次循环
               isMoveOut = false;
               return false;//用于跳出循环
            }
        });
        //元素已经被移出，则说明被改变
        if(isMoveOut){
          return true;
        }
     }

     return false;
   }

   /**
    *判断是否能够调卷
    */
   function isMoveAble(){
      //清空提示信息
      jQuery("#msg").text("");
      	   
      var from = jQuery("#from");
      var to = jQuery("#to");
      if("---请选择---" == from.val() || "---请选择---"==to.val()){
          jQuery("#msg").text("提示：未选择案卷，不能进行调卷！");
          //滚动到底部
          jQuery("#content")[0].scrollTop = jQuery("#content")[0].scrollHeight;
          return false;
      }
      if(from.val() == to.val()){
         jQuery("#msg").html("提示：选中的为同一个案卷，不能进行调卷！");
         //滚动到底部
         jQuery("#content")[0].scrollTop = jQuery("#content")[0].scrollHeight;
         return false;
      }
      if(from.attr("f_doc_year") != to.attr("f_doc_year")){
         jQuery("#msg").text("提示：【档案年份】不同，不能进行调卷！");
         //滚动到底部
         jQuery("#content")[0].scrollTop = jQuery("#content")[0].scrollHeight;
         return false;
      }
      if(from.attr("f_dept_id") != to.attr("f_dept_id")){
          jQuery("#msg").text("提示：【所属部门】不同，不能进行调卷！");
          //滚动到底部
          jQuery("#content")[0].scrollTop = jQuery("#content")[0].scrollHeight;
          return false;
      }
      if(from.attr("f_doc_deadline") != to.attr("f_doc_deadline")){
          jQuery("#msg").text("提示：【保管期限】不同，不能进行调卷！");
          //滚动到底部
          jQuery("#content")[0].scrollTop = jQuery("#content")[0].scrollHeight;
          return false;
      }
      return true;
      
   }
   /**
    *单击后触发的事件
    */
   function onDivClick(obj){
       var objClass = jQuery(obj).attr("class");
       if(objClass == "unselected" || objClass =="onmouseover"){
           jQuery(obj).attr("class","selected");      
       }else{
           jQuery(obj).attr("class","unselected");      
       }        
   }

   /**
    *鼠标移入触发的事件
    */
   function onMouseOver(obj){
       var objClass = jQuery(obj).attr("class");
       if(objClass != "selected"){
           jQuery(obj).attr("class","onmouseover");      
       }       
   }

   /**
    *鼠标移出触发的事件
    */
   function onMouseOut(obj){
       var objClass = jQuery(obj).attr("class");
       if(objClass == "onmouseover"){
           jQuery(obj).attr("class","unselected");      
       }  
   }

   /**
    *保存数据
    */
   function save(){
	   var flag = isMoved("#toDiv");
	   if(!flag){
          alert("没有进行修改");
          return;
	   }
	   //找到选中的option
	   var f_files_id_from = jQuery("#from").val();
	   var idsArray = new Array();
	   jQuery("#fromDiv>div").each(function(){
		   idsArray.push(jQuery(this).attr("f_doc_id"));
        });

	   var f_files_id_to = jQuery("#to").val();
	   var idsArrayTo = new Array();
       jQuery("#toDiv>div").each(function(){
    	   idsArrayTo.push(jQuery(this).attr("f_doc_id"));
        });
     var data={
          ids : idsArray.join(","),
          f_files_id : f_files_id_from,
          ids_to : idsArrayTo.join(","),
          f_files_id_to : f_files_id_to
     };
     var backFn = function(data){
         if(data&&data.msg){
           alert(data.msg);
          }
         if(data.flag){
             //操作完成以后，重新加载select框中的值
        	 changeSelect("#from","#fromDiv");
             changeSelect("#to","#toDiv");
             
         }
     }
     var url = path+"/ajaxServlet?className="
     +"com.chinacreator.xtbg.core.file.action.FileFilesAction&method=fitFiles";
     publicAjax(url,data,backFn);
     
   }
   
  /**
   *公用的ajax提交方法
   */
  function publicAjax(url,data,backFn){
      //ajax方式提交数据
        jQuery.ajax({
            type: "post", 
            url: url,
            contentType: "application/x-www-form-urlencoded; charset=utf-8",
            data : data,
            dataType: "json", 
            success: function (data) {
                if(backFn&& (typeof backFn=='function')){
                    backFn(data);
                }
            }, 
            error: function (XMLHttpRequest, textStatus, errorThrown) { 
                jQuery("#cz_fb_button").removeAttr("disabled");
                alert("出现异常，请稍后再试！");
            }
         });      

  }

/**
 * 关闭弹出框
 */
function closed(){    
   var flag = isMoved("#toDiv");
   if(!flag){
	   removeAlertWindows(windowId,true);
   }else{
       alert("尚未保存更改，是否继续关闭？",{
                headerText:'提示',
                okName:'是',
                okFunction:function(){     
		    	 //新增或修改数据，提示是否保存        
		    	   removeAlertWindows(windowId,true);
                },
                cancelName:'否'
       });    
   }
}

</script>
<!-- 公共部分结束 -->
</head>
<body>
 <div id="content" style="width:100%">
   <table id="queryTable" width="100%" border="0" cellspacing="0" cellpadding="0" class="tabs_search_ctable_box">
        <tr>
            <td>
            <!-- 固定查询 -->
                <table id="searchTable" width="100%" border="0" cellspacing="3" cellpadding="0" class="tabs_search_ctable">
                    <tr>
                       
                        <th  class="input_cx_title_th" style="width:70px;">所属部门 ：</th>
                         <td width="120" class="cx_title_td">
                             <input type="text"
                                    class="input_cx_title_283"  style="width:120px;"
                                     id="f_dept_name" name="f_dept_name" value="<%=orgName %>"/>
                             
                        </td>
                         <th style="width:70px;" class="input_cx_title_th">档案年份：</th>
                        <td width="100" class="cx_title_td">
                        <input style = "width:100px;;background:url(/xtbg/ccapp/oa/resources/style/blue/images/date_img_year.jpg) right 1px no-repeat;" type="text" class="date_120 Wdate" name="f_doc_year" id="f_doc_year"
                             onclick="WdatePicker({dateFmt:'yyyy'})" value="<%=year %>"/>
                        </td>
                      <th  class="input_cx_title_th" style="width:70px;">保管期限：</th>
                        <td valign="top" width="120"  class="cx_title_td">
                        <select style="width:105px;" name ="f_doc_deadline" id= "f_doc_deadline"  >
                            <%for(Map<String,String> dead : deadlineList){ 
                                  String value = StringUtil.deNull(dead.get("dictdata_value"));
                                  String name = StringUtil.deNull(dead.get("dictdata_name"));
                                %>                               
                                <option  value="<%=value %>" ><%=name %></option>
                                <%} %>
                        </select>
                        </td>
                        <td width="60" >
                            <input value="搜索" id="sel" style="float:left;" type="button" onclick="search();" class="but_y_01" />
                        </td>
                        <td>
                        &nbsp;
                        </td>
                    </tr>                   
                </table>
            <!-- 固定查询 end-->
            </td>
        </tr>
    </table>
    
    <div style="width:100%;text-align: center;" align="center">
    <table cellpadding="0" border="0" cellspacing="0" style="width:98%;margin-left: 10px;">
    <tr style="height:30px;line-height: 30px;">
      <td width="45%" style="border:1px solid #f1f1f1;text-align: left;padding-left:5px;">
                      当前案卷档号：
       <select id="from" name="from" style="width:250px;height:20px;line-height:20px;vertical-align: middle;"></select> 
      </td>
      <td style="width:40px;" rowspan="2" valign="middle" align="center">
        <div>
        <input class="but_right_1"  name="toRight" id="toRight" value="" onclick="move('#fromDiv','#toDiv',this);" style="" type="button" /> 
        </div>
        <div>
        <input class="but_left_1" name="toLeft" id="toLeft" value="" onclick="move('#toDiv','#fromDiv',this);" style="margin-top:30px; " type="button" /> 
        </div>
      </td>
      <td width="45%" style="border:1px solid #f1f1f1;text-align: left;padding-left:5px;" >
                       目标案卷档号：
      <select id="to" name="to" style="width:250px;height:20px;line-height:20px;vertical-align: middle;"></select> 
      </td>
    </tr>
     <tr valign="top">
      <td width="45%" style="border:1px solid #f1f1f1;border-top: #fff 0px;" valign="top">
       <table cellpadding="0" cellspacing="0" style="width:100%;height:100%;border-top:#fff 2px solid; ">
           <tr   style="height: 25px;margin-top: 0px;background:#f1f1f1;font-weight:bolder;">
               <td style="border-bottom: #C5DBEC 1px solid;width:10%"><%=columnName %></td>
               <td style="border-bottom: #C5DBEC 1px solid;width:90%">标题</td>
           </tr>
           <tr><td colspan="2" style="width:100%">
           <div id="fromDiv" class="vcenter" style="width:100%;overflow:auto;overflow-x:hidden;text-align: left;">
           
           </div>
           
           </td></tr>  
        </table>
        
        
        </td>
        
        <td width="45%" style="border:1px solid #f1f1f1;border-top: #fff 0px;"  valign="top">
        <table cellpadding="0" cellspacing="0" style="width:100%;height:100%;border-top:#fff 2px solid;table-layout:fixed; ">
           <tr   style="height: 25px;margin-top: 0px;background:#f1f1f1;font-weight:bolder;">
               <td style="border-bottom: #C5DBEC 1px solid;width:15%"><%=columnName %></td>
               <td style="border-bottom: #C5DBEC 1px solid;width:90%;">标题</td>
           </tr>
           <tr><td colspan="2" style="width:100%">
           <div id="toDiv" class="vcenter"  style="width:100%;overflow:auto;text-align: left;overflow-x:hidden;">
           
           </div>           
           </td></tr>   
        </table>
      </td>
    </tr>
    <tr>
    <td id="msg" colspan="3" style="text-align:left;height:30px;width:100%;color:red;font-weight: bold;line-height: 30px;"></td>
    </tr>
    </table>
    </div>
    </div>
   <div class="content_02" style="overflow: hidden;position: absolute;bottom: 0px;" id="_top"><!-- 操作-->
        <div class="content_02_top" style="border-bottom: 0px;border-top:1px solid #9dbfe4;padding-right:5px;">
            <input name="close_button"  value="关闭" onclick="closed()" type="button" class="but_y_01" style="float: right;margin-right: 5px;" />
            <input  name="cz_fb_button" id="cz_fb_button" value="保存" onclick="save();" style="float:right;" type="button" class="but_y_01" /> 
        </div>
    </div>
  
</body>
</html>
<%--
describe:查看反馈列表信息
author:dailianchun
date: 2013-11-6
--%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.common.util.*"%>
<%@page import="java.util.*"%>
<%@page import="com.chinacreator.xtbg.core.meeting.entity.*"%>
<%@page import="com.chinacreator.xtbg.core.meeting.service.impl.*"%>
<%@page import="com.chinacreator.xtbg.core.meeting.service.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@page import="com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.UserCache"%>
<%@page import="com.chinacreator.xtbg.core.inspect.service.InspectManageService"%>
<%@page import="com.chinacreator.xtbg.core.inspect.service.impl.InspectManageServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.inspect.entity.InspectBaseInfoBean"%>
<%@page import="com.chinacreator.xtbg.core.sysparam.util.SysParamUitl"%>
<%@page import="com.chinacreator.xtbg.core.sysparam.util.SysParamConstant"%>
<%@page import="com.chinacreator.xtbg.core.inspect.util.InspectConstant"%><html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
    AccessControl accesscontroler = AccessControl.getAccessControl();
    accesscontroler.checkAccess(request, response);
    String userId = accesscontroler.getUserID();
    String path = request.getContextPath();
    String id = StringUtil.deNull(request.getParameter("id"));//主键id  
    String recept_id = StringUtil.deNull(request.getParameter("recept_id"));//接收主键id
    String windowId = request.getParameter("windowId");//窗口id
    String flag = StringUtil.deNull(request.getParameter("flag"));//状态  0：暂存，1：交办，（2，3）：办结 （完成，未完成）
           flag = StringUtil.nullOrBlank(flag)?"0":flag;
    String recept_state = StringUtil.deNull(request.getParameter("recept_state"));//反馈状态 0：未反馈；1：已反馈；2：退回重办
           recept_state = StringUtil.nullOrBlank(recept_state)
                ?InspectConstant.RECEPT_RESPONSE:recept_state;
    

 
%>
<title>JGRID</title>
<!-- 引入jQuery -->
<script type="text/javascript"src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script type="text/javascript">jQuery.noConflict();</script>
<!-- 引入jQuery UI -->
<script src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>

<!-- 引入formvValidatetion -->
<script  src="../../resources/plug/formvalidation/jquery.validationEngine-cn.js" type="text/javascript"></script>
<script src="../../resources/plug/formvalidation/jquery.validationEngine.js" type="text/javascript"></script>

<!-- 引入jGrid -->
<link rel="stylesheet" type="text/css" media="screen"  href="../../resources/plug/jquery.jqGrid-4.3.1/css/ui.jqgrid.css" />
<script src="../../resources/plug/jquery.jqGrid-4.3.1/js/i18n/grid.locale-en.js" type="text/javascript"></script>
<script src="../../resources/plug/jquery.jqGrid-4.3.1/js/jquery.jqGrid.min.js" type="text/javascript"></script>

<script src="../../resources/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js"></script>
<!-- 引入上传控件 -->
<script type="text/javascript" src="../../resources/plug/fancyupload/mootools-1.2.5-core-jm.js"></script>
<script type="text/javascript" src="../../resources/plug/fancyupload/source/Fx.ProgressBar.js"></script>
<script type="text/javascript" src="../../resources/plug/fancyupload/source/Swiff.Uploader.js"></script>
<script type="text/javascript" src="../../resources/plug/fancyupload/source/FancyUpload3.Attach.js"></script>
<script type="text/javascript" src="../../resources/plug/fancyupload/myfancyupload.js"></script>
<!-- 日期控件 -->
<script src="../../resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<script src="../../resources/plug/form/jquery.form.js" type="text/javascript"></script>

<script type="text/javascript">
var id = "<%=id%>";
var flag = "<%=flag%>";//状态
var recept_state = "<%=recept_state%>";//反馈状态
var windowId = "<%=windowId%>";
var recept_id = "<%=recept_id%>";//任务接收id
//任务id
var info_id = "<%=StringUtil.deNull(id)%>";
//登记人员id
var userId = "<%=StringUtil.deNull(userId)%>";
//附件是否可编辑的选项
var attachFlag = false;

//系统根路径
var path = "<%=path %>";


jQuery(function() {     
     //状态为“办理中”，且反馈状态为已反馈 
     if("1"== flag && ("1"==recept_state)){  
         jQuery("#fk_button").show();  
     }
     //加载回复信息  
     getResponseList("recept_list");
});
/**
 * 获取回复信息
 */
function getResponseList(objId){   
     var url = path+"/ajaxServlet?className=com.chinacreator.xtbg."
        +"core.inspect.action.InspectManageAction&method=queryListResponse";
     var data = { "recept.recept_id":recept_id};
     var backFn = function(data){
        if(data && data.flag){
            var list = data.list;//获得列表数据
           if(list&&list.length){
               jQuery("#"+objId).html("");
               for(var i=0;i<data.list.length;i++){
                   jQuery('<div style="width:97%;background:#F2F2F2;height:25px;font-weight:600;'
                           +'line-height:25px;text-align: left;padding-left:10px;">'
                           +'</div>').html(list[i].org_name+"&nbsp;&nbsp;"+list[i].response_time)
                           .appendTo("#"+objId);
                   jQuery('<div style="width:97%;border-bottom:2px solid #F2F2F2;'
                           +'text-align: left;padding-left:10px;">').html(list[i].response_content)
                           .appendTo("#"+objId);
                   
                   jQuery('<div id="show_'+i+'" style="width:97%;text-align: left; ">'
                           +'<ul id="_fileshow"></ul> </div>').appendTo("#"+objId);
                   jQuery('<input id="select_'+i+'" type="button" style="width:1px;height:1px;border:0px;"/>')
                   .appendTo("#"+objId);
                   
                   MyFancyupload.createUpload('show_'+i, 'select_'+i, path, 
                           path+'/servlet/pubFileUpload?buessid='+list[i].attach_id, 
                           true, 
                           list[i].attach_id,'','','001');                   
               }
           }
        }else{
           jQuery("#"+objId).html("暂无回复信息");
        }
     }   

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
              try{
                 if(backFn&& (typeof backFn=='function')){
                     backFn(data);
                 }
              }catch(e){
                 //忽略异常  
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
	try{
	    var parentWin = getParentWindow(windowId);
	   
	    if(parentWin&&parentWin.reload){
	        parentWin.reload();
	    }       
    }catch(e){
        //忽略异常
    }
   removeAlertWindows(windowId,true);   
}
  

 /**
  * 反馈
  */
 var  response = function(receptIds) {    
     //获得催办消息内容
     var url = path+"/ccapp/oa/inspect/jsp/responseDetail.jsp?windowId=responsedetail"
               +"&info_id="+info_id
               +"&recept_id="+recept_id
               +"&type=1";
     openAlertWindows('responsedetail'
             ,url,                         
             '退回重办',810,450,'5%','10%');    
 }

   /**
	*影藏or显示div
	*/
  function slideUpOrDown(slideId,slide_img){
	 //如果影藏执行显示动画
	 if(jQuery("#"+slideId+":hidden").length >0){
	     jQuery("#"+slideId).slideDown(400,function(){
	    	 jQuery("#"+slide_img).attr("src","../resources/images/slideup_button.gif");
		 });
	     
	 }else{
	     jQuery("#"+slideId).slideUp(400,function(){
	    	 jQuery("#"+slide_img).attr("src","../resources/images/slidedown_button.gif");
         });  
	 }
  }
 /**
  *重新加载反馈信息，并隐藏反馈按钮
  */
 function reload(){
	 recept_state = '2';//状态更改为退回重办
     jQuery("#fk_button").hide();
     getResponseList("recept_list");
 }
</script>
</head>
<body style="overflow-y: hidden;" onload="adaptationWH('_top','vcenter',100)">
<form id="form1" action="" method="post">  
    <!-- 表格-->
    <div id="vcenter" style="float: left; width: 100%;">    
        <div style="float: left; width: 775px;margin-left: 15px;" > 
        <div style="margin-top: 20px;float: left;width:100%;border: 1px solid #BFBFBF;" id="file_div">
            <div style="width:100%;heigth:30px;float:left;background: #F2F2F2;font-weight: 600;line-height:30px;">&nbsp;反馈信息
                <img src="../resources/images/slideup_button.gif" border="0" id="slide_img"
                     onclick="slideUpOrDown('recept_list','slide_img')"
                     style="margin-top:3px;float: right;width: 15px;height:20px;display: inline;margin-right: 10px;cursor: pointer;"/>
            </div> 
            <div style="width:100%;float: left;padding-top: 10px;" align="center" id="recept_list">
               
            </div>
        </div>
        
        <div id="baseInfo_div_assist" style="height:10px;width:100%;float: left;">&nbsp;</div>
           
        </div>  
     </div>
     </form>
        <div id="_top" class="toolbar_bottom">
            <input  value="关闭" onclick="closed()" type="button" class="but_y_01" 
              style="float: right;margin-top:5px;margin-right:10px;"/>    
            <input name="fk_button" id="fk_button" value="退回重办"
             style="display: none;float: right;margin-top:5px;margin-right:5px;"
                 onclick="response();" type="button" class="but_y_01" />           
              
         </div>    
</body>
</html>
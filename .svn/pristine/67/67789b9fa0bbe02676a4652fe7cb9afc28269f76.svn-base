<%--
describe:任务通知接收人查看任务的界面
author:dailianchun
date: 2013-11-5
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
    String path = request.getContextPath();
    String id = StringUtil.deNull(request.getParameter("id"));//主键id  
    String recept_id = StringUtil.deNull(request.getParameter("recept_id"));//接收主键id
    String windowId = request.getParameter("windowId");//窗口id
    String flag = StringUtil.deNull(request.getParameter("flag"));//状态  0：暂存，1：交办，（2，3）：办结 （完成，未完成）
           flag = StringUtil.nullOrBlank(flag)?"0":flag;
    String recept_state = StringUtil.deNull(request.getParameter("recept_state"));//反馈状态 0：未反馈；1：已反馈；2：退回重办
           recept_state = StringUtil.nullOrBlank(recept_state)?"1":recept_state;
    String manage = request.getParameter("manage");//是否从管理界面进入
    manage = StringUtil.nullOrBlank(manage)?InspectConstant.VIEW:manage; 
    //会议纪要service
    InspectManageService service = new InspectManageServiceImpl();
    InspectBaseInfoBean bean = new InspectBaseInfoBean();

    //获得当前日期(用于时间控件限制最大时间)
    String date = DateUtil.getCurrentDateTime().substring(0,
            DateUtil.getCurrentDateTime().length()-3);
    String userId = accesscontroler.getUserID();//用户id
    String userName = accesscontroler.getUserName();//用户名
    String time = DateUtil.getCurrentDateTime();//创建时间
    String m_attach_id = StringUtil.getUUID(); //附件id
    
    //如果传入了id，则查询任务基本信息
    if (!StringUtil.nullOrBlank(id)) {
        bean = service.queryToInspectBaseInfoBean(id);               
        //将秒截取掉
        String plan_endtime = StringUtil.deNull(bean.getPlan_endtime());
        if(!StringUtil.nullOrBlank(plan_endtime)){
            bean.setPlan_endtime(plan_endtime.substring(0,plan_endtime.length()-3));
        }
        //创建时间
        String  create_time = StringUtil.deNull(bean.getCreate_time());
        if(!StringUtil.nullOrBlank(create_time)){
            bean.setCreate_time(create_time.substring(0,create_time.length()-3));
        }
        //提醒时间
        String  remind_time = StringUtil.deNull(bean.getRemind_time());
        if(!StringUtil.nullOrBlank(remind_time)){
            bean.setRemind_time(remind_time.substring(0,remind_time.length()-3));
        }
        //交办时间
        String  send_time = StringUtil.deNull(bean.getSend_time());
        if(!StringUtil.nullOrBlank(send_time)){
            bean.setSend_time(send_time.substring(0,send_time.length()-3));
        }
    }
    
    //查询所有分类信息
    List<Map<String,String>> typeList = service.queryAllType();
    //查询接收单位反馈信息
    List<Map<String,String>> receptList = service.queryRecept(id);
    
 
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
var info_id = "<%=StringUtil.deNull(bean.getInfo_id())%>";
//登记人员id
var userId = "<%=StringUtil.deNull(bean.getSend_user_id())%>";
//附件id
var m_attach_id = "<%=bean.getAttach_id() %>";
//附件是否可编辑的选项
var attachFlag = false;

//系统根路径
var path = "<%=path %>";

var manage = "<%=manage%>";

jQuery(function() {
 
     MyFancyupload.createUpload('_fileshow', '_filebut', path, path+'/servlet/pubFileUpload?buessid='+m_attach_id, attachFlag, m_attach_id,'','','001');
    
     //访问参数为管理，状态为“办理中”，且反馈状态为“未反馈”或“退回重办”则显示反馈按钮
     if("manage"==manage && "1"== flag 
    	     && ("0"==recept_state||"2"==recept_state)){  
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
                   
                   jQuery('<div id="show_'+i+'" style="margin-left:15px;width:97%;text-align: left; ">'
                		   +'<ul id="_fileshow" ></ul> </div>').appendTo("#"+objId);
        		   jQuery('<input id="select_'+i+'" type="button" style="width:1px;height:1px;border:0px;"/>')
        		   .appendTo("#"+objId);
        		   
                   MyFancyupload.createUpload('show_'+i, 'select_'+i, path, 
                           path+'/servlet/pubFileUpload?buessid='+list[i].attach_id, 
                           true, 
                           list[i].attach_id,'','','001');                   
               }
           }
        }else{
           jQuery("#"+objId).html("暂无回复信息<div style='width:100%;height:10px;'></div>");
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
	var parentWin = getParentWindow(windowId);
    if(parentWin && parentWin.reload){   
        parentWin.reload();
    }
   removeAlertWindows(windowId,true);
}

   /**
    *影藏or显示div
    */
 function slideUpOrDown(slideId,slide_img){
   //如果影藏执行显示动画
   if(jQuery("#"+slideId+":hidden").length >0){
       jQuery("#"+slideId).slideDown(400);
       jQuery("#"+slide_img).attr("src","../resources/images/slideup_button.gif");
   }else{
       jQuery("#"+slideId).slideUp(400);       
      //增强动画体验
       jQuery("#"+slide_img).attr("src","../resources/images/slidedown_button.gif");
   }
 }

 /**
  * 反馈
  */
 var  response = function(receptIds) {
    
     //获得催办消息内容
     var url = path+"/ccapp/oa/inspect/jsp/responseDetail.jsp?windowId=responsedetail"
               +"&info_id="+info_id
               +"&recept_id="+recept_id;
     openAlertWindows('responsedetail'
             ,url,                         
             '任务催办',800,450,'5%','10%');    
 }
 /**
  *重新加载反馈信息，并隐藏反馈按钮
  */
 function reload(){
	 recept_state = '1';//状态更改为已反馈
	 jQuery("#fk_button").hide();
	 getResponseList("recept_list");
 }
</script>
</head>
<body style="overflow-y: hidden;" onload="adaptationWH('_top','vcenter',30)">
<form id="form1" action="" method="post">  
    <!-- 表格-->
    <div id="vcenter" style="float: left; width: 100%;">
    
        <div style="float: left; width: 775px;margin-left: 15px;margin-top:10px;" >        
            <div style="float: left;width:100%;background: #F2F2F2;border-bottom: 2px solid #BFBFBF;" >           
                <table border="0" cellspacing="0" cellpadding="0"
                        class="content_02_box_div_table">
                        <tr>                            
                            <td colspan="2" height="40">
                                <span style="font-size: 18px;font-weight: 900;margin-left:5px;margin-top: 5px;
                                line-height: 40px;">
                                <%=StringUtil.deNull(bean.getInspect_name())%>
                                </span>
                                
                                <input type="hidden" id="info_id" 
                                name="bean.info_id" value="<%=StringUtil.deNull(bean.getInfo_id())%>"/>
                              
                           </td>                           
                        </tr>
                        <tr>
                            <th width="10%"  height="25">
                                                                                    交办时间：
                            </th>
                            <td  height="25" width="90%">
                                <%=StringUtil.deNull(bean.getSend_time())%>                                                                     
                            </td>                                                 
                        </tr>
                        <tr >
                          <th  height="25">
                                                                             指定期限：
                          </th>
                            <td  height="25">
                               <%=StringUtil.deNull(bean.getPlan_endtime())%>
                            </td>
                        </tr>      
                        <tr>                        
                         <th  height="25">
                                                                                任务类型：
                          </th>
                            <td  height="25">                               
                                   <%  for(Map<String,String> type : typeList){
                                          if(StringUtil.deNull(bean.getInspect_type()).equals(type.get("type_id"))){%>
                                   
                                       <%=type.get("type_name") %>
                                   
                                   <% 
                                      break; 
                                      } 
                                   }%>
                            </td>
                        </tr>    
                        <tr>                        
                         <th  height="25">
                                                                               交办单位：
                          </th>
                            <td  height="25">                               
                                  <%=StringUtil.deNull(bean.getUser_orgname()) %>
                            </td>
                        </tr>                                                
                    </table>
            </div>
            <div id="baseInfo_div_assist" style="height:10px;width:100%;float: left;">&nbsp;</div>
           
       <div style="float:left;width:100%;padding-left: 5px;" id="content_div">               
                    <%=StringUtil.deNull(bean.getContent()) %>                  
       </div>             
                        
       <div style="margin-top: 20px;float: left;width:100%;background: #F2F2F2;border-top: 2px solid #BFBFBF;" id="file_div">
         
           <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr><td></td></tr>
               <tr>
                   <th valign="top" width="10%" height="25">附件列表：
                    <input style="width:1px;height:1px;border: 0px;"  type="button" id="_filebut" value="请选择文件"/>
                   </th>
                   <td width="90%">
                   <ul id="_fileshow"></ul>
                   &nbsp;
                   </td>
               </tr>
           </table>
        </div>
        <div style="height:10px;border:0px;width:100%;">&nbsp;</div>
        <div style="margin-top: 20px;float: left;width:100%;border: 1px solid #BFBFBF;" id="file_div">
            <div style="width:100%;heigth:30px;float:left;background: #F2F2F2;font-weight: 600;line-height:30px;">&nbsp;反馈信息
                <img src="../resources/images/slideup_button.gif" border="0" id='slide_img'
                     onclick="slideUpOrDown('recept_list','slide_img')"
                     style="margin-top:4px;float: right;width: 15px;height:20px;display: inline;margin-right: 7px;cursor: pointer;"/>
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
            <input name="fk_button" id="fk_button" value="反馈"
             style="display: none;float: right;margin-top:5px;margin-right:5px;"
                 onclick="response();" type="button" class="but_y_01" />           
              
         </div>    
</body>
</html>
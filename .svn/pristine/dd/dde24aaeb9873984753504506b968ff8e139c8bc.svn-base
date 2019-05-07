<%--
describe:查看任务
author:dailianchun
date: 2013-7-11
--%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.common.util.*"%>
<%@page import="com.chinacreator.xtbg.core.task.entity.*"%>
<%@page import="com.chinacreator.xtbg.core.task.service.impl.TasksAssignedServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.task.service.TasksAssignedServiceIfc"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.*"%>
<%@page  import="com.chinacreator.xtbg.core.common.fancyuoload.dao.FiletransfersSysDao"%>
<%@page  import="com.chinacreator.xtbg.core.common.fancyuoload.dao.impl.FiletransfersSysDaoImpl"%>
<%@page import="com.chinacreator.xtbg.core.common.fancyuoload.entity.FileInfoBean"%>
<%@page import="com.chinacreator.xtbg.core.task.util.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%   
    AccessControl accesscontroler = AccessControl.getAccessControl();
    accesscontroler.checkAccess(request, response);
    String path = request.getContextPath();
    String orgName = accesscontroler.getChargeOrgName();
    String orgId = accesscontroler.getChargeOrgId();
    String userName = accesscontroler.getUserName();
    String userId = accesscontroler.getUserID();
    
    String id = StringUtil.deNull(request.getParameter("id"));//任务id
    String status = StringUtil.deNull(request.getParameter("status"));//任务状态
    String windowId = StringUtil.deNull(request.getParameter("windowId"));//窗口id,用于返回,关闭等操作
    String complete_time="";//实际办结时间
    //服务类
    TasksAssignedServiceIfc service = new TasksAssignedServiceImpl();
    TaskBaseInfoBean bean = new TaskBaseInfoBean();    
    
    //id不为空，则查询出任务对应的信息
    if(!StringUtil.nullOrBlank(id)){
        bean = service.queryToTaskBaseInfoBean(id);
      //截取掉日期
        bean.setStart_time(DateUtil.getTimeString(StringUtil
                .convertStringToTimestamp(bean.getStart_time())));
        bean.setEnd_time(DateUtil.getTimeString(StringUtil
                .convertStringToTimestamp(bean.getEnd_time())));
        complete_time = DateUtil.getTimeStringNos(StringUtil.convertStringToTimestamp(bean.getComplete_time()));		
    }else{
        //没有传入数据则给bean对象赋初值
        bean.setInput_userid(userId);
        bean.setInput_username(userName);
        bean.setInput_orgid(orgId);
        bean.setInput_orgname(orgName);
        bean.setAttach_id(StringUtil.getUUID());//附件id
    }
    
    //任务类型
    List<TaskTypeBean> typeList = service.queryTaskTypeBySort(TaskConstant.TASK_TYPE);
    
%>
<title></title>

<!-- 引入jQuery -->
<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script type="text/javascript">jQuery.noConflict();</script> 

<!-- 引入my97时间控件 -->
<script src="../../resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>

<!-- 引入其它 -->
<script src="../../resources/util/public.js" type="text/javascript"></script>

<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>

<!-- 引入formvValidatetion -->
<link rel="stylesheet" href="../../resources/plug/formvalidation/css/validationEngine.jquery.css" type="text/css" />
<script src="../../resources/plug/formvalidation/jquery.validationEngine-cn.js" type="text/javascript" charset="utf-8"></script>
<script src="../../resources/plug/formvalidation/jquery.validationEngine.js" type="text/javascript" charset="utf-8"></script>
<!-- 引入上传控件 -->
<script type="text/javascript" src="../../resources/plug/fancyupload/mootools-1.2.5-core-jm.js" charset="utf-8"></script>
<script type="text/javascript" src="../../resources/plug/fancyupload/source/Fx.ProgressBar.js" charset="utf-8"></script>
<script type="text/javascript" src="../../resources/plug/fancyupload/source/Swiff.Uploader.js" charset="utf-8"></script>
<script type="text/javascript" src="../../resources/plug/fancyupload/source/FancyUpload3.Attach.js" charset="utf-8"></script>
<script type="text/javascript" src="../../resources/plug/fancyupload/myfancyupload.js" charset="utf-8"></script>
<script src="<%=path%>/ccapp/oa/resources/util/htmlutil.js"
    type="text/javascript"></script>  
<!-- 打印需要导入的内容、方法 -->
<script language="javascript" src="../../resources/plug/Lodop/LodopFuncs.js"></script> 
<object  id="LODOP" classid="clsid:2105C259-1E0C-4534-8141-A753534CB4CA" width=0 height=0>  
<!-- 是专为 FireFox 浏览器设计的代码  -->
<embed id="LODOP_EM" type="application/x-print-lodop" width=0 height=0 pluginspage="<%=path %>/resources/plug/Lodop/Lodopinstall_lodop.exe"></embed>
</object>

<script type="text/javascript">
var path = "<%=path %>";//根目录
var attach_id = "<%=bean.getAttach_id()%>";//附件id
var windowId = "<%=windowId%>";//窗口id
var status = "<%=status%>";//任务状态,具体数据参考TaskConstant类
var id = "<%=id%>";//任务id
/*
函数:  Ok
说明:  提交添加与修改密集程度
参数:   无
返回值: 无
*/

jQuery(function(){
   //设置多选框选中
   jQuery("#degree_of_importance option[value='<%=StringUtil.deNull(bean.getDegree_of_importance())%>']").attr("selected","selected");
   jQuery("#task_type option[value='<%=StringUtil.deNull(bean.getTask_type())%>']").attr("selected","selected");
	
	//控制页面元素
	showOrHideButton(status,id);    
   jQuery("#form1").validationEngine();


      
   //回复页面的iframe控制
   controlIframe(status,id);
   //附件控制
   isFileEnble(attach_id);
});

/**
 * 对页面的按钮输入框进行控制
 */
function showOrHideButton(statusFlag,id){
   jQuery("#receive_username_button").css("display","none");
   jQuery("#task_name").attr("readOnly","readOnly");;
   //移除所有的点击事件，以及禁用输入框
   jQuery("#vcenter input[type=text][id!=task_name]:visible,#vcenter select:visible").unbind().each(function(){
	   HTMLUtil.readOnly(this);
   });
   
    //已办结状态
    if(statusFlag=="3"){
    	//显示实际办结时间
		jQuery("#tr_complete").show();
    }
}


/**
 *附件是否可以编辑
 *@m_attach_id :附件id
 *@attachFlag : 是否可以操作的参数  true(可操作)  false（不可操作）
 */
function isFileEnble(m_attach_id){
    var attachFlag = false;    
      //附件
    MyFancyupload.createUpload('_fileshow', '_filebut', path, path+'/servlet/pubFileUpload?buessid='+m_attach_id, attachFlag, m_attach_id,"","","011");
    if(!attachFlag){
        //设置上传按钮大小，间接实现隐藏
       jQuery("#_filebut").width(1).height(1);
    }
}

/**
 * 控制iframe框
 * @param statusFlag : 任务状态  具体参考长两类TaskConstant
 * @param id  : 传入的任务id
 */
function controlIframe(statusFlag,id){
	var flag = ("1" == statusFlag ? "2" : statusFlag);
    var url = "tasksreportlist.jsp?id="+id+"&input_userid=2&status="+flag;
    //iframe显示出来
    jQuery("#reply").attr("src",url).show();    
}  


/**
 * 返回
 */
function closed(){
        removeWindows(windowId,true);
       
}

var LODOP; //声明为全局变量 
/*   打印预览 */
function reviewPrint() {    
    createPrintHtml();  
    LODOP.PREVIEW();    
};
/* 直接打印 */
function print() {      
    createPrintHtml();
    LODOP.PRINT();  
};
/* 
(扩展型)直接打印A
格式：PRINTA ()
功能：同函数PRINT。打印前提示选择打印机。
参数：同函数PRINT。
结果：同函数PRINT。返回逻辑结果，当真实打印时返回真，放弃打印或打印出错时返回假。
建议或要求：
同函数PRINTA 
*/
function directPrint() {        
    createPrintHtml();
    LODOP.PRINTA();     
};
/*创建部分打印内容  */
function createPrintHtml(){
    /*判断浏览器的类型并决定采用哪个对象实例，并检测控件是否安装、是否最新版本、并引导安装或升级。  */
    LODOP=getLodop(document.getElementById('LODOP'),document.getElementById('LODOP_EM'));
    /*初始化运行环境，清理异常打印遗留的系统资源，设定打印任务名。  */
    LODOP.PRINT_INIT("打印请示信息");
    /*
    SET_PRINT_STYLE(strStyleName,varStyleValue)
    功能：设置打印项的输出风格，成功执行该函数，此后再增加的打印项按此风格输出。
    参数： 
    strStyleName：打印风格名，风格名称及其含义如下：
    “FontName”： 设定纯文本打印项的字体名称。
    “FontSize”： 设定纯文本打印项的字体大小。
    “FontColor”： 设定纯文本打印项的字体颜色。
    “Bold”： 设定纯文本打印项是否粗体。
    “Italic”： 设定纯文本打印项是否斜体。
    “Underline”： 设定纯文本打印项是否下滑线。
    “Alignment”： 设定纯文本打印项的内容左右靠齐方式。
    “Angle”： 设定纯文本打印项的旋转角度。
    “ItemType”：设定打印项的基本属性。
    “HOrient”：设定打印项在纸张内的水平位置锁定方式。
    “VOrient”：设定打印项在纸张内的垂直位置锁定方式。
    “PenWidth”：线条宽度。
    “PenStyle”：线条风格。
    “Stretch”：图片截取缩放模式。
    “PreviewOnly”:内容仅仅用来预览。
    “ReadOnly”:纯文本内容在打印维护时，是否禁止修改。 
      */
      /*设置打印字体的大小 */
    LODOP.SET_PRINT_STYLEA(0,"FontSize",20);
    LODOP.SET_PRINT_STYLEA(0,"Horient",3);
    LODOP.SET_PRINT_STYLEA(0,"Vorient",3);
    //LODOP.SET_PRINT_STYLE("Bold",1);
    /*增加纯文本打印项，
    设定该打印项在纸张内的位置和区域大小，
    文本内容在该区域内自动折行，当内容超出区域高度时，
    如果对象被设为“多页文档”则会自动分页继续打印，否则内容被截取。  */
    //LODOP.ADD_PRINT_TEXT(0,0,'99%','99%',"打印通知公告正文内容");
    /*增加超文本打印项，设定该打印项在纸张内的位置和区域大小，实现超文本控制打印。  */
    //LODOP.ADD_PRINT_HTM('1.25CM','2.3CM','80%','80%',document.getElementById("edit_content").value);
    //jQuery("#_print_html").html(jQuery("#vcenter").html());
    /*增加超文本打印项，设定该打印项在纸张内的位置和区域大小，实现超文本控制打印。  */
    LODOP.ADD_PRINT_HTM('1.25CM','2.3CM','80%','80%',joinHtml()); 
    
};  
function joinHtml(){
      var html = [
            '<table width="100%" border="0" cellspacing="0" cellpadding="0" align="left">',
            '<tr>',
            '<td width="99%" style="border-bottom : 2px solid #333" colspan=2>',
            '<font style="font:bold 12px/31px \'宋体\';">基本信息</font>',
            '<br/>',                
            '</td>',
            '</tr>',
            '<tr>',
            '<td  style="font: normal 12px/29px \'宋体\'" colspan=2>',
            '任务名称：',
            jQuery("#task_name").val(),                
            '</td>',
            '</tr>',
            '<tr>',
            '<td  style="font: normal 12px/29px \'宋体\'">',
            '开始时间：'+jQuery("#start_time").val(),
            '</td>',
            '<td  style="font: normal 12px/29px \'宋体\'">',
            '结束时间：'+jQuery("#end_time").val(),
            '</td>',
            '</tr>',
            '<tr>',
            '<td  style="font: normal 12px/29px \'宋体\'">',
            '重要程度：',
            jQuery("#degree_of_importance option:selected").text(),
            '</td>',
            '<td  style="font: normal 12px/29px \'宋体\'">',
            '任务类型：',
            jQuery("#task_type option:selected").text(),    
            '</td>',
            '</tr>',
            '<tr>',
            '<td  style="font: normal 12px/29px \'宋体\'">',
            '发起人:'+jQuery("#input_username").val(),
            '</td>',
            '<td  style="font: normal 12px/29px \'宋体\'">',
            '发起人单位：'+jQuery("#input_orgname").val(),    
            '</td>',
            '</tr>',
            '<tr>',
            '<td colspan="2" style="font: normal 12px/29px \'宋体\'">',
            '负责人:'+jQuery("#receive_username").val(),
            '</td>',          
            '</tr>',
            '<tr>',
            '<td width="99%"  align="left" style="border-bottom : 2px solid #333" colspan=2>',
            '<font style="font:bold 12px/31px \'宋体\';">内容</font>',
            '<br/>',
            '</td>',
            '</tr>',
            '<tr><td colspan=2>',
            eWebEditor1.getHTML(),
            '</td></tr>',           
            '</table>'
      ]
      return html.join(" ");
  }
</script>
</head>
<body style="overflow-y:hidden;" onload="adaptationWH('_top','vcenter',1)">
    <form id="form1" name="form1"  method="post" >
        <div class="content_02" style="overflow: hidden;">
            <div class="content_02" style="overflow: hidden;" id="_top">
                <div class="content_02_top" style="margin-bottom: 10px;">
                
                <input class="but_y_01" type="button" id="print" value="打印" onclick="reviewPrint();" />
                <input class="but_y_01" type="button" id="resert" value="返回"
                    onclick="closed()" />
                </div>
            </div>
            <input type="hidden" name="id" id="id" value="<%=StringUtil.deNull(bean.getId()) %>"/>
            <input type="hidden" name="attach_id"  id="attach_id" value="<%=StringUtil.deNull(bean.getAttach_id())%>" />
            <input type="hidden" name="task_status"  id="task_status" value="<%=StringUtil.deNull(bean.getTask_status())%>" />
        </div>

        <div id="vcenter" style="float:left; width:100%; overflow-y:auto;overflow-x:hidden">
        <div style="float: left;width: 800px"> 
        <div class="content_02_box" >
         <div class="content_02_box_title_bg"><span>基本信息</span></div>
         <div class="content_02_box_div">
            <table width="100%" border="0" cellspacing="0" cellpadding="0"  class="content_02_box_div_table_02">
                <tr>
               <th width="191" class="content_02_box_div_table_th"><span class="color_red">*</span>任务名称：</th>
                <td class="content_02_box_div_table_td" colspan="3">
                <input type="text" class="validate[required,maxSize[150]] input_title_text"  type="text" name="task_name" 
                    id="task_name" value="<%=StringUtil.deNull(bean.getTask_name())%>"/>
                </td>
            </tr>
             <tr>            
                  <th class="content_02_box_div_table_th"><font class="color_red">*</font>开始时间：</th>
                   <td class="content_02_box_div_table_td">
                   <input style="width: 190px" type="text" name="start_time" id="start_time" class="validate[required] date_187" readonly="readonly" 
                        value="<%=StringUtil.deNull(bean.getStart_time())%>" 
                        />
                   </td>
                   <th class="content_02_box_div_table_th"><font class="color_red">*</font>计划完成时间：</th>
                   <td class="content_02_box_div_table_td">
                   <input style="width: 190px" class="validate[required] date_187" type="text" id="end_time" name="end_time" 
                  value="<%=StringUtil.deNull(bean.getEnd_time())%>"  />
                   </td>
             
            </tr>
                <tr>
                   <th class="content_02_box_div_table_th"><span class="color_red">*</span>重要程度：</th>
                   <td class="content_02_box_div_table_td">
                       <%--     <%=infotypeHtml%>--%>
                       <select style="width: 190px" name ="degree_of_importance" id= "degree_of_importance" size ="1"  class ="select_100_box_type" >
                                <option value ="">---请选择---</option>
                                <option value ="1">普通</option>
                                <option value ="2">重要</option>
                                <option value ="3">非常重要</option>                                
                            </select>
                  </td>
                   <th class="content_02_box_div_table_th"><span class="color_red">*</span>任务类型：</th>
                   <td class="content_02_box_div_table_td">
                      <%--  <%=infotypeHtml1%> --%>
                      <select style="width: 190px" name ="task_type" id= "task_type" size ="1"  class ="select_100_box_type" >
                               <option value ="">---请选择---</option>
                               <%for(TaskTypeBean type : typeList){ %>
                               <option value="<%=StringUtil.deNull(type.getType_id()) %>"><%=StringUtil.deNull(type.getType_name()) %></option>
                               <%}%>
                      </select>
                  </td>
         </tr>
         <tr>
                   <th class="content_02_box_div_table_th"><span class="color_red">*</span>发起人：</th>
                   <td class="content_02_box_div_table_td">
                        <input type="text" name="input_username" id="input_username" 
                        class="input_160" disabled="disabled" style="width: 190px" value="<%=StringUtil.deNull(bean.getInput_username()) %>"/>
                        <input type="hidden" name="input_userid" id="input_userid" 
                        class="input_160"  style="width:150px" value="<%=StringUtil.deNull(bean.getInput_userid()) %>"/>
                   </td>
                   <th class="content_02_box_div_table_th"><span class="color_red">*</span>发起人单位：</th>
                   <td class="content_02_box_div_table_td">
                        <input type="text" name="input_orgname" id="input_orgname" 
                        class="input_160" disabled="disabled" style="width: 190px" value="<%=StringUtil.deNull(bean.getInput_orgname()) %>"/>
                        <input type="hidden" name="input_orgid" id="input_orgid" 
                        class="input_160"  style="width:150px" value="<%=StringUtil.deNull(bean.getInput_orgid()) %>"/>
                        
                  </td>
         </tr>
         <tr>
                <th width="212" valign="top" class="content_02_box_div_table_th">负责人：</th>
                <td colspan="3" valign="top" class="content_02_box_div_table_td" >
                    <input type="text" name="receive_username" id="receive_username" 
                        class="input_160" disabled="disabled" style="width: 165px" value="<%=StringUtil.deNull(bean.getReceive_username())%>" 
                         />
                    <input type="hidden" name="receive_userid" id="receive_userid" 
                        class="input_160" style="width:150px"
                        value="<%=StringUtil.deNull(bean.getReceive_userid())%>" />
                    <input type="hidden" name="receive_orgid" id="receive_orgid" 
                        class="input_160" disabled="disabled" style="width:150px"
                        value="<%=StringUtil.deNull(bean.getReceive_orgid())%>"/>
                    <input type="hidden" name="receive_orgname" id="receive_orgname" 
                        class="input_160" disabled="disabled" style="width:150px"
                        value="<%=StringUtil.deNull(bean.getReceive_orgname())%>"/>
                                        
                    <input name="receive_username_button" id="receive_username_button" type="button"  class="but_x" style="float:left;" 
                            />
                </td>               
            </tr>
            <tr id="tr_complete" style="display: none;">
                <th width="212" valign="top" class="content_02_box_div_table_th">实际办结时间：</th>
                <td colspan="3" valign="top" class="content_02_box_div_table_td" >
                     <input style="width: 190px" class="validate[required] input_title_text" readonly="readonly" type="text" id="complete_time" name="complete_time" 
                  value="<%=StringUtil.deNull(complete_time)%>"  />
                </td>               
            </tr>
            </table>
            </div>
            </div>
            
         <div class="content_02_box" >
         <div class="content_02_box_title_bg"><span>任务要求</span></div>
         <div class="content_02_box_div">
            <table width="100%" border="0" cellspacing="0" cellpadding="0"  class="content_02_box_div_table_02">
                <tr>
	               <td class="content_02_box_div_table_td" colspan="3">
	               <input type="hidden"  id="task_needinfo" name="task_needinfo"  value="<%=StringUtil.deNull(bean.getTask_needinfo())%>"/>
		                <textarea class="validate[maxSize[1000]]" style="width: 99%;height: 80px; text-align: left;" name="task_needinfoTextarea" id="task_needinfoTextarea"><%=StringUtil.deNull(bean.getTask_needinfo())%></textarea>
	                </td>
	            </tr>
            </table>
            </div>
            </div>
            
          <div class="content_02_box" >
                <div class="content_02_box_title_bg"><span>内容</span></div>
                <div class="text_show_main_box">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">  
                    <tr>
                        <td>
                            <textarea   style="display:none" name="task_content" id="task_content"><%=StringUtil.deNull(bean.getTask_content())%></textarea>
                            <iframe id="eWebEditor1" src="../../resources/plug/eWebEditor_V4.60/ewebeditor.htm?id=task_content&style=gray&readonly=1" frameborder="0" scrolling="no" width="100%" height="300"></iframe> 
                        </td>
                    </tr>
                </table>
                </div>
                </div>
    
    <div class="content_02_box">
                <div class="content_02_box_title_bg">
                    <span>其他信息</span>
                </div>
                <div class="content_02_box_div">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0" id="content_02_box_div_table_02">
                            <tr id="fj">
                                <th width="212" valign="top">附件：</th>
                                <td width="560" >
                                    <input class="but_y_03"  type="button" id="_filebut" value="请选择文件"/>
                                </td>
                            </tr>
                            <tr>
                                <th valign="top">附件列表：</th>
                                <td id="_fileshow"></td>
                            </tr>
                        </table>
                        </div>
                        </div>
                        </div>
     <iframe src="" 
          id="reply"  width="789px;" height="250px" style="display:none;border: 0;margin-top: 10px;margin-left: 0px" frameborder="0" />
    
    </div>
     </form>
    
     
</body>
</html>

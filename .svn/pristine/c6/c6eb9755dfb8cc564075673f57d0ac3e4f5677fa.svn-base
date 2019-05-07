<%--
describe: 添加任务回复信息
author:dailianchun
date: 2013-7-09
--%>
<%@page import="com.chinacreator.xtbg.core.sysparam.util.SysParamUitl"%>
<%@page import="com.chinacreator.xtbg.core.common.util.*"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.task.entity.*"%>
<%@page import="com.chinacreator.xtbg.core.task.service.impl.TasksReportServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.task.service.TasksReportServiceIfc"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.*"%>

<%@page  import="com.chinacreator.xtbg.core.common.fancyuoload.dao.FiletransfersSysDao"%>
<%@page  import="com.chinacreator.xtbg.core.common.fancyuoload.dao.impl.FiletransfersSysDaoImpl"%>
<%@page import="com.chinacreator.xtbg.core.common.fancyuoload.entity.FileInfoBean"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DaoUtil"%>
<%@page import="com.chinacreator.xtbg.core.task.util.TaskConstant"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	String path = request.getContextPath();
	String userName = accesscontroler.getUserName();
	String userId = accesscontroler.getUserID();

	String task_id = StringUtil.deNull(request.getParameter("task_id"));//交办任务id
	String id = StringUtil.deNull(request.getParameter("id"));//回复id
	String windowId = StringUtil.deNull(request
			.getParameter("windowId"));

	TaskReportBean bean = new TaskReportBean();
	if (!StringUtil.nullOrBlank(id)) {
		TasksReportServiceIfc service = new TasksReportServiceImpl();
		bean = service.queryToTaskReportBean(id);
		//不是自己添加的回复，且回复状态为未读。则更新为已读
		if (!userId.equals(bean.getUser_id())
				&& TaskConstant.UNREAD.equals(bean.getType())) {
			TaskReportBean updateBean = new TaskReportBean();
			updateBean.setId(bean.getId());
			updateBean.setType(TaskConstant.READ);//状态设置为已读
			service.updateTaskReport(updateBean);//更新阅读状态
		}

	} else {
		bean.setUser_id(userId);
		bean.setUser_name(userName);
		bean.setAttach_id(StringUtil.getUUID());
		bean.setTask_id(task_id);//任务id
	}
	
	//判断是否有短信，及时，邮件，站内消息提示
	SysParamUitl noticeutil=new SysParamUitl();
	List<Map<String,String>> list=noticeutil.getSystemValue(TaskConstant.SYSTEM_CODE);
	String is_pub_sms="";
	String is_pub_mail="";
	String is_pub_rtx="";
	String is_pub_msg="";
	if(list.size()>0){
		for (Map<String, String> map : list) {
			if(map.get("p_code").equals(TaskConstant.IS_PUB_MAIL)){
				is_pub_mail=map.get("p_content");
			}
			if(map.get("p_code").equals(TaskConstant.IS_PUB_MSG)){
				is_pub_msg=map.get("p_content");
			}
			if(map.get("p_code").equals(TaskConstant.IS_PUB_RTX)){
				is_pub_rtx=map.get("p_content");
			}
			if(map.get("p_code").equals(TaskConstant.IS_PUB_SMS)){
				is_pub_sms=map.get("p_content");
			}
		}
	}
%>
<title></title>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script type="text/javascript">jQuery.noConflict();</script> 
<script src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>

<!-- 引入其它 -->
<script src="../../resources/util/public.js" type="text/javascript"></script>

<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<!-- 引入formvValidatetion -->
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
<!--公共部分结束  -->

<script type="text/javascript">
var path = "<%=path%>";
var id = "<%=id%>";//回复id
var attach_id = "<%=bean.getAttach_id()%>";
var windowId = "<%=windowId%>";
/*
函数:  Ok
说明:  提交添加与修改密集程度
参数:   无
返回值: 无
*/
var flag=true;
jQuery(function() {
    jQuery("#report_content").focus();
	
    jQuery("#form1").validationEngine();

    //添加操作提交按钮显示    
    if(IsSpace(id)) {
       jQuery("#sel").show();       
    }else{//查看操作
        //禁用输入框
       jQuery("textarea").attr("readOnly","readOnly")
       .css("border","0px;")
       .css("overflow","auto")
       .css("overflow-x","hidden")
       .addClass("vcenter");
       
    }

    //加载附件
    isFileEnble(attach_id,id);
});

/**
 *附件是否可以编辑
 *@m_attach_id :附件id
 
 */
function isFileEnble(m_attach_id,id){
    //@attachFlag : 是否可以操作的参数  true(可操作)  false（不可操作）
    var attachFlag = false;
    //为添加操作
    if(IsSpace(id)){
        attachFlag = true;
        //附件
        MyFancyupload.createUpload('_fileshow', '_filebut', path, path+'/servlet/pubFileUpload?buessid='+m_attach_id, attachFlag, m_attach_id,'','','111');
            
    }else{
        MyFancyupload.createUpload('_fileshow', '_filebut', path, path+'/servlet/pubFileUpload?buessid='+m_attach_id, attachFlag, m_attach_id,'','','011');
    }
    
         if(!attachFlag){
        //设置上传按钮大小，间接实现隐藏
       jQuery("#_filebut").width(1).height(1);
    }
}

/**
 *保存
 */
function save() {
    ajaxSubmit("add","确定保存吗?"); 
}

/*
作者:  肖杰
时间:  2013-10-08
函数:  ischecked
说明:  
参数:   无
返回值: 无
*/
var ischecked = function(){
	if(jQuery('#is_sms').attr("checked")=="checked"){
		jQuery('#is_sms').val("1");
	}else{
		jQuery('#is_sms').val("0");
	}
	if(jQuery('#is_mail').attr("checked")=="checked"){
		jQuery('#is_mail').val("1");
	}else{
		jQuery('#is_mail').val("0");
	}
	if(jQuery('#is_rtx').attr("checked")=="checked"){
		jQuery('#is_rtx').val("1");
	}else{
		jQuery('#is_rtx').val("0");
	}
	if(jQuery('#is_msg').attr("checked")=="checked"){
		jQuery('#is_msg').val("1");
	}else{
		jQuery('#is_msg').val("0");
	}
	
}
/**
 * ajax提交数据
 */
var ajaxSubmit = function(action,alertMsg){
   
    //是否全部验证通过      
    if(!jQuery('#form1').validationEngine('validate') ){
      return ;
    }
    ischecked();
    var okF = function(){
                jQuery("#sel").attr("disabled","disabled");
                //获得所有参数
                var param = getAllValues();
                param["action"] = action;
                //ajax方式提交数据
                jQuery.ajax({
                    type: "post", 
                    url: "tasksreportdo.jsp", 
                    contentType: "application/x-www-form-urlencoded; charset=utf-8",
                    data : param,
                    dataType: "json",
                    success: function (data) {
                        jQuery("#sel").removeAttr("disabled");
                        //操作成功，返回上层界面
                        if(data && data.flag && "true" == data.flag){
                            //调用父窗口的方法重新加载数据
                            var pwindow = window.top.findPageCacheName(windowId).superwindow;
                            if(pwindow && pwindow.tasksAssignedSearch){
                            	pwindow.tasksAssignedSearch();
                            }
                               
                        }
                        if(data &&data.msg){
                            
                          alert(data.msg,{
                              headerText:'提示',
                              okName:'确认',
                              okFunction:function(){
                                 if(data.flag == "true"){
                                    removeAlertWindows(windowId,true);
                                 }
                              }
                              });
                        }
                    }, 
                    error: function (XMLHttpRequest, textStatus, errorThrown) { 
                        jQuery("#sel").removeAttr("disabled");
                        alert("出现异常，请稍后再试！");
                    }
                 });
          }
          var p={
                    headerText:'提示',
                    okName:'确认',
                    okFunction:okF,
                    cancelName:'取消'
          };
          alert(alertMsg,p);        
}

/**
 * 获得参数对象
 */
function getAllValues() {
    var param = {
            id : jQuery("#id").val(),
            task_id : jQuery("#task_id").val(),
            report_content: jQuery("#report_content").val(),
            attach_id: jQuery("#attach_id").val(),
            user_id: jQuery("#user_id").val(),
            user_name: jQuery("#user_name").val(),
            type: jQuery("#type").val(),
            is_sms: jQuery("#is_sms").val(),
            is_msg: jQuery("#is_msg").val(),
            is_rtx: jQuery("#is_rtx").val(),
            is_mail: jQuery("#is_mail").val()
         };    
     return param;
}

/**
 * 关闭窗口
 */
function closed(){
	try{
		//调用父窗口的方法重新加载数据
	    var pwindow = window.top.findPageCacheName(windowId).superwindow;
	    if(pwindow && pwindow.tasksAssignedSearch){
	        pwindow.tasksAssignedSearch();
	    }
	}catch(e){
     //忽略异常
	}
    removeAlertWindows(windowId,true);
}
</script>
</head>
<body style="overflow:hidden;">
    <div id="vcenter" style="float:left;height:140px;overflow-y:auto;overflow-x:hidden;">
     <form id="form1" name="form1"  method="post" action="tasksreportdrewdo.jsp">
        <input type="hidden" name="id" id="id" value="<%=bean.getId()%>"/>
        <input type="hidden" name="task_id" id="task_id" value="<%=bean.getTask_id()%>"/>
        <input type="hidden" name="attach_id" id="attach_id" value="<%=bean.getAttach_id()%>"/>
        <input type="hidden" name="user_name" id="user_name" value="<%=userName%>"/> 
        <input type="hidden" name="user_id" id="user_id" value="<%=userId%>"/>
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="content_box_text">
         <tr id="fj">
                <th width="212" valign="top">附件：</th>
                    <td width="560" >
                            <input type="button" class="but_y_03" id="_filebut" value="请选择文件"/>
                    </td>
                </tr>
                <tr>
                    <th valign="top">附件列表：</th>
                    <td id="_fileshow"></td>
                </tr>
            <tr>
              <th><font id="frequired" style="COLOR: red">*</font>内容：</th>
              <td>
                  <textarea  class="validate[required,maxSize[1000]] cur_textarea_575" style="width: 320px;height:70px;border:0px;margin:2px 0 2px; " name="report_content" id="report_content" ><%=StringUtil.deNull(bean.getReport_content())%></textarea>
            
              </td>
            </tr>
              <%if(("1".equals(is_pub_sms) || "1".equals(is_pub_rtx) || "1".equals(is_pub_msg) || "1".equals(is_pub_mail))&& StringUtil.isBlank(id)){ %>
			<!-- 消息提醒begin -->
					<tr>
						<th class="content_02_box_div_table_th"  style="width:200px;">提醒方式：</th>
						<td class="content_02_box_div_table_td" colspan="3">
						<%if("1".equals(is_pub_sms)){ %>
							<input name="is_sms" id="is_sms" type="checkbox"  value="" />&nbsp;短信
							&nbsp;<%} %>
							<%if("1".equals(is_pub_mail)){ %>
							<input name="is_mail" id="is_mail" type="checkbox"   value="" />&nbsp;邮件&nbsp;
							<%} if("1".equals(is_pub_rtx)){%>
							<input name="is_rtx" id="is_rtx" type="checkbox"   value="" />&nbsp;即时信息&nbsp;
							<%} if("1".equals(is_pub_msg)){%>
							<input name="is_msg" id="is_msg" type="checkbox"   value="" />&nbsp站内信息&nbsp;
							<%} %>
						</td>
						
					</tr>
			<!-- 消息提醒end -->
		<%} %>
		
         </table>
    </form>
    </div>
    <div class="cue_box_foot" style="float:left;">
        <input class="but_y_01" type="reset" id="resert" value="关闭" onclick="closed()" />
        <input class="but_y_01" type="button" id="sel" style="display:none"  name="sel" value="确定" onclick="save()"/>
    </div>
</body>
</html>
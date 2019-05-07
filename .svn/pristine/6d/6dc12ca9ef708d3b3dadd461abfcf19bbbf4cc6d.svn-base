<%--
describe:催办页面
author:dailianchun
date: 2013-11-5
--%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@page import="com.chinacreator.xtbg.core.sysparam.util.SysParamUitl"%>
<%@page import="com.chinacreator.xtbg.core.sysparam.util.SysParamConstant"%>
<%@page import="com.chinacreator.xtbg.core.inspect.service.InspectManageService"%>
<%@page import="com.chinacreator.xtbg.core.inspect.service.impl.InspectManageServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.inspect.entity.InspectBaseInfoBean"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DateUtil"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="java.util.Map"%>
    
<%

AccessControl accesscontroler = AccessControl.getAccessControl();
accesscontroler.checkAccess(request, response);
String userId = accesscontroler.getUserID();
String infoId = request.getParameter("info_id");//任务id
String receptIds = request.getParameter("recept_ids");//任务接收表id集合
String windowId = request.getParameter("windowId");
String path = request.getContextPath();
//会议纪要service
InspectManageService service = new InspectManageServiceImpl();
InspectBaseInfoBean bean = new InspectBaseInfoBean();

//如果传入了id，则查询任务基本信息
if (!StringUtil.nullOrBlank(infoId)) {
    bean = service.queryToInspectBaseInfoBean(infoId);           
}
//判断是否有短信，及时，邮件，站内消息提示
SysParamUitl noticeutil=new SysParamUitl();
Map<String,String> msgmap=noticeutil.getCheckedSystemMsg();
String is_pub_sms=msgmap.get(SysParamConstant.IS_PUB_SMS);
String is_pub_msg=msgmap.get(SysParamConstant.IS_PUB_MSG);
String is_pub_rtx=msgmap.get(SysParamConstant.IS_PUB_RTX);
String is_pub_mail=msgmap.get(SysParamConstant.IS_PUB_MAIL);
%>  
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">



<%@page import="com.chinacreator.security.AccessControl"%><html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>催办</title>

<script type="text/javascript"src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script type="text/javascript">jQuery.noConflict();</script>
<!-- 引入jQuery UI -->
<script src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>

<!-- 引入formvValidatetion -->
<script  src="../../resources/plug/formvalidation/jquery.validationEngine-cn.js" type="text/javascript"></script>
<script src="../../resources/plug/formvalidation/jquery.validationEngine.js" type="text/javascript"></script>


<script src="../../resources/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js"></script>
<script src="../../resources/plug/form/jquery.form.js" type="text/javascript"></script>
<script type="text/javascript">
var path = "<%=path%>"; 
var windowId = "<%=windowId%>";
jQuery(function(){
	jQuery("#remind_content").focus();
    //将表单升级为ajax的提交方式
    jQuery("#form1").submit(function(){
        jQuery(this).ajaxSubmit(
            {
                type: "post", 
                //url: "filefilesdo.jsp", 
                url : path+"/ajaxServlet?className=com.chinacreator.xtbg."
                +"core.inspect.action.InspectManageAction&method=hurryInspect",
                dataType: "json",
                contentType: "application/x-www-form-urlencoded; charset=utf-8",
                beforeSubmit : function(data,form,options ){                                            
                   
                },
                success: function (data,status) {
                    if(data.flag){
                        //removeAlertWindows(windowId,true);                           
                         alert(data.msg,{
                             headerText:'提示',
                             okName:'确认',
                             okFunction:function(){
                                   removeAlertWindows(windowId,true);                                
                             }
                             });
                    }else{
                        if(data.msg){
                            alert(data.msg);
                         }
                    }                    
                }, 
                clearForm : false,
                resetForm:false,
                timeout : 300000                                
             }
        );
        return false;
     });

    //催办提醒多选框选中
    jQuery("input[type=checkbox][name=m_msg_type]").each(function(){
        var This = this;
        jQuery(this).click(function(){
           if(jQuery(This).attr("checked")=="checked"){
                  jQuery("#"+jQuery(This).val()).val("1");
               }else{
                  jQuery("#"+jQuery(This).val()).val("0");
               }
       });
    });
});

/**
 * 催办
 */
var sendHurry = function(){   
    //是否全部验证通过
    var isFlag = jQuery('#form1').validationEngine('validate'); 
    if(!isFlag ){
      return ;
    }
    //本地验证
    var checkBox = jQuery("#m_msg_type:checked").length;
    if(!checkBox){
      alert("请至少选择一种催办方式");
      return;
    }    
   jQuery("#form1").submit();     
}
/**
 * 关闭弹出框
 */
function closed(){
   removeAlertWindows(windowId,true);
}
</script>
</head>
<body style="overflow-y: hidden;" onload="adaptationWH('_top','vcenter',30)">
<!-- 表格-->
<div id="vcenter" style="float: left; width: 100%;">
<div class="content_02_box_div" id="remind_div" style="width:100%">
<form id="form1" action="" method="post">  
<table border="0" cellspacing="0" cellpadding="0"
    class="content_02_box_div_table" style="width: 100%;">
    <tr>
        <th width="20%" class="content_02_box_div_table_th" >催办方式：</th>
        <td width="80%"  class="content_02_box_div_table_td">
        <%if("1".equals(is_pub_sms)){ %> 
        <input style="margin-left: 5px;"
            name="m_msg_type" type="checkbox" value="is_sms"
            <%if("1".equals(StringUtil.deNull(bean.getIs_sms()))){%>
            checked="checked" <%} %> />&nbsp;短信
        &nbsp;<%} %> <%if("1".equals(is_pub_mail)){ %> 
        <input name="m_msg_type"
            type="checkbox" value="is_mail"
            <%if("1".equals(StringUtil.deNull(bean.getIs_mail()))){%>
            checked="checked" <%} %> />&nbsp;邮件&nbsp;
        <%} if("1".equals(is_pub_rtx)){%> <input name="m_msg_type"
            type="checkbox" value="is_rtx"
            <%if("1".equals(StringUtil.deNull(bean.getIs_rtx()))){%>
            checked="checked" <%} %> />&nbsp;即时信息&nbsp;
        <%} if("1".equals(is_pub_msg)){%> <input name="m_msg_type"
            type="checkbox" value="is_msg"
            <%if("1".equals(StringUtil.deNull(bean.getIs_msg()))){%>
            checked="checked" <%} %> />&nbsp;站内信息&nbsp;
        <%} %> <input type="hidden" id="is_sms" name="bean.is_sms"
            value="<%=StringUtil.deNull(bean.getIs_sms()) %>" /> <input
            type="hidden" id="is_mail" name="bean.is_mail"
            value="<%=StringUtil.deNull(bean.getIs_mail()) %>" /> <input
            type="hidden" id="is_rtx" name="bean.is_rtx"
            value="<%=StringUtil.deNull(bean.getIs_rtx()) %>" /> <input
            type="hidden" id="is_msg" name="bean.is_msg"
            value="<%=StringUtil.deNull(bean.getIs_msg()) %>" /></td>
    </tr>
    <tr>
        <th class="content_02_box_div_table_th">催办内容：</th>
        <td class="content_02_box_div_table_td"><textarea
            style="width:98%;height:150px;"
            id="remind_content" name="bean.remind_content"
            class="validate[required,maxSize[300]] textarea_575"><%=StringUtil.deNull(bean.getRemind_content())%></textarea>
        
            <input type="hidden" id="ids" name="ids" value="<%=StringUtil.deNull(receptIds) %>" />
            <input type="hidden" id="bean.send_user_id" name="bean.send_user_id" value="<%=StringUtil.deNull(userId) %>" />
            
        </td>
    </tr>
</table>
</form>
</div>

<div id="_top" class="toolbar_bottom"><input value="关闭"
    onclick="closed()" type="button" class="but_y_01"
    style="float: right; margin-top: 5px; margin-right: 10px;" /> 
<input
    name="cb_button" id="cb_button" value="发送"
    style="float: right; margin-top: 5px; margin-right: 5px;"
    onclick="sendHurry();" type="button" class="but_y_01" /></div>


</div>
</body>
</html>
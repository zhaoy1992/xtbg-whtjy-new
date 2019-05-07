<%--
describe:填写反馈信息页面
author:dailianchun
date: 2013-11-6
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
String userName = accesscontroler.getUserName();
//获得当前登录用户所属单位信息
UserCacheBean usercachebean=UserCache.getUserCacheBean(userId);
String orgId = usercachebean.getUnit_id();//获得单位id
String orgName = usercachebean.getUnit_name();
String infoId = request.getParameter("info_id");//任务id
String receptId = request.getParameter("recept_id");//任务接收表id
String windowId = request.getParameter("windowId");
String type = request.getParameter("type");//0:反馈信息，1：退回重办
       type = StringUtil.nullOrBlank(type)?"0":type;
String path = request.getContextPath();
//会议纪要service
InspectManageService service = new InspectManageServiceImpl();
InspectResponseBean bean = new InspectResponseBean();
bean.setAttach_id(StringUtil.getUUID());
bean.setInfo_id(infoId);
bean.setRecept_id(receptId);
bean.setOrg_id(orgId);
bean.setOrg_name(orgName);
bean.setResponse_userid(userId);
bean.setResponse_username(userName);
bean.setType(type);

%>  

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">



<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.UserCache"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean"%>
<%@page import="com.chinacreator.xtbg.core.inspect.entity.InspectResponseBean"%><html>
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
<!-- 引入上传控件 -->
<script type="text/javascript" src="../../resources/plug/fancyupload/mootools-1.2.5-core-jm.js"></script>
<script type="text/javascript" src="../../resources/plug/fancyupload/source/Fx.ProgressBar.js"></script>
<script type="text/javascript" src="../../resources/plug/fancyupload/source/Swiff.Uploader.js"></script>
<script type="text/javascript" src="../../resources/plug/fancyupload/source/FancyUpload3.Attach.js"></script>
<script type="text/javascript" src="../../resources/plug/fancyupload/myfancyupload.js"></script>

<script src="../../resources/plug/form/jquery.form.js" type="text/javascript"></script>
<script type="text/javascript">
var path = "<%=path%>"; 
var windowId = "<%=windowId%>";
var attach_id = "<%=bean.getAttach_id()%>";
jQuery(function(){
	jQuery("#for_focus").focus();//解决无法获得焦点的问题
	MyFancyupload.createUpload('_fileshow', '_filebut', path, path+'/servlet/pubFileUpload?buessid='+attach_id, true, attach_id,'','','111');
    
    //将表单升级为ajax的提交方式
    jQuery("#form1").submit(function(){
        jQuery(this).ajaxSubmit(
            {
                type: "post", 
                //url: "filefilesdo.jsp", 
                url : path+"/ajaxServlet?className=com.chinacreator.xtbg."
                +"core.inspect.action.InspectManageAction&method=responseInspect",
                dataType: "json",
                contentType: "application/x-www-form-urlencoded; charset=utf-8",
                beforeSubmit : function(data,form,options ){                                            
                   
                },
                success: function (data,status) {
                    if(data.flag){                        
                        alert(data.msg,{
	                            headerText:'提示',
	                            okName:'确认',
	                            okFunction:function(){
		                        	var parentWin = getParentWindow(windowId);
		                            if(parentWin && parentWin.reload){   
		                            	parentWin.reload();
		                            }
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
var responseInspect = function(){   
    //是否全部验证通过
    var isFlag = jQuery('#form1').validationEngine('validate'); 
    if(!isFlag ){
      return ;
    }
    //本地验证
    var nativeFlag = nativeValidate();
    if(!nativeFlag){
       return;
    }       
   jQuery("#form1").submit();     
}

/**
 * 本地验证
 */
function nativeValidate(){
    var str = eWebEditor1.getHTML();
    jQuery('#response_content').val(str); 
    if(IsSpace(str)){
           alert("内容不能为空");
           return false;       
    }   
    return true;
}
/**
 * 关闭弹出框
 */
function closed(){
   removeAlertWindows(windowId,true);
}
</script>
</head>
<body style="overflow-y: hidden;" onload="adaptationWH('_top','vcenter',100)">
<!-- 表格-->
<div id="vcenter" style="float: left; width: 100%;">
<form id="form1" action="" method="post">  
<input type="hidden" id="info_id" name="responseBean.info_id" value="<%=bean.getInfo_id() %>"/>
<input type="hidden" id="recept_id" name="responseBean.recept_id" value="<%=bean.getRecept_id() %>"/>
<input type="hidden" id="org_id" name="responseBean.org_id" value="<%=bean.getOrg_id() %>"/>
<input type="hidden" id="org_name" name="responseBean.org_name" value="<%=bean.getOrg_name() %>"/>
<input type="hidden" id="response_userid" name="responseBean.response_userid" value="<%=bean.getResponse_userid() %>"/>
<input type="hidden" id="response_username" name="responseBean.response_username" value="<%=bean.getResponse_username() %>"/>
<input type="hidden" id="type" name="responseBean.type" value="<%=bean.getType() %>"/>

<table border="0" cellspacing="0" cellpadding="0"
    class="content_02_box_div_table" style="width: 100%;">
  
    <tr>
        <td colspan="2" class="content_02_box_div_table_td"
            style="height: 310px;text-align: center;vertical-align: middle;">
	        <textarea style="display: none" name="responseBean.response_content" id="response_content"></textarea> 
	        <iframe id="eWebEditor1" src="../../resources/plug/eWebEditor_V4.60/ewebeditor.htm?id=response_content&style=gray" frameborder="0" 
	                scrolling="no" width="98%" height="300"></iframe>
        </td>
    </tr>
    <tr>
        <th width="10%" class="content_02_box_div_table_th">选择附件：</th>
        <td width="90%" class="content_02_box_div_table_td">
              <input class="but_y_03" style="margin-top: 3px;"  type="button" id="_filebut" value="请选择文件"/>
              <input type="hidden" id="attach_id" name="responseBean.attach_id" value="<%=StringUtil.deNull(bean.getAttach_id()) %>"/>
               <input type="text" id="for_focus" name="for_focus" value="" style="border: 0px;width:1px;height:1px;"/>
        
        </td>
     </tr>
      <tr>
	       <th width="10%" valign="top" class="content_02_box_div_table_th">附件列表：</th>
	       <td width="90%" class="content_02_box_div_table_td">
	       <ul id="_fileshow"></ul>
       </tr>
   
</table>
</form>
</div>

<div id="_top" class="toolbar_bottom"><input value="关闭"
    onclick="closed()" type="button" class="but_y_01"
    style="float: right; margin-top: 5px; margin-right: 10px;" /> <input
    name="cb_button" id="cb_button" value="发送"
    style="float: right; margin-top: 5px; margin-right: 5px;"
    onclick="responseInspect();" type="button" class="but_y_01" /></div>

</body>
</html>
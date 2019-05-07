<%-- 
描述：添加短信模板
作者：黄海
版本：1.0
日期：2013-07-10
 --%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.common.util.*"%>
<%@page import="java.util.*"%>
<%@page import="com.chinacreator.xtbg.core.meeting.entity.MeetingNoteTemplateBean"%>
<%@page import="com.chinacreator.xtbg.core.meeting.service.impl.*"%>
<%@page import="com.chinacreator.xtbg.core.meeting.service.*"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
    AccessControl accesscontroler = AccessControl.getAccessControl();
    accesscontroler.checkAccess(request, response);
    String path = request.getContextPath();
    
    //传入的会议类型id
    String m_id = StringUtil.deNull(request.getParameter("m_id"));//主键id
    //window的id
    String windowId = StringUtil.deNull(request.getParameter("windowId"));

    //会议类型管理的service
    MeetingHandleServiceIfc service = new MeetingHandleServiceImpl();
    MeetingNoteTemplateBean bean = new MeetingNoteTemplateBean();
    
    //传入了id，则查询得到会议类型
    if(!StringUtil.nullOrBlank(m_id)){
    	bean = service.getMeetingNoteTemplateBeanById(m_id);
    }else{
    	bean.setM_contents("会议通知：会议名称：【会议名称】  会议地点：【会议地点】  会议时间：【会议时间】");
    }

%>
<title>添加会议类型</title>
<!-- 引入jQuery -->
<script type="text/javascript"
    src="<%=path%>/ccapp/oa/resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script type="text/javascript">jQuery.noConflict();</script>
<!-- 引入jQuery UI -->
<script
    src="<%=path%>/ccapp/oa/resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js"
    type="text/javascript"></script>
<!-- 引入formvValidatetion -->
<script
    src="<%=path%>/ccapp/oa/resources/plug/formvalidation/jquery.validationEngine-cn.js"
    type="text/javascript" charset="utf-8"></script>
<script
    src="<%=path%>/ccapp/oa/resources/plug/formvalidation/jquery.validationEngine.js"
    type="text/javascript" charset="utf-8"></script>
<!-- 引入其它 -->
<script src="<%=path%>/ccapp/oa/resources/util/public.js"
    type="text/javascript"></script>
<script type="text/javascript"
    src="<%=path%>/ccapp/oa/resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript"
    src="<%=path%>/ccapp/oa/resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript"
    src="<%=path%>/ccapp/oa/resources/plug/ifrom/js/ifrom-tools.1.1.js"
    charset="utf-8"></script>
<!-- 公共部分引用结束 -->
<script type="text/javascript">
//父窗口id
var windowId ="<%=windowId%>";
var m_id = "<%=m_id%>";
jQuery(function(){
	 jQuery("#form1").validationEngine();
	 jQuery("#m_name").focus();
	 //新增操作
     jQuery("#cz_fb_button").show();          
});
/*
函数:  closed
说明:  关闭
*/
function closed(){
	removeAlertWindows('<%=windowId%>',true);
}

/*
函数:  Ok
说明:  提交添加与修改(发布操作)
参数:   无
返回值: 无
*/
var Ok = function(name) {
    //没有传入id,或为复制操作时，则为插入数据
    if("" == m_id){
        //发布，传入状态和操作参数
        ajaxSubmit("add","确定要"+name+"吗？");
    }else{
         //发布，传入状态和操作参数
        ajaxSubmit("update","确定要"+name+"吗？");
    }
   
}


/**
 函数:  ajaxSubmit
 说明:  ajax访问后台
 参数:  state 状态 0：暂存，1：发布
 返回值: 无
 */
var ajaxSubmit = function(action,alertMsg){    
	//是否全部验证通过
    var isFlag = jQuery('#form1').validationEngine('validate'); 
    if(!isFlag ){
      return ;
    }   

    jQuery("#cz_fb_button").attr("disabled","disabled");
    //ajax方式提交数据
    jQuery.ajax({
        type: "post", 
        url: "meetingnotedo.jsp", 
        contentType: "application/x-www-form-urlencoded; charset=utf-8",
        data : {
            action : action,
            paramJson : setParamJson()      
        },
        dataType: "json", 
        success: function (data) {
        	jQuery("#cz_fb_button").removeAttr("disabled");
            
            //操作成功，返回上层界面
            if(data && data.flag && "true" == data.flag){
                //调用父窗口的方法重新加载数据
            	var pwindow = window.top.findPageCacheName(windowId).superwindow;
                if(pwindow && pwindow.search){
            		pwindow.search();
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
        	jQuery("#cz_fb_button").removeAttr("disabled");
            alert("出现异常，请稍后再试！");
        } 
     });            
          
          
        
}

/**
 * 将参数转换成json数据
 */ 
function setParamJson(){
    var paramjson = "{'m_id':'"+jQuery("#m_id").val()+"',"+
                    " 'm_name':'"+jQuery("#m_name").val()+"',"+
                    " 'm_contents':'"+jQuery("#m_contents").val()+"'"+
                    "}";
    return paramjson
}

</script>
</head>
<body style="overflow-y: hidden;">
<form id="form1" action="" method="post">
    <!-- 隐藏的变量 -->
    <input type="hidden" id="m_id" name="m_id" value="<%=StringUtil.deNull(bean.getM_id())%>"/>
   
	<!-- 表格-->
	<div id="vcenter" style="float: left; width: 100%;height:293px;overflow: scroll；padding:0px;">
		
		<div style="float: left; width: 98%;margin:0px;padding:0px">
			<div class="content_02_box"  style="width:500px;">
			    <div class="content_02_box_title_bg"  style="width:500px;">
			        <span>短信模板信息</span>
			    </div>
				<div class="content_02_box_div" style="width:500px;">
					<table border="0" cellspacing="0" cellpadding="0"
					    class="content_02_box_div_table" style="width:500px;">
					    <tr>
					        <th class="content_02_box_div_table_th">
					            <span class="color_red">*</span>短信模板名称：
					        </th>
					        <td colspan="3" class="content_02_box_div_table_td">
						        <input type="text" style="width: 95%"
						            value="<%=StringUtil.deNull(bean.getM_name())%>" id="m_name"
						            name="m_name" maxlength="50"
						            class="validate[required,maxSize[50]] input_cx_title_150" />
					        </td>
					     </tr>
					    <tr>
                            <th width="150" valign="top" class="content_02_box_div_table_02_th">内容：</th>
                            <td colspan="3" class="content_02_box_div_table_02_td" style="padding:0px;">
                                  <textarea class="validate[maxSize[500]]" style="margin:0px;"
	                                  rows="8" cols="45" id="m_contents" 
	                                  name="m_contents"><%=StringUtil.deNull(bean.getM_contents())%></textarea>
                            </td>
                        </tr>
					</table>
				</div>
			</div>
		</div>
	</div>
	<div class="content_02" style="overflow: hidden;" id="_top"><!-- 操作-->
        <div class="content_02_top" style="border-bottom: 0px;border-top:1px solid #9dbfe4;padding-right:5px;">
            <input name="close_button"  value="关闭" onclick="closed()" type="button" class="but_y_01" style="float: right;margin-right: 5px;" />
            <input  name="cz_fb_button" id="cz_fb_button" value="保存" onclick="Ok(this.value);" style="display: none;float:right;" type="button" class="but_y_01" /> 
        </div>
    </div>
</form>
</body>
</html>
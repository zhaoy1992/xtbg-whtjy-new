<%--
describe: 添加公告栏回复信息
author:dailianchun
date: 2013-7-09
--%>
<%@page import="com.chinacreator.xtbg.core.file.util.FileUtil"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.UserCache"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean"%>
<%@page import="com.chinacreator.xtbg.core.notice.service.impl.NoticeHandleServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.notice.service.NoticeHandleServiceIfc"%>
<%@page import="com.chinacreator.xtbg.core.notice.entity.NoticeReportAuditBean"%>
<%@page import="com.chinacreator.xtbg.core.common.util.*"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.task.entity.*"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.*"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DaoUtil"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	String path = request.getContextPath();
	String userName = accesscontroler.getUserName();
	String userId = accesscontroler.getUserID();
	UserCacheBean userBean= UserCache.getUserCacheBean(accesscontroler.getUserID());
	if(userBean==null){
		userBean = new UserCacheBean();
	}
	
	String n_notice_id = StringUtil.deNull(request.getParameter("n_notice_id"));//通知公告id
	String report_id = StringUtil.deNull(request.getParameter("report_id"));//评论id
	String windowId = StringUtil.deNull(request.getParameter("windowId"));

	Map<String,String> bean = new HashMap<String,String>();
	if (!StringUtil.nullOrBlank(report_id)) {
		NoticeHandleServiceIfc service = new NoticeHandleServiceImpl();
		bean = service.findInfoReportAudit(report_id);

	} else {
		bean.put("report_userid",userId);
		bean.put("report_username",userName);
		bean.put("report_unitid",userBean.getUnit_id());
		bean.put("report_unitname",userBean.getUnit_name());
		bean.put("notice_id",n_notice_id);
		bean.put("report_time",DateUtil.getCurrentDateTime());
	}
	
	//特检员OA 2014-07-07 start  公告管理员角色
	//档案管理员角色
	boolean isFlieROLE = FileUtil.isRolesUser(accesscontroler.getUserID(), "公告管理员");
	//特检员OA 2014-07-07 end   公告管理员角色
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
var windowId = "<%=windowId%>";
/*
函数:  Ok
说明:  提交添加与修改密集程度
参数:   无
返回值: 无
*/
jQuery(function() {
    jQuery("#report_view").focus();
    jQuery("#form1").validationEngine();
});

/**
 *保存
 */
function save() {
    ajaxSubmit("add","确定保存吗?"); 
}

/**
 * ajax提交数据
 */
var ajaxSubmit = function(action,alertMsg){
   
    //是否全部验证通过      
    if(!jQuery('#form1').validationEngine('validate') ){
      return ;
    }
    var okF = function(){
    		jQuery("#action").val("addBaseInfo");
			jQuery("#form1").submit();
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
 * 删除
 */
var deleted = function(){
	var okF = function(){
		jQuery("#action").val("deleteBaseInfo");
		jQuery("#hidden_delete").val("<%=StringUtil.deNull(bean.get("report_id"))%>");
		jQuery("#form1").submit();
	}
	var p={
				headerText:'提示',
				okName:'确认',
		        okFunction:okF,
		        cancelName:'取消'
		};
	alert("确定要删除该信息吗？",p);
}

<%--提交后回调--%>
afterSubmitFn=function(result){
	try{
		if(result.indexOf("delete")!=-1){
			alert(result.split(",")[1]);
			searchData();
		}else{
			if(result.split(",").length>1){
					result = result.split(",");
					alert(result[0]);
					closed();
			} else {
				alert(result);
				closed();
				
			}
			
		}
	}catch(e){alert(e.description);}
};

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
     <form id="form1" name="form1"  method="post" action="noticesreportviewdo.jsp"  target="noticetypeinfodoJSPhiddenFrame">
        <input type="hidden" name="report_id" id="report_id" value="<%=StringUtil.deNull(bean.get("report_id"))%>"/>
        <input type="hidden" name="notice_id" id="notice_id" value="<%=StringUtil.deNull(bean.get("notice_id"))%>"/>
        <input type="hidden" name="report_userid" id="report_userid" value="<%=StringUtil.deNull(bean.get("report_userid"))%>"/> 
        <input type="hidden" name="report_username" id="report_username" value="<%=StringUtil.deNull(bean.get("report_username"))%>"/>
        <input type="hidden" name="report_unitid" id="report_unitid" value="<%=StringUtil.deNull(bean.get("report_unitid"))%>"/>
        <input type="hidden" name="report_unitname" id="report_unitname" value="<%=StringUtil.deNull(bean.get("report_unitname"))%>"/>
        <input type="hidden" name="report_time" id="report_time" value="<%=StringUtil.deNull(bean.get("report_time"))%>"/>
        <input type="hidden" name="action" id="action" value="addBaseInfo"/>
        <input type='hidden' name='delete' id="hidden_delete"/>
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="content_box_text">
              <th><font id="frequired" style="COLOR: red">*</font>内容：</th>
              <td>
                  <textarea  class="validate[required,maxSize[1000]] cur_textarea_575" style="width: 320px;height:130px;border:0px;margin:2px 0 2px; " name="report_view" id="report_view" ><%=StringUtil.deNull(bean.get("report_view"))%></textarea>
            
              </td>
            </tr>
		
         </table>
    </form>
    </div>
    <div class="cue_box_foot" style="float:left;">
        <input class="but_y_01" type="reset" id="resert" value="关闭" onclick="closed()" />
        <% if(StringUtil.deNull(bean.get("report_userid")).equals(userId)||(isFlieROLE==true)){ %>
       		<input class="but_y_01" type="button" id="sel" name="sel" value="删除" onclick="deleted()"/>
         	<input class="but_y_01" type="button" id="sel" name="sel" value="确定" onclick="save()"/>
        <%} %>
       
    </div>
    <iframe name="noticetypeinfodoJSPhiddenFrame" width=0 height=0></iframe>
</body>
</html>
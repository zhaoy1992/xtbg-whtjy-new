<%--
describe:
author:dailianchun
date: 2013-6-27
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
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
    AccessControl accesscontroler = AccessControl.getAccessControl();
    accesscontroler.checkAccess(request, response);
    //会议纪要service
    MeetingMinutesService service = new MeetingMinutesServiceImpl();    
    String path = request.getContextPath();
    String id = StringUtil.deNull(request.getParameter("id"));//主键id  
    String windowId = request.getParameter("windowId");//窗口id
   
    String m_flag = StringUtil.deNull(request.getParameter("m_flag"));//获得传入的阅读状态
    //未传入此参数，则设置为“未读”
    m_flag = StringUtil.nullOrBlank(m_flag) ? "0" : m_flag;
    //只要状态不是已读，更新会议纪要阅读状态为已读
    if(!"1".equals(m_flag)){
        service.updateMeetingMinutesReader(id,accesscontroler.getUserID());
    }
    
    MeetingMinutesBean bean = null;
    //如果传入了id，则查询出会议纪要对象
    if (!StringUtil.nullOrBlank(id)) {
        bean = service.queryToMeetingMinutesBean(id);       
        
        //将会议开始时间的秒截取掉
        String  beginTime = StringUtil.deNull(bean.getM_begin_time());
        bean.setM_begin_time(beginTime.substring(0,beginTime.length()-3));
    }else{
        bean = new MeetingMinutesBean();
    }
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
<!-- 引入其它 -->
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

<script type="text/javascript">
var id = "<%=id%>";
var windowId = "<%=windowId%>";

//附件id
var m_attach_id = "<%=bean.getM_attach_id() %>";

//系统根路径
var path = "<%=path %>";

jQuery(function(){
    //附件
    MyFancyupload.createUpload('_fileshow', '_filebut', path, path+'/servlet/pubFileUpload?buessid='+m_attach_id, false, m_attach_id,'','','011');
    
});

/**
 * 关闭弹出框
 */
function closed(){
    //新增或修改数据，提示是否保存
    removeWindows(windowId,true);
        
}
/**
 * 查看详情
 */
function showDetail(){
	openWindows('showDetail_meetingmenutes','查看会议纪要'
	         ,'meetingminutesadd.jsp?windowId=showDetail_meetingmenutes&flag=1&id='+id
	         ,'meetingmanager',false,window);	   
}
</script>
</head>
<body style="overflow-y: hidden;" onload="adaptationWH('_top','vcenter',1)">

    <div class="content_02" style="overflow: hidden;" id="_top">
        <div class="content_02_top" style="margin-bottom: 10px;">
            <input id="showDetail" name="showDetail" value="查看详情" onclick="showDetail();" type="button" class="but_y_01"/>
            <input name="" value="返回" onclick="closed()" type="button" class="but_y_01" />
        </div>
    </div>
    
    <!-- 表格-->
    <div id="vcenter" style="float: left; width: 100%; overflow: scroll"
        scrolling="yes">
        
        <div style="float: left; width: 775px;">
            <table border="0" cellspacing="0" cellpadding="0"
                        class="content_02_box_div_table">
                <tr>
                    <td colspan="2" height="50" valign="middle" 
                    style="padding-top:5px;font-weight: bolder;font-size:28px; color:red;text-align:center;">
                                                                  会议纪要                
                    </td>
                </tr>
               <tr>
               <td colspan="2" class="content_02_box_div_table_td"  style="border:0px;text-align:right;">
                                              会议纪要登记人：<%=bean.getM_reg_user_name() %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                     会议召开时间： <%=bean.getM_begin_time() %>
               </td>
               </tr>
               <tr>
                   <td colspan="2" width="100%" style="height:3px;background:red">
                                                        
                   </td>
               </tr>               
               <tr>
                   <td colspan="2"  class="content_02_box_div_table_td" 
                   style="padding:20px;border:0px;text-align:center;font-weight: 800;font-size:18px">
                       <%=bean.getM_title() %>
                   </td>
               </tr> 
                <tr>
                   <td colspan="2"  class="content_02_box_div_table_td" 
                   style="height:400px;border:0px;text-align:left;padding:20px 20px 30px 20px;vertical-align: top;">
                       <%=bean.getM_contents() %>
                   </td>
               </tr> 
               <tr>
                   <td colspan="2" width="100%" style="height:3px;background:red">
                                                        
                   </td>
               </tr>   
                
                <tr>
                    <th width="10%" class="content_02_box_div_table_td" style="padding-left:10px;border:0px;" valign="top">
                    <!-- 上传按钮不需要显示，隐藏的话，控件会报错，故设置为非常小 -->
                    <a href="#" id="_filebut" style="width:1px;height:1px;"></a>
                                                        附件：</th>
                    <td width="90%" class="content_02_box_div_table_td" style="border:0px;text-align:left;">
                       
                       <div  id="_fileshow"></div>
                       &nbsp;
                    </td>
                </tr>
            </table>                
        </div>  
    </div>

</body>
</html>
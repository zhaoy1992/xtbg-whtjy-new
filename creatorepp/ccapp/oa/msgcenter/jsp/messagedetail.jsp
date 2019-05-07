<%--
describe:展示消息
author:dailianchun
date: 2013-9-11
--%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.common.util.*"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.UserCache"%>
<%@page import="com.chinacreator.xtbg.core.kbm.util.KbmUtil"%>
<%@page import="com.chinacreator.xtbg.core.common.msgcenter.services.impl.MessageCenterServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.common.msgcenter.services.MessageCenterService"%><html>
<head>
<%
    AccessControl controler = AccessControl.getAccessControl();
    controler.checkAccess(request, response);
    String path = request.getContextPath();
    //获得当前登录用户的id
    String userId = controler.getUserID();    
    String recvId = StringUtil.deNull(request.getParameter("recv_id"));//信息接收id
    String isRead = StringUtil.deNull(request.getParameter("isRead"));//是否已读
    String windowId = StringUtil.deNull(request.getParameter("windowId"));
    MessageCenterService service = new MessageCenterServiceImpl();
    //根据接收id获得消息信息
    Map<String,String> msgMap = service.querySingleMsgById(recvId);
    //未读或未传入阅读状态，则更新状态为已读
    if("0" == isRead || StringUtil.nullOrBlank(isRead)){
    	service.updateMessageReaded(userId,recvId);
    }
    
%>
<title></title>
<!-- 公共部分开始 -->
<script type="text/javascript"
    src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<!-- 日期控件 -->
<script src="../../resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>

<!-- 引入jQuery UI -->
<script
    src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js"
    type="text/javascript"></script>

<!-- 引入jGrid -->
<link rel="stylesheet" type="text/css" media="screen"
    href="../../resources/plug/jquery.jqGrid-4.3.1/css/ui.jqgrid.css" />
<script
    src="../../resources/plug/jquery.jqGrid-4.3.1/js/i18n/grid.locale-en.js"
    type="text/javascript"></script>
<script
    src="../../resources/plug/jquery.jqGrid-4.3.1/js/jquery.jqGrid.min.js"
    type="text/javascript"></script>

<!-- 引入其它 -->
<script type="text/javascript"
    src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"
    charset="utf-8"></script>
<script src="../../resources/util/public.js" type="text/javascript"></script>
<script type="text/javascript"
    src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<script src="../../resources/util/multiSelect.js" type="text/javascript"></script>

<script type="text/javascript">
var windowId = "<%=windowId%>";
jQuery(function(){
	//adaptationWH('','vcenter',450);	
});


/**
 * 关闭窗口
 */
function closed(){
	try{
        //调用父窗口的方法重新加载数据
        var pwindow = window.top.findPageCacheName(windowId).superwindow;
        if(pwindow && pwindow.search){
            pwindow.search();
        }
        
    }catch(e){
        alert(e.message+"");
       /**忽略异常信息**/
    }
    removeAlertWindows(windowId,true);
    
}
</script>
<!-- 公共部分结束 -->
</head>
<body>
    <!-- 查询列表区 cGridArea(查询区样式)-->
 
   <div id="vcenter" align="center" style="width:98%;padding:5px;">
        
         <div  class="vcenter"  align="left" style="height:150px;float: left;width:100%;
         overflow: auto;word-wrap:break-word;word-break:nomal;">         
             <%=StringUtil.deNull(msgMap.get("msg_content")) %>&nbsp;                 
         </div>
         <div  align="left" style="border-top: 1px #999 dashed;float: left;width:100%;height:30px;">
            <span style="color:#D6D6D6;font-weight: bold;">发送人：</span> <%=StringUtil.deNull(msgMap.get("user_name")) %>
            &nbsp; &nbsp; 
            <span style="color:#D6D6D6;font-weight: bold;">时间：</span> <%=StringUtil.deNull(msgMap.get("send_date")) %>
         </div>
   </div>
   
   <div class="cue_box_foot" style="float:left;position: absolute;bottom:0px;">
        <input class="but_y_01" type="reset" id="resert" value="关闭" onclick="closed()" />
    </div>
    
</body>
</html>
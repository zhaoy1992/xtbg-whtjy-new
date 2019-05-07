<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request,response);
	String path = request.getContextPath();
	String userid = accesscontroler.getUserID();
	
	String messtr ="";
	String book_name = URLDecoder.decode(StringUtil.deNull(request.getParameter("book_name")),"UTF-8");//解码
	String borrow_givetime = request.getParameter("borrow_givetime");
	String f_detail_ids = request.getParameter("f_detail_ids");
	String sendtype = request.getParameter("sendtype"); //如果是批量催还
	if(!StringUtil.nullOrBlank(sendtype) && "one".equals(sendtype)){
		 messtr ="您借阅的【"+book_name+"】于【"+borrow_givetime+"】到期。请及时归还!";
	}else{
		 messtr ="您借阅的图书已到期，请及时归还!";
	}
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<title>办公设备 领用登记单</title>
<!-- 公共部分开始 -->
<!-- 引入jQuery -->
<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script src="../../resources/js/util/jsonutil.js" type="text/javascript"></script>
<!-- 引入jQuery UI -->
<script src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>
<!-- 引入其它JS -->
<script src="../../resources/js/util/public.js" type="text/javascript"></script>
<script src="../../resources/js/common/commoncss.js" type="text/javascript"> </script> 
<script src="../../resources/js/conference.js" type="text/javascript"></script>
<script src="../../resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<link rel="stylesheet" href="../../resources/plug/formvalidation/css/validationEngine.jquery.css" type="text/css" />
<script src="../../resources/plug/formvalidation/jquery.validationEngine-cn.js" type="text/javascript" charset="UTF-8"></script>
<script src="../../resources/plug/formvalidation/jquery.validationEngine.js" type="text/javascript" charset="UTF-8"></script>
<!-- 引入提示 -->
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js" ></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>

<script type="text/javascript">
jQuery(document).ready(function() {
	jQuery("#conferenceBase").validationEngine();
});

function backTo(){
	removeAlertWindows('',true);
}

function checktype(){
	if(jQuery('#isTypebox').attr("checked")){
			jQuery('#isType').val('y');
	}else{
			jQuery('#isType').val('n');
	}
	if(jQuery('#isnowType').attr("checked")){
		jQuery('#isnow').val('y');
	}else{
		jQuery('#isnow').val('n');
	}
}

function sendmsg(){
	if(jQuery('#isTypebox').attr("checked")||jQuery('#isnowType').attr("checked")){
		jQuery('#conferenceBase').attr("target","hiddenFrame");
		jQuery('#conferenceBase').submit();
	}else{
		alert("请选择提醒类型!");
	}
}
afterSubmitFn = function(data){
	alert(data);
	backTo();
}
</script>
</head>
<body style="overflow-y: hidden;" onload="adaptationWH('content_02_top','vcenter',40)">
<div class="content_02_top" style="margin-bottom:10px;" id="divA">
	<input type="button" class="but_y_01" value="发送" onclick="sendmsg();" id="btn_insert"/>
	<input type="button" class="but_y_01" value="返回" onclick="backTo();" id="btn_update"/>
</div>
<div class="content_02_box_title_bg"><span>催还消息提醒</span></div>
<form id="conferenceBase" name="conferenceBase" method="post" action="filefilesquerydo.jsp">
<input type="hidden" name="action" value="fileBackCallUser"/>
<input type="hidden" id="isType" name="isType"/>
<input type="hidden" id="isnow" name="isnow"/>
<input type="hidden" id="f_detail_ids" name="f_detail_ids" value="<%=f_detail_ids%>"/>
<table id='formTable' border="0" cellspacing="0" cellpadding="0"  class="content_02_box_div_table" width="100%">
	<tr>
		<th class="content_02_box_div_table_th">提醒方式：</th>
		<td class="f_td1" style="line-height:30px;">
			<input type="checkbox" id="isTypebox" onclick="checktype()"/>
			<span style="color: black;font-size: 13px;">短信提醒</span>
			<input type="checkbox" id="isnowType" onclick="checktype()"/>
			<span style="color: black;font-size: 13px;">即时消息</span>
		</td>
	</tr>
    <tr>
 	     <td width="10%" class="content_02_box_div_table_th">&nbsp;&nbsp;提醒内容内容：</td>
         <td  class="content_02_box_div_table_td" >
         	 <textarea  class="validate[required] textarea_575"  rows="8" cols=""  name="message_info" id="message_info"><%=messtr%></textarea>
         </td>
     </tr>
</table>
</form>
	<iframe name="hiddenFrame" id="hiddenFrame" width=0 height=0></iframe>
</body>
</html>


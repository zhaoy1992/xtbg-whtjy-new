<%@page import="com.chinacreator.xtbg.caizhengting.ibrary.entity.IbraryBorrowInfoBean"%>
<%@page import="com.chinacreator.xtbg.caizhengting.ibrary.service.impl.IbraryBorrowInfoServiceImpl"%>
<%@page import="com.chinacreator.xtbg.caizhengting.ibrary.service.IbraryBorrowInfoService"%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="utf-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.pub.util.StringUtil"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.chinacreator.xtbg.pub.util.*"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Date"%>
<%@page import="com.chinacreator.business.common.tools.CacheCommonManage"%>
<%
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request,response);
	String path = request.getContextPath();
	String userid = accesscontroler.getUserID();
	String theRootOrgid = DaoUtil.SqlToField("select org_id from td_sm_organization where parent_id='0'");
	String widowsid = request.getParameter("widowsid");
	String canedit = request.getParameter("canedit"); //是否可编辑 
	String borrow_id = StringUtil.deNull(request.getParameter("borrow_id"));
	IbraryBorrowInfoBean bean = new IbraryBorrowInfoBean();
	String give_time = "";//应归还时间
	if(!StringUtil.nullOrBlank(borrow_id)){
		IbraryBorrowInfoService service = new IbraryBorrowInfoServiceImpl();
		bean = service.getbeanbyid(borrow_id);
		give_time = bean.getBorrow_givetime();//应归还时间
	}
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<title>办公设备 领用登记单</title>
<!-- 公共部分开始 -->
<!-- 引入jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script src="../../../resources/js/util/jsonutil.js" type="text/javascript"></script>
<!-- 引入jQuery UI -->
<script src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>
<!-- 引入其它JS -->
<script src="../../../resources/js/util/public.js" type="text/javascript"></script>
<script src="../../../resources/js/common/commoncss.js" type="text/javascript"> </script> 
<script src="../../../resources/js/conference.js" type="text/javascript"></script>
<script src="../../../resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<link rel="stylesheet" href="../../../resources/plug/formvalidation/css/validationEngine.jquery.css" type="text/css" />
<script src="../../../resources/plug/formvalidation/jquery.validationEngine-cn.js" type="text/javascript" charset="UTF-8"></script>
<script src="../../../resources/plug/formvalidation/jquery.validationEngine.js" type="text/javascript" charset="UTF-8"></script>
<!-- 引入提示 -->
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js" ></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>

<script type="text/javascript">
var borrow_id ="<%=borrow_id%>";
var give_time = "<%=give_time%>";//应归还时间
jQuery(document).ready(function() {
	jQuery("#conferenceBase").validationEngine();
});

function savebean(type){
	if("giveback"==type){
		jQuery("#boorow_state").val("2"); //归还操作   
	}
	jQuery("#actiontype").val("update");
	jQuery('#conferenceBase').attr("target","hiddenFrame");
	jQuery("#action_type").val(type);
	jQuery('#conferenceBase').submit();
}

function backTo(){
	removeAlertWindows('',true);
}

function sendmsg(){
	var book_name = jQuery("#book_name").val();
	var phone_number = jQuery("#phone_number").val();
	var boorow_user_name = jQuery("#boorow_user_name").val();
	var borrow_givetime = give_time;//应归还时间
	var boorow_user_id = jQuery("#boorow_user_id").val();
	window.location.href="ibrarymessage.jsp?book_name="+encodeURI(encodeURI(book_name))+"&borrow_givetime="+borrow_givetime+"&boorow_user_id="+boorow_user_id+"&sendtype=one&phone_number="+phone_number+"&boorow_user_name="+boorow_user_name;
}
</script>
</head>
<body style="overflow-y: hidden;" onload="adaptationWH('content_02_top','vcenter',40)">
<div class="content_02_top" style="margin-bottom:10px;" id="divA">
<%if("true".equals(canedit)){ %>
	<input type="button" class="but_y_01" value="保存" onclick="savebean('update');" id="btn_save"/>
	<input type="button" class="but_y_01" value="归还" onclick="savebean('giveback');" id="btn_guihuan"/>
	<input type="button" class="but_y_01" value="催还" onclick="sendmsg();" id="btn_chuihuan"/>
<%} %>
	<input type="button" class="but_y_01" value="返回" onclick="backTo();" id="btn_back"/>
</div>
<div class="content_02_box_title_bg"><span>图书借阅管理</span></div>
<form id="conferenceBase" name="conferenceBase" method="post" action="ibraryborrowDo.jsp" >
<input id="action_type" name="action_type" type="hidden"/>
<input id="borrow_id" name="borrow_id" type="hidden" value="<%=StringUtil.deNull(bean.getBorrow_id()) %>"/>
<input id="boorow_state" name="boorow_state" type="hidden"/>
<table id='formTable' border="0" cellspacing="0" cellpadding="0"  class="content_02_box_div_table" width="100%">
	<tr>
		<th class="content_02_box_div_table_th">图书名称：</th>
		<td class="content_02_box_div_table_td" colspan="3">
			<input id="book_id" name="book_id" type="hidden" value="<%=StringUtil.deNull(bean.getBook_id())%>"/>
			<input type="text" class="input_188" name="book_name" id="book_name" disabled="disabled" value="<%=StringUtil.deNull(bean.getBook_name())%>" />
		</td>
	</tr>
	<tr>
		<th class="content_02_box_div_table_th">借阅人：</th>
		<td class="content_02_box_div_table_td">
			<input type="hidden" name="boorow_user_id" id="boorow_user_id" value="<%=StringUtil.deNull(bean.getBoorow_user_id())%>"/>
			<input type="text" id="boorow_user_name" disabled="disabled" name="boorow_user_name" class="input_188" value="<%=StringUtil.deNull(bean.getBoorow_user_name())%>" />
		</td>
		<th class="content_02_box_div_table_th">借阅时间：</th>
		<td class="content_02_box_div_table_td">
			<input class="date_120 Wdate" type="text" id="borrow_time" name="borrow_time" disabled="disabled" readonly="readonly" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm'})" value="<%=StringUtil.deNull(bean.getBorrow_time())%>" />
		</td>
	</tr>
	<tr>
		<th class="content_02_box_div_table_th">联系电话：</th>
		<td class="content_02_box_div_table_td">
			<input type="text" class="input_188" name="phone_number" id="phone_number" disabled="disabled" value="<%=StringUtil.deNull(bean.getPhone_number())%>" />
		</td>
		<%if("true".equals(canedit)){ %>
		<th class="content_02_box_div_table_th"><span class="color_red">*</span>应归还时间：</th>
		<td class="content_02_box_div_table_td">
			<input class="validate[required] date_120 Wdate" type="text" id="borrow_givetime" name="borrow_givetime" onclick="WdatePicker({minDate:'#F{$dp.$D(\'borrow_time\')}'})" value="<%=StringUtil.deNull(bean.getBorrow_givetime())%>" />
		</td>
		<%}else{ %>
		<th class="content_02_box_div_table_th"><span class="color_red">*</span>归还时间：</th>
		<td class="content_02_box_div_table_td">
			<input class="validate[required] date_120 Wdate" type="text" disabled="disabled" value="<%=StringUtil.deNull(bean.getBoorow_backtime())%>" />
		</td>
		<%} %>
	</tr>
	<tr>
		<%if("true".equals(canedit)){ %>
		<th class="content_02_box_div_table_th">借阅经手人：</th>
		<td class="content_02_box_div_table_td" colspan="3">
			<input type="text" class="input_188" name="boorow_out_user_id" id="boorow_out_user_id" disabled="disabled" value="<%=StringUtil.deNull(bean.getBoorow_out_user_id())%>" />
		</td>
		<%}else{%>
		<th class="content_02_box_div_table_th">归还经手人：</th>
		<td class="content_02_box_div_table_td" colspan="3">
			<input type="text" class="input_188" name="boorow_in_user_id" id="boorow_in_user_id" disabled="disabled" value="<%=StringUtil.deNull(bean.getBoorow_in_user_id())%>" />
		</td>
		<%} %>
	</tr>
</table>
</form>
	<iframe name="hiddenFrame" width=0 height=0></iframe>
</body>
</html>


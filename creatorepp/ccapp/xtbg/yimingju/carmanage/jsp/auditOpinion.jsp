

<%@page import="com.chinacreator.xtbg.pub.conference.entity.MeetingTypeMaintainBean"%>
<%@page import="com.chinacreator.xtbg.pub.conference.service.impl.MeetingTypeMaintainServiceImpl"%>
<%@page import="com.chinacreator.xtbg.pub.conference.service.MeetingTypeMaintainService"%>
<%@page import="com.chinacreator.xtbg.pub.util.DaoUtil"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@ page contentType="text/html; charset=GBK"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.chinacreator.xtbg.pub.util.StringUtil"%>



<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<%
AccessControl accesscontroler = AccessControl.getAccessControl();
accesscontroler.checkAccess(request, response);
	
	String path = request.getContextPath();
	//当前用户的id，用户名，真实姓名
	String userId = accesscontroler.getUserID();
	String userName = accesscontroler.getUserName();
	String passCheck=request.getParameter("passCheck");
	String id = request.getParameter("id");
%>
<title>审核意见</title>
<!-- 公共部分开始 -->
		<!-- 引入jQuery -->
	<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
	<script src="../../../resources/js/util/jsonutil.js" type="text/javascript"></script>
	
		<!-- 引入其它 -->
		<script src="../../../resources/js/util/public.js" type="text/javascript"></script>

		<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
		<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
		<link href="../../../resources/plug/ifrom/css/ifrom-ui-core.css" rel="stylesheet" type="text/css" />
	
	
	<!-- 公共部分结束 -->
		<script type="text/javascript">
		
		function mySubmit(){
			 document.all.form1.target = "hiddenFrame";
			 $('#form1').attr("action","carWxSpSave.jsp");
			 $('#form1').submit()
		}
		</script>
		
<body style="overflow-y:hidden;">
	<form id="form1"  method="post">
		<input type="hidden" name="passCheck" id="passCheck" value="<%=passCheck%>"/>
		<input type="hidden" name="id"  id="id" value="<%=id%>"/>
	<div id="users-contain">
		<table width="100%" border="0" cellspacing="0" cellpadding="0" >
		
			<tr>
				<th class="content_02_box_div_table_th">审批意见：</th>
			</tr>
			<tr>
				<td class="content_02_box_div_table_td" colspan="3">
				<textarea rows="3" cols="50" id="passCase" name="passCase"></textarea>
                </td>
			</tr>
		</table>
		
		</div>
		
		<div class="cue_box_foot">
		<input type="button" value='关闭' onclick="" class="but_y_01"/>
		<input type="button" value='保存' onclick="mySubmit()" class="but_y_01"/>
    	</div>
	
	</form>
	<iframe name="hiddenFrame" width=0 height=0></iframe>
</body>
</html>
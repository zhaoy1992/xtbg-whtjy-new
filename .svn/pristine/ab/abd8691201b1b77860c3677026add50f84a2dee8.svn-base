<%@page import="java.util.List"%>
<%@page import="com.chinacreator.xtbg.pub.util.StringUtil"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.business.common.tools.CacheCommonManage"%>
<%@page import="com.chinacreator.business.common.tools.CacheCommonManageProxy"%>
<%@page import="com.chinacreator.xtbg.yimingju.mail.dao.MailConfigDao"%>
<%@page import="com.chinacreator.xtbg.yimingju.mail.dao.impl.MailConfigDaoImpl"%>
<%@page import="com.chinacreator.xtbg.yimingju.mail.constant.EmailConstants"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.HashMap"%>
<%@page contentType="text/html; charset=utf-8"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
AccessControl accesscontroler = AccessControl.getAccessControl();
accesscontroler.checkAccess(request,response);
String userId = accesscontroler.getUserID();
String userName = accesscontroler.getUserName();
String orgId=accesscontroler.getChargeOrgId();
String orgName=accesscontroler.getChargeOrgName();
String path = request.getContextPath();
String mid = request.getParameter("mid");

MailConfigDao mailConfigDao = new MailConfigDaoImpl();
String adminEmailMemory = mailConfigDao.getUserEmailBoxMemoryConfig("'1'").get("1");//此处先写死，后续可以扩展
int adminEmailMemoryInt = Integer.valueOf(adminEmailMemory);
String subid ="";
if(request.getParameter("windowId")!=null){
	subid=request.getParameter("windowId"); //首页
}else{
	subid=request.getParameter("subid");
}
%>
<title></title>

<!-- 引入jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>

<script type="text/javascript">jQuery.noConflict();</script>

<!-- 引入其它 -->
<!-- 公共部分引用结束 -->
<script src="../../../resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<link rel="stylesheet" href="../../../resources/plug/formvalidation/css/validationEngine.jquery.css" type="text/css" />
<script src="../../../resources/plug/formvalidation/jquery.validationEngine-cn.js" type="text/javascript" charset="utf_8"></script>
<script src="../../../resources/plug/formvalidation/jquery.validationEngine.js" type="text/javascript" charset="utf_8"></script>
<script src="../../../resources/js/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js" charset="utf-8"></script>


<style>
	.width70{
		width:70px;
	}
</style>
<script type="text/javascript">
function save(){
	var okF = function(){
			 document.all.form1.target = "hiddenFrame";
			 jQuery('#form1').attr("action","mailConfigSave.jsp");
			 jQuery('#form1').submit();
		}
		var p={
			headerText:'提示',okName:'确认', okFunction:okF,cancelName:'取消'
		};

		alert("是否确定保存？",p);
}


window.onload = function () {
			 adaptationWH("content_02_top","vcenter",50);	
}
 </script> 
</head>
<body style="overflow-y: hidden;">
	<form id="form1" name="form1" method="post" >
	<input type="hidden" name="user_ids" id="user_ids" value="1"/>
	<input type="hidden" name="action" id="action" />
	<div class="content_02" style="overflow: hidden;">
		<div id="vcenter" style="float: left; width: 100%; overflow: scroll" scrolling="yes" >
		<div class="content_02_top" style="margin-bottom: 1px;" id='content_02_top'>
			<input value="保存" type="button" class="but_y_01" onclick="save()" />
		</div>
 		<div class="content_02_box">
				<div class="content_02_box_title_bg">
				<div class="content_02_box_add show_content" >
				
				</div>
					<span>邮箱相关配置</span>
				</div>
				<div class="content_02_box_div" id="info">
					<table width="100%" border="0" cellspacing="0" cellpadding="0" id="content_02_box_div_table_02">
						<tr>
							<th width="212" valign="top">邮箱总容量配置：</th>
							<td width="580" id="">
							<input type="text" id="memory" name="memory" value="<%=adminEmailMemoryInt%>"  class="validate[required] input_140 width70"/><%=EmailConstants.CHECKEMAIL_MEMORY_UNIT %>&nbsp;&nbsp;
							<span style="color:red">如果邮箱容量已超过此上限，则无法发送邮件！</span>
							</td>
						</tr>
					</table>
				</div>
				</div>
			</div>	
	</div>

</form>			
<iframe name="hiddenFrame" width=0 height=0></iframe>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="com.chinacreator.epp.applymanager.util.StrUtil"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.sysmgrcore.entity.User"%>
<%@page import="com.chinacreator.sysmgrcore.manager.db.UserManagerImpl"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<%
	String path = request.getContextPath();
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	String userId = accesscontroler.getUserID();
	UserManagerImpl userDao = new UserManagerImpl();
	User user = new User();
	user = userDao.getUserById(userId);
	String userSex = "";
	if (null != user) {
		if ("M".equals(user.getUserSex())) {
			userSex = "男";
		} else if ("F".equals(user.getUserSex())) {
			userSex = "女";
		}
	}
%>
<title>用户个人信息查看</title>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script src="../../resources/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script src="<%=path%>/ccapp/oa/resources/util/htmlutil.js" type="text/javascript"></script>
<script type="text/javascript">
jQuery(function() {
	jQuery("#vcenter input[type=text][id!=task_name]:visible,#vcenter select:visible").unbind().each(function(){
	   HTMLUtil.readOnly(this);
	});
});

</script>
</head>

<body style="overflow-y: hidden;">
<form id="form1" name="form1" method="post"
	action="selectuserinfodo.jsp"><input type="hidden" id="sex"
	name="sex" value="<%=StringUtil.deNull(user.getUserSex())%>" /> <!--子div -->
<div class="Container" style="width: 100%;"><!--  主题  -->
<div id="vcenter" class="cue_leadcontent">
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="leaderlist_addbox">
	<tr>
		<td width="15%" class="leaderlist_addbox_th">登录名：</td>
		<td width="35%" class="leaderlist_addbox_td"><%=StringUtil.deNull(user.getUserName())%></td>
	</tr>
	<tr>
		<td width="15%" class="leaderlist_addbox_th">真实名称：</td>
		<td class="leaderlist_addbox_td"><%=StringUtil.deNull(user.getUserRealname())%></td>
	</tr>
	<tr>
		<td width="15%" class="leaderlist_addbox_th">性别：</td>
		<td class="leaderlist_addbox_td"><input type="text"
			class="input_title_text" id="userSex" name="userSex"
			value="<%=StringUtil.deNull(userSex)%>" /></td>
	</tr>
	<tr>
		<td width="15%" class="leaderlist_addbox_th">手机号码：</td>
		<td width="35%" class="leaderlist_addbox_td"><input type="text"
			class="input_title_text" id="userMobiletel1" name="userMobiletel1"
			value="<%=StringUtil.deNull(user.getUserMobiletel1())%>" /></td>
	</tr>
	<tr>
		<td width="15%" class="leaderlist_addbox_th">注册日期：</td>
		<td width="35%" class="leaderlist_addbox_td"><%=StringUtil.deNull(user.getUserRegdate() + "")%></td>
	</tr>
</table>
<div class="cue_box_foot" style="position: absolute;bottom: 0px;"><input name="Input2" value="关闭"
	type="button" class="but_y_01" onclick="removeAlertWindows('',true)" />
</div>
</div>

</div>
</form>
</body>
</html>

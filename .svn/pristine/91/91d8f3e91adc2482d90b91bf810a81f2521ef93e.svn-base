<%@page import="com.chinacreator.xtbg.core.directory.service.impl.DirectoryServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.directory.service.DirectoryServiceIfc"%>
<%@page import="com.chinacreator.xtbg.core.directory.entity.DirectoryBean"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
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
	//查询个人信息
	DirectoryServiceIfc directoryServiceIfc = new DirectoryServiceImpl();
	DirectoryBean directoryBean = new DirectoryBean();
	if (!StringUtil.isBlank(userId)) {
		directoryBean = directoryServiceIfc.getTypeBeanById(userId,"view");
	}
%>
<title>用户个人信息查看</title>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script src="../../resources/util/public.js" type="text/javascript"></script>
<link rel="stylesheet" href="../../resources/plug/formvalidation/css/validationEngine.jquery.css" type="text/css" />
<script src="../../resources/plug/formvalidation/jquery.validationEngine-cn.js" type="text/javascript" charset="utf-8"></script>
<script src="../../resources/plug/formvalidation/jquery.validationEngine.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script src="<%=path%>/ccapp/oa/resources/util/htmlutil.js" type="text/javascript"></script>
<script type="text/javascript">
	jQuery(function() {
		jQuery(
				"#vcenter input[type=text][id!=task_name]:visible,#vcenter select:visible")
				.unbind().each(function() {
					HTMLUtil.readOnly(this);
				});
	});
	function updatesubmit(){
		var isFlag = $('#form1').validationEngine('validate'); //是否全部验证通过
		if(isFlag){
			setuserSex();
			$("#form1").submit();
		}else{
			return;
		}
	}
	//设置性别数据
	function setuserSex(){
		//性别
		var userSex = jQuery("#userSex").val();
		if(userSex=="男"){
			jQuery("#userSex").val("M")
		} else if(userSex=="女"){
			jQuery("#userSex").val("F")
		} else {
			jQuery("#userSex").val("")
		}
	}
</script>
</head>

<body style="overflow-y: hidden;">
	<form id="form1" name="form1" method="post" action="<%=path%>/ccapp/oa/directory/jsp/updateUserInfo.jsp">
		<input type="hidden" name="userid" id="userid" value="<%=StringUtil.deNull(userId)%>" />
		<!--子div -->
		<div class="Container" style="width: 100%;">
			<!--  主题  -->
			<table class="content_02_box_div_table" style="width: 100%">
					<tr>
						<td class="content_02_box_title_bg">&nbsp;&nbsp;基本资料</td>
					</tr>
			</table>
			<div id="vcenter" class="cue_leadcontent" style="width: 96%">
				<table width="100%" border="0" cellspacing="0" cellpadding="0" class="leaderlist_addbox">
					<tr>
						<td  class="content_02_box_div_table_th">登录名：</td>
						<td  class="content_02_box_div_table_td" style="width:175px"><%=StringUtil.deNull(user.getUserName())%></td>
						<td  class="content_02_box_div_table_th">真实名称：</td>
						<td  class="content_02_box_div_table_td" width:175px><input type="text" name="userRealname" id="userRealname" readonly="readonly" value="<%=StringUtil.deNull(user.getUserRealname())%>" /></td>
					</tr>
					<tr>
						<td  class="content_02_box_div_table_th">性别：</td>
						<td class="content_02_box_div_table_td" style="width:175px"><input type="text"
							class="input_title_text" id="userSex" name="userSex"
							value="<%=StringUtil.deNull(userSex)%>" />
						</td>
						<td class="content_02_box_div_table_th">注册日期：</td>
						<td class="content_02_box_div_table_td"><%=StringUtil.deNull(user.getUserRegdate() + "")%></td>
					</tr>
				</table>
			</div>
			<table class="content_02_box_div_table">
				<tr>
					<td class="content_02_box_title_bg">&nbsp;&nbsp;联系方式</td>
				</tr>
			</table>
			<div class="cue_leadcontent" style="width: 96%">
			<table class="leaderlist_addbox">
				<tr>
					<th class="content_02_box_div_table_th"> 办公手机：</th>
					<td class="content_02_box_div_table_td" style="width:175px">
					   <input id="userMobiletel1" name="userMobiletel1" class="validate[custom[phone]] input_185" value="<%=StringUtil.deNull(directoryBean.getMobile())%>"/>
					</td>
					<th class="content_02_box_div_table_th" style="width:175px;"> 常用手机：</th>
					<td class="content_02_box_div_table_td" style="width:175px;">
					   <input id="userMobiletel2" name="userMobiletel2" class="validate[custom[phone]] input_185" value="<%=StringUtil.deNull(directoryBean.getMobile2())%>"/>
					</td>
				</tr>
				<tr>
					<th class="content_02_box_div_table_th">办公电话：</th>
					<td class="content_02_box_div_table_td">
					   <input id ="userWorktel" name ="userWorktel" class="input_185" value="<%=StringUtil.deNull(directoryBean.getWorkphone())%>"/>
					</td>
					<th class="content_02_box_div_table_th">短号：</th>
					<td class="content_02_box_div_table_td">
					<input id="remark4" name="remark4" class="validate[maxSize[100]] input_185" value="<%=StringUtil.deNull(directoryBean.getRemark4())%>"/></td>
				</tr>
				<tr>
					<th class="content_02_box_div_table_th">住宅电话：</th>
					<td class="content_02_box_div_table_td">
					   <input id ="homePhone" name ="homePhone" class="validate[custom[phone]] input_185" value="<%=StringUtil.deNull(directoryBean.getHomephone())%>"/>
					</td>
					<th class="content_02_box_div_table_th">电子邮箱：</th>
					<td class="content_02_box_div_table_td">
					   <input id="mail" name="mail" class="validate[custom[email]] input_185" value="<%=StringUtil.deNull(directoryBean.getEmail())%>"/>
					</td>
				</tr>
			</table>
			</div>	
			<div class="cue_box_foot" style="position: absolute; bottom: 0px;">
				<input name="Input2" value="关闭" type="button" class="but_y_01"
					onclick="removeAlertWindows('',true)" />
				<input class="but_h_01" type="button" id="resert" value="提交" onclick="updatesubmit()" />
			</div>

		</div>
	</form>
</body>
</html>

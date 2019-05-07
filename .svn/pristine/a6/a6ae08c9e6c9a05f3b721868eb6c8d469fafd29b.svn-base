<%-- 
描述：用户添加页面
作者：黄艺平
版本：1.0
日期：2013-05-27
 --%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.core.purviewmanager.service.UserManagerServiceIfc"%>
<%@page import="com.chinacreator.xtbg.core.purviewmanager.service.impl.UserManagerServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.purviewmanager.entity.UserBean"%>
<%@page import="com.chinacreator.sysmgrcore.entity.Organization"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="com.chinacreator.sysmgrcore.manager.db.OrgCacheManager"%>
<%@ page import="java.util.Date"%>
<%
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	String org_id = request.getParameter("org_id");
	String user_id = request.getParameter("user_id");
	String type = request.getParameter("type");
	String org_name = "";
	if(!StringUtil.isBlank(org_id)) {
		Organization organization = OrgCacheManager.getInstance().getOrganization(org_id);
		org_name = organization.getOrgName();
	}
	
	UserManagerServiceIfc userManagerServiceIfc = new UserManagerServiceImpl();
	Map<String, String> viewMap = new HashMap<String, String>();
	
	String user_regdate = "";
	String user_birthday = "";

	if(StringUtil.isBlank(user_id)) {
		java.util.Date date = new java.util.Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		user_regdate = sdf.format(date);
	} else {
		viewMap = userManagerServiceIfc.getUserBean(user_id);
		if(!StringUtil.isBlank(viewMap.get("user_regdate"))) {
			user_regdate = StringUtil.convertTimeToString(Timestamp.valueOf(StringUtil.deNull(viewMap.get("user_regdate"))), "yyyy-MM-dd");
		}
		if(!StringUtil.isBlank(viewMap.get("user_birthday"))) {
			user_birthday = StringUtil.convertTimeToString(Timestamp.valueOf(StringUtil.deNull(viewMap.get("user_birthday"))), "yyyy-MM-dd");
		}
	}

%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>用户添加</title>

<!-- 引入jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery1.7/jquery-1.7.1.min.js"></script>
<!-- 引入jQuery UI -->
<script src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>

<!-- 引入my97时间控件 -->
<script src="../../../resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<!-- 引入其它 -->
<script src="../../../resources/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/JQuery zTree v3.0/js/jquery.ztree.core-3.0.js"></script>
<script type="text/javascript" src="../../../resources/plug/JQuery zTree v3.0/js/jquery.ztree.excheck-3.0.js"></script>
<!-- 引入formvValidatetion -->
<script src="../../../resources/plug/formvalidation/jquery.validationEngine-cn.js" type="text/javascript"></script>
<script src="../../../resources/plug/formvalidation/jquery.validationEngine.js" type="text/javascript"></script>

<script type="text/javascript">

jQuery(document).ready(function() {
	jQuery("#form1").validationEngine();
	if('update' == '<%= type%>') {
		jQuery("#user_password").focus();
		jQuery("#user_name").attr("disabled",true);
		jQuery("#user_realname").attr("disabled",true);
		jQuery("#user_regdate").attr("readOnly",true);
		jQuery("#user_sex").val("<%=StringUtil.deNull(viewMap.get("user_sex")) %>");
		jQuery("#user_type").val("<%=StringUtil.deNull(viewMap.get("user_type")) %>");
		jQuery("#user_isvalid").val("<%=StringUtil.deNull(viewMap.get("user_isvalid")) %>");
		if("是" == '<%=viewMap.get("remark3") %>') {
			jQuery("#remark3").attr("checked",true);
		}	
	} else if('add' == '<%= type%>'){
		jQuery("#user_regdate").attr("readOnly",true);
		jQuery("#user_name").focus();
		jQuery("#user_sn").val("1");
	} else {
		jQuery("#save").hide();
	}
});

 /*
　 * description: 保存用户信息
　 * author: 黄艺平
　 * date: 2013-05-27
　 * param:
　 * return:  
　 */
function storeUser() {
	if(validateForm()){
		var okF = function(){
			$("#form1").attr("action","new_user_do.jsp");
			$("#form1").attr("target","hiddenFrame");
			jQuery('#form1').submit();
		}
		var p={
				headerText:'提示',
				okName:'确认',
				okFunction:okF,
				cancelName:'取消'
		};
		if('add' == '<%= type %>') {
			alert('确定添加用户吗？ ',p)
		} else if('update' == '<%= type %>') {
			alert('确定修改用户吗？ ',p)
		}
		
	}
}

/*
 * description: 验证方法
 * author: 黄艺平
 * date: 2013-05-16
 * param:
 * return:  
 */
function validateForm(){
	if(jQuery("#form1").validationEngine("validateform")) {
		return true;
	} else {
		return false;
	}
}


</script>

</head>
<body onload="">
<form action="" id="form1" name="form1" method="post">
<input type="hidden" id="org_id" name="org_id" value="<%=org_id %>" />
<input type="hidden" id="user_id" name="user_id" value="<%=user_id %>" />
<div class="content_02_box">
	<div class="content_02_box_title_bg"><span>用户基本信息</span></div>
		<div class="content_02_box_div">
			<table width="100%" border="0" cellspacing="0" cellpadding="0" class="content_02_box_div_table_02">
				<tr>
					<th class="content_02_box_div_table_th">
						<font color="red">*</font>登录名:
					</th>
					<td class="content_02_box_div_table_td">
						<input id="user_name" name="user_name" value="<%=StringUtil.deNull(viewMap.get("user_name"))%>" onkeyup="checkInsert(this)" onbeforepaste="checkPaste()"
						 class="validate[required,custom[loginUserNameCheck],maxSize[50]] input_185" />
					</td>
					<th class="content_02_box_div_table_th" >
						<font color="red">*</font>真实名称:
					</th>
					<td class="content_02_box_div_table_td">
						<input id="user_realname" name="user_realname" value="<%=StringUtil.deNull(viewMap.get("user_realname"))%>" onkeyup="checkInsert(this)" onbeforepaste="checkPaste()" class="validate[required,custom[userNameCheck],maxSize[50]] input_185"></input>
					</td>
				</tr>
				<tr>
					<th class="content_02_box_div_table_th" >
						<font color="red">*缺省口令为123456</font>口令:
					</th>
					<td class="content_02_box_div_table_td">
						<input id="user_password" name="user_password" type="password" 
						<%
							if(StringUtil.isBlank(user_id)) {
						%>
							value="123456" 
						<%
							} else {
						%>
							value="<%=StringUtil.deNull(viewMap.get("user_password"))%>" 
						<%
							}
						%>
						class="validate[required,maxSize[40]] input_185"  />
					</td>
					<th class="content_02_box_div_table_th">
						身份证号码:
					</th>
					<td class="content_02_box_div_table_td">
						<input id="user_idcard" name="user_idcard" value="<%=StringUtil.deNull(viewMap.get("user_idcard"))%>" class="validate[checkidcard] input_185"  />
					</td>
				</tr>
				<tr>
					<th class="content_02_box_div_table_th" >
						单位电话:
					</th>
					<td class="content_02_box_div_table_td">
						<input id="user_worktel" name="user_worktel" value="<%=StringUtil.deNull(viewMap.get("user_worktel"))%>" class="validate[custom[phone]] input_185"></input>
					</td>
					<th class="content_02_box_div_table_th">
						性别:
					</th>
					<td class="content_02_box_div_table_td">
						<select name="user_sex" id="user_sex"> 
         					<option value="M" selected>男</option>          						
         					<option value="F">女</option>
						</select>
					</td>
				</tr>
				<tr>
				<th class="content_02_box_div_table_th" >
						手机号码:
					</th>
					<td class="content_02_box_div_table_td">
						<input id="user_mobiletel1" name="user_mobiletel1" value="<%=StringUtil.deNull(viewMap.get("user_mobiletel1"))%>" class="validate[custom[mphone]] input_185"></input>
					</td>

					<th class="content_02_box_div_table_th">
						电子邮件:
					</th>
					<td class="content_02_box_div_table_td">
						<input id="user_email" name="user_email" class="validate[custom[email]] input_185" value="<%=StringUtil.deNull(viewMap.get("user_email"))%>" />
					</td>
				</tr>
				<tr>
					<th class="content_02_box_div_table_th" >
						手机号码2:
					</th>
					<td class="content_02_box_div_table_td">
						<input id="user_mobiletel2" name="user_mobiletel2" value="<%=StringUtil.deNull(viewMap.get("user_mobiletel2"))%>" class="validate[custom[mphone]] input_185"></input>
					</td>
					<th class="content_02_box_div_table_th" >
						家庭电话:
					</th>
					<td class="content_02_box_div_table_td">
						<input id="user_hometel" name="user_hometel" value="<%=StringUtil.deNull(viewMap.get("user_hometel"))%>" class="validate[custom[phone]] input_185"></input>
					</td>
					
				</tr>
				<!-- 
				<tr>
					<th class="content_02_box_div_table_th" >
						移动电话1:
					</th>
					<td class="content_02_box_div_table_td">
						<input id="user_mobiletel1" name="user_mobiletel1" value="<%=StringUtil.deNull(viewMap.get("user_mobiletel1"))%>" class="validate[custom[mphone]] input_185"></input>
					</td>
					<th class="content_02_box_div_table_th">
						移动电话1归属地:
					</th>
					<td class="content_02_box_div_table_td">
						<input id="remark4" name="remark4" class="validate[maxSize[100]] input_185" value="<%=StringUtil.deNull(viewMap.get("remark4"))%>" />
					</td>
				</tr>
				<tr>
					<th class="content_02_box_div_table_th" >
						移动电话2:
					</th>
					<td class="content_02_box_div_table_td">
						<input id="user_mobiletel2" name="user_mobiletel2" value="<%=StringUtil.deNull(viewMap.get("user_mobiletel2"))%>" class="validate[custom[mphone]] input_185"></input>
					</td>
					<th class="content_02_box_div_table_th">
						移动电话2归属地:
					</th>
					<td class="content_02_box_div_table_td">
						<input id="remark5" name="remark5" class="validate[maxSize[100]] input_185" value="<%=StringUtil.deNull(viewMap.get("remark5"))%>" />
					</td>
				</tr>
				 -->
				<tr>
					<th class="content_02_box_div_table_th" >
						组织机构:
					</th>
					<td class="content_02_box_div_table_td">
						<input id="orgName" name="orgName" value="<%=org_name %>" readonly class="input_185"></input>
					</td>
					<th class="content_02_box_div_table_th">
						拼音:
					</th>
					<td class="content_02_box_div_table_td">
						<input id="user_pinyin" name="user_pinyin" class="validate[custom[onlyLetterSp],maxSize[40]] input_185" value="<%=StringUtil.deNull(viewMap.get("user_pinyin"))%>" />
					</td>
				</tr>
				<tr>
					<th class="content_02_box_div_table_th" >
						用户类型:
					</th>
					<td class="content_02_box_div_table_td">
						<select name="user_type" id="user_type"> 
         					<option value="0" selected>系统用户</option>          						
         					<option value="1">外部用户</option>
						</select>
					</td>
					<th class="content_02_box_div_table_th">
						邮政编码:
					</th>
					<td class="content_02_box_div_table_td">
						<input id="user_postalcode" name="user_postalcode" class="validate[maxSize[10]] input_185" onkeyup="checkInsert(this)" onbeforepaste="checkPaste()" value="<%=StringUtil.deNull(viewMap.get("user_postalcode"))%>" />
					</td>
				</tr>
				<!-- 
				<tr>
					<th class="content_02_box_div_table_th" >
						传真:
					</th>
					<td class="content_02_box_div_table_td">
						<input id="user_fax" name="user_fax" value="<%=StringUtil.deNull(viewMap.get("user_fax"))%>" class="validate[maxSize[20]] input_185"></input>
					</td>
					<th class="content_02_box_div_table_th">
						OICQ:
					</th>
					<td class="content_02_box_div_table_td">
						<input id="user_oicq" name="user_oicq" class="validate[maxSize[100]] input_185" value="<%=StringUtil.deNull(viewMap.get("user_oicq"))%>" />
					</td>
				</tr>
				 -->
				<tr>
					<th class="content_02_box_div_table_th" >
						生日:
					</th>
					<td class="content_02_box_div_table_td">
						<input class="date_120 Wdate" type="text" id="user_birthday" name="user_birthday"  value="<%=user_birthday %>"
						onclick="WdatePicker()"> </input>
					</td>
					<th class="content_02_box_div_table_th">
						用户地址:
					</th>
					<td class="content_02_box_div_table_td">
						<input id="user_address" name="user_address" class="validate[maxSize[200]] input_185" onkeyup="checkInsert(this)" onbeforepaste="checkPaste()" value="<%=StringUtil.deNull(viewMap.get("user_address"))%>" />
					</td>
				</tr>
				
				<tr>
					<th class="content_02_box_div_table_th" >
						注册日期:
					</th>
					<td class="content_02_box_div_table_td">
						<input id="user_regdate" name="user_regdate" value="<%=user_regdate%>" class="input_185"></input>
					</td>
					<th class="content_02_box_div_table_th">
						短号:
					</th>
					<td class="content_02_box_div_table_td">
						<input id="remark4" name="remark4" class="validate[custom[number],maxSize[6]] input_185" value="<%=StringUtil.deNull(viewMap.get("remark4"))%>" />
					</td>
				</tr>
				<tr>
					<th class="content_02_box_div_table_th" >
						是否有效:
					</th>
					<td class="content_02_box_div_table_td" colspan="3">
						<select name="user_isvalid" id="user_isvalid"> 
         					<option value="2" selected>开通</option>          						
         					<option value="3">停用</option>
						</select>
					</td>
					
				</tr>
				<tr>
					<th class="content_02_box_div_table_th" >
						备注:
					</th>
					<td class="content_02_box_div_table_td" colspan="3">
					<textarea style="width: 99%" rows="6" cols="12" class="validate[maxSize[200]]"
								id="remark5"  name="remark5"><%=StringUtil.deNull(viewMap.get("remark5"))%></textarea>
					</td>
					
					
				</tr>
				<!-- 
				<tr>
					<th class="content_02_box_div_table_th" >
						<font color="red">*</font>用户排序号:
					</th>
					<td class="content_02_box_div_table_td">
						<input id="user_sn" name="user_sn" value="<%=StringUtil.deNull(viewMap.get("user_sn"))%>" class="validate[required,custom[onlyNumberSp],maxSize[5]] input_185"></input>
					</td>
					<th class="content_02_box_div_table_th" >
						<input type="checkbox" id="remark3" name="remark3" value="是" /> 
					</th>
					<td class="content_02_box_div_table_td">
						个人信息是否保密
					</td>
				</tr> -->
			</table>
		</div>
	</div>
	<div class="cue_box_foot" style="position: absolute;bottom: 0px;">
		<input class="but_y_01" type="reset" id="resert" value="关闭" onclick="removeAlertWindows('',true)" />
		<%
				//if (!isNew.equals("0") || accesscontroler.getUserID().equals(userid)
					//|| accesscontroler.checkPermission(currOrgId, "edituser", AccessControl.ORGUNIT_RESOURCE)) {
		%>
		<input class="but_y_01" type="button" value="保存" id="save" name="save" onClick="storeUser()"/>
		<%
				//}
		%>
  	</div>
</form>
<iframe name="hiddenFrame" width="0" height="0"></iframe>
</body>
</html>
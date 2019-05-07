<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DateUtil"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.UserCache"%>
<%@page import="com.chinacreator.xtbg.yimingju.carmanage.entity.CarManageYoukaBean"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.yimingju.carmanage.service.CarManageYoukaService"%>
<%@page import="com.chinacreator.xtbg.yimingju.carmanage.service.impl.CarManageYoukaServiceImpl"%>
<%
	String path = request.getContextPath();
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	 //获得当前登录的用户信息
	String userId = accesscontroler.getUserID();
	String userName = accesscontroler.getUserName();
	//当前系统时间
	String time = DateUtil.getCurrentDateString("yyyy-MM-dd");
	//获得当前登录用户所属单位信息
	UserCacheBean usercachebean=UserCache.getUserCacheBean(userId);
	String unit_id = usercachebean.getUnit_id();
	String unit_name = usercachebean.getUnit_name();
	
	String id = request.getParameter("t_id");
	String windowsId = request.getParameter("windowsId");
	CarManageYoukaBean bean = new CarManageYoukaBean();
	if(!StringUtil.isBlank(id)){
		CarManageYoukaService service = new CarManageYoukaServiceImpl();
		bean = service.getByID(id);
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>油卡发放登记</title>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<!-- 引入jQuery UI -->
<!-- 引入其它 -->
<script src="../../../resources/js/util/public.js" type="text/javascript"></script>
<script src="../../../resources/js/common/commoncss.js" type="text/javascript"></script>
<!-- 引入jQuery_dialog -->
<script src="../../../resources/plug/jquery_dialog/jquery_dialog.js"></script>
<!-- 引入公共JS -->
<!-- 引入formvValidatetion -->
<script src="../../../resources/plug/formvalidation/jquery.validationEngine-cn.js" type="text/javascript" charset="UTF-8"></script>
<script type="text/javascript"src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script src="../../../resources/plug/formvalidation/jquery.validationEngine.js" type="text/javascript" charset="UTF-8"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<script type="text/javascript">
	jQuery(document).ready(function() {
		jQuery("#form1").validationEngine();
		jQuery("#youka_no").focus();
	});
/*
函数:  Ok
说明:  提交添加与修改来文单位
参数:   无
返回值: 无
*/
function Ok() {
	var isFlag = jQuery('#form1').validationEngine('validate'); //是否全部验证通过
	if (isFlag){
		jQuery("#hidden_action").val("update");
		//jQuery("#form1").attr("target","filetypeinfodoJSPhiddenFrame");
		jQuery("#form1").submit();
		getParentWindow("windowId1").userSearch();
		removeAlertWindows("windowId1",true);
	}
}
function closed(){
	removeWindows('',true);
}
</script>
<body style="overflow-y:hidden;">
	<form id="form1" action="youkadjdo.jsp" method="post"  >
		<input type='hidden' name='hidden_action' id="hidden_action"/>
		<input type='hidden' name='t_id' id="t_id" value="<%=id %>"/>
		<div id="users-contain">
			<table  width="100%" border="0" cellspacing="0" cellpadding="0" >
				<tr>
					<th class="content_02_box_div_table_th"><font color="red">*</font>申请事由：</th>
					<td class="content_02_box_div_table_td">
						<input readonly="readonly" type="text" name="shenqingshiyou" id="shenqingshiyou" class="validate[required,maxSize[200]] input_188" style="width:90%;height=23px" value="<%=StringUtil.deNull(bean.getShenqingshiyou()) %>">
					</td>
				</tr>
				<tr>
					<th class="content_02_box_div_table_th"><font color="red">*</font>车牌号：</th>
					<td class="content_02_box_div_table_td">
						<input readonly="readonly" type="text" name="car_info" id="car_info" class="validate[required,maxSize[200]] input_188" style="width:90%;height=23px" value="<%=StringUtil.deNull(bean.getCar_info()) %>">
					</td>
				</tr>
				<tr>
					<th class="content_02_box_div_table_th"><font color="red">*</font>申请科室：</th>
					<td class="content_02_box_div_table_td">
						<input readonly="readonly" type="text" name="org_name" id="org_name" class="validate[required,maxSize[200]] input_188" style="width:90%;height=23px" value="<%=StringUtil.deNull(bean.getOrg_name()) %>">
					</td>
				</tr>
				<tr>
					<th class="content_02_box_div_table_th"><font color="red">*</font>申请人：</th>
					<td class="content_02_box_div_table_td">
						<input readonly="readonly" type="text" name="application" id="application" class="validate[required,maxSize[200]] input_188" style="width:90%;height=23px" value="<%=StringUtil.deNull(bean.getApplication()) %>">
					</td>
				</tr>
				<tr>
					<th class="content_02_box_div_table_th"><font color="red">*</font>充值金额：</th>
					<td class="content_02_box_div_table_td">
						<input readonly="readonly" type="text" name="money" id="money" class="validate[required,maxSize[200]] input_188" style="width:90%;height=23px" value="<%=StringUtil.deNull(bean.getMoney()) %>">
					</td>
				</tr>
				<tr>
					<th class="content_02_box_div_table_th"><font color="red">*</font>申请日期：</th>
					<td class="content_02_box_div_table_td">
						<input readonly="readonly" type="text" name="application_date" id="application_date" class="validate[required,maxSize[200]] input_188" style="width:90%;height=23px" value="<%=StringUtil.deNull(bean.getApplication_date()) %>">
					</td>
				</tr>
				<tr>
					<th class="content_02_box_div_table_th"><font color="red">*</font>油卡号：</th>
					<td class="content_02_box_div_table_td">
						<input type="text" name="youka_no" id="youka_no" class="validate[required,maxSize[200]] input_188" style="width:90%;height=23px" value="">
					</td>
				</tr>
				<tr>
					<th class="content_02_box_div_table_th"><font color="red">*</font>油卡余额：</th>
					<td class="content_02_box_div_table_td">
						<input type="text" name="yu_e" id="yu_e" class="validate[required,maxSize[200]] input_188" style="width:90%;height=23px" value="">
					</td>
				</tr>
				<tr>
					<th class="content_02_box_div_table_th"><font color="red">*</font>发放人：</th>
					<td class="content_02_box_div_table_td">
						<input readonly="readonly" type="text" name="fafang_user" id="fafang_user" class="validate[required,maxSize[200]] input_188" style="width:90%;height=23px" value="<%=userName %>">
						<input type="hidden" name="fafang_user_id" id="fafang_user_id" value="<%=userId %>">
					</td>
				</tr>
				<tr>
					<th class="content_02_box_div_table_th"><font color="red">*</font>发放日期：</th>
					<td class="content_02_box_div_table_td">
						<input readonly="readonly" type="text" name="fafang_date" id="fafang_date" class="validate[required,maxSize[200]] input_188" style="width:90%;height=23px" value="<%=time %>">
					</td>
				</tr>
			</table>
		</div>
		<div class="cue_box_foot">
			<input class="but_y_01" type="button" value="关闭" onclick="removeAlertWindows('',true)" />
			<input class="but_y_01" type="button" id="sel"  value="保存" onclick="Ok()"/>
		</div>
		
	</form>
	
	<iframe name="filetypeinfodoJSPhiddenFrame" width=0 height=0></iframe>
</body>
</html>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="com.chinacreator.xtbg.yimingju.carmanage.service.FuelCardmangeService"%>
<%@page import="com.chinacreator.xtbg.yimingju.carmanage.service.impl.FuelCardmangeServiceImpl"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="com.chinacreator.xtbg.pub.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.pub.util.DaoImplClassUtil"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>特检院油卡查看</title>
<%
	String path = request.getContextPath();
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	String userid = accesscontroler.getUserID();
	String loginUserName = accesscontroler.getUserAccount();
	String subid = request.getParameter("windowId");
	String car_id= request.getParameter("car_id");
	Map<String,String> bean = new HashMap<String,String>();
	//类型业务
	FuelCardmangeService service = new FuelCardmangeServiceImpl();
	if(!StringUtil.nullOrBlank(car_id)){
		bean = service.getFuelcardInfo(car_id);
	}
	
%>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script src="../../../resources/plug/formvalidation/jquery.validationEngine-cn.js" type="text/javascript" charset="UTF-8"></script>
<script src="../../../resources/plug/formvalidation/jquery.validationEngine.js" type="text/javascript" charset="UTF-8"></script>
<!-- 引入jQuery UI -->
<link id="uiThemes" rel="stylesheet" type="text/css" media="screen" href="../../../resources/plug/jquery-ui-1.8.17.custom/css/custom-theme/jquery-ui-1.8.17.custom.css" />
<script src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>

<!-- 引入my97时间控件 -->
<script src="../../../resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>

<!-- 引入其它 -->
<script src="../../../resources/js/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<!-- 公共部分结束 -->

<script type="text/javascript">

jQuery(document).ready(function() {
	jQuery("#form1").validationEngine();
});

/* 
 * 返回 
 */
function back(){
	removeWindows("windowId",true);
}

/* 
 *保存
 */
function save(){
	var isFlag = jQuery('#form1').validationEngine('validate'); //是否全部验证通过
	if (isFlag){
		jQuery("#hidden_action").val("addInfo");
		jQuery("#form1").attr("target","hiddenFramefuelCainfo");
		jQuery("#form1").submit();
	}
}

afterSubmitFn=function(result){
	try{
		if(result.indexOf("delete")!=-1){
			alert(result.split(",")[1]);
		}else{
			if(result.split(",").length>1){
					result = result.split(",");
					alert(result[0]);
					window.parent.location.reload();
			} else {
				alert(result);
				window.parent.location.reload();
			}
			
		}
	}catch(e){alert(e.description);}
};



</script>
<script type="text/javascript">
	window.onload = function () {
		adaptationWH("_top","vcenter",0);
	}
</script>
</head>

<body style="overflow-y: hidden;">
<form id="form1" name="form1" action="fuelCarinfodo.jsp" class="formular" method="post">
<input type='hidden' name='action' id="hidden_action"/>
<input type='hidden' name='car_id' id="car_id" value="<%=StringUtil.deNull(bean.get("car_id"))%>"/>
 <div class="content_02" style="overflow: hidden;" scrolling="yes"  id="_top">
		<!-- 操作-->
		<div class="content_02_top" style="margin-bottom: 10px;" id='content_02_top'>
			<input id="savebtn" name="savebtn" type="button" class="but_y_01" onclick="save();" value="保存" />
			<input id="backbtn" name="backbtn" type="button" class="but_y_01" onclick="back();" value="返回" />
		</div>
 </div>
 <!-- ---表格------->
 <div id="vcenter" style="float: left; width: 100%;">
 <div style="float: left; width: 775px; ">
	<!--------------基本信-------------->
	 <div class="content_02_box_div">
		<div class="content_02_box_title_bg">
			<span>基本信息</span>
		</div>
			<table border="0" cellspacing="0" cellpadding="0" class="content_02_box_div_table">
				<tr>
					<th width="191" class="content_02_box_div_table_th">车牌号：</th>
					<td class="content_02_box_div_table_td">
					<%=StringUtil.deNull(bean.get("car_num")) %>
					</td>
				</tr>
				
				<tr>
					<th width="191" class="content_02_box_div_table_th">品牌：</th>
					<td class="content_02_box_div_table_td">
					<%=StringUtil.deNull(bean.get("car_brand")) %>
					</td>
				</tr>
				
				<tr>
					<th class="content_02_box_div_table_th"><font color="red">*</font>油卡卡号：</th>
					<td class="content_02_box_div_table_td">
						<input type="text" id="fuelcard_num" name="fuelcard_num" class="validate[required,maxSize[25]] input_title_text" value="<%=StringUtil.deNull(bean.get("fuelcard_num")) %>" />
					</td>
				</tr>
				
				<tr>
					<th width="191" class="content_02_box_div_table_th">油卡余额：</th>
					<td class="content_02_box_div_table_td">
						<input type="text" id="fuelcard_sum" readonly="readonly" name="fuelcard_sum" class="input_title_text" value="<%=StringUtil.deNull(bean.get("fuelcard_sum")) %>" />
					</td>
				</tr>
			</table>
	</div>
	<!-- 登记、充值使用记录列表 DIV-->
	<div id="div_fuelcardinfo" class="content_02_box_div"  style="width: 775px;"> 
		<iframe
			frameborder="0"
			style="padding: 0px; border: 0px; width: 780px; height: 350px"
			id="fuelcardinfo" name="fuelcardinfo"
			src="fuelCarHistoryList.jsp?car_id=<%=StringUtil.deNull(bean.get("car_id"))%>"></iframe>
	</div>
	<!-- 核查记录列表清单DIV -->
 
 </div>
</div>
</form>
<iframe name="hiddenFramefuelCainfo" width=0 height=0></iframe>

</body>
</html>
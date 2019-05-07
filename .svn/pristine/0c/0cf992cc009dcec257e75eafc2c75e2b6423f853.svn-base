<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.chinacreator.xtbg.yimingju.carmanage.entity.ApplyinfoState"%>
<%@page import="com.chinacreator.xtbg.yimingju.carmanage.entity.CarManageCarBean"%>
<%@page import="com.chinacreator.xtbg.pub.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.yimingju.carmanage.dao.CarManageCarDao"%>
<%@page import="com.chinacreator.xtbg.yimingju.carmanage.entity.CarManageApplyinfoBean"%>
<%@page import="com.chinacreator.xtbg.pub.util.DaoImplClassUtil"%>
<%@page import="com.chinacreator.xtbg.yimingju.carmanage.dao.CarManageApplyinfoDao"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>车辆管理车辆申请查看页面</title>
<%
	String path = request.getContextPath();
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	String userid = accesscontroler.getUserID();
	String loginUserName = accesscontroler.getUserAccount();
	String subid= request.getParameter("subid");
	String apply_id= request.getParameter("apply_id");
	String car_id = "";
	CarManageApplyinfoBean carManageApplyinfoBean = new CarManageApplyinfoBean();
	CarManageCarBean carManageCarBean = new CarManageCarBean();
	List<CarManageCarBean> carManageCarBeanList = new ArrayList<CarManageCarBean>();
	if(!StringUtil.nullOrBlank(apply_id)){
		// 车辆申请基本信息
		CarManageApplyinfoDao carManageApplyinfoDao = (CarManageApplyinfoDao)DaoImplClassUtil.getDaoImplClass("carManageApplyinfoDaoImplymj");
		carManageApplyinfoBean = carManageApplyinfoDao.findCarManageApplyinfoByApplyID(apply_id);
		// 车辆信息 carManageCarDaoImplymj
		CarManageCarDao carManageCarDao = (CarManageCarDao)DaoImplClassUtil.getDaoImplClass("carManageCarDaoImplymj");
		
		if(!StringUtil.nullOrBlank(carManageApplyinfoBean.getCar_id())){
			car_id = StringUtil.deNull(carManageApplyinfoBean.getCar_id());
			carManageCarBeanList = carManageCarDao.findCarManageCarList(carManageApplyinfoBean.getApply_id());
		}
	}
	
%>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>

<!-- 引入jQuery UI -->
<link id="uiThemes" rel="stylesheet" type="text/css" media="screen" href="../../../resources/plug/jquery-ui-1.8.17.custom/css/custom-theme/jquery-ui-1.8.17.custom.css" />
<script src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>
<!-- 引入formvValidatetion -->
<link rel="stylesheet"href="../../../resources/plug/formvalidation/css/validationEngine.jquery.css"type="text/css" />
<script src="../../../resources/plug/formvalidation/jquery.validationEngine-cn.js" type="text/javascript" charset="utf_8"></script>
<script src="../../../resources/plug/formvalidation/jquery.validationEngine.js" type="text/javascript" charset="utf_8"></script>
<!-- 引入my97时间控件 -->
<script src="../../../resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>

<!-- 引入其它 -->
<script src="../../../resources/js/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<!-- 公共部分结束 -->

<script type="text/javascript">
$(function(){
	jQuery("#form1").validationEngine();
})
var stateValue = "";
/**
 * 派车结束-pcendbtn
 */
var pcEndMethod = function(){
	var ypcInfo = "{'apply_id':'"+<%=apply_id%>
				+"','car_id':'"+'<%=car_id%>'
				+"','current_state':'"+'<%=ApplyinfoState.CAR_PC_END%>'
				+"','mileage':'"+$("#mileage").val()
				+"','oil':'"+$("#oil").val()
				+"','state':'"+'<%=ApplyinfoState.APPLYINFO_PC_END%>'+"'}";
	$("#ypcInfo").val(descape(escape(ypcInfo)));
	var okF = function(){
		$("#form1").attr("target","hiddenFrame");
		$("#form1").submit();
	}
	var p={
			headerText:'提示',
			okName:'确认',
		    okFunction:okF,
		    cancelName:'取消'
		};
	alert("是否派车结束",p)
}

/**
 * 更换派车-replacecarbtn
 */
var replaceCarMethod = function(){
	var url = "<%=path%>/ccapp/xtbg/yimingju/carmanage/jsp/carFpInfo.jsp?urlpar=clbg&apply_id=<%=apply_id%>";
																				//多加&shan=shan tl  2013-5-2
	openWindows("sub_ymjpcsp<%=apply_id%>",window,url+"&subid=sub_ymjpcsp<%=apply_id%>&subidpraent=<%=subid%>&shan=shan",'ymjclgl',false,window);
}


/* 
 * 保存---返回 
 */
function saveBack(){
	var url = "<%=path%>/ccapp/xtbg/yimingju/carmanage/jsp/CarSp.jsp";
	location.href = url;
}

/* 
 * 返回 
 */
function back(){
	removeWindows('<%=subid%>',true);
	window.top.window.frames["_document_body_mian_firstPagerAAAS"].document.location.reload();
}
</script>
<script type="text/javascript">
            
	window.onload = function () {
		adaptationWH("_top","vcenter",50);
	}
</script>
</head>

<body style="overflow-y: hidden;">
<form id="form1" name="form1" action="carpcform.jsp" class="formular" method="post">
 <div class="content_02" style="overflow: hidden;" scrolling="yes"  id="_top">
		<!-- 操作-->
		<div class="content_02_top" style="margin-bottom: 10px;" id='content_02_top'>
		<input id="pcendbtn" name="pcendbtn" type="button" class="but_y_01" onclick="pcEndMethod();" value="派车结束" />
		<input id="replacecarbtn" name="replacecarbtn" type="button" class="but_y_01" onclick="replaceCarMethod();" value="更变派车" />
		<input id="backbtn" name="backbtn" type="button" class="but_y_01" onclick="back();" value="返回" />
		<input id="state" name="state" type="hidden" />
		<input id="spyj" name="spyj" type="hidden" />
		<input id="ypcInfo" name="ypcInfo" type="hidden" />
		<input id="subid" name="subid" value="<%=subid %>" type="hidden" />
		</div>
 </div>
 
 <!-- ---表格------->
 <div id="vcenter" style="float: left; width: 100%;">
 <div style="float: left; width: 775px; ">
 		<!--------------用车信息-------------->
 <div class="content_02_box_div">
				<div class="content_02_box_title_bg">
					<span>用车信息</span>
				</div>
		<table border="0" cellspacing="0" cellpadding="0" class="content_02_box_div_table">
			<tr>
				<th width="191" class="content_02_box_div_table_th">用车人：</th>
				<td class="content_02_box_div_table_td">
				<%=StringUtil.deNull(carManageApplyinfoBean.getUse_name()) %>
				</td>
			</tr>
			
			<tr>
				<th width="191" class="content_02_box_div_table_th">用车事由：</th>
				<td class="content_02_box_div_table_td">
				<%=StringUtil.deNull(carManageApplyinfoBean.getUse_reason()) %>
				</td>
			</tr>
			
			<tr>
				<th class="content_02_box_div_table_th">用车时间：</th>
				<td class="content_02_box_div_table_td">
				<%=StringUtil.deNull(carManageApplyinfoBean.getUse_starttime()) %> 至 <%=StringUtil.deNull(carManageApplyinfoBean.getUse_endtime()) %>
				</td>
			</tr>
			
			<tr>
				<th width="191" class="content_02_box_div_table_th">目的地：</th>
				<td class="content_02_box_div_table_td">
				<%=StringUtil.deNull(carManageApplyinfoBean.getDestination()) %>
				</td>
			</tr>
			<tr>
				<th width="191" class="content_02_box_div_table_th">本次里程数：</th>
				<td class="content_02_box_div_table_td">
					<input class="validate[maxSize[25]] input_title_text"
					id="mileage" name="mileage" value=""></input>
				</td>
			</tr>
			<tr>
				<th width="191" class="content_02_box_div_table_th">本次油耗：</th>
				<td class="content_02_box_div_table_td">
					<input class="validate[maxSize[25]] input_title_text"
					id="oil" name="oil" value=""></input>
				</td>
			</tr>
		</table>
</div>
 
 		<!--------------车辆信息-------------->
 <% for(int i=0; i<carManageCarBeanList.size(); i++){
	      carManageCarBean = carManageCarBeanList.get(i);%>
 <div class="content_02_box_div">
				<div class="content_02_box_title_bg">
					<span>车辆信息</span>
				</div>
		<table border="0" cellspacing="0" cellpadding="0" class="content_02_box_div_table">
			<tr>
				<th width="191" class="content_02_box_div_table_th">车辆：</th>
				<td class="content_02_box_div_table_td">
				<%=StringUtil.deNull(carManageCarBean.getCar_num()) %>
				<!-- <a href="#" onclick="replaceCarMethod()" style="color:#1768B9;"><span>更变派车</span></a> -->
				</td>
			</tr>
			
			<tr>
				<th width="191" class="content_02_box_div_table_th">司机：</th>
				<td class="content_02_box_div_table_td">
				<%=StringUtil.deNull(carManageCarBean.getDriver()) %>
				</td>
			</tr>
			
			<tr>
				<th class="content_02_box_div_table_th">品牌：</th>
				<td class="content_02_box_div_table_td">
				<%=StringUtil.deNull(carManageCarBean.getCar_brand()) %>
				</td>
			</tr>
			
			<tr>
				<th width="191" class="content_02_box_div_table_th">型号：</th>
				<td class="content_02_box_div_table_td">
				<%=StringUtil.deNull(carManageCarBean.getCar_type()) %>
				</td>
			</tr>
			
			<tr>
				<th width="191" class="content_02_box_div_table_th">状态：</th>
				<td class="content_02_box_div_table_td">
				<%=StringUtil.deNull(carManageCarBean.getCurrent_state()) %>
				</td>
			</tr>
			
			<tr style="display: none;">
				<th width="191" class="content_02_box_div_table_th">审批意见：</th>
				<td class="content_02_box_div_table_td">
				<%=StringUtil.deNull(carManageApplyinfoBean.getSpyj()) %>
				</td>
			</tr>
		</table>
</div>	 
 <% }%>
 </div>
</div>

<input id="" name="" type="hidden" value="" />
</form>
<iframe name="hiddenFrame" width=0 height=0></iframe>

</body>
</html>
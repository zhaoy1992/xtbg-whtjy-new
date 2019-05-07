<%@page import="com.chinacreator.xtbg.pub.util.StringUtil"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Date"%>
<%@page import="com.chinacreator.xtbg.pub.jqueryupload.filebuess.dao.impl.FiletransfersSysDaoImpl"%>
<%@page import="com.chinacreator.xtbg.pub.jqueryupload.filebuess.dao.FiletransfersSysDao"%>
<%@page import="com.chinacreator.xtbg.pub.jqueryupload.filebuess.entity.FileInfoBean"%>
<%@page import="com.chinacreator.xtbg.yimingju.carmanage.entity.CarManageCarBean"%>
<%@page import="com.chinacreator.xtbg.pub.util.DaoImplClassUtil"%>
<%@page import="com.chinacreator.xtbg.yimingju.carmanage.dao.CarManageCarDao"%>
<%@page import="com.chinacreator.xtbg.pub.util.DaoUtil"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.yimingju.carmanage.entity.CarImageBeam" %>
<%@ page language="java" contentType="text/html; charset=gbk"
    pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	String userid = accesscontroler.getUserID();
	String loginUserName = accesscontroler.getUserAccount();
	
	String theRootOrgid = DaoUtil.SqlToField("select org_id from td_sm_organization where parent_id='0'");
	String subid = request.getParameter("subid");
	String car_id = request.getParameter("car_id");
	String attachment_id = new Date().getTime()+"";
	CarImageBeam cb = new CarImageBeam();
	CarManageCarBean carManageCarBean = new CarManageCarBean();
	// 车辆信息 carManageCarDaoImplymj
	CarManageCarDao carManageCarDao = (CarManageCarDao)DaoImplClassUtil.getDaoImplClass("carManageCarDaoImplymj");
	if(!StringUtil.nullOrBlank(car_id)){
		carManageCarBean = carManageCarDao.findCarManageCarByCarID(car_id);
	}
	List<CarImageBeam> fileList = null;
	if (!StringUtil.isBlank(carManageCarBean.getCar_photoid())) {
		attachment_id=carManageCarBean.getCar_photoid();
	 	fileList = carManageCarDao.getCarImageBeamlist(carManageCarBean.getCar_photoid());
	 	for(int i =0;i<fileList.size();i++)
	 	{
	 		cb=fileList.get(fileList.size()-1);;
	 	}
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>新车登记-添加界面</title>
</head>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script src="../../../resources/js/util/jsonutil.js" type="text/javascript"></script>

<!-- 引入jQuery UI -->
<link id="uiThemes" rel="stylesheet" type="text/css" media="screen" href="../../../resources/plug/jquery-ui-1.8.17.custom/css/custom-theme/jquery-ui-1.8.17.custom.css" />
<script src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>

<!-- 引入my97时间控件 -->
<script src="../../../resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>


<script type="text/javascript">jQuery.noConflict();</script>

<!-- 引入其它 -->
<script src="../../../resources/js/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../public/flowinfoconfig/resources/js/tree.js" charset="utf-8"></script>
<!-- 公共部分结束 -->

<script type="text/javascript">

var loginUserName = '<%=loginUserName%>';
var user_id = '<%=userid%>';

/**
 * 修改车辆申请基本信息--updateinfo
 */
var updateinfo = function(){
	var url = "<%=path%>/ccapp/xtbg/yimingju/carmanage/jsp/addCarinfo.jsp?car_id="+<%=car_id%>;
	location.href = url;	
}

/**
 * 删除车辆基本信息方法--delinfo()
 */
var delinfo = function(){
	var okF = function(){
		var fm = document.getElementById("form1");
		fm.target = "hiddenFrame";
		fm.submit();
	}
	var p={
			headerText:'提示',
			okName:'确认',
		    okFunction:okF,
		    cancelName:'取消'
		};
	alert('<center>'+'确定要删除吗？'+'</center>',p)
}
/* 
 * 返回 
 */
function back(){
	 var url = "<%=path%>/ccapp/xtbg/yimingju/carmanage/jsp/carRecordList.jsp";
	location.href = url;
	<%-- var okF = function(){
		removeWindows('<%=subid%>',true);
		location.href = url;
		}
		 var p={
			headerText:'提示',
			okName:'确认',
		    okFunction:okF,
		    cancelName:'取消'
		};
	alert('返回该页,未保存的信息将会丢失 '+'<br>'+'确定返回？',p); --%>
}
/* 
 * 保存---返回 
 */
function saveBack(){
	var url = "<%=path%>/ccapp/xtbg/yimingju/carmanage/jsp/carRecordList.jsp";
	location.href = url;
}

</script>

<body style="overflow-y: hidden;"  onload="adaptationWH('_top','vcenter',45);">
<form id="form1" name="form1" action="carmanagecarsaveform.jsp" class="formular" method="post">
<div class="content_02" style="overflow: hidden;" scrolling="yes"  id="_top">
		<!-- 操作-->
		<div class="content_02_top" style="margin-bottom: 10px;" id='content_02_top'>
		<input name="carIds" id="carIds" value="<%=car_id %>" type="hidden"/>
		<input name="action" id="action" value="del" type="hidden"/>
		<input name="viewdel" id="viewdel" value="viewdel" type="hidden"/>
		<input id="updatebtn" name="updatebtn" type="button" class="but_y_01" onclick="updateinfo();" value="修改" />
		<!-- <input id="delbtn" name="delbtn" type="button" class="but_y_01" onclick="delinfo();" value="删除" /> -->
		<input id="backbtn" name="backbtn" type="button" class="but_y_01" onclick="back();" value="返回" />
		</div>
 </div>
 
 <!-- ---表格------->
 <div id="vcenter" style="float: left; width: 100%;">
 <div style="float: left; width: 775px; ">
 		<!--------------车辆信息-------------->
 <div class="content_02_box_div">
				<div class="content_02_box_title_bg">
					<span>车辆信息</span>
				</div>
		<table border="0" cellspacing="0" cellpadding="0" class="content_02_box_div_table">
			<tr>
				<th class="content_02_box_div_table_th">车牌号：</th>
				<td class="content_02_box_div_table_td">
				<%=StringUtil.deNull(carManageCarBean.getCar_num()) %>
				</td>
				<td rowspan="8" width="30%" class="content_02_box_div_table_td">
					<%if(cb.getImage_parth()!=null){
					%>
					<img alt="车辆照片"  width="220" height="220" src="../../../../../<%=cb.getImage_parth()%>">
					<%}else{%>
					<img  width="220" height="220"  width="220" height="220" src="../image/u=2193430612,633948572&fm=11&gp=0.jpg">
					<%} %>
				</td>
			</tr>
			<tr>
				<th class="content_02_box_div_table_th">购买日期：</th>
				<td class="content_02_box_div_table_td">
				<%=StringUtil.deNull(carManageCarBean.getBuy_time()) %>
				</td>
			</tr>
			
			<tr>
				<th class="content_02_box_div_table_th">品牌：</th>
				<td class="content_02_box_div_table_td">
				<%=StringUtil.deNull(carManageCarBean.getCar_brand()) %>
				</td>
			</tr>
			
			<tr>
				<th class="content_02_box_div_table_th">型号：</th>
				<td class="content_02_box_div_table_td">
				<%=StringUtil.deNull(carManageCarBean.getCar_type()) %>
				</td>
			</tr>
			
			<tr>
				<th class="content_02_box_div_table_th">颜色：</th>
				<td class="content_02_box_div_table_td">
				<%=StringUtil.deNull(carManageCarBean.getColor()) %>
				</td>
			</tr>
			
			<tr>
				<th class="content_02_box_div_table_th">购买价格：</th>
				<td class="content_02_box_div_table_td">
				<%=StringUtil.deNull(carManageCarBean.getBuy_money()) %>&nbsp;元
				</td>
			</tr>
			
			<tr>
				<th class="content_02_box_div_table_th">车架号：</th>
				<td class="content_02_box_div_table_td">
				<%=StringUtil.deNull(carManageCarBean.getCard()) %>&nbsp;
				</td>
			</tr>
			
			<tr>
				<th class="content_02_box_div_table_th">发动机号：</th>
				<td class="content_02_box_div_table_td">
				<%=StringUtil.deNull(carManageCarBean.getFdj_num()) %>&nbsp;
				</td>
			</tr>
			
			<tr>
				<th class="content_02_box_div_table_th">司机：</th>
				<td class="content_02_box_div_table_td">
				<%=StringUtil.deNull(carManageCarBean.getDriver()) %>
				<input name="driver_id" id="driver_id" value="<%=StringUtil.deNull(carManageCarBean.getDriver_id()) %>" type="hidden" />
				</td>
			</tr>
			
			<tr>
				<th class="content_02_box_div_table_th">备注：</th>
				<td class="content_02_box_div_table_td">
				<textarea  class="validate[maxSize[500]] textarea_575" readonly="readonly" cols="3" style="width: 99%;"
					id="remark" name="remark"><%=StringUtil.deNull(carManageCarBean.getRemark()) %></textarea>
				</td>
			</tr>
		</table>
	</div>
	
	</div>
</div>
<input id="baseinfoJson" name="baseinfoJson" type="hidden" value="" />
<input id="action" name="action" type="hidden" value="" />
<input id="car_id" name="car_id" type="hidden" value="<%=StringUtil.deNull(carManageCarBean.getCar_id()) %>" />
</form>
<iframe name="hiddenFrame" width=0 height=0></iframe>
</body>
</html>
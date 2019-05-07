<%@page import="com.chinacreator.xtbg.pub.util.DaoImplClassUtil"%>
<%@page import="com.chinacreator.xtbg.yimingju.carmanage.dao.CarManageCarDao"%>
<%@page import="com.chinacreator.xtbg.yimingju.carmanage.service.impl.CarManageCarServiceImpl"%>
<%@page import="com.chinacreator.xtbg.yimingju.carmanage.service.CarManageCarServiceIfc"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.yimingju.carmanage.entity.CarManageCarBean" %>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	
	
	String car_num = request.getParameter("car_num");
	String buy_time = request.getParameter("buy_time");
	String car_brand = request.getParameter("car_brand");
	String car_type = request.getParameter("car_type");
	String color = request.getParameter("color");
	String buy_money = request.getParameter("buy_money");
	String card = request.getParameter("card");
	String fdj_num = request.getParameter("fdj_num");
	String driver = request.getParameter("driver");
	String driver_id = request.getParameter("driver_id");
	String remark = request.getParameter("remark");
	String car_id = request.getParameter("car_id");
	String attachment_id = request.getParameter("attachment_id");
	String unit_id = request.getParameter("unit_id");
	String unit_name = request.getParameter("unit_name");
	String action = request.getParameter("action");
	String viewdel = request.getParameter("viewdel"); // 判断是否是从查看界面进行删除
	CarManageCarBean cb= new CarManageCarBean();
	cb.setCar_num(car_num);
	cb.setUnit_id(unit_id);
	cb.setUnit_name(unit_name);
	cb.setBuy_time(buy_time);
	cb.setCar_brand(car_brand);
	cb.setCar_type(car_type);
	cb.setColor(color);
	cb.setBuy_money(buy_money);
	cb.setCard(card);
	cb.setFdj_num(fdj_num);
	cb.setDriver(driver);
	cb.setDriver_id(driver_id);
	cb.setRemark(remark);
	cb.setCar_id(car_id);
	cb.setCar_photoid(attachment_id);
	
	String flag = "";
	CarManageCarServiceIfc carManageCarServiceImpl = new CarManageCarServiceImpl();
	CarManageCarDao carManageCarDao = (CarManageCarDao)DaoImplClassUtil.getDaoImplClass("carManageCarDaoImplymj");
	if("save".equals(action)) {// 添加
		flag = carManageCarServiceImpl.saveCarManageCarInfo(cb);
	}else if("update".equals(action)){// 修改
		flag = carManageCarServiceImpl.updateCarManageCarInfo(cb);
	}else if("del".equals(action)){// 删除
		String carIds = request.getParameter("carIds");
		flag= carManageCarDao.delCarInfo(carIds);
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>车辆信息保存from</title>
</head>
<body>
<script type="text/javascript">
var mes = "<%=flag%>";
var bool = true;
var action = '<%=action%>';
var ok=function(){
	if(action == "del"){
		window.parent.location.reload();
	}else{
		window.parent.saveBack();//掉父页面的方法
	}
}
//removeAlertWindows = function(windowId,isClose,processVal,msg,isBreak,url)
if(window.top.removeAlertWindows('',false,bool,mes,true)){
	if(bool){
		window.top.alert(mes,{headerText:'提示',okName:'确认',okFunction:ok})
	}
	else{
		window.top.alert(mes)
	}
}
</script>
</body>
</html>
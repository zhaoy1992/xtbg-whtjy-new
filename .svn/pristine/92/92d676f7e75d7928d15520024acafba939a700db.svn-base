<%@page import="com.chinacreator.xtbg.core.common.util.RequestBeanUtils"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="com.chinacreator.xtbg.pub.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.yimingju.carmanage.entity.CarManageRefuelmanageBean"%>
<%@page import="com.chinacreator.xtbg.yimingju.carmanage.service.CarManageRefuelmanageServiceIfc"%>
<%@page import="com.chinacreator.xtbg.yimingju.carmanage.service.impl.CarManageRefuelmanageServiceImpl"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<head>
<title>加油管理处理页面</title>
<%
AccessControl accesscontroler = AccessControl.getAccessControl();
accesscontroler.checkAccess(request, response);
boolean flag = false;
String opt = StringUtil.deNull(request.getParameter("opt"));
CarManageRefuelmanageBean carManageRefuelmanageBean = new CarManageRefuelmanageBean();
CarManageRefuelmanageServiceIfc carManageRefuelmanageServiceIfc = new CarManageRefuelmanageServiceImpl();
if("add".equals(opt) || "upd".equals(opt)) {
	carManageRefuelmanageBean = (CarManageRefuelmanageBean)RequestBeanUtils.getValuesByRequest(request,carManageRefuelmanageBean);
	flag = carManageRefuelmanageServiceIfc.handleCarManageRefuelmanage(carManageRefuelmanageBean);
}else if("del".equals(opt)) {
	String id = request.getParameter("id");
	flag = carManageRefuelmanageServiceIfc.deleteCarManageRefuelmanage(id);
}
%>
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript">
var opt = "<%=opt%>";
if(<%=flag%>){ 
	var submitAlertOK = function(){
		if(opt == "del"){
			window.parent.location.reload();
		}else{
			parent.back();
		}
	}
	var p={
			headerText:'操作信息',
			okName:'确认',
			okFunction:submitAlertOK
	};
	alert('操作成功!',p);
}else{
	alert('操作失败!');
}
</script>
</head>
<body>
</body> 
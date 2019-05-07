<%@page import="com.chinacreator.xtbg.core.common.util.RequestBeanUtils"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="com.chinacreator.xtbg.pub.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.yimingju.carmanage.entity.CarManageViolationrecordBean"%>
<%@page import="com.chinacreator.xtbg.yimingju.carmanage.service.impl.CarManageViolationrecordServiceImpl"%>
<%@page import="com.chinacreator.xtbg.yimingju.carmanage.service.CarManageViolationrecordServiceIfc"%>
<head>
<title>加油管理处理页面</title>
<%
AccessControl accesscontroler = AccessControl.getAccessControl();
accesscontroler.checkAccess(request, response);
boolean flag = false;
String opt = StringUtil.deNull(request.getParameter("opt"));
CarManageViolationrecordBean carManageViolationrecordBean = new CarManageViolationrecordBean();
CarManageViolationrecordServiceIfc carManageViolationrecordServiceIfc = new CarManageViolationrecordServiceImpl();
if("add".equals(opt) || "upd".equals(opt)) {
	carManageViolationrecordBean = (CarManageViolationrecordBean)RequestBeanUtils.getValuesByRequest(request,carManageViolationrecordBean);
	flag = carManageViolationrecordServiceIfc.handleCarManageViolationrecord(carManageViolationrecordBean);
}else if("del".equals(opt)) {
	String id = request.getParameter("id");
	flag = carManageViolationrecordServiceIfc.deleteCarManageViolationrecord(id);
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
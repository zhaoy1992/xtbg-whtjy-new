<%@page import="com.chinacreator.xtbg.core.common.util.RequestBeanUtils"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="com.chinacreator.xtbg.pub.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.yimingju.carmanage.service.impl.CarManageMileagerecordServiceImpl"%>
<%@page import="com.chinacreator.xtbg.yimingju.carmanage.service.CarManageMileagerecordServiceIfc"%>
<%@page import="com.chinacreator.xtbg.yimingju.carmanage.entity.CarManageMileagerecordBean"%>
<head>
<title>加油管理处理页面</title>
<%
AccessControl accesscontroler = AccessControl.getAccessControl();
accesscontroler.checkAccess(request, response);
boolean flag = false;
String opt = StringUtil.deNull(request.getParameter("opt"));
CarManageMileagerecordBean carManageMileagerecordBean = new CarManageMileagerecordBean();
CarManageMileagerecordServiceIfc carManageMileagerecordServiceIfc = new CarManageMileagerecordServiceImpl();
if("add".equals(opt) || "upd".equals(opt)) {
	carManageMileagerecordBean = (CarManageMileagerecordBean)RequestBeanUtils.getValuesByRequest(request,carManageMileagerecordBean);
	flag = carManageMileagerecordServiceIfc.handleCarManageMileagerecord(carManageMileagerecordBean);
}else if("del".equals(opt)) {
	String id = request.getParameter("id");
	flag = carManageMileagerecordServiceIfc.deleteCarManageMileagerecord(id);
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
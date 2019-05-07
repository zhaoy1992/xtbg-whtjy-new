<%@page import="com.chinacreator.xtbg.yimingju.carmanage.service.impl.CarManageApplyinfoServiceImpl"%>
<%@page import="com.chinacreator.xtbg.yimingju.carmanage.service.CarManageApplyinfoServiceIfc"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>已派车是否派车结束form</title>
</head>
<% 
	String path = request.getContextPath();
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	String subid = request.getParameter("subid");
	String ypcInfo = request.getParameter("ypcInfo");
	
	CarManageApplyinfoServiceIfc carManageApplyinfoServiceIfc = new CarManageApplyinfoServiceImpl();
	
	boolean flag = false;
	
	try{
		flag = carManageApplyinfoServiceIfc.updateCarManageApplyPcEndStateByApplyID(ypcInfo);
	}catch(Exception e){
		e.printStackTrace();
		flag = false;
	}
%>
<body>
<script type="text/javascript">
var mes = "";
var bool = true;
if(<%=flag%>){
	mes = "操作成功";
}else{
	mes = "操作失败"	;
	bool = false;
}

var OKF = function(){
	if(window.top.removeWindows('',true)){
		 window.parent.back();//掉父页面的方法 
	}
}
window.top.alert(mes,{headerText:'提示',okName:'确认',okFunction:OKF});


</script>
</body>
</html>
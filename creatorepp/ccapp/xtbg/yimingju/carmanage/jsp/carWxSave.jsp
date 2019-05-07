<%@page import="com.chinacreator.xtbg.pub.util.DaoImplClassUtil"%>

<%@page import=" com.chinacreator.xtbg.yimingju.carmanage.service.impl.CarManageWxByServiceImpl"%>
<%@page import=" com.chinacreator.xtbg.yimingju.carmanage.service.CarManageWxByServiceIfc"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	String baseinfoJson = request.getParameter("baseinfoJson");
	String action = request.getParameter("action");
	String viewdel = request.getParameter("viewdel"); // 判断是否是从查看界面进行删除
	boolean flag = false;
	CarManageWxByServiceIfc service = new CarManageWxByServiceImpl();
	if("add".equals(action)) {// 添加
		flag = service.saveCarWxInfo(baseinfoJson);
	}else if("update".equals(action)){// 修改
		//flag = carManageCarServiceImpl.updateCarManageCarInfo(baseinfoJson);
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>车辆维修信息保存from</title>
</head>
<body>
<script type="text/javascript">
var mes = "";
var action = '<%=action%>';
var viewdel = '<%=viewdel%>';
var bool = true;
if(<%=flag%>){
	mes = "操作成功";
}else{
	mes = "操作失败"	;
	bool = false;
}

var OKF = function(){
	if(window.top.removeWindows('',true)){
		if(action == "del" && viewdel != "viewdel"){
			window.parent.location.reload();
		}else{
			window.parent.saveBack();//掉父页面的方法
		}
	}
}
window.top.alert(mes,{headerText:'提示',okName:'确认',okFunction:OKF});
</script>
</body>
</html>
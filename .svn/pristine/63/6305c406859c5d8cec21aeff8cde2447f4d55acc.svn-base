<%@page import="com.chinacreator.security.AccessControl"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="com.chinacreator.xtbg.pub.personwork.service.PersonInfoServiceIfc"%>
<%@page import="com.chinacreator.xtbg.pub.personwork.service.impl.PersonInfoServiceImpl"%><html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<link href="../../../resources/plug/ifrom/css/ifrom-ui-core.css" rel="stylesheet" type="text/css" />
<link href="../../../resources/css/layer.css" rel="stylesheet" type="text/css" />
<link href="../../../resources/css/style.css" rel="stylesheet" type="text/css" />	

<script type="text/javascript"src="../../../resources/plug/ifrom/js/ifrom-ui-tree.1.1.js"charset="utf-8"></script>
<script type="text/javascript"src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js"></script>
<script type="text/javascript"src="../../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript"src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<title>保存人员分组信息form</title>
<%
AccessControl accesscontroler = AccessControl.getInstance();
accesscontroler.checkAccess(request, response);
	String personids = request.getParameter("personids");
	String groupids = request.getParameter("groupshowids");
	boolean flag = true;
	
	try{
		PersonInfoServiceIfc personInfoService = new PersonInfoServiceImpl();
		personInfoService.savePersonGroupInfo(personids,groupids);
	}catch(Exception e){
		flag = false;
	}
%>
</head>
<body>
<script type="text/javascript">
var mes = "";
var bool = true;
if(<%=flag%>){
	mes = "操作成功";
	//parent.refreshGrid4WfactionInfo();
	//alert();
	//getParentWindow('windowId').refreshGrid4WfactionInfo();
	//alert(mes);
	//removeAlertWindows('windowId',true);
	
	bool = true;
}else{
	mes = "操作失败"	;
	bool = false;

}
var ok=function(){
	window.parent.location.reload();
}
//removeAlertWindows = function(windowId,isClose,processVal,msg,isBreak,url)
if(window.top.removeAlertWindows('',false,bool,mes,true)){
	if(bool){
		window.top.alert(mes,{headerText:'处理结果',okName:'确认',okFunction:ok})
	}
	else{
		window.top.alert(mes)
	}
}
</script>
</body>
</html>
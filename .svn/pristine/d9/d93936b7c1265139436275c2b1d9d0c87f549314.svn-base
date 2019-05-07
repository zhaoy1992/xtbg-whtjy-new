<%@page import="com.chinacreator.security.AccessControl"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%
    AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
    %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="com.chinacreator.xtbg.pub.flowinfoconif.service.FlowInfoConfigServiceIfc"%>
<%@page import="com.chinacreator.xtbg.pub.flowinfoconif.service.impl.FlowInfoConfigServiceImpl"%><html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>环节基本信息保存form</title>
<%
	String jsonparam = request.getParameter("jsonparam");
	boolean flag = true;
	FlowInfoConfigServiceIfc flowInfoConfigService = new FlowInfoConfigServiceImpl();
	try{
		flowInfoConfigService.saveFlowWfactionInfo(jsonparam);
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
}else{
	mes = "操作失败"	;
	bool = false;
}
var ok=function(){
	window.parent.location.reload();
}
if(window.top.removeAlertWindows('',false,bool,mes,true)){
	if(bool){
		window.top.alert(mes,{headerText:'处理结果',okName:'确认',okFunction:ok})
	}
	else{
		window.top.alert(mes)
	}
}
//window.parent.JqueryDialog.SubmitCompleted(mes, true, bool);
</script>
</body>
</html>
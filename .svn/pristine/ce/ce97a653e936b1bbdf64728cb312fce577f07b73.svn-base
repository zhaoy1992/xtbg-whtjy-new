<%@page import="com.chinacreator.xtbg.core.process.processconfig.service.impl.FlowInfoConfigServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.process.processconfig.service.FlowInfoConfigServiceIfc"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>删除流程定义相关信息</title>
<%
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	String defids = request.getParameter("defids");
	boolean flag = false;
	String erroMsg = "";
	FlowInfoConfigServiceIfc service=new FlowInfoConfigServiceImpl();
	boolean flag1 = service.checkFlowDefHasIns(defids);
	if(flag1){
		flag = false;
		erroMsg ="该流程配置，存在流程实例，不能删除！";
	}else{
		flag=service.deleteFlowDefInfo(defids);
	}
	
%>
</head>
<body>
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript">
var mes = "";
var bool = true;
if(<%=flag%>){
	mes = "操作成功";
	window.parent.refreshGrid4FlowInfo();
}else{
	mes = "操作失败"	;
	if(<%=flag1%>){
		mes = "<%=erroMsg%>";
	}
	bool = false;
}
alert(mes);
//window.parent.JqueryDialog.SubmitCompleted(mes, true, bool);
</script>
</body>
</html>
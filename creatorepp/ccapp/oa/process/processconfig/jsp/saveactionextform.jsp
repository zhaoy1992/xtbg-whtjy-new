<%@page import="com.chinacreator.security.AccessControl"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">


<%@page import="com.chinacreator.xtbg.core.process.processconfig.service.FlowInfoConfigServiceIfc"%>
<%@page import="com.chinacreator.xtbg.core.process.processconfig.service.impl.FlowInfoConfigServiceImpl"%><html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>环节扩展信息保存form</title>
<%
AccessControl accesscontroler = AccessControl.getAccessControl();
accesscontroler.checkAccess(request, response);
	String jsonparam = request.getParameter("jsonparam");
	boolean flag = true;
	FlowInfoConfigServiceIfc flowInfoConfigService = new FlowInfoConfigServiceImpl();
	try{
		flowInfoConfigService.saveFlowWfactionExtInfo(jsonparam);
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
	mes = "操作失败";
	bool = false;
}
var ok=function(){
	//window.parent.location.reload();
}
	if(bool){
		window.top.alert(mes,{headerText:'处理结果',okName:'确认',okFunction:ok})
	}
	else{
		window.top.alert(mes)
	}

//window.parent.JqueryDialog.SubmitCompleted(mes, true, bool);
</script>
</body>
</html>
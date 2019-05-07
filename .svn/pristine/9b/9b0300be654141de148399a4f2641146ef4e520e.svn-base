<%@page import="com.chinacreator.security.AccessControl"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.chinacreator.xtbg.pub.flowinfoconif.dao.FlowInfoDao"%>
<%@page import="com.chinacreator.xtbg.pub.util.DaoImplClassUtil"%><html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>删除环节表单配置信息form</title>
<%
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	String flowids =  request.getParameter("flowids");
	String fIds[]=flowids.split("[\\,,\\，]");
	//boolean flag = true;
	String flag ="";
	FlowInfoDao flowInfodao = (FlowInfoDao)DaoImplClassUtil.getDaoImplClass("flowInfoDaoImpl");
	try{
		flag = flowInfodao.deleteFlowBaseInfoById(flowids);
	}catch(Exception e){
		flag = "false";
	}
%>
</head>
<body>
<script type="text/javascript">
var mes = "";
var bool = true;
debugger;
if("<%=flag%>" == "true"){
	mes = "操作成功"; 
}else{
	if("<%=flag%>" == "false"){
		mes = "已绑定流程不能删除";
		bool = false;
	}else{
		mes = "操作失败";
		bool = false;
	}
}
window.parent.JqueryDialog.SubmitCompleted(mes, true, bool);
</script>
</body>
</html>
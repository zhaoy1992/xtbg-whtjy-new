<%--
描述：删除个人通讯录人员信息
姓名：戴连春
日期：2013-06-13
 --%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page language="java" contentType="text/html; charset=utf-8"	pageEncoding="utf-8"%>
<%@page	import="com.chinacreator.xtbg.core.personwork.service.PersonInfoServiceIfc"%>
<%@page	import="com.chinacreator.xtbg.core.personwork.service.impl.PersonInfoServiceImpl"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>删除人员信息form</title>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	String userId = request.getParameter("userid");
	String personIds = request.getParameter("personids");
	String directoryIds = request.getParameter("directoryids");

	//删除用户
	PersonInfoServiceIfc service = new PersonInfoServiceImpl();
	boolean flag = service.deletePersonInfo(personIds,userId,
			directoryIds);
%>
</head>
<body>
<script type="text/javascript">
var mes = "";
var bool = true;
var flag = <%=flag%>;
if(flag){
	mes = "操作成功";
	parent.refreshGrid4WfactionInfo();
	bool = false;
}else{
	mes = "操作失败"	;
	bool = false;
}
window.parent.alert(mes);
</script>
</body>
</html>
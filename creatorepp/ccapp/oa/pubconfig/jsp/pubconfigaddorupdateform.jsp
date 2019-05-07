<%-- 
描述：业务类型处理界面
作者：肖杰
版本：1.0
日期：2013-07-30
 --%>
<%@page import="com.chinacreator.xtbg.core.pubconfig.service.impl.FormBusitypeServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.pubconfig.service.FormBusitypeServiceIfc"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">


<%@page import="java.sql.SQLException"%>
<%@page import="com.chinacreator.xtbg.core.common.util.*"%>
<%@page import="com.chinacreator.xtbg.core.process.processconfig.service.FlowInfoConfigServiceIfc"%>
<%@page import="com.chinacreator.xtbg.core.process.processconfig.service.impl.FlowInfoConfigServiceImpl"%><html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<%
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	String jsonparam = request.getParameter("jsonparam");
	String busitype_code=StringUtil.deNull(request.getParameter("busitype_code"));

	boolean flag = true;
	FormBusitypeServiceIfc formBusitypeServiceIfc=new FormBusitypeServiceImpl();
	try{
		flag = formBusitypeServiceIfc.saveFormBusitypeInfo(jsonparam);
	}catch(Exception e){
		flag = false;
	}
	String openwindid = request.getParameter("openwindid");
%>
</head>
<body>
<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript">
var mes = "";
var bool = true;
if(<%=flag%>){
	mes = "操作成功"; 
	bool = false;
	  var submitAlertOK = function(){
		  if(""=='<%=busitype_code%>'){
			  parent.saveBack();
		  }else{
		  	window.parent.location.reload();
		  }
	  }
		var p={
			headerText:'处理结果',
				okName:'确认',
		        okFunction:submitAlertOK
		};
		alert('操作成功！',p);
}else{
	mes = "操作失败"	;
	bool = false;
	alert(mes);
}
//window.parent.JqueryDialog.SubmitCompleted(mes, true, bool);
</script>
</body>
</html>
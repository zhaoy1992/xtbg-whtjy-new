<%@page import="com.chinacreator.security.AccessControl"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="com.chinacreator.xtbg.pub.flowinfoconif.service.FlowInfoConfigServiceIfc"%>
<%@page import="com.chinacreator.xtbg.pub.flowinfoconif.service.impl.FlowInfoConfigServiceImpl"%>
<%@page import="java.sql.SQLException"%><html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<%
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	String jsonparam = request.getParameter("jsonparam");
	boolean flag = true;
	String flow_id = "";
	FlowInfoConfigServiceIfc flowInfoConfigService = new FlowInfoConfigServiceImpl();
	try{
		flow_id = flowInfoConfigService.saveFlowConfigInfo(jsonparam);
	}catch(Exception e){
		flag = false;
	}
	String openwindid = request.getParameter("openwindid");
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
	parent.setFlowIdAfterSave('<%=flow_id%>');
	bool = false;
	//parent.showcflow();
	  var submitAlertOK = function(){
		  if(removeWindows('<%=openwindid%>',true,false,true)){
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
}
//window.parent.JqueryDialog.SubmitCompleted(mes, true, bool);
</script>
</body>
</html>
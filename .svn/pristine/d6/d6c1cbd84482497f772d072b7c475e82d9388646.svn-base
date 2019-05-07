<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="com.chinacreator.xtbg.core.file.service.impl.FileDestroyServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.file.service.FileDestroyService"%>
<%@page import="com.chinacreator.xtbg.core.common.util.RequestBeanUtils"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="java.util.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page contentType="text/html; charset=utf-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<head>
<title>借阅处理页面</title>
<%
AccessControl accesscontroler = AccessControl.getAccessControl();
accesscontroler.checkAccess(request, response);

String F_USER_NAME = accesscontroler.getUserName();
boolean flag = false;
String subid=request.getParameter("subid");
String action = request.getParameter("action");
String f_destroy_id = request.getParameter("f_destroy_id");
FileDestroyService Service = new FileDestroyServiceImpl();
if(action.equals("del")){
	flag = Service.stopFileDestroy(f_destroy_id);
}
%>
<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript">
var mes = "";
var bool = true;
var action = "<%=action%>";
if(<%=flag%>){
	bool = false;
		mes = "操作成功"; 
		var submitAlertOK = function(){
	
			if(action == "del"){
				window.parent.location.reload();
			}else{
				window.parent.location.href="fileborrowtabs.jsp?index=2";
			}
		}
		var p={
				headerText:'操作信息',
				okName:'确认',
		        okFunction:submitAlertOK
		};
		alert('操作成功!',p);
}else{
	mes = "操作失败"	;
	bool = false;
}
</script>
</head>
</body> 
</html>
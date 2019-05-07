<%@page import="com.chinacreator.xtbg.wangcheng.virtualappmanager.service.impl.AppStoreServiceImpl"%>
<%@page import="com.chinacreator.xtbg.wangcheng.virtualappmanager.service.AppStoreServiceIfc"%>
<%@ page contentType="text/html; charset=utf-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>

<!-- 引入其它 -->
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<title>JGRID</title>

<%
	String paramjosn = request.getParameter("paramjosn");
	String action = request.getParameter("action");
	AppStoreServiceIfc  service = new AppStoreServiceImpl();
	boolean flag = false;
	if("add".equals(action)) {
		flag = service.saveAppStore(paramjosn);
	} else if("update".equals(action)){
		flag = service.updateAppStore(paramjosn);
	} else if("del".equals(action)) {
		String appIds = request.getParameter("appIds");
		flag = service.delAppStore(appIds);
	}
%>
<script type="text/javascript">
var mes = "";
if(<%=flag%>){
	mes = "操作成功";
	alert(mes);
	parent.location.href="../../../wangcheng/virtualappmanager/jsp/appstorelist.jsp";
}else{
	mes = "操作失败"	;
	alert(mes); 
}
</script>
<body>
</body> 
</html>
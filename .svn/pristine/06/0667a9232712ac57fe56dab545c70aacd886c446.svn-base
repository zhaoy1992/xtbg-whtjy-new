<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.zhangjiajie.inforeported.service.impl.InfoTypeServiceImpl"%>
<%@page import="com.chinacreator.xtbg.zhangjiajie.inforeported.service.InfoTypeServiceIfc"%>
<%@ page contentType="text/html; charset=GBK"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<title>信息类型操作页面</title>
<%
AccessControl accesscontroler = AccessControl.getInstance();
accesscontroler.checkAccess(request, response);
	String paramjosn = request.getParameter("paramjosn");
	String action = request.getParameter("action");
	InfoTypeServiceIfc  infoTypeServiceIfc = new InfoTypeServiceImpl();
	boolean flag = false;
	if("add".equals(action)) {
		flag = infoTypeServiceIfc.saveInfoType(paramjosn);
	} else if("update".equals(action)){
		flag = infoTypeServiceIfc.updateInfoType(paramjosn);
	} else if("del".equals(action)) {
		String infotype_ids = request.getParameter("infotype_ids");
		flag = infoTypeServiceIfc.delInfoType(infotype_ids);
	}
%>
<script type="text/javascript">
var mes = "";
var bool = true;
if(<%=flag%>){
	mes = "操作成功"; 
}else{
	mes = "关联数据,操作失败"	;
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
</script>
<body>
</body> 
</html>
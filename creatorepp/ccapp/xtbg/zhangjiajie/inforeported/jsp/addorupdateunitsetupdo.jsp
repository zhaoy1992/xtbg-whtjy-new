<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.zhangjiajie.inforeported.service.impl.UnitsetupServiceImpl"%>
<%@page import="com.chinacreator.xtbg.zhangjiajie.inforeported.service.UnitsetupServiceIfc"%>
<%@ page contentType="text/html; charset=GBK"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<title>上报单位操作页面</title>

<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	String paramjosn = request.getParameter("paramjosn");
	String action = request.getParameter("action");
	UnitsetupServiceIfc unitsetupServiceIfc = new UnitsetupServiceImpl();
	boolean flag = false;
	if("add".equals(action)) {
		flag = unitsetupServiceIfc.saveUnitsetup(paramjosn);
	} else if("update".equals(action)){
		flag = unitsetupServiceIfc.updateUnitsetup(paramjosn);
	} else if("del".equals(action)) {
		String unitsetup_ids = request.getParameter("unitsetup_ids");
		flag = unitsetupServiceIfc.delUnitsetup(unitsetup_ids);
	}

%>
<script type="text/javascript">
var mes = "";
var bool = true;
if(<%=flag%>){
	mes = "操作成功"; 
}else{
	mes = "操作失败"	;
	bool = false;
}
window.parent.JqueryDialog.SubmitCompleted(mes, true, bool);
</script>
<body>
</body> 
</html>
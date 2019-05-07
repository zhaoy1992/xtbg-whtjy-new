<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.zhangjiajie.inforeported.service.impl.ReleaseunitServiceImpl"%>
<%@page import="com.chinacreator.xtbg.zhangjiajie.inforeported.service.ReleaseunitServiceIfc"%>
<%@ page contentType="text/html; charset=GBK"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<title>发布栏目操作页面</title>

<%
AccessControl accesscontroler = AccessControl.getInstance();
accesscontroler.checkAccess(request, response);

	String paramjosn = request.getParameter("paramjosn");
	String action = request.getParameter("action");
	ReleaseunitServiceIfc releaseunitServiceIfc = new ReleaseunitServiceImpl();
	boolean flag = false;
	if("add".equals(action)) {
		flag = releaseunitServiceIfc.saveReleaseunit(paramjosn);
	} else if("update".equals(action)){
		flag = releaseunitServiceIfc.updateReleaseunit(paramjosn);
	} else if("del".equals(action)) {
		String releaseunit_ids = request.getParameter("releaseunit_ids");
		flag = releaseunitServiceIfc.delReleaseunit(releaseunit_ids);
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
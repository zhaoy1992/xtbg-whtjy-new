<%@page import="com.chinacreator.xtbg.wangcheng.virtualappmanager.service.impl.AppPermissionServiceImpl"%>
<%@page import="com.chinacreator.xtbg.wangcheng.virtualappmanager.service.AppPermissionServiceIfc"%>
<%@ page contentType="text/html; charset=utf-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<title>JGRID</title>

<%

	String action = request.getParameter("action");
	String orgid = request.getParameter("orgid");
	String orgname = request.getParameter("orgname");
    AppPermissionServiceIfc  service = new AppPermissionServiceImpl();
	boolean flag = false;
	if("fp".equals(action)) {//分配应用
		String appIds = request.getParameter("appIds");
		flag = service.saveAppPermission(appIds,orgid,orgname);
	} else if("del".equals(action)) {//取消已分配的应用
		String pids = request.getParameter("pids");
		flag = service.delAppPermission(pids,orgid);
	}

%>
<script type="text/javascript">
var orgid = '<%=orgid%>';
var orgname = '<%=orgname%>';
var mes = "";
//var bool = true;
if(<%=flag%>){
	//mes = "操作成功"; 
	parent.location.href="../../../wangcheng/virtualappmanager/jsp/apppermissioncontrol.jsp?orgid="+orgid+"&orgname="+encodeURI(encodeURI(orgname));
}else{
	mes = "操作失败"	;
	//bool = false;
}

//window.parent.JqueryDialog.SubmitCompleted(mes, true, bool);
</script>
<body>

</body> 
</html>
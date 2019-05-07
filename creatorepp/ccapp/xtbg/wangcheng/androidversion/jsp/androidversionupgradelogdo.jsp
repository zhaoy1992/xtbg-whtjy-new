
<%@page import="com.chinacreator.pcbase.common.Constant"%>
<%@page import="java.io.File"%>
<%@ page contentType="text/html; charset=utf-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<title>JGRID</title>
<%
	boolean flag = false;
	String islog = request.getParameter("islog");
 	try{
 		Constant.ISSAVEVERSIONLOG = Boolean.parseBoolean(islog); //重新设置并刷新控制
 		flag = true;
 	}catch(Exception e){
 		flag = false;
 	}

	
%>
<script type="text/javascript">
var mes = "";
var bool = true;
if(<%=flag%>){
	mes = "操作成功"; 
	parent.dealupgradelogshow();
}else{
	mes = "操作失败"	;
	bool = false;
}
window.parent.JqueryDialog.SubmitCompleted(mes, true, bool);
</script>
<body>
</body> 
</html>
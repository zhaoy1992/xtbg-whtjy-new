<%@page import="com.chinacreator.xtbg.pub.util.StringUtil"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.pub.directory.service.impl.DirectoryServiceImpl"%>
<%@page import="com.chinacreator.xtbg.pub.directory.service.DirectoryServiceIfc"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>"> 
<title>JGRID</title>

<%

	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	String paramjosn = request.getParameter("paramjosn");
	String action = request.getParameter("action");
	String widowsid = request.getParameter("widowsid");
	DirectoryServiceIfc  instanceServiceIfc = new DirectoryServiceImpl();
	String orgid = request.getParameter("orgid");
	boolean flag = false;
	String new_directory_id = "";
	if("add".equals(action)) {
		new_directory_id = instanceServiceIfc.saveType(paramjosn);
		if(!StringUtil.nullOrBlank(new_directory_id)){
			flag = true;
		}
	} else if("update".equals(action)){
		flag = instanceServiceIfc.updateType(paramjosn);
	} else if("del".equals(action)) {
		String userIds = request.getParameter("userIds");
		flag = instanceServiceIfc.delType(userIds);
	}

%>
<script type="text/javascript">
<%-- var action = "<%=action%>";
var mes = "";
var bool = true;
var url = "directoryMain.jsp?orgid=<%=orgid%>";
var url = "directorylist.jsp?orgid=<%=orgid%>";
if(<%=flag%>){
	mes = "操作成功"; 
}else{
	mes = "操作失败"	;
	bool = false;
}
var ok=function(){
	/* window.parent.location.reload(); */
	window.parent.location.href = url;
}
if(window.top.removeAlertWindows('<%=StringUtil.deNull(request.getParameter("widowsid"))%>',false,bool,mes,true)){
	if(bool){
		window.top.alert(mes,{headerText:'处理结果',okName:'确认',okFunction:ok})
	}
	else{
		window.top.alert(mes)
	} 
} 
  var OKF = function(){
		if(window.top.removeWindows('<%=StringUtil.deNull(request.getParameter("widowsid"))%>',true)){
			if(action == "del"){
				window.parent.location.reload();
			}else{
				location.href = url;
			}
		}
	}
	window.top.alert(mes,{headerText:'提示',okName:'确认',okFunction:OKF}); --%>
	
	var action = "<%=action%>";
	var mes = "";
	var bool = true;
	if(<%=flag%>){
		mes = "操作成功";
	}else{
		mes = "操作失败"	;
		bool = false;
	}

	var OKF = function(){
		if(window.top.removeWindows('',true)){
			
			if(action == "del"){
				window.parent.location.reload();
			}else if(action == "add"){
				//window.parent.document.getElementById("directoryid").value = "<%=new_directory_id%>";
				//window.parent.saveBack();
				window.parent.resetform();
			}
		}
		
	}
	window.top.alert(mes,{headerText:'提示',okName:'确认',okFunction:OKF});

</script>
<body>
</body> 
</html>
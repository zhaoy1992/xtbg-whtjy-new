<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.pub.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.pub.agency.entity.AgencyBean"%>
<%@page import="com.chinacreator.xtbg.pub.agency.service.impl.AgencyServiceImpl"%>
<%@page import="com.chinacreator.xtbg.pub.agency.service.AgencyService"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<title>JGRID</title>

<%
AccessControl accesscontroler = AccessControl.getInstance();
accesscontroler.checkAccess(request, response);
	String paramjosn = request.getParameter("paramjosn");
	String action = request.getParameter("action");
	AgencyService service = new AgencyServiceImpl();
	String flag = "";
	boolean addNameflag = false;
	if("add".equals(action)) {
			flag = service.setAgencyByName(paramjosn);
	} else if("update".equals(action)){
			flag = service.updateAgencyBeanById(paramjosn);
	} else if("del".equals(action)) {
			String ids = request.getParameter("work_ids");
			flag = service.delAgencyById(ids);
	}
	
 %>
<script type="text/javascript">
var mes = "";
var bool = true;
if('<%=flag%>' == 'flag'){
	 mes = "操作成功！";	
} else if('<%=flag%>' == 'flag1'){
  	mes = "当前用户在该时间段已经设置了代理";
	// bool = false;
}else if('<%=flag%>' == 'flag2'){
	mes = "当前用户已是代理人,不能再设置成代理！";
	 //bool = false;
}else{
	mes = '<%=flag%>'+":用户已是委托人,不能再设置为代理人";
}
var ok = function(){
	window.parent.location.reload();
}

if(window.top.removeAlertWindows('<%=StringUtil.deNull(request.getParameter("windowsId"))%>',false,bool,mes,true)){
	if(bool){
		window.top.alert(mes,{headerText:'处理结果',okName:'确认',okFunction:ok});
	}
	else{
		window.top.alert(mes)
	}
}
</script>
<body>
</body> 
</html>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.pub.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.yimingju.officeassets.service.impl.OfficeConsumeServiceImpl"%>
<%@page import="com.chinacreator.xtbg.yimingju.officeassets.service.OfficeConsumeServiceIfc"%>
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
 	OfficeConsumeServiceIfc  typeServiceIfc = new OfficeConsumeServiceImpl();
	boolean flag = false;
	boolean addNameflag = false;
	if("add".equals(action)) {
		addNameflag  = typeServiceIfc.queryConByTypeName(paramjosn);
		if (addNameflag ==false ){
			flag = typeServiceIfc.saveOe(paramjosn);
		}
	} else if("update".equals(action)){
			flag = typeServiceIfc.updateOe(paramjosn);
	} else if("del".equals(action)) {
		String ids = request.getParameter("userIds");
		//查找易耗品库存信息
		boolean conflag = typeServiceIfc.findConByTypeId(ids);
		if(conflag == false){
			flag = typeServiceIfc.delOe(ids);
		}
	}
	
%>
<script type="text/javascript">
var mes = "";
var bool = true;
if(<%=addNameflag%>){
	mes = "类别名称已经存在！";
} else {
	if(<%=flag%>){
		 mes = "操作成功";	
	} else {
  		//mes = "已存在子数据,请删除子数据信息！";
  		mes = "该类别已被使用，不能被删除！";
	 	bool = false;
	}
}
var ok=function(){
	window.parent.location.reload();
}
if(window.top.removeAlertWindows('<%=StringUtil.deNull(request.getParameter("windowsId"))%>',false,bool,mes,true)){
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
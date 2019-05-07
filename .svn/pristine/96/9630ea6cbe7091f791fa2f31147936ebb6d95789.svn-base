
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.pub.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.yimingju.officeassets.service.impl.OfficeEquipmentTypeServiceImpl"%>
<%@page import="com.chinacreator.xtbg.yimingju.officeassets.service.OfficeEquipmentTypeServiceIfc"%>
<%@ page contentType="text/html; charset=GBK"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<title>JGRID</title>

<%
AccessControl accesscontroler = AccessControl.getInstance();
accesscontroler.checkAccess(request, response);
	String paramjosn = request.getParameter("paramjosn");
	String action = request.getParameter("action");
	
	boolean flag = false;
	boolean flagEq = false;
	boolean addNameFlag = false;
	try{
		OfficeEquipmentTypeServiceIfc  typeServiceIfc = new OfficeEquipmentTypeServiceImpl();
		if("add".equals(action)) {
			addNameFlag = typeServiceIfc.queryOfficeByTypeName(paramjosn);
			if(addNameFlag == false ){
				flag = typeServiceIfc.saveOe(paramjosn);
			}
		} else if("update".equals(action)){
				flag = typeServiceIfc.updateOe(paramjosn);
		} else if("del".equals(action)) {
			String ids = request.getParameter("userIds2");
			//查询关联的库存
			flagEq = typeServiceIfc.findOfficeByTypeid(ids);
			if(flagEq== false){
				flag = typeServiceIfc.delOe(ids);
			}
		}
	}catch(Exception e){
		e.printStackTrace();
		flag=false;
	}
	
%>
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script type="text/javascript"
			src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript">
var mes = "";
var bool = true;
if(<%=addNameFlag%>){
	mes = "类别名称已经存在！";
} else {
	if(<%=flag%>){
		mes = "操作成功"; 
	}else{
		if (<%=addNameFlag%>){
			mes = "类别名称已经存在！";
		} else {
			mes ="该类别已被使用，不能被删除！";
			//mes = "已存在子数据,请删除子数据信息！";
		}
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
		window.top.alert(mes);
	}
}
</script>
<body>
</body> 
</html>
<%--
描述：外部子系统基本信息与后端的交互页面
作者：夏天
版本：1.0
日期：2013-4-28
--%>


<%@ page contentType="text/html; charset=GBK"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">



<%@page import="com.chinacreator.security.AccessControl"%>

<%@page import="com.chinacreator.xtbg.pub.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.pub.util.RequestBeanUtils"%>


<%@page import="com.chinacreator.xtbg.pub.subSystemManage.service.impl.SubSystemServiceImpl"%>
<%@page import="com.chinacreator.xtbg.pub.subSystemManage.service.SubSystemServiceIfc"%>
<%@page import="com.chinacreator.xtbg.pub.subSystemManage.entity.SubsysManageBean"%><html>
<head>
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<title>外部子系统基本信息与后端的交互页面</title>
<%
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	SubsysManageBean subsysManageBean = new SubsysManageBean();
	
	subsysManageBean = (SubsysManageBean)RequestBeanUtils.getValuesByRequest(request,subsysManageBean);
	String sys_id = subsysManageBean.getSys_id();
	
	
	String action = request.getParameter("action_now");
	SubSystemServiceIfc subSystemServiceIfc = new SubSystemServiceImpl();
	
	boolean flag = false;
	String flag1 ="";

	if("save".equals(action)) {
		flag = subSystemServiceIfc.saveSubSystemManage(subsysManageBean);
	}  else if("del".equals(action)) {
		flag = subSystemServiceIfc.deleteSubSystemManage(sys_id);
	}
	

%>
<script type="text/javascript">
var mes = "";
var bool = true;
if(<%=flag%>){
	mes = "操作成功";
	bool = false;
	var submitAlertOK = function(){
		var obj = {action:'<%=action%>'}
		parent.sucessBackFun(obj);
	}
	var p={
			headerText:'操作信息',
			okName:'确认',
	        okFunction:submitAlertOK
	};
	alert("操作成功！",p);
	
}else {
	mes = "操作失败";
	bool = false;
	alert("操作失败！",p);
}


//window.parent.JqueryDialog.SubmitCompleted(mes, true, bool);
</script>
</head>
<body>
</body> 
</html>
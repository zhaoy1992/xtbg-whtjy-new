<%--
描述：外部子系统基本信息与后端的交互页面
作者：夏天
版本：1.0
日期：2013-4-28
--%>


<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">



<%@page import="com.chinacreator.security.AccessControl"%>

<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.core.common.util.RequestBeanUtils"%>


<%@page import="com.chinacreator.xtbg.core.subsystemmanage.service.impl.SubSystemServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.subsystemmanage.service.SubSystemServiceIfc"%>
<%@page import="com.chinacreator.xtbg.core.subsystemmanage.entity.SubsysManageBean"%>
<%@page import="com.chinacreator.xtbg.core.subsystemmanage.entity.SubsysUseInfoBean"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%><html>
<head>
<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<title>外部子系统基本信息与后端的交互页面</title>
<%
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	SubsysUseInfoBean subsysUseInfoBean = new SubsysUseInfoBean();
	subsysUseInfoBean = (SubsysUseInfoBean)RequestBeanUtils.getValuesByRequest(request,subsysUseInfoBean);
	String info_id = subsysUseInfoBean.getInfo_id();
	
	
	String action = request.getParameter("action_now");
	SubSystemServiceIfc subSystemServiceIfc = new SubSystemServiceImpl();
	Map<String,Object> resultMap = new HashMap<String,Object>();
	boolean flag = false;
	String flag1 ="操作失败";

	if("save".equals(action)) {
		resultMap = subSystemServiceIfc.saveSubSystemUseInfo(subsysUseInfoBean);
		flag = (Boolean)resultMap.get("isSucess");
		flag1 = (String)resultMap.get("resultStr");
	}  else if("del".equals(action)) {
		flag = subSystemServiceIfc.deleteSubSystemUseInfo(info_id);
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
	mes = "<%=flag1%>";
	bool = false;
	alert("<%=flag1%>",p);
}


//window.parent.JqueryDialog.SubmitCompleted(mes, true, bool);
</script>
</head>
<body>
</body> 
</html>
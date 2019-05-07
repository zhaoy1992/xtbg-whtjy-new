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
<%@page import="java.util.Map"%>
<%@page import="com.chinacreator.xtbg.core.subsystemmanage.entity.OaGwcsConfigBean"%>
<html>
<head>
<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<title>外部子系统基本信息与后端的交互页面</title>
<%
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	
	String action = request.getParameter("action_now");
	SubSystemServiceIfc subSystemServiceIfc = new SubSystemServiceImpl();
	OaGwcsConfigBean oaGwcsConfigBean  = new OaGwcsConfigBean();
	oaGwcsConfigBean = (OaGwcsConfigBean)RequestBeanUtils.getValuesByRequest(request,oaGwcsConfigBean);
	
	boolean flag = false;
	String flag1 ="";

	if("saveOrgConfig".equals(action)) {
		Map<String,Object> resultMap = subSystemServiceIfc.saveOaGwcsConfigInfo(oaGwcsConfigBean);
		flag = Boolean.valueOf(resultMap.get("isSucess").toString());
	}if("delconfig".equals(action)){
		String ids = StringUtil.deNull(request.getParameter("ids"));
		flag = subSystemServiceIfc.delOrgConfig(ids);
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
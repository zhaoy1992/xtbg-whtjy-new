<%@page import="com.chinacreator.security.AccessControl"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="com.chinacreator.xtbg.pub.flowinfoconif.service.FlowInfoConfigServiceIfc"%>
<%@page import="com.chinacreator.xtbg.pub.flowinfoconif.service.impl.FlowInfoConfigServiceImpl"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.chinacreator.xtbg.pub.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.pub.util.DataControlUtil"%>
<%@page import="com.chinacreator.xtbg.pub.flowinfoconif.entity.FlowDefInfoBean"%>
<%@page import="com.alibaba.fastjson.JSONObject"%>
<%@page import="com.chinacreator.eform.util.Escape"%>
<%@page import="com.chinacreator.xtbg.pub.flowinfoconif.dao.FlowInfoDao"%>
<%@page import="com.chinacreator.xtbg.pub.util.DaoImplClassUtil"%>

<html>
<head>
<link href="../../../resources/css/layer.css" rel="stylesheet" type="text/css" />
<link href="../../../resources/css/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>	
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>流程绑定form</title>
<%
AccessControl accesscontroler = AccessControl.getAccessControl();
accesscontroler.checkAccess(request, response);
String paramjosn = request.getParameter("jsonparam");
boolean flag = true;
String msg = "";
FlowInfoConfigServiceIfc flowInfo = new FlowInfoConfigServiceImpl();
FlowDefInfoBean flowDefInfoBean  = new FlowDefInfoBean();
if (!StringUtil.isBlank(paramjosn)) {
	paramjosn = DataControlUtil.replaceStr(paramjosn);
	paramjosn = Escape.unescape(paramjosn);
	flowDefInfoBean = (FlowDefInfoBean) JSONObject.parseObject(paramjosn, FlowDefInfoBean.class);
} 
String packageId = flowDefInfoBean.getPackage_id();
String flowDefId = flowDefInfoBean.getFlow_defid();

if(null == flowDefId  || "".equals(flowDefId))
{
	flowDefId = request.getParameter("def_id");
}
String flowVersion = flowDefInfoBean.getFlow_version();
String flowId = flowDefInfoBean.getFlow_id();
String type = request.getParameter("type");
String oldFlowId = request.getParameter("old_flow_id");
String newFlowId = request.getParameter("new_flow_id");
FlowDefInfoBean flowDefInfoBean2 = new FlowDefInfoBean();
FlowInfoDao flowInfodao = (FlowInfoDao)DaoImplClassUtil.getDaoImplClass("flowInfoDaoImpl");
flowDefInfoBean = flowInfodao.findFlowDefInfoByFlowId(flowId);
boolean canReload = false;
try{
	if(null!=type && type.equals("saveflowinfo")){//绑定流程
	    if(flowInfo.isExistFlow(packageId,flowDefId,flowId,flowVersion)){
	    	msg = "该记录已经被添加";
	    }else{
			oldFlowId = flowInfo.getOldFlowId(packageId,flowDefId,flowId);    	
	    	newFlowId = flowInfo.saveFlowInfo(packageId,flowDefId,flowId,flowVersion);
	    	msg = "操作成功";
	    	canReload = true;
	    }
	}else if(null!= type && type.equals("userflowinfo")){//启用流程
		flowInfo.userFlowInfo(flowId,flowDefId);
		msg = "启用成功";
		canReload = true;
	}else if(null!=type && type.equals("extendsflowversion")){//继承老版本流程
		flowInfo.updateWorkflowInfo(oldFlowId,newFlowId);
		msg = "操作成功";
		canReload = true;
	}
	flowDefInfoBean = flowInfodao.findFlowDefInfoByFlowId(flowId);
}catch(Exception e){
	msg = "操作失败";
}
%>    
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<title>绑定流程</title>

</head>
<body>
<form name = "form1" method = "post">
<input type = "hidden" name = "type" id="type"  value = "<%=type %>">
<iframe name = "hiddenFrame" width = "0px" height = "0px"></iframe>
</form>
</body>
<script type="text/javascript">

if("<%=type%>"=="saveflowinfo" && "<%=msg%>"=="操作成功"){
	if("<%=oldFlowId%>"!="" && confirm("操作成功，是否继承老版本信息?")){
		document.getElementById("type").value = "extendsflowversion";
		parent.extendsflowversion("<%=oldFlowId%>","<%=newFlowId%>");//继承流程信息	
	}else{
		alert("<%=msg%>");
		if("<%=canReload%>" == "true"){
			parent.refreshGrid4FlowInfo();
			parent.refreshFlowInfo('<%=flowDefInfoBean.getFlow_version()%>','<%=flowDefInfoBean.getPackage_id()%>','<%=flowDefInfoBean.getFlow_defid()%>');
		}
	}
}else{
	alert("<%=msg%>");
	if("<%=canReload%>" == "true"){
	   	parent.refreshGrid4FlowInfo(); 
	   	parent.refreshFlowInfo('<%=flowDefInfoBean.getFlow_version()%>','<%=flowDefInfoBean.getPackage_id()%>','<%=flowDefInfoBean.getFlow_defid()%>');
	}
}
</script>
</html>
</html>
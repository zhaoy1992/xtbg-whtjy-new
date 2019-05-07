<%@page import="com.chinacreator.security.AccessControl"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">


<%@page import="java.sql.SQLException"%>

<%@page import="com.alibaba.fastjson.JSONObject"%>
<%@page import="com.chinacreator.eform.util.Escape"%>



<%@page import="com.chinacreator.xtbg.core.process.processconfig.service.FlowInfoConfigServiceIfc"%>
<%@page import="com.chinacreator.xtbg.core.process.processconfig.service.impl.FlowInfoConfigServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.process.processconfig.entity.FlowDefInfoBean"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DataControlUtil"%>
<%@page import="com.chinacreator.xtbg.core.process.processconfig.dao.FlowInfoDao"%>
<%@page import="com.chinacreator.xtbg.core.common.startup.LoadSpringContext"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%><html>
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
String flowdesc = flowDefInfoBean.getFlow_desc();
String type = request.getParameter("type");
String oldFlowId = request.getParameter("old_flow_id");
String newFlowId = request.getParameter("new_flow_id");
FlowDefInfoBean flowDefInfoBean2 = new FlowDefInfoBean();
FlowInfoDao flowInfodao = (FlowInfoDao)LoadSpringContext.getApplicationContext().getBean("flowInfoDaoImpl");
flowDefInfoBean = flowInfodao.findFlowDefInfoByFlowId(flowId);
boolean canReload = false;
try{
	if(null!=type && type.equals("saveflowinfo")){//绑定流程
	    if(flowInfo.isExistFlow(packageId,flowDefId,flowId,flowVersion)){
	    	msg = "该记录已经被添加";
	    }else{
	    	//flow_id = 85674d7b-1ec0-45b1-93bc-92f160e33119
	    	//def_id= f2a19168-8db9-4f93-82a5-3111926f878c
			oldFlowId = flowInfo.getOldFlowId(packageId,flowDefId,flowId);    	
	    	newFlowId = flowInfo.saveFlowInfo(packageId,flowDefId,flowId,flowVersion,flowdesc);
	    	msg = "操作成功";
	    	canReload = true;
	    }
	}else if(null!= type && type.equals("userflowinfo")){//启用流程
		flowInfo.userFlowInfo(flowId,flowDefId);
		msg = "启用成功";
		canReload = true;
	}else if(null!=type && type.equals("extendsflowversion")){//继承老版本流程
		String oldTableId = StringUtil.deNull(request.getParameter("oldTableId"));
		//老版本的业务表id
		boolean copyFlag = flowInfo.updateWorkflowInfo(oldFlowId,newFlowId,oldTableId);
		if(copyFlag){
			msg = "操作成功";
	        canReload = true;
		}else{
			msg = "操作失败";
            canReload = false;
		}
	}else if(null!=type && type.equals("flowacitoninit")){//流程初始化
		
		boolean copyFlag = flowInfo.ActionInit(newFlowId);
		if(copyFlag){
			msg = "绑定流程成功，并已经初始化流程环节信息！";
	        canReload = true;
		}else{
			msg = "绑定流程失败，初始化流程环节失败，请手动绑定环节配置信息！";
            canReload = false;
		}
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
<input type = "hidden" id="type" name = "type" value = "<%=type %>">
<iframe name = "hiddenFrame" width = "0px" height = "0px"></iframe>
</form>
</body>
<script type="text/javascript">

if("<%=type%>"=="saveflowinfo" && "<%=msg%>"=="操作成功"){
	if("<%=oldFlowId%>"!="" && confirm("操作成功，是否继承老版本信息?")){
		document.getElementById("type").value = "extendsflowversion";
		parent.extendsflowversion("<%=oldFlowId%>","<%=newFlowId%>");//继承流程信息	
	}else{
		//如果是新流程，或者不继承老版本信息，那么初始化流程
		document.getElementById("type").value = "flowacitoninit";
		parent.flowacitoninit("<%=newFlowId%>");//初始化流程	
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
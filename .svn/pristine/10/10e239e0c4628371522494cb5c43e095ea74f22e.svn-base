<%@page import="com.chinacreator.xtbg.pub.workflow.service.impl.WorkFlowServiceImpl"%>
<%@page import="com.chinacreator.xtbg.pub.workflow.service.WorkFlowServiceIfc"%>
<%@page import="com.chinacreator.xtbg.pub.workflow.service.impl.FlowInstanceServiceImpl"%>
<%@page import="com.chinacreator.xtbg.pub.workflow.service.FlowInstanceServiceIfc"%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="java.util.Map" %>
<%@page import="java.util.HashMap"%>
<%@page import="com.alibaba.fastjson.JSONObject"%>
<%@page import="com.chinacreator.xtbg.pub.util.DataControlUtil"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request, response);
	String userName = control.getUserAccount();
	String userRealName = control.getUserName();
	String orgid = control.getChargeOrgId();//与orgId区分
	String orgName = control.getChargeOrgName();
	String entrance1 = request.getParameter("entrance1");
	String indexReturn = request.getParameter("indexReturn");
	String act_name=request.getParameter("act_name");
	String fromPage = "tabs-1";
	String actionPage = request.getParameter("actionPage"); //业务的具体名称：请假or公文
	String msg = "";
	try{
		String operationType = request.getParameter("operationType");	//操作类型
		String flowDataJson = request.getParameter("flowData");//流程信息
		
		String classNameId = request.getParameter("classNameId");	//操作类
		String busiData = request.getParameter("busiData");	//操作类型
		String end_type = request.getParameter("end_type");//分发类型
		String receive_userid = request.getParameter("receive_userid");//分发接收者
		String xzspWorkflowType = request.getParameter("xzspWorkflowType");	//流程类型
		String isDynamicSelectUser = request.getParameter("isDynamicSelectUser");	//是否动态选择执行人
		String DYNAMICPERFORMER = request.getParameter("DYNAMICPERFORMER");	//活动执行人
		String flowTache = request.getParameter("flowTache");	//
		String nextActId = request.getParameter("nextActId");	//下一活动ID
		String nextActList = request.getParameter("nextActList");	//活动列表
		String action_handeridea = request.getParameter("action_handeridea");	//处理意见
		String bigColumnsValue = request.getParameter("bigColumnsValue");	//大字段数据
		String notify_UserId = request.getParameter("notify_UserId");//通知接收人ID


		Map<Object, Object> flowInfoObj = new HashMap<Object, Object>();
		Map<String, String> flowData = new HashMap<String, String>();
		Map<String, String> flowCtrlInfo = new HashMap<String, String>();
		flowDataJson = DataControlUtil.replaceStr(flowDataJson);
		flowData = (Map)JSONObject.parseObject(flowDataJson);// 根据字符串转换对象
		
		
		flowInfoObj.put("flowData", flowData);
		flowInfoObj.put("classNameId", classNameId);
		flowInfoObj.put("end_type", end_type);
		flowInfoObj.put("receive_userid", receive_userid);
		flowInfoObj.put("bigColumnsValue", bigColumnsValue);
		flowInfoObj.put("action_handeridea", action_handeridea);
		flowInfoObj.put("orgid", orgid);
		flowInfoObj.put("orgName", orgName);
		flowInfoObj.put("userRealName", userRealName);
		flowInfoObj.put("notify_UserId", notify_UserId);
		
		FlowInstanceServiceIfc flowInstanceServiceIfc = new FlowInstanceServiceImpl();
		WorkFlowServiceIfc workFlowServiceIfc = new WorkFlowServiceImpl();
		
	    if("dostartflow".equals(operationType)) {//受理	   
	    	flowCtrlInfo = workFlowServiceIfc.getFlowCtrlInfo(xzspWorkflowType,isDynamicSelectUser,DYNAMICPERFORMER,flowData.get("def_id"),nextActList,flowTache,nextActId);
	    	flowInfoObj.put("flowCtrlInfo", flowCtrlInfo);
    		flowInstanceServiceIfc.doStartFlow(flowInfoObj, busiData);
	    } else if("dotemp".equals(operationType)){//暂存
	    	flowInstanceServiceIfc.doTemp(flowInfoObj, busiData);
	    } else if("docompleteworkflow".equals(operationType)) {	//完成活动
	    	//把数据都封装在map中
	    	flowCtrlInfo = workFlowServiceIfc.getFlowCtrlInfo(xzspWorkflowType,isDynamicSelectUser,DYNAMICPERFORMER,flowData.get("def_id"),nextActList,flowTache,nextActId);
	    	flowInfoObj.put("flowCtrlInfo", flowCtrlInfo);
	    	flowInstanceServiceIfc.doCompleteAct(flowInfoObj, busiData);
	    } else if("dofinishworkflow".equals(operationType)) {	//办结
	    	flowCtrlInfo = workFlowServiceIfc.getFlowCtrlInfo(xzspWorkflowType,isDynamicSelectUser,DYNAMICPERFORMER,flowData.get("def_id"),nextActList,flowTache,nextActId);
	    	flowInfoObj.put("flowCtrlInfo", flowCtrlInfo);
	    	flowInstanceServiceIfc.doFlowFinish(flowInfoObj, busiData);
	    } else if("doterminationflow".equals(operationType)) {
	    	flowInstanceServiceIfc.doTerminationFlow(flowInfoObj, busiData);
	    } else if("doflowback".equals(operationType)) {
	    	flowInstanceServiceIfc.doFlowBack(flowInfoObj, busiData);
	    }else if("doTemporarySave".equals(operationType)){
	    	//把数据都封装在map中
	    	flowCtrlInfo = workFlowServiceIfc.getFlowCtrlInfo(xzspWorkflowType,isDynamicSelectUser,DYNAMICPERFORMER,flowData.get("def_id"),nextActList,flowTache,nextActId);
	    	flowInfoObj.put("flowCtrlInfo", flowCtrlInfo);
	    	flowInstanceServiceIfc.doTemporarySave(flowInfoObj, busiData);
	    }
	
	}catch(Exception e){
		e.printStackTrace();
		msg = "error";
	}
%>


<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<title></title>
<script type="text/javascript" src="../../ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript">
var fromPage = '<%=fromPage%>';
var actionPage = '<%=actionPage%>';
	if("<%=msg%>"=="error"){
		alert("操作失败");
	}else{
		alert("<%=CacheCommonManageProxy.getSystemParam("workflow.complete_workflow_notice_str")%>");
		window.top.getIFrameDOM("_document_body_mian_firstPagerAAAS").location.reload();
		if('<%=entrance1%>' =='homepage')
		{
			clearInterval(parent.interval);
			window.top.jQuery("._div_flow").remove();
			parent.doReturnOK1();
			
		}else
		{
			clearInterval(parent.interval);
			window.top.jQuery("._div_flow").remove();
			parent.doReturnOK(<%=indexReturn%>,'<%=act_name%>',actionPage);//操作成功后调用父页面方法    回到暂存，已存，已办页面
		}
		
		
	}
</script>
</head>
<body>

</body>

<%@page import="com.chinacreator.business.common.tools.CacheCommonManageProxy"%></html>
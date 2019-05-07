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
	String orgid = control.getChargeOrgId();//��orgId����
	String orgName = control.getChargeOrgName();
	String entrance1 = request.getParameter("entrance1");
	String indexReturn = request.getParameter("indexReturn");
	String act_name=request.getParameter("act_name");
	String fromPage = "tabs-1";
	String actionPage = request.getParameter("actionPage"); //ҵ��ľ������ƣ����or����
	String msg = "";
	try{
		String operationType = request.getParameter("operationType");	//��������
		String flowDataJson = request.getParameter("flowData");//������Ϣ
		
		String classNameId = request.getParameter("classNameId");	//������
		String busiData = request.getParameter("busiData");	//��������
		String end_type = request.getParameter("end_type");//�ַ�����
		String receive_userid = request.getParameter("receive_userid");//�ַ�������
		String xzspWorkflowType = request.getParameter("xzspWorkflowType");	//��������
		String isDynamicSelectUser = request.getParameter("isDynamicSelectUser");	//�Ƿ�̬ѡ��ִ����
		String DYNAMICPERFORMER = request.getParameter("DYNAMICPERFORMER");	//�ִ����
		String flowTache = request.getParameter("flowTache");	//
		String nextActId = request.getParameter("nextActId");	//��һ�ID
		String nextActList = request.getParameter("nextActList");	//��б�
		String action_handeridea = request.getParameter("action_handeridea");	//�������
		String bigColumnsValue = request.getParameter("bigColumnsValue");	//���ֶ�����
		String notify_UserId = request.getParameter("notify_UserId");//֪ͨ������ID


		Map<Object, Object> flowInfoObj = new HashMap<Object, Object>();
		Map<String, String> flowData = new HashMap<String, String>();
		Map<String, String> flowCtrlInfo = new HashMap<String, String>();
		flowDataJson = DataControlUtil.replaceStr(flowDataJson);
		flowData = (Map)JSONObject.parseObject(flowDataJson);// �����ַ���ת������
		
		
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
		
	    if("dostartflow".equals(operationType)) {//����	   
	    	flowCtrlInfo = workFlowServiceIfc.getFlowCtrlInfo(xzspWorkflowType,isDynamicSelectUser,DYNAMICPERFORMER,flowData.get("def_id"),nextActList,flowTache,nextActId);
	    	flowInfoObj.put("flowCtrlInfo", flowCtrlInfo);
    		flowInstanceServiceIfc.doStartFlow(flowInfoObj, busiData);
	    } else if("dotemp".equals(operationType)){//�ݴ�
	    	flowInstanceServiceIfc.doTemp(flowInfoObj, busiData);
	    } else if("docompleteworkflow".equals(operationType)) {	//��ɻ
	    	//�����ݶ���װ��map��
	    	flowCtrlInfo = workFlowServiceIfc.getFlowCtrlInfo(xzspWorkflowType,isDynamicSelectUser,DYNAMICPERFORMER,flowData.get("def_id"),nextActList,flowTache,nextActId);
	    	flowInfoObj.put("flowCtrlInfo", flowCtrlInfo);
	    	flowInstanceServiceIfc.doCompleteAct(flowInfoObj, busiData);
	    } else if("dofinishworkflow".equals(operationType)) {	//���
	    	flowCtrlInfo = workFlowServiceIfc.getFlowCtrlInfo(xzspWorkflowType,isDynamicSelectUser,DYNAMICPERFORMER,flowData.get("def_id"),nextActList,flowTache,nextActId);
	    	flowInfoObj.put("flowCtrlInfo", flowCtrlInfo);
	    	flowInstanceServiceIfc.doFlowFinish(flowInfoObj, busiData);
	    } else if("doterminationflow".equals(operationType)) {
	    	flowInstanceServiceIfc.doTerminationFlow(flowInfoObj, busiData);
	    } else if("doflowback".equals(operationType)) {
	    	flowInstanceServiceIfc.doFlowBack(flowInfoObj, busiData);
	    }else if("doTemporarySave".equals(operationType)){
	    	//�����ݶ���װ��map��
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
		alert("����ʧ��");
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
			parent.doReturnOK(<%=indexReturn%>,'<%=act_name%>',actionPage);//�����ɹ�����ø�ҳ�淽��    �ص��ݴ棬�Ѵ棬�Ѱ�ҳ��
		}
		
		
	}
</script>
</head>
<body>

</body>

<%@page import="com.chinacreator.business.common.tools.CacheCommonManageProxy"%></html>
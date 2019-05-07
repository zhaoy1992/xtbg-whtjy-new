<%-- 
描述：追回功能处理
作者：黄艺平
版本：1.0
日期：2013-06-17
 --%>
<%@page import="com.chinacreator.xtbg.core.process.flowprocessing.util.FlowStaticTHreadData"%>
<%@page import="com.chinacreator.xtbg.core.process.flowprocessing.service.impl.WorkFlowServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.process.flowprocessing.service.WorkFlowServiceIfc"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.alibaba.fastjson.JSONObject"%>
<%@page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
AccessControl accesscontroler = AccessControl.getInstance();
accesscontroler.checkAccess(request, response);
String actInsId = request.getParameter("actInsId");
String ins_id = request.getParameter("ins_id");
String flow_id = request.getParameter("flow_id");
String action_form = request.getParameter("action_form");
String def_id = request.getParameter("def_id");

FlowStaticTHreadData.setStatus_code("07");
//FlowStaticTHreadData.setMgrName(flowData.get("mgrName"));
FlowStaticTHreadData.setBuisinessId(ins_id);
FlowStaticTHreadData.setModuleId(flow_id);
FlowStaticTHreadData.setAction_form(action_form);
FlowStaticTHreadData.setDefId(def_id);
WorkFlowServiceIfc workFlowServiceIfc = new WorkFlowServiceImpl();
String actUsername = accesscontroler.getUserAccount();

JSONObject jsonObj = new JSONObject();
String currActInsId =  request.getParameter("currActInsId");
//根据流程ID获取会签的环节实例ID

workFlowServiceIfc.recycle(actUsername,actInsId,"",ins_id);

//删除流程静态参数
FlowStaticTHreadData.removeAll();
out.print(jsonObj);
%>

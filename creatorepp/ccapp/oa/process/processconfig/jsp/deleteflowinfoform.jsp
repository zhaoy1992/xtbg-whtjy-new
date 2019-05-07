<%--
删除环节表单配置信息form
作者：戴连春
日期：2013-06-05
 --%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@page
	import="com.chinacreator.xtbg.core.process.processconfig.service.*"%>
<%@page
	import="com.chinacreator.xtbg.core.process.processconfig.service.impl.*"%>
<%
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	String flowids = request.getParameter("flowids");
	String busitype_code = request.getParameter("busitype_code");
	String fIds[] = flowids.split("[\\,,\\，]");
	boolean flag = false;
	try {
		FlowInfoConfigServiceIfc service = new FlowInfoConfigServiceImpl();
		
		boolean isFlow=service.isFlowInstance(busitype_code);
		//删除
		//if(!isFlow){
		flag = service.deleteFlowBaseInfoById(flowids);
		//}
		//if(!isFlow){
			if (flag) {
				out.print(
						"{\"flag\":\"true\",\"msg\":\"删除成功!\"}");
			} else {
				out.print(
						"{\"flag\":\"false\",\"msg\":\"删除失败!\"}");
			}
		//}else{
			//out.print(
			//"{\"flag\":\"false\",\"msg\":\"该流程已经被引用不能删除！!\"}");
		//}
	} catch (Exception e) {
		out.print(
				"{\"flag\":\"false\",\"msg\":\"删除失败!\"}");

	}
%>
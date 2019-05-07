<%--
删除业务类型
作者：肖杰
日期：2013-7-30
 --%>
<%@page import="com.chinacreator.xtbg.core.pubconfig.service.impl.FlowBusitypeServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.pubconfig.service.FlowBusitypeServiceIfc"%>
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
	String busitype_codes = request.getParameter("busitype_codes");
	String fIds[] = busitype_codes.split("[\\,,\\，]");
	boolean flag = false;
	try {
		FlowBusitypeServiceIfc service = new FlowBusitypeServiceImpl();
		//删除
		flag = service.deleteFlowBusitype(busitype_codes);
		if (flag) {
			out.print(
					"{\"flag\":\"true\",\"msg\":\"删除成功!\"}");
		} else {
			out.print(
					"{\"flag\":\"false\",\"msg\":\"删除失败!\"}");
		}

	} catch (Exception e) {
		out.print(
				"{\"flag\":\"false\",\"msg\":\"删除失败!\"}");

	}
%>
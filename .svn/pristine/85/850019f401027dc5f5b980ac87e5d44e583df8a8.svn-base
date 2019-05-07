<%-- 
	描述：机构排序处理页面
	作者：黄艺平
	版本：1.0
	日期：2013-05-23
 --%>
<%@page import="com.chinacreator.xtbg.core.dataresources.service.impl.DataResourcesServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.dataresources.service.DataResourcesServiceIfc"%>
<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%

	boolean flag = false;
	String boxvalue = request.getParameter("boxvalue");
	String orgId = request.getParameter("orgId");
	String oprtype = request.getParameter("oprtype");
	
	DataResourcesServiceIfc dataResourcesServiceIfc = new DataResourcesServiceImpl();
	if("save".equals(oprtype)) {
		flag = dataResourcesServiceIfc.insertOrgResourceConfig(boxvalue, orgId);
	} else {
		flag = dataResourcesServiceIfc.delAllChooseOrgUser(orgId);
	}
	
	try {	
		if(flag){
	        out.print("{\"flag\":\"true\",\"msg\":\"操作成功\"}");
	    }else{
	        out.print("{\"flag\":\"false\",\"msg\":\"操作失败\"}");  
	    }
	} catch (Exception e) {
		out.print("{\"flag\":\"false\",\"msg\":\"操作失败!\"}");
	}
%>

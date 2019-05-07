<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="com.chinacreator.xtbg.core.process.flowprocessing.dao.FlowInstanceDataSaveDao"%>
<%@page import="com.chinacreator.xtbg.core.process.flowprocessing.dao.impl.FlowInstanceDataSaveDaoImpl"%>
<%@page import="com.chinacreator.xtbg.core.common.commonlist.PagingBean"%>
<%@page import="com.chinacreator.xtbg.core.archive.list.CircularizeList"%>
<%@page import="com.chinacreator.xtbg.core.common.util.ResultMap"%>
<%@page import="com.chinacreator.xtbg.core.common.util.AResultCode"%>
<%@page import="com.alibaba.fastjson.JSON"%>
<%@page import="org.apache.ecs.xhtml.object"%>

<%
	String method = request.getParameter("method");
	boolean flag = false;
	if(method.equals("updateState")){
		String circularize_id = request.getParameter("circularize_id");
		String userID = request.getParameter("user_id");
		
		FlowInstanceDataSaveDao flowinstancedatasavedao = new FlowInstanceDataSaveDaoImpl();
		flag = flowinstancedatasavedao.updateFlowActInsState(circularize_id,userID,"1");
		ResultMap<AResultCode,Object> resultMap = new ResultMap<AResultCode,Object>();
		resultMap.setCode(AResultCode.OK);
		resultMap.setResult("");
		out.write(JSON.toJSONString(resultMap,true));
		
	}else if(method.equals("getList")){
		String parmjson = request.getParameter("parmjson");
		String sortName = request.getParameter("sortName");
		String sortOrder = request.getParameter("sortOrder");
		long offset = Long.parseLong(request.getParameter("offset"));
		int maxPagesize = Integer.parseInt(request.getParameter("maxPagesize"));
		PagingBean pb = new PagingBean();
		CircularizeList list = new CircularizeList();
		pb = list.getDataList(parmjson,sortName,sortOrder,offset,maxPagesize);
		ResultMap<AResultCode,PagingBean> result = new ResultMap<AResultCode,PagingBean>();
		result.setCode(AResultCode.OK);
		result.setResult(pb);
		out.write(JSON.toJSONString(result,true));
	}
%>
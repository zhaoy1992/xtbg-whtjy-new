<%@page import="com.chinacreator.xtbg.core.dssave.service.impl.DsCRUDServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.dssave.service.DsCRUDService"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.core.archive.gwcs.services.impl.ReceiveGwServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.archive.gwcs.services.ReceiveGwService"%>
<%@page import="org.apache.velocity.runtime.parser.node.SetExecutor"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import=" com.chinacreator.xtbg.core.archive.cache.UnionArchiveFeedBackThread"%>
<%@page import=" com.chinacreator.xtbg.core.archive.cache.UnionArchiveSendCronTrigger"%>
<%@page import=" com.chinacreator.xtbg.core.common.startup.LoadSpringContext"%>
<%@page import="java.util.Map"%>
<%@page import="com.alibaba.fastjson.JSONObject"%>
<%
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	boolean flag=false;
	String recordid = request.getParameter("recordid");
	String flow_act_id = request.getParameter("flow_act_id");
	DsCRUDService service=new DsCRUDServiceImpl();
	flag=service.updateFile(flow_act_id,recordid);
	JSONObject jsonObj = new JSONObject();
	jsonObj.put("flag",flag);
	response.getWriter().print(jsonObj);
%>


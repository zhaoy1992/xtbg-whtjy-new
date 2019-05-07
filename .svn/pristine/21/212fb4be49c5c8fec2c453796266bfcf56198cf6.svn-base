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
	
	String attach_id = request.getParameter("attach_id");
	String filename = request.getParameter("filename");
	ReceiveGwService service=new ReceiveGwServiceImpl();
	String djsn=StringUtil.deNull(service.findAttachid(attach_id,filename));
	JSONObject jsonObj = new JSONObject();
	jsonObj.put("djsn",djsn);
	out.print(jsonObj);
%>


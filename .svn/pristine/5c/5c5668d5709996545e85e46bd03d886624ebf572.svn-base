<%-- 
描述：公文处理
作者：邹拓
版本：1.0
日期：2013-12-13
 --%>
<%@page import="com.chinacreator.xtbg.core.process.processconfig.dao.impl.FlowInfoDaoImpl"%>
<%@page import="com.chinacreator.xtbg.core.process.processconfig.dao.FlowInfoDao"%>
<%@page import="com.chinacreator.xtbg.core.archive.entity.OfficialDocumentRegisterHandleBean"%>
<%@page import="com.chinacreator.xtbg.core.common.iweboffice.bean.WordRuleItemBean"%>
<%@page import="java.util.List"%>
<%@page import="com.chinacreator.xtbg.core.common.iweboffice.service.impl.WordTemplateServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.common.iweboffice.service.WordTemplateServiceIfc"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.core.archive.entity.ArchiveDispatchBean"%>
<%@page import="com.chinacreator.xtbg.core.archive.service.impl.WordArchiveServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.archive.service.WordArchiveService"%>
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
	String path = request.getContextPath();
	
	String busitype_code=request.getParameter("busitype_code");
	Map<String,String> map = new HashMap<String,String>();
	FlowInfoDao dao=new FlowInfoDaoImpl();
	map=dao.findFlowBaseInfoByCode(busitype_code);
	String pageURL=map.get("from_path");
	String template_id=map.get("template_id");
	String Template="word"+template_id;
	/* String pageURL = "/ccapp/oa/archive/wordform.jsp";
	String busiTypeCode = "hnsbgt_lwdj";
	String template_id = "174edca5-b82e-4211-994d-1ee51c991e61";
	String Template = "word174edca5-b82e-4211-994d-1ee51c991e61"; */
	String height = request.getParameter("height");
	String width = request.getParameter("width");
	String offDocRegId = request.getParameter(OfficialDocumentRegisterHandleBean.OFF_DOC_REG_ID);
%>
<jsp:include page="<%=pageURL%>" >
	<jsp:param name="busiTypeCode" value="<%=busitype_code%>"/>
	<jsp:param name="template_id" value="<%=template_id%>"/>
	<jsp:param name="Template" value="<%=Template%>"/>
	<jsp:param name="width" value="<%=width%>"/>
	<jsp:param name="height" value="<%=height%>"/>
	<jsp:param name="offDocRegId" value="<%=offDocRegId%>"/>
</jsp:include>

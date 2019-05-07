<%-- 
描述：公文处理
作者：邹拓
版本：1.0
日期：2013-12-13
 --%>
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
	
	String pageURL = path+"/ccapp/oa/archive/wordform.jsp";
	Map<String,String> pageArg = new HashMap<String,String>();
	String busiTypeCode = "hnsbgt_gwbl";
	String template_id = "34e74c8a-f71e-42c6-91d9-9ab091328a1c";//文档模板管理ID
	String Template = "word34e74c8a-f71e-42c6-91d9-9ab091328a1c";//文档模版内容 存在数据库中的ID
	String height = request.getParameter("height");
	String width = request.getParameter("width");
	String offDocRegId = request.getParameter(OfficialDocumentRegisterHandleBean.OFF_DOC_REG_ID);
	
%>
<jsp:include page="../wordform.jsp">
	<jsp:param name="busiTypeCode" value="<%=busiTypeCode%>"/>
	<jsp:param name="template_id" value="<%=template_id%>"/>
	<jsp:param name="Template" value="<%=Template%>"/>
	<jsp:param name="width" value="<%=width%>"/>
	<jsp:param name="height" value="<%=height%>"/>
	<jsp:param name="offDocRegId" value="<%=offDocRegId%>"/>
</jsp:include>

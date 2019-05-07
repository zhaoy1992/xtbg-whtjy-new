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
	boolean flag = false;
	String archive_returnid = request.getParameter("archive_returnid");
	WordArchiveService service = new WordArchiveServiceImpl();
	ArchiveDispatchBean bean=new ArchiveDispatchBean();
	bean = service.getArchiveDispatch(archive_returnid);
	String str=service.sendToArchive(bean,archive_returnid);
	if(!StringUtil.isBlank(str)){
		flag=true;
	}
	JSONObject jsonObj = new JSONObject();
	jsonObj.put("flag",flag);
	out.print(jsonObj);
%>


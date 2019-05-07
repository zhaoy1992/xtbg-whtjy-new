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
	boolean flag = true;
	String optType = request.getParameter("optType");
	if("feedBack".equals(optType)){
		UnionArchiveFeedBackThread unionArchiveFeedBackThread = (UnionArchiveFeedBackThread)LoadSpringContext.getApplicationContext().getBean("unionArchiveFeedBackThread");
		flag = unionArchiveFeedBackThread.feedback();//直接调用刷新接口
	}else if("sendArchive".equals(optType)){
		String archive_returnid = request.getParameter("archive_returnid");
		UnionArchiveSendCronTrigger unionArchiveSendCronTrigger = (UnionArchiveSendCronTrigger)LoadSpringContext.getApplicationContext().getBean("unionArchiveSendCronTrigger");
		flag = unionArchiveSendCronTrigger.sendArchive(archive_returnid);
	}
	JSONObject jsonObj = new JSONObject();
	jsonObj.put("flag",flag);
	out.print(jsonObj);
%>


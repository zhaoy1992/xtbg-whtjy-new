
<%@page import="com.alibaba.fastjson.JSON"%>
<%@page import="com.chinacreator.xtbg.core.news.dao.impl.newsDaoImpl"%>
<%@page import="com.chinacreator.xtbg.core.news.entity.newsBean"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.xtbg.core.common.startup.LoadSpringContext"%>
<%@ page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.core.meeting.service.MeetingHandleServiceIfc" %>
<%@page import="com.chinacreator.xtbg.core.meeting.service.impl.MeetingHandleServiceImpl" %>
<%@page import="com.chinacreator.xtbg.core.meeting.service.MeetingRoomoccupancyServiceIfc" %>
<%@page import="com.chinacreator.xtbg.core.meeting.service.impl.MeetingRoomoccupancyServiceImpl" %>
<%@page import="com.chinacreator.xtbg.core.common.util.DataControlUtil" %>
<%@page import="com.chinacreator.xtbg.core.meeting.entity.*" %>
<%@page import="com.alibaba.fastjson.JSONObject" %>
<%@page import="java.util.List"%>
<%@page import="com.chinacreator.eform.util.Escape"%>
<%@page import="com.chinacreator.xtbg.core.meeting.util.MeetingConstants"%>
<%@page import="com.chinacreator.xtbg.core.common.util.*"%>
<%
    AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	String action = request.getParameter("action");
	String n_id = request.getParameter("n_id");
	String n_title = request.getParameter("n_title");
	String n_org_id = request.getParameter("n_org_id");
	String n_org_name = request.getParameter("n_org_name");
	String n_content = request.getParameter("n_content");
	String ins_id = request.getParameter("ins_id");
	newsDaoImpl dao = new newsDaoImpl();
	boolean flag = true;
	newsBean newsbean = new newsBean();
	if("delete".equals(action)){
		flag = dao.deleteNews(n_id);
		out.print(flag);
	}else if("insert".equals(action)){
		newsbean.setIns_id(ins_id);
		newsbean.setN_content(n_content);
		newsbean.setN_org_id(n_org_id);
		newsbean.setN_org_name(n_org_name);
		newsbean.setN_title(n_title);
		flag = dao.insertNews(newsbean);
		out.print(flag);
	}else if("count".equals(action)){
		String is_reply = request.getParameter("is_reply");
		String n_username = request.getParameter("n_username");
		String n_date = request.getParameter("n_date");
		String n_apply_date = request.getParameter("n_apply_date");
		String n_release_type = request.getParameter("n_release_type");
		String n_date_end = request.getParameter("n_date_end");
		String n_apply_date_end = request.getParameter("n_apply_date_end");
		
		newsbean.setN_apply_date_end(n_apply_date_end);
		newsbean.setN_date_end(n_date_end);
		newsbean.setN_title(n_title);
		newsbean.setN_org_name(n_org_name);
		newsbean.setIs_reply(is_reply);
		newsbean.setN_username(n_username);
		newsbean.setN_date(n_date);
		newsbean.setN_apply_date(n_apply_date);
		newsbean.setN_release_type(n_release_type);
		String result = dao.queryNewsCount(newsbean);
		out.write(JSON.toJSONString(result,true));
	}
	
%>

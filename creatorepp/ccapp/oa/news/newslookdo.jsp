
<%@page import="com.alibaba.fastjson.JSON"%>
<%@page import="com.chinacreator.xtbg.core.news.entity.archiveBean"%>
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
	String ins_id = request.getParameter("ins_id");
	System.out.println("ins_id="+ins_id);
	newsBean newsbean = new newsBean();
	newsDaoImpl dao = new newsDaoImpl();
		response.setContentType( "application/x-json");
        ResultMap<ResultCode,archiveBean> result = dao.getLook(ins_id);
       out.write(JSON.toJSONString(result, true));
	
%>

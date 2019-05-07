
<%@page import="com.chinacreator.xtbg.pub.util.DaoUtil"%>
<%@page import="com.chinacreator.xtbg.pub.oagwcs.service.SendGwProxy"%>
<%@page import="com.alibaba.fastjson.JSONObject"%>
<%@page import="com.chinacreator.business.common.tools.CacheCommonManage"%>
<%--
描述：获得环节处理人的异步请求页面
作者：夏天
版本：1.0
日期：2013-4-18
--%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%
	String ins_id = request.getParameter("ins_id");
	String action_defid = request.getParameter("action_defid");
	JSONObject json = new JSONObject();
	StringBuffer sql = new StringBuffer();
	sql.append("select u.user_id||'#'||u.user_name||'#'||u.user_realname from (select wf.action_handerid from ta_oa_ins_wfaction wf ");
	sql.append("inner join ta_oa_flow_wfaction w on wf.action_id = w.action_id ");
	sql.append(" where wf.ins_id = '"+ins_id+"' and w.action_defid = '"+action_defid+"' order by wf.tache_begin_time desc ) o inner join td_sm_user u on u.user_id = o.action_handerid where rownum = 1");
	System.out.println(sql.toString());
	String result = DaoUtil.SqlToField(sql.toString());
	json.put("action_userid",result.split("#")[0]);
	json.put("action_username",result.split("#")[1]);
	json.put("action_userrealname",result.split("#")[2]);
	response.getWriter().print(json);
%>
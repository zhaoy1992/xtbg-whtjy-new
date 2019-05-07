
<%@page import="com.chinacreator.xtbg.xianning.jiekou.entity.OrgBean"%>
<%@page import="com.chinacreator.xtbg.xianning.jiekou.service.impl.UserAndOrgImpl"%>
<%@page import="com.chinacreator.xtbg.fagaiwei.messageCenter.serivce.impl.MesCenterSerivceImpl"%>
<%@page import="com.chinacreator.xtbg.core.common.msgcenter.services.impl.MessageCenterServiceImpl"%>
<%@page import="com.chinacreator.xtbg.fagaiwei.messageCenter.serivce.MesCenterSerivce"%>
<%@page import="com.alibaba.fastjson.JSONArray"%>
<%@page import="java.util.Map"%>
<%@page import="com.chinacreator.xtbg.pub.util.DaoImplClassUtil"%>
<%@page import="com.chinacreator.xtbg.pub.util.DaoUtil"%>
<%@page import="com.chinacreator.xtbg.pub.util.StringUtil"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.alibaba.fastjson.JSONObject"%><%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String userId = request.getParameter("userId");
	MesCenterSerivce mesCenterSerivce=new MesCenterSerivceImpl();
	List<Map<String,String>> list= mesCenterSerivce.queryMslist(userId);
	UserAndOrgImpl userAndOrgImpl=new UserAndOrgImpl();
	/* String xml="<organizations>" +
			"<organization><name>测试</name>" +
			"</organization></organizations>"; */
	//OrgBean orgBean= userAndOrgImpl.redOrgXml(xml);
	Object[] str=  list.toArray();
	String mes="";
	for(int i=0;i<str.length;i++){
		mes+=str[i]+"#";
	}
	mes=mes.substring(0, mes.length()-1);
	//JSONArray jsonObj = new JSONArray();
/* 	Object obj=new Object();
	jsonObj=(JSONArray)JSONObject.toJSON(list); */
	response.getWriter().print(mes);
	
%>

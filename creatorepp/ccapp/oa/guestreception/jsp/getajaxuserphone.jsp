
<%@page import="com.chinacreator.xtbg.core.common.tree.entity.ResourceRoleUserBean"%>
<%@page import="com.chinacreator.xtbg.core.guestreception.dao.impl.GuestreceptionDaoImpl"%>
<%@page import="com.chinacreator.xtbg.core.guestreception.dao.GuestreceptionDao"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.alibaba.fastjson.JSONObject"%><%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String userid = request.getParameter("user_id");
	//System.out.println(user_ids);
	GuestreceptionDao guestreceptionDao=new GuestreceptionDaoImpl();
	String userPhone=guestreceptionDao.queryUserPhone(userid);
	ResourceRoleUserBean rBean=new ResourceRoleUserBean();
	String jsonStr="{'userPhone':'"+ userPhone +"'}";
	//System.out.print(jsonStr);
	JSONObject jsonObj = new JSONObject();
	jsonObj=JSONObject.parseObject(jsonStr);
	out.print(jsonObj);
%>

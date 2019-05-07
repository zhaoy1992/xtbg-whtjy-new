<%@page import="com.chinacreator.xtbg.pub.util.DaoUtil"%>
<%@page import="com.chinacreator.xtbg.pub.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.yimingju.officeassets.dao.imploracle.CollarStockDaoImpl"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>

<%@page import="com.alibaba.fastjson.JSONObject"%><%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String userid = request.getParameter("user_id");
	CollarStockDaoImpl guestreceptionDao=new CollarStockDaoImpl();
	String[] departs =guestreceptionDao.getDepartByUserID(userid);
	String jsonStr="{'org_id':'"+ departs[0] +"','org_name':'"+departs[1]+"'}";
	JSONObject jsonObj = new JSONObject();
	jsonObj=JSONObject.parseObject(jsonStr);
	response.getWriter().print(jsonObj);
%>

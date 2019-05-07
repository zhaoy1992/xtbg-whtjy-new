<%@page import="com.chinacreator.xtbg.suxian.electroniccheck.dao.imploracle.ElectInfoDaoImpl"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="com.chinacreator.xtbg.pub.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.pub.util.DaoUtil"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.pub.util.DaoImplClassUtil"%>
<%@page import="com.alibaba.fastjson.JSONObject"%>
<%@page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	String mFilePath = request.getSession().getServletContext().getRealPath(""); 
	//请假开始时间
    String start_time = request.getParameter("start_time");
  	//请假结束时间
    String end_time = request.getParameter("end_time");
  	
    ElectInfoDaoImpl electinfodao = new ElectInfoDaoImpl();
    List<String> listHolidays = electinfodao.queryHolidayTimes(start_time,end_time);
    /*********查询节假日************/
    JSONObject jsonObj = new JSONObject();
    jsonObj.put("counts",listHolidays.size());
    response.getWriter().print(jsonObj);	
%>


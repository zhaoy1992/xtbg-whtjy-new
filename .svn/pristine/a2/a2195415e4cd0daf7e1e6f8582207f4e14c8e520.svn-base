
<%@page import="java.util.Date"%>
<%@page import="java.io.InputStream"%>
<%@page import="com.chinacreator.xtbg.yimingju.carmanage.dao.impl.CarManageCarDaoImpl"%>
<%@page import="com.chinacreator.xtbg.yimingju.carmanage.dao.CarManageCarDao"%>
<%@page import="com.chinacreator.xtbg.core.common.fancyuoload.entity.FileInfoBean"%>
<%@page import="com.chinacreator.xtbg.core.common.util.FileUtil"%>
<%@page import="com.chinacreator.xtbg.core.common.util.Jacob"%>
<%@page import="com.chinacreator.xtbg.fagaiwei.word.CreatorSXD"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="com.chinacreator.xtbg.pub.tree.entity.ResourceRoleUserBean"%>
<%@page import="com.chinacreator.xtbg.pub.util.DaoUtil"%>
<%@page import="com.chinacreator.xtbg.pub.util.StringUtil"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.chinacreator.xtbg.chenzhou.guestreception.dao.impl.GuestreceptionDaoImpl"%>
<%@page import="com.chinacreator.xtbg.chenzhou.guestreception.dao.GuestreceptionDao"%>
<%@page import="com.chinacreator.xtbg.pub.util.DaoImplClassUtil"%>
<%@page import="com.alibaba.fastjson.JSONObject"%><%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String carnumber = request.getParameter("carnumber");
	String wxc = request.getParameter("wxc");
	String yjfy = request.getParameter("yjfy");
	String year = request.getParameter("year");
	String month = request.getParameter("month");
	String day = request.getParameter("day");
	String id =request.getParameter("fileid");
	String remark= request.getParameter("remark");
	String path=request.getContextPath();
	String contentPath = "D:\\WorkSpace\\xtbg-base\\creatorepp";
	String outputPath = contentPath+"\\ccapp\\wordtemplate\\"+id+".doc";
	String url=path+"\\ccapp\\wordtemplate\\"+id+".doc";
	//String outputPath = contentPath+"\\ccapp\\wordtemplate\\12.doc";
 	CarManageCarDaoImpl carManageCarDao=new CarManageCarDaoImpl();
	byte[] content= carManageCarDao.queryContent(id);
	FileUtil.getFileFromBytes(content, outputPath);
 	Jacob jacob = new Jacob(false);
	jacob.openDocument(outputPath);
 	jacob.replaceLabelValue("year_1",year);
	jacob.replaceLabelValue("month_1",month);
	jacob.replaceLabelValue("day_1",day);
  	jacob.replaceLabelValue("wxc_1",wxc);
	jacob.replaceLabelValue("cartype_1","");
	jacob.replaceLabelValue("carnumber_1",carnumber);
	jacob.replaceLabelValue("content_1",remark);  
	jacob.replaceLabelValue("yjfy_1",yjfy);  
	
	
 	jacob.replaceLabelValue("year_2",year);
	jacob.replaceLabelValue("month_2",month);
	jacob.replaceLabelValue("day_2",day);
  	jacob.replaceLabelValue("wxc_2",wxc);
	jacob.replaceLabelValue("cartype_2","");
	jacob.replaceLabelValue("carnumber_2",carnumber);
	jacob.replaceLabelValue("content_2",remark);
	jacob.replaceLabelValue("yjfy_2",yjfy);  
	jacob.close();
	//Object obj=new Object();
	//String str="{'doc':'"+contentPath+"\\ccapp\\wordtemplate\\"+id+".doc'}";
	//obj=JSONObject.parse(str);
	response.getWriter().print(url);
%>

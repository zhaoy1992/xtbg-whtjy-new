
<%@page import="com.chinacreator.xtbg.pub.jqueryupload.filebuess.dao.impl.FiletransfersSysDaoImpl"%>
<%@page import="com.chinacreator.xtbg.pub.jqueryupload.filebuess.dao.FiletransfersSysDao"%>
<%@page import="com.chinacreator.xtbg.pub.oagwcs.entity.ReceiveGwcsBean"%>
<%@page import="com.chinacreator.xtbg.pub.util.DaoImplClassUtil"%>
<%@page import="com.chinacreator.xtbg.pub.oagwcs.dao.ReceiveDao"%>
<%@page import="com.chinacreator.xtbg.pub.util.DaoUtil"%>
<%@page import="com.chinacreator.xtbg.pub.util.StringUtil"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.alibaba.fastjson.JSONObject"%><%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String gwreceive_id = request.getParameter("gwreceive_id");
	ReceiveDao receiveDao = (ReceiveDao)DaoImplClassUtil.getDaoImplClass("receiveDaoImpl");

	ReceiveGwcsBean receiveGwcsBean = receiveDao.findReceiveGwcsBeanById(gwreceive_id);

	FiletransfersSysDao fsd = new FiletransfersSysDaoImpl();
	String fileCountNum = fsd.getFileCountByDjbh(receiveGwcsBean.getAttach_id());
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("receiveGwcsBean",receiveGwcsBean);
		jsonObj.put("fileCountNum",fileCountNum);
		response.getWriter().print(jsonObj);
	
	
	//response.getWriter().write("name:'0',value:'1'");
%>

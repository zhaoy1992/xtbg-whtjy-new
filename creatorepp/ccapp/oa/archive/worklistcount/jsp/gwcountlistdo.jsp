<%@page import="com.chinacreator.xtbg.core.archive.entity.SfwdjUserListConfBean"%>
<%@page import="com.alibaba.fastjson.JSONArray"%>
<%@page import="java.util.Map"%>
<%@page import="com.chinacreator.xtbg.core.archive.dao.impl.WorkCountDaoImpl"%>
<%@page import="com.chinacreator.xtbg.core.archive.dao.WorkCountDao"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%
	String path = request.getContextPath();
	String grinfoIds = "";
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	String loginUserName = accesscontroler.getUserAccount();
	String userid = accesscontroler.getUserID();
	
	String action = request.getParameter("action");
	
	
	WorkCountDao workCountDao = new WorkCountDaoImpl();
	if("queryColumns".equals(action)){
		String tableid = request.getParameter("tableid");
		List<Map<String,String>> tables = workCountDao.getColumnsByTableId(tableid);

		JSONArray jsonArry = new JSONArray();
		jsonArry.addAll(tables);
		
		out.print(jsonArry);
	}else if("saveTableColumns".equals(action)){
		String tablecode = request.getParameter("tablecode");
		String listtype = request.getParameter("listtype");
		String choose_columns = request.getParameter("choose_columns");
		
		SfwdjUserListConfBean sfwdjUserListConfBean = new SfwdjUserListConfBean();
		sfwdjUserListConfBean.setExtable(tablecode);
		sfwdjUserListConfBean.setList_type(listtype);
		sfwdjUserListConfBean.setUser_id(userid);
		sfwdjUserListConfBean.setColumn_list(choose_columns);
		workCountDao.saveUserListConfig(sfwdjUserListConfBean);
		out.print("alert('保存成功！')");
	}
	
%>


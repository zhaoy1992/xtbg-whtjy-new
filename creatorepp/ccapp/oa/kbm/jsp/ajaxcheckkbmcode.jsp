<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.core.kbm.dao.impl.KbmDocDaoImpl"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.alibaba.fastjson.JSONObject"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	JSONObject jsonObj = new JSONObject();
    //编号
    String k_code = StringUtil.deNull(request.getParameter("k_code"));
    KbmDocDaoImpl dao = new KbmDocDaoImpl();
    boolean isExits = dao.selKbmDocByCode(k_code);
    jsonObj.put("isExits",isExits);
	response.getWriter().print(jsonObj);
%>

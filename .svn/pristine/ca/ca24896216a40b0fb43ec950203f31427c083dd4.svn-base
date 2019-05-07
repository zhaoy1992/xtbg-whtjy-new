<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.pub.util.DaoImplClassUtil"%>
<%@page import="com.chinacreator.xtbg.jiaoyuksy.workflow.send.dao.imploracle.SendDaoImpl"%>
<%@page import="com.alibaba.fastjson.JSONObject"%>
<%@page import="java.util.HashMap"%>
<%@page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
AccessControl accesscontroler = AccessControl.getInstance();
accesscontroler.checkAccess(request, response);
    
    String userId=request.getParameter("userId");
    SendDaoImpl  SendDao= new SendDaoImpl();
    HashMap<String,String> map = (HashMap<String,String>)SendDao.getUserSignByUserId(userId);
    JSONObject jsonObj = new JSONObject();
    jsonObj.put("username",map.get("username"));
	jsonObj.put("leadUserName",map.get("leadUserName"));
	jsonObj.put("leadMaxUserName",map.get("leadMaxUserName"));
	response.getWriter().print(jsonObj);
%>

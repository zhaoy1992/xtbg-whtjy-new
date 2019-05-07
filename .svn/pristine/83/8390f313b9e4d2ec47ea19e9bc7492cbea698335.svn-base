
<%@page import="com.chinacreator.xtbg.core.personholder.dao.imploracle.PersonHolderDaoImpl"%>
<%@page import="com.chinacreator.xtbg.core.personholder.dao.PersonHolderDao"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.alibaba.fastjson.JSON"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%
AccessControl accesscontroler = AccessControl.getInstance();
accesscontroler.checkAccess(request, response);
//对服务器的所有操作，具体调用后台的哪个方法操作用method来判断执行
String userid = request.getParameter("userid");
PersonHolderDao dao = new PersonHolderDaoImpl();
		response.setContentType("application/x-json");
		List<Map<String,String>> result = dao.getMsgCount(userid);
		String amount = result.get(0).get("amount");
		//String clickurl = result.get(0).get("clickurl");
		out.write(JSON.toJSONString(amount,true));
%>
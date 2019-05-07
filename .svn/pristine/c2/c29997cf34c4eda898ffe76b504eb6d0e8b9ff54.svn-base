<%@page import="java.util.Map"%>
<%@page import="com.chinacreator.xtbg.tjy.device.service.DevAccountInfoService"%>
<%@page import="com.chinacreator.xtbg.tjy.device.service.impl.DevAccountServiceImpl"%>
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
	//设备编号
    String dev_code = request.getParameter("dev_code");
    /*********查询设备编号************/
    DevAccountInfoService service = new DevAccountServiceImpl();
    JSONObject jsonObj = new JSONObject();
    Map<String, String> maps = service.getDevAccountByCode(dev_code);
    if(!StringUtil.isBlank(maps.get("dev_code"))){
    	jsonObj.put("result",true);
    } else {
    	jsonObj.put("result",false);
    }
    response.getWriter().print(jsonObj);	
%>


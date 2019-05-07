<%@page import="com.chinacreator.xtbg.tjy.device.service.DevAccountInfoService"%>
<%@page import="com.chinacreator.xtbg.tjy.device.service.impl.DevAccountServiceImpl"%>
<%@page import="java.util.List"%>
<%@page import="com.chinacreator.xtbg.tjy.device.service.DevInfoItemService"%>
<%@page import="com.chinacreator.xtbg.tjy.device.service.impl.DevInfoItemServiceImpl"%>
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
	//设备编号
    String t_sb_id = request.getParameter("t_sb_id");
    DevAccountInfoService serviceInfo = new DevAccountServiceImpl();
    Map<String,String> bean = serviceInfo.getDevAccountBean(StringUtil.deNull(t_sb_id));
    /*********查询设备编号************/
    DevInfoItemService service = new DevInfoItemServiceImpl();
    JSONObject jsonObj = new JSONObject();
    List<Map<String, String>> maps = service.getDevInfoItemBean(bean.get("dev_code"));
    jsonObj.put("maps",maps);
   /*  if(!StringUtil.isBlank(maps.get("dev_code"))){
    	jsonObj.put("result",true);
    } else {
    	jsonObj.put("result",false);
    } */
    response.getWriter().print(jsonObj);	
%>


<%-- 
描述：获取计划登记表物品处理
作者：童佳
版本：1.0
日期：2014-03-11
 --%>
 <%@page import="com.chinacreator.xtbg.tjy.canteenitemssupplies.service.impl.OsHavaObjectServiceImpl"%>
<%@page import="com.chinacreator.xtbg.tjy.canteenitemssupplies.service.OsHavaObjectService"%>
<%@page import="com.alibaba.fastjson.JSON"%>
<%@page import="com.alibaba.fastjson.JSONArray"%>
<%@page import="com.alibaba.fastjson.JSONArray"%>
<%@page import="java.util.*"%>
 <%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.alibaba.fastjson.JSONObject"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	String osappitem = request.getParameter("osappitem");
	String busi_id = request.getParameter("busi_id");
	
	List<Map<String,String>> osappitemList = new ArrayList<Map<String,String>>();
	OsHavaObjectService osHavaObjectService = new OsHavaObjectServiceImpl();
	
	osappitemList = osHavaObjectService.queryOsAppRegObjectList(osappitem, busi_id);
	
	String jsonString  = JSON.toJSONString(osappitemList);
	//System.out.println("json字符串:"+jsonString);
	
	response.getWriter().print(jsonString);
%>
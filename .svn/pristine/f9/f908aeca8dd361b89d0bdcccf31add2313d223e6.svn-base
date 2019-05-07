<%-- 
描述：根据规格ID查询出对应的库存信息
作者：童佳
版本：1.0
日期：2014-03-11
 --%>
 <%@page import="com.chinacreator.xtbg.tjy.officesupplies.service.impl.OsHavaObjectServiceImpl"%>
<%@page import="com.chinacreator.xtbg.tjy.officesupplies.service.OsHavaObjectService"%>
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
	String it_id = request.getParameter("it_id");
	
	List<Map<String,String>> osappitemList = new ArrayList<Map<String,String>>();
	OsHavaObjectService osHavaObjectService = new OsHavaObjectServiceImpl();
	
	osappitemList = osHavaObjectService.queryHavaInfoByItId(it_id);
	
	String jsonString  = JSON.toJSONString(osappitemList);
	//System.out.println("json字符串:"+jsonString);
	
	response.getWriter().print(jsonString);
%>

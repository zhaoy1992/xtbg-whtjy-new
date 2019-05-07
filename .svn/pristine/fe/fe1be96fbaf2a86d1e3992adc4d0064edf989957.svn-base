<%-- 
描述：获取物品类别处理
作者：邱炼
版本：1.0
日期：2014-06-09
 --%>
 <%@page import="com.alibaba.fastjson.JSON"%>
<%@page import="com.alibaba.fastjson.JSONArray"%>
<%@page import="com.chinacreator.xtbg.tjy.detectionsupplies.service.impl.OsUserTypeItemServiceImpl"%>
<%@page import="com.chinacreator.xtbg.tjy.detectionsupplies.service.OsUserTypeItemService"%>
<%@page import="com.alibaba.fastjson.JSONArray"%>
<%@page import="java.util.*"%>
 <%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.alibaba.fastjson.JSONObject"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	String ofustypeValue = request.getParameter("ofustypeValue");
	String[] ofustypeValueArr = ofustypeValue.split(";");
	Map<String,String> ofustypeValueList = new HashMap<String,String>();
	OsUserTypeItemService osUserTypeItemService = new OsUserTypeItemServiceImpl();
	if(!StringUtil.nullOrBlank(ofustypeValueArr[0])){
		ofustypeValueList = osUserTypeItemService.queryOsoFtypeItemList(ofustypeValueArr[0]);
	}
	String jsonString  = JSON.toJSONString(ofustypeValueList,false);
	response.getWriter().print(jsonString);
%>

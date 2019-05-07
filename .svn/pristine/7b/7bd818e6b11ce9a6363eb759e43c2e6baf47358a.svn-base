<%@page import="com.alibaba.fastjson.JSONObject"%>
<%@page import="com.alibaba.fastjson.JSON"%>
<%@page import="com.chinacreator.business.common.tools.CacheCommonManageProxy"%>
<%
	String key = request.getParameter("key");
	String value = CacheCommonManageProxy.getSystemParam(key);
	
	JSONObject json = new JSONObject();
	json.put("value",value);
	response.getWriter().print(json);
	
%>
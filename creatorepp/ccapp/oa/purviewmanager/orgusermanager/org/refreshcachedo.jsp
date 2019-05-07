<%-- 
	描述：用户机构缓存刷新
	作者：黄艺平
	版本：1.0
	日期：2013-05-23
 --%>
<%@page import="com.chinacreator.xtbg.core.common.cache.OrgCache"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.UserCache"%>
<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkManagerAccess(request,response);
	String type = request.getParameter("type");
	UserCache userCache = new UserCache();
    OrgCache orgCache = new OrgCache();
	try {
		if("1".equals(type)) {
			orgCache.init();
			userCache.init();
		} else {
			userCache.init();
		}
	   String returnjsonstr = "{\"flag\":\"true\",\"msg\":\"操作成功\"}";
       out.print(returnjsonstr);  
	} catch (Exception e) {
		out.print("{\"flag\":\"false\",\"msg\":\"操作失败!\"}");
	} 


	
%>

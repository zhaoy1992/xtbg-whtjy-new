<%--
获取办公用品子类
王淑滨
--%>

<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.tjy.officesupplies.entity.OsupplieTypeBean"%>
<%@page import="com.chinacreator.xtbg.tjy.officesupplies.service.OsupplieTypeService"%>
<%@page import="com.chinacreator.xtbg.tjy.officesupplies.service.impl.OsupplieTypeServiceImpl"%>
<%@page import="com.alibaba.fastjson.JSON"%>
<%@page import="com.alibaba.fastjson.JSONArray"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.chinacreator.xtbg.tjy.officesupplies.service.OsUserTypeItemService"%>
<%@page import="com.chinacreator.xtbg.tjy.officesupplies.service.impl.OsUserTypeItemServiceImpl"%>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	String ofustypeValue = request.getParameter("ofustypeValue");	
	String method = request.getParameter("method");
	OsupplieTypeService service = new OsupplieTypeServiceImpl();
	OsupplieTypeBean bean = new OsupplieTypeBean();
	List<Map<String,String>> list = new ArrayList<Map<String,String>>();	
	
	if(method.equals("type")){
		bean.setParent_id(ofustypeValue);
		if(!StringUtil.isBlank(ofustypeValue)){
			list = service.getTypeList(bean);
		}
		String jsonString  = JSON.toJSONString(list);
		response.getWriter().print(jsonString);
	}else if(method.equals("name")){
		bean.setOftype_id(ofustypeValue);
		if(!StringUtil.isBlank(ofustypeValue)){
			list = service.getNameList(bean);
		}
		String jsonString  = JSON.toJSONString(list);
		response.getWriter().print(jsonString);
	}else if(method.equals("it_name")){
		OsUserTypeItemService osUserTypeItemService = new OsUserTypeItemServiceImpl();
		if(!StringUtil.nullOrBlank(ofustypeValue)){
			list = osUserTypeItemService.queryOsuserTyptItemList(ofustypeValue);
		}
		
		String jsonString  = JSON.toJSONString(list);
		response.getWriter().print(jsonString);
	}
%>

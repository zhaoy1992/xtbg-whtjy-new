<%@page import="com.chinacreator.xtbg.core.common.util.DateUtil"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.archive.service.WordArchiveService"%>
<%@page import="com.chinacreator.xtbg.core.archive.service.impl.WordArchiveServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.alibaba.fastjson.JSONObject"%>
<%
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	String user_id = accesscontroler.getUserID();
	String user_name = accesscontroler.getUserName();
	String archive_date = DateUtil.getCurrentDate();
	String busi_id = request.getParameter("busi_id");
	String number_type = request.getParameter("number_type");
	String number_year = request.getParameter("number_year");
	String number_code = StringUtil.deNull(request.getParameter("number_code"));
	String optType = request.getParameter("optType"); 
	boolean  flag  = false;
	boolean flag11 = false;
	WordArchiveService service = new WordArchiveServiceImpl();
	String number_title = number_type+"〔"+number_year+"〕    号";
	
	String jsonparam = "{'number_type':'"+number_type
		+"','number_year':'"+number_year
	    +"','number_code':'"+number_code
	 	+"','archive_user':'"+user_name
	 	+"','archive_userid':'"+user_id
		+"','archive_date':'"+archive_date
		+"','number_title':'"+number_title
	    +"','busi_id':'"+busi_id+"'}";
	    
	flag11=service.isArchiveNumberBybusId(busi_id);
	if(!flag11){
		flag = service.saveNumber(jsonparam);
	}else {
		flag = service.updateNumber(jsonparam);
	}
	JSONObject jsonObj = new JSONObject();
	jsonObj.put("result",flag);
	out.print(jsonObj);

%>

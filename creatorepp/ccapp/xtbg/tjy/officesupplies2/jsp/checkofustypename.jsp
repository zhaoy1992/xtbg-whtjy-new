<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DaoUtil"%>
<%
String path = request.getContextPath();
String actionName = request.getParameter("actionName");

if(actionName.equals("checkOfustypeName")){
	String ofustype_name = request.getParameter("ofustype_name");
    if(ofustype_name != null){
    	ofustype_name = java.net.URLDecoder.decode(ofustype_name, "UTF-8");
	}
	String ofustype_id = DaoUtil.sqlToField("select a.ofustype_id from ta_oa_hava_object a where a.ofustype_name = trim('"+ofustype_name+"')");
	response.getWriter().write("{\"ofustype_id\":\""+ofustype_id+"\"}");
}
%>
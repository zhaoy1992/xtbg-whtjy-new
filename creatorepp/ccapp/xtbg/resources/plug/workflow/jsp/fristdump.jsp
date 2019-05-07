
<%@page import="com.chinacreator.security.AccessControl"%>
<%@ page contentType="text/html; charset=GBK"%>
<% 
AccessControl accesscontroler = AccessControl.getInstance();
String chlikurl = request.getParameter("chlikurl");
String ins_id = request.getParameter("ins_id");
String busi_id = request.getParameter("busi_id");
String actInsId = request.getParameter("actInsId");
String cc_form_instanceid = request.getParameter("cc_form_instanceid");
String def_id = request.getParameter("def_id");
String procId = request.getParameter("procId");
String action_defid = request.getParameter("action_defid");
String list_type = request.getParameter("list_type");
String operType = request.getParameter("operType");
String entrance = request.getParameter("entrance");
//已办公文
String action_form = request.getParameter("action_form");
String act_name = request.getParameter("act_name");
String isdone = request.getParameter("isdone");
String url = chlikurl + "?ins_id=" + ins_id + "&busi_id=" + busi_id + "&actInsId=" + actInsId + "&cc_form_instanceid=" + cc_form_instanceid + "&def_id=" + def_id + "&procId=" + procId + "&action_defid=" + action_defid + "&list_type=" + list_type + "&operType=" + operType + "&entrance=" +entrance+"&action_form="+action_form
		     +"&act_name="+act_name+"&isdone="+isdone;
response.sendRedirect(url);
%>


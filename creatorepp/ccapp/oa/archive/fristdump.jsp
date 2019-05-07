
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<% 
AccessControl accesscontroler = AccessControl.getInstance();
String path = request.getContextPath();
String chlikurl = request.getParameter("chlikurl");
String ins_id = request.getParameter("ins_id");
String busi_id = request.getParameter("busi_id");
String list_type = request.getParameter("list_type");
String operType = request.getParameter("operType");
String act_name = request.getParameter("act_name");
String actiontype_code = request.getParameter("actiontype_code");
String busiTypeCode = request.getParameter("busiTypeCode");
String template_id = request.getParameter("template_id");
String circularize_id = request.getParameter("circularize_id");
String indexReturn  =request.getParameter("indexReturn");
if(!"uuid-1103".equals(StringUtil.deNull(busiTypeCode))){
	chlikurl = "/ccapp/oa/archive/showWordConext.jsp";
}

String url = path + chlikurl + "?ins_id=" + ins_id + "&busi_id=" + busi_id + "&list_type=" + list_type + "&operType=" + operType + "&act_name=" + act_name 
			 + "&actiontype_code=" + actiontype_code + "&busiTypeCode=" + busiTypeCode + "&template_id=" + template_id + "&circularize_id=" + circularize_id
			 +"&indexReturn=" + indexReturn;
response.sendRedirect(url);
%>


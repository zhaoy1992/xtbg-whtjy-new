<%@page import="java.util.HashMap"%>
<%@page import="com.chinacreator.xtbg.core.paper.service.impl.PaperTemplateServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.paper.service.PaperTemplateService"%>
<%@page import="com.chinacreator.xtbg.core.paper.dao.PaperTemplateDao"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.alibaba.fastjson.JSONObject"%>
<%@page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
AccessControl accesscontroler = AccessControl.getInstance();
accesscontroler.checkAccess(request, response);
	JSONObject jsonObj = new JSONObject();
    
    String template_id=request.getParameter("templateids");
    PaperTemplateService paperTemplateService = new PaperTemplateServiceImpl();
    HashMap tmplates =(HashMap)paperTemplateService.getPaperTemplateBean(template_id);
    //正文类型
    jsonObj.put("typename",tmplates.get("p_template_typename"));
    //正文
    jsonObj.put("content",tmplates.get("content"));
    
    out.print(jsonObj);
%>

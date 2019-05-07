<%--
describe:表单do页面
author:shuqi.liu
date: 2013-6-24
--%>
<%@page contentType="text/html; charset=utf-8"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="com.chinacreator.xtbg.core.form.service.Formservice"%>
<%@page import="com.chinacreator.xtbg.core.form.service.impl.FormserviceImpl"%>
<%@page import="com.alibaba.fastjson.JSONArray"%>
<%
	//AccessControl accesscontroler = AccessControl.getInstance();
	//accesscontroler.checkAccess(request, response);
	String action = request.getParameter("action");
	boolean flag = false;
	Formservice Formservice = new FormserviceImpl();
	if("save".equals(action)){//保存配置信息
		String paramJson = request.getParameter("paramJson");//属性
		Map<String,Object> map = Formservice.formAdd(request,response);
		flag = (Boolean)map.get("flag");
		 if(flag){
			 	String filePath = map.get("filePath").toString();
			 	filePath = filePath.replace("\\","\\\\");
				out.print("<script>alert('"+filePath+",生成页面成功！')</script> ");
	        }else{
				out.print("<script>alert('生成页面失败！')</script>");
	    }
		
	}else if("delTag".equals(action)){//保存配置信息
		String tag_id = request.getParameter("selectid");
		flag = Formservice.delTagConfig(tag_id);
		if(flag){
			 out.print("{\"flag\":\"true\",\"msg\":\"删除成功\"}");
		}else{
			 out.print("{\"flag\":\"false\",\"msg\":\"删除失败\"}");
		}
	}
	else if("delForm".equals(action)){//保存配置信息
		String form_ids = request.getParameter("form_ids");
		flag = Formservice.delFormConfig(form_ids);
		if(flag){
			 out.print("{\"flag\":\"true\",\"msg\":\"删除成功\"}");
		}else{
			 out.print("{\"flag\":\"false\",\"msg\":\"删除失败\"}");
		}
	}
%>

<%--
describe:表单do页面
author:shuqi.liu
date: 2013-6-24
--%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.core.form.entity.PageInitHandlerBean"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.chinacreator.xtbg.core.process.processconfig.service.impl.FlowInfoConfigServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.process.processconfig.service.FlowInfoConfigServiceIfc"%>
<%@page contentType="text/html; charset=utf-8"%>
<%@page import="java.util.List"%>
<%@page import="com.chinacreator.xtbg.core.form.service.Formservice"%>
<%@page import="com.chinacreator.xtbg.core.form.service.impl.FormserviceImpl"%>
<%@page import="com.chinacreator.xtbg.core.form.entity.OaMdColumnsBean"%>
<%@page import="com.alibaba.fastjson.JSONArray"%>
<%
	//AccessControl accesscontroler = AccessControl.getInstance();
	//accesscontroler.checkAccess(request, response);
	String action = request.getParameter("action");
	

	Formservice formservice = new FormserviceImpl();
	if("query".equals(action)){//根据表名查询字段
		String table_id = request.getParameter("table_id");//li控件ID
		String type = request.getParameter("type");//li控件ID
		List<OaMdColumnsBean> oaMdColumnsBeanList =  formservice.getCloumn(table_id,type);
		String returnJson = JSONArray.toJSONString(oaMdColumnsBeanList);
		out.print(returnJson);		
	}else if("save".equals(action)){//保存配置信息
		String paramJson = request.getParameter("paramJson");//属性
		boolean  flag = formservice.saveTagConfig(paramJson,request);
		if(flag){
			out.print("<script>alert('保存成功！');parent.setAction('update');</script>");
		}else{
			out.print("<script>alert('保存失败！')</script>");
		}
	}else if("update".equals(action)){//保存配置信息
		String paramJson = request.getParameter("paramJson");//属性
		boolean flag = formservice.updateTagConfig(paramJson,request);
	    if(flag){
			out.print("<script>alert('更新成功！');parent.setAction('update');</script>");
        }else{
			out.print("<script>alert('更新失败！')</script>");
        }
	}else if("savehide".equals(action)){
		String paramJson = request.getParameter("paramJson");//属性
		boolean flag = formservice.saveOrUpdateHideTag(paramJson,request);
	    if(flag){
			out.print("<script>alert('保存成功！')</script> ");
        }else{
			out.print("<script>alert('保存失败！')</script>");
        }
	}else if("docopyflow".equals(action)){
		String backHaddle = request.getParameter("backHaddle");

	    FlowInfoConfigServiceIfc service = new FlowInfoConfigServiceImpl();
		Map<Integer,String> proMap = new HashMap<Integer,String>();
		proMap.put(1,request.getParameter("flow_id_a"));
		proMap.put(2,request.getParameter("flow_id_b"));
		Map<String,String> map = service.copyFlowDefInfo(proMap);
		String flag = map.get("flag");
		String a = map.get("flow_version");
		String b = map.get("package_id");
		String c = map.get("flow_defid");
		out.print("<script>parent."+backHaddle+"("+flag+",'"+a+"','"+b+"','"+c+"')</script>");
	}else if("initSelectObj".equals(action)){
		String objId = request.getParameter("objId");
		if(objId.equals("default_value")){
			String className = request.getParameter("dataArg");
			PageInitHandlerBean bean = null;
			if(!StringUtil.nullOrBlank(className)){
				try{
					bean = (PageInitHandlerBean)Class.forName(className).newInstance();
				}catch(Exception e){
					bean = new PageInitHandlerBean();
				}
			}else{
				bean = new PageInitHandlerBean();
			}
			if(bean!=null){
				String returnJson = JSONArray.toJSONString(bean.getPageDefaultDataName());
				out.print(returnJson);
			}
		}
	}
	
	
%>

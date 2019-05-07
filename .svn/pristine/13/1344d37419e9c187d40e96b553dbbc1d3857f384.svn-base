<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.yimingju.carmanage.service.CarManageYoukaService"%>
<%@page import="com.chinacreator.xtbg.yimingju.carmanage.service.impl.CarManageYoukaServiceImpl"%>
<%@page import="com.chinacreator.xtbg.yimingju.carmanage.entity.CarManageYoukaBean"%>
<%@page import="com.chinacreator.xtbg.core.common.util.RequestBeanUtils"%>
<%@page import="com.alibaba.fastjson.JSON"%>
<%@page import="java.util.regex.Pattern"%>
<%@page import="java.util.regex.Matcher"%>

<%
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	
	boolean flag = false;
	
	String hidden_action = request.getParameter("hidden_action");
	CarManageYoukaService service = new CarManageYoukaServiceImpl();
	
	if(hidden_action.equals("update")){
		CarManageYoukaBean bean = new CarManageYoukaBean();
		bean = (CarManageYoukaBean)RequestBeanUtils.getValuesByRequest(request,bean);
		flag = service.update(bean);
	}
	

%>


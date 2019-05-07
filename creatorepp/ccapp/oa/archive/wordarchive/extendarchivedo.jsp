
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.core.archive.gwcs.dao.impl.ReceiveGwWithFlowDaoImpl"%>
<%@page import="com.chinacreator.xtbg.core.common.startup.LoadSpringContext"%>
<%@page import="java.util.Map"%>
<%@page import="com.alibaba.fastjson.JSONObject"%>
<%
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	String gwreceive_id = StringUtil.deNull(request.getParameter("gwreceive_id"));
	String ins_id = StringUtil.deNull(request.getParameter("ins_id"));
	String org_id = StringUtil.deNull(request.getParameter("oa_org_id"));
	String optType = request.getParameter("optType");

	
	ReceiveGwWithFlowDaoImpl dao = (ReceiveGwWithFlowDaoImpl)LoadSpringContext.getApplicationContext().getBean("hnsbgt_lwdj");
	
	if("setOrgId".equals(optType)){//保存ORG_ID
		boolean  flag  = false;
  		flag =  dao.setGwreceiveOrgId(gwreceive_id,ins_id,org_id);
  		out.print(JSONObject.toJSON(flag));
	}else if("queryOrgId".equals(optType)){//查询ORG_ID
		String oa_org_id = "";
		oa_org_id =  dao.queryGwreceiveOrgId(gwreceive_id,ins_id);
		out.print(JSONObject.toJSON(oa_org_id));
	}
%>


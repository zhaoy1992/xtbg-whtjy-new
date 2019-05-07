<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.chinacreator.xtbg.tjy.officesupplies.service.OsAppObjectService"%>
<%@page import="com.chinacreator.xtbg.tjy.officesupplies.service.impl.OsAppObjectServiceImpl"%>
<%@page import="com.chinacreator.xtbg.tjy.officesupplies.entity.OsAppObjectBean"%>
<%@page import="com.chinacreator.xtbg.core.common.util.RequestBeanUtils"%>
<%@page import="com.chinacreator.xtbg.core.common.util.ResultMap"%>
<%@page import="com.chinacreator.xtbg.core.common.util.AResultCode"%>
<%@page import="com.alibaba.fastjson.JSON"%>
<%
String path = request.getContextPath();

String method = request.getParameter("method");

OsAppObjectBean bean = new OsAppObjectBean();
bean = (OsAppObjectBean)RequestBeanUtils.getValuesByRequest(request,bean);
OsAppObjectService service = new OsAppObjectServiceImpl();
if(method.equals("getCountData")){
	response.setContentType("application/x-json");
	ResultMap<AResultCode,OsAppObjectBean> result = service.getCountData(bean);
	out.write(JSON.toJSONString(result,true));
}else if(method.equals("getCount")){
	response.setContentType("application/x-json");
	ResultMap<AResultCode,OsAppObjectBean> result = service.getCount(bean);
	out.write(JSON.toJSONString(result,true));
}
%>


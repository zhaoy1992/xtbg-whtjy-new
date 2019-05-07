<%@page import="com.alibaba.fastjson.JSON"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.chinacreator.xtbg.core.common.util.BeanUtil"%>
<%@page import="com.chinacreator.xtbg.core.archive.entity.SplitUnitBean"%>
<%@page import="com.chinacreator.xtbg.core.archive.service.SplitUnitService"%>
<%@page import="com.chinacreator.xtbg.core.archive.service.impl.SplitUnitServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.common.util.ResultMap"%>
<%@page import="com.chinacreator.xtbg.core.common.util.ResultCode"%>
<%
	//公共信息分类接口jsp
//对服务器的所有操作，具体调用后台的那个方法操作用method来判断执行
String method = request.getParameter("method");
BeanUtil<SplitUnitBean> beanUtil = new BeanUtil<SplitUnitBean>();
SplitUnitBean bean = beanUtil.requestToBean(request,SplitUnitBean.class);

SplitUnitService service = new SplitUnitServiceImpl();
if(method != null || "".equals(method)){
	if(method.equals("add")){
		response.setContentType("application/x-json");
		ResultMap<ResultCode,SplitUnitBean> result = service.insert(bean);
		out.write(JSON.toJSONString(result,true));
	} else if(method.equals("update")){
		response.setContentType("application/x-json");
		ResultMap<ResultCode,SplitUnitBean> result = service.update(bean);
		out.write(JSON.toJSONString(result,true));
	} else if(method.equals("getById")){
		response.setContentType("application/x-json");
		ResultMap<ResultCode,SplitUnitBean> result = service.getById(bean.getUnit_id());
		out.write(JSON.toJSONString(result,true));
	} else if(method.equals("list")){
		response.setContentType("application/x-json");
		ResultMap<ResultCode,List<SplitUnitBean>> result = service.list(bean);
		out.write(JSON.toJSONString(result,true));
	} else if(method.equals("deleteById")){
		response.setContentType("application/x-json");
		ResultMap<ResultCode,SplitUnitBean> result = service.deleteById(bean.getUnit_id());
		out.write(JSON.toJSONString(result,true));
	} else if(method.equals("getUnitByGwcsOrgId")){
		response.setContentType("application/x-json");
		ResultMap<ResultCode,SplitUnitBean> result = service.getUnitByGwcsOrgId(bean);
		out.write(JSON.toJSONString(result,true));
	} 
}
%>
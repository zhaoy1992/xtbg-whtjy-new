<%@page import="com.alibaba.fastjson.JSON"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.chinacreator.xtbg.core.common.util.ResultMap"%>
<%@page import="com.chinacreator.xtbg.core.common.util.ResultCode"%>
<%@page import="com.chinacreator.xtbg.core.archive.service.GWCSUnitService"%>
<%@page import="com.chinacreator.xtbg.core.archive.service.impl.GWCSUnitServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.archive.entity.GWCSUnitBean"%>
<%@page import="com.chinacreator.xtbg.core.archive.service.BudgetFileService"%>
<%@page import="com.chinacreator.xtbg.core.archive.service.impl.BudgetFileServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.archive.entity.BudgetDetailBean"%>
<%
//对服务器的所有操作，具体调用后台的那个方法操作用method来判断执行
String method = request.getParameter("method");
String type = request.getParameter("type");
String parent_id = request.getParameter("parent_id");
String ins_id = request.getParameter("ins_id");

GWCSUnitService service = new GWCSUnitServiceImpl();
BudgetFileService fileService = new BudgetFileServiceImpl();
if(method != null || "".equals(method)){
	if(method.equals("list")){
		response.setContentType("application/x-json");
		ResultMap<ResultCode,List<GWCSUnitBean>> result = service.list(parent_id);
		out.write(JSON.toJSONString(result,true));
	} else if(method.equals("listByConfig")){
		response.setContentType("application/x-json");
		String send_org_config = request.getParameter("send_org_config");
		ResultMap<ResultCode,List<GWCSUnitBean>> result = service.listByConfig(type,send_org_config);
		out.write(JSON.toJSONString(result,true));
	} else if(method.equals("getGwcsOrg")){
		response.setContentType("application/x-json");
		ResultMap<ResultCode, List<BudgetDetailBean>> result = fileService.getGwcsOrg(ins_id);
		out.write(JSON.toJSONString(result,true));
	}
}
%>
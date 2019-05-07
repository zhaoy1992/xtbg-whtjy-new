<%@page import="com.alibaba.fastjson.JSON"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.chinacreator.xtbg.core.common.util.BeanUtil"%>
<%@page import="com.chinacreator.xtbg.core.common.util.ResultMap"%>
<%@page import="com.chinacreator.xtbg.core.common.util.ResultCode"%>
<%@page import="com.chinacreator.xtbg.core.archive.entity.BudgetDetailBean"%>
<%@page import="com.chinacreator.xtbg.core.archive.service.BudgetDetailService"%>
<%@page import="com.chinacreator.xtbg.core.archive.service.impl.BudgetDetailServiceImpl"%>
<%
	//公共信息分类接口jsp
//对服务器的所有操作，具体调用后台的那个方法操作用method来判断执行
String method = request.getParameter("method");
BeanUtil<BudgetDetailBean> beanUtil = new BeanUtil<BudgetDetailBean>();
BudgetDetailBean bean = beanUtil.requestToBean(request,BudgetDetailBean.class);

BudgetDetailService service = new BudgetDetailServiceImpl();
if(method != null || "".equals(method)){
	if(method.equals("deleteById")){
		response.setContentType("application/x-json");
		ResultMap<ResultCode,BudgetDetailBean> result = service.deleteByIds(bean.getDetail_id());
		out.write(JSON.toJSONString(result,true));
	}
}
%>
<%@page import="com.chinacreator.xtbg.caizhengting.ibrary.service.impl.IbraryBookInfoServiceImpl"%>
<%@page import="com.chinacreator.xtbg.caizhengting.ibrary.service.IbraryBookInfoService"%>
<%@page import="com.alibaba.fastjson.JSON"%>
<%@page import="com.chinacreator.xtbg.pub.common.ResultCode"%>
<%@page import="com.chinacreator.xtbg.pub.common.ResultMap"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.chinacreator.xtbg.pub.util.BeanUtil"%>
<%
	//公共信息分类接口jsp
//对服务器的所有操作，具体调用后台的那个方法操作用method来判断执行
String method = request.getParameter("method");
String id = request.getParameter("id");

IbraryBookInfoService service = new IbraryBookInfoServiceImpl();
if(method != null || "".equals(method)){
	if(method.equals("getCode")){
		response.setContentType("application/x-json");
		String result = service.getbookCode(id);
		out.write(JSON.toJSONString(result,true));
	}
}
%>
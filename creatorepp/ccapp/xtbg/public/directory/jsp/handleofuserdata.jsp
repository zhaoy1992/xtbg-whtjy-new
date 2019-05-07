<%-- 
	描述：望城 用户简历信息操作jsp
	作者：陈建华
	版本：1.0
	日期：2013-7-25
 --%>
<%@page import="com.alibaba.fastjson.JSON"%>
<%@page import="com.chinacreator.xtbg.pub.common.ResultCode"%>
<%@page import="com.chinacreator.xtbg.pub.common.ResultMap"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.chinacreator.xtbg.pub.directory.service.UserDataServiceIfc"%>
<%@page import="com.chinacreator.xtbg.pub.directory.service.impl.UserDataServiceImpl"%>
<%@page import="com.chinacreator.xtbg.pub.directory.entity.UserData"%>
<%
//对服务器的所有操作，具体调用后台的那个方法操作用method来判断执行

String method = request.getParameter("method");
String user_id = request.getParameter("user_id");
String id = request.getParameter("id");

UserDataServiceIfc service = new UserDataServiceImpl();
if(method != null || "".equals(method)){
	if(method.equals("list")){
		response.setContentType("application/x-json");
		ResultMap<ResultCode,List<UserData>> result = service.list(user_id);
		out.write(JSON.toJSONString(result,true));
	} else if (method.equals("delete")){
		response.setContentType("application/x-json");
		ResultMap<ResultCode,UserData> result = service.delete(id);
		out.write(JSON.toJSONString(result,true));
	}
}
%>
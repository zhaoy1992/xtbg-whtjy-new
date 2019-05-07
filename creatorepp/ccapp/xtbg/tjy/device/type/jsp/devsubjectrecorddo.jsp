<%--
  Description：仪器设备标对记录表action页面
  Author：AutoGenerator
  Version：1.0
  Date：Fri Apr 04 14:01:03 CST 2014
--%>
<%@ page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.alibaba.fastjson.JSON"%>
<%@page import="com.chinacreator.xtbg.core.common.util.ResultCode"%>
<%@page import="com.chinacreator.xtbg.core.common.util.ResultMap"%>
<%@page import="com.chinacreator.xtbg.core.common.util.BeanUtil"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.tjy.device.entity.DevSubjectRecordBean"%>
<%@page import="com.chinacreator.xtbg.tjy.device.service.DevSubjectRecordService"%>
<%@page import="com.chinacreator.xtbg.tjy.device.service.impl.DevSubjectRecordServiceImpl"%>
<%
AccessControl accesscontroler = AccessControl.getAccessControl();
accesscontroler.checkAccess(request, response);
//对服务器的所有操作，具体调用后台的哪个方法操作用method来判断执行
String method = request.getParameter("method");
BeanUtil<DevSubjectRecordBean> beanUtil = new BeanUtil<DevSubjectRecordBean>();
request.setCharacterEncoding("UTF-8");
DevSubjectRecordBean bean = beanUtil.requestToBean(request,DevSubjectRecordBean.class);

DevSubjectRecordService service = new DevSubjectRecordServiceImpl();
if(method != null || "".equals(method)){
	if(method.equals("insert")){
		response.setContentType("application/x-json");
		ResultMap<ResultCode,DevSubjectRecordBean> result = service.insert(bean);
		out.write(JSON.toJSONString(result,true));
	} else if(method.equals("update")){
		response.setContentType("application/x-json");
		ResultMap<ResultCode,DevSubjectRecordBean> result = service.update(bean);
		out.write(JSON.toJSONString(result,true));
	} else if(method.equals("getById")){
		response.setContentType("application/x-json");
		ResultMap<ResultCode,DevSubjectRecordBean> result = service.getById(bean);
		out.write(JSON.toJSONString(result,true));
	} else if(method.equals("list")){
		response.setContentType("application/x-json");
		ResultMap<ResultCode,List<DevSubjectRecordBean>> result = service.list(bean);
		out.write(JSON.toJSONString(result,true));
	} else if(method.equals("delete")){
		response.setContentType("application/x-json");
		ResultMap<ResultCode,DevSubjectRecordBean> result = service.delete(bean.getSub_id());
		out.write(JSON.toJSONString(result,true));
	}
}
%>

<%--
删除环节表单配置信息form
作者：戴连春
日期：2013-06-05
 --%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@page
	import="com.chinacreator.xtbg.core.process.processconfig.service.*"%>
<%@page
	import="com.chinacreator.xtbg.core.process.processconfig.service.impl.*"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%
	String msg = "";
	try {
		AccessControl control = AccessControl.getInstance();
		control.checkAccess(request, response);
		String ids = StringUtil.deNull(request.getParameter("ids"));
		Map<Integer,String> procMap = new HashMap<Integer,String>();
		procMap.put(1,ids);
		FlowInfoConfigServiceIfc service = new FlowInfoConfigServiceImpl();
		msg = service.copyFlowInfo(procMap);
	} catch (Exception e) {
		e.printStackTrace();
	}
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title></title>
<script type="text/javascript">
parent.doReturnOK("<%=msg%>");//操作成功后调用父页面方法
</script>
</head>
<body>

</body>
</html>
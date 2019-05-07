<%-- 
描述：业务类型分类DO页面
作者：shuqi.liu
版本：1.0
日期：2013-07-23
 --%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="com.chinacreator.xtbg.core.common.util.RequestBeanUtils"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.pubconfig.service.impl.FlowBusitypeServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.pubconfig.service.FlowBusitypeServiceIfc"%>
<%@page import="com.chinacreator.xtbg.core.pubconfig.entity.FlowBusitypeTypeBean" %>
<%@ page contentType="text/html; charset=utf-8"%>

<head>
<title>业务类型分类页面</title>
<%
String path = request.getContextPath();
AccessControl accesscontroler = AccessControl.getAccessControl();
accesscontroler.checkAccess(request, response);
boolean flag = false;
String action = request.getParameter("action");
String subid=request.getParameter("subid");
FlowBusitypeTypeBean flowBusitypeTypeBean=new FlowBusitypeTypeBean();
FlowBusitypeServiceIfc service = new FlowBusitypeServiceImpl();
flowBusitypeTypeBean = (FlowBusitypeTypeBean)RequestBeanUtils.getValuesByRequest(request,flowBusitypeTypeBean);
Map<String, String> viewMap = new HashMap<String, String>();
if("addType".equals(action)) {
	flag=service.addBusitypeType(flowBusitypeTypeBean);
	
} else if("deleteType".equals(action)) {
	String busitype_type_code=request.getParameter("busitype_type_code");
	flag=service.delBusitypeType(busitype_type_code);
	flag=true;
} else if("updateType".equals(action)){
	flag=service.updateBusitypeType(flowBusitypeTypeBean);
}

%>
<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript">
var mes = "";
var bool = true;
var action = "<%=action%>";
var subid = "<%=subid%>"
if(<%=flag%>){
	mes = "操作成功"; 
	if(action == "deleteType"){
		window.parent.parent.parent.location.reload();
	}else if(action ="addType"){
		removeAlertWindows(subid, false, "111", "123", true, "<%=path%>/ccapp/oa/pubconfig/jsp/flowbusitypetree.jsp","1234");
	}else{
		removeAlertWindows(subid, false, "111", "123", true, "<%=path%>/ccapp/oa/pubconfig/jsp/flowbusitypetree.jsp","1234");
	}
}else{
	mes = "操作失败"	;
	bool = false;
}	
</script>
</head>
</html>
<%-- 
描述：节假日管理处理页面
作者：肖杰
版本：1.0
日期：2013-10-23
 --%>
<%@page import="com.chinacreator.xtbg.core.holiday.entity.Daily"%>
<%@page import="com.chinacreator.xtbg.core.holiday.service.impl.DailyServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.holiday.service.DailyService"%>
<%@page import="com.chinacreator.xtbg.core.sysparam.entity.SysParamvalueBean"%>
<%@page import="com.chinacreator.xtbg.core.sysparam.service.impl.SysParamServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.sysparam.service.SysParamServiceIfc"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="com.chinacreator.xtbg.core.common.util.RequestBeanUtils"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@ page contentType="text/html; charset=utf-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<head>
<title>节假日管理处理页面</title>
<%
AccessControl accesscontroler = AccessControl.getAccessControl();
accesscontroler.checkAccess(request, response);
boolean flag = false;
boolean flag1 = false;
String subid=request.getParameter("subid");
String action = request.getParameter("action");


Daily daily=new Daily();
daily = (Daily)RequestBeanUtils.getValuesByRequest(request,daily);

DailyService service=new DailyServiceImpl();
Map<String, String> viewMap = new HashMap<String, String>();
String msg="";
if("addorupdate".equals(action)) {
	msg=service.findAcross(daily);
	flag1=StringUtil.isBlank(msg);
	flag=true;
	if(flag1){
		flag=service.addorupdateDaily(daily);
	}
} else if("deldaily".equals(action)) {
	String work_id=request.getParameter("work_id");
	flag=service.delDailyByIds(work_id);
	flag1=true;
} 


%>
<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript">
var mes = "";
var bool = true;
var action = "<%=action%>";
var subid="<%=subid%>";
if(<%=flag%>){
	if(<%=flag1%>){
		bool = false;
		mes = "操作成功"; 
		var submitAlertOK = function(){
			if(action == "deldaily"){
				window.parent.location.reload();
			}else if(action=="addorupdate"){
				parent.back();
			}
		}
		var p={
			headerText:'操作信息',
			okName:'确认',
			okFunction:submitAlertOK
		};  
		alert("操作成功！",p);
	}else{
		
		alert("此记录将于其它的记录：<%=msg%>产生交叉，不能插入！");
	}
}else{
	mes = "操作失败"	;
	bool = false;
}
</script>
</head>
<body>
</body> 
</html>
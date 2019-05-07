<%-- 
描述：表单环节定义处理页面
作者：肖杰
版本：1.0
日期：2013-07-31
 --%>
<%@page import="com.chinacreator.xtbg.core.pubconfig.service.impl.FormActionServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.pubconfig.service.FormActionServiceIfc"%>
<%@page import="com.chinacreator.xtbg.core.pubconfig.entity.FormActionBean"%>
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
<title>表单环节定义处理页面</title>
<%
AccessControl accesscontroler = AccessControl.getAccessControl();
accesscontroler.checkAccess(request, response);
boolean flag = false;
boolean flag1=true;
String subid=request.getParameter("subid");
String action = request.getParameter("action");
String table_id = request.getParameter("table_id");

FormActionBean formActionBean=new FormActionBean();
FormActionServiceIfc formActionServiceIfc = new FormActionServiceImpl();
formActionBean = (FormActionBean)RequestBeanUtils.getValuesByRequest(request,formActionBean);
//Map<String, String> viewMap = new HashMap<String, String>();
//viewMap=sysParamServiceIfc.getSysParamvalueByPvcode(sysParamvalueBean.getP_value_code(),sysParamvalueBean.getP_code());
if("addFormAction".equals(action)) {
	flag=formActionServiceIfc.addFormAction(formActionBean, table_id);
} else if("deleteFormAction".equals(action)) {
	String action_id=request.getParameter("action_id");
	flag=formActionServiceIfc.deleteFormAction(action_id);
} else if("updateFormAction".equals(action)){
	flag=formActionServiceIfc.updateFormAction(formActionBean);
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
	bool = false;
	if(<%=flag1%>){
		mes = "操作成功"; 
		var submitAlertOK = function(){
			//window.parent.removeWindows('<%=subid %>',true);
			if(action == "deleteFormAction"){
				window.parent.location.reload();
			}else if(action=="updateFormAction"){
				closeAlertWindows(subid,false,true);
			}else if(action == "addFormAction"){
				closeAlertWindows(subid,false,true);
			}
		}
		var p={
			headerText:'操作信息',
			okName:'确认',
			okFunction:submitAlertOK
		};  
		alert("操作成功！",p);
	}else{
		alert('该参数值编号在该参数编号下已经被引用，请换另外一个编号！');
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
<%-- 
描述：系统参数处理页面
作者：肖杰
版本：1.0
日期：2013-07-15
 --%>
<%@page import="com.chinacreator.xtbg.core.sysparam.service.impl.SysParamServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.sysparam.service.SysParamServiceIfc"%>
<%@page import="com.chinacreator.xtbg.core.sysparam.entity.SysParamBean"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="com.chinacreator.xtbg.core.common.util.RequestBeanUtils"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@ page contentType="text/html; charset=utf-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<head>
<title>系统参数处理页面</title>
<%
String path=request.getContextPath();
AccessControl accesscontroler = AccessControl.getAccessControl();
accesscontroler.checkAccess(request, response);
boolean flag = false;
boolean flag1=true;
String subid=request.getParameter("subid");
String action = request.getParameter("action");
Object treeNode = request.getParameter("treeNode");

SysParamBean sysParamBean=new SysParamBean();
SysParamServiceIfc sysParamServiceIfc = new SysParamServiceImpl();
sysParamBean = (SysParamBean)RequestBeanUtils.getValuesByRequest(request,sysParamBean);
Map<String, String> viewMap = new HashMap<String, String>();
viewMap=sysParamServiceIfc.getSysParamByPcode(sysParamBean.getP_code());
if("addSysParam".equals(action)) {
	if("".equals(StringUtil.deNull(viewMap.get("p_id")))){
		flag=sysParamServiceIfc.addSysParam(sysParamBean);
	}else{
		flag=true;
		flag1=false;
	}
} else if("deleteSysParam".equals(action)) {
	String p_id=request.getParameter("p_id");
	flag=sysParamServiceIfc.deleteSysParam(p_id);
} else if("updateSysParam".equals(action)){
	if("".equals(StringUtil.deNull(viewMap.get("p_id")))||(viewMap.get("p_id").equals(sysParamBean.getP_id()))){
		flag=sysParamServiceIfc.updateSysParam(sysParamBean);
	}else{
		flag=true;
		flag1=false;
	}
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
			if(action == "deleteSysParam"){
				window.parent.location.reload();
			}else {
				window.parent.parent.location.href="<%=path%>/ccapp/oa/sysparam/jsp/sysparaminfo.jsp?&subid=updatesysparam1&p_id=<%=sysParamBean.getP_id()%>";
				<%-- openWindows('sub_main','修改','../../sysparam/jsp/sysparaminfo.jsp?&subid=sub_main&p_id=<%=sysParamBean.getP_id()%>','qzh',false,window); --%>
			}
		}
		var p={
			headerText:'操作信息',
			okName:'确认',
			okFunction:submitAlertOK
		};  
		alert("操作成功！",p);
	}else{
		alert('该编号已经被引用，请更换另外一个编号！');
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
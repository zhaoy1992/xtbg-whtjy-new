
<%@page import="com.chinacreator.xtbg.suxian.electroniccheck.service.ElectServiceIfc"%>
<%@page import="com.chinacreator.xtbg.suxian.electroniccheck.dao.imploracle.ElectDaoImpl"%>
<%@page import="com.chinacreator.xtbg.suxian.electroniccheck.service.impl.ElectServiceImpl"%>
<%@page import="com.chinacreator.xtbg.suxian.electroniccheck.dao.ElectResetDao"%>
<%@page import="java.util.Date"%>
<%@page import="com.chinacreator.xtbg.pub.tree.dao.ResourceConfigDao"%>
<%@page import="com.chinacreator.xtbg.pub.tree.dao.impl.ResouceConfigDaoImpl"%>
<%@page import="com.chinacreator.xtbg.pub.tree.entity.ResourceRoleUserBean"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.pub.util.DaoImplClassUtil"%>
<%@page import="com.chinacreator.xtbg.suxian.electroniccheck.dao.ElectInfoDao"%>
<%@page import="com.chinacreator.eform.util.Escape"%>
<%@page import="com.chinacreator.xtbg.suxian.electroniccheck.entity.ElectInfoBean"%>

<%@page import="com.chinacreator.xtbg.pub.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.suxian.electroniccheck.entity.ElectResetBean"%>
<%@page import ="java.text.SimpleDateFormat"%>
<%@page import ="com.chinacreator.xtbg.pub.util.DaoUtil"%>
<%@ page contentType="text/html; charset=GBK"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<title>JGRID</title>

<%
	String ip = request.getHeader("x-forwarded-for");
	if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
	   ip = request.getHeader("Proxy-Client-IP");
	}
	if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
	   ip = request.getHeader("WL-Proxy-Client-IP");
	}
	if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
	   ip = request.getRemoteAddr();
	} 
	
	/*  AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	String userid=accesscontroler.getUserID();
	String username = accesscontroler.getUserName();
	String userAccout = accesscontroler.getUserAccount(); */
	
	String workUser_name = StringUtil.deNull(request.getParameter("workUser_name"));
	String[][] arryUser = DaoUtil.SqlToFieldsArray("select t.user_id,t.user_realname,t.user_name from td_sm_user t where t.user_name='"+workUser_name+"'");
	
	boolean resultFlag = false;
	String result = ""; //消息信息
	if(arryUser.length!=0){
		ElectServiceIfc electserviceifc = new ElectServiceImpl();
		String[] arrResult = electserviceifc.punchStartClock(arryUser[0][0]+"",arryUser[0][1]+"",arryUser[0][2]+"",ip);
		resultFlag = new Boolean(arrResult[0]);
		result = arrResult[1];
	}
	
%>
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script type="text/javascript"
			src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js" charset="utf-8"></script>
<script type="text/javascript">
var mes = "";
var bool = true;
if(<%=resultFlag%>){
	mes = "<%=result%>"; 
}else{
	mes = "操作失败"	;
	bool = false;
}
var ok=function(){
	//window.parent.location.reload();
}
if(removeAlertWindows('',false,bool,mes,true)){
	if(bool){
		window.top.alert(mes,{headerText:'处理结果',okName:'确认',okFunction:ok})
	}
	else{
		window.top.alert(mes)
	}
}
</script>
<body>
</body> 
</html>
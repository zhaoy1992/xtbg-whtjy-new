
<%@page import="com.chinacreator.xtbg.pub.util.DaoUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.chinacreator.xtbg.pub.util.StringUtil"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.business.common.tools.CacheCommonManageProxy"%>
<html>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	boolean success = accesscontroler.checkAccess(request, response);
	String path = request.getContextPath();
	String userid = accesscontroler.getUserID();
	String username = accesscontroler.getUserName();//获得当前登录用户姓名
	String loginName =  accesscontroler.getUserAccount(); //登录名
	//郴州即时通讯的模块
	//ElectDao electDao = new ElectDaoImpl();
	String userPassword = DaoUtil.SqlToField("select u.user_password from td_sm_user u  where u.user_id = '"+userid+"'");
	//String openfire_server_IP = CacheCommonManageProxy.getSystemParam("openfire_server_IP");
	
	//特检院OA openfire访问地址 根据访问IP来设置 
	String openfire_server_IP = request.getServerName();
%>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>即时通讯</title>
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js" charset="UTF-8"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript">

//及时通讯入口
var tongxun = function(){
	var jstxButton = window.parent.document.getElementById('_firstPagerOpenfireFirstAAAS_bodymian');
	jstxButton.click();
}


//弹出选择的url
function openmodule(menuID,moduleName,url){
	url = '<%=path%>'+url;
	openWindows(menuID,moduleName,url,'_firstPagerAAAS',false,window,false,true);
}


//页面加载完成后
window.onload=function(){
	var jstxButton = window.parent.document.getElementById('_firstPagerAAAS_bodymian');
	jstxButton.click();
}
</script>
</head>
<body style="height: 100%;width: 100%;">
<iframe style="width: 100%;height: 580px;" src="<%=path%>/ccapp/xtbg/openfire/SparkWeb.html?username=<%=StringUtil.deNull(loginName)%>&password=<%=StringUtil.deNull(userPassword)%>&server=<%=openfire_server_IP%>" id="loginMessges"></iframe>
</body>
</html>
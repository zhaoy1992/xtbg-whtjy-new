<%@page import="com.chinacreator.xtbg.yimingju.mail.service.MailConfigServiceIfc"%>
<%@page import="com.chinacreator.xtbg.yimingju.mail.service.impl.MailConfigServiceImpl"%>
<%@page import="com.chinacreator.xtbg.yimingju.mail.entity.MailBoxMemoryConfigBean"%>
<%@page import="com.chinacreator.xtbg.pub.dbbase.dao.BaseDao"%>
<%@page import="com.chinacreator.xtbg.yimingju.mail.dao.impl.MailConfigDaoImpl"%>
<%@page import="com.chinacreator.xtbg.yimingju.mail.dao.MailConfigDao"%>
<%@page import="com.chinacreator.xtbg.pub.util.DaoImplClassUtil"%>
<%@page import="java.util.*"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.pub.util.DaoUtil"%>
<%@ page contentType="text/html; charset=GBK"%>
<%@page import="com.chinacreator.xtbg.pub.util.StringUtil"%>
<%
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	
	String user_ids = request.getParameter("user_ids");
	String memory=request.getParameter("memory");
	boolean flag = false;
	MailConfigServiceIfc mailConfigServiceIfc = new MailConfigServiceImpl();
	flag = mailConfigServiceIfc.saveMailConfigInfo(user_ids, memory);
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>邮箱配置信息保存form</title>
</head>
<body>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>

<script type="text/javascript">
var mes = "";
var flag = <%=flag%>;
var bool = true;
if(flag){
	mes = "操作成功";
}else{
	mes = "操作失败"	;
	
	bool = false;
}

var OKF = function(){
	
}
window.top.alert(mes,{headerText:'提示',okName:'确认',okFunction:OKF});
</script>
</body>
</html>
<%-- 
描述：文号维护处理界面
作者：肖杰
版本：1.0
日期：2013-10-18
 --%>
<%@page import="com.chinacreator.xtbg.core.wordnumdef.service.impl.WordNumDefServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.wordnumdef.dao.impl.WordNumDefDaoImpl"%>
<%@page import="com.chinacreator.xtbg.core.wordnumdef.service.WordNumDefService"%>
<%@page import="com.chinacreator.xtbg.core.wordnumdef.entity.WordNumberDefBean"%>
<%@page import="com.chinacreator.xtbg.core.dict.entity.DictTypeBean"%>
<%@page import="com.chinacreator.xtbg.core.dict.service.impl.DictServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.dict.service.DictServiceIfc"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="com.chinacreator.xtbg.core.common.util.RequestBeanUtils"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@ page contentType="text/html; charset=utf-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<head>
<title>文号维护处理界面</title>
<%
String path = request.getContextPath();
AccessControl accesscontroler = AccessControl.getAccessControl();
accesscontroler.checkAccess(request, response);
boolean flag = false;

String action = request.getParameter("action");

WordNumberDefBean bean=new WordNumberDefBean();
WordNumDefService service=new WordNumDefServiceImpl();
bean = (WordNumberDefBean)RequestBeanUtils.getValuesByRequest(request,bean);
Map<String, String> viewMap = new HashMap<String, String>();

if("addorupdatewordnum".equals(action)) {
	String oldtype=request.getParameter("oldtype");
	String oldyear=request.getParameter("oldyear");
	flag=service.addorupdateWordNum(bean,oldtype,oldyear);
} else if("deletewordnum".equals(action)) {
	flag=service.deleteWordNum(bean);
} 


%>
<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript">
var mes = "";
var bool = true;
var action = "<%=action%>";
if(<%=flag%>){
	bool = false;
	mes = "操作成功"; 
	var submitAlertOK = function(){
		parent.treereload();
	}
	var p={
		headerText:'操作信息',
		okName:'确认',
		okFunction:submitAlertOK
	};  
	alert("操作成功！",p);
	
}else{
	mes = "操作失败"	;
	bool = false;
	alert(mes);
}
</script>
</head>
<body>
</body> 
</html>
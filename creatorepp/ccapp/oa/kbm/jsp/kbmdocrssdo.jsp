<%-- 
描述：知识库文档订阅处理页面
作者：肖杰
版本：1.0
日期：2013-08-13
 --%>
<%@page import="com.chinacreator.xtbg.core.kbm.service.impl.KbmDocRssServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.kbm.service.KbmDocRssService"%>
<%@page import="com.chinacreator.xtbg.core.kbm.entity.KbmDocRssBean"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="com.chinacreator.xtbg.core.common.util.RequestBeanUtils"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@ page contentType="text/html; charset=utf-8"%>  
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<head>
<title>知识库文档订阅处理页面</title>
<%
String path=request.getContextPath();
AccessControl accesscontroler = AccessControl.getAccessControl();
accesscontroler.checkAccess(request, response);
boolean flag = false;
String subid=request.getParameter("subid");
String action = request.getParameter("action");

KbmDocRssBean bean=new KbmDocRssBean();
KbmDocRssService service = new KbmDocRssServiceImpl();
bean = (KbmDocRssBean)RequestBeanUtils.getValuesByRequest(request,bean);
if("add".equals(action)) {
	flag=service.addKbmDocRss(bean);
	
} else if("del".equals(action)) {
	String k_rss_id=request.getParameter("k_rss_id");
	flag=service.deleteKbmDocRss(k_rss_id);
} else if("update".equals(action)){
	flag=service.updKbmDocRss(bean);
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
	mes = "操作成功"; 
	var submitAlertOK = function(){
		if(action == "del"){
			window.parent.location.reload();
		}else {
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
	mes = "操作失败"	;
	bool = false;
}
</script>
</head>
<body>
</body> 
</html>

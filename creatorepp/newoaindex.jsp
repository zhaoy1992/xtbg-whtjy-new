<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
AccessControl accesscontroler = AccessControl.getInstance();
accesscontroler.checkAccess(request, response);
String path = accesscontroler.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="com.chinacreator.security.AccessControl"%><html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="<%=path %>/ccapp/oa/common/newlayout/resources/css/global.css" type="text/css" rel="stylesheet" />
<link href="<%=path %>/ccapp/oa/common/newlayout/resources/css/layout.css" type="text/css" rel="stylesheet" />
<title>首页</title>
<script type="text/javascript" src="<%=path %>/ccapp/oa/resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="<%=path %>/ccapp/oa/resources/util/public.js" ></script>
<script type="text/javascript" src="<%=path %>/ccapp/oa/resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="<%=path %>/ccapp/oa/resources/plug/ifrom/js/ifrom-ui-layout.1.1.js"></script>
<script type="text/javascript" src="<%=path %>/ccapp/oa/resources/plug/ifrom/js/ifrom-ui-layout-new.1.1.js"></script>
<script type="text/javascript" src="<%=path %>/ccapp/oa/resources/plug/ifrom/js/ifrom-tools.1.1.js"></script>
<script type="text/javascript" src="<%=path %>/ccapp/oa/resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="<%=path %>/ccapp/oa/resources/plug/ifrom/js/ifrom-ui-menu.1.1.js"></script>
<script type="text/javascript" src="<%=path %>/ccapp/oa/resources/plug/JQuery zTree v3.0/js/jquery.ztree.core-3.0.js"></script>
<script type="text/javascript" src="<%=path %>/ccapp/oa/resources/plug/JQuery zTree v3.0/js/jquery.ztree.excheck-3.0.js"></script>
<script type="text/javascript" src="<%=path %>/ccapp/oa/resources/plug/JQuery zTree v3.0/js/jquery.ztree.exedit-3.0.js"></script>

<script type="text/javascript">
$(function(){
	style = getSystemStyle("blue");
	var layouts = new  $.IfromLayout();
	layouts.layoutID = "wrap";
	layouts.layoutClass = "wrap";
	layouts.leftUrl="ccapp/oa/common/newlayout/left.jsp";
	layouts.bottomUrl="ccapp/oa/common/newlayout/bottom.jsp";
	layouts.showList=[{menuId:'_firstPagerAAAS',menuName:'公文管理',oper:true,url:'ccapp/oa/common/newlayout/fristpage.jsp',lefturl:'left.jsp',isfristpage:true,secendmenu:[]}];
	layouts.isShowBottom = true;
	layouts.layout();
	var p = [
	          "/ccapp/oa/resources/plug/ifrom/"+style+"/css/ifrom-ui-core.css"
	        ];
	loadCss(p);
});
</script>
</head>
<body id="_tabbody">
<div id="wrap">
</div>
</body>
</html>



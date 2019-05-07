<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>科创协同及移动办公云平台</title>
<script type="text/javascript">
var indexFlager = true;
</script>
<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-tree.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js"></script>
<script src="../../resources/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-newcommonuse.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-layout.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js"></script>

        <script type="text/javascript"
            src="../../resources/plug/JQuery zTree v3.0/js/jquery.ztree.core-3.0.js"></script>
        <script type="text/javascript"
            src="../../resources/plug/JQuery zTree v3.0/js/jquery.ztree.excheck-3.0.js"></script>
            <script type="text/javascript"
            src="../../resources/plug/JQuery zTree v3.0/js/jquery.ztree.exedit-3.0.js"></script>
<script type="text/javascript">
$(function(){
	style = getSystemStyle("blue");
	var layouts =new  $.IfromLayout();
	   layouts.layoutID = "mian";
	   layouts.leftUrl='left_.jsp';
	   layouts.showList=[{menuId:'_firstPagerAAAS',menuName:'个人工作台',oper:true,url:'workbench.jsp',lefturl:'left_.jsp'}];
	   layouts.headerUrl='header.jsp';
	   layouts.layout();
	   var p = ["/ccapp/oa/resources/style/"+style+"/css/style.css",
	            "/ccapp/oa/resources/plug/JQuery zTree v3.0/"+style+"/css/zTreeStyle/zTreeStyle.css",
	            "/ccapp/oa/resources/plug/JQuery zTree v3.0/"+style+"/css/demoout.css",
	            "/ccapp/oa/resources/plug/ifrom/"+style+"/css/ifrom-ui-core.css"];
	   
	   if(style == 'blue') {
  			p.push("/ccapp/oa/login/resources/css/left.css");
       }
	   loadCss(p);
	   $("body").hover(function(){
		   try{
			   var win = getIFrameWindow('_document_body_mian_firstPagerAAAS');
				if(null != win){
					win.opetDate = new Date();
				}
		   }catch(error){}
		   
	   })
});

	//屏蔽鼠标右键、Ctrl+N、Shift+F10、F11、F5刷新、退格键  
	document.oncontextmenu = function() {
		 event.keyCode=0;
		event.returnValue = false;
	}//屏蔽鼠标右键  
	window.onhelp = function() {
		return false
	} //屏蔽F1帮助  
	document.onkeydown = function() {

		if ((event.keyCode == 116) || //屏蔽 F5 刷新键  
		(event.ctrlKey && event.keyCode == 82)) { //Ctrl + R  
			event.keyCode = 0;
			event.returnValue = false;
		}
		if (event.keyCode == 122) {
			event.keyCode = 0;
			event.returnValue = false;
		} //屏蔽F11  
		if (event.ctrlKey && event.keyCode == 78)
			event.returnValue = false; //屏蔽 Ctrl+n
		if (event.shiftKey && event.keyCode == 121)
			event.returnValue = false; //屏蔽 shift+F10  
		if (window.event.srcElement.tagName == "A" && window.event.shiftKey)
			window.event.returnValue = false; //屏蔽 shift 加鼠标左键新开一网页  
		if ((window.event.altKey) && (window.event.keyCode == 115)) //屏蔽Alt+F4  
		{
			window.showModelessDialog("about:blank", "",
					"dialogWidth:1px;dialogheight:1px");
			return false;
		}
	}
	 document.oncontextmenu=function(e){return   false;}   
	 

</script>
</head>
<body id="_superbodys"  style="overflow:hidden;">
	<div id="mian" class="_mian"></div>
</body>
</html>
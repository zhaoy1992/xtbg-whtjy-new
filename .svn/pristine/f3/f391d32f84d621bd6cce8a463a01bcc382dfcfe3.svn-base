<%@page import="com.chinacreator.business.common.tools.CacheCommonManage"%>
<%@page import="com.chinacreator.xtbg.pub.util.DaoUtil"%>
<%@page import="com.chinacreator.xtbg.pub.common.IndexCache"%>
<%@page import="com.chinacreator.task.Execute"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="com.chinacreator.xtbg.pub.util.StringUtil"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.eform.util.Escape"%>
<%@page import="com.chinacreator.business.common.tools.CacheCommonManageProxy"%><html>
<%
AccessControl accesscontroler = AccessControl.getInstance();
boolean success = accesscontroler.checkAccess(request, response);
//根据当前登录的人来刷新缓存
IndexCache indexCache = new IndexCache();
indexCache.updateUserIndexData(accesscontroler.getUserID(),accesscontroler.getUserAccount());
String userArea=CacheCommonManage.getInstance().getSystemParam("CURSYSTEMCODE");

String firstPagerURL = "";
String firstPagerName = "";
	if(!StringUtil.nullOrBlank(request.getParameter("firstPagerURL"))){
		firstPagerURL = Escape.unescape(Escape.unescape(request.getParameter("firstPagerURL").replaceAll("@@","&")));
	}
	if(!StringUtil.nullOrBlank(request.getParameter("firstPagerName"))){
		firstPagerName = Escape.unescape(Escape.unescape(request.getParameter("firstPagerName")));
	}
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>
<%=
CacheCommonManageProxy.getSystemParam("index_title")
%>
</title>
<script type="text/javascript">
var usePareme = "yes";
var indexFlager = true;
</script>
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-tree.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js"></script>
<script src="../../../resources/js/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-newcommonuse.js"></script>
<%if(StringUtil.nullOrBlank(CacheCommonManageProxy.getSystemParam("app_self_layout-js"))){ %>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-layout.1.1.js"></script>
<%} else{%>
<script type="text/javascript" src="<%=CacheCommonManageProxy.getSystemParam("app_self_layout-js")%>"></script>
<%} %>

<!-- 引用核心组JS -->

<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js"></script>

		<script type="text/javascript"
			src="../../../resources/plug/JQuery zTree v3.0/js/jquery.ztree.core-3.0.js"></script>
		<script type="text/javascript"
			src="../../../resources/plug/JQuery zTree v3.0/js/jquery.ztree.excheck-3.0.js"></script>
			<script type="text/javascript"
			src="../../../resources/plug/JQuery zTree v3.0/js/jquery.ztree.exedit-3.0.js"></script>
<script type="text/javascript">

var windowTopUtil = //系统顶级页面的公用工具类
{
	getSystemParam:function(_key){//根据key获取系统配置属性
		var value = "";
		$.ajaxSetup({async : false});
		$.post("getsystemparam.jsp",{key:_key},function(obj){
			  value = obj.value;
		},"json");
		
		return value;
	}
} 

$(function(){
	<%if("430800".equals(userArea) || "421006".equals(userArea)){ %>
	  style = getSystemStyle("");
	<%}else if("410003".equals(userArea)){%>
		style = getSystemStyle("gray");
	<%}else{%>
		style = getSystemStyle("blue");
	<%}%>
	var layouts =new  $.IfromLayout();
	   layouts.layoutID = "mian";
	   leftUrl='<%=CacheCommonManageProxy.getSystemParam("DEFLEFTURL")%>';
	   layouts.showList=<%=CacheCommonManageProxy.getSystemParam("FRISTTABS")%>;
	   layouts.headerUrl='<%=CacheCommonManageProxy.getSystemParam("DEFHEADERURL")%>';
	   <%if(null != firstPagerURL && !"".equals(firstPagerURL)){%>
	   layouts.showList=[<%=CacheCommonManageProxy.getSystemParam("FRISTTABS").replace("[","").replace("]","").replace(";","")+","%>{menuId:'_secondPagerAAAS',menuName:'<%=firstPagerName%>',isClose:true,isReload:true,oper:true,url:'<%=firstPagerURL%>',lefturl:'left_.jsp'}]
	   <%}%>
	   layouts.layout();
	   //reloadThread();
	   var p = ["/ccapp/xtbg/resources/"+style+"/css/style.css",
	            "/ccapp/xtbg/resources/plug/JQuery zTree v3.0/"+style+"/css/zTreeStyle/zTreeStyle.css",
	            "/ccapp/xtbg/resources/plug/JQuery zTree v3.0/"+style+"/css/demoout.css",
	            "/ccapp/xtbg/resources/plug/ifrom/"+style+"/css/ifrom-ui-core.css"];
	   
	   <%if(CacheCommonManageProxy.getBooleanSystemParam("index_add_leftCss")){%>
		   if(style == 'blue') {
	  			p.push("/ccapp/xtbg/<%=CacheCommonManageProxy.getSystemParam("jsp_filePath")%>/login/resources/css/left.css");
	       }
	   <%}%>
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
        /* if(event.keyCode==8) {
             event.returnValue = false;
         }*/
	}
	 document.oncontextmenu=function(e){return   false;}   
	 
	//打开页面
	function openForms(url, flowname){
		var height = window.screen.availHeight;
		var width = window.screen.availWidth;
		url= url+"&height="+height+"&width="+width;
		openAlertWindows('newwindows',url,flowname,width,height,'0%','0%');
	}

</script>
</head>
<body id="_superbodys"  style="overflow:hidden;">
	<div id="mian" class="_mian"></div>

</body>
</html>
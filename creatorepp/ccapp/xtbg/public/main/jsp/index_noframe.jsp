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
<%=CacheCommonManageProxy.getSystemParam("index_title")%>
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
		addFrame();
});
var iframe = null;
//新增一个包含子页面的iframe
function addFrame(){
	iframe = $("<iframe id='mian' name='mian' class='_main_noframe'></iframe>");
	$(iframe).attr("src","<%=firstPagerURL%>");
	$(iframe).bind("load",onFrameLoad);
	$(iframe).appendTo(document.body);
}

//对子iframe进行相关的事件改写
function onFrameLoad(){
	var subFrameCloseBut = $("input[value='关闭']",window.frames['mian'].document.body);
	$(subFrameCloseBut).attr("onclick","");
	$(subFrameCloseBut).bind("click",function(){closeWin()});
}

function closeWin(){
	window.close();
}

</script>
<style>
	._main_noframe{
		width: 100%;
		height: 100%;
	}
</style>
</head>
<body id="_superbodys"  style="overflow:auto;">

</body>
</html>
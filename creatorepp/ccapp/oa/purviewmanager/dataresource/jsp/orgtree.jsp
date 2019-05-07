<%-- 
描述：机构树
作者：黄艺平
版本：1.0
日期：2013-07-15
 --%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%
AccessControl accesscontroler = AccessControl.getInstance();
accesscontroler.checkAccess(request, response);
String userId = accesscontroler.getUserID();
String userKey = accesscontroler.getUserAccount();
String orgId = accesscontroler.getChargeOrgId();
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-treetools.js"></script>
<script type="text/javascript" src="../../../resources/plug/JQuery zTree v3.0/js/jquery.ztree.core-3.0.js"></script>
<script type="text/javascript" src="../../../resources/plug/JQuery zTree v3.0/js/jquery.ztree.excheck-3.0.js"></script>
<script type="text/javascript" src="../../../resources/plug/JQuery zTree v3.0/js/jquery.ztree.exedit-3.0.js"></script>
<script src="../../../resources/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js"></script>

<SCRIPT type="text/javascript">
$(function(){
	  style = window.top.getSystemStyle();
	  adaptationWH("top","vcenter",20);
	  $(".ztree").height(($(parent).height()*1-16)+"px");
	  $("body").width($(window).width());
	  if(style == "/" || style=="") {
			style = "red"
	  }
   var p=["/ccapp/oa/resources/plug/JQuery zTree v3.0/"+style+"/css/demoout.css"];
   loadCss(p,window);
   initpesong();
});

var getSetting=function(key,p){
		var setting = "";
		switch (key) {
		case "checkbox":
			 setting = {
					view : {
						selectedMulti : false,
						expandSpeed:''
					},
					data : {
						simpleData : { // 简单json类型
							enable : true,
							idKey : "id",
							pIdKey : "parent_id",
							rootPId : 0
						}
					},
					check : {
						enable : true,
						chkStyle : "checkbox",
						chkboxType : {
							"Y" : "s",
							"N" : "s"},
						radioType : "all"
					},
					callback: {
						onClick: p.onClick
					},
					async:{
						enable:true
					}
				};
			break;

		default:
			setting = {
				view : {
					selectedMulti : false,
					expandSpeed:''
				},
				data : {
					simpleData : { // 简单json类型
						enable : true,
						idKey : "id",
						pIdKey : 'parent_id',
						rootPId : 0
					}
				},
				callback: {
					onClick: p.onClick
				},
				async:{
					enable:true
				}
			};
		}
		return setting;
	}

	
	
/*
	时间:  2013-7-16
	函数:  initTree
	说明:  初始化树后台方法
	参数:   无
	返回值: 无
*/
var initTree=function(p){
	var span = {
			url : getContextPath()+'/pubtree',
			success : function(ss) {
				var nodes=null;
				if(json.returnValue !='none') {
					nodes = json.returnValue;
			    } else{
					nodes =[];
				}
				window[p.treename] = nodes;
				loadPager();
			},
			data : p.type,
			classID : 'config',
			method : p.method
		}
		ajaxTools(span);
}

var loadPager=function(){
	var p = {"onClick":onclick}
	var setting = getSetting("",p);
	if(window.unit !=null){
		try{delete window.purviewTree;}catch(error){}
		window.unit = $.fn.zTree.init($("#treeDemo_purview"), setting,window.unit);
	}

}

var onclick = function(event, treeId, treeNode){
	zTreeOnClick(event, treeId, treeNode);
}

function zTreeOnClick(event, treeId, treeNode){
	var tree = $.fn.zTree.getZTreeObj(treeId);
	parent.getTempValue("orgresonconfig.jsp?orgId=" + treeNode.org_id);

}
/*
	时间:  2013-7-16
	函数:  initTreeList
	说明:  初始化资源配置树
	参数:   无
	返回值: 无
*/
var initpesong=function(){

	var unit ={
			type:'{"user":""}',
			method:'inqueryTreeReportOrganization',
			treename:'unit'
	};
	initTree(unit);
}
		
</SCRIPT>
	

<TITLE> 机构用户树</TITLE>
</head>
<body  >
<ul id='treeDemo_purview' class='ztree'></ul>
</body>
</html>
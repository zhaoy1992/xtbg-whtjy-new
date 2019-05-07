<%-- 
描述：单位接收人配置
作者：黄艺平
版本：1.0
日期：2013-07-15
 --%>
 <%
 List<Map<String, String>> listMap = new ArrayList<Map<String, String>>();
 List<Map<String, String>> userBeanListMap = new ArrayList<Map<String, String>>();
 DataResourcesServiceIfc dataResourcesServiceIfc = new DataResourcesServiceImpl();
 listMap = dataResourcesServiceIfc.getDataResourcesBeanMap();
 userBeanListMap = dataResourcesServiceIfc.getUserBeanMap("9f225627-9889-42cb-b174-88473fb3e733");
 Map<String, String> dataResourcesMap = null;
 Map<String, String> userBeanMap = null;
 
 %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.chinacreator.xtbg.core.dataresources.service.DataResourcesServiceIfc"%>
<%@page import="com.chinacreator.xtbg.core.dataresources.service.impl.DataResourcesServiceImpl"%>
<%@page import="java.util.HashMap"%><html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-treetools.js"></script>
<script type="text/javascript" src="../../../resources/plug/JQuery zTree v3.0/js/jquery.ztree.core-3.0.js"></script>
<script type="text/javascript" src="../../../resources/plug/JQuery zTree v3.0/js/jquery.ztree.excheck-3.0.js"></script>
<script type="text/javascript" src="../../../resources/plug/JQuery zTree v3.0/js/jquery.ztree.exedit-3.0.js"></script>
<script src="../../../resources/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js"></script>

<script type="text/javascript">
  $(function(){
	  style = window.top.getSystemStyle();
	  adaptationWH("top","vcenter",20);
	  $(".ztree").height($("#vcenter").height()-80);
	  $("body").width($(window).width());
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
	var p = {"onClick":orgTreeClick}
	var setting = getSetting("",p);
	if(window.unit !=null){
		try{delete window.purviewTree;}catch(error){}
		window.unit = $.fn.zTree.init($("#treeDemo_purview"), setting,window.unit);
	}

}

var orgTreeClick = function() {

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
			method:'selAllUnit',
			treename:'unit'
	};
	initTree(unit);
}

	
</script>

</head>
<body style="width:99%;">
<div class="l_box">
	<div class="l_left">
		<div class="l_juzhong">
			<div class="header_class">
				 <div class="header_img"></div>
			                   单位树
			</div>
			<ul id='treeDemo_purview' class='ztree'></ul>
		</div>
	</div>

	<div class="l_right">
		<div class="l_juzhong">
		<table class="content_02_box_div_table_02" >
			<tr align="center">
				<td width="120px" ></td>
				<%
					for (int i = 0; i < listMap.size(); i++) {
						dataResourcesMap = new HashMap<String, String>();
						dataResourcesMap = listMap.get(i);
				%>
				<td width="140px"><%=dataResourcesMap.get("resources_name")%></td>
				<%
					}
				%>
			</tr>
			<%
					for (int j = 0; j < userBeanListMap.size(); j++) {
						userBeanMap = new HashMap<String, String>();
						userBeanMap = userBeanListMap.get(j);
			%>
			<tr>
				<td><%=userBeanMap.get("user_realname")%></td>
				
			</tr>
			<%
					}
				
			%>
		</table>
		</div>
	</div>
	<div class="clear"></div>
</div>

</body>
</html>
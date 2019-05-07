<%--
描述：在线人树查看页面
作者：黄艺平
版本：1.0
时间：2013-7-1
 --%>
<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@page import="com.chinacreator.security.AccessControl"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	String path = request.getContextPath();
	String treetypestr = "";
	treetypestr = "checkbox";
%>
<title>在线人树查看页面</title>
<!-- 引入jQuery -->
<script type="text/javascript"
	src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>

<link rel="stylesheet"
	href="../../resources/plug/JQuery zTree v3.0/css/zTreeStyle/zTreeStyle.css"
	type="text/css"></link>
<script type="text/javascript"
	src="../../resources/plug/JQuery zTree v3.0/js/jquery.ztree.core-3.0.js"></script>
<script type="text/javascript"
	src="../../resources/plug/JQuery zTree v3.0/js/jquery.ztree.excheck-3.0.js"></script>
<!-- 引入其它 -->
<script src="../../resources/util/public.js" type="text/javascript"></script>
<script type="text/javascript"
	src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js"></script>
<script type="text/javascript">
		var treetypestr = '<%=treetypestr%>';
		<!--
		var setting = {
			view: {
				selectedMulti: false
			},
			data: {
				simpleData: { //简单json类型
					enable: true, 
					idKey: "org_id",
					pIdKey: "parent_id",
					rootPId: 0
				}
			},
			check: {
				enable: false,
				chkStyle: treetypestr,
				chkboxType : {
					"Y": "s",
					"N": "s"
				},
				radioType: "all"
			},
			async: {
				enable: true,
				url: window.top.getContextPath() + '/commonTreeServlet?classNameId=com.chinacreator.xtbg.core.workbench.tree.OnlineTree', 
				autoParam:["item_id", "name=item_id", "level=lv"],
				otherParam:{"toporgId":"","userid":""}
			}
		};

		//将选择的用户id传到resourcesconfigmain.jsp
		function passvalue(event, treeId, treeNode){
			if(!IsSpace(treeNode.item_id)){
				if(treeNode.itemtype!="1"){
					parent.pushvalue(treeNode.item_id,"2");
				}
			}
		}
		
		
		function beforeClick(treeId, treeNode) {
			
		}
		
		var log, className = "dark";
		//用于捕获异步加载之前的事件回调函数，zTree 根据返回值确定是否允许进行异步加载
		function beforeAsync(treeId, treeNode) {

		}
		/*
		用于捕获异步加载出现异常错误的事件回调函数
		如果设置了 setting.callback.beforeAsync 方法，且返回 false，将无法触发 onAsyncSuccess / onAsyncError 事件回调函数。
		*/
		function onAsyncError(event, treeId, treeNode, XMLHttpRequest, textStatus, errorThrown) {
		
		}
		/*
		用于捕获异步加载正常结束的事件回调函数
		如果设置了 setting.callback.beforeAsync 方法，且返回 false，将无法触发 onAsyncSuccess / onAsyncError 事件回调函数。
		*/
		function onAsyncSuccess(event, treeId, treeNode, msg) {
			$("#treeDemo").height("380px");
		}

		$(document).ready(function(){
			$.fn.zTree.init($("#treeDemo"), setting);
		});
		//-->
		
		function OK(){
			var returnValName = "";//用户姓名
			var returnValId = "";//用户登录id
			var returnCode = "";//用户登录名
			var userObj = new Object();
			var flag = false;
			
			var zTree = $.fn.zTree.getZTreeObj("treeDemo");
			nodes = zTree.getCheckedNodes(true);

			for (var i=0, l=nodes.length; i<l; i++) {
				
				if(!IsSpace(nodes[i].user_id)){
					flag = true;
					returnValId += nodes[i].user_id + ",";
					returnValName += nodes[i].name + ",";
					returnCode += nodes[i].item_code + ",";
				}
			}
			if (returnValId.length > 0 ) returnValId = returnValId.substring(0, returnValId.length-1);
			if (returnValName.length > 0 ) returnValName = returnValName.substring(0, returnValName.length-1);
			if (returnCode.length > 0 ) returnCode = returnCode.substring(0, returnCode.length-1);
			
			userObj.name = returnValName;
		    userObj.id = returnValId;
		    userObj.user_name = returnCode;
		    if(flag && returnValName != ""){
	        	window.returnValue = userObj;
		    }else{
	        	window.returnValue = false;
			}
		    window.close();
		}

		var Cancel = function() {
			window.close();
		}
		jQuery(function() {
			var _documentBodyHeight = window.document.body.clientHeight;
			jQuery("#treediv").height(_documentBodyHeight-10);
		});
	</script>
</head>
<body class="tree_bg_eaeaea">
	<div style="height: 380px;overflow: auto;" id="treediv">
	<ul id="treeDemo" class="ztree" ></ul>
	</div>
</body>
</html>
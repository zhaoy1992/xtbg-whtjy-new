<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.pub.util.DaoUtil"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	String path = request.getContextPath();
	String orgid =accesscontroler.getChargeOrgId();
	String ischeck = request.getParameter("ischeck");//用来判断是否是复选框,默认是radio
	String resourceLogo = request.getParameter("resourceLogo");//资源类型
	String userid = accesscontroler.getUserID();//用户id
	//ischeck = "true";
	String treetypestr = "";
	treetypestr = "checkbox";
	String theRootOrgid = DaoUtil.SqlToField("select org_id from td_sm_organization where parent_id='0'");
%>
	<title> 机构用户树</title>
	<!-- 引入jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>

	<link rel="stylesheet" href="../../../resources/plug/JQuery zTree v3.0/css/zTreeStyle/zTreeStyle.css" type="text/css"></link>
	<script type="text/javascript" src="../../../resources/plug/JQuery zTree v3.0/js/jquery.ztree.core-3.0.js"></script>
	<script type="text/javascript" src="../../../resources/plug/JQuery zTree v3.0/js/jquery.ztree.excheck-3.0.js"></script>
	<!-- 引入其它 -->
	<script src="../../../resources/js/util/public.js" type="text/javascript"></script>
	<script type="text/javascript"
	src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
	<script type="text/javascript">
		var treetypestr = '<%=treetypestr%>';
		<!--
		var setting = {
			view: {
				selectedMulti: false   
				/*
				1、设置为 true时，按下 Ctrl 键可以选中多个节点
				2、设置为 true / false 都不影响按下 Ctrl 键可以让已选中的节点取消选中状态（ 取消选中状态可以参考 setting.view.autoCancelSelected ）
				*/
			},
			data: {
				simpleData: { //简单json类型
					enable: true, 
					idKey: "item_id",
					pIdKey: "parent_id",
					rootPId: 0
				}
			},
			check: {
				enable: false,
				/*
				chkStyle = "checkbox" 时，显示 checkbox 选择框，setting.check.chkboxType 属性有效。
				chkStyle = "radio" 时，显示 radio 选择框， setting.check.radioType 属性有效。
				
				请注意大小写，不要改变
				*/
				chkStyle: treetypestr,
				chkboxType : {
					"Y": "s",
					"N": "s"
				},
				radioType: "all"
			/*
			规则说明： 
			      Y 属性定义 CheckBox 被勾选后的情况； 
			      N 属性定义 CheckBox 取消勾选后的情况； 
			      "p" 表示操作会影响父级节点； 
			      "s" 表明操作会影响子级节点。
		    */
			},
			async: {
				enable: true,
				url:'<%= path %>' + "/viewOlineTreeServlet",
				autoParam:["item_id", "name=item_id", "level=lv"],
				otherParam:{"toporgId":"<%=theRootOrgid%>","userid":"<%=userid%>","resourceLogo":"<%=resourceLogo%>","orgid":"<%=orgid%>"}
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
			//parent.JqueryDialog.Close();
			window.close();
		}
	</script>
</head>
<body onload="adaptationWH('','treeDemo','220')">
	<ul id="treeDemo" class="ztree" style="height: 380px"></ul>
</body>
</html>
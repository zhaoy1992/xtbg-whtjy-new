<%@page import="com.chinacreator.security.AccessControl"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<%
AccessControl accesscontroler = AccessControl.getInstance();
accesscontroler.checkAccess(request, response);
String path = request.getContextPath();
	String ischeck = request.getParameter("ischeck");//用来判断是否是复选框,默认是radio
	//ischeck = "true";
	String treetypestr = "";
	if("true".equals(ischeck)){
		treetypestr = "checkbox";
	}else{
		treetypestr = "radio";
	}
%>
	<TITLE>机构人员树</TITLE>
	<!-- 引入jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>

	<link rel="stylesheet" href="../../../resources/plug/JQuery zTree v3.0/css/demoout.css" type="text/css">
	<link rel="stylesheet" href="../../../resources/plug/JQuery zTree v3.0/css/zTreeStyle/zTreeStyle.css" type="text/css">
	<script type="text/javascript" src="../../../resources/plug/JQuery zTree v3.0/js/jquery.ztree.core-3.0.js"></script>
	<script type="text/javascript" src="../../../resources/plug/JQuery zTree v3.0/js/jquery.ztree.excheck-3.0.js"></script>
	<!-- 引入其它 -->
	<script src="../../../resources/js/util/public.js" type="text/javascript"></script>
	<script src="../../../resources/js/common/commoncss.js" type="text/javascript"></script>
	<!--<script type="text/javascript" src="../../../../js/jquery.ztree.exedit-3.0.js"></script>-->
	<SCRIPT type="text/javascript">
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
				enable: true,
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
				url:'<%= path %>' + "/orgPersonTreeServlet",
				autoParam:["item_id", "name=item_id", "level=lv"],
				otherParam:{"toporgId":"0802576c-a2fb-4e35-a8e8-79d8e16b79ac"}
				//dataFilter: filter
			},
			callback: {
				beforeClick: beforeClick,
				beforeAsync: beforeAsync,
				onAsyncError: onAsyncError,
				onAsyncSuccess: onAsyncSuccess
			}
		};

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
			var returnValName = "";//人员姓名
			var returnValId = "";//人员id
			var userObj = new Object();
			var flag = false;
			
			var zTree = $.fn.zTree.getZTreeObj("treeDemo");
			nodes = zTree.getCheckedNodes(true);

			for (var i=0, l=nodes.length; i<l; i++) {
				
				if(!IsSpace(nodes[i].user_id)){
					flag = true;
					returnValId += nodes[i].user_id + ",";
					returnValName += nodes[i].name + ",";
				}
			}
			if (returnValId.length > 0 ) returnValId = returnValId.substring(0, returnValId.length-1);
			if (returnValName.length > 0 ) returnValName = returnValName.substring(0, returnValName.length-1);
			
			userObj.name = returnValName;
		    userObj.id = returnValId;
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
	</SCRIPT>

</HEAD>

<BODY>
<table border="0" cellpadding="0" cellspacing="0" class="ztree_tcbox">
  <tr>
    <td class="ztree_tctitle">机构人员树</td>
  </tr>
  <tr>
    <td>
	<table style="width:286px;" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td class="ztree_tcleft">&nbsp;</td>
	    <td>
			<ul id="treeDemo" class="ztree"></ul>
	</td>
    <td class="ztree_tcright">&nbsp;</td>
  </tr>
</table>

	</td>
  </tr>
  <tr>
    <td class="ztree_tcbotton">
    <input id="showorgs" name="showorgs" type="button" value="确定" class="cButton_Gray" onclick="OK()"/>
    </td>
  </tr>
</table>
</BODY>
</HTML>
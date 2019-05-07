<%@page import="com.chinacreator.security.AccessControl"%>
<%@ page contentType="text/html; charset=GBK"%>
<%
AccessControl accesscontroler = AccessControl.getInstance();
accesscontroler.checkAccess(request, response);
String treetypestr = "";
String checkstr = "false";
//获得默认选中节点
String parentId = request.getParameter("parentId");

String url = request.getParameter("url");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>合同分类</title>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<!-- 引入jQuery_zTree -->
<script type="text/javascript" src="../../../resources/plug/JQuery zTree v3.0/js/jquery.ztree.core-3.0.js"></script>
<script type="text/javascript" src="../../../resources/plug/JQuery zTree v3.0/js/jquery.ztree.excheck-3.0.js"></script>
<!-- 引入其它 -->
<script type="text/javascript" src="../../../resources/js/util/public.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
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
					idKey: "id",
					pIdKey: "parent_id",
					name:"id",
					rootPId: 0
				}
			},
			check: {
				enable: <%=checkstr%>,
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
			callback: {
				onClick: zTreeOnClick,
				beforeClick: beforeClick,
				beforeAsync: beforeAsync,
				onAsyncError: onAsyncError,
				onAsyncSuccess: onAsyncSuccess
			}
		};
		<%if("ibrarytype".equals(url)){%> //图书分类
			function zTreeOnClick(event, treeId, treeNode) {
				var zTree = $.fn.zTree.getZTreeObj("treeDemo");
				if(""==treeNode.parent_id){
					parent.setRightIframeSrc("ibrarytypelist.jsp");
				}else{
					parent.setRightIframeSrc("ibrarytypeinfo.jsp?id="+treeNode.id+"&parentId="+treeNode.parent_id+"&tree_type_no="+treeNode.tree_type_no+"&parentname="+encodeURI(encodeURI(treeNode.name)));
				}
			}
		<%}else if("ibrarybook".equals(url)){%> //图书管理
			function zTreeOnClick(event, treeId, treeNode) {
				var zTree = $.fn.zTree.getZTreeObj("treeDemo");
				if(""==treeNode.parent_id){
					parent.setRightIframeSrc("ibrarybooklist.jsp");
				}else{
					parent.setRightIframeSrc("ibrarybooklist.jsp?id="+treeNode.id+"&name="+encodeURI(encodeURI(treeNode.name))+"&tree_type_code="+encodeURI(encodeURI(treeNode.tree_type_code))+"&tree_type_no="+treeNode.tree_type_no);
				}
			}
		<%} else if("ibraryquery".equals(url)){%>
			function zTreeOnClick(event, treeId, treeNode) {
				var zTree = $.fn.zTree.getZTreeObj("treeDemo");
				if(""==treeNode.parent_id){
					parent.setRightIframeSrc("ibraryquerylist.jsp");
				}else{
					parent.setRightIframeSrc("ibraryquerylist.jsp?id="+treeNode.id);
				}
			}
		<%}%>
		
		function beforeClick(treeId, treeNode) {
			var zTree = $.fn.zTree.getZTreeObj("treeDemo");
			zTree.checkNode(treeNode, !treeNode.checked, null, true);

			return true;
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
			var span = {
					url : window.top.getContextPath()+'/tree',
					success : function(ss) {
						if(window.top.json.returnValue !='none')
					    {
							window.top.showDetp(window.top.json.returnValue,window.top.json.orgId);
							$.fn.zTree.init($("#treeDemo"), setting,window.top.json.returnValue);
						}
						else{
							$.fn.zTree.init($("#treeDemo"), setting,[]);
						}
						var zTree = $.fn.zTree.getZTreeObj("treeDemo");
						zTree.expandAll(true);
						//添加默认选中节点
						zTree.selectNode(zTree.getNodeByParam( "id","<%=parentId%>" ), true );
					},
					data : "{'type':'TREE_CZT_IBRARY_TYPE'}",
					classID : 'find',
					method : 'getTreeJsonValue'
				}
				window.top.ajaxTools(span);
		});
		//-->
	</script>
</head>

<body class="tree_bg_eaeaea" onload="adaptationWH('','treeDemo',45)">
<ul id="treeDemo" class="ztree" style="width:200px;height: 600px;overflow: auto;"></ul>
</body>
</html>
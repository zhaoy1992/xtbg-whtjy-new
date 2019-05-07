<%@page import="com.chinacreator.xtbg.pub.util.StringUtil"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.pub.util.DaoUtil"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<HEAD>
<%
	String path = request.getContextPath();
	String ischeck = request.getParameter("ischeck");//用来判断是否是复选框,默认是radio
	AccessControl accessControl = AccessControl.getInstance();
	accessControl.checkAccess(request,response);
	String orgid = accessControl.getChargeOrgId();
	String userid = accessControl.getUserID();
	String showLevel="";
	if(StringUtil.isBlank(request.getParameter("showLevel"))){
		showLevel="3";
	}else{
		showLevel=request.getParameter("showLevel");
	}
	//ischeck = "true";
	String treetypestr = "";
	if("true".equals(ischeck)){
		treetypestr = "checkbox";
	}else{
		treetypestr = "radio";
	}
	String theRootOrgid = DaoUtil.SqlToField("select org_id from td_sm_organization where parent_id='0'");
%>
<TITLE> ZTREE DEMO - reAsyncChildNodes</TITLE>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>

<!-- 引入jQuery_zTree -->

<script type="text/javascript" src="../../../resources/plug/JQuery zTree v3.0/js/jquery.ztree.core-3.0.js"></script>
<script type="text/javascript" src="../../../resources/plug/JQuery zTree v3.0/js/jquery.ztree.excheck-3.0.js"></script>

<!-- 引入其它 -->
<script src="../../../resources/js/util/public.js" type="text/javascript"></script>
<script type="text/javascript"
	src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>

<SCRIPT type="text/javascript">
		var treetypestr = '<%=treetypestr%>';
		<!--
		var setting = {
			view: {
				selectedMulti: false,
				fontCss: getFont,
				nameIsHTML: true   
				/*
				1、设置为 true时，按下 Ctrl 键可以选中多个节点
				2、设置为 true / false 都不影响按下 Ctrl 键可以让已选中的节点取消选中状态（ 取消选中状态可以参考 setting.view.autoCancelSelected ）
				*/
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
			}
			,
			callback: {
				beforeClick: beforeClick,
				beforeAsync: beforeAsync,
				onAsyncError: onAsyncError,
				onAsyncSuccess: onAsyncSuccess,
				onClick:onclick
			}
		};
		function getFont(treeId, node) {
			
			return node.font ? {color:'#999999'} : {};
		}
		function onclick(event,treeId,treeNode){
			if("false" != treeNode.click){
			 	var url="directorylist.jsp?orgid="+treeNode.org_id;
			 	parent.getTempValue(url);
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
					},
					data : "{'type':'5'}",
					classID : 'find',
					method : 'getTreeJsonValue'
				}
				window.top.ajaxTools(span);
			
		});
		//-->
		
		function OK(){
			var returnValName = "";
			var returnValId = "";
			var returnCode = "";
			var orgObj = new Object();
			var flag = false;
			
			var zTree = $.fn.zTree.getZTreeObj("treeDemo");
			nodes = zTree.getCheckedNodes(true);

			for (var i=0, l=nodes.length; i<l; i++) {
				flag = true;
				returnValId += nodes[i].org_id + ",";
				returnValName += nodes[i].name + ",";
			}
			if (returnValId.length > 0 ) returnValId = returnValId.substring(0, returnValId.length-1);
			if (returnValName.length > 0 ) returnValName = returnValName.substring(0, returnValName.length-1);
			
			orgObj.name = returnValName;
		    orgObj.id = returnValId;
		    if(flag && returnValName != ""){
	        	window.returnValue = orgObj;
		    }else{
	        	window.returnValue = false;
			}
		    window.close();
		}
	</SCRIPT>

</HEAD>

<BODY>
<div class="web_tree_box" style="width:220px;"></div>

<div class="header_class">
	<div class="header_img"></div>
	名录管理树
</div>
<ul id="treeDemo" class="ztree" style="width:220px;height: 550px;"></ul>

</BODY>
</HTML>
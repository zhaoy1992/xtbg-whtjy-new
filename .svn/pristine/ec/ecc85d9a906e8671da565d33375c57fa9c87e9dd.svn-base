<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	String path=request.getContextPath();
	String oftype_id=StringUtil.deNull(request.getParameter("oftype_id"));
	String type = StringUtil.deNull(request.getParameter("type"));
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	<title>办公用品分类tree</title>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery1.7/jquery-1.7.1.min.js"></script>
<!-- 引入jQuery_zTree-->
<link rel="stylesheet" href="../../../resources/plug/JQuery zTree v3.0/css/zTreeStyle/zTreeStyle.css" type="text/css"/>
<script type="text/javascript" src="../../../resources/plug/JQuery zTree v3.0/js/jquery.ztree.core-3.0.js"></script>
<script type="text/javascript" src="../../../resources/plug/JQuery zTree v3.0/js/jquery.ztree.excheck-3.0.js"></script>
<script type="text/javascript" src="../../../resources/plug/JQuery zTree v3.0/js/jquery.ztree.exedit-3.0.js"></script>

<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<!-- 引入其它 -->
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js"></script>
<script src="../../../resources/js/util/public.js" type="text/javascript"></script>

	<style type="text/css">
		.td_tree_border_c3d0de{border:solid 0px #FFFFFF;height:auto}
		.tree_bg_eaeaea{background: #FFFFFF}
	</style>
<script type="text/javascript">
var type = "<%=type%>"; 
var treetypestr = 'dd';
var setting = {
	edit: {//移动节点
		drag : {
			isCopy: false,
			isMove: false,
			prev: false,
			inner: false,
			next: false
		},
		enable: true,
		showRemoveBtn: false,
		showRenameBtn: false
	},
	async: {
    	enable: true,//启用异步加载
    	url: window.top.getContextPath() + '/commonTreeServlet?classNameId=com.chinacreator.xtbg.core.common.tree.dao.impl.OsupplieTypeTree', 
		autoParam:["oftype_id", "name=oftype_id", "level=lv"],
		otherParam:{"toporgId":"0","orgids":""}
    },
	data: {
		simpleData: { //简单json类型
			enable: true, 
			idKey: "id",
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
	callback: {
		beforeClick: beforeClick,
		beforeAsync: beforeAsync,
		onAsyncError: onAsyncError,
		onAsyncSuccess: onAsyncSuccess,
		onClick:orgOnclick,
		beforeDrag: beforeDrag,
		beforeDrop: beforeDrop,
		onDrop: zTreeOnDrop
	}
};

<%--callback function 3--%>
function orgOnclick(event,treeId,treeNode) {
	jQuery("#oftype_id").val(treeNode.id);
	var url;
	if(type == "object"){
		url="osmoreobjectlist.jsp?oftype_id="+treeNode.id;
	}else if(type == "item"){
		url="<%=path%>/ccapp/xtbg/tjy/officesupplies/type/jsp/osusertypeItemlist.jsp?oftype_id="+treeNode.id;
	}else if(type == "type"){
		url = "osupplietypelist.jsp?oftype_id="+treeNode.id;
	}
	parent.getTempValue(url);
}
<%--callback function 4--%>
function beforeClick(treeId, treeNode) {}
<%--callback function 5--%>
//用于捕获异步加载之前的事件回调函数，zTree 根据返回值确定是否允许进行异步加载
function beforeAsync(treeId, treeNode) {}
/*
用于捕获异步加载出现异常错误的事件回调函数
如果设置了 setting.callback.beforeAsync 方法，且返回 false，将无法触发 onAsyncSuccess / onAsyncError 事件回调函数。
*/
<%--callback function 6--%>
function onAsyncError(event, treeId, treeNode, XMLHttpRequest, textStatus, errorThrown) {}
/*
用于捕获异步加载正常结束的事件回调函数
如果设置了 setting.callback.beforeAsync 方法，且返回 false，将无法触发 onAsyncSuccess / onAsyncError 事件回调函数。
*/
<%--callback function 7--%>
function onAsyncSuccess(event, treeId, treeNode, msg) {
	var zTree = $.fn.zTree.getZTreeObj("treeDemo");
	if(""!="<%=oftype_id%>"){
		var nodesd =zTree.getNodesByParamFuzzy("id","<%=oftype_id%>",null);
		if(nodesd&&nodesd.length>0){
			for(i = 0; i < nodesd.length; i++) { 
				zTree.selectNode(nodesd[i]);
				zTree.expandNode(nodesd[i],false,false,false); 
				orgOnclick(event,"treeDemo",nodesd[i]);
				return;
	        }
		}
	}
}
<%--callback function 8--%>
function zTreeOnDrop(event, treeId, treeNodes, targetNode, moveType) {//拖拽完成时间

 
}
<%--callback function 1--%>
function beforeDrag(treeId, treeNodes) {

}
<%--callback function 2--%>
function beforeDrop(treeId, treeNodes, targetNode, moveType) {
	
}

$(document).ready(function(){
	$.fn.zTree.init($("#treeDemo"), setting);
});
</script>
</head>
	<body >
	<input type="hidden" id="oftype_id" name="oftype_id"/>
		<div class="left_tree" style="height: 480px;overflow: auto;" >
			<h3><b>办公用品分类</b></h3>
			<ul id="treeDemo" class="ztree" ></ul>
		</div>
	</body>
</html>

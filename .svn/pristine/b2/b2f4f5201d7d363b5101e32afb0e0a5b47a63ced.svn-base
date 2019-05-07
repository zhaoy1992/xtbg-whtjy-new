<%@ page contentType="text/html; charset=utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>JGRID</title>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery1.6/jquery-1.6.min.js"></script>

<!-- 引入ztree -->
<link rel="stylesheet" type="text/css" media="screen" href="../../../resources/plug/JQuery zTree v2.6/demo/zTreeStyle/zTreeStyle.css" />
<link rel="stylesheet" type="text/css" media="screen" href="../../../resources/plug/JQuery zTree v2.6/demo/demoStyle/demo.css" />
<script src="../../../resources/plug/JQuery zTree v2.6/jquery.ztree-2.6.min.js" type="text/javascript"></script>
<%
	String path = request.getContextPath();
%>
<script type="text/javascript">
var zTree1;
var setting;
var pathstr = "<%=path%>";

setting = {
	checkable: false, //目前默认的 checkbox/radio 不支持只出现于部分节点 以及混合出现，如果有需求可以通过自定义控件方式增加，或者利用 nodeCreated 事件回调函数对相应节点的 checkbox 进行隐藏
	open: true,
	/*
	当 checkable = true 且 checkStyle = "checkbox" 时，checkType 配置勾选 checkbox 对于父子节点关联关系。

	规则说明： 
	      Y 属性定义 CheckBox 被勾选后的情况； 
	      N 属性定义 CheckBox 取消勾选后的情况； 
	      "p" 表示操作会影响父级节点； 
	      "s" 表明操作会影响子级节点。
    */
	checkType: {
		"Y": "s",
		"N": "s"
	},
	async: true,
	//isSimpleData : true,
	asyncUrl: pathstr+"/orgtreeServlet",
	//获取节点数据的URL地址
	//treeNodeKey : "org_id", //在isSimpleData格式下，当前节点id属性  
	// treeNodeParentKey : "parent_id", //在isSimpleData格式下，当前节点的父节点id属性  
	//nameCol : "name",            //在isSimpleData格式下，当前节点名称  
	asyncParam: ["name", "org_id"],
	//获取节点数据时，必须的数据名称，例如：id、name
	asyncParamOther: ["toporgId", "0"],
	//其它参数 ( key, value 键值对格式)
	dataType: "json",
	callback: {
		beforeAsync: zTreeBeforeAsync,
		asyncSuccess: zTreeOnAsyncSuccess,
		asyncError: zTreeOnAsyncError,
		click: zTreeOnClick
	}
};
var zNodes = [];
$(document).ready(function() {
	refreshTree();
});
var tmpUrl = "";
function zTreeBeforeAsync(treeId, treeNode) {}
function zTreeOnAsyncSuccess(event, treeId, treeNode, msg) {}
function zTreeOnAsyncError(event, treeId, treeNode, XMLHttpRequest, textStatus, errorThrown) {}

function refreshTree(asyncUrl) {
	zTree1 = $("#treeDemo").zTree(setting, zNodes);
}

function reloadAsync() {
	var treeNode = zTree1.getSelectedNode();
	if (!treeNode) {
		alert("请先选中一个节点");
		return;
	}
	zTree1.reAsyncChildNodes(treeNode, $("#refreshType").attr("checked") ? "refresh": "add")
}


function getCheckBoxId() {
	var nodes = zTree1.getChangeCheckedNodes();
	if (nodes) {
		for (var i = 0; i < nodes.length; i++) {
			alert(nodes[i].org_id);
			nodes[i].name += "_filter";
		}
	}
	var treeNode = zTree1.getSelectedNode();
	if (!treeNode) {
		alert("请先选中一个节点");
		return;
	}
	zTree1.reAsyncChildNodes(treeNode, $("#refreshType").attr("checked") ? "refresh": "add")
}

function zTreeOnClick(event, treeId, treeNode) {
	//alert( " treeId=" + treeId + ";<br/>&nbsp;tId=" + treeNode.tId + "; Name=" + treeNode.name);
	parent.togrant(treeNode.org_id,treeNode.name);
}
</script>
</head>
<body>
<TABLE border=0 width="100%" class="tb1">
	<TR>
		<TD width=340px align=center valign=top>
		<div align="center" >
		<div class="zTreeDemoBackground">
			<ul id="treeDemo" class="tree"></ul>
		</div>
	<!-- 	<button onClick="chooseOrg()" class="btn">确定</button>&nbsp;&nbsp;
				<button onClick="javascript:window.close()" class="btn">取消</button>  -->
		</div>		
		</TD>
	</TR>
</TABLE>
</body>
</html>
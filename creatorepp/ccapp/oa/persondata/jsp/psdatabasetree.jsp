<%-- 
描述：个人资料分类树结构列表页面(index内左)
作者：邱炼
版本：1.0
日期：2013-08-12
--%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	String path = request.getContextPath();
	String rightIframename = StringUtil.deNull(request.getParameter("rightIframename"));
	//当前用户ID
	String userId = accesscontroler.getUserID();
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>个人资料分类树tree</title>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../resources/plug/jquery1.7/jquery-1.7.1.min.js"></script>
<!-- 引入jQuery_zTree-->
<script type="text/javascript" src="../../resources/plug/JQuery zTree v3.0/js/jquery.ztree.core-3.0.js"></script>
<script type="text/javascript" src="../../resources/plug/JQuery zTree v3.0/js/jquery.ztree.excheck-3.0.js"></script>
<script type="text/javascript" src="../../resources/plug/JQuery zTree v3.0/js/jquery.ztree.exedit-3.0.js"></script>

<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<!-- 引入其它 -->
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js"></script>
<script src="../../resources/util/public.js" type="text/javascript"></script>
<style type="text/css">
	.td_tree_border_c3d0de{border:solid 0px #FFFFFF;height:auto}
	.tree_bg_eaeaea{background: #FFFFFF}
</style>
<script type="text/javascript">
var treetypestr = 'dd';
var rightIframename = '<%=rightIframename%>'
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
    	url: window.top.getContextPath() + '/commonTreeServlet?classNameId=com.chinacreator.xtbg.core.persondata.dao.imploracle.PsdataTypeTree', 
		autoParam:["p_type_id", "name=p_type_id", "level=lv"],
		otherParam:{"toporgId":"0","orgids":""}
    },
	data: {
		simpleData: { //简单json类型
			enable: true, 
			idKey: "p_type_id",
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

function beforeDrag(treeId, treeNodes) {
	for (var i=0,l=treeNodes.length; i<l; i++) {
		if (treeNodes[i].drag === false) {
			return false;
		}
	}
	return true;
}

function beforeDrop(treeId, treeNodes, targetNode, moveType) {
	if(treeNodes[0].parent_id != targetNode.parent_id){
		return false;
	}
	return targetNode ? targetNode.drop !== false : true;
}


function orgOnclick(event,treeId,treeNode,c,d,e) {
	if("false" != treeNode.click){
		var url="psdatabaselist.jsp?p_type_id="+treeNode.p_type_id;
	   	parent.setRightIframeSrc(url);
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

//上一次搜索的值，用来搜索高亮显示的节点
var oldSearchValue = "";
 /*
　 * description: 根据参数查询对应的节点
　 * author: 黄艺平
　 * date: 2013-05-16
　 * param:
　 * return:  
　 */
var count=0; 
function searchTree(key){
	key = $.trim($("#key").val());
	var zTree = $.fn.zTree.getZTreeObj("treeDemo");
	var keyType = "name";
	if(key != ""){
		if (oldSearchValue != key) {
			var nodesd =zTree.getNodesByParamFuzzy(keyType,key,null); 
		    for(i = count; i < nodesd.length; i++) { 
				count++; 
				if(count>=nodesd.length){ 
					count=0;
				} 
				if(nodesd[i].name.indexOf(key)!=-1){ 
					zTree.selectNode(nodesd[i]);
					zTree.expandNode(nodesd[i],false,false,false); 
					oldSearchValue = key;
					return; 
			     } 
	        }
		}
   } 
}

function zTreeOnDrop(event, treeId, treeNodes, targetNode, moveType) {//拖拽完成时间
	var zTree = $.fn.zTree.getZTreeObj("treeDemo");
	if(treeNodes == null){
		return;
	}
	var node = zTree.getNodeByParam("org_id", treeNodes[0].parent_id, null);
	var childNodes = zTree.transformToArray(node); 
	var nodes = new Array(); 
   for(i = 0; i < childNodes.length; i++) { 
		nodes[i] = childNodes[i].org_id;
	}
    params="nodes="+ nodes+"&method=order";
	$.ajax({
			url: 'sort_org_do.jsp',
			type: 'POST',
			dataType: 'json',
			data: params,
			success: function(data){
				 if(data&&data.msg){
					if(data.flag == 'true') {
						var zTree = $.fn.zTree.getZTreeObj("treeDemo");
						var node = zTree.getNodeByParam("org_id", treeNodes[0].org_id, null);
		                zTree.reAsyncChildNodes(node, "refresh");
		                zTree.expandNode(node, true, true, true);
					} else {
						alert(data.msg);
					}
				 } 
			},
			error: function(jqXHR, textStatus, errorThrown){
				var zTree = $.fn.zTree.getZTreeObj("treeDemo");
				//return false;
				alert("移动节点失败"+jqXHR+textStatus+errorThrown);
			}
	});	 
}
jQuery(function() {
	var _documentBodyHeight = window.top.findPageCacheName("_documentBodyHeight");
	jQuery("#treediv").height(_documentBodyHeight-50);
});
</script>
</head>
<body class="tree_bg_eaeaea">
<div class="web_tree_box_y"></div>
<div style="width:210px;height: 600px;overflow: auto;" id="treediv">
<ul id="treeDemo" class="ztree" ></ul>
</div>
</body>
</html>
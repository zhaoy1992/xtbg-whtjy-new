<%-- 
描述：权限管理机构树
作者：黄艺平
版本：1.0
日期：2013-04-24
 --%>
<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DaoUtil"%>
<%@page import="com.chinacreator.config.ConfigManager"%>

<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%><html>
<head>
<%
AccessControl accesscontroler = AccessControl.getInstance();
accesscontroler.checkAccess(request, response);
String path = request.getContextPath();
String curOrgId = request.getParameter("curOrgId");

String orgids = "";
if(!StringUtil.isBlank(curOrgId)) {
	StringBuffer sql = new StringBuffer();
	sql.append("select to_char(wmsys.wm_concat(o.org_id)) as orgids");
	sql.append("  from td_sm_organization o");
	sql.append(" connect by prior o.parent_id = o.org_id");
	sql.append(" start with o.org_id = " + curOrgId);
	orgids = DaoUtil.sqlToField(sql.toString());
}

%>
<title>权限管理机构树</title>

<!-- 引入jQuery -->
<script src="../resources/jquery-1.7.1.min.js" type="text/javascript"></script>



<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js"charset="utf-8"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script> 

<!-- 引入jQuery_zTree-->
<link rel="stylesheet" href="../../../resources/plug/JQuery zTree v3.0/css/zTreeStyle/zTreeStyle.css" type="text/css"/>
<script type="text/javascript" src="../../../resources/plug/JQuery zTree v3.0/js/jquery.ztree.core-3.0.js"></script>
<script type="text/javascript" src="../../../resources/plug/JQuery zTree v3.0/js/jquery.ztree.excheck-3.0.js"></script>
<script type="text/javascript" src="../../../resources/plug/JQuery zTree v3.0/js/jquery.ztree.exedit-3.0.js"></script>

<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<!-- 引入其它 -->
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js"></script>
<script src="../../../resources/js/util/public.js" type="text/javascript"></script>

<script type="text/javascript">
var treetypestr = 'dd';

var setting = {
	edit: {//移动节点
		drag : {
			isCopy: false,
			isMove: true,
			prev: true,
			inner: false,
			next: true
		},
		enable: true,
		showRemoveBtn: false,
		showRenameBtn: false
	},
	async: {
    	enable: true,//启用异步加载
    	url: window.top.getContextPath() + '/commonTreeServlet?classNameId=com.chinacreator.xtbg.tjy.officesupplies.dao.impl.OfficeosupplietypeTreeDaoImpl'
    },
	data: {
		simpleData: { //简单json类型
			enable: true, 
			idKey: "oftype_id",
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


function orgOnclick(event,treeId,treeNode) {
	var zTree = $.fn.zTree.getZTreeObj("treeDemo");
	var aaa = treeNode.oftype_id;
	//alert(aaa);
	jQuery("#oftype_id").val(treeNode.oftype_id);
	jQuery("#name").val(treeNode.name);
	parent.getTempValue("officedetaillist.jsp?oftype_id=" + treeNode.oftype_id+"&name="+treeNode.name);
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
	$("#treeDemo").height("385px");
}

$(document).ready(function(){
	$.fn.zTree.init($("#treeDemo"), setting);
	$("#key").focus();
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
				if(nodesd[i].name.indexOf(key)!=-1){ 
					zTree.selectNode(nodesd[i]);
					zTree.expandNode(nodesd[i],false,false,false); 
					oldSearchValue = key;
					count=0;
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

/*
 * description: 新增机构
 * author: 黄艺平
 * date: 2013-05-16
 * param:
 * return:  
 */
function neworg() {
	var url ='<%=path %>' + '/ccapp/oa/purviewmanager/orgusermanager/org/new_org.jsp?org_id='+jQuery("#org_id").val()+'&type=add&org_xzqm=' + jQuery("#org_xzqm").val();
	openAlertWindows('windowId',url,'添加机构','810','370','20%');
}

/*
* description: 机构基本信息修改
* author: 黄艺平
* date: 2013-05-17
* param:
* return:  
*/
function modifyOrgInfo(orgId,parentId) {
	var orgId = jQuery("#org_id").val();
	if(IsSpace(orgId)) {
		alert("请选择机构节点");
		return false;
	}
	var url = '<%=path %>' + "/ccapp/oa/purviewmanager/orgusermanager/org/new_org.jsp?type=update&org_id="+jQuery("#org_id").val()+"&parentId=" + parentId + '&org_xzqm=' + jQuery("#org_xzqm").val();;
	openAlertWindows('windowId',url,'修改机构','810','340','20%');
}

/*
* description: 删除机构
* author: 黄艺平
* date: 2013-05-23
* param:
* return:  
*/
function delOrg() {
	var orgId = jQuery("#org_id").val();
	if(IsSpace(orgId)) {
		alert("请选择机构节点");
		return false;
	}

	var url = "deleteorg_do.jsp";

	var okF = function(){
		$("#form1").attr("action",url);
		$("#form1").attr("target","hiddenFrame");
		$('#form1').submit();
	}
	var p={
			headerText:'提示',
			okName:'确认',
			okFunction:okF,
			cancelName:'取消'
	};
	alert('你确定要删除机构吗？ ',p)
	
	
}

/*
* description: 管理员设置
* author: 黄艺平
* date: 2013-05-23
* param:
* return:  
*/
function changeOrgAdmin()
{
	var orgId = jQuery("#org_id").val();
	if(IsSpace(orgId)) {
		alert("请选择机构节点");
		return false;
	}
	var url = '<%=path %>' + "/purviewmanager/userorgmanager/org/orgAdmin.jsp?orgId=" + orgId;
	openAlertWindows('windowId',url,'管理员设置','750','500','20%');
}
</script>

</head>


<body onload="adaptationWH('','treeDemo',60)">
<form id="form1" name="form1" method="post">
<input type="hidden" id="oftype_id" name="oftype_id"></input>
<input type="hidden" id="name" name="name"></input>




<div style="border-top:1px solid #EAEAEA;">
	<div class=""  >
	</div>
	<ul id="treeDemo" class="ztree" style="width: 210px; height: 400px; overflow: auto;" scrolling="yes"></ul>
</div>
</form>
<iframe name="hiddenFrame" width="0" height="0"></iframe>
</body>
</html>
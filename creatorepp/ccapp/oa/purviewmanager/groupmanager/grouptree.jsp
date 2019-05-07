<%-- 
描述：用户组管理树
作者：肖杰
版本：1.0
日期：2013-08-01
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
String group_id=StringUtil.deNull(request.getParameter("group_id"));

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
<title>用户组管理树</title>

<!-- 引入jQuery -->
<script type="text/javascript" src="../../resources/plug/jquery1.7/jquery-1.7.1.min.js"></script>
<!-- 引入jQuery_zTree-->
<link rel="stylesheet" href="../../resources/plug/JQuery zTree v3.0/css/zTreeStyle/zTreeStyle.css" type="text/css"/>
<script type="text/javascript" src="../../resources/plug/JQuery zTree v3.0/js/jquery.ztree.core-3.0.js"></script>
<script type="text/javascript" src="../../resources/plug/JQuery zTree v3.0/js/jquery.ztree.excheck-3.0.js"></script>
<script type="text/javascript" src="../../resources/plug/JQuery zTree v3.0/js/jquery.ztree.exedit-3.0.js"></script>

<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<!-- 引入其它 -->
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js"></script>
<script src="../../resources/util/public.js" type="text/javascript"></script>

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
    	url: window.top.getContextPath() + '/commonTreeServlet?classNameId=com.chinacreator.xtbg.core.common.tree.dao.impl.PurviewGroupTree', 
		autoParam:["group_id", "name=group_id", "level=lv"],
		otherParam:{"toporgId":"0","orgids":"<%=orgids%>"}
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
	jQuery("#group_id").val(treeNode.org_id);
	parent.getTempValue("userinfo.jsp?group_id=" + treeNode.org_id);
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
	var zTree = $.fn.zTree.getZTreeObj("treeDemo");
	if(""!="<%=group_id%>"){
		
		var nodesd =zTree.getNodesByParamFuzzy("org_id","<%=group_id%>",null);
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

$(document).ready(function(){
	$.fn.zTree.init($("#treeDemo"), setting);
});


function zTreeOnDrop(event, treeId, treeNodes, targetNode, moveType) {//拖拽完成时间
	var zTree = $.fn.zTree.getZTreeObj("treeDemo");
	if(treeNodes == null){
		return;
	}
	var node = zTree.getNodeByParam("org_id", treeNodes[0].parent_id, null);
	if(null==node){
		node="0";
	}
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

function newFirstGroup()
{
	/* winuser = window.showModalDialog("groupinfo_add.jsp",
							 window,"dialogWidth:"+(550)+"px;dialogHeight:"+(350)+"px;help:no;scroll:auto;status:no");
	
	if(winuser)
	{
		parent.location = parent.location;
	} */
	var url = "<%=path%>/ccapp/oa/purviewmanager/groupmanager/groupinfo_add.jsp?subid=add";
	openAlertWindows('add',url,'添加一级组',800,300,'25%','25%');
}
function findUserGroup()
{
	parent.getTempValue("grouplist.jsp");
}


</script>

</head>


<body onload="adaptationWH('','treeDemo',60)">
<form id="form1" name="form1" method="post">
<input type="hidden" id="group_id" name="group_id"></input>

<table  width="100%" border="0" cellpadding="0" cellspacing="0" class="table" >

	  	<tr>
	    	<td align="center"><a onclick="findUserGroup()">用户组查询</a></td>
	    	<% 
				if (accesscontroler.checkPermission("globalgroup","groupmanager", AccessControl.GROUP_RESOURCE)){	
			%>
	    	<td align="center"><a onclick="newFirstGroup()">新增一级组</a></td>
	    	<% 
				}
			%>
		</tr>
	<%
   	%> 
</table>


<div style="border-top:1px solid #EAEAEA;">
	<div class=""  >
	</div>
	<ul id="treeDemo" class="ztree" style="width:210px;height: 750px; overflow:scroll;overflow-x:hidden;" scrolling="yes"></ul>
</div>
</form>
<iframe name="hiddenFrame" width="0" height="0"></iframe>
</body>
</html>
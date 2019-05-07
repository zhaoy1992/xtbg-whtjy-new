<%-- 
描述：邮件树
作者：肖杰
版本：1.0
日期：2013-11-18
--%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	String path = request.getContextPath();
	//当前用户ID
	String userId = accesscontroler.getUserID();
	String state=StringUtil.deNull(request.getParameter("state"));
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>资料分类树tree</title>
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
    	url: window.top.getContextPath() + '/commonTreeServlet?classNameId=com.chinacreator.xtbg.core.email.dao.impl.EmailTree', 
		autoParam:["menu_id", "name=menu_id", "level=lv"],
		otherParam:{"toporgId":"0","orgids":""}
    },
	data: {
		simpleData: { //简单json类型
			enable: true, 
			idKey: "menu_id",
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
		onClick:orgOnclick,
		onAsyncSuccess: function(){
			var zTree = $.fn.zTree.getZTreeObj("treeDemo");
			var state="<%=state%>";
			if(""!=state){
				var menu_remark="";
				if("1"==state){
					menu_remark="3";
				}else{
					menu_remark="2";
				}
				
				var nodesd =zTree.getNodesByParamFuzzy("menu_remark",menu_remark,null);
				if(nodesd&&nodesd.length>0){
					for(i = 0; i < nodesd.length; i++) { 
						zTree.selectNode(nodesd[i]);
						orgOnclick(event,"treeDemo",nodesd[i]);
						return;
			        }
				}
			}
		}
	}
};



function orgOnclick(event,treeId,treeNode,c,d,e) {
	if("false" != treeNode.click){
		var type=treeNode.menu_remark;
		if('1'==type){//收
			var url="receivemail.jsp";
		   	parent.setRightIframeSrc(url);
		}else if('2'==type){//草稿
			var url="cgmail.jsp";
		   	parent.setRightIframeSrc(url);
		}else if('3'==type){//已发
			var url="yjsendmail.jsp";
		   	parent.setRightIframeSrc(url);
		}else if('4'==type){//发邮件
			var url="sendmail.jsp";
		   	parent.setRightIframeSrc(url);
		}
	}
}


var log, className = "dark";
//用于捕获异步加载之前的事件回调函数，zTree 根据返回值确定是否允许进行异步加载


$(document).ready(function(){
	$.fn.zTree.init($("#treeDemo"), setting);
});

jQuery(function() {
	var _documentBodyHeight = window.top.findPageCacheName("_documentBodyHeight");
	jQuery("#treediv").height(_documentBodyHeight-40);
});

</script>
</head>
<body class="tree_bg_eaeaea">
<div class="web_tree_box_y"></div>
<!-- <h3>&nbsp;档案分类</h3>  -->
<div id="treediv" style="overflow: auto;" >
<ul id="treeDemo" class="ztree" style="width:200px;height: 600px;"></ul>
</div>
</body>
</html>
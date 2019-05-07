<%--
    描述：档案管理，机构树界面
    作者：戴连春
    版本：1.0
    日期：2013-6-13
--%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DaoUtil"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<%
	String path = request.getContextPath();
	String ischeck = request.getParameter("ischeck");//用来判断是否是复选框,默认是radio
	String readonly = request.getParameter("readonly"); //是否只读，1：只读，0：

	AccessControl accessControl = AccessControl.getInstance();
	accessControl.checkAccess(request, response);
	String orgid = accessControl.getChargeOrgId();
	String userid = accessControl.getUserID();

	/**
	 *系统没有了配置信息，先写个特定的编码
	 * 
	 */
	String treeName = "组织机构";
	String showLevel = "";
	if (StringUtil.isBlank(request.getParameter("showLevel"))) {
		showLevel = "0";
	} else {
		showLevel = StringUtil
				.deNull(request.getParameter("showLevel"));
	}

	String treetypestr = "";
	if ("true".equals(ischeck)) {
		treetypestr = "checkbox";
	} else {
		treetypestr = "radio";
	}
%>
	<TITLE>人员档案管理组织机构树信息</TITLE>	
	<!-- 引入jQuery -->
	<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
	
	<!--引入jQuery_zTree  -->
	<script type="text/javascript" src="../../resources/plug/JQuery zTree v3.0/js/jquery.ztree.core-3.0.js"></script>
	<script type="text/javascript" src="../../resources/plug/JQuery zTree v3.0/js/jquery.ztree.excheck-3.0.js"></script>
	
	<!-- 引入其它 -->
	<script src="../../resources/util/public.js" type="text/javascript"></script>
	<script src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js" type="text/javascript"></script>
	<style type="text/css">
	.td_tree_border_c3d0de{border:solid 0px #FFFFFF;height:auto}
	.tree_bg_eaeaea{background: #FFFFFF}
	</style>
	<SCRIPT type="text/javascript">
		var treetypestr = '<%=treetypestr%>';

		//机构树的初始化设置
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
			},
			callback: {				
				onClick:onclick
			}
		};
		
		/**
		 *设置字体
		 */
		function getFont(treeId, node) {
			return node.font ? eval('(' + node.font + ')') : {};
		}
		/**
		 *树被点击时触发的事件
		 */
		function onclick(event,treeId,treeNode){
			if("false" != treeNode.click){
				var url="directoryseelist.jsp?orgid="+treeNode.org_id+"&readonly="+<%=readonly%>;
			   	parent.getTempValue(url);
			}
		}
		
		$(document).ready(function(){
			var span = {
					url : window.top.getContextPath()+'/pubtree',
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
					data : "{'user':''}",
					classID : 'config',
					method : 'inqueryTreeReportOrganization'
				}
				window.top.ajaxTools(span);			
		});
		
		jQuery(function() {
			var _documentBodyHeight = window.top.findPageCacheName("_documentBodyHeight");
			jQuery("#treediv").height(_documentBodyHeight-50);
		});
		
	</script>
</head>

<body class="tree_bg_eaeaea">
	<div class="web_tree_box_y">		
	</div>
	<div style="width:210px;height: 600px;overflow: auto;" id="treediv">
		<ul id="treeDemo" class="ztree"></ul>
	</div>
</body>
</html>
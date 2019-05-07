<%--
	描述：字典数据树
	作者：肖杰
	版本：1.0
	日期：2013-7-23
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
	String orgid=request.getParameter("orgid");
	String dictdata_id=(request.getParameter("dictdata_id")).replace("'", "");
	String dict_type=request.getParameter("dict_type");

%>
	<TITLE>字典数据树</TITLE>	
	<!-- 引入jQuery -->
	<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
	
	<!--引入jQuery_zTree  -->
	<script type="text/javascript" src="../../resources/plug/JQuery zTree v3.0/js/jquery.ztree.core-3.0.js"></script>
	<script type="text/javascript" src="../../resources/plug/JQuery zTree v3.0/js/jquery.ztree.excheck-3.0.js"></script>
	
	<!-- 引入其它 -->
	<script src="../../resources/util/public.js" type="text/javascript"></script>
	<script src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js" type="text/javascript"></script>
	<SCRIPT type="text/javascript">
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
	    	url: window.top.getContextPath() + '/commonTreeServlet?classNameId=com.chinacreator.xtbg.core.dict.dao.impl.DictDataTree', 
			autoParam:["dictdata_id", "name=dictdata_id", "level=lv"],
			otherParam:{"toporgId":"0","orgid":"<%=orgid%>"}
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
			onClick:onclick,
			onAsyncSuccess: function(){
				var zTree = $.fn.zTree.getZTreeObj("treeDemo");
				if(""!="<%=dictdata_id%>"){
					var nodesd =zTree.getNodesByParamFuzzy("org_id","<%=dictdata_id%>",null);
					if(nodesd&&nodesd.length>0){
						for(i = 0; i < nodesd.length; i++) { 
							zTree.selectNode(nodesd[i]);
							onclick(event,"treeDemo",nodesd[i]);
							return;
				        }
					}
				}
			}
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
				var url="dictdatalist.jsp?org_id="+treeNode.org_id+"&org_name="+treeNode.name+"&orgid=<%=orgid%>&dict_type=<%=dict_type%>";
			   	parent.getTempValue(url);
			}
		}
		
		$(document).ready(function(){
			$.fn.zTree.init($("#treeDemo"), setting);
		});
		
	</script>
</head>

<body onload="adaptationWH('','treeDemo',1)">
	<div class="web_tree_box_y"><span>字典数据</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;		
	</div>
	<ul id="treeDemo" class="ztree" style="width:220px;height: 550px; overflow:scroll;overflow-x:hidden;" scrolling="yes"></ul>
</body>
</html>
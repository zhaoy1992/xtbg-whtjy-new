<%--
描述：机构树
作者：戴连春
版本：1.0
日期：2013-06-13
--%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.personwork.service.*"%>
<%@page import="com.chinacreator.xtbg.core.personwork.service.impl.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<%
AccessControl accesscontroler = AccessControl.getInstance();
accesscontroler.checkAccess(request, response);
	String path = request.getContextPath();
	String userid = accesscontroler.getUserID();
	String orgid = accesscontroler.getChargeOrgId();
	String showLevel="3";
	if(StringUtil.isBlank(request.getParameter("showLevel"))){
		showLevel="3";
	}else{
		showLevel=request.getParameter("showLevel");
	}
	String ischeck = request.getParameter("ischeck");//用来判断是否是复选框,默认是radio
	String treetypestr = "";
	if("true".equals(ischeck)){
		treetypestr = "checkbox";
	}else{
		treetypestr = "radio";
	}
	//个人通讯录操作的service对象
	PersonInfoServiceIfc service = new PersonInfoServiceImpl();
    //查询顶级机构id
    String theRootOrgid = service.queryRootOrg();
%>
<title> ZTREE DEMO - reAsyncChildNodes</title>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>

<!-- 引入jQuery_zTree-->
<script type="text/javascript" src="../../resources/plug/JQuery zTree v3.0/js/jquery.ztree.core-3.0.js"></script>
<script type="text/javascript" src="../../resources/plug/JQuery zTree v3.0/js/jquery.ztree.excheck-3.0.js"></script>

<!-- 引入其它 -->
<script src="../../resources/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
	
<script type="text/javascript">
		var treetypestr = '<%=treetypestr%>';
		//初始化树的设置
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
				//beforeClick: beforeClick,
				//beforeAsync: beforeAsync,
				//onAsyncError: onAsyncError,
				//onAsyncSuccess: onAsyncSuccess,
				onClick:onclick
			}
		};

		/**
		 *获得字体样式
		 */ 
		function getFont(treeId, node) {
			return node.font ? eval('(' + node.font + ')') : {};
		}

		/**
		 * 树点击后，调用的函数
		 */
		function onclick(event,treeId,treeNode){
			if("false" != treeNode.click){
			 	var url="../../personwork/jsp/publicaddressbook4roleuser.jsp?orgid="+treeNode.org_id;
			 	
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
			
			$.fn.zTree.init($("#treeDemo"), setting);
		});

	</script>

</head>

<body onload="adaptationWH('','treeDemo',100)">
	<div style="border-top:1px solid #EAEAEA;"   >
		<div class="web_tree_box_y"  ></div>
		<ul id="treeDemo" class="ztree" style="width:210px;height: 700px; overflow:scroll;overflow-x:hidden;" scrolling="yes"></ul>
	</div>
</body>
</html>
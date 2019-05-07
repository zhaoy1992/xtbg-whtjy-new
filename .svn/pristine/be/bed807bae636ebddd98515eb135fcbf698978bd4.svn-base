<%@page import="com.chinacreator.security.AccessControl"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@page
	import="com.chinacreator.xtbg.pub.tree.service.ModuleTreeServiceIfc"%>
<%@page
	import="com.chinacreator.xtbg.pub.tree.service.impl.ModuleTreeServiceImpl"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.chinacreator.xtbg.pub.util.DaoUtil"%>
<%@page import="java.util.List"%>
<%@page import="com.chinacreator.sysmgrcoreext.manager.bean.UserOrgStatusBean"%>
<%@page import="com.chinacreator.sysmgrcoreext.manager.IOrgManagerExt"%>
<%@page import="com.chinacreator.sysmgrcoreext.manager.db.OrgManagerExtImpl"%><html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
AccessControl accesscontroler = AccessControl.getInstance();
accesscontroler.checkAccess(request, response);
String userId = accesscontroler.getUserID();
String userKey = accesscontroler.getUserAccount();
String orgId = accesscontroler.getChargeOrgId();
boolean isOrgManager = accesscontroler.isOrganizationManager(orgId);
IOrgManagerExt om = new OrgManagerExtImpl();
List<UserOrgStatusBean> orglist = om.getCurrentOrg(userId);
Map<String,Object> userInfos = new HashMap<String,Object>();
userInfos.put("userId",userId);
userInfos.put("userKey",userKey);
userInfos.put("orgId",orgId);
userInfos.put("isOrgManager",String.valueOf(isOrgManager));
userInfos.put("allOrgList",orglist);

String path = request.getContextPath();
String ischeck = request.getParameter("ischeck");//用来判断是否是复选框,默认是radio
String isnokeshi = request.getParameter("isnokeshi");//是否不要科室，默认是不要
//System.out.println("isnokeshiisnokeshi:"+isnokeshi);
//ischeck = "true";
String treetypestr = "";
if("true".equals(ischeck)){
	treetypestr = "checkbox";
}else{
	treetypestr = "radio";
}

ModuleTreeServiceIfc mIfc=new ModuleTreeServiceImpl();
String zNodes =mIfc.getOrgTreeMessageByUserInfo(userInfos);
String theRootOrgid = DaoUtil.SqlToField("select org_id from td_sm_organization where parent_id='0'");
%>

	<TITLE> 机构用户树</TITLE>



	<!-- 引入jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/JQuery zTree v3.0/js/jquery.ztree.core-3.0.js"></script>
<script type="text/javascript" src="../../../resources/plug/JQuery zTree v3.0/js/jquery.ztree.excheck-3.0.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
	<SCRIPT type="text/javascript">
	$(function(){
		$("#treeDemo").attr("style","height:"+($(parent).height()*1-16)+"px")
	})
		var setting = {
			view: {
					selectedMulti: false   
					/*
					1、设置为 true时，按下 Ctrl 键可以选中多个节点
					2、设置为 true / false 都不影响按下 Ctrl 键可以让已选中的节点取消选中状态（ 取消选中状态可以参考 setting.view.autoCancelSelected ）
					*/
			},
			data: {
				simpleData: {
					enable: true,
					idkey:"id",
					pIdKey:"ppp",
					rootPId:0
				}
			},
			check: {
				enable: false,
				/*
				chkStyle = "checkbox" 时，显示 checkbox 选择框，setting.check.chkboxType 属性有效。
				chkStyle = "radio" 时，显示 radio 选择框， setting.check.radioType 属性有效。
				
				请注意大小写，不要改变
				*/
				chkStyle: '<%=treetypestr%>',
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
				onClick:onclick
			}
		};

		function onclick(event, treeId, treeNode){
			//alert("---"+treeNode.id);
			parent.togrant(treeNode.id,treeNode.name);
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
				returnValId += nodes[i].id + ",";
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
		
		var zNodes=<%=zNodes%>;
		$(document).ready(function(){
			$.fn.zTree.init($("#treeDemo"), setting,zNodes);
		});
		 $(function(){
			  style = window.top.getSystemStyle();
		     var p=["/ccapp/xtbg/resources/plug/JQuery zTree v3.0/"+style+"/css/demoout.css"];
		     loadCss(p,window);
		  });
		
	</SCRIPT>
</head>

<body  onload="adaptationWH('','treeDemo',154)">
<ul id="treeDemo" class="ztree" ></ul>
</body>
</html>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@page
	import="com.chinacreator.xtbg.pub.tree.service.ModuleTreeServiceIfc"%>
<%@page
	import="com.chinacreator.xtbg.pub.tree.service.impl.ModuleTreeServiceImpl"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
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
ModuleTreeServiceIfc mIfc=new ModuleTreeServiceImpl();
String zNodes =mIfc.getOrgTreeMessageByUserInfo(userInfos);
%>

	<TITLE> 机构用户树</TITLE>


</head>

<body  >

<ul id="treeDemo" class="ztree" ></ul>
</body>
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
			data: {
				simpleData: {
					enable: true,
					idkey:"id",
					pIdKey:"ppp",
					rootPId:0
				}
			},
			callback: {
				onClick:showJQgrid
			}
		};

		function showJQgrid(event, treeId, treeNode){
			parent.getTempValue(treeNode.id);
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
</html>
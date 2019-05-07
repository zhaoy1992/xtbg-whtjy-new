<%--
	描述：档案查询index页面
	作者：邹拓
	版本：1.0
	日期：2013-7-23
--%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<style type="text/css">
		HTML{overflow: hidden;}
		.td_tree_border_c3d0de{border:solid 1px #c3d0de;height:auto}
		.tree_bg_eaeaea{background: #eaeaea}
	</style>
	<!-- 引入jQuery -->
	<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
	<!-- 引入其它 -->
	<script src="../../resources/util/public.js" type="text/javascript"></script>
	<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
	<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
	<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js" charset="utf-8"></script>
	<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
	<script type="text/javascript">
		function setRightIframeSrc(url){
			$("#rightIframe").attr("src",url);
		}
		var treeNodeName = "";
		function leftPageTreeNodeOnClick(event,treeId,treeNode){
			treeNodeName = treeNode.name;
			setRightIframeSrc("filefilesquerybydeptlist.jsp?level="+treeNode.level+"&nodeId="+treeNode.id);
			
		}
		
		function resize(docID,otherHeight){
			  var topHeight = 0
			  try{         
			       var parent = window.parent;     
			       if(parent){
			           topHeight = jQuery("#_top",parent.document).height()||0;  
			       }
			  }catch(e){
			      topHeight = 0;
			  }
			  var hight =window.top.findPageCacheName("_documentBodyHeight");

			  jQuery("#" + docID).height(hight - otherHeight-topHeight);
			  jQuery("#" + docID).css("overflow", "auto"); 
			  return jQuery("#" + docID).height();      
			}
		jQuery(function(){
			adaptationWH('','leftTree',1);
			adaptationWH('','vcenter',1);
			resize("tree",5);
			resize("ifbook",5);
		});
	</script>
</head>
<body style="overflow-y: hidden; maring: 0px; padding: 0px;">
<table width="100%" cellpadding="0" cellspacing="2" border="0"
	style="margin: 0px;">
	<tr>
		<td width="200px" style="border: solid 1px #c3d0de;">
		<div id="leftTree" style="float: left; width: 100%;"><iframe
			id="tree" src="organddepttree.jsp" scrolling="no" width="100%"
			frameborder="0"></iframe></div>
		</td>
		<td style="border: solid 1px #c3d0de;">
		<div id="vcenter" style="float: left; width: 100%;"><iframe
			id="rightIframe" src="filefilesquerybydeptlist.jsp" scrolling="no" width="100%" height="400px"
			frameborder="0"></iframe></div>
		</td>
	</tr>
</table>
</body>
</html>
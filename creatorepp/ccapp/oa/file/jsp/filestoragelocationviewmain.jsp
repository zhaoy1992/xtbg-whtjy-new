<%--
	描述：档案存放位置管理
	作者：肖杰
	版本：1.0
	日期：2013-7-15
--%>
<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@page import="com.chinacreator.security.AccessControl"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
	String path = request.getContextPath();
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);

%>
<title>档案存放位置管理</title>
<style type="text/css">
HTML{overflow: hidden;}
</style>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<script type="text/javascript">

function getTempValue(url){
	$("#rightIframe").attr("src",url);
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
			id="tree" src="filestoragelocationztree.jsp" scrolling="no" width="100%"
			frameborder="0"></iframe></div>
		</td>
		<td style="border: solid 1px #c3d0de;">
		<div id="vcenter" style="float: left; width: 100%;">
			<iframe
			id="rightIframe" src="filestoragelocationlist.jsp" scrolling="no" width="100%" height="400px"
			frameborder="0"></iframe>
		</div>
		</td>
	</tr>
</table>
</body>

</html>
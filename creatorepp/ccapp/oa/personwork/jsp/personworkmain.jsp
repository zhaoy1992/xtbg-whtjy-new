<%--  
描述：公共通讯录权限管理
作者：戴连春
版本：1.0
日期：2013-06-13
--%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%
AccessControl accesscontroler = AccessControl.getInstance();
accesscontroler.checkAccess(request, response);
	String path = request.getContextPath();
	String loginUserID = accesscontroler.getUserID();
%>
<%@page import="com.chinacreator.security.AccessControl"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>公共通讯录权限管理</title>

<!-- 引入jQuery -->
<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>

<script type="text/javascript">
function getTempValue(url){
    $("#ifbook").attr("src",url);
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
	resize("ifbook",40);
	//特检院OA  修改 【单位通讯录】底部有一节不展示，不美观。 2014-05-22 start
	//resize("tree"  ,40);
    resize("tree"  ,35);
    //特检院OA  修改 【单位通讯录】底部有一节不展示，不美观。 2014-05-22 end
});

</script>
</head>
<body style="overflow: hidden;maring:0px;padding:0px;">

<table width="100%" cellpadding="0" cellspacing="0" border="0" style="margin: 0px;">

<tr>
<td width="200px">
<iframe id="tree" src="orgtree4publicaddressbookroleruser.jsp" scrolling="no" width="220px" frameborder="0"></iframe>
</td>

<td>
<iframe id="ifbook" src="publicaddressbook4roleuser.jsp" scrolling="no" width="100%"  frameborder="0"></iframe>
</td>
</tr>

</table>

</body>
</html>
<%--
	描述：档案查询index页面
	作者：邹拓
	版本：1.0
	日期：2013-7-23
	页面参数:
	f_type_id 档案分类id
	f_child_type_id 跳转到某一个 档案分类详细页面
--%>
<%@ page contentType="text/html; charset=GBK"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	String f_type_id = request.getParameter("f_type_id");
	String f_child_type_id = request.getParameter("f_child_type_id");
	String urlTmp = "?rightIframename=filefilesquerylist.jsp";
	if(!StringUtil.nullOrBlank(f_type_id)){
		urlTmp = "?f_type_id="+f_type_id;
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>JGRID</title>
<style type="text/css">
HTML{overflow: hidden;}
.td_tree_border_c3d0de{border:solid 1px #c3d0de;height:auto}
.tree_bg_eaeaea{background: #eaeaea}
</style>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<!-- 引入其它 -->
<script src="../../resources/js/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<script type="text/javascript">
function setRightIframeSrc(url){
	$("#rightIframe").attr("src",url);
}
function showLeftIframe(flag){
	if(flag){
		$("#leftTd").show();
	}else{
		$("#leftTd").hide();
	}
}
//档案类型id
var f_type_id = "";
var f_type_name = "";
var f_type_level = "0";//档案类型级别,只有级别为3时，才能在其下面添加档案
var f_typeno = "";//档号
function leftPageTreeNodeOnClick(event,treeId,treeNode){
	//1
	f_type_level = treeNode.f_type_level;
	f_type_name = treeNode.f_type_parentname;
    f_typeno = treeNode.f_typeno;
	f_type_id = treeNode.f_type_id;
	//2
	if(treeNode.name=='会计档案'||treeNode.name=='会计账本'||treeNode.name=='会计凭证'){
		setRightIframeSrc("query"+treeNode.f_files_list);
		return;
	}
	if(treeNode.f_file_list){
		setRightIframeSrc("query"+treeNode.f_file_list+"?f_type_id="+treeNode.f_type_id+"&f_type_name="+encodeURI(treeNode.name)+"&f_file_detail="+treeNode.f_file_detail );
	}else{
		setRightIframeSrc("");
	}
}
function leftPageOnAsyncSuccess(){
	return true;
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
			id="tree" src="filetypetree.jsp<%=urlTmp%>" scrolling="no" width="100%"
			frameborder="0"></iframe></div>
		</td>
		<td style="border: solid 1px #c3d0de;">
		<div id="vcenter" style="float: left; width: 100%;"><iframe
			id="rightIframe" src="" scrolling="no" width="100%" height="610px"
			frameborder="0"></iframe></div>
		</td>
	</tr>
</table>
</body>
</html>
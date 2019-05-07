<%--
¡¡¡¡ÃèÊö£ºµµ°¸¹ÜÀí --ÎÄ¼þ¹ÜÀímain
¡¡¡¡×÷Õß£º»Æº£
¡¡¡¡°æ±¾£º1.0
¡¡¡¡ÈÕÆÚ£º2013-7-22
--%>
<%@ page contentType="text/html; charset=GBK"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.core.common.tree.dao.impl.FileTypeTree"%>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	String f_type_id = request.getParameter("f_type_id");
	String f_child_type_id = request.getParameter("f_child_type_id");
	String urlTmp = "";
	if(!StringUtil.nullOrBlank(f_type_id)){
		urlTmp = "?f_type_id="+f_type_id;
	}else{
		urlTmp = "?rightIframename=autoConfig";
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>µµ°¸¹ÜÀí --ÎÄ¼þ¹ÜÀí</title>
<style type="text/css">
HTML{overflow: hidden;}
.td_tree_border_c3d0de{border:solid 1px #c3d0de;height:auto}
.tree_bg_eaeaea{background: #eaeaea}
</style>
<!-- ÒýÈëjQuery -->
<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<!-- ÒýÈëÆäËü -->
<script type="text/javascript">

var role = "<%=StringUtil.deNull(request.getParameter("role"))%>";

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

//µµ°¸ÀàÐÍid
var f_type_id = "";
var f_type_name = "";
var f_type_level = "0";//µµ°¸ÀàÐÍ¼¶±ð,Ö»ÓÐ¼¶±ðÎª3Ê±£¬²ÅÄÜÔÚÆäÏÂÃæÌí¼Óµµ°¸
var f_typeno = "";//µµºÅ

function leftPageTreeNodeOnClick(event,treeId,treeNode){
    var id = treeNode.f_type_id;
	if("<%=FileTypeTree.FILE_TYPE_TREE_ROOT_NODE%>" == id ){
       id = "";
	}
	f_type_name = treeNode.f_type_parentname;
    f_type_level = treeNode.f_type_level;
    if(f_type_level!=3&&treeNode.COUNTTA=='0'){
    	f_type_level=3;
    }
    
    f_typeno = treeNode.f_typeno;
	f_type_id = id;
	
	if(treeNode.f_file_list){
		setRightIframeSrc(""+treeNode.f_file_list+"?f_type_id="+treeNode.f_type_id+"&f_type_name="+encodeURI(treeNode.f_type_parentname)+"&f_file_detail="+treeNode.f_file_detail );
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
			id="tree" src="filetypetree.jsp" scrolling="no" width="100%"
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
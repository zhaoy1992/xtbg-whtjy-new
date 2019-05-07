<%--
	��������������indexҳ��
	���ߣ�����
	�汾��1.0
	���ڣ�2013-7-18
	ҳ�����:
	f_type_id ��������id
	f_child_type_id ��ת��ĳһ�� ����������ϸҳ��
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
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>JGRID</title>
<style type="text/css">
HTML{overflow: hidden;}
.td_tree_border_c3d0de{border:solid 1px #c3d0de;height:auto}
.tree_bg_eaeaea{background: #FFFFFF}
</style>
<!-- ����jQuery -->
<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<!-- �������� -->
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
leftPageCount=1;
leftPageTreeNodeOnClick=function(event,treeId,treeNode){
	if(treeNode.f_type_level!='3'){
		rightIframename="filetypelist.jsp";
		vall = treeNode.f_type_id;
		level = treeNode.f_type_level;
		if(vall){
			if(vall=='<%=FileTypeTree.FILE_TYPE_TREE_ROOT_NODE%>'){
				vall='';
			}else{
				vall='?f_type_id='+ vall+'&f_type_level='+level;
			}
		}else{
			vall='';
		}
		setRightIframeSrc(rightIframename+vall);
	}else{
		if(treeNode.f_type_id){
			windowId = 'filetypeinfoJSP'+leftPageCount;
			leftPageCount++;
			urlTmp = "filetypeinfo.jsp?f_type_id="+treeNode.f_type_id+"&actionName=update&windowId="+windowId;
			rightWindow = document.getElementById("rightIframe").contentWindow;
			rightWindow.top.window[windowId+"href"] = rightWindow.location.href;
			rightWindow.location.href = urlTmp;
		}
	}
};
var drag = {
	isCopy: false,
	isMove: true,
	prev: true,
	inner: false,
	next: true
};
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
  resize("rightIframe",5);
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
		<div id="vcenter" style="float: left; width: 100%;">
			<%if(f_child_type_id!=null){%>
			<iframe
			id="rightIframe" src="filetypeinfo.jsp?f_type_id=<%=f_child_type_id%>&actionName=update" scrolling="no" width="100%"
			frameborder="0"></iframe>
			<%}else{%>
			<iframe
			id="rightIframe" src="filetypelist.jsp<%=urlTmp%>" scrolling="no" width="100%"
			frameborder="0"></iframe>
			<%}%>
		</div>
		</td>
	</tr>
</table>
</body>
</html>
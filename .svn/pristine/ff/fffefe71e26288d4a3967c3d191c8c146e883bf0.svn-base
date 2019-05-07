<%--
describe:档案管理主界面
author:dailianchun
date: 2013-7-17
--%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%
String path = request.getContextPath();

%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>

<!-- 引入jQuery -->
<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js"></script>


<script type="text/javascript">

var role = "<%=StringUtil.deNull(request.getParameter("role"))%>";

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
	adaptationWH('','leftTree',1);
    adaptationWH('','vcenter',1);
    resize("tree",5);
    resize("ifbook",5);    
    
});

//档案类型id
var f_type_id = "";
var f_type_name = "";
var f_type_level = "0";//档案类型级别,只有级别为3时，才能在其下面添加档案
var f_typeno = "";//档号
/**
 * 树点击后调用的函数
 */
var leftPageTreeNodeOnClick =function(event,treeId,treeNode){
	var id = treeNode.f_type_id;
	if("Hello World!" == id ){//邹拓同学定义的根节点id
       id = "";
	}
	f_type_name = treeNode.f_type_parentname;
    f_type_level = treeNode.f_type_level;
    if(f_type_level!="3"&&!treeNode.children){
    	f_type_level="3";
    }
    f_typeno = treeNode.f_typeno;
	f_type_id = id;
	
	getListPage(id,treeNode.f_type_level);
}
/**
 *左侧页面默认选中第一个三级节点
 */
function leftPageOnAsyncSuccess(){
	return true;
}
/**
 * 子页面处理
 */
function getListPage(typeId,typeLevel){
	//ajax方式提交数据
    jQuery.ajax({
        type: "post", 
        url: "<%=path %>/ajaxServlet?className=com.chinacreator.xtbg.core.file.action.FileFilesAction&method=queryPageByTypeId", 
        contentType: "application/x-www-form-urlencoded; charset=utf-8",
        data : {
             f_type_id: typeId
        },
        dataType: "json",
        success: function (data) {
            if(data.flag){
               var page = jQuery("#ifbook").attr("src");
               jQuery("#ifbook").attr("src",data.page);
               /**
               if(page != data.page){
            	   jQuery("#ifbook").attr("src",data.page)
               }else{
            	   var child = jQuery("#ifbook");
            	   if(child.length>=1 && child[0].contentWindow ){
            	       if(child[0].contentWindow.search){
            	            child[0].contentWindow.search();
	            	   }
	            	   if(child[0].contentWindow.showOrHideButton){
	            	            child[0].contentWindow.showOrHideButton(f_type_level);
            	       }
            	    }
               }
               **/
            }else{
               //找不到页面，隐藏按钮
            	 var child = jQuery("#ifbook");
                 if(child.length>=1 && child[0].contentWindow ){                     
                     if(child[0].contentWindow.showOrHideButton){
                         //传入级别1，隐藏按钮
                         child[0].contentWindow.showOrHideButton("0");
                     }
                  }
            }
        }, 
        error: function (XMLHttpRequest, textStatus, errorThrown) {          
            alert("出现异常，请稍后再试！");
        }
     });
  }



</script>
</head>
<body style="overflow-y: hidden;maring:0px;padding:0px;">

<table width="100%" cellpadding="0" cellspacing="2" border="0" style="margin: 0px;">

<tr>
<td width="200px" style="border:solid 1px #c3d0de;">
<div id="leftTree" style="float: left; width: 100%;"> 
<iframe id="tree" src="filetypetree.jsp" scrolling="no" width="100%" frameborder="0"></iframe>
</div>
</td>
<td style="border:solid 1px #c3d0de;">
<div id="vcenter" style="float: left; width: 100%;">
<iframe id="ifbook" src="" scrolling="no" width="100%"  frameborder="0"></iframe>

</div>
</td>
</tr>

</table>

</body>
</html>
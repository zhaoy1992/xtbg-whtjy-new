<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />

</head>
<body style="width:99%;">
<input type="hidden" class="initload" submitKey="select" actionId="resouceConfig" methodName="initResourceConfig" successful="initsucessful"/>
<div style="width:100%; float: left;">
<div class="input_class" id="top">
    <div class="content_02_top" style="margin-bottom: 10px;"id='content_02_top'>
     <input id="save" value="保存" type="button" class="but_y_01" />
     <!--input id="clear" value="清除" type="button" class="but_y_01" /-->
     <input type="checkbox" id="batch" /><div>&nbsp;批量配置</div>
</div>
</div>
	<div style="width: 100%" id="vcenter">
		<div class="tree_class">
		   <div class="header_class">
		       <div class="header_img"></div>
		            模块树
		   </div>
		    <ul id='treeDemo_purview' class='ztree'></ul>
		</div>

		<div  class="tree_class">
		 <div class="header_class">
		 <div class="header_img"></div>
			<div style="float: right;padding: 5px 5px 0 5px;">
		    	<input type="button" value="搜索" class="but_y_01" id="butseacht"/>
		    </div>
		    <input type="text" class="_z_tree_seachter_input" id="seachInput"/>
		    <span class="config_tree_class">配置树</span>
		 </div>
		      <ul id='treeDemo_person' class='ztree'></ul>
		</div>

		<div  class="tree_class">
		 <div class="header_class">
		       <div class="header_img"></div>
		                 
	<span id="configText">人员树</span>
		       </div>
		      <ul id='treeDemo_config' class='ztree'></ul>
		</div>
	</div>
</div>
</body>

<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-remote.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-treetools.js"></script>

<script type="text/javascript" src="../../../resources/plug/JQuery zTree v3.0/js/jquery.ztree.core-3.0.js"></script>
<script type="text/javascript" src="../../../resources/plug/JQuery zTree v3.0/js/jquery.ztree.excheck-3.0.js"></script>
<script type="text/javascript" src="../../../resources/plug/JQuery zTree v3.0/js/jquery.ztree.exedit-3.0.js"></script>
<script type="text/javascript" src="../resources/js/tree.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>

<script type="text/javascript">

  $(function(){
	  style = window.top.getSystemStyle();
	  
	  adaptationWH("top","vcenter",20);
	  $(".ztree").height($("#vcenter").height()-80);
	  $("body").width($(window).width());
     var p=["/ccapp/xtbg/resources/plug/JQuery zTree v3.0/"+style+"/css/demoout.css"];
     loadCss(p,window);
  });
</script>
</html>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	//子系统ID
	String sys_id = request.getParameter("sys_id");
	//windowid
	String subid=request.getParameter("subid");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>用户导入</title>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>

<!-- 引入my97时间控件 -->
<script src="../../resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
	
<!-- 引入formvValidatetion -->
<link rel="stylesheet" href="../../resources/plug/formvalidation/css/validationEngine.jquery.css" type="text/css" />
<script src="../../resources/plug/formvalidation/jquery.validationEngine-cn.js" type="text/javascript" charset="utf-8"></script>
<script src="../../resources/plug/formvalidation/jquery.validationEngine.js" type="text/javascript" charset="utf-8"></script>

<!-- 引入其它 -->
<script src="../../resources/js/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
</head>
<script>
$(function() {
	$(document).keydown(function(){	
		if(event.keyCode == 13){ 
			userSearch();
		}
	});
});

	function Ok(){
		var uploadFile = $("#filepath").get(0).value+"";
		if(uploadFile.length <= 1 || uploadFile.indexOf(".xls")<0){
			alert("请选择用户表,支持xls格式文件");
			return;
		}
		var sys_id =$("#sys_id").val();
		$("#form1").attr("target","hiddenFrame");
		form1.action="subsys_userimportdo.jsp?sys_id="+sys_id;
		$("#form1").submit();
	}

	function saveBack(){
		removeWindows('<%=subid%>',true);
	}

	window.onload = function () {
		adaptationWH("_top","vcenter");
	}
	function setOutStr(str){
		$("#outStr").append(str);
	}
	
	/*
	函数:  setChange
	说明:  设置下载模版
	参数:   无
	返回值: 下载模块
	*/
	function setChange(){
		var hrefPath="/ccapp/oa/subsystemmanage/excel/";
		$("#impIfr").attr("src","download.jsp?hrefPath="+hrefPath);
	}
</script>
<body style="overflow-y:hidden;">
<form id="form1" action="" method="post" class="formular" enctype="multipart/form-data">
<input id="sys_id" name="sys_id" type="hidden" value="<%=sys_id%>" > 
<!-- 操作按钮  -->
<div style="overflow: hidden;">
	<div class="content_02_top"  id="_top">
		<div class="content_02_top"  id='content_02_top'>
			<input class="but_y_01" type="button" id="sel"  value="导入" onClick="Ok()"/>
			<input class="but_y_01" type="button" id="back"  value="返回" onClick="saveBack()"/>
		</div>
	</div>		
</div>	
<div id="vcenter" style="float:left; width:100%; " >
<div style="float: left; width: 775px; ">
<div class="content_02_box_div">	
<table width="571" >
	<tr>
		<th class="content_02_box_div_table_th"><FONT style="COLOR: red">*</FONT>选择用户表</th>
		<td class="content_02_box_div_table_td" width="415" >
		<input type="file" id="filepath" name="filepath" class="input_188" style="width: 180px;" value="">
		</td>
	</tr>
	<tr>
		<th class="content_02_box_div_table_th"></th>
		<td class="content_02_box_div_table_td" width="415">
			请按照模板格式填写用户表&nbsp;&nbsp;&nbsp;<a onClick="setChange()" href="#"  style="color: blue">模版下载</a>		</td>
	</tr>
	
</table>
<table width="571">
<tr class="content_02_box_div_table_th">
<td  class="content_02_box_div_table_td" width="100%">
<div id="outStr" style="width:100%;height: 300px;overflow: scroll" scrolling="yes"" >
	
</div>
</td>
</tr >
</table>
</div>
</div>
</div>
</form>
<iframe name="hiddenFrame" width=0 height=300></iframe>
<iframe id="impIfr" name="impIfr" width="0" height="0"></iframe>
</body>
</html>
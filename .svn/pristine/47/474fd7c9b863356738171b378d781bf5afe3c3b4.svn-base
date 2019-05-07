<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	String currentYear = DateUtil.getCurrentYear();

	String currentMonth = DateUtil.getCurrentMonth();
%>
<%@page import="com.chinacreator.xtbg.pub.util.DateUtil"%><html>
<% 




%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>工资导入</title>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>

<!-- 引入my97时间控件 -->
<script src="../../../resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
	
<!-- 引入formvValidatetion -->
<link rel="stylesheet" href="../../../resources/plug/formvalidation/css/validationEngine.jquery.css" type="text/css" />
<script src="../../../resources/plug/formvalidation/jquery.validationEngine-cn.js" type="text/javascript" charset="utf-8"></script>
<script src="../../../resources/plug/formvalidation/jquery.validationEngine.js" type="text/javascript" charset="utf-8"></script>

<!-- 引入其它 -->
<script src="../../../resources/js/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
</head>
<script>
$(function(){
    //表单验证  
    $("#form1").validationEngine();
})
var currentYear = "<%=currentYear%>";
var currentMonth = "<%=currentMonth%>";

	function Ok(){
		$("#form1").attr("target","hiddenFrame");
		form1.action="addressBookimportdo.jsp?salarytype=bj&wdo=batch";
		$("#form1").submit();
	}

	function saveBack(){
		
	}

	window.onload = function () {
		$("#year").val(currentYear);
		$("#month").val(currentMonth);
		adaptationWH("_top","vcenter");
	}
	function setOutStr(str){
		$("#outStr").append(str);
	}
	function setChange(){
		//var salarytype=$("#salarytype").val();
		var hrefPath="/ccapp/xtbg/public/personwork/excel/";
		//$("#impIfr").attr("src","download.jsp?hrefPath="+hrefPath+"&salarytype="+salarytype);
		$("#impIfr").attr("src","download.jsp?hrefPath="+hrefPath+"&salarytype=bj");
	}
	function getyears(){
		var data = new Date();
		var year = data.getYear();
		var obj=document.getElementById('year');
		for(var i=0;i<5;i++){
			 obj.add(new Option(year-i,year-i));  
		}
		for(var i=0;i<5;i++)
		{
			obj.options[i].value = year-i;
		}
	}
</script>
<body style="overflow-y:hidden;">
<form id="form1" action="" method="post" class="formular" enctype="multipart/form-data">
<!-- 操作按钮  -->
<div style="overflow: hidden;">
	<div class="content_02_top"  id="_top">
		<div class="content_02_top"  id='content_02_top'>
			<input class="but_y_01" type="button" id="sel"  value="导入" onclick="Ok()"/>
		</div>
	</div>		
</div>	
<div id="vcenter" style="float:left; width:100%; " >
<div style="float: left; width: 775px; ">
<div class="content_02_box_div">	
<table >
	<tr>
		<th class="content_02_box_div_table_th" rowspan="2"><FONT style="COLOR: red">*</FONT>选择通讯录表</th>
		<td class="content_02_box_div_table_td" width="250px;" >
		<input type="file" id="filepath" name="filepath" class="input_188 validate[required]" style="width: 180px;">
		</td>
	</tr>
	<tr>
		<td class="content_02_box_div_table_td" width="250px;">
			&nbsp;请按照模板格式填写通讯录表&nbsp;&nbsp;&nbsp;<a onclick="setChange()" href="#"  style="color: blue">模版下载</a>
		</td>
	</tr>
</table>
<table width="456px">
<tr class="content_02_box_div_table_th">
<td  class="content_02_box_div_table_td" width="100%">
<div id="outStr" style="width:100%;height: 300px;overflow: auto;" >
	
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
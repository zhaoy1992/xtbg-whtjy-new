<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.chinacreator.fusionchart.util.FusionUtil"%>
<%@page import="com.chinacreator.fusionchart.web.FusionStaticField"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String selectedField = FusionUtil.getParameterString(request,"selectedField");
String fusionid = FusionUtil.getParameterString(request,"chart_only_id");

Map<String,String> sessionChartPMap = (Map)session.getAttribute(FusionStaticField.PROPERTIES_STRING+fusionid);

pageContext.setAttribute("selectedField",selectedField);
pageContext.setAttribute("path",path);
pageContext.setAttribute("fusionid",fusionid);


String drillTypeOrg = sessionChartPMap ==null?"nodrill":sessionChartPMap.get("fusion_drilldown.type");
String drillType = null;
	if("frame".equals(drillTypeOrg)){
		drillType = "2";
	}else if("javascript".equals(drillTypeOrg)){
		drillType = "3";
	}else if("popup".equals(drillTypeOrg)){
		drillType = "1";
	}else{
		drillType = "0";
	}

pageContext.setAttribute("drillType",drillType);
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>ç½®</title>
	
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="this is my page">
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    
    <!--<link rel="stylesheet" type="text/css" href="./styles.css">-->
	<link href="${path}/FusionCharts/styles/css/creator.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="${path}/FusionCharts/jquery-1.3.min.js"></script>
  </head>
  <SCRIPT LANGUAGE="JavaScript">
<!--
	$(function(){
	
			if(${drillType} == 1){
				doajax('./drillDown_popup.jsp');
			}else if(${drillType} == 2){
				doajax('./drillDown_frame.jsp');
			}else if(${drillType} == 3){
				doajax('./drillDown_script.jsp');
			}			
	});
	
	function disableParam(paramTD)
	{
		document.getElementById(paramTD).style.display="none";
	}
	function enableParam(paramTD)
	{
		document.getElementById(paramTD).style.display="";
	}
	function disableInfo()
	{
		document.getElementById('pageInfo').style.display="none";
	}
	function enableInfo()
	{
		document.getElementById('pageInfo').style.display="";
	}
	function changeParamType(p_type)
	{
		
		
		var to_load='';
		if(p_type == '0'){
			$('#showConfigPage').html('');
			return;
		}else if(p_type=='1')
			to_load='${path}/FusionCharts/drillDown_popup.jsp?selectedField=${selectedField}&chart_only_id=${fusionid}';
		else if(p_type=='2')
			to_load='${path}/FusionCharts/drillDown_frame.jsp?selectedField=${selectedField}&chart_only_id=${fusionid}';
		else if(p_type=='3')
			to_load='${path}/FusionCharts/drillDown_script.jsp?selectedField=${selectedField}&chart_only_id=${fusionid}';
		
		doajax(to_load)
	}
	changeParamType(${drillType});
	
	
	// 该页面的渲染不能使用异步的形式，若使用异步的形式，那么可能存在在该页面异步渲染还未完毕
	// 而result.jsp展示页面已经加载完毕，而result.jsp页面的展示钻取属性是需要通过这个页面完全渲染完毕才能
	// 初始化，所以需要保证在执行result.jsp页面前保证该页面初始化完毕
	
	function doajax(myurl){
		$.ajax({
		    url: myurl,
		    type: 'POST',
		    async : false, //NOTE
		    error: function(){
		        alert('加载钻取页面出错');
		    },
		    success: function(data){
		        $('#showConfigPage').html(data);
		    }
		});
		
	}
//-->
	</SCRIPT>
  <body>
  <!--
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#518ec8" style="margin-bottom:10px">
      <tr>
        <td width="122" height="24" align="center" class="White12px" nowrap><strong>å¾å½¢é»åéç½®</strong></td>
        <td width="90%" bgcolor="#f0f4f5"></td>
      </tr>
      <tr>
        <td height="100%" colspan="2" align="center" valign="top" bgcolor="#FFFFFF">
		-->
        	<table width="98%" border="0" cellspacing="0" cellpadding="1">
        	<tr>
        		<td align="left">
        			<input type="radio" id="drillType" name="drillType" value="0" ${drillType eq '0'? 'checked':'' } onClick="changeParamType(0)">&nbsp;无&nbsp;
        			<input type="radio" id="drillType" name="drillType" value="1" ${drillType eq '1'? 'checked':'' } onClick="changeParamType(1)">弹出窗口方式配置
        			<input type="radio" id="drillType" name="drillType" value="2" ${drillType eq '2'? 'checked':'' } onClick="changeParamType(2)">Frame链接方式配置
        			<input type="radio" id="drillType" name="drillType" value="3" ${drillType eq '3'? 'checked':'' } onClick="changeParamType(3)">JavaScript调用方法配置       		</td>
        	</tr>
        	<tr>
        		<td valign="top">
					<div id="showConfigPage" align="left"><img src="${path}/FusionCharts/styles/images/loading.gif" border=0></div>
				</td>
			</tr>
			</table>
		<!--</td>
      </tr>
    </table>-->
  </body>
</html>

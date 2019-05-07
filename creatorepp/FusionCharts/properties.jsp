<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.chinacreator.fusionchart.web.FusionStaticField"%>
<%@page import="com.chinacreator.fusionchart.util.FusionUtil"%>
<%
String path = request.getContextPath();
//String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
Map<String,String> sessionChartPMap = (Map)session.getAttribute(FusionStaticField.PROPERTIES_STRING+request.getParameter("chart_only_id"));
FusionUtil.iteratorMap(sessionChartPMap);
pageContext.setAttribute(FusionStaticField.PROPERTIES_STRING,sessionChartPMap);
pageContext.setAttribute("path",path);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
<title>图形配置</title>
<script type="text/javascript" src="${path}/FusionCharts/jquery-1.3.min.js"></script>
<script language="javascript" src="${path}/FusionCharts/colorselect/picker.js"></script>
<link href="${path}/FusionCharts/colorselect/picker.css" rel="stylesheet" type="text/css"/>

<style type="text/css">
<!--
#colorbord{border:1px solid #cccccc; background:#ffffcc; padding:5px; display:none; position:absolute;}
-->
</style>
</head>
<script type="text/javascript">
   xOffset = 5;
   yOffset = 10;
   objName = '';



function getObjName(p_name)
{
	objName=p_name;
	return;
    $("a").click(function(e){
       if(this.id=='color')
    	{
      		//$("body").append("<div id=\"colorbord\" ></div>"); 
      		var toLoad1 = '${path}/FusionCharts/colorFrame.jsp?textId='+objName+' #content';
      		//var toLoad1 = '${path}/FusionCharts/selectColor.jsp?textId='+objName;
			$("#colorbord").load(toLoad1) ;
			$("#colorbord")
		    .css("top",(e.pageY + xOffset) + "px")
		    .css("left",(e.pageX + yOffset) + "px")
		    .fadeIn("slow");    
  		}  
    });

}

function getInfo(p_colorId,colorValue)
{
	document.getElementById(p_colorId).value=colorValue;
	document.getElementById('v_'+p_colorId).style.backgroundColor=colorValue;
	$("#colorbord").css("display","none");
}

function cancleInfo()
{
	$("#colorbord").css("display","none");
}

jQuery(function($) {
    //标志线Table删除按钮事件绑定
    $("#trend_table.del").click(function() {
        $(this).parents("tr").remove();
    });
    //标志线表格的添加按钮事件绑定
    $("#addTrend").click(function(){
        $("#trend_table>tbody").append('<tr>'+
				'<td>&nbsp;显示名称：<input type="text" name="fusion_trendLines.displayValue" size="15" style="height:18"/></td>'+
				'<td>&nbsp;标志线颜色：<input type="text" name="fusion_trendLines.color" readonly="true" size="15" style="height:18"/>'+
				'&nbsp;<input id="aa" type="text" name="v_showColor" readonly="true" onclick="getObjName(\'showColor\')" '+
				'style="border:solid 1px 	#000000;background-color:#ffff00;width:20"></td>'+
				'<td>&nbsp;数值：<input type="text" name="fusion_trendLines.startValue" size="15" style="height:18"/></td>'+
				'')
    });
});




</script>
<body>
<div id="colorbord"  style="position: absolute;"></div>
<table width="100%" border="0" cellspacing="1" cellpadding="0">
  <tr><td colspan="3" width="100%" style="height:5"></td></tr>
  <tr>
    <td nowrap="nowrap">&nbsp;主标题：<input type="text" name="fusion_caption" size="20" style="height:18" value="${pstr.fusion_caption}"/></td>
    <td nowrap="nowrap" align="right">&nbsp;X轴名称：<input type="text" name="fusion_xAxisName" size="15" style="height:18" value="${pstr.fusion_xAxisName}"/></td>
    <td nowrap="nowrap" align="right">数据前缀：<input type="text" name="fusion_numberPrefix" size="15" style="height:18" value="${pstr.fusion_numberPrefix}"/>&nbsp;</td>
  </tr>
  <tr>
    <td nowrap="nowrap">&nbsp;子标题：<input type="text" name="fusion_subCaption" size="20" style="height:18" value="${pstr.fusion_subCaption}"/></td>
    <td nowrap="nowrap" align="right">&nbsp;Y轴名称：<input type="text" name="fusion_yAxisName" size="15" style="height:18" value="${pstr.fusion_yAxisName}"/></td>
    <td nowrap="nowrap" align="right">&nbsp;数据后缀：<input type="text" name="fusion_numberSuffix" size="15" style="height:18" value="${pstr.fusion_numberSuffix}"/>&nbsp;</td>
  </tr>
   <tr>
    <td nowrap="nowrap">&nbsp;字体大小：<input type="text" name="fusion_baseFontSize" size="20" style="height:18" value="${pstr.fusion_baseFontSize}"/></td>
    <td nowrap="nowrap" align="right">&nbsp;画布外字体大小：<input type="text" name="fusion_outCnvBaseFontSize" size="20" style="height:18" value="${pstr.fusion_outCnvBaseFontSize}"/></td>
    <td nowrap="nowrap" align="right">&nbsp;</td>
  </tr>
  
  <tr><td colspan="3" width="100%" style="height:5"></td></tr>
  
  <tr>
  
    <td nowrap="nowrap">&nbsp;是否直接在图上显示数据：<input type="radio" name="fusion_showValues" value="1" ${pstr.fusion_showValues ne 0?'checked=checked':''}/>显示&nbsp;
	<input type="radio" name="fusion_showValues" value="0" ${pstr.fusion_showValues eq 0?'checked=checked':''}/>不显示
	</td>
    <td nowrap="nowrap" align="right">&nbsp;小数位数：<input type="text" name="fusion_decimals" size="15" style="height:18" value="${pstr.fusion_decimals}"/></td>
    <td nowrap="nowrap" align="right">&nbsp;Y轴最小值：<input type="text" name="fusion_yAxisMinValue" size="15" style="height:18" value="${pstr.fusion_yAxisMinValue}"/>&nbsp;</td>
  </tr>
  <tr>
    <td nowrap="nowrap" colspan="2">&nbsp;是否格式化数字：<input type="radio" name="fusion_formatNumberScale" value="1" ${pstr.fusion_formatNumberScale ne '0'?'checked=checked':''} />是&nbsp;
	<input type="radio" name="fusion_formatNumberScale" value="0"  ${pstr.fusion_formatNumberScale eq '0'?'checked=checked':''}/>否
	<span class="STYLE1">(该选项将自动的给你的数字加上K或M)</span>	</td>
    <td nowrap="nowrap" align="right">&nbsp;Y轴最大值：<input type="text" name="fusion_yAxisMaxValue" size="15" style="height:18" value="${pstr.fusion_yAxisMaxValue}"/>&nbsp;</td>
  </tr>
  <tr>
    <td nowrap="nowrap" colspan="1">&nbsp;是否将数字四舍五入：<input type="radio" name="__decimals" value="1" ${pstr.fusion_decimals ne '0'?'checked=checked':''} />是&nbsp;
	<input type="radio" name="fusion_decimals" value="0"  ${pstr.fusion_decimals eq '0'?'checked=checked':''}/>否</td>
	<td nowrap="nowrap" colspan="2">是否显示图形边框：<input type="radio" name="fusion_showBorder" value="1" ${pstr.fusion_showBorder ne '0'?'checked=checked':''} />是&nbsp;
	<input type="radio" name="fusion_showBorder" value="0"  ${pstr.fusion_showBorder eq '0'?'checked=checked':''}/>否
  </tr>
  <tr>
  	<td nowrap="nowrap" colspan="1">&nbsp;柱内显示数据：<input type="radio" name="fusion_placeValuesInside" value="1" ${pstr.fusion_placeValuesInside eq '1'?'checked=checked':''} />是&nbsp;
	<input type="radio" name="fusion_placeValuesInside" value="0"  ${pstr.fusion_placeValuesInside ne '1'?'checked=checked':''}/>否&nbsp;&nbsp;</td>
	<td nowrap="nowrap" colspan="2">&nbsp;纵向显示数据：<input type="radio" name="fusion_rotateValues" value="1" ${pstr.fusion_rotateValues eq '1'?'checked=checked':''} />是&nbsp;
	<input type="radio" name="fusion_rotateValues" value="0"  ${pstr.fusion_rotateValues ne '1'?'checked=checked':''}/>否&nbsp;&nbsp;</td>
  </tr>
  
  <tr><td colspan="3" width="100%" style="height:5"></td></tr>
  
  <tr>
    <td nowrap="nowrap">&nbsp;外框背景色：<input type="text" name="fusion_bgColor" readonly="true" size="15" style="height:18;background-color:${pstr.fusion_bgColor}" value="${pstr.fusion_bgColor}"/>
	<a id="color" class="preview" >
	<input id="aa" type="text" name="v_fusion_bgColor" readonly="true" onclick="openPicker('fusion_bgColor')" class="picker_buttons" style="border:solid 1px #000000;background-color:#ffff00;width:20" />	
	</a>
	</td>
    <td nowrap="nowrap" align="right">&nbsp;外框背景透明度：<input type="text" name="fusion_bgAlpha" size="15" style="height:18" value="${pstr.fusion_bgAlpha}"/></td>
    <td nowrap="nowrap" align="right">&nbsp;&nbsp;</td>
  </tr>
  <tr>
    <td nowrap="nowrap">&nbsp;图形背景色：<input type="text" name="fusion_canvasBgColor" readonly="true" size="15" style="height:18;background-color:${pstr.fusion_canvasBgColor}" value="${pstr.fusion_canvasBgColor}"/>
	<a id="color" class="preview" >
	<input id="aa" type="text" name="v_fusion_canvasBgColor" readonly="true" onclick="openPicker('fusion_canvasBgColor')" class="picker_buttons" style="border:solid 1px #000000;background-color:#ffff00;width:20" />	
	</a>
	</td>
    <td nowrap="nowrap" align="right">&nbsp;图形背景透明度：<input type="text" name="fusion_canvasBgAlpha" size="15" style="height:18" value="${pstr.fusion_canvasBgAlpha}"/></td>
    <td nowrap="nowrap" align="right">&nbsp;&nbsp;</td>
  </tr>
   
   <tr><td colspan="3" width="100%" style="height:5"></td></tr>
   
  <tr>
    <td nowrap="nowrap" colspan="2">&nbsp;是否显示标志线：<input type="radio" name="fusion_trendLines.have" value="1" ${pstr.fusion_showBorder eq '1'?'checked=checked':''} />是&nbsp;
	<input type="radio" name="fusion_trendLines.have" value="0"  ${pstr.fusion_showBorder ne '1'?'checked=checked':''}/>否&nbsp;&nbsp;

	<a href="javascript:function aa(){return null;}" id="addTrend">"增加标志线" </a>
	&nbsp;&nbsp;&nbsp;<input type="button" value="图形其他属性" />
	</td> 
  	
  	</tr>
  <tr id="trend_tr" style="display:">
  	<td colspan="3" align="center">
	<!-- TrendLine Table Begin -->
	<table width="98%" border="0" cellpadding="1" cellspacing="1" bgcolor="#d0d0d0" style="margin-bottom:10px">
	<tr>
		<td bgcolor="#FFFFFF" class="tablehead">
		<table id="trend_table" width="100%" border="0">
		<TBODY>
			<tr>
				<td>&nbsp;显示名称：<input type="text" name="fusion_trendLines.displayValue" size="15" style="height:18" value="${pstr['fusion_trendLines.displayValue']}"/></td>
				<td colspan="2">&nbsp;标志线颜色：<input type="text" name="fusion_trendLines.color" readonly="true" size="15" style="height:18;background-color:${pstr['fusion_trendLines.color']}" value="${pstr['fusion_trendLines.color']}"/>
				<a id="color" class="preview" >
				<input id="aa" type="text" name="v_fusion_trendLines.color" readonly="true" onclick="openPicker('fusion_trendLines.color')" class="picker_buttons" style="border:solid 1px #000000;background-color:#ffff00;width:20" />
				</a>
				</td>
				<td>&nbsp;数值：<input type="text" name="fusion_trendLines.startValue" size="15" style="height:18" value="${pstr['fusion_trendLines.startValue']}"/></td>
				
			</tr>
		</TBODY>
		</table>
		</td>
	</tr>
	</table>
	<!-- TrendLine Table End -->
	</td>
  </tr>
  <tr id="otherp">
 	<td colspan="3" width="100%"></td>
  </tr>
</table>

</body>
</html>

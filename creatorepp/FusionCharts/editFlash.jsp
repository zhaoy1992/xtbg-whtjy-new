<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="com.chinacreator.fusionchart.web.FusionStaticField"%>
<%@page import="com.chinacreator.fusionchart.util.FusionUtil"%>
<%
boolean isFill = false;

String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String sql = request.getParameter("sql");
String fields = request.getParameter("fields");
String fusionid = request.getParameter("fusionid");	
String isuseexsit = request.getParameter("isuseexsit");
String f_w = request.getParameter("f_w");
String f_h = request.getParameter("f_h");

String f_top = request.getParameter("f_top");
if(StringUtils.isBlank(f_top)){
	f_top = "0";
}

String f_left = request.getParameter("f_left");
if(StringUtils.isBlank(f_left)){
	f_left = "0";
}
//Map<String,String> sessionChartPMap = (Map)session.getAttribute(FusionStaticField.PROPERTIES_STRING+fusionid);
//---------------
String isuseurl = FusionUtil.getParameterString(request,"isuseurl"); //是否使用URL远程数据源
String dataurl = FusionUtil.getParameterString(request,"dataurl");

if("1".equals(isuseurl)){
	if(StringUtils.isBlank(dataurl)){
		out.print("你未选择任何URL");
		return;
	}
}


String modelType = request.getParameter("modeltype"); //ms,scroll,single
String modelCode = request.getParameter("modelcode");

String eformDataSetName = request.getParameter("eformDataSetName");

//满足if条件即为选择了某个模板
if(!StringUtils.isBlank(isuseexsit)){
	String modelname = isuseexsit;
	if(StringUtils.isBlank(modelname)){
		out.print("你未选定任何模板");
		return;
	}
	
	Map m = FusionUtil.propertiesStrToMapByid(modelname);
	
	//使用已有的模板
	session.removeAttribute(FusionStaticField.PROPERTIES_STRING+fusionid);
	session.setAttribute(FusionStaticField.PROPERTIES_STRING+fusionid,m);
	modelType  = FusionUtil.checkIsMSchart(FusionUtil.getChartType(modelname))?"multi":"single";
	
	String mc = FusionUtil.getChartType(modelname);
	if("multi".equals(modelType)){
		modelCode = StringUtils.isBlank(mc)?"MSColumn2D":mc;
	}
	
	if("single".equals(modelType)){
		modelCode = StringUtils.isBlank(mc)?"Column2D":mc;
	}
	//modelCode = "multi".equals(modelType)?FusionUtil.getChartType(modelname):"MSColumn2D";
	//modelCode = "single".equals(modelType)?FusionUtil.getChartType(modelname):"Column2D";
	if("ScrollColumn2D".equals(modelCode) || "ScrollArea2D".equals(modelCode)){
		modelType = "scroll";
		modelCode = FusionUtil.getChartType(modelname);
	}
	
}else{
	if(StringUtils.isBlank(modelType)) {modelType = "single";}
	modelCode = request.getParameter("modelCode");
	if(StringUtils.isBlank(modelCode)) {modelCode = "Column2D";}
}



pageContext.setAttribute("isuseurl",isuseurl);
pageContext.setAttribute("f_top",f_top);
pageContext.setAttribute("f_left",f_left);
pageContext.setAttribute("dataurl",dataurl);

pageContext.setAttribute("modeltype",modelType);
pageContext.setAttribute("modelcode",modelCode);
		
pageContext.setAttribute("f_w",f_w);
pageContext.setAttribute("f_h",f_h);
pageContext.setAttribute("path",path);
pageContext.setAttribute("sql",sql);
pageContext.setAttribute("fusionid",fusionid);
pageContext.setAttribute("fields",fields);
pageContext.setAttribute("eformDataSetName",eformDataSetName);

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>图形配置</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">

		<link href="${path}/FusionCharts/styles/css/creator.css"
			rel="stylesheet" type="text/css" />
		<script type="text/javascript"
			src="${path}/FusionCharts/jquery-1.3.min.js"></script>
		<script type="text/javascript"
			src="${path}/FusionCharts/jquery.form.js"></script>
	</head>

	<style>
BODY {
	SCROLLBAR-ARROW-COLOR: #FFFFFF;
	SCROLLBAR-FACE-COLOR: #2878C8;
	SCROLLBAR-DARKSHADOW-COLOR: #2878C8;
	SCROLLBAR-HIGHLIGHT-COLOR: #2878C8;
	SCROLLBAR-3DLIGHT-COLOR: #2878C8;
	SCROLLBAR-SHADOW-COLOR: #2878C8;
}
</style>
	<script LANGUAGE="JavaScript">
	var v_date=0;
  </script>

	<SCRIPT LANGUAGE="JavaScript">
<!--

		var issaved = false;

	var initdata = 0;
	$(function(){			
			var toLoad1 = '${path}/FusionCharts/modelList.jsp?chart_only_id=${fusionid}&modelType=${modeltype}&modelCode=${modelcode}';
			$('#showTable').load(toLoad1,function (){++initdata;});
			document.getElementById('chart_modeltype').value='${modeltype}';
			
			var toLoad2 = '${path}/FusionCharts/properties.jsp?chart_only_id=${fusionid}';
			$('#showProperties').load(toLoad2,function (){++initdata;})
			
			var toLoad3;
			if('${modeltype}'=='single'){
				 toLoad3 = '${path}/FusionCharts/dataView.jsp?sql='+encodeURI('${sql}')+'&fields='+encodeURI('${fields}')+'&chart_only_id='+encodeURI('${fusionid}')+'&isuseurl=${isuseurl}&dataurl='+encodeURI('${dataurl}');
				
			}else{
				 toLoad3 = '${path}/FusionCharts/dataViewMS.jsp?sql='+encodeURI('${sql}')+'&fields='+encodeURI('${fields}')+'&chart_only_id='+encodeURI('${fusionid}')+'&modeltype=${modeltype}&modelcode=${modelcode}&isuseurl=${isuseurl}&dataurl='+encodeURI('${dataurl}');
			}
			//loadDrillDownMain();
			$('#showData').load(toLoad3,function (){
				
				//数据的钻取是基于数据的，所以等待数据加载完毕后再加在
				//先获取所选择的列
				loadDrillDownMain();
			//	var selectedField = getSelectedFieldString();
			//	var toLoad4 = '${path}/FusionCharts/drillDown_main.jsp?selectedField='+encodeURI(selectedField)+'&chart_only_id=${fusionid}';
				//$('#showDrillDown').load(toLoad4,function(){++initdata;})
				++initdata;
			}
			)
	});

	function loadDrillDownMain(){
		var selectedField = getSelectedFieldString();
		var toLoad4 = '${path}/FusionCharts/drillDown_main.jsp?selectedField='+encodeURI(selectedField)+'&chart_only_id=${fusionid}';
		$('#showDrillDown').load(toLoad4,function(){})
	}
	
	var intervalret = setInterval('listener()',50);
	function listener(){
		if(initdata==3){
			//若三个页面全部加在完成再加在flash预览
			//if('loadover' != $('#isload').val()){
			//	//未加载完
			//	listener();
			//}
			
			
			clearInterval(intervalret);
			document.getElementById('chart_action').value='2';
			//alert($('#fusionForm').serialize());
			$.ajax({
			type:'POST',
	 		url:   "${path}/FusionCharts/resault.jsp?isfirstload=1",
	 		data: $('#fusionForm').serialize()+'&dataurl=${dataurl}',
	 		success: function(data){
	 			$('#chartView').html(data);
	 		},
	 		error : function(){
	 			$('#chartView').html('数据预览出现错误');	
	 		}   
			});
		}
	}
	
  	/**
  	* 切换模板类型事件
  	*/
	function changeType(p_type)
	{
			$('#chartView').html('请选择图形');
			
			//重新load模板列表
			var toLoad1 = '${path}/FusionCharts/modelList.jsp?modelType='+p_type;
			document.getElementById('chart_modeltype').value=p_type;
			$('#showTable').load(toLoad1,function (){++initdata;})
			
			//如果是多数据列模板，将重新load数据预览列表
			var toLoad2 = '';
			if(p_type=='single')
			{
				toLoad2 = '${path}/FusionCharts/dataView.jsp?sql='+encodeURI('${sql}')+'&fields='+encodeURI('${fields}')+'&chart_only_id='+encodeURI('${fusionid}')+'&isuseurl=${isuseurl}&dataurl='+encodeURI('${dataurl}');
				$('#showData').load(toLoad2,function (){++initdata;})
			}
			else
			{
				toLoad2 = '${path}/FusionCharts/dataViewMS.jsp?sql='+encodeURI('${sql}')+'&fields='+encodeURI('${fields}')+'&chart_only_id='+encodeURI('${fusionid}')+'&isuseurl=${isuseurl}&dataurl='+encodeURI('${dataurl}');
				$('#showData').load(toLoad2,function (){
				
				if($('#chart_modeltype').val()=='scroll'){
					changeTD('combine','0');
					changeTD('combineDY','0');
					changeTD('combineST','0');
				}
				++initdata;
				})
			}
			
			
	}
	
	var hascombine=',MSCombi2D';
	var has2Y=',MSCombiDY2D,MSStackedColumn2DLineDY';
	/**
	* 点击某个图形模板事件
	*/
	function changeModel(){
		document.getElementById('chart_action').value='2';
		$.ajax({
		type:'POST',
 		url:   "${path}/FusionCharts/resault.jsp",
 		data: $('#fusionForm').serialize()+'&dataurl=${dataurl}',
 		success: function(data){
 			$('#chartView').html(data);
 		},
 		error : function(){
 			$('#chartView').html('数据预览出现错误');	
 		}   
		});
		
		var mstype = document.getElementById('chart_modeltype').value;
		//如果是多数据类型模板才执行下面操作
		if(mstype=='ms' || mstype=='multi')
		{
			var td_ary = document.getElementsByName("chart_modelname");
			var modelID = '';
			for(var i=0;i<td_ary.length;i++)
			{
				if(td_ary[i].checked)
				{
					modelID = ','+td_ary[i].value;
				}
			}
			//判断是选取了组合图形，还是双坐标图形
			if(hascombine.indexOf(modelID)>-1)
			{
				changeTD('combine','1');
				changeTD('combineDY','0');
				changeTD('combineST','0');
				
			}
			else if(has2Y.indexOf(modelID)>-1)
			{
				changeTD('combine','1');
				changeTD('combineDY','1');
				if(modelID.indexOf('MSStackedColumn2DLineDY')>-1)
					changeTD('combineST','1');
				else
					changeTD('combineST','0');
			}
			else
			{
				changeTD('combine','0');
				changeTD('combineDY','0');
				changeTD('combineST','0');
			}
			
		}
	}
	
	function changeTD(tdID,isShow)
	{
	
		var td_ary = document.all[tdID];
		
		//if(td_ary == undefined){
		//	return;
		//}
		if(isShow=='1')
		{
	   		for(var   i=0;i <td_ary.length;i++)
			{
	   			td_ary[i].style.display="";
	   		}
		}
		else
		{
			for(var   i=0;i <td_ary.length;i++)
			{
				td_ary[i].style.display="none";
			}
		}
	}
	
	var v_url = "${path}/FusionCharts/resault.jsp?dataurl=${dataurl}";
	
	$(document).ready(function(){
	
		var options = {
	    target:     '#chartView',
	    url:        v_url,
	    beforeSubmit : function(){
	    	return checkData();
	    },
	    type: "POST",
	    error: function(request) {      // 设置表单提交出错
                    alert("表单提交出错，请稍候再试"+request);
                    },
	    success: function(data) {
	      if( $('#chart_action').val()=='1'){
	      	 if("error" == data){
	      	 	 alert('保存失败');
	      	 }else{
		      	 $('#chartView').html('');
		      	 if('1' == '${isuseurl}'){
		      	 	//url形式
		      	 	var returnids = data.substring(0,data.indexOf('$'));
					alert('保存成功');
		      	 	//window.close();
		      	 	window.location.href = 'noeformsuccess.jsp?fusionid='+returnids+'&dataurl=${dataurl}';	
		      	 }else{
		      	 	parent.parent.returnvalue = data;
				 	uf_ok();
				 }
	      	 }
	      }
	      
	    } };
	
	   // 将options传给ajaxForm
		$('#fusionForm').ajaxForm(options);
		
		
		$("#refrashData").click(function(){
			  document.getElementById('chart_action').value='2';
		  }); 
		$("#saveData").click(function(){
			  document.getElementById('chart_action').value='1';
		  });
	});	

	function uf_ok() {
	
	   var obj=parent.parent.pubDataSet[0] ;
	   
	   obj.returnValue = encodeURI(parent.parent.returnvalue);
	   
	   if(obj.returnValue== undefined || jQuery.trim(obj.returnValue)== ''){
	   var answer = confirm("你未设置图表属性，你确定保存吗？\n 确定：不设置图片信息  \n 取消：继续设置图片信息")
		   if(!answer){
		   		return;
		   }
	   }
	   
	   obj.f_w=$('#chart_width').val();
	   obj.style.width = obj.f_w;
	   obj.f_h=$('#chart_height').val();
	   obj.style.height = obj.f_h;
	   
	   obj.style.top = '${f_top}';
	   obj.style.left = '${f_left}';
	   window.close();
	}

	function selectModel(paramStr)
	{
		$.ajax({                                                 
    	type: "POST",                                     
   	    url: "${path}/FusionCharts/resault.jsp?dataurl=${dataurl}",                                   
    	data: paramStr,  
    	success: function(msg){                   
        alert("数据提交成功");                    
        document.getElementById("chartView").innerHTML = msg 
	    }   
	  });
	}
	
	function cancelStep(){
		var answer = confirm("你确定退出属性配置吗吗?")
			 if(!answer){
				   		return;
			}
			 window.close();
	}

	var hasChange=false;
	//此函数在 dataViedMS.jsp 与 dataView.jsp中被执行 
	function changeSelected(){
		hasChange = true;
	}
	
	function changeTable(entdID,distdID)
	{
		//alert(tdID);
		document.getElementById(entdID+'TD').className='table_btn_on';
		document.getElementById(entdID+'A').style.color='#FFFFFF';
		document.getElementById(entdID).style.display='block';
		document.getElementById(distdID+'TD').className='table_btn_off';
		document.getElementById(distdID+'A').style.color='#000000';
		document.getElementById(distdID).style.display='none';

		if(entdID=="showDrillDown"&&hasChange){			
			loadDrillDownMain();
			hasChange=false;
		}
	}
	
	
	//获得当前被选择的列名 以^分割
	function getSelectedFieldString(){
		    var msflag = $('#msflag').val();
			var fieldsparams = '';
			
			if('1' == msflag){
				//多数据集类型
				var selectedlines = $('input.noclass');
				for(var i=0;i<selectedlines.length;i++){
				
					if(selectedlines[i].checked){
						fieldsparams = fieldsparams +selectedlines[i].value+ '^';
					}
				
				}
								
			}else{
				//单数据集类型
				var selectedlines = document.getElementsByName('chart_selectfileds');
				for(var i=0;i<selectedlines.length;i++){
					if(selectedlines[i].checked){
						fieldsparams = fieldsparams +selectedlines[i].value+'^';
					}
				}
			}
			
			return fieldsparams;
	}
	
	function changeMainTab(tid){
		
		if('attrSet' == tid){ //属性
			$('#showStyles').attr('style','display:none');
			$('#showProperties').attr('style','');
			$('#attrSetTd').attr('class','table_btn_on');
			$('#styleSetTd').attr('class','table_btn_off');
			$('#attrSet').attr('style','color:#FFFFFF');
			$('#styleSet').attr('style','color:#000000');
			return;
		}
	
		if('styleSet' == tid){//样式
			$('#showStyles').attr('style','');
			$('#showProperties').attr('style','display:none');
			$('#attrSetTd').attr('class','table_btn_off');
			$('#styleSetTd').attr('class','table_btn_on');
			$('#attrSet').attr('style','color:#000000');
			$('#styleSet').attr('style','color:#FFFFFF');
			return;
		}
	}
//-->
</SCRIPT>
	<body style="topmargin: 10" bgcolor="#FFFFFF">

		<center>
			<form id="fusionForm" name="fusionForm"
				action="${path}/FusionCharts/resault.jsp?dataurl=${dataurl}"
				method="post">
				<input type=hidden name=chart_action value="" id="chart_action">
				<input type=hidden name=chart_modeltype value="${modelType}"
					id="chart_modeltype">
				<input type=hidden name=fusion_useRoundEdges value="1">
				<input type=hidden name=chart_only_id value="${fusionid}">
				<input type=hidden name=eformDataSetName value="${eformDataSetName}">

				<table width=100% border=0 style="height: 10">
					<tr>
						<td></td>
					</tr>
				</table>
				<table width="95%" border="0" align="center" cellpadding="0"
					cellspacing="0">
					<tr>
						<td width="40%" valign="top">
							<!-- 模板选择表格 Begin-->
							<div id="showTable" align="center">
								<img src="${path}/FusionCharts/styles/images/loading.gif"
									border=0>
							</div>
							<!-- 模板选择表格 End-->
						</td>

						<td style="width: 10">
							&nbsp;
						</td>

						<td width="60%" valign="top">
							<!-- 图形属性配置Table Begin -->
							<table width="100%" border="0" align="center" cellpadding="0"
								cellspacing="1" bgcolor="#518ec8" style="margin-bottom: 10px">
								<tr>
									<td width="80" height="24" align="center" class="table_btn_on"
										id="attrSetTd">
										<a href="javascript:changeMainTab('attrSet');" id="attrSet"
											style="color: #FFFFFF"><strong>图形属性配置</strong>
										</a>
									</td>
									<td width="80" align="center" class="table_btn_off"
										id="styleSetTd">
										<a href="javascript:changeMainTab('styleSet');" id="styleSet"
											style="color: #000000"><strong>样式模板</strong>
										</a>
									</td>
									<td width="60" bgcolor="#f0f4f5" align="right">
									</td>
								</tr>
								<tr>
									<td height="100%" colspan="3" align="center" valign="top"
										bgcolor="#FFFFFF">
										<div id="showProperties" align="center">
											<img src="${path}/FusionCharts/styles/images/loading.gif"
												border=0>
										</div>
										<div id="showStyles" align="center" style="display: none">
											<img src="${path}/FusionCharts/styles/images/loading.gif"
												border=0>
										</div>
									</td>
								</tr>
							</table>
							<!-- 图形属性配置Table End -->
						</td>
					</tr>
				</table>



				<!-- 数据预览Table Begin -->
				<!-- <table width="95%" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#518ec8" style="margin-bottom:10px">
      <tr>
        <td width="181" height="24" align="center" class="White12px" nowrap="nowrap"><strong>数据选择预览</strong></td>
        <td width="100%" bgcolor="#f0f4f5" align="left">
        &nbsp;&nbsp;&nbsp;&nbsp;
		</td>
      </tr>
      <tr>
        <td colspan="2" align="center" valign="top" bgcolor="#FFFFFF" width="100%">
			<div id="showData" align="center" >
			<img src="${path}/FusionCharts/styles/images/loading.gif" border=0>
			</div>
		</td>
      </tr>
   </table>-->
				<!-- 数据预览Table Begin -->
				<table width="95%" border="0" align="center" cellpadding="0"
					cellspacing="1" bgcolor="#518ec8" style="margin-bottom: 10px">
					<tr>
						<td width="181" height="24" align="center" id="showDataTD"
							class="table_btn_on" nowrap="nowrap">
							<a href="javascript:changeTable('showData','showDrillDown')"
								id="showDataA" style="color: #FFFFFF"><strong>数据选择预览</strong>
							</a>
						</td>
						<td width="181" height="24" align="center" id="showDrillDownTD"
							class="table_btn_off" nowrap="nowrap">
							<a href="javascript:changeTable('showDrillDown','showData')"
								id="showDrillDownA" style="color: #000000"><strong>数据钻取配置</strong>
							</a>
						</td>
						<td width="100%" bgcolor="#f0f4f5" align="right">
						</td>
					</tr>
					<tr>
						<td height="121" colspan="3" align="center" valign="top"
							bgcolor="#FFFFFF">
							<div id="showData" align="center">
								<img src="${path}/FusionCharts/styles/images/loading.gif"
									border=0>
							</div>
							<div id="showDrillDown" align="center" style="display: none"></div>
						</td>
					</tr>
				</table>
				<!-- 数据预览Table End -->



				<table width="95%" border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td>

							<!-- 图形预览Table Begin -->
							<table width="100%" border="0" align="center" cellpadding="0"
								cellspacing="1" bgcolor="#518ec8" style="margin-bottom: 10px">
								<tr>
									<td width="188" nowrap="nowrap" height="24" align="center"
										class="White12px">
										<strong>图形预览</strong>
									</td>
									<td width="100%" bgcolor="#f0f4f5" align="right">
										图形宽度：
										<input id="chart_width" type="text" name="chart_width"
											size="10" style="height: 18" value="${f_w}" />
										&nbsp;&nbsp; 图形高度：
										<input id="chart_height" type="text" name="chart_height"
											size="10" style="height: 18" value="${f_h}" />
										&nbsp;&nbsp;
										<input type="submit" value="数据刷新" id="refrashData" />
										&nbsp;&nbsp;
									</td>
								</tr>
								<tr>
									<td height="221" colspan="2" align="center" valign="top"
										bgcolor="#FFFFFF">
										<div id="chartView"></div>
									</td>
								</tr>
							</table>
							<!-- 图形预览Table End -->
						</td>
					</tr>
					<tr>
						<td>
							<table width="100%" border="0" align="center" cellpadding="0"
								cellspacing="0">
								<tr>
									<td align=center>
										<input type="submit" name="Submit2" value="保存" class="btn_s1"
											border="0" id="saveData" />
										&nbsp;
										<input type="button" name="Submit22" value="取消" class="btn_s1"
											onclick="cancelStep();" />
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
				<input type="hidden" name="old_modecode" value="${modelcode}">
			</form>
		</center>
	</body>
</html>

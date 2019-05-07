
/**
 *author 朱文
 *报表相关js
 *modify 20100115
 */
var havaData;
var multiplier;
var width;
var dividend;
var widthScale=0.03;//每根柱宽的比例
var chartAttribute;
var alreadyChangedXml;
var appId = "app_" + creator_getSession("subsystem_id");//oracle用户
var exportDataFlag=0;
var tempIndex=0;

/*funsioncharts加载后错误提示信息
PBarLoadingText --Loading Chart. Please Wait
XMLLoadingText-- Retrieving Data. Please Wait
ParsingDataText --Reading Data. Please Wait
ChartNoDataText --No data to display.
RenderingChartText --Rendering Chart. Please Wait
LoadDataErrorText --Error in loading data.
InvalidXMLText --Invalid XML data.
*/

           

/**
*加载xml,
*由计算得出
*1.柱图的组数 multiplier
*2.得到产生x轴名称之间间隔的百分比dividend
*/
function getWidth(xmlDoc) {
    if(xmlDoc=="nodata") return;
	var dom = new ActiveXObject("Microsoft.XMLDOM");//产生dom对象
	dom.loadXML(xmlDoc);
	var node = dom.getElementsByTagName("dataset");
	var node2 = dom.getElementsByTagName("category");
	multiplier = node.length * node2.length; //组数的数量
	var len = node2.length;
	dividend = (1 / parseInt(len) * 100) + "%"; //width的百分比
}
/**
*滚动报表
*/
function startMove(sp) {
	var dom = new ActiveXObject("Microsoft.XMLDOM");//产生dom对象
	var speed = sp;
	function Marquee() {
		chart.scrollLeft++;
	}
	var MyMar = setInterval(Marquee, speed);
	chart.onmouseover = function () {
		clearInterval(MyMar);
	};
	chart.onmouseout = function () {
		clearInterval(MyMar); //20101021 ly修改。解决初始化时鼠标放在图形区域继续滚动问题
		MyMar = setInterval(Marquee, speed);
	};
}
/**
*产生单柱图宽度
*/
function getChieftainWidth(xmlDoc, cWidth) {
	var dom = new ActiveXObject("Microsoft.XMLDOM");//产生dom对象
	width = document.body.clientWidth*0.8;
	dom.loadXML(xmlDoc);
	var node = dom.getElementsByTagName("set");
	multiplier = node.length;//组数的数量
	var tempwidth = width * cWidth * multiplier;
	width = width > tempwidth ? width : tempwidth;
}
/**
*产生单柱图
*/
function renderChartForSingle(xmlData){

    if(xmlData=='noData'){
    // alert("暂无数据");
     $("3DChartdiv").innerHTML="暂无数据";
     return;
   }



   var reg = new RegExp("\"", "g");
		  xmlData = xmlData.replace(reg, "'");
    if(typeof (chartAttribute)=="undefined"){
		   chartAttribute= getChartAttribute('0.03','0.5')
		  }
  var height = chartAttribute.height;
   getChieftainWidth(xmlData,'0.08');
   width = width > "7000" ? "7000" : width;  //为了解决背景黑色问题20110809 add by yin.liu
   var areaChart = new FusionCharts("../../../ccapp/app_1/report/fusioncharts/charts/"+chartSWF+"?PBarLoadingText=加载中.&LoadDataErrorText=加载出错.&XMLLoadingText=打开中请等待.&ParsingDataText=读取中,请等待.&ChartNoDataText=暂无数据.&RenderingChartText=生成图形中请稍候.&InvalidXMLText=数据类型不匹配.", "myChartId",width,height,"0", "1");
    var fileTitle = document.getElementById('title').innerText;
	document.getElementById('sortdiv').innerHTML='&nbsp;';
    xmlData=xmlData.replace("<graph","<graph caption='"+fileTitle+"'  exportEnabled='1' exportFileName='"+fileTitle+"' exportHandler='fcExporter1' exportAtClient='1' exportAction='download' exportDialogMessage='正在导出,请稍候...' ");//0826ly...update...
   areaChart.setDataXML(xmlData);
   areaChart.addParam("wmode","Opaque");
   areaChart.render("3DChartdiv");
   document.getElementById("spaceline").style.width=width;  //空白行spaceline的宽度
   document.getElementById("spaceline").style.height="0";  //空白行spaceline的宽度
chart.scrollLeft = 0;
		havaData = "1";//生成图形后 标志为 1 有数据
		//产生导出按钮功能
	var tbHead1 = "<table  vertical-align:left cellpadding='0' cellspacing='0'><tr>";
	    tbHead1+="<td vAlign=top ><INPUT class=button onclick=exportHandler(); type=button value='导出图形'></td>";
		tbHead1+="<td vAlign=top><DIV style='margin-top:-10px' id=fcExportDiv align=center>&nbsp;</DIV><div align=right id=closeExportDiv style='background:#999999;display:none;font-size:11;cursor:hand;' onclick=closeExportDivFun(); >[关闭]</div></td>";
		// tbHead1+="<td vAlign=left ><DIV align=left id=closeExportDiv style='display:none;' ><INPUT class=button onclick=closeExportDivFun(); type=button value='关闭'></DIV></td>";
	tbHead1 += "</tr></table>"; 
	  	if(typeof (exportDiv)=="undefined"){return;}
	var mTop = document.getElementById("exportDiv").style.marginTop;
	   var mLeft = document.getElementById("exportDiv").style.marginLeft;
	   var mLeftFlag = (mLeft.substr(0,mLeft.length-2))*1;
	   var mTopFlag = (mTop.substr(0,mTop.length-2))*1;
	  // alert(exportDataFlag);
	     if(exportDataFlag==1){
			mLeft=(mLeftFlag-40)+'px';
            mTop=(mTopFlag+435)+'px';
		 }
	      
		  mTop = Number(mTop.substr(0,mTop.length-2))-435;	  
		  mLeft = Number(mLeft.substr(0,mLeft.length-2))+40;
		  //alert(mTop+','+mLeft);
	     document.getElementById("exportDiv").style.marginTop=mTop+'px';
		 document.getElementById("exportDiv").style.marginLeft=mLeft+'px';
		// document.getElementById("exportDiv").style.marginTop='-42%';
		 //document.getElementById("exportDiv").style.marginLeft='5%';
		 document.getElementById("exportDiv").align='left';
		 document.getElementById("exportDiv").innerHTML = "";// tbHead1; //隐藏图新导出按钮
		 exportDataFlag=1;
		 if(tempIndex==1){
	  if(typeof (exportDiv)=="undefined"){return;}	
	  document.getElementById("exportDiv").innerHTML = "";
	 }
   }


/**
*显示:隐藏 报表上部
*/
function ctrlShow() {
	var st = $("tbody").style.display;
	if (st == "none") {
		$("up").style.display = "block";
		$("down").style.display = "none";
		$("tbody").style.display = "block";
		$("butcol").style.display = "block";
		$("caption").style.display = "block";
	} else {
		$("up").style.display = "none";
		$("down").style.display = "block";
		$("tbody").style.display = "none";
		$("butcol").style.display = "none";
		$("caption").style.display = "none";
	}
}
/**
*返回按钮事件
*/
function goBack() {
	//window.history.go(-1);
	window.history.back();
}
/**
*点击查询后 ,更改标题
*/
function Title(startTime, endTime, area, title) {
	$("title").innerHTML = startTime + "\u81f3" + endTime + area + title;
}
/**
*通过下拉框,修改柱图的宽度比例
*
*/
function changeScale() {
	var selectScales = document.getElementById("selectScale");
	for (i = 0; i < selectScales.length; i++) {
		if (selectScales[i].selected) {
			widthScale = selectScales[i].value;
		}
	}
	onClickAction();
}
/**
*点击查询后,通过dwr返回值 验证是否有数据
*/
function validXmlData(xmlData) {
	var dom = new ActiveXObject("Microsoft.XMLDOM");//产生dom对象
	dom.loadXML(xmlData);
	var node = dom.getElementsByTagName("set");
	if (node.length == 0) {
		document.getElementById("3DChartdiv").innerHTML = "\u6682\u65e0\u6570\u636e";
		return false;
	}
	return true;
}

/**
*产生排序下拉框
*
*/
function createSortOption(xmlData) {
    if(xmlData=="nodata") return;//无数据时终止
	var dom = new ActiveXObject("Microsoft.XMLDOM");//产生dom对象
		dom.loadXML(xmlData);
	var node = dom.getElementsByTagName("dataset"); //得到属性名为"dataset"的所有子节点
	var select = "<select id='selectSort' onchange='changeSort()' style='width: 70;'>";
		select += "<option value=''>默认</option>";
		for (var j = 0; j < node.length; j++) {
			seriesname = node[j].getAttribute("seriesname");
			select += "<option value='" + seriesname + "'>" + seriesname + "</option>";
		}
	select += "</select>";
	var tabHtml="<table style='width:100%'><tr>";
//tabHtml+="<td><INPUT class=button onclick=exportHandler(); type=button value='导出图形'><td/><td><DIV id=fcExportDiv align=center>&nbsp;</DIV></td>";
		tabHtml+="<td style='font-family: 宋体;font-size:12pt' align=right>排　序 &nbsp;";
		tabHtml+=""+select+"</td>";
		tabHtml+="</tr></table>";
 
	 	document.getElementById("sortdiv").innerHTML = tabHtml;
}
/**
*通过下拉框,选择排序字段
*
*/
function changeSort() {
	var selectedVal;
	var selectSorts = document.getElementById("selectSort");
	for (i = 0; i < selectSorts.length; i++) {
		if (selectSorts[i].selected) {
			sortCondition = selectSorts[i].value;
		}
	}
	renderChart(sort(ClickAction()));
}
/**
*排序函数
*通过changeSort() 得到排序的条件,进行排序
*返回排序好的xml
*/
function sort(XML) {
	var dom = new ActiveXObject("Microsoft.XMLDOM");//产生dom对象
	var tempNode;
			//dom.loadXML(tempXml);
	dom.loadXML(XML);
	var node = dom.getElementsByTagName("dataset"); //得到属性名为"dataset"的所有子节点
	var categories = dom.getElementsByTagName("categories");//得到属性名为"categories"的子节点
	var categoriesNode = categories[0].getElementsByTagName("category");
	var tempValueA;
	var tempValueB;
	var tempNameA;
	var tempNameB;
	for (var k = 0; k < node.length; k++) {
		var setNode = node[k].getElementsByTagName("set");
		if (sortCondition == node[k].getAttribute("seriesname")) {//找到需要排序的节点
			for (var i = 0; i < setNode.length; i++) {//冒泡排序,重新排序子节点
				for (var j = i + 1; j < setNode.length; j++) {
					tempValueA = parseFloat(setNode[i].getAttribute("value"));
					tempValueB = parseFloat(setNode[j].getAttribute("value"));
					if (tempValueA < tempValueB) {
						dom.documentElement.getElementsByTagName("dataset")[k].getElementsByTagName("set")[i].setAttribute("value", tempValueB);
						dom.documentElement.getElementsByTagName("dataset")[k].getElementsByTagName("set")[j].setAttribute("value", tempValueA);
						/*其它元素按此排序*/
						for (var z = 0; z < node.length; z++) {
							if (z != k) {
								var setNodeOth = node[z].getElementsByTagName("set");
								tempValueA = parseFloat(setNodeOth[i].getAttribute("value"));
								tempValueB = parseFloat(setNodeOth[j].getAttribute("value"));
								dom.documentElement.getElementsByTagName("dataset")[z].getElementsByTagName("set")[i].setAttribute("value", tempValueB);
								dom.documentElement.getElementsByTagName("dataset")[z].getElementsByTagName("set")[j].setAttribute("value", tempValueA);
							}
						}
						/*categories按此排序*/
						tempNameA = categoriesNode[i].getAttribute("name");
						tempNameB = categoriesNode[j].getAttribute("name");
						dom.documentElement.getElementsByTagName("categories")[0].getElementsByTagName("category")[i].setAttribute("name", tempNameB);
						dom.documentElement.getElementsByTagName("categories")[0].getElementsByTagName("category")[j].setAttribute("name", tempNameA);
					}
				}
			}
		}
	}
	return dom.xml;
}
/**
*onchange事件,单选条 至少有一个已选择
*否则 弹出提示,且选择无效
*/
function change(obj) {
	var checks = document.getElementById("anodiv");
	var checkeds = checks.getElementsByTagName("input");
	var flag = 0;
	for (var i = 0; i < checkeds.length; i++) {
		if (checkeds[i].checked) {
			flag++;
		}
	}
	if (flag == 0) {
		obj.checked = true;
		alert("请至少选择一项");
		return false;
	} else {
		onClickAction();
	}
}
/**
*加载xml,
*解析xml,
*生成图例复选框组合
*/
function crateCheckBtn(xmlDoc) {
    if(xmlDoc=="nodata") return;
	var dom = new ActiveXObject("Microsoft.XMLDOM");//产生dom对象
	if (xmlDoc == "noData") {
		return;
	}
	var finalWidth = document.body.clientWidth * 0.8;
	dom.loadXML(xmlDoc);
	var node = dom.getElementsByTagName("dataset");
	var len = node.length;
	var baseWidth = 10;//每个字的基础宽度
	var tempWidth = parseInt(len) * baseWidth;
	var tb = "";
	tb += "<td style='width:8px;height:27px;background-image:url(../../../ccapp/app_1/report/fusioncharts/js/left.jpg);background-repeat:repeat-x;background-position: right bottom;'></td>";
	for (var i = 0; i < len; i++) {
		var name = node[i].getAttribute("seriesname");
		var color = node[i].getAttribute("color");
		var tdwidth;//td宽度
		tdwidth = parseInt(name.length) * baseWidth + 30;
		tempWidth += tdwidth;
		if (name == "") {
			name = "&nbsp";
		}
		tb += "<td align='right'style='width:10px;height:27px;background-image:url(../../../ccapp/app_1/report/fusioncharts/js/middle.jpg);background-repeat:repeat-x;background-position: right bottom;' ><div style='background-color:#" + color + ";width:10px;height:10px;overflow-y:hidden'></div></td>";
		tb += "<td style='width:" + tdwidth + "px;FONT-SIZE:10pt;FONT-FAMILY:\u5b8b\u4f53;background-image:url(../../../ccapp/app_1/report/fusioncharts/js/middle.jpg);background-repeat:repeat-x;background-position: right bottom;' align='left'>&nbsp;" + name + "</td>";
		tb += "<td align='left'style='width:40px;height:27px;background-image:url(../../../ccapp/app_1/report/fusioncharts/js/middle.jpg);background-repeat:repeat-x;background-position: right bottom;' ><input type='checkbox' value=" + name + " checked onclick='change(this)'></td>";
	}
	tb += "<td style='width:8px;height:27px;background-image:url(../../../ccapp/app_1/report/fusioncharts/js/right.jpg);background-repeat:repeat-x;background-position: right bottom;'></td>";
	finalWidth = tempWidth > finalWidth ?  finalWidth:tempWidth ;
    var twidth=parseInt(len)*(tdwidth+58); //复选框整个宽度计算110303
	var tbHead = "<table style='width:" + twidth + "px' vertical-align:center cellpadding='0' cellspacing='0'><tr>";	
    
	tb += "</tr></table>";
   	if(len==0) {document.getElementById("anodiv").innerHTML = tbHead ;}
	else{
		document.getElementById("anodiv").innerHTML = tbHead + tb;
	}

}

//显示图形分页控件
function showDhDiv(){
	var tbspit = "<table  vertical-align:center cellpadding='0' cellspacing='0' style='font-size:12'><tr>";	
    tbspit += "<td align=right style='display:none'>每页<input type='text' readonly name='chartPageCount' id='chartPageCount' style='width:20px;height:15px '>条</td>";
	tbspit += "<td>&nbsp;&nbsp;第<span id='currentPage'>0</span>/<span id='totalPage'>0</span>页</td>";
	tbspit += "<td>&nbsp;&nbsp;转到第<input type='text' name='goPage' id='goPage' style='width:20px;height:15px '>页</td>";
	tbspit += "<td>&nbsp;<a style='cursor:hand' onclick=gochart('go');>GO</a>&nbsp;<a style='cursor:hand' onclick=gochart('head');>首页</a>&nbsp;<a style='cursor:hand' onclick=gochart('up');>上一页</a>&nbsp;<a style='cursor:hand' onclick=gochart('down');>下一页</a>&nbsp;<a style='cursor:hand' onclick=gochart('last');>尾页</a></td>";
	tbspit += "</tr></table>";
    document.getElementById("dhDIV").innerHTML = tbspit ; 
    document.getElementById("dhDIV").style.display="none";
}

/**
*单选框点击后的动作
*生成图形
*/
function onClickAction(){
  var xml = ClickAction();
	createSortOption(xml);
  	renderChart(xml);
}

/**
*加载dwr返回的xml
*/
function ClickAction() {

	var dom = new ActiveXObject("Microsoft.XMLDOM");//产生dom对象
	var attribute = "";
		if (tempXml == "noData") {
			havaData = "0";//无数据时置为 0
			//document.getElementById("3DChartdiv").innerHTML = $("area_name").value + "\u6682\u65e0\u6570\u636e";
			document.getElementById("anodiv").innerHTML = "";
		//	alert($("area_name").value + "\u6682\u65e0\u6570\u636e");
			return tempXml;
		}
		if (havaData == "0") {
			document.getElementById("sortdiv").style.display = "block";
			crateCheckBtn(tempXml);
		}
		dom.loadXML(tempXml);
	var node = dom.getElementsByTagName("dataset");
	var checks = document.getElementById("anodiv");
	var checkeds = checks.getElementsByTagName("input");
		for (var i = 0; i < checkeds.length; i++) {
			if (!checkeds[i].checked) {
				attribute = checkeds[i].value;
				for (var j = 0; j < node.length; j++) {
					var seriesname = node[j].getAttribute("seriesname");
					if (seriesname == attribute) {
						dom.documentElement.removeChild(node[j]);
					}
				}
			}
		}
		return dom.xml;
}
/**
 *最终接收xml,加载生成图形函数(组合图形)
 *
 */
function renderChart(domXml) {


	if(domXml=='noData'){
     return;
   }

	var xml = domXml;
	//报表不支持双引号,xml中的 " 需替换成 ';
	var reg = new RegExp("\"", "g");
		  xml = xml.replace(reg, "'");
		  alreadyChangedXml = xml;
		  getWidth(xml);
		
		 /* if(typeof (chartAttribute)=="undefined"){
		   chartAttribute= getChartAttribute('0.03','0.42')
		  }*/

		    if(typeof(qp)=="undefined"){
			chartAttribute= getChartAttribute('0.03','0.42');
		 }
		  width= chartAttribute.width;
		  
  var height = chartAttribute.height;

	var finalWidth = document.body.clientWidth * 0.9;
		  finalWidth = width > finalWidth ? width : finalWidth;
		  finalWidth = finalWidth > "7000" ? "7000" : finalWidth;  //为了解决背景黑色问题20110809 add by yin.liu
	var deptChart = new FusionCharts("../../../ccapp/app_1/report/fusioncharts/charts/" + chartSWF +"?PBarLoadingText=加载中.&LoadDataErrorText=加载出错.&XMLLoadingText=打开中请等待.&ParsingDataText=读取中,请等待.&ChartNoDataText=暂无数据.&RenderingChartText=生成图形中请稍候.&InvalidXMLText=数据类型不匹配.", "myChartId", finalWidth, height, "0", "1");
		deptChart.addParam("wmode", "Opaque");
	 var fileTitle = document.getElementById('title').innerText;
		 xml=xml.replace("<graph","<graph showLegend='0' caption='"+fileTitle+"'  exportEnabled='1' exportFileName='"+fileTitle+"' exportHandler='fcExporter1' exportAtClient='1' exportAction='download'  exportDialogMessage='正在导出,请稍候...' ");//0826ly...update...
		//alert(xml);
		deptChart.setDataXML(xml);
		deptChart.render("3DChartdiv");
		document.getElementById("spaceline").style.width=finalWidth;  //空白行spaceline的宽度
		chart.scrollLeft = 0;
		havaData = "1";//生成图形后 标志为 1 有数据
			//产生导出按钮功能
   
  
	var tbHead1 = "<table  vertical-align:left cellpadding='0' cellspacing='0'><tr>";
	    tbHead1+="<td vAlign=top><INPUT class=button onclick=exportHandler(); type=button value='导出图形'></td>";
		tbHead1+="<td vAlign=top><DIV style='margin-top:-10px' id=fcExportDiv align=center>&nbsp;</DIV><div align=right id=closeExportDiv style='background:#999999;display:none;font-size:11;cursor:hand;' onclick=closeExportDivFun(); >[关闭]</div></td>";
       // tbHead1+="<td vAlign=left ><DIV align=left id=closeExportDiv style='display:none;' ><INPUT class=button onclick=closeExportDivFun(); type=button value='关闭'></DIV></td>";
	tbHead1 += "</tr></table>"; 
	if(typeof (exportDiv)=="undefined"){return;}
	   var mTop = document.getElementById("exportDiv").style.marginTop;
	   var mLeft = document.getElementById("exportDiv").style.marginLeft;
	   var mLeftFlag = (mLeft.substr(0,mLeft.length-2))*1;
	   var mTopFlag = (mTop.substr(0,mTop.length-2))*1;
	   //alert(exportDataFlag);
	     if(exportDataFlag==1){
			mLeft=(mLeftFlag-50)+'px';
            mTop=(mTopFlag+425)+'px';
		 }
	      
		  mTop = Number(mTop.substr(0,mTop.length-2))-425;	  
		  mLeft = Number(mLeft.substr(0,mLeft.length-2))+50;
		  //alert(mTop+','+mLeft);
	     document.getElementById("exportDiv").style.marginTop=mTop+'px';
		 document.getElementById("exportDiv").style.marginLeft=mLeft+'px';
		// document.getElementById("exportDiv").style.marginTop='-42%';
		 //document.getElementById("exportDiv").style.marginLeft='5%';
		 document.getElementById("exportDiv").align='left';
		 document.getElementById("exportDiv").innerHTML =""; // tbHead1; //隐藏图形导出按钮
		 exportDataFlag=1;
	if(tempIndex==1){
	  if(typeof (exportDiv)=="undefined"){return;}	
	  document.getElementById("exportDiv").innerHTML = "";
	}
	
}

function getChartAttribute(whidtScale,heigthScale){
 var chartAttribute={
		"height":screen.height*parseFloat(heigthScale),
		"width":document.body.clientWidth * multiplier * parseFloat(whidtScale)
	}
	return chartAttribute;
}

/**
 *点击图形页面后重新加载一次,解决鼠标进入图形后柱图提示框无法显示
 */
function PubClickPageControl(index){

	tempIndex=index;

   if(typeof (refReportbtn)!="undefined"){var refReportbtn = document.getElementById("refReportbtn");}

   if(index==0){

   	if(typeof (refReportbtn)!="undefined"){refReportbtn.style.display="none";}
	if(typeof (windowView)!="undefined"){document.getElementById("windowView").style.display="block";}
	   if(type==1){
	    renderChartForSingle(tempXml);
	   }else{ 
	    renderChart(alreadyChangedXml);
	   }
    }else{

     if(typeof (refReportbtn)!="undefined"){refReportbtn.style.display="none";}

	 	if(typeof (windowView)!="undefined"){document.getElementById("windowView").style.display="none";}
	 if(typeof (exportDiv)=="undefined"){return;}

	 document.getElementById("exportDiv").innerHTML = "";
    }
}	


//图片导出。。。。。。。。。。。。。。。start.....................

function FC_ExportReady(DOMId)
   {  
	   		
        var myExportComponent = new FusionChartsExportObject("fcExporter1", "../../../ccapp/app_1/report/fusioncharts/charts/FCExporter.swf");
		myExportComponent.componentAttributes.saveMode='both';
		myExportComponent.componentAttributes.showAllowedTypes = '1';
		myExportComponent.componentAttributes.width = '200';
		myExportComponent.componentAttributes.height = '66';
		myExportComponent.componentAttributes.btnsavetitle = '保存'
		myExportComponent.componentAttributes.btnFontFace = 'Verdana';
		myExportComponent.componentAttributes.btnFontSize = '12';
		myExportComponent.componentAttributes.btndisabledtitle = '点导出图形或关闭';
	
      /*
        myExportComponent.componentAttributes.width = '400';
		myExportComponent.componentAttributes.height = '60';
		myExportComponent.componentAttributes.bgColor = 'ffffdd';
		myExportComponent.componentAttributes.borderThickness = '2';
		myExportComponent.componentAttributes.borderColor = '0372AB';
		myExportComponent.componentAttributes.fontFace = 'Arial';
		myExportComponent.componentAttributes.fontColor = '0372AB';
		myExportComponent.componentAttributes.fontSize = '8';
		myExportComponent.componentAttributes.showMessage = '0';
		myExportComponent.componentAttributes.message = '在报表上右键导出,然后点此按钮保存图片';
		myExportComponent.componentAttributes.btnWidth = '200';
		myExportComponent.componentAttributes.btnHeight= '25';
		myExportComponent.componentAttributes.btnColor = 'E1f5ff';
		myExportComponent.componentAttributes.btnBorderColor = '0372AB';
		myExportComponent.componentAttributes.btnFontFace = 'Verdana';
		myExportComponent.componentAttributes.btnFontColor = '0372AB';
		myExportComponent.componentAttributes.btnFontSize = '15';
		myExportComponent.componentAttributes.btnsavetitle = '图片已生成,点击保存'
		myExportComponent.componentAttributes.btndisabledtitle = '报表上右键可以导出图片';
     */
		myExportComponent.Render("fcExportDiv");
        document.getElementById('closeExportDiv').style.display="";
		
   }


function exportHandler()
	{
		
        
		var n = document.getElementById('fcExportDiv');
		n.innerHTML = "&nbsp;"; 
	
		 if(typeof (havaData)=="undefined"){alert("暂无数据导出！");return;}

		var chartE = getChartFromId("myChartId");
		if (chartE.hasRendered()==true){
		     // alert('exportChart...');
			chartE.exportChart();
			//fcExportDiv
		}else{
			
			alert("请您等待图形加载完毕后再执行导出图形操作！");
		}
	}


function closeExportDivFun(){
	
	var n = document.getElementById('fcExportDiv');
	n.innerHTML = "&nbsp;";
	document.getElementById('closeExportDiv').style.display="none";
}
//导出。。。。。。。。。。。。。。。。。。。。end................

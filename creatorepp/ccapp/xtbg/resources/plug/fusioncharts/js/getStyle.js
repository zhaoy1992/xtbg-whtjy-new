
/**
 *author ����
 *�������js
 */
var havaData;
var multiplier;
var width;
var dividend;
var appId = "app_" + creator_getSession("subsystem_id");//oracle�û�
/**
*����xml,
*�ɼ���ó�
*1.��ͼ������ multiplier
*2.�õ�����x������֮�����İٷֱ�dividend
*/
function getWidth(xmlDoc) {
var dom=new ActiveXObject("Microsoft.XMLDOM");//����dom����
	dom.loadXML(xmlDoc);
	var node = dom.getElementsByTagName("dataset");
	var node2 = dom.getElementsByTagName("category");
	multiplier = node.length * node2.length; //����������
	var len = node2.length;
	dividend = (1 / parseInt(len) * 100) + "%"; //width�İٷֱ�
}
/**
*����xml,
*����xml,
*��������ͼX������
*/
function crateAnoForMulti(xmlDoc) {
var dom=new ActiveXObject("Microsoft.XMLDOM");//����dom����
	var finalWidth = document.body.clientWidth * 0.8;
	finalWidth = (width * 0.996) > finalWidth ? width * 0.996 : finalWidth;
	dom.loadXML(xmlDoc);
	var node = dom.getElementsByTagName("category");
	var tb = "<table style='width:" + finalWidth + "' cellpadding='0' cellspacing='18px' ><tr>";
	for (var i = 0; i < node.length; i++) {
		var name = node[i].getAttribute("name");
		if (name == "") {
			name = "&nbsp";
		}
		tb += "<td style='vertical-align:top;width:" + dividend + ";FONT-SIZE:9pt;FONT-FAMILY:����'>" + name + "</td>";
	}
	tb += "</tr></table>";
	document.getElementById("anodiv").innerHTML = tb;
}
/**
*����xml,
*����xml,
*��������ͼX������
*/
function crateAnoForChieftain(xmlDoc) {
var dom=new ActiveXObject("Microsoft.XMLDOM");//����dom����
	dom.loadXML(xmlDoc);
	var node = dom.getElementsByTagName("set");
	var tb = "<table style='width:" + width * 0.99 + "' cellpadding='0' cellspacing='13px'><tr>";
	var len = node.length;
	dividend = (1 / parseInt(len) * 100) + "%"; //width�İٷֱ�
	for (var i = 0; i < node.length; i++) {
		var color = node[i].getAttribute("color");
		var name = node[i].getAttribute("name");
		tb += "<td style='vertical-align:top;width:" + dividend + ";FONT-SIZE:9pt;FONT-FAMILY:����'>" + name + "</td>";
	}
	tb += "<tr></table>";
	document.getElementById("anodiv").innerHTML = tb;
}
/**
*����xml,
*����xml,
*���ɶ���ͼ��
*/
function crateAnoCutline(xmlDoc) {
var dom=new ActiveXObject("Microsoft.XMLDOM");//����dom����
	if (xmlDoc == "noData") {
		return;
	}
	var finalWidth = document.body.clientWidth * 0.8;
	dom.loadXML(xmlDoc);
	var node = dom.getElementsByTagName("dataset");
	var len = node.length;
	if (len == 0) {//���û��dataset 
		document.getElementById("anodiv").innerHTML = " ";
		return;
	}
	var baseWidth = 10;//ÿ���ֵĻ������
	var tempWidth = parseInt(len) * baseWidth;
	var tb = "";
	 	        	//tb+="<td style='width:8px;height:27px;background-image:url(../../../ccapp/app_1/report/fusioncharts/js/left.jpg);background-repeat:repeat-x;background-position: right bottom;'></td>";
	tb += "<td style='width:8px;height:27px;background-image:url(../../../ccapp/app_1/report/fusioncharts/js/left.jpg);background-repeat:repeat-x;background-position: right bottom;'></td>";
	for (var i = 0; i < len; i++) {
		var name = node[i].getAttribute("seriesname");
		var color = node[i].getAttribute("color");
		var tdwidth;//td���
		tdwidth = parseInt(name.length) * baseWidth + 60;
		if (i == len - 1) {
			tdwidth = (parseInt(name.length) + 3) * baseWidth;
		}
		tempWidth += tdwidth;
		if (name == "") {
			name = "&nbsp";
		}
				      	//tb+="<td align='right'style='width:10px;height:27px;background-image:url(../fusioncharts/middle.jpg);background-repeat:repeat-x;background-position: right bottom;' ><div style='background-color:#"+color+";width:10px;height:10px;overflow-y:hidden' ></div></td>"
				     	//tb+="<td style='width:"+tdwidth+"px;FONT-SIZE:10pt;FONT-FAMILY:����;color:#909976;background-image:url(../../../ccapp/app_1/report/fusioncharts/js/middle.jpg);background-repeat:repeat-x;background-position: right bottom;' align='left'>&nbsp;"+name+"</td>"
		tb += "<td align='right'style='width:10px;height:27px;background-image:url(../../../ccapp/app_1/report/fusioncharts/js/middle.jpg);background-repeat:repeat-x;background-position: right bottom;' ><div style='background-color:#" + color + ";width:10px;height:10px;overflow-y:hidden'></div></td>";
		tb += "<td style='width:" + tdwidth + "px;FONT-SIZE:10pt;FONT-FAMILY:����;color:#909976;background-image:url(../../../ccapp/app_1/report/fusioncharts/js/middle.jpg);background-repeat:repeat-x;background-position: right bottom;' align='left'>&nbsp;" + name + "</td>";
	}
			     	//tb+="<td style='width:8px;height:27px;background-image:url(.../../../ccapp/app_1/report/fusioncharts/js/right.jpg);background-repeat:repeat-x;background-position: right bottom;'></td>";
	tb += "<td style='width:8px;height:27px;background-image:url(../../../ccapp/app_1/report/fusioncharts/js/right.jpg);background-repeat:repeat-x;background-position: right bottom;'></td>";
	finalWidth = tempWidth > finalWidth ? finalWidth : tempWidth;
	var tbHead = "<table  vertical-align:center cellpadding='0' cellspacing='0'><tr>";
	tb += "</tr></table>";
	document.getElementById("anodiv").innerHTML = tbHead + tb;
}
/**
*��������
*/
function startMove(sp) {
var dom=new ActiveXObject("Microsoft.XMLDOM");//����dom����
	var speed = sp;
	function Marquee() {
		chart.scrollLeft++
	}
	var MyMar = setInterval(Marquee, speed);
	chart.onmouseover = function () {
		clearInterval(MyMar);
	};
	chart.onmouseout = function () {
		MyMar = setInterval(Marquee, speed);
	};
}
/**
*��������ͼ���
*/
function getChieftainWidth(xmlDoc, cWidth) {
var dom=new ActiveXObject("Microsoft.XMLDOM");//����dom����
	width = document.body.clientWidth;
	dom.loadXML(xmlDoc);
	var node = dom.getElementsByTagName("set");
	multiplier = node.length;//����������
	var tempwidth = width * cWidth * multiplier;
	width = width > tempwidth ? width : tempwidth;
}
/**
*��ʾ:���� �����ϲ�
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
*����
*/
function goBack() {
	window.history.go(-1);
}
/**
*�����ѯ�� ,���ı���
*/
function Title(startTime, endTime, area, title) {
	$("title").innerHTML = startTime + "\u81f3" + endTime + area + title;
}
/**
*�����ѯ��,ͨ��dwr����ֵ ��֤�Ƿ�������(����ͼ)
*/
function validXmlData(xmlData) {
	var dom=new ActiveXObject("Microsoft.XMLDOM");//����dom����
	dom.loadXML(xmlData);
	var node = dom.getElementsByTagName("set");
	if(node.length==0){
	   alert($("area_name").value+"��������");
	   document.getElementById("3DChartdiv").innerHTML =$("area_name").value+ "��������";
	   return false;
	}
    return true;
}
/**
*onchange�¼�,��ѡ�� ������һ����ѡ��
*���� ������ʾ,��ѡ����Ч
*/
function change(obj){
	var checks = document.getElementById("chartdiv");
	var checkeds = checks.getElementsByTagName("input");
	var flag=0;
for (var i = 0; i < checkeds.length; i++) {
		if (checkeds[i].checked) {
			flag++;
		}
	}
	if(flag==0){
		obj.checked=true;
	   alert("������ѡ��һ��");
	   return false;
	}else{
		onClickAction();
	}
}
/**
*��ѡ������Ķ���
*����dwr���ص�xml
*/
function onClickAction() {
	var dom=new ActiveXObject("Microsoft.XMLDOM");//����dom����
	var attribute = "";
	var areaName="";
	
	if(typeof($("area_name")) == "undefined"){
	    areaName=" ";
	}
	if(tempXml=="noData"){
		havaData="0";//������
		document.getElementById("chartdiv").style.display="none";
		document.getElementById("3DChartdiv").innerHTML=areaName+"��������";
		document.getElementById("anodiv").innerHTML = "";
		alert(areaName+"��������");
		return;
	}
	if(havaData=="0"){
		document.getElementById("chartdiv").style.display="block";
		crateCheckBtn(tempXml);
	}
	dom.loadXML(tempXml);
	var node = dom.getElementsByTagName("dataset");
	var checks = document.getElementById("chartdiv");
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
	xml = dom.xml;
	//����֧��˫����,xml�е� " ���滻�� ';
	var reg = new RegExp("\"", "g");
	var xml = xml.replace(reg, "'");
	getWidth(xml);
	width = document.body.clientWidth * multiplier * 0.03;
	var finalWidth = document.body.clientWidth * 0.9;
	finalWidth = width > finalWidth ? width : finalWidth;
	var height = screen.height * 0.5;
	var deptChart = new FusionCharts("../../../ccapp/app_1/report/fusioncharts/charts/" + chartSWF, "myChartId", finalWidth, height);
	deptChart.addParam("wmode", "Opaque");
	deptChart.setDataXML(xml);
	deptChart.render("3DChartdiv");
	crateAnoCutline(xml);
	chart.scrollLeft = 0;
	havaData="1";//������
}
/**
*����xml,
*����xml,
*���ɸ�ѡ��
*/
function crateCheckBtn(xmlDoc) {
var dom=new ActiveXObject("Microsoft.XMLDOM");//����dom����
	if (xmlDoc == "noData") {
		return;
	}
	var finalWidth = document.body.clientWidth * 0.8;
	dom.loadXML(xmlDoc);
	var node = dom.getElementsByTagName("dataset");
	var len = node.length;
	var baseWidth = 10;//ÿ���ֵĻ������
	var tempWidth = parseInt(len) * baseWidth;
	var tb = "";
	tb += "<td style='width:8px;height:27px;background-image:url(../../../ccapp/app_1/report/fusioncharts/js/left.jpg);background-repeat:repeat-x;background-position: right bottom;'></td>";
	for (var i = 0; i < len; i++) {
		var name = node[i].getAttribute("seriesname");
		var color = node[i].getAttribute("color");
		var tdwidth;//td���
		tdwidth = parseInt(name.length) * baseWidth + 60;
		if (i == len - 1) {
			tdwidth = (parseInt(name.length) + 3) * baseWidth;
		}
		tempWidth += tdwidth;
		if (name == "") {
			name = "&nbsp";
		}
		tb += "<td align='right'style='width:10px;height:27px;background-image:url(../../../ccapp/app_1/report/fusioncharts/js/middle.jpg);background-repeat:repeat-x;background-position: right bottom;' ><input type='checkbox' value=" + name + " checked onclick='change(this)'></td>";
		tb += "<td style='width:" + tdwidth + "px;FONT-SIZE:10pt;FONT-FAMILY:����;color:#" + color + ";background-image:url(../../../ccapp/app_1/report/fusioncharts/js/middle.jpg);background-repeat:repeat-x;background-position: right bottom;' align='left'>&nbsp;" + name + "</td>";
	}
	tb += "<td style='width:8px;height:27px;background-image:url(../../../ccapp/app_1/report/fusioncharts/js/right.jpg);background-repeat:repeat-x;background-position: right bottom;'></td>";
	finalWidth = tempWidth > finalWidth ? finalWidth : tempWidth;
	var tbHead = "<table  vertical-align:center cellpadding='0' cellspacing='0'><tr>";
	tb += "</tr></table>";
	document.getElementById("chartdiv").innerHTML = tbHead + tb;
}
//**************************************************************************************************************************
//*************************************************** ȫ������**************************************************************
//**************************************************************************************************************************
/**
*ȫ�� ��ѡ������Ķ���
*����dwr���ص�xml
*/
function onClickActionFroWindow() {
var dom=new ActiveXObject("Microsoft.XMLDOM");//����dom����
	var attribute = "";
	dom.loadXML(tempXml);
	var node = dom.getElementsByTagName("dataset");
	var checks = document.getElementById("chartdiv");
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
	var xml = dom.xml;
	//����֧��˫����,xml�е� " ���滻�� ';
	var reg = new RegExp("\"", "g");
	xml = xml.replace(reg, "'");
	getWidth(xml);
	width = document.body.clientWidth * multiplier * 0.03;
	var finalWidth = document.body.clientWidth * 0.9;
	finalWidth = width > finalWidth ? width : finalWidth;
	var height = screen.height * 0.75;
	var deptChart = new FusionCharts("../../../ccapp/app_1/report/fusioncharts/charts/" + reportMap.cls, "myChartId", finalWidth, height);
	deptChart.addParam("wmode", "Opaque");
	deptChart.setDataXML(xml);
	deptChart.render("3DChartdiv"); 
	crateAnoCutline(xml);
}
/**
*ȫ�� ����xml,
*����xml,
*���ɸ�ѡ��
*/
function crateCheckBtnFroWindow(xmlDoc) {
var dom=new ActiveXObject("Microsoft.XMLDOM");//����dom����
	if (xmlDoc == "noData") {
		return;
	}
	var finalWidth = document.body.clientWidth * 0.8;
	dom.loadXML(xmlDoc);
	var node = dom.getElementsByTagName("dataset");
	var len = node.length;
	var baseWidth = 10;//ÿ���ֵĻ������
	var tempWidth = parseInt(len) * baseWidth;
	var tb = "";
	tb += "<td style='width:8px;height:27px;background-image:url(../../../ccapp/app_1/report/fusioncharts/js/left.jpg);background-repeat:repeat-x;background-position: right bottom;'></td>";
    //tb+="<td style='width:8px;height:27px;background-image:url(../../../ccapp/app_1/report/fusioncharts/js/left.jpg);background-repeat:repeat-x;background-position: right bottom;'></td>";
	for (var i = 0; i < len; i++) {
		var name = node[i].getAttribute("seriesname");
		var color = node[i].getAttribute("color");
		var tdwidth;//td���
		tdwidth = parseInt(name.length) * baseWidth + 60;
		if (i == len - 1) {
			tdwidth = (parseInt(name.length) + 3) * baseWidth;
		}
		tempWidth += tdwidth;
		if (name == "") {
			name = "&nbsp";
		}
		tb += "<td align='right'style='width:10px;height:27px;background-image:url(../../../ccapp/app_1/report/fusioncharts/js/middle.jpg);background-repeat:repeat-x;background-position: right bottom;' ><input type='checkbox' value=" + name + " checked onclick=changeForWindow(this)></td>";
		tb += "<td style='width:" + tdwidth + "px;FONT-SIZE:10pt;FONT-FAMILY:����;color:#" + color + ";background-image:url(../../../ccapp/app_1/report/fusioncharts/js/middle.jpg);background-repeat:repeat-x;background-position: right bottom;' align='left'>&nbsp;" + name + "</td>";
	}
	tb += "<td style='width:8px;height:27px;background-image:url(../../../ccapp/app_1/report/fusioncharts/js/right.jpg);background-repeat:repeat-x;background-position: right bottom;'></td>";
	finalWidth = tempWidth > finalWidth ? finalWidth : tempWidth;
	var tbHead = "<table  vertical-align:center cellpadding='0' cellspacing='0'><tr>";
	tb += "</tr></table>";
	document.getElementById("chartdiv").innerHTML = tbHead + tb;
}

function changeForWindow(obj){
	var checks = document.getElementById("chartdiv");
	var checkeds = checks.getElementsByTagName("input");
	var flag=0;
for (var i = 0; i < checkeds.length; i++) {
		if (checkeds[i].checked) {
			flag++;
		}
	}
	if(flag==0){
		obj.checked=true;
	   alert("������ѡ��һ��");
	   return false;
	}else{
		onClickActionFroWindow();
	}
}

<%@ page contentType="text/html; charset=GBK" %><%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.frameworkset.common.poolman.DBUtil"%>

<%AccessControl accesscontroler = AccessControl.getInstance();
  if(!accesscontroler.checkAccess(request, response)){
  		return;
  }
  String appPath = "app_"+accesscontroler.getCurrentSystemID();
  String appId = accesscontroler.getCurrentSystemID();
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html xmlns:fc xmlns:v="urn:schemas-microsoft-com:vml">
	<HEAD>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">		
		<STYLE> .userData{behavior:url(#default#userData);}
	</STYLE>
	<script type="text/javascript" src="../../../cachloader/pre_load.js"></script>	
	<script language="javascript">
		var __dj_win_flag__ = true;
		function load_over(){
			document.getElementById("preloadView").style.display="none";
			document.getElementById("SKbillsheet").style.visibility="visible";
		}
	
		function optmGetUsdatObj()
		{
			if((typeof(eppDataWrObj) != "undefined") && eppDataWrObj.isCanUse()) return eppDataWrObj;
			if((typeof(userDataWrObj) != "undefined") && userDataWrObj.isCanUse()) return userDataWrObj;
			return null;			
		}
		
		function optmGetFlashObj()
		{
			if((typeof(eppDataWrObj) != "undefined") && eppDataWrObj.isCanUse()) return eppDataWrObj;
			if((typeof(flashWrObj) != "undefined") && flashWrObj.isCanUse()) return flashWrObj;
			return null;
		}
		
		function ex_prePageInit()
		{	
			var bSucced = __pre_loadjsFrame();
			if(!bSucced) 
			{
				document.body.innerHTML = "<font color='#ff0000'>preload js frame failure!</font>";
				return;
			}
			
			mtJsFileArray("eformsys/fceform/js/fcpub.js", true, optmGetUsdatObj());
			mtJsFileArray("eformsys/fceform/js/fcvalid.js", true, optmGetUsdatObj());
			mtJsFileArray("eformsys/fceformext/js/usertb.js", true, optmGetUsdatObj());			
			mtJsFileArray("eformsys/fceform/js/ccpub.js", true, optmGetUsdatObj());
			mtJsFileArray("eformsys/fceform/js/fcrundj.js", true, optmGetUsdatObj());
			mtJsFileArray("eformsys/fceform/js/tabpane.js", true, optmGetFlashObj());
			mtJsFileArray("eformsys/fceform/js/fcsavedj.js", true, eppDataWrObj);
					
			s=0;
			s=1;
		
			bSucced = prePageInit(false, true);
			if(!bSucced) 
			{
				document.body.innerHTML = "<font color='#ff0000'>preload js file failure!</font>";
				return;
			}
			
			pub_djhtm();
			fcpubdata.creatorStyle='creatorBlue';
		}
		
		//根据应用确定样式的目录
		var stylePath = "../../../ccapp/<%=appPath%>/";			
	</script>
		
	</HEAD>
	<body  onload="load_over();pub_window_onload()"
		onkeydown="RunTabindex()" onbeforeunload="pub_window_onbeforeunload()" onkeypress="pub_window_onkeypress()"
		onresize="pub_window_onresize()">
		<DIV style="Z-INDEX: 1000; BACKGROUND: #e0e0e0; FILTER: alpha(opacity=80); LEFT: 0px; WIDTH: 100%; POSITION: absolute; TOP: 0px; HEIGHT: 100%" id="preloadView">
		   <TABLE style="VERTICAL-ALIGN: middle; WIDTH: 100%; HEIGHT: 100%; TEXT-ALIGN: center">
		      <TBODY>
		         <TR>
		            <TD><DIV style="BORDER-RIGHT: skyblue 2px solid; BORDER-TOP: skyblue 2px solid; FONT-SIZE: 15px; BACKGROUND: #ffffff; BORDER-LEFT: skyblue 2px solid; WIDTH: 150px; PADDING-TOP: 9px; BORDER-BOTTOM: skyblue 2px solid; HEIGHT: 40px; solid: #000000">正在加载……</DIV></TD>
		         </TR>
		      </TBODY>
		   </TABLE>
		</DIV>
		
		<iframe id="_newframe" name="_newframe" height="0" width="0"></iframe>
		<script>
			var pubdjbh=parent.sOpenDjNo;
			var pubEdit=false;
			var pubDataSet=null;
			var pubRequest=parent.oRequest;
			var pubEformEnterStatus="OK"; 
			ex_prePageInit();
		</script>

<!-- 提示：以下为页面的JS&CSS内容 -->
<%
 String iWebOfficeVersion  = com.chinacreator.config.ConfigManager.getInstance().getConfigValue("iWebOfficeVersion", "7,8,0,4");
String strDgMode = com.chinacreator.config.ConfigManager.getInstance().getConfigValue("file.upload.jsdgmode");
boolean bDgMode = !((strDgMode == null) || !strDgMode.equals("1"));
%><script language='javascript'>
<%if(bDgMode){%>  var myhead = document.getElementsByTagName('head')[0];
  var mylink = document.createElement("link");
  mylink.setAttribute("type","text/css");
  mylink.setAttribute("rel","stylesheet");
  mylink.setAttribute('href','../../../ccapp/<%=appPath%>/css//allStyle.css');
  myhead.appendChild(mylink);
<%}else{%>  adv_loadjsfile('ccapp/<%=appPath%>/css//allStyle.css');
<%}%>  fcpubdata.creatorStyle='';
</script>
<%
if(!bDgMode) out.println("<script language='javascript'>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/fcsavedj.js');");
if(bDgMode) out.println("<script defer src='../../fceform/js/fcsavedj.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/fcbasecont.js');");
if(bDgMode) out.println("<script src='../../fceform/js/fcbasecont.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/selectdate.js');");
if(bDgMode) out.println("<script defer src='../../fceform/js/selectdate.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/../fceformext/js/userfunc.js');");
if(bDgMode) out.println("<script src='../../fceform/../fceformext/js/userfunc.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/fcdate.js');");
if(bDgMode) out.println("<script src='../../fceform/js/fcdate.js'></script>");
if(!bDgMode) out.println("</script>");
%>

   <script >document.styleSheets[0].addRule("fc\\:dataset","behavior: url(../../fceform/htc/dataset.htc)",0);</script>
   <script language='javascript'>
adv_loadjsfile('/eformsys/fceform/css/tabstyle.css');
adv_loadjsfile('/eformsys/fceform/js/fcdataset.js');
adv_loadjsfile('/FusionCharts/Contents/Style.css');
adv_loadjsfile('/FusionCharts/JSClass/FusionCharts.js');
adv_loadjsfile('/FusionCharts/JSClass/FusionCharts_CN.js');
adv_loadjsfile('/FusionCharts/jquery-1.2.6.min.js');
adv_loadjsfile('/FusionCharts/s2u.js');
</script>


<!-- 提示：以下为页面自定义JS内容 -->
<script></script>

<!-- 提示：以下为页面DOM元素内容 -->
<DIV id=SKbillsheet style="visibility:hidden" toolbar="不带工具栏" BLONopen="setAuthority();" contxml="<root><dataset><id>dataset1</id></dataset><Fusionchar><id>Fusionchar2</id><id>Fusionchar1</id></Fusionchar></root>" billtaborder="<root></root>" dj_sn="20100507113204780340" caption="测试图形控件" mkbh codeheader="BBB" entertype="修改" poswidth posheight controlno="SKButton:0;SKDBedit:0;checkbox:0;label:0;radio:0;listbox:0;textarea:0;combobox:0;password:0;upload:0;SKDBtext:0;chart:1;dbimg:0;img:0;SKBILLgrid:0;shape:0;tab:0;div:0;DsMain_field:0;a:0;button:0;text:0;hr:0;checkboxlist:0;radiolist:0;dropdownlist:0;grid:0;dataset:1;spin:0;excel:0;tree:0;ebshow:0;creatorSubForm:0;creator_div:0;ExtGrid:0;ExtUpload:0;ExtTree:0;Fusionchar:2" window="当前窗口" posleft postop keyfield isfile="否" OtherSave="否" idtype="1" testDbName creatorStyle="creatorBlue" BLONclose="UnLoadWebOffice();" creator_remark hasWorkflowButton="否" creator_elementAuthoritySwitch="否" creator_showAlert="是" creator_office_isBindForm="否" islog="否" isprotect="是" creator_csslib version="1.0" creator_pagination type="ZW" creatorType="20100430111825238919" jslib="fcsavedj.js&#13;&#10;fcbasecont.js&#13;&#10;selectdate.js&#13;&#10;~userfunc.js&#13;&#10;fcdate.js">

<?xml:namespace prefix = fc />

<fc:dataset id=dataset1 format="<fields><field><fieldname>AA</fieldname><datatype>字符</datatype><displaylabel>AA</displaylabel><size>20</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>AGE</fieldname><datatype>字符</datatype><displaylabel>AGE</displaylabel><size>22</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>BB</fieldname><datatype>字符</datatype><displaylabel>BB</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>RIGHT</fieldname><datatype>字符</datatype><displaylabel>RIGHT</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field></fields>" sqltrans="%F4%D8%E6%D8%D4%F6XrnbXrn%DA%F2%EC%E8Xrn%B6%90%CC%B6%98%B4%B6r" onSetText='bill_ondatasetsettext("<dsid><AA></AA><AGE></AGE><BB></BB><RIGHT></RIGHT></dsid>")' onGetText='bill_ondatasetgettext("<dsid><AA></AA><AGE></AGE><BB></BB><RIGHT></RIGHT></dsid>")' onValid='bill_ondatasetvalid("<dsid><AA></AA><AGE></AGE><BB></BB><RIGHT></RIGHT></dsid>")' opensortno="1" temptable="TMP_DATASET1" multiResult="否"></fc:dataset>

<INPUT id=1273655204015azxshidinput type=hidden value=dataset.filedName=RIGHT%5EBB%5EAGE%60bgAlpha=10%60yAxisMinValue=500%60canvasBgColor=#cccc66%60useRoundEdges=1%60trendLines.color=#ff0000%60trendLines.displayValue=%E5%A4%A7%E5%8E%A6%60dataset.seriesName=RIGHT%5EBB%5EAGE%60linehead=AA%60decimals=1%60dataset.renderAs=AGE-Line%5EBB-Area%60drilldown.type=nodrill%60chartWidth=499%60showValues=1%60numberPrefix=#%60trendLines.have=1%60chartHeight=384%60numberSuffix=&amp;%60eformDataSetName=dataset1%60trendLines.startValue=900%60subCaption=%E5%8F%91%E5%A4%A7%E5%9F%8E%E6%A2%B0%60caption=%E5%B0%8F%E5%BF%83%E4%B8%80%E7%82%B9%60dataSet.dataset.fieldname=AGE%5EBB%5ERIGHT%60canvasBgAlpha=10%60bgColor=#993333%60xAxisName=%E6%9E%97%60showBorder=1%60yAxisMaxValue=1500%60dataSet.dataset.seriesName=AGE%5EBB%5ERIGHT%60yAxisName=%E5%AD%90%60formatNumberScale=1>

<DIV id=1273655204015azxsdivid style="LEFT: 517px; POSITION: absolute; TOP: 1px" align=center>loadingdata...</DIV>

<SCRIPT defer type=text/javascript>var dataset_dataset1 = document.getElementById('dataset1');if(typeof(varfuns_dataset1)=='undefined'){varfuns_dataset1 = new Array();}varfuns_dataset1.push(function(){var xml=dataset_dataset1.xml; var propertiesValue = decodeURI(document.getElementById('1273655204015azxshidinput').value);$.ajax({    url: getContextPath()+'/fusionchar',    type: 'POST',	 data: 'datasetxml='+toUN.on(xml)+'&propertiesValue='+toUN.on(propertiesValue)+'&chart_modelname=ScrollColumn2D_1273655204015azxs&chart_action=3',    async: true ,    error: function(){       $('#1273655204015azxsdivid').html('load data error!');    },    success: function(xml){	 	 $('#1273655204015azxsdivid').html(' ');        var fusionxml = xml;    		 var chart = new FusionCharts('../../../FusionCharts/Charts/ScrollColumn2D.swf', '1273655204015azxschartid', '499', '384');		 chart.setDataXML(decodeURI(fusionxml));		 chart.render('1273655204015azxsdivid');    }});}); dataset_dataset1.AfterOpen=function(){if(typeof(varfuns_dataset1)!=null) for(var i=0;i<varfuns_dataset1.length;++i){varfuns_dataset1[i]();}}</SCRIPT>

<INPUT id=1273202990827ZZZZhidinput type=hidden value=dataset.filedName=RIGHT%5EBB%5EAGE%60bgAlpha=15%60yAxisMinValue=%60canvasBgColor=#99cc66%60useRoundEdges=1%60trendLines.color=#ff0000%60dataset.parentYAxis=BB-S%5ERIGHT-S%5EAGE-P%60trendLines.displayValue=%E4%B8%87%E6%AC%A2%E6%B5%8B%E8%AF%95%60dataset.seriesName=%E7%BA%AF%E5%88%A9%E6%B6%A6%5E%E8%90%A5%E4%B8%9A%E5%88%A9%E6%B6%A6%5E%E9%94%80%E5%94%AE%E9%A2%9D%60linehead=AA%60dataset.renderAs=RIGHT-Area%5EBB-Line%60decimals=1%60drilldown.type=nodrill%60dataSet.dataset.lineSet.seriesName=RIGHT%60chartWidth=575%60showValues=1%60numberPrefix=%EF%BF%A5%60trendLines.have=1%60chartHeight=382%60numberSuffix=%E4%BA%BA%E6%B0%91%E5%B8%81%60eformDataSetName=dataset1%60trendLines.startValue=500%60subCaption=%60caption=%E4%B8%87%E6%AC%A2%E6%B5%8B%E8%AF%95%60dataSet.dataset.fieldname=AGE%5EBB%60canvasBgAlpha=15%60bgColor=#00ffcc%60xAxisName=%E9%87%91%E9%A2%9D%60showBorder=1%60yAxisMaxValue=%60dataSet.dataset.seriesName=AGE%5EBB%60dataSet.dataset.lineSet.fieldName=RIGHT%60yAxisName=%E5%8D%95%E4%BD%8D%60formatNumberScale=0>

<DIV id=1273202990827ZZZZdivid style="LEFT: 0px; POSITION: absolute; TOP: 0px" align=center>loadingdata...</DIV>

<SCRIPT defer type=text/javascript>var dataset_dataset1 = document.getElementById('dataset1');if(typeof(varfuns_dataset1)=='undefined'){varfuns_dataset1 = new Array();}varfuns_dataset1.push(function(){var xml=dataset_dataset1.xml; var propertiesValue = decodeURI(document.getElementById('1273202990827ZZZZhidinput').value);$.ajax({    url: getContextPath()+'/fusionchar',    type: 'POST',	 data: 'datasetxml='+toUN.on(xml)+'&propertiesValue='+toUN.on(propertiesValue)+'&chart_modelname=MSColumn2D_1273202990827ZZZZ&chart_action=3',    async: true ,    error: function(){       $('#1273202990827ZZZZdivid').html('load data error!');    },    success: function(xml){	 	 $('#1273202990827ZZZZdivid').html(' ');        var fusionxml = xml;    		 var chart = new FusionCharts('../../../FusionCharts/Charts/MSColumn2D.swf', '1273202990827ZZZZchartid', '575', '382');		 chart.setDataXML(decodeURI(fusionxml));		 chart.render('1273202990827ZZZZdivid');    }});}); dataset_dataset1.AfterOpen=function(){if(typeof(varfuns_dataset1)!=null) for(var i=0;i<varfuns_dataset1.length;++i){varfuns_dataset1[i]();}}</SCRIPT>
</DIV>
<div id='grid_tip'></div></body></html>
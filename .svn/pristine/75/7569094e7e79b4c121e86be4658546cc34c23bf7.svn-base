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
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/fcbasecont.js');");
if(bDgMode) out.println("<script src='../../fceform/js/fcbasecont.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/selectdate.js');");
if(bDgMode) out.println("<script defer src='../../fceform/js/selectdate.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/../fceformext/js/userfunc.js');");
if(bDgMode) out.println("<script src='../../fceform/../fceformext/js/userfunc.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/fcdate.js');");
if(bDgMode) out.println("<script src='../../fceform/js/fcdate.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/common/Common.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/common/Common.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/business/ReportStatistics.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/business/ReportStatistics.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/dao/ReportStatisticsDao.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/dao/ReportStatisticsDao.js'></script>");
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
<script>
var left_time = parent.$("left_time").value;
var right_time = parent.$("right_time").value;
var temp = parent.temp;//执法主体ID
function init(){
    var sql = ReportStatistics.findPayLevel(temp, left_time, right_time);
    dataset1.Open(sql);
}
</script>

<!-- 提示：以下为页面DOM元素内容 -->
<DIV id=SKbillsheet style="visibility:hidden" toolbar="不带工具栏" BLONopen="setAuthority();init();" contxml="<root><dataset><id>dataset1</id></dataset><Fusionchar><id>Fusionchar1</id></Fusionchar></root>" billtaborder="<root></root>" dj_sn="20101223202930234052" caption="案件金额等级统计报表" mkbh codeheader="BBB" entertype="修改" poswidth posheight controlno="SKButton:0;SKDBedit:0;checkbox:0;label:0;radio:0;listbox:0;textarea:0;combobox:0;password:0;upload:0;SKDBtext:0;chart:0;dbimg:0;img:0;SKBILLgrid:0;shape:0;tab:0;div:0;DsMain_field:0;a:0;button:0;text:0;hr:0;checkboxlist:0;radiolist:0;dropdownlist:0;grid:0;dataset:1;spin:0;excel:0;tree:0;ebshow:0;creatorSubForm:0;creator_div:0;ExtGrid:0;ExtUpload:0;ExtTree:0;Fusionchar:1" window="当前窗口" posleft postop keyfield isfile="否" OtherSave="否" idtype="1" testDbName="app_xzcf" creatorStyle="creatorBlue" BLONclose="UnLoadWebOffice();" creator_remark hasWorkflowButton="否" creator_elementAuthoritySwitch="否" creator_showAlert="否" creator_office_isBindForm="否" islog="否" isprotect="是" creator_csslib version="1.0" creator_pagination type="ZW" creatorType="20100902181125312621" jslib="fcbasecont.js&#13;&#10;selectdate.js&#13;&#10;~userfunc.js&#13;&#10;fcdate.js&#13;&#10;../../../ccapp/app_xzcf/js/common/Common.js&#13;&#10;../../../ccapp/app_xzcf/js/business/ReportStatistics.js&#13;&#10;../../../ccapp/app_xzcf/js/dao/ReportStatisticsDao.js">

<INPUT id=1293107872187charPayLevelhidinput type=hidden value=dataSet.dataset.fieldname=a1%5Ea2%5Ea3%5Ea4%5Ea5%5Ea6%60formatNumberScale=1%60canvasBgColor=%60caption=%E6%A1%88%E4%BB%B6%E9%87%91%E9%A2%9D%E7%AD%89%E7%BA%A7%E7%BB%9F%E8%AE%A1%60useRoundEdges=1%60showValues=1%60chartHeight=500%60dataSet.dataset.seriesName=a1%5Ea2%5Ea3%5Ea4%5Ea5%5Ea6%60drilldown.type=nodrill%60linehead=sumAll%60numberPrefix=%60yAxisName=%E6%A1%88%E4%BB%B6%E6%95%B0%E9%87%8F%60bgColor=%60yAxisMaxValue=%60yAxisMinValue=%60dataset.seriesName=%E4%B8%80%E4%B8%87%E4%BB%A5%E4%B8%8B%5E%E4%B8%80%E4%B8%87%E8%87%B3%E4%B8%89%E4%B8%87%5E%E4%B8%83%E4%B8%87%E8%87%B3%E5%8D%81%E4%B8%87%5E%E5%8D%81%E4%B8%87%E4%BB%A5%E4%B8%8A%5E%E4%B8%89%E4%B8%87%E8%87%B3%E4%BA%94%E4%B8%87%5E%E4%BA%94%E4%B8%87%E8%87%B3%E4%B8%83%E4%B8%87%60numberSuffix=%60bgAlpha=%60subCaption=%60showBorder=1%60decimals=0%60canvasBgAlpha=%60xAxisName=%E6%A1%88%E4%BB%B6%E9%87%91%E9%A2%9D%E7%AD%89%E7%BA%A7%60chartWidth=1000%60eformDataSetName=dataset1%60dataset.filedName=a1%5Ea2%5Ea5%5Ea6%5Ea3%5Ea4>

<DIV id=1293107872187charPayLeveldivid style="LEFT: 0px; POSITION: absolute; TOP: 0px" align=center>loadingdata...</DIV>

<SCRIPT defer type=text/javascript>var dataset_dataset1 = document.getElementById('dataset1');if(typeof(varfuns_dataset1)=='undefined'){varfuns_dataset1 = new Array();}varfuns_dataset1.push(function(){var xml=dataset_dataset1.xml; var propertiesValue = decodeURI(document.getElementById('1293107872187charPayLevelhidinput').value);$.ajax({    url: getContextPath()+'/fusionchar',    type: 'POST',	 data: 'datasetxml='+toUN.on(xml)+'&propertiesValue='+toUN.on(propertiesValue)+'&chart_modelname=MSColumn2D_1293107872187charPayLevel&chart_action=3',    async: true ,    error: function(){       $('#1293107872187charPayLeveldivid').html('load data error!');    },    success: function(xml){	 	 $('#1293107872187charPayLeveldivid').html(' ');        var fusionxml = xml;    		 var chart = new FusionCharts('../../../FusionCharts/Charts/MSColumn2D.swf', '1293107872187charPayLevelchartid', '1000', '500');		 chart.setDataXML(decodeURI(fusionxml));		 chart.render('1293107872187charPayLeveldivid');    }});}); dataset_dataset1.AfterOpen=function(){if(typeof(varfuns_dataset1)!=null) for(var i=0;i<varfuns_dataset1.length;++i){varfuns_dataset1[i]();}}</SCRIPT>

<?xml:namespace prefix = fc />

<fc:dataset id=dataset1 format="<fields><field><fieldname>a1</fieldname><datatype>字符</datatype><displaylabel>一万以下</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>a2</fieldname><datatype>字符</datatype><displaylabel>一万至三万</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>a3</fieldname><datatype>字符</datatype><displaylabel>三万至五万</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>a4</fieldname><datatype>字符</datatype><displaylabel>五万至七万</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>a5</fieldname><datatype>字符</datatype><displaylabel>七万至十万</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>a6</fieldname><datatype>字符</datatype><displaylabel>十万以上</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>sumAll</fieldname><datatype>字符</datatype><displaylabel>案件数量</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field></fields>" sqltrans="%F4%D8%E6%D8%D4%F6XrnbXrn%DA%F2%EC%E8Xrn%D6%F8%D0%E6" onSetText='bill_ondatasetsettext("<dsid><a1></a1><a2></a2><a3></a3><a4></a4><a5></a5><a6></a6><sumAll></sumAll></dsid>")' onGetText='bill_ondatasetgettext("<dsid><a1></a1><a2></a2><a3></a3><a4></a4><a5></a5><a6></a6><sumAll></sumAll></dsid>")' onValid='bill_ondatasetvalid("<dsid><a1></a1><a2></a2><a3></a3><a4></a4><a5></a5><a6></a6><sumAll></sumAll></dsid>")' opensortno="1" temptable="TMP_DATASET1" multiResult="是"></fc:dataset>
</DIV>
<div id='grid_tip'></div></body></html>
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
		
		//����Ӧ��ȷ����ʽ��Ŀ¼
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
		            <TD><DIV style="BORDER-RIGHT: skyblue 2px solid; BORDER-TOP: skyblue 2px solid; FONT-SIZE: 15px; BACKGROUND: #ffffff; BORDER-LEFT: skyblue 2px solid; WIDTH: 150px; PADDING-TOP: 9px; BORDER-BOTTOM: skyblue 2px solid; HEIGHT: 40px; solid: #000000">���ڼ��ء���</DIV></TD>
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

<!-- ��ʾ������Ϊҳ���JS&CSS���� -->
<%




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


<!-- ��ʾ������Ϊҳ���Զ���JS���� -->
<script></script>

<!-- ��ʾ������Ϊҳ��DOMԪ������ -->
<DIV id=SKbillsheet style="visibility:hidden" toolbar="����������" BLONopen="setAuthority();" contxml="<root><dataset><id>dataset1</id></dataset><Fusionchar><id>Fusionchar1</id></Fusionchar></root>" billtaborder="<root></root>" dj_sn caption="����ͼ����ȡopen" mkbh codeheader="BBB" entertype="�޸�" poswidth posheight controlno="SKButton:0;SKDBedit:0;checkbox:0;label:0;radio:0;listbox:0;textarea:0;combobox:0;password:0;upload:0;SKDBtext:0;chart:0;dbimg:0;img:0;SKBILLgrid:0;shape:0;tab:0;div:0;DsMain_field:0;a:0;button:0;text:0;hr:0;checkboxlist:0;radiolist:0;dropdownlist:0;grid:0;dataset:1;spin:0;excel:0;tree:0;ebshow:0;creatorSubForm:0;creator_div:0;ExtGrid:0;ExtUpload:0;ExtTree:0;Fusionchar:1" window="��ǰ����" posleft postop keyfield isfile="��" OtherSave="��" idtype="1" testDbName creatorStyle="creatorBlue" BLONclose="UnLoadWebOffice();" creator_remark hasWorkflowButton="��" creator_elementAuthoritySwitch="��" creator_showAlert="��" creator_office_isBindForm="��" islog="��" isprotect="��" creator_csslib version="1.0" creator_pagination type="ZW" creatorType="20100429103033952469" jslib="fcsavedj.js&#13;&#10;fcbasecont.js&#13;&#10;selectdate.js&#13;&#10;~userfunc.js&#13;&#10;fcdate.js">

<INPUT id=1249464660724test2hidinput type=hidden value=drilldown.popup.resizable=0%60baseFontSize=%60drilldown.popup.scrollbars=0%60trendLines.have=1%60rotateValues=0%60eformDataSetName=dataset1%60trendLines.color=%60linehead=CITY_NAME%60caption=%60canvasBgColor=%60chartHeight=336%60placeValuesInside=0%60yAxisName=%60drilldown.popup.fullscreen=0%60xAxisName=%60drilldown.popup.menubar=0%60drilldown.type=popup%60canvasBgAlpha=%60showBorder=1%60drilldown.popup.location=0%60drilldown.linkUrl.CITY_RAIN=20090805174859697050.jsp%60chartWidth=528%60bgColor=%60subCaption=%60drilldown.popup.status=0%60trendLines.displayValue=%60yAxisMinValue=%60bgAlpha=%60decimals=%60showValues=1%60outCnvBaseFontSize=%60numberPrefix=%60numberSuffix=%60useRoundEdges=1%60formatNumberScale=1%60drilldown.field=CITY_RAIN%60drilldown.popup.toolbar=0%60yAxisMaxValue=%60drilldown.paramValue.CITY_RAIN=%7B-categoryValue%7D%5ENuLl%5ENuLl%60drilldown.paramName.CITY_RAIN=data%5E%5E%60selectedfield=CITY_RAIN%60trendLines.startValue=%0D%0A%0D%0A%0D%0A%0D%0A>

<DIV id=1249464660724test2divid style="LEFT: 0px; POSITION: absolute; TOP: 0px" align=center>loadingdata...</DIV>

<SCRIPT defer type=text/javascript>var dataset_dataset1 = document.getElementById('dataset1');if(typeof(varfuns_dataset1)=='undefined'){varfuns_dataset1 = new Array();}varfuns_dataset1.push(function(){var xml=dataset_dataset1.xml; var propertiesValue = decodeURI(document.getElementById('1249464660724test2hidinput').value);$.ajax({    url: getContextPath()+'/fusionchar',    type: 'POST',	 data: 'datasetxml='+toUN.on(xml)+'&propertiesValue='+toUN.on(propertiesValue)+'&chart_modelname=Column3D_1249464660724test2&chart_action=3',    async: true ,    error: function(){       $('#1249464660724test2divid').html('load data error!');    },    success: function(xml){	 	 $('#1249464660724test2divid').html(' ');        var fusionxml = xml;    		 var chart = new FusionCharts('../../../FusionCharts/Charts/Column3D.swf', '1249464660724test2chartid', '528', '336');		 chart.setDataXML(decodeURI(fusionxml));		 chart.render('1249464660724test2divid');    }});}); dataset_dataset1.AfterOpen=function(){if(typeof(varfuns_dataset1)!=null) for(var i=0;i<varfuns_dataset1.length;++i){varfuns_dataset1[i]();}}</SCRIPT>

<?xml:namespace prefix = fc />

<fc:dataset id=dataset1 format="<fields><field><fieldname>CITY_NAME</fieldname><datatype>�ַ�</datatype><displaylabel>CITY_NAME</displaylabel><size>20</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>CITY_RAIN</fieldname><datatype>�ַ�</datatype><displaylabel>CITY_RAIN</displaylabel><size>20</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>RAIN_MONTH</fieldname><datatype>�ַ�</datatype><displaylabel>RAIN_MONTH</displaylabel><size>20</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field></fields>" sqltrans="%F4%D8%E6%D8%D4%F6XrnbXrn%DA%F2%EC%E8Xrn%B6%90%CC%F2%D0%E0%EA%DA%D0%E6%E6" onSetText='bill_ondatasetsettext("<dsid><CITY_NAME></CITY_NAME><CITY_RAIN></CITY_RAIN><RAIN_MONTH></RAIN_MONTH></dsid>")' onGetText='bill_ondatasetgettext("<dsid><CITY_NAME></CITY_NAME><CITY_RAIN></CITY_RAIN><RAIN_MONTH></RAIN_MONTH></dsid>")' onValid='bill_ondatasetvalid("<dsid><CITY_NAME></CITY_NAME><CITY_RAIN></CITY_RAIN><RAIN_MONTH></RAIN_MONTH></dsid>")' opensortno="1" temptable="TMP_DATASET1" multiResult="��"></fc:dataset>
</DIV>
<div id='grid_tip'></div></body></html>
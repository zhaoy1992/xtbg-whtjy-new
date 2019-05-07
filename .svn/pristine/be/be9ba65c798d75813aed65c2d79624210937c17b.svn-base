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
					
			mtJsFileArray("eformsys/fceform/js/Ext/ext-base.js", true, eppDataWrObj);
         mtJsFileArray("eformsys/fceform/js/Ext/ext-all.js", true, eppDataWrObj);
         mtJsFileArray("eformsys/fceform/js/Ext/ext-lang-zh_CN.js", true, eppDataWrObj, "UTF-8");
         mtJsFileArray("eformsys/fceform/js/Ext/css/ext-all.css", true, optmGetUsdatObj());
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
  mylink.setAttribute('href','../../../ccapp/<%=appPath%>/css/creatorBlue/allStyle.css');
  myhead.appendChild(mylink);
<%}else{%>  adv_loadjsfile('ccapp/<%=appPath%>/css/creatorBlue/allStyle.css');
<%}%>  fcpubdata.creatorStyle='creatorBlue';
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
if(!bDgMode) out.println("</script>");
%>

   <script language='javascript'>
adv_loadjsfile('/eformsys/fceform/css/tabstyle.css');
adv_loadjsfile('/eformsys/fceform/css/Button.css');
adv_loadjsfile('/eformsys/fceform/css/TextStyle.css');
adv_loadjsfile('/eformsys/fceform/js/Ext/CreatorMemoryProxy.js');
adv_loadjsfile('/eformsys/fceform/js/Ext/TreeCheckBoxNodeUI.js');
</script>


<!-- 提示：以下为页面自定义JS内容 -->
<script>
var arr = "{id : 1, text : '实物工作量信息',children : [ {id : 100000, text : '地形测绘', children : [{id : 110000, text : '地形测量', children : [{id : 111000, text : '控制测量', children : [{id : 111001, text : '导线测量', leaf : true},{id : 111002, text : '水准测量', leaf : true},{id : 111003, text : 'GPS', leaf : true}]},{id : 112000, text : '地形测量', children : [{id : 112001, text : '1:10000地形测量', leaf : true},{id : 112002, text : '1:5000地形测量', leaf : true},{id : 112003, text : '1:2000地形测量', leaf : true},{id : 112004, text : '1:1000地形测量', leaf : true},{id : 112005, text : '1:500地形测量', leaf : true}]}]},{id : 120000, text : '制图', children : [{id : 121000, text : '地形图编绘', children : [{id : 121001, text : '1:25000地形图编绘', leaf : true},{id : 121002, text : '1:10000地形图编绘', leaf : true},{id : 121003, text : '1:5000地形图编绘', leaf : true},{id : 121004, text : '1:1000000地理底图编绘', leaf : true},{id : 121005, text : '1:500000地理底图编绘', leaf : true},{id : 121006, text : '1:250000地理底图编绘', leaf : true},{id : 121007, text : '1:100000地理底图编绘', leaf : true},{id : 121008, text : '1:50000地理底图编绘', leaf : true},{id : 121009, text : '1:25000地理底图编绘', leaf : true},{id : 121010, text : '1:10000地理底图编绘', leaf : true},{id : 121011, text : '1:5000地理底图编绘', leaf : true}]},{id : 122000, text : '地形图数字化', children : [{id : 122001, text : '1:1000000地形图数字化', leaf : true},{id : 122002, text : '1:250000地形图数字化', leaf : true},{id : 122003, text : '1:100000地形图数字化', leaf : true},{id : 122004, text : '1:50000地形图数字化', leaf : true},{id : 122005, text : '1:25000地形图数字化', leaf : true},{id : 122006, text : '1:10000地形图数字化', leaf : true},{id : 122007, text : '1:5000地形图数字化', leaf : true},{id : 122008, text : '1:2000地形图数字化', leaf : true},{id : 122009, text : '1:500~1000地形图数字化', leaf : true}]},{id : 123000, text : '地质图数字化', children : [{id : 123001, text : '1:5万~1:25万地质图数字化', leaf : true},{id : 123002, text : '1:50万~1:250万地质图数字化', leaf : true}]},{id : 124000, text : '地质图计算机成图', children : [{id : 124001, text : '平面地质图（全开）计算机成图', leaf : true},{id : 124002, text : '平面地质图（对开）计算机成图', leaf : true},{id : 124003, text : '1:5万~1:10万区域地质图计算机成图', leaf : true},{id : 124004, text : '剖面图计算机成图', leaf : true},{id : 124005, text : '槽探、浅井、坑道图、柱状图计算机成图', leaf : true}]}]}]},{id : 200000, text : '地质测量', children : [{id : 210000, text : '区域地质调查', children : [{id : 210001, text : '1:250000区域地质调查', leaf : true},{id : 210002, text : '1:50000区域地质调查', leaf : true},{id : 210003, text : '区域地质调查（实测）', leaf : true},{id : 210004, text : '区域地质调查（修测）', leaf : true}]},{id : 220000, text : '专项地质测量', children : [{id : 221000, text : '专项地质测量', children : [{id : 221001, text : '1:50000专项地质测量', leaf : true},{id : 221002, text : '1:25000专项地质测量', leaf : true},{id : 221003, text : '1:10000专项地质测量', leaf : true},{id : 221004, text : '1:5000专项地质测量', leaf : true},{id : 221005, text : '1:2000专项地质测量', leaf : true},{id : 221006, text : '1:1000专项地质测量', leaf : true}]},{id : 222000, text : '地质剖面测量', children : [{id : 222001, text : '1:10000地质剖面测量', leaf : true},{id : 222002, text : '1:5000地质剖面测量', leaf : true},{id : 222003, text : '1:2000地质剖面测量', leaf : true},{id : 222004, text : '1:1000地质剖面测量', leaf : true},{id : 222005, text : '1:500地质剖面测量', leaf : true}]}]},{id : 230000, text : '区域水文地质、生态环境地质调查', children : [{id : 231000, text : '区域水文地质调查', children : [{id : 231001, text : '1:250000区域水文地质调查', leaf : true},{id : 231002, text : '1:200000区域水文地质调查', leaf : true},{id : 231003, text : '1:100000区域水文地质调查', leaf : true}]},{id : 232000, text : '区域生态环境地质调查', children : [{id : 232001, text : '1:250000区域生态环境地质调查', leaf : true},{id : 232002, text : '1:200000区域生态环境地质调查', leaf : true},{id : 232003, text : '1:100000区域生态环境地质调查', leaf : true}]}]},{id : 240000, text : '专项水文地质、生态环境地质测量', children : [{id : 241000, text : '专项水文地质测量', children : [{id : 241001, text : '1:50000专项水文地质测量', leaf : true},{id : 241002, text : '1:25000专项水文地质测量', leaf : true},{id : 241003, text : '1:10000专项水文地质测量', leaf : true},{id : 241004, text : '1:5000专项水文地质测量', leaf : true},{id : 241005, text : '1:2000专项水文地质测量', leaf : true}]},{id : 242000, text : '专项生态环境地质测量', children : [{id : 242001, text : '1:50000专项生态环境地质测量', leaf : true},{id : 242002, text : '1:25000专项生态环境地质测量', leaf : true},{id : 242003, text : '1:10000专项生态环境地质测量', leaf : true},{id : 242004, text : '1:5000专项生态环境地质测量', leaf : true},{id : 242005, text : '1:2000专项生态环境地质测量', leaf : true}]}]},{id : 250000, text : '区域工程地质、环境地质调查', children : [{id : 251000, text : '区域工程地质调查', children : [{id : 251001, text : '1:250000区域工程地质调查', leaf : true},{id : 251002, text : '1:200000区域工程地质调查', leaf : true},{id : 251003, text : '1:100000区域工程地质调查', leaf : true}]},{id : 252000, text : '区域环境地质调查', children : [{id : 252001, text : '1:500000区域环境地质调查', leaf : true},{id : 252002, text : '1:250000区域环境地质调查', leaf : true},{id : 252003, text : '1:200000区域环境地质调查', leaf : true},{id : 252004, text : '1:100000区域环境地质调查', leaf : true}]}]},{id : 260000, text : '专项工程地质、环境地质、地质灾害测量', children : [{id : 261000, text : '专项工程地质测量', children : [{id : 261001, text : '1:50000专项工程地质测量', leaf : true},{id : 261002, text : '1:25000专项工程地质测量', leaf : true},{id : 261003, text : '1:10000专项工程地质测量', leaf : true},{id : 261004, text : '1:5000专项工程地质测量', leaf : true},{id : 261005, text : '1:2000专项工程地质测量', leaf : true}]},{id : 262000, text : '专项环境地质、地质灾害测量', children : [{id : 262001, text : '1:50000专项环境地质、地质灾害测量', leaf : true},{id : 262002, text : '1:25000专项环境地质、地质灾害测量', leaf : true},{id : 262003, text : '1:10000专项环境地质、地质灾害测量', leaf : true},{id : 262004, text : '1:5000专项环境地质、地质灾害测量', leaf : true},{id : 262005, text : '1:2000专项环境地质、地质灾害测量', leaf : true}]}]}]},{id : 300000, text : '遥感地质', children : [{id : 310000, text : '航空遥感彩色摄影', children : [{id : 310001, text : '1:70000航空遥感彩色摄影', leaf : true},{id : 310002, text : '1:60000航空遥感彩色摄影', leaf : true},{id : 310003, text : '1:50000航空遥感彩色摄影', leaf : true},{id : 310004, text : '1:35000航空遥感彩色摄影', leaf : true},{id : 310005, text : '1:30000航空遥感彩色摄影', leaf : true},{id : 310006, text : '1:25000航空遥感彩色摄影', leaf : true},{id : 310007, text : '1:20000航空遥感彩色摄影', leaf : true},{id : 310008, text : '1:15000航空遥感彩色摄影', leaf : true},{id : 310009, text : '1:10000航空遥感彩色摄影', leaf : true},{id : 310010, text : '1:8000航空遥感彩色摄影', leaf : true}]},{id : 320000, text : '遥感地质解译', children : [{id : 321000, text : '遥感信息提取', children : [{id : 321001, text : '1:250000~1:50000遥感信息提取', leaf : true},{id : 321002, text : '1:50000遥感信息提取', leaf : true},{id : 321003, text : '1:10000遥感信息提取', leaf : true},{id : 321004, text : '1:25000遥感信息提取', leaf : true},{id : 321005, text : '1:5000遥感信息提取', leaf : true}]},{id : 322000, text : '遥感地质解译', children : [{id : 322001, text : '1:500000遥感地质解译', leaf : true},{id : 322002, text : '1:250000遥感地质解译', leaf : true},{id : 322003, text : '1:200000遥感地质解译', leaf : true},{id : 322004, text : '1:100000遥感地质解译', leaf : true},{id : 322005, text : '1:50000遥感地质解译', leaf : true},{id : 322006, text : '1:25000遥感地质解译', leaf : true},{id : 322007, text : '1:10000遥感地质解译', leaf : true}]}]}]},{id : 400000, text : '物化探', children : [{id : 410000, text : '物探', children : [{id : 411000, text : '磁法', children : [{id : 411001, text : '1:50000磁法测量', leaf : true},{id : 411002, text : '1:25000磁法测量', leaf : true},{id : 411003, text : '1:20000磁法测量', leaf : true},{id : 411004, text : '1:10000磁法测量', leaf : true},{id : 411005, text : '1:5000磁法测量', leaf : true},{id : 411006, text : '1:2000磁法测量', leaf : true},{id : 411007, text : '1:1000磁法测量', leaf : true},{id : 411008, text : '1:10000磁法剖面测量', leaf : true},{id : 411009, text : '1:5000磁法剖面测量', leaf : true},{id : 411010, text : '1:2000磁法剖面测量', leaf : true},{id : 411011, text : '1:1000磁法剖面测量', leaf : true}]},{id : 412000, text : '重力', children : [{id : 412001, text : '1:1000000区域重力测量', leaf : true},{id : 412002, text : '1:500000区域重力测量', leaf : true},{id : 412003, text : '1:250000区域重力测量', leaf : true},{id : 412004, text : '1:200000区域重力测量', leaf : true},{id : 412005, text : '1:100000区域重力测量', leaf : true},{id : 412006, text : '1:50000区域重力测量', leaf : true},{id : 412007, text : '1:25000重力测量', leaf : true},{id : 412008, text : '1:10000重力测量', leaf : true},{id : 412009, text : '1:5000重力测量', leaf : true},{id : 412010, text : '1:25000重力剖面测量', leaf : true},{id : 412011, text : '1:10000重力剖面测量', leaf : true},{id : 412012, text : '1:5000重力剖面测量', leaf : true},{id : 412013, text : '1:2000重力剖面测量', leaf : true},{id : 412014, text : '1:1000重力剖面测量', leaf : true}]},{id : 413000, text : '电法', children : [{id : 413001, text : '激电中梯(长导线)测量', leaf : true},{id : 413002, text : '激电中梯(长导线)剖面测量', leaf : true},{id : 413003, text : '激电中梯(短导线)测量', leaf : true},{id : 413004, text : '激电中梯(短导线)剖面测量', leaf : true},{id : 413005, text : '激电测深测量', leaf : true},{id : 413006, text : '视电阻率中梯测量', leaf : true},{id : 413007, text : '视电阻率联合剖面测量', leaf : true},{id : 413008, text : '视电阻率垂向电测探测量', leaf : true},{id : 413009, text : '视电阻率对称四极剖面测量', leaf : true},{id : 413010, text : '1:25000充电法电位和梯度测量', leaf : true},{id : 413011, text : '1:10000充电法电位和梯度测量', leaf : true},{id : 413012, text : '1:5000充电法电位和梯度测量', leaf : true},{id : 413013, text : '1:2000充电法电位和梯度测量', leaf : true},{id : 413014, text : '1:25000自然电场法电位测量', leaf : true},{id : 413015, text : '1:10000自然电场法电位测量', leaf : true},{id : 413016, text : '1:5000自然电场法电位测量', leaf : true},{id : 413017, text : '1:2000自然电场法电位测量', leaf : true},{id : 413018, text : '瞬变电磁法测量', leaf : true},{id : 413019, text : '高密度电阻率法测量', leaf : true},{id : 413020, text : '大地电磁测深测量', leaf : true},{id : 413021, text : '可控源音频大地电磁测深测量', leaf : true},{id : 413022, text : '甚低频测量', leaf : true}]},{id : 414000, text : '地震', children : [{id : 414001, text : '浅层地震一次观测法测量', leaf : true},{id : 414002, text : '浅层地震多次迭加法测量', leaf : true}]},{id : 415000, text : '放射性', children : [{id : 415001, text : '1:50000伽玛总量测量（面积测量）', leaf : true},{id : 415002, text : '1:25000伽玛总量测量（面积测量）', leaf : true},{id : 415003, text : '1:10000伽玛总量测量（面积测量）', leaf : true},{id : 415004, text : '1:5000伽玛总量测量（面积测量）', leaf : true},{id : 415005, text : '1:2000伽玛总量测量（面积测量）', leaf : true},{id : 415006, text : '1:1000伽玛总量测量（面积测量）', leaf : true},{id : 415007, text : '1:50000伽玛总量测量（剖面测量）', leaf : true},{id : 415008, text : '1:25000伽玛总量测量（剖面测量）', leaf : true},{id : 415009, text : '1:10000伽玛总量测量（剖面测量）', leaf : true},{id : 415010, text : '1:5000伽玛总量测量（剖面测量）', leaf : true},{id : 415011, text : '1:2000伽玛总量测量（剖面测量）', leaf : true},{id : 415012, text : '1:1000伽玛总量测量（剖面测量）', leaf : true},{id : 415013, text : '1:50000伽玛能谱测量（面积测量）', leaf : true},{id : 415014, text : '1:25000伽玛能谱测量（面积测量）', leaf : true},{id : 415015, text : '1:10000伽玛能谱测量（面积测量）', leaf : true},{id : 415016, text : '1:5000伽玛能谱测量（面积测量）', leaf : true},{id : 415017, text : '1:2000伽玛能谱测量（面积测量）', leaf : true},{id : 415018, text : '1:50000伽玛能谱测量（剖面测量）', leaf : true},{id : 415019, text : '1:25000伽玛能谱测量（剖面测量）', leaf : true},{id : 415020, text : '1:10000伽玛能谱测量（剖面测量）', leaf : true},{id : 415021, text : '1:5000伽玛能谱测量（剖面测量）', leaf : true},{id : 415022, text : '1:2000伽玛能谱测量（剖面测量）', leaf : true},{id : 415023, text : '1:25000常规测氧、RaA法测氧（面积测量）', leaf : true},{id : 415024, text : '1:10000常规测氧、RaA法测氧（面积测量）', leaf : true},{id : 415025, text : '1:5000常规测氧、RaA法测氧（面积测量）', leaf : true},{id : 415026, text : '1:2000常规测氧、RaA法测氧（面积测量）', leaf : true},{id : 415027, text : '1:1000常规测氧、RaA法测氧（面积测量）', leaf : true},{id : 415028, text : '1:25000常规测氧、RaA法测氧（剖面测量）', leaf : true},{id : 415029, text : '1:10000常规测氧、RaA法测氧（剖面测量）', leaf : true},{id : 415030, text : '1:5000常规测氧、RaA法测氧（剖面测量）', leaf : true},{id : 415031, text : '1:2000常规测氧、RaA法测氧（剖面测量）', leaf : true},{id : 415032, text : '1:1000常规测氧、RaA法测氧（剖面测量）', leaf : true},{id : 415033, text : '1:50000活性炭测量（面积测量）', leaf : true},{id : 415034, text : '1:25000活性炭测量（面积测量）', leaf : true},{id : 415035, text : '1:10000活性炭测量（面积测量）', leaf : true},{id : 415036, text : '1:5000活性炭测量（面积测量）', leaf : true},{id : 415037, text : '1:2000活性炭测量（面积测量）', leaf : true},{id : 415038, text : '1:50000活性炭测量（剖面测量）', leaf : true},{id : 415039, text : '1:25000活性炭测量（剖面测量）', leaf : true},{id : 415040, text : '1:10000活性炭测量（剖面测量）', leaf : true},{id : 415041, text : '1:5000活性炭测量（剖面测量）', leaf : true},{id : 415042, text : '1:2000活性炭测量（剖面测量）', leaf : true}]},{id : 416000, text : '测井', children : [{id : 416001, text : '视电阻率测井', leaf : true},{id : 416002, text : '电化学测井', leaf : true},{id : 416003, text : '放射性测井', leaf : true},{id : 416004, text : '井径测井', leaf : true},{id : 416005, text : '井温测井', leaf : true},{id : 416006, text : '井中磁测', leaf : true},{id : 416007, text : '水文测井', leaf : true},{id : 416008, text : '测井斜', leaf : true},{id : 416009, text : '激电测井', leaf : true},{id : 416010, text : '三侧向测井', leaf : true},{id : 416011, text : '密度测井', leaf : true}]}]},{id : 420000, text : '化探', children : [{id : 421000, text : '土壤测量', children : [{id : 421001, text : '1:50000土壤测量', leaf : true},{id : 421002, text : '1:25000土壤测量', leaf : true},{id : 421003, text : '1:10000土壤测量', leaf : true},{id : 421004, text : '1:5000土壤测量', leaf : true},{id : 421005, text : '1:2000土壤测量', leaf : true},{id : 421006, text : '200米土壤剖面测量', leaf : true},{id : 421007, text : '100米土壤剖面测量', leaf : true},{id : 421008, text : '50米土壤剖面测量', leaf : true},{id : 421009, text : '40米土壤剖面测量', leaf : true},{id : 421010, text : '20米土壤剖面测量', leaf : true},{id : 421011, text : '10米土壤剖面测量', leaf : true},{id : 421012, text : '多目标土壤测量', leaf : true}]},{id : 422000, text : '岩石测量', children : [{id : 422001, text : '1:50000岩石测量', leaf : true},{id : 422002, text : '1:25000岩石测量', leaf : true},{id : 422003, text : '1:10000岩石测量', leaf : true},{id : 422004, text : '1:5000岩石测量', leaf : true},{id : 422005, text : '1:2000岩石测量', leaf : true},{id : 422006, text : '200米岩石剖面测量', leaf : true},{id : 422007, text : '100米岩石剖面测量', leaf : true},{id : 422008, text : '50米岩石剖面测量', leaf : true},{id : 422009, text : '40米岩石剖面测量', leaf : true},{id : 422010, text : '20米岩石剖面测量', leaf : true},{id : 422011, text : '10米岩石剖面测量', leaf : true}]},{id : 423000, text : '水地球化学测量', children : [{id : 423001, text : '水地球化学测量', leaf : true}]},{id : 424000, text : '水系沉积物测量', children : [{id : 424001, text : '1:500000水系沉积物测量', leaf : true},{id : 424002, text : '1:200000水系沉积物测量', leaf : true},{id : 424003, text : '1:50000水系沉积物测量', leaf : true}]},{id : 425000, text : '汞气测量', children : [{id : 425001, text : '1:50000汞气测量', leaf : true},{id : 425002, text : '1:25000汞气测量', leaf : true},{id : 425003, text : '1:10000汞气测量', leaf : true},{id : 425004, text : '1:5000汞气测量', leaf : true},{id : 425005, text : '1:2000汞气测量', leaf : true}]},{id : 426000, text : '地气测量', children : [{id : 426001, text : '1:200000地气测量（纳米级物质测量）', leaf : true},{id : 426002, text : '1:100000地气测量（纳米级物质测量）', leaf : true},{id : 426003, text : '1:50000地气测量（纳米级物质测量）', leaf : true},{id : 426004, text : '1:25000地气测量（纳米级物质测量）', leaf : true},{id : 426005, text : '1:10000地气测量（纳米级物质测量）', leaf : true},{id : 426006, text : '1:5000地气测量（纳米级物质测量）', leaf : true},{id : 426007, text : '1:2000地气测量（纳米级物质测量）', leaf : true}]},{id : 427000, text : '地热化探测量', children : [{id : 427001, text : '地热化探测量', leaf : true}]}]},{id : 430000, text : '物化探测网与剖面布设', children : [{id : 431000, text : '测网布设', children : [{id : 431001, text : '1:25000测网布设', leaf : true},{id : 431002, text : '1:10000测网布设', leaf : true},{id : 431003, text : '1:5000测网布设', leaf : true},{id : 431004, text : '1:2000测网布设', leaf : true},{id : 431005, text : '1:1000测网布设', leaf : true}]},{id : 432000, text : '剖面布设', children : [{id : 432001, text : '1:10000剖面布设', leaf : true},{id : 432002, text : '1:5000剖面布设', leaf : true},{id : 432003, text : '1:2000剖面布设', leaf : true}]},{id : 433000, text : '测网等外水准测量', children : [{id : 433001, text : '1:25000测网等外水准测量', leaf : true},{id : 433002, text : '1:10000测网等外水准测量', leaf : true},{id : 433003, text : '1:5000测网等外水准测量', leaf : true},{id : 433004, text : '1:2000测网等外水准测量', leaf : true}]}]},{id : 440000, text : '航空物探', children : [{id : 441000, text : '单磁', children : [{id : 441001, text : '1:100万单磁', leaf : true},{id : 441002, text : '1:50万单磁', leaf : true},{id : 441003, text : '1:25万单磁', leaf : true},{id : 441004, text : '1:10万单磁', leaf : true},{id : 441005, text : '1:20万单磁', leaf : true},{id : 441006, text : '1:5万单磁', leaf : true},{id : 441007, text : '1:1万单磁', leaf : true},{id : 441008, text : '1:2万单磁', leaf : true},{id : 441009, text : '1:2.5万单磁', leaf : true}]},{id : 442000, text : '磁放', children : [{id : 442001, text : '1:100万磁放', leaf : true},{id : 442002, text : '1:50万磁放', leaf : true},{id : 442003, text : '1:25万磁放', leaf : true},{id : 442004, text : '1:10万磁放', leaf : true},{id : 442005, text : '1:20万磁放', leaf : true},{id : 442006, text : '1:5万磁放', leaf : true},{id : 442007, text : '1:1万磁放', leaf : true},{id : 442008, text : '1:2万磁放', leaf : true},{id : 442009, text : '1:2.5万磁放', leaf : true}]},{id : 443000, text : '磁放电', children : [{id : 443001, text : '1:100万磁放电', leaf : true},{id : 443002, text : '1:50万磁放电', leaf : true},{id : 443003, text : '1:25万磁放电', leaf : true},{id : 443004, text : '1:10万磁放电', leaf : true},{id : 443005, text : '1:20万磁放电', leaf : true},{id : 443006, text : '1:5万磁放电', leaf : true},{id : 443007, text : '1:1万磁放电', leaf : true},{id : 443008, text : '1:2万磁放电', leaf : true},{id : 443009, text : '1:2.5万磁放电', leaf : true}]}]}]},{id : 500000, text : '钻探', children : [{id : 510000, text : '矿产地质钻探', children : [{id : 510001, text : '机械岩心钻探', leaf : true},{id : 510002, text : '砂钻', leaf : true},{id : 510003, text : '取样钻', leaf : true},{id : 510004, text : '矿产地质水平钻探', leaf : true}]},{id : 520000, text : '水文地质钻探', children : [{id : 520001, text : '水文钻探', leaf : true}]},{id : 530000, text : '地热钻探', children : [{id : 530001, text : '地热钻探', leaf : true}]},{id : 540000, text : '工程地质钻探', children : [{id : 540001, text : '工程地质钻探', leaf : true}]}]},{id : 600000, text : '山地工程', children : [{id : 610000, text : '坑探', children : [{id : 610001, text : '坑探', leaf : true}]},{id : 620000, text : '浅井', children : [{id : 620001, text : '浅井', leaf : true},{id : 620002, text : '土石井', leaf : true},{id : 620003, text : '砂井', leaf : true},{id : 620004, text : '小园井', leaf : true}]},{id : 630000, text : '槽探', children : [{id : 630001, text : '槽探', leaf : true}]}]},{id : 700000, text : '岩矿试验', children : [{id : 710000, text : '岩矿分析', children : [{id : 710001, text : '一般岩矿分析', leaf : true},{id : 710002, text : '物相分析', leaf : true},{id : 710003, text : '单矿物分析', leaf : true},{id : 710004, text : '样品加工', leaf : true}]},{id : 720000, text : '化探分析', children : [{id : 720001, text : '化探样品综合分析', leaf : true},{id : 720002, text : '化探单项分析', leaf : true}]},{id : 730000, text : '土壤分析', children : [{id : 730001, text : '土壤化学性质及常量养分分析', leaf : true},{id : 730002, text : '土壤水溶性盐分析', leaf : true},{id : 730003, text : '土壤矿物质全量分析', leaf : true},{id : 730004, text : '土壤微量元素和重金属元素分析', leaf : true}]},{id : 740000, text : '水质分析', children : [{id : 740001, text : '水质综合分析', leaf : true},{id : 740002, text : '地下水污染有机组分分析', leaf : true},{id : 740003, text : '水质单项分析', leaf : true}]},{id : 750000, text : '光谱半定量分析', children : [{id : 750001, text : '光谱全分析', leaf : true},{id : 750002, text : '光谱水样全分析', leaf : true},{id : 750003, text : '光谱单矿物全分析', leaf : true}]},{id : 760000, text : '非金属矿物性测试', children : [{id : 760001, text : '非金属矿物物性测试', leaf : true}]},{id : 770000, text : '煤质分析', children : [{id : 770001, text : '煤质分析', leaf : true},{id : 770002, text : '煤灰成份分析', leaf : true}]},{id : 780000, text : '岩矿鉴定与试验', children : [{id : 781000, text : '岩矿鉴定及测试', children : [{id : 781001, text : '制片', leaf : true},{id : 781002, text : '岩矿鉴定', leaf : true},{id : 781003, text : '包体测温', leaf : true},{id : 781004, text : 'X射线衍射分析', leaf : true},{id : 781005, text : '电子探针', leaf : true},{id : 781006, text : '古生物鉴定', leaf : true},{id : 781007, text : '稳定同位素', leaf : true},{id : 781008, text : '年龄同位素', leaf : true},{id : 781009, text : '其他鉴定及测试', leaf : true}]},{id : 782000, text : '重砂分析', children : [{id : 782001, text : '重砂分析', leaf : true}]},{id : 783000, text : '岩石试验和土工试验', children : [{id : 783001, text : '岩石试验和土工试验', leaf : true}]}]},{id : 790000, text : '选冶试验', children : [{id : 790001, text : '实验室试验', leaf : true},{id : 790002, text : '中间试验', leaf : true}]}]},{id : 800000, text : '其他地质工作', children : [{id : 810000, text : '矿点检查', children : [{id : 810001, text : '矿点检查', leaf : true}]},{id : 820000, text : '地质勘查工作测量', children : [{id : 820001, text : '勘探基线测量', leaf : true},{id : 820002, text : '剖面线测量', leaf : true},{id : 820003, text : '工程点测量', leaf : true}]},{id : 830000, text : '地质编录', children : [{id : 830001, text : '钻探编录', leaf : true},{id : 830002, text : '坑探编录', leaf : true},{id : 830003, text : '槽探编录', leaf : true},{id : 830004, text : '浅井编录', leaf : true}]},{id : 840000, text : '采样', children : [{id : 840001, text : '刻槽样', leaf : true},{id : 840002, text : '岩心样', leaf : true}]},{id : 850000, text : '岩矿心保管', children : [{id : 850001, text : '岩矿心保管', leaf : true}]},{id : 860000, text : '报告编写', children : [{id : 860001, text : '设计论证报告', leaf : true},{id : 860002, text : '综合研究报告', leaf : true},{id : 860003, text : '项目成果报告', leaf : true}]},{id : 870000, text : '报告印刷', children : [{id : 870001, text : '报告印刷', leaf : true}]}]}]}";
function json_test(){
    return eval('('+arr+')');
}

function change(){
    //ExtTree1.getRootNode().appendChild({id:113,text:"xxxx",leaf:true});
    creator_pt_trees[0].obj.getRootNode().appendChild({id:113,text:"xxxx",leaf:true});

}

function change2(){
    tree.getRootNode().appendChild({id:113,text:"xxxx",leaf:true});
}

</script>

<!-- 提示：以下为页面DOM元素内容 -->
<DIV id=SKbillsheet style="visibility:hidden" jslib="fcbasecont.js&#13;&#10;selectdate.js&#13;&#10;~userfunc.js&#13;&#10;fcdate.js" creatorType="20100715141826312774" type="ZW" toolbar="不带工具栏" BLONopen="setAuthority();" contxml="<root><button><id>button1</id><id>button2</id></button><text><id>text1</id><id>text2</id></text><ExtTree><id>ExtTree1</id></ExtTree></root>" billtaborder="<root><taborder>button1</taborder><taborder>text1</taborder><taborder>text2</taborder><taborder>button2</taborder></root>" dj_sn="20100114063137300887" caption="测试ext树" mkbh codeheader="BBB" entertype="修改" poswidth posheight controlno="SKButton:0;SKDBedit:0;checkbox:0;label:0;radio:0;listbox:0;textarea:0;combobox:0;password:0;upload:0;SKDBtext:0;chart:0;dbimg:0;img:0;SKBILLgrid:0;shape:0;tab:0;div:0;DsMain_field:0;a:0;button:2;text:2;hr:0;checkboxlist:0;radiolist:0;dropdownlist:0;grid:0;dataset:0;spin:0;excel:0;tree:0;ebshow:0;creatorSubForm:0;creator_div:0;ExtGrid:0;ExtUpload:0;ExtTree:1;Fusionchar:0" window="当前窗口" posleft postop keyfield isfile="否" OtherSave="否" idtype="1" testDbName creatorStyle="creatorBlue" BLONclose="UnLoadWebOffice();" creator_remark hasWorkflowButton="否" creator_elementAuthoritySwitch="否" creator_showAlert="是" creator_office_isBindForm="否" islog="否" isprotect="是" creator_csslib version="1.0" creator_pagination>

&nbsp;

<DIV id=ExtTreeDiv_ExtTree1 style="BORDER-RIGHT: #c3daf9 1px solid; BORDER-TOP: #c3daf9 1px solid; LEFT: 0px; OVERFLOW: auto; BORDER-LEFT: #c3daf9 1px solid; BORDER-BOTTOM: #c3daf9 1px solid; POSITION: static; TOP: 0px"></DIV>

&nbsp;

<SCRIPT type=text/javascript>var tree,ExtTree1;Ext.onReady(function(){	Ext.BLANK_IMAGE_URL = '../../fceform/js/Ext/images/default/s.gif';    tree=ExtTree1 = new Ext.tree.TreePanel({		el:'ExtTreeDiv_ExtTree1',		title:'树',		frame:true,	height:386,	width:395,		autoScroll:'true',		loader:new Ext.tree.TreeLoader({			baseAttrs: { uiProvider: Ext.ux.TreeCheckNodeUI } 		}),		checkModel: 'multiple', 		onlyLeafCheckable : true,		tbar:[			new Ext.form.TextField({				emptyText:'输入后按回车',				allowBlank:true,				listeners:{					specialkey:function(field,e){						if (e.getKey()==Ext.EventObject.ENTER){							filterTree(e); 						}					}				}			})		]	});	var jsonObj = {text:"treeItem",qtip:"treeItem",id:"",children:[{text:"测试A",qtip:"A",id:"",leaf:true},{text:"测试B",qtip:"B",id:"",children:[{text:"开发A",qtip:"KA",id:"",leaf:true}]}]};	var root = new Ext.tree.AsyncTreeNode(jsonObj);	ExtTree1.setRootNode(root);/**
使用说明                      
1.注释不要用 //。
2.这里可以操作此控件的tree（Ext.tree.TreePanel）对象和root（Ext.tree.AsyncTreeNode）对象
3.这里的代码用于一些个性化的需求，如某列的某些特定工作。
**/
	ExtTree1.render();	root.expand();	var filter = new Ext.tree.TreeFilter(ExtTree1, {		clearBlank: true,		autoClear: true	});	function filterTree(e){		filterCondition = Ext.escapeRe(e.target.value);		ExtTree1.body.mask('加载中……','x-mask-loading');		var myroot = ExtTree1.root;		var i = myroot.childNodes.length-1;		for(; i>=0 ;i-- ){			myroot.removeChild(myroot.item(i));		}		var jsonFilterObj = jsonFilterResult();		if(jsonFilterObj.children.length>0){			myroot.appendChild(jsonFilterObj.children);		}		myroot.expand(false,true,function(){		ExtTree1.body.unmask();});	}	var filterCondition="";	function filterJSONLeafSon(source) {		var arrs = source.children;		for ( var i = arrs.length - 1; i >= 0; i--) {			var attri = arrs[i];			if ((typeof attri.leaf != 'undefined' && attri.text.indexOf(filterCondition) < 0)) {				arrs.splice(i, 1);			} else if (typeof attri.children != 'undefined'&& attri.children.length > 0) {				filterJSONLeafSon(attri);				if (attri.children.length <= 0) {					arrs.splice(i, 1);				}			}		}		return source;	}		function jsonFilterResult() {		var json =Ext.decode(Ext.encode(jsonObj));		if(filterCondition!=""){			json=filterJSONLeafSon(json);		}		return json;	}	Ext.QuickTips.init();if(Ext.isIE6){var nodes = null;ExtTree1.on('beforecollapsenode',function(node){nodes = ExtTree1.getChecked();});ExtTree1.on('expandnode',function(){if(nodes==null) return;for(var i=0;i<nodes.length;++i){if(nodes[i].isLeaf())nodes[i].getUI().toggleCheck(true);}});}if(typeof(creator_pt_trees)=='undefined'){creator_pt_trees=new Array();}creator_pt_trees.push({id:'ExtTree1',obj:ExtTree1});});</SCRIPT>

<BUTTON id=button1 style="LEFT: 0px; WIDTH: 75px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() controltype="button" dropstyle="否" onclick='bill_onclick("change()")'>button1</BUTTON>

<INPUT id=text1 style="LEFT: 0px; WIDTH: 110px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text">

<INPUT id=text2 style="LEFT: 0px; WIDTH: 110px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text">

<BUTTON id=button2 style="LEFT: 0px; WIDTH: 75px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() controltype="button" dropstyle="否" onclick='bill_onclick("change2()")'>button2</BUTTON>
</DIV>
<div id='grid_tip'></div></body></html>
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
if(!bDgMode) out.println("</script>");
%>

   <script >document.styleSheets[0].addRule("fc\\:webgrid","behavior: url(../../fceform/htc/webgrid.htc)",0);</script>
   <script >document.styleSheets[0].addRule("fc\\:fc_code","behavior: url(../../fceform/htc/fc_code.htc)",0);</script>
   <script >document.styleSheets[0].addRule("fc\\:dataset","behavior: url(../../fceform/htc/dataset.htc)",0);</script>
   <script language='javascript'>
adv_loadjsfile('/eformsys/fceform/css/tabstyle.css');
adv_loadjsfile('/eformsys/fceform/css/Button.css');
adv_loadjsfile('/eformsys/fceform/js/fcwebgrid.js');
adv_loadjsfile('/eformsys/fceform/js/fcdataset.js');
</script>


<!-- 提示：以下为页面自定义JS内容 -->
<script>
function aa(){
//alert(grid1.Col+" "+grid1.Row);
alert(dataset1.Fields.Field['rain_id'].Value);
//grid1.SetFocus(null,"");
 //alert(grid1.tab.rows(grid1.Row).cells(grid1.Col).innerText);
}

function test(){
//alert(GridColNoToFieldName(grid1,2));
//alert(grid1.curTD.innerText);
//alert(grid1.Col+" "+grid1.Row);
alert(grid1.tab.rows(grid1.Row).cells(grid1.Col).innerText);
}
</script>

<!-- 提示：以下为页面DOM元素内容 -->
<DIV id=SKbillsheet style="visibility:hidden" toolbar="不带工具栏" BLONopen="setAuthority();" contxml="<root><button><id>button1</id></button><grid><id>grid7</id><id>grid8</id></grid><dataset><id>dataset1</id><id>dataset3</id></dataset></root>" billtaborder="<root><taborder>button1</taborder><taborder>grid7</taborder><taborder>grid8</taborder></root>" dj_sn="20100825173913968325" caption="testtrid" mkbh codeheader="BBB" entertype="修改" poswidth posheight controlno="SKButton:0;SKDBedit:0;checkbox:0;label:0;radio:0;listbox:0;textarea:0;combobox:0;password:0;upload:0;SKDBtext:0;chart:0;dbimg:0;img:0;SKBILLgrid:0;shape:0;tab:2;div:0;DsMain_field:0;a:0;button:1;text:0;hr:0;checkboxlist:0;radiolist:0;dropdownlist:0;grid:8;dataset:3;spin:0;excel:0;tree:0;ebshow:0;creatorSubForm:0;creator_div:0;ExtGrid:0;ExtUpload:0;ExtTree:0;Fusionchar:0" window="当前窗口" posleft postop keyfield isfile="否" OtherSave="否" idtype="1" testDbName creatorStyle="creatorBlue" BLONclose="UnLoadWebOffice();" creator_remark hasWorkflowButton="否" creator_elementAuthoritySwitch="否" creator_showAlert="是" creator_office_isBindForm="否" islog="否" isprotect="是" creator_csslib version="1.0" creator_pagination="grid7,dataset1,;grid8,dataset3,;" type="ZW" creatorType="20090722200209296716" jslib="fcbasecont.js&#13;&#10;selectdate.js&#13;&#10;~userfunc.js&#13;&#10;fcdate.js" creator_allTab="<tabs><tab><id>tab2</id><content><index>0</index><gridid></gridid><iframeid></iframeid><index>1</index><gridid></gridid><iframeid></iframeid></content></tab></tabs>">

&nbsp;

<?xml:namespace prefix = fc />

<fc:dataset id=dataset1 format="<fields><field><fieldname>CITY_NAME</fieldname><datatype>字符</datatype><displaylabel>CITY_NAME</displaylabel><size>20</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>CITY_RAIN</fieldname><datatype>字符</datatype><displaylabel>CITY_RAIN</displaylabel><size>20</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>RAIN_MONTH</fieldname><datatype>字符</datatype><displaylabel>RAIN_MONTH</displaylabel><size>20</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>RAIN_ID</fieldname><datatype>字符</datatype><displaylabel>RAIN_ID</displaylabel><size>20</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>否</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>a</fieldname><datatype>字符</datatype><displaylabel>新建字段</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>是</link><target>_self</target><href>javascript:aa()</href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field></fields>" sqltrans="%F4%D8%E6%D8%D4%F6Xrn%94%A0%B6%C0%CC%AA%90%A8%98Xr%94%B2%90%A0%AA%CC%A0%96Xr%94%94%A0%B6%C0%CC%B2%90%A0%AAXr%94%B2%90%A0%AA%CC%A8%AC%AA%B6%9EXr%94Xr%7CX%F8v%9A%98%98X%F8zxt%80Xr%7CXrn%D0%F4Xrn%D0Xrn%DA%F2%EC%E8Xrn%B6%90%CC%B2%90%A0%AA%9A%90%A6%A6" onSetText='bill_ondatasetsettext("<dsid><CITY_NAME></CITY_NAME><CITY_RAIN></CITY_RAIN><RAIN_MONTH></RAIN_MONTH><RAIN_ID></RAIN_ID><a></a></dsid>")' onGetText='bill_ondatasetgettext("<dsid><CITY_NAME></CITY_NAME><CITY_RAIN></CITY_RAIN><RAIN_MONTH></RAIN_MONTH><RAIN_ID></RAIN_ID><a></a></dsid>")' onValid='bill_ondatasetvalid("<dsid><CITY_NAME></CITY_NAME><CITY_RAIN></CITY_RAIN><RAIN_MONTH></RAIN_MONTH><RAIN_ID></RAIN_ID><a></a></dsid>")' opensortno="1" temptable="TMP_DATASET1" multiResult="否"></fc:dataset>

<BUTTON id=button1 style="LEFT: 213px; WIDTH: 75px; POSITION: absolute; TOP: 284px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("test()")'>button1</BUTTON>

<TABLE style="POSITION: static" cellSpacing=2 cellPadding=1 width=100 align=left border=1>
   <TBODY>
      <TR>
         <TD><fc:webgrid id=grid7 onkeydown='bill_ongridkeydown("<grid7><col></col><col></col><col></col><col></col></grid7>")' ondblclick='bill_ongriddblclick("<grid7><col></col><col></col><col></col><col></col></grid7>")' onclick='bill_ongridclick("<grid7><col></col><col></col><col></col><col></col></grid7>")' top="0" width="288%" height="123" format="<cols><col><fname>CITY_NAME</fname><cname>CITY_NAME</cname><width>20</width><dtype>字符</dtype><readonly>否</readonly><visible>是</visible><u></u><v></v><s></s><r></r><columnwidth>80</columnwidth><align>left</align></col><col><fname>CITY_RAIN</fname><cname>CITY_RAIN</cname><width>20</width><dtype>字符</dtype><readonly>否</readonly><visible>是</visible><u></u><v></v><s></s><r></r><columnwidth>80</columnwidth><align>left</align></col><col><fname>RAIN_MONTH</fname><cname>RAIN_MONTH</cname><width>20</width><dtype>字符</dtype><readonly>否</readonly><visible>是</visible><u></u><v></v><s></s><r></r><columnwidth>80</columnwidth><align>left</align></col><col><fname>a</fname><cname>新建字段</cname><width>10</width><dtype>字符</dtype><readonly>是</readonly><visible>是</visible><u></u><v></v><s></s><r></r><columnwidth>80</columnwidth><align>left</align></col></cols>" dataset="dataset1" visible="是" canselect="是" autoheight="否" autowidth="否" autoappend="否" readonly="否" SetRowHeight="是" hideVscroll="是" hideHscroll="是" autosize="是" bodyrowheight="-1" bodyrows="-1" left="0">
               <TABLE id=t style="TABLE-LAYOUT: fixed; LEFT: 0px; POSITION: absolute; TOP: 0px; BORDER-COLLAPSE: collapse" cellSpacing=0 cellPadding=1 width="100%" frame=box>
                  <TBODY>
                     <TR class=fcGridFirstRow>
                        <TD></TD>
                     </TR>
                  </TBODY>
               </TABLE>
            </fc:webgrid>
         </TD>
         <TD></TD>
      </TR>
      <TR>
         <TD></TD>
         <TD></TD>
      </TR>
   </TBODY>
</TABLE>

<TABLE style="POSITION: static" cellSpacing=2 cellPadding=1 width=100 align=left border=1>
   <TBODY>
      <TR>
         <TD><fc:webgrid id=grid8 onkeydown='bill_ongridkeydown("<grid8><col></col><col></col><col></col><col></col><col></col></grid8>")' ondblclick='bill_ongriddblclick("<grid8><col></col><col></col><col></col><col></col><col></col></grid8>")' onclick='bill_ongridclick("<grid8><col></col><col></col><col></col><col></col><col></col></grid8>")' top="0" width="300px" height="123" format="<cols><col><fname>CITY_NAME</fname><cname>CITY_NAME</cname><width>20</width><dtype>字符</dtype><readonly>否</readonly><visible>是</visible><u></u><v></v><s></s><r></r><columnwidth>80</columnwidth><align>left</align></col><col><fname>CITY_RAIN</fname><cname>CITY_RAIN</cname><width>20</width><dtype>字符</dtype><readonly>否</readonly><visible>是</visible><u></u><v></v><s></s><r></r><columnwidth>80</columnwidth><align>left</align></col><col><fname>RAIN_ID</fname><cname>RAIN_ID</cname><width>20</width><dtype>字符</dtype><readonly>否</readonly><visible>是</visible><u></u><v></v><s></s><r></r><columnwidth>80</columnwidth><align>left</align></col><col><fname>RAIN_MONTH</fname><cname>RAIN_MONTH</cname><width>20</width><dtype>字符</dtype><readonly>否</readonly><visible>是</visible><u></u><v></v><s></s><r></r><columnwidth>80</columnwidth><align>left</align></col><col><fname>a</fname><cname>新建字段</cname><width>10</width><dtype>字符</dtype><readonly>否</readonly><visible>是</visible><u></u><v></v><s></s><r></r><columnwidth>80</columnwidth><align>left</align></col></cols>" dataset="dataset3" visible="是" canselect="是" autoheight="否" autowidth="否" autoappend="否" readonly="否" SetRowHeight="是" hideVscroll="是" hideHscroll="是" autosize="是" bodyrowheight="-1" bodyrows="-1" left="0">
               <TABLE id=t style="TABLE-LAYOUT: fixed; LEFT: 0px; POSITION: absolute; TOP: 0px; BORDER-COLLAPSE: collapse" cellSpacing=0 cellPadding=1 width="100%" frame=box>
                  <TBODY>
                     <TR class=fcGridFirstRow>
                        <TD></TD>
                     </TR>
                  </TBODY>
               </TABLE>
            </fc:webgrid>
         </TD>
         <TD></TD>
      </TR>
      <TR>
         <TD></TD>
         <TD></TD>
      </TR>
   </TBODY>
</TABLE>

<fc:dataset id=dataset3 format="<fields><field><fieldname>CITY_NAME</fieldname><datatype>字符</datatype><displaylabel>CITY_NAME</displaylabel><size>20</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>CITY_RAIN</fieldname><datatype>字符</datatype><displaylabel>CITY_RAIN</displaylabel><size>20</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>RAIN_ID</fieldname><datatype>字符</datatype><displaylabel>RAIN_ID</displaylabel><size>20</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>RAIN_MONTH</fieldname><datatype>字符</datatype><displaylabel>RAIN_MONTH</displaylabel><size>20</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>a</fieldname><datatype>字符</datatype><displaylabel>新建字段</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field></fields>" sqltrans="%F4%D8%E6%D8%D4%F6Xrn%94%A0%B6%C0%CC%AA%90%A8%98Xr%94%B2%90%A0%AA%CC%A0%96Xr%94%94%A0%B6%C0%CC%B2%90%A0%AAXr%94%B2%90%A0%AA%CC%A8%AC%AA%B6%9EXr%94Xr%7CX%F8v%9A%98%98X%F8zxt%80Xr%7CXrn%D0%F4Xrn%D0Xrn%DA%F2%EC%E8Xrn%B6%90%CC%B2%90%A0%AA%9A%90%A6%A6" onSetText='bill_ondatasetsettext("<dsid><CITY_NAME></CITY_NAME><CITY_RAIN></CITY_RAIN><RAIN_ID></RAIN_ID><RAIN_MONTH></RAIN_MONTH><a></a></dsid>")' onGetText='bill_ondatasetgettext("<dsid><CITY_NAME></CITY_NAME><CITY_RAIN></CITY_RAIN><RAIN_ID></RAIN_ID><RAIN_MONTH></RAIN_MONTH><a></a></dsid>")' onValid='bill_ondatasetvalid("<dsid><CITY_NAME></CITY_NAME><CITY_RAIN></CITY_RAIN><RAIN_ID></RAIN_ID><RAIN_MONTH></RAIN_MONTH><a></a></dsid>")' opensortno="1" temptable="TMP_DATASET3" multiResult="否"></fc:dataset>
</DIV>
<div id='grid_tip'></div></body></html>
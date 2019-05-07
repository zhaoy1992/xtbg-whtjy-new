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

   <script language='javascript'>
adv_loadjsfile('/eformsys/fceform/css/tabstyle.css');
adv_loadjsfile('/eformsys/fceform/js/webfxlayout.js');
adv_loadjsfile('/eformsys/fceform/css/luna/tab.css');
adv_loadjsfile('/eformsys/fceform/css/Button.css');
</script>


<!-- 提示：以下为页面自定义JS内容 -->
<script>
function test(){
    //var sql = "<no>insert into app_1.ta_dms_document (docid, title, content, createuserid, createdate, publishuserid, publishdate, audityuserid, auditydate, lockuserid, lockdate, lastmodified, version, filetype, filename, filesize, folderid, templateid, useflow, statusid, des, cc_form_instanceid, doctype, versiondocid, updateid, updatename, updatetime, isback) select '1485',title, content, createuserid, createdate, publishuserid, publishdate, audityuserid, auditydate, lockuserid, lockdate, lastmodified, version, filetype, filename, filesize, folderid, templateid, useflow, statusid, des, cc_form_instanceid, doctype, versiondocid, updateid, updatename, updatetime,'1' from app_1.ta_dms_document t where t.docid='1451'</no><no>insert into app_1.fc_attach(extend,djbh,dj_sn,filename,attachid,bz,djsn,attachcontent,filepos) select f.extend,'1485',f.dj_sn,f.filename, f.attachid, f.bz, f.dj_sn, f.attachcontent, f.filepos from app_1.fc_attach f   where f.djbh='1451' and f.djsn='20100721100405609573'</no><no>insert into app_1.fc_attacheref(refid, ref_ctrl_insid, note, addtime, ref_attache_id, ref_type, djbh) select 'new'||app_1.SEQ_UPLOAD_INS.nextval, f1.ref_ctrl_insid, f1.note, f1.addtime, f1.ref_attache_id, f1.ref_type, '1485' from app_1.fc_attacheref f1  where djbh='1451'</no><no>insert into app_1.td_octl_document(documentid,recordid, subject, author, filedate, filetype, htmlpath, status, djid) select '35','w1485',s.subject,s.author,s.filedate,s.filetype,s.htmlpath,s.status,s.djid from app_1.td_octl_document s where s.recordid='w1451'</no><no>insert into app_1.td_octl_document_file(fileid,recordid, filename, filetype, filesize, filedate,filebody, filepath, username, descript) select '35','w1485','w1485.doc', s.filetype, s.filesize, s.filedate, s.filebody, s.filepath, s.username, s.descript from app_1.td_octl_document_file s where recordid='w1451'</no>";
    //alert(sql);
    //alert(InsertSqls(sql));
    //var sql = "select BB from ta_test where BB='BBB00004224'";
    //dataset1.Open(sql);
    text1.style.display="none"
    alert(text1.value);
}

</script>

<!-- 提示：以下为页面DOM元素内容 -->
<DIV id=SKbillsheet style="visibility:hidden" toolbar="不带工具栏" BLONopen="setAuthority();" contxml="<root><radio><id>radio1</id><id>radio2</id></radio><combobox><id>combobox5</id><id>combobox6</id></combobox><tab><id>tab1</id></tab><button><id>button1</id><id>button2</id><id>button3</id><id>button4</id><id>button5</id></button></root>" billtaborder="<root><taborder>button1</taborder><taborder>button2</taborder><taborder>button3</taborder><taborder>radio1</taborder><taborder>radio2</taborder><taborder>button4</taborder><taborder>combobox5</taborder><taborder>combobox6</taborder><taborder>button5</taborder></root>" dj_sn="20100714153436015181" caption="数据源测试" mkbh codeheader="BBB" entertype="修改" poswidth posheight controlno="SKButton:0;SKDBedit:0;checkbox:1;label:0;radio:2;listbox:0;textarea:0;combobox:6;password:0;upload:0;SKDBtext:0;chart:0;dbimg:0;img:0;SKBILLgrid:0;shape:0;tab:1;div:0;DsMain_field:0;a:0;button:5;text:1;hr:0;checkboxlist:0;radiolist:0;dropdownlist:2;grid:0;dataset:1;spin:0;excel:0;tree:0;ebshow:0;creatorSubForm:0;creator_div:0;ExtGrid:0;ExtUpload:0;ExtTree:0;Fusionchar:0" window="当前窗口" posleft postop keyfield isfile="否" OtherSave="否" idtype="1" testDbName="bspf" creatorStyle="creatorBlue" BLONclose="UnLoadWebOffice();" creator_remark hasWorkflowButton="否" creator_elementAuthoritySwitch="否" creator_showAlert="是" creator_office_isBindForm="否" islog="否" isprotect="是" creator_csslib version="1.0" creator_pagination type="ZW" creatorType="20100607093706211537" jslib="fcbasecont.js&#13;&#10;selectdate.js&#13;&#10;~userfunc.js&#13;&#10;fcdate.js" creator_allTab="<tabs><tab><id>tab1</id><content><index>0</index><gridid></gridid><iframeid></iframeid><index>1</index><gridid></gridid><iframeid></iframeid></content></tab></tabs>">

<BUTTON id=button1 style="LEFT: 0px; WIDTH: 75px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("test()")'>button1</BUTTON>

<BUTTON id=button2 style="LEFT: 80px; WIDTH: 75px; POSITION: absolute; TOP: 1px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="·ń" controltype="button">button2</BUTTON>

<BUTTON id=button3 style="LEFT: 162px; WIDTH: 75px; POSITION: absolute; TOP: 1px; HEIGHT: 25px" onmovestart=moveStart() controltype="button">button3</BUTTON>

<FIELDSET id=radio1 contentEditable=false style="LEFT: 12px; WIDTH: 152px; COLOR: #000000; POSITION: absolute; TOP: 40px; HEIGHT: 96px" onmovestart=moveStart() controltype="radio" field="" dataset="" value="-1">
   <LEGEND>单选表</LEGEND>
</FIELDSET>

<FIELDSET id=radio2 contentEditable=false style="LEFT: 177px; WIDTH: 152px; COLOR: #000000; POSITION: absolute; TOP: 40px; HEIGHT: 96px" onmovestart=moveStart() controltype="radio" field="" dataset="" value="-1">
   <LEGEND>单选表</LEGEND>
</FIELDSET>

<BUTTON id=button4 style="LEFT: 352px; WIDTH: 75px; POSITION: absolute; TOP: 49px; HEIGHT: 25px" onmovestart=moveStart() controltype="button">button4</BUTTON>

<SELECT id=combobox5 style="LEFT: 351px; WIDTH: 120px; POSITION: absolute; TOP: 80px; HEIGHT: 25px" onmovestart=moveStart() sqltrans controltype="combobox" sql></SELECT>

<SELECT id=combobox6 style="LEFT: 357px; WIDTH: 120px; POSITION: absolute; TOP: 116px; HEIGHT: 25px" onmovestart=moveStart() sqltrans controltype="combobox" sql></SELECT>

<DIV class=tab-pane id=tab1 style="LEFT: 211px; WIDTH: 402px; POSITION: absolute; TOP: 195px; HEIGHT: 320px" showtype="luna" IsHideTitle="否">
   <DIV class=tab-page style="WIDTH: 402px; HEIGHT: 302px">
      <H2 class=tab>页签1</H2>
   </DIV>
   <DIV class=tab-page style="WIDTH: 402px; HEIGHT: 302px">
      <H2 class=tab>页签2</H2>
   </DIV>
</DIV>

<SCRIPT>var tab1 = new WebFXTabPane( document.getElementById( "tab1" ) );</SCRIPT>

<BUTTON id=button5 style="LEFT: 116px; WIDTH: 75px; POSITION: absolute; TOP: 178px; HEIGHT: 25px" onmovestart=moveStart() controltype="button">button5</BUTTON>
</DIV>
<div id='grid_tip'></div></body></html>
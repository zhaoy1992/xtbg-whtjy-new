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
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/fcopendj.js');");
if(bDgMode) out.println("<script src='../../fceform/js/fcopendj.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/fcsavedj.js');");
if(bDgMode) out.println("<script defer src='../../fceform/js/fcsavedj.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/fcselfuse.js');");
if(bDgMode) out.println("<script src='../../fceform/js/fcselfuse.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/fcbasecont.js');");
if(bDgMode) out.println("<script src='../../fceform/js/fcbasecont.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/fcother.js');");
if(bDgMode) out.println("<script defer src='../../fceform/js/fcother.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/selectdate.js');");
if(bDgMode) out.println("<script defer src='../../fceform/js/selectdate.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/../fceformext/js/userfunc.js');");
if(bDgMode) out.println("<script src='../../fceform/../fceformext/js/userfunc.js'></script>");
if(!bDgMode) out.println("</script>");
%>

   <script >document.styleSheets[0].addRule("fc\\:dataset","behavior: url(../../fceform/htc/dataset.htc)",0);</script>
   <script language='javascript'>
adv_loadjsfile('/eformsys/fceform/css/tabstyle.css');
adv_loadjsfile('/eformsys/fceform/css/Button.css');
adv_loadjsfile('/eformsys/fceform/css/TextStyle.css');
adv_loadjsfile('/eformsys/fceform/js/fcdataset.js');
</script>


<!-- ��ʾ������Ϊҳ���Զ���JS���� -->
<script></script>

<!-- ��ʾ������Ϊҳ��DOMԪ������ -->
<DIV id=SKbillsheet style="visibility:hidden" toolbar="����������" BLONopen="setAuthority();" contxml="<root><label><id>cc_label_REMARK</id><id>cc_label_SCORE</id><id>cc_label_XB</id><id>cc_label_XM</id><id>cc_label_STU_ID</id></label><div><id>div1</id></div><button><id>creator_button2</id><id>creator_button1</id></button><text><id>cc_text_REMARK</id><id>cc_text_SCORE</id><id>cc_text_XB</id><id>cc_text_XM</id><id>cc_text_STU_ID</id></text><dataset><id>dataset1</id></dataset></root>" billtaborder="<root><taborder>creator_button2</taborder><taborder>creator_button1</taborder><taborder>cc_text_REMARK</taborder><taborder>cc_text_SCORE</taborder><taborder>cc_text_XB</taborder><taborder>cc_text_XM</taborder><taborder>cc_text_STU_ID</taborder></root>" dj_sn="20100127084433926207" caption="�Զ�������ϸҳ��" mkbh codeheader="BBB" entertype="�޸�" poswidth posheight controlno="SKButton:0;SKDBedit:0;checkbox:0;label:0;radio:0;listbox:0;textarea:1;combobox:0;password:0;upload:0;SKDBtext:0;chart:0;dbimg:0;img:0;SKBILLgrid:0;shape:0;tab:0;div:1;DsMain_field:0;a:0;button:5;text:4;hr:0;checkboxlist:0;radiolist:0;dropdownlist:0;grid:0;dataset:0;spin:0;excel:0;tree:0;ebshow:0;creatorSubForm:0;creator_div:0;ExtGrid:0;ExtUpload:0;ExtTree:0;Fusionchar:0" window="��ǰ����" posleft postop keyfield isfile="��" OtherSave="��" idtype="1" BLONclose="UnLoadWebOffice();" creator_remark hasWorkflowButton="��" creator_elementAuthoritySwitch="��" creator_showAlert="��" creator_office_isBindForm="��" islog="��" isprotect="��" version="1.0" creator_pagination type="ZW" creatorType="20091219104852735215" jslib="fcopendj.js&#13;&#10;fcsavedj.js&#13;&#10;fcselfuse.js&#13;&#10;fcbasecont.js&#13;&#10;fcother.js&#13;&#10;selectdate.js&#13;&#10;~userfunc.js">

<DIV id=div1 style="BORDER-RIGHT: 0px; PADDING-RIGHT: 10px; BORDER-TOP: 0px; OVERFLOW-Y: hidden; PADDING-LEFT: 10px; LEFT: 141px; OVERFLOW-X: hidden; PADDING-BOTTOM: 10px; OVERFLOW: auto; BORDER-LEFT: 0px; WIDTH: 700px; PADDING-TOP: 10px; BORDER-BOTTOM: 0px; POSITION: absolute; TOP: 145px; HEIGHT: 191px; BACKGROUND-COLOR: #ebeae8" onmovestart=moveStart() controltype="div" NotBg="��">
   <TABLE width="100%">
      <CAPTION>�Զ�������ϸҳ��</CAPTION>
      <TBODY>
         <TR>
            <TD><DIV id=cc_label_REMARK style="LEFT: 32px; WIDTH: 65px; POSITION: static; TOP: 49px; HEIGHT: 15px" onmovestart=moveStart() noWrap controltype="label" NotBg="��" value="label1">REMARK</DIV></TD>
            <TD><INPUT id=cc_text_REMARK style="LEFT: 0px; WIDTH: 150px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="REMARK" china="REMARK" dataset="dataset1"></TD>
            <TD><DIV id=cc_label_SCORE style="LEFT: 32px; WIDTH: 65px; POSITION: static; TOP: 49px; HEIGHT: 15px" onmovestart=moveStart() noWrap controltype="label" NotBg="��" value="label1">SCORE</DIV></TD>
            <TD><INPUT id=cc_text_SCORE style="LEFT: 0px; WIDTH: 150px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="SCORE" china="SCORE" dataset="dataset1"></TD>
         </TR>
         <TR>
            <TD><DIV id=cc_label_XB style="LEFT: 32px; WIDTH: 65px; POSITION: static; TOP: 49px; HEIGHT: 15px" onmovestart=moveStart() noWrap controltype="label" NotBg="��" value="label1">XB</DIV></TD>
            <TD><INPUT id=cc_text_XB style="LEFT: 0px; WIDTH: 150px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="XB" china="XB" dataset="dataset1"></TD>
            <TD><DIV id=cc_label_XM style="LEFT: 32px; WIDTH: 65px; POSITION: static; TOP: 49px; HEIGHT: 15px" onmovestart=moveStart() noWrap controltype="label" NotBg="��" value="label1">XM</DIV></TD>
            <TD><INPUT id=cc_text_XM style="LEFT: 0px; WIDTH: 150px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="XM" china="XM" dataset="dataset1"></TD>
         </TR>
         <TR>
            <TD><DIV id=cc_label_STU_ID style="LEFT: 32px; WIDTH: 65px; POSITION: static; TOP: 49px; HEIGHT: 15px" onmovestart=moveStart() noWrap controltype="label" NotBg="��" value="label1">STU_ID</DIV></TD>
            <TD><INPUT id=cc_text_STU_ID style="LEFT: 0px; WIDTH: 150px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="STU_ID" china="STU_ID" dataset="dataset1"></TD>
            <TD></TD>
            <TD></TD>
         </TR>
      </TBODY>
   </TABLE>
   <BUTTON class=button id=creator_button2 style="LEFT: 290px; POSITION: absolute; TOP: 135px" onmovestart=moveStart() dropstyle="��" controltype="button" onclick='bill_onclick("DjSaveShow();CloseBill();")'>����</BUTTON>
   <BUTTON class=button id=creator_button1 style="LEFT: 340px; POSITION: absolute; TOP: 135px" onmovestart=moveStart() dropstyle="��" controltype="button" onclick='bill_onclick("CloseBill()")'>�ر�</BUTTON>
</DIV>

<?xml:namespace prefix = fc />

<fc:dataset id=dataset1 format="<fields><field><fieldname>REMARK</fieldname><datatype>�ַ�</datatype><displaylabel>REMARK</displaylabel><size>200</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>SCORE</fieldname><datatype>�ַ�</datatype><displaylabel>SCORE</displaylabel><size>22</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>STU_ID</fieldname><datatype>�ַ�</datatype><displaylabel>STU_ID</displaylabel><size>20</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>XB</fieldname><datatype>�ַ�</datatype><displaylabel>XB</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>XM</fieldname><datatype>�ַ�</datatype><displaylabel>XM</displaylabel><size>30</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field></fields>" sqltrans="%F4%D8%E6%D8%D4%F6XrnbXrn%DA%F2%EC%E8Xrn%F6%D0%CC%D6%F8%D0%EAXrn%FC%DE%D8%F2%D8Xrn%B4%B6%B8%CC%A0%96Xrn%E6%E0%E4%D8XrnXt%90%EE%F8%D2%96%D0%F6%D0%B4%D8%F6j%B4%B6%B8%CC%A0%96" onSetText='bill_ondatasetsettext("<dsid><REMARK></REMARK><SCORE></SCORE><STU_ID></STU_ID><XB></XB><XM></XM></dsid>")' onGetText='bill_ondatasetgettext("<dsid><REMARK></REMARK><SCORE></SCORE><STU_ID></STU_ID><XB></XB><XM></XM></dsid>")' onValid='bill_ondatasetvalid("<dsid><REMARK></REMARK><SCORE></SCORE><STU_ID></STU_ID><XB></XB><XM></XM></dsid>")' opensortno="1" temptable="TMP_DATASET1" multiResult="��"></fc:dataset>
</DIV>
<div id='grid_tip'></div></body></html>
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

   <script >document.styleSheets[0].addRule(".fcmask","behavior: url(../../fceform/htc/fcmask.htc)",0);</script>
   <script >document.styleSheets[0].addRule("fc\\:fc_code","behavior: url(../../fceform/htc/fc_code.htc)",0);</script>
   <script >document.styleSheets[0].addRule("fc\\:dataset","behavior: url(../../fceform/htc/dataset.htc)",0);</script>
   <script language='javascript'>
adv_loadjsfile('/eformsys/fceform/css/tabstyle.css');
adv_loadjsfile('/eformsys/fceform/js/fcmask.vbs');
adv_loadjsfile('/eformsys/fceform/css/Button.css');
adv_loadjsfile('/eformsys/fceform/css/TextStyle.css');
adv_loadjsfile('/eformsys/fceform/js/fcdataset.js');
</script>


<!-- ��ʾ������Ϊҳ���Զ���JS���� -->
<script></script>

<!-- ��ʾ������Ϊҳ��DOMԪ������ -->
<DIV id=SKbillsheet style="visibility:hidden" toolbar="����������" BLONopen="setAuthority();" contxml="<root><textarea><id>version_log</id></textarea><button><id>bc</id></button><text><id>version_id</id><id>version_name</id><id>version_from</id></text><dropdownlist><id>version_module</id></dropdownlist><dataset><id>dataset3</id></dataset></root>" billtaborder="<root><taborder>bc</taborder><taborder>version_id</taborder><taborder>version_name</taborder><taborder>version_from</taborder><taborder>version_module</taborder><taborder>version_log</taborder></root>" dj_sn="20091129112128926441" caption="ƽ̨�汾ά��" mkbh codeheader="BBB" entertype="�޸�" poswidth posheight controlno="SKButton:0;SKDBedit:0;checkbox:0;label:0;radio:0;listbox:0;textarea:1;combobox:0;password:0;upload:0;SKDBtext:0;chart:0;dbimg:0;img:0;SKBILLgrid:0;shape:0;tab:0;div:0;DsMain_field:0;a:0;button:0;text:0;hr:0;checkboxlist:0;radiolist:0;dropdownlist:0;grid:0;dataset:0;spin:0;excel:0;tree:0;ebshow:0;creatorSubForm:0;creator_div:0;ExtGrid:0;ExtUpload:0;ExtTree:0;Fusionchar:0" window="��ǰ����" posleft postop keyfield isfile="��" OtherSave="��" idtype="1" testDbName creatorStyle="creatorBlue" BLONclose="UnLoadWebOffice();" creator_remark hasWorkflowButton="��" creator_elementAuthoritySwitch="��" creator_showAlert="��" creator_office_isBindForm="��" islog="��" isprotect="��" creator_csslib version="1.0" creator_pagination type="ZW" creatorType="20100715141826312774" jslib="fcbasecont.js&#13;&#10;selectdate.js&#13;&#10;~userfunc.js&#13;&#10;fcdate.js">

<TABLE style="WIDTH: 553px; POSITION: static; HEIGHT: 337px" cellSpacing=2 cellPadding=1 width=553 align=left border=1>
   <TBODY>
      <TR>
         <TD>������ţ�</TD>
         <TD><INPUT id=version_id style="LEFT: 0px; WIDTH: 332px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() size=58 controltype="text" field="VERSION_ID" china="VERSION_ID" dataset="dataset3"></TD>
      </TR>
      <TR>
         <TD>�������ƣ�</TD>
         <TD><INPUT id=version_name style="LEFT: 0px; WIDTH: 332px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() size=58 controltype="text" field="VERSION_NAME" china="VERSION_NAME" dataset="dataset3"></TD>
      </TR>
      <TR>
         <TD>����������</TD>
         <TD><INPUT id=version_from style="LEFT: 0px; WIDTH: 333px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() size=58 controltype="text" field="VERSION_FROM" china="VERSION_FROM" dataset="dataset3"></TD>
      </TR>
      <TR>
         <TD>�������ࣺ</TD>
         <TD><?xml:namespace prefix = fc /><fc:fc_code id=version_module top="0" width="231px" height="0" align="" format="" sqltrans="" field="VERSION_MODULE" dataset="dataset3" blninput="��" blnempty="��" addrow="��" multiselect="��" xml="<tr height='16px' ><td>����ƽ̨</td><td>sysmanager</td></tr><tr height='16px' ><td>�����</td><td>eform</td></tr><tr height='16px' ><td>�������</td><td>report</td></tr><tr height='16px' ><td>���������</td><td>workflow</td></tr><tr height='16px' ><td>��Ϣ���</td><td>message</td></tr><tr height='16px' ><td>ȫ�ļ������</td><td>search</td></tr><tr height='16px' ><td>���ϲ�����</td><td>list</td></tr><tr height='16px' ><td>����</td><td>other</td></tr>" visible="��" left="0" sql2="" fontweight="" color="" backgroundcolor="" fontfamily="" fontstyle="" fontsize="" position="static" enabled="false"></fc:fc_code></TD>
      </TR>
      <TR>
         <TD>����˵����</TD>
         <TD>&nbsp;<TEXTAREA id=version_log style="LEFT: 0px; WIDTH: 364px; POSITION: static; TOP: 0px; HEIGHT: 85px" onmovestart=moveStart() cols=72 controltype="textarea" field="VERSION_LOG" china="VERSION_LOG" dataset="dataset3" value="textarea1" induce="��"></TEXTAREA></TD>
      </TR>
      <TR>
         <TD></TD>
         <TD><BUTTON id=bc style="LEFT: 0px; WIDTH: 75px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="��" controltype="button" onclick='bill_onclick("DjSaveShow()")'>�ύ����</BUTTON></TD>
      </TR>
   </TBODY>
</TABLE>

<fc:dataset id=dataset3 format="<fields><field><fieldname>VERSION_FROM</fieldname><datatype>�ַ�</datatype><displaylabel>VERSION_FROM</displaylabel><size>100</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>VERSION_ID</fieldname><datatype>�ַ�</datatype><displaylabel>VERSION_ID</displaylabel><size>20</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>VERSION_LOG</fieldname><datatype>�ַ�</datatype><displaylabel>VERSION_LOG</displaylabel><size>2000</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>VERSION_MODULE</fieldname><datatype>�ַ�</datatype><displaylabel>VERSION_MODULE</displaylabel><size>20</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>VERSION_NAME</fieldname><datatype>�ַ�</datatype><displaylabel>VERSION_NAME</displaylabel><size>50</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field></fields>" onSetText='bill_ondatasetsettext("<dsid><VERSION_FROM></VERSION_FROM><VERSION_ID></VERSION_ID><VERSION_LOG></VERSION_LOG><VERSION_MODULE></VERSION_MODULE><VERSION_NAME></VERSION_NAME></dsid>")' onGetText='bill_ondatasetgettext("<dsid><VERSION_FROM></VERSION_FROM><VERSION_ID></VERSION_ID><VERSION_LOG></VERSION_LOG><VERSION_MODULE></VERSION_MODULE><VERSION_NAME></VERSION_NAME></dsid>")' onValid='bill_ondatasetvalid("<dsid><VERSION_FROM></VERSION_FROM><VERSION_ID></VERSION_ID><VERSION_LOG></VERSION_LOG><VERSION_MODULE></VERSION_MODULE><VERSION_NAME></VERSION_NAME></dsid>")' opensortno="1" temptable="TMP_DATASET3" saveastable="TA_VERSIONLIST" multiResult="��"></fc:dataset>
</DIV>
<div id='grid_tip'></div></body></html>
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
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/common/Namespace.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/common/Namespace.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/common/nsreg.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/common/nsreg.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/business/DataManager.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/business/DataManager.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/dao/DataManagerDao.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/dao/DataManagerDao.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/util/DBUtil.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/util/DBUtil.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/vo/vo.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/vo/vo.js'></script>");
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
<script>
var userId=creator_getQueryString("user_id");

function init(){
  initBtn();
}

function initBtn(){
    //alert(userId);
    if(IsSpace(userId)){
      $("btnUp").style.display = "none";
      $("btnNext").style.display = "none";
      $("btnSave").style.display = "none";
      $("btnDel").style.display = "none";
    }else{
      $("USER_ID").value = userId;
      $("saveAndClose").style.display = "none";
      $("saveAndAdd").style.display = "none";
      var sql = DataManager.initUpdateDateManager(userId);
      dataManagerdataset.Open(sql);
      initUporNextBtn();
    }
}

function initUporNextBtn(){
    var recodeArr = DataManager.initUporNext($("USER_ID").value);
    if(recodeArr[0][0]=='0'){
        $("btnUp").disabled=true;   
    }else{
        $("btnUp").disabled=false;
    }
    if(recodeArr[0][1]=='0'){
        $("btnNext").disabled=true;
    }else{
        $("btnNext").disabled=false;
    }
}
function saveDateManager(state){
    var rv = DataManager.saveDateManager(DBUtil.getVoFromPage(new xzcf.vo.User()));
    if(IsSpace(rv)){
        alert("����������Ϣ�ɹ���");
    }else{
        alert("����������Ϣʧ�ܣ�");
    }
    
    if(state=='addClose'){
      windowClose();
    }else if(state=='Add'){
      $('USER_NAME').value = "";
      $('USER_REALNAME').value = "";
      $('USER_SEX').value = "��";
      $('USER_WORKTEL').value = "";
      $('USER_ID').value = "";
    }else{
    
    }
}

function UpOrNext(state){
  var recodeArr = DataManager.initUporNext($("USER_ID").value);
  var upOrNextId= "0";
  if(state=='btnUp'){
    upOrNextId = recodeArr[0][0];
  }else{
    upOrNextId = recodeArr[0][1];
  }
  
  var sql = DataManager.initUpdateDateManager(upOrNextId);
  dataManagerdataset.Open(sql);
  
  initUporNextBtn();
}

function windowClose(){
  window.close();
}

function delDataManager(){
    var userId = $("USER_ID").value
    var recodeArr = DataManager.initUporNext($("USER_ID").value);
    var upId = recodeArr[0][0];
    var nextId = recodeArr[0][1];
    var rv = DataManager.delOneDataManager(userId)
    if(IsSpace(rv)){
        alert("ɾ��������Ϣ�ɹ���");
        initDelShow(upId,nextId);
    }else{
        alert("ɾ��������Ϣʧ�ܣ�");
    }
}

function initDelShow(upId,nextId){
  var upOrNextId = '0';
  if(nextId!='0'){
    upOrNextId = nextId;
  }else if(upId!='0'){
    upOrNextId = upId;
  }else{
    window.close();
  }
  
  var sql = DataManager.initUpdateDateManager(upOrNextId);
  dataManagerdataset.Open(sql);
  initUporNextBtn();
}
</script>

<!-- ��ʾ������Ϊҳ��DOMԪ������ -->
<DIV id=SKbillsheet style="visibility:hidden" toolbar="����������" BLONopen="setAuthority();init();" contxml="<root><combobox><id>USER_SEX</id></combobox><button><id>saveAndClose</id><id>saveAndAdd</id><id>btnUp</id><id>btnNext</id><id>btnSave</id><id>btnDel</id><id>btnClose</id></button><text><id>USER_NAME</id><id>USER_REALNAME</id><id>USER_WORKTEL</id><id>USER_ID</id></text><dataset><id>dataManagerdataset</id></dataset></root>" billtaborder="<root><taborder>USER_SEX</taborder><taborder>saveAndClose</taborder><taborder>saveAndAdd</taborder><taborder>btnUp</taborder><taborder>btnNext</taborder><taborder>btnSave</taborder><taborder>btnDel</taborder><taborder>btnClose</taborder><taborder>USER_NAME</taborder><taborder>USER_REALNAME</taborder><taborder>USER_WORKTEL</taborder><taborder>USER_ID</taborder></root>" dj_sn="20100902204858171297" caption="��������" mkbh codeheader="BBB" entertype="�޸�" poswidth posheight controlno="SKButton:0;SKDBedit:0;checkbox:0;label:0;radio:0;listbox:0;textarea:0;combobox:0;password:0;upload:0;SKDBtext:0;chart:0;dbimg:0;img:0;SKBILLgrid:0;shape:0;tab:0;div:0;DsMain_field:0;a:0;button:0;text:0;hr:0;checkboxlist:0;radiolist:0;dropdownlist:0;grid:0;dataset:0;spin:0;excel:0;tree:0;ebshow:0;creatorSubForm:0;creator_div:0;ExtGrid:0;ExtUpload:0;ExtTree:0;Fusionchar:0" window="��ǰ����" posleft postop keyfield isfile="��" OtherSave="��" idtype="1" testDbName="app_xzcf" creatorStyle="creatorBlue" BLONclose="UnLoadWebOffice();" creator_remark hasWorkflowButton="��" creator_elementAuthoritySwitch="��" creator_showAlert="��" creator_office_isBindForm="��" islog="��" isprotect="��" creator_csslib version="1.0" creator_pagination type="ZW" creatorType="20100902181125312621" jslib="fcsavedj.js&#13;&#10;fcbasecont.js&#13;&#10;selectdate.js&#13;&#10;~userfunc.js&#13;&#10;fcdate.js&#13;&#10;../../../ccapp/app_xzcf/js/common/Namespace.js&#13;&#10;../../../ccapp/app_xzcf/js/common/nsreg.js&#13;&#10;../../../ccapp/app_xzcf/js/business/DataManager.js&#13;&#10;../../../ccapp/app_xzcf/js/dao/DataManagerDao.js&#13;&#10;../../../ccapp/app_xzcf/js/util/DBUtil.js&#13;&#10;../../../ccapp/app_xzcf/js/vo/vo.js">

<TABLE style="POSITION: static" cellSpacing=2 cellPadding=1 width="100%" align=left border=1>
   <TBODY>
      <TR>
         <TD>
            <TABLE width="100%">
               <TBODY>
                  <TR>
                     <TD width="100%"><DIV id=titleChargeName>��������</DIV></TD>
                  </TR>
               </TBODY>
            </TABLE>
         </TD>
      </TR>
      <TR>
         <TD>
            <TABLE style="POSITION: static" cellSpacing=2 cellPadding=1 width="100%" align=left border=1>
               <TBODY>
                  <TR>
                     <TD width="15%">�û��ʺ�</TD>
                     <TD width="35%"><INPUT id=USER_NAME style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="USER_NAME" china="�û��ʺ�" dataset="dataManagerdataset"></TD>
                     <TD width="15%">�û�ʵ��</TD>
                     <TD width="35%"><INPUT id=USER_REALNAME style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="USER_REALNAME" china="�û�ʵ��" dataset="dataManagerdataset"></TD>
                  </TR>
                  <TR>
                     <TD>�Ա�</TD>
                     <TD>&nbsp;<SELECT id=USER_SEX style="LEFT: 0px; WIDTH: 120px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() sqltrans controltype="combobox" field="USER_SEX" china="�Ա�" dataset="dataManagerdataset" tempvalue="��&#13;&#10;Ů" temptext="��&#13;&#10;Ů" sql check="1"><OPTION value=�� selected>��</OPTION><OPTION value=Ů>Ů</OPTION></SELECT></TD>
                     <TD>��˾�绰</TD>
                     <TD><INPUT id=USER_WORKTEL style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="USER_WORKTEL" china="��˾�绰" dataset="dataManagerdataset"></TD>
                  </TR>
               </TBODY>
            </TABLE>
         </TD>
      </TR>
      <TR>
         <TD align=middle><BUTTON id=saveAndClose style="LEFT: 0px; WIDTH: 75px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="��" controltype="button" onclick="bill_onclick(&quot;saveDateManager('addClose');&quot;)">���沢�ر�</BUTTON><BUTTON id=saveAndAdd style="LEFT: 0px; WIDTH: 75px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="��" controltype="button" onclick="bill_onclick(&quot;saveDateManager('Add');&quot;)">���沢����</BUTTON><BUTTON id=btnUp style="LEFT: 0px; WIDTH: 75px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="��" controltype="button" onclick="bill_onclick(&quot;UpOrNext('btnUp')&quot;)">��һ��</BUTTON><BUTTON id=btnNext style="LEFT: 0px; WIDTH: 75px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="��" controltype="button" onclick="bill_onclick(&quot;UpOrNext('btnNext');&quot;)">��һ��</BUTTON><BUTTON id=btnSave style="LEFT: 0px; WIDTH: 75px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="��" controltype="button" onclick="bill_onclick(&quot;saveDateManager('btnSave');&quot;)">����</BUTTON><BUTTON id=btnDel style="LEFT: 0px; WIDTH: 75px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="��" controltype="button" onclick='bill_onclick("delDataManager();")'>ɾ��</BUTTON><BUTTON id=btnClose style="LEFT: 0px; WIDTH: 75px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="��" controltype="button" onclick='bill_onclick("windowClose();")'>�ر�</BUTTON></TD>
      </TR>
   </TBODY>
</TABLE>

<INPUT id=USER_ID style="DISPLAY: none; LEFT: 41px; WIDTH: 110px; POSITION: absolute; TOP: 186px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" field="USER_ID" china="�û�ID" dataset="dataManagerdataset">

<?xml:namespace prefix = fc />

<fc:dataset id=dataManagerdataset showtypeXml="<root><showType><name>USER_ID</name><showRule></showRule></showType><showType><name>checked</name><showRule>%5B%7Bshowtype%3A%27checkbox%27%7D%5D</showRule></showType></root>" columnHeight1Xml="undefined" columnWidth1Xml="<root><columnWidth1><name>checked</name><columnWidth2>5%25</columnWidth2></columnWidth1><columnWidth1><name>USER_NAME</name><columnWidth2>25%25</columnWidth2></columnWidth1><columnWidth1><name>USER_REALNAME</name><columnWidth2>25%25</columnWidth2></columnWidth1><columnWidth1><name>USER_SEX</name><columnWidth2>10%25</columnWidth2></columnWidth1><columnWidth1><name>USER_WORKTEL</name><columnWidth2>15%25</columnWidth2></columnWidth1><columnWidth1><name>DREDGE_TIME</name><columnWidth2>15%25</columnWidth2></columnWidth1></root>" format="<fields><field><fieldname>USER_NAME</fieldname><datatype>�ַ�</datatype><displaylabel>�û��ʺ�</displaylabel><size>100</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1><columnWidth2>25%25</columnWidth2></columnWidth1></field><field><fieldname>USER_REALNAME</fieldname><datatype>�ַ�</datatype><displaylabel>�û�ʵ��</displaylabel><size>100</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1><columnWidth2>25%25</columnWidth2></columnWidth1></field><field><fieldname>USER_SEX</fieldname><datatype>�ַ�</datatype><displaylabel>�Ա�</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1><columnWidth2>10%25</columnWidth2></columnWidth1></field><field><fieldname>USER_WORKTEL</fieldname><datatype>�ַ�</datatype><displaylabel>��˾�绰</displaylabel><size>100</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1><columnWidth2>15%25</columnWidth2></columnWidth1></field><field><fieldname>DREDGE_TIME</fieldname><datatype>�ַ�</datatype><displaylabel>��ͨʱ��</displaylabel><size>100</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1><columnWidth2>15%25</columnWidth2></columnWidth1></field><field><fieldname>USER_ID</fieldname><datatype>�ַ�</datatype><displaylabel>�û�ID</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype><showRule></showRule></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field></fields>" onSetText='bill_ondatasetsettext("<dsid><USER_NAME></USER_NAME><USER_REALNAME></USER_REALNAME><USER_SEX></USER_SEX><USER_WORKTEL></USER_WORKTEL><DREDGE_TIME></DREDGE_TIME><USER_ID></USER_ID></dsid>")' onGetText='bill_ondatasetgettext("<dsid><USER_NAME></USER_NAME><USER_REALNAME></USER_REALNAME><USER_SEX></USER_SEX><USER_WORKTEL></USER_WORKTEL><DREDGE_TIME></DREDGE_TIME><USER_ID></USER_ID></dsid>")' onValid='bill_ondatasetvalid("<dsid><USER_NAME></USER_NAME><USER_REALNAME></USER_REALNAME><USER_SEX></USER_SEX><USER_WORKTEL></USER_WORKTEL><DREDGE_TIME></DREDGE_TIME><USER_ID></USER_ID></dsid>")' opensortno="1" temptable="TMP_DATASET1" multiResult="��"></fc:dataset>
</DIV>
<div id='grid_tip'></div></body></html>
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
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/vo/SpecialVo.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/vo/SpecialVo.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/vo/PunishMeasureVo.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/vo/PunishMeasureVo.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/util/WorkflowUtil.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/util/WorkflowUtil.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/common/Common.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/common/Common.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/business/ExecuteState.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/business/ExecuteState.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/dao/ExecuteStateDao.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/dao/ExecuteStateDao.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/business/DocumentList.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/business/DocumentList.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/dao/DocumentListDao.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/dao/DocumentListDao.js'></script>");
if(!bDgMode) out.println("</script>");
%>

   <script >document.styleSheets[0].addRule(".fcmask","behavior: url(../../fceform/htc/fcmask.htc)",0);</script>
   <script >document.styleSheets[0].addRule("fc\\:dataset","behavior: url(../../fceform/htc/dataset.htc)",0);</script>
   <script language='javascript'>
adv_loadjsfile('/eformsys/fceform/css/tabstyle.css');
adv_loadjsfile('/eformsys/fceform/js/fcmask.vbs');
adv_loadjsfile('/eformsys/fceform/css/Button.css');
adv_loadjsfile('/eformsys/fceform/css/TextStyle.css');
adv_loadjsfile('/eformsys/fceform/js/fcdataset.js');
</script>


<!-- ��ʾ������Ϊҳ���Զ���JS���� -->
<script>
//��ȡ�ô�������ʵ��ID
var wft_id = creator_getQueryString("wft_id");

//��ȡ�ò���ϸ���µĸô�����ʩ
var jd_id = creator_getQueryString("jd_id");//����ϸ����ˮ
var pm_id = creator_getQueryString("pm_id");//������ʩID

//���ݡ�ִ����Ϣ���Ƿ��ύ�жϳ�ʼ��

//��ʼ���ô�����ʩ
function init(){
    var sql = ExecuteState.findPunishMeasure(jd_id,pm_id);
    punishMeasureDataset.Open(sql);
    selectExecuteState();
}

//��ѯ"ִ�����"�ֶ�����
function selectExecuteState(){
    var ldt_id = 6;//��ʾ�ĵ�����
    var md_title = "ִ�����";
    var sql = DocumentList.findDocumentInfo(wft_id, ldt_id, md_title);
    punishMeasureDataset.Open(sql);
    var executeInfo = punishMeasureDataset..Fields.Field['MD_BODY'].Value;
    if(!IsSpace(executeInfo)){
        $('executeInfo').value = executeInfo;
    }
}

//�޸�"ִ��״̬"
function updateExecuteState(){
    var vo = new PunishMeasureVo.PunishMeasure();
    vo.WFT_ID = wft_id;
    vo.JD_ID = jd_id;
    vo.PM_ID = pm_id;
    vo.EXECUTING_STATE = $('EXECUTING_STATE').value;
    return vo;
}

//����"ִ�����"�ֶ�����
function insertExecuteInfo(){
    var vo = new SpecialVo.Document();
    vo.WFT_ID = wft_id;
    vo.LDT_ID = 6;//��ʾ�ĵ�����
    vo.MD_TITLE = "ִ�����";
    vo.MD_BODY = $('executeInfo').value;
    vo.WORKFLOW_NAME = "ִ��";
    return vo;
}

//�޸�"ִ�����"�ֶ�����
function updateExecuteInfo(){
    var vo = new SpecialVo.Document();
    vo.WFT_ID = wft_id;
    vo.LDT_ID = 6;//��ʾ�ĵ�����
     vo.MD_TITLE = "ִ�����";
    vo.MD_BODY = $('executeInfo').value;
    return vo;
}

//���"����"��ť
function clickSave(){
    var flag = false;
    var vo1 = updateExecuteState();//�޸�"ִ��״̬"
    if(IsSpace(selectExecuteState())){//���"ִ�����"����Ϊ��
    //����"ִ�����"�ֶ�����
        var vo2 = insertExecuteInfo();
    //����  
        flag = true;
        var rv = ExecuteState.savePunishMeasure(vo1, vo2, flag);
        alert(rv);
        if(rv){
            alert("����ɹ���");
        } else {
            alert("����ʧ�ܣ�");
        }
    } else {
    //�޸�"ִ�����"�ֶ�����
        var vo3 = updateExecuteInfo();
    //�޸�
         flag = false;
        var rv = ExecuteState.savePunishMeasure(vo1, vo3, flag);
        alert(rv);
        if(rv){
            alert("����ɹ���");
        } else {
            alert("����ʧ�ܣ�");
        }
    }
}

//���"����"��ť
function clickBack(){
    window.history.back();
}
</script>

<!-- ��ʾ������Ϊҳ��DOMԪ������ -->
<DIV id=SKbillsheet style="visibility:hidden" toolbar="����������" BLONopen="setAuthority();init();" contxml="<root><textarea><id>executeInfo</id></textarea><combobox><id>EXECUTING_STATE</id></combobox><button><id>button1</id><id>button2</id></button><text><id>PM_NAME</id><id>TIME_OF_PERFORMANCE</id><id>EXECUTING_DATE</id></text><dataset><id>punishMeasureDataset</id></dataset></root>" billtaborder="<root><taborder>button1</taborder><taborder>button2</taborder><taborder>EXECUTING_STATE</taborder><taborder>PM_NAME</taborder><taborder>TIME_OF_PERFORMANCE</taborder><taborder>EXECUTING_DATE</taborder><taborder>executeInfo</taborder></root>" dj_sn="20100926200552578075" caption="������ʩִ�����" mkbh codeheader="BBB" entertype="�޸�" poswidth posheight controlno="SKButton:0;SKDBedit:0;checkbox:0;label:0;radio:0;listbox:0;textarea:1;combobox:1;password:0;upload:0;SKDBtext:0;chart:0;dbimg:0;img:0;SKBILLgrid:0;shape:0;tab:0;div:0;DsMain_field:0;a:0;button:2;text:4;hr:0;checkboxlist:0;radiolist:0;dropdownlist:0;grid:0;dataset:1;spin:0;excel:0;tree:0;ebshow:0;creatorSubForm:0;creator_div:0;ExtGrid:0;ExtUpload:0;ExtTree:0;Fusionchar:0" window="��ǰ����" posleft postop keyfield isfile="��" OtherSave="��" idtype="1" testDbName="app_xzcf" creatorStyle="creatorBlue" BLONclose="UnLoadWebOffice();" creator_remark hasWorkflowButton="��" creator_elementAuthoritySwitch="��" creator_showAlert="��" creator_office_isBindForm="��" islog="��" isprotect="��" creator_csslib version="1.0" creator_pagination type="ZW" creatorType="20100902181230265751" jslib="fcbasecont.js&#13;&#10;selectdate.js&#13;&#10;~userfunc.js&#13;&#10;fcdate.js&#13;&#10;../../../ccapp/app_xzcf/js/vo/SpecialVo.js&#13;&#10;../../../ccapp/app_xzcf/js/vo/PunishMeasureVo.js&#13;&#10;../../../ccapp/app_xzcf/js/util/WorkflowUtil.js&#13;&#10;../../../ccapp/app_xzcf/js/common/Common.js&#13;&#10;../../../ccapp/app_xzcf/js/business/ExecuteState.js&#13;&#10;../../../ccapp/app_xzcf/js/dao/ExecuteStateDao.js&#13;&#10;../../../ccapp/app_xzcf/js/business/DocumentList.js&#13;&#10;../../../ccapp/app_xzcf/js/dao/DocumentListDao.js">

<TABLE cellSpacing=0 cellPadding=0 width="95%" align=center border=0>
   <TBODY>
      <TR>
         <TD>
            <TABLE cellSpacing=0 cellPadding=0 width="100%" border=1>
               <TBODY>
                  <TR>
                     <TD class=taobox colSpan=4>������ʩִ�����</TD>
                  </TR>
                  <TR>
                     <TD class=c2 width="15%">������ʩ</TD>
                     <TD width="30%"><INPUT id=PM_NAME style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" field="PM_NAME" china="ִ����ʩ" dataset="punishMeasureDataset"></TD>
                     <TD class=c2 width="15%">��������</TD>
                     <TD width="30%"><INPUT id=TIME_OF_PERFORMANCE style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" field="TIME_OF_PERFORMANCE" china="��������" dataset="punishMeasureDataset"></TD>
                  </TR>
                  <TR>
                     <TD class=c2 width="15%">ִ��״̬</TD>
                     <TD width="30%"><SELECT id=EXECUTING_STATE style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() sqltrans controltype="combobox" field="EXECUTING_STATE" china="ִ��״̬" dataset="punishMeasureDataset" tempvalue="0&#13;&#10;1&#13;&#10;2" temptext="δִ��&#13;&#10;ִ����&#13;&#10;��ִ��" sql check="1"><OPTION value=0 selected>δִ��</OPTION><OPTION value=1>ִ����</OPTION><OPTION value=2>��ִ��</OPTION></SELECT></TD>
                     <TD class=c2 width="15%">ִ��ʱ��</TD>
                     <TD width="30%"><INPUT id=EXECUTING_DATE style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" field="EXECUTING_DATE" china="ִ��ʱ��" dataset="punishMeasureDataset"></TD>
                  </TR>
                  <TR>
                     <TD class=c2 width="15%">ִ�����</TD>
                     <TD colSpan=3><TEXTAREA class=input_out onmousemove="this.className='input_move'" id=executeInfo onblur="this.className='input_off';this.onmouseout=function(){this.className='input_out'};" style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 85px" onfocus="this.className='input_on';this.onmouseout='" onmovestart=moveStart() onmouseout="this.className='input_out'" controltype="textarea" value="textarea1" induce="��"></TEXTAREA></TD>
                  </TR>
               </TBODY>
            </TABLE>
         </TD>
      </TR>
      <TR>
         <TD><BUTTON id=button1 style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="��" controltype="button">����</BUTTON><BUTTON id=button2 style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="��" controltype="button">����</BUTTON></TD>
      </TR>
      <TR>
         <TD>
            <TABLE cellSpacing=0 cellPadding=0 width=760 border=0>
               <TBODY>
                  <TR>
                     <TD>&nbsp;</TD>
                  </TR>
               </TBODY>
            </TABLE>
         </TD>
      </TR>
   </TBODY>
</TABLE>

<?xml:namespace prefix = fc />

<fc:dataset id=punishMeasureDataset format="<fields><field><fieldname>PM_NAME</fieldname><datatype>�ַ�</datatype><displaylabel>ִ����ʩ</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>PM_ID</fieldname><datatype>�ַ�</datatype><displaylabel>ִ����ʩID</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>TIME_OF_PERFORMANCE</fieldname><datatype>�ַ�</datatype><displaylabel>��������</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>EXECUTING_STATE</fieldname><datatype>�ַ�</datatype><displaylabel>ִ��״̬</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>EXECUTING_DATE</fieldname><datatype>�ַ�</datatype><displaylabel>ִ��ʱ��</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>MD_BODY</fieldname><datatype>�ַ�</datatype><displaylabel>�ĵ���</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field></fields>" onSetText='bill_ondatasetsettext("<dsid><PM_NAME></PM_NAME><PM_ID></PM_ID><TIME_OF_PERFORMANCE></TIME_OF_PERFORMANCE><EXECUTING_STATE></EXECUTING_STATE><EXECUTING_DATE></EXECUTING_DATE><MD_BODY></MD_BODY></dsid>")' onGetText='bill_ondatasetgettext("<dsid><PM_NAME></PM_NAME><PM_ID></PM_ID><TIME_OF_PERFORMANCE></TIME_OF_PERFORMANCE><EXECUTING_STATE></EXECUTING_STATE><EXECUTING_DATE></EXECUTING_DATE><MD_BODY></MD_BODY></dsid>")' onValid='bill_ondatasetvalid("<dsid><PM_NAME></PM_NAME><PM_ID></PM_ID><TIME_OF_PERFORMANCE></TIME_OF_PERFORMANCE><EXECUTING_STATE></EXECUTING_STATE><EXECUTING_DATE></EXECUTING_DATE><MD_BODY></MD_BODY></dsid>")' opensortno="1" temptable="TMP_DATASET1" multiResult="��"></fc:dataset>
</DIV>
<div id='grid_tip'></div></body></html>
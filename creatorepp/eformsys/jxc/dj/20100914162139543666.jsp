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
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/common/Common.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/common/Common.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/business/PunishInformed.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/business/PunishInformed.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/dao/PunishInformedDao.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/dao/PunishInformedDao.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/util/HTMLUtil.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/util/HTMLUtil.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/util/WorkflowUtil.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/util/WorkflowUtil.js'></script>");
if(!bDgMode) out.println("</script>");
%>

   <script >document.styleSheets[0].addRule("fc\\:dataset","behavior: url(../../fceform/htc/dataset.htc)",0);</script>
   <script language='javascript'>
adv_loadjsfile('/eformsys/fceform/css/tabstyle.css');
adv_loadjsfile('/eformsys/fceform/css/Button.css');
adv_loadjsfile('/eformsys/fceform/js/fcdataset.js');
adv_loadjsfile('/eformsys/fceform/js/Ext/SlidingPager.js');
adv_loadjsfile('/eformsys/fceform/js/Ext/SliderTip.js');
adv_loadjsfile('/eformsys/fceform/js/Ext/PanelResizer.js');
adv_loadjsfile('/eformsys/fceform/js/Ext/XmlTextReader.js');
adv_loadjsfile('/eformsys/fceform/js/Ext/CreatorMemoryProxy.js');
</script>


<!-- ��ʾ������Ϊҳ���Զ���JS���� -->
<script>
var wftId = creator_getQueryString("wft_id");//����ʵ��ID;
var piId = creator_getQueryString("pi_id");//����ID
var bu_id = creator_getQueryString("bu_id"); //ִ������ID
var read_only = creator_getQueryString("readOnlyFlag");
var ndpId = parent.ndpId;
var status = "";

/**
 * ��ʼ������
 */
function init() {
    loadCheckUserTable();
    initInstrumentsList();
    checkBig();
    initHiddenPage();
}

function wslbReload() {
    location.reload();
}

//��ѯ�����б�
function initInstrumentsList() {
    var sql = PunishInformed.queryInstrumentsList(wftId, ndpId);
    InstrumentsDataset.Open(sql);
}

/**
 * ��������ϸ
 * return:checkUserListHtml-String
 */
 function loadCheckUserTable() {
    var parties = PunishInformed.queryPunishParties(wftId, ndpId);
    var tr = null;
    var tdCount = 4;
    document.getElementById("$template1$").style.display = "none";
    document.getElementById("$template2$").style.display = "none";
    for(var i = 0; i < parties.length; i++) {
        if (i % tdCount == 0) {
            tr = HTMLUtil.cloneReplaceElement(document.getElementById("$template1$"), {
                template1 : "tr_id_" + i
            });
        }
        var td = HTMLUtil.cloneReplaceElement(document.getElementById("$template2$"), {
            $INFORMEDUSERID$ : parties[i][0],
            $CHECKEDS$ : "",
            $INFORMEDUSERNAME$ : parties[i][1]
        });
        td.style.display = "block";
        tr.appendChild(td);
        if (i % tdCount == 0) {
            tr.style.display = "block";
            document.getElementById("container").appendChild(tr);
        }
    }
    var count = 0;
    var tempCount = parties.length % tdCount;
    if(tempCount == 0) {
        count = 0;
    } else {
        count = tdCount - tempCount;
    }
    for (var i = 0; i < count; i++) {
        var td = HTMLUtil.cloneReplaceElement(document.getElementById("$template2$"), {
            $INFORMEDUSERID$ : " ",
            $CHECKEDS$ : " ",
            $INFORMEDUSERNAME$ : " "
        });
        td.style.display = "block";
        tr.appendChild(td);
    }
 }
 
function icb(element) {
    if (IsSpace(element.id)) {
        element.style.display = "none";
    }
}

function checkIsInstruments() {
    var userArr = PunishInformed.queryPunishParties(wftId, ndpId);
    var userNameObj = document.getElementsByName("USERNAME");
    for(var i = 0; i < userNameObj.length; i++) {
        userNameObj[i].disabled = false;
        for(var j = 0; j < userArr.length; j++) {
            if(userArr[j][2] == userNameObj[i].id) {
                userNameObj[i].disabled = true;
                userNameObj[i].checked = false;
                break;
            } 
        }
    }
}

//��ѡ�������б�
function openWordList(a){
    var url = "../../../eformsys/jxc/dj/20101216090615718050.jsp?wft_id=" + wftId;
    url += "&pi_id=" + piId + "&ndp_id=" + ndpId + "&bu_id=" + bu_id + "&ltt_id=" + a;
    var height = window.screen.availHeight;
    var width = window.screen.availWidth;
    var tempPara="dialogWidth:"+width+"px;dialogHeight:"+height+"px;";
    //window.open(url, window,'height=768px,width=1250px,top=0,left=0,toolbar=no,menubar=no,scrollbars=no,resizable=no,location=no,status=no');
    var wsObj = showModalDialog(url, window,'height=768px,width=1250px,top=0,left=0,toolbar=no,menubar=no,scrollbars=no,resizable=no,location=no,status=no');   
    return wsObj;
}

//��������
function generationInstruments() {
    var flag = false;
    //��ѯ��ǰ�����µ�ǰ�׶ε���������ģ��
    var templeteArr = PunishInformed.getInstrumentsTemp(piId, ndpId);
    if(templeteArr.length <= 0) {
        alert("�������ǰ�׶�û����������,�����ú�����������");
        return;
    }
    //�½����е����˶�������
    var userNameObj = document.getElementsByName("USERNAME");
    //�½�һ��������ID����
    var userIds = new Array();
    for(var i = 0; i < userNameObj.length; i++) {
        if(userNameObj[i].checked == true) {
            userIds[userIds.length] = userNameObj[i].id;
        }
    }
    //û�й�ѡ������
    if(userIds.length == 0) {
        if(!confirm("ȷ��Ҫ�ֱ�����������")){
            alert("��ѡ������");
            return;
        }
        flag = true;
        //��ѯ�ô�������ʵ����ǰ�׶������еĵ������Ƿ�������ȫ������
        var userArr = PunishInformed.queryPunishParties(wftId, ndpId);
        for(var j = 0; j < userArr.length; j++){
            userIds[userIds.length] = userArr[j][0];
        }
        
        /*var k = 0;
        for(var j = 0; j < userArr.length; j ++) {
            if(IsSpace(userArr[j][2])) {
                userIds[userIds.length] = userArr[j][0];
                k++;
            }
        }
        if(k == 0) {
            alert("���еĵ����˶�����������,��Ҫ����������");
            return;
        }*/
    }
    //��ѡ���������
    var WenShuObj = openWordList(userIds);//�������
    if(IsSpace(WenShuObj)){
        return;
    }
    /*WenShuObj.rfl_id//����ID����
    WenShuObj.rfl_name//������������
    WenShuObj.rfl_brief_name//����������
    WenShuObj.mb_id//ģ��ID����
    WenShuObj.isTemplate//�Ƿ���ģ��
    WenShuObj.rflTsm//ģ��洢��ʽ
    */
    var rv = PunishInformed.generationInstruments(piId, wftId, userIds, ndpId, flag, "", WenShuObj);
    if(rv) {
        alert("��������ɹ�");
        reloadExtGrid();
        checkBig();
    }    
}

//ɾ������
function delInstruments() {
    var grid = creator_pt_grids[0].obj;
    var ids = FormUtil.getExtGridSelectedIds('RLD_ID', grid);
    if(ids.length==0){
       alert("��ѡ��Ҫɾ���ļ�¼��");
    }else{
        if(!confirm("ȷ��Ҫɾ��ѡ���������")){
            return;
        }
        var rv = PunishInformed.delInstruments(ids);
        if(rv){
            alert("ɾ��������Ϣ�ɹ���");
            reloadExtGrid();
            checkBig();
        }else{
            alert("ɾ��������Ϣʧ�ܣ�");
        }
    }
}

function initHiddenPage() {
    if(read_only == "readOnly") {
        $("btnScWs").disabled = true;
        $("delBtn").disabled = true;
    }
}

//��ӡ����
function printInstruments() {
    var grid = creator_pt_grids[0].obj;
    var ids = FormUtil.getExtGridSelectedIds('RLD_ID', grid);
    if(ids.length==0){
       alert("��ѡ��Ҫ��ӡ�����飡");
    }else{
    
    }
}

//Ԥ������20101110145308843964 
                 //������ˮ��������������������ID
function readWenShu(rld_id, ltt_Names, ltt_Ids){

    var nowDate = getNowDate();//��ȡ��ǰ����

    //��ѯ��ǰ��¼�������
    var result = PunishInformed.findRld_Instrument_NoByRld_id(rld_id);
    var WenShuNumber = result[0][0];
    var mbId = result[0][1];
    //��ѯwordʵ��ID
    var wordInstanceId = PunishInformed.QueryWordInstanceId(rld_id);
    if(read_only == "readOnly"){
        status = "readOnly";
    }
    if(!IsSpace(wordInstanceId)){//������wordʵ��
        var url = "20101110145308843964.jsp?wft_id="+wftId+"&wordInstanceId="+wordInstanceId;
        url += "&mb_id="+mbId+"&status=" + status;
        var width = window.screen.availWidth;
        var height = window.screen.availHeight;
        var tempPara="dialogWidth:"+width+"px;dialogHeight:"+height+"px;";
        window.showModalDialog(url,window,tempPara);
        return;
    }

    var url = "20101110145308843964.jsp?wft_id="+wftId+"&mb_id="+mbId;
    //�����ţ�������ID������������ 
    
     url += "&WenShuNumber="+WenShuNumber+"&bl_ltt_Info="+ltt_Names+"@@@"+ltt_Ids;
    url += "&bl_NowDate="+nowDate;
    url += "&status=write&WenShuLiuShui="+rld_id+"&wordInstanceId="+wordInstanceId;

    var width = window.screen.availWidth;
    var height = window.screen.availHeight;
    var tempPara="dialogWidth:"+width+"px;dialogHeight:"+height+"px;";
    window.showModalDialog(url,window,tempPara);
    reloadExtGrid();
}

//��ȡ��ǰ������ʱ��
function getNowDate(){
    var nowYear = FormUtil.getServerYear();//��ȡ��ǰ��������
    var nowMonth = FormUtil.getServerMonth();//��ȡ��ǰ��������
    var nowDay = FormUtil.getServerDay();//��ȡ��ǰ��������
    if(parseInt(nowMonth) < 10){
        nowMonth = "0" + nowMonth;
    }
    if(parseInt(nowDay) < 10){
        nowDay = "0" + nowDay;
    }
    var nowDate = nowYear + "��" + nowMonth + "��" + nowDay + "��";
    return nowDate;
}

//�жϿ�ѡ���������뵱������ѡ���������Ĵ�С
function checkBig(){
    var canChoose = PunishInformed.countRldByNdp_id(wftId, ndpId);//��ѡ����
    var alreadyChoose = PunishInformed.countRldByLttAndNdp(wftId, ndpId);//��ѡ����
    var userNameObj = document.getElementsByName("USERNAME");
    for(var i = 0; i < userNameObj.length; i++) {
        userNameObj[i].disabled = false;
        for(var j = 0; j < alreadyChoose.length; j++) {
            //����������������
            if(alreadyChoose[j][0] == userNameObj[i].id && alreadyChoose[j][1] == canChoose) {
                userNameObj[i].disabled = true;
                userNameObj[i].checked = false;
                break;
            } 
        }
    }
}
</script>

<!-- ��ʾ������Ϊҳ��DOMԪ������ -->
<DIV id=SKbillsheet style="visibility:hidden" toolbar="����������" BLONopen="setAuthority();init();" contxml="<root><div><id>div1</id></div><button><id>btnScWs</id><id>delBtn</id></button><dataset><id>InstrumentsDataset</id></dataset><ExtGrid><id>ExtGrid2</id></ExtGrid></root>" billtaborder="<root><taborder>btnScWs</taborder><taborder>delBtn</taborder></root>" dj_sn="20100914162139543666" caption="�����б�" mkbh codeheader="BBB" entertype="�޸�" poswidth posheight controlno="SKButton:0;SKDBedit:0;checkbox:1;label:1;radio:0;listbox:0;textarea:0;combobox:0;password:0;upload:0;SKDBtext:0;chart:0;dbimg:0;img:0;SKBILLgrid:0;shape:0;tab:0;div:1;DsMain_field:0;a:0;button:3;text:0;hr:0;checkboxlist:0;radiolist:0;dropdownlist:0;grid:0;dataset:1;spin:0;excel:0;tree:0;ebshow:0;creatorSubForm:0;creator_div:1;ExtGrid:2;ExtUpload:0;ExtTree:0;Fusionchar:0" window="��ǰ����" posleft postop keyfield isfile="��" OtherSave="��" idtype="1" testDbName="app_xzcf" creatorStyle="creatorBlue" BLONclose="UnLoadWebOffice();" creator_remark hasWorkflowButton="��" creator_elementAuthoritySwitch="��" creator_showAlert="��" creator_office_isBindForm="��" islog="��" isprotect="��" creator_csslib version="1.0" creator_pagination type="ZW" creatorType="20100902181230265751" jslib="fcbasecont.js&#13;&#10;selectdate.js&#13;&#10;~userfunc.js&#13;&#10;fcdate.js&#13;&#10;../../../ccapp/app_xzcf/js/common/Common.js&#13;&#10;../../../ccapp/app_xzcf/js/business/PunishInformed.js&#13;&#10;../../../ccapp/app_xzcf/js/dao/PunishInformedDao.js&#13;&#10;../../../ccapp/app_xzcf/js/util/HTMLUtil.js&#13;&#10;../../../ccapp/app_xzcf/js/util/WorkflowUtil.js">

<TABLE style="WIDTH: 100%; POSITION: static; HEIGHT: 397px" cellSpacing=2 cellPadding=1 width=870 align=center border=0>
   <TBODY>
      <TR>
         <TD>
            <TABLE class=Ctable style="POSITION: static" cellSpacing=0 cellPadding=0 width="100%" align=left border=0>
               <TBODY>
                  <TR>
                     <TD class=taobox colSpan=3>���ɰ�����Ӧ����</TD>
                  </TR>
                  <TR>
                     <TD class=c2 width="15%">������</TD>
                     <TD width="65%">
                        <TABLE style="POSITION: static" cellSpacing=0 cellPadding=0 width="100%" align=left border=0>
                           <TBODY id=container>
                              <TR id=$template1$>
                                 <TD id=$template2$ align=middle width="25%"><INPUT id=$INFORMEDUSERID$ type=checkbox value=$INFORMEDUSERNAME$ name=USERNAME callback="icb" $CHECKEDS$></INPUT>$INFORMEDUSERNAME$</TD>
                           </TR>
                        </TBODY>
                     </TABLE>
                  </TD>
                  <TD width="20%"><BUTTON class=button id=btnScWs style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="��" controltype="button" onclick='bill_onclick("generationInstruments();")'>��������</BUTTON><BUTTON class=button id=delBtn style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="��" controltype="button" onclick='bill_onclick("delInstruments();")'>ɾ������</BUTTON></TD>
               </TR>
            </TBODY>
         </TABLE>
      </TD>
   </TR>
   <TR>
      <TD><DIV id=div1 style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; OVERFLOW: auto; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 338px" onmovestart=moveStart() controltype="div" NotBg="��"><IMG style="DISPLAY: none" src="undefined"><DIV id=div_ExtGrid2 style="LEFT: 0px; POSITION: static; TOP: 0px"></DIV><SCRIPT type=text/javascript>var ExtGrid2;
Ext.BLANK_IMAGE_URL = '../../fceform/js/Ext/images/default/s.gif';
var ExtGrid2_retint = 0;
var ExtGrid2_onReady = function(){ 
 Ext.QuickTips.init();
var dataset = document.getElementById("InstrumentsDataset");
try{var temp = dataset.Fields.Field.length;}catch(e){if(ExtGrid2_retint==0) ExtGrid2_retint = setInterval(ExtGrid2_onReady,200);dataset =null;return;}finally{if(temp!=null)temp=null;}
clearInterval(ExtGrid2_retint);ExtGrid2_retint = null ;var pagesize =10;
dataset.PageSize = pagesize ;
var mapping = creator_pt_getmapping(dataset);
var store  = new Ext.data.Store({
	proxy: new Ext.data.CreatorMemoryProxy("InstrumentsDataset"), 
	reader: new Ext.data.XmlStringReader({       record: 'tr',       totalRecords: 'pages'   }, mapping)});
var sm = new Ext.grid.RowSelectionModel({singleSelect: true});
var retcm = creator_pt_getcm(dataset,sm);var cm = new Ext.grid.ColumnModel(retcm);
if(typeof(retcm[0].getCount)!='undefined') sm = retcm[0] ;
 ExtGrid2 = new Ext.grid.GridPanel({
		el: 'div_ExtGrid2',        store: store,
        cm:cm,
		sm: sm,
 			 bodyStyle : 'width:100%',
		viewConfig: {
			forceFit: true		},       loadMask: true,
	width: '100%',
					height: eval(parseFloat(document.getElementById('div1').style.height)*(parseFloat('100%')))/100-60,
		split: true,
		region: 'north',
		title:'�����б�',
		frame:true
		,plugins: new Ext.ux.PanelResizer({
            minHeight: 100        }),
       bbar: new Ext.PagingToolbar({
            pageSize: pagesize,
            store: store,
            displayInfo: true,
            displayMsg:'��ǰ��ʾ�� {0} - {1} ������ {2} ��',            plugins: new Ext.ux.SlidingPager()        })		    });
    var grid=ExtGrid2;
		grid.getStore().on('datachanged', function() {
		var hd_checker = grid.getEl().select('div.x-grid3-hd-checker');
		var hd = hd_checker.first();
		if(hd != null){ 
			hd.removeClass('x-grid3-hd-checker-on');
		}
});

/**
ʹ��˵��                      
1.ע�Ͳ�Ҫ�� //��
2.���Բ�����ǰGrid��sm��cm��store����
3.����Ĵ�������һЩ���Ի���������ĳ�е�ĳЩ�ض�������
**/
cm.setHidden(4,true);
cm.setHidden(5,true);
ExtGrid2.render();
store.load({params:{start:0, limit:pagesize}});
if(typeof(creator_pt_grids)=='undefined'){creator_pt_grids=new Array();}
creator_pt_grids.push({id:'ExtGrid2',obj:ExtGrid2,dataset:'InstrumentsDataset',isEdit:'false'});
if(typeof(onGridPanelLoaded)=='function') setTimeout(onGridPanelLoaded,0);
};
ExtGrid2_onReady();</SCRIPT></DIV></TD>
   </TR>
</TBODY>
</TABLE>

<?xml:namespace prefix = fc />

<fc:dataset id=InstrumentsDataset showtypeXml="<root><showType><name>RLD_ID</name><showRule>undefined</showRule></showType><showType><name>checked</name><showRule>%5B%7Bshowtype%3A%27checkbox%27%7D%5D</showRule></showType><showType><name>a</name><showRule>%5B%7BRule%3A%27%24%7Bsdf%7D%3D%3D%22bb%22%27%2Cshowtype%3A%27%3Cinput%20type%3Dbutton%20value%3D%u201D%u6309%u94AE%u201D%20/%3E%27%7D%5D</showRule></showType><showType><name>baocun</name><showRule>%5B%7BRule%3A%271%3D%3D1%27%2Cshowtype%3A%27%3Cinput%20type%3Dbutton%20value%3D%u6253%u5370%u6587%u4E66%20v1%3D%24%7Brld_id%7D%20v2%3D%24%7Bltt_name%7D%20v3%3D%24%7Bltt_id%7D%20onclick%3DreadWenShu%28this.v1%2Cthis.v2%2Cthis.v3%29%20/%3E%27%7D%5D</showRule></showType><showType><name>dayin</name><showRule>%5B%7BRule%3A%271%3D%3D1%27%2Cshowtype%3A%27%3Cinput%20type%3Dbutton%20value%3D%u6253%u5370%u6587%u4E66%20/%3E%27%7D%5D</showRule></showType></root>" columnHeight1Xml="undefined" columnWidth1Xml="<root><columnWidth1><name>RLD_TITLE</name><columnWidth2>40</columnWidth2></columnWidth1><columnWidth1><name>RLD_INSTRUMENT_NO</name><columnWidth2>40</columnWidth2></columnWidth1><columnWidth1><name>checked</name><columnWidth2>10</columnWidth2></columnWidth1><columnWidth1><name>LTT_NAME</name><columnWidth2>40</columnWidth2></columnWidth1></root>" format="<fields><field><fieldname>checked</fieldname><datatype>�ַ�</datatype><displaylabel>ȫѡ</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype><showRule>%5B%7Bshowtype%3A%27checkbox%27%7D%5D</showRule></showtype><columnHeight1></columnHeight1><columnWidth1><columnWidth2>10</columnWidth2></columnWidth1></field><field><fieldname>RLD_TITLE</fieldname><datatype>�ַ�</datatype><displaylabel>��������</displaylabel><size>200</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1><columnWidth2>40</columnWidth2></columnWidth1></field><field><fieldname>RLD_INSTRUMENT_NO</fieldname><datatype>�ַ�</datatype><displaylabel>������</displaylabel><size>30</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1><columnWidth2>40</columnWidth2></columnWidth1></field><field><fieldname>LTT_NAME</fieldname><datatype>�ַ�</datatype><displaylabel>��Ӧ������</displaylabel><size>1000</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1><columnWidth2>40</columnWidth2></columnWidth1></field><field><fieldname>RLD_ID</fieldname><datatype>�ַ�</datatype><displaylabel>����������ˮ</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype><showRule>undefined</showRule></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>LTT_ID</fieldname><datatype>�ַ�</datatype><displaylabel>��Ӧ������ID</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>baocun</fieldname><datatype>�ַ�</datatype><displaylabel>��ӡ����</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype><showRule>%5B%7BRule%3A%271%3D%3D1%27%2Cshowtype%3A%27%3Cinput%20type%3Dbutton%20value%3D%u6253%u5370%u6587%u4E66%20v1%3D%24%7Brld_id%7D%20v2%3D%24%7Bltt_name%7D%20v3%3D%24%7Bltt_id%7D%20onclick%3DreadWenShu%28this.v1%2Cthis.v2%2Cthis.v3%29%20/%3E%27%7D%5D</showRule></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field></fields>" onSetText='bill_ondatasetsettext("<dsid><checked></checked><RLD_TITLE></RLD_TITLE><RLD_INSTRUMENT_NO></RLD_INSTRUMENT_NO><LTT_NAME></LTT_NAME><RLD_ID></RLD_ID><LTT_ID></LTT_ID><baocun></baocun></dsid>")' onGetText='bill_ondatasetgettext("<dsid><checked></checked><RLD_TITLE></RLD_TITLE><RLD_INSTRUMENT_NO></RLD_INSTRUMENT_NO><LTT_NAME></LTT_NAME><RLD_ID></RLD_ID><LTT_ID></LTT_ID><baocun></baocun></dsid>")' onValid='bill_ondatasetvalid("<dsid><checked></checked><RLD_TITLE></RLD_TITLE><RLD_INSTRUMENT_NO></RLD_INSTRUMENT_NO><LTT_NAME></LTT_NAME><RLD_ID></RLD_ID><LTT_ID></LTT_ID><baocun></baocun></dsid>")' opensortno="1" temptable="TMP_DATASET1" multiResult="��"></fc:dataset>
</DIV>
<div id='grid_tip'></div></body></html>
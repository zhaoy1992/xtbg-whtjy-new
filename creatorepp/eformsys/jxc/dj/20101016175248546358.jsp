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
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/vo/publicVO.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/vo/publicVO.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/vo/SpecialVo.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/vo/SpecialVo.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/util/WorkflowUtil.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/util/WorkflowUtil.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/util/DBUtil.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/util/DBUtil.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/business/SpecialApply.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/business/SpecialApply.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/dao/SpecialApplyDao.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/dao/SpecialApplyDao.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/business/DocumentList.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/business/DocumentList.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/dao/DocumentListDao.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/dao/DocumentListDao.js'></script>");
if(!bDgMode) out.println("</script>");
%>

   <script >document.styleSheets[0].addRule("fc\\:dataset","behavior: url(../../fceform/htc/dataset.htc)",0);</script>
   <script language='javascript'>
adv_loadjsfile('/eformsys/fceform/css/tabstyle.css');
adv_loadjsfile('/eformsys/fceform/css/Button.css');
adv_loadjsfile('/eformsys/fceform/css/TextStyle.css');
adv_loadjsfile('/eformsys/fceform/js/fcdataset.js');
adv_loadjsfile('/eformsys/fceform/js/Ext/SlidingPager.js');
adv_loadjsfile('/eformsys/fceform/js/Ext/SliderTip.js');
adv_loadjsfile('/eformsys/fceform/js/Ext/PanelResizer.js');
adv_loadjsfile('/eformsys/fceform/js/Ext/XmlTextReader.js');
adv_loadjsfile('/eformsys/fceform/js/Ext/CreatorMemoryProxy.js');
</script>


<!-- ��ʾ������Ϊҳ���Զ���JS���� -->
<script>
<%@page import="com.chinacreator.xzcf.baseservice.menu.OrgAccessUtil "%>
<%
OrgAccessUtil orgAccess = new OrgAccessUtil();
String idName = orgAccess.getLawOrgIdName(accesscontroler.getUserID());
String allZfztId = "";
if (!"1".equals(accesscontroler.getUserID())) {
    allZfztId = orgAccess.getBuIdByOrgIds(accesscontroler.getUserID());
} else {
    allZfztId = orgAccess.getAllBuIds();
}

String idTmp = "";
String nameTmp = "";
if("".equals(idName)){
    idTmp = "";
    nameTmp = "";
}else{
    String[] tmps = idName.split("_");
    idTmp = tmps[0];
    nameTmp = tmps[1];
}
%>

//��ȡ��ǰ�û�
var orgname = getSysElement("userorgname");
var user = getSysElement("username");
var user_id = getSysElement("userid");

var temp = "";


//��ʼ��
function init(){
    $('orgIds').value = "<%=idTmp %>";
    $('orgNames').value = "<%=nameTmp %>";
    temp = $('orgIds').value;
    findCanAvermentCase();
}

//�������֤������֤�İ������б�
function findCanAvermentCase(){
    if(!validate()){
        return;
    }  
    if(IsSpace(temp)){//��ǰ�û��������Ų���ִ������
        temp = "<%=allZfztId %>";//���п��Է��ʵ�ִ������ID
    }
    if(IsSpace(temp)){
        alert("��ǰ�û�û�в�ѯȨ��");
        return;
    }

    var pagePrams = {
      bu_id : temp,
      ltt_name : ${'LTT_NAME'}.value.trim(),
      wft_business_number : ${'WFT_BUSINESS_NUMBER'}.value.trim(),
      ltt_code : ${'LTT_CODE'}.value.trim(),
      avermentState : ${'AVERMENTSTATE'}.value,
      acceptTimeMin : ${'ACCEPTTIMEMIN'}.value,
      acceptTimeMax : ${'ACCEPTTIMEMAX'}.value
    }
    var sql = DocumentList.findListenList(pagePrams);
    caseDataset.Open(sql);
    reloadExtGrid();
}

//����
function resetinfo(){
    ${'orgIds'}.value = "<%=idTmp %>";
    ${'orgNames'}.value = "<%=nameTmp %>";
    temp = ${'orgIds'}.value;
    if(IsSpace(temp)){
        temp = "<%=allZfztId %>";    
    }
    ${'LTT_NAME'}.value = "";
    ${'WFT_BUSINESS_NUMBER'}.value = "";
    ${'LTT_CODE'}.value = "";
    ${'AVERMENTSTATE'}.value = "0";
    ${'ACCEPTTIMEMIN'}.value = "";
    ${'ACCEPTTIMEMAX'}.value = "";
}

//��ȡ�ô�������ʵ������ע״̬
function getStatus(wft_id){
    var sql = DocumentList.findPostilInfo(wft_id, "��֤");
    var arr = DBUtil.getQueryArray(sql, 0, -1);
    if(IsSpace(arr)){
        return "";
    } else {
        var tp_status = arr[0][1];
        return tp_status;
    }
}

//��ȡ��ǰ������ʱ��
function getNowTime(){
    var nowTime = FormUtil.getServerDate(); //��ǰ������ʱ��
     var nowTIME = nowTime.substring(0,10);
    //var nowDate = new Date(nowTime.replace(/-/g,"/"));
    return nowTIME;
}

//��ȡ�ô�������ʵ���ĳ�������ļƻ���ֹʱ��
function getPlanTime(wft_id){
    var result = SpecialApply.findPlanTime(wft_id, "��֤");
    return result[0][0];
}

//��������Ƿ�ʱ
function checkTime(wft_id){
    var flag = true;
    var t1 = getNowTime();
    var t2 = getPlanTime(wft_id).substring(0,10);
    
    var arys1 = new Array();
    arys1 = t1.split('-');
    var myDate1 = new Date(arys1[0],arys1[1],arys1[2]); 
    
    var arys2 = new Array();
    arys2 = t2.split('-');
    var myDate2 = new Date(arys2[0],arys2[1],arys2[2]); 
    if(myDate1 > myDate2){
        flag = false;        
    } else {
        flag = true;
    }
    return flag;
}

//���볬ʱ��д��ǿ����ֹ����
function saveEndInfo(wft_id){
    var vo = new SpecialVo.SpecialApply();
    vo.WFT_ID = wft_id;
    vo.SPA_SEGMENT = "��֤";
    vo.SPAFTC_ID = 2;//(��ʱ��ֹ)
    vo.SPA_FORCED_TERMINATION = 1;//ǿ����ֹ״̬
    vo.SPA_FORCED_TERMINATER = user_id;//��ǰ�û�ID(��ǿ����ֹ��)
    vo.SPA_TERMINATION_REASONS = "���볬ʱ������ֹ���룬�����ٴ����룡";//ǿ����ֹ����
    var rv = SpecialApply.updateSpecialApply(vo);
}

//˫����һ����¼��������֤����
function initAverment(grid, rowIndex, e){
    var row = grid.store.getById(grid.store.data.items[rowIndex].id); 
    var wft_id = row.get("wft_id");
    var tp_status = getStatus(wft_id);
    var avermentState = row.get("aa");
    if(avermentState == "������" && IsSpace(tp_status)){//������֤�������
        var flag = checkTime(wft_id);//��������Ƿ�ʱ
        if(!flag){  //��ʱ
              saveEndInfo(wft_id);//д��ǿ����ֹ��Ϣ
              var tempPara = "dialogWidth:780px,dialogHeight:250px;";
            var tempURL = "20101016201431000833.jsp?djbh=222&wft_id=" + wft_id + "&flag=1&temp=0&avermentState=" + avermentState;
            window.showModalDialog(tempURL, "window", tempPara);
            reloadExtGrid();
        } else {   //δ��ʱ
              var tempPara = "dialogWidth:780px,dialogHeight:250px;";
            var tempURL = "20101016201431000833.jsp?djbh=222&wft_id=" + wft_id + "&flag=0&temp=0&avermentState=" + avermentState;
            window.showModalDialog(tempURL, "window", tempPara);
            reloadExtGrid();
        }    
    } else if(avermentState == "δ����" || avermentState == "����֤" || (avermentState == "������" && tp_status == 0)){ //��ת����֤����
        var tempPara = "dialogWidth:780px,dialogHeight:250px;";
        var tempURL = "20100913145409775622.jsp?djbh=222&wft_id=" + wft_id + "&avermentState=" + avermentState + "&tp_status=" + tp_status + "&eflag=0";
        window.showModalDialog(tempURL, "", tempPara);
        reloadExtGrid();
    }
}

//������֤
function validate(){
    var flag = true;
    if(!IsSpace(${'ACCEPTTIMEMIN'}.value) && !IsSpace(${'ACCEPTTIMEMAX'}.value) && ${'ACCEPTTIMEMIN'}.value > ${'ACCEPTTIMEMAX'}.value){
        alert("�������ʱ�䲻��С������ʼʱ��");
        flag = false;
    }
    return flag;
}

//��ִ��������Դ��
function openUserTree(){
    url = "../../../ccapp/app_xzcf/jsp/baseservice/chooseZfztResourse.jsp";
    chooseUsers = window.showModalDialog(url,window, "dialogWidth=620px;dialogHeight=500px");
}
</script>

<!-- ��ʾ������Ϊҳ��DOMԪ������ -->
<DIV id=SKbillsheet style="visibility:hidden" toolbar="����������" BLONopen="setAuthority();init();" contxml="<root><combobox><id>AVERMENTSTATE</id></combobox><button><id>button3</id><id>button4</id></button><text><id>orgNames</id><id>LTT_NAME</id><id>WFT_BUSINESS_NUMBER</id><id>LTT_CODE</id><id>ACCEPTTIMEMIN</id><id>ACCEPTTIMEMAX</id></text><dataset><id>caseDataset</id><id>postilDataset</id></dataset><ExtGrid><id>ExtGrid1</id></ExtGrid></root>" billtaborder="<root><taborder>AVERMENTSTATE</taborder><taborder>button3</taborder><taborder>button4</taborder><taborder>orgNames</taborder><taborder>LTT_NAME</taborder><taborder>WFT_BUSINESS_NUMBER</taborder><taborder>LTT_CODE</taborder><taborder>ACCEPTTIMEMIN</taborder><taborder>ACCEPTTIMEMAX</taborder></root>" dj_sn="20101016175248546358" caption="��֤��ѯ" mkbh codeheader="BBB" entertype="�޸�" poswidth posheight controlno="SKButton:0;SKDBedit:0;checkbox:0;label:0;radio:0;listbox:0;textarea:0;combobox:0;password:0;upload:0;SKDBtext:0;chart:0;dbimg:0;img:0;SKBILLgrid:0;shape:0;tab:0;div:0;DsMain_field:0;a:0;button:0;text:1;hr:0;checkboxlist:0;radiolist:0;dropdownlist:0;grid:0;dataset:0;spin:0;excel:0;tree:0;ebshow:0;creatorSubForm:0;creator_div:0;ExtGrid:0;ExtUpload:0;ExtTree:0;Fusionchar:0" window="��ǰ����" posleft postop keyfield isfile="��" OtherSave="��" idtype="1" testDbName="app_xzcf" creatorStyle="creatorBlue" BLONclose="UnLoadWebOffice();" creator_remark hasWorkflowButton="��" creator_elementAuthoritySwitch="��" creator_showAlert="��" creator_office_isBindForm="��" islog="��" isprotect="��" creator_csslib version="1.0" creator_pagination type="ZW" creatorType="20100902181230265751" jslib="fcbasecont.js&#13;&#10;selectdate.js&#13;&#10;~userfunc.js&#13;&#10;fcdate.js&#13;&#10;../../../ccapp/app_xzcf/js/common/Common.js&#13;&#10;../../../ccapp/app_xzcf/js/vo/publicVO.js&#13;&#10;../../../ccapp/app_xzcf/js/vo/SpecialVo.js&#13;&#10;../../../ccapp/app_xzcf/js/util/WorkflowUtil.js&#13;&#10;../../../ccapp/app_xzcf/js/util/DBUtil.js&#13;&#10;../../../ccapp/app_xzcf/js/business/SpecialApply.js&#13;&#10;../../../ccapp/app_xzcf/js/dao/SpecialApplyDao.js&#13;&#10;../../../ccapp/app_xzcf/js/business/DocumentList.js&#13;&#10;../../../ccapp/app_xzcf/js/dao/DocumentListDao.js">

<TABLE cellSpacing=0 cellPadding=0 width="95%" align=center border=0>
   <TBODY>
      <TR>
         <TD>
            <TABLE class=Ctable cellSpacing=0 cellPadding=0 width="100%" border=0>
               <TBODY>
                  <TR>
                     <TD class=taobox colSpan=4>��֤��ѯ</TD>
                  </TR>
                  <TR>
                     <TD class=c2 width="15%">ִ������</TD>
                     <TD width="35%"><INPUT class=input_image id=orgNames style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" onclick='bill_onclick("openUserTree()")'><INPUT id=orgIds type=hidden></TD>
                     <TD class=c2 width="15%">������(��λ)����</TD>
                     <TD width="35%"><INPUT class=input_out id=LTT_NAME style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text"></TD>
                  </TR>
                  <TR>
                     <TD class=c2 width="15%">�������</TD>
                     <TD width="35%"><INPUT class=input_out id=WFT_BUSINESS_NUMBER style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text"></TD>
                     <TD class=c2 width="15%">֤������</TD>
                     <TD width="35%"><INPUT class=input_out id=LTT_CODE style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text"></TD>
                  </TR>
                  <TR>
                     <TD class=c2 width="15%">��֤״̬</TD>
                     <TD width="35%"><SELECT id=AVERMENTSTATE style="LEFT: 0px; WIDTH: 120px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() sqltrans controltype="combobox" tempvalue="0&#13;&#10;1&#13;&#10;2&#13;&#10;3" temptext="ȫ��&#13;&#10;δ����&#13;&#10;������&#13;&#10;����֤" sql check="1"><OPTION value=0 selected>ȫ��</OPTION><OPTION value=1>δ����</OPTION><OPTION value=2>������</OPTION><OPTION value=3>����֤</OPTION></SELECT></TD>
                     <TD class=c2 width="15%">����ʱ��</TD>
                     <TD width="35%"><INPUT class=its_out id=ACCEPTTIMEMIN style="LEFT: 0px; WIDTH: 44%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" onclick='bill_onclick("SelectDate()")'>&nbsp;��&nbsp;<INPUT class=its_out id=ACCEPTTIMEMAX style="LEFT: 0px; WIDTH: 44%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" onclick='bill_onclick("SelectDate()")'></TD>
                  </TR>
               </TBODY>
            </TABLE>
         </TD>
      </TR>
      <TR>
         <TD align=middle><BUTTON class=button id=button3 style="LEFT: 450px; POSITION: static; TOP: 150px" onmovestart=moveStart() dropstyle="��" controltype="button" onclick='bill_onclick("findCanAvermentCase()")'>��ѯ</BUTTON><BUTTON class=button id=button4 style="LEFT: 550px; POSITION: static; TOP: 150px" onmovestart=moveStart() dropstyle="��" controltype="button" onclick='bill_onclick("resetinfo()")'>����</BUTTON></TD>
      </TR>
      <TR>
         <TD><IMG style="DISPLAY: none" src="undefined"><DIV id=div_ExtGrid1 style="LEFT: 28px; POSITION: static; TOP: 200px"></DIV><SCRIPT type=text/javascript>var ExtGrid1;
Ext.BLANK_IMAGE_URL = '../../fceform/js/Ext/images/default/s.gif';
var ExtGrid1_retint = 0;
var ExtGrid1_onReady = function(){ 
 Ext.QuickTips.init();
var dataset = document.getElementById("caseDataset");
try{var temp = dataset.Fields.Field.length;}catch(e){if(ExtGrid1_retint==0) ExtGrid1_retint = setInterval(ExtGrid1_onReady,200);dataset =null;return;}finally{if(temp!=null)temp=null;}
clearInterval(ExtGrid1_retint);ExtGrid1_retint = null ;var pagesize =10;
dataset.PageSize = pagesize ;
var mapping = creator_pt_getmapping(dataset);
var store  = new Ext.data.Store({
	proxy: new Ext.data.CreatorMemoryProxy("caseDataset"), 
	reader: new Ext.data.XmlStringReader({       record: 'tr',       totalRecords: 'pages'   }, mapping)});
var sm = new Ext.grid.RowSelectionModel({singleSelect: true});
var retcm = creator_pt_getcm(dataset,sm);var cm = new Ext.grid.ColumnModel(retcm);
if(typeof(retcm[0].getCount)!='undefined') sm = retcm[0] ;
 ExtGrid1 = new Ext.grid.GridPanel({
		el: 'div_ExtGrid1',        store: store,
        cm:cm,
		sm: sm,
 			 bodyStyle : 'width:100%',
		viewConfig: {
			forceFit: true		},       loadMask: true,
	width: '100%',
					height: eval(document.body.clientHeight*(parseFloat('60%')))/100,
		split: true,
		region: 'north',
		title:'��ѯ����б�',
		frame:true
		,plugins: new Ext.ux.PanelResizer({
            minHeight: 100        }),
       bbar: new Ext.PagingToolbar({
            pageSize: pagesize,
            store: store,
            displayInfo: true,
            displayMsg:'��ǰ��ʾ�� {0} - {1} ������ {2} ��',            plugins: new Ext.ux.SlidingPager()        })		    });
    var grid=ExtGrid1;
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
/**cm.setHidden(5,true);**/
cm.setHidden(6,true);
cm.setHidden(7,true);
grid.addListener('rowdblclick',initAverment);
ExtGrid1.render();
store.load({params:{start:0, limit:pagesize}});
if(typeof(creator_pt_grids)=='undefined'){creator_pt_grids=new Array();}
creator_pt_grids.push({id:'ExtGrid1',obj:ExtGrid1,dataset:'caseDataset',isEdit:'false'});
if(typeof(onGridPanelLoaded)=='function') setTimeout(onGridPanelLoaded,0);
};
ExtGrid1_onReady();window.onresize=function(){try{ExtGrid1.setWidth(eval(document.body.clientWidth*(parseFloat('95%')))/100);}catch(e){}};</SCRIPT></TD>
      </TR>
      <TR>
         <TD>
            <TABLE cellSpacing=0 cellPadding=0 width=760 border=0>
               <TBODY></TBODY>
            </TABLE>
         </TD>
      </TR>
   </TBODY>
</TABLE>

<?xml:namespace prefix = fc />

<fc:dataset id=caseDataset format="<fields><field><fieldname>WFT_BUSINESS_NUMBER</fieldname><datatype>�ַ�</datatype><displaylabel>�������</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>BU_NAME</fieldname><datatype>�ַ�</datatype><displaylabel>ִ������</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>WFT_TITLE</fieldname><datatype>�ַ�</datatype><displaylabel>��������</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>LTT_NAME</fieldname><datatype>�ַ�</datatype><displaylabel>������(��λ)����</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>LTT_CODE</fieldname><datatype>�ַ�</datatype><displaylabel>֤������</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>WFT_DATE_RETURN_RECEIVE</fieldname><datatype>�ַ�</datatype><displaylabel>����ʱ��</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>WFT_ID</fieldname><datatype>�ַ�</datatype><displaylabel>��������ʵ��ID</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>MIS_ID</fieldname><datatype>�ַ�</datatype><displaylabel>����ʵ��״̬</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>aa</fieldname><datatype>�ַ�</datatype><displaylabel>��֤״̬</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field></fields>" onSetText='bill_ondatasetsettext("<dsid><WFT_BUSINESS_NUMBER></WFT_BUSINESS_NUMBER><BU_NAME></BU_NAME><WFT_TITLE></WFT_TITLE><LTT_NAME></LTT_NAME><LTT_CODE></LTT_CODE><WFT_DATE_RETURN_RECEIVE></WFT_DATE_RETURN_RECEIVE><WFT_ID></WFT_ID><MIS_ID></MIS_ID><aa></aa></dsid>")' onGetText='bill_ondatasetgettext("<dsid><WFT_BUSINESS_NUMBER></WFT_BUSINESS_NUMBER><BU_NAME></BU_NAME><WFT_TITLE></WFT_TITLE><LTT_NAME></LTT_NAME><LTT_CODE></LTT_CODE><WFT_DATE_RETURN_RECEIVE></WFT_DATE_RETURN_RECEIVE><WFT_ID></WFT_ID><MIS_ID></MIS_ID><aa></aa></dsid>")' onValid='bill_ondatasetvalid("<dsid><WFT_BUSINESS_NUMBER></WFT_BUSINESS_NUMBER><BU_NAME></BU_NAME><WFT_TITLE></WFT_TITLE><LTT_NAME></LTT_NAME><LTT_CODE></LTT_CODE><WFT_DATE_RETURN_RECEIVE></WFT_DATE_RETURN_RECEIVE><WFT_ID></WFT_ID><MIS_ID></MIS_ID><aa></aa></dsid>")' opensortno="1" temptable="TMP_DATASET1" multiResult="��"></fc:dataset>

&nbsp;

<fc:dataset id=postilDataset format="<fields><field><fieldname>TP_STATUS</fieldname><datatype>�ַ�</datatype><displaylabel>��ע״̬</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field></fields>" onSetText='bill_ondatasetsettext("<dsid><TP_STATUS></TP_STATUS></dsid>")' onGetText='bill_ondatasetgettext("<dsid><TP_STATUS></TP_STATUS></dsid>")' onValid='bill_ondatasetvalid("<dsid><TP_STATUS></TP_STATUS></dsid>")' opensortno="1" temptable="TMP_DATASET4" multiResult="��"></fc:dataset>
</DIV>
<div id='grid_tip'></div></body></html>
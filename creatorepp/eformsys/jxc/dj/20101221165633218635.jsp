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
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/common/Common.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/common/Common.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/business/ReportStatistics.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/business/ReportStatistics.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/dao/ReportStatisticsDao.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/dao/ReportStatisticsDao.js'></script>");
if(!bDgMode) out.println("</script>");
%>

   <script language='javascript'>
adv_loadjsfile('/eformsys/fceform/css/tabstyle.css');
adv_loadjsfile('/eformsys/fceform/css/Button.css');
adv_loadjsfile('/eformsys/fceform/css/TextStyle.css');
</script>


<!-- ��ʾ������Ϊҳ���Զ���JS���� -->
<script>
<%@page import="com.chinacreator.xzcf.baseservice.menu.OrgAccessUtil "%>
<%
OrgAccessUtil orgAccess = new OrgAccessUtil();
String idName = orgAccess.getLawOrgIdName(accesscontroler.getUserID());
String allZfztId = "";
//��ǰ�û��ɷ��ʵ�����ִ������
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
    var nowDate = nowYear + "-" + nowMonth + "-" + nowDay;
    return nowDate;
}

/*
    ������getFirstDay()
     ˵������ǰϵͳʱ����³�
*/
function getFirstDay(){
    var nowTime = getNowDate();
    var firstDay = nowTime.substring(0,7) + "-01";
    return firstDay;
}

/*
    ������init()
    ˵������ʼ����ѯ������ִ������Ĭ��Ϊ��ǰ��¼�û�����ִ�����壬
           ����ʼʱ��Ĭ��Ϊ��ǰ���ڵ��³���
           �������ʱ��Ĭ��Ϊ��ǰϵͳ���ڡ�
*/
function init(){
    $("orgIds").value = "<%=idTmp %>";
    $("orgNames").value = "<%=nameTmp %>";
    temp = $('orgIds').value;
    $('left_time').value = getFirstDay();
    $('right_time').value = getNowDate();
    if(IsSpace(temp)){//��ǰ�û��������Ų���ִ������
        temp = "<%=allZfztId %>";//���п��Է��ʵ�ִ������ID
    }
    if(IsSpace(temp)){
        alert("��ǰ�û�û�в�ѯȨ��");
        return;
    }
    var url = "20101221084839156441.jsp?"; 
    document.all.reportid.src = url;
}

/*
    ������queryAndStatistics()
    ˵������ѯͳ��20101221084839156441 
*/
function queryAndStatistics(){
    temp = $("orgIds").value;
    if(IsSpace(temp)){//��ǰ�û��������Ų���ִ������
        temp = "<%=allZfztId %>";//���п��Է��ʵ�ִ������ID
    }
    if(IsSpace(temp)){
        alert("��ǰ�û�û�в�ѯȨ��");
        return;
    }
    if(!validated()){
        return;
    }
    var leftTime = $('left_time').value;
    var rightTime = $('right_time').value;
    var url ="20101221084839156441.jsp?";
    document.all.reportid.src = url;
}

//����
function resetButton(){
    $("orgIds").value = "<%=idTmp %>";
    $("orgNames").value = "<%=nameTmp %>";
    $('left_time').value = getFirstDay();
    $('right_time').value = getNowDate();
}

//������֤
function validated(){
    var a = $('left_time').value;//����ʼʱ��
    var b = $('right_time').value;//�������ʱ��
    if(a > b){
        alert("����ʼʱ�䲻�ܴ����������ʱ��");
        return false;
    } else {
        return true;
    }
}

//��ִ��������Դ��
function openUserTree(){
    url = "../../../ccapp/app_xzcf/jsp/baseservice/chooseZfztResourse.jsp";
    chooseUsers = window.showModalDialog(url,window, "dialogWidth=620px;dialogHeight=500px");
}

</script>

<!-- ��ʾ������Ϊҳ��DOMԪ������ -->
<DIV id=SKbillsheet style="visibility:hidden" toolbar="����������" BLONopen="setAuthority();init();" contxml="<root><button><id>button1</id><id>button3</id></button><text><id>orgNames</id><id>left_time</id><id>right_time</id></text></root>" billtaborder="<root><taborder>orgNames</taborder><taborder>left_time</taborder><taborder>right_time</taborder><taborder>button1</taborder><taborder>button3</taborder></root>" dj_sn="20101221165633218635" caption="������Դͳ��" mkbh codeheader="BBB" entertype="�޸�" poswidth posheight controlno="SKButton:0;SKDBedit:0;checkbox:0;label:0;radio:0;listbox:0;textarea:0;combobox:0;password:0;upload:0;SKDBtext:0;chart:0;dbimg:0;img:0;SKBILLgrid:0;shape:0;tab:1;div:0;DsMain_field:0;a:0;button:3;text:3;hr:0;checkboxlist:0;radiolist:0;dropdownlist:0;grid:0;dataset:0;spin:0;excel:0;tree:0;ebshow:0;creatorSubForm:0;creator_div:0;ExtGrid:0;ExtUpload:0;ExtTree:0;Fusionchar:0" window="��ǰ����" posleft postop keyfield isfile="��" OtherSave="��" idtype="1" testDbName="app_xzcf" creatorStyle="creatorBlue" BLONclose="UnLoadWebOffice();" creator_remark hasWorkflowButton="��" creator_elementAuthoritySwitch="��" creator_showAlert="��" creator_office_isBindForm="��" islog="��" isprotect="��" creator_csslib version="1.0" creator_pagination type="ZW" creatorType="20100902181125312621" jslib="fcbasecont.js&#13;&#10;selectdate.js&#13;&#10;~userfunc.js&#13;&#10;fcdate.js&#13;&#10;../../../ccapp/app_xzcf/js/common/Common.js&#13;&#10;../../../ccapp/app_xzcf/js/business/ReportStatistics.js&#13;&#10;../../../ccapp/app_xzcf/js/dao/ReportStatisticsDao.js" creator_allTab="<tabs><tab><id>tab1</id><content><index>0</index><gridid></gridid><iframeid>querymission</iframeid><index>1</index><gridid></gridid><iframeid></iframeid><index>2</index><gridid></gridid><iframeid></iframeid><index>3</index><gridid></gridid><iframeid></iframeid><index>4</index><gridid></gridid><iframeid></iframeid></content></tab></tabs>">

<TABLE cellSpacing=0 cellPadding=0 width="95%" align=center border=0>
   <TBODY>
      <TR>
         <TD>
            <TABLE class=Ctable cellSpacing=0 cellPadding=0 width="100%" border=0>
               <TBODY>
                  <TR>
                     <TD class=taobox colSpan=4>������Դͳ��</TD>
                  </TR>
                  <TR>
                     <TD class=c2 width="15%">ִ������</TD>
                     <TD width="35%"><INPUT id=orgNames style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" onclick='bill_onclick("openUserTree()")'><INPUT id=orgIds type=hidden></TD>
                     <TD class=c2 width="15%">����ʱ��</TD>
                     <TD width="35%"><INPUT class=its_out id=left_time style="LEFT: 0px; WIDTH: 46%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" onclick='bill_onclick("SelectDate()")'>&nbsp;��&nbsp;<INPUT class=its_out id=right_time style="LEFT: 0px; WIDTH: 46%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" onclick='bill_onclick("SelectDate()")'></TD>
                  </TR>
               </TBODY>
            </TABLE>
         </TD>
      </TR>
      <TR>
         <TD align=middle><BUTTON class=button id=button1 style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="��" controltype="button" onclick='bill_onclick("queryAndStatistics()")'>��ѯ</BUTTON><BUTTON class=button id=button3 style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="��" controltype="button" onclick='bill_onclick("resetButton()")'>����</BUTTON></TD>
      </TR>
      <TR>
         <TD><IFRAME id=reportid style="WIDTH: 100%; HEIGHT: 445px" border=0 frameBorder=no></IFRAME></TD>
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
</DIV>
<div id='grid_tip'></div></body></html>
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
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/util/FormUtil.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/util/FormUtil.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/business/YbcxajIndex.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/business/YbcxajIndex.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/common/Common.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/common/Common.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/lock/WDCLLock.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/lock/WDCLLock.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/util/WorkflowUtil.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/util/WorkflowUtil.js'></script>");
if(!bDgMode) out.println("</script>");
%>
<script >document.styleSheets[0].addRule("fc\\:creatorSubForm","behavior: url(../../fceform/htc/creatorSubForm.htc)",0);</script>
   <script language='javascript'>
adv_loadjsfile('/eformsys/fceform/css/tabstyle.css');
adv_loadjsfile('/eformsys/fceform/js/webfxlayout.js');
adv_loadjsfile('/eformsys/fceform/css/luna/tab.css');
</script>


<!-- ��ʾ������Ϊҳ���Զ���JS���� -->
<script>
var wft_id = creator_getQueryString("wft_id");
var pi_id = creator_getQueryString("pi_id");
var readOnlyFlag = creator_getQueryString("readOnlyFlag");
var ndp_id = creator_getQueryString("ndp_id");
var bu_id = creator_getQueryString("bu_id");
var bu_name = creator_getQueryString("bu_name");
var orderNum= "";
var user_id = getSysElement("userId");
var userName = getSysElement("useraccount");


var LockParms = {
    lockTime : 5 * 60, // ����ʱ�� 5����
    brathRate : 4 * 60 * 1000, // ����ʱ�� 4����
    lockResult : "" // �������  
}

/*
     ����:   init
     ˵��:   ʵ���Զ���λ���ػ���
              �Զ���ʾ���ڻ��ں�ǰ�滷��
     ����:   
    ����ֵ: 
*/
function init() {
    if(!IsSpace(wft_id)) {
         releaseLockPage();
         addLock(wft_id);//����
    }
    var djbh = objDjbh();
    var order = 1;
    if(!IsSpace(ndp_id)) {
        order = DBUtil.SqlToField(YbcxajIndex.SelectNDPByOrder(ndp_id));
    } else {
        ndp_id = 1;
    }
    FormUtil.hundredPercentTab($("div1"));
    orderNum = order;
    var num = parseInt(order) + 1;
    var obj= {item : "item"+num+""};
    eval(obj.item).location.href="../../jxc/dj/"+djbh[order]+".jsp?wft_id="+wft_id+"&pi_id="+pi_id+"&ndp_id="+ndp_id+"&bu_id="+bu_id+"&bu_name="+bu_name+"&readOnlyFlag="+readOnlyFlag;
    div1.setSelectedIndex(order);
    controlTabName(ndp_id);    
    $("item"+num+"").style.marginRight = screen.availWidth * 0.02;
}

/**
 * ����
 * 
 * @param {}wftId
 */
function addLock(wftId) {
    //var lockRequest = new Array(); // ������
    /*lockRequest.push({
                lockKey : wftId,
                lockType : 1,
                who : userName,
                time : 5 * 60,
                description : "�û���" + userName + "��������ʵ��:" + wftId
            })*/
    var lockKey = wftId;
    var lockType = 1;
    var who = userName;
    var time = 5 * 60;
    var description = "�û���" + userName + "��������ʵ��:" + wftId;
    var lockResult = getLock(lockKey,lockType,who,time,description);
    if (lockResult != null) {// ������ʧ��
         alert("����ʵ�����ڱ����˴�����ǰֻ�в鿴Ȩ��");
        readOnlyFlag = "readOnly";
    } else { // �������ɹ�
        setTimeout(function() { // ����
                    lockBreath(lockKey, who, time);
                    setTimeout(arguments.callee, LockParms.brathRate);
                }, LockParms.brathRate);
    }
}

function releaseLockPage() {
   releaseLock(wft_id, userName);
}
/**
 * �����뿪�¼�
 */
window.onunload = function() {
    releaseLockPage();
}
</script>

<!-- ��ʾ������Ϊҳ��DOMԪ������ -->
<DIV id=SKbillsheet style="visibility:hidden" toolbar="����������" BLONopen="setAuthority();init();" contxml="<root><tab><id>div1</id></tab><creatorSubForm><id>item1</id><id>item2</id><id>item3</id><id>item4</id><id>item5</id><id>item6</id><id>item7</id><id>item8</id><id>item9</id><id>item10</id><id>item11</id><id>item12</id></creatorSubForm></root>" billtaborder="<root></root>" dj_sn="20101008112101437663" caption="һ����򰸾�" mkbh codeheader="BBB" entertype="�޸�" poswidth posheight controlno="SKButton:0;SKDBedit:0;checkbox:0;label:0;radio:0;listbox:0;textarea:0;combobox:0;password:0;upload:0;SKDBtext:0;chart:0;dbimg:0;img:0;SKBILLgrid:0;shape:0;tab:5;div:0;DsMain_field:0;a:0;button:0;text:2;hr:0;checkboxlist:0;radiolist:0;dropdownlist:0;grid:0;dataset:0;spin:0;excel:0;tree:0;ebshow:0;creatorSubForm:0;creator_div:0;ExtGrid:0;ExtUpload:0;ExtTree:0;Fusionchar:0" window="��ǰ����" posleft postop keyfield isfile="��" OtherSave="��" idtype="1" testDbName="app_xzcf" creatorStyle="creatorBlue" BLONclose="UnLoadWebOffice();" creator_remark hasWorkflowButton="��" creator_elementAuthoritySwitch="��" creator_showAlert="��" creator_office_isBindForm="��" islog="��" isprotect="��" creator_csslib version="1.0" creator_pagination type="ZW" creatorType="20100902181230265751" jslib="fcbasecont.js&#13;&#10;selectdate.js&#13;&#10;~userfunc.js&#13;&#10;fcdate.js&#13;&#10;../../../ccapp/app_xzcf/js/util/FormUtil.js&#13;&#10;../../../ccapp/app_xzcf/js/business/YbcxajIndex.js&#13;&#10;../../../ccapp/app_xzcf/js/common/Common.js&#13;&#10;../../../ccapp/app_xzcf/js/lock/WDCLLock.js&#13;&#10;../../../ccapp/app_xzcf/js/util/WorkflowUtil.js" creator_allTab="<tabs><tab><id>div1</id><content><index>0</index><gridid></gridid><iframeid>item1</iframeid><index>1</index><gridid></gridid><iframeid>item2</iframeid><index>2</index><gridid></gridid><iframeid>item3</iframeid><index>3</index><gridid></gridid><iframeid>item4</iframeid><index>4</index><gridid></gridid><iframeid>item5</iframeid><index>5</index><gridid></gridid><iframeid>item6</iframeid><index>6</index><gridid></gridid><iframeid>item7</iframeid><index>7</index><gridid></gridid><iframeid>item8</iframeid><index>8</index><gridid></gridid><iframeid>item9</iframeid><index>9</index><gridid></gridid><iframeid>item10</iframeid><index>10</index><gridid></gridid><iframeid>item11</iframeid><index>11</index><gridid></gridid><iframeid>item12</iframeid></content></tab></tabs>">

<DIV class=tab-pane id=div1 style="LEFT: 0px; WIDTH: 800px; POSITION: absolute; TOP: 0px; HEIGHT: 600px" showtype="luna" IsHideTitle="��">
   <DIV class=tab-page style="WIDTH: 800px; HEIGHT: 582px">
      <H2 class=tab>����</H2>
      <IFRAME id=item1 style="WIDTH: 100%; POSITION: static; HEIGHT: 100%" onclick=test(); onmovestart=moveStart() src="" frameBorder=no controltype="creatorSubForm" id_load objType="eform" reportname urlargs autoload="no" autoSetSize="no" url=""></IFRAME>
   </DIV>
   <DIV class=tab-page style="WIDTH: 800px; HEIGHT: 582px">
      <H2 class=tab>����</H2>
      <IFRAME id=item2 style="WIDTH: 100%; HEIGHT: 100%" onmovestart=moveStart() src="" frameBorder=no controltype="creatorSubForm" id_load objType="eform" autoload="no" autoSetSize="no" url=""></IFRAME>
   </DIV>
   <DIV class=tab-page style="WIDTH: 800px; HEIGHT: 582px">
      <H2 class=tab>��������</H2>
      <IFRAME id=item3 style="WIDTH: 100%; HEIGHT: 100%" onmovestart=moveStart() src="" frameBorder=no controltype="creatorSubForm" id_load objType="eform" autoload="no" autoSetSize="no" url=""></IFRAME>
   </DIV>
   <DIV class=tab-page style="WIDTH: 800px; HEIGHT: 582px">
      <H2 class=tab>����ȡ֤</H2>
      <IFRAME id=item4 style="WIDTH: 100%; HEIGHT: 100%" onmovestart=moveStart() src="" frameBorder=no controltype="creatorSubForm" id_load objType="eform" autoload="no" autoSetSize="no" url=""></IFRAME>
   </DIV>
   <DIV class=tab-page style="WIDTH: 800px; HEIGHT: 582px">
      <H2 class=tab>�⴦������</H2>
      <IFRAME id=item5 style="WIDTH: 100%; HEIGHT: 100%" onmovestart=moveStart() src="" frameBorder=no controltype="creatorSubForm" id_load objType="eform" autoload="no" autoSetSize="no" url=""></IFRAME>
   </DIV>
   <DIV class=tab-page style="WIDTH: 800px; HEIGHT: 582px">
      <H2 class=tab>��֪</H2>
      <IFRAME id=item6 style="WIDTH: 100%; HEIGHT: 100%" onmovestart=moveStart() src="" frameBorder=no controltype="creatorSubForm" id_load objType="eform" autoload="no" autoSetSize="no" url=""></IFRAME>
   </DIV>
   <DIV class=tab-page style="WIDTH: 800px; HEIGHT: 582px">
      <H2 class=tab>�������</H2>
      <IFRAME id=item7 style="WIDTH: 100%; HEIGHT: 100%" onmovestart=moveStart() src="" frameBorder=no controltype="creatorSubForm" id_load objType="eform" reportname urlargs autoload="no" autoSetSize="no" url=""></IFRAME>
   </DIV>
   <DIV class=tab-page style="WIDTH: 800px; HEIGHT: 582px">
      <H2 class=tab>��֤</H2>
      <IFRAME id=item8 style="WIDTH: 100%; HEIGHT: 100%" onmovestart=moveStart() src="" frameBorder=no controltype="creatorSubForm" id_load objType="eform" autoload="no" autoSetSize="no" url=""></IFRAME>
   </DIV>
   <DIV class=tab-page style="WIDTH: 800px; HEIGHT: 582px">
      <H2 class=tab>���ɴ�������</H2>
      <IFRAME id=item9 style="WIDTH: 100%; HEIGHT: 100%" onmovestart=moveStart() src="" frameBorder=no controltype="creatorSubForm" id_load objType="eform" autoload="no" autoSetSize="no" url=""></IFRAME>
   </DIV>
   <DIV class=tab-page style="WIDTH: 800px; HEIGHT: 582px">
      <H2 class=tab>�ʹ�</H2>
      <IFRAME id=item10 style="WIDTH: 100%; HEIGHT: 100%" onmovestart=moveStart() src="" frameBorder=no controltype="creatorSubForm" id_load objType="eform" autoload="no" autoSetSize="no" url=""></IFRAME>
   </DIV>
   <DIV class=tab-page style="WIDTH: 800px; HEIGHT: 582px">
      <H2 class=tab>ִ��</H2>
      <IFRAME id=item11 style="WIDTH: 100%; HEIGHT: 100%" onmovestart=moveStart() src="" frameBorder=no controltype="creatorSubForm" id_load objType="eform" autoload="no" autoSetSize="no" url=""></IFRAME>
   </DIV>
   <DIV class=tab-page style="WIDTH: 800px; HEIGHT: 582px">
      <H2 class=tab>�᰸�鵵</H2>
      <IFRAME id=item12 style="WIDTH: 100%; HEIGHT: 100%" onmovestart=moveStart() src="" frameBorder=no controltype="creatorSubForm" id_load objType="eform" autoload="no" autoSetSize="no" url=""></IFRAME>
   </DIV>
</DIV>

<SCRIPT>var div1 = new WebFXTabPane( document.getElementById( "div1" ) );</SCRIPT>
</DIV>
<div id='grid_tip'></div></body></html>
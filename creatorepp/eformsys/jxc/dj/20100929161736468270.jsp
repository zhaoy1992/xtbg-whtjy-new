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
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/common/Namespace.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/common/Namespace.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/common/nsreg.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/common/nsreg.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/common/Common.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/common/Common.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/vo/ZfsyVo.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/vo/ZfsyVo.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/business/Zfsy.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/business/Zfsy.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/dao/ZfsyDao.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/dao/ZfsyDao.js'></script>");
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
var USER_ID = getSysElement("userid");
//˫�����������
function editDbjl(grid, rowIndex, e){
    var row = grid.store.getById(grid.store.data.items[rowIndex].id); 
    var wftId= row.get("wft_id");
    var pId= row.get("pi_id");
    var ndpId= row.get("ndp_id");
    var state = row.get("status");
    /*if (state=="����") {
        parent.window.location.href = "20101008112101437663.jsp?wft_id=" + wftId + "&readOnlyFlag=add" + "&pi_id=" + pId;
    } else if (state=="�ݸ�") {
        parent.window.location.href = "20101008112101437663.jsp?wft_id=" + wftId + "&readOnlyFlag=update" + "&pi_id=" + pId;
    } else {*/
        parent.window.location.href = "20101008112101437663.jsp?wft_id=" + wftId + "&readOnlyFlag=readOnly" + "&pi_id=" + pId + "&ndp_id=" + ndpId;
    //}
}

function aj_query(){
    if(!IsSpace($("WFT_FILE_TIME_START").value) && !IsSpace($("WFT_FILE_TIME_END").value) && ($("WFT_FILE_TIME_START").value > $("WFT_FILE_TIME_END").value)){
        alert("������ʼʱ�䲻�ܴ�����������ʱ��");
        return false;
    }
    var obj = new ZfsyVo.Zfsy();
    var vo = DBUtil.getVoFromPage(obj);
    vo.USER_ID = USER_ID;
    var sql = Zfsy.getWorkByVo(vo);
    workquerydataset.Open(sql);
    reloadExtGrid();
}

function aj_reset(){
    ${'IC_ID'}.value = -1;
    ${'LTT_NAME'}.value = "";
    ${'WFT_BUSINESS_NUMBER'}.value = "";
    ${'MIS_ID'}.value = -1;
    ${'WFT_FILE_TIME_START'}.value = "";
    ${'WFT_FILE_TIME_END'}.value = "";
}
</script>

<!-- ��ʾ������Ϊҳ��DOMԪ������ -->
<DIV id=SKbillsheet style="visibility:hidden" toolbar="����������" BLONopen="setAuthority();aj_query();" contxml="<root><combobox><id>IC_ID</id><id>MIS_ID</id></combobox><button><id>queryBtn</id><id>resetBtn</id></button><text><id>LTT_NAME</id><id>WFT_BUSINESS_NUMBER</id><id>WFT_FILE_TIME_START</id><id>WFT_FILE_TIME_END</id></text><dataset><id>workquerydataset</id></dataset><ExtGrid><id>ExtGrid1</id></ExtGrid></root>" billtaborder="<root><taborder>LTT_NAME</taborder><taborder>WFT_BUSINESS_NUMBER</taborder><taborder>IC_ID</taborder><taborder>MIS_ID</taborder><taborder>queryBtn</taborder><taborder>resetBtn</taborder><taborder>WFT_FILE_TIME_START</taborder><taborder>WFT_FILE_TIME_END</taborder></root>" dj_sn="20100929161736468270" caption="ִ����Ա������ѯ" mkbh codeheader="BBB" entertype="չ��" poswidth posheight controlno="SKButton:0;SKDBedit:0;checkbox:0;label:0;radio:0;listbox:0;textarea:0;combobox:3;password:0;upload:0;SKDBtext:0;chart:0;dbimg:0;img:0;SKBILLgrid:0;shape:0;tab:0;div:0;DsMain_field:0;a:0;button:5;text:4;hr:0;checkboxlist:0;radiolist:0;dropdownlist:0;grid:1;dataset:0;spin:0;excel:0;tree:1;ebshow:0;creatorSubForm:0;creator_div:0;ExtGrid:1;ExtUpload:0;ExtTree:1;Fusionchar:0" window="��ǰ����" posleft postop keyfield isfile="��" OtherSave="��" idtype="1" testDbName="app_xzcf" creatorStyle="creatorBlue" BLONclose="UnLoadWebOffice();" creator_remark hasWorkflowButton="��" creator_elementAuthoritySwitch="��" creator_showAlert="��" creator_office_isBindForm="��" islog="��" isprotect="��" creator_csslib version="1.0" creator_pagination type="ZW" creatorType="20100929113705609567" jslib="fcbasecont.js&#13;&#10;selectdate.js&#13;&#10;~userfunc.js&#13;&#10;fcdate.js&#13;&#10;../../../ccapp/app_xzcf/js/common/Namespace.js&#13;&#10;../../../ccapp/app_xzcf/js/common/nsreg.js&#13;&#10;../../../ccapp/app_xzcf/js/common/Common.js&#13;&#10;../../../ccapp/app_xzcf/js/vo/ZfsyVo.js&#13;&#10;../../../ccapp/app_xzcf/js/business/Zfsy.js&#13;&#10;../../../ccapp/app_xzcf/js/dao/ZfsyDao.js">

<TABLE cellSpacing=0 cellPadding=0 width="98%" border=0>
   <TBODY>
      <TR>
         <TD>
            <TABLE class=Ctable cellSpacing=0 cellPadding=0 width="100%" align=center border=0>
               <TBODY>
                  <TR>
                     <TD class=taobox colSpan=4>��ѯ����</TD>
                  </TR>
                  <TR>
                     <TD class=c2>�������</TD>
                     <TD><SELECT id=IC_ID style="LEFT: 0px; WIDTH: 120px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() sqltrans="%F4%D8%E6%D8%D4%F6Xrn%A0%94%CC%A0%96Xr%94%A0%94%CC%AA%90%A8%98Xrn%DA%F2%EC%E8Xrn%B6%90%CC%A0%B6%98%A8%CC%94%90%B6%98%9C%AC%B2%C0" controltype="combobox" tempvalue="-1" temptext="--��ѡ��--" sql check="2"><OPTION value=-1 selected>--��ѡ��--</OPTION></SELECT></TD>
                     <TD class=c2>������(��λ)����</TD>
                     <TD><INPUT class=input_out id=LTT_NAME style="LEFT: 0px; WIDTH: 120px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() size=21 controltype="text"></TD>
                  </TR>
                  <TR>
                     <TD class=c2>�������</TD>
                     <TD><INPUT class=input_out id=WFT_BUSINESS_NUMBER style="LEFT: 0px; WIDTH: 121px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() size=22 controltype="text"></TD>
                     <TD class=c2>����״̬</TD>
                     <TD><SELECT id=MIS_ID style="LEFT: 0px; WIDTH: 120px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() sqltrans="%F4%D8%E6%D8%D4%F6Xrn%A8%A0%B4%CC%A0%96Xr%94%A8%A0%B4%CC%AA%90%A8%98Xrn%DA%F2%EC%E8Xrn%F6%D0%CC%E8%D0%F6%F6%D8%F2%F4%CC%E0%EA%F4%F6%D0%EA%D4%D8%CC%F4%F6%D0%F6%F8%F4" controltype="combobox" tempvalue="-1" temptext="--��ѡ��--" sql check="1"><OPTION value=-1 selected>--��ѡ��--</OPTION></SELECT></TD>
                  </TR>
                  <TR>
                     <TD class=c2>��������</TD>
                     <TD colSpan=3><INPUT class=its_out id=WFT_FILE_TIME_START style="LEFT: 0px; WIDTH: 122px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() size=22 controltype="text" onclick='bill_onclick("SelectDate()")'>��<INPUT class=its_out id=WFT_FILE_TIME_END style="LEFT: 0px; WIDTH: 123px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() size=22 controltype="text" onclick='bill_onclick("SelectDate()")'></TD>
                  </TR>
               </TBODY>
            </TABLE>
         </TD>
      </TR>
      <TR>
         <TD align=middle colSpan=4><BUTTON class=button id=queryBtn style="LEFT: 450px; POSITION: static; TOP: 150px" onmovestart=moveStart() dropstyle="��" controltype="button" onclick='bill_onclick("aj_query()")'>��ѯ</BUTTON>&nbsp;<BUTTON class=button id=resetBtn style="LEFT: 550px; POSITION: static; TOP: 150px" onmovestart=moveStart() dropstyle="��" controltype="button" onclick='bill_onclick("aj_reset()")'>����</BUTTON></TD>
      </TR>
      <TR align=middle>
         <TD></TD>
      </TR>
   </TBODY>
</TABLE>

<?xml:namespace prefix = fc />

<fc:dataset id=workquerydataset format="<fields><field><fieldname>WFT_APPLICATION_NUMBER</fieldname><datatype>�ַ�</datatype><displaylabel>������</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>WFT_BUSINESS_NUMBER</fieldname><datatype>�ַ�</datatype><displaylabel>�������</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>WFT_TITLE</fieldname><datatype>�ַ�</datatype><displaylabel>��������</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>LTT_NAME</fieldname><datatype>�ַ�</datatype><displaylabel>������(��λ)</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>WFT_PLACED_ON_FILE_TIME</fieldname><datatype>�ַ�</datatype><displaylabel>��������</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>NDP_NAME</fieldname><datatype>�ַ�</datatype><displaylabel>����ִ�н׶�</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>status</fieldname><datatype>�ַ�</datatype><displaylabel>����״̬</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>WFT_ID</fieldname><datatype>�ַ�</datatype><displaylabel>��������ʵ��ID</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>MIS_NAME</fieldname><datatype>�ַ�</datatype><displaylabel>����ʵ��״̬</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>PI_ID</fieldname><datatype>�ַ�</datatype><displaylabel>����ID</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>NDP_ID</fieldname><datatype>�ַ�</datatype><displaylabel>�׶�ID</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field></fields>" onSetText='bill_ondatasetsettext("<dsid><WFT_APPLICATION_NUMBER></WFT_APPLICATION_NUMBER><WFT_BUSINESS_NUMBER></WFT_BUSINESS_NUMBER><WFT_TITLE></WFT_TITLE><LTT_NAME></LTT_NAME><WFT_PLACED_ON_FILE_TIME></WFT_PLACED_ON_FILE_TIME><NDP_NAME></NDP_NAME><status></status><WFT_ID></WFT_ID><MIS_NAME></MIS_NAME><PI_ID></PI_ID><NDP_ID></NDP_ID></dsid>")' onGetText='bill_ondatasetgettext("<dsid><WFT_APPLICATION_NUMBER></WFT_APPLICATION_NUMBER><WFT_BUSINESS_NUMBER></WFT_BUSINESS_NUMBER><WFT_TITLE></WFT_TITLE><LTT_NAME></LTT_NAME><WFT_PLACED_ON_FILE_TIME></WFT_PLACED_ON_FILE_TIME><NDP_NAME></NDP_NAME><status></status><WFT_ID></WFT_ID><MIS_NAME></MIS_NAME><PI_ID></PI_ID><NDP_ID></NDP_ID></dsid>")' onValid='bill_ondatasetvalid("<dsid><WFT_APPLICATION_NUMBER></WFT_APPLICATION_NUMBER><WFT_BUSINESS_NUMBER></WFT_BUSINESS_NUMBER><WFT_TITLE></WFT_TITLE><LTT_NAME></LTT_NAME><WFT_PLACED_ON_FILE_TIME></WFT_PLACED_ON_FILE_TIME><NDP_NAME></NDP_NAME><status></status><WFT_ID></WFT_ID><MIS_NAME></MIS_NAME><PI_ID></PI_ID><NDP_ID></NDP_ID></dsid>")' opensortno="1" temptable="TMP_DATASET1" multiResult="��"></fc:dataset>

<IMG style="DISPLAY: none" src="undefined">

<DIV id=div_ExtGrid1 style="POSITION: static"></DIV>

<SCRIPT type=text/javascript>var ExtGrid1;
Ext.BLANK_IMAGE_URL = '../../fceform/js/Ext/images/default/s.gif';
var ExtGrid1_retint = 0;
var ExtGrid1_onReady = function(){ 
 Ext.QuickTips.init();
var dataset = document.getElementById("workquerydataset");
try{var temp = dataset.Fields.Field.length;}catch(e){if(ExtGrid1_retint==0) ExtGrid1_retint = setInterval(ExtGrid1_onReady,200);dataset =null;return;}finally{if(temp!=null)temp=null;}
clearInterval(ExtGrid1_retint);ExtGrid1_retint = null ;var pagesize =5;
dataset.PageSize = pagesize ;
var mapping = creator_pt_getmapping(dataset);
var store  = new Ext.data.Store({
	proxy: new Ext.data.CreatorMemoryProxy("workquerydataset"), 
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
					height: eval(document.body.clientHeight*(parseFloat('58%')))/100,
		split: true,
		region: 'north',
		title:'��ѯ���',
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
cm.setHidden(7,true);
cm.setHidden(9,true);
cm.setHidden(10,true);
grid.addListener('rowdblclick', editDbjl);ExtGrid1.render();
store.load({params:{start:0, limit:pagesize}});
if(typeof(creator_pt_grids)=='undefined'){creator_pt_grids=new Array();}
creator_pt_grids.push({id:'ExtGrid1',obj:ExtGrid1,dataset:'workquerydataset',isEdit:'false'});
if(typeof(onGridPanelLoaded)=='function') setTimeout(onGridPanelLoaded,0);
};
ExtGrid1_onReady();window.onresize=function(){try{ExtGrid1.setWidth(eval(document.body.clientWidth*(parseFloat('95%')))/100);}catch(e){}};</SCRIPT>
</DIV>
<div id='grid_tip'></div></body></html>
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
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/business/PunishDecide.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/business/PunishDecide.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/dao/PunishDecideDao.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/dao/PunishDecideDao.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/vo/PunishDecideVo.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/vo/PunishDecideVo.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/util/HTMLUtil.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/util/HTMLUtil.js'></script>");
if(!bDgMode) out.println("</script>");
%>

   <script language='javascript'>
adv_loadjsfile('/eformsys/fceform/css/tabstyle.css');
adv_loadjsfile('/eformsys/fceform/css/Button.css');
</script>


<!-- ��ʾ������Ϊҳ���Զ���JS���� -->
<script>
var user_id = creator_getQueryString("userid");
var read_only = parent.read_only;
var wft_id = parent.wftId;
var ndp_id = parent.NdpId;
var tempMD_ID = "";
if(user_id == null || user_id == ""){
    user_id = parent.dsr_user_id.value;
}
</script>

<!-- ��ʾ������Ϊҳ��DOMԪ������ -->
<DIV id=SKbillsheet style="visibility:hidden" toolbar="����������" BLONopen="setAuthority();initModuleInfo();" contxml="<root><img><id>pic_path_cfcs_$rmd_id$</id></img><button><id>saveBtn</id></button></root>" billtaborder="<root><taborder>saveBtn</taborder></root>" dj_sn="20101008091744171948" caption="���ɲ�����׼���£�" mkbh codeheader="BBB" entertype="�޸�" poswidth posheight controlno="SKButton:0;SKDBedit:0;checkbox:0;label:0;radio:0;listbox:0;textarea:0;combobox:0;password:0;upload:0;SKDBtext:0;chart:0;dbimg:0;img:0;SKBILLgrid:0;shape:0;tab:0;div:0;DsMain_field:0;a:0;button:3;text:0;hr:0;checkboxlist:0;radiolist:0;dropdownlist:0;grid:0;dataset:0;spin:0;excel:0;tree:0;ebshow:0;creatorSubForm:0;creator_div:0;ExtGrid:0;ExtUpload:0;ExtTree:0;Fusionchar:0" window="��ǰ����" posleft postop keyfield isfile="��" OtherSave="��" idtype="1" testDbName="app_xzcf" creatorStyle="creatorBlue" BLONclose="UnLoadWebOffice();" creator_remark hasWorkflowButton="��" creator_elementAuthoritySwitch="��" creator_showAlert="��" creator_office_isBindForm="��" islog="��" isprotect="��" creator_csslib version="1.0" creator_pagination type="ZW" creatorType="20100902181230265751" jslib="fcbasecont.js&#13;&#10;selectdate.js&#13;&#10;~userfunc.js&#13;&#10;fcdate.js&#13;&#10;../../../ccapp/app_xzcf/js/common/Namespace.js&#13;&#10;../../../ccapp/app_xzcf/js/common/nsreg.js&#13;&#10;../../../ccapp/app_xzcf/js/common/Common.js&#13;&#10;../../../ccapp/app_xzcf/js/business/PunishDecide.js&#13;&#10;../../../ccapp/app_xzcf/js/dao/PunishDecideDao.js&#13;&#10;../../../ccapp/app_xzcf/js/vo/PunishDecideVo.js&#13;&#10;../../../ccapp/app_xzcf/js/util/HTMLUtil.js">

<TABLE class=Ctable cellSpacing=1 cellPadding=1 width="100%">
   <TBODY id=container>
      <TR id=$tmp_wfxw$>
         <TD onclick=changeCFCS(this) width=10 flag="$tmp_cfcs$"><IMG id=pic_path_cfcs_$rmd_id$ style="POSITION: static" src="../../../ccapp/app_xzcf/images/plus.gif" controltype="img" plus.gif? images app_xzcf ccapp .. cover="9" srcsk="../../../ccapp/app_xzcf/images/plus.gif"></IMG></TD>
      <TD class=c2 width="15%">Υ����Ϊ����</TD>
      <TD width="80%" colSpan=3>$wfxwmc$</TD>
   </TR>
   <TR id=$tmp_cfcs$>
      <TD colSpan=5>
         <TABLE cellSpacing=0 cellPadding=0 width="100%">
            <TBODY>
               <TR>
                  <TD class=c2 width="15%">������ʩ</TD>
                  <TD colSpan=3>$cfcs$</TD>
               </TR>
               <TR>
                  <TD class=taobox colSpan=4>���ɲ�����׼�ο�</TD>
               </TR>
               <TR>
                  <TD class=c2 width="30%">Υ���̶�</TD>
                  <TD class=c2 width="30%">Υ������</TD>
                  <TD class=c2 width="40%" colSpan=2>������׼����</TD>
               </TR>
               <TR id=$tmp_zycl$ flag="$rmd_id$" callback="addZYCLBZ">
                  <TD width="15%">$zycldjmc$</TD>
                  <TD width="35%">$zycldjnr$</TD>
                  <TD colSpan=2><LABEL><INPUT id=rd_$rdd_flag$ onclick=selectCFCSXX(this) type=radio value=$rdd_id$ name=t flag="$rdd_flag$">$zycldjcfbz$</INPUT></TD>
               </TR>
               <TR>
                  <TD colSpan=4>
                     <TABLE id=$tmp_cfcsmc$ cellSpacing=0 cellPadding=0 width="100%">
                        <TBODY>
                           <TR>
                              <TD class=c2 width="50%">������ʩ</TD>
                              <TD class=c2 width="50%">��������(��)</TD>
                           </TR>
                           <TR id=$tmp_cfcsmc_child$>
                              <TD width="50%"><LABEL><INPUT id=cb_$tmp_cfcsmc_child$_$pm_id$ type=checkbox value=$pm_id$ name=checkbox>$cfcsmc$</INPUT></TD>
                              <TD width="50%"><INPUT id=tf_$tmp_cfcsmc_child$_$pm_id$ name=textfield></TD>
                           </TR>
                        </TBODY>
                     </TABLE>
                  </TD>
               </TR>
               <TR>
                  <TD class=c2 width="15%">ִ������</TD>
                  <TD width="35%" colSpan=3><TEXTAREA id=tx_zfyj_$rmd_id$ style="WIDTH: 100%; POSITION: static; HEIGHT: 55px; TEXT-ALIGN: left" name=textarea readOnly controltype>$zfyj_info$</TEXTAREA></TD>
               </TR>
               <TR>
                  <TD class=c2 width="15%">��������</TD>
                  <TD colSpan=3><TEXTAREA id=tx_cfyj_$rmd_id$ style="WIDTH: 100%; POSITION: static; HEIGHT: 55px; TEXT-ALIGN: left" name=textarea readOnly>$cfyj_info$</TEXTAREA></TD>
               </TR>
               <TR id=cfje_$rmd_id$>
                  <TD class=c2 width="15%">�������</TD>
                  <TD colSpan=3><INPUT id=tx_cfje_$rmd_id$ onmouseout=getFKJE() name=textfield>��Ԫ��</TD>
               </TR>
            </TBODY>
         </TABLE>
      </TD>
   </TR>
   <TR id=opsFlag>
      <TD class=c2 colSpan=2>�ܽ��</TD>
      <TD><INPUT id=tx_fkzje readOnly name=textfield>��Ԫ��</TD>
      <TD class=c2>ʵ�ʽ��</TD>
      <TD><INPUT id=tx_fksjje name=textfield>��Ԫ��</TD>
   </TR>
   <TR>
      <TD align=middle colSpan=6><BUTTON class=button id=saveBtn style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="��" controltype="button" onclick='bill_onclick("savePunishDecideInfo();")'>����</BUTTON></TD>
   </TR>
</TBODY>
</TABLE>
</DIV>
<div id='grid_tip'></div></body></html>
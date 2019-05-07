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
		
		//根据应用确定样式的目录
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
		            <TD><DIV style="BORDER-RIGHT: skyblue 2px solid; BORDER-TOP: skyblue 2px solid; FONT-SIZE: 15px; BACKGROUND: #ffffff; BORDER-LEFT: skyblue 2px solid; WIDTH: 150px; PADDING-TOP: 9px; BORDER-BOTTOM: skyblue 2px solid; HEIGHT: 40px; solid: #000000">正在加载……</DIV></TD>
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

<!-- 提示：以下为页面的JS&CSS内容 -->
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
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/vo/vo.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/vo/vo.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/dao/BusinessUnitDao.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/dao/BusinessUnitDao.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/business/BusinessUnit.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/business/BusinessUnit.js'></script>");
if(!bDgMode) out.println("</script>");
%>

   <script >document.styleSheets[0].addRule("fc\\:dataset","behavior: url(../../fceform/htc/dataset.htc)",0);</script>
   <script language='javascript'>
adv_loadjsfile('/eformsys/fceform/css/tabstyle.css');
adv_loadjsfile('/eformsys/fceform/js/webfxlayout.js');
adv_loadjsfile('/eformsys/fceform/css/luna/tab.css');
adv_loadjsfile('/eformsys/fceform/css/Button.css');
adv_loadjsfile('/eformsys/fceform/css/TextStyle.css');
adv_loadjsfile('/eformsys/fceform/js/fcdataset.js');
adv_loadjsfile('/eformsys/fceform/js/Ext/SlidingPager.js');
adv_loadjsfile('/eformsys/fceform/js/Ext/SliderTip.js');
adv_loadjsfile('/eformsys/fceform/js/Ext/PanelResizer.js');
adv_loadjsfile('/eformsys/fceform/js/Ext/XmlTextReader.js');
adv_loadjsfile('/eformsys/fceform/js/Ext/CreatorMemoryProxy.js');
</script>


<!-- 提示：以下为页面自定义JS内容 -->
<script>
//初始化列表
function init(){
   businessUnitQueryList();
   lawUserQueryList();
}

//查询执法主体信息
function businessUnitQueryList(){
     var zfzt_Name = $("BU_NAME").value;
     var zfzt_Id = $("BU_BRIEF_CODE").value;
     var zfzt_Qz_IsNo = $("BU_COERCIVE_POWER").value;
     var zfzt_Zt_IsNo = $("BU_VALID").value;
    
   var pagePrams={ 
          zfzt_Name:zfzt_Name,
          zfzt_Id:zfzt_Id,
          zfzt_Qz_IsNo:zfzt_Qz_IsNo,
          zfzt_Zt_IsNo:zfzt_Zt_IsNo       
   }
  
    var sql = BusinessUnit.queryZfzt(pagePrams);
    businessUnitDataset.Open(sql);
    reloadExtGrid();
}

//查询执法人员信息
function lawUserQueryList(){
    var USER_ID = $("USER_ID").value;
     var ELU_DOCUMENT_NO = $("ELU_DOCUMENT_NO").value;
     var BU_ID = $("BU_ID").value;
     var state = $("state").value; 
     var ELU_CERTIFICATION_DATE = $("ELU_CERTIFICATION_DATE").value;
     var ELU_CERTIFICATION_DATE1 = $("ELU_CERTIFICATION_DATE1").value;
     var Prams = { 
          USER_ID:USER_ID,
          ELU_DOCUMENT_NO:ELU_DOCUMENT_NO,
          BU_ID:BU_ID,
          state:state,
          ELU_CERTIFICATION_DATE:ELU_CERTIFICATION_DATE ,
          ELU_CERTIFICATION_DATE1:ELU_CERTIFICATION_DATE1           
   }
    var sql = BusinessUnit.lawUser(Prams);
    dataset4.Open(sql);
    reloadExtGrid();
}

//执法主体信息查询重置
function businessUnitReset(){
    $("BU_NAME").value = "";
    $("BU_BRIEF_CODE").value = "";
    $("BU_COERCIVE_POWER").value = "";
    $("BU_VALID").value = "";

}

//执法人员信息查询重置
function lawUserReset(){
     $("USER_ID").value="";
     $("ELU_DOCUMENT_NO").value="";
     $("BU_ID").value="";
     $("state").value="";
     $("ELU_CERTIFICATION_DATE").value="";
     $("ELU_CERTIFICATION_DATE1").value="";
}

//执法主体导出excel
function businessUnitExcel(){

}

//执法人员导出excel
function lawUserExcel(){

}

//执法主体新增跳转
function addBusinessUnitLoad(){
   var tempPara="dialogWidth:800px;dialogHeight:600px;";
   var tempURL="20100902193731453898.jsp";
   showModalDialog(tempURL,"window",tempPara);
   reloadExtGrid();
}

//执法主体删除
function delBusinessUnit(){
    var grid =  creator_pt_grids[1].obj;
    alert(grid);
    var ids = FormUtil.getExtGridSelectedIds('user_id', grid);
    alert(ids.length);
    alert('a');
    alert(ids);
    if(ids.length==0){    
       alert("请选择要删除的记录！");
       return false;
    } else if (confirm('是否要删除所选数据?')) {
       var rv = BusinessUnit.delBusinessUnit(ids);
       if(rv){
          alert("删除数据信息成功！");
       }else{
           alert("删除数据信息失败！");
       }
     reloadExtGrid();
    }
}
</script>

<!-- 提示：以下为页面DOM元素内容 -->
<DIV id=SKbillsheet style="visibility:hidden" toolbar="不带工具栏" BLONopen="setAuthority();init();" contxml="<root><combobox><id>BU_COERCIVE_POWER</id><id>BU_VALID</id><id>state</id></combobox><tab><id>tab3</id></tab><div><id>div2</id></div><button><id>button3</id><id>button4</id><id>button5</id><id>button6</id><id>button7</id><id>button9</id><id>button10</id><id>button13</id></button><text><id>BU_NAME</id><id>BU_BRIEF_CODE</id><id>USER_ID</id><id>ELU_DOCUMENT_NO</id><id>BU_ID</id><id>ELU_CERTIFICATION_DATE</id><id>ELU_CERTIFICATION_DATE1</id><id>zfzt_name</id></text><dataset><id>businessUnitDataset</id><id>dataset4</id></dataset><ExtGrid><id>ExtGrid1</id><id>ExtGrid6</id></ExtGrid></root>" billtaborder="<root><taborder>zfzt_name</taborder><taborder>BU_COERCIVE_POWER</taborder><taborder>BU_VALID</taborder><taborder>button3</taborder><taborder>button4</taborder><taborder>button5</taborder><taborder>button6</taborder><taborder>button7</taborder><taborder>button9</taborder><taborder>button10</taborder><taborder>button13</taborder><taborder>BU_NAME</taborder><taborder>BU_BRIEF_CODE</taborder><taborder>USER_ID</taborder><taborder>ELU_DOCUMENT_NO</taborder><taborder>BU_ID</taborder><taborder>ELU_CERTIFICATION_DATE</taborder><taborder>ELU_CERTIFICATION_DATE1</taborder><taborder>state</taborder></root>" dj_sn="20100902193122890559" caption="test1" mkbh codeheader="BBB" entertype="展现" poswidth posheight controlno="SKButton:0;SKDBedit:0;checkbox:0;label:0;radio:1;listbox:0;textarea:0;combobox:2;password:0;upload:0;SKDBtext:0;chart:0;dbimg:0;img:0;SKBILLgrid:0;shape:0;tab:0;div:0;DsMain_field:0;a:0;button:0;text:0;hr:0;checkboxlist:0;radiolist:0;dropdownlist:0;grid:0;dataset:4;spin:0;excel:0;tree:0;ebshow:0;creatorSubForm:0;creator_div:0;ExtGrid:6;ExtUpload:0;ExtTree:0;Fusionchar:0" window="当前窗口" posleft postop keyfield isfile="否" OtherSave="否" idtype="1" testDbName="app_xzcf" creatorStyle="creatorBlue" BLONclose="UnLoadWebOffice();" creator_remark hasWorkflowButton="否" creator_elementAuthoritySwitch="否" creator_showAlert="是" creator_office_isBindForm="否" islog="否" isprotect="是" creator_csslib version="1.0" creator_pagination type="ZW" creatorType="20100902181546343920" jslib="fcbasecont.js&#13;&#10;selectdate.js&#13;&#10;~userfunc.js&#13;&#10;fcdate.js&#13;&#10;../../../ccapp/app_xzcf/js/common/Namespace.js&#13;&#10;../../../ccapp/app_xzcf/js/common/nsreg.js&#13;&#10;../../../ccapp/app_xzcf/js/common/Common.js&#13;&#10;../../../ccapp/app_xzcf/js/vo/vo.js&#13;&#10;../../../ccapp/app_xzcf/js/dao/BusinessUnitDao.js&#13;&#10;../../../ccapp/app_xzcf/js/business/BusinessUnit.js" creator_allTab="<tabs><tab><id>tab3</id><content><index>0</index><gridid></gridid><iframeid></iframeid><index>1</index><gridid></gridid><iframeid></iframeid></content></tab></tabs>">

<TABLE style="POSITION: static" cellSpacing=0 cellPadding=1 width="95%" align=center border=1>
   <TBODY>
      <TR>
         <TD height=25></TD>
      </TR>
      <TR>
         <TD><DIV id=div2 style="BORDER-RIGHT: black 1px solid; BORDER-TOP: black 1px solid; LEFT: 0px; OVERFLOW: auto; BORDER-LEFT: black 1px solid; WIDTH: 100%; BORDER-BOTTOM: black 1px solid; POSITION: static; TOP: 0px; HEIGHT: 600px; BACKGROUND-COLOR: #ffffff" onmovestart=moveStart() controltype="div" NotBg="否"><DIV class=tab-pane id=tab3 style="LEFT: 0px; WIDTH: 934px; POSITION: absolute; TOP: 0px; HEIGHT: 600px" showtype="luna" IsHideTitle="否"><DIV class=tab-page style="WIDTH: 934px; HEIGHT: 582px"><H2 class=tab>执法主体信息查询</H2>
                     <TABLE style="POSITION: static" cellSpacing=1 cellPadding=1 width="100%" align=center border=1>
                        <TBODY>
                           <TR>
                              <TD align=left colSpan=4>执法主体信息查询</TD>
                           </TR>
                           <TR>
                              <TD align=right width="15%">执法主体</TD>
                              <TD width="35%"><INPUT id=BU_NAME style="LEFT: 0px; WIDTH: 228px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() size=39 controltype="text"></TD>
                              <TD align=right width="15%">执法编号</TD>
                              <TD><INPUT id=BU_BRIEF_CODE style="LEFT: 0px; WIDTH: 228px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() size=39 controltype="text"></TD>
                           </TR>
                           <TR>
                              <TD align=right width="15%">是否具有强制权</TD>
                              <TD width="35%"><SELECT id=BU_COERCIVE_POWER style="LEFT: 0px; WIDTH: 120px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() sqltrans controltype="combobox" tempvalue="&#13;&#10;1&#13;&#10;0" temptext="---请选择---&#13;&#10;是&#13;&#10;否" sql check="1" backwidth="120" backheight="25"><OPTION value="" selected>---请选择---</OPTION><OPTION value=1>是</OPTION><OPTION value=0>否</OPTION></SELECT></TD>
                              <TD align=right width="15%">状态</TD>
                              <TD><SELECT id=BU_VALID style="LEFT: 0px; WIDTH: 120px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() sqltrans controltype="combobox" tempvalue="&#13;&#10;1&#13;&#10;0" temptext="---请选择---&#13;&#10;有效&#13;&#10;无效" sql check="1" backwidth="120" backheight="25"><OPTION value="" selected>---请选择---</OPTION><OPTION value=1>有效</OPTION><OPTION value=0>无效</OPTION></SELECT></TD>
                           </TR>
                           <TR>
                              <TD align=middle colSpan=4><BUTTON id=button3 style="LEFT: 0px; WIDTH: 75px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("businessUnitQueryList()")'>查询</BUTTON><BUTTON id=button4 style="LEFT: 0px; WIDTH: 75px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("businessUnitReset()")'>重置</BUTTON><BUTTON id=button5 style="LEFT: 0px; WIDTH: 75px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("exportExcel();")'>导出excel</BUTTON></TD>
                           </TR>
                        </TBODY>
                     </TABLE>
                     <TABLE style="WIDTH: 100%; POSITION: static" cellSpacing=0 cellPadding=0 width=100 align=left border=1>
                        <TBODY>
                           <TR>
                              <TD align=right><BUTTON id=button6 style="LEFT: 0px; WIDTH: 75px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("addBusinessUnitLoad()")'>新增</BUTTON><BUTTON id=button7 style="LEFT: 786px; WIDTH: 75px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("delBusinessUnit()")'>删除</BUTTON></TD>
                           </TR>
                           <TR>
                              <TD>&nbsp;<?xml:namespace prefix = fc /><fc:dataset id=businessUnitDataset showtypeXml="<root><showType><name>checkbox</name><showRule>%5B%7Bshowtype%3A%27checkbox%27%7D%5D</showRule></showType></root>" columnHeight1Xml="undefined" columnWidth1Xml="undefined" format="<fields><field><fieldname>checkbox</fieldname><datatype>字符</datatype><displaylabel>选择</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype><showRule>%5B%7Bshowtype%3A%27checkbox%27%7D%5D</showRule></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>BU_NAME</fieldname><datatype>字符</datatype><displaylabel>执法主体</displaylabel><size>150</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>BU_BRIEF_CODE</fieldname><datatype>字符</datatype><displaylabel>执法编号</displaylabel><size>4</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>BU_LEGAL_PERSON</fieldname><datatype>字符</datatype><displaylabel>法人代表</displaylabel><size>20</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>VC_ID</fieldname><datatype>字符</datatype><displaylabel>行业规则</displaylabel><size>22</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>BU_COERCIVE_POWER</fieldname><datatype>字符</datatype><displaylabel>是否具有强制权</displaylabel><size>22</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>AD_ID</fieldname><datatype>字符</datatype><displaylabel>行政区划</displaylabel><size>20</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>count_people</fieldname><datatype>字符</datatype><displaylabel>人数</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>BU_VALID</fieldname><datatype>字符</datatype><displaylabel>是否有效</displaylabel><size>22</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>BU_ID</fieldname><datatype>字符</datatype><displaylabel>执法主体ID</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field></fields>" onSetText='bill_ondatasetsettext("<dsid><checkbox></checkbox><BU_NAME></BU_NAME><BU_BRIEF_CODE></BU_BRIEF_CODE><BU_LEGAL_PERSON></BU_LEGAL_PERSON><VC_ID></VC_ID><BU_COERCIVE_POWER></BU_COERCIVE_POWER><AD_ID></AD_ID><count_people></count_people><BU_VALID></BU_VALID><BU_ID></BU_ID></dsid>")' onGetText='bill_ondatasetgettext("<dsid><checkbox></checkbox><BU_NAME></BU_NAME><BU_BRIEF_CODE></BU_BRIEF_CODE><BU_LEGAL_PERSON></BU_LEGAL_PERSON><VC_ID></VC_ID><BU_COERCIVE_POWER></BU_COERCIVE_POWER><AD_ID></AD_ID><count_people></count_people><BU_VALID></BU_VALID><BU_ID></BU_ID></dsid>")' onValid='bill_ondatasetvalid("<dsid><checkbox></checkbox><BU_NAME></BU_NAME><BU_BRIEF_CODE></BU_BRIEF_CODE><BU_LEGAL_PERSON></BU_LEGAL_PERSON><VC_ID></VC_ID><BU_COERCIVE_POWER></BU_COERCIVE_POWER><AD_ID></AD_ID><count_people></count_people><BU_VALID></BU_VALID><BU_ID></BU_ID></dsid>")' opensortno="1" temptable="TMP_DATASET1" multiResult="是"></fc:dataset><IMG style="DISPLAY: none" src="undefined"><DIV id=div_ExtGrid1 style="LEFT: 0px; POSITION: static; TOP: 0px"></DIV><SCRIPT type=text/javascript>var ExtGrid1;
Ext.BLANK_IMAGE_URL = '../../fceform/js/Ext/images/default/s.gif';
var ExtGrid1_retint = 0;
var ExtGrid1_onReady = function(){ 
 Ext.QuickTips.init();
var dataset = document.getElementById("businessUnitDataset");
try{var temp = dataset.Fields.Field.length;}catch(e){if(ExtGrid1_retint==0) ExtGrid1_retint = setInterval(ExtGrid1_onReady,200);dataset =null;return;}finally{if(temp!=null)temp=null;}
clearInterval(ExtGrid1_retint);ExtGrid1_retint = null ;var pagesize =10;
dataset.PageSize = pagesize ;
var mapping = creator_pt_getmapping(dataset);
var store  = new Ext.data.Store({
	proxy: new Ext.data.CreatorMemoryProxy("businessUnitDataset"), 
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
		width:0,      height:0,		split: true,
		region: 'north',
		title:'执法主体信息列表',
		frame:true
		,plugins: new Ext.ux.PanelResizer({
            minHeight: 100        }),
       bbar: new Ext.PagingToolbar({
            pageSize: pagesize,
            store: store,
            displayInfo: true,
            displayMsg:'当前显示第 {0} - {1} 条，共 {2} 条',            plugins: new Ext.ux.SlidingPager()        })		    });
    var grid=ExtGrid1;
		grid.getStore().on('datachanged', function() {
		var hd_checker = grid.getEl().select('div.x-grid3-hd-checker');
		var hd = hd_checker.first();
		if(hd != null){ 
			hd.removeClass('x-grid3-hd-checker-on');
		}
});

/**
使用说明                      
1.注释不要用 //。
2.可以操作当前Grid的sm、cm、store对象。
3.这里的代码用于一些个性化的需求，如某列的某些特定工作。
**/
ExtGrid1.render();
store.load({params:{start:0, limit:pagesize}});
if(typeof(creator_pt_grids)=='undefined'){creator_pt_grids=new Array();}
creator_pt_grids.push({id:'ExtGrid1',obj:ExtGrid1,dataset:'businessUnitDataset',isEdit:'false'});
if(typeof(onGridPanelLoaded)=='function') setTimeout(onGridPanelLoaded,0);
};
ExtGrid1_onReady();</SCRIPT></TD>
                           </TR>
                        </TBODY>
                     </TABLE>
                  </DIV>
                  <DIV class=tab-page style="WIDTH: 934px; HEIGHT: 582px">
                     <H2 class=tab>执法人员信息查询</H2>
                     <TABLE cellSpacing=0 cellPadding=0 width="100%" align=center border=1>
                        <TBODY>
                           <TR>
                              <TD colSpan=6>执法人员信息查询</TD>
                           </TR>
                           <TR>
                              <TD align=right width="13%">姓名</TD>
                              <TD align=left width="20%"><INPUT id=USER_ID style="LEFT: 0px; WIDTH: 147px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() size=26 controltype="text"></TD>
                              <TD align=right width="13%">证件编号</TD>
                              <TD width="20%"><INPUT id=ELU_DOCUMENT_NO style="LEFT: 0px; WIDTH: 147px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() size=26 controltype="text"></TD>
                              <TD align=right width="13%">所属执法主体</TD>
                              <TD>&nbsp;<INPUT id=BU_ID style="LEFT: 0px; WIDTH: 150px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() size=27 controltype="text"></TD>
                           </TR>
                           <TR>
                              <TD align=right width="13%">状态</TD>
                              <TD align=left width="20%"><SELECT id=state style="LEFT: 0px; WIDTH: 120px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() sqltrans controltype="combobox" tempvalue="&#13;&#10;1&#13;&#10;0" temptext="---请选择---&#13;&#10;有效&#13;&#10;无效" sql check="1" backwidth="120" backheight="25"><OPTION value="" selected>---请选择---</OPTION><OPTION value=1>有效</OPTION><OPTION value=0>无效</OPTION></SELECT></TD>
                              <TD align=right width="13%">发证日期</TD>
                              <TD colSpan=3><INPUT id=ELU_CERTIFICATION_DATE style="LEFT: 0px; WIDTH: 146px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() size=24 controltype="text" onclick='bill_onclick("SelectDate()")'>至<INPUT id=ELU_CERTIFICATION_DATE1 style="LEFT: 0px; WIDTH: 148px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() size=26 controltype="text" onclick='bill_onclick("SelectDate()")'></TD>
                           </TR>
                           <TR>
                              <TD align=middle colSpan=6>&nbsp;<BUTTON id=button9 style="LEFT: 0px; WIDTH: 75px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("lawUserQueryList();")'>查询</BUTTON><BUTTON id=button10 style="LEFT: 0px; WIDTH: 75px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("lawUserReset()")'>重置</BUTTON><BUTTON id=button13 style="LEFT: 0px; WIDTH: 75px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="否" controltype="button">导出excel</BUTTON></TD>
                           </TR>
                           <TR>
                              <TD colSpan=6>&nbsp;</TD>
                           </TR>
                        </TBODY>
                     </TABLE>
                     <fc:dataset id=dataset4 showtypeXml="<root><showType><name>checkBox</name><showRule>%5B%7BRule%3A%27%u6761%u4EF6%27%2Cshowtype%3A%27checkBox%27%7D%2C%7BRule%3A%27%u6761%u4EF6%27%2Cshowtype%3A%27%u663E%u793A%u65B9%u5F0F%27%7D%5D</showRule></showType><showType><name>checkec</name><showRule>%5B%7BRule%3A%27%u6761%u4EF6%27%2Cshowtype%3A%27checkec%27%7D%2C%7BRule%3A%27%u6761%u4EF6%27%2Cshowtype%3A%27%u663E%u793A%u65B9%u5F0F%27%7D%5D</showRule></showType><showType><name>a</name><showRule>%5B%7BRule%3A%27%u6761%u4EF6%27%2Cshowtype%3A%27a%27%7D%2C%7BRule%3A%27%u6761%u4EF6%27%2Cshowtype%3A%27%u663E%u793A%u65B9%u5F0F%27%7D%5D</showRule></showType><showType><name>checkbox</name><showRule>%5B%7Bshowtype%3A%27checkbox%27%7D%5D</showRule></showType></root>" columnHeight1Xml="undefined" columnWidth1Xml="undefined" format="<fields><field><fieldname>checkbox</fieldname><datatype>字符</datatype><displaylabel>选择</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype><showRule>%5B%7Bshowtype%3A%27checkbox%27%7D%5D</showRule></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>USER_ID</fieldname><datatype>字符</datatype><displaylabel>姓名</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>ELU_DOCUMENT_NO</fieldname><datatype>字符</datatype><displaylabel>证件编号</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>ELU_LICENCE</fieldname><datatype>字符</datatype><displaylabel>发证机关</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>BWT_ID</fieldname><datatype>字符</datatype><displaylabel>执法类别</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>ELU_CERTIFICATION_DATE</fieldname><datatype>字符</datatype><displaylabel>发证日期</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>ELU_END_DATE</fieldname><datatype>字符</datatype><displaylabel>失效日期</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>ELU_STATUS</fieldname><datatype>字符</datatype><displaylabel>状态</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field></fields>" onSetText='bill_ondatasetsettext("<dsid><checkbox></checkbox><USER_ID></USER_ID><ELU_DOCUMENT_NO></ELU_DOCUMENT_NO><ELU_LICENCE></ELU_LICENCE><BWT_ID></BWT_ID><ELU_CERTIFICATION_DATE></ELU_CERTIFICATION_DATE><ELU_END_DATE></ELU_END_DATE><ELU_STATUS></ELU_STATUS></dsid>")' onGetText='bill_ondatasetgettext("<dsid><checkbox></checkbox><USER_ID></USER_ID><ELU_DOCUMENT_NO></ELU_DOCUMENT_NO><ELU_LICENCE></ELU_LICENCE><BWT_ID></BWT_ID><ELU_CERTIFICATION_DATE></ELU_CERTIFICATION_DATE><ELU_END_DATE></ELU_END_DATE><ELU_STATUS></ELU_STATUS></dsid>")' onValid='bill_ondatasetvalid("<dsid><checkbox></checkbox><USER_ID></USER_ID><ELU_DOCUMENT_NO></ELU_DOCUMENT_NO><ELU_LICENCE></ELU_LICENCE><BWT_ID></BWT_ID><ELU_CERTIFICATION_DATE></ELU_CERTIFICATION_DATE><ELU_END_DATE></ELU_END_DATE><ELU_STATUS></ELU_STATUS></dsid>")' opensortno="1" temptable="TMP_DATASET4" multiResult="否"></fc:dataset>
                     <IMG style="DISPLAY: none" src="undefined">
                     <DIV id=div_ExtGrid6 style="LEFT: 0px; POSITION: static; TOP: 0px"></DIV>
                     <SCRIPT type=text/javascript>var ExtGrid6;
Ext.BLANK_IMAGE_URL = '../../fceform/js/Ext/images/default/s.gif';
var ExtGrid6_retint = 0;
var ExtGrid6_onReady = function(){ 
 Ext.QuickTips.init();
var dataset = document.getElementById("dataset4");
try{var temp = dataset.Fields.Field.length;}catch(e){if(ExtGrid6_retint==0) ExtGrid6_retint = setInterval(ExtGrid6_onReady,200);dataset =null;return;}finally{if(temp!=null)temp=null;}
clearInterval(ExtGrid6_retint);ExtGrid6_retint = null ;var pagesize =10;
dataset.PageSize = pagesize ;
var mapping = creator_pt_getmapping(dataset);
var store  = new Ext.data.Store({
	proxy: new Ext.data.CreatorMemoryProxy("dataset4"), 
	reader: new Ext.data.XmlStringReader({       record: 'tr',       totalRecords: 'pages'   }, mapping)});
var sm = new Ext.grid.RowSelectionModel({singleSelect: true});
var retcm = creator_pt_getcm(dataset,sm);var cm = new Ext.grid.ColumnModel(retcm);
if(typeof(retcm[0].getCount)!='undefined') sm = retcm[0] ;
 ExtGrid6 = new Ext.grid.GridPanel({
		el: 'div_ExtGrid6',        store: store,
        cm:cm,
		sm: sm,
 			 bodyStyle : 'width:100%',
		viewConfig: {
			forceFit: true		},       loadMask: true,
		width:0,      height:0,		split: true,
		region: 'north',
		title:'执法人员列表',
		frame:true
		,plugins: new Ext.ux.PanelResizer({
            minHeight: 100        }),
       bbar: new Ext.PagingToolbar({
            pageSize: pagesize,
            store: store,
            displayInfo: true,
            displayMsg:'当前显示第 {0} - {1} 条，共 {2} 条',            plugins: new Ext.ux.SlidingPager()        })		    });
    var grid=ExtGrid6;
		grid.getStore().on('datachanged', function() {
		var hd_checker = grid.getEl().select('div.x-grid3-hd-checker');
		var hd = hd_checker.first();
		if(hd != null){ 
			hd.removeClass('x-grid3-hd-checker-on');
		}
});

/**
使用说明                      
1.注释不要用 //。
2.可以操作当前Grid的sm、cm、store对象。
3.这里的代码用于一些个性化的需求，如某列的某些特定工作。
**/
ExtGrid6.render();
store.load({params:{start:0, limit:pagesize}});
if(typeof(creator_pt_grids)=='undefined'){creator_pt_grids=new Array();}
creator_pt_grids.push({id:'ExtGrid6',obj:ExtGrid6,dataset:'dataset4',isEdit:'false'});
if(typeof(onGridPanelLoaded)=='function') setTimeout(onGridPanelLoaded,0);
};
ExtGrid6_onReady();</SCRIPT>
                  </DIV>
               </DIV>
               <SCRIPT>var tab3 = new WebFXTabPane( document.getElementById( "tab3" ) );</SCRIPT>
            </DIV>
            <P>&nbsp;</P>
            <P>&nbsp;</P>
            <P>&nbsp;</P>
            <TABLE style="POSITION: static" cellSpacing=0 cellPadding=0 width=760 align=left border=0>
               <TBODY>
                  <TR>
                     <TD></TD>
                  </TR>
               </TBODY>
            </TABLE>
            <INPUT id=zfzt_name style="DISPLAY: none; LEFT: 0px; WIDTH: 110px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text">
         </TD>
      </TR>
      <TR></TR>
   </TBODY>
</TABLE>
</TR>
</TBODY>
</TABLE>
</DIV>
<div id='grid_tip'></div></body></html>
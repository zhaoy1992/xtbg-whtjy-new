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
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/business/ZhglBiz.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/business/ZhglBiz.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/dao/ZhglDao.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/dao/ZhglDao.js'></script>");
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


<!-- 提示：以下为页面自定义JS内容 -->
<script>
<%@page import="com.chinacreator.xzcf.baseservice.menu.OrgAccessUtil "%>
<%
OrgAccessUtil orgAccess = new OrgAccessUtil();
String idName = orgAccess.getLawOrgIdName(accesscontroler.getUserID());
String queryName = orgAccess.getBuIdByOrgIds(accesscontroler.getUserID()) ;
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

//获取当前用户
var orgname = getSysElement("userorgname");
var user = getSysElement("username");
var user_id = getSysElement("userid");
/*if(user_id==1){
    user_id = 2 ;
}*/

//初始化函数
function init(){
    $("bu_id").value = "<%=idTmp %>";
    $("bu_name").value = "<%=nameTmp %>";
    $("orgNames").value = $("bu_name").value ;
    $("orgIds").value = $("bu_id").value ;
    
    queryBusinessUnit(); //查询执法主体信息
     businessLoad(); //加载执法主体信息
     queryBut(); //加载初始化查询
}


//查询执法主体信息
function queryBusinessUnit(){
    var sql = ZhglBiz.queryBussinessUnitBiz(user_id);
    dataset2.Open(sql);
}

//加载执法主体信息
function businessLoad(){
    var bu_name = dataset2.Fields.Field["bu_name"].Value ;
    var org_id = dataset2.Fields.Field["org_id"].Value ;
    $("bu_id").value = org_id ;
    $("bu_name").value = bu_name ;
}

//加载违法行为信息
function issuseLoad(){
    var bu_id = dataset2.Fields.Field["bu_id"].Value;
    bu_id = 644 ;
    var sql = ZhglBiz.queryIssuesBiz(bu_id);
    dataset2.Open(sql);
    dataset1.MoveFirst();
    var temp = "";
    for( var i = 0 ; i < dataset2.RecordCount ; i++){
        if(temp==""){
            temp = dataset2.Fields.Field["pi_id"].Value;
        } else {
            temp = temp + "," + dataset2.Fields.Field["pi_id"].Value;
        }
        dataset2.MoveNext(); 
    }
    var pi_id = temp ; 
    return pi_id ;  
}

//选择违法行为函数
function selWfxw(){
    PI_ID = issuseLoad() ;
    if(IsSpace(PI_ID)){
        PI_ID = 0 ;
    }
    WFT_ID = 0 ;
    var tempPara="dialogWidth:760px;dialogHeight:400px;";
    var tempURL="20101014084224921532.jsp?PI_ID=" + PI_ID + "&WFT_ID=" + WFT_ID ;
    var tmp = showModalDialog(tempURL,window,tempPara);
    if (!IsSpace(tmp)) {
        var name_tmp = tmp.names;
        var id_tmp = tmp.ids;
        $("RMD_NAME").value = name_tmp ;
        $("RMD_ID").value = tmp.ids ;
    }
}

//案件类型的选择函数
function checkType(){
    var tmp = document.getElementsByName('RGWFT_CASE_TYPE');
    var temp = "" ;
    for(var i = 0 ; i<tmp.length ; i++){
        if(tmp[i].checked==true){
            temp = tmp[i].value ;
        }
    }
    return temp ;
}

//查询函数
function queryBut(){
   var bu_name = $("bu_id").value.trim() ; //执法主体名称
    var IS_ID = $("IS_ID").value ; //案件来源
    var LTT_NAME = $("LTT_NAME").value.trim() ; //当事人(单位)名称
    var LTT_CODE = $("LTT_CODE").value.trim() ; //当事人证件号码
    var WFT_ADDRESS = $("WFT_ADDRESS").value.trim() ; //案发地址
    var RMD_NAME = $("RMD_NAME").value.trim() ; //违法行为
    var WFT_APPLICATION_NUMBER = $("WFT_APPLICATION_NUMBER").value.trim() ; //案件受理编号
    var WFT_TITLE = $("WFT_TITLE").value.trim() ; //案件标题
    var NDP_ID = $("NDP_ID").value ; //当前阶段
    var WFT_DATE_RETURN_RECEIVE = $("WFT_DATE_RETURN_RECEIVE").value ; //受理开始时间
    var WFT_DATE_RETURN_RECEIVE1 = $("WFT_DATE_RETURN_RECEIVE1").value ; //受理结束时间
    var WFT_PLACED_ON_FILE_TIME = $("WFT_PLACED_ON_FILE_TIME").value ; //立案开始时间 
    var WFT_PLACED_ON_FILE_TIME1 = $("WFT_PLACED_ON_FILE_TIME1").value ; //立案结束时间 
    var WFT_CASE_TYPE = checkType() ;   //案件类型  
    var pagePrams = { //界面元素封装成json对象
            bu_name:bu_name,
          IS_ID:IS_ID,
          LTT_NAME:LTT_NAME,
          LTT_CODE:LTT_CODE,
          WFT_ADDRESS:WFT_ADDRESS,
          RMD_NAME:RMD_NAME,
          WFT_APPLICATION_NUMBER:WFT_APPLICATION_NUMBER,
          WFT_TITLE:WFT_TITLE,
          NDP_ID:NDP_ID,
          WFT_DATE_RETURN_RECEIVE:WFT_DATE_RETURN_RECEIVE,
          WFT_DATE_RETURN_RECEIVE1:WFT_DATE_RETURN_RECEIVE1,
          WFT_PLACED_ON_FILE_TIME:WFT_PLACED_ON_FILE_TIME,
          WFT_PLACED_ON_FILE_TIME1:WFT_PLACED_ON_FILE_TIME1,
          WFT_CASE_TYPE:WFT_CASE_TYPE,
          queryName:"<%=queryName%>"
   }
   var sql = ZhglBiz.advancedQueryBiz(pagePrams);
   dataset1.Open(sql);
   reloadExtGrid(); 
}

//重置函数
function resetBut(){
    $("bu_id").value = "<%=idTmp %>";
    $("bu_name").value = "<%=nameTmp %>";
    $("orgNames").value = "" ;
    $("orgIds").value = "" ;
    $("IS_ID").value = -1 ;
    $("LTT_NAME").value = "" ;
    $("LTT_CODE").value = "" ;
    $("WFT_ADDRESS").value = "" ;
    $("RMD_ID").value = "" ;
    $("RMD_NAME").value = "" ;
    $("WFT_APPLICATION_NUMBER").value = "" ;
    $("WFT_TITLE").value = "" ;
    $("NDP_ID").value = -1 ;
    var tmp = document.getElementsByName('RGWFT_CASE_TYPE');
    tmp[2].checked = true ;
    $("WFT_DATE_RETURN_RECEIVE").value = "" ;
    $("WFT_DATE_RETURN_RECEIVE1").value = "" ;
    $("WFT_PLACED_ON_FILE_TIME").value = "" ;
    $("WFT_PLACED_ON_FILE_TIME1").value = "" ;  
} 

//打开执法主体的选择
function openOrgTree(){
    url = "../../../ccapp/app_xzcf/jsp/baseservice/chooseZfztResourse.jsp";
    $("orgNames").value = $("bu_name").value ;
    $("orgIds").value = $("bu_id").value ;
    chooseUsers = window.showModalDialog(url,window, "dialogWidth=620px;dialogHeight=500px");
    $("bu_name").value = $("orgNames").value ;
    $("bu_id").value  = $("orgIds").value ;

}
//导出Excel
function outPutExcel(){
    var title = "高级综合管理查询";
    var Wft_Application_Number="案件受理编号";
    var bu_names="执法主体";
    var wft_title="案件标题";
    var ltt_name="当事人";
    var ltt_code="证件号码";
    var wft_address="案发地址";
    var rmd_name="违法行为";
    var is_name="案件来源";
    var ndp_name="当前阶段";
    var mis_name="案件状态";
    var WFT_DATE_RETURN_RECEIVE="受理时间";
    var WFT_PLACED_ON_FILE_TIME="立案时间";
    var wft_case_type="案件类型";
    //以上几个变量名与模板的字段头一致
    var id = "HeightZhglQuery";
    //上面的id为配置文件对应的
    var bu_id = $("bu_id").value.trim() ; //执法主体名称
    var IS_ID = $("IS_ID").value ; //案件来源
    var LTT_NAME = $("LTT_NAME").value.trim() ; //当事人(单位)名称
    var LTT_CODE = $("LTT_CODE").value.trim() ; //当事人证件号码
    var WFT_ADDRESS = $("WFT_ADDRESS").value.trim() ; //案发地址
    var RMD_NAME = $("RMD_NAME").value.trim() ; //违法行为
    var WFT_APPLICATION_NUMBER = $("WFT_APPLICATION_NUMBER").value.trim() ; //案件受理编号
    var WFT_TITLE = $("WFT_TITLE").value.trim() ; //案件标题
    var NDP_ID = $("NDP_ID").value ; //当前阶段
    var WFT_DATE_RETURN_RECEIVES = $("WFT_DATE_RETURN_RECEIVE").value ; //受理开始时间
    var WFT_DATE_RETURN_RECEIVE1 = $("WFT_DATE_RETURN_RECEIVE1").value ; //受理结束时间
    var WFT_PLACED_ON_FILE_TIMES = $("WFT_PLACED_ON_FILE_TIME").value ; //立案开始时间 
    var WFT_PLACED_ON_FILE_TIME1 = $("WFT_PLACED_ON_FILE_TIME1").value ; //立案结束时间 
    var WFT_CASE_TYPE = checkType() ;   //案件类型  
    var queryName = "<%=queryName%>" ;
    
    
  var url="<%=request.getContextPath() %>/ccapp/app_xzcf/excel/jsp/poiCommond.jsp";
  url+="?title="+title+"&Wft_Application_Number="+Wft_Application_Number+"&bu_name="+bu_names;
  url+="&wft_title="+wft_title+"&ltt_name="+ltt_name+"&ltt_code="+ltt_code ;
  url+="&wft_address="+wft_address+"&rmd_name="+rmd_name+"&is_name="+is_name ;
  url+="&ndp_name="+ndp_name+"&mis_name="+mis_name+"&WFT_DATE_RETURN_RECEIVE="+WFT_DATE_RETURN_RECEIVE ;
  url+="&WFT_PLACED_ON_FILE_TIME="+WFT_PLACED_ON_FILE_TIME+"&wft_case_type="+wft_case_type+"&id="+id ;
  url+="&bu_id="+bu_id+"&IS_ID="+IS_ID+"&LTT_NAME="+LTT_NAME ;
  url+="&LTT_CODE="+LTT_CODE+"&WFT_ADDRESS="+WFT_ADDRESS+"&RMD_NAME="+RMD_NAME ;
  url+="&WFT_APPLICATION_NUMBER="+WFT_APPLICATION_NUMBER+"&WFT_TITLE="+WFT_TITLE ;
  url+="&NDP_ID="+NDP_ID+"&WFT_DATE_RETURN_RECEIVES="+WFT_DATE_RETURN_RECEIVES ;
  url+="&WFT_DATE_RETURN_RECEIVE1="+WFT_DATE_RETURN_RECEIVE1 ;
  url+="&WFT_PLACED_ON_FILE_TIMES="+WFT_PLACED_ON_FILE_TIMES+"&WFT_PLACED_ON_FILE_TIME1="+WFT_PLACED_ON_FILE_TIME1 ;
  url+="&WFT_CASE_TYPE="+WFT_CASE_TYPE+"&queryName="+queryName ;

   window.location.href=url;
}
</script>

<!-- 提示：以下为页面DOM元素内容 -->
<DIV id=SKbillsheet style="visibility:hidden" toolbar="不带工具栏" BLONopen="setAuthority();init();" contxml="<root><radio><id>WFT_CASE_TYPE</id></radio><combobox><id>IS_ID</id><id>NDP_ID</id></combobox><img><id>img2</id><id>img0</id></img><button><id>button1</id><id>button2</id><id>button3</id></button><text><id>bu_name</id><id>bu_id</id><id>orgNames</id><id>orgIds</id><id>LTT_NAME</id><id>LTT_CODE</id><id>WFT_ADDRESS</id><id>RMD_NAME</id><id>RMD_ID</id><id>WFT_APPLICATION_NUMBER</id><id>WFT_TITLE</id><id>WFT_DATE_RETURN_RECEIVE</id><id>WFT_DATE_RETURN_RECEIVE1</id><id>WFT_PLACED_ON_FILE_TIME</id><id>WFT_PLACED_ON_FILE_TIME1</id></text><dataset><id>dataset2</id><id>dataset1</id></dataset><ExtGrid><id>ExtGrid6</id></ExtGrid></root>" billtaborder="<root><taborder>bu_name</taborder><taborder>WFT_CASE_TYPE</taborder><taborder>IS_ID</taborder><taborder>NDP_ID</taborder><taborder>LTT_NAME</taborder><taborder>LTT_CODE</taborder><taborder>WFT_ADDRESS</taborder><taborder>WFT_APPLICATION_NUMBER</taborder><taborder>WFT_TITLE</taborder><taborder>WFT_DATE_RETURN_RECEIVE</taborder><taborder>WFT_DATE_RETURN_RECEIVE1</taborder><taborder>WFT_PLACED_ON_FILE_TIME</taborder><taborder>WFT_PLACED_ON_FILE_TIME1</taborder><taborder>button1</taborder><taborder>button2</taborder><taborder>bu_id</taborder><taborder>RMD_NAME</taborder><taborder>RMD_ID</taborder><taborder>button3</taborder><taborder>orgNames</taborder><taborder>orgIds</taborder></root>" dj_sn="20101026171315609921" caption="高级综合管理查询" mkbh codeheader="BBB" entertype="修改" poswidth posheight controlno="SKButton:0;SKDBedit:0;checkbox:0;label:0;radio:1;listbox:0;textarea:0;combobox:3;password:0;upload:0;SKDBtext:0;chart:0;dbimg:0;img:0;SKBILLgrid:0;shape:0;tab:0;div:0;DsMain_field:0;a:0;button:3;text:15;hr:0;checkboxlist:0;radiolist:0;dropdownlist:0;grid:1;dataset:4;spin:0;excel:0;tree:0;ebshow:0;creatorSubForm:0;creator_div:0;ExtGrid:6;ExtUpload:1;ExtTree:0;Fusionchar:0" window="当前窗口" posleft postop keyfield isfile="否" OtherSave="否" idtype="1" testDbName="app_xzcf" creatorStyle="creatorBlue" BLONclose="UnLoadWebOffice();" creator_remark hasWorkflowButton="否" creator_elementAuthoritySwitch="否" creator_showAlert="是" creator_office_isBindForm="否" islog="否" isprotect="是" creator_csslib version="1.0" creator_pagination type="ZW" creatorType="20100902181125312621" jslib="fcbasecont.js&#13;&#10;selectdate.js&#13;&#10;~userfunc.js&#13;&#10;fcdate.js&#13;&#10;../../../ccapp/app_xzcf/js/common/Namespace.js&#13;&#10;../../../ccapp/app_xzcf/js/common/nsreg.js&#13;&#10;../../../ccapp/app_xzcf/js/common/Common.js&#13;&#10;../../../ccapp/app_xzcf/js/business/ZhglBiz.js&#13;&#10;../../../ccapp/app_xzcf/js/dao/ZhglDao.js">

&nbsp;

<TABLE cellSpacing=0 cellPadding=0 width="95%" align=center border=0>
   <TBODY>
      <TR>
         <TD>
            <TABLE class=Ctable cellSpacing=0 cellPadding=0 width="100%" align=center border=0>
               <TBODY>
                  <TR>
                     <TD class=taobox colSpan=4>处罚案件信息查询</TD>
                  </TR>
                  <TR>
                     <TD class=c2 align=right width="15%">执法主体</TD>
                     <TD align=left width="35%"><INPUT id=bu_name style="LEFT: 0px; WIDTH: 90%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" onclick='bill_onclick("openOrgTree();")'><IMG id=img2 style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() src="../../../ccapp/app_xzcf/images/search12.gif" controltype="img" onclick='bill_onclick("openOrgTree();")' cover="9" srcsk="../../../ccapp/app_xzcf/images/search12.gif"><INPUT id=bu_id style="DISPLAY: none; LEFT: 0px; WIDTH: 2%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=82 controltype="text"><INPUT id=orgNames style="DISPLAY: none; LEFT: 0px; WIDTH: 2%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=78 controltype="text"><INPUT id=orgIds style="DISPLAY: none; LEFT: 0px; WIDTH: 2%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=132 controltype="text"></TD>
                     <TD class=c2 align=right width="15%">案件来源</TD>
                     <TD align=left><SELECT id=IS_ID style="LEFT: 0px; WIDTH: 50%; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() sqltrans="%F4%D8%E6%D8%D4%F6Xrn%E0%F4%CC%E0%D6Xr%94%E0%F4%CC%EA%D0%E8%D8Xrn%DA%F2%EC%E8Xrn%B6%90%CC%A0%AA%9A%AC%CC%B4%AC%B8%B2%94%98" controltype="combobox" tempvalue="-1" temptext="---请选择---" sql check="2"><OPTION value=-1 selected>---请选择---</OPTION></SELECT></TD>
                  </TR>
                  <TR>
                     <TD class=c2 align=right width="15%">当事人(单位)名称</TD>
                     <TD align=left width="35%"><INPUT id=LTT_NAME style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text"></TD>
                     <TD class=c2 align=right width="15%">当事人证件号码</TD>
                     <TD align=left><INPUT id=LTT_CODE style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text"></TD>
                  </TR>
                  <TR>
                     <TD class=c2 align=right width="15%">案发地址</TD>
                     <TD align=left width="35%"><INPUT id=WFT_ADDRESS style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text"></TD>
                     <TD class=c2 align=right width="15%">违法行为</TD>
                     <TD align=left><INPUT id=RMD_NAME style="LEFT: 0px; WIDTH: 90%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text"><IMG id=img0 style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() src="../../../ccapp/app_xzcf/images/search12.gif" controltype="img" onclick='bill_onclick("selWfxw();")' cover="9" srcsk="../../../ccapp/app_xzcf/images/search12.gif"><INPUT id=RMD_ID style="DISPLAY: none; LEFT: 0px; WIDTH: 35px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=6 controltype="text"></TD>
                  </TR>
                  <TR>
                     <TD class=c2 align=right width="15%">案件受理编号</TD>
                     <TD align=left width="35%"><INPUT id=WFT_APPLICATION_NUMBER style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text"></TD>
                     <TD class=c2 align=right width="15%">案件标题</TD>
                     <TD align=left><INPUT id=WFT_TITLE style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text"></TD>
                  </TR>
                  <TR>
                     <TD class=c2 align=right width="15%">当前阶段</TD>
                     <TD align=left width="35%"><SELECT id=NDP_ID style="LEFT: 0px; WIDTH: 50%; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() sqltrans="%F4%D8%E6%D8%D4%F6Xrn%EA%D6%EE%CC%E0%D6Xr%94%EA%D6%EE%CC%EA%D0%E8%D8Xrn%DA%F2%EC%E8Xrn%B6%90%CC%AA%AC%B2%A8%90%A6%CC%96%A0%B4%94%A0%AE%A6%A0%AA%90%B2%C0%CC%AE%B2%AC%94Xrn%FC%DE%D8%F2%D8Xrn%F2%EC%FC%AA%F8%E8Xt%94%7C" controltype="combobox" tempvalue="-1" temptext="---请选择---" sql check="2"><OPTION value=-1 selected>---请选择---</OPTION></SELECT></TD>
                     <TD class=c2 align=right width="15%">案件类型</TD>
                     <TD align=left><FIELDSET id=WFT_CASE_TYPE contentEditable=false style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 288px; COLOR: #000000; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() controltype="radio" tempvalue="1&#13;&#10;2&#13;&#10;0" temptext="一般程序&#13;&#10;简易程序&#13;&#10;全部" aspect="横向" legend NotBg="否" value="0"><INPUT type=radio value=1 name=RGWFT_CASE_TYPE text="一般程序"><SPAN onclick=RGWFT_CASE_TYPE[0].checked=true;WFT_CASE_TYPE.value=RGWFT_CASE_TYPE[0].value;RGWFT_CASE_TYPE[0].focus();>一般程序</SPAN><INPUT type=radio value=2 name=RGWFT_CASE_TYPE text="简易程序"><SPAN onclick=RGWFT_CASE_TYPE[1].checked=true;WFT_CASE_TYPE.value=RGWFT_CASE_TYPE[1].value;RGWFT_CASE_TYPE[1].focus();>简易程序</SPAN><INPUT type=radio CHECKED value=0 name=RGWFT_CASE_TYPE text="全部"><SPAN onclick=RGWFT_CASE_TYPE[2].checked=true;WFT_CASE_TYPE.value=RGWFT_CASE_TYPE[2].value;RGWFT_CASE_TYPE[2].focus();>全部</SPAN></FIELDSET></TD>
                  </TR>
                  <TR>
                     <TD class=c2 align=right width="15%">受理时间</TD>
                     <TD align=left><INPUT class=its_out id=WFT_DATE_RETURN_RECEIVE style="LEFT: 0px; WIDTH: 40%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" onclick='bill_onclick("SelectDate()")'>至<INPUT class=its_out id=WFT_DATE_RETURN_RECEIVE1 style="LEFT: 0px; WIDTH: 40%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" onclick='bill_onclick("SelectDate()")'></TD>
                     <TD class=c2 align=right width="15%">立案时间</TD>
                     <TD align=left><INPUT class=its_out id=WFT_PLACED_ON_FILE_TIME style="LEFT: 0px; WIDTH: 40%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" onclick='bill_onclick("SelectDate()")'>至<INPUT class=its_out id=WFT_PLACED_ON_FILE_TIME1 style="LEFT: 0px; WIDTH: 40%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" onclick='bill_onclick("SelectDate()")'></TD>
                  </TD>
               </TR>
               <TR>
                  <TD align=middle colSpan=4><BUTTON class=button id=button1 style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("queryBut();")'>查询</BUTTON><BUTTON class=button id=button2 style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("resetBut();")'>重置</BUTTON><BUTTON class=button id=button3 style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("outPutExcel();")'>Excel导出</BUTTON></TD>
               </TR>
            </TBODY>
         </TABLE>
      </TD>
   </TR>
   <TR>
      <TD colSpan=4><IMG style="DISPLAY: none" src="undefined"><DIV id=div_ExtGrid6 style="LEFT: 0px; POSITION: static; TOP: 0px"></DIV><SCRIPT type=text/javascript>var ExtGrid6;
Ext.BLANK_IMAGE_URL = '../../fceform/js/Ext/images/default/s.gif';
var ExtGrid6_retint = 0;
var ExtGrid6_onReady = function(){ 
 Ext.QuickTips.init();
var dataset = document.getElementById("dataset1");
try{var temp = dataset.Fields.Field.length;}catch(e){if(ExtGrid6_retint==0) ExtGrid6_retint = setInterval(ExtGrid6_onReady,200);dataset =null;return;}finally{if(temp!=null)temp=null;}
clearInterval(ExtGrid6_retint);ExtGrid6_retint = null ;var pagesize =10;
dataset.PageSize = pagesize ;
var mapping = creator_pt_getmapping(dataset);
var store  = new Ext.data.Store({
	proxy: new Ext.data.CreatorMemoryProxy("dataset1"), 
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
	width: '100%',
					height: eval(document.body.clientHeight*(parseFloat('50%')))/100,
		split: true,
		region: 'north',
		title:'查询结果列表',
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
creator_pt_grids.push({id:'ExtGrid6',obj:ExtGrid6,dataset:'dataset1',isEdit:'false'});
if(typeof(onGridPanelLoaded)=='function') setTimeout(onGridPanelLoaded,0);
};
ExtGrid6_onReady();window.onresize=function(){try{ExtGrid6.setWidth(eval(document.body.clientWidth*(parseFloat('95%')))/100);}catch(e){}};</SCRIPT><?xml:namespace prefix = fc /><fc:dataset id=dataset2 format="<fields><field><fieldname>bu_id</fieldname><datatype>字符</datatype><displaylabel>执法主体编号</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>bu_name</fieldname><datatype>字符</datatype><displaylabel>执法主体名称</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>org_id</fieldname><datatype>字符</datatype><displaylabel>机构编号</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>pi_id</fieldname><datatype>字符</datatype><displaylabel>事项编号</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field></fields>" onSetText='bill_ondatasetsettext("<dsid><bu_id></bu_id><bu_name></bu_name><org_id></org_id><pi_id></pi_id></dsid>")' onGetText='bill_ondatasetgettext("<dsid><bu_id></bu_id><bu_name></bu_name><org_id></org_id><pi_id></pi_id></dsid>")' onValid='bill_ondatasetvalid("<dsid><bu_id></bu_id><bu_name></bu_name><org_id></org_id><pi_id></pi_id></dsid>")' opensortno="1" temptable="TMP_DATASET4" multiResult="是"></fc:dataset><fc:dataset id=dataset1 format="<fields><field><fieldname>Wft_Application_Number</fieldname><datatype>字符</datatype><displaylabel>案件受理编号</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>bu_name</fieldname><datatype>字符</datatype><displaylabel>执法主体</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>wft_title</fieldname><datatype>字符</datatype><displaylabel>案件标题</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>ltt_name</fieldname><datatype>字符</datatype><displaylabel>当事人</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>ltt_code</fieldname><datatype>字符</datatype><displaylabel>证件号码</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>wft_address</fieldname><datatype>字符</datatype><displaylabel>案发地址</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>rmd_name</fieldname><datatype>字符</datatype><displaylabel>违法行为</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>is_name</fieldname><datatype>字符</datatype><displaylabel>案件来源</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>ndp_name</fieldname><datatype>字符</datatype><displaylabel>当前阶段</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>mis_name</fieldname><datatype>字符</datatype><displaylabel>案件状态</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>WFT_DATE_RETURN_RECEIVE</fieldname><datatype>字符</datatype><displaylabel>受理时间</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>WFT_PLACED_ON_FILE_TIME</fieldname><datatype>字符</datatype><displaylabel>立案时间</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>wft_case_type</fieldname><datatype>字符</datatype><displaylabel>案件类型</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field></fields>" onSetText='bill_ondatasetsettext("<dsid><Wft_Application_Number></Wft_Application_Number><bu_name></bu_name><wft_title></wft_title><ltt_name></ltt_name><ltt_code></ltt_code><wft_address></wft_address><rmd_name></rmd_name><is_name></is_name><ndp_name></ndp_name><mis_name></mis_name><WFT_DATE_RETURN_RECEIVE></WFT_DATE_RETURN_RECEIVE><WFT_PLACED_ON_FILE_TIME></WFT_PLACED_ON_FILE_TIME><wft_case_type></wft_case_type></dsid>")' onGetText='bill_ondatasetgettext("<dsid><Wft_Application_Number></Wft_Application_Number><bu_name></bu_name><wft_title></wft_title><ltt_name></ltt_name><ltt_code></ltt_code><wft_address></wft_address><rmd_name></rmd_name><is_name></is_name><ndp_name></ndp_name><mis_name></mis_name><WFT_DATE_RETURN_RECEIVE></WFT_DATE_RETURN_RECEIVE><WFT_PLACED_ON_FILE_TIME></WFT_PLACED_ON_FILE_TIME><wft_case_type></wft_case_type></dsid>")' onValid='bill_ondatasetvalid("<dsid><Wft_Application_Number></Wft_Application_Number><bu_name></bu_name><wft_title></wft_title><ltt_name></ltt_name><ltt_code></ltt_code><wft_address></wft_address><rmd_name></rmd_name><is_name></is_name><ndp_name></ndp_name><mis_name></mis_name><WFT_DATE_RETURN_RECEIVE></WFT_DATE_RETURN_RECEIVE><WFT_PLACED_ON_FILE_TIME></WFT_PLACED_ON_FILE_TIME><wft_case_type></wft_case_type></dsid>")' opensortno="1" temptable="TMP_DATASET1" multiResult="否"></fc:dataset></TD>
   </TR>
   <TR>
      <TD colSpan=4>
         <TABLE cellSpacing=0 cellPadding=0 width=760 border=0>
            <TBODY>
               <TR>
                  <TD></TD>
               </TR>
            </TBODY>
         </TABLE>
      </TD>
   </TR>
</TBODY>
</TABLE>
</DIV>
<div id='grid_tip'></div></body></html>
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
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/util/DateUtil.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/util/DateUtil.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/vo/vo.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/vo/vo.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/business/BusinessUnit.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/business/BusinessUnit.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/dao/BusinessUnitDao.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/dao/BusinessUnitDao.js'></script>");
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
<%@page import="com.chinacreator.xzcf.baseservice.menu.OrgAccessUtil "%>
<%
OrgAccessUtil orgAccess = new OrgAccessUtil();
String idName = orgAccess.getLawOrgIdName(accesscontroler.getUserID());
String queryName = "";
if (!"1".equals(accesscontroler.getUserID())) {
    queryName = orgAccess.getBuIdByOrgIds(accesscontroler.getUserID()) ;
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
var buId=creator_getQueryString("BU_ID");
var user_id = getSysElement("userid");
var id = "" ;
var name = "" ;
var queryIds = "0";

//初始化列表
function init(){
   $("BU_NAMES").readOnly = true ; //所属执法主体只读
   $("buNames").readOnly = true ; //所属执法主体只读
   $("buIds").value = "<%=idTmp %>";
   $("buNames").value = "<%=nameTmp %>";
   $("orgNames").value = $("buNames").value ;
   $("orgIds").value = $("buIds").value ;
   
   $("BU_ID").value = "<%=idTmp %>";
   $("BU_NAMES").value = "<%=nameTmp %>";
   $("orgNames").value = $("BU_NAMES").value ;
   $("orgIds").value = $("BU_ID").value ;

   lawUserQueryList();
   businessUnitQueryList();
}

//双击修改执法主体信息
function updateBusinessUnit(grid, rowIndex, e){
    var row = grid.store.getById(grid.store.data.items[rowIndex].id); 
    var buId = row.get("bu_id");
    var buName = row.get("bu_name");
    var tempPara="dialogWidth:800px;dialogHeight:600px;";
    var tempURL="20100902193731453898.jsp?BU_ID="+buId+"&BU_NAME="+buName;
    //window.location.href(tempURL);
    showModalDialog(tempURL,"window",tempPara);
    reloadExtGrid();
}

//双击修改执法人员信息
function updateLawUser(grid, rowIndex, e){
    var row = grid.store.getById(grid.store.data.items[rowIndex].id); 
    var userId= row.get("user_id");
    var buId = row.get("bu_id");
    var buName = row.get("bu_name");
    var tempPara="dialogWidth:800px;dialogHeight:320px;";
    var tempURL="20100902194102000659.jsp?userId="+userId;
    tempURL += "&bu_id=" + buId + "&bu_name=" + buName;
    showModalDialog(tempURL,"window",tempPara);
    reloadExtGrid();
}

//查询执法主体信息
function businessUnitQueryList(){
     if (user_id==1){
         queryIds = BusinessUnit.getAllBuIds();
     } else {
         queryIds = "<%=queryName%>";
     }
     if (queryIds=="") {
         queryIds="0";
     }
     var zfzt_Name = $("orgIds").value.trim();
     var zfzt_Id = $("BU_BRIEF_CODE").value.trim();
     var tmp = document.getElementsByName('radiobutton');
        if (tmp[0].checked) {
            cl_enable1 = tmp[0].value ;
        } else if (tmp[1].checked) {
            cl_enable1 = tmp[1].value ;
        } else {
            cl_enable1 = -1 ;
        } 
     var zfzt_Qz_IsNo = cl_enable1;   
     var tmp1 = document.getElementsByName('state');
        if (tmp1[0].checked) {
            cl_enable2 = tmp1[0].value ;
        } else if (tmp1[1].checked) {
            cl_enable2 = tmp1[1].value ;
        } else {
            cl_enable2 = -1 ;
        }
     var zfzt_Zt_IsNo = cl_enable2;
     var pagePrams= { 
          zfzt_Name:zfzt_Name,
          zfzt_Id:zfzt_Id,
          zfzt_Qz_IsNo:zfzt_Qz_IsNo,
          zfzt_Zt_IsNo:zfzt_Zt_IsNo,
          queryName:queryIds         
     }
    var sql = BusinessUnit.queryZfzt(pagePrams);
    businessUnitDataset.Open(sql);
    reloadExtGrid();
}

//查询执法人员信息
function lawUserQueryList(){
     if (user_id==1){
         queryIds = BusinessUnit.getAllBuIds();
     } else {
         queryIds = "<%=queryName%>";
     }
     if (queryIds=="") {
         queryIds="0";
     }
     var USER_REALNAME = $("USER_REALNAME").value.trim();
     var ELU_DOCUMENT_NO = $("ELU_DOCUMENT_NO").value.trim();
     var BU_NAMES = $("BU_ID").value.trim();
     var tmp = document.getElementsByName('zhuangtai');
        if (tmp[0].checked) {
            cl_enable1 = tmp[0].value ;
        } else if (tmp[1].checked) {
            cl_enable1 = tmp[1].value ;
        } else {
            cl_enable1 = -1 ;
        } 
     var state = cl_enable1;
     var ELU_CERTIFICATION_DATE = $("ELU_CERTIFICATION_DATE").value;
     var ELU_CERTIFICATION_DATE1 = $("ELU_CERTIFICATION_DATE1").value;
     validateTime();
     var Prams = { 
          USER_REALNAME:USER_REALNAME,
          ELU_DOCUMENT_NO:ELU_DOCUMENT_NO,
          BU_NAMES:BU_NAMES,
          state:state,
          ELU_CERTIFICATION_DATE:ELU_CERTIFICATION_DATE ,
          ELU_CERTIFICATION_DATE1:ELU_CERTIFICATION_DATE1 ,
          queryName:queryIds          
     }
     var sql = BusinessUnit.lawUser(Prams);
     dataset4.Open(sql);
     reloadExtGrid();
}

//发证时间的验证
function validateTime(){
    var ELU_CERTIFICATION_DATE = $("ELU_CERTIFICATION_DATE").value;
    var ELU_CERTIFICATION_DATE1 = $("ELU_CERTIFICATION_DATE1").value;
    if(!IsSpace(ELU_CERTIFICATION_DATE) && !IsSpace(ELU_CERTIFICATION_DATE1)){
        if(ELU_CERTIFICATION_DATE>ELU_CERTIFICATION_DATE1){
            alert("发证起始日期不能大于终止日期");
            return false ;
        }
    }
}

//执法主体信息查询重置
function businessUnitReset(){
    $("buIds").value = "<%=idTmp %>";
    $("buNames").value = "<%=nameTmp %>";
    $("orgIds").value = "" ;
    $("orgNames").value = "" ;
    $("BU_BRIEF_CODE").value = "";
    var boxes = document.getElementsByName('radiobutton');
    boxes[2].checked = true;
    var box = document.getElementsByName('state');
    box[2].checked = true;
}

//执法人员信息查询重置
function lawUserReset(){
     $("USER_REALNAME").value="";
     $("ELU_DOCUMENT_NO").value="";
     $("BU_ID").value = "<%=idTmp %>";
     $("BU_NAMES").value = "<%=nameTmp %>";
     $("state").value="";
     var boxes = document.getElementsByName('zhuangtai');
     boxes[0].checked = true;
     $("ELU_CERTIFICATION_DATE").value="";
     $("ELU_CERTIFICATION_DATE1").value="";
}

//执法主体新增跳转
function addBusinessUnitLoad(){
   var tempPara="dialogWidth:800px;dialogHeight:600px;";
   var tempURL="20100902193731453898.jsp";
   //window.location.href(tempURL);
   showModalDialog(tempURL,"window",tempPara);
   businessUnitQueryList();
}

//执法主体删除
function delBusinessUnit(){
    var grid =  creator_pt_grids[0].obj;
    var ids = FormUtil.getExtGridSelectedIds("BU_ID", grid);
       if(ids.length==0){    
       alert("请选择要删除的记录");
       return false;
    } else if (confirm('是否要删除所选数据?')) {
       var rv = BusinessUnit.delBusinessUnit(ids);
       if(rv){
          alert("删除数据信息成功");
       }else{
           alert("执法主体被引用不能进行删除");
       }
     reloadExtGrid();
    }
}

//打开执法主体的选择
function openOrgTree(){
    var url = "../../../ccapp/app_xzcf/jsp/baseservice/chooseZfztResourse.jsp";
    $("orgNames").value = $("buNames").value ;
    $("orgIds").value = $("buIds").value ;
    chooseUsers = window.showModalDialog(url,window, "dialogWidth=620px;dialogHeight=500px");
    $("buNames").value = $("orgNames").value ;
    $("buIds").value  = $("orgIds").value ;

}

//打开执法主体的选择
function openOrgTree1(){
    var url = "../../../ccapp/app_xzcf/jsp/baseservice/chooseZfztResourse.jsp";
    $("orgNames").value = $("BU_NAMES").value ;
    $("orgIds").value = $("BU_ID").value ;
    chooseUsers = window.showModalDialog(url,window, "dialogWidth=620px;dialogHeight=500px");
    $("BU_NAMES").value = $("orgNames").value ;
    $("BU_ID").value = $("orgIds").value ;

}

//执法主体导出excel
function businessUnitExcel(){
    var title = "执法主体信息";//标题
    var BU_NAME="执法主体";
    var BU_BRIEF_CODE="执法编号";
    var BU_LEGAL_PERSON="法人代表";
    var BU_COERCIVE_POWER="是否具有强制权";
    var BU_VALID="是否有效";
    var AD_NAME="行政区划名称";
    var VC_NAME="行业分类";
    var id = "TipstaffMainBody";
    var Name = $("orgIds").value.trim();//执法主体
     var Ids = $("BU_BRIEF_CODE").value.trim();//执法编号
     var tmp = document.getElementsByName('radiobutton');
        if (tmp[0].checked) {
            cl_enable1 = tmp[0].value ;
        } else if (tmp[1].checked) {
            cl_enable1 = tmp[1].value ;
        } else {
            cl_enable1 = -1 ;
        } 
     var IsNo = cl_enable1;//是否有效   
     var tmp1 = document.getElementsByName('state');
        if (tmp1[0].checked) {
            cl_enable2 = tmp1[0].value ;
        } else if (tmp1[1].checked) {
            cl_enable2 = tmp1[1].value ;
        } else {
            cl_enable2 = -1 ;
        }
     var ZT = cl_enable2;//状态
      var queryName = queryIds ;
     var url="<%=request.getContextPath() %>/ccapp/app_xzcf/excel/jsp/poiCommond.jsp";
     url+="?title="+title+"&BU_NAME="+BU_NAME+"&BU_BRIEF_CODE="+BU_BRIEF_CODE+"&BU_LEGAL_PERSON="+BU_LEGAL_PERSON;
     url+="&BU_COERCIVE_POWER="+BU_COERCIVE_POWER+"&BU_VALID="+BU_VALID+"&AD_NAME="+AD_NAME+"&VC_NAME="+VC_NAME+"&id="+id; //模板加id
     url+="&Name="+Name+"&Ids="+Ids+"&IsNo="+IsNo+"&ZT="+ZT+"&queryName="+queryName; //参数
      window.location.href=url;
}


//执法人员导出excel
function lawUserExcel(){
    var title = "执法人员信息";
    var ELU_DOCUMENT_NO="证件编号";
    var ELU_LICENCE="发证机关";
    var ELU_CERTIFICATION_DATE="发证日期";
    var ELU_END_DATE="失效日期";
    var ELU_STATUS="状态";
    var USER_REALNAME="姓名";
    var BWT_NAME="执法类别";
    var BU_NAME="执法主体名称";

    //以上几个变量名与模板的字段头一致
    var id = "TipstaffPeople";
    //上面的id为配置文件对应的
     var user_Name = $("USER_REALNAME").value.trim();
     var elu_No = $("ELU_DOCUMENT_NO").value.trim();
     var bu_name = $("BU_ID").value.trim();
     var tmp = document.getElementsByName('zhuangtai');
        if (tmp[0].checked) {
            cl_enable1 = tmp[0].value ;
        } else if (tmp[1].checked) {
            cl_enable1 = tmp[1].value ;
        } else {
            cl_enable1 = -1 ;
        } 
     var elu_Status = cl_enable1;
     var begin_Time = $("ELU_CERTIFICATION_DATE").value;
     var end_Time = $("ELU_CERTIFICATION_DATE1").value;
     var queryName = queryIds ;

  var url="<%=request.getContextPath() %>/ccapp/app_xzcf/excel/jsp/poiCommond.jsp";
  url+="?title="+title+"&ELU_DOCUMENT_NO="+ELU_DOCUMENT_NO+"&ELU_LICENCE="+ELU_LICENCE ;
  url+="&ELU_CERTIFICATION_DATE="+ELU_CERTIFICATION_DATE+"&ELU_END_DATE="+ELU_END_DATE ;
  url+="&ELU_STATUS="+ELU_STATUS+"&USER_REALNAME="+USER_REALNAME+"&BWT_NAME="+BWT_NAME ;
  url+="&BU_NAME="+BU_NAME+"&id="+id ;
  url+="&user_Name="+user_Name+"&elu_No="+elu_No+"&bu_name="+bu_name+"&elu_Status="+elu_Status;
  url+="&begin_Time="+begin_Time+"&end_Time="+end_Time+"&queryName="+queryName ;
  window.location.href=url;
}

</script>

<!-- 提示：以下为页面DOM元素内容 -->
<DIV id=SKbillsheet style="visibility:hidden" toolbar="不带工具栏" BLONopen="setAuthority();init();" contxml="<root><tab><id>tab3</id></tab><button><id>button3</id><id>button4</id><id>button5</id><id>button6</id><id>button7</id><id>button9</id><id>button10</id><id>button13</id></button><text><id>buNames</id><id>buIds</id><id>BU_BRIEF_CODE</id><id>orgNames</id><id>orgIds</id><id>USER_REALNAME</id><id>ELU_DOCUMENT_NO</id><id>BU_NAMES</id><id>BU_ID</id><id>ELU_CERTIFICATION_DATE</id><id>ELU_CERTIFICATION_DATE1</id></text><dataset><id>businessUnitDataset</id><id>dataset4</id></dataset><ExtGrid><id>ExtGrid1</id><id>ExtGrid</id></ExtGrid></root>" billtaborder="<root><taborder>buNames</taborder><taborder>BU_BRIEF_CODE</taborder><taborder>button3</taborder><taborder>button4</taborder><taborder>button5</taborder><taborder>button6</taborder><taborder>button7</taborder><taborder>USER_REALNAME</taborder><taborder>ELU_DOCUMENT_NO</taborder><taborder>BU_NAMES</taborder><taborder>ELU_CERTIFICATION_DATE</taborder><taborder>ELU_CERTIFICATION_DATE1</taborder><taborder>button9</taborder><taborder>button10</taborder><taborder>button13</taborder><taborder>BU_ID</taborder><taborder>buIds</taborder><taborder>orgNames</taborder><taborder>orgIds</taborder></root>" dj_sn="20100902193122890559" caption="执法主体信息" mkbh codeheader="BBB" entertype="展现" poswidth posheight controlno="SKButton:0;SKDBedit:0;checkbox:0;label:0;radio:5;listbox:0;textarea:0;combobox:2;password:0;upload:0;SKDBtext:0;chart:0;dbimg:0;img:0;SKBILLgrid:0;shape:0;tab:0;div:0;DsMain_field:0;a:0;button:0;text:8;hr:0;checkboxlist:0;radiolist:0;dropdownlist:0;grid:0;dataset:7;spin:0;excel:0;tree:0;ebshow:0;creatorSubForm:0;creator_div:0;ExtGrid:6;ExtUpload:0;ExtTree:0;Fusionchar:0" window="当前窗口" posleft postop keyfield isfile="否" OtherSave="否" idtype="1" testDbName="app_xzcf" creatorStyle="creatorBlue" BLONclose="UnLoadWebOffice();" creator_remark hasWorkflowButton="否" creator_elementAuthoritySwitch="否" creator_showAlert="否" creator_office_isBindForm="否" islog="否" isprotect="是" creator_csslib version="1.0" creator_pagination type="ZW" creatorType="20100902181546343920" jslib="fcbasecont.js&#13;&#10;selectdate.js&#13;&#10;~userfunc.js&#13;&#10;fcdate.js&#13;&#10;../../../ccapp/app_xzcf/js/common/Namespace.js&#13;&#10;../../../ccapp/app_xzcf/js/common/nsreg.js&#13;&#10;../../../ccapp/app_xzcf/js/common/Common.js&#13;&#10;../../../ccapp/app_xzcf/js/util/DateUtil.js&#13;&#10;../../../ccapp/app_xzcf/js/vo/vo.js&#13;&#10;../../../ccapp/app_xzcf/js/business/BusinessUnit.js&#13;&#10;../../../ccapp/app_xzcf/js/dao/BusinessUnitDao.js" creator_allTab="<tabs><tab><id>tab3</id><content><index>0</index><gridid></gridid><iframeid></iframeid><index>1</index><gridid></gridid><iframeid></iframeid></content></tab></tabs>">

<TABLE cellSpacing=0 cellPadding=0 width="95%" align=center border=0>
   <TBODY>
      <TR>
         <TD><DIV class=tab-pane id=tab3 style="LEFT: 0px; WIDTH: 100%; POSITION: absolute; TOP: 0px; HEIGHT: 600px" showtype="luna" IsHideTitle="否"><DIV class=tab-page style="WIDTH: 100%; HEIGHT: 582px"><H2 class=tab>执法主体信息</H2>
                  <TABLE height="100%" width="100%" border=0>
                     <TBODY>
                        <TR>
                           <TD>
                              <TABLE class=CTable cellSpacing=0 cellPadding=0 width="95%" align=center border=0>
                                 <TBODY>
                                    <TR>
                                       <TD class=taobox align=left colSpan=4>执法主体信息查询</TD>
                                       <TR>
                                          <TD class=c2 align=right width="15%">执法主体</TD>
                                          <TD width="35%"><INPUT class=input_image id=buNames style="LEFT: 0px; WIDTH: 228px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() size=39 name=Input controltype="text" onclick='bill_onclick("openOrgTree();")'><INPUT id=buIds style="DISPLAY: none; LEFT: 0px; WIDTH: 53px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=4 controltype="text"></TD>
                                          <TD class=c2 align=right width="15%">执法编号</TD>
                                          <TD><INPUT class=input_out id=BU_BRIEF_CODE style="LEFT: 0px; WIDTH: 228px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() size=39 name=Input2 controltype="text"></TD>
                                       </TR>
                                       <TR>
                                          <TD class=c2 align=right width="15%">是否具有强制权</TD>
                                          <TD width="35%"><INPUT type=radio value=1 name=radiobutton>是<INPUT type=radio CHECKED value=0 name=radiobutton>否<INPUT type=radio value=-1 name=radiobutton>全部</TD>
                                          <TD class=c2 align=right width="15%">状态</TD>
                                          <TD><INPUT type=radio CHECKED value=1 name=state>有效<INPUT type=radio value=0 name=state>无效<INPUT type=radio value=-1 name=state>全部</TD>
                                       </TR>
                                       <TR>
                                          <TD align=middle colSpan=4><BUTTON class=button id=button3 style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("businessUnitQueryList()")'>查询</BUTTON><BUTTON class=button id=button4 style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("businessUnitReset()")'>重置</BUTTON><BUTTON class=button id=button5 style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("businessUnitExcel();")'>导出excel</BUTTON><INPUT id=orgNames style="DISPLAY: none; LEFT: 0px; WIDTH: 96px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=15 controltype="text"><INPUT id=orgIds style="DISPLAY: none; LEFT: 0px; WIDTH: 87px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=15 controltype="text"></TD>
                                       </TR>
                                    </TBODY>
                                 </TABLE>
                              </TD>
                           </TR>
                           <TR height=32>
                              <TD align=right><BUTTON class=addbutton1 id=button6 style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("addBusinessUnitLoad()")'>新增</BUTTON>&nbsp;<BUTTON class=sbutton1 id=button7 style="LEFT: 786px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("delBusinessUnit()")'>删除</BUTTON></TD>
                           </TR>
                           <TR>
                              <TD>&nbsp;<IMG style="DISPLAY: none" src="undefined"><DIV id=div_ExtGrid1 style="LEFT: 0px; POSITION: static; TOP: 0px"></DIV><SCRIPT type=text/javascript>var ExtGrid1;
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
	width: '100%',
					height: eval(document.body.clientHeight*(parseFloat('60%')))/100,
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
cm.setHidden(4,true);
cm.setHidden(6,true);
cm.setHidden(7,true);
cm.setHidden(9,true);
grid.addListener('rowdblclick',updateBusinessUnit);ExtGrid1.render();
store.load({params:{start:0, limit:pagesize}});
if(typeof(creator_pt_grids)=='undefined'){creator_pt_grids=new Array();}
creator_pt_grids.push({id:'ExtGrid1',obj:ExtGrid1,dataset:'businessUnitDataset',isEdit:'false'});
if(typeof(onGridPanelLoaded)=='function') setTimeout(onGridPanelLoaded,0);
};
ExtGrid1_onReady();window.onresize=function(){try{ExtGrid1.setWidth(eval(document.body.clientWidth*(parseFloat('95%')))/100);}catch(e){}};</SCRIPT></TD>
                           </TR>
                        </TBODY>
                     </TABLE>
                     <TABLE style="WIDTH: 100%; POSITION: static" cellSpacing=0 cellPadding=0 width=100 align=left border=0>
                        <TBODY>
                           <TR>
                              <TD><?xml:namespace prefix = fc /><fc:dataset id=businessUnitDataset showtypeXml="<root><showType><name>checkbox</name><showRule>%5B%7Bshowtype%3A%27checkbox%27%7D%5D</showRule></showType></root>" columnHeight1Xml="undefined" columnWidth1Xml="undefined" format="<fields><field><fieldname>checkbox</fieldname><datatype>字符</datatype><displaylabel>选择</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype><showRule>%5B%7Bshowtype%3A%27checkbox%27%7D%5D</showRule></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>BU_NAME</fieldname><datatype>字符</datatype><displaylabel>执法主体</displaylabel><size>150</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>BU_BRIEF_CODE</fieldname><datatype>字符</datatype><displaylabel>执法编号</displaylabel><size>4</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>BU_LEGAL_PERSON</fieldname><datatype>字符</datatype><displaylabel>法人代表</displaylabel><size>20</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>VC_ID</fieldname><datatype>字符</datatype><displaylabel>行业规则</displaylabel><size>22</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>BU_COERCIVE_POWER</fieldname><datatype>字符</datatype><displaylabel>是否具有强制权</displaylabel><size>22</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>AD_ID</fieldname><datatype>字符</datatype><displaylabel>行政区划</displaylabel><size>20</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>count_people</fieldname><datatype>字符</datatype><displaylabel>人数</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>BU_VALID</fieldname><datatype>字符</datatype><displaylabel>是否有效</displaylabel><size>22</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>bu_id</fieldname><datatype>整数</datatype><displaylabel>执法主体ID</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>AD_NAME</fieldname><datatype>字符</datatype><displaylabel>行政区划名称</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>VC_NAME</fieldname><datatype>字符</datatype><displaylabel>行业分类</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>BU_YY</fieldname><datatype>字符</datatype><displaylabel>是否引用</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field></fields>" onSetText='bill_ondatasetsettext("<dsid><checkbox></checkbox><BU_NAME></BU_NAME><BU_BRIEF_CODE></BU_BRIEF_CODE><BU_LEGAL_PERSON></BU_LEGAL_PERSON><VC_ID></VC_ID><BU_COERCIVE_POWER></BU_COERCIVE_POWER><AD_ID></AD_ID><count_people></count_people><BU_VALID></BU_VALID><bu_id></bu_id><AD_NAME></AD_NAME><VC_NAME></VC_NAME><BU_YY></BU_YY></dsid>")' onGetText='bill_ondatasetgettext("<dsid><checkbox></checkbox><BU_NAME></BU_NAME><BU_BRIEF_CODE></BU_BRIEF_CODE><BU_LEGAL_PERSON></BU_LEGAL_PERSON><VC_ID></VC_ID><BU_COERCIVE_POWER></BU_COERCIVE_POWER><AD_ID></AD_ID><count_people></count_people><BU_VALID></BU_VALID><bu_id></bu_id><AD_NAME></AD_NAME><VC_NAME></VC_NAME><BU_YY></BU_YY></dsid>")' onValid='bill_ondatasetvalid("<dsid><checkbox></checkbox><BU_NAME></BU_NAME><BU_BRIEF_CODE></BU_BRIEF_CODE><BU_LEGAL_PERSON></BU_LEGAL_PERSON><VC_ID></VC_ID><BU_COERCIVE_POWER></BU_COERCIVE_POWER><AD_ID></AD_ID><count_people></count_people><BU_VALID></BU_VALID><bu_id></bu_id><AD_NAME></AD_NAME><VC_NAME></VC_NAME><BU_YY></BU_YY></dsid>")' opensortno="1" temptable="TMP_DATASET1" multiResult="是"></fc:dataset></TD>
                           </TR>
                        </TBODY>
                     </TABLE>
                  </DIV>
                  <DIV class=tab-page style="WIDTH: 100%; HEIGHT: 582px">
                     <H2 class=tab>执法人员信息</H2>
                     <TABLE height="100%" width="100%" border=0>
                        <TBODY>
                           <TR>
                              <TD height=130>
                                 <TABLE class=CTable cellSpacing=0 cellPadding=0 width="95%" align=center border=0>
                                    <TBODY>
                                       <TR>
                                          <TD class=taobox colSpan=6>执法人员信息查询</TD>
                                       </TR>
                                       <TR>
                                          <TD class=c2 align=right width="13%">姓名</TD>
                                          <TD align=left width="20%"><INPUT id=USER_REALNAME style="LEFT: 0px; WIDTH: 147px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() size=26 name=Input2 controltype="text"></TD>
                                          <TD class=c2 align=right width="13%">证件编号</TD>
                                          <TD width="20%"><INPUT id=ELU_DOCUMENT_NO style="LEFT: 0px; WIDTH: 147px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() size=26 name=Input2 controltype="text"></TD>
                                          <TD class=c2 align=right width="13%">所属执法主体</TD>
                                          <TD><INPUT id=BU_NAMES style="LEFT: 0px; WIDTH: 150px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() size=27 name=Input2 controltype="text" onclick='bill_onclick("openOrgTree1();")'><INPUT id=BU_ID style="DISPLAY: none; LEFT: 0px; WIDTH: 65px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=8 controltype="text"></TD>
                                       </TR>
                                       <TR>
                                          <TD class=c2 align=right width="13%">状态</TD>
                                          <TD align=left width="20%"><INPUT type=radio CHECKED value=1 name=zhuangtai>有效<INPUT type=radio value=0 name=zhuangtai>无效<INPUT type=radio value=-1 name=zhuangtai>全部</TD>
                                          <TD class=c2 align=right width="13%">发证日期</TD>
                                          <TD colSpan=3><INPUT class=its_out id=ELU_CERTIFICATION_DATE style="LEFT: 0px; WIDTH: 146px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=24 name=Input2 controltype="text" onclick='bill_onclick("SelectDate()")'>至<INPUT class=its_out id=ELU_CERTIFICATION_DATE1 style="LEFT: 0px; WIDTH: 148px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=26 name=Input2 controltype="text" onclick='bill_onclick("SelectDate()")'></TD>
                                       </TR>
                                       <TR>
                                          <TD align=middle colSpan=6>&nbsp;<BUTTON class=button id=button9 style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("lawUserQueryList()")'>查询</BUTTON><BUTTON class=button id=button10 style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("lawUserReset()")'>重置</BUTTON><BUTTON class=button id=button13 style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("lawUserExcel();")'>导出excel</BUTTON></TD>
                                       </TR>
                                    </TBODY>
                                 </TABLE>
                              </TD>
                           </TR>
                           <TR>
                              <TD>&nbsp;<IMG style="DISPLAY: none" src="undefined"><DIV id=div_ExtGrid style="LEFT: 0px; POSITION: static; TOP: 0px"></DIV><SCRIPT type=text/javascript>var ExtGrid;
Ext.BLANK_IMAGE_URL = '../../fceform/js/Ext/images/default/s.gif';
var ExtGrid_retint = 0;
var ExtGrid_onReady = function(){ 
 Ext.QuickTips.init();
var dataset = document.getElementById("dataset4");
try{var temp = dataset.Fields.Field.length;}catch(e){if(ExtGrid_retint==0) ExtGrid_retint = setInterval(ExtGrid_onReady,200);dataset =null;return;}finally{if(temp!=null)temp=null;}
clearInterval(ExtGrid_retint);ExtGrid_retint = null ;var pagesize =10;
dataset.PageSize = pagesize ;
var mapping = creator_pt_getmapping(dataset);
var store  = new Ext.data.Store({
	proxy: new Ext.data.CreatorMemoryProxy("dataset4"), 
	reader: new Ext.data.XmlStringReader({       record: 'tr',       totalRecords: 'pages'   }, mapping)});
var sm = new Ext.grid.RowSelectionModel({singleSelect: true});
var retcm = creator_pt_getcm(dataset,sm);var cm = new Ext.grid.ColumnModel(retcm);
if(typeof(retcm[0].getCount)!='undefined') sm = retcm[0] ;
 ExtGrid = new Ext.grid.GridPanel({
		el: 'div_ExtGrid',        store: store,
        cm:cm,
		sm: sm,
 			 bodyStyle : 'width:100%',
		viewConfig: {
			forceFit: true		},       loadMask: true,
	width: '100%',
					height: eval(document.body.clientHeight*(parseFloat('60%')))/100,
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
    var grid=ExtGrid;
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
cm.setHidden(1,true);
cm.setHidden(4,true);
grid.addListener('rowdblclick',updateLawUser);ExtGrid.render();
store.load({params:{start:0, limit:pagesize}});
if(typeof(creator_pt_grids)=='undefined'){creator_pt_grids=new Array();}
creator_pt_grids.push({id:'ExtGrid',obj:ExtGrid,dataset:'dataset4',isEdit:'false'});
if(typeof(onGridPanelLoaded)=='function') setTimeout(onGridPanelLoaded,0);
};
ExtGrid_onReady();window.onresize=function(){try{ExtGrid.setWidth(eval(document.body.clientWidth*(parseFloat('95%')))/100);}catch(e){}};</SCRIPT></TD>
                           </TR>
                        </TBODY>
                     </TABLE>
                     <fc:dataset id=dataset4 showtypeXml="<root><showType><name>checkBox</name><showRule>%5B%7BRule%3A%27%u6761%u4EF6%27%2Cshowtype%3A%27checkBox%27%7D%2C%7BRule%3A%27%u6761%u4EF6%27%2Cshowtype%3A%27%u663E%u793A%u65B9%u5F0F%27%7D%5D</showRule></showType><showType><name>checkec</name><showRule>%5B%7BRule%3A%27%u6761%u4EF6%27%2Cshowtype%3A%27checkec%27%7D%2C%7BRule%3A%27%u6761%u4EF6%27%2Cshowtype%3A%27%u663E%u793A%u65B9%u5F0F%27%7D%5D</showRule></showType><showType><name>a</name><showRule>%5B%7BRule%3A%27%u6761%u4EF6%27%2Cshowtype%3A%27a%27%7D%2C%7BRule%3A%27%u6761%u4EF6%27%2Cshowtype%3A%27%u663E%u793A%u65B9%u5F0F%27%7D%5D</showRule></showType><showType><name>checkbox</name><showRule>%5B%7Bshowtype%3A%27checkbox%27%7D%5D</showRule></showType></root>" columnHeight1Xml="undefined" columnWidth1Xml="undefined" format="<fields><field><fieldname>checkbox</fieldname><datatype>字符</datatype><displaylabel>选择</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype><showRule>%5B%7Bshowtype%3A%27checkbox%27%7D%5D</showRule></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>USER_ID</fieldname><datatype>字符</datatype><displaylabel>执法人员编号</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>ELU_DOCUMENT_NO</fieldname><datatype>字符</datatype><displaylabel>证件编号</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>ELU_LICENCE</fieldname><datatype>字符</datatype><displaylabel>发证机关</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>BWT_ID</fieldname><datatype>字符</datatype><displaylabel>执法类别</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>ELU_CERTIFICATION_DATE</fieldname><datatype>字符</datatype><displaylabel>发证日期</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>ELU_END_DATE</fieldname><datatype>字符</datatype><displaylabel>失效日期</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>ELU_STATUS</fieldname><datatype>字符</datatype><displaylabel>状态</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>USER_REALNAME</fieldname><datatype>字符</datatype><displaylabel>姓名</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>BWT_NAME</fieldname><datatype>字符</datatype><displaylabel>执法类别</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>BU_NAME</fieldname><datatype>字符</datatype><displaylabel>执法主体名称</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field></fields>" onSetText='bill_ondatasetsettext("<dsid><checkbox></checkbox><USER_ID></USER_ID><ELU_DOCUMENT_NO></ELU_DOCUMENT_NO><ELU_LICENCE></ELU_LICENCE><BWT_ID></BWT_ID><ELU_CERTIFICATION_DATE></ELU_CERTIFICATION_DATE><ELU_END_DATE></ELU_END_DATE><ELU_STATUS></ELU_STATUS><USER_REALNAME></USER_REALNAME><BWT_NAME></BWT_NAME><BU_NAME></BU_NAME></dsid>")' onGetText='bill_ondatasetgettext("<dsid><checkbox></checkbox><USER_ID></USER_ID><ELU_DOCUMENT_NO></ELU_DOCUMENT_NO><ELU_LICENCE></ELU_LICENCE><BWT_ID></BWT_ID><ELU_CERTIFICATION_DATE></ELU_CERTIFICATION_DATE><ELU_END_DATE></ELU_END_DATE><ELU_STATUS></ELU_STATUS><USER_REALNAME></USER_REALNAME><BWT_NAME></BWT_NAME><BU_NAME></BU_NAME></dsid>")' onValid='bill_ondatasetvalid("<dsid><checkbox></checkbox><USER_ID></USER_ID><ELU_DOCUMENT_NO></ELU_DOCUMENT_NO><ELU_LICENCE></ELU_LICENCE><BWT_ID></BWT_ID><ELU_CERTIFICATION_DATE></ELU_CERTIFICATION_DATE><ELU_END_DATE></ELU_END_DATE><ELU_STATUS></ELU_STATUS><USER_REALNAME></USER_REALNAME><BWT_NAME></BWT_NAME><BU_NAME></BU_NAME></dsid>")' opensortno="1" temptable="TMP_DATASET4" multiResult="是"></fc:dataset>
                  </DIV>
               </DIV>
               <SCRIPT>var tab3 = new WebFXTabPane( document.getElementById( "tab3" ) );</SCRIPT>
               <TABLE style="POSITION: static" cellSpacing=0 cellPadding=0 width=760 align=left border=0>
                  <TBODY>
                     <TR>
                        <TD></TD>
                     </TR>
                  </TBODY>
               </TABLE>
               &nbsp;&nbsp;&nbsp;
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
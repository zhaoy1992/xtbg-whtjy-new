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
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/fcopendj.js');");
if(bDgMode) out.println("<script src='../../fceform/js/fcopendj.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/fcsavedj.js');");
if(bDgMode) out.println("<script defer src='../../fceform/js/fcsavedj.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/fcselfuse.js');");
if(bDgMode) out.println("<script src='../../fceform/js/fcselfuse.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/fcbasecont.js');");
if(bDgMode) out.println("<script src='../../fceform/js/fcbasecont.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/fcother.js');");
if(bDgMode) out.println("<script defer src='../../fceform/js/fcother.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/selectdate.js');");
if(bDgMode) out.println("<script defer src='../../fceform/js/selectdate.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/../fceformext/js/userfunc.js');");
if(bDgMode) out.println("<script src='../../fceform/../fceformext/js/userfunc.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/fcdate.js');");
if(bDgMode) out.println("<script src='../../fceform/js/fcdate.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_4/js/Validate.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_4/js/Validate.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_4/js/PubFun.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_4/js/PubFun.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_4/js/FuJianShangChuan.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_4/js/FuJianShangChuan.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_4/js/QianYueYiJian.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_4/js/QianYueYiJian.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_4/js/FuJianChaKan.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_4/js/FuJianChaKan.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_4/js/SimpleWord.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_4/js/SimpleWord.js'></script>");
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


<!-- 提示：以下为页面自定义JS内容 -->
<script>
var cc_form_instanceid="";
var bdid="";
var actName="";
function $(ob)
{
    return typeof(ob)=="string"?document.getElementById(ob):ob;
}
function $F(ob)
{
    return $(ob).value;
}
function getQueryString(ob)
{
    if(!typeof(ob)=="string")return "";
    return IsSpace(creator_getQueryString(ob))?"":creator_getQueryString(ob);
}
function init()
{
    cc_form_instanceid=getQueryString("cc_form_instanceid");
    bdid=getQueryString("bdid");
    actName=getQueryString("actDefName");
    $("dqhj").value=actName;
    $("bdid").value=SqlToField("select fw_bdid from td_fw_minfo where cc_form_instanceid='"+cc_form_instanceid+"'");
    if(cc_form_instanceid=="clear")
    {
        $("fwsj").value=SqlToField("select sysdate from dual");
    }else
    {
        ds.Open("select * from td_fw_minfo where cc_form_instanceid='"+cc_form_instanceid+"'");
        ds1.Open("select id,fw_action,fw_creator,fw_memo,to_char(fw_date,'yyyy/mm/dd') as fw_date from td_fw_mind where cc_form_instanceid='"+cc_form_instanceid+"' and id in(select max(to_number(id)) from td_fw_mind group by fw_creator,fw_action,cc_form_instanceid)");
        var shyj=new Array();
        var hqyj=new Array();
        var ldyj=new Array();
        ds1.MoveFirst();
        for(var i=0;i<ds1.RecordCount;i++)
        {
            if(ds1.Fields.Field["fw_action"].Value=="审核")
            {
                shyj.push(ds1.Fields.Field["fw_date"].Value);
                shyj.push("  ");
                shyj.push(ds1.Fields.Field["fw_creator"].Value);
                shyj.push("：");
                shyj.push(ds1.Fields.Field["fw_memo"].Value);
                shyj.push("  \n");
                
            }
            if(ds1.Fields.Field["fw_action"].Value=="部门会签")
            {
                hqyj.push(ds1.Fields.Field["fw_date"].Value);
                hqyj.push("  ");
                hqyj.push(ds1.Fields.Field["fw_creator"].Value);
                hqyj.push("：");
                hqyj.push(ds1.Fields.Field["fw_memo"].Value);
                hqyj.push("  \n");
            }
            if(ds1.Fields.Field["fw_action"].Value=="签阅")
            {
                ldyj.push(ds1.Fields.Field["fw_date"].Value);
                ldyj.push("  ");
                ldyj.push(ds1.Fields.Field["fw_creator"].Value);
                ldyj.push("：");
                ldyj.push(ds1.Fields.Field["fw_memo"].Value);
                ldyj.push("  \n");
            }
            ds1.MoveNext();
        }
        $("bgsh").innerHTML=shyj.join("");
        $("qf").innerHTML=hqyj.join("");
        $("ldyj").innerHTML=ldyj.join("");
    }
    if(IsSpace($F("fjid")))
    {
        $("fjid").value=SqlToField("select SEQ_FW_FJID.nextval from dual");
    }
    if(actName=="审核")
    {
        $("hgr").value=getSysElement("userName");
    }
}
function startWorkFlow()
{
    //if(cc_form_instanceid=="clear")cc_form_instanceid=getNewCc_form_instanceid(true);
    saveMinfo();
    creator_djsave('启动流程',false,true,'../../../common_workflow/main.jsp')
}
function saveMinfo()
{
//alert($F("bdid"));
    if(IsSpace($F("bdid"))){
        $("bdid").value=SqlToField("select SEQ_FW_MAINID.nextval from dual");
        insertMinfo();
    }else
    {
        updateMinfo();
    }
}
function insertMinfo()
{
    var sql=new Array();
    sql.push("insert into td_fw_minfo(fw_wjn,fw_wjh,fw_hj,fw_mj,fw_fs,fw_ngdw,fw_ngrq,fw_ngr,fw_hgr,fw_zs,fw_cs,fw_ztc,fw_bt,FW_BDID,FW_FJID) values('");
    sql.push($F("fwn"));
    sql.push("','");
    sql.push($F("fwh"));
    sql.push("','");
    sql.push($F("hj"));
    sql.push("','");
    sql.push($F("mj"));
    sql.push("','");
    sql.push($F("fs"));
    sql.push("','");
    sql.push($F("ngdw"));
    sql.push("','");
    sql.push($F("ngrq"));
    sql.push("','");
    sql.push($F("ngr"));
    sql.push("','");
    sql.push($F("hgr"));
    sql.push("','");
    sql.push($("zs").innerHTML);
    sql.push("','");
    sql.push($("cs").innerHTML);
    sql.push("','");
    sql.push($F("ztc"));
    sql.push("','");
    sql.push($F("bt"));
    sql.push("','");
    sql.push($F("bdid"));
    sql.push("','");
    sql.push($F("fjid"));
    sql.push("')");
    //CopyToPub(sql.join(""));
    var s=InsertSql(sql.join(""));
    //alert(s);
    return s; 
}
function updateMinfo()
{
    var sql=new Array();
    sql.push("update td_fw_minfo set fw_wjn='");
    sql.push($F("fwn"));
    sql.push("',fw_wjh='");
    sql.push($F("fwh"));
    sql.push("',fw_hj='");
    sql.push($F("hj"));
    sql.push("',fw_mj='");
    sql.push($F("mj"));
    sql.push("',fw_fs='");
    sql.push($F("fs"));
    sql.push("',fw_ngdw='");
    sql.push($F("ngdw"));
    sql.push("',fw_ngrq='");
    sql.push($F("ngrq"));
    sql.push("',fw_ngr='");
    sql.push($F("ngr"));
    sql.push("',fw_hgr='");
    sql.push($F("hgr"));
    sql.push("',fw_zs='");
    sql.push($("zs").innerHTML);
    sql.push("',fw_cs='");
    sql.push($("cs").innerHTML);
    sql.push("',fw_ztc='");
    sql.push($F("ztc"));
    sql.push("',fw_bt='");
    sql.push($F("bt"));
    sql.push("' where fw_bdid='");
    sql.push($F("bdid"));
    sql.push("'");
    //CopyToPub(sql.join(""));
    var s=InsertSql(sql.join(""));
    //alert(s);
    return s;
}
function memo()
{
    var sql=new Array();
    sql.push("insert into td_fw_mind(id,fw_action,fw_creator,fw_memo) values(SEQ_FW_MINDID.nextval,'");
    sql.push(creator_getActName());
    sql.push("','");
    sql.push(getSysElement("userName"));
    sql.push("','");
    sql.push($("yj").innerHTML);
    sql.push("')");
    //CopyToPub(sql.join(""));
    var s=InsertSql(sql.join(""));
    return s;
}
function completeWorkFlow()
{
    saveMinfo();
    memo();
    //alert(creator_getSession("cc_form_instanceid"));
    creator_djsave('完成活动',false,true,'../../../common_workflow/main.jsp');
}
function editFJ()
{
        var cc="";
          if(IsSpace(creator_getSession("cc_form_instanceid"))||creator_getSession("cc_form_instanceid")=="clear")
          {
               cc=getNewCc_form_instanceid(true);
          }else{
               cc=creator_getSession("cc_form_instanceid");
           }    
    showModalDialog(getOpenUrlByDjid('20090903152316781786')+"&djbh="+$F("fjid")+"&cc_form_instanceid="+cc,"status:yes;resizable:yes;;unadorne:yes;center:yes");
}
function openEdit() {
          var cc="";
          if(IsSpace(creator_getSession("cc_form_instanceid"))||creator_getSession("cc_form_instanceid")=="clear")
          {
               cc=getNewCc_form_instanceid(true);
          }else{
               cc=creator_getSession("cc_form_instanceid");
           }    
    showModalDialog(getOpenUrlByDjid('20090827085359250127') + "&cc_form_instanceid=" + cc+"&actName="+actName,window,"status:yes;resizable:yes;;unadorne:yes;center:yes");
}















</script>

<!-- 提示：以下为页面DOM元素内容 -->
<DIV id=SKbillsheet style="visibility:hidden" toolbar="不带工具栏" BLONopen="setAuthority();init();" contxml="<root><label><id>label1</id><id>label2</id><id>label3</id><id>label4</id><id>label10</id><id>label12</id><id>label15</id><id>label13</id><id>label14</id><id>label16</id><id>label20</id><id>label17</id><id>label18</id><id>label19</id><id>label21</id><id>label22</id><id>label23</id><id>label24</id><id>label25</id><id>label26</id></label><textarea><id>yj</id><id>qf</id><id>ldyj</id><id>bgsh</id><id>zs</id><id>cs</id></textarea><combobox><id>fwn</id><id>hj</id><id>mj</id><id>workflowControl_selectAct</id></combobox><div><id>workflowControl_selectAct_div</id><id>workflowControl_selectUser</id><id>workflowControl_selectAndUser</id><id>workflowControl_start</id><id>workflowControl_complete</id><id>workflowControl_back</id><id>workflowControl_recycle</id><id>workflowControl_tempSaveForm</id><id>workflowControl_backToPrior</id></div><button><id>button1</id><id>button2</id><id>button3</id><id>button4</id><id>button6</id><id>button_xzxr</id><id>button_yfzxzxr</id><id>button_qdlc</id><id>button_wchd</id><id>button_ht</id><id>button_hs</id><id>button_zc</id><id>button_fh</id></button><text><id>bdid</id><id>fjid</id><id>dqhj</id><id>fwsj</id><id>fwh</id><id>fs</id><id>ngdwid</id><id>ngdw</id><id>ngrq</id><id>ngr</id><id>hgr</id><id>zsid</id><id>csid</id><id>ztc</id><id>bt</id><id>DYNAMICPERFORMER_NAME</id><id>DYNAMICPERFORMER</id><id>ANDSPLITUSERS_ACTNAME</id><id>ANDSPLITUSERS</id><id>workflowControl_result</id></text><dataset><id>ds</id><id>ds1</id></dataset></root>" billtaborder="<root><taborder>workflowControl_selectAct</taborder><taborder>button_xzxr</taborder><taborder>button_yfzxzxr</taborder><taborder>button_qdlc</taborder><taborder>button_wchd</taborder><taborder>button_ht</taborder><taborder>button_hs</taborder><taborder>button_zc</taborder><taborder>DYNAMICPERFORMER_NAME</taborder><taborder>DYNAMICPERFORMER</taborder><taborder>ANDSPLITUSERS_ACTNAME</taborder><taborder>ANDSPLITUSERS</taborder><taborder>workflowControl_result</taborder><taborder>yj</taborder><taborder>qf</taborder><taborder>ldyj</taborder><taborder>bgsh</taborder><taborder>zs</taborder><taborder>cs</taborder><taborder>fwn</taborder><taborder>hj</taborder><taborder>mj</taborder><taborder>button1</taborder><taborder>button2</taborder><taborder>button3</taborder><taborder>button4</taborder><taborder>button6</taborder><taborder>button_fh</taborder><taborder>bdid</taborder><taborder>fjid</taborder><taborder>dqhj</taborder><taborder>fwsj</taborder><taborder>fwh</taborder><taborder>fs</taborder><taborder>ngdw</taborder><taborder>ngrq</taborder><taborder>ngr</taborder><taborder>hgr</taborder><taborder>ztc</taborder><taborder>bt</taborder><taborder>ngdwid</taborder><taborder>zsid</taborder><taborder>csid</taborder></root>" dj_sn="20090826085027984445" caption="发文稿纸" mkbh codeheader="BBB" entertype="修改" poswidth posheight controlno="SKButton:0;SKDBedit:0;checkbox:0;label:0;radio:0;listbox:0;textarea:1;combobox:0;password:0;upload:0;SKDBtext:0;chart:0;dbimg:0;img:0;SKBILLgrid:0;shape:0;tab:0;div:0;DsMain_field:0;a:0;button:1;text:10;hr:0;checkboxlist:0;radiolist:0;dropdownlist:0;grid:0;dataset:2;spin:0;excel:0;tree:0;ebshow:0;creatorSubForm:0;creator_div:0;ExtGrid:0;ExtUpload:2;ExtTree:0;Fusionchar:0" window="当前窗口" posleft postop keyfield="bdid" isfile="否" OtherSave="否" idtype="1" testDbName creatorStyle="creatorBlue" BLONclose="UnLoadWebOffice();" creator_remark hasWorkflowButton="是" creator_elementAuthoritySwitch="否" creator_showAlert="否" creator_office_isBindForm="否" islog="否" isprotect="是" creator_csslib version="1.0" creator_pagination type="ZW" creatorType="20090826084448609544" jslib="fcopendj.js&#13;&#10;fcsavedj.js&#13;&#10;fcselfuse.js&#13;&#10;fcbasecont.js&#13;&#10;fcother.js&#13;&#10;selectdate.js&#13;&#10;~userfunc.js&#13;&#10;fcdate.js&#13;&#10;../../../ccapp/app_4/js/Validate.js&#13;&#10;../../../ccapp/app_4/js/PubFun.js&#13;&#10;../../../ccapp/app_4/js/FuJianShangChuan.js&#13;&#10;../../../ccapp/app_4/js/QianYueYiJian.js&#13;&#10;../../../ccapp/app_4/js/FuJianChaKan.js&#13;&#10;../../../ccapp/app_4/js/SimpleWord.js">

<H1 style="WIDTH: 100%; TEXT-ALIGN: center">长沙市人民政府发文稿纸</H1>

<INPUT id=bdid style="DISPLAY: none; LEFT: 0px; WIDTH: 110px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="FW_BDID" china="主建" dataset="ds">

<INPUT id=fjid style="DISPLAY: none; LEFT: 0px; WIDTH: 110px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="FW_FJID" china="附件主键" dataset="ds">

<TABLE style="POSITION: static" cellSpacing=0 cellPadding=0 width="100%" border=1>
   <THEAD>
      <TR>
         <TD width="20%"><DIV id=label1 style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 15px; TEXT-ALIGN: right" onmovestart=moveStart() noWrap controltype="label" NotBg="否" value="label1">当前环节</DIV></TD>
         <TD width="30%"><INPUT id=dqhj style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text"></TD>
         <TD width="20%"><DIV id=label2 style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 15px; TEXT-ALIGN: right" onmovestart=moveStart() noWrap controltype="label" NotBg="否" value="label2">发文时间</DIV></TD>
         <TD width="30%"><INPUT id=fwsj style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="fw_date" china="发文日期" dataset="ds"></TD>
      </TR>
   </THEAD>
   <TBODY>
      <TR>
         <TD><DIV id=label3 style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 15px; TEXT-ALIGN: right" onmovestart=moveStart() noWrap controltype="label" NotBg="否" value="label3">长信中心</DIV></TD>
         <TD>(<SELECT id=fwn style="LEFT: 0px; WIDTH: 40%; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() sqltrans controltype="combobox" field="FW_WJN" china="文件年" dataset="ds" tempvalue="2006&#13;&#10;2007&#13;&#10;2008&#13;&#10;2009&#13;&#10;2010" temptext="2006&#13;&#10;2007&#13;&#10;2008&#13;&#10;2009&#13;&#10;2010" sql check="1"><OPTION value=2006 selected>2006</OPTION><OPTION value=2007>2007</OPTION><OPTION value=2008>2008</OPTION><OPTION value=2009>2009</OPTION><OPTION value=2010>2010</OPTION></SELECT>)<INPUT id=fwh style="LEFT: 0px; WIDTH: 40%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="FW_WJH" china="文件号" dataset="ds">&nbsp;号</TD>
         <TD colSpan=2><DIV id=label4 style="LEFT: 0px; FLOAT: left; WIDTH: 65px; POSITION: static; TOP: 0px; HEIGHT: 15px; TEXT-ALIGN: center" onmovestart=moveStart() noWrap controltype="label" NotBg="否" value="label4">缓急</DIV><SELECT id=hj style="LEFT: 0px; FLOAT: left; WIDTH: 16%; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() sqltrans controltype="combobox" field="FW_HJ" china="缓急" dataset="ds" tempvalue="一般&#13;&#10;紧急" temptext="一般&#13;&#10;紧急" sql check="1"><OPTION value=一般 selected>一般</OPTION><OPTION value=紧急>紧急</OPTION></SELECT><DIV id=label10 style="LEFT: 0px; FLOAT: left; WIDTH: 65px; POSITION: static; TOP: 0px; HEIGHT: 15px; TEXT-ALIGN: center" onmovestart=moveStart() noWrap controltype="label" NotBg="否" value="label10">密级</DIV><SELECT id=mj style="LEFT: 0px; FLOAT: left; WIDTH: 16%; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() sqltrans controltype="combobox" field="FW_MJ" china="秘级" dataset="ds" tempvalue="一般&#13;&#10;秘密&#13;&#10;机密" temptext="一般&#13;&#10;秘密&#13;&#10;机密" sql check="1"><OPTION value=一般 selected>一般</OPTION><OPTION value=秘密>秘密</OPTION><OPTION value=机密>机密</OPTION></SELECT><DIV id=label12 style="LEFT: 0px; FLOAT: left; WIDTH: 65px; POSITION: static; TOP: 0px; HEIGHT: 15px; TEXT-ALIGN: center" onmovestart=moveStart() noWrap controltype="label" NotBg="否" value="label12">份数</DIV><INPUT id=fs style="LEFT: 0px; FLOAT: left; WIDTH: 16%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="FW_FS" china="份数" dataset="ds"></TD>
      </TR>
      <TR id=memo>
         <TD><DIV id=label15 style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 15px; TEXT-ALIGN: right" onmovestart=moveStart() noWrap controltype="label" NotBg="否" value="label15">意见</DIV></TD>
         <TD colSpan=3><TEXTAREA id=yj style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 100px" onmovestart=moveStart() controltype="textarea" value="textarea3" induce="否"></TEXTAREA></TD>
      </TR>
      <TR>
         <TD colSpan=2><DIV id=label13 style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 15px" onmovestart=moveStart() noWrap controltype="label" NotBg="否" value="label13">签发</DIV><TEXTAREA id=qf style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 100px" onmovestart=moveStart() readOnly controltype="textarea" value="textarea1" induce="否"></TEXTAREA></TD>
         <TD colSpan=2><DIV id=label14 style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 15px" onmovestart=moveStart() noWrap controltype="label" NotBg="否" value="label14">主要领导批示</DIV><TEXTAREA id=ldyj style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 100px" onmovestart=moveStart() readOnly controltype="textarea" value="textarea2" induce="否"></TEXTAREA></TD>
      </TR>
      <TR>
         <TD><DIV id=label16 style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 15px; TEXT-ALIGN: right" onmovestart=moveStart() noWrap controltype="label" NotBg="否" value="label16">拟稿单位</DIV><INPUT id=ngdwid style="DISPLAY: none; LEFT: 0px; WIDTH: 110px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text"></TD>
         <TD><INPUT id=ngdw style="LEFT: 0px; WIDTH: 70%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="FW_NGDW" china="拟稿单位" dataset="ds"><BUTTON id=button1 style="LEFT: 0px; WIDTH: 75px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick="bill_onclick(&quot;openTree('org',ngdwid,ngdw,false)&quot;)">选择</BUTTON></TD>
         <TD colSpan=2 rowSpan=4><DIV id=label20 style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 15px" onmovestart=moveStart() noWrap controltype="label" NotBg="否" value="label20">办公室审核意见</DIV><TEXTAREA id=bgsh style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 100px" onmovestart=moveStart() readOnly controltype="textarea" value="textarea4" induce="否"></TEXTAREA></TD>
      </TR>
      <TR>
         <TD><DIV id=label17 style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 15px; TEXT-ALIGN: right" onmovestart=moveStart() noWrap controltype="label" NotBg="否" value="label17">拟稿日期</DIV></TD>
         <TD><INPUT id=ngrq style="LEFT: 0px; WIDTH: 70%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" field="FW_NGRQ" china="拟稿日期" dataset="ds" onclick='bill_onclick("SelectDate()")'></TD>
      </TR>
      <TR>
         <TD><DIV id=label18 style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 15px; TEXT-ALIGN: right" onmovestart=moveStart() noWrap controltype="label" NotBg="否" value="label18">拟稿人</DIV></TD>
         <TD><INPUT id=ngr style="LEFT: 0px; WIDTH: 70%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="FW_NGR" china="拟稿人" dataset="ds"></TD>
      </TR>
      <TR>
         <TD><DIV id=label19 style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 15px; TEXT-ALIGN: right" onmovestart=moveStart() noWrap controltype="label" NotBg="否" value="label19">核稿人</DIV></TD>
         <TD><INPUT id=hgr style="LEFT: 0px; WIDTH: 70%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" field="FW_HGR" china="核稿人" dataset="ds"></TD>
      </TR>
      <TR>
         <TD><DIV id=label21 style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 15px; TEXT-ALIGN: right" onmovestart=moveStart() noWrap controltype="label" NotBg="否" value="label21">主送</DIV><INPUT id=zsid style="DISPLAY: none; LEFT: 0px; WIDTH: 110px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text"></TD>
         <TD colSpan=3><TEXTAREA id=zs style="LEFT: 0px; WIDTH: 80%; POSITION: static; TOP: 0px; HEIGHT: 85px" onmovestart=moveStart() controltype="textarea" field="FW_ZS" china="主送" dataset="ds" value="textarea5" induce="否"></TEXTAREA><BUTTON id=button2 style="LEFT: 0px; WIDTH: 75px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick="bill_onclick(&quot;openTree('org',zsid,zs,false)&quot;)">选择</BUTTON></TD>
      </TR>
      <TR>
         <TD><DIV id=label22 style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 15px; TEXT-ALIGN: right" onmovestart=moveStart() noWrap controltype="label" NotBg="否" value="label22">抄送</DIV><INPUT id=csid style="DISPLAY: none; LEFT: 0px; WIDTH: 110px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text"></TD>
         <TD colSpan=3><TEXTAREA id=cs style="LEFT: 0px; WIDTH: 80%; POSITION: static; TOP: 0px; HEIGHT: 85px" onmovestart=moveStart() controltype="textarea" field="FW_CS" china="抄送" dataset="ds" value="textarea6" induce="否"></TEXTAREA><BUTTON id=button3 style="LEFT: 0px; WIDTH: 75px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick="bill_onclick(&quot;openTree('org',csid,cs,false)&quot;)">选择</BUTTON></TD>
      </TR>
      <TR>
         <TD><DIV id=label23 style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 15px; TEXT-ALIGN: right" onmovestart=moveStart() noWrap controltype="label" NotBg="否" value="label23">主题词</DIV></TD>
         <TD colSpan=3><INPUT id=ztc style="LEFT: 0px; WIDTH: 80%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="FW_ZTC" china="主题词" dataset="ds"></TD>
      </TR>
      <TR>
         <TD><DIV id=label24 style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 15px; TEXT-ALIGN: right" onmovestart=moveStart() noWrap controltype="label" NotBg="否" value="label24">标题</DIV></TD>
         <TD colSpan=3><INPUT id=bt style="LEFT: 0px; WIDTH: 80%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="FW_BT" china="标题" dataset="ds"></TD>
      </TR>
      <TR>
         <TD><DIV id=label25 style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 15px; TEXT-ALIGN: right" onmovestart=moveStart() noWrap controltype="label" NotBg="否" value="label25">正文</DIV></TD>
         <TD colSpan=3><BUTTON id=button4 style="LEFT: 0px; WIDTH: 75px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("openEdit()")'>编辑</BUTTON></TD>
      </TR>
      <TR>
         <TD><DIV id=label26 style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 15px; TEXT-ALIGN: right" onmovestart=moveStart() noWrap controltype="label" NotBg="否" value="label26">附件</DIV></TD>
         <TD colSpan=3><BUTTON id=button6 style="LEFT: 0px; WIDTH: 75px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("editFJ()")'>编辑</BUTTON></TD>
      </TR>
   </TBODY>
</TABLE>

<DIV id=workflowControl2 style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; OVERFLOW-Y: hidden; LEFT: 0px; OVERFLOW-X: hidden; OVERFLOW: auto; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 171.66%" onmovestart=moveStart() controltype="workflowControl" NotBg="是">
   <DIV id=workflowControl_selectAct_div style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; OVERFLOW-Y: hidden; FONT-SIZE: 12px; LEFT: 0px; FLOAT: left; OVERFLOW-X: hidden; BORDER-LEFT: 0px; WIDTH: 215px; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 30px; auto: " onmovestart=moveStart() controltype="div" NotBg="是">请选择活动：
      <SELECT id=workflowControl_selectAct style="LEFT: 58px; WIDTH: 120px; POSITION: static; TOP: 33px; HEIGHT: 25px" onmovestart=moveStart() onchange='bill_onclick("changeSelectActor()")' sqltrans controltype="combobox" tempvalue temptext sql check="1"></SELECT>
   </DIV>
   <DIV id=workflowControl_selectUser style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; OVERFLOW-Y: hidden; FONT-SIZE: 12px; LEFT: 0px; FLOAT: left; OVERFLOW-X: hidden; OVERFLOW: auto; BORDER-LEFT: 0px; WIDTH: 340px; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 30px" onmovestart=moveStart() controltype="div" NotBg="是">请选择执行人：
      <INPUT id=DYNAMICPERFORMER_NAME style="LEFT: 0px; WIDTH: 150px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=25 controltype="text">
      <INPUT id=DYNAMICPERFORMER style="DISPLAY: none; LEFT: 0px; WIDTH: 5px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() size=2 controltype="text">
      <BUTTON class=button1 id=button_xzxr style="LEFT: 0px; WIDTH: 75px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("adduser();")'>选执行人</BUTTON>
   </DIV>
   <DIV id=workflowControl_selectAndUser style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; OVERFLOW-Y: hidden; FONT-SIZE: 12px; LEFT: 0px; FLOAT: left; OVERFLOW-X: hidden; OVERFLOW: auto; BORDER-LEFT: 0px; WIDTH: 380px; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 30px" onmovestart=moveStart() controltype="div" NotBg="是">请选择执行人：
      <INPUT id=ANDSPLITUSERS_ACTNAME style="LEFT: 0px; WIDTH: 150px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=25 controltype="text">
      <INPUT id=ANDSPLITUSERS style="DISPLAY: none; LEFT: 0px; WIDTH: 5px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() size=2 controltype="text">
      <BUTTON class=button1 id=button_yfzxzxr style="LEFT: 0px; WIDTH: 75px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("addAndUser();")'>与分支选执行人</BUTTON>
   </DIV>
   <DIV id=workflowControl_start style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; OVERFLOW-Y: hidden; LEFT: 0px; FLOAT: left; OVERFLOW-X: hidden; OVERFLOW: auto; BORDER-LEFT: 0px; WIDTH: 84px; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 30px" onmovestart=moveStart() controltype="div" NotBg="是">
      <BUTTON class=button1 id=button_qdlc style="LEFT: 0px; WIDTH: 75px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("startWorkFlow()")'>启动流程</BUTTON>
   </DIV>
   <DIV id=workflowControl_complete style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; OVERFLOW-Y: hidden; LEFT: 0px; FLOAT: left; OVERFLOW-X: hidden; OVERFLOW: auto; BORDER-LEFT: 0px; WIDTH: 84px; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 30px" onmovestart=moveStart() controltype="div" NotBg="是">
      <BUTTON class=button1 id=button_wchd style="LEFT: 0px; WIDTH: 75px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("completeWorkFlow()")'>完成活动</BUTTON>
   </DIV>
   <DIV id=workflowControl_back style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; OVERFLOW-Y: hidden; LEFT: 0px; FLOAT: left; OVERFLOW-X: hidden; OVERFLOW: auto; BORDER-LEFT: 0px; WIDTH: 84px; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 30px" onmovestart=moveStart() controltype="div" NotBg="是">
      <BUTTON class=button1 id=button_ht style="LEFT: 0px; WIDTH: 75px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick="bill_onclick(&quot;creator_djsave('回退',false,true,'../../../common_workflow/main.jsp')&quot;)">回退</BUTTON>
   </DIV>
   <DIV id=workflowControl_recycle style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; OVERFLOW-Y: hidden; LEFT: 0px; FLOAT: left; OVERFLOW-X: hidden; OVERFLOW: auto; BORDER-LEFT: 0px; WIDTH: 84px; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 30px" onmovestart=moveStart() controltype="div" NotBg="是">
      <BUTTON class=button1 id=button_hs style="LEFT: 0px; WIDTH: 75px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick="bill_onclick(&quot;creator_djsave('收回',false,true,'../../../common_workflow/main.jsp')&quot;)">收回</BUTTON>
   </DIV>
   <DIV id=workflowControl_tempSaveForm style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; OVERFLOW-Y: hidden; LEFT: 0px; FLOAT: left; OVERFLOW-X: hidden; OVERFLOW: auto; BORDER-LEFT: 0px; WIDTH: 84px; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 30px" onmovestart=moveStart() controltype="div" NotBg="是">
      <BUTTON class=button1 id=button_zc style="LEFT: 0px; WIDTH: 75px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick="bill_onclick(&quot;creator_djsave('暂存',true,true,'../../../common_workflow/main.jsp')&quot;)">暂存</BUTTON>
   </DIV>
   <DIV id=workflowControl_backToPrior style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; OVERFLOW-Y: hidden; LEFT: 0px; FLOAT: left; OVERFLOW-X: hidden; OVERFLOW: auto; BORDER-LEFT: 0px; WIDTH: 84px; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 30px" onmovestart=moveStart() controltype="div" NotBg="是">
      <BUTTON class=button1 id=button_fh style="LEFT: 0px; WIDTH: 75px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("history.back();")'>返回</BUTTON>
   </DIV>
   <INPUT id=workflowControl_result style="DISPLAY: none; LEFT: 0px; WIDTH: 0px; POSITION: static; TOP: 0px; HEIGHT: 0px" onmovestart=moveStart() controltype="text">
</DIV>

<?xml:namespace prefix = fc />

<fc:dataset id=ds format="<fields><field><fieldname>FW_WJN</fieldname><datatype>字符</datatype><displaylabel>文件年</displaylabel><size>20</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>FW_WJH</fieldname><datatype>字符</datatype><displaylabel>文件号</displaylabel><size>20</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>FW_HJ</fieldname><datatype>字符</datatype><displaylabel>缓急</displaylabel><size>20</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>FW_MJ</fieldname><datatype>字符</datatype><displaylabel>秘级</displaylabel><size>20</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>FW_FS</fieldname><datatype>字符</datatype><displaylabel>份数</displaylabel><size>20</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>FW_NGDW</fieldname><datatype>字符</datatype><displaylabel>拟稿单位</displaylabel><size>100</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>FW_NGRQ</fieldname><datatype>字符</datatype><displaylabel>拟稿日期</displaylabel><size>100</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>FW_NGR</fieldname><datatype>字符</datatype><displaylabel>拟稿人</displaylabel><size>20</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>FW_HGR</fieldname><datatype>字符</datatype><displaylabel>核稿人</displaylabel><size>20</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>FW_ZS</fieldname><datatype>字符</datatype><displaylabel>主送</displaylabel><size>1000</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>FW_CS</fieldname><datatype>字符</datatype><displaylabel>抄送</displaylabel><size>1000</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>FW_ZTC</fieldname><datatype>字符</datatype><displaylabel>主题词</displaylabel><size>200</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>FW_BT</fieldname><datatype>字符</datatype><displaylabel>标题</displaylabel><size>200</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>FW_BDID</fieldname><datatype>字符</datatype><displaylabel>主建</displaylabel><size>40</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>fw_date</fieldname><datatype>字符</datatype><displaylabel>发文日期</displaylabel><size>40</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>FW_FJID</fieldname><datatype>字符</datatype><displaylabel>附件主键</displaylabel><size>40</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field></fields>" onSetText='bill_ondatasetsettext("<dsid><FW_WJN></FW_WJN><FW_WJH></FW_WJH><FW_HJ></FW_HJ><FW_MJ></FW_MJ><FW_FS></FW_FS><FW_NGDW></FW_NGDW><FW_NGRQ></FW_NGRQ><FW_NGR></FW_NGR><FW_HGR></FW_HGR><FW_ZS></FW_ZS><FW_CS></FW_CS><FW_ZTC></FW_ZTC><FW_BT></FW_BT><FW_BDID></FW_BDID><fw_date></fw_date><FW_FJID></FW_FJID></dsid>")' onGetText='bill_ondatasetgettext("<dsid><FW_WJN></FW_WJN><FW_WJH></FW_WJH><FW_HJ></FW_HJ><FW_MJ></FW_MJ><FW_FS></FW_FS><FW_NGDW></FW_NGDW><FW_NGRQ></FW_NGRQ><FW_NGR></FW_NGR><FW_HGR></FW_HGR><FW_ZS></FW_ZS><FW_CS></FW_CS><FW_ZTC></FW_ZTC><FW_BT></FW_BT><FW_BDID></FW_BDID><fw_date></fw_date><FW_FJID></FW_FJID></dsid>")' onValid='bill_ondatasetvalid("<dsid><FW_WJN></FW_WJN><FW_WJH></FW_WJH><FW_HJ></FW_HJ><FW_MJ></FW_MJ><FW_FS></FW_FS><FW_NGDW></FW_NGDW><FW_NGRQ></FW_NGRQ><FW_NGR></FW_NGR><FW_HGR></FW_HGR><FW_ZS></FW_ZS><FW_CS></FW_CS><FW_ZTC></FW_ZTC><FW_BT></FW_BT><FW_BDID></FW_BDID><fw_date></fw_date><FW_FJID></FW_FJID></dsid>")' opensortno="1" temptable="TMP_DATASET1" multiResult="否"></fc:dataset>

<fc:dataset id=ds1 format="<fields><field><fieldname>ID</fieldname><datatype>字符</datatype><displaylabel>主键</displaylabel><size>40</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>FW_ACTION</fieldname><datatype>字符</datatype><displaylabel>行为</displaylabel><size>40</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>FW_CREATOR</fieldname><datatype>字符</datatype><displaylabel>行为人</displaylabel><size>20</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>FW_MEMO</fieldname><datatype>字符</datatype><displaylabel>意见</displaylabel><size>200</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>FW_DATE</fieldname><datatype>字符</datatype><displaylabel>发表意见的时间</displaylabel><size>40</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field></fields>" onSetText='bill_ondatasetsettext("<dsid><ID></ID><FW_ACTION></FW_ACTION><FW_CREATOR></FW_CREATOR><FW_MEMO></FW_MEMO><FW_DATE></FW_DATE></dsid>")' onGetText='bill_ondatasetgettext("<dsid><ID></ID><FW_ACTION></FW_ACTION><FW_CREATOR></FW_CREATOR><FW_MEMO></FW_MEMO><FW_DATE></FW_DATE></dsid>")' onValid='bill_ondatasetvalid("<dsid><ID></ID><FW_ACTION></FW_ACTION><FW_CREATOR></FW_CREATOR><FW_MEMO></FW_MEMO><FW_DATE></FW_DATE></dsid>")' opensortno="1" temptable="TMP_DATASET2" multiResult="否"></fc:dataset>
</DIV>
<div id='grid_tip'></div></body></html>
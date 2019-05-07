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
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_5/js/Namespace.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_5/js/Namespace.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_5/js/commonOperation.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_5/js/commonOperation.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_5/js/workflow.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_5/js/workflow.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_5/js/vo/vo.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_5/js/vo/vo.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_5/js/util/DBUtil.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_5/js/util/DBUtil.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_5/js/util/public.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_5/js/util/public.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_5/js/util/CookieManager.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_5/js/util/CookieManager.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_5/js/api/BaseService2InstanceAPI.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_5/js/api/BaseService2InstanceAPI.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_5/js/api/WebServ2InstanceAPI.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_5/js/api/WebServ2InstanceAPI.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_5/js/ApplyCtrl.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_5/js/ApplyCtrl.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_5/js/util/validate.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_5/js/util/validate.js'></script>");
if(!bDgMode) out.println("</script>");
%>
<script language='javascript'>
<%if(bDgMode){%>var mylink0 = document.createElement("link");
mylink0.setAttribute("type","text/css");
mylink0.setAttribute("rel","stylesheet");
mylink0.setAttribute("href",stylePath+"css/creatorBlue/style_right.css");
var myhead0 = document.getElementsByTagName("head")[0];
myhead0.appendChild(mylink0);
<%}else{%>adv_loadjsfile(stylePath+'css/creatorBlue/style_right.css');
<%}%></script>
   <script >document.styleSheets[0].addRule(".fcmask","behavior: url(../../fceform/htc/fcmask.htc)",0);</script>
   <script >document.styleSheets[0].addRule("fc\\:dataset","behavior: url(../../fceform/htc/dataset.htc)",0);</script>
   <script >document.styleSheets[0].addRule("fc\\:creatorSubForm","behavior: url(../../fceform/htc/creatorSubForm.htc)",0);</script>
   <script language='javascript'>
adv_loadjsfile('/eformsys/fceform/css/tabstyle.css');
adv_loadjsfile('/eformsys/fceform/js/fcmask.vbs');
adv_loadjsfile('/eformsys/fceform/js/webfxlayout.js');
adv_loadjsfile('/eformsys/fceform/css/luna/tab.css');
adv_loadjsfile('/eformsys/fceform/css/Button.css');
adv_loadjsfile('/eformsys/fceform/css/TextStyle.css');
adv_loadjsfile('/eformsys/fceform/js/fcdataset.js');
</script>


<!-- 提示：以下为页面自定义JS内容 -->
<script>

        
//==============================================全局对象变量定义=========================================
var ds = new DataStore();
var PageParms = {
    //新受理时为clear
    ccFormId :IsSpace(creator_getQueryString("cc_form_instanceid"))? "":creator_getQueryString("cc_form_instanceid"),
    //只有在新受理的时候才会传过来ecId，从暂存、补交告知、回退到受理过来的，须从instace表中查询获得
    ecId :IsSpace(creator_getQueryString("ec_id"))? "1341":1341,//得到项目基本信息ID
    //只有在新受理时才会传过来itemCode 
    itemCode : IsSpace(creator_getQueryString("item_code"))? "":creator_getQueryString("item_code"),//流程ID
    itemInsId : "",  //项目实例号
    yxtywlsh : "",  //原系统业务流水号
    //只有在新受理时才会传过来flowId 
    flowId : IsSpace(creator_getQueryString("flow_id"))? "":creator_getQueryString("flow_id"),//流程ID
    flowret : "",     //流程信息
    baseinfoVO : null,
    wfActionVO : null,
    instanceVO : null,
    applyViewVO : null,
    xzspWorkflowType : "",   //流程类别：1-普通流程 2-或分支选择 3-与分支选择
    isDynamicSelectAct : false,  //是否动态选择下一步活动
    isDynamicSelectAndAct : false, //是否动态选择下一步与活动
    isDynamicSelectUser : false, //是否动态选择或活动执行人
    nextActList : new Array(),
    instanceCode : "",
    isChargeShow : false,
    isFromParent : false,
    isFromChild : false,
    isFromPre : false, //是否来自预受理
    isFromNew : false, //来自新受理标志
    isFromTemp : false, //来自暂存标志
    isPrepareFlow : false,//来自预受理标志 
    isFromSupply : false, //来自补交告知标志
    isFromBack : false  //来自退回到受理的活动

}






//==============================================初始化及界面控制区=========================================


/**
 * 初始化
 * 本界面有4种入口，分别是新受理、来自暂存、来自补交告知、退回到受理
 * 系统默认只展示项目、申请人的主要填写区域，可点向下箭头展开填写更多
 * 系统默认不显示收费信息和意见列表，只有事项定义为收费的才小时收费，只有回退到受理的才显示意见列表
 */
function initByInitManager(){

    if(!IsSpace(PageParms.ccFormId) && PageParms.ccFormId!="clear" ){
        initBackInstance();
        PageParms.isFromBack =true;
        return;
    }
   $("CORP_TYPE").value="国有企业";

    hideOrShowTabByName("意见列表","hide"); //默认先隐藏意见列表页面 
    PageParms.isFromNew=true;
    
       PageParms.ccFormId = getNewCc_form_instanceid("true"); //生成一个新的业务ID

       creator_setSession("cc_form_instanceid",PageParms.ccFormId);
}


function initBackInstance(){
 
  var sql1="select * from ta_sp_instance where cc_form_instanceid='"+PageParms.ccFormId+"'";
  var sql3="select * from ta_sp_applycorp  where cc_form_instanceid='"+PageParms.ccFormId+"'";

  instanceDataset.Open(sql1); 
  applycorpDataset.Open(sql3);

  ds.SendAllRequest();
}

function creator_pt_onbodyload(){
  ds.regRequest(instanceDataset);
  ds.regRequest(applycorpDataset);
}




function insertInstance(){
  var item_insname=$("ITEM_INSNAME").value;
  var remark=$("REMARK1").value;
  var current_tache=creator_getQueryString("actDefName");
  var insid=$("INSTANCE_CODE").value;
  var sql ="insert into TA_SP_INSTANCE(ITEM_INSID,INSTANCE_CODE,EC_ID,ACCEPT_TIME,ACCEPTER,STATUS,CURRENT_TACHE,";
      sql+=" ACCEPTER_ID,ITEM_INSNAME,APPLY_ID,APPLY_TYPE,REMARK1) values('"+insid+"','"+insid+"',";
      sql+= "1341,sysdate,'"+getSysElement("userName")+"',";
      sql+= "'办理','"+current_tache+"','"+getSysElement('userName')+"',";
      sql+= "'"+item_insname+"','"+pubdjbh+"','"+getApplyType()+"','"+remark+"')";
  InsertSql(sql);

}




/* 初始化动态选择执行人和动态选择执行活动，视情况隐藏或展示 */
function initDynamicWorkflow(flowret){
    var ret = initDynamicWorkflowSet(flowret,"start"); //初始化动态选择
    PageParms.xzspWorkflowType = ret["xzspWorkflowType"];
    PageParms.isDynamicSelectAct = ret["isDynamicSelectAct"];
    PageParms.isDynamicSelectUser = ret["isDynamicSelectUser"];
    PageParms.isDynamicSelectAndAct = ret["isDynamicSelectAndAct"];
    PageParms.nextActList = ret["nextActList"];    
}








/* 根据不同的列表类别做界面控件的隐藏或显示 */
function initByListType(){
   if(creator_getQueryString("operType") == "nosend"){ //暂存
        if(creator_getQueryString("list_type") == "supply"){
           PageParms.isFromSupply = true;
           initFromSupply();
        }else{
           PageParms.isFromTemp = true;
        }
    }else if(creator_getQueryString("operType") == "daiban"){ //回退到受理
        PageParms.isFromBack = true;
        initFromBack();
    }else if(creator_getQueryString("operType") == "readonly" || creator_getQueryString("operType") == "onuse"){
        $('btnBack').style.display = "";
    }
}


/**
 * 初始化：来自补交告知
 * 以下按钮将不可点：暂存、预受理查询、打印受理通知书、受理、不予受理办件
 */
function initFromSupply(){
    initHideDynamic();
    $('btnTemp').style.display = "none";
    $('btnPreQuery').style.display = "none";
    $('btnPrtAccept').style.display = "none";
    $('btnAccept').style.display = "none";
    $('btnNotAccept').style.display = "none";
    $('btnSupplyInform').disabled = true;
    $('btnSupplyAccept').style.display = "";
}


/**
 * 初始化：退回到受理
 */
function initFromBack(){
    $('btnTemp').style.display = "none";
    $('btnPreQuery').style.display = "none";
    $('btnPrtAccept').style.display = "none";
    $('btnAccept').innerHTML = "完成活动";
    $('btnAccept').style.display = "";
    $('btnAccept').disabled = false;
    $('btnNotAccept').style.display = "none";
    $('btnSupplyInform').style.display = "none";
    $('btnSupplyAccept').style.display = "none";
}


/* 选择显示哪种申请者类型 */
function chooseApply(robj){
    if(robj.value == "1"){
        $("applyCorpArea").style.display="";
        $("applicantArea").style.display="none";
        $('applicantDefaultHideArea').style.display="none";
    }else{
        $("applyCorpArea").style.display="none";
        $("applicantArea").style.display="";
        $('applyCorpDefaultHideArea').style.display="none";
    }
}

//判断是否来自父流程
function isFromParent(){
    return true;
}

//判断是否从子流程返回
function isFromChild(){
    return true;
}


//==============================================功能按钮控制区=========================================


//判断是否输入了项目信息
function isInstanceEntered(){
    if(IsSpace($('ITEM_INSNAME').value)){
        alert("请输入项目名称");
        $('ITEM_INSNAME').focus();
        return false;
    }
    return true;
}

//判断是否输入了申请者信息
function isApplyEntered(){ 
        if(IsSpace($('CORP_NAME').value)){
            alert("请输入单位名称");
            $('CORP_NAME').focus();
            return false;
        }
        if(IsSpace($('CORP_CERTTYPE').value)){
            alert("请选择证件类型");
            $('CORP_CERTTYPE').focus();
            return false;
        }
        if(IsSpace($('CORP_ACCOUNTS').value)){
            alert("请输入证件号");
            $('CORP_ACCOUNTS').focus();
            return false;
        }

    return true;    
}


/* 暂存逻辑 */
function doTemp(){
    if(!checkByDataset() || !checkByReg()){
        return;
    }


}


/* 打开预受理查询表单 */
function openPreQueryView(){
    var args = "&cc_form_instanceid="+creator_getSession("cc_form_instanceid")+"&ec_id="+PageParms.ecId;
    var viewAddr = "20090827151939437040.jsp?cc_form_instanceid="+creator_getSession("cc_form_instanceid")+args;
    var featrues = "center:yes;help:no;resizable:no;status:no;scroll:no";
    var rtn = window.showModalDialog(viewAddr,window,featrues); 
    if(!IsSpace(rtn)){ //rtn为预受理实例的项目实例ID
        PageParms.isFromPre = true; //设置是否来自外网预受理
        InstanceManager.doSaveFromPre(rtn,doCallBackForInitFromPre);
    }
}



/* 打印受理通知书，打印完后显示“受理”按钮 */
function doPrintAccept(){

    if(isNewItem() || PageParms.isFromTemp){  //只有新受理、暂存时才需要产生流水号
        genInstanceCode(); //生成受理流水号     
    }
    $('btnAccept').disabled = false;
}
/* 打开动态选择执行人界面 */
function openOrSelectUserView(){
    var oUserId = document.getElementById("DYNAMICPERFORMER_ID");
    var oUserName = document.getElementById("DYNAMICPERFORMER");
    var oUserRealName = document.getElementById("DYNAMICPERFORMER_REALNAME");
    var actDefId = "";
    if(PageParms.xzspWorkflowType == "1"){  //普通流程
        actDefId = $('btnAccept').getAttribute("actid");
    }else if(PageParms.xzspWorkflowType == "2"){  //或选择
        actDefId = $('xzsp_workflowControl_selectAct').value;
    }
    openSelectUserTree(oUserId,oUserName,oUserRealName,false,true,PageParms.flowId,actDefId);
}



/* 受理按钮响应事件 */
function doAccept(){
    if(!checkByDataset() || !checkByReg()){
        return;
    }
    if(IsSpace( $("CORP_TYPE").value)){
          alert("单位性质不能为空");
          return;
    }

     if(PageParms.isFromBack){
         creator_setSession("cc_form_instanceid",PageParms.ccFormId);
        creator_djsave('完成活动',true,true,'../../../common_workflow/main.jsp');

        return;
     }
    SKbillsheet.keyfield="applycorp_id"; 
    SKbillsheet.codeheader="cor"; 
    fcpubvar.DsMain ="applycorpDataset";
      creator_setSession("cc_form_instanceid",PageParms.ccFormId);
   var msg=DjSave();
   if(!IsSpace(msg)){
      alert(msg);
      return;
   }
  

    creator_setSession("cc_form_instanceid",PageParms.ccFormId);
   if(isNewItem()){
     insertInstance();
    // insertAttach(cid);
   }
   //alert(PageParms.ccFormId);
   alert(fcpubdata.cc_form_instanceid);
   creator_djsave('启动流程',true,true,'../../../common_workflow/main.jsp');
      

}



//==============================================取界面参数区============================================


/* 获取流水号 */
function genInstanceCode(){
     var dd=new Date();
     var rtnData=dd.getFullYear()+""+(dd.getMonth()+1)+""+dd.getDate()+""+dd.getHours()+""+dd.getMinutes()+""+dd.getSeconds();
     $('INSTANCE_CODE').value = rtnData;
     PageParms.instanceCode = rtnData;

}


//判断是否是新受理项目：业务ID为空、不是来自预受理
function isNewItem(){
    if(!PageParms.isFromBack){ 
        return true;
    }
    return false;
}

//判断是否是来自外网预受理的项目
function isFromPre(){
    return PageParms.isFromPre;
}

/* 判断申请者类型是否为申请单位，如果不是，则是申请人 */
function isApplyTypeCorp(){
    return (getRadioValue("applyTypeCtrl") == "1");
}


//活动申请者类别
function getApplyType(){
    return 1;
}


//获得申请者姓名
function getApplyName(){
    return $('CORP_NAME').value;
}
/* 获取材料列表 */
function insertAttach(cid){
    var attachSubFormObj = window.frames("attachSubForm");
    if(attachSubFormObj){
        attachSubFormObj.insertAttach(cid);
    }
}


/* 预受理办件加载材料信息 */
function initPreAttachList(itemInsId){
    var attachSubFormObj = window.frames("attachSubForm");
    if(attachSubFormObj){
        return attachSubFormObj.initFromItemInsId(itemInsId);
    }
}



/* 校验函数 */
function checkByDataset(){
    return true;
}


/* 根据自定义规则校验 */
function checkByReg(){
    return true;
}


/* 查看审批规范 */
function openBaseInfoView(ecId){
  // 20090826143732234645   20090826161618109773
      var viewAddr = "20090826104738265675.jsp?cc_form_instanceid="+creator_getSession("cc_form_instanceid")+"&ec_id="+ecId;
      var featrues = "center:yes;help:no;resizable:no;status:no;scroll:no";
    showModalDialog(viewAddr,window,"status:yes;scrollbars:no;resizable:yes;dialogWidth:800px;");
}


</script>

<!-- 提示：以下为页面DOM元素内容 -->
<DIV id=SKbillsheet style="visibility:hidden" toolbar="不带工具栏" BLONopen="setAuthority();initByInitManager();" contxml="<root><textarea><id>REMARK1</id></textarea><combobox><id>CORP_CERTTYPE</id><id>CORP_TYPE</id><id>xzsp_workflowControl_selectAct</id></combobox><img><id>imgOne</id><id>imgTwo</id></img><tab><id>tab2</id></tab><div><id>mainDiv</id></div><button><id>btnViewBaseInfo</id><id>btnPreQuery</id><id>btnBack</id><id>button2</id><id>btnAccept</id><id>btnNotAccept</id></button><text><id>ITEM_INSID</id><id>ITEM_INSNAME</id><id>INSTANCE_CODE</id><id>ACCEPT_TIME</id><id>STATUS</id><id>APPLICANT_ID</id><id>CORP_NAME</id><id>CORP_ACCOUNTS</id><id>RELATOR</id><id>RELATOR_MOBILE</id><id>CORP_ADDR</id><id>CORPORATOR</id><id>CORPORATOR_PHONE</id><id>XZSPNEXTACT_NAME</id><id>XZSPNEXTACT</id><id>DYNAMICPERFORMER_REALNAME</id><id>DYNAMICPERFORMER</id><id>DYNAMICPERFORMER_ID</id></text><dataset><id>applycorpDataset</id><id>instanceDataset</id><id>queryFieldDataset</id></dataset><creatorSubForm><id>attachSubForm</id><id>taskListSubForm</id></creatorSubForm></root>" billtaborder="<root><taborder>REMARK1</taborder><taborder>CORP_TYPE</taborder><taborder>xzsp_workflowControl_selectAct</taborder><taborder>btnViewBaseInfo</taborder><taborder>btnPreQuery</taborder><taborder>btnBack</taborder><taborder>btnAccept</taborder><taborder>btnNotAccept</taborder><taborder>ITEM_INSID</taborder><taborder>ITEM_INSNAME</taborder><taborder>INSTANCE_CODE</taborder><taborder>ACCEPT_TIME</taborder><taborder>STATUS</taborder><taborder>APPLICANT_ID</taborder><taborder>CORP_NAME</taborder><taborder>CORP_ACCOUNTS</taborder><taborder>RELATOR</taborder><taborder>RELATOR_MOBILE</taborder><taborder>CORP_ADDR</taborder><taborder>CORPORATOR</taborder><taborder>CORPORATOR_PHONE</taborder><taborder>XZSPNEXTACT_NAME</taborder><taborder>XZSPNEXTACT</taborder><taborder>DYNAMICPERFORMER_REALNAME</taborder><taborder>DYNAMICPERFORMER</taborder><taborder>DYNAMICPERFORMER_ID</taborder><taborder>CORP_CERTTYPE</taborder><taborder>button2</taborder></root>" dj_sn="20090826114651203188" caption="受理表单" mkbh codeheader="APP" entertype="修改" poswidth posheight controlno="SKButton:0;SKDBedit:0;checkbox:0;label:0;radio:0;listbox:0;textarea:0;combobox:1;password:0;upload:0;SKDBtext:0;chart:0;dbimg:0;img:0;SKBILLgrid:0;shape:0;tab:0;div:0;DsMain_field:0;a:0;button:2;text:1;hr:0;checkboxlist:0;radiolist:0;dropdownlist:1;grid:0;dataset:0;spin:0;excel:0;tree:0;ebshow:0;creatorSubForm:0;creator_div:0;ExtGrid:0;ExtUpload:0;ExtTree:0;Fusionchar:0" window="当前窗口" posleft postop keyfield="applycorp_id" isfile="否" OtherSave="否" idtype="1" testDbName="bspf" creatorStyle="creatorBlue" BLONclose="UnLoadWebOffice();" creator_remark hasWorkflowButton="是" creator_elementAuthoritySwitch="否" creator_showAlert="否" creator_office_isBindForm="否" islog="否" isprotect="是" creator_csslib="style_right.css" version="1.0" creator_pagination type="ZW" creatorType="20090825142858531214" jslib="fcsavedj.js&#13;&#10;fcselfuse.js&#13;&#10;fcbasecont.js&#13;&#10;fcother.js&#13;&#10;selectdate.js&#13;&#10;~userfunc.js&#13;&#10;fcdate.js&#13;&#10;../../../ccapp/app_5/js/Namespace.js&#13;&#10;../../../ccapp/app_5/js/commonOperation.js&#13;&#10;../../../ccapp/app_5/js/workflow.js&#13;&#10;../../../ccapp/app_5/js/vo/vo.js&#13;&#10;../../../ccapp/app_5/js/util/DBUtil.js&#13;&#10;../../../ccapp/app_5/js/util/public.js&#13;&#10;../../../ccapp/app_5/js/util/CookieManager.js&#13;&#10;../../../ccapp/app_5/js/api/BaseService2InstanceAPI.js&#13;&#10;../../../ccapp/app_5/js/api/WebServ2InstanceAPI.js&#13;&#10;../../../ccapp/app_5/js/ApplyCtrl.js&#13;&#10;../../../ccapp/app_5/js/util/validate.js" creator_allTab="<tabs><tab><id>tab2</id><content><index>0</index><gridid></gridid><iframeid>attachSubForm</iframeid><index>1</index><gridid></gridid><iframeid>taskListSubForm</iframeid></content></tab></tabs>">

<TABLE width="100%" border=0>
   <TBODY>
      <TR>
         <TD>
            <TABLE class=table_sidle width="100%">
               <TBODY>
                  <TR>
                     <TD class=all_title align=left width="50%"><DIV id=divItemName></DIV></TD>
                     <TD class=all_title align=right><DIV id=divCurrentTache></DIV></TD>
                  </TR>
               </TBODY>
            </TABLE>
         </TD>
      </TR>
      <TR>
         <TD vAlign=top align=right><BUTTON class=btn_long id=btnViewBaseInfo onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("openBaseInfoView(PageParms.ecId)")'>查看审批规范</BUTTON><BUTTON class=btn id=btnPreQuery onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("openPreQueryView()")'>预受理查询</BUTTON><BUTTON class=btn id=btnBack onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("history.back(-1);")'>返回</BUTTON><BUTTON id=button2 style="LEFT: 0px; WIDTH: 75px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick="bill_onclick(&quot;alert(creator_getSession('cc_form_instanceid'));&quot;)">button2</BUTTON></TD>
      </TR>
      <TR>
         <TD>
            <TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
               <TBODY>
                  <TR>
                     <TD>
                        <TABLE class=table_function width="100%">
                           <TBODY>
                              <TR>
                                 <TD class=color width="15%"><INPUT id=ITEM_INSID style="DISPLAY: none; LEFT: 0px; WIDTH: 1px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=2 controltype="text" field="ITEM_INSID" china="ITEM_INSID" dataset="instanceDataset"><FONT color=red>*</FONT>项目名称</TD>
                                 <TD colSpan=3><INPUT id=ITEM_INSNAME style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="ITEM_INSNAME" china="ITEM_INSNAME" dataset="instanceDataset"></TD>
                              </TR>
                              <TR>
                                 <TD class=color width="15%">受理流水号</TD>
                                 <TD width="35%"><INPUT id=INSTANCE_CODE style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" field="INSTANCE_CODE" china="INSTANCE_CODE" dataset="instanceDataset"></TD>
                                 <TD class=color width="15%">受理时间</TD>
                                 <TD><INPUT id=ACCEPT_TIME style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 90%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" field="ACCEPT_TIME" china="ACCEPT_TIME" dataset="instanceDataset"><IMG id=imgOne style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() height=16 src="../../../ccapp/app_5/images/menu_off.gif" width=16 controltype="img" onclick="bill_onclick(&quot;showAreaCtrl('instanceDefaultHideArea')&quot;)" cover="9" srcsk="../../../ccapp/app_5/images/menu_off.gif"></TD>
                              </TR>
                           </TBODY>
                        </TABLE>
                     </TD>
                  </TR>
                  <TR>
                     <TD>
                        <TABLE class=table_function_other id=instanceDefaultHideArea style="DISPLAY: none" width="100%">
                           <TBODY>
                              <TR>
                                 <TD class=color width="15%">备注<INPUT id=STATUS style="DISPLAY: none; LEFT: 0px; WIDTH: 28px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() size=5 controltype="text" field="STATUS" china="办件状态" dataset="instanceDataset"></TD>
                                 <TD><TEXTAREA id=REMARK1 style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 42px" onmovestart=moveStart() cols=19 controltype="textarea" field="REMARK1" china="REMARK1" dataset="baseinfoDataset" value="textarea1" induce="否"></TEXTAREA></TD>
                              </TR>
                           </TBODY>
                        </TABLE>
                     </TD>
                  </TR>
               </TBODY>
            </TABLE>
            <TR>
               <TD>
                  <TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
                     <TBODY>
                        <TR>
                           <TD>
                              <TABLE class=table_function width="100%">
                                 <TBODY>
                                    <STYLE type=text/css>
                                       <!--div#showCorpNameDiv{ position: absolute;width: 100%;visibility: hidden;left: 0px;top: 20px;z-index:1;}div#showCorpNameDiv ul {border: 1px solid #000000;text-align: left;}div#showCorpNameDiv li { position: relative; width: 100%; background-color: #FFFFFF; cursor: default; line-height: 18px; text-indent: 2px;}div#showCorpNameDiv li.hov {background-color: #6666FF;color: #FFFFFF;}div#showCorpNameDiv li.hov span {color: #99FFFF;}div#showCorpNameDiv li span {color: #009900;position: absolute;top: 0px;right: 2px;}UL {list-style-type: none;}div#showPersonNameDiv{ position: absolute;width: 100%;visibility: hidden;left: 0px;top: 20px;z-index:1;}div#showPersonNameDiv ul {border: 1px solid #000000;text-align: left;}div#showPersonNameDiv li { position: relative; width: 100%; background-color: #FFFFFF; cursor: default; line-height: 18px; text-indent: 2px;}div#showPersonNameDiv li.hov {background-color: #6666FF;color: #FFFFFF;}div#showPersonNameDiv li.hov span {color: #99FFFF;}div#showPersonNameDiv li span {color: #009900;position: absolute;top: 0px;right: 2px;}UL {list-style-type: none;}--></STYLE>
                                       <TR>
                                          <TD id=applyTypeSelect><INPUT style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; BORDER-LEFT: 0px; BORDER-BOTTOM: 0px" onclick=chooseApply(this) type=radio CHECKED value=1 name=RGapplyTypeCtrl>申请单位<SPAN style="TEXT-ALIGN: right"></SPAN></TD>
                                       </TR>
                                    </TBODY>
                                 </TABLE>
                              </TD>
                           </TR>
                           <TR>
                              <TD>
                                 <TABLE class=table_function_other id=applyCorpArea width="100%">
                                    <TBODY>
                                       <TR>
                                          <TD class=color><FONT color=red>*</FONT><INPUT id=APPLICANT_ID style="DISPLAY: none; LEFT: 0px; WIDTH: 1px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() size=2 controltype="text" field="APPLICANT_ID" china="APPLICANT_ID" dataset="applicantDataset">单位名称</TD>
                                          <TD colSpan=3><DIV style="POSITION: relative"><INPUT id=CORP_NAME style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="CORP_NAME" china="CORP_NAME" dataset="applycorpDataset"></DIV></TD>
                                       </TR>
                                       <TR>
                                          <TD class=color width="15%"><FONT color=red>*</FONT>证件类型</TD>
                                          <TD width="35%"><SELECT id=CORP_CERTTYPE style="LEFT: 0px; WIDTH: 120px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() sqltrans controltype="combobox" field="CORP_CERTTYPE" china="证件类型" dataset="applycorpDataset" tempvalue="1&#13;&#10;0" temptext="工商注册号&#13;&#10;组织机构代码" sql check="1"><OPTION value=1 selected>工商注册号</OPTION><OPTION value=0>组织机构代码</OPTION></SELECT></TD>
                                          <TD class=color width="15%"><FONT color=red>*</FONT>证件号码</TD>
                                          <TD><INPUT id=CORP_ACCOUNTS style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="CORP_ACCOUNTS" china="证件号码" dataset="applycorpDataset"></TD>
                                       </TR>
                                       <TR>
                                          <TD class=color>联系人</TD>
                                          <TD><INPUT id=RELATOR style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="RELATOR" china="RELATOR" dataset="applycorpDataset"></TD>
                                          <TD class=color>联系电话</TD>
                                          <TD><INPUT id=RELATOR_MOBILE onblur="app_5_checkPhone(this.value,'联系电话输入错误，请检查')" style="LEFT: 0px; WIDTH: 90%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() size=16 controltype="text" field="RELATOR_MOBILE" china="RELATOR_MOBILE" dataset="applycorpDataset"><IMG id=imgTwo style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() height=16 src="../../../ccapp/app_5/images/menu_off.gif" width=16 controltype="img" onclick="bill_onclick(&quot;showAreaCtrl('applyCorpDefaultHideArea')&quot;)" cover="9" srcsk="../../../ccapp/app_5/images/menu_off.gif"></TD>
                                       </TR>
                                    </TBODY>
                                 </TABLE>
                              </TD>
                           </TR>
                           <TR>
                              <TD>
                                 <TABLE class=table_function_other id=applyCorpDefaultHideArea style="DISPLAY: none" width="100%">
                                    <TBODY>
                                       <TR>
                                          <TR>
                                             <TD class=color>单位地址</TD>
                                             <TD colSpan=5><INPUT id=CORP_ADDR style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="CORP_ADDR" china="CORP_ADDR" dataset="applycorpDataset"></TD>
                                          </TR>
                                          <TR>
                                             <TD class=color width="15%">单位性质</TD>
                                             <TD width="35%"><SELECT id=CORP_TYPE style="WIDTH: 100%; POSITION: static; HEIGHT: 25px" onmovestart=moveStart() sqltrans controltype="combobox" field="CORP_TYPE" china="CORP_TYPE" dataset="applycorpDataset" tempvalue="国有企业&#13;&#10;非国有企业" temptext="国有企业&#13;&#10;非国有企业" sql check="1" backwidth="229" backheight="25"><OPTION value=国有企业 selected>国有企业</OPTION><OPTION value=非国有企业>非国有企业</OPTION></SELECT></TD>
                                             <TD width="15%"></TD>
                                             <TD></TD>
                                          </TR>
                                          <TR>
                                             <TD class=color>法人代表</TD>
                                             <TD><INPUT id=CORPORATOR style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="CORPORATOR" china="CORPORATOR" dataset="applycorpDataset"></TD>
                                             <TD class=color>法人代表电话</TD>
                                             <TD><INPUT id=CORPORATOR_PHONE onblur="app_5_checkPhone(this.value,'法人代表电话输入错误，请检查')" style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="CORPORATOR_PHONE" china="CORPORATOR_PHONE" dataset="applycorpDataset"></TD>
                                          </TR>
                                       </TBODY>
                                    </TABLE>
                                 </TD>
                              </TR>
                              <TR>
                                 <TD>
                                    <TABLE class=table_function_other id=applicantArea style="DISPLAY: none" width="100%">
                                       <TBODY>
                                          <TR>
                                             <TD class=color></TD>
                                             <TD colSpan=3><DIV style="POSITION: relative">&nbsp;<DIV id=showPersonNameDiv style="LEFT: -39px; TOP: 26px"></DIV></DIV></TD>
                                          </TR>
                                          <TR>
                                             <TD class=color width="15%"><FONT color=red></FONT></TD>
                                             <TD width="35%"></TD>
                                             <TD class=color width="15%"></TD>
                                             <TD></TD>
                                          </TR>
                                          <TR>
                                             <TD class=color></TD>
                                             <TD></TD>
                                             <TD class=color></TD>
                                             <TD></TD>
                                          </TR>
                                       </TBODY>
                                    </TABLE>
                                 </TD>
                              </TR>
                              <TR>
                                 <TD>
                                    <TABLE class=table_function_other id=applicantDefaultHideArea style="DISPLAY: none" width="100%">
                                       <TBODY>
                                          <TR>
                                             <TD class=color></TD>
                                             <TD colSpan=3></TD>
                                          </TR>
                                          <TR>
                                             <TD class=color width="15%"></TD>
                                             <TD width="35%">&nbsp;</TD>
                                             <TD width="15%"></TD>
                                             <TD></TD>
                                          </TR>
                                          <TR>
                                             <TD class=color></TD>
                                             <TD></TD>
                                             <TD class=color></TD>
                                             <TD></TD>
                                          </TR>
                                       </TBODY>
                                    </TABLE>
                                 </TD>
                              </TR>
                           </TBODY>
                        </TABLE>
                        <TR>
                           <TD><DIV id=mainDiv style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; OVERFLOW: auto; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 253px; BACKGROUND-COLOR: #ffffff" onmovestart=moveStart() controltype="div" NotBg="否"><DIV class=tab-pane id=tab2 style="LEFT: 0px; WIDTH: 100%; POSITION: absolute; TOP: 0px; HEIGHT: 97.75%" showtype="luna" IsHideTitle="否"><DIV class=tab-page style="WIDTH: 100%; HEIGHT: 79px"><H2 class=tab>材料信息</H2><IFRAME id=attachSubForm style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 209px" onmovestart=moveStart() src="" frameBorder=no scrolling=no controltype="creatorSubForm" id_load="1" objType="eform" autoload="yes" autoSetSize="no" url="../../jxc/dj/20090825161955609398.jsp?ecId=1341"></IFRAME></DIV><DIV class=tab-page style="WIDTH: 100%; HEIGHT: 79px"><H2 class=tab>意见列表</H2><IFRAME id=taskListSubForm style="LEFT: 50px; WIDTH: 100%; POSITION: static; TOP: 50px; HEIGHT: 209px" onmovestart=moveStart() src="" frameBorder=no scrolling=no controltype="creatorSubForm" id_load objType="eform" autoload="no" autoSetSize="no" url="../../jxc/dj/20090826083758343990.jsp"></IFRAME></DIV></DIV><SCRIPT>var tab2 = new WebFXTabPane( document.getElementById( "tab2" ) );</SCRIPT></DIV></TD>
                        </TR>
                        <TR>
                           <TD vAlign=top align=right><SPAN><SPAN id=xzsp_workflowControl_selectAndAct style="DISPLAY: none; FONT-SIZE: 12px"><INPUT id=XZSPNEXTACT_NAME style="LEFT: 0px; WIDTH: 92px; POSITION: static; TOP: 0px" onclick=openAndSelectActView() onmovestart=moveStart() readOnly size=14 controltype="text"><INPUT id=XZSPNEXTACT style="DISPLAY: none; LEFT: 0px; WIDTH: 5px; POSITION: static; TOP: 0px" onmovestart=moveStart() size=2 controltype="text"></SPAN><SPAN id=xzsp_workflowControl_selectOrAct style="DISPLAY: none; FONT-SIZE: 12px">选下一步环节：<SELECT id=xzsp_workflowControl_selectAct style="LEFT: 58px; WIDTH: 78px; POSITION: static; TOP: 33px" onmovestart=moveStart() sqltrans controltype="combobox" tempvalue temptext sql check="1"></SELECT></SPAN><SPAN id=xzsp_workflowControl_selectUser style="DISPLAY: none; FONT-SIZE: 12px">选执行人：<INPUT class=input_ico id=DYNAMICPERFORMER_REALNAME onclick=openOrSelectUserView() onmovestart=moveStart() readOnly size=14 controltype="text"><INPUT id=DYNAMICPERFORMER style="DISPLAY: none; LEFT: 0px; WIDTH: 2px; POSITION: static; TOP: 0px" onmovestart=moveStart() size=2 controltype="text"><INPUT id=DYNAMICPERFORMER_ID style="DISPLAY: none; LEFT: 0px; WIDTH: 2px; POSITION: static; TOP: 0px" onmovestart=moveStart() size=2 controltype="text"></SPAN><SPAN><BUTTON class=btn id=btnAccept disabled onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("doAccept()")'>受理</BUTTON><BUTTON class=btn id=btnNotAccept onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("doPrintAccept();")'>打印受理通知书</BUTTON></SPAN></SPAN></TD>
                        </TR>
                        <TR>
                           <TD></TD>
                        </TR>
                     </TBODY>
                  </TABLE>
                  <?xml:namespace prefix = fc />
                  <fc:dataset id=applycorpDataset format="<fields><field><fieldname>APPLYCORP_ID</fieldname><datatype>字符</datatype><displaylabel>APPLYCORP_ID</displaylabel><size>32</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>是</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>CORP_NAME</fieldname><datatype>字符</datatype><displaylabel>单位名称</displaylabel><size>100</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>是</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>CORP_CERTTYPE</fieldname><datatype>字符</datatype><displaylabel>证件类型</displaylabel><size>50</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>CORP_ACCOUNTS</fieldname><datatype>字符</datatype><displaylabel>证件号码</displaylabel><size>50</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>是</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>RELATOR</fieldname><datatype>字符</datatype><displaylabel>联系人</displaylabel><size>20</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>RELATOR_MOBILE</fieldname><datatype>字符</datatype><displaylabel>联系电话</displaylabel><size>20</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>CORP_TYPE</fieldname><datatype>字符</datatype><displaylabel>单位性质</displaylabel><size>32</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>CORP_ADDR</fieldname><datatype>字符</datatype><displaylabel>单位地址</displaylabel><size>150</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>CORPORATOR</fieldname><datatype>字符</datatype><displaylabel>法人代表</displaylabel><size>20</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>CORPORATOR_PHONE</fieldname><datatype>字符</datatype><displaylabel>法人代表电话</displaylabel><size>20</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field></fields>" onSetText='bill_ondatasetsettext("<dsid><APPLYCORP_ID></APPLYCORP_ID><CORP_NAME></CORP_NAME><CORP_CERTTYPE></CORP_CERTTYPE><CORP_ACCOUNTS></CORP_ACCOUNTS><RELATOR></RELATOR><RELATOR_MOBILE></RELATOR_MOBILE><CORP_TYPE></CORP_TYPE><CORP_ADDR></CORP_ADDR><CORPORATOR></CORPORATOR><CORPORATOR_PHONE></CORPORATOR_PHONE></dsid>")' onGetText='bill_ondatasetgettext("<dsid><APPLYCORP_ID></APPLYCORP_ID><CORP_NAME></CORP_NAME><CORP_CERTTYPE></CORP_CERTTYPE><CORP_ACCOUNTS></CORP_ACCOUNTS><RELATOR></RELATOR><RELATOR_MOBILE></RELATOR_MOBILE><CORP_TYPE></CORP_TYPE><CORP_ADDR></CORP_ADDR><CORPORATOR></CORPORATOR><CORPORATOR_PHONE></CORPORATOR_PHONE></dsid>")' onValid='bill_ondatasetvalid("<dsid><APPLYCORP_ID></APPLYCORP_ID><CORP_NAME></CORP_NAME><CORP_CERTTYPE></CORP_CERTTYPE><CORP_ACCOUNTS></CORP_ACCOUNTS><RELATOR></RELATOR><RELATOR_MOBILE></RELATOR_MOBILE><CORP_TYPE></CORP_TYPE><CORP_ADDR></CORP_ADDR><CORPORATOR></CORPORATOR><CORPORATOR_PHONE></CORPORATOR_PHONE></dsid>")' opensortno="1" temptable="TMP_DATASET2" saveastable="TA_SP_APPLYCORP" multiResult="是"></fc:dataset>
                  <fc:dataset id=instanceDataset format="<fields><field><fieldname>ITEM_INSID</fieldname><datatype>字符</datatype><displaylabel>ITEM_INSID</displaylabel><size>32</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>INSTANCE_CODE</fieldname><datatype>字符</datatype><displaylabel>流水号</displaylabel><size>32</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>ITEM_INSNAME</fieldname><datatype>字符</datatype><displaylabel>项目名称</displaylabel><size>200</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>是</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>STATUS</fieldname><datatype>字符</datatype><displaylabel>办件状态</displaylabel><size>50</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>ACCEPT_TIME</fieldname><datatype>日期</datatype><displaylabel>受理日期</displaylabel><size>20</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>APPLYCORP_ID</fieldname><datatype>字符</datatype><displaylabel>APPLYCORP_ID</displaylabel><size>32</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>APPLICANT_ID</fieldname><datatype>字符</datatype><displaylabel>APPLICANT_ID</displaylabel><size>32</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field></fields>" onSetText='bill_ondatasetsettext("<dsid><ITEM_INSID></ITEM_INSID><INSTANCE_CODE></INSTANCE_CODE><ITEM_INSNAME></ITEM_INSNAME><STATUS></STATUS><ACCEPT_TIME></ACCEPT_TIME><APPLYCORP_ID></APPLYCORP_ID><APPLICANT_ID></APPLICANT_ID></dsid>")' onGetText='bill_ondatasetgettext("<dsid><ITEM_INSID></ITEM_INSID><INSTANCE_CODE></INSTANCE_CODE><ITEM_INSNAME></ITEM_INSNAME><STATUS></STATUS><ACCEPT_TIME></ACCEPT_TIME><APPLYCORP_ID></APPLYCORP_ID><APPLICANT_ID></APPLICANT_ID></dsid>")' onValid='bill_ondatasetvalid("<dsid><ITEM_INSID></ITEM_INSID><INSTANCE_CODE></INSTANCE_CODE><ITEM_INSNAME></ITEM_INSNAME><STATUS></STATUS><ACCEPT_TIME></ACCEPT_TIME><APPLYCORP_ID></APPLYCORP_ID><APPLICANT_ID></APPLICANT_ID></dsid>")' opensortno="1" temptable="TMP_DATASET4" multiResult="是"></fc:dataset>
                  <fc:dataset id=queryFieldDataset format="<fields><field><fieldname>primaryName</fieldname><datatype>字符</datatype><displaylabel>主键名</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>fieldName0</fieldname><datatype>字符</datatype><displaylabel>字段名0</displaylabel><size>100</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>fieldName1</fieldname><datatype>字符</datatype><displaylabel>字段名1</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field></fields>" onSetText='bill_ondatasetsettext("<dsid><primaryName></primaryName><fieldName0></fieldName0><fieldName1></fieldName1></dsid>")' onGetText='bill_ondatasetgettext("<dsid><primaryName></primaryName><fieldName0></fieldName0><fieldName1></fieldName1></dsid>")' onValid='bill_ondatasetvalid("<dsid><primaryName></primaryName><fieldName0></fieldName0><fieldName1></fieldName1></dsid>")' opensortno="1" temptable="TMP_DATASET5" multiResult="是"></fc:dataset>
               </DIV>
<div id='grid_tip'></div></body></html>
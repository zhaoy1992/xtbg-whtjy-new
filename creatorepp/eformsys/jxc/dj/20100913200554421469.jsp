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
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/util/HTMLUtil.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/util/HTMLUtil.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/util/DateUtil.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/util/DateUtil.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/util/WorkflowUtil.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/util/WorkflowUtil.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/vo/AjslVo.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/vo/AjslVo.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/vo/AttachVo.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/vo/AttachVo.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/vo/publicVO.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/vo/publicVO.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/business/Ajsl.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/business/Ajsl.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/dao/AjslDao.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/dao/AjslDao.js'></script>");
if(!bDgMode) out.println("</script>");
%>

   <script >document.styleSheets[0].addRule(".fcmask","behavior: url(../../fceform/htc/fcmask.htc)",0);</script>
   <script >document.styleSheets[0].addRule("fc\\:dataset","behavior: url(../../fceform/htc/dataset.htc)",0);</script>
   <script language='javascript'>
adv_loadjsfile('/eformsys/fceform/css/tabstyle.css');
adv_loadjsfile('/eformsys/fceform/js/fcmask.vbs');
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
var WFT_ID = creator_getQueryString("wft_id");//事项实例ID
var PI_ID = creator_getQueryString("pi_id");//事项ID
var user = getSysElement("username");
var user_id = getSysElement("userid");
var ora_name = getSysElement("userorgname");
var currentDate = getNowTime();
var readOnlyFlag = creator_getQueryString("readOnlyFlag");
var cl_id = new Array();//材料ID
var md_id = new Array();//材料实例ID
var comit_id = new Array();//对应的提交状态
var arr_cl = new Array();//材料提交清单数组
var clTmp = "";//要提交的材料ID

//返回
function backBtn(){
    parent.window.location.href = "20100929153136375631.jsp";
}

//改变执法主体,也清空处罚事项
function changedUnit(){
    document.getElementById("PI_ID").value = "";
    PI_ID = 0;
}

//事项下拉列表
function piLoad(){
    if (document.getElementById("BU_NAME").value != "") {
        var tempPara="dialogWidth:760px;dialogHeight:400px;";
        var tempURL="20101013144720390036.jsp?USER_ID="+user_id+"&BU_ID="+document.getElementById("BU_ID").value;
        var rtn = showModalDialog(tempURL,window,tempPara);
        if (!IsSpace(rtn)) {
            document.getElementById("PI_ID").value = rtn.names;
            PI_ID = rtn.ids; 
        }
    } else {
        alert("请先选择执法主体!");
        return false;
    }
}

//违法记录列表初始化
function wfjlinit(){
    var sql = Ajsl.getWfjl(WFT_ID);
    Wfjldataset.Open(sql);
}

//当事人列表初始化
function dsrinit(){
    var sql = Ajsl.getDsr(WFT_ID);
    Dsrdataset.Open(sql);
}

//删除当事人
function delDsr(){
    var grid =  creator_pt_grids[1].obj;
    var ids = FormUtil.getExtGridSelectedIds("LTT_ID", grid);
    if (ids.length==0) {    
       alert("请选择要删除的记录！");
       return false;
    } else if (confirm('是否要删除所选数据?')) {
       var rv = Ajsl.delDsr(ids);
       if (rv) {
          alert("删除数据信息成功！");
       } else {
          alert("删除违法记录失败！");
       }
       reloadExtGrid();
    }
}

//环节提交前判断提交的材料清单是否有实例ID
function haveIDs(){
    for (var i=0; i<comit_id.length; i++) {
        if (Number(comit_id[i]) == 1) {
            if (Number(md_id[i]) == 0) {
                md_id[i] = DBUtil.getSeq('SEQ_LITIGANT_RD');
            }
        }
    }
}

//刷新界面上的材料提交状态
function refStatus(flag){
    var grid = creator_pt_grids[2].obj;
    var ids = FormUtil.getExtGridSelectedIds("RIL_ID", grid);
    for (var i=0; i<ids.length; i++) {
        Cllbdataset.MoveFirst();
        for (var j=0; j<Cllbdataset.RecordCount; j++) {
             if(Number(ids[i])==Number(Cllbdataset.Fields.Field['RIL_ID'].Value)) {
                 if (flag) {
                     grid.getView().getCell(j, 3).innerText= "已提交";
                 } else {
                     grid.getView().getCell(j, 3).innerText= "未提交";
                 }            
             }
             Cllbdataset.MoveNext();
        }
    }
}

//根据材料清单ID,标识撤消提交的材料信息
function clRtn(){
    var grid =  creator_pt_grids[2].obj;
    var ids = FormUtil.getExtGridSelectedIds("RIL_ID", grid);
    if (ids.length == 0) {
        alert("请选择要撤消提交的材料信息!");
        return false;
    } else if (confirm('是否要撤消提交材料信息?')) {
        for (var i=0; i<ids.length; i++) {
            for(var j=0; j<cl_id.length; j++) {
                if (Number(cl_id[j]) == Number(ids[i])) {
                    comit_id[j] = 0;
                }
            }
        }
        alert("材料清单撤消提交成功!");
        //刷新GRID为未提交数据
         refStatus(false);
    }
}


//根据材料清单ID,标识提交的材料信息
function clComit(){
    var grid =  creator_pt_grids[2].obj;
    var ids = FormUtil.getExtGridSelectedIds("RIL_ID", grid);
    if (ids.length == 0) {
        alert("请选择要提交的材料信息!");
        return false;
    } else if (confirm('是否要提交材料信息?')) {
        for (var i=0; i<ids.length; i++) {
            for(var j=0; j<cl_id.length; j++) {
                if (Number(cl_id[j]) == Number(ids[i])) {
                    comit_id[j] = 1;
                }
            }
        }
        alert("材料清单提交成功!");
        //刷新GRID为已提交数据
         refStatus(true);
    }
}

//根据材料清单ID上传附件前,产生材料清单实例ID
function storeMd(cid,flag){
    var k = 0;
    for(var i=0; i<cl_id.length; i++) {
        if (Number(cl_id[i]) == Number(cid)) {
            k = i;
            break;
        }
    }
    if (md_id[k] == 0) {
        var id = DBUtil.getSeq('SEQ_LITIGANT_RD');
        md_id[k] = id;
    }
    openUploadAndDownView(md_id[k],flag);
}

//封装提交材料清单
function packAttach(){
    var md_tmp="";//记录对应的实例ID
    clTmp="";
    for (var i=0;i<comit_id.length;i++) {
        if (comit_id[i]==1) {
            if (clTmp =="") {
                clTmp = cl_id[i];
                md_tmp = md_id[i];
            } else {
                clTmp = clTmp + "," + cl_id[i];
                md_tmp = md_tmp + "," + md_id[i];
            }
        }
    }
    var clTmpSplit = clTmp.split(",");
    var mdTmpSplit = md_tmp.split(",");
    var n=0;
    arr_cl.length=0;
    for (var k=0; k<clTmpSplit.length; k++) {
        Cllbdataset.MoveFirst();
        for (var j=0; j<Cllbdataset.RecordCount; j++) {
            if (Number(clTmpSplit[k])==Number(Cllbdataset.Fields.Field['RIL_ID'].Value)) {
                //封装vo和arr_cl数组
                  var vo = new AttachVo.Attach();
                vo.WFT_ID = WFT_ID;
                vo.MD_ID = mdTmpSplit[k];
                vo.MD_TITLE = Cllbdataset.Fields.Field['RIL_NAME'].Value;
                vo.MD_NUM = Cllbdataset.Fields.Field['ISR_AMT'].Value;
                vo.MD_EDIT_DATE = currentDate;
                vo.MD_DSM = 3;
                vo.MD_ISTEMPLATE = Cllbdataset.Fields.Field['RIL_ISTEMPLATE'].Value;
                vo.MD_TSM = 3;
                vo.MD_FORMAT = Cllbdataset.Fields.Field['RIL_FORMAT'].Value;
                vo.MD_ISACCESSORIES = 1; //有附件
                  vo.MD_ASM = 3;//附件存储方式
                  vo.ISPLATFORM = 0 ;
                vo.WORKFLOW_NAME = "受理";
                vo.MD_REFER_ATTRI = 1;
                arr_cl[n]=vo;
                n=n+1;       
            }
            Cllbdataset.MoveNext();
        }
    }
}

//材料列表初始化
//1为受理阶段
function cllbinit(userId){
    if (readOnlyFlag != "readOnly") {
        var sql = Ajsl.getCllb(PI_ID, 1, userId);
        Cllbdataset.Open(sql);
        Cllbdataset.MoveFirst();
        for (var i=0; i<Cllbdataset.RecordCount; i++) {
            cl_id[i] = Cllbdataset.Fields.Field['RIL_ID'].Value;//材料ID
            md_id[i] = 0;
            comit_id[i] = 0;
            Cllbdataset.MoveNext();
        }
    } else {
        var sql = Ajsl.getCllbByWftId(WFT_ID, userId);
        Cllbdataset.Open(sql);
    }
}

//提交
function comit(){
    if (confirm("确认结束本阶段?")) {
        if (Wfjldataset.RecordCount == 0) {
            alert("请添加违法记录!");
            return false;
        } else {
            Wfjldataset.MoveFirst();
            for (var i=0;i<Wfjldataset.RecordCount;i++) {
                if (Wfjldataset.Fields.Field['LTT_NAME'].Value==""){
                    alert("违法记录列表中，"+Wfjldataset.Fields.Field['OR_NAME'].Value+"，请添加当事人！");
                    return false;
                }
                Wfjldataset.MoveNext();
            }
        }
        if (validate()) {
            var obj = new AjslVo.Ajsl();
            var vo = DBUtil.getVoFromPage(obj);
            vo.WFT_ID = WFT_ID ;
            vo.IS_ID = ${'IS_ID'}.value;
            vo.AD_ID = ${'AD_ID'}.value;
            vo.PI_ID = PI_ID;
            vo.BU_ID = document.getElementById("BU_ID").value;   
            vo.BU_NAME = document.getElementById("BU_NAME").value;
            vo.WFT_HANDLER = user_id;
            vo.WFT_DATE_RETURN_RECEIVE = currentDate ;
            //事项实例状态
             vo.MIS_ID = WorkflowUtil.getMisId("DEAL_WITH_THE_CASE");
            haveIDs();//将提交的材料清单确保有材料清单实例ID
            packAttach();
            if (arr_cl.length==0) {
                var isNeedComit = WorkflowUtil.isNeedComtFile(PI_ID, 1);
                if (isNeedComit==1) {
                    alert("当前事项阶段需要提交材料信息!");
                    return false;
                }
                if (!confirm("当前尚无提交的材料，是否继续?")) {
                    return false;
                }
            }
            var rv = Ajsl.commitAjsl(vo, arr_cl);
            if (rv) {
                alert("提交数据信息成功！");
                parent.window.location.href = "20100929153136375631.jsp";
            } else {
                alert("提交数据信息失败！");
            }
    
        }
    }
}

//保存
function save(){
    if (validate()) {
        if (PI_ID == 0) {
            alert("请选择处罚事项");
            return false;
        }
        var obj = new AjslVo.Ajsl();
        var vo = DBUtil.getVoFromPage(obj);
        vo.WFT_ID = WFT_ID ;
        vo.PI_ID = PI_ID;
        vo.NDP_ID = 1;
        vo.IS_ID = ${'IS_ID'}.value;
        vo.AD_ID = ${'AD_ID'}.value;
        vo.BU_ID = document.getElementById("BU_ID").value;   
        vo.BU_NAME = document.getElementById("BU_NAME").value;
        vo.WFT_HANDLER = user_id;
        vo.WFT_DATE_RETURN_RECEIVE = currentDate ;
        //事项实例状态
         vo.MIS_ID = WorkflowUtil.getMisId("ACCEPT_THE_CASE");
        var rv = Ajsl.saveAjsl(vo);
        if (rv) {
            alert("保存数据信息成功！");
            if (WFT_ID ==0) {
                ${'comBtn'}.style.visibility="visible";
                WFT_ID = vo.WFT_ID ;
                document.getElementById("showForeigns").style.display="block";
            }
            $("BU_NAME").disabled=true;
            $("PI_ID").disabled=true;
            //HTMLUtil.readOnly($("PI_ID"),"commonReadOnly");
            wfjlinit();
            dsrinit();
            cllbinit();
            reloadExtGrid();     
        } else {
            alert("保存数据信息失败！");
        }
    }
}

//初始化
function init(){    
    if (WFT_ID == "" || WFT_ID == null) {
        WFT_ID=0;
        $("BU_ID").value = "<%=idTmp %>";
        $("BU_NAME").value = "<%=nameTmp %>";
    }
    if (WFT_ID) {
        var sql = Ajsl.getAjslById(WFT_ID);
        AjslSaveDataset.Open(sql);
        ${'BU_ID'}.value = AjslSaveDataset.Fields.Field['BU_ID'].Value;
        ${'BU_NAME'}.value = AjslSaveDataset.Fields.Field['BU_NAME'].Value;
        ${'IS_ID'}.value = AjslSaveDataset.Fields.Field['IS_ID'].Value;
        ${'AD_ID'}.value = AjslSaveDataset.Fields.Field['AD_ID'].Value;
        PI_ID = AjslSaveDataset.Fields.Field['PI_ID'].Value;
        document.getElementById("showForeigns").style.display="block";
        currentDate = AjslSaveDataset.Fields.Field['WFT_DATE_RETURN_RECEIVE'].Value;
        document.getElementById("signDate").innerHTML = currentDate.substr(0,10) ;
        var tmpdate = AjslSaveDataset.Fields.Field['WFT_DATE'].Value;
        ${'WFT_DATE'}.value = tmpdate.substr(0,10);
        user_id = AjslSaveDataset.Fields.Field['WFT_HANDLER'].Value;
        var tmpName = AjslSaveDataset.Fields.Field['USER_REALNAME'].Value;
        var orgName = AjslSaveDataset.Fields.Field['ORG_NAME'].Value;
        document.getElementById("signUser").innerHTML = orgName+" "+tmpName ;
        $("BU_NAME").disabled=true;
        $("PI_ID").disabled=true;    
        //HTMLUtil.readOnly($("PI_ID"),"commonReadOnly");
    } else {
        document.getElementById("signUser").innerHTML =ora_name+" "+user;
        document.getElementById("signDate").innerHTML = currentDate ;
        ${'comBtn'}.style.visibility="hidden";
        document.getElementById("showForeigns").style.display="none";
    }
    wfjlinit();
    dsrinit();
    cllbinit(user_id);
    reloadExtGrid();
    if (readOnlyFlag == "readOnly") {
        HTMLUtil.readOnly($("WFT_APPLICATION_NUMBER"),"commonReadOnly");
        HTMLUtil.readOnly($("WFT_DATE"),"commonReadOnly");
        HTMLUtil.readOnly($("IS_ID"),"commonReadOnly");
        HTMLUtil.readOnly($("AD_NAME"),"commonReadOnly");
        HTMLUtil.readOnly($("WFT_ADDRESS"),"commonReadOnly");
        HTMLUtil.readOnly($("WFT_TITLE"),"commonReadOnly");
        HTMLUtil.readOnly($("WFT_BRIEF"),"commonReadOnly");
        document.getElementById("comBtn").style.visibility="hidden";
        document.getElementById("saveBtn").style.visibility="hidden";
        document.getElementById("rtnBtn").style.visibility="hidden";
        document.getElementById("newWfjl").style.visibility="hidden";
        document.getElementById("delWfjl").style.visibility="hidden";
        document.getElementById("delDsr").style.visibility="hidden";
        document.getElementById("ComitCl").style.visibility="hidden";      
        document.getElementById("rtnComit").style.visibility="hidden";   
    }
}

//验证
function validate(){
    var flag = true;
    delSpace();
    if (flag) {
        flag = SValidator.validate(${'WFT_APPLICATION_NUMBER'}.value, {
            CHECK_TYPE : "required",
            ARGUMENT : {placeholders : [${'WFT_APPLICATION_NUMBER'}.value]},
            MESSAGE : "受理编号不能为空!"
        }, true);
    }
    if (flag) {
        var reg=/[\u4E00-\u9FA5]+/g;
        if (reg.test($("WFT_APPLICATION_NUMBER").value)){
            flag = false;
            alert("受理编号不能包含汉字！");
        }            
    }    
    if (flag) {
        flag = SValidator.validate(${'WFT_APPLICATION_NUMBER'}.value, {
            CHECK_TYPE : "maxlength",
            ARGUMENT : {placeholders : [10],maxlength : 10},
            MESSAGE : "受理编号最大不能超过{0}字符!"
        }, true);
    }
    if (flag) {
        flag = checkonly(WFT_ID, ${'WFT_APPLICATION_NUMBER'}.value);
        if (!flag) {
            alert("案件受理编码已存在，请重新输入！");
            return false;
        }
    }  
    if (flag) {
        if (document.getElementById('BU_NAME').value=="") {
            alert("请选择执法主体!");
            flag = false;
        }
    }
    if (flag) {
        if (document.getElementById('IS_ID').value==-1) {
            alert("请选择案件来源!");
            flag = false;
        }
    }
    if (flag) {
        flag = SValidator.validate(${'WFT_DATE'}.value, {
            CHECK_TYPE : "required",
            ARGUMENT : {placeholders : [${'WFT_DATE'}.value]},
            MESSAGE : "案发时间不能为空!"
        }, true);
    }
    if (flag) {
        var arys1=currentDate.split("-");   
        var sdate=new Date(arys1[0],parseInt(arys1[1]-1),arys1[2]);   
        var arys2=${'WFT_DATE'}.value.split("-");
        var edate=new Date(arys2[0],parseInt(arys2[1]-1),arys2[2]);
        if (sdate < edate) {
            alert("案发时间不能大于当前登记日期!");
            flag = false;
        }
    }
    if (flag) {
        flag = SValidator.validate($("PI_ID").value, {
            CHECK_TYPE : "required",
            ARGUMENT : {placeholders : [$("PI_ID").value]},
            MESSAGE : "处罚事项不能为空!"
        }, true);
    }
    if (flag) {
        if (document.getElementById('AD_ID').value==-1) {
            alert("请选择案发地址!");
            flag = false;
        }
    }
    if (flag) {
        flag = SValidator.validate(${'WFT_ADDRESS'}.value, {
            CHECK_TYPE : "required",
            ARGUMENT : {placeholders : [${'WFT_ADDRESS'}.value]},
            MESSAGE : "案发地址不能为空!"
        }, true);
    }
    if (flag) {
        flag = SValidator.validate(${'WFT_ADDRESS'}.value, {
            CHECK_TYPE : "maxlength",
            ARGUMENT : {placeholders : [125],maxlength : 125},
            MESSAGE : "案发地址不能超过{0}字符!"
        }, true);
    }
    if (flag) {
        flag = SValidator.validate(${'WFT_TITLE'}.value, {
            CHECK_TYPE : "required",
            ARGUMENT : {placeholders : [${'WFT_TITLE'}.value]},
            MESSAGE : "案发标题不能为空!"
        }, true);
    }
    if (flag) {
        flag = SValidator.validate(${'WFT_TITLE'}.value, {
            CHECK_TYPE : "maxlength",
            ARGUMENT : {placeholders : [125],maxlength : 125},
            MESSAGE : "案发标题最大不能超过{0}字符!"
        }, true);
    }
    if (flag) {
        flag = SValidator.validate(${'WFT_BRIEF'}.value, {
            CHECK_TYPE : "required",
            ARGUMENT : {placeholders : [${'WFT_BRIEF'}.value]},
            MESSAGE : "简要案件内容不能为空!"
        }, true);
    }
    return flag;
}

//去全角半角空格
function delSpace(){
    ${'WFT_APPLICATION_NUMBER'}.value = ${'WFT_APPLICATION_NUMBER'}.value.trim();
    ${'WFT_ADDRESS'}.value = ${'WFT_ADDRESS'}.value.trim();
    ${'WFT_TITLE'}.value = ${'WFT_TITLE'}.value.trim();
    ${'WFT_BRIEF'}.value = ${'WFT_BRIEF'}.value.trim();
}

//验证案件受理编码是否唯一
function checkonly(WFT_ID, bm){
    var countSql = Ajsl.countBm(WFT_ID, bm);
    if (countSql > 0) {
        return false;
    } else {
        return true;
    }
}

/* 打开上传下载页面 */
function openUploadAndDownView(id,flag){
    var isAllowDelete = flag ;
    var allowAdd = flag;
    var name = "app_xzcf";
    var viewAddr =getOpenUrlByDjid("20100920113019725484")+"&id="+id+"&allowDelete="+isAllowDelete+
             "&allowAdd="+allowAdd+"&mode_name="+name+"&djbh="+id +
             "&fileCount=10" ;
    var featrues = "dialogWidth:640px;dialogHeight:360px;center:yes;help:no;resizable:no;status:no;scroll:no";
    var rtn = window.showModalDialog(viewAddr,window,featrues); 
    return rtn ;
}

//跳转到新增违法记录
function newWfjl(){
    var tempPara="dialogWidth:760px;dialogHeight:550px;";
    var tempURL="20100917114541166821.jsp?wft_id=" + WFT_ID + "&PI_ID=" + PI_ID + "&or_id=0";
    var tmp = showModalDialog(tempURL,window,tempPara);
    reloadExtGrid();
   // window.location.href = "20100917114541166821.jsp?wft_id=" + WFT_ID + "&PI_ID=" + PI_ID + "&or_id=0";
}

//双击进入违法记录修改
function editWfjl(grid, rowIndex, e){
    var row = grid.store.getById(grid.store.data.items[rowIndex].id); 
    var orId= row.get("or_id");
    //window.location.href = "20100917114541166821.jsp?or_id=" + orId + "&wft_id=" + WFT_ID + "&PI_ID=" + PI_ID +
     //   "&readOnlyFlag=" + readOnlyFlag;
    
    var tempPara="dialogWidth:760px;dialogHeight:550px;";
    var tempURL="20100917114541166821.jsp?or_id=" + orId + "&wft_id=" + WFT_ID + "&PI_ID=" + PI_ID + "&readOnlyFlag=" + readOnlyFlag;
    showModalDialog(tempURL,window,tempPara);
    reloadExtGrid();

}

//删除违法记录
function delWfjl(){
    var grid =  creator_pt_grids[0].obj;
    var ids = FormUtil.getExtGridSelectedIds("OR_ID", grid);
    var names = FormUtil.getExtGridSelectedIds("OR_NAME", grid);
    if (ids.length==0) {    
       alert("请选择要删除的记录！");
       return false;
    } else if (confirm('是否要删除所选数据?')) {
       var rv = Ajsl.delWfjl(names, ids);
       if (rv == "") {
          alert("删除数据信息成功！");
          reloadExtGrid();
       } else {
          alert("删除违法记录失败:"+rv);
       }
    }
}

//双击修改当事人
function editDsr(grid, rowIndex, e){
    var row = grid.store.getById(grid.store.data.items[rowIndex].id); 
    var LTT_ID= row.get("ltt_id");
    var tempPara="dialogWidth:760px;dialogHeight:300px;";
    var tempURL="20100917152958303983.jsp?OR_ID=0"+"&WFT_ID="+WFT_ID+"&LTT_ID="+LTT_ID+"&readOnlyFlag="+readOnlyFlag;
    showModalDialog(tempURL,window,tempPara);
    reloadExtGrid();
}

//打开案发地址的选择
function openDivisionTree(){
    url = "../../../ccapp/app_xzcf/jsp/baseservice/chooseDivisionTree.jsp"; 
    window.showModalDialog(url,window, "dialogWidth=620px;dialogHeight=500px");
}

//打开执法主体的选择
function openOrgTree(){
    url = "../../../ccapp/app_xzcf/jsp/baseservice/chooseZfztResourseSingle.jsp";
    $("orgNames").value = $("BU_NAME").value ;
    $("orgIds").value = $("BU_ID").value ;
    var idTmp = $("BU_ID").value ;
    chooseUsers = window.showModalDialog(url,window, "dialogWidth=620px;dialogHeight=500px");
    $("BU_NAME").value = $("orgNames").value ;
    $("BU_ID").value  = $("orgIds").value ;
    if (idTmp!=$("orgIds").value) {
        $("PI_ID").value="";
    }
}
//打开行政区划的选择
function openDivisionTree(){
    url = "../../../ccapp/app_xzcf/jsp/baseservice/chooseDivisionTree.jsp"; 
    window.showModalDialog(url,window, "dialogWidth=620px;dialogHeight=500px");
}

//获取当前服务器时间
function getNowTime(){
    var nowYear = FormUtil.getServerYear();//获取当前服务器年
    var nowMonth = FormUtil.getServerMonth();//获取当前服务器月
    var nowDay = FormUtil.getServerDay();//获取当前服务器日
    if(parseInt(nowMonth) < 10){
        nowMonth = "0" + nowMonth;
    }
    if(parseInt(nowDay) < 10){
        nowDay = "0" + nowDay;
    }
    var nowDate = nowYear + "-" + nowMonth + "-" + nowDay;
    return nowDate;
}

</script>

<!-- 提示：以下为页面DOM元素内容 -->
<DIV id=SKbillsheet style="visibility:hidden" toolbar="不带工具栏" BLONopen="setAuthority();init();" contxml="<root><textarea><id>WFT_BRIEF</id></textarea><combobox><id>IS_ID</id></combobox><tab><id>tab9</id></tab><div><id>div1</id></div><button><id>saveBtn</id><id>comBtn</id><id>rtnBtn</id><id>newWfjl</id><id>delWfjl</id><id>delDsr</id><id>ComitCl</id><id>rtnComit</id></button><text><id>WFT_APPLICATION_NUMBER</id><id>BU_NAME</id><id>BU_ID</id><id>WFT_DATE</id><id>PI_ID</id><id>AD_NAME</id><id>WFT_ADDRESS</id><id>WFT_TITLE</id><id>orgIds</id><id>orgNames</id><id>AD_ID</id></text><dataset><id>Cllbdataset</id><id>AjslSaveDataset</id><id>Wfjldataset</id><id>Dsrdataset</id></dataset><ExtGrid><id>WfjlExtGrid</id><id>DsrExtGrid</id><id>cllbExtGrid</id></ExtGrid></root>" billtaborder="<root><taborder>saveBtn</taborder><taborder>comBtn</taborder><taborder>rtnBtn</taborder><taborder>IS_ID</taborder><taborder>WFT_DATE</taborder><taborder>newWfjl</taborder><taborder>delWfjl</taborder><taborder>delDsr</taborder><taborder>ComitCl</taborder><taborder>WFT_APPLICATION_NUMBER</taborder><taborder>WFT_ADDRESS</taborder><taborder>WFT_TITLE</taborder><taborder>WFT_BRIEF</taborder><taborder>PI_ID</taborder><taborder>rtnComit</taborder><taborder>BU_ID</taborder><taborder>BU_NAME</taborder><taborder>orgIds</taborder><taborder>orgNames</taborder><taborder>AD_NAME</taborder><taborder>AD_ID</taborder></root>" dj_sn="20100913200554421469" caption="案件受理" mkbh codeheader="BBB" entertype="修改" poswidth posheight controlno="SKButton:0;SKDBedit:0;checkbox:0;label:1;radio:0;listbox:0;textarea:2;combobox:6;password:0;upload:0;SKDBtext:0;chart:0;dbimg:0;img:0;SKBILLgrid:0;shape:0;tab:10;div:1;DsMain_field:0;a:0;button:7;text:20;hr:0;checkboxlist:0;radiolist:0;dropdownlist:0;grid:1;dataset:9;spin:0;excel:0;tree:0;ebshow:0;creatorSubForm:0;creator_div:0;ExtGrid:1;ExtUpload:0;ExtTree:0;Fusionchar:0" window="当前窗口" posleft postop keyfield isfile="否" OtherSave="否" idtype="1" testDbName="app_xzcf" creatorStyle="creatorBlue" BLONclose="UnLoadWebOffice();" creator_remark hasWorkflowButton="否" creator_elementAuthoritySwitch="否" creator_showAlert="否" creator_office_isBindForm="否" islog="否" isprotect="是" creator_csslib version="1.0" creator_pagination type="ZW" creatorType="20100913200141634274" jslib="fcbasecont.js&#13;&#10;selectdate.js&#13;&#10;~userfunc.js&#13;&#10;fcdate.js&#13;&#10;../../../ccapp/app_xzcf/js/common/Namespace.js&#13;&#10;../../../ccapp/app_xzcf/js/common/nsreg.js&#13;&#10;../../../ccapp/app_xzcf/js/common/Common.js&#13;&#10;../../../ccapp/app_xzcf/js/util/HTMLUtil.js&#13;&#10;../../../ccapp/app_xzcf/js/util/DateUtil.js&#13;&#10;../../../ccapp/app_xzcf/js/util/WorkflowUtil.js&#13;&#10;../../../ccapp/app_xzcf/js/vo/AjslVo.js&#13;&#10;../../../ccapp/app_xzcf/js/vo/AttachVo.js&#13;&#10;../../../ccapp/app_xzcf/js/vo/publicVO.js&#13;&#10;../../../ccapp/app_xzcf/js/business/Ajsl.js&#13;&#10;../../../ccapp/app_xzcf/js/dao/AjslDao.js" creator_allTab="<tabs><tab><id>tab9</id><content><index>0</index><gridid></gridid><iframeid></iframeid><index>1</index><gridid></gridid><iframeid></iframeid><index>2</index><gridid></gridid><iframeid></iframeid></content></tab></tabs>">

<TABLE height=196 cellSpacing=0 cellPadding=0 width="95%" align=center border=0>
   <TBODY>
      <TR>
         <TD>
            <TABLE class=Ctable height=196 cellSpacing=0 cellPadding=0 width="100%" align=center border=0>
               <TBODY>
                  <TR>
                     <TD class=taobox colSpan=6>案件基本信息</TD>
                  </TR>
                  <TR>
                     <TD class=c2>受理编号<FONT color=red>*</FONT></TD>
                     <TD><INPUT class=input_out id=WFT_APPLICATION_NUMBER style="LEFT: 0px; WIDTH: 121px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() size=22 controltype="text" field="WFT_APPLICATION_NUMBER" china="案件受理编号" dataset="AjslSaveDataset"></TD>
                     <TD class=c2>登记日期</TD>
                     <TD><SPAN id=signDate></SPAN></TD>
                     <TD class=c2>登记人</TD>
                     <TD><SPAN id=signUser></SPAN></TD>
                  </TR>
                  <TR>
                     <TD class=c2>执法主体<FONT color=red>*</FONT></TD>
                     <TD><INPUT class=input_image id=BU_NAME style="LEFT: 0px; WIDTH: 121px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=22 controltype="text" onclick='bill_onclick("openOrgTree();")'><INPUT id=BU_ID style="DISPLAY: none; LEFT: 0px; WIDTH: 29px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=5 controltype="text"></TD>
                     <TD class=c2>案件来源<FONT color=red>*</FONT></TD>
                     <TD colSpan=3><SELECT id=IS_ID style="LEFT: 0px; WIDTH: 120px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() sqltrans="%F4%D8%E6%D8%D4%F6Xrn%A0%B4%CC%A0%96Xr%94%A0%B4%CC%AA%90%A8%98Xrn%DA%F2%EC%E8Xrn%B6%90%CC%A0%AA%9A%AC%CC%B4%AC%B8%B2%94%98Xrn%EC%F2%D6%D8%F2Xrn%D2%u0100Xrn%A0%B4%CC%AC%B2%96%98%B2" controltype="combobox" tempvalue="-1" temptext="--请选择--" sql check="2"><OPTION value=-1 selected>--请选择--</OPTION></SELECT></TD>
                  </TR>
                  <TR>
                     <TD class=c2>案发时间<FONT color=red>*</FONT></TD>
                     <TD><INPUT class=its_out id=WFT_DATE style="LEFT: 0px; WIDTH: 120px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=22 controltype="text" onclick='bill_onclick("SelectDate()")'></TD>
                     <TD class=c2>处罚事项<FONT color=red>*</FONT></TD>
                     <TD colSpan=3><INPUT class=input_image id=PI_ID style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=21 controltype="text" field="PI_NAME" china="处罚事项名称" dataset="AjslSaveDataset" onclick='bill_onclick("piLoad()")'></TD>
                  </TR>
                  <TR>
                     <TD class=c2>案发地址<FONT color=red>*</FONT></TD>
                     <TD colSpan=5><INPUT class=input_image id=AD_NAME style="LEFT: 0px; WIDTH: 103px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=17 controltype="text" field="AD_NAME" china="行政区域名称" dataset="AjslSaveDataset" onclick='bill_onclick("openDivisionTree();")'>&nbsp;<INPUT class=input_out id=WFT_ADDRESS style="LEFT: 0px; WIDTH: 83%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() size=65 controltype="text" field="WFT_ADDRESS" china="案件细节地址" dataset="AjslSaveDataset"></TD>
                  </TR>
                  <TR>
                     <TD class=c2>案件标题<FONT color=red>*</FONT></TD>
                     <TD colSpan=5><INPUT class=input_out id=WFT_TITLE style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() size=88 controltype="text" field="WFT_TITLE" china="案件标题" dataset="AjslSaveDataset"></TD>
                  </TR>
                  <TR>
                     <TD class=c2>简要案件内容<FONT color=red>*</FONT></TD>
                     <TD colSpan=5><TEXTAREA class=input_out id=WFT_BRIEF style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 85px" onmovestart=moveStart() cols=98 controltype="textarea" field="WFT_BRIEF" china="简要案件内容" dataset="AjslSaveDataset" value="textarea2" induce="否"></TEXTAREA></TD>
                  </TR>
               </TBODY>
            </TABLE>
            <DIV align=center>
               <BUTTON class=button id=saveBtn style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("save()")'>保存</BUTTON>
               <BUTTON class=button id=comBtn style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("comit()")'>提交</BUTTON>
               <BUTTON class=button id=rtnBtn style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("backBtn()")'>返回</BUTTON>
            </DIV>
         </TD>
      </TR>
      <TR>
         <TD><?xml:namespace prefix = fc /><fc:dataset id=Cllbdataset showtypeXml="<root><showType><name>checked</name><showRule>%5B%7Bshowtype%3A%27checkbox%27%7D%5D</showRule></showType><showType><name>UP_AND_DOWN</name><showRule>%5B%7BRule%3A%271%3D%3D1%27%2Cshowtype%3A%27%3Cinput%20type%3Dbutton%20value%3D%u4E0A%u4F20%u4E0E%u4E0B%u8F7D%20onclick%3DopenUploadAndDownView%28%29%3E%27%7D%5D</showRule></showType><showType><name>UP_LOAD</name><showRule>%5B%7BRule%3A%27%24%7Bwft_id%7D%3D%3D0%27%2Cshowtype%3A%27%3Cinput%20type%3Dbutton%20value%3D%22%u4E0A%u4F20%22%20onclick%3D%22storeMd%28%24%7Bril_id%7D%2Ctrue%29%22/%3E%27%7D%5D</showRule></showType><showType><name>DOWN_LOAD</name><showRule>%5B%7BRule%3A%27%24%7Bwft_id%7D%21%3D0%27%2Cshowtype%3A%27%3Cinput%20type%3Dbutton%20value%3D%22%u4E0B%u8F7D%22%20onclick%3D%22openUploadAndDownView%28%24%7Bril_id%7D%2Cfalse%29%22/%3E%27%7D%5D</showRule></showType></root>" columnHeight1Xml="undefined" columnWidth1Xml="undefined" format="<fields><field><fieldname>checked</fieldname><datatype>字符</datatype><displaylabel>全选</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype><showRule>%5B%7Bshowtype%3A%27checkbox%27%7D%5D</showRule></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>RIL_NAME</fieldname><datatype>字符</datatype><displaylabel>材料名称</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>ISR_AMT</fieldname><datatype>字符</datatype><displaylabel>份数</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>STATUS</fieldname><datatype>字符</datatype><displaylabel>状态</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>TP_EMY</fieldname><datatype>字符</datatype><displaylabel>接收人</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>TP_DATE</fieldname><datatype>字符</datatype><displaylabel>接收时间</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>RIL_ID</fieldname><datatype>字符</datatype><displaylabel>材料ID</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>PI_ID</fieldname><datatype>字符</datatype><displaylabel>事项ID</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>UP_LOAD</fieldname><datatype>字符</datatype><displaylabel>上传</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype><showRule>%5B%7BRule%3A%27%24%7Bwft_id%7D%3D%3D0%27%2Cshowtype%3A%27%3Cinput%20type%3Dbutton%20value%3D%22%u4E0A%u4F20%22%20onclick%3D%22storeMd%28%24%7Bril_id%7D%2Ctrue%29%22/%3E%27%7D%5D</showRule></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>DOWN_LOAD</fieldname><datatype>字符</datatype><displaylabel>下载</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype><showRule>%5B%7BRule%3A%27%24%7Bwft_id%7D%21%3D0%27%2Cshowtype%3A%27%3Cinput%20type%3Dbutton%20value%3D%22%u4E0B%u8F7D%22%20onclick%3D%22openUploadAndDownView%28%24%7Bril_id%7D%2Cfalse%29%22/%3E%27%7D%5D</showRule></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>RIL_ISTEMPLATE</fieldname><datatype>字符</datatype><displaylabel>有模板</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>RIL_TSM</fieldname><datatype>字符</datatype><displaylabel>模板存储方式</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>RIL_FORMAT</fieldname><datatype>字符</datatype><displaylabel>格式</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>WFT_ID</fieldname><datatype>字符</datatype><displaylabel>处罚事项实例ID</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field></fields>" onSetText='bill_ondatasetsettext("<dsid><checked></checked><RIL_NAME></RIL_NAME><ISR_AMT></ISR_AMT><STATUS></STATUS><TP_EMY></TP_EMY><TP_DATE></TP_DATE><RIL_ID></RIL_ID><PI_ID></PI_ID><UP_LOAD></UP_LOAD><DOWN_LOAD></DOWN_LOAD><RIL_ISTEMPLATE></RIL_ISTEMPLATE><RIL_TSM></RIL_TSM><RIL_FORMAT></RIL_FORMAT><WFT_ID></WFT_ID></dsid>")' onGetText='bill_ondatasetgettext("<dsid><checked></checked><RIL_NAME></RIL_NAME><ISR_AMT></ISR_AMT><STATUS></STATUS><TP_EMY></TP_EMY><TP_DATE></TP_DATE><RIL_ID></RIL_ID><PI_ID></PI_ID><UP_LOAD></UP_LOAD><DOWN_LOAD></DOWN_LOAD><RIL_ISTEMPLATE></RIL_ISTEMPLATE><RIL_TSM></RIL_TSM><RIL_FORMAT></RIL_FORMAT><WFT_ID></WFT_ID></dsid>")' onValid='bill_ondatasetvalid("<dsid><checked></checked><RIL_NAME></RIL_NAME><ISR_AMT></ISR_AMT><STATUS></STATUS><TP_EMY></TP_EMY><TP_DATE></TP_DATE><RIL_ID></RIL_ID><PI_ID></PI_ID><UP_LOAD></UP_LOAD><DOWN_LOAD></DOWN_LOAD><RIL_ISTEMPLATE></RIL_ISTEMPLATE><RIL_TSM></RIL_TSM><RIL_FORMAT></RIL_FORMAT><WFT_ID></WFT_ID></dsid>")' opensortno="1" temptable="TMP_DATASET8" multiResult="否"></fc:dataset></TD>
      </TR>
   </TBODY>
</TABLE>

<TABLE id=showForeigns cellSpacing=0 cellPadding=0 width="95%" align=center border=1>
   <TBODY>
      <TR>
         <TD><DIV><DIV id=div1 style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; OVERFLOW: auto; BORDER-LEFT: 0px; WIDTH: 100.09%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 350px" onmovestart=moveStart() controltype="div" NotBg="否"><DIV class=tab-pane id=tab9 style="LEFT: 0px; WIDTH: 100%; POSITION: absolute; TOP: 0px; HEIGHT: 320px" showtype="luna" IsHideTitle="否"><DIV class=tab-page style="WIDTH: 100%; HEIGHT: 302px"><H2 class=tab>违法记录列表</H2>
                        <TABLE cellSpacing=0 cellPadding=0 width="100%" align=left border=0>
                           <TBODY>
                              <TR>
                                 <TD align=right><BUTTON id=newWfjl style="LEFT: 0px; WIDTH: 105px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("newWfjl()")'>新增违法记录</BUTTON><BUTTON id=delWfjl style="LEFT: 0px; WIDTH: 106px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("delWfjl()")'>删除违法记录</BUTTON></TD>
                              </TR>
                              <TR>
                                 <TD><IMG style="DISPLAY: none" src="undefined"><DIV id=div_WfjlExtGrid style="LEFT: 0px; POSITION: static; TOP: 0px"></DIV><SCRIPT type=text/javascript>var WfjlExtGrid;
Ext.BLANK_IMAGE_URL = '../../fceform/js/Ext/images/default/s.gif';
var WfjlExtGrid_retint = 0;
var WfjlExtGrid_onReady = function(){ 
 Ext.QuickTips.init();
var dataset = document.getElementById("Wfjldataset");
try{var temp = dataset.Fields.Field.length;}catch(e){if(WfjlExtGrid_retint==0) WfjlExtGrid_retint = setInterval(WfjlExtGrid_onReady,200);dataset =null;return;}finally{if(temp!=null)temp=null;}
clearInterval(WfjlExtGrid_retint);WfjlExtGrid_retint = null ;var pagesize =5;
dataset.PageSize = pagesize ;
var mapping = creator_pt_getmapping(dataset);
var store  = new Ext.data.Store({
	proxy: new Ext.data.CreatorMemoryProxy("Wfjldataset"), 
	reader: new Ext.data.XmlStringReader({       record: 'tr',       totalRecords: 'pages'   }, mapping)});
var sm = new Ext.grid.RowSelectionModel({singleSelect: true});
var retcm = creator_pt_getcm(dataset,sm);var cm = new Ext.grid.ColumnModel(retcm);
if(typeof(retcm[0].getCount)!='undefined') sm = retcm[0] ;
 WfjlExtGrid = new Ext.grid.GridPanel({
		el: 'div_WfjlExtGrid',        store: store,
        cm:cm,
		sm: sm,
 			 bodyStyle : 'width:100%',
		viewConfig: {
			forceFit: true		},       loadMask: true,
	width: '100%',
					height: eval(document.body.clientHeight*(parseFloat('50%')))/100,
		split: true,
		region: 'north',
		title:'违法记录列表',
		frame:true
		,plugins: new Ext.ux.PanelResizer({
            minHeight: 100        }),
       bbar: new Ext.PagingToolbar({
            pageSize: pagesize,
            store: store,
            displayInfo: true,
            displayMsg:'当前显示第 {0} - {1} 条，共 {2} 条',            plugins: new Ext.ux.SlidingPager()        })		    });
    var grid=WfjlExtGrid;
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
grid.addListener('rowdblclick', editWfjl);WfjlExtGrid.render();
store.load({params:{start:0, limit:pagesize}});
if(typeof(creator_pt_grids)=='undefined'){creator_pt_grids=new Array();}
creator_pt_grids.push({id:'WfjlExtGrid',obj:WfjlExtGrid,dataset:'Wfjldataset',isEdit:'false'});
if(typeof(onGridPanelLoaded)=='function') setTimeout(onGridPanelLoaded,0);
};
WfjlExtGrid_onReady();window.onresize=function(){try{WfjlExtGrid.setWidth(eval(document.body.clientWidth*(parseFloat('95%')))/100);}catch(e){}};</SCRIPT></TD>
                              </TR>
                           </TBODY>
                        </TABLE>
                     </DIV>
                     <DIV class=tab-page style="WIDTH: 100%; HEIGHT: 302px">
                        <H2 class=tab>当事人列表</H2>
                        <TABLE cellSpacing=0 cellPadding=0 width="100%" align=left border=1>
                           <TBODY>
                              <TR>
                                 <TD align=right><BUTTON id=delDsr style="LEFT: 0px; WIDTH: 110px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("delDsr()")'>删除当事人记录</BUTTON></TD>
                              </TR>
                              <TR>
                                 <TD><IMG style="DISPLAY: none" src="undefined"><DIV id=div_DsrExtGrid style="LEFT: 0px; POSITION: static; TOP: 0px"></DIV><SCRIPT type=text/javascript>var DsrExtGrid;
Ext.BLANK_IMAGE_URL = '../../fceform/js/Ext/images/default/s.gif';
var DsrExtGrid_retint = 0;
var DsrExtGrid_onReady = function(){ 
 Ext.QuickTips.init();
var dataset = document.getElementById("Dsrdataset");
try{var temp = dataset.Fields.Field.length;}catch(e){if(DsrExtGrid_retint==0) DsrExtGrid_retint = setInterval(DsrExtGrid_onReady,200);dataset =null;return;}finally{if(temp!=null)temp=null;}
clearInterval(DsrExtGrid_retint);DsrExtGrid_retint = null ;var pagesize =5;
dataset.PageSize = pagesize ;
var mapping = creator_pt_getmapping(dataset);
var store  = new Ext.data.Store({
	proxy: new Ext.data.CreatorMemoryProxy("Dsrdataset"), 
	reader: new Ext.data.XmlStringReader({       record: 'tr',       totalRecords: 'pages'   }, mapping)});
var sm = new Ext.grid.RowSelectionModel({singleSelect: true});
var retcm = creator_pt_getcm(dataset,sm);var cm = new Ext.grid.ColumnModel(retcm);
if(typeof(retcm[0].getCount)!='undefined') sm = retcm[0] ;
 DsrExtGrid = new Ext.grid.GridPanel({
		el: 'div_DsrExtGrid',        store: store,
        cm:cm,
		sm: sm,
 			 bodyStyle : 'width:100%',
		viewConfig: {
			forceFit: true		},       loadMask: true,
	width: '100%',
					height: eval(document.body.clientHeight*(parseFloat('50%')))/100,
		split: true,
		region: 'north',
		title:'当事人列表',
		frame:true
		,plugins: new Ext.ux.PanelResizer({
            minHeight: 100        }),
       bbar: new Ext.PagingToolbar({
            pageSize: pagesize,
            store: store,
            displayInfo: true,
            displayMsg:'当前显示第 {0} - {1} 条，共 {2} 条',            plugins: new Ext.ux.SlidingPager()        })		    });
    var grid=DsrExtGrid;
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
cm.setHidden(6,true);
grid.addListener('rowdblclick', editDsr);DsrExtGrid.render();
store.load({params:{start:0, limit:pagesize}});
if(typeof(creator_pt_grids)=='undefined'){creator_pt_grids=new Array();}
creator_pt_grids.push({id:'DsrExtGrid',obj:DsrExtGrid,dataset:'Dsrdataset',isEdit:'false'});
if(typeof(onGridPanelLoaded)=='function') setTimeout(onGridPanelLoaded,0);
};
DsrExtGrid_onReady();window.onresize=function(){try{DsrExtGrid.setWidth(eval(document.body.clientWidth*(parseFloat('95%')))/100);}catch(e){}};</SCRIPT></TD>
                              </TR>
                           </TBODY>
                        </TABLE>
                     </DIV>
                     <DIV class=tab-page style="WIDTH: 100%; HEIGHT: 302px">
                        <H2 class=tab>材料列表</H2>
                        <TABLE cellSpacing=0 cellPadding=0 width="100%" align=left border=1>
                           <TBODY>
                              <TR>
                                 <TD align=right><BUTTON id=ComitCl style="LEFT: 0px; WIDTH: 76px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("clComit()")'>提交材料</BUTTON><BUTTON id=rtnComit style="LEFT: 0px; WIDTH: 94px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("clRtn()")'>撤消提交材料</BUTTON></TD>
                              </TR>
                              <TR>
                                 <TD><IMG style="DISPLAY: none" src="undefined"><DIV id=div_cllbExtGrid style="LEFT: 0px; POSITION: static; TOP: 0px"></DIV><SCRIPT type=text/javascript>var cllbExtGrid;
Ext.BLANK_IMAGE_URL = '../../fceform/js/Ext/images/default/s.gif';
var cllbExtGrid_retint = 0;
var cllbExtGrid_onReady = function(){ 
 Ext.QuickTips.init();
var dataset = document.getElementById("Cllbdataset");
try{var temp = dataset.Fields.Field.length;}catch(e){if(cllbExtGrid_retint==0) cllbExtGrid_retint = setInterval(cllbExtGrid_onReady,200);dataset =null;return;}finally{if(temp!=null)temp=null;}
clearInterval(cllbExtGrid_retint);cllbExtGrid_retint = null ;var pagesize =5;
dataset.PageSize = pagesize ;
var mapping = creator_pt_getmapping(dataset);
var store  = new Ext.data.Store({
	proxy: new Ext.data.CreatorMemoryProxy("Cllbdataset"), 
	reader: new Ext.data.XmlStringReader({       record: 'tr',       totalRecords: 'pages'   }, mapping)});
var sm = new Ext.grid.RowSelectionModel({singleSelect: true});
var retcm = creator_pt_getcm(dataset,sm);var cm = new Ext.grid.ColumnModel(retcm);
if(typeof(retcm[0].getCount)!='undefined') sm = retcm[0] ;
 cllbExtGrid = new Ext.grid.GridPanel({
		el: 'div_cllbExtGrid',        store: store,
        cm:cm,
		sm: sm,
 			 bodyStyle : 'width:100%',
		viewConfig: {
			forceFit: true		},       loadMask: true,
	width: '100%',
					height: eval(document.body.clientHeight*(parseFloat('50%')))/100,
		split: true,
		region: 'north',
		title:'材料列表',
		frame:true
		,plugins: new Ext.ux.PanelResizer({
            minHeight: 100        }),
       bbar: new Ext.PagingToolbar({
            pageSize: pagesize,
            store: store,
            displayInfo: true,
            displayMsg:'当前显示第 {0} - {1} 条，共 {2} 条',            plugins: new Ext.ux.SlidingPager()        })		    });
    var grid=cllbExtGrid;
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
cm.setHidden(6,true);
cm.setHidden(7,true);
cm.setHidden(10,true);
cm.setHidden(11,true);
cm.setHidden(12,true);
cm.setHidden(13,true);


cllbExtGrid.render();
store.load({params:{start:0, limit:pagesize}});
if(typeof(creator_pt_grids)=='undefined'){creator_pt_grids=new Array();}
creator_pt_grids.push({id:'cllbExtGrid',obj:cllbExtGrid,dataset:'Cllbdataset',isEdit:'false'});
if(typeof(onGridPanelLoaded)=='function') setTimeout(onGridPanelLoaded,0);
};
cllbExtGrid_onReady();window.onresize=function(){try{cllbExtGrid.setWidth(eval(document.body.clientWidth*(parseFloat('95%')))/100);}catch(e){}};</SCRIPT></TD>
                              </TR>
                           </TBODY>
                        </TABLE>
                     </DIV>
                  </DIV>
                  <SCRIPT>var tab9 = new WebFXTabPane( document.getElementById( "tab9" ) );</SCRIPT>
               </DIV>
            </DIV>
         </TD>
      </TR>
   </TBODY>
</TABLE>

<fc:dataset id=AjslSaveDataset format="<fields><field><fieldname>WFT_ID</fieldname><datatype>字符</datatype><displaylabel>处罚事项实例</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>BU_ID</fieldname><datatype>字符</datatype><displaylabel>执法主体</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>AD_ID</fieldname><datatype>字符</datatype><displaylabel>行政区划代码</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>IS_ID</fieldname><datatype>字符</datatype><displaylabel>案件来源</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>WFT_DATE</fieldname><datatype>字符</datatype><displaylabel>案发日期</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>WFT_DATE_RETURN_RECEIVE</fieldname><datatype>字符</datatype><displaylabel>登记日期</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>WFT_APPLICATION_NUMBER</fieldname><datatype>字符</datatype><displaylabel>案件受理编号</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>WFT_TITLE</fieldname><datatype>字符</datatype><displaylabel>案件标题</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>WFT_ADDRESS</fieldname><datatype>字符</datatype><displaylabel>案件地址细节</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>WFT_BRIEF</fieldname><datatype>字符</datatype><displaylabel>简要案件内容</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>WFT_HANDLER</fieldname><datatype>字符</datatype><displaylabel>登记人</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>PI_ID</fieldname><datatype>字符</datatype><displaylabel>事项</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>USER_REALNAME</fieldname><datatype>字符</datatype><displaylabel>登记人姓名</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>PI_NAME</fieldname><datatype>字符</datatype><displaylabel>处罚事项名称</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>ORG_NAME</fieldname><datatype>字符</datatype><displaylabel>登记人机构</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>BU_NAME</fieldname><datatype>字符</datatype><displaylabel>执法主体名称</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>AD_NAME</fieldname><datatype>字符</datatype><displaylabel>行政区域名称</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field></fields>" onSetText='bill_ondatasetsettext("<dsid><WFT_ID></WFT_ID><BU_ID></BU_ID><AD_ID></AD_ID><IS_ID></IS_ID><WFT_DATE></WFT_DATE><WFT_DATE_RETURN_RECEIVE></WFT_DATE_RETURN_RECEIVE><WFT_APPLICATION_NUMBER></WFT_APPLICATION_NUMBER><WFT_TITLE></WFT_TITLE><WFT_ADDRESS></WFT_ADDRESS><WFT_BRIEF></WFT_BRIEF><WFT_HANDLER></WFT_HANDLER><PI_ID></PI_ID><USER_REALNAME></USER_REALNAME><PI_NAME></PI_NAME><ORG_NAME></ORG_NAME><BU_NAME></BU_NAME><AD_NAME></AD_NAME></dsid>")' onGetText='bill_ondatasetgettext("<dsid><WFT_ID></WFT_ID><BU_ID></BU_ID><AD_ID></AD_ID><IS_ID></IS_ID><WFT_DATE></WFT_DATE><WFT_DATE_RETURN_RECEIVE></WFT_DATE_RETURN_RECEIVE><WFT_APPLICATION_NUMBER></WFT_APPLICATION_NUMBER><WFT_TITLE></WFT_TITLE><WFT_ADDRESS></WFT_ADDRESS><WFT_BRIEF></WFT_BRIEF><WFT_HANDLER></WFT_HANDLER><PI_ID></PI_ID><USER_REALNAME></USER_REALNAME><PI_NAME></PI_NAME><ORG_NAME></ORG_NAME><BU_NAME></BU_NAME><AD_NAME></AD_NAME></dsid>")' onValid='bill_ondatasetvalid("<dsid><WFT_ID></WFT_ID><BU_ID></BU_ID><AD_ID></AD_ID><IS_ID></IS_ID><WFT_DATE></WFT_DATE><WFT_DATE_RETURN_RECEIVE></WFT_DATE_RETURN_RECEIVE><WFT_APPLICATION_NUMBER></WFT_APPLICATION_NUMBER><WFT_TITLE></WFT_TITLE><WFT_ADDRESS></WFT_ADDRESS><WFT_BRIEF></WFT_BRIEF><WFT_HANDLER></WFT_HANDLER><PI_ID></PI_ID><USER_REALNAME></USER_REALNAME><PI_NAME></PI_NAME><ORG_NAME></ORG_NAME><BU_NAME></BU_NAME><AD_NAME></AD_NAME></dsid>")' opensortno="1" temptable="TMP_DATASET5" multiResult="否"></fc:dataset>

<fc:dataset id=Wfjldataset showtypeXml="<root><showType><name>checked</name><showRule>%5B%7Bshowtype%3A%27checkbox%27%7D%5D</showRule></showType></root>" columnHeight1Xml="undefined" columnWidth1Xml="undefined" format="<fields><field><fieldname>checked</fieldname><datatype>字符</datatype><displaylabel>全选</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype><showRule>%5B%7Bshowtype%3A%27checkbox%27%7D%5D</showRule></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>OR_NAME</fieldname><datatype>字符</datatype><displaylabel>违法行为名称</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>OR_BRIEF</fieldname><datatype>字符</datatype><displaylabel>违法情况</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>LTT_NAME</fieldname><datatype>字符</datatype><displaylabel>当事人</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>OR_ID</fieldname><datatype>字符</datatype><displaylabel>违法记录ID</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field></fields>" onSetText='bill_ondatasetsettext("<dsid><checked></checked><OR_NAME></OR_NAME><OR_BRIEF></OR_BRIEF><LTT_NAME></LTT_NAME><OR_ID></OR_ID></dsid>")' onGetText='bill_ondatasetgettext("<dsid><checked></checked><OR_NAME></OR_NAME><OR_BRIEF></OR_BRIEF><LTT_NAME></LTT_NAME><OR_ID></OR_ID></dsid>")' onValid='bill_ondatasetvalid("<dsid><checked></checked><OR_NAME></OR_NAME><OR_BRIEF></OR_BRIEF><LTT_NAME></LTT_NAME><OR_ID></OR_ID></dsid>")' opensortno="1" temptable="TMP_DATASET6" multiResult="否"></fc:dataset>

<fc:dataset id=Dsrdataset showtypeXml="<root><showType><name>checked</name><showRule>%5B%7Bshowtype%3A%27checkbox%27%7D%5D</showRule></showType></root>" columnHeight1Xml="undefined" columnWidth1Xml="undefined" format="<fields><field><fieldname>checked</fieldname><datatype>字符</datatype><displaylabel>全选</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype><showRule>%5B%7Bshowtype%3A%27checkbox%27%7D%5D</showRule></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>LTT_ATTRI</fieldname><datatype>字符</datatype><displaylabel>公民/法人</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>LTT_NAME</fieldname><datatype>字符</datatype><displaylabel>当事人/单位名称</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>LTT_CODE</fieldname><datatype>字符</datatype><displaylabel>证件号码</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>LTT_TEL</fieldname><datatype>字符</datatype><displaylabel>当事人电话</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>LTT_ADDRESS</fieldname><datatype>字符</datatype><displaylabel>当事人地址</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>LTT_ID</fieldname><datatype>字符</datatype><displaylabel>当事人流水</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field></fields>" onSetText='bill_ondatasetsettext("<dsid><checked></checked><LTT_ATTRI></LTT_ATTRI><LTT_NAME></LTT_NAME><LTT_CODE></LTT_CODE><LTT_TEL></LTT_TEL><LTT_ADDRESS></LTT_ADDRESS><LTT_ID></LTT_ID></dsid>")' onGetText='bill_ondatasetgettext("<dsid><checked></checked><LTT_ATTRI></LTT_ATTRI><LTT_NAME></LTT_NAME><LTT_CODE></LTT_CODE><LTT_TEL></LTT_TEL><LTT_ADDRESS></LTT_ADDRESS><LTT_ID></LTT_ID></dsid>")' onValid='bill_ondatasetvalid("<dsid><checked></checked><LTT_ATTRI></LTT_ATTRI><LTT_NAME></LTT_NAME><LTT_CODE></LTT_CODE><LTT_TEL></LTT_TEL><LTT_ADDRESS></LTT_ADDRESS><LTT_ID></LTT_ID></dsid>")' opensortno="1" temptable="TMP_DATASET7" multiResult="否"></fc:dataset>

<INPUT id=orgIds style="DISPLAY: none; LEFT: 0px; WIDTH: 87px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=15 controltype="text">

<INPUT id=orgNames style="DISPLAY: none; LEFT: 0px; WIDTH: 96px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=15 controltype="text">

<INPUT id=AD_ID style="DISPLAY: none; LEFT: 0px; WIDTH: 110px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" field="AD_ID" china="行政区划代码" dataset="AjslSaveDataset">
</DIV>
<div id='grid_tip'></div></body></html>
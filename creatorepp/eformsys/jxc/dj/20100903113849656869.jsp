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
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/fcsavedj.js');");
if(bDgMode) out.println("<script defer src='../../fceform/js/fcsavedj.js'></script>");
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
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/vo/WfxwVo.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/vo/WfxwVo.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/util/WorkflowUtil.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/util/WorkflowUtil.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/business/Wfxw.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/business/Wfxw.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/dao/WfxwDao.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/dao/WfxwDao.js'></script>");
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
adv_loadjsfile('/eformsys/fceform/js/Ext/SlidingPager.js');
adv_loadjsfile('/eformsys/fceform/js/Ext/SliderTip.js');
adv_loadjsfile('/eformsys/fceform/js/Ext/PanelResizer.js');
adv_loadjsfile('/eformsys/fceform/js/Ext/XmlTextReader.js');
adv_loadjsfile('/eformsys/fceform/js/Ext/CreatorMemoryProxy.js');
</script>


<!-- 提示：以下为页面自定义JS内容 -->
<script>
var RMD_ID_TMP = creator_getQueryString("rmdId");
var zfyj = "";//执法依据
var cfyj = "";//处罚依据
var flfg = "";//法律法规
var cfcsTmp = "";//存放已选择的处罚措施
var chktmp = "";//存放初始的处罚措施
var chkClsIds = "" ; //存放被取消的初始措施信息 
//新增、停用、删除措施
var addcfcs = "";
var stopcfcs = "";
var delcfcs = "";
//存放考核字段旧值
var arr_ora = new Array();
var arr_new = new Array();
//是否有金额新旧值
var isValueOra = "";
var isValueNew = "";
//上下限新旧值
var upOra = "";
var lowOra = "";

function showmoney(){
    var tmp = document.getElementsByName('RMD_ISVALUE');//是否有金额
     if (tmp[0].checked) {
        isValueOra = tmp[0].value;
        document.getElementById("hasmoney").style.display="block";
    } else {
        document.getElementById("hasmoney").style.display="none"; 
        isValueOra = tmp[1].value;
    }
}


//判断选择的法律法规是否有相同记录
function isSame(ids, names, type){
    if (names!=null ){
        var zfyjName = $("RMD_THE_LAW").value;
        var cfyjName = $("RMD_RULE").value;
        var nameValue = "" ;
        for(var j=0;j<names.length;j++){
            if (type == 1){
                if (zfyjName.indexOf("《"+names[j]+"》")!=-1) {
                    nameValue = names[j];
                    break;
                }
            } else if (type ==2){
                if (cfyjName.indexOf("《"+names[j]+"》")!=-1) {
                    nameValue = names[j];
                    break;
                }
            }
        }    
        return nameValue;
    }
}

//打开法律法规选择界面
function showLaw(obj, type){
    var tempPara="dialogWidth:760px;dialogHeight:600px;";
    var tempURL="20100904171631828947.jsp?type="+type;
    var tmp = showModalDialog(tempURL,window,tempPara);
    if (!IsSpace(tmp)) {
        var name_tmp = tmp.names;
        var id_tmp = tmp.ids;
        for(var i=0;i<name_tmp.length;i++){
            obj.value = (obj.value==""?"《" + name_tmp[i] + "》":obj.value + "\n" + "《" + name_tmp[i] + "》");
            if (type == 1) {
                if (zfyj=="") {
                    zfyj = id_tmp[i];
                } else {
                    zfyj = zfyj + "," + id_tmp[i];
                }
            } else if (type == 2) {
                if (cfyj=="") {
                    cfyj = id_tmp[i];
                } else {
                    cfyj = cfyj + "," + id_tmp[i];
                }
            }
        }
    }
}


//加载处罚措施
function cfcsinit(){
    var sql = Wfxw.queryCfcs();
    tempDataset.Open(sql);
    tempDataset.MoveFirst();
    var tmpbox = document.getElementById('tmpbox');
    var tmpcfcsbox = document.getElementById('cfcsBox');
    for(var i=0;i<tempDataset.RecordCount;i++){
        var str = "<INPUT name=chks id=chks type=checkbox>";
        var newCheckbox = document.createElement(str);
        newCheckbox.value=tempDataset.Fields.Field['PM_ID'].Value;
        var spanStr="<span></span>";
        var spanTmp = document.createElement(spanStr);
        spanTmp.innerHTML = tempDataset.Fields.Field['PM_NAME'].Value;
        tmpcfcsbox.insertBefore(spanTmp,tmpbox);
        tmpcfcsbox.insertBefore(newCheckbox,spanTmp);
        tempDataset.MoveNext();
    }
}
//初始化
function init(){
    if(RMD_ID_TMP==null){
        RMD_ID_TMP=0;
    } else {
        document.getElementById("formTitleId").innerHTML = "修改违法行为";
    }
    //设置RMD_ID初始值
    document.getElementById('rmd_id').value = RMD_ID_TMP;
    //加载处罚措施
    cfcsinit();
    //自由裁量权列表
    var obj = 1;//公民,法人或其他组织
    var zyclGridSql = "";
    
    //自由裁量权列表,新增,删除按钮控制
    if (RMD_ID_TMP) {
        ${'newBtn'}.style.visibility="visible";
        ${'delBtn'}.style.visibility="visible";
        var editSql = Wfxw.findWfxwById(RMD_ID_TMP);
        wfxwSaveDataset.Open(editSql);
        ${'VC_ID'}.value = wfxwSaveDataset.Fields.Field['VC_ID'].Value;
        ${'OC_ID'}.value = wfxwSaveDataset.Fields.Field['OC_ID'].Value;
        ${'VC_ID'}.disabled=true;
        //状态
         var status = wfxwSaveDataset.Fields.Field['RMD_STATUS'].Value;
        var rmdStatus = document.getElementsByName('RMD_STATUS');
        if (status == 1){
            rmdStatus[0].checked = true;
        } else {
            rmdStatus[1].checked = true;
        }
        //是否有金额
         var isvalueTmp = document.getElementsByName("RMD_ISVALUE");
        if (wfxwSaveDataset.Fields.Field['RMD_ISVALUE'].Value == 1) {
            isvalueTmp[0].checked = true;
        } else {
            isvalueTmp[1].checked = true;
        }
        //初始化处罚措施
         var initCfcs = Wfxw.findCfcsByWfxwId(RMD_ID_TMP);
        tempDataset.Open(initCfcs);
        tempDataset.MoveFirst();
        for(var i=0;i<tempDataset.RecordCount;i++){
            var chkarg = document.getElementsByName('chks');
            var valueTmp = tempDataset.Fields.Field['PM_ID'].Value ;
            if (chktmp == "") {
                chktmp = valueTmp;
            } else {
                chktmp = chktmp + "," + valueTmp;
            }
            for(var j=0;j<chkarg.length;j++){
                if (chkarg[j].value == valueTmp) {
                    chkarg[j].checked = true;
                }
            }
            tempDataset.MoveNext();
        }
        //存放考核字段旧值
         arr_ora[0] = wfxwSaveDataset.Fields.Field['RMD_THE_LAW'].Value;
        arr_ora[1] = wfxwSaveDataset.Fields.Field['RMD_RULE'].Value;
        arr_ora[2] = wfxwSaveDataset.Fields.Field['RMD_UPPER'].Value;
        arr_ora[3] = wfxwSaveDataset.Fields.Field['RMD_LOWER'].Value;
        upOra = arr_ora[2];
        lowOra = arr_ora[3];
    } else {
        ${'newBtn'}.style.visibility="hidden";
        ${'delBtn'}.style.visibility="hidden";
    }
    showmoney();//是否有金额
     zyclGridSql = Wfxw.findZycl(RMD_ID_TMP,obj);
    zyclDataSet.Open(zyclGridSql);
    reloadExtGrid();
}

//去全角半角空格
function delSpace(){
    ${'RMD_NAME'}.value = ${'RMD_NAME'}.value.trim();
    ${'RMD_BRIEF_NAME'}.value = ${'RMD_BRIEF_NAME'}.value.trim();
    ${'RMD_CODE'}.value = ${'RMD_CODE'}.value.trim();
    ${'RMD_THE_LAW'}.value = ${'RMD_THE_LAW'}.value.trim();
    ${'RMD_RULE'}.value = ${'RMD_RULE'}.value.trim();
    ${'RMD_REMARK'}.value = ${'RMD_REMARK'}.value.trim();
}

//验证
function validate(){
    var tmpIsValue = document.getElementsByName('RMD_ISVALUE');//是否有金额
    delSpace();
     var flag = true;
    if (flag) {
        if(document.getElementById('VC_ID').value==-1){
            alert("请选择行业分类!");
            flag = false;
        }
    }
    if (flag) {
        if(document.getElementById('OC_ID').value==-1){
            alert("请选择违法类别!");
            flag = false;
        }
    }
    if (flag) {
        flag = SValidator.validate(${'RMD_NAME'}.value, {
            CHECK_TYPE : "required",
            ARGUMENT : {placeholders : [${'RMD_NAME'}.value]},
            MESSAGE : "违法行为名称不能为空!"
        }, true);
    }
    if (flag) {
        flag = SValidator.validate(${'RMD_NAME'}.value, {
            CHECK_TYPE : "maxlength",
            ARGUMENT : {placeholders : [125],maxlength : 125},
            MESSAGE : "违法行为名称最大不能超过{0}字符!"
        }, true);
    }
    if (flag) {
        flag = SValidator.validate(${'RMD_BRIEF_NAME'}.value, {
            CHECK_TYPE : "required",
            ARGUMENT : {placeholders : [${'RMD_BRIEF_NAME'}.value]},
            MESSAGE : "违法行为简称不能为空!"
        }, true);
    }
    if (flag) {
        flag = SValidator.validate(${'RMD_BRIEF_NAME'}.value, {
            CHECK_TYPE : "maxlength",
            ARGUMENT : {placeholders : [125],maxlength : 125},
            MESSAGE : "违法行为简称最大不能超过{0}字符!"
        }, true);
    }
    if (flag) {
        flag = SValidator.validate(${'RMD_CODE'}.value, {
            CHECK_TYPE : "required",
            ARGUMENT : {placeholders : [${'RMD_CODE'}.value]},
            MESSAGE : "违法行为编码不能为空!"
        }, true);
    }
    if (flag) {
        var reg=/[\u4E00-\u9FA5]+/g;
        if (reg.test($("RMD_CODE").value)){
            flag = false;
            alert("违法行为编码不能包含汉字！");
        }            
    }
    if (flag) {
        flag = SValidator.validate(${'RMD_CODE'}.value, {
            CHECK_TYPE : "maxlength",
            ARGUMENT : {placeholders : [10],maxlength : 10},
            MESSAGE : "违法行为编码最大不能超过{0}字符!"
        }, true);
    }
    if (flag) {
        flag = checkonly(RMD_ID_TMP, ${'RMD_CODE'}.value.trim()) ;
        if (!flag) {
            alert('违法行为编码已存在,请重新输入!');
        }
    }
    if (flag) {
        flag = selCheckBox();
        if (!flag) {
            alert('请选择处罚措施!');
        }
    }
    if (flag && tmpIsValue[0].checked) {
        flag = SValidator.validate(${'RMD_UPPER'}.value, {
            CHECK_TYPE : "required",
            ARGUMENT : {placeholders : [${'RMD_UPPER'}.value]},
            MESSAGE : "罚金限制上限不能为空!"
        }, true);
    }
    if (flag && tmpIsValue[0].checked) {
        flag = SValidator.validate(${'RMD_UPPER'}.value, {
            CHECK_TYPE : "mask",
            ARGUMENT : {placeholders : [""],mask:/^\d{1,10}([\.]\d{1,2})?$/},
            MESSAGE : "罚金限制上限格式不正确!参照如:1234567890.12"
        }, false);
    }
    if (flag && tmpIsValue[0].checked) {
        flag = SValidator.validate(${'RMD_UPPER'}.value, {
            CHECK_TYPE : "maxlength",
            ARGUMENT : {placeholders : [12],maxlength : 12},
            MESSAGE : "罚金限制上限最多不能超过{0}字符!"
        }, true);
    }
    if (flag && tmpIsValue[0].checked) {
        if (Number(${'RMD_UPPER'}.value)<Number(${'RMD_LOWER'}.value)) {
            flag = false;
            alert("上限值应该比下限值大");
        }
    }
    if (flag && tmpIsValue[0].checked) {
        flag = SValidator.validate(${'RMD_LOWER'}.value, {
            CHECK_TYPE : "required",
            ARGUMENT : {placeholders : [${'RMD_LOWER'}.value]},
            MESSAGE : "罚金限制下限不能为空!"
        }, true);
    }
    if (flag && tmpIsValue[0].checked) {
        flag = SValidator.validate(${'RMD_LOWER'}.value, {
            CHECK_TYPE : "mask",
            ARGUMENT : {placeholders : [""],mask:/^\d{1,10}([\.]\d{1,2})?$/},
            MESSAGE : "罚金限制下限格式不正确!参照如:1234567890.12"
        }, false);
    }
    if (flag && tmpIsValue[0].checked) {
        flag = SValidator.validate(${'RMD_LOWER'}.value, {
            CHECK_TYPE : "maxlength",
            ARGUMENT : {placeholders : [12],maxlength : 12},
            MESSAGE : "罚金限制下限最多不能超过{0}字符!"
        }, true);
    }
    return flag;
}

//保存
function save(){
     if (validate()) {
        var obj = new WfxwVo.Wfxw();
        var vo = DBUtil.getVoFromPage(obj);
        var tmp = document.getElementsByName('RMD_STATUS');
        if (tmp[0].checked) {
            vo.RMD_STATUS = tmp[0].value ;
        } else {
            vo.RMD_STATUS = tmp[1].value ;
        }
        var tmpIsValue = document.getElementsByName('RMD_ISVALUE');//是否有金额
         if (tmpIsValue[0].checked) {
            vo.RMD_ISVALUE = tmpIsValue[0].value;
        } else {
            var num = Wfxw.countIsValue(RMD_ID_TMP);
            if (num > 0) {
                alert("相关裁量细则已有金额，因此是否有金额不能被修改");
                tmpIsValue[0].checked = true;
                showmoney();
                return false;
            }
            vo.RMD_ISVALUE = tmpIsValue[1].value;
            ${'RMD_UPPER'}.value = 0;
            ${'RMD_UPPER'}.value = 0;
            vo.RMD_UPPER = 0;
            vo.RMD_LOWER = 0;
        }
        var arg = "";//处罚措施
         if (RMD_ID_TMP) {
            var flag = isQuote();
            if (!flag) {
                return false;
            }
            if (tmpIsValue[0].checked) {
                var upCheck = Wfxw.countUpperCheck(RMD_ID_TMP, ${'RMD_UPPER'}.value);
                if (upCheck>0) {
                    alert("罚金上限不得低于已有裁量细则的金额上限");
                    return false;
                }
                var lowCheck = Wfxw.countLowerCheck(RMD_ID_TMP, ${'RMD_LOWER'}.value);
                if (lowCheck>0) {
                    alert("罚金下限不得高于已有裁量细则的金额下限");
                    return false;
                }
            }            
            arr_new[0] = ${'RMD_THE_LAW'}.value;
            arr_new[1] = ${'RMD_RULE'}.value;
            arr_new[2] = ${'RMD_UPPER'}.value;
            arr_new[3] = ${'RMD_LOWER'}.value;
            if (addcfcs != "") {
                arg = addcfcs.split(",");
            }
        } else {
            arg = cfcsTmp.split(",");
        }
        vo.RMD_ID = RMD_ID_TMP;
        vo.RMD_THE_LAW_IDS = zfyj;
        vo.RMD_RULE_IDS = cfyj;
        vo.DEL_PUNISHMENT_ID = delcfcs;
        vo.STOP_PUNISHMENT_ID = stopcfcs; 
        var rv = Wfxw.saveWfxw(vo, arg, arr_ora, arr_new);
        if (rv) {
            alert("保存数据信息成功！");
            if (RMD_ID_TMP == 0) {
                RMD_ID_TMP = vo.RMD_ID ;
                ${'VC_ID'}.disabled=true;
                ${'newBtn'}.style.visibility="visible";
                ${'delBtn'}.style.visibility="visible";  
            }
            chktmp = cfcsTmp;
            //存放考核字段旧值
              arr_ora[0] = ${'RMD_THE_LAW'}.value;
            arr_ora[1] = ${'RMD_RULE'}.value;
            arr_ora[2] = ${'RMD_UPPER'}.value;
            arr_ora[3] = ${'RMD_LOWER'}.value;
            upOra = arr_ora[2];
            lowOra = arr_ora[3];
        } else {
            alert("保存数据信息失败！");
        }
    }
}

//新增自由裁量权
function addZycl(){
    var tempPara="dialogWidth:760px;dialogHeight:550px;";
    var tmpValue = "";
    var tmp = document.getElementsByName('RDD_OBJECT_TYPE');
    if (tmp[0].checked) {
        tmpValue = tmp[0].value ;
    } else if (tmp[1].checked) {
        tmpValue = tmp[1].value ;
    }
    var v_tmp = document.getElementsByName('RMD_ISVALUE');
    if (v_tmp[0].checked) {
        isValueNew = v_tmp[0].value ;
    } else if (v_tmp[1].checked) {
        isValueNew = v_tmp[1].value ;
    }
    if (!selCheckBox()) {
        alert('请选择处罚措施!');
        return false;
    } else if (chktmp!=cfcsTmp) {
        alert('处罚措施已被修改,请先保存!');
        return false;
    }
    if (isValueOra != "" && isValueNew != isValueOra ) {
        alert("是否有金额已被修改,请先保存!");
        return false;
    }
    var uptmp = ${'RMD_UPPER'}.value ;
    var lowtmp = ${'RMD_LOWER'}.value ;
    //若有金额判断
     if (isValueNew == 1) {
        if (Number(uptmp) != Number(upOra) || Number(lowtmp) != Number(lowOra)) {
            alert("违法行为金额上下限已更改，请先保存！");
            return false;
        }
    }
    var tempURL="20100904105058984229.jsp?type="+tmpValue
    +"&cfcsids="+cfcsTmp+"&rmdId="+RMD_ID_TMP+"&upvalue="+uptmp+"&lowvalue="
    +lowtmp+"&isValueNew="+isValueNew ;
    showModalDialog(tempURL,window,tempPara);
    zyclGridSql = Wfxw.findZycl(RMD_ID_TMP,tmpValue);
    zyclDataSet.Open(zyclGridSql);
    reloadExtGrid();
}

//自由裁量权查询
function cf_queryZycl(){
    var obj = event.srcElement?event.srcElement : event.target;
    var zyclGridSql = Wfxw.findZycl(RMD_ID_TMP,obj.value);
    zyclDataSet.Open(zyclGridSql);
    reloadExtGrid();    
}

function close(){
    window.history.back();
}

//双击修改自由裁量权
function editZycl(grid, rowIndex, e){
    var row = grid.store.getById(grid.store.data.items[rowIndex].id); 
    var rddId = row.get("rdd_id");
    var tmpValue = "";
    var uptmp = ${'RMD_UPPER'}.value ;
    var lowtmp = ${'RMD_LOWER'}.value ;
    var tmp = document.getElementsByName('RDD_OBJECT_TYPE');
    if (tmp[0].checked) {
        tmpValue = tmp[0].value ;
    } else if (tmp[1].checked) {
        tmpValue = tmp[1].value ;
    }
    var v_tmp = document.getElementsByName('RMD_ISVALUE');
    if (v_tmp[0].checked) {
        isValueNew = v_tmp[0].value ;
    } else if (v_tmp[1].checked) {
        isValueNew = v_tmp[1].value ;
    }
    if (!selCheckBox()) {
        alert('请选择处罚措施!');
        return false;
    } else if (chktmp!=cfcsTmp) {
        alert('处罚措施已被修改,请先保存!');
        return false;
    }
    if (isValueOra != "" && isValueNew != isValueOra ) {
        alert("是否有金额已被修改,请先保存!");
        return false;
    }
    //若有金额判断
     if (isValueNew == 1) {
        if (Number(uptmp) != Number(upOra) || Number(lowtmp) != Number(lowOra)) {
            alert("违法行为金额上下限已更改，请先保存！");
            return false;
        }
    }
    var tempPara="dialogWidth:760px;dialogHeight:550px;";
    var tempURL="20100904105058984229.jsp?rddId="+rddId 
    +"&rmdId="+RMD_ID_TMP+"&type="+tmpValue+"&cfcsids="+cfcsTmp
    +"&upvalue="+uptmp+"&lowvalue="+lowtmp+"&isValueNew="+isValueNew;
    showModalDialog(tempURL,window,tempPara);
    //zyclGridSql = Wfxw.findZycl(RMD_ID_TMP,1);
    //zyclDataSet.Open(zyclGridSql);
    reloadExtGrid();
}

//删除自由裁量权
function delZycl(){
    var grid =  creator_pt_grids[0].obj;
    var ids = FormUtil.getExtGridSelectedIds("rdd_id", grid);
    var quote_ids = FormUtil.getExtGridSelectedIds("quoted_id", grid);
    if (ids.length==0) {    
       alert("请选择要删除的记录！");
       return false;
    } else {
       var flag = false;
       for (var i=0;i<quote_ids.length;i++) {
           if (Number(quote_ids[i])==1) {
               flag = true;
               break;
           }
       }
       var str = "";
       if (flag) {
           str = "所选数据中有包含被引用的数据，删除后数据会失效，是否继续？";
       } else {
           str = "是否删除所选数据？";
       }
       if (confirm(str)) {
           var rv = Wfxw.delZycl(ids);
           if (rv) {
              alert("删除数据信息成功！");
              reloadExtGrid();
           } else {
              alert("删除数据信息失败！");
           }
       }
    }
}

//验证违法行为编码是否唯一
function checkonly(RMD_ID_TMP, bm){
    var countSql = Wfxw.countBm(RMD_ID_TMP, bm);
    tmpdataset.Open(countSql);
    if (tmpdataset.Fields.Field['NUM'].Value >0) {
        return false;
    } else {
        return true;
    }
}

//获取已选择的处罚措施
//chkClsIds 被取消的措施ID
//addcfcs 新增的措施ID
function selCheckBox(){
    var chkarg = document.getElementsByName('chks');    
    var tflag = false;
    cfcsTmp = "";
    addcfcs = "";
    chkClsIds = "";
    for(var j=0;j<chkarg.length;j++){
        if (chktmp != "") {
            if (chktmp.indexOf(chkarg[j].value)==-1 && chkarg[j].checked) {
                //-1为找不到在原有选择的ID里,现有选的为新增
                  if (addcfcs.indexOf(chkarg[j].value)==-1 ){
                    addcfcs = (addcfcs==""?chkarg[j].value:(addcfcs+","+chkarg[j].value));    
                }  
            } else if (chktmp.indexOf(chkarg[j].value)!=-1 && !chkarg[j].checked) {
                //找到已在原有选择的ID里,现没选的为取消
                  if (chkClsIds.indexOf(chkarg[j].value)==-1 ){
                    chkClsIds = (chkClsIds==""?chkarg[j].value:(chkClsIds+","+chkarg[j].value));
                }
            }
        }
        if (chkarg[j].checked) {
            tflag=true;
            if (cfcsTmp=="") {
                cfcsTmp = chkarg[j].value;
            } else {
                cfcsTmp = cfcsTmp+","+chkarg[j].value;
            }
        }
    }
    return tflag;
}

//取消的处罚措施分是否被引用
function isQuote(){
    if (chkClsIds!="") {
        stopcfcs = "";
        delcfcs  = "";
        var sql  = Wfxw.countWfxwCfcs(chkClsIds, RMD_ID_TMP);
        cfcsdataset.Open(sql);
        cfcsdataset.MoveFirst();
        var flag = true;
        var tmp = "";
        for(var i=0;i<cfcsdataset.RecordCount;i++){
             if (Number(cfcsdataset.Fields.Field['NUM'].Value)!=0) {
                if (Wfxw.countStopNum(Number(cfcsdataset.Fields.Field['PM_ID'].Value),RMD_ID_TMP)>0) {
                    stopcfcs=(stopcfcs==""?(cfcsdataset.Fields.Field['PM_ID'].Value):(stopcfcs+","+cfcsdataset.Fields.Field['PM_ID'].Value));
                } else {
                    if (Number(cfcsdataset.Fields.Field['NUM'].Value)>0) {
                        flag = false;
                        tmp = (tmp==""?(cfcsdataset.Fields.Field['PM_ID'].Value):(tmp+","+cfcsdataset.Fields.Field['PM_ID'].Value));
                    }
                }
            } else {
                if (delcfcs == "") {
                    delcfcs = cfcsdataset.Fields.Field['PM_ID'].Value;
                } else {
                    delcfcs = delcfcs + "," + cfcsdataset.Fields.Field['PM_ID'].Value;
                }
            }
            cfcsdataset.MoveNext();
        }
        if (!flag) {
            alert("在取消处罚措施之前,请先取消对应裁量细则的措施关系!");
            selBox(tmp);
            return false;
        }
    }
    return true;
}

//循环将裁量细则引用的选项重新选中
function selBox(sels){
    var chkarg = document.getElementsByName('chks');
    var sel_split = sels.split(",");
    for(var i=0;i<sel_split.length;i++) {
        for(var j=0;j<chkarg.length;j++){
            if (chkarg[j].value==Number(sel_split[i])) {
                chkarg[j].checked = true;
                break;
            }
        }
    }
}

</script>

<!-- 提示：以下为页面DOM元素内容 -->
<DIV id=SKbillsheet style="visibility:hidden" toolbar="不带工具栏" BLONopen="setAuthority();init();" contxml="<root><textarea><id>RMD_THE_LAW</id><id>RMD_RULE</id><id>RMD_REMARK</id></textarea><combobox><id>VC_ID</id><id>OC_ID</id></combobox><button><id>addZfyj</id><id>addCfyj</id><id>saveBtn</id><id>clsBtn</id><id>newBtn</id><id>delBtn</id></button><text><id>RMD_NAME</id><id>RMD_BRIEF_NAME</id><id>RMD_CODE</id><id>RMD_UPPER</id><id>RMD_LOWER</id></text><dataset><id>tmpdataset</id><id>cfcsdataset</id><id>tempDataset</id><id>zyclDataSet</id><id>wfxwSaveDataset</id></dataset><ExtGrid><id>zyclGrid</id></ExtGrid></root>" billtaborder="<root><taborder>RMD_THE_LAW</taborder><taborder>RMD_RULE</taborder><taborder>RMD_REMARK</taborder><taborder>VC_ID</taborder><taborder>OC_ID</taborder><taborder>addZfyj</taborder><taborder>addCfyj</taborder><taborder>saveBtn</taborder><taborder>clsBtn</taborder><taborder>newBtn</taborder><taborder>delBtn</taborder><taborder>RMD_NAME</taborder><taborder>RMD_CODE</taborder><taborder>RMD_UPPER</taborder><taborder>RMD_LOWER</taborder><taborder>RMD_BRIEF_NAME</taborder></root>" dj_sn="20100903113849656869" caption="新增违法行为" mkbh codeheader="BBB" entertype="修改" poswidth posheight controlno="SKButton:0;SKDBedit:0;checkbox:0;label:0;radio:0;listbox:0;textarea:0;combobox:0;password:0;upload:0;SKDBtext:0;chart:0;dbimg:0;img:0;SKBILLgrid:0;shape:0;tab:0;div:0;DsMain_field:0;a:0;button:0;text:0;hr:0;checkboxlist:0;radiolist:0;dropdownlist:0;grid:0;dataset:1;spin:0;excel:0;tree:0;ebshow:0;creatorSubForm:0;creator_div:0;ExtGrid:1;ExtUpload:0;ExtTree:0;Fusionchar:0" window="当前窗口" posleft postop keyfield isfile="否" OtherSave="否" idtype="1" testDbName="app_xzcf" creatorStyle="creatorBlue" BLONclose="UnLoadWebOffice();" creator_remark hasWorkflowButton="否" creator_elementAuthoritySwitch="否" creator_showAlert="否" creator_office_isBindForm="否" islog="否" isprotect="是" creator_csslib version="1.0" creator_pagination type="ZW" creatorType="20100902181525484338" jslib="fcsavedj.js&#13;&#10;fcbasecont.js&#13;&#10;selectdate.js&#13;&#10;~userfunc.js&#13;&#10;fcdate.js&#13;&#10;../../../ccapp/app_xzcf/js/common/Namespace.js&#13;&#10;../../../ccapp/app_xzcf/js/common/nsreg.js&#13;&#10;../../../ccapp/app_xzcf/js/common/Common.js&#13;&#10;../../../ccapp/app_xzcf/js/vo/WfxwVo.js&#13;&#10;../../../ccapp/app_xzcf/js/util/WorkflowUtil.js&#13;&#10;../../../ccapp/app_xzcf/js/business/Wfxw.js&#13;&#10;../../../ccapp/app_xzcf/js/dao/WfxwDao.js">

<TABLE cellSpacing=0 cellPadding=0 width="100%" align=center border=0>
   <TBODY>
      <TR>
         <TD>
            <TABLE class=Ctable cellSpacing=0 cellPadding=0 width="100%" align=center border=0>
               <TBODY>
                  <TR>
                     <TD class=taobox id=formTitleId colSpan=4>新增违法行为</TD>
                  </TR>
                  <TR>
                     <TD class=c2>行业分类<FONT color=red>*</FONT></TD>
                     <TD><SELECT id=VC_ID style="LEFT: 0px; WIDTH: 159px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() sqltrans="%F4%D8%E6%D8%D4%F6Xrn%BA%94%CC%A0%96Xr%94%BA%94%CC%AA%90%A8%98Xrn%DA%F2%EC%E8Xrn%B6%90%CC%BA%AC%94%90%B6%A0%AC%AA%CC%94%AC%AA%B4%B6%A0%B6%B8%B6%AC%B2Xrn%EC%F2%D6%D8%F2Xrn%D2%u0100Xrn%BA%94%CC%AC%B2%96%98%B2" controltype="combobox" tempvalue="-1" temptext="--请选择--" sql check="2"><OPTION value=-1 selected>--请选择--</OPTION></SELECT></TD>
                     <TD class=c2>违法类别<FONT color=red>*</FONT></TD>
                     <TD><SELECT id=OC_ID style="LEFT: 0px; WIDTH: 167px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() sqltrans="%F4%D8%E6%D8%D4%F6Xrn%AC%94%CC%A0%96Xr%94Xrn%AC%94%CC%AA%90%A8%98Xrn%DA%F2%EC%E8Xrn%B6%90%CC%AC%9A%9A%98%AA%B4%98%CC%94%90%B6%98%9C%AC%B2%C0Xrn%EC%F2%D6%D8%F2Xrn%D2%u0100Xrn%AC%94%CC%AC%B2%96%98%B2" controltype="combobox" tempvalue="-1" temptext="--请选择--" sql check="2"><OPTION value=-1 selected>--请选择--</OPTION></SELECT></TD>
                  </TR>
                  <TR>
                     <TD class=c2>违法行为名称<FONT color=red>*</FONT></TD>
                     <TD colSpan=3><INPUT class=input_out id=RMD_NAME style="LEFT: 0px; WIDTH: 298px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() size=54 controltype="text" field="RMD_NAME" china="违法行为名称" dataset="wfxwSaveDataset"></TD>
                  </TR>
                  <TR>
                     <TD class=c2>违法行为简称<FONT color=red>*</FONT></TD>
                     <TD colSpan=3><INPUT class=input_out id=RMD_BRIEF_NAME style="LEFT: 0px; WIDTH: 298px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() size=54 controltype="text" field="RMD_BRIEF_NAME" china="违法行为简称" dataset="wfxwSaveDataset"></TD>
                  </TR>
                  <TR>
                     <TD class=c2>违法行为编码<FONT color=red>*</FONT></TD>
                     <TD colSpan=3><INPUT class=input_out id=RMD_CODE style="LEFT: 0px; WIDTH: 110px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="RMD_CODE" china="违法行为编码" dataset="wfxwSaveDataset"></TD>
                  </TR>
                  <TR>
                     <TD class=c2>执法依据</TD>
                     <TD colSpan=3><TEXTAREA class=input_out id=RMD_THE_LAW style="LEFT: 0px; WIDTH: 438px; POSITION: static; TOP: 0px; HEIGHT: 85px" onmovestart=moveStart() cols=87 controltype="textarea" field="RMD_THE_LAW" china="执法依据" dataset="wfxwSaveDataset" value="textarea1" induce="否"></TEXTAREA><BUTTON id=addZfyj style="LEFT: 0px; WIDTH: 96px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick="bill_onclick(&quot;showLaw(${'RMD_THE_LAW'},1)&quot;)">添加执法依据</BUTTON></TD>
                  </TR>
                  <TR>
                     <TD class=c2>处罚依据</TD>
                     <TD colSpan=3><TEXTAREA class=input_out id=RMD_RULE style="LEFT: 0px; WIDTH: 438px; POSITION: static; TOP: 0px; HEIGHT: 85px" onmovestart=moveStart() cols=87 controltype="textarea" field="RMD_RULE" china="处罚依据" dataset="wfxwSaveDataset" value="textarea2" induce="否"></TEXTAREA><BUTTON id=addCfyj style="LEFT: 0px; WIDTH: 96px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick="bill_onclick(&quot;showLaw(${'RMD_RULE'},2)&quot;)">添加处罚依据</BUTTON><?xml:namespace prefix = fc /><fc:dataset id=tmpdataset format="<fields><field><fieldname>NUM</fieldname><datatype>字符</datatype><displaylabel>个数</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field></fields>" onSetText='bill_ondatasetsettext("<dsid><NUM></NUM></dsid>")' onGetText='bill_ondatasetgettext("<dsid><NUM></NUM></dsid>")' onValid='bill_ondatasetvalid("<dsid><NUM></NUM></dsid>")' opensortno="1" temptable="TMP_DATASET1" multiResult="否"></fc:dataset><fc:dataset id=cfcsdataset format="<fields><field><fieldname>PM_ID</fieldname><datatype>字符</datatype><displaylabel>处罚措施ID</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>NUM</fieldname><datatype>字符</datatype><displaylabel>统计数据</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>PMRRD_ATTRI</fieldname><datatype>字符</datatype><displaylabel>细则措施是否停用</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field></fields>" onSetText='bill_ondatasetsettext("<dsid><PM_ID></PM_ID><NUM></NUM><PMRRD_ATTRI></PMRRD_ATTRI></dsid>")' onGetText='bill_ondatasetgettext("<dsid><PM_ID></PM_ID><NUM></NUM><PMRRD_ATTRI></PMRRD_ATTRI></dsid>")' onValid='bill_ondatasetvalid("<dsid><PM_ID></PM_ID><NUM></NUM><PMRRD_ATTRI></PMRRD_ATTRI></dsid>")' opensortno="1" temptable="TMP_DATASET4" multiResult="否"></fc:dataset></TD>
                  </TR>
                  <TR>
                     <TD class=c2>处罚措施<FONT color=red>*</FONT></TD>
                     <TD colSpan=3><DIV id=cfcsBox><DIV id=tmpbox></DIV></DIV><fc:dataset id=tempDataset format="<fields><field><fieldname>PM_ID</fieldname><datatype>字符</datatype><displaylabel>处罚措施ID</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>PM_NAME</fieldname><datatype>字符</datatype><displaylabel>处罚措施名称</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field></fields>" onSetText='bill_ondatasetsettext("<dsid><PM_ID></PM_ID><PM_NAME></PM_NAME></dsid>")' onGetText='bill_ondatasetgettext("<dsid><PM_ID></PM_ID><PM_NAME></PM_NAME></dsid>")' onValid='bill_ondatasetvalid("<dsid><PM_ID></PM_ID><PM_NAME></PM_NAME></dsid>")' opensortno="1" temptable="TMP_DATASET2" multiResult="是"></fc:dataset></TD>
                  </TR>
                  <TR>
                     <TD class=c2>是否有金额</TD>
                     <TD colSpan=3><INPUT onclick=showmoney() type=radio CHECKED value=1 name=RMD_ISVALUE>是<INPUT onclick=showmoney() type=radio value=0 name=RMD_ISVALUE>否</TD>
                  </TR>
                  <TR id=hasmoney>
                     <TD class=c2>罚金限制<FONT color=red>*</FONT></TD>
                     <TD colSpan=3>上限<INPUT class=input_out id=RMD_UPPER style="LEFT: 0px; WIDTH: 110px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="RMD_UPPER" china="罚金上限" dataset="wfxwSaveDataset">元&nbsp;&nbsp;下限<INPUT class=input_out id=RMD_LOWER style="LEFT: 0px; WIDTH: 110px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="RMD_LOWER" china="罚金下限" dataset="wfxwSaveDataset">元</TD>
                  </TR>
                  <TR>
                     <TD class=c2>是否有效</TD>
                     <TD colSpan=3><INPUT type=radio CHECKED value=1 name=RMD_STATUS>是<INPUT type=radio value=0 name=RMD_STATUS>否</TD>
                  </TR>
                  <TR>
                     <TD class=c2>备注</TD>
                     <TD colSpan=3><TEXTAREA class=input_out id=RMD_REMARK style="LEFT: 0px; WIDTH: 441px; POSITION: static; TOP: 0px; HEIGHT: 85px" onmovestart=moveStart() cols=88 controltype="textarea" field="RMD_REMARK" china="备注" dataset="wfxwSaveDataset" value="textarea3" induce="否"></TEXTAREA></TD>
                  </TR>
                  <TR>
                     <TD align=middle colSpan=4><BUTTON class=button id=saveBtn style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("save()")'>保存</BUTTON><BUTTON class=button id=clsBtn style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("close()")'>关闭</BUTTON></TD>
                  </TR>
               </TBODY>
            </TABLE>
         </TD>
      </TR>
      <TR>
         <TD>
            <TABLE cellSpacing=0 cellPadding=0 width="100%" align=center border=0>
               <TBODY>
                  <TR>
                     <TD align=right colSpan=4><BUTTON class=addbutton1 id=newBtn style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("addZycl()")'>新增</BUTTON><BUTTON class=sbutton1 id=delBtn style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("delZycl()")'>删除</BUTTON></TD>
                  </TR>
                  <TR>
                     <TD align=left colSpan=4><INPUT onclick=cf_queryZycl() type=radio CHECKED value=1 name=RDD_OBJECT_TYPE>公民<INPUT onclick=cf_queryZycl() type=radio value=2 name=RDD_OBJECT_TYPE>法人或其他组织</TD>
                  </TR>
                  <TR>
                     <TD colSpan=4>&nbsp;<IMG style="DISPLAY: none" src="undefined"><DIV id=div_zyclGrid style="LEFT: 0px; POSITION: static; TOP: 0px"></DIV><SCRIPT type=text/javascript>var zyclGrid;
Ext.BLANK_IMAGE_URL = '../../fceform/js/Ext/images/default/s.gif';
var zyclGrid_retint = 0;
var zyclGrid_onReady = function(){ 
 Ext.QuickTips.init();
var dataset = document.getElementById("zyclDataSet");
try{var temp = dataset.Fields.Field.length;}catch(e){if(zyclGrid_retint==0) zyclGrid_retint = setInterval(zyclGrid_onReady,200);dataset =null;return;}finally{if(temp!=null)temp=null;}
clearInterval(zyclGrid_retint);zyclGrid_retint = null ;var pagesize =10;
dataset.PageSize = pagesize ;
var mapping = creator_pt_getmapping(dataset);
var store  = new Ext.data.Store({
	proxy: new Ext.data.CreatorMemoryProxy("zyclDataSet"), 
	reader: new Ext.data.XmlStringReader({       record: 'tr',       totalRecords: 'pages'   }, mapping)});
var sm = new Ext.grid.RowSelectionModel({singleSelect: true});
var retcm = creator_pt_getcm(dataset,sm);var cm = new Ext.grid.ColumnModel(retcm);
if(typeof(retcm[0].getCount)!='undefined') sm = retcm[0] ;
 zyclGrid = new Ext.grid.GridPanel({
		el: 'div_zyclGrid',        store: store,
        cm:cm,
		sm: sm,
 			 bodyStyle : 'width:100%',
		viewConfig: {
			forceFit: true		},       loadMask: true,
	width: '100%',
					height: eval(document.body.clientHeight*(parseFloat('50%')))/100,
		split: true,
		region: 'north',
		title:'自由裁量权',
		frame:true
		,plugins: new Ext.ux.PanelResizer({
            minHeight: 100        }),
       bbar: new Ext.PagingToolbar({
            pageSize: pagesize,
            store: store,
            displayInfo: true,
            displayMsg:'当前显示第 {0} - {1} 条，共 {2} 条',            plugins: new Ext.ux.SlidingPager()        })		    });
    var grid=zyclGrid;
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
cm.setHidden(7,true);
grid.addListener('rowdblclick', editZycl);zyclGrid.render();
store.load({params:{start:0, limit:pagesize}});
if(typeof(creator_pt_grids)=='undefined'){creator_pt_grids=new Array();}
creator_pt_grids.push({id:'zyclGrid',obj:zyclGrid,dataset:'zyclDataSet',isEdit:'false'});
if(typeof(onGridPanelLoaded)=='function') setTimeout(onGridPanelLoaded,0);
};
zyclGrid_onReady();window.onresize=function(){try{zyclGrid.setWidth(eval(document.body.clientWidth*(parseFloat('95%')))/100);}catch(e){}};</SCRIPT></TD>
                  </TR>
               </TBODY>
            </TABLE>
         </TD>
      </TR>
   </TBODY>
</TABLE>

<INPUT id=rmd_id type=hidden name=rmd_id>

<fc:dataset id=zyclDataSet showtypeXml="<root><showType><name>checked</name><showRule>%5B%7Bshowtype%3A%27checkbox%27%7D%5D</showRule></showType><showType><name>RDD_ID</name><showRule>undefined</showRule></showType></root>" columnHeight1Xml="undefined" columnWidth1Xml="undefined" format="<fields><field><fieldname>checked</fieldname><datatype>字符</datatype><displaylabel>全选</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype><showRule>%5B%7Bshowtype%3A%27checkbox%27%7D%5D</showRule></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>RDD_LAW_DEGREE</fieldname><datatype>字符</datatype><displaylabel>违法程度</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>RDD_ILLEGAL_PLOT</fieldname><datatype>字符</datatype><displaylabel>违法情节</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>RDD_PUNISHMENT_STANDARDS</fieldname><datatype>字符</datatype><displaylabel>处罚标准</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>RDD_ID</fieldname><datatype>字符</datatype><displaylabel>裁量细则ID</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>否</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype><showRule>undefined</showRule></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>IS_QUOTED</fieldname><datatype>字符</datatype><displaylabel>是否被引用</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>RDD_STATUS</fieldname><datatype>字符</datatype><displaylabel>状态</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>QUOTED_ID</fieldname><datatype>字符</datatype><displaylabel>是否被引用标识</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field></fields>" onSetText='bill_ondatasetsettext("<dsid><checked></checked><RDD_LAW_DEGREE></RDD_LAW_DEGREE><RDD_ILLEGAL_PLOT></RDD_ILLEGAL_PLOT><RDD_PUNISHMENT_STANDARDS></RDD_PUNISHMENT_STANDARDS><RDD_ID></RDD_ID><IS_QUOTED></IS_QUOTED><RDD_STATUS></RDD_STATUS><QUOTED_ID></QUOTED_ID></dsid>")' onGetText='bill_ondatasetgettext("<dsid><checked></checked><RDD_LAW_DEGREE></RDD_LAW_DEGREE><RDD_ILLEGAL_PLOT></RDD_ILLEGAL_PLOT><RDD_PUNISHMENT_STANDARDS></RDD_PUNISHMENT_STANDARDS><RDD_ID></RDD_ID><IS_QUOTED></IS_QUOTED><RDD_STATUS></RDD_STATUS><QUOTED_ID></QUOTED_ID></dsid>")' onValid='bill_ondatasetvalid("<dsid><checked></checked><RDD_LAW_DEGREE></RDD_LAW_DEGREE><RDD_ILLEGAL_PLOT></RDD_ILLEGAL_PLOT><RDD_PUNISHMENT_STANDARDS></RDD_PUNISHMENT_STANDARDS><RDD_ID></RDD_ID><IS_QUOTED></IS_QUOTED><RDD_STATUS></RDD_STATUS><QUOTED_ID></QUOTED_ID></dsid>")' opensortno="1" temptable="TMP_DATASET1" multiResult="是"></fc:dataset>

<fc:dataset id=wfxwSaveDataset format="<fields><field><fieldname>VC_ID</fieldname><datatype>字符</datatype><displaylabel>行业分类</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>OC_ID</fieldname><datatype>字符</datatype><displaylabel>违法类别</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>RMD_NAME</fieldname><datatype>字符</datatype><displaylabel>违法行为名称</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>RMD_BRIEF_NAME</fieldname><datatype>字符</datatype><displaylabel>违法行为简称</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>RMD_CODE</fieldname><datatype>字符</datatype><displaylabel>违法行为编码</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>RMD_THE_LAW</fieldname><datatype>字符</datatype><displaylabel>执法依据</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>RMD_RULE</fieldname><datatype>字符</datatype><displaylabel>处罚依据</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>RMD_UPPER</fieldname><datatype>实数</datatype><displaylabel>罚金上限</displaylabel><size>10</size><precision>2</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>RMD_LOWER</fieldname><datatype>实数</datatype><displaylabel>罚金下限</displaylabel><size>10</size><precision>2</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>RMD_STATUS</fieldname><datatype>字符</datatype><displaylabel>是否有效</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>RMD_REMARK</fieldname><datatype>字符</datatype><displaylabel>备注</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>RMD_ISVALUE</fieldname><datatype>字符</datatype><displaylabel>是否有金额</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field></fields>" onSetText='bill_ondatasetsettext("<dsid><VC_ID></VC_ID><OC_ID></OC_ID><RMD_NAME></RMD_NAME><RMD_BRIEF_NAME></RMD_BRIEF_NAME><RMD_CODE></RMD_CODE><RMD_THE_LAW></RMD_THE_LAW><RMD_RULE></RMD_RULE><RMD_UPPER></RMD_UPPER><RMD_LOWER></RMD_LOWER><RMD_STATUS></RMD_STATUS><RMD_REMARK></RMD_REMARK><RMD_ISVALUE></RMD_ISVALUE></dsid>")' onGetText='bill_ondatasetgettext("<dsid><VC_ID></VC_ID><OC_ID></OC_ID><RMD_NAME></RMD_NAME><RMD_BRIEF_NAME></RMD_BRIEF_NAME><RMD_CODE></RMD_CODE><RMD_THE_LAW></RMD_THE_LAW><RMD_RULE></RMD_RULE><RMD_UPPER></RMD_UPPER><RMD_LOWER></RMD_LOWER><RMD_STATUS></RMD_STATUS><RMD_REMARK></RMD_REMARK><RMD_ISVALUE></RMD_ISVALUE></dsid>")' onValid='bill_ondatasetvalid("<dsid><VC_ID></VC_ID><OC_ID></OC_ID><RMD_NAME></RMD_NAME><RMD_BRIEF_NAME></RMD_BRIEF_NAME><RMD_CODE></RMD_CODE><RMD_THE_LAW></RMD_THE_LAW><RMD_RULE></RMD_RULE><RMD_UPPER></RMD_UPPER><RMD_LOWER></RMD_LOWER><RMD_STATUS></RMD_STATUS><RMD_REMARK></RMD_REMARK><RMD_ISVALUE></RMD_ISVALUE></dsid>")' opensortno="1" temptable="TMP_DATASET1" multiResult="否"></fc:dataset>
</DIV>
<div id='grid_tip'></div></body></html>
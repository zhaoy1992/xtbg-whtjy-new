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
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/vo/ZyclVo.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/vo/ZyclVo.js'></script>");
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
</script>


<!-- 提示：以下为页面自定义JS内容 -->
<script>
var TYPE_TMP = creator_getQueryString("type");
var IS_VALUE = creator_getQueryString("isValueNew");
var upvalue = creator_getQueryString("upvalue");
var lowvalue= creator_getQueryString("lowvalue");
var RDD_ID_TMP = creator_getQueryString("rddId");
var RMD_ID_TMP = creator_getQueryString("rmdId");
var cfcsIds = creator_getQueryString("cfcsids");//违法行为的处罚措施IDS
var cfcsTmp = "";//存放已选择的处罚措施
var chkids = "";//存放初始的处罚措施
var chkClsIds = "" ; //存放被取消的初始措施信息 
//新增、停用、删除措施
var addcfcs = "";
var stopcfcs = "";
var delcfcs = "";
//存放考核字段旧值
var arr_ora = new Array();
var arr_new = new Array();

//处罚标准描述补充
function showadd(){
    document.getElementById("supplement").style.display = (document.getElementById("supplement").style.display=="block"?"none":"block");
}

function showmoney(){
    var tmp = document.getElementsByName('RDD_ISVALUE');//是否有金额
     if (tmp[0].checked) {
        document.getElementById("hasmoney").style.display="block";
    } else {
        document.getElementById("hasmoney").style.display="none"; 
        var attriTmp = document.getElementsByName('RDD_ATTRI');//取值规则
         attriTmp[0].checked=true; 
        ${'RDD_BASEUNIT_DESC'}.value = "";
        ${'JDD_BASEUNIT'}.value = "";
        showjs();
    }
}


function showjs(){
    var obj = document.getElementsByName('RDD_ATTRI');
    if (obj[1].checked) {
        document.getElementById('bl').style.display="block";
        document.getElementById('dw1').innerHTML="&nbsp;";
        document.getElementById('dw2').innerHTML="&nbsp;";
    } else {
        document.getElementById('bl').style.display="none";
        document.getElementById('dw1').innerHTML="元";
        document.getElementById('dw2').innerHTML="元";
    }
}

function init(){
    if(RDD_ID_TMP==null){RDD_ID_TMP=0;}
    //加载选择的处罚对象类别
    if (TYPE_TMP==1) {
        document.getElementById('faren').innerHTML = "公民";
    } else if (TYPE_TMP==2) {
        document.getElementById('faren').innerHTML = "法人和其他组织";
    }  
    //加载违法行为勾选的处罚措施
     var sql = Wfxw.queryCfcsByIds(cfcsIds);
    zycldataset.Open(sql);
    zycldataset.MoveFirst();
    var tmpbox = document.getElementById('tmpbox');//div
    var tmpcfcsbox = document.getElementById('cfcsBox');//div
    for(var i=0;i<zycldataset.RecordCount;i++){
        var str = "<INPUT name=chks id=chks type=checkbox onclick=compoStandards()>"
        var newCheckbox = document.createElement(str);
        newCheckbox.value=zycldataset.Fields.Field['PM_ID'].Value;
        var spanStr="<span id =" + newCheckbox.value + "></span>";
        var spanTmp = document.createElement(spanStr);
        spanTmp.innerHTML = zycldataset.Fields.Field['PM_NAME'].Value;
        tmpcfcsbox.insertBefore(spanTmp,tmpbox);
        tmpcfcsbox.insertBefore(newCheckbox,spanTmp);
        zycldataset.MoveNext();
    }
    //加载是否有金额
     var isvalueTmp = document.getElementsByName('RDD_ISVALUE') ;//是否有金额
     if (IS_VALUE == 0) {
        isvalueTmp[1].checked = true;
        isvalueTmp[0].disabled = true;
        isvalueTmp[1].disabled = true;
    }
    if (RDD_ID_TMP) {
        var editSql = Wfxw.findZyclById(RDD_ID_TMP);
        zyclsavedataset.Open(editSql);
        
        ${'OL_ID'}.value = zyclsavedataset.Fields.Field['OL_ID'].Value;
        //状态
         var status = zyclsavedataset.Fields.Field['RDD_STATUS'].Value;
        var rddStatus = document.getElementsByName('RDD_STATUS');
        if (status == 1){
            rddStatus[0].checked = true;
        } else {
            rddStatus[1].checked = true;
        }
        //是否有金额初始化
         var rddup = zyclsavedataset.Fields.Field['RDD_UPPER'].Value;
        var rddupvalue = zyclsavedataset.Fields.Field['RDD_VALUE_UPPER'].Value;
        var rddlower = zyclsavedataset.Fields.Field['RDD_LOWER'].Value;
        var rddlowervalue = zyclsavedataset.Fields.Field['RDD_VALUE_LOWER'].Value;
        var isneedmoney = zyclsavedataset.Fields.Field['RDD_ISVALUE'].Value;
        var ismoney = zyclsavedataset.Fields.Field['RDD_ATTRI'].Value;
        var standarSplit = zyclsavedataset.Fields.Field['RDD_PUNISHMENT_STANDARDS'].Value.split("\n");
        $("RDD_PUNISHMENT_STANDARDS").value = standarSplit[0];
        if (standarSplit.length>1) {
            for (var k=1;k<standarSplit.length;k++) {
                if ($("RDD_PUNISHMENT_ADD").value == "") {
                    $("RDD_PUNISHMENT_ADD").value = standarSplit[k];
                } else {
                    $("RDD_PUNISHMENT_ADD").value = $("RDD_PUNISHMENT_ADD").value +"\n"+standarSplit[k];
                }
            }
        }
        if (isneedmoney == 1) {
            isvalueTmp[0].checked = true;
        } else {
            isvalueTmp[1].checked = true;
        }
        var attriTmp = document.getElementsByName('RDD_ATTRI');//取值规则
         if (ismoney == 1) {
            attriTmp[0].checked = true;
        } else {
            attriTmp[1].checked = true;
        }
        
        if (isneedmoney==1) {
            if (ismoney==1) {
                ${'RDD_UPPER'}.value = rddupvalue ;
                ${'RDD_LOWER'}.value = rddlowervalue ;
            } else {
                ${'RDD_UPPER'}.value = rddup ;
                ${'RDD_LOWER'}.value = rddlower ;
            }
        }
        showmoney();
        //存放考核字段旧值
         arr_ora[0] = zyclsavedataset.Fields.Field['OL_ID'].Value;//违法级别
         arr_ora[1] = zyclsavedataset.Fields.Field['RDD_ILLEGAL_PLOT'].Value;//违法情节
         arr_ora[2] = zyclsavedataset.Fields.Field['RDD_LAW_DEGREE'].Value;//违法程度
         arr_ora[3] = zyclsavedataset.Fields.Field['RDD_ISVALUE'].Value;//有金额
         arr_ora[4] = zyclsavedataset.Fields.Field['RDD_UPPER'].Value;//比例上限
         arr_ora[5] = zyclsavedataset.Fields.Field['RDD_LOWER'].Value;//比例下限
         arr_ora[6] = zyclsavedataset.Fields.Field['RDD_ATTRI'].Value;//取值规则
         arr_ora[7] = zyclsavedataset.Fields.Field['RDD_PUNISHMENT_STANDARDS'].Value;//处罚标准
         arr_ora[8] = zyclsavedataset.Fields.Field['JDD_BASEUNIT'].Value;//基数单位
         arr_ora[9] = zyclsavedataset.Fields.Field['RDD_BASEUNIT_DESC'].Value;//基数说明
        
        //初始化处罚措施
         var initCfcs = Wfxw.findCfcsByZyclId(RDD_ID_TMP);
        zycldataset.Open(initCfcs);
        zycldataset.MoveFirst();
        for(var i=0;i<zycldataset.RecordCount;i++){
            var chkarg = document.getElementsByName('chks');
            var valueTmp = zycldataset.Fields.Field['PM_ID'].Value ;
            if (chkids == "") {
                chkids = valueTmp;
            } else {
                chkids = chkids + "," + valueTmp;
            }
            for(var j=0;j<chkarg.length;j++){
                if (chkarg[j].value == valueTmp) {
                    chkarg[j].checked = true;
                }
            }
            zycldataset.MoveNext();
        }
    }
}

//逻辑验证
function validate(){
    var flag = true;
    delSpace();
    if (flag) {
        flag = SValidator.validate(${'RDD_LAW_DEGREE'}.value, {
            CHECK_TYPE : "maxlength",
            ARGUMENT : {placeholders : [30],maxlength : 30},
            MESSAGE : "违法程度最大不能超过{0}字符!"
        }, false);
    }
    if (flag) {
        if(document.getElementById('OL_ID').value==-1){
            alert("请选择违法级别!");
            flag = false;
        }
    }
    if (flag) {
        flag = SValidator.validate(${'RDD_CODE'}.value, {
            CHECK_TYPE : "required",
            ARGUMENT : {placeholders : [""]},
            MESSAGE : "编码不能为空!"
        }, true);
    }
    if (flag) {
        flag = SValidator.validate(${'RDD_CODE'}.value, {
            CHECK_TYPE : "maxlength",
            ARGUMENT : {placeholders : [10],maxlength : 10},
            MESSAGE : "编码最大不能超过{0}字符!"
        }, true);
    }
    if (flag) {
        flag = checkonly(RDD_ID_TMP, ${'RDD_CODE'}.value.trim()) ;
        if (!flag) {
            alert('编码已存在,请重新输入!');
        }    }
    if (flag) {
        flag = SValidator.validate(${'RDD_ILLEGAL_PLOT'}.value, {
            CHECK_TYPE : "required",
            ARGUMENT : {placeholders : [""]},
            MESSAGE : "违法情节不能为空!"
        }, true);
    }
    if (flag) {
        flag = SValidator.validate(${'RDD_ILLEGAL_PLOT'}.value, {
            CHECK_TYPE : "maxlength",
            ARGUMENT : {placeholders : [125],maxlength : 125},
            MESSAGE : "违法情节最大不能超过{0}字符!"
        }, true);
    }
    if (flag) {
        flag = selCheckBox();
        if (!flag) {
            alert('请选择处罚措施!');
        }
    }
    if (flag) {
        flag = SValidator.validate(${'RDD_PUNISHMENT_STANDARDS'}.value, {
            CHECK_TYPE : "maxlength",
            ARGUMENT : {placeholders : [125],maxlength : 125},
            MESSAGE : "处罚标准最大不能超过{0}字符!"
        }, true);
    }
    return flag ; 
}

function moneyValidate(){
    var flag = true;
    if (flag) {
        flag = SValidator.validate(${'RDD_UPPER'}.value, {
            CHECK_TYPE : "required",
            ARGUMENT : {placeholders : [${'RDD_UPPER'}.value]},
            MESSAGE : "罚金限制上限不能为空!"
        }, true);
    }
    if (flag) {
        flag = SValidator.validate(${'RDD_UPPER'}.value, {
            CHECK_TYPE : "mask",
            ARGUMENT : {placeholders : [""],mask:/^\d{1,10}([\.]\d{1,2})?$/},
            MESSAGE : "罚金限制上限格式不正确!参照如:1234567890.12"
        }, false);
    }
    if (flag) {
        flag = SValidator.validate(${'RDD_UPPER'}.value, {
            CHECK_TYPE : "maxlength",
            ARGUMENT : {placeholders : [12],maxlength : 12},
            MESSAGE : "罚金限制上限最多不能超过{0}字符!"
        }, true);
    }
    if (flag) {
        flag = SValidator.validate(${'RDD_LOWER'}.value, {
            CHECK_TYPE : "required",
            ARGUMENT : {placeholders : [${'RDD_LOWER'}.value]},
            MESSAGE : "罚金限制下限不能为空!"
        }, true);
    }
    if (flag) {
        flag = SValidator.validate(${'RDD_LOWER'}.value, {
            CHECK_TYPE : "mask",
            ARGUMENT : {placeholders : [""],mask:/^\d{1,10}([\.]\d{1,2})?$/},
            MESSAGE : "罚金限制下限格式不正确!参照如:1234567890.12"
        }, false);
    }
    if (flag) {
        flag = SValidator.validate(${'RDD_LOWER'}.value, {
            CHECK_TYPE : "maxlength",
            ARGUMENT : {placeholders : [12],maxlength : 12},
            MESSAGE : "罚金限制下限最多不能超过{0}字符!"
        }, true);
    }
    if (flag) {
        flag = SValidator.validate(${'RDD_BASEUNIT_DESC'}.value, {
            CHECK_TYPE : "maxlength",
            ARGUMENT : {placeholders : [125],maxlength : 125},
            MESSAGE : "基数说明最大不能超过{0}字符!"
        }, false);
    }
    if (flag) {
        flag = SValidator.validate(${'JDD_BASEUNIT'}.value, {
            CHECK_TYPE : "maxlength",
            ARGUMENT : {placeholders : [10],maxlength : 10},
            MESSAGE : "基数单位最大不能超过{0}字符!"
        }, false);
    }
    return flag;
}

//组合处罚措施和金额到处罚标准描述一栏中
function compoStandards(){
    var chkarg = document.getElementsByName('chks');
    var chkBaseTmp = "";
    for (var j=0; j<chkarg.length; j++) {
        if (chkarg[j].checked) {
            if (chkBaseTmp=="") {
                chkBaseTmp = chkarg[j].value;
            } else {
                chkBaseTmp = chkBaseTmp+","+chkarg[j].value;
            }
        }
    }
    var tmp = chkBaseTmp.split(",");
    var composeText = "";
    for (var i=0;i<tmp.length;i++) {
        var spanTmp = document.getElementById(tmp[i]);
        if (composeText == "") {
            composeText = spanTmp.innerHTML;
        } else {
            composeText = composeText + "," + spanTmp.innerHTML;
        }
    }
    if (document.getElementsByName('RDD_ISVALUE')[0].checked && document.getElementsByName('RDD_ATTRI')[0].checked){//有金额且是金额非比例
         composeText = composeText + ",罚款上限" + Number(document.getElementById('RDD_UPPER').value) + "元 下限" + Number(document.getElementById('RDD_LOWER').value)+"元";
    }
    $("RDD_PUNISHMENT_STANDARDS").value = composeText ;
}

//保存
function save(){
    if (validate()) {
        var obj = new ZyclVo.Zycl();
        var vo = DBUtil.getVoFromPage(obj);
        var tmp = document.getElementsByName('RDD_ISVALUE');//是否有金额
         if (tmp[0].checked) {
            if (!moneyValidate()) {
                return false;
            }
            vo.RDD_ISVALUE = tmp[0].value ;
        } else {
            //var num = Wfxw.countRddIsValue(RDD_ID_TMP);
            //if (num > 0) {
            //    alert("裁量细则实例已使用金额，因此是否有金额不能修改");
            //    return false;
            //}
            vo.RDD_ISVALUE = tmp[1].value ;
        }
        var tmp1 = document.getElementsByName('RDD_ATTRI');//取值规则
         var uptmp = document.getElementById('RDD_UPPER').value;
        var lowtmp = document.getElementById('RDD_LOWER').value;
        
        //临时变量,最后存入arr_new[4]与arr_new[5]
        var tmp4 = "";
        var tmp5 = "";
        if (tmp[0].checked) {//有金额
             if (Number(uptmp)<Number(lowtmp)) {
               alert("上限值应该比下限值大");
               return false;
           }
           if (tmp1[0].checked) {//金额规则
                 vo.RDD_ATTRI = tmp1[0].value ;                
               //上限
                 if (Number(uptmp)>Number(upvalue)) {
                   alert("金额上限请控制在违法行为定义的罚金上限之内!");
                   return false;
               }
               //下限
                 if (Number(lowtmp)<Number(lowvalue)) {
                   alert("金额下限请在违法行为定义的罚金下限之上!");
                   return false;
               }
               vo.RDD_VALUE_UPPER = uptmp ;
               vo.RDD_UPPER = 0 ;
               vo.RDD_VALUE_LOWER = lowtmp ;
               vo.RDD_LOWER = 0 ;
               tmp4 = vo.RDD_VALUE_UPPER;//上限
                 tmp5 = vo.RDD_VALUE_LOWER;//下限
             } else {//比例规则
                 vo.RDD_ATTRI = tmp1[1].value ;
               vo.RDD_VALUE_UPPER = 0;
               vo.RDD_UPPER = uptmp ;
               vo.RDD_VALUE_LOWER = 0;
               vo.RDD_LOWER = lowtmp ;   
               tmp4 = vo.RDD_UPPER;//上限
                 tmp5 = vo.RDD_LOWER;//下限     
             }
        } else { //无金额
             tmp4 = 0;//上限
             tmp5 = 0;//下限
             vo.RDD_ATTRI = 1 ;
           vo.RDD_VALUE_UPPER = 0;
           vo.RDD_UPPER = 0;
           vo.RDD_VALUE_LOWER = 0;
           vo.RDD_LOWER = 0; 
        }
        tmp = document.getElementsByName('RDD_STATUS');//状态
         if (tmp[0].checked) {
            vo.RDD_STATUS = tmp[0].value ;
        } else {
            vo.RDD_STATUS = tmp[1].value ;
        }
        compoStandards();
        vo.RDD_PUNISHMENT_STANDARDS = $("RDD_PUNISHMENT_STANDARDS").value ;
        if (!IsSpace($("RDD_PUNISHMENT_ADD").value)) {
            vo.RDD_PUNISHMENT_STANDARDS = vo.RDD_PUNISHMENT_STANDARDS + "\n"+$("RDD_PUNISHMENT_ADD").value;
        }
        var arg = "";//处罚措施
         if (RDD_ID_TMP) {
            var flag = isQuote();
            if (!flag) {
                return false;
            }
            if (addcfcs != "") {
                arg = addcfcs.split(",");
            }
            //存放考核字段新值
             arr_new[0] = vo.OL_ID;//违法级别
             arr_new[1] = vo.RDD_ILLEGAL_PLOT;//违法情节
             arr_new[2] = vo.RDD_LAW_DEGREE;//违法程度
             arr_new[3] = vo.RDD_ISVALUE;//有金额
             arr_new[4] = tmp4;//上限
             arr_new[5] = tmp5;//下限
             arr_new[6] = vo.RDD_ATTRI;//取值规则
             arr_new[7] = vo.RDD_PUNISHMENT_STANDARDS;//处罚标准
             arr_new[8] = vo.JDD_BASEUNIT;//基数单位
             arr_new[9] = vo.RDD_BASEUNIT_DESC;//基数说明
         } else {
            arg = cfcsTmp.split(",");
        }
        vo.RMD_ID = RMD_ID_TMP;//违法行为ID
        vo.RDD_ID = RDD_ID_TMP;//违法行为ID
        vo.RDD_OBJECT_TYPE = TYPE_TMP;//处罚对象类别
         vo.DEL_PUNISHMENT_ID = delcfcs;
        vo.STOP_PUNISHMENT_ID = stopcfcs; 
        var rv = Wfxw.saveWfxwZycl(vo, arg, arr_ora, arr_new);
        if(rv){
            alert("保存数据信息成功！");
            if (RDD_ID_TMP == 0) {
                RDD_ID_TMP = vo.RDD_ID;
            }
            chkids = cfcsTmp;
            //存放考核字段旧值
             arr_ora[0] = vo.OL_ID;//违法级别
             arr_ora[1] = vo.RDD_ILLEGAL_PLOT;//违法情节
             arr_ora[2] = vo.RDD_LAW_DEGREE;//违法程度
             arr_ora[3] = vo.RDD_ISVALUE;//有金额
             arr_ora[4] = tmp4;//上限
             arr_ora[5] = tmp5;//下限
             arr_ora[6] = vo.RDD_ATTRI;//取值规则
             arr_ora[7] = vo.RDD_PUNISHMENT_STANDARDS;//处罚标准
             arr_ora[8] = vo.JDD_BASEUNIT;//基数单位
             arr_ora[9] = vo.RDD_BASEUNIT_DESC;//基数说明
             window.close();
         }else{
            alert("保存数据信息失败！");
         }
    }
}


//验证自由裁量权编码是否唯一
function checkonly(RDD_ID_TMP, bm){
    var countSql = Wfxw.countZyBm(RDD_ID_TMP, bm);
    tempdataset.Open(countSql);
    if (tempdataset.Fields.Field['NUM'].Value >0) {
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
        if (chkids != "") {
            if (chkids.indexOf(chkarg[j].value)==-1 && chkarg[j].checked) {
                //-1为找不到在原有选择的ID里,现有选的为新增
                  if (addcfcs.indexOf(chkarg[j].value)==-1 ){
                    addcfcs = (addcfcs==""?chkarg[j].value:(addcfcs+","+chkarg[j].value));    
                }  
            } else if (chkids.indexOf(chkarg[j].value)!=-1 && !chkarg[j].checked) {
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

//取消的处罚措施分为停用与删除
function isQuote(){
    if (chkClsIds!="") {
        var sql = Wfxw.countZyclCfcs(chkClsIds, RDD_ID_TMP);
        cfcsdataset.Open(sql);
        cfcsdataset.MoveFirst();
        var flag = true;
        var tmp = "";
        for(var i=0;i<cfcsdataset.RecordCount;i++){
            if (cfcsdataset.Fields.Field['NUM'].Value!=0) {
                if (Number(cfcsdataset.Fields.Field['NUM'].Value)>0) {
                    flag = false;
                    tmp = (tmp==""?(cfcsdataset.Fields.Field['PM_ID'].Value):(tmp+","+cfcsdataset.Fields.Field['PM_ID'].Value));
                }
            } else {
                if (delcfcs == ""){
                    delcfcs = cfcsdataset.Fields.Field['PM_ID'].Value;
                } else {
                    delcfcs = delcfcs + "," + cfcsdataset.Fields.Field['PM_ID'].Value;
                }
            }
            cfcsdataset.MoveNext();
        }
        if (!flag) {
            if (confirm("处罚措施被引用不能直接删除,是否将其停用?")) {
                stopcfcs = tmp;
            } else {
                selBox(tmp);
                return false;
            }
        }
    }
    return true;
}

//循环将被引用的措施选项重新选中
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


//去全角半角空格
function delSpace(){
    ${'RDD_LAW_DEGREE'}.value = ${'RDD_LAW_DEGREE'}.value.trim();
    ${'RDD_CODE'}.value = ${'RDD_CODE'}.value.trim();
    ${'RDD_ILLEGAL_PLOT'}.value = ${'RDD_ILLEGAL_PLOT'}.value.trim();
    ${'RDD_UPPER'}.value = ${'RDD_UPPER'}.value.trim();
    ${'RDD_LOWER'}.value = ${'RDD_LOWER'}.value.trim();
    ${'RDD_BASEUNIT_DESC'}.value = ${'RDD_BASEUNIT_DESC'}.value.trim();
    ${'JDD_BASEUNIT'}.value = ${'JDD_BASEUNIT'}.value.trim();
    $("RDD_PUNISHMENT_STANDARDS").value = $("RDD_PUNISHMENT_STANDARDS").value.trim();
}
</script>

<!-- 提示：以下为页面DOM元素内容 -->
<DIV id=SKbillsheet style="visibility:hidden" toolbar="不带工具栏" BLONopen="setAuthority();init();showmoney();showjs();" contxml="<root><textarea><id>RDD_ILLEGAL_PLOT</id><id>RDD_PUNISHMENT_STANDARDS</id><id>RDD_PUNISHMENT_ADD</id></textarea><combobox><id>OL_ID</id></combobox><button><id>showAdd</id><id>saveBtn</id><id>closeBtn</id></button><text><id>RDD_LAW_DEGREE</id><id>RDD_CODE</id><id>RDD_UPPER</id><id>RDD_LOWER</id><id>RDD_BASEUNIT_DESC</id><id>JDD_BASEUNIT</id></text><dataset><id>cfcsdataset</id><id>zycldataset</id><id>zyclsavedataset</id><id>tempdataset</id></dataset></root>" billtaborder="<root><taborder>RDD_ILLEGAL_PLOT</taborder><taborder>RDD_PUNISHMENT_STANDARDS</taborder><taborder>OL_ID</taborder><taborder>saveBtn</taborder><taborder>closeBtn</taborder><taborder>RDD_LAW_DEGREE</taborder><taborder>RDD_CODE</taborder><taborder>RDD_UPPER</taborder><taborder>RDD_LOWER</taborder><taborder>RDD_BASEUNIT_DESC</taborder><taborder>JDD_BASEUNIT</taborder><taborder>RDD_PUNISHMENT_ADD</taborder><taborder>showAdd</taborder></root>" dj_sn="20100904105058984229" caption="自由裁量权" mkbh codeheader="BBB" entertype="修改" poswidth posheight controlno="SKButton:0;SKDBedit:0;checkbox:0;label:0;radio:0;listbox:0;textarea:2;combobox:1;password:0;upload:0;SKDBtext:0;chart:0;dbimg:0;img:0;SKBILLgrid:0;shape:0;tab:0;div:0;DsMain_field:0;a:0;button:3;text:5;hr:0;checkboxlist:0;radiolist:0;dropdownlist:0;grid:0;dataset:5;spin:0;excel:0;tree:0;ebshow:0;creatorSubForm:0;creator_div:0;ExtGrid:0;ExtUpload:0;ExtTree:0;Fusionchar:0" window="当前窗口" posleft postop keyfield isfile="否" OtherSave="否" idtype="1" testDbName="app_xzcf" creatorStyle="creatorBlue" BLONclose="UnLoadWebOffice();" creator_remark hasWorkflowButton="否" creator_elementAuthoritySwitch="否" creator_showAlert="否" creator_office_isBindForm="否" islog="否" isprotect="是" creator_csslib version="1.0" creator_pagination type="ZW" creatorType="20100902181525484338" jslib="fcsavedj.js&#13;&#10;fcbasecont.js&#13;&#10;selectdate.js&#13;&#10;~userfunc.js&#13;&#10;fcdate.js&#13;&#10;../../../ccapp/app_xzcf/js/common/Namespace.js&#13;&#10;../../../ccapp/app_xzcf/js/common/nsreg.js&#13;&#10;../../../ccapp/app_xzcf/js/common/Common.js&#13;&#10;../../../ccapp/app_xzcf/js/vo/ZyclVo.js&#13;&#10;../../../ccapp/app_xzcf/js/util/WorkflowUtil.js&#13;&#10;../../../ccapp/app_xzcf/js/business/Wfxw.js&#13;&#10;../../../ccapp/app_xzcf/js/dao/WfxwDao.js">

<TABLE class=Ctable cellSpacing=0 cellPadding=0 width="95%" align=center border=0>
   <TBODY>
      <TR>
         <TD class=taobox colSpan=4>编辑自由裁量权</TD>
      </TR>
      <TR>
         <TD class=c2>违法程度</TD>
         <TD><INPUT class=input_out id=RDD_LAW_DEGREE style="LEFT: 0px; WIDTH: 148px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() size=26 controltype="text" field="RDD_LAW_DEGREE" china="违法程度" dataset="zyclsavedataset"></TD>
         <TD class=c2>违法级别<FONT color=#ff0000>*</FONT></TD>
         <TD><DIV id=tm2008style><SELECT id=OL_ID style="LEFT: 0px; WIDTH: 120px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() sqltrans="%F4%D8%E6%D8%D4%F6Xrn%AC%A6%CC%A0%96Xr%94%AC%A6%CC%AA%90%A8%98Xrn%DA%F2%EC%E8Xrn%B6%90%CC%AC%9A%9A%98%AA%B4%98%CC%A6%98%BA%98%A6Xrn%EC%F2%D6%D8%F2Xrn%D2%u0100Xrn%AC%A6%CC%AC%B2%96%98%B2" controltype="combobox" tempvalue="-1" temptext="--请选择--" sql check="1"><OPTION value=-1 selected>--请选择--</OPTION></SELECT></DIV></TD>
      </TR>
      <TR>
         <TD class=c2>编码<FONT color=#ff0000>*</FONT></TD>
         <TD colSpan=3><INPUT class=input_out id=RDD_CODE style="LEFT: 0px; WIDTH: 148px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() size=26 controltype="text" field="RDD_CODE" china="违法编码" dataset="zyclsavedataset"></TD>
      </TR>
      <TR>
         <TD class=c2>违法情节<FONT color=#ff0000>*</FONT></TD>
         <TD colSpan=3><TEXTAREA class=input_out id=RDD_ILLEGAL_PLOT style="LEFT: 0px; WIDTH: 355px; POSITION: static; TOP: 0px; HEIGHT: 85px" onmovestart=moveStart() cols=70 controltype="textarea" field="RDD_ILLEGAL_PLOT" china="违法情节" dataset="zyclsavedataset" value="textarea1" induce="否"></TEXTAREA></TD>
      </TR>
      <TR>
         <TD class=c2>处罚对象</TD>
         <TD colSpan=3><DIV id=faren></DIV></TD>
      </TR>
      <TR>
         <TD class=c2>处罚措施<FONT color=#ff0000>*</FONT></TD>
         <TD colSpan=3><DIV id=cfcsBox><DIV id=tmpbox></DIV></DIV></TD>
      </TR>
      <TR>
         <TD class=c2>是否有金额</TD>
         <TD colSpan=3><INPUT onclick=showmoney() type=radio CHECKED value=1 name=RDD_ISVALUE>是<INPUT onclick=showmoney() type=radio value=0 name=RDD_ISVALUE>否</TD>
      </TR>
      <TR id=hasmoney>
         <TD class=c2><INPUT onclick=showjs() type=radio CHECKED value=1 name=RDD_ATTRI>金额<INPUT onclick=showjs() type=radio value=2 name=RDD_ATTRI>比例<FONT color=#ff0000>*</FONT></TD>
         <TD colSpan=3>上限<INPUT class=input_out id=RDD_UPPER style="LEFT: 0px; WIDTH: 110px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() onchange='bill_onclick("compoStandards()")' value=0 controltype="text"><SPAN id=dw1>元</SPAN>&nbsp;&nbsp;&nbsp;&nbsp;下限<INPUT class=input_out id=RDD_LOWER style="LEFT: 0px; WIDTH: 110px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() onchange='bill_onclick("compoStandards()")' value=0 controltype="text"><SPAN id=dw2>元</SPAN></TD>
      </TR>
      <TR id=bl style="DISPLAY: none">
         <TD class=c2>&nbsp;</TD>
         <TD colSpan=3><P>基数说明<INPUT class=input_out id=RDD_BASEUNIT_DESC style="LEFT: 0px; WIDTH: 306px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() size=53 controltype="text" field="RDD_BASEUNIT_DESC" china="基数说明" dataset="zyclsavedataset"></P><P>基数单位<INPUT class=input_out id=JDD_BASEUNIT style="LEFT: 0px; WIDTH: 110px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() onmouseout="this.className='input_out'" controltype="text" field="JDD_BASEUNIT" china="基数单位" dataset="zyclsavedataset"></P></TD>
      </TR>
      <TR>
         <TD class=c2>处罚标准描述</TD>
         <TD colSpan=3><TEXTAREA class=input_out id=RDD_PUNISHMENT_STANDARDS style="LEFT: 0px; WIDTH: 356px; POSITION: static; TOP: 0px; HEIGHT: 85px" onmovestart=moveStart() readOnly cols=71 controltype="textarea" value="textarea2" induce="否"></TEXTAREA><BUTTON id=showAdd style="LEFT: 0px; WIDTH: 61px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("showadd()")'>补充&gt;&gt;</BUTTON></TD>
      </TR>
      <TR id=supplement style="DISPLAY: none">
         <TD class=c2>处罚标准描述补充</TD>
         <TD colSpan=3><TEXTAREA class=input_out id=RDD_PUNISHMENT_ADD style="LEFT: 0px; WIDTH: 356px; POSITION: static; TOP: 0px; HEIGHT: 85px" onmovestart=moveStart() cols=71 controltype="textarea" value="textarea2" induce="否"></TEXTAREA></TD>
      </TR>
      <TR>
         <TD class=c2>状态</TD>
         <TD colSpan=3><INPUT type=radio CHECKED value=1 name=RDD_STATUS>有效<INPUT type=radio value=0 name=RDD_STATUS>无效<?xml:namespace prefix = fc /><fc:dataset id=cfcsdataset format="<fields><field><fieldname>PM_ID</fieldname><datatype>字符</datatype><displaylabel>处罚措施ID</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>NUM</fieldname><datatype>字符</datatype><displaylabel>统计数据</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field></fields>" onSetText='bill_ondatasetsettext("<dsid><PM_ID></PM_ID><NUM></NUM></dsid>")' onGetText='bill_ondatasetgettext("<dsid><PM_ID></PM_ID><NUM></NUM></dsid>")' onValid='bill_ondatasetvalid("<dsid><PM_ID></PM_ID><NUM></NUM></dsid>")' opensortno="1" temptable="TMP_DATASET4" multiResult="否"></fc:dataset></TD>
      </TR>
   </TBODY>
</TABLE>

<DIV align=center>
   <BUTTON class=button id=saveBtn style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("save()")'>保存</BUTTON>
   <BUTTON class=button id=closeBtn style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("CloseBill()")'>关闭</BUTTON>
</DIV>

<fc:dataset id=zycldataset format="<fields><field><fieldname>PM_ID</fieldname><datatype>字符</datatype><displaylabel>处罚措施ID</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>PM_NAME</fieldname><datatype>字符</datatype><displaylabel>处罚措施名称</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field></fields>" onSetText='bill_ondatasetsettext("<dsid><PM_ID></PM_ID><PM_NAME></PM_NAME></dsid>")' onGetText='bill_ondatasetgettext("<dsid><PM_ID></PM_ID><PM_NAME></PM_NAME></dsid>")' onValid='bill_ondatasetvalid("<dsid><PM_ID></PM_ID><PM_NAME></PM_NAME></dsid>")' opensortno="1" temptable="TMP_DATASET1" multiResult="是"></fc:dataset>

<fc:dataset id=zyclsavedataset format="<fields><field><fieldname>RDD_PUNISHMENT_STANDARDS</fieldname><datatype>字符</datatype><displaylabel>处罚标准</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>OL_ID</fieldname><datatype>字符</datatype><displaylabel>违法级别</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>RDD_CODE</fieldname><datatype>字符</datatype><displaylabel>违法编码</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>RDD_ILLEGAL_PLOT</fieldname><datatype>字符</datatype><displaylabel>违法情节</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>RDD_LAW_DEGREE</fieldname><datatype>字符</datatype><displaylabel>违法程度</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>RDD_OBJECT_TYPE</fieldname><datatype>字符</datatype><displaylabel>处罚对象</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>RDD_ISVALUE</fieldname><datatype>字符</datatype><displaylabel>是否有金额</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>RDD_ATTRI</fieldname><datatype>字符</datatype><displaylabel>取值规则</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>RDD_UPPER</fieldname><datatype>实数</datatype><displaylabel>比例上限</displaylabel><size>10</size><precision>2</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>RDD_LOWER</fieldname><datatype>实数</datatype><displaylabel>比例下限</displaylabel><size>10</size><precision>2</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>JDD_BASEUNIT</fieldname><datatype>字符</datatype><displaylabel>基数单位</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>RDD_BASEUNIT_DESC</fieldname><datatype>字符</datatype><displaylabel>基数说明</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>RDD_VALUE_UPPER</fieldname><datatype>字符</datatype><displaylabel>金额上限</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>RDD_VALUE_LOWER</fieldname><datatype>字符</datatype><displaylabel>金额下限</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>RDD_STATUS</fieldname><datatype>字符</datatype><displaylabel>状态</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field></fields>" onSetText='bill_ondatasetsettext("<dsid><RDD_PUNISHMENT_STANDARDS></RDD_PUNISHMENT_STANDARDS><OL_ID></OL_ID><RDD_CODE></RDD_CODE><RDD_ILLEGAL_PLOT></RDD_ILLEGAL_PLOT><RDD_LAW_DEGREE></RDD_LAW_DEGREE><RDD_OBJECT_TYPE></RDD_OBJECT_TYPE><RDD_ISVALUE></RDD_ISVALUE><RDD_ATTRI></RDD_ATTRI><RDD_UPPER></RDD_UPPER><RDD_LOWER></RDD_LOWER><JDD_BASEUNIT></JDD_BASEUNIT><RDD_BASEUNIT_DESC></RDD_BASEUNIT_DESC><RDD_VALUE_UPPER></RDD_VALUE_UPPER><RDD_VALUE_LOWER></RDD_VALUE_LOWER><RDD_STATUS></RDD_STATUS></dsid>")' onGetText='bill_ondatasetgettext("<dsid><RDD_PUNISHMENT_STANDARDS></RDD_PUNISHMENT_STANDARDS><OL_ID></OL_ID><RDD_CODE></RDD_CODE><RDD_ILLEGAL_PLOT></RDD_ILLEGAL_PLOT><RDD_LAW_DEGREE></RDD_LAW_DEGREE><RDD_OBJECT_TYPE></RDD_OBJECT_TYPE><RDD_ISVALUE></RDD_ISVALUE><RDD_ATTRI></RDD_ATTRI><RDD_UPPER></RDD_UPPER><RDD_LOWER></RDD_LOWER><JDD_BASEUNIT></JDD_BASEUNIT><RDD_BASEUNIT_DESC></RDD_BASEUNIT_DESC><RDD_VALUE_UPPER></RDD_VALUE_UPPER><RDD_VALUE_LOWER></RDD_VALUE_LOWER><RDD_STATUS></RDD_STATUS></dsid>")' onValid='bill_ondatasetvalid("<dsid><RDD_PUNISHMENT_STANDARDS></RDD_PUNISHMENT_STANDARDS><OL_ID></OL_ID><RDD_CODE></RDD_CODE><RDD_ILLEGAL_PLOT></RDD_ILLEGAL_PLOT><RDD_LAW_DEGREE></RDD_LAW_DEGREE><RDD_OBJECT_TYPE></RDD_OBJECT_TYPE><RDD_ISVALUE></RDD_ISVALUE><RDD_ATTRI></RDD_ATTRI><RDD_UPPER></RDD_UPPER><RDD_LOWER></RDD_LOWER><JDD_BASEUNIT></JDD_BASEUNIT><RDD_BASEUNIT_DESC></RDD_BASEUNIT_DESC><RDD_VALUE_UPPER></RDD_VALUE_UPPER><RDD_VALUE_LOWER></RDD_VALUE_LOWER><RDD_STATUS></RDD_STATUS></dsid>")' opensortno="1" temptable="TMP_DATASET2" multiResult="否"></fc:dataset>

<fc:dataset id=tempdataset format="<fields><field><fieldname>NUM</fieldname><datatype>字符</datatype><displaylabel>总数</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field></fields>" onSetText='bill_ondatasetsettext("<dsid><NUM></NUM></dsid>")' onGetText='bill_ondatasetgettext("<dsid><NUM></NUM></dsid>")' onValid='bill_ondatasetvalid("<dsid><NUM></NUM></dsid>")' opensortno="1" temptable="TMP_DATASET3" multiResult="否"></fc:dataset>
</DIV>
<div id='grid_tip'></div></body></html>
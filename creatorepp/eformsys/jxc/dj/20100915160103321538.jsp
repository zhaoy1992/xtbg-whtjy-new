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
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/util/DBUtil.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/util/DBUtil.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/common/Common.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/common/Common.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/util/DateUtil.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/util/DateUtil.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/vo/SimplyVo.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/vo/SimplyVo.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/business/Simply.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/business/Simply.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/dao/SimplyDao.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/dao/SimplyDao.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/util/WorkflowUtil.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/util/WorkflowUtil.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/util/FormUtil.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/util/FormUtil.js'></script>");
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
/**
 *模块：简易程序
 *作者：zefeng.yu
 *时间：2010-11-8
 *状态：update
 **/
var djbh = "<%=request.getParameter("djbh")%>"; 
var wft_id = "<%=request.getParameter("wft_id")%>";
var flag = "<%=request.getParameter("flag")%>";
var thisOneCaseType = "<%=request.getParameter("thisOneCaseType")%>";
var user_id = getSysElement("userid");
var tempBuId = "";

function init(){
    document.getElementById('bu_id').value="";
    document.getElementById('RMD_ID').value="";
    document.getElementById('ad_id').value="";
    $('WFT_ID').value=wft_id;
    initInfo();
    
}
/**
 *函数：initInfo
 *描述：初始化界面信息
 *作者：zefeng.yu
**/
function initInfo(){
    $('is_id').value = -1 ;
    $('ad_id').value = -1 ;
    $('CT_ID').value = -1 ;
    $('RMD_ID').value = -1 ;
    $('JD_LAW_DEGREE').value = -1 ;
    $('JD_BRIEF_OF_CASE').value = -1 ;
    if(!IsSpace(wft_id)){
        var sql =  Simply.findJYInfoBiz(wft_id);
        insertOrUpdateDateset.Open(sql);
        $('WFT_ID').value=wft_id;
        findEndCaseInfo();       
        offence_degree();
        wfaction();
        document.getElementById('NUM1').style.display = "none";
        document.getElementById('NUM2').style.display = "none";
        document.getElementById('NUM3').style.display = "none";
    } else {
        $("orTheLaw").style.display = "none";
        $("orRule").style.display = "none";
    }
}
//打开行政区划的选择
function openDivisionTree(){
    url = "../../../ccapp/app_xzcf/jsp/baseservice/chooseDivisionTree.jsp"; 
    window.showModalDialog(url,window, "dialogWidth=620px;dialogHeight=500px");
}

/**
 *函数：tiJiaoAndBaoCun
 *描述：提交和保存的函数
 *作者：zefeng.yu
**/
function tiJiaoAndBaoCun(status){
        var bu_id =$('BU_ID').value.trim(); 
        $('BU_ID').value = bu_id ;
        var simplyObj = new SimplyVo.simple() ;
        var simplyVo= DBUtil.getVoFromPage(simplyObj);//处罚事项实例类
         simplyVo.BU_ID = bu_id ;
        simplyVo.WFT_ID = $("WFT_ID").value;

        var litigantObj = new SimplyVo.litigant() ;
        var litigantVo = DBUtil.getVoFromPage(litigantObj) ; //当事人类
         var tmp = "" ;
        var temp = document.getElementsByName('RGLTT_ATTRI');
        for(var i=0 ; i<temp.length ; i++){
           if(temp[i].checked==true){
               tmp = temp[i].value ;
           }
        } 
        litigantVo.LTT_ATTRI = tmp ;
        
        var recordObj = new SimplyVo.record() ;
        var recordVo = DBUtil.getVoFromPage(recordObj) ; //违法记录类
         var rmdId = document.getElementById("RMD_ID");
        var aa = rmdId.options(rmdId.selectedIndex).text;
        recordVo.OR_NAME = aa ;
        
        recordVo.OR_THE_LAW = $("OR_THE_LAW").value;//执法依据
         recordVo.OR_THE_LAW2 = $("OR_THE_LAW2").value;//添加的执法依据
         recordVo.OR_RULE = $("OR_RULE").value;//处罚依据
         recordVo.OR_RULE2 = $("OR_RULE2").value;//添加的处罚依据             
         
        var detailObj = new SimplyVo.detail() ;
        var detailVo = DBUtil.getVoFromPage(detailObj) ; //裁量细则实例类
         detailVo.JD_EDIT_DATE = getNowTime();
         var rddTemp = Simply.findrddIdAndolIdBiz($('RMD_ID').value);  //裁量细则及违法级别二维数组
        var rddId = "" ; //裁量细则编号
         var olId = "" ; //违法级别编号
         for (var i = 0; i<rddTemp.length ; i++) {
             rddId = rddTemp[i][0];
             olId = rddTemp[i][1];
        }
        detailVo.RDD_ID = rddId ;
        detailVo.OL_ID = olId ;
                
        var PostilObj = new SimplyVo.Postil() ;
        var PostilVo = DBUtil.getVoFromPage(PostilObj) ; //批注类
         PostilVo.TP_POSTIL = "";
        PostilVo.TP_IMAGE = "";
        PostilVo.TP_SYS = "";
        PostilVo.TP_FW_NAME = "";
        PostilVo.TP_ES_NAME = "";
        PostilVo.TP_EMY_SET = "";
        PostilVo.SEGMENT_ID = "";
        PostilVo.TP_EMY = user_id;
        PostilVo.TP_STATUS = status;
        PostilVo.TP_SYSUNIT_NAME = $('BU_NAME').value ;
        PostilObj.TP_LEO_NAME = $("userNames").value;
        PostilObj.TP_LEO_ID = $("userIds").value;
 
        var listsObj = new SimplyVo.lists();
        var listsVo = DBUtil.getVoFromPage(listsObj); //执行明细类
        
         var judgeDetailObj = new SimplyVo.judgeDetail();
        var judgeDetailVo = DBUtil.getVoFromPage(judgeDetailObj) ; //违法行为与处罚措施与裁量细则类
         var pmId = Simply.findpmIdBiz($('RMD_ID').value);
        judgeDetailVo.PM_ID = pmId ;  
        
        var multiObj = new SimplyVo.multi();
        var multiVo = DBUtil.getVoFromPage(multiObj) ; //提交文档清单类
        
         var wfssVo = new SimplyVo.multi();//违法事实提交材料清单
         wfssVo.MD_BODY = $("wfssID").value;//违法事实内容
         if(IsSpace($('WFT_ID').value)){
            if(validate()){
                var v = Simply.saveDateManagerBiz(simplyVo,litigantVo,recordVo,
                detailVo,PostilVo,listsVo,judgeDetailVo,multiVo,wfssVo);
                if(v){
                    alert("保存成功");
                    $('WFT_ID').value = simplyVo.WFT_ID;
                    if(status == 1){
                        parent.window.location.href = "20100916091232930767.jsp";//简易程序查询列表
                       }
                }else{
                    alert("保存失败");
                }
            }
        }else{
            if(validate()){
                 var v = Simply.updateDataManagerBiz(simplyVo,litigantVo,recordVo,
                detailVo,PostilVo,listsVo,multiVo,wfssVo);
                if(v){
                    alert("保存成功");
                    if(status == 1){
                        parent.window.location.href = "20100916091232930767.jsp";//简易程序查询列表
                       }
                }else{
                    alert("保存失败");
                }
            }
        }
}

//当前服务器时间
function getNowTime(){
    return FormUtil.getServerDate();
}


//打开新证据按钮函数
function openNewProof(){
    if(IsSpace($('WFT_ID').value)){
        alert("请先保存之后再添加证据");
        return;
    } else {
        var tempPara="dialogWidth:800px;dialogHeight:350px;";
        var tempURL="20100928171808109374.jsp?wft_id="+wft_id ;
        showModalDialog(tempURL,"window",tempPara);
        reloadExtGrid();
    }
}


//附件上传按钮函数
/* 打开上传下载页面 */
function openUploadAndDownView(){
    var isAllowDelete = true ;
    var id = $('MD_ACCESSORIES_BODY').value;
    if(IsSpace(id)){
     id = DBUtil.getSeq('SEQ_LITIGANT_RD');
     $('MD_ACCESSORIES_BODY').value = id;
    }
    var allowAdd = true;
    var name = "app_xzcf";
    var viewAddr =getOpenUrlByDjid("20100920113019725484")+"&id="+id+"&allowDelete="+isAllowDelete+
             "&allowAdd="+allowAdd+"&mode_name="+name+"&djbh="+id +
             "&fileCount=10" ;
    var featrues = "dialogWidth:640px;dialogHeight:360px;center:yes;help:no;resizable:no;status:no;scroll:no";
    var rtn = window.showModalDialog(viewAddr,window,featrues); 
    return rtn ;
}

var flagLaw = 0;//默认为隐藏
function addTheLaw(){ //添加执法依据
    if(flagLaw == 0){//如果为隐藏
        $("orTheLaw").style.display = "";//展开
        flagLaw = 1;
    } else {
       $("orTheLaw").style.display = "none";//隐藏
        flagLaw = 0;
    } 
}

var flagRule = 0;//默认为隐藏
function addRule(){  //添加处罚依据
    if(flagRule == 0){//如果为隐藏
        $("orRule").style.display = "";//展开
        flagRule = 1;   
    } else {
       $("orRule").style.display = "none";//隐藏
        flagRule = 0;
    }
}

//界面元素的验证函数
function validate(){
    var flag = true;
    if(flag){
       flag = SValidator.validate(document.getElementById('WFT_APPLICATION_NUMBER').value, {
        CHECK_TYPE : "required",
        ARGUMENT : {placeholders : ["受理编号"]}
        }, true);
    }
    if (flag) {
        var reg=/[\u4E00-\u9FA5]+/g;
        if (reg.test($("WFT_APPLICATION_NUMBER").value)){
            flag = false;
            alert("案件受理编号不能包含汉字！");
        }            
    }
    
    if (flag) {
        flag = SValidator.validate(${'WFT_APPLICATION_NUMBER'}.value, {
            CHECK_TYPE : "maxlength",
            ARGUMENT : {placeholders : [20],maxlength : 20},
            MESSAGE : "受理编号最大不能超过{0}字符"
        }, true);
    }

      //案件来源
    if(flag){
        if($('IS_ID').value==-1){
            alert("请选择案件来源");
            return false ;
        }
    }
         //案件标题
    if(flag){
       flag = SValidator.validate(document.getElementById('WFT_TITLE').value, {
        CHECK_TYPE : "required",
        ARGUMENT : {placeholders : ["案件标题"]}
        }, true);
    }
    
    if (flag) {
        flag = SValidator.validate(${'WFT_TITLE'}.value, {
            CHECK_TYPE : "maxlength",
            ARGUMENT : {placeholders : [125],maxlength : 125},
            MESSAGE : "案件标题最大不能超过{0}字符"
        }, true);
    }

    
       //案件地址
    if(flag){
        if($('AD_ID').value == -1){
            alert("请选择案发地址");
            return false ;
        }
    }
    
    if (flag) {
        flag = SValidator.validate(${'WFT_ADDRESS'}.value, {
            CHECK_TYPE : "maxlength",
            ARGUMENT : {placeholders : [125],maxlength : 125},
            MESSAGE : "案件地址信息最大不能超过{0}字符"
        }, true);
    }
    
        
    //案发时间
    if(flag){
       flag = SValidator.validate(document.getElementById('WFT_DATE').value, {
        CHECK_TYPE : "required",
        ARGUMENT : {placeholders : ["案发时间"]}
        }, true);
    }
    //案发时间不能大于系统当前时间
    if(flag){
        var sysDate = DateUtil.getSysTime();
        var newDate = $('WFT_DATE').value ;
        flag = DateUtil.opinionStartTimeEndTime(newDate,sysDate);
        if(!flag){
            alert("案发时间不能大于系统当前时间");
            return false ;
        }
    }
    
    //受理时间
      if(flag){
       flag = SValidator.validate(document.getElementById('WFT_DATE_RETURN_RECEIVE').value, {
        CHECK_TYPE : "required",
        ARGUMENT : {placeholders : ["受理时间"]}
        }, true);
    }
    //受理时间不能大于系统时间
    if(flag){
        var sysDate = DateUtil.getSysTime();
        var newDate = $('WFT_DATE_RETURN_RECEIVE').value ;
        if(flag){
            flag = DateUtil.opinionStartTimeEndTime(newDate,sysDate);
            if(!flag){
                alert("受理时间不能大于系统当前时间");
                return false ;
            }
        }
    }
    //案发时间不能大于受理时间
    if(flag){
        var sysDate = $('WFT_DATE_RETURN_RECEIVE').value ;
        var newDate = $('WFT_DATE').value ;
        if(flag){
            flag = DateUtil.opinionStartTimeEndTime(newDate,sysDate);
            if(!flag){
                alert("案发时间不能大于受理时间");
                return false ;
            }
        }
    }

    //执法主体
    if(flag){
       flag = SValidator.validate(document.getElementById('BU_ID').value, {
        CHECK_TYPE : "required",
        ARGUMENT : {placeholders : ["执法主体"]}
        }, true);
    }

     
    //当事人/单位名称
    if(flag){
       flag = SValidator.validate(document.getElementById('LTT_NAME').value, {
        CHECK_TYPE : "required",
        ARGUMENT : {placeholders : ["当事人/单位名称"]}
        }, true);
    }
    
    //证件类型
    if(flag){
       if($('CT_ID').value==-1){
           alert("请选择证件类型");
           return false ;
       }
    }
    
    //违法行为名称
    if(flag){
        if($('RMD_ID').value == -1){
            alert("请选择违法行为名称");
            return false ;
        }
    }
    
    //违法情况
    if(flag){
       flag = SValidator.validate(document.getElementById('OR_BRIEF').value, {
        CHECK_TYPE : "required",
        ARGUMENT : {placeholders : ["违法情况"]}
        }, true);
    }
       //违法程度
    if(flag){
        if($('JD_LAW_DEGREE').value == -1){
            alert("请选择违法程度");
            return false ;
        }
    }
       //违法情节
    if(flag){
        if($('JD_BRIEF_OF_CASE').value == -1){
            alert("请选择违法情节");
            return false ;
        }
    }
        //违法事实
    if(flag){
        if(IsSpace($("wfssID").value)){
            alert("违法事实不能为空");
            flag = false;
        }
    }
    
       //罚款金额
    if(flag){
       flag = SValidator.validate(document.getElementById('wft_penalty_sum').value, {
        CHECK_TYPE : "required",
        ARGUMENT : {placeholders : ["罚款金额"]}
        }, true);
    }
    
  /*  if(flag){
        flag = SValidator.validate(${'WFT_PENALTY_SUM'}.value, {
            CHECK_TYPE : "integer",
            ARGUMENT : {placeholders : ["罚款金额"],length : 0}
        }, false);
    }
  */
  
    if(flag){
        if(isNaN(${'WFT_PENALTY_SUM'}.value)){   
            flag = false;  
             alert("罚款金额必须是数字");  
        } 
    }
    
    if(flag){
        if(Number(${'WFT_PENALTY_SUM'}.value) < 0){
            flag = false;
            alert("罚款金额不能小于零");
        }
    }
    
    //罚款凭证
    if(flag){
       flag = SValidator.validate(document.getElementById('EL_VOUCHER_NUMBER').value, {
        CHECK_TYPE : "required",
        ARGUMENT : {placeholders : ["处罚收据编号"]}
        }, true);
                    
    }
    
    if (flag) {
        flag = SValidator.validate(${'EL_VOUCHER_NUMBER'}.value, {
            CHECK_TYPE : "maxlength",
            ARGUMENT : {placeholders : [20],maxlength : 20},
            MESSAGE : "处罚收据编号最大不能超过{0}字符"
        }, true);
    }

    
    //执法人
    if(flag){
       flag = SValidator.validate(document.getElementById("userIds").value, {
        CHECK_TYPE : "required",
        ARGUMENT : {placeholders : ["执法人员"]}
        }, true);
                    
    }

      //处罚决定时间
    if(flag){
       flag = SValidator.validate(document.getElementById('EL_DATE').value, {
        CHECK_TYPE : "required",
        ARGUMENT : {placeholders : ["处罚决定时间"]}
        }, true);
    }
    
    if(flag){
        var sysDate = DateUtil.getSysTime();
        var newDate = $('EL_DATE').value ;
        if(flag){
            flag = DateUtil.opinionStartTimeEndTime(newDate,sysDate);
            if(!flag){
                alert("处罚决定时间不能大于系统当前时间");
                return false ;
            }
        }    
    }
    //受理时间不能大于处罚决定时间
    if(flag){
        var sysDate = $('EL_DATE').value ;
        var newDate = $('WFT_DATE_RETURN_RECEIVE').value ;
        if(flag){
            flag = DateUtil.opinionStartTimeEndTime(newDate,sysDate);
            if(!flag){
                alert("受理时间不能大于处罚决定时间");
                return false ;
            }
        }
    }

    return  flag;
}

//验证从简易程序列表所进界面元素
function validate2(){
    var flag = true ;
      //违法程度
    if(flag){
        if($('JD_LAW_DEGREE').value == -1){
            alert("请选择违法程度");
            return false ;
        }
    }
       //违法情节
    if(flag){
        if($('JD_BRIEF_OF_CASE').value == -1){
            alert("请选择违法情节");
            return false ;
        }
    }
       //罚款金额
    if(flag){
       flag = SValidator.validate(document.getElementById('wft_penalty_sum').value, {
        CHECK_TYPE : "required",
        ARGUMENT : {placeholders : ["罚款金额不能为空"]}
        }, true);
    }
    
   if (flag) {
        flag = SValidator.validate(${'WFT_PENALTY_SUM'}.value, {
            CHECK_TYPE : "integer",
            ARGUMENT : {placeholders : ["罚款金额"],length : 0}
        }, false);
    }

    
    //罚款凭证
    if(flag){
       flag = SValidator.validate(document.getElementById('EL_VOUCHER_NUMBER').value, {
        CHECK_TYPE : "required",
        ARGUMENT : {placeholders : ["处罚收据编号不能为空"]}
        }, true);
                    
    }
    
    if (flag) {
        flag = SValidator.validate(${'EL_VOUCHER_NUMBER'}.value, {
            CHECK_TYPE : "maxlength",
            ARGUMENT : {placeholders : [20],maxlength : 20},
            MESSAGE : "处罚收据编号最大不能超过{0}字符"
        }, true);
    }

    
    //执法人
    if(flag){
       flag = SValidator.validate(document.getElementById("userIds").value, {
        CHECK_TYPE : "required",
        ARGUMENT : {placeholders : ["执法人员不能为空"]}
        }, true);
                    
    }

      //处罚决定时间
    if(flag){
       flag = SValidator.validate(document.getElementById('EL_DATE').value, {
        CHECK_TYPE : "required",
        ARGUMENT : {placeholders : ["处罚决定时间不能为空"]}
        }, true);
    }
    
    if(flag){
        var sysDate = DateUtil.getSysTime();
        var newDate = $('EL_DATE').value ;
        if(flag){
            flag = DateUtil.opinionStartTimeEndTime(newDate,sysDate);
            if(!flag){
                alert("处罚决定时间不能大于系统当前时间");
                return false ;
            }
        }    
    }
    return  flag;

}


function isdigit(s)//判断金额
{
    var r,re;
    re = /\d*.{0,1}\d{1,2}/;
    r = s.match(re);
    return (r==s)?true:false;
}

function isdate(s)//判断日期格式
{
    var r,re;
    re = /\d{4}-\d{2}-\d{2}/;
    r = s.match(re);
    return (r==s)?true:false;
}

//执法主体变化违法行为也变化
function wfaction(){
    if($("BU_ID").value != tempBuId){
        var wfxwSql = Simply.initWfxwAction($("BU_ID").value);
        SqlCombo(document.getElementById("RMD_ID"),wfxwSql);    
    }
    
    /*var oOption = document.createElement("OPTION");
    document.getElementById("RMD_ID").options.add(oOption);
    oOption.innerText = "--请选择--";
    oOption.value = "-1";
    document.getElementById("RMD_ID").value = -1;*/
}

function  degree(){  //违法情节程度下拉菜单实际初始化函数
     var  offence_id=document.getElementById("RMD_ID").value;  //得到违法行为名称id 
    var obj=document.getElementById('JD_BRIEF_OF_CASE').options;//清空违法情节和违法程度下拉菜单
    if(obj!=null){
        var j=obj.length;
        var i=0;
        for( i=0;i<j;i++)
            obj.options.remove(0); 
            }
    obj=document.getElementById('JD_LAW_DEGREE').options;
    if(obj!=null){
        j=obj.length;
        for( i=0;i<j;i++)
            obj.options.remove(0); 
            }
    
    var  sql="select t.rdd_illegal_plot from ta_rule_dictionary_detail t where t.rmd_id="+offence_id;
    SqlCombo(document.getElementById('JD_BRIEF_OF_CASE'),sql) ;
    sql="select t.rdd_law_degree from ta_rule_dictionary_detail t  where t.rmd_id="+offence_id;
    SqlCombo(document.getElementById('JD_LAW_DEGREE'),sql) ;
    
}

function offence_degree(){   //违法行为下的违法情节和违法程度选择下拉菜单生成  违法依据和执法依据初始化
     var  offence_id=document.getElementById("RMD_ID").value;  //得到违法行为名称id 
     if (offence_id==-1) {
         document.getElementById("JD_LAW_DEGREE").options[0].innerText = "--请选择--";
         document.getElementById("JD_LAW_DEGREE").options[0].value = -1;
         document.getElementById("JD_BRIEF_OF_CASE").options[0].innerText = "--请选择--";
         document.getElementById("JD_BRIEF_OF_CASE").options[0].value = -1;
         $('OR_THE_LAW').value = "";
         $('OR_RULE').value = "";
         return false;
     }
     degree();
    
    //执法依据
    sql="select t.rmd_the_law from ta_rule_matter_dictionary t  where t.rmd_id="+offence_id;
    document.getElementById('OR_THE_LAW').value=SqlToField(sql);
    
    //处罚依据
    sql="select  t.rmd_rule from ta_rule_matter_dictionary t  where t.rmd_id="+offence_id;
    document.getElementById('OR_RULE').value=SqlToField(sql);
    
}

function close(){
    window.history.back();
}


function readOnly(){
    document.getElementById('wft_application_number').readOnly = true;
    document.getElementById('is_id').readOnly = true;
    document.getElementById('wft_title').readOnly = true;
    document.getElementById('ad_id').readOnly = true;
    document.getElementById('wft_address').readOnly = true;
    document.getElementById('wft_date').readOnly = true;
    document.getElementById('wft_date_return_receive').readOnly = true;
    document.getElementById('bu_id').readOnly = true;
    document.getElementById('wft_brief').readOnly = true;
    document.getElementById('LTT_ATTRI').readOnly = true;
    document.getElementById('LTT_NAME').readOnly = true;
    document.getElementById('CT_ID').readOnly = true;
    document.getElementById('LTT_CODE').readOnly = true;
    document.getElementById('LTT_CORPORATE_COMMISSARY').readOnly = true;
    document.getElementById('RMD_ID').readOnly = true;
    document.getElementById('OR_BRIEF').readOnly = true;
    //document.getElementById('OR_THE_LAW').readOnly = true;
    //document.getElementById('OR_RULE').readOnly = true;
    document.getElementById('JD_LAW_DEGREE').readOnly = true;
    document.getElementById('JD_BRIEF_OF_CASE').readOnly = true;
    document.getElementById('wft_penalty_sum').readOnly = true;
    document.getElementById('EL_VOUCHER_NUMBER').readOnly = true;
    document.getElementById('TP_EMY').readOnly = true;
    document.getElementById('EL_DATE').readOnly = true;

    document.getElementById("button4").style.display = "none";
    document.getElementById("button5").style.display = "none";
    document.getElementById("button8").style.display = "none";
    document.getElementById("button12").style.display = "none";
    document.getElementById("button10").style.display = "none";
    document.getElementById("button11").style.display = "none";
}

//打开执法主体的选择
function openOrgTree(){
    tempBuId = $("BU_ID").value;
    url = "../../../ccapp/app_xzcf/jsp/baseservice/chooseZfztResourseSingle.jsp";
    $("orgNames").value = $("BU_NAME").value ;
    $("orgIds").value = $("BU_ID").value ;
    var idTmp = $("BU_ID").value ;
    chooseUsers = window.showModalDialog(url,window, "dialogWidth=620px;dialogHeight=500px");
    $("BU_NAME").value = $("orgNames").value ;
    $("BU_ID").value  = $("orgIds").value ;
}


//打开执法人员的选择
function openUserTree(){
    if(IsSpace($("BU_ID").value)){
        alert("请先选择执法主体!");
        return false;
    }
    url = "../../../ccapp/app_xzcf/jsp/baseservice/chooseOrgLawUserTree.jsp?bu_id="+$("BU_ID").value;
    chooseUsers = window.showModalDialog(url,window, "dialogWidth=620px;dialogHeight=500px");
}
//打开行政区划的选择
function openDivisionTree(){
    url = "../../../ccapp/app_xzcf/jsp/baseservice/chooseDivisionTree.jsp"; 
    window.showModalDialog(url,window, "dialogWidth=620px;dialogHeight=500px");
}

//获取简易程序执法人员
function findEndCaseInfo(){
     var sql = Simply.findOpinionInfo(wft_id);
     var arr = DBUtil.getQueryArray(sql, 0, -1);
     $("userNames").value = arr[0][1];
     $("userIds").value = arr[0][0];
}

//当前服务器时间
function getNowTime(){
    return FormUtil.getServerDate();
}

</script>

<!-- 提示：以下为页面DOM元素内容 -->
<DIV id=SKbillsheet style="visibility:hidden" toolbar="不带工具栏" BLONopen="setAuthority();init();" contxml="<root><radio><id>LTT_ATTRI</id></radio><textarea><id>WFT_BRIEF</id><id>OR_BRIEF</id><id>wfssID</id><id>OR_THE_LAW</id><id>OR_THE_LAW2</id><id>OR_RULE</id><id>OR_RULE2</id><id>punishDetail</id></textarea><combobox><id>IS_ID</id><id>CT_ID</id><id>RMD_ID</id><id>JD_LAW_DEGREE</id><id>JD_BRIEF_OF_CASE</id></combobox><button><id>button4</id><id>button5</id><id>button13</id><id>button11</id><id>button12</id><id>button8</id><id>button10</id></button><text><id>WFT_APPLICATION_NUMBER</id><id>WFT_TITLE</id><id>AD_NAME</id><id>AD_ID</id><id>WFT_ADDRESS</id><id>WFT_DATE</id><id>BU_ID</id><id>ORG_ID</id><id>WFT_DATE_RETURN_RECEIVE</id><id>BU_NAME</id><id>orgNames</id><id>orgIds</id><id>LTT_NAME</id><id>LTT_CODE</id><id>LTT_CORPORATE_COMMISSARY</id><id>wfss_ID</id><id>WFT_PENALTY_SUM</id><id>EL_VOUCHER_NUMBER</id><id>userNames</id><id>EL_DATE</id><id>MD_ACCESSORIES_BODY</id><id>WFT_ID</id><id>userIds</id></text><dataset><id>detail</id><id>insertOrUpdateDateset</id></dataset></root>" billtaborder="<root><taborder>BU_ID</taborder><taborder>BU_NAME</taborder><taborder>ORG_ID</taborder><taborder>orgNames</taborder><taborder>orgIds</taborder><taborder>button4</taborder><taborder>AD_ID</taborder><taborder>AD_NAME</taborder><taborder>LTT_ATTRI</taborder><taborder>WFT_BRIEF</taborder><taborder>OR_BRIEF</taborder><taborder>wfssID</taborder><taborder>OR_THE_LAW</taborder><taborder>OR_THE_LAW2</taborder><taborder>OR_RULE</taborder><taborder>OR_RULE2</taborder><taborder>punishDetail</taborder><taborder>IS_ID</taborder><taborder>CT_ID</taborder><taborder>RMD_ID</taborder><taborder>JD_LAW_DEGREE</taborder><taborder>JD_BRIEF_OF_CASE</taborder><taborder>button5</taborder><taborder>button13</taborder><taborder>button11</taborder><taborder>button12</taborder><taborder>button8</taborder><taborder>button10</taborder><taborder>WFT_APPLICATION_NUMBER</taborder><taborder>WFT_TITLE</taborder><taborder>WFT_ADDRESS</taborder><taborder>WFT_DATE</taborder><taborder>WFT_DATE_RETURN_RECEIVE</taborder><taborder>LTT_NAME</taborder><taborder>LTT_CODE</taborder><taborder>LTT_CORPORATE_COMMISSARY</taborder><taborder>wfss_ID</taborder><taborder>WFT_PENALTY_SUM</taborder><taborder>EL_VOUCHER_NUMBER</taborder><taborder>userNames</taborder><taborder>EL_DATE</taborder><taborder>MD_ACCESSORIES_BODY</taborder><taborder>WFT_ID</taborder><taborder>userIds</taborder></root>" dj_sn="20100915160103321538" caption="简易程序" mkbh codeheader="BBB" entertype="修改" poswidth posheight controlno="SKButton:0;SKDBedit:0;checkbox:0;label:1;radio:1;listbox:1;textarea:9;combobox:11;password:0;upload:3;SKDBtext:0;chart:0;dbimg:0;img:0;SKBILLgrid:0;shape:0;tab:0;div:1;DsMain_field:0;a:0;button:13;text:29;hr:0;checkboxlist:0;radiolist:0;dropdownlist:0;grid:0;dataset:9;spin:0;excel:0;tree:0;ebshow:0;creatorSubForm:0;creator_div:0;ExtGrid:2;ExtUpload:1;ExtTree:0;Fusionchar:0" window="当前窗口" posleft postop keyfield="wft_id" isfile="否" OtherSave="否" idtype="2" testDbName="app_xzcf" creatorStyle="creatorBlue" BLONclose="UnLoadWebOffice();" creator_remark hasWorkflowButton="否" creator_elementAuthoritySwitch="否" creator_showAlert="否" creator_office_isBindForm="否" islog="否" isprotect="是" creator_csslib version="1.0" creator_pagination type="ZW" creatorType="20100902181244984828" jslib="fcbasecont.js&#13;&#10;selectdate.js&#13;&#10;~userfunc.js&#13;&#10;fcdate.js&#13;&#10;../../../ccapp/app_xzcf/js/common/Namespace.js&#13;&#10;../../../ccapp/app_xzcf/js/common/nsreg.js&#13;&#10;../../../ccapp/app_xzcf/js/util/DBUtil.js&#13;&#10;../../../ccapp/app_xzcf/js/common/Common.js&#13;&#10;../../../ccapp/app_xzcf/js/util/DateUtil.js&#13;&#10;../../../ccapp/app_xzcf/js/vo/SimplyVo.js&#13;&#10;../../../ccapp/app_xzcf/js/business/Simply.js&#13;&#10;../../../ccapp/app_xzcf/js/dao/SimplyDao.js&#13;&#10;../../../ccapp/app_xzcf/js/util/WorkflowUtil.js&#13;&#10;../../../ccapp/app_xzcf/js/util/FormUtil.js">

<TABLE cellSpacing=0 cellPadding=0 width="95%" align=center border=0>
   <TBODY>
      <TR>
         <TD>
            <TABLE class=Ctable id=NUM1 cellSpacing=0 cellPadding=0 width="100%" border=0>
               <TBODY>
                  <TR>
                     <TD class=taobox colSpan=4>简易程序案件信息</TD>
                     <TR>
                        <TD class=c2 width="15%">案件受理编号<SPAN style="COLOR: red">*</SPAN></TD>
                        <TD width="35%"><INPUT class=input_out id=WFT_APPLICATION_NUMBER style="LEFT: 0px; WIDTH: 60%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text" field="WFT_APPLICATION_NUMBER" china="受理编号" dataset="insertOrUpdateDateset"></TD>
                        <TD class=c2 width="15%">案件来源<SPAN style="COLOR: red">*</SPAN></TD>
                        <TD width="35%"><SELECT id=IS_ID style="LEFT: 0px; WIDTH: 60%; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() sqltrans="%F4%D8%E6%D8%D4%F6Xrn%A0%B4%CC%A0%96Xr%94%A0%B4%CC%AA%90%A8%98Xrn%DA%F2%EC%E8Xrn%B6%90%CC%A0%AA%9A%AC%CC%B4%AC%B8%B2%94%98Xrn%EC%F2%D6%D8%F2Xrn%D2%u0100Xrn%A0%B4%CC%AC%B2%96%98%B2" controltype="combobox" field="IS_ID" china="消息来源" dataset="insertOrUpdateDateset" tempvalue="-1" temptext="--请选择--" sql check="1"><OPTION value=-1 selected>--请选择--</OPTION></SELECT></TD>
                     </TR>
                     <TR>
                        <TD class=c2 width="15%">案件标题<SPAN style="COLOR: red">*</SPAN></TD>
                        <TD width="85%" colSpan=3><INPUT class=input_out id=WFT_TITLE style="LEFT: 0px; WIDTH: 24.5%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() size=42 controltype="text" field="WFT_TITLE" china="案件标题" dataset="insertOrUpdateDateset"></TD>
                     </TR>
                     <TR>
                        <TD class=c2 width="15%">案发地址<SPAN style="COLOR: red">*</SPAN></TD>
                        <TD width="35%" colSpan=3><INPUT class=input_image id=AD_NAME style="LEFT: 0px; WIDTH: 24.5%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=30 controltype="text" field="AD_NAME" china="行政区划名称" dataset="insertOrUpdateDateset" onclick='bill_onclick("openDivisionTree();")'><INPUT id=AD_ID style="DISPLAY: none; LEFT: 0px; WIDTH: 28px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() size=5 controltype="text" field="AD_ID" china="行业区划代码" dataset="insertOrUpdateDateset">&nbsp;<INPUT class=input_out id=WFT_ADDRESS style="LEFT: 0px; WIDTH: 59%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() size=85 controltype="text" field="WFT_ADDRESS" china="案件地址" dataset="insertOrUpdateDateset"></TD>
                     </TR>
                     <TR>
                        <TD class=c2 width="15%">案发时间<SPAN style="COLOR: red">*</SPAN></TD>
                        <TD width="35%" colSpan=3><INPUT class=its_out id=WFT_DATE style="LEFT: 0px; WIDTH: 24.5%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=28 controltype="text" field="WFT_DATE" china="案发时间" dataset="insertOrUpdateDateset" onclick='bill_onclick("SelectDate()")'><INPUT id=BU_ID style="DISPLAY: none; LEFT: 0px; WIDTH: 26px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=4 controltype="text" field="BU_ID" china="执法主体" dataset="insertOrUpdateDateset"><INPUT id=ORG_ID style="DISPLAY: none; LEFT: 0px; WIDTH: 26px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=4 controltype="text"></TD>
                     </TR>
                     <TR>
                        <TD class=c2 width="15%">受理时间<SPAN style="COLOR: red">*</SPAN></TD>
                        <TD width="35%"><INPUT class=its_out id=WFT_DATE_RETURN_RECEIVE style="LEFT: 0px; WIDTH: 60%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=69 name=Input controltype="text" field="WFT_DATE_RETURN_RECEIVE" china="受理时间" dataset="insertOrUpdateDateset" onclick='bill_onclick("SelectDate()")'></TD>
                        <TD class=c2 width="15%">执法主体<SPAN style="COLOR: red">*</SPAN></TD>
                        <TD vAlign=top width="35%"><INPUT class=input_image id=BU_NAME style="LEFT: 0px; WIDTH: 60%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" field="BU_NAME" china="执法主体名称" dataset="insertOrUpdateDateset" onclick='bill_onclick("openOrgTree();wfaction();")'><INPUT id=orgNames style="DISPLAY: none; LEFT: 0px; WIDTH: 42px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() size=7 controltype="text"><INPUT id=orgIds style="DISPLAY: none; LEFT: 0px; WIDTH: 51px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() size=7 controltype="text"></TD>
                     </TR>
                     <TR>
                        <TD class=c2 width="15%">简要案件内容</TD>
                        <TD width="85%" colSpan=3><TEXTAREA id=WFT_BRIEF style="LEFT: 0px; WIDTH: 83.5%; POSITION: static; TOP: 0px; HEIGHT: 111px" onmovestart=moveStart() cols=76 controltype="textarea" field="WFT_BRIEF" china="案件描述" dataset="insertOrUpdateDateset" value="textarea1" induce="否" algin="left"></TEXTAREA></TD>
                     </TR>
                  </TBODY>
               </TABLE>
            </TD>
         </TR>
         <TR>
            <TD>
               <TABLE class=Ctable id=NUM2 cellSpacing=0 cellPadding=0 width="100%" border=0>
                  <TBODY>
                     <TR>
                        <TD class=taobox colSpan=4>当事人(单位)信息</TD>
                     </TR>
                     <TR>
                        <TD class=c2 width="15%">当事人/单位</TD>
                        <TD width="35%"><FIELDSET id=LTT_ATTRI contentEditable=false style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; BORDER-LEFT: 0px; WIDTH: 60%; COLOR: #000000; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 18px" onmovestart=moveStart() controltype="radio" field="LTT_ATTRI" china="公民或法人" dataset="insertOrUpdateDateset" tempvalue="1&#13;&#10;2&#13;&#10;3" temptext="公民&#13;&#10;法人&#13;&#10;其他" aspect="横向" legend NotBg="否" value="1"><LEGEND></LEGEND><INPUT type=radio CHECKED value=1 name=RGLTT_ATTRI text="公民"><SPAN onclick=RGLTT_ATTRI[0].checked=true;LTT_ATTRI.value=RGLTT_ATTRI[0].value;RGLTT_ATTRI[0].focus();>公民</SPAN>&nbsp;<INPUT type=radio value=2 name=RGLTT_ATTRI text="法人"><SPAN onclick=RGLTT_ATTRI[1].checked=true;LTT_ATTRI.value=RGLTT_ATTRI[1].value;RGLTT_ATTRI[1].focus();>法人</SPAN>&nbsp;<INPUT type=radio value=3 name=RGLTT_ATTRI text="其他"><SPAN onclick=RGLTT_ATTRI[2].checked=true;LTT_ATTRI.value=RGLTT_ATTRI[2].value;RGLTT_ATTRI[2].focus();>其他</SPAN>&nbsp;</FIELDSET></TD>
                        <TD class=c2 width="15%">当事人/单位名称<SPAN style="COLOR: red">*</SPAN></TD>
                        <TD width="35%"><INPUT class=input_out id=LTT_NAME style="LEFT: 0px; WIDTH: 60%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() size=59 controltype="text" field="LTT_NAME" china="名称" dataset="insertOrUpdateDateset"></TD>
                     </TR>
                     <TR>
                        <TD class=c2 width="15%">证件类型<SPAN style="COLOR: red">*</SPAN></TD>
                        <TD width="35%"><SELECT id=CT_ID style="LEFT: 0px; WIDTH: 60%; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() sqltrans="%F4%D8%E6%D8%D4%F6Xrn%F6j%D4%F6%CC%E0%D6Xr%94%F6j%D4%F6%CC%EA%D0%E8%D8Xrn%DA%F2%EC%E8Xrn%F6%D0%CC%D4%D8%F2%F6%F6%u0100%EE%D8Xrn%F6" controltype="combobox" field="CT_ID" china="证件类型" dataset="insertOrUpdateDateset" tempvalue="-1" temptext="--请选择--" sql check="1"><OPTION value=-1 selected>--请选择--</OPTION></SELECT></TD>
                        <TD width="15%"></TD>
                        <TD width="35%"></TD>
                     </TR>
                     <TR>
                        <TD class=c2 width="15%">证件号码</TD>
                        <TD width="35%"><INPUT class=input_out id=LTT_CODE style="LEFT: 0px; WIDTH: 60%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() size=52 controltype="text" field="LTT_CODE" china="证件编号" dataset="insertOrUpdateDateset"></TD>
                        <TD class=c2 width="15%">法人代表</TD>
                        <TD width="35%"><INPUT class=input_out id=LTT_CORPORATE_COMMISSARY style="LEFT: 0px; WIDTH: 60%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() size=58 controltype="text" field="LTT_CORPORATE_COMMISSARY" china="法人代表" dataset="insertOrUpdateDateset"></TD>
                     </TR>
                  </TBODY>
               </TABLE>
            </TD>
         </TR>
         <TR>
            <TD>
               <TABLE class=Ctable id=NUM3 cellSpacing=0 cellPadding=0 width="100%" border=0>
                  <TBODY>
                     <TR>
                        <TD class=taobox colSpan=4>违法信息</TD>
                     </TR>
                     <TR>
                        <TD class=c2 width="15%">违法行为名称<SPAN style="COLOR: red">*</SPAN></TD>
                        <TD width="85%" colSpan=3><SELECT id=RMD_ID style="LEFT: 0px; WIDTH: 24%; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() onchange='bill_onclick("offence_degree()")' sqltrans controltype="combobox" field="RMD_ID" china="违法行为ID" dataset="insertOrUpdateDateset" tempvalue="-1" temptext="--请选择--" sql check="2"><OPTION value=-1 selected>--请选择--</OPTION></SELECT></TD>
                     </TR>
                     <TR>
                        <TD class=c2 width="15%">违法情况<SPAN style="COLOR: red">*</SPAN></TD>
                        <TD width="85%" colSpan=3><TEXTAREA id=OR_BRIEF style="LEFT: 0px; WIDTH: 83.5%; POSITION: static; TOP: 0px; HEIGHT: 85px" onmovestart=moveStart() cols=117 controltype="textarea" field="OR_BRIEF" china="违法情况" dataset="insertOrUpdateDateset" value="textarea3" induce="否"></TEXTAREA></TD>
                     </TR>
                  </TBODY>
               </TABLE>
            </TD>
         </TR>
         <TR>
            <TD>
               <TABLE class=Ctable cellSpacing=0 cellPadding=0 width="100%" border=0>
                  <TBODY>
                     <TR>
                        <TD class=taobox colSpan=4>处罚决定信息</TD>
                     </TR>
                     <TR>
                        <TD class=c2 width="15%">违法事实<SPAN style="COLOR: red">*</SPAN></TD>
                        <TD width="85%" colSpan=3><TEXTAREA id=wfssID style="LEFT: 0px; WIDTH: 83.5%; POSITION: static; TOP: 0px; HEIGHT: 85px" onmovestart=moveStart() controltype="textarea" value="textarea9" induce="否"></TEXTAREA><INPUT id=wfss_ID style="DISPLAY: none; LEFT: 0px; WIDTH: 110px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text"></TD>
                     </TR>
                     <TR>
                        <TD class=c2 width="15%">执法依据</TD>
                        <TD width="35%" colSpan=3><TEXTAREA id=OR_THE_LAW style="LEFT: 0px; WIDTH: 83.5%; POSITION: static; TOP: 0px; HEIGHT: 85px" onmovestart=moveStart() readOnly cols=117 controltype="textarea" field="OR_THE_LAW" china="执法依据" dataset="insertOrUpdateDateset" value="textarea4" induce="否"></TEXTAREA><BUTTON class=button id=button4 style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("addTheLaw()")'>添加执法依据</BUTTON></TD>
                     </TR>
                     <TR id=orTheLaw>
                        <TD class=c2 width="15%">&nbsp;</TD>
                        <TD width="35%" colSpan=3><TEXTAREA id=OR_THE_LAW2 style="LEFT: 0px; WIDTH: 83.5%; POSITION: static; TOP: 0px; HEIGHT: 72px" onmovestart=moveStart() rows=1 cols=117 controltype="textarea" value="textarea4" induce="否"></TEXTAREA></TD>
                     </TR>
                     <TR>
                        <TD class=c2 width="15%">处罚依据</TD>
                        <TD width="35%" colSpan=3><TEXTAREA id=OR_RULE style="LEFT: 0px; WIDTH: 83.5%; POSITION: static; TOP: 0px; HEIGHT: 83px" onmovestart=moveStart() rows=1 readOnly cols=117 controltype="textarea" field="OR_RULE" china="处罚依据" dataset="insertOrUpdateDateset" value="textarea5" induce="否"></TEXTAREA><BUTTON class=button id=button5 style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("addRule()")'>添加处罚依据</BUTTON></TD>
                     </TR>
                     <TR id=orRule>
                        <TD class=c2 width="15%">&nbsp;</TD>
                        <TD width="35%" colSpan=3><TEXTAREA id=OR_RULE2 style="LEFT: 0px; WIDTH: 83.5%; POSITION: static; TOP: 0px; HEIGHT: 56px" onmovestart=moveStart() rows=1 cols=117 controltype="textarea" value="textarea5" induce="否"></TEXTAREA></TD>
                     </TR>
                     <TR>
                        <TD class=c2 width="15%">违法程度<SPAN style="COLOR: red">*</SPAN></TD>
                        <TD width="35%"><SELECT id=JD_LAW_DEGREE style="LEFT: 0px; WIDTH: 60%; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() sqltrans="%F4%D8%E6%D8%D4%F6Xrn%F2%D6%D6%CC%E0%D6Xr%94%F2%D6%D6%CC%E6%D0%FC%CC%D6%D8%DC%F2%D8%D8Xrn%DA%F2%EC%E8Xrn%B6%90%CC%B2%B8%A6%98%CC%96%A0%94%B6%A0%AC%AA%90%B2%C0%CC%96%98%B6%90%A0%A6" controltype="combobox" field="JD_LAW_DEGREE" china="违法程度" dataset="insertOrUpdateDateset" tempvalue="-1" temptext="--请选择--" sql check="1"><OPTION value=-1 selected>--请选择--</OPTION></SELECT></TD>
                        <TD class=c2 width="15%">违法情节<SPAN style="COLOR: red">*</SPAN></TD>
                        <TD width="35%"><SELECT id=JD_BRIEF_OF_CASE style="LEFT: 0px; WIDTH: 60%; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() sqltrans="%F4%D8%E6%D8%D4%F6Xrn%F2%D6%D6%CC%E0%D6Xr%94%F2%D6%D6%CC%E0%E6%E6%D8%DC%D0%E6%CC%EE%E6%EC%F6Xrn%DA%F2%EC%E8Xrn%B6%90%CC%B2%B8%A6%98%CC%96%A0%94%B6%A0%AC%AA%90%B2%C0%CC%96%98%B6%90%A0%A6" controltype="combobox" field="JD_BRIEF_OF_CASE" china="违法情节" dataset="insertOrUpdateDateset" tempvalue="-1" temptext="--请选择--" sql check="1"><OPTION value=-1 selected>--请选择--</OPTION></SELECT></TD>
                     </TR>
                     <TR>
                        <TD class=c2 width="15%">处罚决定内容</TD>
                        <TD width="35%" colSpan=3><TEXTAREA id=punishDetail style="LEFT: 0px; WIDTH: 83.5%; POSITION: static; TOP: 0px; HEIGHT: 85px" onmovestart=moveStart() cols=88 controltype="textarea" field="MD_BODY" china="处罚决定内容" dataset="insertOrUpdateDateset" value="textarea2" induce="否"></TEXTAREA></TD>
                     </TR>
                     <TR>
                        <TD class=c2 width="15%">罚款金额<SPAN style="COLOR: red">*</SPAN></TD>
                        <TD width="35%"><INPUT class=input_out id=WFT_PENALTY_SUM style="LEFT: 0px; WIDTH: 60%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() size=28 controltype="text" field="WFT_PENALTY_SUM" china="罚款金额" dataset="insertOrUpdateDateset"></TD>
                        <TD class=c2 width="15%">处罚收据编号<SPAN style="COLOR: red">*</SPAN></TD>
                        <TD width="35%"><INPUT class=input_out id=EL_VOUCHER_NUMBER style="LEFT: 0px; WIDTH: 60%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() size=27 controltype="text" field="EL_VOUCHER_NUMBER" china="发票编号" dataset="insertOrUpdateDateset"></TD>
                     </TR>
                     <TR>
                        <TD class=c2 width="15%">执法人员<SPAN style="COLOR: red">*</SPAN></TD>
                        <TD width="35%"><INPUT class=input_image id=userNames style="LEFT: 0px; WIDTH: 60%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" onclick='bill_onclick("openUserTree();")'></TD>
                        <TD class=c2 width="15%">处罚决定时间<SPAN style="COLOR: red">*</SPAN></TD>
                        <TD width="35%"><INPUT class=its_out id=EL_DATE style="LEFT: 0px; WIDTH: 60%; POSITION: static; TOP: 0px" onmovestart=moveStart() readOnly size=29 controltype="text" field="EL_DATE" china="处罚日期" dataset="insertOrUpdateDateset" onclick='bill_onclick("SelectDate()")'></TD>
                     </TR>
                     <TR>
                        <TD class=c2 width="15%">处罚决定书上传</TD>
                        <TD width="85%" colSpan=3><BUTTON class=button id=button13 style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("openUploadAndDownView();")'>附件上传</BUTTON><INPUT id=MD_ACCESSORIES_BODY style="DISPLAY: none; LEFT: 0px; WIDTH: 110px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" field="MD_ACCESSORIES_BODY" china="材料体" dataset="insertOrUpdateDateset"></TD>
                     </TR>
                     <TR>
                        <TD class=c2 width="15%">添加证据信息</TD>
                        <TD width="85%" colSpan=3><BUTTON class=button id=button11 style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("openNewProof();")'>添加证据</BUTTON><INPUT id=WFT_ID style="DISPLAY: none; LEFT: 0px; WIDTH: 57px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=10 controltype="text" field="WFT_ID" china="处罚事项实例id" dataset="insertOrUpdateDateset"><INPUT id=userIds style="DISPLAY: none; LEFT: 0px; WIDTH: 46px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=8 controltype="text"></TD>
                     </TR>
                     <TR>
                        <TD align=middle width="100%" colSpan=4><BUTTON class=button id=button12 style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("tiJiaoAndBaoCun(0)")'>暂存</BUTTON><BUTTON class=button id=button8 style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("tiJiaoAndBaoCun(1)")'>提交</BUTTON><BUTTON class=button id=button10 style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("close()")'>关闭</BUTTON></TD>
                     </TR>
                  </TBODY>
               </TABLE>
            </TD>
         </TR>
         <TR>
            <TD>
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
   <?xml:namespace prefix = fc />
   <fc:dataset id=detail format="<fields><field><fieldname>RDD_ID</fieldname><datatype>字符</datatype><displaylabel>RDD_ID</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>OL_ID</fieldname><datatype>字符</datatype><displaylabel>OL_ID</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>RDD_ILLEGAL_PLOT</fieldname><datatype>字符</datatype><displaylabel>RDD_ILLEGAL_PLOT</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>RDD_LAW_DEGREE</fieldname><datatype>字符</datatype><displaylabel>RDD_LAW_DEGREE</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>RDD_ISVALUE</fieldname><datatype>字符</datatype><displaylabel>RDD_ISVALUE</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>RDD_ATTRI</fieldname><datatype>字符</datatype><displaylabel>RDD_ATTRI</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>RDD_UPPER</fieldname><datatype>字符</datatype><displaylabel>RDD_UPPER</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>RDD_LOWER</fieldname><datatype>字符</datatype><displaylabel>RDD_LOWER</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>RDD_BASEUNIT_DESC</fieldname><datatype>字符</datatype><displaylabel>RDD_BASEUNIT_DESC</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>RDD_VALUE_UPPER</fieldname><datatype>字符</datatype><displaylabel>RDD_VALUE_UPPER</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>RDD_VALUE_LOWER</fieldname><datatype>字符</datatype><displaylabel>RDD_VALUE_LOWER</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>JDD_BASEUNIT</fieldname><datatype>字符</datatype><displaylabel>JDD_BASEUNIT</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field></fields>" onSetText='bill_ondatasetsettext("<dsid><RDD_ID></RDD_ID><OL_ID></OL_ID><RDD_ILLEGAL_PLOT></RDD_ILLEGAL_PLOT><RDD_LAW_DEGREE></RDD_LAW_DEGREE><RDD_ISVALUE></RDD_ISVALUE><RDD_ATTRI></RDD_ATTRI><RDD_UPPER></RDD_UPPER><RDD_LOWER></RDD_LOWER><RDD_BASEUNIT_DESC></RDD_BASEUNIT_DESC><RDD_VALUE_UPPER></RDD_VALUE_UPPER><RDD_VALUE_LOWER></RDD_VALUE_LOWER><JDD_BASEUNIT></JDD_BASEUNIT></dsid>")' onGetText='bill_ondatasetgettext("<dsid><RDD_ID></RDD_ID><OL_ID></OL_ID><RDD_ILLEGAL_PLOT></RDD_ILLEGAL_PLOT><RDD_LAW_DEGREE></RDD_LAW_DEGREE><RDD_ISVALUE></RDD_ISVALUE><RDD_ATTRI></RDD_ATTRI><RDD_UPPER></RDD_UPPER><RDD_LOWER></RDD_LOWER><RDD_BASEUNIT_DESC></RDD_BASEUNIT_DESC><RDD_VALUE_UPPER></RDD_VALUE_UPPER><RDD_VALUE_LOWER></RDD_VALUE_LOWER><JDD_BASEUNIT></JDD_BASEUNIT></dsid>")' onValid='bill_ondatasetvalid("<dsid><RDD_ID></RDD_ID><OL_ID></OL_ID><RDD_ILLEGAL_PLOT></RDD_ILLEGAL_PLOT><RDD_LAW_DEGREE></RDD_LAW_DEGREE><RDD_ISVALUE></RDD_ISVALUE><RDD_ATTRI></RDD_ATTRI><RDD_UPPER></RDD_UPPER><RDD_LOWER></RDD_LOWER><RDD_BASEUNIT_DESC></RDD_BASEUNIT_DESC><RDD_VALUE_UPPER></RDD_VALUE_UPPER><RDD_VALUE_LOWER></RDD_VALUE_LOWER><JDD_BASEUNIT></JDD_BASEUNIT></dsid>")' opensortno="1" temptable="TMP_DATASET2" multiResult="否"></fc:dataset>
   <fc:dataset id=insertOrUpdateDateset format="<fields><field><fieldname>WFT_ID</fieldname><datatype>字符</datatype><displaylabel>处罚事项实例id</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>WFT_APPLICATION_NUMBER</fieldname><datatype>字符</datatype><displaylabel>受理编号</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>IS_ID</fieldname><datatype>字符</datatype><displaylabel>消息来源</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>WFT_TITLE</fieldname><datatype>字符</datatype><displaylabel>案件标题</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>AD_ID</fieldname><datatype>字符</datatype><displaylabel>行政区域</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>WFT_ADDRESS</fieldname><datatype>字符</datatype><displaylabel>案件地址</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>WFT_DATE</fieldname><datatype>字符</datatype><displaylabel>案发时间</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>WFT_DATE_RETURN_RECEIVE</fieldname><datatype>字符</datatype><displaylabel>受理时间</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>BU_ID</fieldname><datatype>字符</datatype><displaylabel>执法主体</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>WFT_BRIEF</fieldname><datatype>字符</datatype><displaylabel>案件描述</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>LTT_ID</fieldname><datatype>字符</datatype><displaylabel>当事人流水</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>LTT_ATTRI</fieldname><datatype>字符</datatype><displaylabel>公民或法人</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>LTT_NAME</fieldname><datatype>字符</datatype><displaylabel>名称</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>CT_ID</fieldname><datatype>字符</datatype><displaylabel>证件类型</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>LTT_CODE</fieldname><datatype>字符</datatype><displaylabel>证件编号</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>LTT_CORPORATE_COMMISSARY</fieldname><datatype>字符</datatype><displaylabel>法人代表</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>JD_ID</fieldname><datatype>字符</datatype><displaylabel>裁量细则流水</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>JD_BRIEF_OF_CASE</fieldname><datatype>字符</datatype><displaylabel>违法情节</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>JD_LAW_DEGREE</fieldname><datatype>字符</datatype><displaylabel>违法程度</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>OR_ID</fieldname><datatype>字符</datatype><displaylabel>违法记录流水</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>RMD_ID</fieldname><datatype>字符</datatype><displaylabel>违法行为ID</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>OR_NAME</fieldname><datatype>字符</datatype><displaylabel>违法行为名称</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>OR_THE_LAW</fieldname><datatype>字符</datatype><displaylabel>执法依据</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>OR_RULE</fieldname><datatype>字符</datatype><displaylabel>处罚依据</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>OR_BRIEF</fieldname><datatype>字符</datatype><displaylabel>违法情况</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>EL_ID</fieldname><datatype>字符</datatype><displaylabel>执行明细流水</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>EL_DATE</fieldname><datatype>字符</datatype><displaylabel>处罚日期</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>EL_VOUCHER_NUMBER</fieldname><datatype>字符</datatype><displaylabel>发票编号</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>WFT_PENALTY_SUM</fieldname><datatype>字符</datatype><displaylabel>罚款金额</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>MD_ID</fieldname><datatype>字符</datatype><displaylabel>材料清单流水</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>MD_BODY</fieldname><datatype>字符</datatype><displaylabel>处罚决定内容</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>TP_STATUS</fieldname><datatype>字符</datatype><displaylabel>存档还是草稿</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>TP_EMY</fieldname><datatype>字符</datatype><displaylabel>执法人</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>RMD_NAME</fieldname><datatype>字符</datatype><displaylabel>违法行为名称</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>WFT1_ID</fieldname><datatype>字符</datatype><displaylabel>处罚事项实例编号2</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>MD_ACCESSORIES_BODY</fieldname><datatype>字符</datatype><displaylabel>材料体</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>BU_NAME</fieldname><datatype>字符</datatype><displaylabel>执法主体名称</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>AD_NAME</fieldname><datatype>字符</datatype><displaylabel>行政区划名称</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field></fields>" onSetText='bill_ondatasetsettext("<dsid><WFT_ID></WFT_ID><WFT_APPLICATION_NUMBER></WFT_APPLICATION_NUMBER><IS_ID></IS_ID><WFT_TITLE></WFT_TITLE><AD_ID></AD_ID><WFT_ADDRESS></WFT_ADDRESS><WFT_DATE></WFT_DATE><WFT_DATE_RETURN_RECEIVE></WFT_DATE_RETURN_RECEIVE><BU_ID></BU_ID><WFT_BRIEF></WFT_BRIEF><LTT_ID></LTT_ID><LTT_ATTRI></LTT_ATTRI><LTT_NAME></LTT_NAME><CT_ID></CT_ID><LTT_CODE></LTT_CODE><LTT_CORPORATE_COMMISSARY></LTT_CORPORATE_COMMISSARY><JD_ID></JD_ID><JD_BRIEF_OF_CASE></JD_BRIEF_OF_CASE><JD_LAW_DEGREE></JD_LAW_DEGREE><OR_ID></OR_ID><RMD_ID></RMD_ID><OR_NAME></OR_NAME><OR_THE_LAW></OR_THE_LAW><OR_RULE></OR_RULE><OR_BRIEF></OR_BRIEF><EL_ID></EL_ID><EL_DATE></EL_DATE><EL_VOUCHER_NUMBER></EL_VOUCHER_NUMBER><WFT_PENALTY_SUM></WFT_PENALTY_SUM><MD_ID></MD_ID><MD_BODY></MD_BODY><TP_STATUS></TP_STATUS><TP_EMY></TP_EMY><RMD_NAME></RMD_NAME><WFT1_ID></WFT1_ID><MD_ACCESSORIES_BODY></MD_ACCESSORIES_BODY><BU_NAME></BU_NAME><AD_NAME></AD_NAME></dsid>")' onGetText='bill_ondatasetgettext("<dsid><WFT_ID></WFT_ID><WFT_APPLICATION_NUMBER></WFT_APPLICATION_NUMBER><IS_ID></IS_ID><WFT_TITLE></WFT_TITLE><AD_ID></AD_ID><WFT_ADDRESS></WFT_ADDRESS><WFT_DATE></WFT_DATE><WFT_DATE_RETURN_RECEIVE></WFT_DATE_RETURN_RECEIVE><BU_ID></BU_ID><WFT_BRIEF></WFT_BRIEF><LTT_ID></LTT_ID><LTT_ATTRI></LTT_ATTRI><LTT_NAME></LTT_NAME><CT_ID></CT_ID><LTT_CODE></LTT_CODE><LTT_CORPORATE_COMMISSARY></LTT_CORPORATE_COMMISSARY><JD_ID></JD_ID><JD_BRIEF_OF_CASE></JD_BRIEF_OF_CASE><JD_LAW_DEGREE></JD_LAW_DEGREE><OR_ID></OR_ID><RMD_ID></RMD_ID><OR_NAME></OR_NAME><OR_THE_LAW></OR_THE_LAW><OR_RULE></OR_RULE><OR_BRIEF></OR_BRIEF><EL_ID></EL_ID><EL_DATE></EL_DATE><EL_VOUCHER_NUMBER></EL_VOUCHER_NUMBER><WFT_PENALTY_SUM></WFT_PENALTY_SUM><MD_ID></MD_ID><MD_BODY></MD_BODY><TP_STATUS></TP_STATUS><TP_EMY></TP_EMY><RMD_NAME></RMD_NAME><WFT1_ID></WFT1_ID><MD_ACCESSORIES_BODY></MD_ACCESSORIES_BODY><BU_NAME></BU_NAME><AD_NAME></AD_NAME></dsid>")' onValid='bill_ondatasetvalid("<dsid><WFT_ID></WFT_ID><WFT_APPLICATION_NUMBER></WFT_APPLICATION_NUMBER><IS_ID></IS_ID><WFT_TITLE></WFT_TITLE><AD_ID></AD_ID><WFT_ADDRESS></WFT_ADDRESS><WFT_DATE></WFT_DATE><WFT_DATE_RETURN_RECEIVE></WFT_DATE_RETURN_RECEIVE><BU_ID></BU_ID><WFT_BRIEF></WFT_BRIEF><LTT_ID></LTT_ID><LTT_ATTRI></LTT_ATTRI><LTT_NAME></LTT_NAME><CT_ID></CT_ID><LTT_CODE></LTT_CODE><LTT_CORPORATE_COMMISSARY></LTT_CORPORATE_COMMISSARY><JD_ID></JD_ID><JD_BRIEF_OF_CASE></JD_BRIEF_OF_CASE><JD_LAW_DEGREE></JD_LAW_DEGREE><OR_ID></OR_ID><RMD_ID></RMD_ID><OR_NAME></OR_NAME><OR_THE_LAW></OR_THE_LAW><OR_RULE></OR_RULE><OR_BRIEF></OR_BRIEF><EL_ID></EL_ID><EL_DATE></EL_DATE><EL_VOUCHER_NUMBER></EL_VOUCHER_NUMBER><WFT_PENALTY_SUM></WFT_PENALTY_SUM><MD_ID></MD_ID><MD_BODY></MD_BODY><TP_STATUS></TP_STATUS><TP_EMY></TP_EMY><RMD_NAME></RMD_NAME><WFT1_ID></WFT1_ID><MD_ACCESSORIES_BODY></MD_ACCESSORIES_BODY><BU_NAME></BU_NAME><AD_NAME></AD_NAME></dsid>")' opensortno="1" temptable="TMP_DATASET5" multiResult="否"></fc:dataset>
</DIV>
<div id='grid_tip'></div></body></html>
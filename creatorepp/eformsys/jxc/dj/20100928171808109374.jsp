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
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/common/Common.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/common/Common.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/util/DateUtil.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/util/DateUtil.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/vo/EvidenceListVo.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/vo/EvidenceListVo.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/business/EvidenceList.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/business/EvidenceList.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/dao/EvidenceListDao.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/dao/EvidenceListDao.js'></script>");
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
//处罚事项实例编号的获取
var wftId = creator_getQueryString("WFT_ID");
//给处罚事项实例编号赋默认值
if(IsSpace(wftId)){
    wftId = 1 ;
}
//证据信息编号的获取
var elId = creator_getQueryString("EL_ID");
//初始化方法
function init(){
    //加载违法行为下拉列表
    var sql = "select t.or_id, trim(t1.rmd_name) rmd_name from TA_OFFENSE_RECORD t, " + 
             "TA_RULE_MATTER_DICTIONARY t1 where t.wft_id = " + wftId + 
             " and t.rmd_id = t1.rmd_id";
    if(!IsSpace(sql)){
        SqlCombo(WFXW_combox, sql);
    }
    if(IsSpace(elId)){//界面的显示数据的初始化
        $('MT_ID').value = -1 ;
        document.getElementById("AABB").innerText = "新增证据信息" ;
    }else{
         document.getElementById("AABB").innerText = "修改证据信息" ;
         var sql = EvidenceList.findEvidenceListByElid(elId);
         dataset1.Open(sql);
         $("WFXW_combox").value = dataset1.Fields.Field['OR_ID'].Value;
    }
    $("EL_ID").value = elId;
}

//保存按钮函数
function saveProof(){
    if(IsSpace($("EL_ID").value)){//如果证据流水为空，则进行新增证据信息
        if(validateProof()){
           var obj = new EvidenceListVo.Evidence() ;  //证据Vo
           var evidenceVo= DBUtil.getVoFromPage(obj);
           //evidenceVo.OR_ID = findIllegalId() ;//违法事实编号 
             evidenceVo.OR_ID = $("WFXW_combox").value;//违法记录ID 
             evidenceVo.EL_FORMAT = "" ; //格式
             evidenceVo.EL_DEL = 0 ; //删除
            var vr = EvidenceList.addEvidenceList(evidenceVo); //调用Biz方法
             if(vr){
                alert("保存成功");
                var elids = DBUtil.getSeq("SEQ_EVIDENCE_LIST")-1 ;
                $("EL_ID").value = elids ; 
            }else{
                alert("保存失败");
            }
       }
    }else{//根据证据流水号进行证据信息的修改
        if(validateProof()){
           var obj = new EvidenceListVo.Evidence() ;  //证据Vo
           var evidenceVo= DBUtil.getVoFromPage(obj);
           evidenceVo.EL_ID = $("EL_ID").value ;
           var vr = EvidenceList.updEvidenceList(evidenceVo);
           if(vr){
               alert("保存成功");
           }else{
               alert("保存失败");
           }
       }
    }
}

//查询违法事实编号
function findIllegalId(){
   var vr = EvidenceList.findIllegalId(wftId);
   return vr ;
}

//附件上传按钮函数
/* 打开上传下载页面 */
function openUploadAndDownView(){
    var isAllowDelete = true ;
    var id = $('EL_EVIDENCE_BODY').value;
    if(IsSpace(id)){
     id = DBUtil.getSeq('SEQ_LITIGANT_RD');
     $('EL_EVIDENCE_BODY').value = id;
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

//证据信息验证函数
function validateProof(){
    var flag = true;
    
    if(flag){
        if($("WFXW_combox").value == -1){
            alert("请选择违法行为");
            flag = false;
        }
    }
    
    if (flag) {
        if(${'MT_ID'}.value==-1){
            alert("请选择材料类型");
            return false ;
        }
    }
    
    if (flag) {
        flag = SValidator.validate(${'EL_DESCRIPTION'}.value, {
            CHECK_TYPE : "required",
            ARGUMENT : {placeholders : [${'EL_DESCRIPTION'}.value]},
            MESSAGE : "材料名称不能为空"
        }, true);
    }
    
    if (flag) {
        flag = SValidator.validate(${'EL_ACQUISITION_TIME'}.value, {
            CHECK_TYPE : "required",
            ARGUMENT : {placeholders : [${'EL_ACQUISITION_TIME'}.value]},
            MESSAGE : "采集时间不能为空"
        }, true);
    }
    
    if(flag){
        var newTime = ${'EL_ACQUISITION_TIME'}.value ;
        var sysTime = DateUtil.getSysTime();
        flag = DateUtil.opinionStartTimeEndTime(newTime,sysTime);
        if(!flag){
            alert("采集时间不能大于系统当前时间");
            return false ;
        }
    }
    
    if (flag) {
        flag = SValidator.validate(${'EL_NUM'}.value, {
            CHECK_TYPE : "required",
            ARGUMENT : {placeholders : [${'EL_NUM'}.value]},
            MESSAGE : "材料份数不能为空"
        }, true);
    }
    
    if (flag) {
        flag = SValidator.validate(${'EL_NUM'}.value, {
            CHECK_TYPE : "integer",
            ARGUMENT : {placeholders : ["材料份数"],length : 0}
        }, false);
    }  
    
    if (flag) {
        var reg = /^[1-9]\d*$/;
        if (!reg.test($("EL_NUM").value)) {
            alert("材料份数请输入正整数！");
            flag = false;
        }
    }
   return flag;
}
</script>

<!-- 提示：以下为页面DOM元素内容 -->
<DIV id=SKbillsheet style="visibility:hidden" toolbar="不带工具栏" BLONopen="setAuthority();init();" contxml="<root><textarea><id>EL_REMARK</id></textarea><combobox><id>WFXW_combox</id><id>MT_ID</id></combobox><button><id>button3</id><id>button1</id><id>button2</id></button><text><id>EL_DESCRIPTION</id><id>EL_ACQUISITION_TIME</id><id>EL_NUM</id><id>EL_EVIDENCE_BODY</id><id>EL_ID</id></text><dataset><id>dataset1</id></dataset></root>" billtaborder="<root><taborder>WFXW_combox</taborder><taborder>MT_ID</taborder><taborder>EL_DESCRIPTION</taborder><taborder>EL_ACQUISITION_TIME</taborder><taborder>EL_REMARK</taborder><taborder>EL_NUM</taborder><taborder>button3</taborder><taborder>button1</taborder><taborder>button2</taborder><taborder>EL_EVIDENCE_BODY</taborder><taborder>EL_ID</taborder></root>" dj_sn="20100928171808109374" caption="新增或者修改证据信息" mkbh codeheader="BBB" entertype="修改" poswidth posheight controlno="SKButton:0;SKDBedit:0;checkbox:0;label:0;radio:0;listbox:1;textarea:1;combobox:3;password:0;upload:0;SKDBtext:0;chart:0;dbimg:0;img:0;SKBILLgrid:0;shape:0;tab:0;div:0;DsMain_field:0;a:0;button:3;text:5;hr:0;checkboxlist:0;radiolist:0;dropdownlist:2;grid:0;dataset:1;spin:0;excel:0;tree:0;ebshow:0;creatorSubForm:0;creator_div:0;ExtGrid:1;ExtUpload:1;ExtTree:0;Fusionchar:0" window="当前窗口" posleft postop keyfield isfile="否" OtherSave="否" idtype="1" testDbName="app_xzcf" creatorStyle="creatorBlue" BLONclose="UnLoadWebOffice();" creator_remark hasWorkflowButton="否" creator_elementAuthoritySwitch="否" creator_showAlert="否" creator_office_isBindForm="否" islog="否" isprotect="是" creator_csslib version="1.0" creator_pagination type="ZW" creatorType="20100902181230265751" jslib="fcbasecont.js&#13;&#10;selectdate.js&#13;&#10;~userfunc.js&#13;&#10;fcdate.js&#13;&#10;../../../ccapp/app_xzcf/js/common/Namespace.js&#13;&#10;../../../ccapp/app_xzcf/js/common/nsreg.js&#13;&#10;../../../ccapp/app_xzcf/js/common/Common.js&#13;&#10;../../../ccapp/app_xzcf/js/util/DateUtil.js&#13;&#10;../../../ccapp/app_xzcf/js/vo/EvidenceListVo.js&#13;&#10;../../../ccapp/app_xzcf/js/business/EvidenceList.js&#13;&#10;../../../ccapp/app_xzcf/js/dao/EvidenceListDao.js">

<TABLE cellSpacing=0 cellPadding=0 width="95%" align=center border=0>
   <TBODY>
      <TR>
         <TD>
            <TABLE class=Ctable cellSpacing=0 cellPadding=0 width="100%" border=0>
               <TBODY>
                  <TR>
                     <TD class=taobox id=AABB colSpan=4></TD>
                  </TR>
                  <TR>
                     <TD class=c2 width="15%">违法行为<SPAN style="COLOR: red">*</SPAN></TD>
                     <TD width="35%"><SELECT id=WFXW_combox style="LEFT: 0px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() sqltrans controltype="combobox" field="OR_ID" china="违法记录流水" dataset="dataset1" tempvalue="-1" temptext="--请选择--" sql check="1"><OPTION value=-1 selected>--请选择--</OPTION></SELECT></TD>
                     <TD class=c2 width="15%">证据材料类型<SPAN style="COLOR: red">*</SPAN></TD>
                     <TD width="35%"><SELECT id=MT_ID style="LEFT: 0px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() name=select sqltrans="%F4%D8%E6%D8%D4%F6Xrn%A8%B6%CC%A0%96Xr%94%A8%B6%CC%AA%90%A8%98Xrn%DA%F2%EC%E8Xrn%F6%D0%CC%E8%D0%F6%D8%F2%E0%D0%E6%CC%F6%u0100%EE%D8Xrn%F6Xrn%AC%B2%96%98%B2Xrn%92%C0Xrn%A8%B6%CC%A0%96" controltype="combobox" field="MT_ID" china="证据材料类型" dataset="dataset1" tempvalue="-1" temptext="--请选择--" sql check="1"><OPTION value=-1 selected>--请选择--</OPTION></SELECT></TD>
                  </TR>
                  <TR>
                     <TD class=c2 width="15%">材料名称<SPAN style="COLOR: red">*</SPAN></TD>
                     <TD width="35%"><INPUT class=input_out id=EL_DESCRIPTION style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() name=Input controltype="text" field="EL_DESCRIPTION" china="材料名称" dataset="dataset1"></TD>
                     <TD class=c2 width="15%">采集时间<SPAN style="COLOR: red">*</SPAN></TD>
                     <TD><INPUT class=its_out id=EL_ACQUISITION_TIME style="LEFT: 0px; WIDTH: 120px; POSITION: static; TOP: 0px" onmovestart=moveStart() readOnly name=Input controltype="text" field="EL_ACQUISITION_TIME" china="采集时间" dataset="dataset1" onclick='bill_onclick("SelectDate()")'></TD>
                  </TR>
                  <TR>
                     <TD class=c2 width="15%">简要描述</TD>
                     <TD width="85%" colSpan=3><TEXTAREA id=EL_REMARK style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 85px" onmovestart=moveStart() name=textarea controltype="textarea" field="EL_REMARK" china="备注" dataset="dataset1" value="textarea1" induce="否"></TEXTAREA></TD>
                  </TR>
                  <TR>
                     <TD class=c2 width="15%">材料份数<SPAN style="COLOR: red">*</SPAN></TD>
                     <TD width="35%"><INPUT class=input_out id=EL_NUM style="LEFT: 0px; WIDTH: 90%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() name=Input controltype="text" field="EL_NUM" china="材料份数" dataset="dataset1">&nbsp;份</TD>
                     <TD width="50%" colSpan=2><BUTTON class=button id=button3 style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("openUploadAndDownView()")'>附件上传</BUTTON><INPUT id=EL_EVIDENCE_BODY style="DISPLAY: none; LEFT: 0px; WIDTH: 75px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=13 controltype="text" field="EL_EVIDENCE_BODY" china="文档体" dataset="dataset1"></TD>
                  </TR>
               </TBODY>
            </TABLE>
         </TD>
      </TR>
      <TR>
         <TD align=middle colSpan=2><BUTTON class=button id=button1 style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("saveProof()")'>保存</BUTTON><BUTTON class=button id=button2 style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("CloseBill()")'>关闭</BUTTON></TD>
      </TR>
      <TR>
         <TD colSpan=4>
            <TABLE cellSpacing=0 cellPadding=0 width=760 border=0>
               <TBODY>
                  <TR>
                     <TD><INPUT id=EL_ID style="DISPLAY: none; LEFT: 0px; WIDTH: 75px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() size=13 name=Input controltype="text" field="EL_ID" china="证据编号" dataset="dataset1"></TD>
                  </TR>
               </TBODY>
            </TABLE>
         </TD>
      </TR>
   </TBODY>
</TABLE>

<?xml:namespace prefix = fc />

<fc:dataset id=dataset1 format="<fields><field><fieldname>MT_ID</fieldname><datatype>字符</datatype><displaylabel>证据材料类型</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>EL_ACQUISITION_TIME</fieldname><datatype>字符</datatype><displaylabel>采集时间</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>EL_DESCRIPTION</fieldname><datatype>字符</datatype><displaylabel>材料名称</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>EL_REMARK</fieldname><datatype>字符</datatype><displaylabel>备注</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>EL_NUM</fieldname><datatype>字符</datatype><displaylabel>材料份数</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>OR_ID</fieldname><datatype>字符</datatype><displaylabel>违法记录流水</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>EL_ID</fieldname><datatype>字符</datatype><displaylabel>证据编号</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>EL_DSM</fieldname><datatype>字符</datatype><displaylabel>文档储存方式</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>EL_EVIDENCE_BODY</fieldname><datatype>字符</datatype><displaylabel>文档体</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field></fields>" onSetText='bill_ondatasetsettext("<dsid><MT_ID></MT_ID><EL_ACQUISITION_TIME></EL_ACQUISITION_TIME><EL_DESCRIPTION></EL_DESCRIPTION><EL_REMARK></EL_REMARK><EL_NUM></EL_NUM><OR_ID></OR_ID><EL_ID></EL_ID><EL_DSM></EL_DSM><EL_EVIDENCE_BODY></EL_EVIDENCE_BODY></dsid>")' onGetText='bill_ondatasetgettext("<dsid><MT_ID></MT_ID><EL_ACQUISITION_TIME></EL_ACQUISITION_TIME><EL_DESCRIPTION></EL_DESCRIPTION><EL_REMARK></EL_REMARK><EL_NUM></EL_NUM><OR_ID></OR_ID><EL_ID></EL_ID><EL_DSM></EL_DSM><EL_EVIDENCE_BODY></EL_EVIDENCE_BODY></dsid>")' onValid='bill_ondatasetvalid("<dsid><MT_ID></MT_ID><EL_ACQUISITION_TIME></EL_ACQUISITION_TIME><EL_DESCRIPTION></EL_DESCRIPTION><EL_REMARK></EL_REMARK><EL_NUM></EL_NUM><OR_ID></OR_ID><EL_ID></EL_ID><EL_DSM></EL_DSM><EL_EVIDENCE_BODY></EL_EVIDENCE_BODY></dsid>")' opensortno="1" temptable="TMP_DATASET1" multiResult="是"></fc:dataset>
</DIV>
<div id='grid_tip'></div></body></html>
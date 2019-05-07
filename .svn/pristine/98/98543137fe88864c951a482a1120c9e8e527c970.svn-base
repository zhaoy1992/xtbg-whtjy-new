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
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/common/Common.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/common/Common.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/business/PunishInsConfig.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/business/PunishInsConfig.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/dao/PunishInsConfigDao.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/dao/PunishInsConfigDao.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/vo/PunishInsConfigVo.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/vo/PunishInsConfigVo.js'></script>");
if(!bDgMode) out.println("</script>");
%>

   <script >document.styleSheets[0].addRule("fc\\:dataset","behavior: url(../../fceform/htc/dataset.htc)",0);</script>
   <script language='javascript'>
adv_loadjsfile('/eformsys/fceform/css/tabstyle.css');
adv_loadjsfile('/eformsys/fceform/css/Button.css');
adv_loadjsfile('/eformsys/fceform/css/TextStyle.css');
adv_loadjsfile('/eformsys/fceform/js/fcdataset.js');
</script>


<!-- 提示：以下为页面自定义JS内容 -->
<script>
var rflId = 0;
var buId = creator_getQueryString("buId");
var buName = creator_getQueryString("buName");
var USER_ID = getSysElement("userid");
var word_id = 0;

function init(){
    document.getElementById("zfztName").innerHTML = buName;
    document.getElementById("wsName").style.display="none";
    document.getElementById("wsBrief").style.display="none";
    document.getElementById("issueNeed").style.display = "none";
    $("preView").style.display="none";
    var tableObj = document.getElementById("stageTable");
    var sqlArray = PunishInsConfig.getIssueStage(rflId);
    for (var i = 0; i < sqlArray.length; i++) {
        var rowObj = tableObj.insertRow();//创建一行
         var cell0 = rowObj.insertCell();//创建一个单元
         cell0.innerHTML = sqlArray[i][1];
        
        var cell1 = rowObj.insertCell();//创建一个单元
         var readTmp = document.createElement("<INPUT TYPE='CHECKBOX' NAME='ISREAD' CHECKED VALUE='"+sqlArray[i][0]+"'>");
        cell1.appendChild(readTmp);
         
        var cell2 = rowObj.insertCell();//创建一个单元
         var editTmp = document.createElement("<INPUT TYPE='CHECKBOX' NAME='ISEDIT' VALUE='"+sqlArray[i][0]+"'>");
        cell2.appendChild(editTmp);
         
        var cell3 = rowObj.insertCell();//创建一个单元
         var isValid = document.createElement("<INPUT TYPE='CHECKBOX' NAME='ISVALID' CHECKED VALUE='"+sqlArray[i][0]+"'>");
        cell3.appendChild(isValid);
    }
}

//事项配置
function piLoad(){
    if (!IsSpace(buName)) {
        var tempPara="dialogWidth:760px;dialogHeight:400px;";
        var tempURL="20101013144720390036.jsp?USER_ID="+USER_ID+"&BU_ID="+buId;
        var rtn = showModalDialog(tempURL,window,tempPara);
        if (!IsSpace(rtn)) {
            document.getElementById("PI_NAME").value = rtn.names;
            document.getElementById("PI_ID").value = rtn.ids; 
        }
    } else {
        alert("当前尚无执法主体!");
        return false;
    }
}


//配置方式
function showCom(){
    var conf = document.getElementsByName("CONFIG_TYPE");
    if (conf[0].checked) {    
        document.getElementById("issueNeed").style.display = "none";
    } else {    
        document.getElementById("issueNeed").style.display = "";
    }
}

//返回
function rtnBack(){
    history.back(-1);
}

//选择文书
function wordSel(){
    var tempPara="dialogWidth:760px;dialogHeight:500px;";
    var tempURL="20101213155612812145.jsp?bu_id="+buId;
    var wsObj = showModalDialog(tempURL,window,tempPara);
    if (!IsSpace(wsObj)) {
        rflId = wsObj.rfl_id;
        document.getElementById("wsName").style.display="";
        document.getElementById("wsBrief").style.display="";
        $("preView").style.display="";
        document.getElementById("rflName").innerHTML = wsObj.rfl_name;
        document.getElementById("rflBriefName").innerHTML = wsObj.rfl_brief_name;
        word_id = wsObj.mb_id;
        $("preView").style.display="";        
    }    
}

//预览word文档
function preMb() {
    var url = "../../../eformsys/jxc/dj/20101124143257625133.jsp?mb_id="+word_id;
    var height = window.screen.availHeight;
    var width = window.screen.availWidth;
    var tempPara="dialogWidth:"+width+"px;dialogHeight:"+height+"px;";
    window.open(url,'newwindow','height=768px,width=1250px,top=0,left=0,toolbar=no,menubar=no,scrollbars=no,resizable=no,location=no,status=no')
}

function validate(){
    var conf = document.getElementsByName("CONFIG_TYPE");//配置方式
     var flag = true;
    if (flag) {
        if (rflId==0 || IsSpace(rflId)) {
            alert("请选择文书!");
            flag = false;
        }
    }
    if (flag) {
        if(word_id==0){
            alert("当前文书尚无WORD模板，请重新选择!");
            flag = false;
        }    
    }
    if (conf[1].checked) {
        if (flag) {
            flag = SValidator.validate($("PI_NAME").value, {
                CHECK_TYPE : "required",
                ARGUMENT : {placeholders : [$("PI_NAME").value]},
                MESSAGE : "配置事项不能为空!"
            }, true);
        }
    }
    return flag;
}

//保存
function save(){
    if (validate()) {
        var obj = new PunishInsConfigVo.PunishInsConfig();
        var vo = DBUtil.getVoFromPage(obj);
        vo.RFL_ID = rflId;
        vo.BU_ID = buId;
        var arr = stageConfig();
        if (arr.length==0) {
            alert("至少选择一个环节有效!");
            return false;
        }
        var confType = document.getElementsByName("CONFIG_TYPE");//配置方式
         if (confType[0].checked) {
            vo.CONF_TYPE=1;
        } else if (confType[1].checked) {
            vo.CONF_TYPE=2;
        }
        var rv = PunishInsConfig.saveSelPunishConfig(vo, arr);
        if (rv) {
            alert("保存数据信息成功！");
        } else {
            alert("保存数据信息失败！");
        }
    }
}

//获取阶段配置
function stageConfig(){
    var validTmp = document.getElementsByName("ISVALID");
    var editTmp = document.getElementsByName("ISEDIT");
    var list = new Array();
    var k = 0;
    var str = "";
    for (var i=0;i<validTmp.length;i++) {
        if (validTmp[i].checked) {
            k =0 ;
            if (editTmp[i].checked) {
                k = 1; 
            }
            str = validTmp[i].value + "_" + k;
            list.add(str);
        }
    }
    return list;
}
</script>

<!-- 提示：以下为页面DOM元素内容 -->
<DIV id=SKbillsheet style="visibility:hidden" toolbar="不带工具栏" BLONopen="setAuthority();init();" contxml="<root><button><id>selWord</id><id>preView</id><id>saveBtn</id><id>clsBtn</id></button><text><id>PI_NAME</id><id>PI_ID</id></text><dataset><id>wsSaveDataset</id></dataset></root>" billtaborder="<root><taborder>selWord</taborder><taborder>preView</taborder><taborder>saveBtn</taborder><taborder>clsBtn</taborder><taborder>PI_NAME</taborder><taborder>PI_ID</taborder></root>" dj_sn="20101213151728671768" caption="选择文书配置" mkbh codeheader="BBB" entertype="修改" poswidth posheight controlno="SKButton:0;SKDBedit:0;checkbox:0;label:0;radio:0;listbox:0;textarea:0;combobox:0;password:0;upload:0;SKDBtext:0;chart:0;dbimg:0;img:0;SKBILLgrid:0;shape:0;tab:0;div:0;DsMain_field:0;a:0;button:0;text:0;hr:0;checkboxlist:0;radiolist:0;dropdownlist:0;grid:0;dataset:0;spin:0;excel:0;tree:0;ebshow:0;creatorSubForm:0;creator_div:0;ExtGrid:0;ExtUpload:0;ExtTree:0;Fusionchar:0" window="当前窗口" posleft postop keyfield isfile="否" OtherSave="否" idtype="1" testDbName="app_xzcf" creatorStyle="creatorBlue" BLONclose="UnLoadWebOffice();" creator_remark hasWorkflowButton="否" creator_elementAuthoritySwitch="否" creator_showAlert="否" creator_office_isBindForm="否" islog="否" isprotect="是" creator_csslib version="1.0" creator_pagination type="ZW" creatorType="20101117093013703020" jslib="fcbasecont.js&#13;&#10;selectdate.js&#13;&#10;~userfunc.js&#13;&#10;fcdate.js&#13;&#10;../../../ccapp/app_xzcf/js/common/Common.js&#13;&#10;../../../ccapp/app_xzcf/js/business/PunishInsConfig.js&#13;&#10;../../../ccapp/app_xzcf/js/dao/PunishInsConfigDao.js&#13;&#10;../../../ccapp/app_xzcf/js/vo/PunishInsConfigVo.js">

<TABLE cellSpacing=0 cellPadding=0 width="100%" align=center border=0>
   <TBODY>
      <TR>
         <TD>
            <TABLE class=Ctable cellSpacing=0 cellPadding=0 width="100%" align=center border=0>
               <TBODY>
                  <TR>
                     <TD class=taobox id=formTitleId colSpan=4>选择文书配置</TD>
                  </TR>
                  <TR>
                     <TD class=c2>执法主体</TD>
                     <TD><SPAN id=zfztName></SPAN>&nbsp;</TD>
                  </TR>
                  <TR id=wsName>
                     <TD class=c2>文书名称</TD>
                     <TD><SPAN id=rflName></SPAN></TD>
                  </TR>
                  <TR id=wsBrief>
                     <TD class=c2>文书简称</TD>
                     <TD><SPAN id=rflBriefName></SPAN></TD>
                  </TR>
                  <TR>
                     <TD class=c2>选择文书<FONT color=red>*</FONT></TD>
                     <TD><BUTTON id=selWord style="LEFT: 0px; WIDTH: 106px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("wordSel()")'>选择文书</BUTTON><BUTTON id=preView style="LEFT: 0px; WIDTH: 84px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("preMb()")'>预览</BUTTON></TD>
                  </TR>
                  <TR style="DISPLAY: none">
                     <TD class=c2>是否启用</TD>
                     <TD colSpan=3><INPUT type=radio CHECKED value=1 name=IS_STATUS>是<INPUT type=radio value=0 name=IS_STATUS>否</TD>
                  </TR>
                  <TR id=isConfig>
                     <TD class=c2>配置方式</TD>
                     <TD><SPAN id=com0><SPAN id=com1><INPUT onclick=showCom() type=radio CHECKED value=1 name=CONFIG_TYPE>阶段配置</SPAN><SPAN id=com2><INPUT onclick=showCom() type=radio value=2 name=CONFIG_TYPE>事项与阶段配置</SPAN></SPAN></TD>
                  </TR>
                  <TR id=issueNeed>
                     <TD class=c2>配置事项</TD>
                     <TD><INPUT class=input_out id=PI_NAME style="LEFT: 0px; WIDTH: 298px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=10 controltype="text" onclick='bill_onclick("piLoad()")'><INPUT id=PI_ID style="DISPLAY: none; LEFT: 0px; WIDTH: 38px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=6 controltype="text"></TD>
                  </TR>
               </TBODY>
            </TABLE>
            <?xml:namespace prefix = fc />
            <fc:dataset id=wsSaveDataset format="<fields><field><fieldname>MB_ID</fieldname><datatype>字符</datatype><displaylabel>word模板ID</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>RFL_NAME</fieldname><datatype>字符</datatype><displaylabel>文书名称</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>RFL_BRIEF_NAME</fieldname><datatype>字符</datatype><displaylabel>文书简称</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>RFL_STATUS</fieldname><datatype>字符</datatype><displaylabel>是否启用</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>DOA_ID</fieldname><datatype>字符</datatype><displaylabel>文档属性ID</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>MB_MC</fieldname><datatype>字符</datatype><displaylabel>模板名称</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>RFL_ISRELEASE_DOCUMENT</fieldname><datatype>字符</datatype><displaylabel>是否发布</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field></fields>" onSetText='bill_ondatasetsettext("<dsid><MB_ID></MB_ID><RFL_NAME></RFL_NAME><RFL_BRIEF_NAME></RFL_BRIEF_NAME><RFL_STATUS></RFL_STATUS><DOA_ID></DOA_ID><MB_MC></MB_MC><RFL_ISRELEASE_DOCUMENT></RFL_ISRELEASE_DOCUMENT></dsid>")' onGetText='bill_ondatasetgettext("<dsid><MB_ID></MB_ID><RFL_NAME></RFL_NAME><RFL_BRIEF_NAME></RFL_BRIEF_NAME><RFL_STATUS></RFL_STATUS><DOA_ID></DOA_ID><MB_MC></MB_MC><RFL_ISRELEASE_DOCUMENT></RFL_ISRELEASE_DOCUMENT></dsid>")' onValid='bill_ondatasetvalid("<dsid><MB_ID></MB_ID><RFL_NAME></RFL_NAME><RFL_BRIEF_NAME></RFL_BRIEF_NAME><RFL_STATUS></RFL_STATUS><DOA_ID></DOA_ID><MB_MC></MB_MC><RFL_ISRELEASE_DOCUMENT></RFL_ISRELEASE_DOCUMENT></dsid>")' opensortno="1" temptable="TMP_DATASET1" multiResult="否"></fc:dataset>
         </TD>
      </TR>
      <TR>
         <TD>
            <TABLE class=Ctable id=stageTable cellSpacing=0 cellPadding=0 width="100%" align=center border=0>
               <TBODY>
                  <TR>
                     <TD class=c2>环节名称</TD>
                     <TD class=c2>只读</TD>
                     <TD class=c2>编辑</TD>
                     <TD class=c2>是否有效</TD>
                  </TR>
               </TBODY>
            </TABLE>
         </TD>
      </TR>
      <TR>
         <TD align=middle colSpan=4><BUTTON class=button id=saveBtn style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("save()")'>保存</BUTTON><BUTTON class=button id=clsBtn style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("rtnBack()")'>返回</BUTTON></TD>
      </TR>
   </TBODY>
</TABLE>
</DIV>
<div id='grid_tip'></div></body></html>
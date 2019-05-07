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
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/dao/PunishPermissionDao.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/dao/PunishPermissionDao.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/business/PunishPermission.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/business/PunishPermission.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/util/DBUtil.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/util/DBUtil.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/util/WorkflowUtil.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/util/WorkflowUtil.js'></script>");
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
var buId = creator_getQueryString("buId");
var buName = creator_getQueryString("buName");
var userId = creator_getQueryString("userId");
var userName = creator_getQueryString("userName");

//初始化
function init(){
    $("zfzt_name").innerHTML = buName;
    $("user_name").innerHTML = userName;
    $("BU_ID").value = buId ;
    $("USER_ID").value = userId ;
    var tableObj = document.getElementById("stageTable");
    var sql = PunishPermission.queryPunishes(buId);
    var sqlArray = DBUtil.getQueryArray(sql, 0, -1);
    for (var i = 0; i < sqlArray.length; i++) {
        var rowObj = tableObj.insertRow();//创建一行
         var cell0 = rowObj.insertCell();//创建一个单元
         var piValue = sqlArray[i][0];
        cell0.id = "td_"+sqlArray[i][0];
        cell0.innerHTML = "+";
        cell0.align="center";
        cell0.style.cursor = "hand";
        cell0.onclick=function()
        {
            var trStage = document.getElementById("tr_"+this.id.split("_")[1]);
            if (this.innerHTML=="+") {                
                for (var n=0; n<sqlArray.length; n++) {
                    var trTmp = document.getElementById("tr_"+sqlArray[n][0]);
                    var tdTmp = document.getElementById("td_"+sqlArray[n][0]);
                    trTmp.style.display="none";
                    tdTmp.innerHTML = "+";
                }
                this.innerHTML = "-";
                trStage.style.display = "block";
            } else {
                this.innerHTML = "+";
                trStage.style.display = "none";
            }        
        }  
        var cell1 = rowObj.insertCell();//创建一个单元
         cell1.innerHTML = "事项名称";
        cell1.className = "c2"; 
        var cell2 = rowObj.insertCell();//创建一个单元
         cell2.innerHTML = sqlArray[i][1];
        cell2.width="70%";
        var stageSql = PunishPermission.queryStagesByPid(piValue);
        var stageArray = DBUtil.getQueryArray(stageSql, 0, -1);
        var stageRow = tableObj.insertRow();//创建一行
         stageRow.id = "tr_" + piValue;
        stageRow.style.display="none";
        var stageCell = stageRow.insertCell();//创建一个单元
         stageCell.colSpan = 3;
        var stageTable = document.createElement("table");//创建表格
         stageTable.width="100%";
        stageTable.cellSpacing=0;
        stageTable.cellPadding=0;
        var stagesRow = stageTable.insertRow();//创建一行
         var stagesCell_1 = stagesRow.insertCell();//创建一个单元  
         stagesCell_1.innerHTML = "阶段名称";
        stagesCell_1.className = "c2_1";
        var stagesCell_2 = stagesRow.insertCell();//创建一个单元  
         stagesCell_2.innerHTML = "操作权限";
        stagesCell_2.className = "c2_1";
        if (stageArray.length==0){
            var rowTmp = stageTable.insertRow();//创建一行
              var stagesTmp = rowTmp.insertCell();//创建一个单元
              stagesTmp.colSpan = 2;
            stagesTmp.innerHTML = "当前事项尚无配置任何阶段信息!";
        } else {
            for (var k=0;k<stageArray.length;k++) {
                var row_stage = stageTable.insertRow();//创建一行
                  var cell_1 = row_stage.insertCell();//创建一个单元
                  cell_1.innerHTML = stageArray[k][1];
                cell_1.align = "center";
                var cell_2 = row_stage.insertCell();//创建一个单元
                  var rtnTmp = WorkflowUtil.hasPermission(piValue, userId, stageArray[k][0]);
                var newRadio_1 ;
                var newRadio_2 ;
                var newRadio_3 ;
                
                if (rtnTmp == -1) {
                    newRadio_1 = document.createElement("<INPUT type=radio name="+piValue+"_"+stageArray[k][0]+" value=0>");
                    newRadio_2 = document.createElement("<INPUT type=radio name="+piValue+"_"+stageArray[k][0]+" value=1>");
                    newRadio_3 = document.createElement("<INPUT type=radio name="+piValue+"_"+stageArray[k][0]+" value=-1 checked>");
                } else if (rtnTmp == 0) {
                    newRadio_1 = document.createElement("<INPUT type=radio name="+piValue+"_"+stageArray[k][0]+" value=0 checked>");
                    newRadio_2 = document.createElement("<INPUT type=radio name="+piValue+"_"+stageArray[k][0]+" value=1>");
                    newRadio_3 = document.createElement("<INPUT type=radio name="+piValue+"_"+stageArray[k][0]+" value=-1>");                
                } else {
                    newRadio_1 = document.createElement("<INPUT type=radio name="+piValue+"_"+stageArray[k][0]+" value=0>");
                    newRadio_2 = document.createElement("<INPUT type=radio name="+piValue+"_"+stageArray[k][0]+" value=1 checked>");
                    newRadio_3 = document.createElement("<INPUT type=radio name="+piValue+"_"+stageArray[k][0]+" value=-1>");                
                }
                cell_2.appendChild(newRadio_1);
                var spanTmp_1 = document.createElement("<span></span>");
                spanTmp_1.innerHTML = "只读     ";
                cell_2.appendChild(spanTmp_1);
                cell_2.appendChild(newRadio_2);
                var spanTmp_2 = document.createElement("<span></span>");
                spanTmp_2.innerHTML = "编辑     ";
                cell_2.appendChild(spanTmp_2);
                cell_2.appendChild(newRadio_3);
                var spanTmp_3 = document.createElement("<span></span>");
                spanTmp_3.innerHTML = "无";
                cell_2.appendChild(spanTmp_3);
                cell_2.align = "center";
            }
        }
        stageCell.appendChild(stageTable);
    }

}
//保存
function save(){
    var arr = new Array();
    var n=0;
    var sql = PunishPermission.queryPunishes(buId);
    var sqlArray = DBUtil.getQueryArray(sql, 0, -1);
        for (var i = 0; i < sqlArray.length; i++) {
        var piValue = sqlArray[i][0];
        var stageSql = PunishPermission.queryStagesByPid(piValue);
        var stageArray = DBUtil.getQueryArray(stageSql, 0, -1);
        for (var k=0;k<stageArray.length;k++) {
            var ndpValue = stageArray[k][0];
            var radTmp = document.getElementsByName(piValue+"_"+ndpValue);
            if(radTmp!=null){
                for(j=0;j<radTmp.length;j++){
                    if(radTmp[j].checked){
                        arr[n] = piValue + "_" + ndpValue + "_" +radTmp[j].value;
                        n++;
                        break;
                    }
                }
            }

        }
    } 
    var rv = PunishPermission.saveConfigs(userId, arr);
        if (rv) {
        alert("保存数据信息成功！");
    } else {
        alert("保存数据信息失败！");
    }

}

//返回
function rtnBack(){
    window.history.back();
}
</script>

<!-- 提示：以下为页面DOM元素内容 -->
<DIV id=SKbillsheet style="visibility:hidden" toolbar="不带工具栏" BLONopen="setAuthority();init();" contxml="<root><button><id>saveBtn</id><id>clsBtn</id></button><text><id>BU_ID</id><id>USER_ID</id></text><dataset><id>wsSaveDataset</id></dataset></root>" billtaborder="<root><taborder>saveBtn</taborder><taborder>clsBtn</taborder><taborder>BU_ID</taborder><taborder>USER_ID</taborder></root>" dj_sn="20110126113145296483" caption="事项阶段权限配置" mkbh codeheader="BBB" entertype="修改" poswidth posheight controlno="SKButton:0;SKDBedit:0;checkbox:0;label:0;radio:0;listbox:0;textarea:0;combobox:0;password:0;upload:0;SKDBtext:0;chart:0;dbimg:0;img:0;SKBILLgrid:0;shape:0;tab:0;div:0;DsMain_field:0;a:0;button:0;text:2;hr:0;checkboxlist:0;radiolist:0;dropdownlist:0;grid:0;dataset:0;spin:0;excel:0;tree:0;ebshow:0;creatorSubForm:0;creator_div:0;ExtGrid:0;ExtUpload:0;ExtTree:0;Fusionchar:0" window="当前窗口" posleft postop keyfield isfile="否" OtherSave="否" idtype="1" testDbName="app_xzcf" creatorStyle="creatorBlue" BLONclose="UnLoadWebOffice();" creator_remark hasWorkflowButton="否" creator_elementAuthoritySwitch="否" creator_showAlert="否" creator_office_isBindForm="否" islog="否" isprotect="是" creator_csslib version="1.0" creator_pagination type="ZW" creatorType="20101125140655546142" jslib="fcbasecont.js&#13;&#10;selectdate.js&#13;&#10;~userfunc.js&#13;&#10;fcdate.js&#13;&#10;../../../ccapp/app_xzcf/js/common/Namespace.js&#13;&#10;../../../ccapp/app_xzcf/js/common/nsreg.js&#13;&#10;../../../ccapp/app_xzcf/js/common/Common.js&#13;&#10;../../../ccapp/app_xzcf/js/dao/PunishPermissionDao.js&#13;&#10;../../../ccapp/app_xzcf/js/business/PunishPermission.js&#13;&#10;../../../ccapp/app_xzcf/js/util/DBUtil.js&#13;&#10;../../../ccapp/app_xzcf/js/util/WorkflowUtil.js">

<TABLE cellSpacing=0 cellPadding=0 width="95%" align=center border=0>
   <TBODY>
      <TR>
         <TD>
            <TABLE class=Ctable cellSpacing=0 cellPadding=0 width="100%" align=center border=0>
               <TBODY>
                  <TR>
                     <TD class=taobox id=formTitleId colSpan=4>事项阶段权限配置<INPUT id=BU_ID style="DISPLAY: none; LEFT: 0px; WIDTH: 54px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=9 controltype="text"><INPUT id=USER_ID style="DISPLAY: none; LEFT: 0px; WIDTH: 46px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=8 controltype="text"></TD>
                  </TR>
                  <TR>
                     <TD class=c2>执法主体</TD>
                     <TD width="85%"><SPAN id=zfzt_name></SPAN>&nbsp;</TD>
                  </TR>
                  <TR>
                     <TD class=c2>人员名称</TD>
                     <TD><SPAN id=user_name></SPAN>&nbsp;</TD>
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
                     <TD class=c2 colSpan=3>事项列表</TD>
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
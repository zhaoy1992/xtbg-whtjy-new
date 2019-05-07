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
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/business/PunishDecide.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/business/PunishDecide.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/dao/PunishDecideDao.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/dao/PunishDecideDao.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/vo/PunishDecideVo.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/vo/PunishDecideVo.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/util/HTMLUtil.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/util/HTMLUtil.js'></script>");
if(!bDgMode) out.println("</script>");
%>

   <script >document.styleSheets[0].addRule("fc\\:dataset","behavior: url(../../fceform/htc/dataset.htc)",0);</script>
   <script language='javascript'>
adv_loadjsfile('/eformsys/fceform/css/tabstyle.css');
adv_loadjsfile('/eformsys/fceform/js/fcdataset.js');
</script>


<!-- 提示：以下为页面自定义JS内容 -->
<script>
var rddId = "";
var k = ""; //对象个数
var wft_id = creator_getQueryString("wft_id"); //事项实例ID
var ndp_id = 3;//creator_getQueryString("ndp_id"); //阶段ID
var pi_id = creator_getQueryString("pi_id");//事项ID
var userId = "";

/**
 * 初始化函数
 */
 function init() {
     zjeList.style.display = "none";
 }
 
 /**
 * 人员违法处罚列表
 * @param:user_id-处罚人ID
 */
function cfcsList(user_id) {
    userId = user_id;
    var cfcsListHtml = loadCfcsList(user_id);
    $('cfcsList').innerHTML = cfcsListHtml;
    var zjeListHtml = loadZJEList();
    $('zjeList').innerHTML = zjeListHtml;   
}

/**
 * 人员违法处罚详细
 * @param:user_id-处罚人ID
 * return:wfxwListHtml-String
 */
 function loadCfcsList(user_id) {
     var wfxwListHtml = new Array();
     wfxwListHtml.push("<TABLE width=100% class=Ctable>");

     var sql = PunishDecide.selectPunishActionByWFT_IdAndLTT_Id(wft_id,user_id);
     dataset2.Open(sql);
     var rowcount=dataset2.RecordCount;
     dataset2.MoveFirst();
     for(i=1;i<=rowcount;i++){
         k++;
         var rmd_id = dataset2.Fields.Field['rmd_id'].Value;
         wfxwListHtml.push("<TR>");
         wfxwListHtml.push('<TD  colspan=20>');
         wfxwListHtml.push('<TABLE width=100%>');
         wfxwListHtml.push('<TR>');
         wfxwListHtml.push('<Td width="5%">');
         wfxwListHtml.push("<img id='cfcsListItemEvent' style='margin-top:2px' src='../../../ccapp/app_xzcf/images/plus.gif' alt='展开详细信息' onclick=\"loadDetailInfo('");
         wfxwListHtml.push(rmd_id);
         wfxwListHtml.push("','");
         wfxwListHtml.push(k);
         wfxwListHtml.push("',event)\"></img>");
         wfxwListHtml.push('</TD>');
         wfxwListHtml.push("<TD width=15% class=c2>违法行为名称</TD>");
         wfxwListHtml.push("<TD>"+dataset2.Fields.Field['rmd_name'].Value+"</TD>");
         wfxwListHtml.push("</TR>");
         wfxwListHtml.push("</TABLE>");
         wfxwListHtml.push("<div name='cfcsDetail' style='display:none'>");
         dataset2.MoveNext();
     }   
     
     wfxwListHtml.push("</TABLE>");

     wfxwListHtml= wfxwListHtml.join("");
     return wfxwListHtml;
 }

 /**
 * 当事人动态数据加载
 * @param:rmdId-违法行为ID
 * @param:event-事件
 */
 function loadDetailInfo(rmdId,k,event) {
    var eventObject = event.srcElement;     
    var nextSibling =  eventObject.parentNode.parentNode.parentNode.parentNode.nextSibling;
    eventObject.parentNode.innerHTML = "<img id='cfcsListItemEvent' style='margin-top:2px' src='../../../ccapp/app_xzcf/images/minus.gif' alt='收缩详细信息'  onclick=\"showDetailInfo(event)\"></img>";
    nextSibling.innerHTML = loadCfcsAllHtml(rmdId,k);
    nextSibling.style.display = "block";
    initLoad(rmdId,k);
    getFKJE();
    var zje = document.getElementsByName("zje");
    if(zje[0].value ==0){
        zjeList.style.display = "none";
    }
}

/**
 * 隐藏详细信息
 * @param:event-事件
 */
function hiddenDetailInfo(event) {
    var eventObject = event.srcElement;
    var nextSibling =  eventObject.parentNode.parentNode.parentNode.parentNode.nextSibling;
    eventObject.parentNode.innerHTML = "<img id='cfcsListItemEvent' style='margin-top:2px' src='../../../ccapp/app_xzcf/images/plus.gif' alt='展开详细信息'  onclick=\"showDetailInfo(event)\"></img>";
    nextSibling.style.display = "none";
}

/**
 * 显示详细信息
 * @param:event-事件
 */
function showDetailInfo(event) {
    var eventObject = event.srcElement;
    var nextSibling =  eventObject.parentNode.parentNode.parentNode.parentNode.nextSibling;
    eventObject.parentNode.innerHTML = "<img id='cfcsListItemEvent' style='margin-top:2px' src='../../../ccapp/app_xzcf/images/minus.gif' alt='收缩详细信息'  onclick=\"hiddenDetailInfo(event)\"></img>";
    nextSibling.style.display = "block";
}

/**
 * 动态数据加载实现
 * @param:rmdId-违法行为ID
 * return:cfcsTableHtml -String
 */
function loadCfcsAllHtml(rmdId,k) {
    
    var sql = PunishDecide.selectPunishStepContentByRmd_Id(rmdId)
    var punishStepContent = SqlToField(sql);
    
    var cfcsTableHtmlArray = new Array();
    cfcsTableHtmlArray.push('<TABLE id="cfcsTable"  style="WIDTH: 99%" cellSpacing=0 cellPadding=0 align=middle><TBODY>');
    cfcsTableHtmlArray.push("<TR><TD width=15% class=c2>处罚措施</TD><TD colspan=3>"+punishStepContent+"</TD></TR>");
    cfcsTableHtmlArray.push('<TR><TD width=15% class=taobox colspan=4>自由裁量标准参考</TD></TR>');
    cfcsTableHtmlArray.push(loadZYCLBZHtml(rmdId,k));
    cfcsTableHtmlArray.push(loadZFYJHtml(rmdId,k));
    cfcsTableHtmlArray.push('</TBODY></TABLE>');
    cfcsTableHtmlArray.push("<div name='csxxList' style='display:block'>");
    
    if(rddId != ""){
        cfcsTableHtmlArray.push(loadCFCSHtml(rddId,k));
    }
    
    var cfcsTableHtml = cfcsTableHtmlArray.join(" ");
    return cfcsTableHtml ;
}

/**
 * 加载自由裁量标准
 * @param:rmdId-违法行为ID
 * return:zyclTableHtml-String
 */
function loadZYCLBZHtml(rmd_id,k) {
    var zyclTableHtmlArray = new Array(); 
    var sql = PunishDecide.selectPunishJudgmentStandardByRmd_Id(rmd_id);
    rddId = "";
    dataset3.Open(sql);
    var rowcount=dataset3.RecordCount;
    dataset3.MoveFirst();
    
    for(var i=1;i<=rowcount;i++){
          var rdd_id = dataset3.Fields.Field['rdd_id'].Value;
          var jd_id = dataset3.Fields.Field['jd_id'].Value;
          var ltt_id = dataset3.Fields.Field['ltt_id'].Value;
          var rdd_law_degree = dataset3.Fields.Field['rdd_law_degree'].Value;
          var rdd_illegal_plot = dataset3.Fields.Field['rdd_illegal_plot'].Value;
          var rdd_isvalue = dataset3.Fields.Field['rdd_isvalue'].Value;
          var rdd_value_upper = dataset3.Fields.Field['rdd_value_upper'].Value;
          var rdd_value_lower = dataset3.Fields.Field['rdd_value_lower'].Value;
          
          if(i==1 || ltt_id == userId){ //给裁量标准ID赋值（初始化为第一条）
                                              //如果有自由裁量实例，则取选中的自由裁量标准
               rddId= rdd_id;
          }

          if(ltt_id == userId || ltt_id == ""){
              zyclTableHtmlArray.push('<tr>');
              zyclTableHtmlArray.push('<td class=c2 width="10%">');
              zyclTableHtmlArray.push(rdd_law_degree);
              zyclTableHtmlArray.push("<INPUT type=hidden name=rdd_law_degree"+k+" value="+rdd_law_degree+">");
              zyclTableHtmlArray.push("<INPUT type=hidden name=rmd_id"+k+" value="+rmd_id+">");
              zyclTableHtmlArray.push("<INPUT type=hidden name=rdd_id"+k+" value="+rdd_id+">");
              zyclTableHtmlArray.push("<INPUT type=hidden name=jd_id"+k+" value="+jd_id+">");
              zyclTableHtmlArray.push("<INPUT type=hidden name=rdd_isvalue"+k+" value="+rdd_isvalue+">");
              zyclTableHtmlArray.push("<INPUT type=hidden name=rdd_value_upper"+k+" value="+rdd_value_upper+">");
              zyclTableHtmlArray.push("<INPUT type=hidden name=rdd_value_lower"+k+" value="+rdd_value_lower+">");
              zyclTableHtmlArray.push('</td>');
              zyclTableHtmlArray.push('<td width="40%">');
              zyclTableHtmlArray.push(rdd_illegal_plot);
              zyclTableHtmlArray.push("<INPUT type=hidden name=rdd_illegal_plot"+k+" value="+rdd_illegal_plot+">");
              zyclTableHtmlArray.push('</td>');
              zyclTableHtmlArray.push('<td colspan="2" width="50%"><INPUT type=radio value=');
              zyclTableHtmlArray.push(rdd_id);
              zyclTableHtmlArray.push('onclick="checkCfcs(');
              zyclTableHtmlArray.push(rdd_id);
              zyclTableHtmlArray.push(',');
              zyclTableHtmlArray.push(k);
              zyclTableHtmlArray.push(');"');
              zyclTableHtmlArray.push("name=check_zyclbz"+k+"");

              if(ltt_id != ""){
                  zyclTableHtmlArray.push('checked>');
              }else{
                  zyclTableHtmlArray.push('>');
              }
              
              zyclTableHtmlArray.push(dataset3.Fields.Field['rdd_punishment_standards'].Value);
              zyclTableHtmlArray.push('</td>');
              zyclTableHtmlArray.push('</tr>');
          }
          dataset3.MoveNext();
    }

    var zyclTableHtml = zyclTableHtmlArray.join(" ");
    return zyclTableHtml ;
}

/**
 * 加载执法依据和处罚依据
 * @param:rmdId-违法行为ID
 * return:zfyjTableHtml-String
 */
function loadZFYJHtml(rmd_id,k) {
    var zfyjTableHtmlArray = new Array(); 
    var sql = PunishDecide.selectPunishGistByRmd_Id(rmd_id);

    dataset4.Open(sql);
    var rowcount=dataset4.RecordCount;
    dataset4.MoveFirst();
    for(var i=1;i<=rowcount;i++){
          var rmd_the_law = dataset4.Fields.Field['rmd_the_law'].Value;
          var rmd_rule = dataset4.Fields.Field['rmd_rule'].Value;
          zfyjTableHtmlArray.push('<tr>');
          zfyjTableHtmlArray.push('<td width="10%" class=c2>执法依据</td>');
          zfyjTableHtmlArray.push('<td width="40%"><textarea id="rmd_the_law"  name="rmd_the_law">');
          zfyjTableHtmlArray.push(rmd_the_law);
          zfyjTableHtmlArray.push('</textarea>');
          zfyjTableHtmlArray.push("<INPUT type=hidden name=rmd_the_law"+k+" value="+rmd_the_law+">");
          zfyjTableHtmlArray.push('</td>');
          zfyjTableHtmlArray.push('<td width="10%" class=c2>处罚依据</td>');
          zfyjTableHtmlArray.push('<td width="40%"><textarea id="rmd_rule"  name="rmd_rule">');
          zfyjTableHtmlArray.push(rmd_rule);
          zfyjTableHtmlArray.push('</textarea>');
          zfyjTableHtmlArray.push("<INPUT type=hidden name=rmd_rule"+k+" value="+rmd_rule+">");
          zfyjTableHtmlArray.push('</td>');
          zfyjTableHtmlArray.push('</tr>');
          dataset4.MoveNext();
    }

    var zfyjTableHtml = zfyjTableHtmlArray.join(" ");

    return zfyjTableHtml ;
}

/**
 * 返回处罚措施详细
 * @param:rdd_id-裁量细则ID

 */
function checkCfcs(rdd_id,k) {
     
     var cfcsTableHtml = loadCFCSHtml(rdd_id,k);
     var eventObject = event.srcElement;
     var nextSibling =  eventObject.parentNode.parentNode.parentNode.parentNode.nextSibling;
     
     nextSibling.innerHTML = cfcsTableHtml;
}

/**
 * 加载处罚措施
 * @param:rdd_id-裁量细则ID
 * return:cfcsTableHtml-String
 */
function loadCFCSHtml(rdd_id,k) {
    var cfcsTableHtmlArray = new Array();
    var sql = PunishDecide.selectPunishStepByRdd_Id(rdd_id);
    dataset5.Open(sql);
    var rowcount=dataset5.RecordCount;
    cfcsTableHtmlArray.push('<TABLE width=100%>');
    cfcsTableHtmlArray.push('<tr>');
    cfcsTableHtmlArray.push('<td width="10%" class=c2 rowspan=');
    cfcsTableHtmlArray.push(rowcount+1);
    cfcsTableHtmlArray.push('>处<br>罚<br>措<br>施<br></td>');
    cfcsTableHtmlArray.push('<td width="40%"></td>');
    cfcsTableHtmlArray.push('<td width="10%" class=c2 rowspan=');
    cfcsTableHtmlArray.push(rowcount+1);
    cfcsTableHtmlArray.push('>履<br>行<br>期<br>限<br>（单位:天）</td>');
    cfcsTableHtmlArray.push('<td width="40%"></td>');
    cfcsTableHtmlArray.push('</tr>');
   
    dataset5.MoveFirst();
    for(var i=1;i<=rowcount;i++){
        var pm_id = dataset5.Fields.Field['pm_id'].Value;
        var pm_name = dataset5.Fields.Field['pm_name'].Value;
        cfcsTableHtmlArray.push('<tr>');
        cfcsTableHtmlArray.push("<td><INPUT type=checkbox value="+pm_id+" name=pm_id"+k+">"+pm_name+"</td>");
        cfcsTableHtmlArray.push("<td><INPUT type=text name=time_limit"+k+"></td>");
        cfcsTableHtmlArray.push('</tr>');
        dataset5.MoveNext();
    }

    cfcsTableHtmlArray.push('<tr>');
    cfcsTableHtmlArray.push('<td width=10% class=c2>处罚金额</td>');
    cfcsTableHtmlArray.push("<td colspan=3><INPUT onblur=getFKJE() type=text name=is_fkje"+k+"></td>");
    cfcsTableHtmlArray.push('</tr>');
    cfcsTableHtmlArray.push('</table>');
    
    var cfcsTableHtml = cfcsTableHtmlArray.join(" ");
    return cfcsTableHtml ;
}

/**
 * 加载所有环节的详细信息
 */
function loadAllCFCSDeatailInfo() {
    var cfcsListItemEvents = document.getElementsByName("cfcsListItemEvent");
    var cfcsListItemDetail = "";
    for(var i=0; i<cfcsListItemEvents.length; i++ ) {
        cfcsListItemDetail = cfcsListItemEvents[i].parentNode.parentNode.parentNode.parentNode.nextSibling;
        if(cfcsListItemDetail.style.display != "block") {
            cfcsListItemEvents[i].click();
        }
    }
    var zje = document.getElementsByName("zje");
    if(zje[0].value !=0){
        zjeList.style.display = "block";
    }
}

/**
 * 收缩所有环节的详细信息
 */
function hiddenAllCFCSDeatailInfo() {
    var cfcsListItemEvents = document.getElementsByName("cfcsListItemEvent");
    var cfcsListItemDetail = "";
    for(var i=0; i<cfcsListItemEvents.length; i++ ) {
        cfcsListItemDetail = cfcsListItemEvents[i].parentNode.parentNode.parentNode.parentNode.nextSibling;
        if(cfcsListItemDetail.style.display == "block") {
            cfcsListItemEvents[i].click();
        }
    }
}

/**
 * 加载总金额
 * @param:rmdId-违法行为ID
 * return:cfcsTableHtml-String
 */
function loadZJEList() {
     
     if(k !=0 ){
         var zjeListHtmlArray = new Array();
         zjeListHtmlArray.push("<TABLE width=100% class=Ctable>");
         zjeListHtmlArray.push("<TR>");
         zjeListHtmlArray.push("<TD width=10% class=c2>总金额</TD>");
         zjeListHtmlArray.push("<TD width=40%><INPUT type=text readonly id = zje name=zje>（元）</TD>");
         zjeListHtmlArray.push("<TD width=10% class=c2>实际金额</TD>");
         zjeListHtmlArray.push("<TD width=40%><INPUT type=text name=sjje>（元）</TD>");
         zjeListHtmlArray.push("</TR>");
         zjeListHtmlArray.push("</TABLE>");
     
         var zjeListHtml = zjeListHtmlArray.join(" ");
         return zjeListHtml ;
     }
     
}

/**
 * 得到罚款总金额
 */
function getFKJE() {
     var fkje = 0;
     var zje = document.getElementsByName("zje");
     if(typeof(zje[0])!="undefined"){
         for(var i=0; i<k; i++){
             var j = i+1;
             var is_fkje = document.getElementsByName("is_fkje"+j); //处罚金额
               for(var f=0; f<is_fkje.length; f++){
                 fkje += parseInt(is_fkje[f].value);
             }
         }
         if(isNaN(fkje)){
             zje[0].value = 0;
         }else{
             zjeList.style.display = "block";
             zje[0].value = fkje;
         }
     } 
}

/**
 * 保存处罚决定相关信息
 * @param:rmdId-违法行为ID
 */
function savePunishDecideInfo() {
     
     var sql="";
     var dbUtil = new DBUtil.BatchSqls();
     
     for(var i=0; i<k; i++){
        var pdvObj = new PunishDecideVo.PunishJudje();
        var pdVo = DBUtil.getVoFromPage(pdvObj);
        var j = i+1;
        if(!validate(j)){
            return;
        }
        deletePunishDecideInfo(j);
        
        var check_zyclbz = document.getElementsByName("check_zyclbz"+j); //选择自由裁量
         var pm_id= document.getElementsByName("pm_id"+j); //处罚措施ID
        var rmd_id = document.getElementsByName("rmd_id"+j); //违法行为ID
        var rdd_law_degree = document.getElementsByName("rdd_law_degree"+j); //违法程度
         var rdd_illegal_plot = document.getElementsByName("rdd_illegal_plot"+j); //违法情节
         var time_limit= document.getElementsByName("time_limit"+j); //履行期限
         var rmd_the_law =document.getElementsByName("rmd_the_law"+j); //执行依据
         var rmd_rule =document.getElementsByName("rmd_rule"+j); //处罚依据
         var is_fkje = document.getElementsByName("is_fkje"+j); //处罚金额
         var sjje = document.getElementsByName("sjje"); //实际金额
         
         pdvObj.JD_ID =DBUtil.getSeq('SEQ_JUDGE_DETAIL'); //裁量细则实例ID
        pdvObj.WFT_ID = wft_id; //处罚实例ID
        pdvObj.NDP_ID = ndp_id; //阶段ID
        pdvObj.WORKFLOW_NAME = "处罚决定";
        pdvObj.LTT_ID = userId; //当事人ID
        pdvObj.EXECUTING_DATE = FormUtil.getServerDate();
        
         for(var f=0; f<rmd_the_law.length; f++){
             pdvObj.JD_BRIEF_OF_CASE = rdd_illegal_plot[f].value;
             pdvObj.JD_LAW_DEGREE = rdd_law_degree[f].value;
             pdvObj.JD_RULE = rmd_rule[f].value;
             pdvObj.JD_VALUE = is_fkje[f].value;
             pdvObj.RMD_ID = rmd_id[f].value;
         }

         for(var f=0; f<check_zyclbz.length; f++){
             var rdd_id = check_zyclbz[f].value;
             
            if(check_zyclbz[f].checked){
                pdvObj.RDD_ID = check_zyclbz[f].value;
                var querySql = PunishDecide.selectPunishJudgmentStandardByRmd_IdAndRdd_Id(pdvObj.RMD_ID,rdd_id);
                dataset3.Open(querySql);
                var rowcount=dataset3.RecordCount;
                dataset3.MoveFirst();
                for(var i=1;i<=rowcount;i++){
                    pdvObj.JD_ISVALUE = dataset3.Fields.Field['rdd_isvalue'].Value ;
                    pdvObj.JD_ATTRI = dataset3.Fields.Field['rdd_attri'].Value ;
                    pdvObj.JD_UPPER = dataset3.Fields.Field['rdd_upper'].Value ;
                    pdvObj.JD_LOWER = dataset3.Fields.Field['rdd_lower'].Value ;
                    pdvObj.JDD_BASEUNIT = dataset3.Fields.Field['jdd_baseunit'].Value ;
                    pdvObj.JD_VALUE_UPPER = dataset3.Fields.Field['rdd_value_upper'].Value ;
                    pdvObj.JD_VALUE_LOWER = dataset3.Fields.Field['rdd_value_lower'].Value ;
                    dataset3.MoveNext();
                }
                sql = PunishDecide.savePunishJudje(pdVo);
                dbUtil.addSql(sql);
                sql = PunishDecide.savePunishJudjeAndUser(pdVo);
                dbUtil.addSql(sql);
            }
         }

         for(var f=0; f<pm_id.length; f++){
            if(pm_id[f].checked){
                pdvObj.PM_ID = pm_id[f].value;
                pdvObj.TIME_OF_PERFORMANCE = time_limit[f].value;
                
                sql = PunishDecide.savePenaltyMeasuAndJudgeAndDetail(pdVo); //插入处罚措施
                dbUtil.addSql(sql);
            }
         }
     }
     
     sql = PunishDecide.updateUserInfo(sjje[0].value,wft_id,userId); //更新当事人的罚款金额
      dbUtil.addSql(sql);     
     
     var returnValue = dbUtil.doBatch();
     
     if(returnValue==true){
         alert("保存数据信息成功");
         init();
     }else{
         alert("保存数据信息失败");
     }
}

/**
 * 更新操作给处罚决定相关信息赋值
 * @param:rmdId-违法行为ID
 * @param:k-对象个数
 */
function initLoad(rmdId,countK) {
        var check_zyclbz = document.getElementsByName("check_zyclbz"+countK); //选择自由裁量
         var jd_id = document.getElementsByName("jd_id"+countK); //自由裁量实例ID
        var is_fkje = document.getElementsByName("is_fkje"+countK); //处罚金额
         var rmd_id = document.getElementsByName("rmd_id"+countK); //违法行为ID
        var pm_id= document.getElementsByName("pm_id"+countK); //处罚措施ID
        var time_limit= document.getElementsByName("time_limit"+countK); //履行期限
         var sjje = document.getElementsByName("sjje"); //实际金额
         var tempRmdId = "";
        var tempPmId = "";
        var tempJd_id = ""; 
        
        for(var f=0; f<check_zyclbz.length; f++){
             if(check_zyclbz[f].checked){
                 tempRmdId = rmd_id[f].value;
                 tempJd_id = jd_id[f].value;
                 var sql = PunishDecide.selectJDValueByJd_Id(tempJd_id);
                 is_fkje[0].value = SqlToField(sql);
             }
        }

        for(var f=0; f<pm_id.length; f++) {
             tempPmId =pm_id[f].value;
             var sql = PunishDecide.selectPenaltyMeasuJudgeDetailByRmd_IdAndPm_IdAndJd_Id(tempRmdId,tempPmId,tempJd_id);
             dataset5.Open(sql);
             var rowcount=dataset5.RecordCount;
             if(rowcount >0){
                 dataset5.MoveFirst();
                 for(i=1;i<=rowcount;i++){
                     time_limit[f].value = dataset5.Fields.Field['time_of_performance'].Value;
                     pm_id[f].checked = true;
                     dataset5.MoveNext();
                 }
             }
        }
        var sql1 = PunishDecide.selectLttPenaltySum(wft_id,userId);
        sjje[0].value = SqlToField(sql1);
        
}

/**
 * 删除处罚决定相关信息
 * @param:rmdId-违法行为ID
 */
function deletePunishDecideInfo(countK) {
        var sql="";
        var dbUtil = new DBUtil.BatchSqls();
        var pdvObj = new PunishDecideVo.PunishJudje();
        var pdVo = DBUtil.getVoFromPage(pdvObj);
        var j = i+1;
        var pm_id= document.getElementsByName("pm_id"+countK); //处罚措施ID
        var rmd_id = document.getElementsByName("rmd_id"+countK); //违法行为ID
        var jd_id = document.getElementsByName("jd_id"+countK); //自由裁量实例ID
        var check_zyclbz = document.getElementsByName("check_zyclbz"+countK); //选择自由裁量
         var wftId = wft_id; //处罚实例ID
        var lttId = userId; //当事人ID
        var pmId = "";
        var rmdId = "";
        var jdId = "";
        
        for(var f=0; f<jd_id.length; f++){
             rmdId = rmd_id[f].value;
             jdId = jd_id[f].value;
             
             for(var h=0; h<pm_id.length; h++){
                if(pm_id[h].checked){
                    pmId = pm_id[h].value;
                    if(jdId != ""){
                        sql = PunishDecide.deletePenaltyMeasuAndJudgeAndDetail(rmdId,pmId,jdId);
                        dbUtil.addSql(sql);
                    }
                }
             }
             if(jdId != ""){
                 sql = PunishDecide.deletePunishJudjeAndUser(wftId,lttId,jdId);
                 dbUtil.addSql(sql);

                 sql = PunishDecide.deletePunishJudje(jdId);
                 dbUtil.addSql(sql);
             }
       } 
       dbUtil.doBatch();
}

function validate(countK) { 
    var is_fkje = document.getElementsByName("is_fkje"+countK); //处罚金额
     var pm_id= document.getElementsByName("pm_id"+countK); //处罚措施ID
    var time_limit= document.getElementsByName("time_limit"+countK); //履行期限
     var check_zyclbz = document.getElementsByName("check_zyclbz"+countK); //选择自由裁量
     var sjje = document.getElementsByName("sjje"); //实际金额
     var rdd_isvalue = document.getElementsByName("rdd_isvalue"+countK); //有金额
     var rdd_value_upper = document.getElementsByName("rdd_value_upper"+countK); //金额上限
     var rdd_value_lower = document.getElementsByName("rdd_value_lower"+countK); //金额下限
     var flag = true;
    var zyclbz=new Boolean(false);
    var cfcs = new Boolean(false);
    var isObject = new Boolean(false);

    for(var f=0; f<check_zyclbz.length; f++) {
         if(check_zyclbz[f].checked) {
             zyclbz = true;
             var fkje = is_fkje[0].value;
             var rdd_value_lower = rdd_value_lower[0].value;
             var rdd_value_upper = rdd_value_upper[0].value;
             var rdd_isvalue = rdd_isvalue[0].value;
             if(rdd_isvalue==0){
                 isObject = true;
             }
             //if (flag) {
             //    flag = SValidator.validate(fkje, {
             //        CHECK_TYPE : "required",
             //        ARGUMENT : {placeholders : [fkje]},
             //        MESSAGE : "处罚金额不能为空!"
             //   }, true);
             //}
             //if (flag) {
             //    flag = SValidator.validate(fkje, {
             //        CHECK_TYPE : "integer",
             //        ARGUMENT : {placeholders : ["处罚金额"],length : 0}
             //   }, false);
             //}
             //if(fkje != 0) {
             //    if (flag) {
             //        flag = SValidator.validate(fkje, {
             //            CHECK_TYPE : "intRange",
             //            ARGUMENT : {placeholders : [fkje,rdd_value_lower,rdd_value_upper],maxnumber : rdd_value_upper,minnumber :rdd_value_lower ,length : 0}
             //       }, false);
             //    }
             //}
         }
         if (flag) {
            if(zyclbz==false){
               flag = SValidator.validate(zyclbz, {
                     CHECK_TYPE : "required",
                     ARGUMENT : {placeholders : [zyclbz]},
                     MESSAGE : "自由裁量不能为空!"
               }, true);
           }   
        }
    }
    
    for(var f=0; f<pm_id.length; f++){
         if(pm_id[f].checked){
             cfcs = true;
             if (flag) {
                 flag = SValidator.validate(time_limit[f].value, {
                     CHECK_TYPE : "required",
                     ARGUMENT : {placeholders : [time_limit[f].value]},
                     MESSAGE : "选择处罚措施的履行期限不能为空!"
                }, true);
             }
             if (flag) {
                 flag = SValidator.validate(time_limit[f].value, {
                     CHECK_TYPE : "integer",
                     ARGUMENT : {placeholders : ["履行期限"],length : 0}
                }, false);
             }
         }
         if (flag) {
            if(cfcs==false){
               flag = SValidator.validate(cfcs, {
                     CHECK_TYPE : "required",
                     ARGUMENT : {placeholders : [cfcs]},
                     MESSAGE : "必须选择一个或多个处罚措施!"
               }, true);
           }   
        }
    }
    //if (flag) {
    //      flag = SValidator.validate(sjje[0].value, {
    //            CHECK_TYPE : "integer",
    //            ARGUMENT : {placeholders : ["实际金额"],length : 0}
    //      }, false);
    //}
    if (flag) {
        if(isObject) {
            if(!confirm("自由裁量标准没有确定处罚金额，是否需要保存处罚金额。")){
                return false;
            }
        }
    }

    return flag;
}

</script>

<!-- 提示：以下为页面DOM元素内容 -->
<DIV id=SKbillsheet style="visibility:hidden" toolbar="不带工具栏" BLONopen="setAuthority();init();" contxml="<root><dataset><id>dataset1</id><id>dataset2</id><id>dataset3</id><id>dataset4</id><id>dataset5</id></dataset></root>" billtaborder="<root></root>" dj_sn="20100911151557562999" caption="自由裁量标准" mkbh codeheader="BBB" entertype="修改" poswidth posheight controlno="SKButton:0;SKDBedit:0;checkbox:0;label:0;radio:0;listbox:0;textarea:0;combobox:0;password:0;upload:0;SKDBtext:0;chart:0;dbimg:1;img:1;SKBILLgrid:0;shape:0;tab:0;div:0;DsMain_field:0;a:0;button:0;text:0;hr:0;checkboxlist:0;radiolist:0;dropdownlist:0;grid:0;dataset:5;spin:0;excel:0;tree:0;ebshow:0;creatorSubForm:0;creator_div:0;ExtGrid:0;ExtUpload:1;ExtTree:1;Fusionchar:0" window="当前窗口" posleft postop keyfield isfile="否" OtherSave="否" idtype="1" testDbName="app_xzcf" creatorStyle="creatorBlue" BLONclose="UnLoadWebOffice();" creator_remark hasWorkflowButton="否" creator_elementAuthoritySwitch="否" creator_showAlert="否" creator_office_isBindForm="否" islog="否" isprotect="是" creator_csslib version="1.0" creator_pagination type="ZW" creatorType="20100902181230265751" jslib="fcbasecont.js&#13;&#10;selectdate.js&#13;&#10;~userfunc.js&#13;&#10;fcdate.js&#13;&#10;../../../ccapp/app_xzcf/js/common/Namespace.js&#13;&#10;../../../ccapp/app_xzcf/js/common/nsreg.js&#13;&#10;../../../ccapp/app_xzcf/js/common/Common.js&#13;&#10;../../../ccapp/app_xzcf/js/business/PunishDecide.js&#13;&#10;../../../ccapp/app_xzcf/js/dao/PunishDecideDao.js&#13;&#10;../../../ccapp/app_xzcf/js/vo/PunishDecideVo.js&#13;&#10;../../../ccapp/app_xzcf/js/util/HTMLUtil.js">

<DIV id=cfcsList style="WIDTH: 100%"></DIV>

<DIV id=zjeList style="WIDTH: 100%"></DIV>

<?xml:namespace prefix = fc />

<fc:dataset id=dataset1 format="<fields><field><fieldname>ltt_id</fieldname><datatype>字符</datatype><displaylabel>当事人ID</displaylabel><size>50</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>ltt_name</fieldname><datatype>字符</datatype><displaylabel>当事人名称</displaylabel><size>200</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field></fields>" onSetText='bill_ondatasetsettext("<dsid><ltt_id></ltt_id><ltt_name></ltt_name></dsid>")' onGetText='bill_ondatasetgettext("<dsid><ltt_id></ltt_id><ltt_name></ltt_name></dsid>")' onValid='bill_ondatasetvalid("<dsid><ltt_id></ltt_id><ltt_name></ltt_name></dsid>")' opensortno="1" temptable="TMP_DATASET1" multiResult="是"></fc:dataset>

<fc:dataset id=dataset2 format="<fields><field><fieldname>rmd_id</fieldname><datatype>字符</datatype><displaylabel>违法行为ID</displaylabel><size>50</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>rmd_name</fieldname><datatype>字符</datatype><displaylabel>违法行为名称</displaylabel><size>400</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field></fields>" onSetText='bill_ondatasetsettext("<dsid><rmd_id></rmd_id><rmd_name></rmd_name></dsid>")' onGetText='bill_ondatasetgettext("<dsid><rmd_id></rmd_id><rmd_name></rmd_name></dsid>")' onValid='bill_ondatasetvalid("<dsid><rmd_id></rmd_id><rmd_name></rmd_name></dsid>")' opensortno="1" temptable="TMP_DATASET2" multiResult="是"></fc:dataset>

<fc:dataset id=dataset3 format="<fields><field><fieldname>rdd_law_degree</fieldname><datatype>字符</datatype><displaylabel>违法程度</displaylabel><size>400</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>rdd_illegal_plot</fieldname><datatype>字符</datatype><displaylabel>违法情节</displaylabel><size>400</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>rdd_punishment_standards</fieldname><datatype>字符</datatype><displaylabel>处罚标准</displaylabel><size>400</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>rdd_id</fieldname><datatype>字符</datatype><displaylabel>裁量细则ID</displaylabel><size>50</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>rmd_id</fieldname><datatype>字符</datatype><displaylabel>违法行为ID</displaylabel><size>50</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>jd_id</fieldname><datatype>字符</datatype><displaylabel>裁量细则实例ID</displaylabel><size>50</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>ltt_id</fieldname><datatype>字符</datatype><displaylabel>当事人ID</displaylabel><size>50</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>ol_id</fieldname><datatype>字符</datatype><displaylabel>违法级别</displaylabel><size>50</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>rdd_code</fieldname><datatype>字符</datatype><displaylabel>编码</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>rdd_object_type</fieldname><datatype>字符</datatype><displaylabel>法人类别</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>rdd_attri</fieldname><datatype>字符</datatype><displaylabel>取值规则</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>rdd_upper</fieldname><datatype>字符</datatype><displaylabel>上限</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>rdd_lower</fieldname><datatype>字符</datatype><displaylabel>下限</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>jdd_baseunit</fieldname><datatype>字符</datatype><displaylabel>基数单位</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>rdd_baseunit_desc</fieldname><datatype>字符</datatype><displaylabel>基数说明</displaylabel><size>500</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>rdd_value_upper</fieldname><datatype>字符</datatype><displaylabel>金额上限</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>rdd_value_lower</fieldname><datatype>字符</datatype><displaylabel>金额下限</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>rdd_status</fieldname><datatype>字符</datatype><displaylabel>状态</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>rdd_checked</fieldname><datatype>字符</datatype><displaylabel>审核</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>rdd_isvalue</fieldname><datatype>字符</datatype><displaylabel>有金额</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field></fields>" onSetText='bill_ondatasetsettext("<dsid><rdd_law_degree></rdd_law_degree><rdd_illegal_plot></rdd_illegal_plot><rdd_punishment_standards></rdd_punishment_standards><rdd_id></rdd_id><rmd_id></rmd_id><jd_id></jd_id><ltt_id></ltt_id><ol_id></ol_id><rdd_code></rdd_code><rdd_object_type></rdd_object_type><rdd_attri></rdd_attri><rdd_upper></rdd_upper><rdd_lower></rdd_lower><jdd_baseunit></jdd_baseunit><rdd_baseunit_desc></rdd_baseunit_desc><rdd_value_upper></rdd_value_upper><rdd_value_lower></rdd_value_lower><rdd_status></rdd_status><rdd_checked></rdd_checked><rdd_isvalue></rdd_isvalue></dsid>")' onGetText='bill_ondatasetgettext("<dsid><rdd_law_degree></rdd_law_degree><rdd_illegal_plot></rdd_illegal_plot><rdd_punishment_standards></rdd_punishment_standards><rdd_id></rdd_id><rmd_id></rmd_id><jd_id></jd_id><ltt_id></ltt_id><ol_id></ol_id><rdd_code></rdd_code><rdd_object_type></rdd_object_type><rdd_attri></rdd_attri><rdd_upper></rdd_upper><rdd_lower></rdd_lower><jdd_baseunit></jdd_baseunit><rdd_baseunit_desc></rdd_baseunit_desc><rdd_value_upper></rdd_value_upper><rdd_value_lower></rdd_value_lower><rdd_status></rdd_status><rdd_checked></rdd_checked><rdd_isvalue></rdd_isvalue></dsid>")' onValid='bill_ondatasetvalid("<dsid><rdd_law_degree></rdd_law_degree><rdd_illegal_plot></rdd_illegal_plot><rdd_punishment_standards></rdd_punishment_standards><rdd_id></rdd_id><rmd_id></rmd_id><jd_id></jd_id><ltt_id></ltt_id><ol_id></ol_id><rdd_code></rdd_code><rdd_object_type></rdd_object_type><rdd_attri></rdd_attri><rdd_upper></rdd_upper><rdd_lower></rdd_lower><jdd_baseunit></jdd_baseunit><rdd_baseunit_desc></rdd_baseunit_desc><rdd_value_upper></rdd_value_upper><rdd_value_lower></rdd_value_lower><rdd_status></rdd_status><rdd_checked></rdd_checked><rdd_isvalue></rdd_isvalue></dsid>")' opensortno="1" temptable="TMP_DATASET3" multiResult="是"></fc:dataset>

<fc:dataset id=dataset4 format="<fields><field><fieldname>rmd_the_law</fieldname><datatype>字符</datatype><displaylabel>执法依据</displaylabel><size>500</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>rmd_rule</fieldname><datatype>字符</datatype><displaylabel>处罚依据</displaylabel><size>500</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field></fields>" onSetText='bill_ondatasetsettext("<dsid><rmd_the_law></rmd_the_law><rmd_rule></rmd_rule></dsid>")' onGetText='bill_ondatasetgettext("<dsid><rmd_the_law></rmd_the_law><rmd_rule></rmd_rule></dsid>")' onValid='bill_ondatasetvalid("<dsid><rmd_the_law></rmd_the_law><rmd_rule></rmd_rule></dsid>")' opensortno="1" temptable="TMP_DATASET4" multiResult="是"></fc:dataset>

<fc:dataset id=dataset5 format="<fields><field><fieldname>pm_name</fieldname><datatype>字符</datatype><displaylabel>处罚措施名称</displaylabel><size>500</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>pm_id</fieldname><datatype>字符</datatype><displaylabel>处罚措施ID</displaylabel><size>50</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>rmd_id</fieldname><datatype>字符</datatype><displaylabel>违法行为ID</displaylabel><size>50</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>jd_id</fieldname><datatype>字符</datatype><displaylabel>自由裁量实例ID</displaylabel><size>50</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>time_of_performance</fieldname><datatype>字符</datatype><displaylabel>履行期限</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field></fields>" onSetText='bill_ondatasetsettext("<dsid><pm_name></pm_name><pm_id></pm_id><rmd_id></rmd_id><jd_id></jd_id><time_of_performance></time_of_performance></dsid>")' onGetText='bill_ondatasetgettext("<dsid><pm_name></pm_name><pm_id></pm_id><rmd_id></rmd_id><jd_id></jd_id><time_of_performance></time_of_performance></dsid>")' onValid='bill_ondatasetvalid("<dsid><pm_name></pm_name><pm_id></pm_id><rmd_id></rmd_id><jd_id></jd_id><time_of_performance></time_of_performance></dsid>")' opensortno="1" temptable="TMP_DATASET5" multiResult="是"></fc:dataset>
</DIV>
<div id='grid_tip'></div></body></html>
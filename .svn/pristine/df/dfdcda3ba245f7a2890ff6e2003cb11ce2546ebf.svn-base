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
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/business/ReportStatistics.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/business/ReportStatistics.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/dao/ReportStatisticsDao.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/dao/ReportStatisticsDao.js'></script>");
if(!bDgMode) out.println("</script>");
%>

   <script language='javascript'>
adv_loadjsfile('/eformsys/fceform/css/tabstyle.css');
adv_loadjsfile('/eformsys/fceform/css/Button.css');
adv_loadjsfile('/eformsys/fceform/css/TextStyle.css');
</script>


<!-- 提示：以下为页面自定义JS内容 -->
<script>
<%@page import="com.chinacreator.xzcf.baseservice.menu.OrgAccessUtil "%>
<%
OrgAccessUtil orgAccess = new OrgAccessUtil();
String idName = orgAccess.getLawOrgIdName(accesscontroler.getUserID());
String allZfztId = "";
//当前用户可访问的所有执法主体
if (!"1".equals(accesscontroler.getUserID())) {
    allZfztId = orgAccess.getBuIdByOrgIds(accesscontroler.getUserID());
} else {
    allZfztId = orgAccess.getAllBuIds();
}
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

//获取当前用户
var orgname = getSysElement("userorgname");
var user = getSysElement("username");
var user_id = getSysElement("userid");

var temp = "";


/*
    函数：validated()
    描述：验证输入的日期是否合法
          受理开始时间不能大于受理结束时间
*/
function validated(){
    var leftYear = $('left_year').value;
    var rightYear = $('right_year').value;
    var leftMonth = $('left_month').value;
    var rightMonth = $('right_month').value;
    //左右年份都未选择
    if(IsSpace(leftYear) && IsSpace(rightYear)){
        alert("请至少选择一个年份");
        return flase;
    }
    //如果选择了月份，就必须选择年份
    if(!IsSpace(leftMonth) && IsSpace(leftYear)){
        alert("请选择受理开始年份");
        return flase;
    }
    if(!IsSpace(rightMonth) && IsSpace(rightYear)){
        alert("请选择受理结束年份");
        return flase;
    }
    //左年份大于右年份
    if(parseInt(leftYear) > parseInt(rightYear)){
      alert("受理开始时间不能大于受理结束时间");
      return false;
    } else if(parseInt(leftYear) == parseInt(rightYear) && parseInt(leftMonth) > parseInt(rightMonth)){
      alert("受理开始时间不能大于受理结束时间");
      return false;
    } else {
      return true;
    }
}

//获取当前服务器时间
function getNowDate(){
    var nowYear = FormUtil.getServerYear();//获取当前服务器年
    var nowMonth = FormUtil.getServerMonth();//获取当前服务器月
    var nowDate = nowYear + "-" + nowMonth;
    return nowDate;
}

/*
    函数：init()
    描述：初始化查询条件，并进行查询
          执法主体查询条件默认为当前登录用户的执法主体,
         受理开始时间默认为当前年的一月，
          受理结束时间默认为当前年的当前月。
*/
function init(){
    var nowDate = getNowDate();
    var rightYear = nowDate.split("-")[0];//当前年
    var rightMonth = nowDate.split("-")[1];//当前月
    var leftYear = nowDate.split("-")[0];//当前年
    var leftMonth = 1;
    $('left_year').value = leftYear;
    $('left_month').value = leftMonth;
    $('right_year').value = rightYear;
    $('right_month').value = rightMonth;
    $("orgIds").value = "<%=idTmp %>";
    $("orgNames").value = "<%=nameTmp %>";
    temp = $('orgIds').value;
    if(IsSpace(temp)){
        temp = "<%=allZfztId %>";
    }
    if(IsSpace(temp)){
         alert("当前用户没有访问权限");
        return;
    }
    var url = "20101224163902625945.jsp?"; 
    document.all.reportid.src = url;
}

/*
    函数：queryAndStatistics()
    描述：查询统计
*/
function queryAndStatistics(){
    temp = $('orgIds').value;
    if(IsSpace(temp)){
        temp = "<%=allZfztId %>";
    }
    if(IsSpace(temp)){
         alert("当前用户没有访问权限");
        return;
    }
    var flag = validated();
    if(!flag){
        return;
    }
    var url = "20101224163902625945.jsp?"; 
    document.all.reportid.src = url;
}

//重置
function resetButton(){
    $("orgIds").value = "<%=idTmp %>";
    $("orgNames").value = "<%=nameTmp %>";
    var nowDate = getNowDate();
    var rightYear = nowDate.split("-")[0];//当前年
    var rightMonth = nowDate.split("-")[1];//当前月
    var leftYear = nowDate.split("-")[0];//当前年
    var leftMonth = 1;
    $('left_year').value = leftYear;
    $('left_month').value = leftMonth;
    $('right_year').value = rightYear;
    $('right_month').value = rightMonth;
}

//打开执法主体资源树
function openUserTree(){
    url = "../../../ccapp/app_xzcf/jsp/baseservice/chooseZfztResourse.jsp";
    chooseUsers = window.showModalDialog(url,window, "dialogWidth=620px;dialogHeight=500px");
}
</script>

<!-- 提示：以下为页面DOM元素内容 -->
<DIV id=SKbillsheet style="visibility:hidden" toolbar="不带工具栏" BLONopen="setAuthority();init();" contxml="<root><combobox><id>left_year</id><id>left_month</id><id>right_year</id><id>right_month</id></combobox><button><id>button1</id><id>button2</id></button><text><id>orgNames</id></text></root>" billtaborder="<root><taborder>button1</taborder><taborder>button2</taborder><taborder>orgNames</taborder><taborder>left_year</taborder><taborder>left_month</taborder><taborder>right_year</taborder><taborder>right_month</taborder></root>" dj_sn="20101224142822843354" caption="受理与立案统计比较" mkbh codeheader="BBB" entertype="修改" poswidth posheight controlno="SKButton:0;SKDBedit:0;checkbox:0;label:0;radio:0;listbox:0;textarea:0;combobox:4;password:0;upload:0;SKDBtext:0;chart:0;dbimg:0;img:0;SKBILLgrid:0;shape:0;tab:0;div:0;DsMain_field:0;a:0;button:0;text:0;hr:0;checkboxlist:0;radiolist:0;dropdownlist:0;grid:0;dataset:0;spin:0;excel:0;tree:0;ebshow:0;creatorSubForm:0;creator_div:0;ExtGrid:0;ExtUpload:0;ExtTree:0;Fusionchar:0" window="当前窗口" posleft postop keyfield isfile="否" OtherSave="否" idtype="1" testDbName="app_xzcf" creatorStyle="creatorBlue" BLONclose="UnLoadWebOffice();" creator_remark hasWorkflowButton="否" creator_elementAuthoritySwitch="否" creator_showAlert="否" creator_office_isBindForm="否" islog="否" isprotect="是" creator_csslib version="1.0" creator_pagination type="ZW" creatorType="20100902181125312621" jslib="fcbasecont.js&#13;&#10;selectdate.js&#13;&#10;~userfunc.js&#13;&#10;fcdate.js&#13;&#10;../../../ccapp/app_xzcf/js/common/Common.js&#13;&#10;../../../ccapp/app_xzcf/js/business/ReportStatistics.js&#13;&#10;../../../ccapp/app_xzcf/js/dao/ReportStatisticsDao.js">

<TABLE cellSpacing=0 cellPadding=0 width="95%" align=center border=0>
   <TBODY>
      <TR>
         <TD>
            <TABLE class=Ctable cellSpacing=0 cellPadding=0 width="100%" border=0>
               <TBODY>
                  <TR>
                     <TD class=taobox colSpan=2>受理与立案统计比较</TD>
                  </TR>
                  <TR>
                     <TD class=c2 width="15%">执法主体</TD>
                     <TD width="85%"><INPUT id=orgNames style="LEFT: 0px; WIDTH: 31%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text" onclick='bill_onclick("openUserTree()")'><INPUT id=orgIds type=hidden></TD>
                  </TR>
                  <TR>
                     <TD class=c2 width="15%">受理时间</TD>
                     <TD width="85%"><SELECT id=left_year style="LEFT: 0px; WIDTH: 15%; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() sqltrans controltype="combobox" tempvalue="2010&#13;&#10;2011&#13;&#10;2012&#13;&#10;2013&#13;&#10;2014&#13;&#10;2015&#13;&#10;2016&#13;&#10;2017&#13;&#10;2018&#13;&#10;2019&#13;&#10;2020" temptext="2010&#13;&#10;2011&#13;&#10;2012&#13;&#10;2013&#13;&#10;2014&#13;&#10;2015&#13;&#10;2016&#13;&#10;2017&#13;&#10;2018&#13;&#10;2019&#13;&#10;2020" sql check="1"><OPTION value=2010 selected>2010</OPTION><OPTION value=2011>2011</OPTION><OPTION value=2012>2012</OPTION><OPTION value=2013>2013</OPTION><OPTION value=2014>2014</OPTION><OPTION value=2015>2015</OPTION><OPTION value=2016>2016</OPTION><OPTION value=2017>2017</OPTION><OPTION value=2018>2018</OPTION><OPTION value=2019>2019</OPTION><OPTION value=2020>2020</OPTION></SELECT>年<SELECT id=left_month style="LEFT: 0px; WIDTH: 15%; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() sqltrans controltype="combobox" tempvalue="1&#13;&#10;2&#13;&#10;3&#13;&#10;4&#13;&#10;5&#13;&#10;6&#13;&#10;7&#13;&#10;8&#13;&#10;9&#13;&#10;10&#13;&#10;11&#13;&#10;12" temptext="01&#13;&#10;02&#13;&#10;03&#13;&#10;04&#13;&#10;05&#13;&#10;06&#13;&#10;07&#13;&#10;08&#13;&#10;09&#13;&#10;10&#13;&#10;11&#13;&#10;12" sql check="1"><OPTION value=1 selected>01</OPTION><OPTION value=2>02</OPTION><OPTION value=3>03</OPTION><OPTION value=4>04</OPTION><OPTION value=5>05</OPTION><OPTION value=6>06</OPTION><OPTION value=7>07</OPTION><OPTION value=8>08</OPTION><OPTION value=9>09</OPTION><OPTION value=10>10</OPTION><OPTION value=11>11</OPTION><OPTION value=12>12</OPTION></SELECT>月&nbsp;&nbsp;至&nbsp;&nbsp;<SELECT id=right_year style="LEFT: 0px; WIDTH: 15%; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() sqltrans controltype="combobox" tempvalue="2010&#13;&#10;2011&#13;&#10;2012&#13;&#10;2013&#13;&#10;2014&#13;&#10;2015&#13;&#10;2016&#13;&#10;2017&#13;&#10;2018&#13;&#10;2019&#13;&#10;2020" temptext="2010&#13;&#10;2011&#13;&#10;2012&#13;&#10;2013&#13;&#10;2014&#13;&#10;2015&#13;&#10;2016&#13;&#10;2017&#13;&#10;2018&#13;&#10;2019&#13;&#10;2020" sql check="1"><OPTION value=2010 selected>2010</OPTION><OPTION value=2011>2011</OPTION><OPTION value=2012>2012</OPTION><OPTION value=2013>2013</OPTION><OPTION value=2014>2014</OPTION><OPTION value=2015>2015</OPTION><OPTION value=2016>2016</OPTION><OPTION value=2017>2017</OPTION><OPTION value=2018>2018</OPTION><OPTION value=2019>2019</OPTION><OPTION value=2020>2020</OPTION></SELECT>年<SELECT id=right_month style="LEFT: 0px; WIDTH: 15%; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() sqltrans controltype="combobox" tempvalue="1&#13;&#10;2&#13;&#10;3&#13;&#10;4&#13;&#10;5&#13;&#10;6&#13;&#10;7&#13;&#10;8&#13;&#10;9&#13;&#10;10&#13;&#10;11&#13;&#10;12" temptext="01&#13;&#10;02&#13;&#10;03&#13;&#10;04&#13;&#10;05&#13;&#10;06&#13;&#10;07&#13;&#10;08&#13;&#10;09&#13;&#10;10&#13;&#10;11&#13;&#10;12" sql check="1"><OPTION value=1 selected>01</OPTION><OPTION value=2>02</OPTION><OPTION value=3>03</OPTION><OPTION value=4>04</OPTION><OPTION value=5>05</OPTION><OPTION value=6>06</OPTION><OPTION value=7>07</OPTION><OPTION value=8>08</OPTION><OPTION value=9>09</OPTION><OPTION value=10>10</OPTION><OPTION value=11>11</OPTION><OPTION value=12>12</OPTION></SELECT>月</TD>
                  </TR>
               </TBODY>
            </TABLE>
         </TD>
      </TR>
      <TR>
         <TD align=middle><BUTTON class=button id=button1 style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("queryAndStatistics()")'>查询</BUTTON><BUTTON class=button id=button2 style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("resetButton()")'>重置</BUTTON></TD>
      </TR>
      <TR>
         <TD><IFRAME id=reportid style="WIDTH: 100%; HEIGHT: 445px" border=0 frameBorder=no></IFRAME></TD>
      </TR>
      <TR>
         <TD>
            <TABLE cellSpacing=0 cellPadding=0 width=760 border=0>
               <TBODY>
                  <TR>
                     <TD>&nbsp;</TD>
                  </TR>
               </TBODY>
            </TABLE>
         </TD>
      </TR>
   </TBODY>
</TABLE>
</DIV>
<div id='grid_tip'></div></body></html>
<%@ page contentType="text/html; charset=GBK" %><%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.frameworkset.common.poolman.DBUtil"%>

<%AccessControl accesscontroler = AccessControl.getInstance();
  accesscontroler.checkAccess(request, response);
  String appPath = "app_"+accesscontroler.getCurrentSystemID();
  String appId = accesscontroler.getCurrentSystemID();
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html xmlns:fc xmlns:v="urn:schemas-microsoft-com:vml">
	<HEAD>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">		
		<STYLE> .userData{behavior:url(#default#userData);}
	</STYLE>		
		<script src="../../fceform/js/fcpub.js"></script>
		<script src="../../fceform/js/fcrundj.js"></script>
		<script src="../../fceform/js/tabpane.js"></script>
		<script src="../../fceform/js/ccpub.js" defer></script>
		<script src="../../fceform/js/ccapp_pub.js" defer></script>		
		<script src="../../../eformsys/gaeditor/js/gaeditor.js" defer></script>
		<script src="../../../iWebOffice2006/js/iWebOffice2006.js" defer></script>
		<script langage="javascript">
			//根据应用确定样式的目录
			var stylePath = "../../../ccapp/<%=appPath%>/"; 
			var mylink = document.createElement("link");
			mylink.setAttribute("type","text/css");
			mylink.setAttribute("rel","stylesheet");
			mylink.setAttribute("href",stylePath+"css/"+fcpubdata.creatorStyle+"/allStyle.css");
			var myhead = document.getElementsByTagName("head")[0];
			myhead.appendChild(mylink);
		</script>
		<%@ include file="../../../iWebOffice2006/js/iWebOffice2006Event.jsp"%>
	</HEAD>
	<body background="../../fceform/images/ef_run_background.gif" onload="pub_window_onload()"
		onkeydown="RunTabindex()" onbeforeunload="pub_window_onbeforeunload()" onkeypress="pub_window_onkeypress()"
		onresize="pub_window_onresize()">
		<iframe id="_newframe" name="_newframe" height="0" width="0"></iframe>
		<script>
var pubdjbh=parent.sOpenDjNo;
var pubEdit=false;   			
var pubDataSet=null;
var pubRequest=parent.oRequest;
var pubEformEnterStatus="OK"; 
pub_djhtm();
		</script>
<script src='../../fceform/js/fcopendj.js'></script><script defer src='../../fceform/js/fcsavedj.js'></script><script src='../../fceform/js/fcselfuse.js'></script><script src='../../fceform/js/fcbasecont.js'></script><script defer src='../../fceform/js/fcother.js'></script><script defer src='../../fceform/js/selectdate.js'></script><script src='../../fceform/../fceformext/js/userfunc.js'></script><script src='../../fceform/js/fcdate.js'></script><link href=../../fceform/css/tabstyle.css type=text/css rel=stylesheet><script src='../../fceform/js/webfxlayout.js'></script><link id='luna-tab-style-sheet' type='text/css' rel='stylesheet' href='../../fceform/css/luna/tab.css'  /><link type='text/css' rel='stylesheet' href='../../fceform/css/Button.css'/><link type='text/css' rel='stylesheet' href='../../fceform/css/TextStyle.css'/>
<script>/*    初始化页面图片参数        */

var div_djid="";
var div_pic="";
function init(){
   //alert(fcpubdata.creatorStyle);

   // 模板对应的 表单ID
   div_djid={
   layout_type1       : "20090312093855765554",
   layout_type2       : "20090313155146078022",  
   layout_type3       : "20090316164256781975"      
   }
   table_djid={
   layout_type1       : "20090316164650562837",
   layout_type2       : "20090316164748062800",  
   layout_type3       : "20090316164836546989"      
   }
   frame_djid={
   layout_type1       : "20090316164650562837",
   layout_type2       : "20090316164748062800",  
   layout_type3       : "20090316164836546989"      
   }
   //模板对应的 图片路径
   div_pic={
   layout             : "../../../eformsys/fceform/images/layout/00.bmp",
   layout_type1       : "../../../eformsys/fceform/images/layout/type1.bmp",
   layout_type2       : "../../../eformsys/fceform/images/layout/type2.bmp",
   layout_type3       : "../../../eformsys/fceform/images/layout/type3.bmp"  
   }
   table_pic={
   layout             : "../../../eformsys/fceform/images/layout/00.bmp",
   layout_type1       : "../../../eformsys/fceform/images/layout/type1.bmp",
   layout_type2       : "../../../eformsys/fceform/images/layout/type2.bmp",
   layout_type3       : "../../../eformsys/fceform/images/layout/type3.bmp"  
   }
   frame_pic={
   layout             : "../../../eformsys/fceform/images/layout/00.bmp",
   layout_type1       : "../../../eformsys/fceform/images/layout/type1.bmp",
   layout_type2       : "../../../eformsys/fceform/images/layout/type2.bmp",
   layout_type3       : "../../../eformsys/fceform/images/layout/type3.bmp"  
   }
}
function layout_submit(){
      var arr=new Array();
      var cla=$("layoutClass").value;
      arr[0]=eval(cla+"_djid."+$("layoutType").value);
      arr[1]=$("pageWidth").value;
      arr[2]=$("pageHeight").value;
      window.returnValue=arr;
      this.close();
}


function showPicture(){
   var cla=$("layoutClass").value;
   var type=$("layoutType").value;
   $("templatePic").src= eval(cla+"_pic."+type);
}

</script><DIV id=SKbillsheet jslib="fcopendj.js&#13;&#10;fcsavedj.js&#13;&#10;fcselfuse.js&#13;&#10;fcbasecont.js&#13;&#10;fcother.js&#13;&#10;selectdate.js&#13;&#10;~userfunc.js&#13;&#10;fcdate.js" creatorType="20090312093045390397" type="ZW" center="居中" toolbar="不带工具栏" dj_sn="20090313092638953994" caption="layoutManage" mkbh codeheader="BBB" keyfield BLONopen="setAuthority();init();" BLONclose="UnLoadWebOffice();" window="当前窗口" entertype="修改" creator_remark hasWorkflowButton="否" creator_elementAuthoritySwitch="否" creator_showAlert="否" creator_office_isBindForm="否" islog="否" isprotect="是" posleft postop poswidth posheight isfile="否" OtherSave="否" creator_csslib idtype="1" version="1.0" creator_pagination billtaborder="<root><taborder>pageWidth</taborder><taborder>pageHeight</taborder><taborder>layoutClass</taborder><taborder>layoutType</taborder><taborder>button2</taborder></root>" controlno="SKButton:0;SKDBedit:0;checkbox:0;label:1;radio:5;listbox:1;textarea:2;combobox:2;password:0;upload:0;SKDBtext:0;chart:0;dbimg:0;img:2;SKBILLgrid:0;shape:0;tab:1;div:1;DsMain_field:0;a:0;button:2;text:3;hr:0;checkboxlist:1;radiolist:0;dropdownlist:0;grid:2;dataset:0;spin:0;excel:0;tree:0;ebshow:0;creatorSubForm:0;creator_div:0" contxml="<root><radio><id>layoutClass</id></radio><combobox><id>layoutType</id></combobox><img><id>templatePic</id></img><tab><id>tab1</id></tab><button><id>button2</id></button><text><id>pageWidth</id><id>pageHeight</id></text></root>" creator_allTab="<tabs><tab><id>tab1</id><content><index>0</index><gridid></gridid><iframeid></iframeid><index>1</index><gridid></gridid><iframeid></iframeid></content></tab></tabs>" creatorStyle="creatorBlue"><DIV class=tab-pane id=tab1 style="LEFT: 13px; WIDTH: 272px; POSITION: absolute; TOP: 7px; HEIGHT: 281px" IsHideTitle="undefined" showtype="luna">
<DIV class=tab-page style="WIDTH: 272px; HEIGHT: 263px">
<H2 class=tab>模板样式</H2>
<FIELDSET id=layoutClass contentEditable=false style="LEFT: 0px; WIDTH: 100%; COLOR: #000000; POSITION: static; TOP: 0px; HEIGHT: 42px" onmovestart=moveStart() value="frame" controltype="radio" aspect="横向" legend="布局类别" tempvalue="div&#13;&#10;table&#13;&#10;frame" temptext="层 &#13;&#10;表格&#13;&#10;框架" NotBg="否"><LEGEND>布局类别</LEGEND><INPUT type=radio value=div name=RGlayoutClass text="层"><SPAN onclick=RGlayoutClass[0].checked=true;layoutClass.value=RGlayoutClass[0].value;RGlayoutClass[0].focus();>层 </SPAN>&nbsp;<INPUT type=radio value=table name=RGlayoutClass text="表格"><SPAN onclick=RGlayoutClass[1].checked=true;layoutClass.value=RGlayoutClass[1].value;RGlayoutClass[1].focus();>表格</SPAN>&nbsp;<INPUT type=radio CHECKED value=frame name=RGlayoutClass text="框架"><SPAN onclick=RGlayoutClass[2].checked=true;layoutClass.value=RGlayoutClass[2].value;RGlayoutClass[2].focus();>框架</SPAN>&nbsp;</FIELDSET> 
<TABLE class=formtable style="POSITION: static" cellSpacing=0 cellPadding=0 width="100%" align=left border=1>
<TBODY>
<TR>
<TD>布局样式</TD>
<TD><SELECT id=layoutType style="LEFT: 0px; WIDTH: 120px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() onchange='bill_onclick("showPicture()")' controltype="combobox" tempvalue="layout&#13;&#10;layout_type1&#13;&#10;layout_type2&#13;&#10;layout_type3&#13;&#10;" temptext="不使用&#13;&#10;样式一&#13;&#10;样式二&#13;&#10;样式三&#13;&#10;" backwidth="120" backheight="25" check="1" sql sqltrans><OPTION value=layout selected>不使用</OPTION><OPTION value=layout_type1>样式一</OPTION><OPTION value=layout_type2>样式二</OPTION><OPTION value=layout_type3>样式三</OPTION><OPTION value=""></OPTION></SELECT></TD></TR>
<TR>
<TD colSpan=2><IMG id=templatePic style="LEFT: 0px; WIDTH: 227px; POSITION: static; TOP: 0px; HEIGHT: 176px" onmovestart=moveStart() height=30 src="../../../eformsys/fceform/images/layout/00.bmp" width=284 controltype="img" srcsk cover="9"></TD></TR></TBODY></TABLE></DIV>
<DIV class=tab-page style="WIDTH: 272px; HEIGHT: 263px">
<H2 class=tab>自定义样式</H2>
<FIELDSET id=page contentEditable=false style="LEFT: 0px; WIDTH: 100%; COLOR: #000000; POSITION: static; TOP: 0px; HEIGHT: 240px" onmovestart=moveStart() value="-1" aspect="横向" legend="页面尺寸设置" NotBg="否"><LEGEND>页面尺寸设置</LEGEND>
<TABLE class=formtable style="POSITION: static" cellSpacing=0 cellPadding=0 width="100%" align=left border=0>
<TBODY>
<TR>
<TD vAlign=top align=left width="30%">页面宽度</TD>
<TD><INPUT id=pageWidth style="LEFT: 0px; WIDTH: 110px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text">px</TD></TR>
<TR>
<TD>页面高度</TD>
<TD><INPUT id=pageHeight style="LEFT: 0px; WIDTH: 110px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text">px</TD></TR></TBODY></TABLE></FIELDSET></DIV></DIV>
<SCRIPT>var tab1 = new WebFXTabPane( document.getElementById( "tab1" ) );</SCRIPT>
<BUTTON id=button2 style="LEFT: 78px; WIDTH: 75px; POSITION: absolute; TOP: 299px; HEIGHT: 25px" onmovestart=moveStart() controltype="button" onclick='bill_onclick("layout_submit()")' dropstyle="否">确认新建</BUTTON></DIV></body></html>
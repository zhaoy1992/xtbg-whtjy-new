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
<script></script>

<!-- 提示：以下为页面DOM元素内容 -->
<DIV id=SKbillsheet style="visibility:hidden" toolbar="不带工具栏" BLONopen="setAuthority();" contxml="<root><textarea><id>textarea1</id><id>textarea2</id></textarea><combobox><id>combobox1</id><id>combobox2</id><id>combobox3</id><id>combobox4</id></combobox><button><id>button1</id><id>button2</id><id>button3</id><id>button4</id><id>button6</id><id>button7</id><id>button9</id></button><text><id>text1</id><id>text2</id><id>text3</id><id>text4</id><id>text5</id><id>text6</id><id>text7</id><id>text9</id><id>text10</id><id>text11</id><id>text12</id><id>text13</id></text><dataset><id>dataset1</id></dataset><ExtGrid><id>ExtGrid1</id></ExtGrid></root>" billtaborder="<root><taborder>button1</taborder><taborder>button2</taborder><taborder>button3</taborder><taborder>combobox1</taborder><taborder>text1</taborder><taborder>text2</taborder><taborder>text3</taborder><taborder>text4</taborder><taborder>textarea1</taborder><taborder>textarea2</taborder><taborder>combobox2</taborder><taborder>combobox3</taborder><taborder>combobox4</taborder><taborder>button4</taborder><taborder>text5</taborder><taborder>text6</taborder><taborder>text7</taborder><taborder>text9</taborder><taborder>text10</taborder><taborder>text11</taborder><taborder>text12</taborder><taborder>text13</taborder><taborder>button6</taborder><taborder>button7</taborder><taborder>button9</taborder></root>" dj_sn="20100910185710265418" caption="处罚决定" mkbh codeheader="BBB" entertype="修改" poswidth posheight controlno="SKButton:0;SKDBedit:0;checkbox:0;label:0;radio:2;listbox:0;textarea:2;combobox:4;password:0;upload:0;SKDBtext:0;chart:0;dbimg:0;img:0;SKBILLgrid:0;shape:0;tab:0;div:0;DsMain_field:0;a:0;button:9;text:13;hr:0;checkboxlist:0;radiolist:0;dropdownlist:0;grid:0;dataset:1;spin:0;excel:0;tree:0;ebshow:0;creatorSubForm:0;creator_div:0;ExtGrid:1;ExtUpload:0;ExtTree:0;Fusionchar:0" window="当前窗口" posleft postop keyfield isfile="否" OtherSave="否" idtype="1" testDbName="app_xzcf" creatorStyle="creatorBlue" BLONclose="UnLoadWebOffice();" creator_remark hasWorkflowButton="否" creator_elementAuthoritySwitch="否" creator_showAlert="是" creator_office_isBindForm="否" islog="否" isprotect="是" creator_csslib version="1.0" creator_pagination type="ZW" creatorType="20100902181244984828" jslib="fcbasecont.js&#13;&#10;selectdate.js&#13;&#10;~userfunc.js&#13;&#10;fcdate.js">

<TABLE cellSpacing=0 cellPadding=0 width="95%" align=center border=1>
   <TBODY>
      <TR>
         <TD>
            <TABLE cellSpacing=0 cellPadding=0 width="100%" border=1>
               <TBODY>
                  <TR height=33>
                     <TD>【处罚决定】</TD>
                     <TD align=right><BUTTON id=button1 style="LEFT: 642px; WIDTH: 75px; POSITION: static; TOP: 20px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="否" controltype="button">暂存</BUTTON><BUTTON id=button2 style="LEFT: 0px; WIDTH: 75px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="否" controltype="button">提交</BUTTON><BUTTON id=button3 style="LEFT: 0px; WIDTH: 75px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="否" controltype="button">返回</BUTTON></TD>
                  </TR>
               </TBODY>
            </TABLE>
         </TD>
      </TR>
      <TR>
         <TD>
            <TABLE cellSpacing=0 cellPadding=0 width="100%" border=1>
               <TBODY>
                  <TR>
                     <TD colSpan=2>简易程序案件信息</TD>
                  </TR>
                  <TR>
                     <TD colSpan=2>
                        <TABLE cellSpacing=0 cellPadding=0 width="100%" border=1>
                           <TBODY>
                              <TR>
                                 <TD align=right width="15%">案件受理编号：</TD>
                                 <TD align=left width="35%"><INPUT id=text1 style="LEFT: 0px; WIDTH: 110px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text"></TD>
                                 <TD align=right width="15%">案件来源：</TD>
                                 <TD align=left width="35%"><SELECT id=combobox1 style="LEFT: 0px; WIDTH: 120px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() sqltrans controltype="combobox" tempvalue temptext sql check="1"></SELECT></TD>
                              </TR>
                              <TR>
                                 <TD align=right width="15%">案件标题：</TD>
                                 <TD width="85%" colSpan=3><INPUT id=text2 style="LEFT: 0px; WIDTH: 50%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() size=39 controltype="text"></TD>
                              </TR>
                              <TR>
                                 <TD align=right width="15%">案发地址：</TD>
                                 <TD align=left width="35%"><INPUT id=text3 style="LEFT: 0px; WIDTH: 110px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text"></TD>
                                 <TD align=right width="15%">受理时间：</TD>
                                 <TD vAlign=top align=left width="35%"><INPUT id=text4 style="LEFT: 0px; WIDTH: 110px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text"></TD>
                              </TR>
                              <TR>
                                 <TD align=right width="15%">简要案件内容：</TD>
                                 <TD align=left width="85%" colSpan=3><TEXTAREA id=textarea1 style="LEFT: 0px; WIDTH: 50%; POSITION: static; TOP: 0px; HEIGHT: 111px" onmovestart=moveStart() cols=70 controltype="textarea" value="textarea1" induce="否" algin="left"></TEXTAREA></TD>
                              </TR>
                           </TBODY>
                        </TABLE>
                     </TD>
                  </TR>
                  <TR>
                     <TD colSpan=2>当事人(单位)信息</TD>
                  </TR>
                  <TR>
                     <TD colSpan=2>
                        <TABLE cellSpacing=0 cellPadding=0 width="100%" border=1>
                           <TBODY>
                              <TR>
                                 <TD align=right width="15%">当事人/单位：</TD>
                                 <TD width="35%"><INPUT type=radio CHECKED value=1 name=RGradio2 text="公民"><SPAN>公民</SPAN>&nbsp;<INPUT type=radio value=2 name=RGradio2 text="法人或其它组织"><SPAN>法人或其它组织</SPAN></TD>
                                 <TD align=right width="15%">当事人/单位名称：</TD>
                                 <TD width="35%"><INPUT id=text5 style="LEFT: 0px; WIDTH: 110px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text"></TD>
                              </TR>
                              <TR>
                                 <TD align=right width="15%">证件类型：</TD>
                                 <TD width="35%"><SELECT id=combobox2 style="LEFT: 0px; WIDTH: 120px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() sqltrans controltype="combobox" tempvalue temptext sql check="1"></SELECT></TD>
                                 <TD width="15%"></TD>
                                 <TD width="35%"></TD>
                              </TR>
                              <TR>
                                 <TD align=right width="15%">证件号码：</TD>
                                 <TD width="35%"><INPUT id=text6 style="LEFT: 0px; WIDTH: 110px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text"></TD>
                                 <TD align=right width="15%">法人代表：</TD>
                                 <TD width="35%"><INPUT id=text7 style="LEFT: 0px; WIDTH: 110px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text"></TD>
                              </TR>
                           </TBODY>
                        </TABLE>
                     </TD>
                  </TR>
                  <TR>
                     <TD colSpan=2>处罚决定信息</TD>
                  </TR>
                  <TR>
                     <TD colSpan=2>
                        <TABLE cellSpacing=0 cellPadding=0 width="100%" border=1>
                           <TBODY>
                              <TR>
                                 <TD align=right width="15%">执法主体：</TD>
                                 <TD width="35%"><INPUT id=text9 style="LEFT: 0px; WIDTH: 110px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text"></TD>
                                 <TD width="15%"></TD>
                                 <TD width="35%"></TD>
                              </TR>
                              <TR>
                                 <TD align=right width="15%">违法行为名称：</TD>
                                 <TD width="35%"><INPUT id=text10 style="LEFT: 0px; WIDTH: 110px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text"></TD>
                                 <TD align=right width="15%">违法程度：</TD>
                                 <TD width="35%"><SELECT id=combobox3 style="LEFT: 0px; WIDTH: 120px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() sqltrans controltype="combobox" tempvalue temptext sql check="1"></SELECT></TD>
                              </TR>
                              <TR>
                                 <TD align=right width="15%">违法情节：</TD>
                                 <TD width="85%" colSpan=3><SELECT id=combobox4 style="LEFT: 0px; WIDTH: 120px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() sqltrans controltype="combobox" tempvalue temptext sql check="1"></SELECT></TD>
                              </TR>
                              <TR>
                                 <TD align=right width="15%">违法金额：</TD>
                                 <TD width="35%"><INPUT id=text11 style="LEFT: 0px; WIDTH: 110px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text"></TD>
                                 <TD align=right width="15%">处罚收据编号：</TD>
                                 <TD width="35%"><INPUT id=text12 style="LEFT: 0px; WIDTH: 110px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text"></TD>
                              </TR>
                              <TR>
                                 <TD align=right width="15%">处罚决定内容：</TD>
                                 <TD width="85%" colSpan=3><TEXTAREA id=textarea2 style="LEFT: 0px; WIDTH: 50%; POSITION: static; TOP: 0px; HEIGHT: 85px" onmovestart=moveStart() cols=81 controltype="textarea" value="textarea2" induce="否"></TEXTAREA></TD>
                              </TR>
                              <TR>
                                 <TD align=right width="15%">处罚决定时间：</TD>
                                 <TD width="85%" colSpan=3><INPUT id=text13 style="LEFT: 0px; WIDTH: 110px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text"></TD>
                              </TR>
                              <TR>
                                 <TD align=right width="15%">附件上传：</TD>
                                 <TD width="85%" colSpan=3><BUTTON id=button4 style="LEFT: 0px; WIDTH: 75px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="否" controltype="button">上传证据</BUTTON></TD>
                              </TR>
                           </TBODY>
                        </TABLE>
                     </TD>
                  </TR>
                  <TR>
                     <TD>证据信息</TD>
                     <TD align=right><BUTTON id=button6 style="LEFT: 0px; WIDTH: 75px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="否" controltype="button">上传新数据</BUTTON>&nbsp;<BUTTON id=button7 style="LEFT: 0px; WIDTH: 91px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="否" controltype="button">编辑选中数据</BUTTON>&nbsp;<BUTTON id=button9 style="LEFT: 0px; WIDTH: 88px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() dropstyle="否" controltype="button">删除选中数据</BUTTON></TD>
                  </TR>
                  <TR>
                     <TD colSpan=2><DIV><IMG style="DISPLAY: none" src="undefined"><DIV id=div_ExtGrid1 style="LEFT: 0px; POSITION: static; TOP: 0px"></DIV><SCRIPT type=text/javascript>var ExtGrid1;
Ext.BLANK_IMAGE_URL = '../../fceform/js/Ext/images/default/s.gif';
var ExtGrid1_retint = 0;
var ExtGrid1_onReady = function(){ 
 Ext.QuickTips.init();
var dataset = document.getElementById("dataset1");
try{var temp = dataset.Fields.Field.length;}catch(e){if(ExtGrid1_retint==0) ExtGrid1_retint = setInterval(ExtGrid1_onReady,200);dataset =null;return;}finally{if(temp!=null)temp=null;}
clearInterval(ExtGrid1_retint);ExtGrid1_retint = null ;var pagesize =-1;
dataset.PageSize = pagesize ;
var mapping = creator_pt_getmapping(dataset);
var store  = new Ext.data.Store({
	proxy: new Ext.data.CreatorMemoryProxy("dataset1"), 
	reader: new Ext.data.XmlStringReader({       record: 'tr',       totalRecords: 'pages'   }, mapping)});
var sm = new Ext.grid.RowSelectionModel({singleSelect: true});
var retcm = creator_pt_getcm(dataset,sm);var cm = new Ext.grid.ColumnModel(retcm);
if(typeof(retcm[0].getCount)!='undefined') sm = retcm[0] ;
 ExtGrid1 = new Ext.grid.GridPanel({
		el: 'div_ExtGrid1',        store: store,
        cm:cm,
		sm: sm,
 			 bodyStyle : 'width:100%',
		viewConfig: {
			forceFit: true		},       loadMask: true,
		width:0,      height:0,		split: true,
		region: 'north',
		title:'查询结果',
		frame:true
    });
    var grid=ExtGrid1;
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
[{Rule:'${user_sn}=="1"',showtype:'<span style="color:red">${user_sn}</span>'}];
[{showtype:'checkbox'}];ExtGrid1.render();
store.load();
if(typeof(creator_pt_grids)=='undefined'){creator_pt_grids=new Array();}
creator_pt_grids.push({id:'ExtGrid1',obj:ExtGrid1,dataset:'dataset1',isEdit:'false'});
if(typeof(onGridPanelLoaded)=='function') setTimeout(onGridPanelLoaded,0);
};
ExtGrid1_onReady();</SCRIPT></DIV></TD>
                  </TR>
               </TBODY>
            </TABLE>
         </TD>
      </TR>
   </TBODY>
</TABLE>

<?xml:namespace prefix = fc />

<fc:dataset id=dataset1 format="<fields><field><fieldname>radio</fieldname><datatype>字符</datatype><displaylabel></displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue>1</defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>a</fieldname><datatype>字符</datatype><displaylabel>序号</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>b</fieldname><datatype>字符</datatype><displaylabel>证据类型</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>c</fieldname><datatype>字符</datatype><displaylabel>调查取证时间</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>d</fieldname><datatype>字符</datatype><displaylabel>上传时间</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>e</fieldname><datatype>字符</datatype><displaylabel>调查取证人员</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>f</fieldname><datatype>字符</datatype><displaylabel>证据名称</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field></fields>" onSetText='bill_ondatasetsettext("<dsid><radio></radio><a></a><b></b><c></c><d></d><e></e><f></f></dsid>")' onGetText='bill_ondatasetgettext("<dsid><radio></radio><a></a><b></b><c></c><d></d><e></e><f></f></dsid>")' onValid='bill_ondatasetvalid("<dsid><radio></radio><a></a><b></b><c></c><d></d><e></e><f></f></dsid>")' opensortno="1" temptable="TMP_DATASET1" multiResult="是"></fc:dataset>
</DIV>
<div id='grid_tip'></div></body></html>
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
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/util/WorkflowUtil.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/util/WorkflowUtil.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/common/Common.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/common/Common.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/util/WorkflowUtil.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/util/WorkflowUtil.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/business/ExecuteState.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/business/ExecuteState.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/dao/ExecuteStateDao.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/dao/ExecuteStateDao.js'></script>");
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
//获取该处罚事项实例ID
var wft_id = creator_getQueryString("wft_id");

//获取该裁量细则下的该处罚措施
var jd_id = creator_getQueryString("jd_id");//裁量细则流水
var pm_id = creator_getQueryString("pm_id");//处罚措施ID==2

//根据“执行信息”是否提交判断初始化

//初始化该处罚措施
function init(){
    var sql = ExecuteState.findPunishMeasure(jd_id,pm_id);
    punishMeasureDataset.Open(sql);
    selectExecuteState();
}

//查询"执行情况"字段内容
function selectExecuteState(){
    var ldt_id = 6;//列示文档归类
    var md_title = "执行情况";
    var sql = DocumentList.findDocumentInfo(wft_id, ldt_id, md_title);
    punishMeasureDataset.Open(sql);
    var executeInfo = punishMeasureDataset..Fields.Field['MD_BODY'].Value;
    if(!IsSpace(executeInfo)){
        $('executeInfo').value = executeInfo;
    }
}

//修改"执行状态"
function updateExecuteState(){
    var vo = new PunishMeasureVo.PunishMeasure();
    vo.WFT_ID = wft_id;
    vo.JD_ID = jd_id;
    vo.PM_ID = pm_id;
    vo.EXECUTING_STATE = $('EXECUTING_STATE').value;
    return vo;
}
</script>

<!-- 提示：以下为页面DOM元素内容 -->
<DIV id=SKbillsheet style="visibility:hidden" toolbar="不带工具栏" BLONopen="setAuthority();" contxml="<root><textarea><id>executeInfo</id></textarea><combobox><id>EXECUTING_STATE</id></combobox><button><id>button3</id><id>button1</id><id>button2</id></button><text><id>PM_NAME</id><id>TIME_OF_PERFORMANCE</id><id>EXECUTING_DATE</id><id>LTT_PENALTY_SUM</id><id>text5</id><id>LTT_PENALTY_PAIDED_SUM</id><id>LTT_LATE_FEE</id></text><dataset><id>punishMeasureDataset</id></dataset><ExtGrid><id>ExtGrid1</id></ExtGrid></root>" billtaborder="<root><taborder>button1</taborder><taborder>button2</taborder><taborder>PM_NAME</taborder><taborder>TIME_OF_PERFORMANCE</taborder><taborder>executeInfo</taborder><taborder>EXECUTING_STATE</taborder><taborder>EXECUTING_DATE</taborder><taborder>LTT_PENALTY_SUM</taborder><taborder>text5</taborder><taborder>LTT_LATE_FEE</taborder><taborder>button3</taborder><taborder>LTT_PENALTY_PAIDED_SUM</taborder></root>" dj_sn="20100927105913687545" caption="罚款措施执行情况" mkbh codeheader="BBB" entertype="修改" poswidth posheight controlno="SKButton:0;SKDBedit:0;checkbox:0;label:0;radio:0;listbox:0;textarea:1;combobox:1;password:0;upload:0;SKDBtext:0;chart:0;dbimg:0;img:0;SKBILLgrid:0;shape:0;tab:0;div:0;DsMain_field:0;a:0;button:3;text:7;hr:0;checkboxlist:0;radiolist:0;dropdownlist:0;grid:0;dataset:1;spin:0;excel:0;tree:0;ebshow:0;creatorSubForm:0;creator_div:0;ExtGrid:1;ExtUpload:0;ExtTree:0;Fusionchar:0" window="当前窗口" posleft postop keyfield isfile="否" OtherSave="否" idtype="1" testDbName="app_xzcf" creatorStyle="creatorBlue" BLONclose="UnLoadWebOffice();" creator_remark hasWorkflowButton="否" creator_elementAuthoritySwitch="否" creator_showAlert="否" creator_office_isBindForm="否" islog="否" isprotect="是" creator_csslib version="1.0" creator_pagination type="ZW" creatorType="20100902181230265751" jslib="fcbasecont.js&#13;&#10;selectdate.js&#13;&#10;~userfunc.js&#13;&#10;fcdate.js&#13;&#10;../../../ccapp/app_xzcf/js/util/WorkflowUtil.js&#13;&#10;../../../ccapp/app_xzcf/js/common/Common.js&#13;&#10;../../../ccapp/app_xzcf/js/util/WorkflowUtil.js&#13;&#10;../../../ccapp/app_xzcf/js/business/ExecuteState.js&#13;&#10;../../../ccapp/app_xzcf/js/dao/ExecuteStateDao.js">

<TABLE cellSpacing=0 cellPadding=0 width="95%" align=center border=0>
   <TBODY>
      <TR>
         <TD>
            <TABLE cellSpacing=0 cellPadding=0 width="100%" border=1>
               <TBODY>
                  <TR>
                     <TD class=taobox colSpan=4>处罚措施执行情况</TD>
                  </TR>
                  <TR>
                     <TD class=c2 width="15%">处罚措施</TD>
                     <TD width="30%"><INPUT id=PM_NAME style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text"></TD>
                     <TD class=c2 width="15%">履行期限</TD>
                     <TD width="30%"><INPUT id=TIME_OF_PERFORMANCE style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text"></TD>
                  </TR>
                  <TR>
                     <TD class=c2 width="15%">执行状态</TD>
                     <TD width="30%"><SELECT id=EXECUTING_STATE style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() sqltrans controltype="combobox" tempvalue="0&#13;&#10;1&#13;&#10;2" temptext="未执行&#13;&#10;执行中&#13;&#10;已执行" sql check="1"><OPTION value=0 selected>未执行</OPTION><OPTION value=1>执行中</OPTION><OPTION value=2>已执行</OPTION></SELECT></TD>
                     <TD class=c2 width="15%">执行时间</TD>
                     <TD width="30%"><INPUT id=EXECUTING_DATE style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text"></TD>
                  </TR>
                  <TR>
                     <TD class=c2 width="15%">应缴金额</TD>
                     <TD width="30%"><INPUT id=LTT_PENALTY_SUM style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly controltype="text"></TD>
                     <TD class=c2 width="15%">实缴金额</TD>
                     <TD class=input_out id=text5 onblur="this.className='input_off';this.onmouseout=function(){this.className='input_out'};" style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 20px" onfocus="this.className='input_on';this.onmouseout='" onmovestart=moveStart() onmouseout="this.className='input_out'" width="30%" controltype="text" this.className="input_move" ?><INPUT id=LTT_PENALTY_PAIDED_SUM style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text"></TD>
                  </TR>
                  <TR>
                     <TD class=c2 width="15%">滞纳金</TD>
                     <TD width="30%"><INPUT class=input_out onmousemove="this.className='input_move'" id=LTT_LATE_FEE onblur="this.className='input_off';this.onmouseout=function(){this.className='input_out'};" style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 20px" onfocus="this.className='input_on';this.onmouseout='" onmovestart=moveStart() onmouseout="this.className='input_out'" controltype="text"></TD>
                  </TR>
                  <TR>
                     <TD class=c2 width="15%">罚款收据明细</TD>
                     <TD colSpan=3><IMG style="DISPLAY: none" src="undefined"><DIV id=div_ExtGrid1 style="LEFT: 0px; POSITION: static; TOP: 0px"></DIV><SCRIPT type=text/javascript>var ExtGrid1;
Ext.BLANK_IMAGE_URL = '../../fceform/js/Ext/images/default/s.gif';
var ExtGrid1_retint = 0;
var ExtGrid1_onReady = function(){ 
 Ext.QuickTips.init();
var dataset = document.getElementById("punishMeasureDataset");
try{var temp = dataset.Fields.Field.length;}catch(e){if(ExtGrid1_retint==0) ExtGrid1_retint = setInterval(ExtGrid1_onReady,200);dataset =null;return;}finally{if(temp!=null)temp=null;}
clearInterval(ExtGrid1_retint);ExtGrid1_retint = null ;var pagesize =20;
dataset.PageSize = pagesize ;
var mapping = creator_pt_getmapping(dataset);
var store  = new Ext.data.Store({
	proxy: new Ext.data.CreatorMemoryProxy("punishMeasureDataset"), 
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
		title:'收据列表',
		frame:true
		,plugins: new Ext.ux.PanelResizer({
            minHeight: 100        }),
       bbar: new Ext.PagingToolbar({
            pageSize: pagesize,
            store: store,
            displayInfo: true,
            displayMsg:'当前显示第 {0} - {1} 条，共 {2} 条',            plugins: new Ext.ux.SlidingPager()        })		    });
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
ExtGrid1.render();
store.load({params:{start:0, limit:pagesize}});
if(typeof(creator_pt_grids)=='undefined'){creator_pt_grids=new Array();}
creator_pt_grids.push({id:'ExtGrid1',obj:ExtGrid1,dataset:'punishMeasureDataset',isEdit:'false'});
if(typeof(onGridPanelLoaded)=='function') setTimeout(onGridPanelLoaded,0);
};
ExtGrid1_onReady();</SCRIPT><BUTTON id=button3 style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="否" controltype="button">添加收据</BUTTON></TD>
                  </TR>
                  <TR>
                     <TD class=c2 width="15%">执行情况</TD>
                     <TD colSpan=3><TEXTAREA class=input_out onmousemove="this.className='input_move'" id=executeInfo onblur="this.className='input_off';this.onmouseout=function(){this.className='input_out'};" style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 85px" onfocus="this.className='input_on';this.onmouseout='" onmovestart=moveStart() onmouseout="this.className='input_out'" controltype="textarea" value="textarea1" induce="否"></TEXTAREA></TD>
                  </TR>
               </TBODY>
            </TABLE>
         </TD>
      </TR>
      <TR>
         <TD align=middle><BUTTON class=button id=button1 style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="否" controltype="button">保存</BUTTON><BUTTON class=button id=button2 style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="否" controltype="button">返回</BUTTON></TD>
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

<?xml:namespace prefix = fc />

<fc:dataset id=punishMeasureDataset format="<fields><field><fieldname>PM_ID</fieldname><datatype>字符</datatype><displaylabel>处罚措施ID</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>PM_NAME</fieldname><datatype>字符</datatype><displaylabel>处罚措施</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>TIME_OF_PERFORMANCE</fieldname><datatype>字符</datatype><displaylabel>履行期限</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>EXECUTING_STATE</fieldname><datatype>字符</datatype><displaylabel>执行状态</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>EXECUTING_DATE</fieldname><datatype>字符</datatype><displaylabel>执行时间</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>EL_LATE_FEE_ITEM</fieldname><datatype>字符</datatype><displaylabel>是否滞纳金</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>LTT_PENALTY_SUM</fieldname><datatype>字符</datatype><displaylabel>罚款金额</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>LTT_PENALTY_PAIDED_SUM</fieldname><datatype>字符</datatype><displaylabel>罚款已付金额</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>LTT_LATE_FEE</fieldname><datatype>字符</datatype><displaylabel>滞纳金</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field></fields>" onSetText='bill_ondatasetsettext("<dsid><PM_ID></PM_ID><PM_NAME></PM_NAME><TIME_OF_PERFORMANCE></TIME_OF_PERFORMANCE><EXECUTING_STATE></EXECUTING_STATE><EXECUTING_DATE></EXECUTING_DATE><EL_LATE_FEE_ITEM></EL_LATE_FEE_ITEM><LTT_PENALTY_SUM></LTT_PENALTY_SUM><LTT_PENALTY_PAIDED_SUM></LTT_PENALTY_PAIDED_SUM><LTT_LATE_FEE></LTT_LATE_FEE></dsid>")' onGetText='bill_ondatasetgettext("<dsid><PM_ID></PM_ID><PM_NAME></PM_NAME><TIME_OF_PERFORMANCE></TIME_OF_PERFORMANCE><EXECUTING_STATE></EXECUTING_STATE><EXECUTING_DATE></EXECUTING_DATE><EL_LATE_FEE_ITEM></EL_LATE_FEE_ITEM><LTT_PENALTY_SUM></LTT_PENALTY_SUM><LTT_PENALTY_PAIDED_SUM></LTT_PENALTY_PAIDED_SUM><LTT_LATE_FEE></LTT_LATE_FEE></dsid>")' onValid='bill_ondatasetvalid("<dsid><PM_ID></PM_ID><PM_NAME></PM_NAME><TIME_OF_PERFORMANCE></TIME_OF_PERFORMANCE><EXECUTING_STATE></EXECUTING_STATE><EXECUTING_DATE></EXECUTING_DATE><EL_LATE_FEE_ITEM></EL_LATE_FEE_ITEM><LTT_PENALTY_SUM></LTT_PENALTY_SUM><LTT_PENALTY_PAIDED_SUM></LTT_PENALTY_PAIDED_SUM><LTT_LATE_FEE></LTT_LATE_FEE></dsid>")' opensortno="1" temptable="TMP_DATASET1" multiResult="是"></fc:dataset>
</DIV>
<div id='grid_tip'></div></body></html>
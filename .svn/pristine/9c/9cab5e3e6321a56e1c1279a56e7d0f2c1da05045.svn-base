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
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/common/Common.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/common/Common.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/business/Wfxw.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/business/Wfxw.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/dao/WfxwDao.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/dao/WfxwDao.js'></script>");
if(!bDgMode) out.println("</script>");
%>

   <script >document.styleSheets[0].addRule("fc\\:dataset","behavior: url(../../fceform/htc/dataset.htc)",0);</script>
   <script language='javascript'>
adv_loadjsfile('/eformsys/fceform/css/tabstyle.css');
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
function init(){
    cf_queryWfxw();
}

function cf_queryWfxw(){
    var rmdCodeValue= $("rmdCode").value.trim();
    var rmdTypeValue= $("rmdType").value;
    var businessTypeValue= $("businessType").value;
    var ruleMatterValue= $("ruleMatter").value.trim();
    var rmdStatusValue = "";
    var tmp = document.getElementsByName('RMD_STATUS');
    if (tmp[0].checked) {
        rmdStatusValue = tmp[0].value ;
    } else if (tmp[1].checked) {
        rmdStatusValue = tmp[1].value ;
    } else {
        rmdStatusValue = -1 ;
    }
    var pagePrams = {
      rmdCode : rmdCodeValue,
      rmdType : rmdTypeValue,
      businessType : businessTypeValue,
      ruleMatter : ruleMatterValue,
      rmdStatus : rmdStatusValue 
    }
    var sql = Wfxw.queryWfxw(pagePrams);
    wfxwdataset.Open(sql);
    reloadExtGrid();
}

function cf_WfxwReset(){
    ${'rmdCode'}.value="";
    ${'rmdType'}.value=-1;
    ${'businessType'}.value=-1;
    ${'ruleMatter'}.value="";
    var status = document.getElementsByName('RMD_STATUS');
    status[0].checked = true ;
}
function expWfxwExcel(){

}

function addWfxw (){
    window.location.href = "20100903113849656869.jsp";
    //var tempPara="dialogWidth:760px;dialogHeight:400px;";
    //var tempURL="20100903113849656869.jsp";
    //showModalDialog(tempURL,"window",tempPara);
    //reloadExtGrid();
}

//双击进入违法行为修改
function editWfxw(grid, rowIndex, e){
    var row = grid.store.getById(grid.store.data.items[rowIndex].id); 
    var rmdId = row.get("rmd_id");
    window.location.href = "20100903113849656869.jsp?rmdId="+rmdId;
    //var tempPara="dialogWidth:760px;dialogHeight:400px;";
    //var tempURL="20100903113849656869.jsp?rmdId="+rmdId;
    //showModalDialog(tempURL,"window",tempPara);
}

function delWfxw(){
    var grid =  creator_pt_grids[0].obj;
    var ids = FormUtil.getExtGridSelectedIds("RMD_ID", grid);
    var quote_ids = FormUtil.getExtGridSelectedIds("quoted_id", grid);
    if(ids.length==0){    
       alert("请选择要删除的记录！");
       return false;
    } else {
       var flag = false;
       for (var i=0;i<quote_ids.length;i++) {
           if (Number(quote_ids[i])==1) {
               flag = true;
               break;
           }
       }
       var str = "";
       if (flag) {
           str = "所选数据中有包含被引用的数据，删除后数据会失效，是否继续？";
       } else {
           str = "是否删除所选数据？";
       }
       if (confirm(str)) {
           var rv = Wfxw.delWfxw(ids);
           if(rv){
              alert("删除数据信息成功！");
              init();
           }else{
              alert("删除数据信息失败！");
           }
       }
    }
}

//excel导出
function excelExport(){
    var title = "违法行为信息";//标题
     var OC_NAME="违法类别";
    var RMD_NAME="违法行为";
    var RMD_CODE="违法行为编码";
    var RMD_RULE="处罚依据";
    var RMD_MODIFY_DATE="最新修改时间";
    var VC_NAME="行业分类";
    var RMD_STATUS="状态";
  //以上几个变量名与模板的字段头一致
    var id = "WfxwExport";
  //上面的id为配置文件对应的<exportModule id>
    var rmdCode = $("rmdCode").value;//违法行为编码
     var rmdType = $("rmdType").value;//违法类别
    var businessType = $("businessType").value;//行业分类
    var ruleMatter = $("ruleMatter").value.trim();//违法行为
    var rmdStatusValue = "";//状态
    var tmp = document.getElementsByName('RMD_STATUS');
    if (tmp[0].checked) {
        rmdStatusValue = tmp[0].value ;
    } else if (tmp[1].checked) {
        rmdStatusValue = tmp[1].value ;
    } else {
        rmdStatusValue = -1 ;
    }
  var url="<%=request.getContextPath() %>/ccapp/app_xzcf/excel/jsp/poiCommond.jsp";
  url+="?title="+title+"&OC_NAME="+OC_NAME+"&RMD_NAME="+RMD_NAME+"&RMD_CODE="+RMD_CODE;
  url+="&RMD_RULE="+RMD_RULE+"&RMD_MODIFY_DATE="+RMD_MODIFY_DATE+"&VC_NAME="+VC_NAME+"&RMD_STATUS="+RMD_STATUS+"&id="+id;
  url+="&rmdCode="+rmdCode+"&rmdType="+rmdType+"&businessType="+businessType+"&ruleMatter="+ruleMatter+"&rmdStatusValue="+rmdStatusValue;
  window.location.href=url;
}
</script>

<!-- 提示：以下为页面DOM元素内容 -->
<DIV id=SKbillsheet style="visibility:hidden" toolbar="不带工具栏" BLONopen="setAuthority();init();" contxml="<root><combobox><id>rmdType</id><id>businessType</id></combobox><button><id>qryBtn</id><id>rstBtn</id><id>expExcel</id><id>newBtn</id><id>delBtn</id></button><text><id>rmdCode</id><id>ruleMatter</id></text><dataset><id>wfxwdataset</id></dataset><ExtGrid><id>wfxwGrid</id></ExtGrid></root>" billtaborder="<root><taborder>businessType</taborder><taborder>qryBtn</taborder><taborder>rstBtn</taborder><taborder>expExcel</taborder><taborder>newBtn</taborder><taborder>delBtn</taborder><taborder>rmdType</taborder><taborder>rmdCode</taborder><taborder>ruleMatter</taborder></root>" dj_sn="20100904111809718054" caption="违法行为查询" mkbh codeheader="BBB" entertype="展现" poswidth posheight controlno="SKButton:0;SKDBedit:0;checkbox:0;label:0;radio:0;listbox:0;textarea:0;combobox:0;password:0;upload:0;SKDBtext:0;chart:0;dbimg:0;img:0;SKBILLgrid:0;shape:0;tab:0;div:0;DsMain_field:0;a:0;button:0;text:2;hr:0;checkboxlist:0;radiolist:0;dropdownlist:0;grid:0;dataset:0;spin:0;excel:0;tree:0;ebshow:0;creatorSubForm:0;creator_div:0;ExtGrid:2;ExtUpload:0;ExtTree:0;Fusionchar:0" window="当前窗口" posleft postop keyfield isfile="否" OtherSave="否" idtype="1" testDbName="app_xzcf" creatorStyle="creatorBlue" BLONclose="UnLoadWebOffice();" creator_remark hasWorkflowButton="否" creator_elementAuthoritySwitch="否" creator_showAlert="是" creator_office_isBindForm="否" islog="否" isprotect="是" creator_csslib version="1.0" creator_pagination type="ZW" creatorType="20100902181525484338" jslib="fcsavedj.js&#13;&#10;fcbasecont.js&#13;&#10;selectdate.js&#13;&#10;~userfunc.js&#13;&#10;fcdate.js&#13;&#10;../../../ccapp/app_xzcf/js/common/Common.js&#13;&#10;../../../ccapp/app_xzcf/js/business/Wfxw.js&#13;&#10;../../../ccapp/app_xzcf/js/dao/WfxwDao.js">

<TABLE cellSpacing=0 cellPadding=0 width="95%" align=center border=0>
   <TBODY>
      <TR>
         <TD>
            <TABLE class=Ctable cellSpacing=0 cellPadding=0 width="100%" border=0>
               <TBODY>
                  <TR>
                     <TD class=taobox colSpan=4>&nbsp;违法行为信息查询</TD>
                  </TR>
                  <TR>
                     <TD class=c2 width="15%">违法行为编码</TD>
                     <TD width="35%"><INPUT class=input_out id=rmdCode style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text"></TD>
                     <TD class=c2>违法类别</TD>
                     <TD width="35%"><SELECT id=rmdType style="LEFT: 0px; WIDTH: 135px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() sqltrans="%F4%D8%E6%D8%D4%F6Xrn%AC%94%CC%A0%96Xr%94Xrn%AC%94%CC%AA%90%A8%98Xrn%DA%F2%EC%E8Xrn%B6%90%CC%AC%9A%9A%98%AA%B4%98%CC%94%90%B6%98%9C%AC%B2%C0Xrn%EC%F2%D6%D8%F2Xrn%D2%u0100Xrn%AC%94%CC%AC%B2%96%98%B2" controltype="combobox" tempvalue="-1" temptext="--请选择--" sql check="1"><OPTION value=-1 selected>--请选择--</OPTION></SELECT></TD>
                  </TR>
                  <TR>
                     <TD class=c2>行业分类</TD>
                     <TD width="35%"><SELECT id=businessType style="LEFT: 0px; WIDTH: 120px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() name=select sqltrans="%F4%D8%E6%D8%D4%F6Xrn%BA%94%CC%A0%96Xr%94%BA%94%CC%AA%90%A8%98Xrn%DA%F2%EC%E8Xrn%B6%90%CC%BA%AC%94%90%B6%A0%AC%AA%CC%94%AC%AA%B4%B6%A0%B6%B8%B6%AC%B2Xrn%EC%F2%D6%D8%F2Xrn%D2%u0100Xrn%BA%94%CC%AC%B2%96%98%B2" controltype="combobox" tempvalue="-1" temptext="--请选择--" sql check="1"><OPTION value=-1 selected>--请选择--</OPTION></SELECT></TD>
                     <TD class=c2>违法行为</TD>
                     <TD width="35%"><INPUT class=input_out id=ruleMatter style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text"></TD>
                  </TR>
                  <TR>
                     <TD class=c2 width="15%">状态</TD>
                     <TD colSpan=3><INPUT type=radio CHECKED value=1 name=RMD_STATUS>有效<INPUT type=radio value=0 name=RMD_STATUS>无效<INPUT type=radio value=-1 name=RMD_STATUS>全部</TD>
                  </TR>
               </TBODY>
            </TABLE>
         </TD>
      </TR>
      <TR>
         <TD><DIV align=center><BUTTON class=button id=qryBtn style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("cf_queryWfxw()")'>查询</BUTTON><BUTTON class=button id=rstBtn style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("cf_WfxwReset()")'>重置</BUTTON><BUTTON class=button id=expExcel style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("excelExport();")'>导出EXCEL</BUTTON></DIV></TD>
      </TR>
      <TR>
         <TD align=right><BUTTON class=addbutton1 id=newBtn style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("addWfxw ()")'>新增</BUTTON><BUTTON class=sbutton1 id=delBtn style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("delWfxw()")'>删除</BUTTON></TD>
      </TR>
      <TR>
         <TD>&nbsp;<IMG style="DISPLAY: none" src="undefined"><DIV id=div_wfxwGrid style="LEFT: 0px; POSITION: static; TOP: 0px"></DIV><SCRIPT type=text/javascript>var wfxwGrid;
Ext.BLANK_IMAGE_URL = '../../fceform/js/Ext/images/default/s.gif';
var wfxwGrid_retint = 0;
var wfxwGrid_onReady = function(){ 
 Ext.QuickTips.init();
var dataset = document.getElementById("wfxwdataset");
try{var temp = dataset.Fields.Field.length;}catch(e){if(wfxwGrid_retint==0) wfxwGrid_retint = setInterval(wfxwGrid_onReady,200);dataset =null;return;}finally{if(temp!=null)temp=null;}
clearInterval(wfxwGrid_retint);wfxwGrid_retint = null ;var pagesize =10;
dataset.PageSize = pagesize ;
var mapping = creator_pt_getmapping(dataset);
var store  = new Ext.data.Store({
	proxy: new Ext.data.CreatorMemoryProxy("wfxwdataset"), 
	reader: new Ext.data.XmlStringReader({       record: 'tr',       totalRecords: 'pages'   }, mapping)});
var sm = new Ext.grid.RowSelectionModel({singleSelect: true});
var retcm = creator_pt_getcm(dataset,sm);var cm = new Ext.grid.ColumnModel(retcm);
if(typeof(retcm[0].getCount)!='undefined') sm = retcm[0] ;
 wfxwGrid = new Ext.grid.GridPanel({
		el: 'div_wfxwGrid',        store: store,
        cm:cm,
		sm: sm,
 			 bodyStyle : 'width:100%',
		viewConfig: {
			forceFit: true		},       loadMask: true,
	width: '100%',
					height: eval(document.body.clientHeight*(parseFloat('60%')))/100,
		split: true,
		region: 'north',
		title:'查询结果列表',
		frame:true
		,plugins: new Ext.ux.PanelResizer({
            minHeight: 100        }),
       bbar: new Ext.PagingToolbar({
            pageSize: pagesize,
            store: store,
            displayInfo: true,
            displayMsg:'当前显示第 {0} - {1} 条，共 {2} 条',            plugins: new Ext.ux.SlidingPager()        })		    });
    var grid=wfxwGrid;
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
cm.setHidden(6,true);
cm.setHidden(10,true);
grid.addListener('rowdblclick', editWfxw);wfxwGrid.render();
store.load({params:{start:0, limit:pagesize}});
if(typeof(creator_pt_grids)=='undefined'){creator_pt_grids=new Array();}
creator_pt_grids.push({id:'wfxwGrid',obj:wfxwGrid,dataset:'wfxwdataset',isEdit:'false'});
if(typeof(onGridPanelLoaded)=='function') setTimeout(onGridPanelLoaded,0);
};
wfxwGrid_onReady();window.onresize=function(){try{wfxwGrid.setWidth(eval(document.body.clientWidth*(parseFloat('95%')))/100);}catch(e){}};</SCRIPT></TD>
      </TR>
   </TBODY>
</TABLE>

<?xml:namespace prefix = fc />

<fc:dataset id=wfxwdataset showtypeXml="<root><showType><name>checked</name><showRule>%5B%7Bshowtype%3A%27checkbox%27%7D%5D</showRule></showType><showType><name>RMD_ID</name><showRule>undefined</showRule></showType><showType><name>VC_ID</name><showRule>undefined</showRule></showType></root>" columnHeight1Xml="undefined" columnWidth1Xml="undefined" format="<fields><field><fieldname>checked</fieldname><datatype>字符</datatype><displaylabel>全选</displaylabel><size>30</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype><showRule>%5B%7Bshowtype%3A%27checkbox%27%7D%5D</showRule></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>OC_NAME</fieldname><datatype>字符</datatype><displaylabel>违法类别</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>RMD_NAME</fieldname><datatype>字符</datatype><displaylabel>违法行为</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>RMD_CODE</fieldname><datatype>字符</datatype><displaylabel>违法行为编码</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>RMD_RULE</fieldname><datatype>字符</datatype><displaylabel>处罚依据</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>RMD_MODIFY_DATE</fieldname><datatype>字符</datatype><displaylabel>最新修改时间</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat>yyyy-mm-dd</displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>RMD_ID</fieldname><datatype>字符</datatype><displaylabel>违法行为ID</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>否</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype><showRule>undefined</showRule></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>VC_NAME</fieldname><datatype>字符</datatype><displaylabel>行业分类</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>否</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>RMD_STATUS</fieldname><datatype>字符</datatype><displaylabel>状态</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>IS_QUOTED</fieldname><datatype>字符</datatype><displaylabel>是否被引用</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>QUOTED_ID</fieldname><datatype>字符</datatype><displaylabel>是否被引用标识</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field></fields>" onSetText='bill_ondatasetsettext("<dsid><checked></checked><OC_NAME></OC_NAME><RMD_NAME></RMD_NAME><RMD_CODE></RMD_CODE><RMD_RULE></RMD_RULE><RMD_MODIFY_DATE></RMD_MODIFY_DATE><RMD_ID></RMD_ID><VC_NAME></VC_NAME><RMD_STATUS></RMD_STATUS><IS_QUOTED></IS_QUOTED><QUOTED_ID></QUOTED_ID></dsid>")' onGetText='bill_ondatasetgettext("<dsid><checked></checked><OC_NAME></OC_NAME><RMD_NAME></RMD_NAME><RMD_CODE></RMD_CODE><RMD_RULE></RMD_RULE><RMD_MODIFY_DATE></RMD_MODIFY_DATE><RMD_ID></RMD_ID><VC_NAME></VC_NAME><RMD_STATUS></RMD_STATUS><IS_QUOTED></IS_QUOTED><QUOTED_ID></QUOTED_ID></dsid>")' onValid='bill_ondatasetvalid("<dsid><checked></checked><OC_NAME></OC_NAME><RMD_NAME></RMD_NAME><RMD_CODE></RMD_CODE><RMD_RULE></RMD_RULE><RMD_MODIFY_DATE></RMD_MODIFY_DATE><RMD_ID></RMD_ID><VC_NAME></VC_NAME><RMD_STATUS></RMD_STATUS><IS_QUOTED></IS_QUOTED><QUOTED_ID></QUOTED_ID></dsid>")' opensortno="1" temptable="TMP_DATASET1" multiResult="是"></fc:dataset>
</DIV>
<div id='grid_tip'></div></body></html>
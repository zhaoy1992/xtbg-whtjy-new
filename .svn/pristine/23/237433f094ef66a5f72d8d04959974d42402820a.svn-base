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
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/common/Common.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/common/Common.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/business/PunishInsConfig.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/business/PunishInsConfig.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/dao/PunishInsConfigDao.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/dao/PunishInsConfigDao.js'></script>");
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
<%@page import="com.chinacreator.xzcf.baseservice.menu.OrgAccessUtil "%>
<%
OrgAccessUtil orgAccess = new OrgAccessUtil();
String queryName = "";//能够访问的执法主体IDS
if (!"1".equals(accesscontroler.getUserID())) {
    queryName = orgAccess.getBuIdByOrgIds(accesscontroler.getUserID()) ;
} else {
    queryName = orgAccess.getAllBuIds();
}
%>
var buId = creator_getQueryString("buId");
var buName = creator_getQueryString("resourceName");
var adId = creator_getQueryString("adId");
var USER_ID = getSysElement("userid");

function init() {
    if (!IsSpace(adId)) {
        var buIds = "<%=queryName%>";
        buId = PunishInsConfig.queryUnitId(adId,buIds);
    } else {
        if (IsSpace(buName)) {
            buId = "<%=queryName%>";
        }
    }
    if (IsSpace(buName)) {
        $("addBtn").style.visibility = "hidden";
        $("selWsConf").style.visibility = "hidden";
    }
    queryInsConfigList();
}

/*
    函数:   queryInsConfigList
    说明:   查询文书列表
    参数:    buId (执法主体ID),
            rflName(文书名称),
            piName(事项名称),
    返回值: 无
*/
function queryInsConfigList() {

    var rflName = $("RFL_NAME").value;//文书名称
    var piName = $("PI_NAME").value.trim();//事项名称
    var parms = {
        buId : buId,
        rflName : rflName,
        piName : piName
    }

    var sql = PunishInsConfig.queryInsConfigList(parms);
    InsConfigDataset.Open(sql);
    reloadExtGrid();

}

function resetWay() {
    $("RFL_NAME").value = "";
    $("PI_NAME").value = "";
}

//双击进入文书修改
function editWsxg(grid, rowIndex, e){
    var row = grid.store.getById(grid.store.data.items[rowIndex].id); 
    var rflId = row.get("rfl_id");
    var piId = row.get("pi_id");
    var piName = row.get("pi_name");
    buId = row.get("bu_id");
    buName = row.get("bu_name");
    window.location.href = "20101118162152671015.jsp?rflId="+rflId+"&buName="+buName+"&buId="+buId+"&piId="+piId+"&piName="+piName;
}

//新增文书
function newWs(){
    window.location.href = "20101118162152671015.jsp?buName="+buName+"&buId="+buId;
}

//选择文书配置
function defineWs(){
    window.location.href = "20101213151728671768.jsp?buName="+buName+"&buId="+buId;
}


//删除文书
function delWs(){
    var grid =  creator_pt_grids[0].obj;
    var ids = FormUtil.getExtGridSelectedIds("RFL_ID", grid);
    var pi_ids = FormUtil.getExtGridSelectedIds("PI_ID", grid);
    if(ids.length==0){    
       alert("请选择要删除的记录！");
       return false;
    } else {
       if (confirm("是否删除所选数据？")) {
           var rv = PunishInsConfig.delInsConfig(ids, pi_ids);
           if(rv){
              alert("删除数据信息成功！");
              reloadExtGrid();
           }else{
              alert("删除数据信息失败！");
           }
       }
    }
}

//事项配置
function piLoad(){
    var tempPara="dialogWidth:760px;dialogHeight:400px;";
    var tempURL="20101013144720390036.jsp?USER_ID="+USER_ID+"&BU_ID="+buId;
    var rtn = showModalDialog(tempURL,window,tempPara);
    if (!IsSpace(rtn)) {
        document.getElementById("PI_NAME").value = rtn.names;
        document.getElementById("PI_ID").value = rtn.ids; 
    }
}

</script>

<!-- 提示：以下为页面DOM元素内容 -->
<DIV id=SKbillsheet style="visibility:hidden" toolbar="不带工具栏" BLONopen="setAuthority();init();" contxml="<root><img><id>img2</id></img><div><id>div1</id></div><button><id>selBtn</id><id>resetBtn</id><id>addBtn</id><id>selWsConf</id><id>delBtn</id></button><text><id>RFL_NAME</id><id>PI_NAME</id><id>PI_ID</id></text><dataset><id>InsConfigDataset</id></dataset><ExtGrid><id>ExtGrid1</id></ExtGrid></root>" billtaborder="<root><taborder>RFL_NAME</taborder><taborder>PI_NAME</taborder><taborder>selBtn</taborder><taborder>resetBtn</taborder><taborder>addBtn</taborder><taborder>delBtn</taborder><taborder>selWsConf</taborder><taborder>PI_ID</taborder></root>" dj_sn="20101117093210421448" caption="事项文书列表" mkbh codeheader="BBB" entertype="修改" poswidth posheight controlno="SKButton:0;SKDBedit:0;checkbox:0;label:0;radio:0;listbox:0;textarea:0;combobox:1;password:0;upload:0;SKDBtext:0;chart:0;dbimg:0;img:0;SKBILLgrid:0;shape:0;tab:0;div:1;DsMain_field:0;a:0;button:7;text:3;hr:0;checkboxlist:0;radiolist:0;dropdownlist:0;grid:0;dataset:4;spin:0;excel:0;tree:0;ebshow:0;creatorSubForm:0;creator_div:0;ExtGrid:1;ExtUpload:0;ExtTree:0;Fusionchar:0" window="当前窗口" posleft postop keyfield isfile="否" OtherSave="否" idtype="1" testDbName="app_xzcf" creatorStyle="creatorBlue" BLONclose="UnLoadWebOffice();" creator_remark hasWorkflowButton="否" creator_elementAuthoritySwitch="否" creator_showAlert="否" creator_office_isBindForm="否" islog="否" isprotect="是" creator_csslib version="1.0" creator_pagination type="ZW" creatorType="20101117093013703020" jslib="fcbasecont.js&#13;&#10;selectdate.js&#13;&#10;~userfunc.js&#13;&#10;fcdate.js&#13;&#10;../../../ccapp/app_xzcf/js/common/Common.js&#13;&#10;../../../ccapp/app_xzcf/js/business/PunishInsConfig.js&#13;&#10;../../../ccapp/app_xzcf/js/dao/PunishInsConfigDao.js">

<TABLE style="POSITION: static" cellSpacing=2 cellPadding=1 width="100%" align=left border=0>
   <TBODY>
      <TR>
         <TD>
            <TABLE class=Ctable width="100%">
               <TBODY>
                  <TR>
                     <TD class=taobox>文书配置</TD>
                  </TR>
               </TBODY>
            </TABLE>
         </TD>
      </TR>
      <TR>
         <TD>
            <TABLE class=Ctable style="POSITION: static" cellSpacing=2 cellPadding=1 width="100%" align=left border=0>
               <TBODY>
                  <TR>
                     <TD class=c2 width="15%">文书名称</TD>
                     <TD colSpan=3><INPUT class=input_out id=RFL_NAME style="LEFT: 0px; WIDTH: 80%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text"></TD>
                  </TR>
                  <TR>
                     <TD class=c2>处罚事项名称</TD>
                     <TD colSpan=3><INPUT class=input_out id=PI_NAME style="LEFT: 0px; WIDTH: 80%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text"><IMG id=img2 style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() src="../../../ccapp/app_xzcf/images/search12.gif" controltype="img" onclick='bill_onclick("piLoad()")' cover="9" srcsk="../../../ccapp/app_xzcf/images/search12.gif"><INPUT id=PI_ID style="DISPLAY: none; LEFT: 0px; WIDTH: 48px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=8 controltype="text"></TD>
                  </TR>
               </TBODY>
            </TABLE>
         </TD>
      </TR>
      <TR>
         <TD align=middle><BUTTON class=button id=selBtn style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() align="middle" dropstyle="否" controltype="button" onclick='bill_onclick("queryInsConfigList()")'>查询</BUTTON><BUTTON class=button id=resetBtn style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("resetWay();")'>重置</BUTTON></TD>
      </TR>
      <TR>
         <TD align=right><BUTTON class=addbutton1 id=addBtn style="LEFT: 0px; MARGIN: 3px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("newWs()")'>新增</BUTTON><BUTTON class=selectbutton1 id=selWsConf style="LEFT: 0px; MARGIN: 3px; POSITION: static; TOP: 0px; HEIGHT: 27px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("defineWs()")'>选择文书配置</BUTTON><BUTTON class=sbutton1 id=delBtn style="LEFT: 0px; MARGIN: 3px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("delWs()")'>删除</BUTTON></TD>
      </TR>
      <TR>
         <TD><DIV id=div1 style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; LEFT: 0px; OVERFLOW: auto; BORDER-LEFT: 0px; WIDTH: 100%; BORDER-BOTTOM: 0px; POSITION: static; TOP: 0px; HEIGHT: 360px; BACKGROUND-COLOR: #ffffff" onmovestart=moveStart() controltype="div" NotBg="否"><IMG style="DISPLAY: none" src="undefined"><DIV id=div_ExtGrid1 style="LEFT: 0px; POSITION: static; TOP: 0px"></DIV><SCRIPT type=text/javascript>var ExtGrid1;
Ext.BLANK_IMAGE_URL = '../../fceform/js/Ext/images/default/s.gif';
var ExtGrid1_retint = 0;
var ExtGrid1_onReady = function(){ 
 Ext.QuickTips.init();
var dataset = document.getElementById("InsConfigDataset");
try{var temp = dataset.Fields.Field.length;}catch(e){if(ExtGrid1_retint==0) ExtGrid1_retint = setInterval(ExtGrid1_onReady,200);dataset =null;return;}finally{if(temp!=null)temp=null;}
clearInterval(ExtGrid1_retint);ExtGrid1_retint = null ;var pagesize =10;
dataset.PageSize = pagesize ;
var mapping = creator_pt_getmapping(dataset);
var store  = new Ext.data.Store({
	proxy: new Ext.data.CreatorMemoryProxy("InsConfigDataset"), 
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
	width: '100%',
					height: eval(parseFloat(document.getElementById('div1').style.height)*(parseFloat('100%')))/100-60,
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
cm.setHidden(4,true);
cm.setHidden(5,true);
cm.setHidden(7,true);
grid.addListener('rowdblclick', editWsxg);ExtGrid1.render();
store.load({params:{start:0, limit:pagesize}});
if(typeof(creator_pt_grids)=='undefined'){creator_pt_grids=new Array();}
creator_pt_grids.push({id:'ExtGrid1',obj:ExtGrid1,dataset:'InsConfigDataset',isEdit:'false'});
if(typeof(onGridPanelLoaded)=='function') setTimeout(onGridPanelLoaded,0);
};
ExtGrid1_onReady();</SCRIPT></DIV></TD>
      </TR>
   </TBODY>
</TABLE>

<?xml:namespace prefix = fc />

<fc:dataset id=InsConfigDataset showtypeXml="<root><showType><name>checked</name><showRule>%5B%7Bshowtype%3A%27checkbox%27%7D%5D</showRule></showType></root>" columnHeight1Xml="<root><columnHeight1><name>RFL_STATUS</name><columnHeight2></columnHeight2></columnHeight1><columnHeight1><name>NDP_NAME</name><columnHeight2>10</columnHeight2></columnHeight1></root>" columnWidth1Xml="<root><columnWidth1><name>PI_NAME</name><columnWidth2>35</columnWidth2></columnWidth1><columnWidth1><name>RFL_NAME</name><columnWidth2>35</columnWidth2></columnWidth1><columnWidth1><name>checked</name><columnWidth2>10</columnWidth2></columnWidth1><columnWidth1><name>RFL_STATUS</name><columnWidth2>10</columnWidth2></columnWidth1><columnWidth1><name>NDP_NAME</name><columnWidth2>10</columnWidth2></columnWidth1></root>" format="<fields><field><fieldname>checked</fieldname><datatype>字符</datatype><displaylabel>全选</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype><showRule>%5B%7Bshowtype%3A%27checkbox%27%7D%5D</showRule></showtype><columnHeight1></columnHeight1><columnWidth1><columnWidth2>10</columnWidth2></columnWidth1></field><field><fieldname>PI_NAME</fieldname><datatype>字符</datatype><displaylabel>处罚事项名称</displaylabel><size>200</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1><columnWidth2>35</columnWidth2></columnWidth1></field><field><fieldname>RFL_NAME</fieldname><datatype>字符</datatype><displaylabel>文书名称</displaylabel><size>100</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1><columnWidth2>35</columnWidth2></columnWidth1></field><field><fieldname>RFL_STATUS</fieldname><datatype>字符</datatype><displaylabel>状态</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1><columnHeight2></columnHeight2></columnHeight1><columnWidth1><columnWidth2>10</columnWidth2></columnWidth1></field><field><fieldname>PI_ID</fieldname><datatype>字符</datatype><displaylabel>事项ID</displaylabel><size>100</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>RFL_ID</fieldname><datatype>字符</datatype><displaylabel>清单ID</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>BU_NAME</fieldname><datatype>字符</datatype><displaylabel>执法主体</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>BU_ID</fieldname><datatype>字符</datatype><displaylabel>执法主体ID</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field></fields>" onSetText='bill_ondatasetsettext("<dsid><checked></checked><PI_NAME></PI_NAME><RFL_NAME></RFL_NAME><RFL_STATUS></RFL_STATUS><PI_ID></PI_ID><RFL_ID></RFL_ID><BU_NAME></BU_NAME><BU_ID></BU_ID></dsid>")' onGetText='bill_ondatasetgettext("<dsid><checked></checked><PI_NAME></PI_NAME><RFL_NAME></RFL_NAME><RFL_STATUS></RFL_STATUS><PI_ID></PI_ID><RFL_ID></RFL_ID><BU_NAME></BU_NAME><BU_ID></BU_ID></dsid>")' onValid='bill_ondatasetvalid("<dsid><checked></checked><PI_NAME></PI_NAME><RFL_NAME></RFL_NAME><RFL_STATUS></RFL_STATUS><PI_ID></PI_ID><RFL_ID></RFL_ID><BU_NAME></BU_NAME><BU_ID></BU_ID></dsid>")' opensortno="1" temptable="TMP_DATASET4" multiResult="否"></fc:dataset>
</DIV>
<div id='grid_tip'></div></body></html>
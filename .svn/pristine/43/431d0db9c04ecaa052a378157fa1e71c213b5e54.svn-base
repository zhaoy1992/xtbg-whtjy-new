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
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/common/Namespace.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/common/Namespace.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/common/nsreg.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/common/nsreg.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/common/Common.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/common/Common.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/business/LawManager.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/business/LawManager.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/dao/LawManagerDao.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/dao/LawManagerDao.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/vo/LawVo.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/vo/LawVo.js'></script>");
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
    var cl_name1 = ${'CL_NAME'}.value.trim();
        var cl_agency1 = ${'CL_AGENCY'}.value.trim();
        var clt_id1 = ${'CLT_ID'}.value;
        var cl_enable1 = "";
        var tmp = document.getElementsByName('CL_ENABLE');
        if (tmp[0].checked) {
            cl_enable1 = tmp[0].value ;
        } else if (tmp[1].checked) {
            cl_enable1 = tmp[1].value ;
        } else {
            cl_enable1 = -1 ;
        }

        var vc_id1 = ${'VC_ID'}.value;
        var pagePrams = {
          cl_name : cl_name1,
          cl_agency : cl_agency1,
          clt_id : clt_id1,
          cl_enable : cl_enable1,
          vc_id : vc_id1  
        }
        var sql = LawManager.queryLawManager(pagePrams);
        lawdataset.Open(sql);
        reloadExtGrid();
}



//查询法律法规
function cf_queryLaw(){
        var cl_name1 = ${'CL_NAME'}.value.trim();
        var cl_agency1 = ${'CL_AGENCY'}.value.trim();
        var clt_id1 = ${'CLT_ID'}.value;
        var cl_enable1 = "";
        var tmp = document.getElementsByName('CL_ENABLE');
        if (tmp[0].checked) {
            cl_enable1 = tmp[0].value ;
        } else if (tmp[1].checked) {
            cl_enable1 = tmp[1].value ;
        } else {
            cl_enable1 = -1 ;
        }

        var vc_id1 = ${'VC_ID'}.value;
        var pagePrams = {
          cl_name : cl_name1,
          cl_agency : cl_agency1,
          clt_id : clt_id1,
          cl_enable : cl_enable1,
          vc_id : vc_id1  
        }
        var sql = LawManager.queryLawManager(pagePrams);
        creator_pt_grids[0].obj.store.load();
        lawdataset.Open(sql);
        creator_pt_grids[0].obj.store.reload(); 
}

//重置查询条件
function cf_LawReset(){
   ${'CL_NAME'}.value = "";
   ${'CL_AGENCY'}.value = "";
   ${'CLT_ID'}.value = -1;
   var boxes = document.getElementsByName('CL_ENABLE');
   boxes[0].checked = true;
   ${'CL_ENABLE'}.value = 1;
   ${'VC_ID'}.value = -1;
}

//跳转到新增法律法规界面
function addLaw(){
   var tempPara = "dialogWidth:780px,dialogHeight:150px;";
   var tempURL = "20100906100701578358.jsp?djbh=222";
   window.showModalDialog(tempURL, window, tempPara);
   reloadExtGrid();
}

//修改法律法规
function updateLawManager(grid, rowIndex, e){
   var row = grid.store.getById(grid.store.data.items[rowIndex].id); 
   var cl_ID = row.get("cl_id");
   var tempPara = "dialogWidth:780px,dialogHeight:150px;";
   var tempURL = "20100906100701578358.jsp?djbh=222&cl_id=" + cl_ID;
   window.showModalDialog(tempURL, window, tempPara);
   reloadExtGrid();
}

//删除法律法规
function delLawManager(){
    var grid = creator_pt_grids[0].obj;
    var ids = FormUtil.getExtGridSelectedIds("cl_id", grid);
    if(ids.length == 0){    
       alert("请选择要删除的记录！");
       return false;
    } else {
        var unDelete = new Array();
        var unDeleteId = new Array();
        var canDelete = new Array();
        var rows = grid.getSelectionModel().getSelections();
        for(var i = 0; i < rows.length; i++){
            var rmdId = rows[i].get("rmd_id");
            if(rmdId == "被引用"){
                unDelete[unDelete.length] = rows[i].get("cl_name").trim();//不能删
                  unDeleteId[unDeleteId.length] = rows[i].get("cl_id").trim();//置为无效
              } else {
                canDelete[canDelete.length] = rows[i].get("cl_id");//能删
              }                   
        }
        
        if(confirm("是否删除勾选的法律法规？")){
            if(IsSpace(unDelete)){
                LawManager.delLawManager(canDelete);
            } else if(IsSpace(canDelete)){
                //var putString = "\"" + unDelete + "\"被引用，不能删除！";
                //alert(putString);
                if(confirm("\"" + unDelete + "\"被引用，不能删除！" + "\n是否将其置为无效？")){
                    LawManager.setLawUnable(unDeleteId);//置为无效
                }
            } else {
                if(confirm("\"" + unDelete + "\"被引用，不能删！是否删除其他勾选的法律法规？")){
                  LawManager.delLawManager(canDelete);//删除
                    LawManager.setLawUnable(unDeleteId);//置为无效
                }
            }
        }
    }
    reloadExtGrid();
}

//导出excel
function expLawExcel(){
    var title = "法律法规信息";//标题
     var CL_NAME = "法律法规名称";
    var CL_BRIEF_NAME = "法规简称";
    var VC_NAME = "行业类别";
    var CLT_NAME = "法规类型";
    var CL_AGENCY = "发布部门";
    var CL_DATE = "生效日期";
    var CL_EXPIRY_DATE = "失效日期";
    var CL_ENABLE = "状态";
    
    var id = "LawExport";
  
    var cl_name = $("CL_NAME").value;//执法主体名称
    var cl_agency = $("CL_AGENCY").value.trim();//事项名称
    var clt_id = $("CLT_ID").value.trim();//事项编码
    var tmp = document.getElementsByName('CL_ENABLE');//状态
        if (tmp[0].checked) {
            cl_enable = tmp[0].value ;
        } else if (tmp[1].checked) {
            cl_enable = tmp[1].value ;
        } else {
            cl_enable = -1 ;
        }
    var vc_id = $("VC_ID").value;//事项类别
  var url="<%=request.getContextPath() %>/ccapp/app_xzcf/excel/jsp/poiCommond.jsp";
  url+="?title="+title+"&CL_NAME="+CL_NAME+"&CL_BRIEF_NAME="+CL_BRIEF_NAME+"&VC_NAME="+VC_NAME;
  url+="&CLT_NAME="+CLT_NAME+"&CL_AGENCY="+CL_AGENCY+"&CL_DATE="+CL_DATE+"&CL_EXPIRY_DATE="+CL_EXPIRY_DATE;
  url+="&CL_ENABLE="+CL_ENABLE+"&id="+id+"&cl_name="+cl_name;
  url+="&cl_agency="+cl_agency+"&clt_id="+clt_id+"&cl_enable="+cl_enable+"&vc_id="+vc_id;
  window.location.href=url;
}

</script>

<!-- 提示：以下为页面DOM元素内容 -->
<DIV id=SKbillsheet style="visibility:hidden" toolbar="不带工具栏" BLONopen="setAuthority();init();" contxml="<root><combobox><id>CLT_ID</id><id>VC_ID</id></combobox><button><id>queryLaw</id><id>LawReset</id><id>expLawExcelB</id><id>addLawB</id><id>delLaw</id></button><text><id>CL_NAME</id><id>CL_AGENCY</id></text><dataset><id>lawdataset</id></dataset><ExtGrid><id>ExtGrid1</id></ExtGrid></root>" billtaborder="<root><taborder>CL_NAME</taborder><taborder>CL_AGENCY</taborder><taborder>CLT_ID</taborder><taborder>VC_ID</taborder><taborder>queryLaw</taborder><taborder>LawReset</taborder><taborder>expLawExcelB</taborder><taborder>addLawB</taborder><taborder>delLaw</taborder></root>" dj_sn="20100907205508078541" caption="法律法规信息管理" mkbh codeheader="BBB" entertype="展现" poswidth posheight controlno="SKButton:0;SKDBedit:0;checkbox:0;label:0;radio:0;listbox:0;textarea:0;combobox:0;password:0;upload:0;SKDBtext:0;chart:0;dbimg:0;img:0;SKBILLgrid:0;shape:0;tab:0;div:0;DsMain_field:0;a:0;button:0;text:0;hr:0;checkboxlist:0;radiolist:0;dropdownlist:0;grid:0;dataset:1;spin:0;excel:0;tree:0;ebshow:0;creatorSubForm:0;creator_div:0;ExtGrid:2;ExtUpload:0;ExtTree:0;Fusionchar:0" window="当前窗口" posleft postop keyfield isfile="否" OtherSave="否" idtype="1" testDbName="app_xzcf" creatorStyle="creatorBlue" BLONclose="UnLoadWebOffice();" creator_remark hasWorkflowButton="否" creator_elementAuthoritySwitch="否" creator_showAlert="否" creator_office_isBindForm="否" islog="否" isprotect="是" creator_csslib version="1.0" creator_pagination type="ZW" creatorType="20100902181501546870" jslib="fcsavedj.js&#13;&#10;fcbasecont.js&#13;&#10;selectdate.js&#13;&#10;~userfunc.js&#13;&#10;fcdate.js&#13;&#10;../../../ccapp/app_xzcf/js/common/Namespace.js&#13;&#10;../../../ccapp/app_xzcf/js/common/nsreg.js&#13;&#10;../../../ccapp/app_xzcf/js/common/Common.js&#13;&#10;../../../ccapp/app_xzcf/js/business/LawManager.js&#13;&#10;../../../ccapp/app_xzcf/js/dao/LawManagerDao.js&#13;&#10;../../../ccapp/app_xzcf/js/vo/LawVo.js">

<TABLE cellSpacing=0 cellPadding=0 width="95%" align=center border=0>
   <TBODY>
      <TR>
         <TD>
            <TABLE class=Ctable cellSpacing=0 cellPadding=0 width="100%" border=0>
               <TBODY>
                  <TR>
                     <TD class=taobox colSpan=4>法律法规信息查询</TD>
                  </TR>
                  <TR>
                     <TD class=c2>法律法规名称</TD>
                     <TD width="35%"><INPUT class=input_out id=CL_NAME style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text"></TD>
                     <TD class=c2>发布部门</TD>
                     <TD width="35%"><INPUT class=input_out id=CL_AGENCY style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text"></TD>
                  </TR>
                  <TR>
                     <TD class=c2>法规类型</TD>
                     <TD width="35%"><SELECT id=CLT_ID style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() sqltrans="%F4%D8%E6%D8%D4%F6Xrn%94%A6%B6%CC%A0%96Xr%94%94%A6%B6%CC%AA%90%A8%98Xrn%DA%F2%EC%E8Xrn%B6%90%CC%94%9E%A0%AA%90%CC%A6%90%BC%B4%CC%B6%C0%AE%98" controltype="combobox" tempvalue="-1" temptext="--请选择--" sql check="1"><OPTION value=-1 selected>--请选择--</OPTION></SELECT></TD>
                     <TD class=c2>状态</TD>
                     <TD width="35%"><INPUT type=radio CHECKED value=1 name=CL_ENABLE>有效&nbsp;<INPUT type=radio value=0 name=CL_ENABLE>无效&nbsp;<INPUT type=radio value=-1 name=CL_ENABLE>全部</TD>
                  </TR>
                  <TR>
                     <TD class=c2>行业分类</TD>
                     <TD><SELECT id=VC_ID style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() sqltrans="%F4%D8%E6%D8%D4%F6Xrn%BA%94%CC%A0%96Xr%94%BA%94%CC%AA%90%A8%98Xrn%DA%F2%EC%E8Xrn%B6%90%CC%BA%AC%94%90%B6%A0%AC%AA%CC%94%AC%AA%B4%B6%A0%B6%B8%B6%AC%B2" controltype="combobox" tempvalue="-1" temptext="--请选择--" sql check="2"><OPTION value=-1 selected>--请选择--</OPTION></SELECT></TD>
                     <TD colSpan=2></TD>
                  </TR>
               </TBODY>
            </TABLE>
         </TD>
      </TD>
      <TR>
         <TD align=middle><BUTTON class=button id=queryLaw style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("cf_queryLaw()")'>查询</BUTTON><BUTTON class=button id=LawReset style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("cf_LawReset()")'>重置</BUTTON><BUTTON class=button id=expLawExcelB style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("expLawExcel()")'>导出excel</BUTTON></TD>
      </TR>
      <TR>
         <TD align=right><BUTTON class=addbutton1 id=addLawB style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("addLaw()")'>新增</BUTTON>&nbsp;<BUTTON class=sbutton1 id=delLaw style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("delLawManager()")'>删除</BUTTON></TD>
      </TR>
      <TR>
         <TD><IMG style="DISPLAY: none" src="undefined"><DIV id=div_ExtGrid1 style="LEFT: 0px; POSITION: static; TOP: 0px"></DIV><SCRIPT type=text/javascript>var ExtGrid1;
Ext.BLANK_IMAGE_URL = '../../fceform/js/Ext/images/default/s.gif';
var ExtGrid1_retint = 0;
var ExtGrid1_onReady = function(){ 
 Ext.QuickTips.init();
var dataset = document.getElementById("lawdataset");
try{var temp = dataset.Fields.Field.length;}catch(e){if(ExtGrid1_retint==0) ExtGrid1_retint = setInterval(ExtGrid1_onReady,200);dataset =null;return;}finally{if(temp!=null)temp=null;}
clearInterval(ExtGrid1_retint);ExtGrid1_retint = null ;var pagesize =10;
dataset.PageSize = pagesize ;
var mapping = creator_pt_getmapping(dataset);
var store  = new Ext.data.Store({
	proxy: new Ext.data.CreatorMemoryProxy("lawdataset"), 
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
cm.setHidden(7,true);
cm.setHidden(8,true);
cm.setHidden(10,true);
grid.addListener('rowdblclick',updateLawManager);ExtGrid1.render();
store.load({params:{start:0, limit:pagesize}});
if(typeof(creator_pt_grids)=='undefined'){creator_pt_grids=new Array();}
creator_pt_grids.push({id:'ExtGrid1',obj:ExtGrid1,dataset:'lawdataset',isEdit:'false'});
if(typeof(onGridPanelLoaded)=='function') setTimeout(onGridPanelLoaded,0);
};
ExtGrid1_onReady();window.onresize=function(){try{ExtGrid1.setWidth(eval(document.body.clientWidth*(parseFloat('95%')))/100);}catch(e){}};</SCRIPT></TD>
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

<fc:dataset id=lawdataset showtypeXml="<root><showType><name>CL_ID</name><showRule>undefined</showRule></showType><showType><name>CLT_ID</name><showRule>undefined</showRule></showType><showType><name>checked</name><showRule>%5B%7Bshowtype%3A%27checkbox%27%7D%5D</showRule></showType><showType><name>CL_ENABLE</name><showRule>undefined</showRule></showType><showType><name>CL_EXPIRY_DATE</name><showRule>undefined</showRule></showType><showType><name>RMD_NAME</name><showRule>undefined</showRule></showType></root>" columnHeight1Xml="undefined" columnWidth1Xml="undefined" format="<fields><field><fieldname>checked</fieldname><datatype>字符</datatype><displaylabel>全选</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype><showRule>%5B%7Bshowtype%3A%27checkbox%27%7D%5D</showRule></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>CL_NAME</fieldname><datatype>字符</datatype><displaylabel>法律法规名称</displaylabel><size>80</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>CL_AGENCY</fieldname><datatype>字符</datatype><displaylabel>发布部门</displaylabel><size>80</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>CLT_NAME</fieldname><datatype>字符</datatype><displaylabel>法规类型</displaylabel><size>30</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>VC_NAME</fieldname><datatype>字符</datatype><displaylabel>行业分类</displaylabel><size>80</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>CL_DATE</fieldname><datatype>字符</datatype><displaylabel>生效日期</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>CL_EXPIRY_DATE</fieldname><datatype>字符</datatype><displaylabel>失效日期</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype><showRule>undefined</showRule></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>CL_ID</fieldname><datatype>字符</datatype><displaylabel>法律法规库</displaylabel><size>22</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>否</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype><showRule>undefined</showRule></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>CLT_ID</fieldname><datatype>字符</datatype><displaylabel>法规类型ID</displaylabel><size>22</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>否</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype><showRule>undefined</showRule></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>CL_ENABLE</fieldname><datatype>字符</datatype><displaylabel>状态</displaylabel><size>22</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype><showRule>undefined</showRule></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>VC_ID</fieldname><datatype>字符</datatype><displaylabel>行业分类</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>RMD_ID</fieldname><datatype>字符</datatype><displaylabel>引用状态</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field></fields>" onSetText='bill_ondatasetsettext("<dsid><checked></checked><CL_NAME></CL_NAME><CL_AGENCY></CL_AGENCY><CLT_NAME></CLT_NAME><VC_NAME></VC_NAME><CL_DATE></CL_DATE><CL_EXPIRY_DATE></CL_EXPIRY_DATE><CL_ID></CL_ID><CLT_ID></CLT_ID><CL_ENABLE></CL_ENABLE><VC_ID></VC_ID><RMD_ID></RMD_ID></dsid>")' onGetText='bill_ondatasetgettext("<dsid><checked></checked><CL_NAME></CL_NAME><CL_AGENCY></CL_AGENCY><CLT_NAME></CLT_NAME><VC_NAME></VC_NAME><CL_DATE></CL_DATE><CL_EXPIRY_DATE></CL_EXPIRY_DATE><CL_ID></CL_ID><CLT_ID></CLT_ID><CL_ENABLE></CL_ENABLE><VC_ID></VC_ID><RMD_ID></RMD_ID></dsid>")' onValid='bill_ondatasetvalid("<dsid><checked></checked><CL_NAME></CL_NAME><CL_AGENCY></CL_AGENCY><CLT_NAME></CLT_NAME><VC_NAME></VC_NAME><CL_DATE></CL_DATE><CL_EXPIRY_DATE></CL_EXPIRY_DATE><CL_ID></CL_ID><CLT_ID></CLT_ID><CL_ENABLE></CL_ENABLE><VC_ID></VC_ID><RMD_ID></RMD_ID></dsid>")' opensortno="1" temptable="TMP_DATASET1" multiResult="是"></fc:dataset>
</DIV>
<div id='grid_tip'></div></body></html>
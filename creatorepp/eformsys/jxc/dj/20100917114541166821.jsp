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
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/common/Namespace.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/common/Namespace.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/common/nsreg.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/common/nsreg.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/common/Common.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/common/Common.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/vo/WfjlVo.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/vo/WfjlVo.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/business/Ajsl.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/business/Ajsl.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/dao/AjslDao.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/dao/AjslDao.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/util/HTMLUtil.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_xzcf/js/util/HTMLUtil.js'></script>");
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
var OR_ID = creator_getQueryString("or_id");//违法记录ID
var WFT_ID = creator_getQueryString("wft_id");//事项实例ID
var PI_ID = creator_getQueryString("PI_ID");//事项ID
var readOnlyFlag = creator_getQueryString("readOnlyFlag");//是否为只读
var rmd_object_type = "";

//打开选择违法行为
function selWfxw(){
    var tempPara="dialogWidth:760px;dialogHeight:370px;";
    var tempURL="20101014084224921532.jsp?PI_ID=" + PI_ID + "&WFT_ID=" + WFT_ID ;
    var tmp = showModalDialog(tempURL,window,tempPara);
    if (!IsSpace(tmp)) {
        var name_tmp = tmp.names;
        var id_tmp = tmp.ids;
        var or_id = tmp.orIds;
        rmd_object_type = tmp.types;
        $("OR_NAME").value = name_tmp;
        $("RMD_ID").value = id_tmp;
        OR_ID = or_id;
        init();
        //document.getElementById("findWfxw").style.visibility= "visible";
    }
}

//新增当事人
function addDsr(){
    var tempPara="dialogWidth:760px;dialogHeight:300px;";
    var tempURL="20100917152958303983.jsp?OR_ID="+OR_ID+"&WFT_ID="+WFT_ID+"&rddType="+rmd_object_type;
    showModalDialog(tempURL,window,tempPara);
    dsrLoad();
}

//双击修改当事人
function editDsr(grid, rowIndex, e){
    var row = grid.store.getById(grid.store.data.items[rowIndex].id); 
    var LTT_ID= row.get("ltt_id");
    var tempPara="dialogWidth:760px;dialogHeight:300px;";
    var tempURL="20100917152958303983.jsp?OR_ID="+OR_ID+"&WFT_ID="+WFT_ID+"&rddType="+rmd_object_type+"&LTT_ID="+LTT_ID+"&readOnlyFlag="+readOnlyFlag;
    showModalDialog(tempURL,window,tempPara);
    dsrLoad();
}

//删除当事人
function delDsr(){
    var grid =  creator_pt_grids[0].obj;
    var ids = FormUtil.getExtGridSelectedIds("LTT_ID", grid);
    if (ids.length==0) {    
       alert("请选择要删除的记录！");
       return false;
    } else if (confirm('是否要删除所选数据?')) {
       var rv = Ajsl.delDsrByOrId(ids,OR_ID);
       if (rv) {
          alert("删除数据信息成功！");
       } else {
          alert("删除违法记录失败！");
       }
       reloadExtGrid();
    }
}

//保存
function save(){
    if (validate()) {
        var obj = new WfjlVo.Wfjl();
        var vo = DBUtil.getVoFromPage(obj);
        vo.OR_ID= OR_ID;
        vo.WFT_ID = WFT_ID;
        vo.OR_EDIT_DATE = FormUtil.getServerDate();
        vo.NDP_ID = 1;//受理阶段
         var rv = Ajsl.saveWfjl(vo);
        if (rv) {
            alert("保存数据信息成功！");
            if (OR_ID ==0) {
                OR_ID = vo.OR_ID;
                document.getElementById("operDsr").style.display="";            
                ${'OR_NAME'}.disabled = true;
                //document.getElementById("findWfxw").style.visibility= "hidden";
            }
        } else {
            alert("保存数据信息失败！");
        }
    }
}

//加载当事人信息
function dsrLoad(){
    var sql = Ajsl.getDsrByOrId(OR_ID, WFT_ID);
    Dsrdataset1.Open(sql);
    reloadExtGrid();
}

//初始化
function init(){
    if(OR_ID == "" || OR_ID == null){OR_ID=0;}
    if (OR_ID!=0) {
        ${'OR_NAME'}.disabled = true;
       //document.getElementById("findWfxw").style.visibility= "hidden";
        var sql = Ajsl.getWfjlById(OR_ID);
        wfjldataset.Open(sql);
        if (readOnlyFlag != "readOnly") {
            document.getElementById("operDsr").style.display="";
        } else {
            document.getElementById("saveBtn").style.visibility="hidden";
            document.getElementById("operDsr").style.display="none";
            HTMLUtil.readOnly($("OR_BRIEF"),"commonReadOnly");
        }
        rmd_object_type = wfjldataset.Fields.Field['rdd_type'].Value;
    } else {
        document.getElementById("operDsr").style.display="none";
    }
    dsrLoad();
}

//验证
function validate(){
    var flag = true;
    if (flag) {
        flag = SValidator.validate(${'OR_NAME'}.value, {
            CHECK_TYPE : "required",
            ARGUMENT : {placeholders : [${'OR_NAME'}.value]},
            MESSAGE : "违法行为名称不能为空!"
        }, true);
    }
    return flag;
}

//返回
function turnback(){
    window.location.href = "20100913200554421469.jsp?wft_id=" + WFT_ID + "&readOnlyFlag="+readOnlyFlag;
}
</script>

<!-- 提示：以下为页面DOM元素内容 -->
<DIV id=SKbillsheet style="visibility:hidden" toolbar="不带工具栏" BLONopen="setAuthority();init();" contxml="<root><textarea><id>OR_BRIEF</id></textarea><button><id>findWfxw</id><id>saveBtn</id><id>rtnBtn</id><id>newDsr</id><id>delDsr1</id></button><text><id>OR_NAME</id><id>RMD_ID</id></text><dataset><id>Dsrdataset1</id><id>wfjldataset</id></dataset><ExtGrid><id>DsrGrid</id></ExtGrid></root>" billtaborder="<root><taborder>OR_NAME</taborder><taborder>OR_BRIEF</taborder><taborder>saveBtn</taborder><taborder>rtnBtn</taborder><taborder>newDsr</taborder><taborder>delDsr1</taborder><taborder>findWfxw</taborder><taborder>RMD_ID</taborder></root>" dj_sn="20100917114541166821" caption="违法记录" mkbh codeheader="BBB" entertype="修改" poswidth posheight controlno="SKButton:0;SKDBedit:0;checkbox:0;label:0;radio:0;listbox:0;textarea:1;combobox:0;password:0;upload:0;SKDBtext:0;chart:0;dbimg:0;img:1;SKBILLgrid:0;shape:0;tab:0;div:0;DsMain_field:0;a:0;button:8;text:4;hr:0;checkboxlist:0;radiolist:0;dropdownlist:0;grid:0;dataset:2;spin:0;excel:0;tree:0;ebshow:0;creatorSubForm:0;creator_div:0;ExtGrid:1;ExtUpload:0;ExtTree:0;Fusionchar:0" window="当前窗口" posleft postop keyfield isfile="否" OtherSave="否" idtype="1" testDbName="app_xzcf" creatorStyle="creatorBlue" BLONclose="UnLoadWebOffice();" creator_remark hasWorkflowButton="否" creator_elementAuthoritySwitch="否" creator_showAlert="否" creator_office_isBindForm="否" islog="否" isprotect="是" creator_csslib version="1.0" creator_pagination type="ZW" creatorType="20100913200141634274" jslib="fcbasecont.js&#13;&#10;selectdate.js&#13;&#10;~userfunc.js&#13;&#10;fcdate.js&#13;&#10;../../../ccapp/app_xzcf/js/common/Namespace.js&#13;&#10;../../../ccapp/app_xzcf/js/common/nsreg.js&#13;&#10;../../../ccapp/app_xzcf/js/common/Common.js&#13;&#10;../../../ccapp/app_xzcf/js/vo/WfjlVo.js&#13;&#10;../../../ccapp/app_xzcf/js/business/Ajsl.js&#13;&#10;../../../ccapp/app_xzcf/js/dao/AjslDao.js&#13;&#10;../../../ccapp/app_xzcf/js/util/HTMLUtil.js">

<TABLE class=Ctable cellSpacing=0 cellPadding=0 width="95%" align=center border=0>
   <TBODY>
      <TR>
         <TD class=taobox colSpan=2>编辑违法记录</TD>
      </TR>
      <TR>
         <TD class=c2>违法行为名称<FONT color=red>*</FONT></TD>
         <TD><INPUT class=input_image id=OR_NAME style="LEFT: 0px; WIDTH: 293px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() readOnly size=53 controltype="text" field="OR_NAME" china="违法行为名称" dataset="wfjldataset" onclick='bill_onclick("selWfxw()")'>&nbsp;<BUTTON class=button id=findWfxw style="DISPLAY: none; LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("selWfxw()")'>选择</BUTTON></TD>
      </TR>
      <TR>
         <TD class=c2>违法情况</TD>
         <TD><TEXTAREA class=input_out id=OR_BRIEF style="LEFT: 0px; WIDTH: 293px; POSITION: static; TOP: 0px; HEIGHT: 85px" onmovestart=moveStart() cols=58 controltype="textarea" field="OR_BRIEF" china="违法情况" dataset="wfjldataset" value="textarea1" induce="否"></TEXTAREA></TD>
      </TR>
   </TBODY>
</TABLE>

<TABLE cellSpacing=0 cellPadding=0 width="95%" align=center border=0>
   <TBODY>
      <TR align=middle>
         <TD><BUTTON class=button id=saveBtn style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("save()")'>保存</BUTTON><BUTTON class=button id=rtnBtn style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("CloseBill()")'>关闭</BUTTON><INPUT id=RMD_ID style="DISPLAY: none; LEFT: 0px; WIDTH: 93px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() size=16 controltype="text" field="RMD_ID" china="违法行为ID" dataset="wfjldataset"></TD>
      </TR>
   </TBODY>
</TABLE>

<TABLE cellSpacing=0 cellPadding=0 width="95%" align=center border=0>
   <TBODY>
      <TR id=operDsr align=right>
         <TD><BUTTON class=addbutton1 id=newDsr style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("addDsr()")'>新增当事人</BUTTON><BUTTON class=sbutton1 id=delDsr1 style="LEFT: 0px; POSITION: static; TOP: 0px" onmovestart=moveStart() dropstyle="否" controltype="button" onclick='bill_onclick("delDsr()")'>删除当事人</BUTTON></TD>
      </TR>
      <TR>
         <TD><IMG style="DISPLAY: none" src="undefined"><DIV id=div_DsrGrid style="LEFT: 0px; POSITION: static; TOP: 0px"></DIV><SCRIPT type=text/javascript>var DsrGrid;
Ext.BLANK_IMAGE_URL = '../../fceform/js/Ext/images/default/s.gif';
var DsrGrid_retint = 0;
var DsrGrid_onReady = function(){ 
 Ext.QuickTips.init();
var dataset = document.getElementById("Dsrdataset1");
try{var temp = dataset.Fields.Field.length;}catch(e){if(DsrGrid_retint==0) DsrGrid_retint = setInterval(DsrGrid_onReady,200);dataset =null;return;}finally{if(temp!=null)temp=null;}
clearInterval(DsrGrid_retint);DsrGrid_retint = null ;var pagesize =10;
dataset.PageSize = pagesize ;
var mapping = creator_pt_getmapping(dataset);
var store  = new Ext.data.Store({
	proxy: new Ext.data.CreatorMemoryProxy("Dsrdataset1"), 
	reader: new Ext.data.XmlStringReader({       record: 'tr',       totalRecords: 'pages'   }, mapping)});
var sm = new Ext.grid.RowSelectionModel({singleSelect: true});
var retcm = creator_pt_getcm(dataset,sm);var cm = new Ext.grid.ColumnModel(retcm);
if(typeof(retcm[0].getCount)!='undefined') sm = retcm[0] ;
 DsrGrid = new Ext.grid.GridPanel({
		el: 'div_DsrGrid',        store: store,
        cm:cm,
		sm: sm,
 			 bodyStyle : 'width:100%',
		viewConfig: {
			forceFit: true		},       loadMask: true,
	width: '100%',
					height: eval(document.body.clientHeight*(parseFloat('50%')))/100,
		split: true,
		region: 'north',
		title:'当事人(单位)信息',
		frame:true
		,plugins: new Ext.ux.PanelResizer({
            minHeight: 100        }),
       bbar: new Ext.PagingToolbar({
            pageSize: pagesize,
            store: store,
            displayInfo: true,
            displayMsg:'当前显示第 {0} - {1} 条，共 {2} 条',            plugins: new Ext.ux.SlidingPager()        })		    });
    var grid=DsrGrid;
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
grid.addListener('rowdblclick', editDsr);DsrGrid.render();
store.load({params:{start:0, limit:pagesize}});
if(typeof(creator_pt_grids)=='undefined'){creator_pt_grids=new Array();}
creator_pt_grids.push({id:'DsrGrid',obj:DsrGrid,dataset:'Dsrdataset1',isEdit:'false'});
if(typeof(onGridPanelLoaded)=='function') setTimeout(onGridPanelLoaded,0);
};
DsrGrid_onReady();window.onresize=function(){try{DsrGrid.setWidth(eval(document.body.clientWidth*(parseFloat('95%')))/100);}catch(e){}};</SCRIPT></TD>
      </TR>
   </TBODY>
</TABLE>

<?xml:namespace prefix = fc />

<fc:dataset id=Dsrdataset1 showtypeXml="<root><showType><name>checked</name><showRule>%5B%7Bshowtype%3A%27checkbox%27%7D%5D</showRule></showType></root>" columnHeight1Xml="undefined" columnWidth1Xml="undefined" format="<fields><field><fieldname>checked</fieldname><datatype>字符</datatype><displaylabel>全选</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype><showRule>%5B%7Bshowtype%3A%27checkbox%27%7D%5D</showRule></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>LTT_ATTRI</fieldname><datatype>字符</datatype><displaylabel>公民/法人</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>LTT_NAME</fieldname><datatype>字符</datatype><displaylabel>当事人/单位名称</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>LTT_CODE</fieldname><datatype>字符</datatype><displaylabel>证件号码</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>LTT_TEL</fieldname><datatype>字符</datatype><displaylabel>当事人电话</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>LTT_ADDRESS</fieldname><datatype>字符</datatype><displaylabel>当事人地址</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>LTT_ID</fieldname><datatype>字符</datatype><displaylabel>当事人流水</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field></fields>" onSetText='bill_ondatasetsettext("<dsid><checked></checked><LTT_ATTRI></LTT_ATTRI><LTT_NAME></LTT_NAME><LTT_CODE></LTT_CODE><LTT_TEL></LTT_TEL><LTT_ADDRESS></LTT_ADDRESS><LTT_ID></LTT_ID></dsid>")' onGetText='bill_ondatasetgettext("<dsid><checked></checked><LTT_ATTRI></LTT_ATTRI><LTT_NAME></LTT_NAME><LTT_CODE></LTT_CODE><LTT_TEL></LTT_TEL><LTT_ADDRESS></LTT_ADDRESS><LTT_ID></LTT_ID></dsid>")' onValid='bill_ondatasetvalid("<dsid><checked></checked><LTT_ATTRI></LTT_ATTRI><LTT_NAME></LTT_NAME><LTT_CODE></LTT_CODE><LTT_TEL></LTT_TEL><LTT_ADDRESS></LTT_ADDRESS><LTT_ID></LTT_ID></dsid>")' opensortno="1" temptable="TMP_DATASET7" multiResult="否"></fc:dataset>

<fc:dataset id=wfjldataset format="<fields><field><fieldname>OR_ID</fieldname><datatype>字符</datatype><displaylabel>违法记录流水</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>RMD_ID</fieldname><datatype>字符</datatype><displaylabel>违法行为ID</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>OR_BRIEF</fieldname><datatype>字符</datatype><displaylabel>违法情况</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>WFT_ID</fieldname><datatype>字符</datatype><displaylabel>事项实例ID</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>OR_NAME</fieldname><datatype>字符</datatype><displaylabel>违法行为名称</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>RDD_TYPE</fieldname><datatype>字符</datatype><displaylabel>当事人类型</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field></fields>" onSetText='bill_ondatasetsettext("<dsid><OR_ID></OR_ID><RMD_ID></RMD_ID><OR_BRIEF></OR_BRIEF><WFT_ID></WFT_ID><OR_NAME></OR_NAME><RDD_TYPE></RDD_TYPE></dsid>")' onGetText='bill_ondatasetgettext("<dsid><OR_ID></OR_ID><RMD_ID></RMD_ID><OR_BRIEF></OR_BRIEF><WFT_ID></WFT_ID><OR_NAME></OR_NAME><RDD_TYPE></RDD_TYPE></dsid>")' onValid='bill_ondatasetvalid("<dsid><OR_ID></OR_ID><RMD_ID></RMD_ID><OR_BRIEF></OR_BRIEF><WFT_ID></WFT_ID><OR_NAME></OR_NAME><RDD_TYPE></RDD_TYPE></dsid>")' opensortno="1" temptable="TMP_DATASET2" multiResult="否"></fc:dataset>
</DIV>
<div id='grid_tip'></div></body></html>
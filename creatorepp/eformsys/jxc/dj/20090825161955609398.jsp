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
  mylink.setAttribute('href','../../../ccapp/<%=appPath%>/css/creatorBlue/allStyle.css');
  myhead.appendChild(mylink);
<%}else{%>  adv_loadjsfile('ccapp/<%=appPath%>/css/creatorBlue/allStyle.css');
<%}%>  fcpubdata.creatorStyle='creatorBlue';
</script>
<%
if(!bDgMode) out.println("<script language='javascript'>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/fcsavedj.js');");
if(bDgMode) out.println("<script defer src='../../fceform/js/fcsavedj.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/fcselfuse.js');");
if(bDgMode) out.println("<script src='../../fceform/js/fcselfuse.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/fcbasecont.js');");
if(bDgMode) out.println("<script src='../../fceform/js/fcbasecont.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/fcother.js');");
if(bDgMode) out.println("<script defer src='../../fceform/js/fcother.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/selectdate.js');");
if(bDgMode) out.println("<script defer src='../../fceform/js/selectdate.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/../fceformext/js/userfunc.js');");
if(bDgMode) out.println("<script src='../../fceform/../fceformext/js/userfunc.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/fcdate.js');");
if(bDgMode) out.println("<script src='../../fceform/js/fcdate.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_5/js/Namespace.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_5/js/Namespace.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_5/js/vo/vo.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_5/js/vo/vo.js'></script>");
if(!bDgMode) out.println("  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_5/js/commonOperation.js');");
if(bDgMode) out.println("<script src='../../fceform/js/../../../ccapp/app_5/js/commonOperation.js'></script>");
if(!bDgMode) out.println("</script>");
%>

   <script >document.styleSheets[0].addRule("fc\\:dataset","behavior: url(../../fceform/htc/dataset.htc)",0);</script>
   <script language='javascript'>
adv_loadjsfile('/eformsys/fceform/css/tabstyle.css');
adv_loadjsfile('/eformsys/fceform/css/Button.css');
adv_loadjsfile('/eformsys/fceform/js/fcdataset.js');
adv_loadjsfile('/eformsys/fceform/js/Ext/SlidingPager.js');
adv_loadjsfile('/eformsys/fceform/js/Ext/SliderTip.js');
adv_loadjsfile('/eformsys/fceform/js/Ext/PanelResizer.js');
adv_loadjsfile('/eformsys/fceform/js/Ext/XmlTextReader.js');
adv_loadjsfile('/eformsys/fceform/js/Ext/CreatorMemoryProxy.js');
</script>


<!-- 提示：以下为页面自定义JS内容 -->
<script>
//==============================================全局对象变量定义=========================================

var PageParms = {
    ecId :IsSpace(creator_getQueryString("ecId")) ? "":creator_getQueryString("ecId"),//事项ID
    itemInsId : IsSpace(creator_getQueryString("item_insid"))? "":creator_getQueryString("item_insid"),//项目实例ID
    STATUS_ATTACH_INIT : '未提交',
    STATUS_ATTACH_SUBMITTED : '已提交',
    STATUS_ATTACH_REPEALED : '已撤消',
    subAttIdList : new Array()
}

function cellClick(grid,rowIndex,colIndex,e){
   var attach_id=grid.store.getAt(rowIndex).get('attach_insid');

   if(colIndex==7){
       openUploadAndDownView(attach_id,"UPLOAD",true,"文件上传");
   }else if(colIndex==8){
       openUploadAndDownView(attach_id,"DOWNLOAD",true,"文件下载");
   }
}



/**
 * 初始化：如果还没产生实例，则查询材料基本信息表；否则，查询材料实例表
 */
function init(){
     var cc_form_instanceid =creator_getQueryString("cc_form_instanceid");
     
    if(IsSpace(cc_form_instanceid) || cc_form_instanceid=="clear"){
        var baseAttachSql = new Array();
        baseAttachSql.push("select b.attach_id,b.attach_name,b.attach_transact,b.attach_number, '未提交' as attach_status");
        baseAttachSql.push(" from ta_sp_baseattach b where b.ec_id='");
        baseAttachSql.push(PageParms.ecId);
        baseAttachSql.push("'");
        baseAttachSql.push(" order by b.attach_name");
        attachDataset.Open(baseAttachSql.join(""));
        InsertAllAttach();
       
        selectInsAttach();
      }else{
          selectInsAttach();
      }
}
function selectInsAttach(){
        //var cc_form_instanceid =creator_getQueryString("cc_form_instanceid");
        //if(IsSpace(cc_form_instanceid) || cc_form_instanceid=="clear"){
        //      cc_form_instanceid=parent.PageParms.ccFormId;
        // }
        var cc_form_instanceid = fcpubdata.cc_form_instanceid;
        var attachInsSql = new Array();
        attachInsSql.push("select a.attach_id,a.attach_insid,a.attach_name,a.attach_transact,");
        attachInsSql.push("a.attach_number,a.attach_status,a.accepter,");
        attachInsSql.push("to_char(a.accept_time,'yyyy-mm-dd') as accept_time");
        attachInsSql.push(" from ta_sp_attachinstance a");
        if(!IsSpace(cc_form_instanceid)){
            attachInsSql.push(" where a.cc_form_instanceid='");
            attachInsSql.push(cc_form_instanceid);
            attachInsSql.push("'");
        }else{
            attachInsSql.push(" where a.item_insid='");
            attachInsSql.push(item_insid);
            attachInsSql.push("'");
        }
        attachInsSql.push(" order by a.attach_name");
        attachDataset.Open(attachInsSql.join(""));

}

function InsertAllAttach(){
   creator_setSession("cc_form_instanceid",parent.PageParms.ccFormId);
 
   var orgid=getSysElement("userorgid");
   var accepter=getSysElement('userName');
   var ccid=parent.PageParms.ccFormId;
   var sql="insert into ta_sp_attachinstance(ATTACH_INSID,ATTACH_NAME,ATTACH_NUMBER,ATTACH_TRANSACT,";
       sql+=" ATTACH_ID,ATTACH_STATUS) select seq_attach.nextval,";
       sql+=" attach_name,ATTACH_NUMBER,ATTACH_TRANSACT,";
       sql+=" ATTACH_ID,'未提交' from ta_sp_baseattach z where z.ec_id = '1341'";
  InsertSql(sql);
}

/* 通过项目实例ID查询 */
function initFromItemInsId(itemInsId){
    var preAttachSql = new Array();
    preAttachSql.push("select a.attach_id,a.attach_insid,a.attach_name,a.attach_transact,");
    preAttachSql.push("a.attach_number,a.attach_status,a.accepter,");
    preAttachSql.push("to_char(a.accept_time,'yyyy-mm-dd') as accept_time");
    preAttachSql.push(" from ta_sp_attachinstance a where a.item_insid='");
    preAttachSql.push(itemInsId);
    preAttachSql.push("'");
    preAttachSql.push(" order by a.attach_name");
    attachDataset.Open(preAttachSql.join(""));    
}


/* 获取材料列表 */
function getAttachList(){
    var attachList = new Array();
    var attachInstance = null;
    var count=attachDataset.RecordCountAll;
    attachDataset.MoveFirst();
    for(var i=0; i<count ; i++,attachDataset.MoveNext()){
        if(IsSpace(attachDataset.Fields.Field["ATTACH_INSID"].Value)) continue;
        attachInstance = new xzsp.vo.AttachInstance();
        attachInstance.attach_id = attachDataset.Fields.Field["ATTACH_ID"].Value;
        attachInstance.attach_insid = attachDataset.Fields.Field["ATTACH_INSID"].Value;
        attachInstance.attach_name = attachDataset.Fields.Field["ATTACH_NAME"].Value;
        attachInstance.attach_number =attachDataset.Fields.Field["ATTACH_NUMBER"].Value;
        attachInstance.attach_transact =attachDataset.Fields.Field["ATTACH_TRANSACT"].Value;
        attachInstance.attach_status = attachDataset.Fields.Field["ATTACH_STATUS"].Value;
        attachList[i] = attachInstance;

    }
    return attachList;
}


function updateAttach(record){

    var userName=getSysElement("userName");
    var orgid=getSysElement("userorgid");
    var attach_status=record.get('attach_status');
    var insid=record.get('attach_insid');
     var sql="update ta_sp_attachinstance set org_id='"+orgid+"',accepter='"+userName+"',accept_time=sysdate,"
            sql+="attach_status='"+attach_status+"' where attach_insid='"+insid+"'";
         InsertSql(sql);


   
}





/* 提交材料：将材料实例状态修改为’已提交‘ */
function submitAttach(grid){
    updateAttachStatus(grid,PageParms.STATUS_ATTACH_SUBMITTED);
}


/* 撤消材料：将材料实例状态修改为’已撤消‘ */
function repealAttach(grid){
    updateAttachStatus(grid,PageParms.STATUS_ATTACH_REPEALED);
}


/* 修改材料实例状态 */
function updateAttachStatus(grid,status){   
    var records=grid.getSelectionModel().getSelections();
    for(var i=0; i<records.length; i++){
            if(status == PageParms.STATUS_ATTACH_REPEALED){
                var attachName = records[i].get('attach_name'); 
                if(records[i].get('attach_status')!= "已提交"){
                    alert("第"+(i+1)+"条材料【"+attachName+"】还没有提交，不能撤消，请检查");
                    return;
                }
            }
        var actime=SqlToField("select to_char(sysdate,'yyyy-mm-dd') from dual");
              records[i].set("attach_status",status);
              records[i].set("accepter",getSysElement('userName'));
              records[i].set("accept_time",actime);
               var condition="F('attach_id') == '"+records[i].get("attach_id")+"'";
 
                  if(attachDataset.Find(condition)){
                 
                 attachDataset.Edit();
                 attachDataset.Fields.Field['ACCEPT_TIME'].Value=actime;
                 attachDataset.Fields.Field['ACCEPTER'].Value=getSysElement('userName');
                 attachDataset.Fields.Field['ATTACH_STATUS'].Value=status;
                 attachDataset.Update();
                 updateAttach(records[i]);
             
            }
        
    }
  //  selectInsAttach();
    grid.getStore().reload()

  


}





/* 打开上传下载页面 */
function openUploadAndDownView(id,delType,allowAdd,name){
    var isAllowDelete = delType.toUpperCase()=="UPLOAD" ? true : false ;
  //  var cc_form_id =parent.PageParms.isFromBack;

     var viewAddr =getOpenUrlByDjid("20090828105536609657")+"&djbh="+id+"&allowDownload=true&allowDelete="+isAllowDelete+
             "&allowAdd="+allowAdd+"&mode_name="+name ;
    var featrues = "center:yes;help:no;resizable:no;status:no;scroll:no";
    var rtn = window.showModalDialog(viewAddr,window,featrues); 
    return rtn ;
}


</script>

<!-- 提示：以下为页面DOM元素内容 -->
<DIV id=SKbillsheet style="visibility:hidden" jslib="fcsavedj.js&#13;&#10;fcselfuse.js&#13;&#10;fcbasecont.js&#13;&#10;fcother.js&#13;&#10;selectdate.js&#13;&#10;~userfunc.js&#13;&#10;fcdate.js&#13;&#10;../../../ccapp/app_5/js/Namespace.js&#13;&#10;../../../ccapp/app_5/js/vo/vo.js&#13;&#10;../../../ccapp/app_5/js/commonOperation.js" creatorType="20090825142932109877" type="ZW" creator_pagination version="1.0" creator_csslib isprotect="是" islog="否" creator_office_isBindForm="否" creator_showAlert="否" creator_elementAuthoritySwitch="否" hasWorkflowButton="否" creator_remark BLONclose="UnLoadWebOffice();" creatorStyle="creatorBlue" testDbName="bspf" idtype="4" OtherSave="否" isfile="否" keyfield="attach_insid" postop posleft window="当前窗口" controlno="SKButton:0;SKDBedit:0;checkbox:0;label:0;radio:0;listbox:0;textarea:0;combobox:0;password:0;upload:0;SKDBtext:0;chart:0;dbimg:0;img:0;SKBILLgrid:0;shape:0;tab:0;div:0;DsMain_field:0;a:0;button:1;text:0;hr:0;checkboxlist:0;radiolist:0;dropdownlist:0;grid:2;dataset:0;spin:0;excel:0;tree:0;ebshow:0;creatorSubForm:0;creator_div:0;ExtGrid:2;ExtUpload:0;ExtTree:0;Fusionchar:0" posheight poswidth entertype="修改" codeheader="SEQ_ATTACH" mkbh caption="材料信息" dj_sn="20090825161955609398" billtaborder="<root><taborder>btnSubmitAttach</taborder><taborder>btnCancalAttach</taborder></root>" contxml="<root><button><id>btnSubmitAttach</id><id>btnCancalAttach</id></button><dataset><id>attachDataset</id></dataset><ExtGrid><id>grid1</id></ExtGrid></root>" BLONopen="setAuthority();init();" toolbar="不带工具栏">

<TABLE style="WIDTH: 658px; HEIGHT: 210px" width=658 border=0>
   <TBODY>
      <TR>
         <TD><IMG style="DISPLAY: none" src="undefined"><DIV id=div_grid1 style="LEFT: 0px; POSITION: static; TOP: 0px"></DIV><SCRIPT type=text/javascript>var grid1;
Ext.BLANK_IMAGE_URL = '../../fceform/js/Ext/images/default/s.gif';
var grid1_retint = 0;
var grid1_onReady = function(){ 
 Ext.QuickTips.init();
var dataset = document.getElementById("attachDataset");
try{var temp = dataset.Fields.Field.length;}catch(e){if(grid1_retint==0) grid1_retint = setInterval(grid1_onReady,200);dataset =null;return;}finally{if(temp!=null)temp=null;}
clearInterval(grid1_retint);grid1_retint = null ;var pagesize =5;
dataset.PageSize = pagesize ;
var mapping = creator_pt_getmapping(dataset);
var store  = new Ext.data.GroupingStore({
	proxy: new Ext.data.CreatorMemoryProxy(
"attachDataset"), 
	reader: new Ext.data.XmlStringReader({
       record: 'tr',
       totalRecords: 'pages'
   }, mapping),
	sortInfo:{field: 'attach_id', direction: 'ASC'},
    groupField:'attach_status'
});var view = new Ext.grid.GroupingView({
    forceFit:true,
    groupTextTpl: '{text} (共 {[values.rs.length]} 项)'});
var sm = new Ext.grid.RowSelectionModel({singleSelect: true});
var retcm = creator_pt_getcm(dataset,sm);var cm = new Ext.grid.ColumnModel(retcm);
if(typeof(retcm[0].getCount)!='undefined') sm = retcm[0] ;
 grid1 = new Ext.grid.GridPanel({
		el: 'div_grid1',        store: store,
        cm:cm,
		sm: sm,
 			 bodyStyle : 'width:100%',
		viewConfig: {
			forceFit: true		},       loadMask: true,
		view:view,		width:800,      height:172,		split: true,
		region: 'north',
		title:'材料',
		frame:true
		,plugins: new Ext.ux.PanelResizer({
            minHeight: 100        }),
       bbar: new Ext.PagingToolbar({
            pageSize: pagesize,
            store: store,
            displayInfo: true,
            displayMsg:'当前显示第 {0} - {1} 条，共 {2} 条',            plugins: new Ext.ux.SlidingPager()        })		    });
    var grid=grid1;
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
cm.setHidden(9,true); 
cm.setHidden(10,true); 
cm.setHidden(11,true); 
grid.on('cellclick', cellClick);grid1.render();
store.load({params:{start:0, limit:pagesize}});
if(typeof(creator_pt_grids)=='undefined'){creator_pt_grids=new Array();}
creator_pt_grids.push({id:'grid1',obj:grid1,dataset:'attachDataset',isEdit:'false'});
if(typeof(onGridPanelLoaded)=='function') setTimeout(onGridPanelLoaded,0);
};
grid1_onReady();</SCRIPT></TD>
      </TR>
      <TR>
         <TD vAlign=top align=right><BUTTON class=sub_btn id=btnSubmitAttach onmovestart=moveStart() controltype="button" onclick='bill_onclick("submitAttach(creator_pt_grids[0].obj)")' dropstyle="否">提交材料</BUTTON><BUTTON class=sub_btn id=btnCancalAttach onmovestart=moveStart() controltype="button" onclick='bill_onclick("repealAttach(creator_pt_grids[0].obj)")' dropstyle="否">撤消材料</BUTTON></TD>
      </TR>
   </TBODY>
</TABLE>

<?xml:namespace prefix = fc />

<fc:dataset id=attachDataset multiResult="是" saveastable="ta_sp_attachinstance" temptable="TMP_DATASET1" opensortno="1" onValid='bill_ondatasetvalid("<dsid><a1></a1><ATTACH_NAME></ATTACH_NAME><ATTACH_NUMBER></ATTACH_NUMBER><ATTACH_TRANSACT></ATTACH_TRANSACT><ATTACH_STATUS></ATTACH_STATUS><ACCEPTER></ACCEPTER><ACCEPT_TIME></ACCEPT_TIME><ATTACH_UPLOAD></ATTACH_UPLOAD><ATTACH_DOWNLOAD></ATTACH_DOWNLOAD><ATTACH_ID></ATTACH_ID><ATTACH_INSID></ATTACH_INSID><FCATTACH_ID></FCATTACH_ID></dsid>")' onGetText='bill_ondatasetgettext("<dsid><a1></a1><ATTACH_NAME></ATTACH_NAME><ATTACH_NUMBER></ATTACH_NUMBER><ATTACH_TRANSACT></ATTACH_TRANSACT><ATTACH_STATUS></ATTACH_STATUS><ACCEPTER></ACCEPTER><ACCEPT_TIME></ACCEPT_TIME><ATTACH_UPLOAD></ATTACH_UPLOAD><ATTACH_DOWNLOAD></ATTACH_DOWNLOAD><ATTACH_ID></ATTACH_ID><ATTACH_INSID></ATTACH_INSID><FCATTACH_ID></FCATTACH_ID></dsid>")' onSetText='bill_ondatasetsettext("<dsid><a1></a1><ATTACH_NAME></ATTACH_NAME><ATTACH_NUMBER></ATTACH_NUMBER><ATTACH_TRANSACT></ATTACH_TRANSACT><ATTACH_STATUS></ATTACH_STATUS><ACCEPTER></ACCEPTER><ACCEPT_TIME></ACCEPT_TIME><ATTACH_UPLOAD></ATTACH_UPLOAD><ATTACH_DOWNLOAD></ATTACH_DOWNLOAD><ATTACH_ID></ATTACH_ID><ATTACH_INSID></ATTACH_INSID><FCATTACH_ID></FCATTACH_ID></dsid>")' format="<fields><field><fieldname>a1</fieldname><datatype>字符</datatype><displaylabel>全选</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype><showRule>%5B%7Bshowtype%3A%27checkbox%27%7D%5D</showRule></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>ATTACH_NAME</fieldname><datatype>字符</datatype><displaylabel>材料名称</displaylabel><size>500</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>ATTACH_NUMBER</fieldname><datatype>字符</datatype><displaylabel>份数</displaylabel><size>50</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>ATTACH_TRANSACT</fieldname><datatype>字符</datatype><displaylabel>提交方式</displaylabel><size>50</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype><showRule></showRule></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>ATTACH_STATUS</fieldname><datatype>字符</datatype><displaylabel>状态</displaylabel><size>50</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>ACCEPTER</fieldname><datatype>字符</datatype><displaylabel>接收人</displaylabel><size>50</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>ACCEPT_TIME</fieldname><datatype>字符</datatype><displaylabel>接收时间</displaylabel><size>20</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>ATTACH_UPLOAD</fieldname><datatype>字符</datatype><displaylabel>附件上传</displaylabel><size>100</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype><showRule>%5B%7BRule%3A%27%24%7BATTACH_UPLOAD%7D%21%3D%22bb%22%27%2Cshowtype%3A%27%3Cimg%20src%3D%22../../../ccapp/app_5/images/file_upload.gif%22/%3E%27%7D%5D</showRule></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>ATTACH_DOWNLOAD</fieldname><datatype>字符</datatype><displaylabel>附件下载</displaylabel><size>100</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype><showRule>%5B%7BRule%3A%27%24%7BATTACH_UPLOAD%7D%21%3D%22bb%22%27%2Cshowtype%3A%27%3Cimg%20src%3D%22../../../ccapp/app_5/images/file_download.gif%22%20/%3E%27%7D%5D</showRule></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>ATTACH_ID</fieldname><datatype>实数</datatype><displaylabel>ATTACH_ID</displaylabel><size></size><precision>2</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>否</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>ATTACH_INSID</fieldname><datatype>字符</datatype><displaylabel>ATTACH_INSID</displaylabel><size>32</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>否</visible><primarykey>是</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>FCATTACH_ID</fieldname><datatype>字符</datatype><displaylabel>附件ID</displaylabel><size>100</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>否</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field></fields>" columnWidth1Xml="undefined" columnHeight1Xml="undefined" showtypeXml="<root><showType><name>a1</name><showRule>%5B%7Bshowtype%3A%27checkbox%27%7D%5D</showRule></showType><showType><name>ATTACH_UPLOAD</name><showRule>%5B%7BRule%3A%27%24%7BATTACH_UPLOAD%7D%21%3D%22bb%22%27%2Cshowtype%3A%27%3Cimg%20src%3D%22../../../ccapp/app_5/images/file_upload.gif%22/%3E%27%7D%5D</showRule></showType><showType><name>ATTACH_DOWNLOAD</name><showRule>%5B%7BRule%3A%27%24%7BATTACH_UPLOAD%7D%21%3D%22bb%22%27%2Cshowtype%3A%27%3Cimg%20src%3D%22../../../ccapp/app_5/images/file_download.gif%22%20/%3E%27%7D%5D</showRule></showType><showType><name>ATTACH_TRANSACT</name><showRule></showRule></showType></root>"></fc:dataset>
</DIV>
<div id='grid_tip'></div></body></html>
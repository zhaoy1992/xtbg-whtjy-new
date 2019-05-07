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
if(!bDgMode) out.println("</script>");
%>

   <script language='javascript'>
adv_loadjsfile('/eformsys/fceform/css/tabstyle.css');

adv_loadjsfile('/eformsys/fceform/js/Ext/css/SwfUploadPanel.css');
adv_loadjsfile('/eformsys/fceform/js/Ext/SwfUpload.js');
adv_loadjsfile('/eformsys/fceform/js/Ext/SwfUploadPanel.js');
</script>


<!-- 提示：以下为页面自定义JS内容 -->
<script></script>

<!-- 提示：以下为页面DOM元素内容 -->
<DIV id=SKbillsheet style="visibility:hidden" toolbar="不带工具栏" BLONopen="setAuthority();" contxml="<root><ExtUpload><id>ExtUpload1</id></ExtUpload></root>" billtaborder="<root></root>" dj_sn="20100729120017906821" caption="测试附件上传" mkbh codeheader="BBB" entertype="修改" poswidth posheight controlno="SKButton:0;SKDBedit:0;checkbox:0;label:0;radio:0;listbox:0;textarea:0;combobox:0;password:0;upload:0;SKDBtext:0;chart:0;dbimg:0;img:0;SKBILLgrid:0;shape:0;tab:0;div:0;DsMain_field:0;a:0;button:0;text:0;hr:0;checkboxlist:0;radiolist:0;dropdownlist:0;grid:0;dataset:0;spin:0;excel:0;tree:0;ebshow:0;creatorSubForm:0;creator_div:0;ExtGrid:0;ExtUpload:1;ExtTree:0;Fusionchar:0" window="当前窗口" posleft postop keyfield isfile="否" OtherSave="否" idtype="1" testDbName creatorStyle="creatorBlue" BLONclose="UnLoadWebOffice();" creator_remark hasWorkflowButton="否" creator_elementAuthoritySwitch="否" creator_showAlert="是" creator_office_isBindForm="否" islog="否" isprotect="是" creator_csslib version="1.0" creator_pagination type="ZW" creatorType="20090902155009062414" jslib="fcsavedj.js&#13;&#10;fcbasecont.js&#13;&#10;selectdate.js&#13;&#10;~userfunc.js&#13;&#10;fcdate.js">

<DIV id=div_ExtUpload1 style="LEFT: 0px; POSITION: absolute; TOP: 0px"></DIV>

&nbsp;

<SCRIPT type=text/javascript>
Ext.BLANK_IMAGE_URL = '../../fceform/js/Ext/images/default/s.gif';
var w_ExtUpload1 = 538;
var h_ExtUpload1 = 313;
var upobj_ExtUpload1;var refidtemp;var attachidtemp;
var fileListGrid_ExtUpload1;
var del_ExtUpload1 = eval('true');
var isflow = IsSpace(fcpubdata.cc_form_instanceid)?-1:1;
var ExtUpload1_retint = 0;
var ExtUpload1_onReady = function(){ 
 Ext.QuickTips.init();
if(ExtUpload1_retint==0) {ExtUpload1_retint = setInterval(ExtUpload1_onReady,200);return;}
if(document.readyState!="complete") return;
clearInterval(ExtUpload1_retint);ExtUpload1_retint = null ;
var urls = eval('getContextPath()');
var _djsn = localWindowParams("djsn");
var _djid = localWindowParams("djid");
var _djbh = localWindowParams("djbh");
if(typeof(creator_pt_djbh)!='undefined') _djbh=creator_pt_djbh;
if(IsSpace(_djbh)&&isflow==-1) return;
var urls = urls+'/servlet/CreatorPTServlet?key=ExtUpload';
urls += '&uploadid=ExtUpload1';
urls += '&djsn='+_djsn;
urls += '&djid='+_djid;
urls += '&djbh='+_djbh;
urls += '&creator=<%=accesscontroler.getUserID()%>';
urls += '&savetofile=2';
urls += '&savefiledir=';
var uploadFinishFlag = false;
	function createUpload(){
	var uploader = new Ext.ux.SwfUploadPanel({
		title: '上传文件'
		, width: w_ExtUpload1		, height: h_ExtUpload1		,collapsible : true
		,file_size_limit : '16000'
		,fc_addfiles : true
		,fc_delfiles : true
		,fc_uploadfiles :true
		, upload_url:urls
		, flash_url: '../../fceform/js/Ext/swfupload.swf'
		, single_file_select: false
		, confirm_delete: false
		, remove_completed: false
        , file_types : '*.*'});
	uploader.on('uploadStart',function(obj,file){
		if(typeof(Creator_setRelativePath)=='function'){
			var relativePath = eval('Creator_setRelativePath()');
			if(relativePath=='undefined'||typeof(relativePath)!='string'){
				alert('定义的函数Creator_setRelativePath期望返回字符串类型，返回的是【'+typeof(relativePath)+'】，相对路径设置无效！');
			}else{
				uploader.suo.setUploadURL(urls+'&relativePath='+relativePath);
			}
		}
		var note = obj.store.getById(file.id).get('note');note=IsSpace(note)?"":note;
		this.addPostParam( 'note',note );
		if(IsSpace(_djbh) && isflow==1) {this.addPostParam( 'cc_form_instanceid',fcpubdata.cc_form_instanceid);}
	});
	uploader.on('swfUploadLoaded',function(obj,file){
		uploader.focus();
	});
	uploader.on('startUpload', function(t) {
	});
	uploader.on('fileDialogStart', function(t) {if(uploadFinishFlag) {t.store.removeAll(); uploadFinishFlag=false;};
	});
  uploader.on('fileUploadSuccess',function(t,file,data){t.store.getById(file.id).set('attachid',data.attachid);fcpubdata.cc_form_instanceid=data.cc_form_instanceid;});
 uploader.on('allUploadsComplete', function(t, file){
 fileListGrid_ExtUpload1.store.reload({params:{cc_form_instanceid:fcpubdata.cc_form_instanceid}});uploadFinishFlag=true;
});	upobj_ExtUpload1 = uploader;
	return uploader;
	}
function createGridList(){
	var uploadRecode = Ext.data.Record.create([
        {name: 'refid', type: 'string'},
        {name: 'addTime', type: 'string'},
        {name: 'filename', type: 'string'},
        {name: 'filetype', type: 'string'},
        {name: 'note', type: 'string'},
        {name: 'attachid', type: 'string'}
    ]);
    var store = new Ext.data.Store({
        proxy: new Ext.data.HttpProxy({url: urls+'&showlist=showlist'}),
        reader: new Ext.data.JsonReader({
        totalProperty: 'totalCount',
        root: 'result'
        },uploadRecode)
  });
       var sm =new Ext.grid.CheckboxSelectionModel();
       sm.handleMouseDown = Ext.emptyFn;
        var cm = new Ext.grid.ColumnModel([
        new Ext.grid.RowNumberer(),
        sm,
        {header: '文件名', dataIndex: 'filename',width: '20%',renderer:function(val){return decodeURI(val);}},
        {header: '添加时间', dataIndex: 'addTime',width: '20%'},
		{header: '类型', dataIndex: 'filetype',width: '20%',renderer:function(val){return decodeURI(val);}},
        {header: '备注', dataIndex: 'note',width: '20%',renderer:function(val){return decodeURI(IsSpace(val)?"":val);}}
    ]);
        cm.defaultSortable = true;
if(!del_ExtUpload1){
cm.setHidden(1,!del_ExtUpload1);
}
        var grid = new Ext.grid.GridPanel({
        title: '已上传文件列表',
        region: 'center',
        loadMask: true,
        width: w_ExtUpload1,
	    height: h_ExtUpload1,
             margins : '0 0 0 0',
        store: store,
        cm: cm,
        sm: sm,
        tbar: [
        {
            text: '删除',
        iconCls:'deletepanel',
            xtype:del_ExtUpload1?"":'hidden',
            handler :deleteGrid
        },'->'
        ],
        viewConfig: {
        columnsText:'显示的列',
        sortAscText:'升序',
        sortDescText:'降序',
        forceFit: true
		}    });	grid.on('rowdblclick',function(g,index){
		var downloadFrame = document.getElementById("downloadFrame");
		if(downloadFrame==null){
			downloadFrame = document.createElement("iframe");
			downloadFrame.setAttribute("id", "downloadFrame");
			downloadFrame.setAttribute("display", "none");
			downloadFrame.setAttribute("width", "0");
			downloadFrame.setAttribute("height", "0");
			document.body.appendChild(downloadFrame);
		}
		downloadFrame.src = getContextPath()+'/servlet/CreatorPTServlet?key=Extdownload&refid='+g.getStore().getAt(index).get('refid');
	});
    store.load({params:{cc_form_instanceid:fcpubdata.cc_form_instanceid}});
	fileListGrid_ExtUpload1  = grid ;
    return grid;
}
function deleteGrid(){
 var rows = fileListGrid_ExtUpload1.getSelectionModel().getSelections();
				if(rows.length==0){
				Ext.MessageBox.alert('警告', '最少选择一条信息，进行删除!');
				}else{
				Ext.MessageBox.confirm('提示框', '您确定要进行该操作？',function(btn){
				 var delid=""; var delidw="";
				if(btn=='yes'){    
					for(var i=0;i<rows.length;i++){
					 delid=delid+rows[i].get('refid')+'^';   
					}refidtemp=delid;
					for(var i=0;i<rows.length;i++){
					 delidw=delidw+rows[i].get('attachid')+'^';   
					}attachidtemp=delidw;
				  Ext.Ajax.request({
                  url : urls,
                 method : 'POST',
                  params : {
                      ids : delid,
					  deletes :'delete'	
                  },
                      success: function(response, options) {
                       var responseArray = Ext.util.JSON.decode(response.responseText);
                            if(responseArray.success==true){
								fileListGrid_ExtUpload1.getStore().reload({params:{cc_form_instanceid:fcpubdata.cc_form_instanceid}});
                            }
                            else{
                                Ext.Msg.alert('失败',responseArray.msg);
                            }
                         }
              });
				}  		});	}}    var panel = new Ext.TabPanel({
             title : '上传控件面板',
             id : 'div_ExtUpload1',
					width: w_ExtUpload1+10,
					height: h_ExtUpload1+10,
             frame:true,
			 activeTab: 0,
             margins : '0 0 0 0',
             minHeight : 100,
             autoHeight : false,
             items : [				createUpload(),				createGridList()             ]             });				var win = new Ext.Window({					title: '上传窗口'					, width: w_ExtUpload1+20					, height: h_ExtUpload1+60					, resizable: true					, items: [					panel					]				});				win.show();
if(localWindowParams('operType')=='readonly'){
panel.setActiveTab(panel.items.item(1));
panel.items.item(0).setDisabled(true);
panel.items.item(1).getTopToolbar().setVisible(false);
}if(typeof(creator_pt_uppanels)=='undefined'){creator_pt_uppanels=new Array();}
creator_pt_uppanels.push({id:'ExtUpload1',obj:panel});
if(typeof(onUpPanelLoaded)=='function') setTimeout(onUpPanelLoaded,0);
};
function dodoupload(){
upobj_ExtUpload1.startUpload();
}ExtUpload1_onReady();</SCRIPT>
</DIV>
<div id='grid_tip'></div></body></html>
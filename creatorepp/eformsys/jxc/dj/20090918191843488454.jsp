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
		
		//����Ӧ��ȷ����ʽ��Ŀ¼
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
		            <TD><DIV style="BORDER-RIGHT: skyblue 2px solid; BORDER-TOP: skyblue 2px solid; FONT-SIZE: 15px; BACKGROUND: #ffffff; BORDER-LEFT: skyblue 2px solid; WIDTH: 150px; PADDING-TOP: 9px; BORDER-BOTTOM: skyblue 2px solid; HEIGHT: 40px; solid: #000000">���ڼ��ء���</DIV></TD>
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

<!-- ��ʾ������Ϊҳ���JS&CSS���� -->
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
adv_loadjsfile('/eformsys/fceform/js/fcdataset.js');
adv_loadjsfile('/eformsys/fceform/js/Ext/SlidingPager.js');
adv_loadjsfile('/eformsys/fceform/js/Ext/SliderTip.js');
adv_loadjsfile('/eformsys/fceform/js/Ext/PanelResizer.js');
adv_loadjsfile('/eformsys/fceform/js/Ext/XmlTextReader.js');
adv_loadjsfile('/eformsys/fceform/js/Ext/CreatorMemoryProxy.js');

adv_loadjsfile('/eformsys/fceform/js/Ext/css/SwfUploadPanel.css');
adv_loadjsfile('/eformsys/fceform/js/Ext/SwfUpload.js');
adv_loadjsfile('/eformsys/fceform/js/Ext/SwfUploadPanel.js');
adv_loadjsfile('/eformsys/fceform/js/Ext/CreatorMemoryProxy.js');
adv_loadjsfile('/eformsys/fceform/js/Ext/TreeCheckBoxNodeUI.js');
</script>


<!-- ��ʾ������Ϊҳ���Զ���JS���� -->
<script>
function showMessage()
{
    alert(dataset1.tagName + " : " + dataset1.scopName);
}
</script>

<!-- ��ʾ������Ϊҳ��DOMԪ������ -->
<DIV id=SKbillsheet style="visibility:hidden" toolbar="����������" BLONopen="setAuthority();" contxml="<root><textarea><id>textarea1</id></textarea><button><id>button2</id></button><dataset><id>dataset2</id></dataset><ExtGrid><id>ExtGrid1</id></ExtGrid><ExtUpload><id>ExtUpload3</id></ExtUpload><ExtTree><id>ExtTree2</id></ExtTree></root>" billtaborder="<root><taborder>button2</taborder><taborder>textarea1</taborder></root>" dj_sn="20090918191843488454" caption="��֧���̲���" mkbh codeheader="BBB" entertype="�޸�" poswidth posheight controlno="SKButton:0;SKDBedit:0;checkbox:0;label:0;radio:0;listbox:0;textarea:1;combobox:0;password:0;upload:1;SKDBtext:0;chart:0;dbimg:0;img:1;SKBILLgrid:0;shape:0;tab:0;div:1;DsMain_field:0;a:1;button:2;text:1;hr:0;checkboxlist:0;radiolist:0;dropdownlist:0;grid:0;dataset:2;spin:0;excel:0;tree:1;ebshow:0;creatorSubForm:0;creator_div:0;ExtGrid:1;ExtUpload:3;ExtTree:2;Fusionchar:0" window="��ǰ����" posleft postop keyfield isfile="��" OtherSave="��" idtype="1" testDbName creatorStyle="creatorBlue" BLONclose="UnLoadWebOffice();" creator_remark hasWorkflowButton="��" creator_elementAuthoritySwitch="��" creator_showAlert="��" creator_office_isBindForm="��" islog="��" isprotect="��" creator_csslib version="1.0" creator_pagination type="ZW" creatorType="20090918191749849030" jslib="fcbasecont.js&#13;&#10;selectdate.js&#13;&#10;~userfunc.js&#13;&#10;fcdate.js">

<?xml:namespace prefix = fc />

<fc:dataset id=dataset2 format="<fields><field><fieldname>AA</fieldname><datatype>�ַ�</datatype><displaylabel>AA</displaylabel><size>30</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>BB</fieldname><datatype>�ַ�</datatype><displaylabel>BB</displaylabel><size>30</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field></fields>" sqltrans="%F4%D8%E6%D8%D4%F6XrnbXrn%DA%F2%EC%E8Xrn%F6%D0%CC%F6%D8%F4%F6" onSetText='bill_ondatasetsettext("<dsid><AA></AA><BB></BB></dsid>")' onGetText='bill_ondatasetgettext("<dsid><AA></AA><BB></BB></dsid>")' onValid='bill_ondatasetvalid("<dsid><AA></AA><BB></BB></dsid>")' opensortno="1" temptable="TMP_DATASET2" multiResult="��"></fc:dataset>

&nbsp;&nbsp;

<DIV id=ExtTreeDiv_ExtTree2 style="BORDER-RIGHT: #c3daf9 1px solid; BORDER-TOP: #c3daf9 1px solid; LEFT: 0px; OVERFLOW: auto; BORDER-LEFT: #c3daf9 1px solid; BORDER-BOTTOM: #c3daf9 1px solid; POSITION: static; TOP: 0px"></DIV>

&nbsp;

<SCRIPT type=text/javascript>var tree;Ext.onReady(function(){	Ext.BLANK_IMAGE_URL = '../../fceform/js/Ext/images/default/s.gif';    tree = new Ext.tree.TreePanel({		el:'ExtTreeDiv_ExtTree2',		title:'��',		frame:true,	height:200,	width:150,		autoScroll:'true',		loader:new Ext.tree.TreeLoader({		}),		tbar:[			new Ext.form.TextField({				emptyText:'��������ַ�',				allowBlank:true,				listeners:{					render:function(f){						   f.el.on('keydown', filterTree, f, {								buffer: 350						   });					}				}			})		]	});	var root = new Ext.tree.AsyncTreeNode({text:"treeItem",qtip:"treeItem",id:"",leaf:true});	tree.setRootNode(root);/**
ʹ��˵��                      
1.ע�Ͳ�Ҫ�� //��
2.������Բ����˿ؼ���tree��Ext.tree.TreePanel�������root��Ext.tree.AsyncTreeNode������
3.����Ĵ�������һЩ���Ի���������ĳ�е�ĳЩ�ض�������
**/
	tree.render();	root.expand();	var filter = new Ext.tree.TreeFilter(tree, {		clearBlank: true,		autoClear: true	});	function filterTree(e){		var text = e.target.value;		var re = new RegExp(Ext.escapeRe(text), 'i');		filter.filterBy(function(n){			return !n.isLeaf() || re.test(n.text);		});	}	Ext.QuickTips.init();if(Ext.isIE6){var nodes = null;tree.on('beforecollapsenode',function(node){nodes = tree.getChecked();});tree.on('expandnode',function(){if(nodes==null) return;for(var i=0;i<nodes.length;++i){if(nodes[i].isLeaf())nodes[i].getUI().toggleCheck(true);}});}if(typeof(creator_pt_trees)=='undefined'){creator_pt_trees=new Array();}creator_pt_trees.push({id:'ExtTree2',obj:tree});});</SCRIPT>

<IMG style="DISPLAY: none" src="undefined">

<DIV id=div_ExtGrid1 style="LEFT: 0px; POSITION: static; TOP: 0px"></DIV>

<SCRIPT type=text/javascript>var ExtGrid1;
Ext.BLANK_IMAGE_URL = '../../fceform/js/Ext/images/default/s.gif';
var ExtGrid1_retint = 0;
var ExtGrid1_onReady = function(){ 
 Ext.QuickTips.init();
var dataset = document.getElementById("dataset2");
try{var temp = dataset.Fields.Field.length;}catch(e){if(ExtGrid1_retint==0) ExtGrid1_retint = setInterval(ExtGrid1_onReady,200);dataset =null;return;}finally{if(temp!=null)temp=null;}
clearInterval(ExtGrid1_retint);ExtGrid1_retint = null ;var pagesize =-1;
dataset.PageSize = pagesize ;
var mapping = creator_pt_getmapping(dataset);
var store  = new Ext.data.Store({
	proxy: new Ext.data.CreatorMemoryProxy("dataset2"), 
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
		title:'11111',
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
ʹ��˵��                      
1.ע�Ͳ�Ҫ�� //��
2.���Բ�����ǰGrid��sm��cm��store����
3.����Ĵ�������һЩ���Ի���������ĳ�е�ĳЩ�ض�������
**/
ExtGrid1.render();
store.load();
if(typeof(creator_pt_grids)=='undefined'){creator_pt_grids=new Array();}
creator_pt_grids.push({id:'ExtGrid1',obj:ExtGrid1,dataset:'dataset2',isEdit:'false'});
if(typeof(onGridPanelLoaded)=='function') setTimeout(onGridPanelLoaded,0);
};
ExtGrid1_onReady();</SCRIPT>

<BUTTON class=button1 id=button2 style="LEFT: 0px; WIDTH: 75px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() controltype="button">button2</BUTTON>

<DIV id=div_ExtUpload3 style="LEFT: 0px; POSITION: static; TOP: 0px"></DIV>

&nbsp;

<SCRIPT type=text/javascript>
Ext.BLANK_IMAGE_URL = '../../fceform/js/Ext/images/default/s.gif';
var w_ExtUpload3 = 389;
var h_ExtUpload3 = 180;
var upobj_ExtUpload3;var refidtemp;var attachidtemp;
var fileListGrid_ExtUpload3;
var del_ExtUpload3 = eval('true');
var isflow = IsSpace(fcpubdata.cc_form_instanceid)?-1:1;
var ExtUpload3_retint = 0;
var ExtUpload3_onReady = function(){ 
 Ext.QuickTips.init();
if(ExtUpload3_retint==0) {ExtUpload3_retint = setInterval(ExtUpload3_onReady,200);return;}
if(document.readyState!="complete") return;
clearInterval(ExtUpload3_retint);ExtUpload3_retint = null ;
var urls = eval('getContextPath()');
var _djsn = localWindowParams("djsn");
var _djid = localWindowParams("djid");
var _djbh = localWindowParams("djbh");
if(typeof(creator_pt_djbh)!='undefined') _djbh=creator_pt_djbh;
if(IsSpace(_djbh)&&isflow==-1) return;
var urls = urls+'/servlet/CreatorPTServlet?key=ExtUpload';
urls += '&uploadid=ExtUpload3';
urls += '&djsn='+_djsn;
urls += '&djid='+_djid;
urls += '&djbh='+_djbh;
urls += '&creator=<%=accesscontroler.getUserID()%>';
urls += '&savetofile=2';
urls += '&savefiledir=';
var uploadFinishFlag = false;
	function createUpload(){
	var uploader = new Ext.ux.SwfUploadPanel({
		title: '�ϴ��ļ�'
		, width: w_ExtUpload3		, height: h_ExtUpload3		,collapsible : true
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
				alert('����ĺ���Creator_setRelativePath���������ַ������ͣ����ص��ǡ�'+typeof(relativePath)+'�������·��������Ч��');
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
 fileListGrid_ExtUpload3.store.reload({params:{cc_form_instanceid:fcpubdata.cc_form_instanceid}});uploadFinishFlag=true;
});	upobj_ExtUpload3 = uploader;
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
        {header: '�ļ���', dataIndex: 'filename',width: '20%',renderer:function(val){return decodeURI(val);}},
        {header: '���ʱ��', dataIndex: 'addTime',width: '20%'},
		{header: '����', dataIndex: 'filetype',width: '20%',renderer:function(val){return decodeURI(val);}},
        {header: '��ע', dataIndex: 'note',width: '20%',renderer:function(val){return decodeURI(IsSpace(val)?"":val);}}
    ]);
        cm.defaultSortable = true;
if(!del_ExtUpload3){
cm.setHidden(1,!del_ExtUpload3);
}
        var grid = new Ext.grid.GridPanel({
        title: '���ϴ��ļ��б�',
        region: 'center',
        loadMask: true,
        width: w_ExtUpload3,
	    height: h_ExtUpload3,
             margins : '0 0 0 0',
        store: store,
        cm: cm,
        sm: sm,
        tbar: [
        {
            text: 'ɾ��',
        iconCls:'deletepanel',
            xtype:del_ExtUpload3?"":'hidden',
            handler :deleteGrid
        },'->'
        ],
        viewConfig: {
        columnsText:'��ʾ����',
        sortAscText:'����',
        sortDescText:'����',
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
	fileListGrid_ExtUpload3  = grid ;
    return grid;
}
function deleteGrid(){
 var rows = fileListGrid_ExtUpload3.getSelectionModel().getSelections();
				if(rows.length==0){
				Ext.MessageBox.alert('����', '����ѡ��һ����Ϣ������ɾ��!');
				}else{
				Ext.MessageBox.confirm('��ʾ��', '��ȷ��Ҫ���иò�����',function(btn){
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
								fileListGrid_ExtUpload3.getStore().reload({params:{cc_form_instanceid:fcpubdata.cc_form_instanceid}});
                            }
                            else{
                                Ext.Msg.alert('ʧ��',responseArray.msg);
                            }
                         }
              });
				}  		});	}}    var panel = new Ext.TabPanel({
             title : '�ϴ��ؼ����',
             renderTo:'div_ExtUpload3',
             id : 'div_ExtUpload3',
					width: w_ExtUpload3+10,
					height: h_ExtUpload3+10,
             frame:true,
			 activeTab: 0,
             margins : '0 0 0 0',
             minHeight : 100,
             autoHeight : false,
             items : [				createUpload(),				createGridList()             ]             });if(localWindowParams('operType')=='readonly'){
panel.setActiveTab(panel.items.item(1));
panel.items.item(0).setDisabled(true);
panel.items.item(1).getTopToolbar().setVisible(false);
}if(typeof(creator_pt_uppanels)=='undefined'){creator_pt_uppanels=new Array();}
creator_pt_uppanels.push({id:'ExtUpload3',obj:panel});
if(typeof(onUpPanelLoaded)=='function') setTimeout(onUpPanelLoaded,0);
};
function dodoupload(){
upobj_ExtUpload3.startUpload();
}ExtUpload3_onReady();</SCRIPT>

<TEXTAREA id=textarea1 style="LEFT: 0px; WIDTH: 197px; POSITION: static; TOP: 0px; HEIGHT: 97px" onmovestart=moveStart() cols=39 controltype="textarea" value="textarea1"></TEXTAREA>
</DIV>
<div id='grid_tip'></div></body></html>
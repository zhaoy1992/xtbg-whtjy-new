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
			mtJsFileArray("eformsys/fceform/js/ccpub.js", true, optmGetUsdatObj());
			mtJsFileArray("eformsys/fceform/js/fcrundj.js", true, optmGetUsdatObj());
			mtJsFileArray("eformsys/fceform/js/tabpane.js", true, optmGetFlashObj());
			mtJsFileArray("eformsys/fceform/js/fcsavedj.js", true, eppDataWrObj);			
			
			mtJsFileArray("eformsys/fceform/js/Ext/ext-base.js", true, eppDataWrObj);
         mtJsFileArray("eformsys/fceform/js/Ext/ext-all.js", true, eppDataWrObj);
         mtJsFileArray("eformsys/fceform/js/Ext/ext-lang-zh_CN.js", true, eppDataWrObj, "UTF-8");
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
			var mylink = document.createElement("link");
			mylink.setAttribute("type","text/css");
			mylink.setAttribute("rel","stylesheet");
			var _my_namespace_js = "<script src='"+stylePath+"js/namespace.js"+"'></"+"script>";
			window.document.write(_my_namespace_js);
	</script>
		
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
			ex_prePageInit();
		</script>
<link rel="stylesheet" type="text/css" href="../../fceform/js/Ext/css/ext-all.css" />
<!-- ����Ϊҳ���JS&CSS���� -->
<script>
  mylink.setAttribute('href',stylePath+'css/creatorBlue/allStyle.css');
  var myhead = document.getElementsByTagName('head')[0];
  myhead.appendChild(mylink);
  fcpubdata.creatorStyle='creatorBlue';
</script>

<script language='javascript'>
  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/fcbasecont.js');
  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/selectdate.js');
  adv_loadjsfile('eformsys/jxc/dj/../../fceform/../fceformext/js/userfunc.js');
  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/fcdate.js');
  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/business/Wfxw.js');
  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/dao/WfxwDao.js');
  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/common/Common.js');
</script>
<link href='../../fceform/css/tabstyle.css' type='text/css' rel='stylesheet'/>
<link type='text/css' rel='stylesheet' href='../../fceform/css/Button.css'/>
<link type='text/css' rel='stylesheet' href='../../fceform/css/TextStyle.css'/>
<script >document.styleSheets[0].addRule("fc\\:dataset","behavior: url(../../fceform/htc/dataset.htc)",0);</script>
<script src='../../fceform/js/fcdataset.js'></script>
<script type="text/javascript" src="../../fceform/js/Ext/SlidingPager.js"></script>
<script type="text/javascript" src="../../fceform/js/Ext/SliderTip.js"></script>
<script type="text/javascript" src="../../fceform/js/Ext/PanelResizer.js"></script>
<script type="text/javascript" src="../../fceform/js/Ext/XmlTextReader.js"></script>
<script type="text/javascript" src="../../fceform/js/Ext/CreatorMemoryProxy.js"></script>

<script>
function init(){
  cf_queryWfxw();
}

function cf_queryWfxw(){
    var rmdCodeValue= $("rmdCode").value;
    var rmdTypeValue= $("rmdType").value;
    var businessTypeValue= $("businessType").value;
    var ruleMatterValue= $("ruleMatter").value;
    
    var pagePrams = {
      rmdCode : rmdCodeValue,
      rmdType : rmdTypeValue,
      businessType : businessTypeValue,
      ruleMatter : ruleMatterValue
    }
    var sql = Wfxw.queryWfxw(pagePrams);
    alert(sql);
    wfxwdataset.Open(sql);
}

function cf_WfxwReset(){
   ${'rmdCode'}.value="";
   ${'rmdType'}.value=-1;
   ${'businessType'}.value=-1;
   ${'ruleMatter'}.value="";
}
function expWfxwExcel(){

}

function addWfxw (){
   var tempPara="dialogWidth:760px;dialogHeight:400px;";
   var tempURL="20100901180339609140.jsp";
   showModalDialog(tempURL,"window",tempPara);
   reloadExtGrid();
}

function delWfxw(){
}
</script>

<!-- ��ʾ������Ϊҳ��DOMԪ������ -->
<DIV id=SKbillsheet jslib="fcbasecont.js&#13;&#10;selectdate.js&#13;&#10;~userfunc.js&#13;&#10;fcdate.js&#13;&#10;../../../ccapp/app_xzcf/js/business/Wfxw.js&#13;&#10;../../../ccapp/app_xzcf/js/dao/WfxwDao.js&#13;&#10;../../../ccapp/app_xzcf/js/common/Common.js" creatorType="20100830162735203288" type="ZW" toolbar="����������" testDbName dj_sn="20100902174444609101" caption="Υ����Ϊ��ѯ" mkbh creatorStyle="creatorBlue" codeheader="BBB" keyfield BLONopen="setAuthority();init();" BLONclose="UnLoadWebOffice();" window="��ǰ����" entertype="չ��" creator_remark hasWorkflowButton="��" creator_elementAuthoritySwitch="��" creator_showAlert="��" creator_office_isBindForm="��" islog="��" isprotect="��" posleft postop poswidth posheight isfile="��" OtherSave="��" creator_csslib idtype="1" version="1.0" creator_pagination billtaborder="<root><taborder>qryBtn</taborder><taborder>rstBtn</taborder><taborder>expExcel</taborder><taborder>newBtn</taborder><taborder>delBtn</taborder><taborder>rmdCode</taborder><taborder>ruleMatter</taborder><taborder>rmdType</taborder><taborder>businessType</taborder></root>" controlno="SKButton:0;SKDBedit:0;checkbox:6;label:0;radio:0;listbox:0;textarea:0;combobox:4;password:0;upload:0;SKDBtext:0;chart:0;dbimg:0;img:0;SKBILLgrid:0;shape:0;tab:0;div:0;DsMain_field:0;a:0;button:6;text:2;hr:0;checkboxlist:0;radiolist:0;dropdownlist:2;grid:1;dataset:1;spin:0;excel:0;tree:0;ebshow:0;creatorSubForm:0;creator_div:0;ExtGrid:1;ExtUpload:0;ExtTree:0;Fusionchar:0" contxml="<root><combobox><id>rmdType</id><id>businessType</id></combobox><button><id>qryBtn</id><id>rstBtn</id><id>expExcel</id><id>newBtn</id><id>delBtn</id></button><text><id>rmdCode</id><id>ruleMatter</id></text><dataset><id>wfxwdataset</id></dataset><ExtGrid><id>wfxwGrid</id></ExtGrid></root>">

<TABLE cellSpacing=0 cellPadding=0 width="95%" align=center border=1>
<TBODY>
<TR>
<TD>
<TABLE cellSpacing=0 cellPadding=0 width="100%" border=1>
<TBODY>
<TR>
<TD colSpan=4>&nbsp;Υ����Ϊ��Ϣ��ѯ</TD>
</TR>
<TR>
<TD width="15%">Υ����Ϊ����</TD>
<TD width="35%">&nbsp;

<INPUT id=rmdCode style="LEFT: 0px; WIDTH: 143px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() size=26 controltype="text">
</TD>
<TD width="15%">Υ�����</TD>
<TD width="25%">&nbsp;

<SELECT id=rmdType style="LEFT: 0px; WIDTH: 135px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() controltype="combobox" sql check="1" tempvalue="-1" temptext="--��ѡ��--" sqltrans="%F4%D8%E6%D8%D4%F6Xrn%AC%94%CC%A0%96Xr%94Xrn%AC%94%CC%AA%90%A8%98Xrn%DA%F2%EC%E8Xrn%B6%90%CC%AC%9A%9A%98%AA%B4%98%CC%94%90%B6%98%9C%AC%B2%C0Xrn%EC%F2%D6%D8%F2Xrn%D2%u0100Xrn%AC%94%CC%AC%B2%96%98%B2">
<OPTION value=-1 selected>--��ѡ��--</OPTION>
</SELECT>
</TD>
</TR>
<TR>
<TD width="15%">��ҵ����</TD>
<TD width="35%">&nbsp;

<SELECT id=businessType style="LEFT: 0px; WIDTH: 120px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() controltype="combobox" sql check="1" tempvalue="-1" temptext="--��ѡ��--" sqltrans="%F4%D8%E6%D8%D4%F6Xrn%BA%94%CC%A0%96Xr%94%BA%94%CC%AA%90%A8%98Xrn%DA%F2%EC%E8Xrn%B6%90%CC%BA%AC%94%90%B6%A0%AC%AA%CC%94%AC%AA%B4%B6%A0%B6%B8%B6%AC%B2Xrn%EC%F2%D6%D8%F2Xrn%D2%u0100Xrn%BA%94%CC%AC%B2%96%98%B2">
<OPTION value=-1 selected>--��ѡ��--</OPTION>
</SELECT>

����</TD>
<TD width="15%">Υ����Ϊ</TD>
<TD>&nbsp;

<INPUT id=ruleMatter style="LEFT: 0px; WIDTH: 135px; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() size=21 controltype="text">
</TD>
</TR>
</TBODY>
</TABLE>
</TD>
</TR>
<TR>
<TD>
<DIV align=center>
<BUTTON id=qryBtn style="LEFT: 0px; WIDTH: 75px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() controltype="button" onclick='bill_onclick("cf_queryWfxw ()")' dropstyle="��">��ѯ</BUTTON>
<BUTTON id=rstBtn style="LEFT: 0px; WIDTH: 75px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() controltype="button" onclick='bill_onclick("cf_WfxwReset()")' dropstyle="��">����</BUTTON>
<BUTTON id=expExcel style="LEFT: 0px; WIDTH: 75px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() controltype="button" dropstyle="��">����EXCEL</BUTTON>
</DIV>
</TD>
</TR>
<TR>
<TD>
<TABLE cellSpacing=0 cellPadding=0 width="100%" border=1>
<TBODY>
<TR>
<TD>
<DIV align=right>
<BUTTON id=newBtn style="LEFT: 0px; WIDTH: 75px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() controltype="button" onclick='bill_onclick("addWfxw ()")' dropstyle="��">����</BUTTON>
<BUTTON id=delBtn style="LEFT: 0px; WIDTH: 75px; POSITION: static; TOP: 0px; HEIGHT: 25px" onmovestart=moveStart() controltype="button" dropstyle="��">ɾ��</BUTTON>
</DIV>
</TD>
</TR>
<TR>
<TD>&nbsp;

<DIV id=div_wfxwGrid style="LEFT: 0px; POSITION: static; TOP: 0px"></DIV>
<SCRIPT type=text/javascript>Ext.BLANK_IMAGE_URL = '../../fceform/js/Ext/images/default/s.gif';var wfxwGrid_retint = 0;var wfxwGrid_onReady = function(){var dataset = document.getElementById("wfxwdataset");try{var temp = dataset .Fields.Field.length;}catch(e){if(wfxwGrid_retint==0) wfxwGrid_retint = setInterval(wfxwGrid_onReady,200);dataset =null;return;}finally{if(temp!=null)temp=null;}clearInterval(wfxwGrid_retint);wfxwGrid_retint = null ;var pagesize =10;dataset.PageSize = pagesize ;var mapping = creator_pt_getmapping(dataset);var store  = new Ext.data.Store({	proxy: new Ext.data.CreatorMemoryProxy("wfxwdataset"), 	reader: new Ext.data.XmlStringReader({       record: 'tr',       totalRecords: 'pages'   }, mapping)});var sm = new Ext.grid.RowSelectionModel({singleSelect: true});var retcm = creator_pt_getcm(dataset,sm);var cm = new Ext.grid.ColumnModel(retcm);if(typeof(retcm[0].getCount)!='undefined') sm = retcm[0] ; var grid = new Ext.grid.GridPanel({		el: 'div_wfxwGrid',        store: store,        cm:cm,		sm: sm,		viewConfig: {			forceFit: true		},       loadMask: true,		width:959,        height:140,		split: true,		region: 'north',		title:'��ѯ���',		frame:true		,plugins: new Ext.ux.PanelResizer({            minHeight: 100        }),       bbar: new Ext.PagingToolbar({            pageSize: pagesize,            store: store,            displayInfo: true,            displayMsg:'��ǰ��ʾ�� {0} - {1} ������ {2} ��',            plugins: new Ext.ux.SlidingPager()        })		    });/**
ʹ��˵��                      
1.ע�Ͳ�Ҫ�� //��
2.���Բ�����ǰGrid��sm��cm��store����
3.����Ĵ�������һЩ���Ի���������ĳ�е�ĳЩ�ض�������
**/
cm.setHidden(6,true);grid.render();store.load({params:{start:0, limit:pagesize}});if(typeof(creator_pt_grids)=='undefined'){creator_pt_grids=new Array();}creator_pt_grids.push({id:'wfxwGrid',obj:grid,dataset:'wfxwdataset',isEdit:'false'});if(typeof(onGridPanelLoaded)=='function') setTimeout(onGridPanelLoaded,0);};wfxwGrid_onReady();</SCRIPT>
</TD>
</TR>
</TBODY>
</TABLE>
</TD>
</TR>
</TBODY>
</TABLE>

<?xml:namespace prefix = fc />

<fc:dataset id=wfxwdataset opensortno="1" temptable="TMP_DATASET1" multiResult="��" onValid='bill_ondatasetvalid("<dsid><checked></checked><OC_NAME></OC_NAME><RMD_NAME></RMD_NAME><RMD_CODE></RMD_CODE><RMD_RULE></RMD_RULE><RMD_MODIFY_DATE></RMD_MODIFY_DATE><RMD_ID></RMD_ID><VC_ID></VC_ID></dsid>")' onGetText='bill_ondatasetgettext("<dsid><checked></checked><OC_NAME></OC_NAME><RMD_NAME></RMD_NAME><RMD_CODE></RMD_CODE><RMD_RULE></RMD_RULE><RMD_MODIFY_DATE></RMD_MODIFY_DATE><RMD_ID></RMD_ID><VC_ID></VC_ID></dsid>")' onSetText='bill_ondatasetsettext("<dsid><checked></checked><OC_NAME></OC_NAME><RMD_NAME></RMD_NAME><RMD_CODE></RMD_CODE><RMD_RULE></RMD_RULE><RMD_MODIFY_DATE></RMD_MODIFY_DATE><RMD_ID></RMD_ID><VC_ID></VC_ID></dsid>")' format="<fields><field><fieldname>checked</fieldname><datatype>�ַ�</datatype><displaylabel>ȫѡ</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype><showRule>%5B%7Bshowtype%3A%27checkbox%27%7D%5D</showRule></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>OC_NAME</fieldname><datatype>�ַ�</datatype><displaylabel>Υ�����</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>RMD_NAME</fieldname><datatype>�ַ�</datatype><displaylabel>Υ����Ϊ</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>RMD_CODE</fieldname><datatype>�ַ�</datatype><displaylabel>Υ����Ϊ����</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>RMD_RULE</fieldname><datatype>�ַ�</datatype><displaylabel>��������</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>RMD_MODIFY_DATE</fieldname><datatype>����</datatype><displaylabel>�����޸�ʱ��</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat>yyyy-mm-dd</displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>RMD_ID</fieldname><datatype>�ַ�</datatype><displaylabel>Υ����ΪID</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype><showRule>undefined</showRule></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>VC_ID</fieldname><datatype>�ַ�</datatype><displaylabel>��ҵ����</displaylabel><size>10</size><precision>0</precision><fieldkind>������</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>��</isnull><iskey>��</iskey><valid>��</valid><procvalid>��</procvalid><link>��</link><target></target><href></href><visible>��</visible><primarykey>��</primarykey><fieldvalid></fieldvalid><tag></tag><showtype><showRule>undefined</showRule></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field></fields>" columnWidth1Xml="undefined" columnHeight1Xml="undefined" showtypeXml="<root><showType><name>checked</name><showRule>%5B%7Bshowtype%3A%27checkbox%27%7D%5D</showRule></showType><showType><name>RMD_ID</name><showRule>undefined</showRule></showType><showType><name>VC_ID</name><showRule>undefined</showRule></showType></root>"></fc:dataset>

</DIV>
</body></html>
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
		
			//根据应用确定样式的目录
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
<!-- 以下为页面的JS&CSS内容 -->
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
  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/common/Common.js');
  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/business/Wfxw.js');
  adv_loadjsfile('eformsys/jxc/dj/../../fceform/js/../../../ccapp/app_xzcf/js/dao/WfxwDao.js');
</script>
<link href='../../fceform/css/tabstyle.css' type='text/css' rel='stylesheet'/>
<script >document.styleSheets[0].addRule(".fcmask","behavior: url(../../fceform/htc/fcmask.htc)",0);</script>
<script language='vbscript' src='../../fceform/js/fcmask.vbs'></script>
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
    //加载处罚措施
    var sql = Wfxw.queryCfcs();
    tempDataset.Open(sql);

    tempDataset.MoveFirst();
    var tmpbox = document.getElementById('tmpbox');
    var tmpcfcsbox = document.getElementById('cfcsBox');
    for(var i=0;i<tempDataset.RecordCount;i++){
        var str = "<INPUT name=chks id=chks type=checkbox>"
        var newCheckbox = document.createElement(str);
        newCheckbox.value=tempDataset.Fields.Field['PM_ID'].Value;
        var spanStr="<span></span>";
        var spanTmp = document.createElement(spanStr);
        spanTmp.innerHTML = tempDataset.Fields.Field['PM_NAME'].Value;
        tmpcfcsbox.insertBefore(spanTmp,tmpbox);
        tmpcfcsbox.insertBefore(newCheckbox,spanTmp);
        tempDataset.MoveNext();
    }
    //自由裁量权列表
    var rmdId = 0;
    var obj = 1;
    var zyclGridSql = Wfxw.findZycl(rmdId,obj);
    zyclDataSet.Open(zyclGridSql);
    ${'newBtn'}.style.disabled=false;
}
function validate(){
    var flag = true;
    if(flag){
        if(document.getElementById('businessType').value==-1){
            alert("请选择行业分类!");
            flag = false;
        }
    }
    if(flag){
        if(document.getElementById('breakLawType').value==-1){
            alert("请选择违法类别!");
            flag = false;
        }
    }
    if(flag){
        flag = SValidator.validate(${'RMD_NAME'}.value, {
            CHECK_TYPE : "required",
            ARGUMENT : {placeholders : [${'RMD_NAME'}.value]},
            MESSAGE : "违法行为不能为空!"
        }, true);
    }
    if(flag){
        flag = SValidator.validate(${'RMD_NAME'}.value, {
            CHECK_TYPE : "maxlength",
            ARGUMENT : {placeholders : [125],maxlength : 125},
            MESSAGE : "违法行为最大不能超过{0}字符!"
        }, true);
    }
    if(flag){
        flag = SValidator.validate(${'RMD_CODE'}.value, {
            CHECK_TYPE : "required",
            ARGUMENT : {placeholders : [${'RMD_CODE'}.value]},
            MESSAGE : "违法行为编码不能为空!"
        }, true);
    }
    if(flag){
        flag = SValidator.validate(${'RMD_CODE'}.value, {
            CHECK_TYPE : "maxlength",
            ARGUMENT : {placeholders : [10],maxlength : 10},
            MESSAGE : "违法行为编码最大不能超过{0}字符!"
        }, true);
    }
    if(flag){
        var chkarg = document.getElementsByName('chks');    
        var tflag = false;
        for(var j=0;j<chkarg.length;j++){
            if(chkarg[j].checked){tflag=true;}
        }
        if(!tflag){
            alert('请选择处罚措施!');
            flag = false;
        }
    }
    if(flag){
        flag = SValidator.validate(${'RMD_UPPER'}.value, {
            CHECK_TYPE : "required",
            ARGUMENT : {placeholders : [${'RMD_UPPER'}.value]},
            MESSAGE : "罚金限制上限不能为空!"
        }, true);
    }
    if(flag){
        flag = SValidator.validate(${'RMD_UPPER'}.value, {
            CHECK_TYPE : "float",
            ARGUMENT : {placeholders : ["罚金限制上限"]}
        }, false);
    }
    if(flag){
        flag = SValidator.validate(${'RMD_LOWER'}.value, {
            CHECK_TYPE : "required",
            ARGUMENT : {placeholders : [${'RMD_LOWER'}.value]},
            MESSAGE : "罚金限制下限不能为空!"
        }, true);
    }
    if(flag){
        flag = SValidator.validate(${'RMD_LOWER'}.value, {
            CHECK_TYPE : "float",
            ARGUMENT : {placeholders : ["罚金限制下限"]}
        }, false);
    }
    return flag;
}
 
function save(){
    //去全角半角空格
    
    if(validate()){
    //写数据库
    }
}
</script>

<!-- 提示：以下为页面DOM元素内容 -->
<DIV id=SKbillsheet toolbar="不带工具栏" jslib="fcbasecont.js&#13;&#10;selectdate.js&#13;&#10;~userfunc.js&#13;&#10;fcdate.js&#13;&#10;../../../ccapp/app_xzcf/js/common/Common.js&#13;&#10;../../../ccapp/app_xzcf/js/business/Wfxw.js&#13;&#10;../../../ccapp/app_xzcf/js/dao/WfxwDao.js" creatorType="20100830162735203288" type="ZW" contxml="<root><textarea><id>RMD_THE_LAW</id><id>RMD_RULE</id><id>RMD_REMARK</id></textarea><combobox><id>businessType</id><id>breakLawType</id></combobox><button><id>addZfyj</id><id>addCfyj</id><id>saveBtn</id><id>clsBtn</id><id>newBtn</id><id>delBtn</id></button><text><id>RMD_NAME</id><id>RMD_CODE</id><id>RMD_UPPER</id><id>RMD_LOWER</id></text><dataset><id>tempDataset</id><id>zyclDataSet</id><id>wfxwSaveDataset</id></dataset><ExtGrid><id>zyclGrid</id></ExtGrid></root>" controlno="SKButton:0;SKDBedit:0;checkbox:15;label:0;radio:4;listbox:0;textarea:3;combobox:4;password:0;upload:0;SKDBtext:0;chart:0;dbimg:0;img:0;SKBILLgrid:0;shape:0;tab:0;div:0;DsMain_field:0;a:0;button:1;text:4;hr:0;checkboxlist:0;radiolist:0;dropdownlist:2;grid:0;dataset:2;spin:0;excel:0;tree:0;ebshow:0;creatorSubForm:0;creator_div:0;ExtGrid:0;ExtUpload:0;ExtTree:0;Fusionchar:0" billtaborder="<root><taborder>RMD_NAME</taborder><taborder>RMD_CODE</taborder><taborder>RMD_UPPER</taborder><taborder>RMD_LOWER</taborder><taborder>saveBtn</taborder><taborder>clsBtn</taborder><taborder>newBtn</taborder><taborder>delBtn</taborder><taborder>RMD_THE_LAW</taborder><taborder>RMD_RULE</taborder><taborder>addZfyj</taborder><taborder>addCfyj</taborder><taborder>RMD_REMARK</taborder><taborder>businessType</taborder><taborder>breakLawType</taborder></root>" creator_pagination version="1.0" idtype="1" creator_csslib OtherSave="否" isfile="否" posheight poswidth postop posleft isprotect="是" islog="否" creator_office_isBindForm="否" creator_showAlert="是" creator_elementAuthoritySwitch="否" hasWorkflowButton="否" creator_remark entertype="新增" window="当前窗口" BLONclose="UnLoadWebOffice();" BLONopen="setAuthority();init();" keyfield codeheader="BBB" creatorStyle="creatorBlue" mkbh caption="违法行为信息新增" dj_sn="20100902175612515982" testDbName="app_xzcf">

<TABLE border=1 cellSpacing=0 cellPadding=0 width="90%" align=center>
<TBODY>
<TR>
<TD colSpan=4>新增违法行为</TD>
</TR>
<TR>
<TD>行业分类

<FONT color=red>*</FONT>
</TD>
<TD>
<SELECT onresizeend=resizeEnd() style="POSITION: static; WIDTH: 159px; HEIGHT: 25px; TOP: 0px; LEFT: 0px" id=businessType onmovestart=moveStart() onmoveend=moveEnd() onresizestart=resizeStart() temptext="--请选择--" tempvalue="-1" check="1" controltype="combobox" sql sqltrans="%F4%D8%E6%D8%D4%F6Xrn%BA%94%CC%A0%96Xr%94%BA%94%CC%AA%90%A8%98Xrn%DA%F2%EC%E8Xrn%B6%90%CC%BA%AC%94%90%B6%A0%AC%AA%CC%94%AC%AA%B4%B6%A0%B6%B8%B6%AC%B2Xrn%EC%F2%D6%D8%F2Xrn%D2%u0100Xrn%BA%94%CC%AC%B2%96%98%B2">
<OPTION selected value=-1>--请选择--</OPTION>
</SELECT>
</TD>
<TD>违法类别

<FONT color=red>*</FONT>
</TD>
<TD>
<SELECT onresizeend=resizeEnd() style="POSITION: static; WIDTH: 167px; HEIGHT: 25px; TOP: 0px; LEFT: 0px" id=breakLawType onmovestart=moveStart() onmoveend=moveEnd() onresizestart=resizeStart() temptext="--请选择--" tempvalue="-1" check="1" controltype="combobox" sql sqltrans="%F4%D8%E6%D8%D4%F6Xrn%AC%94%CC%A0%96Xr%94Xrn%AC%94%CC%AA%90%A8%98Xrn%DA%F2%EC%E8Xrn%B6%90%CC%AC%9A%9A%98%AA%B4%98%CC%94%90%B6%98%9C%AC%B2%C0Xrn%EC%F2%D6%D8%F2Xrn%D2%u0100Xrn%AC%94%CC%AC%B2%96%98%B2">
<OPTION selected value=-1>--请选择--</OPTION>
</SELECT>
</TD>
</TR>
<TR>
<TD>违法行为

<FONT color=red>*</FONT>
</TD>
<TD colSpan=3>
<INPUT onresizeend=resizeEnd() style="POSITION: static; WIDTH: 298px; HEIGHT: 20px; TOP: 0px; LEFT: 0px" id=RMD_NAME onmovestart=moveStart() onmoveend=moveEnd() onresizestart=resizeStart() size=54 controltype="text">
</TD>
</TR>
<TR>
<TD>违法行为编码

<FONT color=red>*</FONT>
</TD>
<TD colSpan=3>
<INPUT onresizeend=resizeEnd() style="POSITION: static; WIDTH: 110px; HEIGHT: 20px; TOP: 0px; LEFT: 0px" id=RMD_CODE onmovestart=moveStart() onmoveend=moveEnd() onresizestart=resizeStart() controltype="text">
</TD>
</TR>
<TR>
<TD>执法依据</TD>
<TD colSpan=3>
<TEXTAREA onresizeend=resizeEnd() style="POSITION: static; WIDTH: 438px; HEIGHT: 85px; TOP: 0px; LEFT: 0px" id=RMD_THE_LAW onmovestart=moveStart() onmoveend=moveEnd() onresizestart=resizeStart() cols=87 controltype="textarea" induce="否" value="textarea1"></TEXTAREA>
<BUTTON onresizeend=resizeEnd() style="POSITION: static; WIDTH: 96px; HEIGHT: 25px; TOP: 0px; LEFT: 0px" id=addZfyj onmovestart=moveStart() onmoveend=moveEnd() onresizestart=resizeStart() controltype="button" dropstyle="否">添加执法依据</BUTTON>
</TD>
</TR>
<TR>
<TD>处罚依据</TD>
<TD colSpan=3>
<TEXTAREA onresizeend=resizeEnd() style="POSITION: static; WIDTH: 438px; HEIGHT: 85px; TOP: 0px; LEFT: 0px" id=RMD_RULE onmovestart=moveStart() onmoveend=moveEnd() onresizestart=resizeStart() cols=87 controltype="textarea" induce="否" value="textarea2"></TEXTAREA>
<BUTTON onresizeend=resizeEnd() style="POSITION: static; WIDTH: 96px; HEIGHT: 25px; TOP: 0px; LEFT: 0px" id=addCfyj onmovestart=moveStart() onmoveend=moveEnd() onresizestart=resizeStart() controltype="button" dropstyle="否">添加处罚依据</BUTTON>
</TD>
</TR>
<TR>
<TD>处罚措施

<FONT color=red>*</FONT>
</TD>
<TD colSpan=3>
<DIV id=cfcsBox>
<DIV id=tmpbox></DIV>
</DIV>
<?xml:namespace prefix = fc />
<fc:dataset id=tempDataset multiResult="是" temptable="TMP_DATASET2" opensortno="1" onValid='bill_ondatasetvalid("<dsid><PM_ID></PM_ID><PM_NAME></PM_NAME></dsid>")' onGetText='bill_ondatasetgettext("<dsid><PM_ID></PM_ID><PM_NAME></PM_NAME></dsid>")' onSetText='bill_ondatasetsettext("<dsid><PM_ID></PM_ID><PM_NAME></PM_NAME></dsid>")' format="<fields><field><fieldname>PM_ID</fieldname><datatype>字符</datatype><displaylabel>处罚措施ID</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>PM_NAME</fieldname><datatype>字符</datatype><displaylabel>处罚措施名称</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>否</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field></fields>"></fc:dataset>
</TD>
</TR>
<TR>
<TD>罚金限制

<FONT color=red>*</FONT>
</TD>
<TD colSpan=3>上限

<INPUT onresizeend=resizeEnd() style="POSITION: static; WIDTH: 110px; HEIGHT: 20px; TOP: 0px; LEFT: 0px" id=RMD_UPPER onmovestart=moveStart() onmoveend=moveEnd() onresizestart=resizeStart() controltype="text">

元&nbsp;&nbsp;下限
<INPUT onresizeend=resizeEnd() style="POSITION: static; WIDTH: 110px; HEIGHT: 20px; TOP: 0px; LEFT: 0px" id=RMD_LOWER onmovestart=moveStart() onmoveend=moveEnd() onresizestart=resizeStart() controltype="text">

元</TD>
</TR>
<TR>
<TD>是否有效</TD>
<TD colSpan=3>
<INPUT value=1 CHECKED type=radio name=isEfect>

是
<INPUT value=0 type=radio name=isEfect>

否</TD>
</TR>
<TR>
<TD>备注</TD>
<TD colSpan=3>
<TEXTAREA onresizeend=resizeEnd() style="POSITION: static; WIDTH: 441px; HEIGHT: 85px; TOP: 0px; LEFT: 0px" id=RMD_REMARK onmovestart=moveStart() onmoveend=moveEnd() onresizestart=resizeStart() cols=88 controltype="textarea" induce="否" value="textarea3"></TEXTAREA>
</TD>
</TR>
<TR>
<TD colSpan=4 align=middle>&nbsp;

<BUTTON onresizeend=resizeEnd() style="POSITION: static; WIDTH: 75px; HEIGHT: 25px; TOP: 0px; LEFT: 0px" id=saveBtn onmovestart=moveStart() onmoveend=moveEnd() onresizestart=resizeStart() controltype="button" dropstyle="否" onclick='bill_onclick("save()")'>保存</BUTTON>
<BUTTON onresizeend=resizeEnd() style="POSITION: static; WIDTH: 75px; HEIGHT: 25px; TOP: 0px; LEFT: 0px" id=clsBtn onmovestart=moveStart() onmoveend=moveEnd() onresizestart=resizeStart() controltype="button" dropstyle="否">关闭</BUTTON>
</TD>
</TR>
<TR>
<TD colSpan=4 align=right>
<BUTTON onresizeend=resizeEnd() style="POSITION: static; WIDTH: 75px; HEIGHT: 25px; TOP: 0px; LEFT: 0px" id=newBtn onmovestart=moveStart() onmoveend=moveEnd() onresizestart=resizeStart() controltype="button" dropstyle="否">新增</BUTTON>
<BUTTON onresizeend=resizeEnd() style="POSITION: static; WIDTH: 75px; HEIGHT: 25px; TOP: 0px; LEFT: 0px" id=delBtn onmovestart=moveStart() onmoveend=moveEnd() onresizestart=resizeStart() controltype="button" dropstyle="否">删除</BUTTON>
</TD>
</TR>
<TR>
<TD colSpan=4 align=left>
<INPUT value=1 CHECKED type=radio name=faren>

公民
<INPUT value=2 type=radio name=faren>

法人
<INPUT value=3 type=radio name=faren>

其他</TD>
</TR>
<TR>
<TD colSpan=4>&nbsp;

<DIV style="POSITION: static; TOP: 0px; LEFT: 0px" id=div_zyclGrid></DIV>
<SCRIPT type=text/javascript>Ext.BLANK_IMAGE_URL = '../../fceform/js/Ext/images/default/s.gif';var zyclGrid_retint = 0;var zyclGrid_onReady = function(){var dataset = document.getElementById("zyclDataSet");try{var temp = dataset .Fields.Field.length;}catch(e){if(zyclGrid_retint==0) zyclGrid_retint = setInterval(zyclGrid_onReady,200);dataset =null;return;}finally{if(temp!=null)temp=null;}clearInterval(zyclGrid_retint);zyclGrid_retint = null ;var pagesize =10;dataset.PageSize = pagesize ;var mapping = creator_pt_getmapping(dataset);var store  = new Ext.data.Store({	proxy: new Ext.data.CreatorMemoryProxy("zyclDataSet"), 	reader: new Ext.data.XmlStringReader({       record: 'tr',       totalRecords: 'pages'   }, mapping)});var sm = new Ext.grid.RowSelectionModel({singleSelect: true});var retcm = creator_pt_getcm(dataset,sm);var cm = new Ext.grid.ColumnModel(retcm);if(typeof(retcm[0].getCount)!='undefined') sm = retcm[0] ; var grid = new Ext.grid.GridPanel({		el: 'div_zyclGrid',        store: store,        cm:cm,		sm: sm,		viewConfig: {			forceFit: true		},       loadMask: true,		width:909,        height:140,		split: true,		region: 'north',		title:'自由裁量权',		frame:true		,plugins: new Ext.ux.PanelResizer({            minHeight: 100        }),       bbar: new Ext.PagingToolbar({            pageSize: pagesize,            store: store,            displayInfo: true,            displayMsg:'当前显示第 {0} - {1} 条，共 {2} 条',            plugins: new Ext.ux.SlidingPager()        })		    });/**
使用说明                      
1.注释不要用 //。
2.可以操作当前Grid的sm、cm、store对象。
3.这里的代码用于一些个性化的需求，如某列的某些特定工作。
**/
grid.render();store.load({params:{start:0, limit:pagesize}});if(typeof(creator_pt_grids)=='undefined'){creator_pt_grids=new Array();}creator_pt_grids.push({id:'zyclGrid',obj:grid,dataset:'zyclDataSet',isEdit:'false'});if(typeof(onGridPanelLoaded)=='function') setTimeout(onGridPanelLoaded,0);};zyclGrid_onReady();</SCRIPT>
</TD>
</TR>
</TBODY>
</TABLE>

<fc:dataset id=zyclDataSet multiResult="是" temptable="TMP_DATASET1" opensortno="1" onValid='bill_ondatasetvalid("<dsid><checked></checked><RDD_LAW_DEGREE></RDD_LAW_DEGREE><RDD_ILLEGAL_PLOT></RDD_ILLEGAL_PLOT><PM_NAME></PM_NAME><RDD_PUNISHMENT_STANDARDS></RDD_PUNISHMENT_STANDARDS></dsid>")' onGetText='bill_ondatasetgettext("<dsid><checked></checked><RDD_LAW_DEGREE></RDD_LAW_DEGREE><RDD_ILLEGAL_PLOT></RDD_ILLEGAL_PLOT><PM_NAME></PM_NAME><RDD_PUNISHMENT_STANDARDS></RDD_PUNISHMENT_STANDARDS></dsid>")' onSetText='bill_ondatasetsettext("<dsid><checked></checked><RDD_LAW_DEGREE></RDD_LAW_DEGREE><RDD_ILLEGAL_PLOT></RDD_ILLEGAL_PLOT><PM_NAME></PM_NAME><RDD_PUNISHMENT_STANDARDS></RDD_PUNISHMENT_STANDARDS></dsid>")' format="<fields><field><fieldname>checked</fieldname><datatype>字符</datatype><displaylabel>全选</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype><showRule>%5B%7Bshowtype%3A%27checkbox%27%7D%5D</showRule></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>RDD_LAW_DEGREE</fieldname><datatype>字符</datatype><displaylabel>违法程度</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>RDD_ILLEGAL_PLOT</fieldname><datatype>字符</datatype><displaylabel>违法情节</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>PM_NAME</fieldname><datatype>字符</datatype><displaylabel>处罚措施</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>RDD_PUNISHMENT_STANDARDS</fieldname><datatype>字符</datatype><displaylabel>处罚标准</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field></fields>" columnWidth1Xml="undefined" columnHeight1Xml="undefined" showtypeXml="<root><showType><name>checked</name><showRule>%5B%7Bshowtype%3A%27checkbox%27%7D%5D</showRule></showType></root>"></fc:dataset>

<fc:dataset id=wfxwSaveDataset multiResult="否" temptable="TMP_DATASET1" opensortno="1" onValid='bill_ondatasetvalid("<dsid><a></a></dsid>")' onGetText='bill_ondatasetgettext("<dsid><a></a></dsid>")' onSetText='bill_ondatasetsettext("<dsid><a></a></dsid>")' format="<fields><field><fieldname>a</fieldname><datatype>字符</datatype><displaylabel>新建字段</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field></fields>"></fc:dataset>

</DIV>
</body></html>
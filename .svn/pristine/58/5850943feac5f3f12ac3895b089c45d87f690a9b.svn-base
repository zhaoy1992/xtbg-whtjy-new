<%@ page contentType="text/html; charset=GBK" %><%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.frameworkset.common.poolman.DBUtil"%>

<%AccessControl accesscontroler = AccessControl.getInstance();
  accesscontroler.checkAccess(request, response);
  String appPath = "app_"+accesscontroler.getCurrentSystemID();
  String appId = accesscontroler.getCurrentSystemID();
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html xmlns:fc xmlns:v="urn:schemas-microsoft-com:vml">
	<HEAD>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">		
		<STYLE> .userData{behavior:url(#default#userData);}
	</STYLE>		
		<script src="../../fceform/js/fcpub.js"></script>
		<script src="../../fceform/js/fcrundj.js"></script>
		<script src="../../fceform/js/tabpane.js"></script>
		<script src="../../fceform/js/ccpub.js" defer></script>
		<script src="../../fceform/js/ccapp_pub.js" defer></script>		
		<script src="../../../eformsys/gaeditor/js/gaeditor.js" defer></script>
		<script src="../../../iWebOffice2006/js/iWebOffice2006.js" defer></script>
		<script langage="javascript">
			//根据应用确定样式的目录
			var stylePath = "../../../ccapp/<%=appPath%>/"; 
			var mylink = document.createElement("link");
			mylink.setAttribute("type","text/css");
			mylink.setAttribute("rel","stylesheet");
			var _my_namespace_js = "<script src='"+stylePath+"js/namespace.js"+"'></"+"script>";
			window.document.write(_my_namespace_js);		
		</script>
		<%@ include file="../../../iWebOffice2006/js/iWebOffice2006Event.jsp"%>
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
pub_djhtm();
		</script>
<script type='javascript'>mylink.setAttribute('href',stylePath+'css/creatorBlue/allStyle.css');var myhead = document.getElementsByTagName('head')[0];myhead.appendChild(mylink);fcpubdata.creatorStyle='creatorBlue';</script><script src='../../fceform/js/fcopendj.js'></script><script defer src='../../fceform/js/fcsavedj.js'></script><script src='../../fceform/js/fcselfuse.js'></script><script src='../../fceform/js/fcbasecont.js'></script><script defer src='../../fceform/js/fcother.js'></script><script defer src='../../fceform/js/selectdate.js'></script><script src='../../fceform/../fceformext/js/userfunc.js'></script><script src='../../fceform/js/fcdate.js'></script><script src='../../fceform/js/../../../ccapp/app_5/js/commonOperation.js'></script><link href=../../fceform/css/tabstyle.css type=text/css rel=stylesheet><script>var mylink0 = document.createElement("link");mylink0.setAttribute("type","text/css");mylink0.setAttribute("rel","stylesheet");mylink0.setAttribute("href",stylePath+"css/"+fcpubdata.creatorStyle+"/style_right.css");var myhead0 = document.getElementsByTagName("head")[0];myhead0.appendChild(mylink0);</script><link rel="stylesheet" type="text/css" href="../../fceform/js/Ext/css/ext-all.css" /><script type="text/javascript" src="../../fceform/js/Ext/ext-base.js"></script><script type="text/javascript" src="../../fceform/js/Ext/ext-all-debug.js"></script><script type="text/javascript" charset="utf-8" src="../../fceform/js/Ext/ext-lang-zh_CN.js"></script><link type='text/css' rel='stylesheet' href='../../fceform/css/Button.css'/><link type='text/css' rel='stylesheet' href='../../fceform/css/TextStyle.css'/><script >document.styleSheets[0].addRule("fc\\:dataset","behavior: url(../../fceform/htc/dataset.htc)",0);</script><script src='../../fceform/js/fcdataset.js'></script><script type="text/javascript" src="../../fceform/js/Ext/SlidingPager.js"></script><script type="text/javascript" src="../../fceform/js/Ext/SliderTip.js"></script><script type="text/javascript" src="../../fceform/js/Ext/PanelResizer.js"></script><script type="text/javascript" src="../../fceform/js/Ext/XmlTextReader.js"></script><script type="text/javascript" src="../../fceform/js/Ext/CreatorMemoryProxy.js"></script>
<script>var ec_id='<%=request.getParameter("ec_id")%>';


/*预受理查询*/
function queryPre(){
    if(!checkInputForPre()){
        return;  //如果验证不通过，则返回
    }
    var preSqlStr = new Array();
    preSqlStr.push("select i.item_insid,i.instance_code,i.item_insname,");
    preSqlStr.push("i.apply_name as apply_name,");
    preSqlStr.push("to_char(i.apply_date,'yyyy-mm-dd') as apply_date,");
    preSqlStr.push("to_char(i.accept_time,'yyyy-mm-dd') as accept_time");
    preSqlStr.push(" from v_sp_instance_web i");
    preSqlStr.push(" where i.status='预受理' and i.is_accepted='N'");
    preSqlStr.push(" and i.ec_id='");
    preSqlStr.push(ec_id);
    preSqlStr.push("'");
    var applyer = getRadioValue("applyTypeCtrl") ; //申请者类型
    if(applyer != "0"){
        preSqlStr.push(" and i.apply_type='");
        preSqlStr.push(applyer);
        preSqlStr.push("'");
    }
    //根据输入条件自动组合查询条件
    var applyName = trim($('txtPersonName').value);
    var instanceCode = trim($('txtAcceptNum').value);
    var endTime = trim($('txtTimeEnd').value);
    var startTime = trim($('txtTimeStart').value);
    var endTime = trim($('txtTimeEnd').value);
    if(!IsSpace(applyName)){ //申请者名称
        preSqlStr.push(" and i.apply_name like '%");
        preSqlStr.push(applyName);
        preSqlStr.push("%'");
    }
    if(!IsSpace(instanceCode)){ //受理流水号
        preSqlStr.push(" and i.instance_code like '%");
        preSqlStr.push(instanceCode);
        preSqlStr.push("%'");
    }
    if(!IsSpace(startTime)){  //受理日期起
        preSqlStr.push(" and i.apply_date >= to_date('");
        preSqlStr.push(startTime);
        preSqlStr.push("','yyyy-mm-dd')");
    }
    if(!IsSpace(endTime)){  //受理日期止
        preSqlStr.push(" and i.apply_date <= to_date('");
        preSqlStr.push(endTime);
        preSqlStr.push("'||' 23:59:59','yyyy-mm-dd hh24:mi:ss')"); //结束日期须取到最后一秒
    }	
    preDataset.Open(preSqlStr.join(""));
}

/* 输入验证 */
function checkInputForPre(){
    var checker = new checkList();
    if(!IsSpace($('txtTimeStart').value) && !IsSpace($('txtTimeEnd').value)){
        if($('txtTimeStart').value > $('txtTimeEnd').value){
            alert("申请日期起止值输入错误，开始日期不能大于结束日期，请检查");
            return false;
        }
    }
    if(!IsSpace($('txtPersonName').value) && ($('txtApplyer').value=="0")){
        alert("请选择申请者类型");
        return false;
    }
    return true;
}


/* 清空输入项的值 */
function clearInput(){
    $('txtAcceptNum').value = "";
    setRadioChecked("applyTypeCtrl","0");
    $('txtPersonName').value = "";
    $('txtTimeStart').value = "";
    $('txtTimeEnd').value = ""
}

/* 双击返回主调界面 */
function rtn2Main(){
    window.returnValue = preDataset.Fields.Field['item_insid'].Value;
    window.close();
}</script><DIV id=SKbillsheet jslib="fcopendj.js&#13;&#10;fcsavedj.js&#13;&#10;fcselfuse.js&#13;&#10;fcbasecont.js&#13;&#10;fcother.js&#13;&#10;selectdate.js&#13;&#10;~userfunc.js&#13;&#10;fcdate.js&#13;&#10;../../../ccapp/app_5/js/commonOperation.js" creatorType="20090825142958890821" type="ZW" toolbar="不带工具栏" billtaborder="<root><taborder>btnQuery</taborder><taborder>btnClear</taborder><taborder>btnClose</taborder><taborder>txtAcceptNum</taborder><taborder>txtTimeStart</taborder><taborder>txtTimeEnd</taborder><taborder>txtPersonName</taborder></root>" testDbName="bspf" dj_sn="20090827151939437040" caption="已预受理查询" mkbh creatorStyle="creatorBlue" codeheader="BBB" keyfield BLONopen="setAuthority();queryPre();" BLONclose="UnLoadWebOffice();" window="当前窗口" entertype="修改" creator_remark hasWorkflowButton="否" creator_elementAuthoritySwitch="否" creator_showAlert="否" creator_office_isBindForm="否" islog="否" isprotect="是" posleft postop poswidth="800" posheight="600" isfile="否" OtherSave="否" creator_csslib="style_right.css" idtype="1" version="1.0" creator_pagination controlno="SKButton:0;SKDBedit:0;checkbox:0;label:0;radio:0;listbox:0;textarea:0;combobox:0;password:0;upload:0;SKDBtext:0;chart:0;dbimg:0;img:0;SKBILLgrid:0;shape:0;tab:0;div:0;DsMain_field:0;a:0;button:0;text:0;hr:0;checkboxlist:0;radiolist:0;dropdownlist:0;grid:0;dataset:0;spin:0;excel:0;tree:0;ebshow:0;creatorSubForm:0;creator_div:0;ExtGrid:1;ExtUpload:0;ExtTree:0" contxml="<root><button><id>btnQuery</id><id>btnClear</id><id>btnClose</id></button><text><id>txtAcceptNum</id><id>txtTimeStart</id><id>txtTimeEnd</id><id>txtPersonName</id></text><dataset><id>preDataset</id></dataset><ExtGrid><id>ExtGrid1</id></ExtGrid></root>"><TABLE width="100%">
<TBODY>
<TR>
<TD>
<TABLE class=table_function width="100%">
<TBODY>
<TR>
<TD class=color width="15%">预受理号</TD>
<TD width="35%"><INPUT id=txtAcceptNum style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() size=38 controltype="text"></TD>
<TD class=color width="15%">申请日期</TD>
<TD><INPUT id=txtTimeStart style="LEFT: 0px; WIDTH: 40%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() size=15 controltype="text" onclick='bill_onclick("SelectDate()")'>至&nbsp;<INPUT id=txtTimeEnd style="LEFT: 0px; WIDTH: 40%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() size=16 controltype="text" onclick='bill_onclick("SelectDate()")'></TD></TR>
<TR>
<TD class=color>申请者类别</TD>
<TD><INPUT style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; BORDER-LEFT: 0px; BORDER-BOTTOM: 0px" type=radio CHECKED value=0 name=RGapplyTypeCtrl>全部<INPUT style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; BORDER-LEFT: 0px; BORDER-BOTTOM: 0px" type=radio value=1 name=RGapplyTypeCtrl>申请单位<INPUT style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; BORDER-LEFT: 0px; BORDER-BOTTOM: 0px" type=radio value=2 name=RGapplyTypeCtrl>申请人<SPAN style="TEXT-ALIGN: right"></SPAN></TD>
<TD class=color>申请者名称</TD>
<TD><INPUT id=txtPersonName style="LEFT: 0px; WIDTH: 100%; POSITION: static; TOP: 0px; HEIGHT: 20px" onmovestart=moveStart() controltype="text"></TD></TR></TBODY></TABLE></TD></TR>
<TR>
<TD align=middle><BUTTON class=btn id=btnQuery onmovestart=moveStart() controltype="button" onclick='bill_onclick("queryPre();")' dropstyle="否">查询</BUTTON><BUTTON class=btn id=btnClear onmovestart=moveStart() controltype="button" onclick='bill_onclick("clearInput();")' dropstyle="否">重置</BUTTON><BUTTON class=btn id=btnClose onmovestart=moveStart() controltype="button" onclick='bill_onclick("window.close();")' dropstyle="否">关闭</BUTTON></TD></TR>
<TR>
<TD>&nbsp; 
<DIV style="DISPLAY: inline">&nbsp;</DIV></TD></TR></TBODY></TABLE><?xml:namespace prefix = fc /><fc:dataset id=preDataset multiResult="是" temptable="TMP_DATASET3" opensortno="1" onValid='bill_ondatasetvalid("<dsid><ITEM_INSID></ITEM_INSID><INSTANCE_CODE></INSTANCE_CODE><ITEM_INSNAME></ITEM_INSNAME><APPLY_NAME></APPLY_NAME><APPLY_DATE></APPLY_DATE><ACCEPT_TIME></ACCEPT_TIME></dsid>")' onGetText='bill_ondatasetgettext("<dsid><ITEM_INSID></ITEM_INSID><INSTANCE_CODE></INSTANCE_CODE><ITEM_INSNAME></ITEM_INSNAME><APPLY_NAME></APPLY_NAME><APPLY_DATE></APPLY_DATE><ACCEPT_TIME></ACCEPT_TIME></dsid>")' onSetText='bill_ondatasetsettext("<dsid><ITEM_INSID></ITEM_INSID><INSTANCE_CODE></INSTANCE_CODE><ITEM_INSNAME></ITEM_INSNAME><APPLY_NAME></APPLY_NAME><APPLY_DATE></APPLY_DATE><ACCEPT_TIME></ACCEPT_TIME></dsid>")' format="<fields><field><fieldname>ITEM_INSID</fieldname><datatype>字符</datatype><displaylabel>项目实例ID</displaylabel><size>32</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>否</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>INSTANCE_CODE</fieldname><datatype>字符</datatype><displaylabel>流水号</displaylabel><size>50</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>ITEM_INSNAME</fieldname><datatype>字符</datatype><displaylabel>项目名称</displaylabel><size>200</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>APPLY_NAME</fieldname><datatype>字符</datatype><displaylabel>申请者</displaylabel><size>500</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>APPLY_DATE</fieldname><datatype>字符</datatype><displaylabel>申请日期</displaylabel><size>20</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field><field><fieldname>ACCEPT_TIME</fieldname><datatype>字符</datatype><displaylabel>预受理日期</displaylabel><size>20</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag><showtype></showtype><columnHeight1></columnHeight1><columnWidth1></columnWidth1></field></fields>"></fc:dataset> &nbsp;
<DIV id=div_ExtGrid1 style="LEFT: 0px; POSITION: static; TOP: 0px"></DIV>
<SCRIPT type=text/javascript>var ExtGrid1_retint = 0;var ExtGrid1_onReady = function(){var dataset = document.getElementById("preDataset");try{var temp = dataset .Fields.Field.length;}catch(e){if(ExtGrid1_retint==0) ExtGrid1_retint = setInterval(ExtGrid1_onReady,200);dataset =null;return;}finally{if(temp!=null)temp=null;}clearInterval(ExtGrid1_retint);ExtGrid1_retint = null ;var pagesize =5;dataset.PageSize = pagesize ;var mapping = creator_pt_getmapping(dataset);var store  = new Ext.data.Store({	proxy: new Ext.data.CreatorMemoryProxy("preDataset"), 	reader: new Ext.data.XmlStringReader({       record: 'tr',       totalRecords: 'pages'   }, mapping)});var sm = new Ext.grid.RowSelectionModel({singleSelect: true});var retcm = creator_pt_getcm(dataset,sm);var cm = new Ext.grid.ColumnModel(retcm);if(typeof(retcm[0].getCount)!='undefined') sm = retcm[0] ; var grid = new Ext.grid.GridPanel({		el: 'div_ExtGrid1',        store: store,        cm:cm,		sm: sm,		viewConfig: {			forceFit: true		},       loadMask: true,		width:800,        height:140,		split: true,		region: 'north',		title:'呵呵',		frame:true		,plugins: new Ext.ux.PanelResizer({            minHeight: 100        }),       bbar: new Ext.PagingToolbar({            pageSize: pagesize,            store: store,            displayInfo: true,            displayMsg:'当前显示第 {0} - {1} 条，共 {2} 条',            plugins: new Ext.ux.SlidingPager()        })		    });/**
使用说明                      
1.注释不要用 //。
2.可以操作当前Grid的sm、cm、store对象。
3.这里的代码用于一些个性化的需求，如某列的某些特定工作。
**/
grid.render();store.load({params:{start:0, limit:pagesize}});if(typeof(creator_pt_grids)=='undefined'){creator_pt_grids=new Array();}creator_pt_grids.push({id:'ExtGrid1',obj:grid,dataset:'preDataset',isEdit:'false'});};ExtGrid1_onReady();</SCRIPT>
</DIV></body></html>
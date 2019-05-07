<%@ page contentType="text/html; charset=gb2312" %><!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html xmlns:fc xmlns:v="urn:schemas-microsoft-com:vml">
	<HEAD>
		<STYLE> .userData{behavior:url(#default#userData);}
	@import url(../../fceform/css/dj.css); 
	</STYLE>
		<script src="../../fceform/js/fcpub.js"></script>
		<script src="../../fceform/js/fcrundj.js"></script>
		<script src="../../fceform/js/tabpane.js"></script>		
	</HEAD>
	<body background="../../fceform/images/ef_run_background.gif" onload="pub_window_onload()"
		onkeydown="RunTabindex()" onbeforeunload="pub_window_onbeforeunload()" onkeypress="pub_window_onkeypress()"
		onresize="pub_window_onresize()">
		<script>
var pubdjbh=parent.sOpenDjNo;
var pubEdit=false;   			
var pubDataSet=null;
var pubRequest=parent.oRequest;
var pubEformEnterStatus="OK"; 
pub_djhtm();
		</script>
<script>function loadGridData(){
    var djid=parent.topdjid;
    var oid = parent.oid;
    var str="select t.oid,t.ctrl_id,decode(t.perattr_type,-2,'只读元素',1,'disabled',2,'不可见',0,'可见',3,'只读',4,'允许修改，保留痕迹',5,'领导手写批注',6,'成文员文档核稿',7,'允许修改，保留痕迹，可修订',8,'允许修改，无痕迹',9,'成文员文档核稿(带套红)',10,'清稿有痕迹',11,'文档核稿（只读）','是否为新的权限？') as remark,t.djid from td_form_perattr t where t.djid="+djid+" and t.oid='"+oid+"'" ;
    dsMain.Open(str); 
}

function deleteRow(){
var tt=dsMain.Fields.Field['ctrl_id'].Value;
var ss=dsMain.Fields.Field['oid'].Value;
var sql="delete from td_form_perattr t where t.ctrl_id='"+tt+"' and t.oid='"+ss+"'";
//var sql="delete from td_form_perattr t where t.ctrl_id='"+tt+"'";
if(confirm("你确认要删除当前行吗？")){
    var result = InsertSql(sql);
    if(result==""){
        alert("删除成功！");
        window.location.reload();
    }else{
        alert("删除失败！");
        alert(result);
        return;
    }
}
}</script><script src='../../fceform/js/fcopendj.js'></script><script defer src='../../fceform/js/fcsavedj.js'></script><script src='../../fceform/js/fcselfuse.js'></script><script src='../../fceform/js/fcbasecont.js'></script><script defer src='../../fceform/js/fcother.js'></script><script defer src='../../fceform/js/selectdate.js'></script><script src='../../fceform/../fceformext/js/userfunc.js'></script><link href=../../fceform/css/tabstyle.css type=text/css rel=stylesheet><link type='text/css' rel='stylesheet' href='../../fceform/css/Button.css'/><script >document.styleSheets[0].addRule("fc\\:webgrid","behavior: url(../../fceform/htc/webgrid.htc)",0);</script><script src='../../fceform/js/fcwebgrid.js'></script><script >document.styleSheets[0].addRule("fc\\:fc_code","behavior: url(../../fceform/htc/fc_code.htc)",0);</script><script >document.styleSheets[0].addRule("fc\\:dataset","behavior: url(../../fceform/htc/dataset.htc)",0);</script><script src='../../fceform/js/fcdataset.js'></script>
<DIV id=SKbillsheet toolbar="不带工具栏" jslib="fcopendj.js&#13;&#10;fcsavedj.js&#13;&#10;fcselfuse.js&#13;&#10;fcbasecont.js&#13;&#10;fcother.js&#13;&#10;selectdate.js&#13;&#10;~userfunc.js" type="11" billtaborder="<root><taborder>grid1</taborder><taborder>button1</taborder><taborder>button2</taborder></root>" dj_sn="1783" caption="1783" mkbh codeheader="BBB" keyfield window="当前窗口" entertype="修改" posleft postop poswidth posheight isfile="否" OtherSave="否" idtype="1" version="1.0" controlno="SKButton:0;SKDBedit:0;checkbox:0;label:1;radio:0;listbox:0;textarea:0;combobox:0;password:0;upload:0;SKDBtext:0;chart:0;dbimg:0;img:0;SKBILLgrid:0;shape:0;tab:0;div:0;DsMain_field:0;a:0;button:3;text:0;hr:0;checkboxlist:0;radiolist:0;dropdownlist:0;grid:1;dataset:1;spin:0;excel:0;tree:0;ebshow:0" contxml="<root><label><id>label1</id></label><button><id>button1</id><id>button2</id></button><grid><id>grid1</id></grid><dataset><id>dsMain</id></dataset></root>" BLONopen="loadGridData()"><?xml:namespace prefix = fc /><fc:dataset id=dsMain opensortno="1" temptable="TMP_DATASET1" saveastable="td_form_perattr" format="<fields>

<field><fieldname>oid</fieldname><datatype>字符</datatype><displaylabel>活动id</displaylabel><size>100</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag></field>

<field><fieldname>ctrl_id</fieldname><datatype>字符</datatype><displaylabel>控件id</displaylabel><size>128</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag></field>

<field><fieldname>perattr_type</fieldname><datatype>整数</datatype><displaylabel>权限类型</displaylabel><size>100</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>否</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag></field>

<field><fieldname>remark</fieldname><datatype>字符</datatype><displaylabel>权限控制类型</displaylabel><size>200</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag></field>

<field><fieldname>djid</fieldname><datatype>实数</datatype><displaylabel>djid</displaylabel><size>22</size><precision>2</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag></field>

</fields>" 

onValid='bill_ondatasetvalid("<dsid><oid></oid><ctrl_id></ctrl_id><perattr_type></perattr_type><remark></remark><djid></djid></dsid>")' onGetText='bill_ondatasetgettext("<dsid><oid></oid><ctrl_id></ctrl_id><perattr_type></perattr_type><remark></remark><djid></djid></dsid>")' onSetText='bill_ondatasetsettext("<dsid><oid></oid><ctrl_id></ctrl_id><perattr_type></perattr_type><remark></remark><djid></djid></dsid>")'></fc:dataset><fc:webgrid id=grid1 onkeydown='bill_ongridkeydown("<grid1><col></col><col></col><col></col><col></col></grid1>")' ondblclick='bill_ongriddblclick("<grid1><col></col><col></col><col></col><col></col></grid1>")' onclick='bill_ongridclick("<grid1><col></col><col></col><col></col><col></col></grid1>")' width="412" height="171" format="<cols><col><fname>oid</fname><cname>活动id</cname><width>19</width><dtype>字符</dtype><readonly>否</readonly><visible>是</visible><u></u><v></v><s></s><r></r><columnwidth>80</columnwidth><align>left</align></col><col><fname>ctrl_id</fname><cname>控件id</cname><width>128</width><dtype>字符</dtype><readonly>否</readonly><visible>是</visible><u></u><v></v><s></s><r></r><columnwidth>120</columnwidth><align>left</align></col><col><fname>remark</fname><cname>权限控制类型</cname><width>100</width><dtype>字符</dtype><readonly>否</readonly><visible>是</visible><u></u><v></v><s></s><r></r><columnwidth>120</columnwidth><align>left</align></col><col><fname>djid</fname><cname>djid</cname><width>22</width><dtype>实数</dtype><readonly>否</readonly><visible>是</visible><u></u><v></v><s></s><r></r><columnwidth>80</columnwidth><align>left</align></col></cols>" top="49" left="25" dataset="dsMain" canselect="是" autoheight="否" autowidth="否" autoappend="否" readonly="是" visible="是" SetRowHeight="是" hideVscroll="否" hideHscroll="否" autosize="否" bodyrowheight="-1" bodyrows="-1">
<TABLE id=t style="TABLE-LAYOUT: fixed; LEFT: 0px; POSITION: absolute; TOP: 0px; BORDER-COLLAPSE: collapse" cellSpacing=0 cellPadding=1 frame=box>
<TBODY>
<TR class=fcGridFirstRow>
<TD></TD></TR></TBODY></TABLE></fc:webgrid><BUTTON id=button1 style="LEFT: 371px; WIDTH: 75px; POSITION: absolute; TOP: 10px; HEIGHT: 25px" onmovestart=moveStart() controltype="button" dropstyle="否" onclick='bill_onclick("deleteRow()")'>删除</BUTTON><BUTTON id=button2 style="LEFT: 263px; WIDTH: 75px; POSITION: absolute; TOP: 10px; HEIGHT: 25px" onmovestart=moveStart() controltype="button" dropstyle="否" onclick='bill_onclick("loadGridData()")'>刷新</BUTTON> 
<DIV id=label1 style="LEFT: 26px; WIDTH: 65px; POSITION: absolute; TOP: 23px; HEIGHT: 15px" onmovestart=moveStart() noWrap controltype="label" value="label1" NotBg="否">已设置权限控制的元素：</DIV></DIV></body></html>
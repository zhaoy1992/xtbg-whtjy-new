<%@ page language="java" pageEncoding="GBK"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%AccessControl accesscontroler = AccessControl.getInstance();
  accesscontroler.checkAccess(request, response);
%>
<%
String userName = (String)session.getAttribute("subsystem_id_nouse");
if(userName == null || "".equals(userName.trim()) || "module".equalsIgnoreCase(userName.trim())){
	userName = "";
}else{
	userName = "APP_"+userName.trim().toUpperCase()+".";
}
//System.out.println("userName:"+userName);
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html xmlns:fc xmlns:v="urn:schemas-microsoft-com:vml">
	<HEAD>
		<STYLE> .userData{behavior:url(#default#userData);}
	@import url(../../fceform/css/dj.css); 
	</STYLE>
		<script src="../../fceform/js/fcpub.js"></script>
		<script src="../../fceform/js/fcrundj.js"></script>
		<script src="../../fceform/js/tabpane.js"></script>		
		<script langage="javascript">
			var mylink = document.createElement("link");
			mylink.setAttribute("type","text/css");
			mylink.setAttribute("rel","stylesheet");
			mylink.setAttribute("href","../../fceform/css/"+fcpubdata.creatorStyle+"/allStyle.css");
			var myhead = document.getElementsByTagName("head")[0];
			myhead.appendChild(mylink);
		</script>
	</HEAD><%@ include file="/epp/css/cssControl.jsp"%>
	<body background="../../fceform/images/ef_run_background.gif" onload="pub_window_onload()"
		onkeydown="RunTabindex()" onbeforeunload="pub_window_onbeforeunload()" onkeypress="pub_window_onkeypress()"
		onresize="pub_window_onresize()">
		<script>
var dbName = "";
var pubdjbh=parent.sOpenDjNo;
var pubEdit=false;   			
var pubDataSet=null;
var pubRequest=parent.oRequest;
var pubEformEnterStatus="OK"; 
pub_djhtm();
//creator_setSession("cc_form_instanceid",fcpubdata.cc_form_instanceid);
		</script>
<script>
  var appUserName=parent.appUserName;
  //alert("appUserName:"+appUserName);
  var curTbname = "";

function initdbNameselect(){
	var dbnames = SendHttp(location.protocol+"//"+location.host+ fcpubdata.servletPath + "/CreatorPTServlet"+fcpubdata.dotnetVersion+"?key=getDbNames");
	dbnames = dbnames.replace(/\|\|$/g,'');	
	var arr = dbnames.split("||");
	var dbSelectops = document.getElementById('dbNameSelect').options;
	for(var i=0,len = arr.length;i<len;++i){
		var temp = arr[i];
		dbSelectops.add(new Option(temp,temp));
	}
}
  
function uf_open() {
   dbName = document.getElementById('dbNameSelect').value;
   SKBILLgrid1.IsOrder="否";
   SKBILLgrid2.IsOrder="否";
   SKBILLgrid3.IsOrder="否";
   SKBILLgrid1.DeleteRow(1);   
   dssub2.Open("select tbname,chnname from FC_TBLIST where dbname='"+dbName+"' order by tbname");
}

function cmd_ok() {
	var curRow = dssub3.RecNo+1 ; //SKBILLgrid3.curTD.
	var str = SKBILLgrid3.tab.rows(curRow).cells(1).innerText ;
	var s1 = SKBILLgrid3.tab.rows(curRow).cells(2).innerText
	var s2 = SKBILLgrid3.tab.rows(curRow).cells(3).innerText
	var s3 = SKBILLgrid3.tab.rows(curRow).cells(4).innerText
	var s4 = SKBILLgrid3.tab.rows(curRow).cells(5).innerText
	var s5 = dssub3.Fields.Field['objwidth'].Value ;
	var s6 = curTbname;
	var AllStr = str+","+s1+","+s2+","+s3+","+s4 +","+s5+","+s6 ;
	 DjOpen('fcs_FieldEdit',AllStr,'展现','有模式窗口','直接','修改字段的输入方式')
}
function uf_scroll() {
   var tb=dssub2.Fields.Field['tbname'].Value ;
   curTbname=tb;
   var s="fdname";
   var s1="tbname";
   if(fcpubdata.databaseTypeName == "oracle") {
   		 s = "upper(fdname)";
   		 s1 = "trim(tbname)"
   } 
    		 
   //var sql="select * from "+appUserName+"FC_FLDLIST where "+s+" in (select "+s+" from "+appUserName+"FC_TBSTRU where "+s1+"='"+ tb + "') order by fdname " ;  
   var sql="select t1.* from fc_fldlist t1,fc_tblist t2 where t1.tbid=t2.tbid and t2.tbname='"+tb+"' and t1.fdname!='CC_FORM_INSTANCEID' and  t1.dbname='"+dbName+"' order by fdname";
   dssub3.Open(sql);
}
function uf_scroll1() {
   var fd=dssub1.Fields.Field['fdname'].Value ;
   var s="fdname";
   var s1="tbname";
   if(fcpubdata.databaseTypeName == "oracle") {
   		 s = "trim(fdname)";
   		 s1 = "upper(trim(tbname))"
   }   		 
   //var sql="select * from FC_TBLIST where "+s1+" in (select "+s1+" from FC_TBSTRU where "+s+"='"+ fd + "') order by tbname " ;
   var sql="select t2.* from fc_fldlist t1,fc_tblist t2  where t1.tbid=t2.tbid and t1.fdname='"+fd+"' and t1.fdname!='CC_FORM_INSTANCEID' and t1.dbname='"+dbName+"' order by tbname ";
   dssub1sub.Open(sql);

}
function uf_find(){
   var sfind = Trim(txtFind.value);
   sfind = sfind.toUpperCase();
   dssub1.opensql="select * from FC_FLDLIST where dbname='"+dbName+"' and fdname like '"+ sfind + "%' or chnname like '" + sfind + "%' order by fdname" ;
   dssub1.PageSize=100 ;
   dssub1.Open();
}
function uf_show() {
   SKBILLgrid4.format="";
   dssub4.format="";
   dssub4.Open(SKDBedit1.value);
}
//页签的点击事件
function PubClickPageControl(index){
	/*
	if(index == 1){
		SKBILLgrid2.initGrid() ;
	}
	*/
}
function uf_delfld(){
   var sfld =dssub3.Fields.Field['fdname'].Value;
   var sok=window.confirm("是否确定删除字段:"+sfld) ;
   if (sok==false) {
      return
   }
   //var sql="delete FC_TBSTRU where fdname='"+sfld+"' and tbname='"+dssub2.Fields.Field['tbname'].Value+"'" ;
   var sql="delete from FC_FLDLIST t1 where t1.fdname='"+sfld+"' and t1.tbid=(select t2.tbid from fc_tblist t2 where  dbname='"+dbName+"' and t2.tbname='"+dssub2.Fields.Field['tbname'].Value+"')"
   var sRet=InsertSql(sql)
   if(IsSpace(sRet)==false){
      alert(sRet);
      return ;
   }
   dssub3.Open();

}

function uf_runsql() {
	var s1=SKDBMemo1.value ;
	var arr = s1.split(";");
	var l= arr.length;
	var sXml = ""
	for(var i=0;i<l;i++){
		var s2=Trim(arr[i])
		if(IsSpace(s2)) continue;
		sXml += "<no>" +s2 + "</no>";
	}
	var sRet=InsertSqls(sXml);
	if(IsSpace(sRet)){
		alert("成功!");
	}else{
		alert(sRet);
	}
 
}

//added by zhou.luo 2008-09-03
//删除表，因为必须要先删除表中的字段才能删除表，所以需要先做判断。
function delTable(){
    var dbUser = "<%=userName%>";
    var tbname = dssub2.Fields.Field['tbname'].Value;
    var sql = "select count(1) from "+dbUser+"fc_fldlist t1,"+dbUser+"fc_tblist t2 where t1.tbid =t2.tbid and t2.tbname='"+tbname+"' and dbname='"+dbName+"'";
    var retX = SelectSql(sql,1,1);
    retX = retX.substring(retX.indexOf("<fc>")+4,retX.indexOf("</fc>"));
    retX = retX - 0;
    if(retX > 0){
    	alert("请先在右边删除该表的字段，再删除表。");
    	return;
    }
    DelGridRow(dssub2);
}
</script><script src='../js/fcopendj.js'></script><script defer src='../js/fcsavedj.js'></script><script src='../js/fcstring.js'></script><script src='../js/fcnumdate.js'></script><script src='../js/fcselfuse.js'></script><script src='../js/fcbasecont.js'></script><script defer src='../js/fcother.js'></script><script defer src='../js/selectdate.js'></script><link href=../css/tabstyle.css type=text/css rel=stylesheet><script src='../js/webfxlayout.js'></script><link id='luna-tab-style-sheet' type='text/css' rel='stylesheet' href='../css/luna/tab.css'  /><link type='text/css' rel='stylesheet' href='../css/Button.css'/><link type='text/css' rel='stylesheet' href='../css/TextStyle.css'/><script >document.styleSheets[0].addRule("fc\\:webgrid","behavior: url(../htc/webgrid.htc)",0);</script><script src='../js/fcwebgrid.js'></script><script >document.styleSheets[0].addRule("fc\\:fc_code","behavior: url(../htc/fc_code.htc)",0);</script><script >document.styleSheets[0].addRule("fc\\:dataset","behavior: url(../htc/dataset.htc)",0);</script><script src='../js/fcdataset.js'></script>
<DIV class=dj id=SKbillsheet onkeydown="" ondblclick="" jslib="fcopendj.js&#13;&#10;fcsavedj.js&#13;&#10;fcstring.js&#13;&#10;fcnumdate.js&#13;&#10;fcselfuse.js&#13;&#10;fcbasecont.js&#13;&#10;fcother.js&#13;&#10;selectdate.js&#13;&#10;" idtype="1" isfile="否" keyfield postop="-12" posleft="26" window="当前窗口" controlno="SKButton:14;SKDBedit:9;checkbox:0;label:0;radio:0;listbox:0;textarea:0;combobox:0;password:0;upload:0;SKDBtext:0;chart:0;dbimg:0;img:0;SKBILLgrid:5;shape:0;tab:0;div:0;DsMain_field:0;a:0;button:0;text:0;hr:0;checkboxlist:0;radiolist:0;dropdownlist:0;grid:0;dataset:0;spin:0;excel:0;tree:0;ebshow:0" posheight="549" poswidth="850" entertype="修改" codeheader mkbh="E5" caption="维护字段中文名" type="ST" dj_sn="support" billtaborder="<root><taborder>SKButton2</taborder><taborder>SKButton3</taborder><taborder>SKButton10</taborder><taborder>SKButton4</taborder><taborder>SKButton5</taborder><taborder>SKButton1</taborder><taborder>SKDBedit1</taborder><taborder>SKBILLgrid1</taborder><taborder>SKBILLgrid2</taborder><taborder>SKBILLgrid3</taborder><taborder>SKBILLgrid4</taborder><taborder>FCButton1</taborder><taborder>gridsub1</taborder><taborder>SKButton12</taborder><taborder>SKButton13</taborder><taborder>cmdFind</taborder><taborder>txtFind</taborder></root>" contxml="<root><SKButton><id>SKButton4</id><id>SKButton5</id><id>SKButton13</id><id>SKButton2</id><id>SKButton3</id><id>SKButton10</id><id>SKButton12</id><id>cmdFind</id><id>SKButton1</id></SKButton><SKDBedit><id>SKDBedit1</id></SKDBedit><label><id>Label9</id></label><tab><id>PageControl1</id></tab><button><id>FCButton1</id></button><text><id>txtFind</id></text><grid><id>SKBILLgrid2</id><id>SKBILLgrid3</id><id>SKBILLgrid1</id><id>gridsub1</id><id>SKBILLgrid4</id></grid><dataset><id>dssub2</id><id>dssub3</id><id>dssub1</id><id>dssub1sub</id><id>dssub4</id></dataset></root>" BLONopen="initdbNameselect();uf_open()" para="<r></r>" dj_id="233" blmode="其它" toolbar="不带工具栏" OtherSave="否">
请选择数据源:<select onchange="uf_open()" id="dbNameSelect" style="DISPLAY: block; FONT-SIZE: 12px; LEFT: 100px; WIDTH: 64px; FONT-FAMILY: ; POSITION: absolute; TOP: 10px; HEIGHT: 25px; BACKGROUND-COLOR: #d4d0c8" ></select>
<DIV class=tab-pane id=PageControl1 style="LEFT: 0px; WIDTH: 760px; POSITION: absolute; TOP: 50px; HEIGHT: 512px" IsHideTitle="undefined" showtype="luna">
<DIV class=tab-page style=" POSITION: absolute;top:20px;WIDTH: 760px; HEIGHT: 494px">
<H2 class=tab>表结构</H2><?xml:namespace prefix = fc /><fc:webgrid id=SKBILLgrid2 onkeydown='bill_ongridkeydown("<SKBILLgrid2><col></col><col></col></SKBILLgrid2>")' ondblclick='bill_ongriddblclick("<SKBILLgrid2><col></col><col></col></SKBILLgrid2>")' onclick='bill_ongridclick("<SKBILLgrid2><col></col><col></col></SKBILLgrid2>")' dataset="dssub2" visible="是" readonly="否" autoappend="否" autowidth="否" autoheight="否" canselect="是" format="<cols><col><fname>tbname</fname><cname>西文表名</cname><width>10</width><dtype>字符</dtype><readonly>是</readonly><visible>是</visible><u></u><v></v><s></s><r></r><columnwidth>140</columnwidth><align>left</align></col><col><fname>chnname</fname><cname>中文名称</cname><width>40</width><dtype>字符</dtype><readonly>否</readonly><visible>是</visible><u></u><v></v><s></s><r></r><columnwidth>150</columnwidth><align>left</align></col></cols>" width="303" height="423" top="35" left="6" ParentPos="相对">
<TABLE id=t style="TABLE-LAYOUT: fixed; FONT-SIZE: 12px; LEFT: 0px; POSITION: absolute; TOP: 0px; BORDER-COLLAPSE: collapse; BACKGROUND-COLOR: #ffffff" cellSpacing=0 cellPadding=1 frame=box>
<TBODY>
<TR class=fcGridFirstRow style="FONT-SIZE: 12px; BACKGROUND-COLOR: #c0c0c0">
<TD></TD></TR></TBODY></TABLE></fc:webgrid><fc:dataset id=dssub2 AfterScroll='bill_dsevent("AfterScroll","uf_scroll()")' opensortno="2" temptable="TMP_STGRID2" saveastable="<%=userName%>FC_TBLIST" format="<fields><field><fieldname>tbname</fieldname><datatype>字符</datatype><displaylabel>西文表名</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>是</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target>_blank</target><href></href><visible>是</visible><primarykey>是</primarykey><fieldvalid></fieldvalid><tag></tag></field><field><fieldname>chnname</fieldname><datatype>字符</datatype><displaylabel>中文名称</displaylabel><size>40</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>是</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target>_blank</target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag></field></fields>" onValid='bill_ondatasetvalid("<dsid><tbname></tbname><chnname></chnname></dsid>")' onGetText='bill_ondatasetgettext("<dsid><tbname></tbname><chnname></chnname></dsid>")' onSetText='bill_ondatasetsettext("<dsid><tbname></tbname><chnname></chnname></dsid>")'></fc:dataset><fc:webgrid id=SKBILLgrid3 onkeydown='bill_ongridkeydown("<SKBILLgrid3><col></col><col></col><col></col><col></col><col></col></SKBILLgrid3>")' ondblclick='bill_ongriddblclick("<SKBILLgrid3><col></col><col></col><col></col><col></col><col></col></SKBILLgrid3>")' onclick='bill_ongridclick("<SKBILLgrid3><col></col><col></col><col></col><col></col><col></col></SKBILLgrid3>")' dataset="dssub3" visible="是" readonly="否" autoappend="否" autowidth="否" autoheight="否" canselect="是" format="<cols><col><fname>fdname</fname><cname>西文字段名</cname><width>20</width><dtype>字符</dtype><readonly>是</readonly><visible>是</visible><u></u><v></v><s></s><r></r><columnwidth>80</columnwidth><align>left</align></col><col><fname>chnname</fname><cname>中文名称</cname><width>40</width><dtype>字符</dtype><readonly>否</readonly><visible>是</visible><u></u><v></v><s></s><r></r><columnwidth>118</columnwidth><align>left</align></col><col><fname>fdtype</fname><cname>字段类型</cname><width>4</width><dtype>字符</dtype><readonly>是</readonly><visible>是</visible><u></u><v></v><s></s><r></r><columnwidth>65</columnwidth><align>left</align></col><col><fname>fdsize</fname><cname>字段宽度</cname><width>2</width><dtype>整数</dtype><readonly>是</readonly><visible>是</visible><u></u><v></v><s></s><r></r><columnwidth>65</columnwidth><align>right</align></col><col><fname>fddec</fname><cname>字段精度</cname><width>2</width><dtype>整数</dtype><readonly>是</readonly><visible>是</visible><u></u><v></v><s></s><r></r><columnwidth>65</columnwidth><align>right</align></col></cols>" width="406" height="423" top="35" left="327" ParentPos="相对">
<TABLE id=t style="TABLE-LAYOUT: fixed; LEFT: 0px; POSITION: absolute; TOP: 0px; BORDER-COLLAPSE: collapse" cellSpacing=0 cellPadding=1 frame=box>
<TBODY>
<TR class=fcGridFirstRow>
<TD></TD></TR></TBODY></TABLE></fc:webgrid><fc:dataset id=dssub3 saveastable="<%=userName%>FC_FLDLIST" opensortno="3" temptable="TMP_TTGRID3" format="<fields><field><fieldname>fldid</fieldname><datatype>字符</datatype><displaylabel>字段id</displaylabel><size>50</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target>_blank</target><href></href><visible>否</visible><primarykey>是</primarykey><fieldvalid></fieldvalid><tag></tag></field><field><fieldname>fdname</fieldname><datatype>字符</datatype><displaylabel>西文字段名</displaylabel><size>20</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target>_blank</target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag></field><field><fieldname>chnname</fieldname><datatype>字符</datatype><displaylabel>中文名称</displaylabel><size>40</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target>_blank</target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag></field><field><fieldname>fdtype</fieldname><datatype>字符</datatype><displaylabel>字段类型</displaylabel><size>4</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target>_blank</target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag></field><field><fieldname>fdsize</fieldname><datatype>整数</datatype><displaylabel>字段宽度</displaylabel><size>2</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target>_blank</target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag></field><field><fieldname>fddec</fieldname><datatype>整数</datatype><displaylabel>字段精度</displaylabel><size>2</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target>_blank</target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag></field><field><fieldname>objwidth</fieldname><datatype>字符</datatype><displaylabel>控件宽度</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>否</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag></field></fields>" onValid='bill_ondatasetvalid("<dsid><fdname></fdname><chnname></chnname><fdtype></fdtype><fdsize></fdsize><fddec></fddec><objwidth></objwidth></dsid>")' onGetText='bill_ondatasetgettext("<dsid><fdname></fdname><chnname></chnname><fdtype></fdtype><fdsize></fdsize><fddec></fddec><objwidth></objwidth></dsid>")' onSetText='bill_ondatasetsettext("<dsid><fdname></fdname><chnname></chnname><fdtype></fdtype><fdsize></fdsize><fddec></fddec><objwidth></objwidth></dsid>")'></fc:dataset><INPUT id=SKButton4 style="DISPLAY: block; FONT-SIZE: 12px; LEFT: 4px; WIDTH: 55px; FONT-FAMILY: 宋体; POSITION: absolute; TOP: 9px; HEIGHT: 23px;" type=button class=input value=保存 controltype="SKButton"  onclick="bill_onclick(&quot;SaveOneGrid(' ',dssub2)&quot;)" dropstyle="否"><!--BUTTON id=FCButton1 style="DISPLAY: block; FONT-SIZE: 12px; LEFT: 396px; WIDTH: 135px; FONT-FAMILY: ; POSITION: absolute; TOP: 9px; HEIGHT: 23px; BACKGROUND-COLOR: #d4d0c8" onmovestart=moveStart() controltype="button" class="button_short" onclick='bill_onclick("cmd_ok()")' dropstyle="否">修改字段输入方式</BUTTON>--><BUTTON id=FCButton14 style="DISPLAY: block; FONT-SIZE: 12px; LEFT: 400px; WIDTH: 110px; FONT-FAMILY: ; POSITION: absolute; TOP: 9px; HEIGHT: 23px; BACKGROUND-COLOR: #d4d0c8" onmovestart=moveStart() controltype="button" class=input onclick='bill_onclick("GridSave(dssub3)")' dropstyle="否">保存字段信息</BUTTON></DIV>
<DIV class=tab-page style="WIDTH: 760px; HEIGHT: 494px">
<H2 class=tab>字段</H2><fc:webgrid id=SKBILLgrid1 onkeydown='bill_ongridkeydown("<SKBILLgrid1><col></col><col></col><col></col><col></col><col></col></SKBILLgrid1>")' ondblclick='bill_ongriddblclick("<SKBILLgrid1><col></col><col></col><col></col><col></col><col></col></SKBILLgrid1>")' onclick='bill_ongridclick("<SKBILLgrid1><col></col><col></col><col></col><col></col><col></col></SKBILLgrid1>")' dataset="dssub1" visible="是" readonly="否" autoappend="否" autowidth="否" autoheight="否" canselect="是" format="<cols><col><fname>fdname</fname><cname>西文字段名</cname><width>20</width><dtype>字符</dtype><readonly>是</readonly><visible>是</visible><u></u><v></v><s></s><r></r><columnwidth>100</columnwidth><align>left</align></col><col><fname>chnname</fname><cname>中文名称</cname><width>40</width><dtype>字符</dtype><readonly>是</readonly><visible>是</visible><u></u><v></v><s></s><r></r><columnwidth>134</columnwidth><align>left</align></col><col><fname>fdtype</fname><cname>字段类型</cname><width>4</width><dtype>字符</dtype><readonly>是</readonly><visible>是</visible><u></u><v></v><s></s><r></r><columnwidth>65</columnwidth><align>left</align></col><col><fname>fdsize</fname><cname>字段宽度</cname><width>2</width><dtype>整数</dtype><readonly>否</readonly><visible>是</visible><u></u><v></v><s></s><r></r><columnwidth>65</columnwidth><align>right</align></col><col><fname>fddec</fname><cname>字段精度</cname><width>2</width><dtype>整数</dtype><readonly>否</readonly><visible>是</visible><u></u><v></v><s></s><r></r><columnwidth>65</columnwidth><align>right</align></col></cols>" width="442" height="430" top="36" left="6" ParentPos="相对" SetRowHeight="是" hideVscroll="否" hideHscroll="否" autosize="否" bodyrowheight="-1" bodyrows="-1">
<TABLE id=t style="TABLE-LAYOUT: fixed; FONT-SIZE: 12px; LEFT: 0px; POSITION: absolute; TOP: 0px; BORDER-COLLAPSE: collapse; BACKGROUND-COLOR: #ffffff" cellSpacing=0 cellPadding=1 frame=box>
<TBODY>
<TR class=fcGridFirstRow style="FONT-SIZE: 12px; BACKGROUND-COLOR: #c0c0c0">
<TD></TD></TR></TBODY></TABLE></fc:webgrid><fc:dataset id=dssub1 AfterScroll='bill_dsevent("AfterScroll","uf_scroll1()")' opensortno="1" temptable="TMP_STGRID1" saveastable="<%=userName%>FC_FLDLIST" format="<fields><field><fieldname>fdname</fieldname><datatype>字符</datatype><displaylabel>西文字段名</displaylabel><size>20</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>是</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target>_blank</target><href></href><visible>是</visible><primarykey>是</primarykey><fieldvalid></fieldvalid><tag></tag></field><field><fieldname>chnname</fieldname><datatype>字符</datatype><displaylabel>中文名称</displaylabel><size>40</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>是</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target>_blank</target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag></field><field><fieldname>fdtype</fieldname><datatype>字符</datatype><displaylabel>字段类型</displaylabel><size>4</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target>_blank</target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag></field><field><fieldname>fdsize</fieldname><datatype>整数</datatype><displaylabel>字段宽度</displaylabel><size>2</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target>_blank</target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag></field><field><fieldname>fddec</fieldname><datatype>整数</datatype><displaylabel>字段精度</displaylabel><size>2</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target>_blank</target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag></field></fields>" onValid='bill_ondatasetvalid("<dsid><fdname></fdname><chnname></chnname><fdtype></fdtype><fdsize></fdsize><fddec></fddec></dsid>")' onGetText='bill_ondatasetgettext("<dsid><fdname></fdname><chnname></chnname><fdtype></fdtype><fdsize></fdsize><fddec></fddec></dsid>")' onSetText='bill_ondatasetsettext("<dsid><fdname></fdname><chnname></chnname><fdtype></fdtype><fdsize></fdsize><fddec></fddec></dsid>")'></fc:dataset><INPUT id=SKButton2 style="DISPLAY: block; FONT-SIZE: 12px; LEFT: 188px; WIDTH: 55px; COLOR: #000000; FONT-FAMILY: 宋体; POSITION: absolute; TOP: 7px; HEIGHT: 23px; BACKGROUND-COLOR: #d4d0c8" type=button value=下一页 controltype="SKButton" class="button_short2" onclick='bill_onclick("dssub1.NextPage()")' dropstyle="否"><INPUT id=SKButton10 style="DISPLAY: block; FONT-SIZE: 12px; LEFT: 127px; WIDTH: 55px; COLOR: #000000; FONT-FAMILY: 宋体; POSITION: absolute; TOP: 7px; HEIGHT: 23px; BACKGROUND-COLOR: #d4d0c8" type=button value=上一页 controltype="SKButton" class="button_short2" onclick='bill_onclick("dssub1.PrevPage()")' dropstyle="否"><fc:webgrid id=gridsub1 onkeydown='bill_ongridkeydown("<gridsub1><col></col><col></col></gridsub1>")' ondblclick='bill_ongriddblclick("<gridsub1><col></col><col></col></gridsub1>")' onclick='bill_ongridclick("<gridsub1><col></col><col></col></gridsub1>")' dataset="dssub1sub" visible="是" readonly="否" autoappend="否" autowidth="否" autoheight="否" canselect="是" format="<cols><col><fname>tbname</fname><cname>西文表名</cname><width>50</width><dtype>字符</dtype><readonly>是</readonly><visible>是</visible><u></u><v></v><s></s><r></r><columnwidth>102</columnwidth><align>left</align></col><col><fname>chnname</fname><cname>中文名称</cname><width>50</width><dtype>字符</dtype><readonly>是</readonly><visible>是</visible><u></u><v></v><s></s><r></r><columnwidth>150</columnwidth><align>left</align></col></cols>" width="264" height="426" top="36" left="469" ParentPos="相对"> 
<TABLE id=t style="TABLE-LAYOUT: fixed; FONT-SIZE: 12px; LEFT: 0px; POSITION: absolute; TOP: 0px; BORDER-COLLAPSE: collapse; BACKGROUND-COLOR: #ffffff" cellSpacing=0 cellPadding=1 frame=box>
<TBODY>
<TR class=fcGridFirstRow style="FONT-SIZE: 12px; BACKGROUND-COLOR: #c0c0c0">
<TD></TD></TR></TBODY></TABLE></fc:webgrid><fc:dataset id=dssub1sub opensortno="1" temptable="TMP_IMGDATASET2" format="<fields><field><fieldname>tbname</fieldname><datatype>字符</datatype><displaylabel>西文表名</displaylabel><size>50</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag></field><field><fieldname>chnname</fieldname><datatype>字符</datatype><displaylabel>中文名称</displaylabel><size>50</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag></field></fields>" onValid='bill_ondatasetvalid("<dsid><tbname></tbname><chnname></chnname></dsid>")' onGetText='bill_ondatasetgettext("<dsid><tbname></tbname><chnname></chnname></dsid>")' onSetText='bill_ondatasetsettext("<dsid><tbname></tbname><chnname></chnname></dsid>")'></fc:dataset><INPUT type=text id=txtFind style="BORDER-RIGHT: silver 1px solid; BORDER-TOP: dimgray 2px solid; DISPLAY: block; FONT-SIZE: 12px; LEFT: 15px; BORDER-LEFT: dimgray 2px solid; WIDTH: 64px; BORDER-BOTTOM: silver 1px solid; FONT-FAMILY: ; POSITION: absolute; TOP: 8px; HEIGHT: 20px; BACKGROUND-COLOR: #ffffff; TEXT-ALIGN: left" onmovestart=moveStart() controltype="text" value china CanSelect="false"></INPUT><INPUT id=cmdFind style="DISPLAY: block; FONT-SIZE: 12px; LEFT: 79px; WIDTH: 42px; COLOR: #000000; FONT-FAMILY: 宋体; POSITION: absolute; TOP: 7px; HEIGHT: 22px; BACKGROUND-COLOR: #d4d0c8" type=button size=14 value=查找 controltype="SKButton" class="button_short3" onclick='bill_onclick("uf_find()")' dropstyle="否"></DIV>
</DIV></DIV>
<SCRIPT>var PageControl1 = new WebFXTabPane( document.getElementById( "PageControl1" ) );</SCRIPT>
<fc:dataset id=dssub4 opensortno="1" temptable="TMP_IMGDATASET1" format="<fields><field><fieldname>a</fieldname><datatype>字符</datatype><displaylabel>新建字段</displaylabel><size>10</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag></field></fields>" onValid='bill_ondatasetvalid("<dsid><a></a></dsid>")' onGetText='bill_ondatasetgettext("<dsid><a></a></dsid>")' onSetText='bill_ondatasetsettext("<dsid><a></a></dsid>")'></fc:dataset></DIV></body></html>



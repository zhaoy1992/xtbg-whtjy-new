<%@ page language="java" pageEncoding="GBK"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>

    <%
     AccessControl control = AccessControl.getInstance();
     control.checkAccess(request,response);
     String currentSystemID = control.getCurrentSystemID();
     String appUserName = "app_"+currentSystemID;
     appUserName=appUserName.toUpperCase();
     //System.out.println("appUserName:"+appUserName);     
    %>
<HEAD>
		<STYLE> .userData{behavior:url(#default#userData);}
	@import url(../css/dj.css); 
	</STYLE>
		<script src="../js/fcpub.js"></script>
		<script src="../js/fcrundj.js"></script>
		<script src="../js/tabpane.js"></script>
		<script src="../js/cclog.js"></script>		
		<script langage="javascript">
			var mylink = document.createElement("link");
			mylink.setAttribute("type","text/css");
			mylink.setAttribute("rel","stylesheet");
			mylink.setAttribute("href","../../fceform/css/"+fcpubdata.creatorStyle+"/allStyle.css");
			var myhead = document.getElementsByTagName("head")[0];
			myhead.appendChild(mylink);
		</script>
	</HEAD><%@ include file="/epp/css/cssControl.jsp"%>
	<body background="../images/ef_run_background.gif" onload="pub_window_onload()"
		onkeydown="RunTabindex()" onbeforeunload="pub_window_onbeforeunload()" onkeypress="pub_window_onkeypress()"
		onresize="pub_window_onresize()">
		<script>
var pubdjbh=parent.sOpenDjNo;
var pubEdit=false;   			
var pubDataSet=null;
var pubRequest=parent.oRequest;
var pubEformEnterStatus="OK"; 
pub_djhtm();
  var appUserName = "<%=appUserName%>";
var dbName = "";
//alert('appUserName:'+appUserName);
		</script>
<script>
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
function uf_open(){
	dbName = document.getElementById('dbNameSelect').value;
	/*if(fcpubdata.databaseTypeName!="sqlserver" && fcpubdata.databaseTypeName!="oracle"){
		alert("传递表结构数据只支持sqlserver和oracle两个版本");
		CloseBill();
	}*/
}
function uf_ok() {
	if(fcpubdata.databaseTypeName=="oracle"){
		uf_run();
		return;
		//var s = "{ call CREATOR_SPECIAL_TABLE_DATA() }" ;
	} else if (fcpubdata.databaseTypeName=="sqlserver"){
		var s = "exec AUTO_SPECIAL_TABLE_DATA" ;
	}else{
		uf_run();
		return;
	}
	var sRet = InsertSql(s,dbName)
	if(IsSpace(sRet)){
	    creator_log("表单数据库管理","传递表结构");
		alert("生成成功!")
	}else{
		alert(sRet)
	}
}
function uf_run(){
	var djid = fcpubdata.djid;
	//alert("uf_run():djid:"+djid);
	var strXml="<patternName>"+fcpubdata.db2UserName+"</patternName>";
	var str = IsSpace(dbName)?"":"&dbName="+dbName;
	SendHttp(location.protocol+"//"+location.host + fcpubdata.servletPath + "/WebBill"+fcpubdata.dotnetVersion+"?DataToFieldList&key=DataToFieldList&djid="+djid+str,strXml,function (result){
		var sRet = result.value;
		if(IsSpace(sRet)==false) {
			alert(sRet);
		}else{
			alert("OK!")
		}
	
	})

}</script><script src='../js/fcopendj.js'></script><script defer src='../js/fcsavedj.js'></script><script src='../js/fcstring.js'></script><script src='../js/fcnumdate.js'></script><script src='../js/fcselfuse.js'></script><script src='../js/fcbasecont.js'></script><script defer src='../js/fcother.js'></script><script defer src='../js/selectdate.js'></script><script src='../../fceformext/js/userfunc.js'></script><link href=../css/tabstyle.css type=text/css rel=stylesheet><link type='text/css' rel='stylesheet' href='../css/Button.css'/>
<DIV id=SKbillsheet jslib="fcopendj.js&#13;&#10;fcsavedj.js&#13;&#10;fcstring.js&#13;&#10;fcnumdate.js&#13;&#10;fcselfuse.js&#13;&#10;fcbasecont.js&#13;&#10;fcother.js&#13;&#10;selectdate.js&#13;&#10;~userfunc.js" idtype="1" isfile="否" postop posleft window="当前窗口" keyfield controlno="SKButton:0;SKDBedit:0;checkbox:0;label:0;radio:0;listbox:0;textarea:0;combobox:0;password:0;upload:0;SKDBtext:0;chart:0;dbimg:0;img:0;SKBILLgrid:0;shape:0;tab:0;div:0;DsMain_field:0;a:0;button:1;text:0;hr:0;checkboxlist:0;radiolist:0;dropdownlist:0;grid:0;dataset:0;spin:0;excel:0;tree:0" posheight poswidth entertype="修改" codeheader="BBB" mkbh caption="导入数据到fldlist等表" type="ST" dj_sn="data_fldlist" billtaborder="<root><taborder>FCButton1</taborder><taborder>FCButton2</taborder></root>" contxml="<root><label><id>Label1</id><id>Label2</id></label><button><id>FCButton1</id><id>FCButton2</id></button></root>" BLONopen="initdbNameselect();uf_open()" toolbar="不带工具栏" OtherSave="否">

              <table width="100%" border="0" cellpadding="1" cellspacing="1" class="thin">
					<tr>
						<td class="detailtitle" width="10%" align=right>
							请选择数据源:
						</td>
						<td class="detailcontent" width="90%">
							<select onchange="uf_open()" id="dbNameSelect" style="DISPLAY: block; FONT-SIZE: 12px; LEFT: 100px; WIDTH: 64px; FONT-FAMILY: ; HEIGHT: 25px; BACKGROUND-COLOR: #d4d0c8" ></select>
						</td>
					</tr>
					<tr>
						<td colspan="2"  class="detailcontent" width="30%" align="left">                             
							注意：点击下面的按钮后将会整个数据库的用户表和字段信息生成到两个专门的表中保存.
						</td>
					</tr>
					<tr>					
					    <td colspan="2" class="detailcontent" align="left">
					      <BUTTON id=FCButton1  class=input onmovestart=moveStart() controltype="button" class="button_long" onclick='bill_onclick("uf_ok()")' dropstyle="否">传递表结构</BUTTON>
					    </td>
					</tr>
				</table>


</DIV></body></html>


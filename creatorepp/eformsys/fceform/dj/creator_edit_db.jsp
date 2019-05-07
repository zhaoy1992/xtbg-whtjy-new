<%@ page language="java" pageEncoding="GBK"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<HEAD>
    <%
     AccessControl control = AccessControl.getInstance();
     control.checkAccess(request,response);
     String currentSystemID = control.getCurrentSystemID();
     String appUserName = "app_"+currentSystemID;
     appUserName=appUserName.toUpperCase();
     //System.out.println("appUserName:"+appUserName);     
    %>
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
            var appUserName = "<%=appUserName%>";
    </script>
		</script>
	</HEAD><%@ include file="/epp/css/cssControl.jsp"%>
	<body background="../images/ef_run_background.gif" onload="pub_window_onload()"
		onkeydown="RunTabindex()" onbeforeunload="pub_window_onbeforeunload()" onkeypress="pub_window_onkeypress()"
		onresize="pub_window_onresize()">
		<script>
//var appUserName = parent.appUserName;  //连接应用的数据库的用户名
//appUserName = appUserName.toUpperCase();
var dbName = "";
var pubdjbh=parent.sOpenDjNo;
var pubEdit=false;   			
var pubDataSet=null;
var pubRequest=parent.oRequest;
var pubEformEnterStatus="OK"; 
pub_djhtm();
creator_setSession("cc_form_instanceid",fcpubdata.cc_form_instanceid); 
		</script>
<script>//拼写listbox控件的显示SQL语句
var db2UserName=fcpubdata.db2UserName;
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
function uf_sSql(){
	dbName = document.getElementById('dbNameSelect').value;
	if(fcpubdata.databaseTypeName!="sqlserver" && fcpubdata.databaseTypeName!="oracle" && fcpubdata.databaseTypeName!="db2"){
		alert("数据库维护只支持sqlserver和oracle和db2");
		CloseBill();
	}
	var sSql="";
	if(fcpubdata.databaseTypeName=="sqlserver"){
		sSql="select name from sysobjects where xtype='U'and name not like 'tmp_%' order by name ";	
	}
	if(fcpubdata.databaseTypeName=="oracle"){
		//sSql="select table_name from user_tables order by table_name";
		sSql="select t.table_name from  user_tables t where substr(t.table_name,0,3) ='TA_' order by table_name";	
	}
	if(fcpubdata.databaseTypeName=="db2"){
		sSql="SELECT TABNAME FROM SYSCAT.TABLES WHERE TABSCHEMA='"+db2UserName+"'";
		Label2.style.display="none";
		txtPkey.style.display="none";
	}
	lstTable.innerHTML="";
	lstTable.dbName = dbName;
	var oOpt=SqlCombo(lstTable,sSql);
	//lstTable.outerHTML=SelectAddOption(lstTable,oOpt);
}

//双击List列表，查询出当前数据表中的字段列表
function uf_click(){
	var slen=lstTable.length;
	if(lstTable.selectedIndex>=0){
		uf_showFieldList(lstTable.value)
		uf_showkey(lstTable.value);
	}
}
function uf_showFieldList(tableName) {
	var sval = tableName;
	if(fcpubdata.databaseTypeName=="sqlserver"){
		var sSql="select syscolumns.name as fdname,systypes.name as fdtype,syscolumns.length as fdsize,syscolumns.scale as fddec,case when syscolumns.isnullable=0 then 'NOT NULL' when syscolumns.isnullable=1 then 'NULL' end as isnullable from syscolumns,sysobjects,"
		+"systypes where syscolumns.id=sysobjects.id and  syscolumns.xtype=systypes.xtype and sysobjects.xtype='U' and "
		+"sysobjects.name='"+sval+"' order by syscolumns.colorder";
	}
	if(fcpubdata.databaseTypeName=="oracle"){
		//var sSql="select COLUMN_NAME as fdname,DATA_TYPE AS fdtype,decode(DATA_TYPE,'CHAR',DATA_LENGTH,'NCHAR',DATA_LENGTH,'VARCHAR2',DATA_LENGTH,'NVARCHAR2',DATA_LENGTH,'RAW',DATA_LENGTH,DATA_PRECISION) as fdsize,decode(DATA_TYPE,'NUMBER',DATA_SCALE,DATA_PRECISION) as fddec,decode(NULLABLE,'N','NOT NULL','Y','NULL') as isnullable from user_tab_columns where table_name='"+sval+"'";	
	    var sSql="select COLUMN_NAME as fdname,DATA_TYPE AS fdtype,decode(DATA_TYPE,'CHAR',DATA_LENGTH,'NCHAR',DATA_LENGTH,'VARCHAR2',DATA_LENGTH,'NVARCHAR2',DATA_LENGTH,'RAW',DATA_LENGTH,DATA_PRECISION) as fdsize,decode(DATA_TYPE,'NUMBER',DATA_SCALE,'FLOAT',DATA_SCALE,DATA_PRECISION) as fddec,decode(NULLABLE,'N','NOT NULL','Y','NULL') as isnullable from user_tab_columns where COLUMN_NAME!='CC_FORM_INSTANCEID' and table_name='"+sval+"'";
	}
	if(fcpubdata.databaseTypeName=="db2"){
		var sSql="select COLNAME as fdname,TYPENAME AS fdtype,LENGTH as fdsize,SCALE as fddec,CASE NULLS WHEN 'N' THEN 'NOT NULL' ELSE 'NULL' END as isnullable  FROM SYSCAT.COLUMNS where TABNAME='"+sval+"' and TABSCHEMA='"+db2UserName+"'";	
	}
	
	//使dataset查询指定数据源
	creator_pt_dbname = dbName;
	imgdataset1.Open(sSql);
	creator_pt_dbname = "";
	//delete creator_pt_dbname;
	
}
//点击删除Button，将字段表中当前选中行从数据表中删除
function uf_del(){
	if(fcpubdata.databaseTypeName=="db2"){
		alert("db2数据库不支持删除字段!");
		return;
	}
	if(lstTable.selectedIndex<0){
		alert("请选择数据表")
		return;	
	}
	var TAB=lstTable.value;
	var sSql="";
	var allZD="";
	var iCount=0;
	//双击多选删除字段
	for (i=0;i<imgdataset1.RecordCount;i++){
		if (imgdataset1.oDom.documentElement.childNodes(i).getAttribute("multisel")=='是') {  
	    	var ZD=imgdataset1.oDom.documentElement.childNodes(i).childNodes(0).text;
			sSql += _delOneField(TAB,ZD);
			allZD+=ZD+",";	
			iCount++;
		}
	}
	//默认当前行删除字段
	if(iCount<=0){
		allZD=imgdataset1.Fields.Field["fdname"].Value
		sSql += _delOneField(TAB,allZD);
	}
	if(allZD.indexOf(",")>0){
		allZD=allZD.substring(0,allZD.length-1);
	}
	var s1=sSql ;	
	var arr = s1.split(";");
	var l= arr.length;
	var sXml = ""
	for(var i=0;i<l;i++){
		var s2=Trim(arr[i])
		if(IsSpace(s2)) continue;
		sXml += "<no>" +s2 + "</no>";
	}
	//alert("sXml:"+sXml);
	if(confirm("真的要删除'"+allZD+"'字段吗？")){
		var sRet=InsertSqls(sXml,dbName);
	}
	if(IsSpace(sRet)){
	    creator_log("表单数据库管理","对表(" +TAB+ ")删除字段:" +allZD+ " ");
		uf_click();
	}else{
		alert(sRet);
	}
	
	function _delOneField(tableName,fieldName){
		var TAB = tableName;
		var allZD = fieldName;
		var sSql="";
		if(fcpubdata.databaseTypeName=="sqlserver"){
			var DF=SqlToField("select top 1 name from sysobjects where id=(select syscolumns.cdefault from syscolumns,sysobjects where syscolumns.id=sysobjects.id and sysobjects.name='"+TAB+"' and syscolumns.name='"+allZD+"')")
			if(IsSpace(DF)==false){
			sSql="alter table "+TAB+" drop constraint "+DF+";\n"
			}
		    sSql+="alter table "+TAB+" drop column "+allZD+";\n";	
		}
		if(fcpubdata.databaseTypeName=="oracle"){
			sSql+="alter table "+TAB+" drop column "+allZD+";\n";	
		}
		return sSql;
	}
}

//点击修改Button，修改当前选中字段

function uf_alterField(bAdd){
	if(bAdd == false && fcpubdata.databaseTypeName=="db2"){
		alert("db2数据库不支持修改字段!");
		return;
	}
	
	if(lstTable.selectedIndex<0){
		alert("请选择数据表")
		return;		
	}
	var sval=lstTable.value;
	var sFd="";
	if(bAdd == false){
		sFd=imgdataset1.Fields.Field['fdname'].Value;
	}
	var arr=new Array();
	arr[0]=sval;	//表名
	arr[1]=sFd;		//字段名
	arr[2]=dbName;//连接应用的数据库的用户名
	var sText = "";
	if(bAdd){
		sText=DjOpen('fcs_edit_column',arr,'展现','有模式窗口','直接','新增字段');
	}else{
	    sText=DjOpen('fcs_edit_column',arr,'展现','有模式窗口','直接','修改字段');	
	}
	if(sText=="ok"){
		uf_showFieldList(sval);
	}
}

//设置主键

function uf_setPrimaryKey(){
	if(lstTable.selectedIndex<0){
		alert("请选择数据表")	
		return;	
	}
	var sval=lstTable.value;  //表名 
	var sFd=""   //字段名
	var sSql1="";
	//查找原来的主键,并删除
	if(fcpubdata.databaseTypeName=="sqlserver"){
		sSql1="select name from sysobjects where parent_obj=(select id from sysobjects where sysobjects.name='"+sval+"') and sysobjects.type='K'";
	}
	if(fcpubdata.databaseTypeName=="oracle"){
		//sSql1="select constraint_name from user_constraints where table_name='"+sval+"' and constraint_type='P'"	
	    sSql1="select distinct constraint_name from all_constraints where table_name='"+sval+"' and constraint_type='P' order by constraint_name desc"
	}
	var sSql2="";
	var s1=SqlToField(sSql1,dbName);

	if(IsSpace(s1)==false){
		sSql2+="alter table "+sval+" drop constraint "+s1;	
	}
    InsertSql(sSql2);
	//加上新的主键
	for(var i=0;i<imgdataset1.RecordCount;i++){
		if(imgdataset1.oDom.documentElement.childNodes(i).getAttribute("multisel")=='是'){
			sFd+=imgdataset1.oDom.documentElement.childNodes(i).childNodes(0).text+",";
		}	
	}
	var len=sFd.length;
	sFd=sFd.substring(0,len-1);
	if(IsSpace(sFd)){
		sFd=imgdataset1.Fields.Field['fdname'].Value	
	}
	if(fcpubdata.databaseTypeName=="sqlserver"){
		sSql2="alter table "+sval+" add constraint PK_"+sval+" PRIMARY KEY CLUSTERED ("+sFd+")";
	}
	if(fcpubdata.databaseTypeName=="oracle"){
		sSql2="alter table "+sval+" add primary key ("+sFd+")"	
	}
	if(fcpubdata.databaseTypeName=="db2"){
		sSql2="alter table "+sval+" add constraint PK_"+sval+" PRIMARY KEY ("+sFd+")";
	}
//	alert("sSql2:"+sSql2);
	//成批执行这些命令
	
	var arr = sSql2.split(";");
	var l= arr.length;
	var sXml = ""
	//for(var i=0;i<l;i++){
	//	var s3=Trim(arr[i])
	//	if(IsSpace(s3)) continue;
	//	sXml += "<no>" +s3 + "</no>";
	//}
	var sRet=InsertSql(sSql2);
	if(IsSpace(sRet)){
	    creator_log("表单数据库管理","对表(" + sval + ")" + "设置主键：" + sFd + "");
		uf_showkey(sval)
		alert("成功！");
	}else{
		alert(sRet);
	}
}
//显示主键到编辑框
function uf_showkey(sval) {
	if(fcpubdata.databaseTypeName=="sqlserver"){
		var sSql3="sp_helpindex '"+sval+"'"
		var str=SelectSql(sSql3,1,1,dbName);
		var oXml=SetDom(str);
		var s1="";
		if(oXml.documentElement != null ){
			if(oXml.documentElement.childNodes.length>1){
				s1=oXml.documentElement.childNodes(0).childNodes(2).text;
			}
		}
	}
	if(fcpubdata.databaseTypeName=="oracle"){
		//var sSql3="select user_cons_columns.column_name from user_constraints ,user_cons_columns where user_cons_columns.constraint_name=user_constraints.constraint_name and constraint_type='P' and user_constraints.table_name='"+sval+"'";
		var sSql3="select distinct v2.column_name from all_constraints v1,all_cons_columns v2 where v2.constraint_name=v1.constraint_name and v1.constraint_type='P' and v1.table_name='"+sval+"'";
		//var sSql4="select count(user_cons_columns.column_name) from user_constraints ,user_cons_columns where user_cons_columns.constraint_name=user_constraints.constraint_name and constraint_type='P' and user_constraints.table_name='"+sval+"'";
		var sSql4="select count(distinct v2.column_name) from all_constraints v1,all_cons_columns v2 where v2.constraint_name=v1.constraint_name and v1.constraint_type='P' and v1.table_name='"+sval+"'";
		
		var slen=SelectSql(sSql4,1,1,dbName);//查询出表内有几个字段被设为主键，返回XML串
		var oXml1=SetDom(slen);
		var ilen="";
		var s1="";
		if(oXml1.documentElement != null ){
			if(oXml1.documentElement.childNodes.length>1){
				ilen=oXml1.documentElement.childNodes(0).childNodes(0).text;//返回数字
			}
		}
		if(ilen>0){
			var str=SelectSql(sSql3,1,ilen,dbName);
			var oXml=SetDom(str);
			for(var i=0;i<ilen;i++){				
				if(oXml.documentElement.childNodes(i).childNodes(0).text!="CC_FORM_INSTANCEID"){//默认的主键不显示。
					s1+=oXml.documentElement.childNodes(i).childNodes(0).text+",";
				}				
			}			
			s1=s1.substring(0,s1.length-1);
		}
	}
	if(typeof s1 == "undefined") s1 = "";
	txtPkey.value=s1;
	
}
//删除表
function uf_dropTab(){
	if(lstTable.selectedIndex<0){
		alert("请选择数据表")
		return;		
	}
	var TAB=lstTable.value;  //表名 
	var sSql="drop table "+TAB;
	if(confirm("确定要删除'"+TAB+"'表吗？")==true){
		var s1=InsertSql(sSql,dbName);
	}else{
		return;
	}
	if(IsSpace(s1)){
	    creator_log("表单数据库管理","删除表:" + TAB);
		for (var i=lstTable.length-1;i>=0;i--){
			if (lstTable.options(i).selected){
				lstTable.remove(i)
				lstTable.selectedIndex=0
				break;
			}
		}
		uf_click();
	}else{
		alert(s1);
	}	
}

//新建表
function uf_createTab(){
	var arr = new Array();
	arr[0] = dbName;
	var sText=DjOpen('fcs_edit_table',arr,'展现','有模式窗口','直接','新建表')	
	
	if(IsSpace(sText)==false){
		sText = sText.toUpperCase();
		var i=lstTable.options.length;
		var oOpt=document.createElement("option")
		oOpt.text=sText;
		oOpt.value=sText;
		lstTable.add(oOpt);
		lstTable.options(i).selected=true;
		
		uf_showFieldList(sText);
		txtPkey.value=""
		uf_showkey(sText)	
	}
}

//删除主键

function uf_delUnique(){
	var sval=lstTable.value;	//表名
	if(fcpubdata.databaseTypeName=="db2"){
		var sSql2="alter table "+sval+" drop PRIMARY KEY " ;
		if(confirm("确定要删除'"+sval+"'表的主键吗？")==true){
			var s2=InsertSql(sSql2,dbName);
			if(IsSpace(s2)){
				//不提示
			}else{
				alert(s2)
			}
		}
	
		return;
	}
	var sSql="";
	if(fcpubdata.databaseTypeName=="sqlserver"){
		sSql="select name from sysobjects where parent_obj=(select id from sysobjects where sysobjects.name='"+sval+"') and sysobjects.type='k'";
		var oXml=SetDom(SelectSql(sSql,1,1));
	}
	if(fcpubdata.databaseTypeName=="oracle"){
		//sSql="select constraint_name from user_constraints where table_name='"+sval+"' and constraint_type='P'"	
		sSql="select distinct constraint_name from all_constraints where table_name='"+sval+"' and constraint_type='P' order by  constraint_name desc"	
		var oXml=SetDom(SelectSql(sSql,1,1,dbName))
		
	}
	if(oXml.documentElement.childNodes.length>1){
		var s1=oXml.documentElement.childNodes(0).childNodes(0).text;
	}else{
		alert("此表内未设主键");
	}	
	if(IsSpace(s1)==false){	    
		var sSql2="alter table "+sval+" drop constraint "+s1;
		if(confirm("确定要删除'"+sval+"'表的主键吗？")==true){
			var s2=InsertSql(sSql2,dbName);
			if(IsSpace(s2) || true ){
				txtPkey.value="";	
				var defaultPkey = "cc_form_instanceid";
				var defaultSql = "alter table "+sval+" add primary key ("+defaultPkey+")";
				var s3=InsertSql(defaultSql,dbName);
				if(IsSpace(s3)){
				    //uf_showkey(sval);
				}else{
				    //alert(s3);
				}
				creator_log("表单数据库管理","删除表(" + sval + ")的主键");
			}else{			    
				alert(s2);
			}
		}else{
			return;
		}
		
	}
}</script><script src='../js/fcopendj.js'></script><script defer src='../js/fcsavedj.js'></script></script><script src='../js/fcselfuse.js'></script><script src='../js/fcbasecont.js'></script><script defer src='../js/fcother.js'></script><script defer src='../js/selectdate.js'></script><script src='../../fceformext/js/userfunc.js'></script><link href=../css/tabstyle.css type=text/css rel=stylesheet><link type='text/css' rel='stylesheet' href='../css/Button.css'/><link type='text/css' rel='stylesheet' href='../css/TextStyle.css'/><script >document.styleSheets[0].addRule("fc\\:webgrid","behavior: url(../htc/webgrid.htc)",0);</script><script src='../js/fcwebgrid.js'></script><script >document.styleSheets[0].addRule("fc\\:fc_code","behavior: url(../htc/fc_code.htc)",0);</script><script >document.styleSheets[0].addRule("fc\\:dataset","behavior: url(../htc/dataset.htc)",0);</script><script src='../js/fcdataset.js'></script>
<DIV id=SKbillsheet jslib="fcopendj.js&#13;&#10;fcsavedj.js&#13;&#10;fcstring.js&#13;&#10;fcnumdate.js&#13;&#10;fcselfuse.js&#13;&#10;fcbasecont.js&#13;&#10;fcother.js&#13;&#10;selectdate.js&#13;&#10;~userfunc.js" idtype="1" OtherSave="否" isfile="否" keyfield postop posleft window="当前窗口" controlno="SKButton:0;SKDBedit:0;checkbox:0;label:0;radio:0;listbox:0;textarea:0;combobox:0;password:0;upload:0;SKDBtext:0;chart:0;dbimg:0;img:0;SKBILLgrid:0;shape:0;tab:0;div:0;DsMain_field:0;a:0;button:0;text:0;hr:0;checkboxlist:0;radiolist:0;dropdownlist:0;grid:0;dataset:0;spin:0;excel:0;tree:0" posheight poswidth entertype="修改" codeheader="BBB" mkbh caption="数据库维护" type="ST" dj_sn="fcs_edit_db" billtaborder="<root><taborder>lstTable</taborder><taborder>FCButton1</taborder><taborder>FCButton2</taborder><taborder>FCButton3</taborder><taborder>FCButton4</taborder><taborder>FCButton5</taborder><taborder>FCButton6</taborder><taborder>FCButton7</taborder><taborder>txtPkey</taborder><taborder>imgwebgrid1</taborder></root>" contxml="<root><label><id>Label1</id><id>Label2</id></label><listbox><id>lstTable</id></listbox><button><id>FCButton1</id><id>FCButton2</id><id>FCButton3</id><id>FCButton4</id><id>FCButton5</id><id>FCButton6</id><id>FCButton7</id></button><text><id>txtPkey</id></text><grid><id>imgwebgrid1</id></grid><dataset><id>imgdataset1</id></dataset></root>" toolbar="不带工具栏" BLONopen="initdbNameselect();uf_sSql()"><SPAN id=Label1 style="DISPLAY: block; FONT-WEIGHT: bold; FONT-SIZE: 16px; LEFT: 12px; WIDTH: 124px; COLOR: #0000ff; FONT-FAMILY: 楷体_GB2312; POSITION: absolute; TOP: 37px; HEIGHT: 17px; TEXT-ALIGN: left; TEXT-DECORATION: underline; backgroundColor1: #ffffff; textLeft: undefined; textRight: undefined; textCenter: undefined" onmovestart=moveStart() controltype="label" value="Label1">选择数据库表：</SPAN><SELECT id=lstTable style="DISPLAY: block; FONT-SIZE: 12px; LEFT: 6px; WIDTH: 255px; FONT-FAMILY: ; POSITION: absolute; TOP: 56px; HEIGHT: 484px; BACKGROUND-COLOR: #ffffff" onmovestart=moveStart() onchange='bill_onclick("uf_click()")' size=8 controltype="listbox" tempvalue temptext sql check="1" sqltrans></SELECT><?xml:namespace prefix = fc /><fc:dataset id=imgdataset1 opensortno="1" temptable="TMP_IMGDATASET2" onValid='bill_ondatasetvalid("<dsid><fdname></fdname><colorder></colorder><fdtype></fdtype><fdsize></fdsize><fddec></fddec><isnullable></isnullable></dsid>")' onGetText='bill_ondatasetgettext("<dsid><fdname></fdname><colorder></colorder><fdtype></fdtype><fdsize></fdsize><fddec></fddec><isnullable></isnullable></dsid>")' onSetText='bill_ondatasetsettext("<dsid><fdname></fdname><colorder></colorder><fdtype></fdtype><fdsize></fdsize><fddec></fddec><isnullable></isnullable></dsid>")' format="<fields><field><fieldname>fdname</fieldname><datatype>字符</datatype><displaylabel>西文字段名</displaylabel><size>50</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag></field><field><fieldname>colorder</fieldname><datatype>字符</datatype><displaylabel>序列号</displaylabel><size>2</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>否</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag></field><field><fieldname>fdtype</fieldname><datatype>字符</datatype><displaylabel>字段类型</displaylabel><size>20</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag></field><field><fieldname>fdsize</fieldname><datatype>整数</datatype><displaylabel>字段宽度</displaylabel><size>2</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag></field><field><fieldname>fddec</fieldname><datatype>整数</datatype><displaylabel>字段精度</displaylabel><size>2</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag></field><field><fieldname>isnullable</fieldname><datatype>整数</datatype><displaylabel>允许空</displaylabel><size>4</size><precision>0</precision><fieldkind>数据项</fieldkind><defaultvalue></defaultvalue><displayformat></displayformat><isnull>否</isnull><iskey>否</iskey><valid>是</valid><procvalid>否</procvalid><link>否</link><target></target><href></href><visible>是</visible><primarykey>否</primarykey><fieldvalid></fieldvalid><tag></tag></field></fields>"></fc:dataset><fc:webgrid id=imgwebgrid1 onkeydown='bill_ongridkeydown("<imgwebgrid1><col></col><col></col><col></col><col></col><col></col></imgwebgrid1>")' ondblclick='bill_ongriddblclick("<imgwebgrid1><col>GridMultiSel(imgwebgrid1,imgdataset1)</col><col>GridMultiSel(imgwebgrid1,imgdataset1)</col><col>GridMultiSel(imgwebgrid1,imgdataset1)</col><col>GridMultiSel(imgwebgrid1,imgdataset1)</col><col>GridMultiSel(imgwebgrid1,imgdataset1)</col></imgwebgrid1>")' onclick='bill_ongridclick("<imgwebgrid1><col></col><col></col><col></col><col></col><col></col></imgwebgrid1>")' dataset="imgdataset1" format="<cols><col><fname>fdname</fname><cname>西文字段名</cname><width>50</width><dtype>字符</dtype><readonly>是</readonly><visible>是</visible><u></u><v></v><s></s><r></r><columnwidth>112</columnwidth><align>left</align></col><col><fname>fdtype</fname><cname>字段类型</cname><width>20</width><dtype>字符</dtype><readonly>是</readonly><visible>是</visible><u></u><v></v><s></s><r></r><columnwidth>100</columnwidth><align>left</align></col><col><fname>fdsize</fname><cname>字段宽度</cname><width>2</width><dtype>整数</dtype><readonly>是</readonly><visible>是</visible><u></u><v></v><s></s><r></r><columnwidth>100</columnwidth><align>left</align></col><col><fname>fddec</fname><cname>字段精度</cname><width>2</width><dtype>整数</dtype><readonly>是</readonly><visible>是</visible><u></u><v></v><s></s><r></r><columnwidth>100</columnwidth><align>left</align></col><col><fname>isnullable</fname><cname>允许空</cname><width>4</width><dtype>整数</dtype><readonly>是</readonly><visible>是</visible><u></u><v></v><s></s><r></r><columnwidth>87</columnwidth><align>left</align></col></cols>" visible="是" readonly="否" autoappend="否" autowidth="否" autoheight="否" canselect="是" width="512" height="468" top="56" left="259">
<TABLE id=t style="TABLE-LAYOUT: fixed; FONT-SIZE: 12px; LEFT: 0px; POSITION: absolute; TOP: 0px; BORDER-COLLAPSE: collapse; BACKGROUND-COLOR: #ffffff" cellpadding="0" cellspacing="1" class="thin" frame=box>
<TBODY>
<TR class=fcGridFirstRow style="FONT-SIZE: 12px; HEIGHT: 30px; BACKGROUND-COLOR: #d4d0c8">
<TD></TD></TR></TBODY></TABLE></fc:webgrid>

<select onchange="uf_sSql()" id="dbNameSelect"  ></select>
<BUTTON id=FCButton1  onmovestart=moveStart() controltype="button" class="input" onclick='bill_onclick("uf_alterField(true)")' dropstyle="否">新增字段</BUTTON>
<BUTTON id=FCButton2  onmovestart=moveStart() controltype="button" class="input" onclick='bill_onclick("uf_del()")' dropstyle="否">删除字段</BUTTON>
<BUTTON id=FCButton3  onmovestart=moveStart() controltype="button" class="input" onclick='bill_onclick("uf_alterField(false)")' dropstyle="否">修改字段</BUTTON>
<BUTTON id=FCButton4  onmovestart=moveStart() controltype="button" class="input" onclick='bill_onclick("uf_setPrimaryKey()")' dropstyle="否">设置主键</BUTTON>
<BUTTON id=FCButton5  onmovestart=moveStart() controltype="button" class="input" onclick='bill_onclick("uf_dropTab()")' dropstyle="否">删除表</BUTTON>
<BUTTON id=FCButton6  onmovestart=moveStart() controltype="button" class="input" onclick='bill_onclick("uf_createTab()")' dropstyle="否">新建表</BUTTON>
<SPAN id=Label2 style="DISPLAY: block; FONT-WEIGHT: bold; FONT-SIZE: 16px; LEFT: 260px; WIDTH: 92px; COLOR: #0000ff; FONT-FAMILY: 楷体_GB2312; POSITION: absolute; TOP: 37px; HEIGHT: 0px; TEXT-ALIGN: left; TEXT-DECORATION: none; backgroundColor1: #c0c0c0; textLeft: undefined; textRight: undefined; textCenter: undefined" onmovestart=moveStart() controltype="label" value="Label2">主键字段：</SPAN>

<INPUT type=text id=txtPkey  onmovestart=moveStart() controltype="text" value CanSelect="false"></INPUT>

<BUTTON id=FCButton7  class="input" onclick='bill_onclick("uf_delUnique()")' dropstyle="否">删除主键</BUTTON></DIV></body></html>
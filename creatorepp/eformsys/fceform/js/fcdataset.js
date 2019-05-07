
function dataset_select(sSql,PageNo,PageSize,sfieldset,callback,context) {
var sXml=new StringBuffer().append("<No>").append(RepXml(sSql)).append("</No>").append("<No1>").append(PageNo).append("</No1>").append("<No2>").append(PageSize).append("</No2>").append("<No2>").append(sfieldset).append("</No2>").append("<No2>").append(fcpubdata.databaseTypeName).append("</No2>").toString();
var retX="";
//creator_pt_actionUrl 定义了的话就向定义的URL发送数据
//add by zuojian.xiang 2009-4-21 
var tmp="";
if(typeof creator_pt_dbname != "undefined"){
	tmp ="&key=dataset_select&dbName="+creator_pt_dbname;
}
if(typeof creator_pt_actionUrl == "undefined"){
	retX = SendHttp(new StringBuffer().append(location.protocol).append("//").append(location.host).append( fcpubdata.servletPath ).append( "/WebBill").append(fcpubdata.dotnetVersion).append("?dataset_select").append(tmp).toString(),sXml,callback,context);
}else{
	var regex = new RegExp("(^/+)(.*)");
	retX = SendHttp(new StringBuffer().append(location.protocol).append("//").append(location.host).append( "/").append(creator_pt_actionUrl.replace(regex,"$2")).toString(),sXml,callback,context);
}
return retX;
}
function copydataset(dsSour,dsDest){
for(var i=0;i<dsSour.FieldCount;i++){
var s1=dsSour.Fields.Field[i].FieldName ;
if(s1!="djbh"){
try{
dsDest.Fields.Field[s1].Value=dsSour.Fields.Field[i].Value;
}catch(e){}
}
}
}
function copydatasetsel(dsSour,dsDest){
var arrSour=new Array();
var arrDest=new Array();
var k=0;
for(var i=0;i<dsSour.FieldCount;i++){
for(var j=0;j<dsDest.FieldCount;j++){
if(dsDest.Fields.Field[j].FieldName.toUpperCase()==dsSour.Fields.Field[i].FieldName.toUpperCase()){
arrSour[k]=i;
arrDest[k]=j;
k++;
break;
}
}
}
var tmpB=true;
if(k>0){
for(var i=0;i<dsSour.RecordCount;i++){
if(dsSour.oDom.documentElement.childNodes(i).getAttribute("multisel")=="是"){
	    //**************开始*******如果发现重复的字段，则不添加该字段××××××××××× 2009-3-23 陈志武
	    var tempBool=false;
	    var value1=dsSour.oDom.documentElement.childNodes(i).childNodes(0).text;
	    dsDest.MoveFirst();
	    for(var m=0;m<dsDest.RecordCount;m++){
	        if(value1==dsDest.Fields.Field[0].Value){
	           m--;
	           tempBool=true;
	           break;
	        }
	        dsDest.MoveNext();
	    }
	    if(tempBool){
	      continue; //继续循环不添加
	    }
	    //*************结束**************   
		var iTmp=dsDest.RecNo;
		if(tmpB){
			dsDest.Append("强行加一行");
			var iTmp=dsDest.oDom.documentElement.childNodes.length-2;
		}
		for(var j=0;j<k;j++){
			dsDest.oDom.documentElement.childNodes(iTmp).childNodes(arrDest[j]).text=dsSour.oDom.documentElement.childNodes(i).childNodes(arrSour[j]).text;
		}
		tmpB=true;
		dsDest.LineSum(null,iTmp);
	}
}
return true;
}else {return false;}
}
function bill_dsevent(eventname,eventfunction){
LoadMod(eventfunction,"clickmenu");
}
function bill_ondatasetvalid(sXml){
var oXml=new ActiveXObject("Microsoft.XMLDOM");
oXml.async=false;
oXml.loadXML (sXml);
var iLen=oXml.documentElement.childNodes.length;
if(iLen>0){
var curFieldName=event.FieldName;
var oNode = oXml.documentElement.selectSingleNode(curFieldName) ;
if(IsSpace(oNode) == false){
var sCommand=oNode.text;
eval(sCommand);
}
}
}
function bill_ondatasetsettext(sXml){
var oXml=new ActiveXObject("Microsoft.XMLDOM");
oXml.async=false;
oXml.loadXML (sXml);
var iLen=oXml.documentElement.childNodes.length;
if(iLen>0){
if(event.FieldName==""){
for(var i=0;i<iLen;i++){
eval(oXml.documentElement.childNodes(i).text);
}
}else{
var curFieldName=event.FieldName;
var oo = oXml.documentElement.selectSingleNode(curFieldName);
if(oo != null){
var sCommand=oo.text;
eval(sCommand);
}
}
}
}
function EditDs(dssub1,fieldname,fieldvalue){
var colno=dssub1.FieldNameToNo(fieldname);
var ii=dssub1.RecNo ;
dssub1.oDom.documentElement.childNodes(ii).childNodes(colno).text=fieldvalue ;
dssub1.oDom.documentElement.childNodes(ii).setAttribute("rowstate","edit") ;
}
function CopyFieldsToArr(oDs) {
var arr = new Array() ;
var ll = oDs.Fields.Field.length;
for(var i=0;i<ll;i++){
arr[i]=oDs.Fields.Field[i].Value ;
}
return arr ;
}
function CopyArrToFields(oDs,arr) {
var ll = oDs.Fields.Field.length;
for(var i=0;i<ll;i++){
oDs.Fields.Field[i].Value = arr[i] ;
}
}
function DsBeforeSave(oDs,oGrid1) {
var oGrid = oGrid1;
if(typeof oGrid1 == "undefined"){
oGrid = GetDsGrid(oDs);
}
if(oGrid.txt.style.display != "none" ){
oDs.cont_onDataChange();
}
if(oDs.Update()==1) return true;
return false;
}
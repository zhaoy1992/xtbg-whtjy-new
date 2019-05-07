
function ShowCalc(){
var s1="";
try{
s1=event.srcElement.value;
}catch(e){};
var sRet=window.showModalDialog(fcpubdata.Path+"/fceform/common/caculator.htm",s1,"status:no;scroll:no;dialogHeight:310px;dialogWidth:300px;center:yes ;") ;
try{
event.srcElement.value=sRet;
}catch(e){}
}
function SendEmail(to,title,body,sip,sfrom,susername,spassword,copyto,sData,sFileName,sBcc) {
if(isSpace(sip)){ sip="smtp.sina.com.cn";}
if(isSpace(sfrom)){ sfrom="82645151@sina.com";}
if(isSpace(susername)) {susername="82645151" ;}
if(isSpace(spassword)) {spassword="8264";}
title=escape(title);
body=escape(body);
sData=escape(sData);
sFileName=escape(sFileName);
var sXml=new StringBuffer().append("<no>").append(to).append("</no>").append("<no>").append(title).append("</no>").append("<no>").append(body).append("</no>");
sXml.append("<no>").append(sip).append("</no>").append("<no>").append(sfrom).append("</no>").append("<no>").append(susername).append("</no>").append("<no>").append(spassword).append("</no>");
sXml.append("<no>").append(copyto).append("</no>").append("<no>").append(sData).append("</no>").append("<no>").append(sFileName).append("</no>").append("<no>").append(sBcc).append("</no>");
var retX=SendHttp(new StringBuffer().append(location.protocol).append("//").append(location.host).append( fcpubdata.servletPath ).append( "/WebBill").append(fcpubdata.dotnetVersion).append("?autosendmail").toString(),sXml);
return retX;
}
function zl_select(sXml) {
var retX=SendHttp(new StringBuffer().append(location.protocol).append("//").append(location.host).append( fcpubdata.servletPath ).append( "/WebBill").append(fcpubdata.dotnetVersion).append("?zl_select").toString(),sXml);
return retX;
}
function SelectZl(fabh,likevalue,ogrid){
if(fabh.indexOf("<") < 0){
fabh="zl_select_"+fabh ;
}
if(typeof likevalue == "undefined") likevalue="";
return zlSelect(fabh,likevalue,1,"",ogrid);
}
function SelectZlSql(sql,sMultiSel,sHideField,sLikeValue,oGrid) {
if(typeof sMultiSel == "undefined") sMultiSel="否";
if(typeof sHideField == "undefined") sHideField="";
if(typeof sLikeValue == "undefined") sLikeValue="";
var s=new StringBuffer().append("<root><dialog_cap></dialog_cap><dialog_hei>400</dialog_hei><dialog_wid>400</dialog_wid><displyflds></displyflds>");
s.append("<filterflds></filterflds><hzcode></hzcode><multisel>").append(sMultiSel).append("</multisel><editflds></editflds><undispflds>").append(sHideField).append("</undispflds>");
s.append("<sql>").append(sql).append("</sql></root>");
return zlSelect(s.toString(),sLikeValue,1,"",oGrid);
}
function zlSelect(zlfabs,zlfield,ipos,zlPara,ogrid){
ShowWait('正在装入....');
if(zlfabs.substring(0,10)=="zl_select_"){
if(typeof zlPara == "undefined") zlPara="";
var sXml=new StringBuffer().append("<no>").append(zlfabs).append("</no>").append("<no>").append(trim(zlfield)).append("</no>").append("<no>").append(zlPara).append("</no>").toString();
var sRet=zl_select(sXml);
if(sRet=="<root></root>") return;
}else{
var sRet=zlfabs ;
}
var oXml=new ActiveXObject("Microsoft.XMLDOM");
oXml.async=false;
oXml.loadXML (sRet);
var screenHeight=parseInt(oXml.documentElement.childNodes(1).text);
var screenWidth=parseInt(oXml.documentElement.childNodes(2).text);
if(isSpace(screenHeight) || isNaN(screenHeight)){
screenHeight=600;
}
if(isSpace(screenWidth) || isNaN(screenWidth)){
screenWidth=500;
}
var iLeft=(screen.availWidth-screenWidth)/2;
var iTop=(screen.availHeight-screenHeight)/2   ;
var dialogStyle="dialogHeight:314px;dialogWidth:480px;status:no;scroll:no";
var arr=new Array();
arr[0]=window;
arr[1]=oXml.documentElement.childNodes(9).text;
arr[1]=RepOpenSql(arr[1],zlfield);
arr[2]=ogrid;
arr[3]=oXml.documentElement.childNodes(8).text;
arr[4]=oXml.documentElement.childNodes(6).text;
if(IsSpace(arr[4])) arr[4]="否";
arr[5]=getuser() ;
arr[6]=zlfabs;
var sPath="";
if(ipos==1 || typeof ipos =="undefined") { sPath=fcpubdata.Path+"/fceform/common/" ;}
if(ipos==2) {sPath="fceform/common/";}
var sXml=dataset_select(arr[1],1,2);
if(sXml == "<root>"){
CopyToPub(arr[1]);
alert("此条SQL语句执行出错! "+arr[1]);
return
}
var oXml=new ActiveXObject("Microsoft.XMLDOM");
oXml.async=false;
oXml.loadXML (sXml);
if(oXml.documentElement.childNodes.length==2){
if(typeof ogrid == "undefined" ) {
var odsmain=GetDsMainObj();
if(odsmain != null){
var ooField=oXml.documentElement.childNodes(oXml.documentElement.childNodes.length-1).childNodes(1);
for(var j=0;j<ooField.childNodes.length;j++){
try {
odsmain.Fields.Field[ooField.childNodes(j).childNodes(0).text].Value =
oXml.documentElement.childNodes(0).childNodes(j).text ;
}catch(e){}
};
odsmain.fset_cont1();
}
}
if(typeof ogrid != "undefined" ) {
ogrid.hide();
var oDs=eval(ogrid.dataset);
var ooField=oXml.documentElement.childNodes(oXml.documentElement.childNodes.length-1).childNodes(1);
for(var j=0;j<ooField.childNodes.length;j++){
try {
oDs.Fields.Field[ooField.childNodes(j).childNodes(0).text].Value =
oXml.documentElement.childNodes(0).childNodes(j).text ;
}catch(e){
}
}
oDs.bEdit = true;
oDs.Update("不检查")  ;
oDs.LineSum(ogrid,oDs.RecNo);
oDs.fset_cont1();
oDs.fset_cont();
if(ogrid.curTD.parentNode.rowIndex == ogrid.tab.rows.length-1){
ogrid.EndRowState="edit";
}
}
ShowWait("end");
return;
}else if(oXml.documentElement.childNodes.length==1){
ShowWait("end");
alert("没有要显示的资料数据!");
return;
}
var sRet=window.showModalDialog(sPath+"selectall.htm",arr,dialogStyle);
if(typeof ogrid != "undefined"){
DsToGrid(ogrid,arr[4]);
}
ShowWait("end");
return sRet;
}
function ZlSelect(zlfabs,zlfield,ipos,zlPara,ogrid){return zlSelect(zlfabs,zlfield,ipos,zlPara,ogrid);}
var kcpubdata={
servletPath			: "/servlet",
Path				: "/eformsys",
djtype              : "ZW", //�����ͣ�������Ϊ�丳ֵ��������һ��Ĭ��ֵ�� 
openDjUrl           : ""   //������Ϊ�丳ֵ�����ļ��򿪱���url 
} ;

var kc_tmp12345 = GetUrlFirstPart();
kcpubdata.servletPath = kc_tmp12345+kcpubdata.servletPath;
kcpubdata.Path = kc_tmp12345+kcpubdata.Path;

var sHtml=GetBillType(); //��ȡbilltype.xml�еļ�¼.
kcpubdata.djtype = sHtml.substring(sHtml.indexOf('value=')+7,sHtml.indexOf('value=')+9);
kcpubdata.openDjUrl = location.protocol+"//"+location.host+kcpubdata.Path+"/fceform/common/djframe.htm?djtype="+kcpubdata.djtype+"&djsn=";


//===================================���õĺ���
function GetBillType() {
var oXml = SetDomFile(kcpubdata.Path+"/fceform/billtype.xml");
var sRet = "" ;
if(oXml.documentElement != null) {
var l = oXml.documentElement.childNodes.length-1;
for(var i=0;i<l ; i++) {
var stext = oXml.documentElement.childNodes(i).childNodes(1).text;
var svalue = oXml.documentElement.childNodes(i).childNodes(2).text;
var spath = oXml.documentElement.childNodes(i).childNodes(3).text;
var sextname = oXml.documentElement.childNodes(i).childNodes(4).text;
sRet += "<option value=\""+svalue+"\" extname=\""+sextname+"\" path=\""+spath+"\">"+stext+"</option>";
}
}
return sRet;
}



function SetDomFile(sPath) {
var oXml ;
try{
oXml=new ActiveXObject("Msxml2.DOMDocument");
}catch(e){
}
if(typeof oXml == "undefined") oXml=new ActiveXObject("Microsoft.XMLDOM");
oXml.async=false;
oXml.load (sPath);
return oXml;
}



function GetUrlFirstPart(){
	var tmp12345 = location.pathname ;
	tmp12345 = tmp12345.substring(0,tmp12345.indexOf("/",1));
	if(tmp12345.substring(0,1) != "/") tmp12345 = "/" +tmp12345;
	return tmp12345;
}
//======================================��
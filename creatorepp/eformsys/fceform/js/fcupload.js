var attachidArr=new Array();
function upload_addrow(tb){
var oTr=tb.insertRow(tb.rows.length-1);
oTr.style.borderBottom="1px solid";
var oTd;
oTd=oTr.insertCell();
oTd.style.width="20";
oTd.style.borderBottom="1px solid";
oTd.style.fontSize="12px";
oTd=oTr.insertCell();
oTd.style.width="60%";
oTd.style.borderBottom="1px solid";
oTd.style.fontSize="12px";
oTd=oTr.insertCell();
oTd.style.width="30%";
oTd.style.borderBottom="1px solid";
oTd.style.fontSize="12px";
oTd=oTr.insertCell();
oTd.style.display="none";
oTd.style.fontSize="12px";
oTd=oTr.insertCell();
oTd.style.display="none";
oTd.style.fontSize="12px";
oTd=oTr.insertCell();
oTd.style.width="40";
oTd.style.borderBottom="1px solid";
oTd.style.fontSize="12px";
oTd=oTr.insertCell();
oTd.style.display="none";
oTr.style.height=20;
oTd.style.fontSize="12px";
return oTr;
}
function upload_onload(){
var allowDelete = creator_getQueryString("allowDelete"); //�Ƿ�����ɾ��    "true":����"false":������
var allowAdd = creator_getQueryString("allowAdd");       //�Ƿ��������Ӹ��� "true":����"false":������
if(IsSpace(allowDelete)){
	allowDelete = "true";
}
if(IsSpace(allowAdd)){
    allowAdd = "true";
}
if(HaveUpload() == false ) return;
var sRet="";
try{
if(isSpace(pubdjbh)) {return;}
}catch(E){}
var tmpdjbh=pubdjbh;
if(IsSpace(fcpubdata.uploadForm)) fcpubdata.uploadForm = SKbillsheet.dj_sn ;
    var retX=SendHttp(location.protocol+"//"+location.host+ fcpubdata.servletPath + "/uploaddoc"+fcpubdata.dotnetVersion+"?key=readimage&sTablename=FC_ATTACH&sImgname=attach&sKeyvalue="+tmpdjbh+"&sKeyvalue1="+fcpubdata.uploadForm+"&subPath="+escape(fcpubdata.Path),"");

//alert("req:"+location.protocol+"//"+location.host+ fcpubdata.servletPath + "/uploaddoc"+fcpubdata.dotnetVersion+"?key=readimage&sTablename=FC_ATTACH&sImgname=attach&sKeyvalue="+tmpdjbh+"&sKeyvalue1="+fcpubdata.uploadForm+"&subPath="+escape(fcpubdata.Path));
//alert("retX:"+retX);

if(isSpace(retX)==false){
var oXml=new ActiveXObject("Microsoft.XMLDOM");
oXml.async=false;
oXml.loadXML (retX);
if(oXml.documentElement == null) return ;
var tb=upload1.children[0];
if(allowAdd=="false"){   //�������Ӹ�����ť
    tb.rows(tb.rows.length-1).style.display="none";
}
for(var i=0;i<oXml.documentElement.childNodes.length;i++){
if(isSpace(oXml.documentElement.childNodes(i).childNodes(0).text)==false){
var oTr=upload_addrow(tb);
var extName=oXml.documentElement.childNodes(i).childNodes(3).text;
var tmp_extname = extName.substring(1,extName.length) ;
if (tmp_extname != "avi" && tmp_extname != "css" && tmp_extname != "doc" && tmp_extname != "gif" && tmp_extname != "htm" && tmp_extname != "jpg" && tmp_extname != "js" && tmp_extname != "mid" && tmp_extname != "psd" && tmp_extname != "rar" && tmp_extname != "txt" && tmp_extname != "wav" && tmp_extname != "xml" && tmp_extname != "xsl" && tmp_extname != "zip" && tmp_extname != "asf" && tmp_extname != "mpeg" && tmp_extname != "mpg" && tmp_extname != "pdf" && tmp_extname != "ppt" && tmp_extname != "swf" && tmp_extname != "au" && tmp_extname != "bmp" && tmp_extname != "ini" && tmp_extname != "mdb" && tmp_extname != "midi" && tmp_extname != "mov" && tmp_extname != "mp3" && tmp_extname !="xls"){
tmp_extname = "other" ;
}
var fileName1=tmp_extname+".gif";
var gifPath=fcpubdata.Path+'/fceform/images/filetype/';
tb.rows(i).cells(0).innerHTML="<img src='"+gifPath+fileName1+"'></img>";
tb.rows(i).cells(3).innerText = oXml.documentElement.childNodes(i).childNodes(2).text;
tb.rows(i).cells(2).innerText = oXml.documentElement.childNodes(i).childNodes(4).text;
var tmpPath = fcpubdata.Path
//tb.rows(i).cells(1).innerHTML = "<a target='_blank' href='"+location.protocol+"//"+location.host+tmpPath+oXml.documentElement.childNodes(i).childNodes(0).text +"'>"+sepFile(oXml.documentElement.childNodes(i).childNodes(1).text)+"</a>";
var myfilename = sepFile(oXml.documentElement.childNodes(i).childNodes(1).text);
tb.rows(i).cells(1).innerHTML = "<a target='_newframe' href='"+location.protocol+"//"+location.host+ fcpubdata.servletPath + "/DownloadUploadFile"+fcpubdata.dotnetVersion+"?attachid="+oXml.documentElement.childNodes(i).childNodes(2).text+"&filename="+myfilename+"'>"+myfilename+"</a>";
if(allowDelete=="false"){
	tb.rows(i).cells(5).innerHTML = "";	
}else{
	tb.rows(i).cells(5).innerHTML = "<span style='cursor:hand;color:blue;font-size:12px;text-decoration:underline;width:70px' onclick='uploadDelFile("+i+")'  >ɾ��</span>";
}
tb.rows(i).cells(6).innerText = oXml.documentElement.childNodes(i).childNodes(0).text;
}
}
}
}
//�޸ĺ󣬱������ʱ��Ͳ���Ҫִ����������ˡ�����ʵʱ������
function upload_save(djbh){
//if(HaveUpload() == false ) return;
//if(IsSpace(fcpubdata.uploadForm)) fcpubdata.uploadForm = SKbillsheet.dj_sn ;

//var sDelXml="";
//var sql="";
//var tb=upload1.children[0];
//for(var i=0;i<tb.rows.length-1;i++){
//var sTag = tb.rows(i).cells(4).innerText;
//if(sTag == "����" ){   //�ļ��ϴ�ʵ��ʵʱ��⣬����Ҫ����ı��水ť��
//var filename = tb.rows(i).cells(1).innerText;
//if(isSpace(filename)==false){
//filename=trim(filename);
//var extname=filename.substring(filename.length-4,filename.length);
//extname=extname.toLowerCase();
//filename=tb.rows(i).cells(1).title;
//var m_attachid = tb.rows(i).cells(3).innerText;
//var sBz = tb.rows(i).cells(2).innerText;
//var sFilepos = tb.rows(i).cells(6).innerText;
//sql+="<no>insert into FC_ATTACH (attachid,djbh,filename,extend,bz,djsn,filepos) values ('"+m_attachid+"','"+djbh+"','"+filename+"','"+extname+"','"+sBz+"','"+fcpubdata.uploadForm+ "','" + sFilepos+"') </no>";
//}
//}else if(sTag == "ɾ��"){
//	var m_attachid = tb.rows(i).cells(3).innerText;
//	if(isSpace(m_attachid)==false){
//		sql+="<no>delete from FC_ATTACH where attachid='"+m_attachid+"' </no>";
//	}
//}

//if(sTag == "ɾ��" || sTag == "���Ӻ�ɾ��"){
//	sDelXml += "<file>" + tb.rows(i).cells(6).innerText + "</file>";
//}
//}

//�޸ĺ�ֻ�ǲ�������ʱ�ļ�����ʱ�ļ��Ѿ�ɾ��������Ͳ���Ҫɾ���ļ��ˡ�
//if(sDelXml!=""){      
//	sDelXml = "<path>"+fcpubdata.Path+"</path>" + sDelXml  ;
//	var retX=SendHttp(location.protocol+"//"+location.host + fcpubdata.servletPath + "/WebBill"+fcpubdata.dotnetVersion+"?DelUploadFile",sDelXml);
//	if(IsSpace(retX) == false){
//		alert(retX);
//	}
//}

//if(sql!=""){
//	var sRet1=inserts(sql);
//	if(isSpace(sRet1)==false){
//		alert(sRet1);
//		return;
//	}
//}
}
function uploadAddFile(){

if(upload1.disabled)return;
var arrPara = new Array();
arrPara[0] = upload1.setpath ;
if(typeof upload1.setpath == "undefined") arrPara[0] ="/fceformext/res/";
arrPara[1] = upload1.extfiles ;
if(!isSpace(pubdjbh)){
    arrPara[2] = pubdjbh;   //������ֵ��Ҫ�����fc_attach��djbh�ֶΡ�
}else{
	alert("��ǰ��������Ϊ�գ����ܽ����ϴ��ļ��Ĳ�����");
	return;
}
arrPara[3] = SKbillsheet.dj_sn;
var mytb = upload1.children[0];
var fileQuantity = upload1.fileQuantity;  //���fileQuantity����û�����ã���������Ϊ0�����ļ��������Ʋ������á�

var quantity = 0;
if(mytb.rows.length>0){
	for(var i=0;i<mytb.rows.length-1;i++){
    	arrPara[4+i] = mytb.rows(i).cells(1).innerText; 
    	//alert("js:"+arrPara[4+i]); 
    	if(arrPara[4+i]!="��ɾ��"){
    	    quantity++;
    	}  
	}
}

if(!IsSpace(fileQuantity) && fileQuantity>0){
	if(quantity>=fileQuantity){
		alert("���ֻ���ϴ�"+fileQuantity+"��������");
		return;
	}
}
	
if(typeof upload1.extfiles == "undefined") arrPara[1] = "";
var arr = window.showModalDialog(fcpubdata.Path+"/fceform/common/uploadfilemain.htm",arrPara,"scroll:no;status:no;dialogHeight:290px;dialogWidth:350px;dialogTop:180;dialogLeft:250px") ;
// modified by zhiwu.chen 2009-05-14
//  ������ʵ��ID ������ҳ������У���Ӧ����ʹ��
if(attachidArr.length>0 && !isSpace(arr)){
attachidArr[attachidArr.length]=arr[3];
}else if(!isSpace(arr)){
attachidArr[0]=arr[3];
}

/***************  end  *********/
//alert("arr[0]:"+arr[0]); //�ϴ��ļ��ĵ�ַ
//alert("arr[1]:"+arr[1]); //��ע��˵��
//alert("arr[2]:"+arr[2]); //����������ʱ�ļ��ĵ�ַ���Ѿ�û����
//alert("arr[3]:"+arr[3]); //attachid
pubEdit=true;
if(isSpace(arr)==false) {
var sRet = arr[0];
var tb=upload1.children[0];
var oTr=upload_addrow(tb);
var expName=sRet.substring(sRet.length-3,sRet.length);
var tmp_extname=expName.toLowerCase();
if (tmp_extname != "avi" && tmp_extname != "css" && tmp_extname != "doc" && tmp_extname != "gif" && tmp_extname != "htm" && tmp_extname != "jpg" && tmp_extname != "js" && tmp_extname != "mid" && tmp_extname != "psd" && tmp_extname != "rar" && tmp_extname != "txt" && tmp_extname != "wav" && tmp_extname != "xml" && tmp_extname != "xsl" && tmp_extname != "zip" && tmp_extname != "asf" && tmp_extname != "mpeg" && tmp_extname != "mpg" && tmp_extname != "pdf" && tmp_extname != "ppt" && tmp_extname != "swf" && tmp_extname != "au" && tmp_extname != "bmp" && tmp_extname != "ini" && tmp_extname != "mdb" && tmp_extname != "midi" && tmp_extname != "mov" && tmp_extname != "mp3" && tmp_extname !="xls"){
tmp_extname = "other" ;
}
var fileName1=tmp_extname+".gif";
var gifPath=fcpubdata.Path+'/fceform/images/filetype/';
oTr.cells(0).innerHTML="<img src='"+gifPath+fileName1+"'></img>";
oTr.cells(1).innerText=sepFile(sRet);
oTr.cells(1).title=sRet;
oTr.cells(2).innerText = arr[1] ;
//oTr.cells(3).innerText=getMaxNo("UPF",SKbillsheet.mkbh);
oTr.cells(3).innerText=arr[3];
oTr.cells(4).innerText="����";
oTr.cells(5).innerHTML="<span style='cursor:hand;color:blue;text-decoration:underline;width:70px;' onclick='uploadDelFile("+oTr.rowIndex+")'>ɾ��</span>";
oTr.cells(6).innerText=arr[2];
}
}

function uploadDelFile(iRow){
	if(upload1.disabled)
	    return;
	if(!confirm("��ȷ��Ҫɾ�����ļ���ɾ�����ǲ����Իָ��ġ�")){
		return;
	}
	pubEdit=true;
    var tb=upload1.children[0];
    var m_attachid = tb.rows(iRow).cells(3).innerText;
// modified by zhiwu.chen 2009-05-14
//  ������ʵ��ID ������ҳ������У���Ӧ����ʹ��
    attachidArr.remove(m_attachid);
    //**************  end *********
	var sql = "";
	if(isSpace(m_attachid)==false){
	    var app_id = creator_getSession("subsystem_id");
	    var app_user = "";	    
	    if(!IsSpace(app_id) && app_id!="module"){
	    	//modify by minghua.guo 09/12/14
	        app_user = "";//"APP_"+app_id.toUpperCase()+".";
        }
		sql+="delete from "+app_user+"FC_ATTACH where attachid='"+m_attachid+"'";
	}
    if(sql!=""){
		var sRet1=InsertSql(sql,getAppDbName());   //ִ��ɾ��
		if(!isSpace(sRet1)){
			alert(sRet1);
			return;
		}else{
		    var o=tb.rows(iRow).cells(2);
			var s1=o.parentNode.cells(4).innerText;
			if(isSpace(s1)){
				o.parentNode.cells(4).innerText="ɾ��";
				o.parentNode.cells(1).innerHTML="<font color=red>��ɾ��</font>";		
			}else if(s1=="ɾ��" || s1==="���Ӻ�ɾ��"){
				alert("���ļ���ɾ��!");
				return;
			}else {
				o.parentNode.cells(4).innerText="���Ӻ�ɾ��";
				o.parentNode.cells(1).innerHTML="<font color=red>��ɾ��</font>";
			}
			tb.rows(iRow).style.display="none";
		}
	}
}

function sepFile(sPath){
if(isSpace(sPath)){ return "";}
for(var i=sPath.length;i>0;i--){
var s1=sPath.substring(i-1,i);
if ( escape(s1)=="%5C" || s1=="/" || s1==":" ) {
return sPath.substring(i,sPath.length);
}
}
}
if ( typeof window.attachEvent != "undefined" ) {
window.attachEvent( "onload", upload_onload );
}
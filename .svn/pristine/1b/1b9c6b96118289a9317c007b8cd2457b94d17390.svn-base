//编辑文件
function editFileContent(fileName,uri){
	var url = "editFileContent.jsp?fileName="+fileName+"&uri="+uri;
	var width = screen.availWidth;
	var height = screen.availHeight;
	var f = "dialogWidth:"+width+"px;dialogHeight:"+height+"px;center:yes;resizable:no;scroll:auto";
	window.showModalDialog(url,window,f);

}
function onMsEnter(obj){
	//obj.style.backgroundColor = "#C3D2E5";
	obj.style.cursor="hand";
}
function onMsOut(obj){
	//obj.style.backgroundColor = "#EEEEEE";
	obj.style.cursor="default";
}
function myOpen(url){
	window.showModalDialog(url,window,"dialogWidth:400px;dialogHeight:300px;center:yes;resizable:no;scroll:no");
}
/**
* 
* 实现:打开模态窗口
*/
function openWin(url,swidth,sheight){
     var w = showModalDialog(url,window,"dialogWidth:"+swidth+"px;dialogHeight:"+sheight+"px;help:no;scroll:auto;status:no");
     return w;
}
//复选框全部选中
function checkAll(totalCheck,checkName){	
   var selectAll = document.getElementsByName(totalCheck);
   var o = document.getElementsByName(checkName);
   if(selectAll[0].checked==true){
	   for (var i=0; i<o.length; i++){
      	  if(!o[i].disabled){
      	  	o[i].checked=true;
      	  }
	   }
   }else{
	   for (var i=0; i<o.length; i++){
   	  	  o[i].checked=false;
   	   }
   }
}
//如果有checkboxId,将删除checkbox所在的那一行,
//如果没有checkboxId这个参数,将删除所有选中的checkbox所在的行
function deleteFiles(checkboxId,uri){
	if(checkboxId){
	  if(confirm('您确定要删除所选文件?')){
			var Obj = eval("document.form1."+checkboxId);
			var url = "deleteFiles_do.jsp?uri="+uri+"&files="+Obj.value;
			document.form1.action = url;
			document.form1.method = "post";
			document.form1.target = "hidFrm";
			document.form1.submit();
		}
		return;

	}
	var files = document.all.form1.elements("multiFiles");
	var hasChoosed = false;
	var filesStr = "";
	if(!files){
		alert("这个目录下没有文件!");
		return;
	}
	if(!files.length){
		if(files.checked){
			hasChoosed = true;
			filesStr += files.value+"<>";
		}	
	}else{
		for(var i=0;i<files.length;i++){
			if(files[i].checked){
				hasChoosed = true;
				filesStr += files[i].value+"<>"
			}
		}
	}
	if(hasChoosed){
		filesStr = filesStr.substring(0,filesStr.length-2);
	}else{
		alert("请选中一个或多个文件(夹)");
		return;
	}
	var url = "deleteFiles_do.jsp?uri="+uri+"&files="+filesStr;
	if(confirm('您确定要删除所选文件?')){
		document.form1.action = url;
		document.form1.method = "post";
		document.form1.target = "hidFrm";
		document.form1.submit();
	}
}
//重命名
function reName(currFileName,uri){
var url = "reName.jsp?uri="+uri+"&tempuri="+currFileName;
	myOpen(url);
}
//预览模板
function pubPreviewFile(filename,uri) {
	var u = uri.replace("\\", "/").replace(/\s+/img,"");
	if(u.charAt(u.length - 1)!="/"){
		u = u+"/";
	}
	if(u=="/"){
		u = "";
	}
	hidFrm.location.href = "template_pub_preview.jsp?uri="+(u+filename);
}
//新建文件
function createFile(type,uri){
	var url = "createFile.jsp?uri="+uri+"&type="+type;
	myOpen(url);
}
//上传文件
function uploadFile(uri){
	var url = "uploadFile.jsp?uri="+uri;
	myOpen(url);
}

function goBack(theURI){
	//(1)确保uri的格式为:文件夹名1/文件夹名1
	var uri = theURI.replace(/\\/img,"/");
	if(uri.charAt(0)=="/"){
		uri = uri.substr(1);
	}
	if(uri.charAt(uri.length-1)=="/"){
		uri = uri.substring(0,uri.length-1);
	}
	
	
	var uris = uri.split("/");
	uri = "";
	for(var i=0;i<uris.length-1;i++){
		uri += uris[i]+"/";
	}
	if(uri!=""){
		uri = uri.substring(0,uri.length-1);
	}
	self.location = "docTpl_list.jsp?uri="+uri;
}

function onDBClick(obj,name,isFolder,theURI){
	if(isFolder == true){
		var u = "";
		if(theURI){
			u = theURI.replace("\\", "/").replace(/^\s+$/img,"");
	
			if(u.charAt(u.length - 1)!="/"){
				u = u+"/";
			}
			if(u=="/"){
				u = "";
			}
		}
		self.location = "docTpl_list.jsp?uri="+u+name;
	}
}
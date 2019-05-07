/**
 *依赖jquery*.js,public.js
 *检测打开页面你的浏览器是否安装显示TIF图片的插件
 */
var htmlshowTIFhelp={};
htmlshowTIFhelp.hasCJ = false;
htmlshowTIFhelp.unNeedCJ = false;
htmlshowTIFhelp.noCJmess="<br><font color='#FF00FF'>检测不到插件,无法显示TIF图片</font>";
htmlshowTIFhelp.checkPlugins =function(pluginsName, activexObjectName) {
         var np = navigator.plugins;
         // 针对于FF等非IE
         if (np && np.length) {
             for(var i = 0; i < np.length; i ++) {
                 if(np[i].name.indexOf(pluginsName) != -1) return true;
             }
             return false;
         }
         // 针对于IE
         else if (window.ActiveXObject) {
         	try{
         		var axobj =eval("new ActiveXObject('"+activexObjectName+"');");
				return axobj ? true : false;
         	}catch(e){
         		return false;
         	}
         } else {
         	alert('无法识别浏览器');
             // 以上情况都排除则返回false
             return false;
         }
     }
htmlshowTIFhelp.checkTIF=function(showMessObjId){
	var IE_64="<br><font color='#FF00FF'>支持浏览器显示TIF文件的插件未安装!点击这里<a href='"+getContextPath()+"/ccapp/oa/file/resources/tifhelp/alternatiff-ax-w64-2.0.6.zip' target='_self'>下载文件,执行安装</a>,安装后重新进入,注册后使用。</font>";
	var IE_32="<br><font color='#FF00FF'>支持浏览器显示TIF文件的插件未安装!点击这里<a href='"+getContextPath()+"/ccapp/oa/file/resources/tifhelp/alternatiff-ax-w32-2.0.6.zip' target='_self'>下载文件,执行安装</a>,安装后重新进入,注册后使用。</font>";	  
	var OTHER_64="<br><font color='#FF00FF'>支持浏览器显示TIF文件的插件未安装!点击这里<a href='"+getContextPath()+"/ccapp/oa/file/resources/tifhelp/alternatiff-pl-w64-2.0.6.exe' target='_self'>下载文件,执行安装</a>,安装后重新进入,注册后使用。</font>";	  
	var OTHER_32="<br><font color='#FF00FF'>支持浏览器显示TIF文件的插件未安装!点击这里<a href='"+getContextPath()+"/ccapp/oa/file/resources/tifhelp/alternatiff-pl-w32-2.0.6.exe' target='_self'>下载文件,执行安装</a>,安装后重新进入,注册后使用。</font>";	  
	var CHROME="<br><font color='#FF00FF'>支持浏览器显示TIF文件的插件未安装!点击这里<a href='"+getContextPath()+"/ccapp/oa/file/resources/tifhelp/alternatiff-pl-w32-2.0.6-chrome.exe' target='_self'>下载文件,执行安装</a>,安装后重新进入,注册后使用。</font>";	  
	var mess="<br>注册方法:点击插件容器中心,(连互联网)选择自动注册(AutomaticRegistration) <br>或 (未连互联网)选择手动注册(ManualRegistration):复制网络地址通过其他途径上网获取激活码注册";

	var hasEXE = htmlshowTIFhelp.checkPlugins('AlternaTIFF','Alttiff.AlttiffCtl');
	htmlshowTIFhelp.hasCJ = hasEXE;
	if(!hasEXE){
		if(navigator.userAgent.indexOf("MSIE")>0){
			if(navigator.appVersion.match(/9./i)=="9."||navigator.appVersion.match(/10./i)=="10."){
				htmlshowTIFhelp.unNeedCJ=true;
			}else{
				if (navigator.userAgent.indexOf('Win64')>=0){
					document.getElementById(showMessObjId).innerHTML=IE_64+mess;
				} else {
					document.getElementById(showMessObjId).innerHTML=IE_32+mess;
				}
			}
		}else if(navigator.userAgent.indexOf("Chrome")>0){
			//checkOver = "需要安装chrome插件";
			if (navigator.userAgent.indexOf('Win64')>=0){
				document.getElementById(showMessObjId).innerHTML=OTHER_64+mess;	
			}else{
			 	document.getElementById(showMessObjId).innerHTML=CHROME+mess;	
			}
		}else{//Mozilla Firefox
			//checkOver = "需要安装o插件"+navigator.userAgent;
			if (navigator.userAgent.indexOf('Win64')>=0){
				document.getElementById(showMessObjId).innerHTML=OTHER_64+mess;	
			}else{
			 	document.getElementById(showMessObjId).innerHTML=OTHER_32+mess;	
			}
		}
   }
};
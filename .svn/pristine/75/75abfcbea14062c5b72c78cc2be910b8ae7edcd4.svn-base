/*
	文件：commoncss.js
	描述：协同办公系统的所有页面都必须引用此文件；文件包含一些协同办公都需要使用的内容。
	作者：黄艺平
	日期：2012-2-1
*/
var SYSINFO = {}; //系统信息对象
//SYSINFO.ROOTPATH = "/ccapp/resources"; //系统根目录
SYSINFO.CSSPATH = getContextPath() + ""; //CSS样式文件路径 


var path = SYSINFO.CSSPATH.substring(0,1);
if(path != "/"){
	SYSINFO.CSSPATH = "/" + SYSINFO.CSSPATH;
	
}

SYSINFO.CSSFILES = [
	
];
(function () { //根据CSS样式文件列表自动加载CSS样式文件
	var tmp = null;
	for (var i = 0, count = SYSINFO.CSSFILES.length; i < count; i++) {
		tmp = document.createElement("link");
		tmp.setAttribute("type", "text/css");
		tmp.setAttribute("rel", "stylesheet");
		tmp.setAttribute("href", SYSINFO.CSSPATH + "/" + SYSINFO.CSSFILES[i]);
		document.getElementsByTagName("head")[0].appendChild(tmp);
	}
	tmp = null;
})();

 





/*
	�ļ���commoncss.js
	������Эͬ�칫ϵͳ������ҳ�涼�������ô��ļ����ļ�����һЩЭͬ�칫����Ҫʹ�õ����ݡ�
	���ߣ�����ƽ
	���ڣ�2012-2-1
*/
var SYSINFO = {}; //ϵͳ��Ϣ����
//SYSINFO.ROOTPATH = "/ccapp/resources"; //ϵͳ��Ŀ¼
SYSINFO.CSSPATH = getContextPath() + ""; //CSS��ʽ�ļ�·�� 


var path = SYSINFO.CSSPATH.substring(0,1);
if(path != "/"){
	SYSINFO.CSSPATH = "/" + SYSINFO.CSSPATH;
	
}

SYSINFO.CSSFILES = [
	
];
(function () { //����CSS��ʽ�ļ��б��Զ�����CSS��ʽ�ļ�
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

 





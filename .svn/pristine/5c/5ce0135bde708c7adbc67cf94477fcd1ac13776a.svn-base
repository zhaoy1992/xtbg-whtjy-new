var fcpubdata = {
	servletPath : "/servlet",
	Path : "/eformsys",
	dotnetVersion : "",
	databaseTypeName : "oracle",
	db2UserName : "DB2ADMIN",
	pub_sendhttp_errmsg : ":与后台连接出错:",
	gridno_fieldname : "dj_sn",
	BillOpenWinName : "rightmain",
	position : "static",
	toolbar : "newempty,newdj,opendj,opendjfile,billtype,djpreview,directrun,save,saveas,|,cut,copy,paste,undo,redo,|,align,focus,front,behind,form,|,userfunction,userfunction1,addhtml,execute,showlist,setPosition,|,menu,eformhelp,cbozoom,br,button,label,img,div,shape,|,tab,tree,a,spin,checkboxlist,radiolist,|,dataset,grid,htmltable,formattab,|,text,checkbox,radio,listbox,combobox,dropdownlist,textarea,dbimg,|,chart,upload,excel",
	toolbarstyle : "CoolBlue",
	creatorStyle : "creatorBlue",
	version : "1.0",// 用户输入的版本号
	djid : "",
	cc_form_instanceid : " ", // 每个活动对应的业务id，表单实例id。
	cc_form_showid : "", // 根据该值来显示表单数据。
	djtype : "ZW", // 表单类型，在下面为其赋值，这里填一个默认值。
	openDjUrl : "", // 在下面为其赋值，从文件打开表单的url
	savePath : "jxc/dj/",// 表单生成文件的保存路径
	extname : "jsp",// 生成文件的扩展名
	formtb : "<option path=\"~/fceform/common/toolbarinput1.htm\">单表输入工具栏</option><option path=\"~/fceform/common/toolbarinput2.htm\">多表输入工具栏</option><option path=\"~/fceform/common/toolbarfind.htm\">查询工具栏</option><option path=\"~/fceform/common/toolbar.htm\">带工具栏</option>",

	// 以下几个是iWebOffice2006控件使用的全局变量,默认值，不打开文件。
	mServerUrl : "",
	mRecordID : "", // 文档id，新建的文件使用cc_form_instanceid
	mTemplate : "", // 文档模板id
	mFileName : "", // 文档名称=文档id+文档类型
	mFileType : ".doc",
	mUserName : "admin", // 默认值，下面进行了修改。
	mEditType : "2,0",
	mShowType : "1",
	mIsFirstLoad : "", // 是否是第一次加载office控件。true：是；false：否。
	mLoadTool : "false", // 判断office控件的工具栏（页面范围内）是否已经加载。 true,已经加载；false,没加载
	mWebOfficeRoot : "", // 得到WebOffice控件在应用中的根目录。
	noneWorkflowWordId : "", // 非流程应用使用word控件
	taohong : "0", // 文档核稿有两种状态，一种可以套红，一种不可以套红，以此变量来区分是否套红。
	webOfficeLoadOk : "0", // webOffice控件是否加载完成 0，加载未完成；1，加载完成
	webOfficeHadTaohong : "0", // webOffice文档是否已经成功套红。 0，未套红，或套红失败；1，成功套红。

	// 表单流程一体化保存添加的变量，统一参数传递通道。
	workflowId : "", // 流程定义id
	oid : "", // 活动定义id djid和cc_form_instanceid已经有了。

	mAppName : "", // 平台配置的访问名称。

	mIsAutoLoadWord : "true", // 启动流程表单是否自动加载word控件。默认自动加载
	wf_isReadOnly : "", // 是否为办结列表，"readonly":办结列表 "nosend":未发送列表
	elementAuthoritySwitch : "", // 是否用户控制表单元素权限
	office_isBindForm : "", // 流程中office控件是否绑定表单，绑定表单之后，就只有该表单才能打开这个word的文档。非流程表单中的word文档是与表单绑定的。

	opentree_orgids : "", // opentree打开的机构用户树返回的机构id

	// added by zhou.luo in 2008-10-15
	// 在流程中打开其他流程或本流程其他表单包含的word文档而添加的4个可选参数
	other_form_instanceid : "", // 需要打开的word文档所在的流程的cc_form_instanceid
	other_djid : "", // 需要打开的word文档所在的表单id
	other_officeid : "", // 需要打开的非流程中的word文档id，即wordid
	other_aswfdoc : "false", // 是否将打开的文档作为当前流程的文档来运行。
	allowLoad : "true", // office文档的属性是否设置齐全，只有设置齐全才能加载。默认允许加载。
	moduleId : "", // 模块ID(事项ID)
	menuModuleId : "", // 菜单模块ID
	debugModel : true,// 优化后的debug模式
	newccid : false,
// 是否产生了新的cc_form_instanceid
	login_orgid : "", //当前流程处理人使用的机构id，用户有兼职（一个用户属于多个机构）的情况，添加后流程中的用户名将变为格式：用户名#机构id
	workflow_orgid : "" //当前流程的处理机构，如果设置了机构id值，则后续活动都将对非动态分配用户进行过滤，只有此机构下的用户才行。
};

// =====20100223添加,js字符串连接优化封装。
function StringBuffer() {
	this._strs = new Array;
}
StringBuffer.prototype.append = function(str) {
	this._strs.push(str);
	return this;
};
StringBuffer.prototype.toString = function() {
	return this._strs.join("");
};

// ================
// ===================================20080523添加,对iWebOffice控件的全局变量赋初值
fcpubdata.mAppName = location.pathname;
if (fcpubdata.mAppName.indexOf('/') == 0)
	fcpubdata.mAppName = location.pathname.substring(1);
fcpubdata.mAppName = fcpubdata.mAppName.substring(0, fcpubdata.mAppName
		.indexOf("/"));
// ===字符串连接优化前代码
fcpubdata.mServerUrl = location.protocol + "//" + location.host + "/"
		+ fcpubdata.mAppName + "/servlet/officeServer";
fcpubdata.mWebOfficeRoot = location.protocol + "//" + location.host + "/"
		+ fcpubdata.mAppName + "/iWebOffice2006/";
// ===========================================================================

var tmp12345 = GetUrlFirstPart();
fcpubdata.servletPath = tmp12345 + fcpubdata.servletPath;
fcpubdata.Path = tmp12345 + fcpubdata.Path;
var fcpubvar = {
	DsMain : "DsMain",
	pubSession : "null",
	AutoAddField : "no",
	pubdatasrc : "",
	topicsrc : ""
};

// add by zuojian.xiang 2009-4-15
// for : 一个流程多个流程word
var creator_pt_webOfficeId;

// ===================================20080419添加
function GetBillType() {
	var oXml = SetDomFile(fcpubdata.Path + "/fceform/billtype.xml");
	var sRet = new StringBuffer();;
	if (oXml.documentElement != null) {
		var l = oXml.documentElement.childNodes.length - 1;
		for (var i = 0;i < l; i++) {
			var stext = oXml.documentElement.childNodes(i).childNodes(1).text;
			var svalue = oXml.documentElement.childNodes(i).childNodes(2).text;
			var spath = oXml.documentElement.childNodes(i).childNodes(3).text;
			var sextname = oXml.documentElement.childNodes(i).childNodes(4).text;
			sRet.append("<option value=\"").append(svalue)
					.append("\" extname=\"").append(sextname)
					.append("\" path=\"").append(spath).append("\">")
					.append(stext).append("</option>");
		}
	}
	return sRet.toString();
}
/*
 * 优化表单速度，取消从文件中读取类型，使用默认的ZW var sHtml=GetBillType(); //读取billtype.xml中的记录.
 * fcpubdata.djtype =
 * sHtml.substring(sHtml.indexOf('value=')+7,sHtml.indexOf('value=')+9);
 */
fcpubdata.openDjUrl = new StringBuffer();
fcpubdata.openDjUrl.append(location.protocol).append("//")
		.append(location.host).append(fcpubdata.Path)
		.append("/fceform/common/djframe.htm?djtype=").append(fcpubdata.djtype)
		.append("&djsn=");
// ======================================完

// ====================================20080426添加，获取url的cc_form_instanceid,然后在SetAuthority()中设置session变量cc_form_showid
/*
 * var cc_form_showid; var cur_search = location.search; var my_arr =new
 * Array();
 * 
 * if(cur_search.indexOf("&")!=-1){ my_arr = cur_search.split("&"); for(var
 * i=0;i<my_arr.length;i++){ if(my_arr[i].indexOf("cc_form_instanceid")!=-1){
 * if(my_arr[i].indexOf("=")+1 == my_arr[i].length){ cc_form_showid = ""; }else{
 * cc_form_showid =
 * my_arr[i].substring(my_arr[i].indexOf("=")+1,my_arr[i].length); } break; } }
 * }else if(cur_search.indexOf("cc_form_instanceid")!=-1){
 * if(cur_search.indexOf("=")+1==cur_search.length){ cc_form_showid = ""; }else{
 * cc_form_showid =
 * cur_search.substring(cur_search.indexOf("=")+1,cur_search.length); } }
 */
// 获得url后面的某个参数的值。
function creator_getQueryString(item) {
	var svalue = location.search.match(new RegExp(new StringBuffer()
			.append("[\?\&]").append(item).append("=([^\&]*)(\&?)").toString(),
			"i"));
	return svalue ? svalue[1] : svalue;
}

var oid = creator_getQueryString("oid");
if (IsSpace(oid)) {
	oid = "";
}
var djid = creator_getQueryString("djid");
// modified by zhou.luo 2008-10-24
// 如果没有传递djid，就把文件名作为djid(仅限eformsys/jxc/dj/下的表单)
if (IsSpace(djid)) {
	djid = location.pathname.substring(location.pathname.lastIndexOf("/") + 1,
			location.pathname.lastIndexOf("."));
	if (location.pathname.indexOf("eformsys/jxc/dj/" + djid) == -1) {
		djid = "";
	}
}
var workflowId = creator_getQueryString("workflowId");
if (IsSpace(workflowId)) {
	workflowId = "";
}
var wf_isReadOnly = creator_getQueryString("operType");
if (IsSpace(wf_isReadOnly)) {
	wf_isReadOnly = "";
}
var noneWorkflowWordId = creator_getQueryString("wordid");

if (IsSpace(noneWorkflowWordId)) {
	noneWorkflowWordId = "";
} else {
	noneWorkflowWordId = "w" + noneWorkflowWordId;
}

var cc_form_showid = creator_getQueryString("cc_form_instanceid");
// added by zhou.luo 2008-10-22
// 当没有传递cc_form_instanceid时，cc_form_showid取到的值为null，在此赋值为"undefined".
if (cc_form_showid == null) {
	cc_form_showid = "undefined";
}
var other_form_instanceid = creator_getQueryString("other_form_instanceid");
var other_djid = creator_getQueryString("other_djid");
var other_officeid = creator_getQueryString("other_officeid");
var other_aswfdoc = creator_getQueryString("other_aswfdoc");
if (IsSpace(other_form_instanceid)) {
	other_form_instanceid = "";
}
if (IsSpace(other_djid)) {
	other_djid = "";
}
if (IsSpace(other_officeid)) {
	other_officeid = "";
} else {
	other_officeid = "w" + other_officeid;
}
if (IsSpace(other_aswfdoc)) {
	other_aswfdoc = "false";
}

fcpubdata.oid = oid;
fcpubdata.djid = djid;
fcpubdata.workflowId = workflowId;
fcpubdata.wf_isReadOnly = wf_isReadOnly;
fcpubdata.cc_form_showid = cc_form_showid;
fcpubdata.cc_form_instanceid = cc_form_showid;
fcpubdata.noneWorkflowWordId = noneWorkflowWordId;

fcpubdata.other_form_instanceid = other_form_instanceid;
fcpubdata.other_djid = other_djid;
fcpubdata.other_officeid = other_officeid;
fcpubdata.other_aswfdoc = other_aswfdoc;
// 查询css目录样式 赋值

// ===========================================完

// ===============================20080424添加，通过djid获取jsp文件的路径
function getFormUrlByDjid(myDjid) {
	var formUrl = new StringBuffer().append(location.protocol).append("//")
			.append(location.host).append(fcpubdata.Path).append("/")
			.append(fcpubdata.savePath).append(myDjid).append(".")
			.append(fcpubdata.extname);
	return formUrl;
}

// 20080612新增，根据表单id获取打开表单的路径。
function getOpenUrlByDjid(myDjid) {
	var formUrl = fcpubdata.openDjUrl + myDjid;
	return formUrl;
}
// ========================================================
(function() {
	if(!((typeof(__dj_win_flag__) == "boolean") && __dj_win_flag__)){
		var head = document.getElementsByTagName("head")[0];	
		var script = document.createElement("script");
		script.src = fcpubdata.Path + "/fceform/js/fcvalid.js";
		head.appendChild(script);
	}
})();
function GetUrlFirstPart() {
	var tmp12345 = location.pathname;
	tmp12345 = tmp12345.substring(0, tmp12345.indexOf("/", 1));
	if (tmp12345.substring(0, 1) != "/")
		tmp12345 = "/" + tmp12345;
	return tmp12345;
}
function $(elementID) {
	return document.getElementById(elementID);
}
// added by zhiwu.chen in 2006-6-16
// 获得对象的值 并做单引号做了处理
function $value(elementID) {
	var str = document.getElementById(elementID).value;
	return RepStr(str, "'", "''");
}
String.prototype.trimLeft = function() {
	return this.replace(/^\s*/, "");
}
String.prototype.trimRight = function() {
	return this.replace(/\s*$/, "");
}
String.prototype.replaceAllSingleQuotes = function() {
	var re = /\'/g;
	return this.replace(re, '"');
}
String.prototype.trim = function() {
	return this.trimRight().trimLeft();
}
Array.prototype.add = function(item) {
	this.push(item);
}
Array.prototype.addRange = function(items) {
	var length = items.length;
	if (length != 0) {
		for (var index = 0;index < length; index++) {
			this.push(items[index]);
		}
	}
}
Array.prototype.clear = function() {
	if (this.length > 0) {
		this.splice(0, this.length);
	}
}
Array.prototype.clone = function() {
	var clonedArray = [];
	var length = this.length;
	for (var index = 0;index < length; index++) {
		clonedArray[index] = this[index];
	}
	return clonedArray;
}
Array.prototype.contains = function(item) {
	var index = this.indexOf(item);
	return (index >= 0);
}
Array.prototype.dequeue = function() {
	return this.shift();
}
Array.prototype.indexOf = function(item) {
	var length = this.length;
	if (length != 0) {
		for (var index = 0;index < length; index++) {
			if (this[index] == item) {
				return index;
			}
		}
	}
	return -1;
}
Array.prototype.insert = function(index, item) {
	this.splice(index, 0, item);
}
Array.prototype.queue = function(item) {
	this.push(item);
}
Array.prototype.remove = function(item) {
	var index = this.indexOf(item);
	if (index >= 0) {
		this.splice(index, 1);
	}
}
Array.prototype.removeAt = function(index) {
	this.splice(index, 1);
}
StringBuilder = function(initialText) {
	var _parts = new Array();
	if ((typeof(initialText) == 'string') && (initialText.length != 0)) {
		_parts.add(initialText);
	}
	this.append = function(text) {
		if ((text == null) || (typeof(text) == 'undefined')) {
			return;
		}
		if ((typeof(text) == 'string') && (text.length == 0)) {
			return;
		}
		_parts.add(text);
	}
	this.appendLine = function(text) {
		this.append(text);
		_parts.add('\r\n');
	}
	this.clear = function() {
		_parts.clear();
	}
	this.isEmpty = function() {
		return (_parts.length == 0);
	}
	this.toString = function(delimiter) {
		delimiter = delimiter || '';
		return _parts.join(delimiter);
	}
}
var oPubPopup = window.createPopup();
var oPubPopupBody = oPubPopup.document.body;
function ShowWait(displaystr) {
	if (displaystr == "end") {
		oPubPopup.hide();
	} else {
		if (event != null) {
			if (event.srcElement != null) {
				if (event.srcElement.tagName.toUpperCase() == "SELECT")
					return;
			}
		}
		var strHTML = new StringBuffer();
		strHTML
				.append("<TABLE WIDTH=100% BORDER=0 CELLSPACING=0 CELLPADDING=0><TR><td width=0%></td>");
		strHTML
				.append("<TD bgcolor=#ff9900><TABLE WIDTH=100% height=60 BORDER=0 CELLSPACING=2 CELLPADDING=0>");
		strHTML.append("<TR><td bgcolor=#eeeeee align=center>")
				.append(displaystr).append("</td></tr></table></td>");
		strHTML.append("<td width=0%></td></tr></table>");
		oPubPopupBody.innerHTML = strHTML.toString();
		var iwidth = 300;
		var iheight = 60;
		var ileft = (screen.availWidth - iwidth) / 2;
		var itop = (screen.availHeight - iheight) / 2;
		oPubPopup.show(ileft, itop, iwidth, iheight);
	}
}
function SaveUserData(Main, Sub, strContent) {
	try {
		userData = parent.pubdata.oForm.oInput;
	} catch (e) {
		return;
	}
	userData.setAttribute(Main + userData.value, strContent);
	userData.save(Sub + userData.value);
}
function LoadUserData(Main, Sub) {
	try {
		userData = parent.pubdata.oForm.oInput;
	} catch (e) {
		return "";
	}
	userData.load(Sub + userData.value);
	var sTmp = userData.getAttribute(Main + userData.value);
	if (sTmp == null) {
		sTmp = "";
	}
	return sTmp;
}
function num(str1) {
	var s1 = trim(str1);
	var f1 = parseFloat(s1);
	if (isNaN(f1)) {
		return 0;
	}
	return f1;
}
function ToInt(str1) {
	var s1 = trim(str1);
	if (s1.charAt(0) == "0")
		s1 = s1.substring(1, s1.length);
	var f1 = parseInt(s1);
	if (isNaN(f1)) {
		return 0;
	}
	return f1;
}
function ContDec(sValue, sPointNum) {
	var dblValue = parseFloat(sValue);
	if (isNaN(dblValue)) {
		return sValue;
	}
	var iPointNum = parseInt(sPointNum);
	if (isNaN(iPointNum)) {
		iPointNum = 0;
	}
	if (iPointNum > 9) {
		iPointNum = 9;
	}
	if (iPointNum < 0) {
		iPointNum = 0;
	}
	var dbl1 = Math.round(dblValue * Math.pow(10, iPointNum))
			/ Math.pow(10, iPointNum);
	var s1 = dbl1 + "";
	var num0 = 0;
	if (s1.indexOf(".") == -1) {
		num0 = iPointNum;
	} else {
		var num1 = s1.length - s1.indexOf(".") - 1;
		if (num1 < iPointNum) {
			num0 = iPointNum - num1;
		}
	}
	if (num0 > 0) {
		var s2 = "000000000000000";
		if (num0 == iPointNum) {
			s1 = s1 + "." + s2.substring(0, num0);
		} else {
			s1 = s1 + s2.substring(0, num0);
		}
	}
	return s1;
}
function isTrue(svalue) {
	if (svalue == false || svalue == "false" || svalue == "False"
			|| svalue == "no" || svalue == 0 || svalue == "0"
			|| svalue == "off" || svalue == "否" || svalue == "假"
			|| svalue == "")
		return false;
	else
		return true;
}
function isSpace(strMain) {
	var strComp = strMain;
	try {
		if (strComp == "　" || strComp == "" || strComp == " "
				|| strComp == null || strComp == "null" || strComp.length == 0
				|| typeof strMain == "undefined" || strMain == "undefined") {
			return true;
		} else {
			return false;
		}
	} catch (e) {
		return false;
	}
}
function trim(strMain) {
	if (strMain == null) {
		return "";
	}
	strMain = strMain + "";
	return strMain.trim();
}
function repStr(mainStr, findStr, replaceStr) {
	if (typeof mainStr == "undefined" || mainStr == null) {
		return "";
	}
	var convertedString = mainStr.split(findStr);
	convertedString = convertedString.join(replaceStr);
	return convertedString;
}
function repNewLine(sRun) {
	return RepStr(sRun, "\r\n", "&#13;&#10;");
}
function unRepNewLine(sRun) {
	return RepStr(sRun, "&#13;&#10;", "\r\n");
}
function repXml(sRun) {
	sRun = RepStr(sRun, "&", "&amp;");
	sRun = RepStr(sRun, ">", "&gt;");
	sRun = RepStr(sRun, "<", "&lt;");
	return sRun;
}
function UnRepXml(sSql) {
	sSql = RepStr(sSql, "&lt;", "<");
	sSql = RepStr(sSql, "&gt;", ">");
	sSql = RepStr(sSql, "&amp;", "&");
	return sSql;
}
function ChangeToBig(value) {
	var intFen, i;
	var strArr, strCheck, strFen, strDW, strNum, strBig, strNow;
	if (trim(value) == "") {
		return "零";
	}
	if (isNaN(value)) {
		strErr = "数据" + value + "非法！";
		alert(strErr);
		return "";
	}
	strCheck = value + ".";
	strArr = strCheck.split(".");
	strCheck = strArr[0];
	var len = strCheck.length;
	if (len > 12) {
		strErr = "数据" + value + "过大，无法处理！";
		alert(strErr);
		return "";
	}
	try {
		i = 0;
		strBig = "";
		var s00 = "00";
		var svalue = value + "";
		var ipos = svalue.indexOf(".");
		var iiLen = svalue.length;
		if (ipos < 0) {
			strFen = svalue + "00";
		} else if (ipos == iiLen - 2) {
			strFen = svalue.substring(0, iiLen - 2)
					+ svalue.substring(iiLen - 1, iiLen) + "0";
		} else if (ipos == iiLen - 3) {
			strFen = svalue.substring(0, iiLen - 3)
					+ svalue.substring(iiLen - 2, iiLen);
		} else {
			strFen = svalue.substring(0, ipos)
					+ svalue.substring(ipos + 1, ipos + 3);
		}
		intFen = strFen.length;
		strArr = strFen.split("");
		while (intFen != 0) {
			i = i + 1;
			switch (i) {
				case 1 :
					strDW = "分";
					break;
				case 2 :
					strDW = "角";
					break;
				case 3 :
					strDW = "元";
					break;
				case 4 :
					strDW = "拾";
					break;
				case 5 :
					strDW = "佰";
					break;
				case 6 :
					strDW = "仟";
					break;
				case 7 :
					strDW = "万";
					break;
				case 8 :
					strDW = "拾";
					break;
				case 9 :
					strDW = "佰";
					break;
				case 10 :
					strDW = "仟";
					break;
				case 11 :
					strDW = "亿";
					break;
				case 12 :
					strDW = "拾";
					break;
				case 13 :
					strDW = "佰";
					break;
				case 14 :
					strDW = "仟";
					break;
			}
			switch (strArr[intFen - 1]) {
				case "1" :
					strNum = "壹";
					break;
				case "2" :
					strNum = "贰";
					break;
				case "3" :
					strNum = "叁";
					break;
				case "4" :
					strNum = "肆";
					break;
				case "5" :
					strNum = "伍";
					break;
				case "6" :
					strNum = "陆";
					break;
				case "7" :
					strNum = "柒";
					break;
				case "8" :
					strNum = "捌";
					break;
				case "9" :
					strNum = "玖";
					break;
				case "0" :
					strNum = "零";
					break;
			}
			strNow = strBig.split("");
			if ((i == 1) && (strArr[intFen - 1] == "0")) {
				strBig = "整";
			} else if ((i == 2) && (strArr[intFen - 1] == "0")) {
				if (strBig != "整")
					strBig = "零" + strBig;
			} else if ((i == 3) && (strArr[intFen - 1] == "0")) {
				strBig = "元" + strBig;
			} else if ((i < 7) && (i > 3) && (strArr[intFen - 1] == "0")
					&& (strNow[0] != "零") && (strNow[0] != "元")) {
				strBig = "零" + strBig;
			} else if ((i < 7) && (i > 3) && (strArr[intFen - 1] == "0")
					&& (strNow[0] == "零")) {
			} else if ((i < 7) && (i > 3) && (strArr[intFen - 1] == "0")
					&& (strNow[0] == "元")) {
			} else if ((i == 7) && (strArr[intFen - 1] == "0")) {
				strBig = "万" + strBig;
			} else if ((i < 11) && (i > 7) && (strArr[intFen - 1] == "0")
					&& (strNow[0] != "零") && (strNow[0] != "万")) {
				strBig = "零" + strBig;
			} else if ((i < 11) && (i > 7) && (strArr[intFen - 1] == "0")
					&& (strNow[0] == "万")) {
			} else if ((i < 11) && (i > 7) && (strArr[intFen - 1] == "0")
					&& (strNow[0] == "零")) {
			} else if ((i < 11) && (i > 8) && (strArr[intFen - 1] != "0")
					&& (strNow[0] == "万") && (strNow[2] == "仟")) {
				strBig = strNum + strDW + "万零"
						+ strBig.substring(1, strBig.length);
			} else if (i == 11) {
				if ((strArr[intFen - 1] == "0") && (strNow[0] == "万")
						&& (strNow[2] == "仟")) {
					strBig = "亿" + "零" + strBig.substring(1, strBig.length);
				} else if ((strArr[intFen - 1] == "0") && (strNow[0] == "万")
						&& (strNow[2] != "仟")) {
					strBig = "亿" + strBig.substring(1, strBig.length);
				} else if ((strNow[0] == "万") && (strNow[2] == "仟")) {
					strBig = strNum + strDW + "零"
							+ strBig.substring(1, strBig.length);
				} else if ((strNow[0] == "万") && (strNow[2] != "仟")) {
					strBig = strNum + strDW
							+ strBig.substring(1, strBig.length);
				} else {
					strBig = strNum + strDW + strBig;
				}
			} else if ((i < 15) && (i > 11) && (strArr[intFen - 1] == "0")
					&& (strNow[0] != "零") && (strNow[0] != "亿")) {
				strBig = "零" + strBig;
			} else if ((i < 15) && (i > 11) && (strArr[intFen - 1] == "0")
					&& (strNow[0] == "亿")) {
			} else if ((i < 15) && (i > 11) && (strArr[intFen - 1] == "0")
					&& (strNow[0] == "零")) {
			} else if ((i < 15) && (i > 11) && (strArr[intFen - 1] != "0")
					&& (strNow[0] == "零") && (strNow[1] == "亿")
					&& (strNow[3] != "仟")) {
				strBig = strNum + strDW + strBig.substring(1, strBig.length);
			} else if ((i < 15) && (i > 11) && (strArr[intFen - 1] != "0")
					&& (strNow[0] == "零") && (strNow[1] == "亿")
					&& (strNow[3] == "仟")) {
				strBig = strNum + strDW + "亿零"
						+ strBig.substring(2, strBig.length);
			} else {
				strBig = strNum + strDW + strBig;
			}
			strFen = strFen.substring(0, intFen - 1);
			intFen = strFen.length;
			strArr = strFen.split("");
		}
		if (strBig == "整") {
			strBig = "零";
		}
		return strBig;
	} catch (err) {
		return "";
	}
}
function SqlToField(sql, dbName) {
	var sXml = new StringBuffer().append("<No>").append(RepXml(sql))
			.append("</No>").toString();
	var temp = typeof(dbName) == 'undefined' ? "" : ("&dbName=" + dbName);
	// alert(location.protocol+"//"+location.host + fcpubdata.servletPath +
	// "/WebBill"+fcpubdata.dotnetVersion+"?SqlToField"+sXml);
	var retX = SendHttp(new StringBuffer().append(location.protocol)
			.append("//").append(location.host).append(fcpubdata.servletPath)
			.append("/WebBill").append(fcpubdata.dotnetVersion)
			.append("?key=SqlToField").append(temp).toString(), sXml);
	
	return retX;
}
function RepOpenSql(sql, slikevalue) {
	if (isSpace(sql)) {
		return "";
	}
	if (fcpubdata.databaseTypeName == "mysql") {
		sql = trim(sql);
		if (sql.substring(0, 4).toUpperCase() == "EXEC") {
			alert("因mysql数据库不支持存储过程!故无法使用此功能!");
			return sql;
		}
	}
	sql = repStr(sql, "\r\n", " ");
	var posStart = 0;
	var posEnd = 0;
	var ret = "";
	var re = new RegExp();
	re.compile("(:[a-zA-Z0-9_\.\$]*)([), =+%']|$|\s)", "gi");
	var sInput = sql;
	var nextpoint = 0;
	while ((arr = re.exec(sInput)) != null) {
		posEnd = arr.index;
		var s1 = RegExp.$1;
		var sRep = "";
		if (s1 == ":get_userid") {
			sRep = "'" + trim(getuser()) + "'";
		} else if (s1 == ":v_get") {
			sRep = slikevalue;
		} else if (s1 == ":get_date") {
			sRep = "'" + getdate() + "'";
		} else if (s1 == ":get_time") {
			sRep = "'" + getTime() + "'";
		} else if (s1 == ":get_datetime") {
			sRep = "'" + getdatetime() + "'";
		} else if (s1.substring(0, 2) == ":$") {
			sRep = eval(s1.substring(2, s1.length));
			sRep = sRep;
		} else {
			var arr2 = s1.split(".");
			if (arr2.length == 1) {
				if (s1 == ":pubdjbh") {
					sRep = "'" + pubdjbh + "'";
				} else {
					sRep = s1;
				}
			} else {
				var stmp1 = arr2[0].substring(1, arr2[0].length);
				var oDs = eval(stmp1);
				if (oDs != null) {
					if (oDs.Empty == "null") {
						sRep = "''";
					} else {
						try {
							sRep = "'" + oDs.Fields.Field[arr2[1]].Value + "'";
						} catch (E) {
							alert(stmp1 + "中不存在字段" + arr2[1]);
							sRep = "'" + "'";
						}
					}
				}
			}
		}
		ret += sql.substring(posStart + nextpoint, posEnd + nextpoint);
		ret += sRep;
		posStart = arr.index + s1.length;
	}
	if (ret == "") {
		ret = sql;
	} else if (posStart <= sql.length) {
		ret += sql.substring(posStart, sql.length);
	}
	if (isSpace(ret)) {
		ret = "";
	}
	return ret;
}
function inserts(sSql, dbName) {
	sSql = RepStr(sSql, "&", "&amp;");
	var djid = fcpubdata.djid;
	// alert("inserts djid:"+djid);
	var temp = typeof(dbName) == 'undefined' ? "" : ("&dbName=" + dbName);
	var retX = SendHttp(new StringBuffer().append(location.protocol)
			.append("//").append(location.host).append(fcpubdata.servletPath)
			.append("/WebBill").append(fcpubdata.dotnetVersion)
			.append("?inserts&key=inserts&djid=").append(djid).append(temp)
			.toString(), sSql);
	retX = bindccid(retX);
	return retX;
}
function fc_insert(sSql, dbName) {
	sSql = repXml(sSql);
	var temp = typeof(dbName) == 'undefined' ? "" : ("&dbName=" + dbName);
	if (fcpubdata.databaseTypeName == "mysql"
			&& sSql.substring(0, 4).toUpperCase() == "EXEC") {
		alert("因mysql数据库不支持存储过程!故无法使用此功能!");
		return "";
	}
	var sXml = new StringBuffer().append("<No>").append(sSql).append("</No>")
			.toString();
	var retX = SendHttp(new StringBuffer().append(location.protocol)
			.append("//").append(location.host).append(fcpubdata.servletPath)
			.append("/WebBill").append(fcpubdata.dotnetVersion)
			.append("?fc_insert&key=fc_insert").append(temp).toString(), sXml);
	retX = bindccid(retX);
	return retX;
}
/*
 * 20080328新增，用于使用tableinfo生成的主键。
 */
function creator_insert(sSql) {
	if (fcpubdata.databaseTypeName == "mysql"
			&& sSql.substring(0, 4).toUpperCase() == "EXEC") {
		alert("因mysql数据库不支持存储过程!故无法使用此功能!");
		return "";
	}
	var sXml = new StringBuffer().append("<No>").append(sSql).append("</No>")
			.toString();
	var retX = SendHttp(new StringBuffer().append(location.protocol)
			.append("//").append(location.host).append(fcpubdata.servletPath)
			.append("/DbTools").append(fcpubdata.dotnetVersion)
			.append("?creator_insert").toString(), sXml);
	return retX;
}
function creator_inserts(sSql) {
	if (fcpubdata.databaseTypeName == "mysql"
			&& sSql.substring(0, 4).toUpperCase() == "EXEC") {
		alert("因mysql数据库不支持存储过程!故无法使用此功能!");
		return "";
	}
	var sXml = new StringBuffer().append("").append(sSql).append("")
			.toString();
	var retX = SendHttp(new StringBuffer().append(location.protocol)
			.append("//").append(location.host).append(fcpubdata.servletPath)
			.append("/DbTools").append(fcpubdata.dotnetVersion)
			.append("?creator_inserts").toString(), sXml);
	return retX;
}
/* 20080328新增，用于更新表记录 */
function creator_update(sSql) {
	if (fcpubdata.databaseTypeName == "mysql"
			&& sSql.substring(0, 4).toUpperCase() == "EXEC") {
		alert("因mysql数据库不支持存储过程!故无法使用此功能!");
		return "";
	}
	var sXml = new StringBuffer().append("<No>").append(sSql).append("</No>")
			.toString();
	var retX = SendHttp(new StringBuffer().append(location.protocol)
			.append("//").append(location.host).append(fcpubdata.servletPath)
			.append("/DbTools").append(fcpubdata.dotnetVersion)
			.append("?creator_update").toString(), sXml);
	return retX;
}

/* 20080407新增，用于在eform中设置session */
function creator_setSession(sName, sValue) {
	var sXml = new StringBuffer().append("<No>").append(sName).append("=")
			.append(sValue).append("</No>").toString();
	var retX = SendHttp(new StringBuffer().append(location.protocol)
			.append("//").append(location.host).append(fcpubdata.servletPath)
			.append("/EformSessionManager").append(fcpubdata.dotnetVersion)
			.append("?creator_setSession").toString(), sXml);
	return retX;
}

/* 20080408新增，用于在eform中获取session */
function creator_getSession(sName) {
	var sXml = new StringBuffer().append("<No>").append(sName).append("</No>")
			.toString();
	var retX = SendHttp(new StringBuffer().append(location.protocol)
			.append("//").append(location.host).append(fcpubdata.servletPath)
			.append("/EformSessionManager").append(fcpubdata.dotnetVersion)
			.append("?creator_getSession").toString(), sXml);
	return retX;
}

/*
 * modified by zhou.luo 2008-11-03
 * 增加一个djid的参数传递到后台去，不通过session变量：cc_form_djid来传递
 */
/* 20080524新增，用于在页面上调用后台生成一个新的cc_form_instanceid */
function getNewCc_form_instanceid(type, noCtrlInsid) {
	var sXml = new StringBuffer().append("<No>").append(type)
			.append("</No><No>").append(noCtrlInsid).append("</No><No>")
			.append(fcpubdata.djid).append("</No>").toString();
	var retX = SendHttp(new StringBuffer().append(location.protocol)
			.append("//").append(location.host).append(fcpubdata.servletPath)
			.append("/DbTools").append(fcpubdata.dotnetVersion)
			.append("?getNewCc_form_instanceid").toString(), sXml);
	return retX;
}


/* 用于读取系统管理的配置文件config-manager.xml */
function creator_getConfigValue(sName) {
	var sXml = new StringBuffer().append("<No>").append(sName).append("</No>")
			.toString();
	var retX = SendHttp(new StringBuffer().append(location.protocol)
			.append("//").append(location.host).append(fcpubdata.servletPath)
			.append("/EformSessionManager").append(fcpubdata.dotnetVersion)
			.append("?creator_getConfigValue").toString(), sXml);
	return retX;
}

/* 判断平台中控制日志的开发是否被打开 */
function creator_islogopen() {
	// alert("进入creator_islogopen");
	var sXml = "<No></No>";
	var retX = SendHttp(new StringBuffer().append(location.protocol)
			.append("//").append(location.host).append(fcpubdata.servletPath)
			.append("/IsLog").toString(), sXml);
	return retX;
}

/* 20080610新增，获取上下文路径 */
function creator_getContextPath() {
	var sXml = "<No></No>";
	var retX = SendHttp(new StringBuffer().append(location.protocol)
			.append("//").append(location.host).append(fcpubdata.servletPath)
			.append("/DbTools").append(fcpubdata.dotnetVersion)
			.append("?creator_getContextPath").toString(), sXml);
	return retX;
}

/* 20080616新增，根据表单id获取表单所属的业务类别id */
function creator_getEformClass(djid) {
	var sXml = new StringBuffer().append("<No>").append(djid).append("</No>")
			.toString();
	var retX = SendHttp(new StringBuffer().append(location.protocol)
			.append("//").append(location.host).append(fcpubdata.servletPath)
			.append("/DbTools").append(fcpubdata.dotnetVersion)
			.append("?getEformClass").toString(), sXml);
	return retX;
}

/* 20080618新增，根据表单备注获取表单的id，如果有多个表单具有相同的备注，则返回这些表单id，以逗号隔开 */
function creator_getDjidByRemark(remark) {
	var sXml = new StringBuffer().append("<No>").append(remark).append("</No>")
			.toString();
	var retX = SendHttp(new StringBuffer().append(location.protocol)
			.append("//").append(location.host).append(fcpubdata.servletPath)
			.append("/DbTools").append(fcpubdata.dotnetVersion)
			.append("?getDjidByRemark").toString(), sXml);
	return retX;
}

/* 20080618新增，根据表单id获得表单备注 */
function creator_getRemarkByDjid(djid) {
	var sXml = new StringBuffer().append("<No>").append(djid).append("</No>")
			.toString();
	var retX = SendHttp(new StringBuffer().append(location.protocol)
			.append("//").append(location.host).append(fcpubdata.servletPath)
			.append("/DbTools").append(fcpubdata.dotnetVersion)
			.append("?getRemarkByDjid").toString(), sXml);
	return retX;
}

/*
 * 20080711新增，获取控件的实例id modified in 2008-09-22
 * 添加一个ctrl_isBindForm参数：控件是否绑定表单，只实现了office控件 modified by zhou.luo 2008-11-03
 * 添加一个参数djid，从request中传递过去，而不使用session变量cc_form_djid。
 */

function creator_getCtrlInsid(ctrlid, ctrl_isBindForm) {
	if (IsSpace(ctrl_isBindForm)) {
		ctrl_isBindForm = "";
	}
	var sXml = new StringBuffer().append("<No>").append(ctrlid)
			.append("</No><No>").append(ctrl_isBindForm).append("</No><No>")
			.append(fcpubdata.djid).append("</No>").toString();
	var retX = SendHttp(new StringBuffer().append(location.protocol)
			.append("//").append(location.host).append(fcpubdata.servletPath)
			.append("/DbTools").append(fcpubdata.dotnetVersion)
			.append("?getControlInstanceid").toString(), sXml);
	return retX;
}

/* 20080716新增，根据表单实例id获取该表单是否保存表单历史记录。 */
function creator_getEnableHistory(cc_form_instanceid) {
	var sXml = new StringBuffer().append("<No>").append(cc_form_instanceid)
			.append("</No>").toString();
	var retX = SendHttp(new StringBuffer().append(location.protocol)
			.append("//").append(location.host).append(fcpubdata.servletPath)
			.append("/DbTools").append(fcpubdata.dotnetVersion)
			.append("?getEformHistory").toString(), sXml);
	return retX;
}

/* 20080717新增，得到一个新的控件实例id */
function creator_getNewCtrlInsid(ctrlType) {
	var sXml = new StringBuffer().append("<No>").append(ctrlType)
			.append("</No>").toString();
	var retX = SendHttp(new StringBuffer().append(location.protocol)
			.append("//").append(location.host).append(fcpubdata.servletPath)
			.append("/DbTools").append(fcpubdata.dotnetVersion)
			.append("?getNewCtrlInsid").toString(), sXml);
	return retX;
}

// 20090514
function messageisOpen(msgType) {
	var sXml = new StringBuffer().append("<No>").append(msgType)
			.append("</No>").toString();
	var retX = SendHttp(new StringBuffer().append(location.protocol)
			.append("//").append(location.host).append(fcpubdata.servletPath)
			.append("/MessageServlet").append(fcpubdata.dotnetVersion)
			.append("?messageisOpen").toString(), encodeURI(sXml));
	return retX;
}

/* 20080721新增，基本的发送消息函数 */
function creator_sendMessage(from, receivers, title, content, messageType) {
	var sXml = new StringBuffer().append("<No>").append(from)
			.append("</No><No>").append(receivers).append("</No><No>")
			.append(title).append("</No><No>").append(content)
			.append("</No><No>").append(messageType).append("</No>").toString();
	var retX = SendHttp(new StringBuffer().append(location.protocol)
			.append("//").append(location.host).append(fcpubdata.servletPath)
			.append("/MessageServlet").append(fcpubdata.dotnetVersion)
			.append("?key=sendMessage").toString(), encodeURI(sXml));
	return retX;
}

/* 20080721新增，带businessId的发送消息函数 */
function creator_sendMessage_businessId(from, receivers, title, content,
		messageType, businessId) {
	var sXml = new StringBuffer().append("<No>").append(from)
			.append("</No><No>").append(receivers).append("</No><No>")
			.append(title).append("</No><No>").append(content)
			.append("</No><No>").append(messageType).append("</No></No>")
			.append(businessId).append("</No>").toString();
	var retX = SendHttp(new StringBuffer().append(location.protocol)
			.append("//").append(location.host).append(fcpubdata.servletPath)
			.append("/MessageServlet").append(fcpubdata.dotnetVersion)
			.append("?sendMessage_businessId").toString(), encodeURI(sXml));
	return retX;
}

/* 20080721新增，带rtx详细参数的发送消息函数 */
function creator_sendMessage_rtx(from, receivers, title, content, notifyType,
		delayTime) {
	var sXml = new StringBuffer().append("<No>").append(from)
			.append("</No><No>").append(receivers).append("</No><No>")
			.append(title).append("</No><No>").append(content)
			.append("</No><No>rtx</No><No>").append(notifyType)
			.append("</No><No>").append(delayTime).append("</No>").toString();
	var retX = SendHttp(new StringBuffer().append(location.protocol)
			.append("//").append(location.host).append(fcpubdata.servletPath)
			.append("/MessageServlet").append(fcpubdata.dotnetVersion)
			.append("?sendMessage_rtx").toString(), encodeURI(sXml));
	return retX;
}

/* 20080721新增，带所有参数的发送消息函数 */
function creator_sendMessage_full(from, receivers, title, content, messageType,
		businessId, notifyType, delayTime) {
	var sXml = new StringBuffer().append("<No>").append(from)
			.append("</No><No>").append(receivers).append("</No><No>")
			.append(title).append("</No><No>").append(content)
			.append("</No><No>").append(messageType).append("</No><No>")
			.append(businessId).append("</No><No>").append(notifyType)
			.append("</No><No>").append(delayTime).append("</No>").toString();
	var retX = SendHttp(new StringBuffer().append(location.protocol)
			.append("//").append(location.host).append(fcpubdata.servletPath)
			.append("/MessageServlet").append(fcpubdata.dotnetVersion)
			.append("?sendMessage_full").toString(), encodeURI(sXml));
	return retX;
}

// add by yaohui.luo 2008-9-18
function creator_sendMessage_resource(from, receivers, title, content,
		resourceName) {
	var sXml = new StringBuffer().append("<No>").append(from)
			.append("</No><No>").append(receivers).append("</No><No>")
			.append(title).append("</No><No>").append(content)
			.append("</No><No>").append(resourceName).append("</No>")
			.toString();
	var retX = SendHttp(new StringBuffer().append(location.protocol)
			.append("//").append(location.host).append(fcpubdata.servletPath)
			.append("/MessageServlet").append(fcpubdata.dotnetVersion)
			.append("?sendMessageByResource").toString(), encodeURI(sXml));
	return retX;
}

/* 20080728新增，直接使用手机号发送短消息 */
function creator_sendMessage_mobile(from, receivers, content, businessId) {
	if (/^13\d{9}$/g.test(from) || (/^15\d{9}$/g.test(from))) {

	} else {
		alert("您输入的发送方的手机号码有误，请重新输入！");
		return;
	}
	if (receivers.indexOf(",") > 0) {
		var arr_receivers = new Array();
		arr_receivers = receivers.split(",");
		for (var i = 0;i < arr_receivers.length; i++) {
			if (/^13\d{9}$/g.test(arr_receivers[i])
					|| (/^15\d{9}$/g.test(arr_receivers[i]))) {

			} else {
				alert("您输入的接收方的手机号码有误，请重新输入！");
				return;
			}
		}
	}

	var sXml = new StringBuffer().append("<No>").append(from)
			.append("</No><No>").append(receivers).append("</No><No>")
			.append(content).append("</No><No>").append(businessId)
			.append("</No>").toString();
	var retX = SendHttp(new StringBuffer().append(location.protocol)
			.append("//").append(location.host).append(fcpubdata.servletPath)
			.append("/MessageServlet").append(fcpubdata.dotnetVersion)
			.append("?sendMessage_mobile").toString(), encodeURI(sXml));
	return retX;
}

function fc_select(sSql, PageNo, PageSize, dbName) {
	if (fcpubdata.databaseTypeName == "mysql"
			&& sSql.substring(0, 4).toUpperCase() == "EXEC") {
		alert("因mysql数据库不支持存储过程!故无法使用此功能!");
	}
	var sql1 = RepXml(sSql);
	var sXml = new StringBuffer().append("<No>").append(sql1).append("</No>")
			.append("<No1>").append(PageNo).append("</No1>").append("<No2>")
			.append(PageSize).append("</No2>").toString();
	var temp = IsSpace(dbName) ? "" : ("&dbName=" + dbName);
	var retX = SendHttp(new StringBuffer().append(location.protocol)
			.append("//").append(location.host).append(fcpubdata.servletPath)
			.append("/WebBill").append(fcpubdata.dotnetVersion)
			.append("?key=fc_select").append(temp).toString(), sXml);
	return retX;
}
function curDate() {
	var dDate = new Date();
	var s1 = "" + dDate.getYear();
	var s2 = dDate.getMonth() + 1;
	if (s2 < 10) {
		s2 = "0" + s2;
	} else {
		s2 = "" + s2;
	}
	var s3 = dDate.getDate();
	if (s3 < 10) {
		s3 = "0" + s3;
	} else {
		s3 = "" + s3;
	}
	return s1 + "-" + s2 + "-" + s3;
}
function getdate() {
	if (fcpubdata.databaseTypeName != "sqlserver")
		return curDate();
	var sql = "select convert(varchar(10),getdate(),20) ";
	var s1 = SqlToField(sql);
	return s1;
}
function curTime() {
	var s1 = "";
	var c = ":";
	var d = new Date();
	var iHours = d.getHours();
	var iMinutes = d.getMinutes();
	if (iHours < 10) {
		iHours = "0" + iHours;
	} else {
		iHours = "" + iHours;
	}
	if (iMinutes < 10) {
		iMinutes = "0" + iMinutes;
	} else {
		iMinutes = "" + iMinutes;
	}
	s1 = iHours + c;
	s1 += iMinutes;
	return s1;
}
function curDateTime() {
	var s1 = curDate() + " ";
	var c = ":";
	var d = new Date();
	var iHours = d.getHours();
	var iMinutes = d.getMinutes();
	var iSeconds = d.getSeconds();
	if (iHours < 10) {
		iHours = "0" + iHours;
	} else {
		iHours = "" + iHours;
	}
	if (iMinutes < 10) {
		iMinutes = "0" + iMinutes;
	} else {
		iMinutes = "" + iMinutes;
	}
	if (iSeconds < 10) {
		iSeconds = "0" + iSeconds;
	} else {
		iSeconds = "" + iSeconds;
	}
	s1 += iHours + c;
	s1 += iMinutes + c;
	s1 += iSeconds;
	return s1;
}
function CopyToPub(str) {
	window.clipboardData.setData("Text", str);
}
function Trim(strMain) {
	return trim(strMain);
}
function SelectSql(sSql, PageNo, PageSize, dbName) {
	return fc_select(sSql, PageNo, PageSize, dbName);
}
function InsertSql(sSql, dbName) {
	return fc_insert(sSql, dbName);
}
function InsertSqls(sSql, dbName) {
	/*将<no>sql</no> 替换成 <no><![CDATA[sql]]></no>的格式，
	 *sql以xml文本 的方式发送至后台，
	 *后台用dom解析xml，否则sql中存在特殊字符的话，将无法解析。
	 */
	var regx = new RegExp("<no>(.+?)</no>","g");
	var sqls= sSql;
	sqls = sqls.replace(regx,"<no><![CDATA[$1]]></no>");
	return inserts(sqls, dbName);
}
function GetDate() {
	return getdate();
}
function RepStr(mainStr, findStr, replaceStr) {
	return repStr(mainStr, findStr, replaceStr);
}
function IsSpace(strMain) {
	return isSpace(strMain);
}
function RepXml(sSql) {
	return repXml(sSql);
}
function unRepXml(sSql) {
	return UnRepXml(sSql);
}
function Num(str1) {
	return num(str1);
}
function IsTrue(svalue) {
	return isTrue(svalue);
}
function SetDom(sXml) {
	var oXml = new ActiveXObject("Microsoft.XMLDOM");
	oXml.async = false;
	oXml.loadXML(sXml);
	return oXml;
}
function SetDomFile(sPath) {
	var oXml;
	try {
		oXml = new ActiveXObject("Msxml2.DOMDocument");
	} catch (e) {
	}
	if (typeof oXml == "undefined")
		oXml = new ActiveXObject("Microsoft.XMLDOM");
	oXml.async = false;
	oXml.load(sPath);
	return oXml;
}
function RemoveRoot(strX) {
	if (strX.length > 13) {
		strX = strX.substring(6, strX.length - 7);
		return strX;
	} else {
		return "";
	}
}
function CssPart(csstext) {
	if (typeof csstext == "undefined")
		return "";
	var sRet = "";
	var arr = csstext.split(";");
	var l = arr.length;
	for (var i = 0;i < l; i++) {
		var arr1 = arr[i].split(":");
		if (arr1.length != 2)
			continue;
		var stitle = trim(arr1[0]);
		var svalue = trim(arr1[1]);
		if (stitle == "FONT-WEIGHT" || stitle == "FONT-SIZE"
				|| stitle == "COLOR" || stitle == "FONT-STYLE"
				|| stitle == "FONT-FAMILY" || stitle == "BACKGROUND-COLOR"
				|| stitle == "TEXT-DECORATION") {
			sRet += stitle + ":" + svalue + ";";
		}
	}
	return sRet;
}
function ClearCssPart(obj, attrNameJs, attrName) {
	if (typeof(obj) == "undefined" || typeof(attrName) == "undefined")
		return;
	eval("obj.style." + attrNameJs + "='';");
	var s1 = obj.style.cssText;
	attrName = attrName.toUpperCase();
	obj.style.cssText = RepStr(s1, attrName, "");
}
function HaveUpload() {
	try {
		var s1 = upload1.id;
		if (s1 != "upload1") {
			return false;
		}
	} catch (e) {
		return false;
	}
	return true;
}
function getMaxNo(sTag, strMK) {
	return SendHttp(new StringBuffer().append(location.protocol).append("//")
			.append(location.host).append(fcpubdata.servletPath)
			.append("/WebBill").append(fcpubdata.dotnetVersion)
			.append("?getRecnum").toString(), new StringBuffer().append("<no>")
			.append(sTag).append("</no>").toString());
}
function getMaxIntNo(sTag) {
	return SendHttp(new StringBuffer().append(location.protocol).append("//")
			.append(location.host).append(fcpubdata.servletPath)
			.append("/WebBill").append(fcpubdata.dotnetVersion)
			.append("?getMaxIntNo").toString(), new StringBuffer()
			.append("<no>").append(sTag).append("</no>").toString());
}
function getAbsLeft(e) {
	var l = e.offsetLeft;
	while (e = e.offsetParent) {
		if (e.style.position != "absolute") {
			l += e.offsetLeft;
		} else {
			l += e.style.pixelLeft;
		}
	}
	return l;
}
function getAbsTop(e) {
	var t = e.offsetTop;
	while (e = e.offsetParent) {
		if (e.style.position != "absolute") {
			t += e.offsetTop;
		} else {
			t += e.style.pixelTop;
		}
	}
	return t;
}
function getPosLeft(e) {
	var l = e.offsetLeft;
	while (e = e.parentNode) {
		l += e.offsetLeft;
	}
	return l;
}
function getPosTop(e) {
	var t = e.offsetTop;
	while (e = e.parentNode) {
		t += e.offsetTop;
	}
	return t;
}
function uploadImg() {
	var oImg = event.srcElement;
	if (oImg.isContentEditable)
		return;
	var arr = window
			.showModalDialog(
					new StringBuffer().append(fcpubdata.Path)
							.append("/fceform/common/uploadimgmain.htm")
							.toString(),
					oImg,
					"scroll:no;status:no;dialogHeight:150px;dialogWidth:350px;dialogTop:180;dialogLeft:250px");
	if (typeof arr == "undefined")
		return;
	var ods = GetDsMainObj();
	if (ods != null) {
		ods.Fields.Field[oImg.field].Value = arr[2];
		ods.Fields.Field[oImg.field].valid = "变";
	}
}
function GetDsMain(bUseSelect) {
	var sRet = "DsMain";
	if (bUseSelect == true) {
		var oContXml = SetDom(Parent.SKbillsheet.contxml);
	} else {
		var oContXml = SetDom(SKbillsheet.contxml);
	}
	var oNode = oContXml.documentElement.selectSingleNode("grid");
	var oNodeDs = oContXml.documentElement.selectSingleNode("dataset");
	if (oNodeDs != null) {
		for (var i = 0;i < oNodeDs.childNodes.length; i++) {
			if (oNodeDs.pubpara == "是")
				continue;
			var bool = false;
			var s = oNodeDs.childNodes(i).text;
			if (oNode != null) {
				for (var j = 0;j < oNode.childNodes.length; j++) {
					var s1 = oNode.childNodes(j).text;
					if (bUseSelect == true)
						s1 = "Parent." + s1;
					var otmp = eval(s1);
					if (s == otmp.dataset) {
						bool = true;
						break;
					}
				}
			}
			if (typeof(creator_pt_grids) == 'undefined') {
				creator_pt_grids = new Array();
			}
			var oExtGrid = creator_pt_grids;
			for (var j = 0;j < oExtGrid.length; j++) {
				if (s == oExtGrid[j].dataset) {
					bool = true;
					break;
				}
			}
			if (bool == false) {
				var s1 = oNodeDs.childNodes(i).text;
				if (bUseSelect == true)
					s1 = "Parent." + s1;
				sRet = eval(s1).id;
				break;
			}
		}
	}
	return sRet;
}
function GetDsMainObj() {
	var bErr = true;
	if (bErr) {
		fcpubvar.DsMain = GetDsMain(false);
		try {
			var obj = eval(fcpubvar.DsMain);
			if (typeof obj == "undefined") {
				obj = eval("window." + fcpubvar.DsMain);
			}
		} catch (e) {
			return null;
		}
	}
	return obj;
}
function Pause(numberMillis) {
	var dialogScript = new StringBuffer().append('window.setTimeout(')
			.append(' function () { window.close(); }, ').append(numberMillis)
			.append(');').toString();
	var result = window.showModalDialog(new StringBuffer()
			.append('javascript:document.writeln(').append('"<script>')
			.append(dialogScript).append('<').append('/script>")').toString());
}
function SetSession(strQueryString, callback) {
	if (document.all("ifrSession") == null) {
		document.body
				.insertAdjacentHTML("BeforeEnd",
						"<IFRAME id=ifrSession name=ifrSession src='' width=0 height=0></IFRAME>");
	}
	document.all.ifrSession.src = new StringBuffer().append(location.protocol)
			.append("//").append(location.host).append(fcpubdata.servletPath)
			.append("/setSession").append(fcpubdata.dotnetVersion).append("?")
			.append(strQueryString).toString();
	document.all.ifrSession.onreadystatechange = function() {
		if (document.all.ifrSession.readyState != "complete")
			return;
		if (typeof callback == "function") {
			callback();
		}
	}
}
function GetSession(strQueryString, callback) {
	if (typeof callback == "function") {
		if (strQueryString.substring(strQueryString.length - 1,
				strQueryString.length) != "=") {
			strQueryString = strQueryString + "=";
		}
		if (document.all("ifrSession") == null) {
			document.body
					.insertAdjacentHTML("BeforeEnd",
							"<IFRAME id=ifrSession name=ifrSession src='' width=0 height=0></IFRAME>");
		}
		fcpubvar.pubSession = "null";
		document.all.ifrSession.src = new StringBuffer()
				.append(location.protocol).append("//").append(location.host)
				.append(fcpubdata.servletPath).append("/getSession")
				.append(fcpubdata.dotnetVersion).append("?")
				.append(strQueryString).toString();
		document.all.ifrSession.onreadystatechange = function() {
			if (document.all.ifrSession.readyState != "complete")
				return;
			var arrRet = new Array();
			var arr = fcpubvar.pubSession.split("&");
			var ilen = arr.length;
			for (i = 0;i < ilen; i++) {
				var arr1 = arr[i].split("=");
				arrRet[arr1[0]] = arr1[1];
			}
			if (typeof callback == "function") {
				callback(arrRet);
			}
		}
	} else {
		var arrRet = new Array();
		var arr = parent.fcpubvar.pubSession.split("&");
		var ilen = arr.length;
		for (i = 0;i < ilen; i++) {
			var arr1 = arr[i].split("=");
			arrRet[arr1[0]] = arr1[1];
		}
		return arrRet;
	}
}
function GetSessionOne(name) {
	return GetSession(name + "=")[name];
}
function CancelEvent() {
	event.cancelBubble = true;
	event.returnValue = false;
}
function ShowHelp(htmlfile) {
	window
			.open(
					new StringBuffer().append(fcpubdata.Path)
							.append("/eformhelp/").append(htmlfile)
							.append(".htm").toString(),
					"_blank",
					"top=0,left=0,height=400,width=300,status=no,toolbar=yes,menubar=no,location=no,resizable=yes,scrollbars=yes")
}
function ComboToStr(lstSelField2) {
	var sb = new StringBuilder();
	var len = lstSelField2.options.length;
	for (var i = 0;i < len; i++) {
		sb.append(Trim(lstSelField2.options(i).value));
		sb.append(",");
	}
	var sV = sb.toString();
	sV = sV.substring(0, sV.length - 1);
	return sV;
}

function SendHttp(url, data, callback, context, noRoot) {
	//获取测试数据源;
	var dbName=creator_getQueryString("pt_test");
	var regex = new RegExp("([\?\&]dbName=)[^\&]*");
	//是否设置了数据源;
	var hasPtTest =typeof(dbName) != 'undefined' && !IsSpace(dbName);
	//url是否包含dbName参数;
	var hasDbName=regex.test(url);
	if(hasPtTest){
		if(hasDbName){
			var tRep = "$1"+dbName;
			url=url.replace(regex,tRep);
		}else{
			url += "&dbName="+dbName;
		}
	}
	return ajax_request(url, data, callback, context, noRoot);
}

//位异或加密算法
function CodeAndEncode(_key,_str)
{
	if(_str && _str != ""){
		 var keyUnicodeSum=0;
		 var codedStr = "";
		 for( j = 0; j<_key.length; j++ )
		 {
			  //取出密钥的每一个字符Unicode值，并对其所有字符的Unicode值相加，得到一个总密钥Unicode值
			  keyUnicodeSum += _key.charCodeAt( j ); //charCodeAt() 方法可返回指定位置的字符的 Unicode 编码。
		 }
		 for( i = 0; i<_str.length; i++ )
		 {
			  var _strXOR = _str.charCodeAt(i) ^ keyUnicodeSum; //分别对每一个等加密字符串进行“位异或”运算
			  codedStr += String.fromCharCode( _strXOR );          //fromCharCode() 可接受一个指定的 Unicode 值，然后返回一个字符串。
		 }
		 return codedStr;
	}else{
		return _str;
	}
}


var requests = new Array();
if (typeof(XMLHttpRequest) == 'undefined')
	var XMLHttpRequest = function() {
		var request = null;
		try {
			request = new ActiveXObject('Msxml2.XMLHTTP');
			request.setTimeouts(20000, 20000, 50000, 100000);
		} catch (e) {
			try {
				request = new ActiveXObject('Microsoft.XMLHTTP');
			} catch (ee) {
			}
		}
		return request;
	}
function ajax_stop() {
	for (var i = 0;i < requests.length; i++) {
		if (requests[i] != null) {
			requests[i].obj.abort();
		}
	}
}
function ajax_create_request(context) {
	for (var i = 0;i < requests.length; i++) {
		if (requests[i].readyState == 4) {
			requests[i].abort();
			requests[i].context = null;
			return requests[i];
		}
	}
	var pos = requests.length;
	requests[pos] = Object();
	requests[pos].obj = new XMLHttpRequest();
	requests[pos].context = context;
	return requests[pos];
}
function ajax_request(url, data, callback, context, noRoot) {
	var request = ajax_create_request(context);
	var async = typeof(callback) == 'function';
	if (async)
		request.obj.onreadystatechange = function() {
			if (request.obj.readyState == 4)
				callback(new ajax_response(request));
		}
	request.obj.open('POST', url, async);
	if (noRoot == "noRoot") {
		//add by minghua.guo[2011-06-29] 位异或加密
		data = CodeAndEncode("chinacreator",data);
		request.obj.send(data);
	} else {
		//add by minghua.guo[2011-06-29] 位异或加密
		data = "<root>" + data + "</root>";
		data = CodeAndEncode("chinacreator",data);
		request.obj.send(data);
	}
	if (!async) {
		var o = new ajax_response(request);
		return o.value;
	}
}
function ajax_response(request) {
	this.request = request.obj;
	this.error = null;
	this.value = null;
	this.context = request.context;
	if (request.obj.status == 200) {
		try {
			this.value = object_from_json(request);
			if (this.value && this.value.error) {
				this.error = this.value.error;
				this.value = null;
			}
		} catch (e) {
			this.error = new ajax_error(e.name, e.description, e.number);
		}
	} else {
		this.error = new ajax_error('HTTP request failed with status: '
				+ request.obj.status, request.obj.status);
	}
	return this;
}
function enc(s) {
	return s.toString().replace(/\%/g, "%26").replace(/=/g, "%3D");
}
function object_from_json(request) {
	if (request.obj.responseXML != null && request.obj.responseXML.xml != null
			&& request.obj.responseXML.xml != '')
		return request.obj.responseXML;
	return request.obj.responseText;
}
function ajax_error(name, description, number) {
	this.name = name;
	this.description = description;
	this.number = number;
	return this;
}
ajax_error.prototype.toString = function() {
	return this.name + " " + this.description;
}
function json_from_object(o) {
	if (o == null)
		return 'null';
	switch (typeof(o)) {
		case 'object' :
			if (o.constructor == Array) {
				var s = '';
				for (var i = 0;i < o.length; ++i) {
					s += json_from_object(o[i]);
					if (i < o.length - 1)
						s += ',';
				}
				return '[' + s + ']';
			}
			break;
		case 'string' :
			return '"' + o.replace(/(["\\])/g, '\\$1') + '"';
		default :
			return String(o);
	}
}
var ajaxVersion = '5.6.3.4'
// -----------------------------------------------------------------------------------------------
CloneObject = function(obj) {
	var newObj = new Object;
	// check for array objects
	if (obj.constructor.toString().indexOf("function Array(") == 1) {
		newObj = obj.constructor();
	}
	// check for function objects (as usual, IE is fucked up)
	if (obj.constructor.toString().indexOf("function Function(") == 1) {
		newObj = obj; // just copy reference to it
	} else
		for (var n in obj) {
			var node = obj[n];
			if (typeof node == 'object') {
				newObj[n] = CloneObject(node);
			} else {
				newObj[n] = node;
			}
		}
	return newObj;
};

// setAuthority()中要有，外面也要有!有些系统表单并没有在表单的打开事件中写入setAuthority();现在已放入系统表单中
// creator_setSession("cc_form_instanceid",fcpubdata.cc_form_instanceid);
/* 20080401，添加的自定义函数，用于打开表单时进行权限控制设置 */
// 权限控制
function setAuthority() {
	var oid = fcpubdata.oid;
	var djid = fcpubdata.djid;
	/*
	 * modified by zhou.luo 2008-11-03 djid不写入session if(IsSpace(djid)){
	 * creator_setSession("cc_form_djid","-1"); }else{
	 * creator_setSession("cc_form_djid",djid); //将表单定义id存入session，后台需要用到。 }
	 */
	/*
	 * cc_form_instanceid 所对应的值： 1.undefined :
	 * 代表非流程表单，不需要走流程表单的保存逻辑,打开表单的url中没有传cc_form_instanceid 2.clear :
	 * 表示新受理一个项目实例，需要生成新的cc_form_instanceid 3.正常的id值 :
	 * 表示正常的值，该值是否改变取决于保存表单历史记录的开关是否开启 4.null :
	 * 表示session中没有设置该值，一般情况，是表单都会设置，就在此处设置
	 */
	creator_setSession("cc_form_issave", "false"); // 工作流用来确认表单是否保存。
													// false,没保存；true，保存
	addModuleIdToSession();
	if (IsSpace(oid) || IsSpace(djid)) {
		// alert("请在调用该表单的jsp页面中定义javascript变量：oid,djid \r\n
		// \toid为与该表单关联的活动id.djid为表单id");
		// return;
	} else {
		var sXml = SelectSql(
				"select substr(t.ctrl_id,length(to_char(t.djid))+1),t.perattr_type,t.readonlystyle from td_form_perattr t where t.oid='"
						+ oid + "' and t.djid=" + djid, 1, 200, getEgpDbName());
		// alert(sXml);
		if (sXml == "<root></root>") {// 从数据库中查出来的记录为空。
			// 不执行任何操作
		} else {
			var oXml = SetDom(sXml);
			var len = oXml.documentElement.childNodes.length;
			// alert("记录条数1111："+oXml.documentElement.childNodes[len-1].text);
			// alert(sXml);
			for (var i = 0;i < len - 1; i++) {
				var elementId = oXml.documentElement.childNodes[i].childNodes[0].text;
				var authority = oXml.documentElement.childNodes[i].childNodes[1].text;
				var styleName = oXml.documentElement.childNodes[i].childNodes[2].text;

				authority = authority - 0;
				switch (authority) {
					case 0 :
						break;
					case -2 :
						setReadOnly(elementId, styleName);
						break;
					case 1 :
						setDisabled(elementId);
						break;
					case 2 :
						setHidden(elementId);
						break;
					case 3 :
						fcpubdata.mShowType = "1";
						fcpubdata.mEditType = "4,0";
						break;
					case 4 :
						fcpubdata.mShowType = "1";
						fcpubdata.mEditType = "2,0";
						break;
					case 5 :
						fcpubdata.mShowType = "2";
						fcpubdata.mEditType = "3,1";
						break;
					case 6 :
						fcpubdata.mShowType = "0";
						fcpubdata.mEditType = "1,0";
						break;
					case 7 :
						fcpubdata.mShowType = "1";
						fcpubdata.mEditType = "3,0";
						break;
					case 8 :
						fcpubdata.mShowType = "1";
						fcpubdata.mEditType = "1,0";
						break;
					case 9 :
						fcpubdata.mShowType = "0";
						fcpubdata.mEditType = "1,0";
						fcpubdata.taohong = "1";
						break;
					case 10 :
						fcpubdata.mShowType = "0";
						fcpubdata.mEditType = "2,0";
						break;
					case 11 :
						fcpubdata.mShowType = "0";
						fcpubdata.mEditType = "0,0";
						break;
				}
			}
		}
	}

	// 下面将加载iWebOffice2006控件。一个页面只允许放一个iWebOffice2006控件。
	// myLoadWebOffice("WebOffice1");
	// 将流程word文档的加载和非流程word文档的加载分开。
	// alert("fcpubdata.cc_form_instanceid:"+fcpubdata.cc_form_instanceid)
	// modified by zhou.luo 2008-10-17 优化表单加载速度，加载word之前先判断是否包含word控件，包含再加载。
	var hasOffice = SqlToField(
			"select t.hasoffice from tb_form t where t.djid='" + fcpubdata.djid
					+ "'", getEgpDbName());
	if (!IsSpace(hasOffice) && hasOffice == "1") {

		// add by zuojian.xiang 2009-4-15
		// for : 一个流程多个流程word
		if (IsSpace(creator_pt_webOfficeId)) {
			creator_pt_webOfficeId = "WebOffice1";
		}
		if (fcpubdata.cc_form_instanceid != "undefined") {
			// alert("20081028：加载流程word");
			myLoadWorkflowOffice(creator_pt_webOfficeId);
		} else {
			// alert("20081028：加载非流程word");
			myLoadNoneWorkflowOffice(creator_pt_webOfficeId);
		}
		fcpubdata.mLoadTool == "false"; // 控制在一个页面范围内office工具栏只加载一次

		// added in 2008-09-22
		// 添加office控件是否绑定到表单。默认不绑定，绑定表示在取office控件实例id的时候会添加一个djid的查询条件。
		fcpubdata.office_isBindForm = SKbillsheet.creator_office_isBindForm;
		if (!IsSpace(fcpubdata.office_isBindForm)
				&& fcpubdata.office_isBindForm == '是') {
			fcpubdata.office_isBindForm = "true";
		} else {
			fcpubdata.office_isBindForm = "false";
		}

		if (fcpubdata.wf_isReadOnly == 'readonly') { // 当在办结列表显示时，将word控件的状态设为只读。
			fcpubdata.mShowType = "1";
			fcpubdata.mEditType = "0,0";
		}
	}
	// 控制工作流控件按钮的显示：
	// modified by zhou.luo 2008-10-17 优化表单加载速度，判断工作流控件是否显示之前，先判断是否包含工作流控件。
	var hasWorkflowButton = SqlToField(
			"select t.procattr from tb_form t where t.djid='" + fcpubdata.djid
					+ "'", getEgpDbName());
	if (!IsSpace(hasWorkflowButton) && hasWorkflowButton == "1") {
		/*
		 * creator_isShowActSelectText(); creator_isShowUserText();
		 * creator_isShowBackButton(); creator_isShowOtherButton();
		 * creator_isShowRecycle(); creator_isShowCompleteWorkflow();
		 * creator_isShowTempSaveForm(); creator_isShowTerminate();
		 * creator_isShowSuspend(); creator_isShowResume();
		 * changeWorkflowControlStatus();
		 */
		// modified by zhou.luo 2008-11-25 通过一次请求来判断工作流的按钮是否显示。
		creator_showAllWorkflowButtonControl();
	}

	// added by zhou.luo in 2008-10-15 添加“onuse”为待办时，做同样处理。
	// modified by zhou.luo 2008-11-04 修改传参数为"onuse",与办结做同样的处理。
	// modified by zhou.luo 2008-11-11
	// 增加挂起列表"suspend",做同样处理。(自己添加的工作流按钮是否显示要由自己控制；工作流控件则会自动控制)
	// modified by zhou.luo 2009-01-15 从已办列表点击查看表单时，grid的分页按钮应该显示出来。
	fcpubdata.elementAuthoritySwitch = SKbillsheet.creator_elementAuthoritySwitch; // 是否由用户控制已办结的表单的元素的显示
	if (fcpubdata.elementAuthoritySwitch != '是'
			&& (fcpubdata.wf_isReadOnly == 'onuse'
					|| fcpubdata.wf_isReadOnly == 'readonly' || fcpubdata.wf_isReadOnly == 'suspend')) { // 默认的办结表单元素权限控制
		var o = document;
		var arrayWfControl = new Array(); // 工作流控件里面的button，input，select
		arrayWfControl[0] = "workflowControl_selectAct";
		arrayWfControl[1] = "DYNAMICPERFORMER_NAME";
		arrayWfControl[2] = "DYNAMICPERFORMER";
		arrayWfControl[3] = "button_xzxr";
		arrayWfControl[4] = "ANDSPLITUSERS_ACTNAME";
		arrayWfControl[5] = "ANDSPLITUSERS";
		arrayWfControl[6] = "button_yfzxzxr";
		arrayWfControl[7] = "button_qdlc";
		arrayWfControl[8] = "button_wchd";
		arrayWfControl[9] = "button_ht";
		arrayWfControl[10] = "button_hs";
		arrayWfControl[11] = "button_zzlc";
		arrayWfControl[12] = "button_zc";
		arrayWfControl[13] = "workflowControl_result";
		arrayWfControl[14] = "workflowControl_suspend"; // 挂起
		arrayWfControl[15] = "workflowControl_resume"; // 恢复
		arrayWfControl[16] = "workflowControl_backToPrior";
		arrayWfControl[17] = "button_fh";
		arrayWfControl[18] = "button_gq";
		arrayWfControl[19] = "button_hf";
		arrayWfControl[20] = "firstpagegrid"; // grid的4个分页按钮
		arrayWfControl[21] = "prevpagegrid";
		arrayWfControl[22] = "nextpagegrid";
		arrayWfControl[23] = "lastpagegrid";

		for (i = 0;i < o.all.length; i++) {

			for (var wf_i = 0;wf_i < arrayWfControl.length; wf_i++) {
				/*
				 * if(o.all(i).id == arrayWfControl[wf_i]){ //工作流控件的是否显示不受此控制。
				 * break; }
				 */
				if (o.all(i).id.substring(0, arrayWfControl[wf_i].length) == arrayWfControl[wf_i]) {
					break;
				}
			}

			if (o.all(i).tagName == "INPUT") {
				if (wf_i == arrayWfControl.length) {
					o.all(i).disabled = "true";
				}
			}
			if (o.all(i).tagName == "BUTTON") {
				if (wf_i == arrayWfControl.length) {
					// alert("input:"+o.all(i).id);
					o.all(i).style.display = "none";
					// o.all(i).disabled = "true";
				}
			}
			if (o.all(i).tagName == "TEXTAREA") {
				if (wf_i == arrayWfControl.length) {
					// alert("input:"+o.all(i).id);
					o.all(i).disabled = "true";
				}
			}
			if (o.all(i).tagName == "SELECT") {
				if (wf_i == arrayWfControl.length) {
					o.all(i).disabled = "true";
				}
			}
		}
	}
	// 传递参数，并设置自动加载的iframe的src
	creator_setIframesSrc();
	// grid添加分页功能需初始化
	creator_gridpage();
}
// 2008-09-11 设置为只读
// modified by zhou.luo 2009-02-25
// 去掉只读设置样式的功能，在平台无法设置，现在以提供接口的形式由开发人员来设置。
function setReadOnly(id, styleName) {
	var o = SKbillsheet.all;// 获得表单所有的控件对象。
	var l = o.length;
	for (var i = 0;i < l; i++) {
		if (o[i].id == id) {
			if (o[i].readOnly != undefined) {
				o[i].readOnly = true;
			}

			break;
		}
	}
}
// 设置为disable
function setDisabled(id) {
	var o = SKbillsheet.all;// 获得表单所有的控件对象。
	var l = o.length;
	for (var i = 0;i < l; i++) {
		if (o[i].id == id) {
			o[i].disabled = true;
			break;
		}
	}
}

// 设置为不可见
function setHidden(id) {
	var o = SKbillsheet.all;
	var l = o.length;
	for (var i = 0;i < l; i++) {
		if (o[i].id == id) {
			o[i].style.display = "none";
			break;
		}
	}
}

// added by zhou.luo in 2008-10-15
// 加载非流程的word文档。
function myLoadNoneWorkflowOffice(id) {
	var currentSystemID = creator_getSession("subsystem_id_nouse");
	var appUserName = "";
	if (!IsSpace(currentSystemID) && currentSystemID != "module") {
		appUserName = "APP_" + currentSystemID.toUpperCase() + ".";
	}
	fcpubdata.mUserName = getSysElement("userName");
	// 先查询表Document，看该表单是否已经有对应的recordid，如果有就直接使用这个文档，如果没有就生成一个id。
	if (noneWorkflowWordId != "") { // 必须传递参数
		var strsql_document1 = new StringBuffer()
				.append("select t.recordid,t.template,t.filetype from ")
				.append(appUserName).append("td_octl_document t where t.djid=")
				.append(fcpubdata.djid).append(" and t.recordid='")
				.append(noneWorkflowWordId).append("'").toString();
		var sXml_document1 = SelectSql(strsql_document1, 1, 5);
		if (sXml_document1 == "<root></root>") {// 从数据库中查出来的记录为空,表示要新建一个文档。
			fcpubdata.mIsFirstLoad = "true";
			fcpubdata.mRecordID = noneWorkflowWordId;
			fcpubdata.mTemplate = "";
			fcpubdata.mFileType = ".doc";
			fcpubdata.mFileName = fcpubdata.mRecordID + fcpubdata.mFileType;
			fcpubdata.mEditType = "1,0";
			fcpubdata.mShowType = "1";
		} else {
			fcpubdata.mIsFirstLoad = "false";
			var oXml = SetDom(sXml_document1);
			fcpubdata.mRecordID = oXml.documentElement.childNodes[0].childNodes[0].text;
			fcpubdata.mTemplate = oXml.documentElement.childNodes[0].childNodes[1].text;
			fcpubdata.mFileType = oXml.documentElement.childNodes[0].childNodes[2].text;
			fcpubdata.mFileName = fcpubdata.mRecordID + fcpubdata.mFileType;
		}
	}
}

// added by zhou.luo in 2008-10-15
// 加载流程的word文档
function myLoadWorkflowOffice(id) {
	var currentSystemID = creator_getSession("subsystem_id_nouse");
	var appUserName = "";
	if (!IsSpace(currentSystemID) && currentSystemID != "module") {
		appUserName = "APP_" + currentSystemID.toUpperCase() + ".";
	}
	/*
	 * modified by zhou.luo 208-10-17 去掉循环 var o = SKbillsheet.all; var l =
	 * o.length; for(var i = 0;i < l;i++){ if(o[i].id == id){
	 */
	fcpubdata.mUserName = getSysElement("userName");

	if ((fcpubdata.other_form_instanceid != "" && fcpubdata.other_djid != "")
			|| fcpubdata.other_officeid != "") {
		if (fcpubdata.other_form_instanceid != "" && fcpubdata.other_djid != "") {
			// 查数据库得到文档id
			// modify by zuojian.xiang
			// 将SQL中的weboffice1改成变量id
			var strsql_record = new StringBuffer()
					.append("select t.ctrl_insid from ")
					.append(appUserName)
					.append("tb_ctrl_office_run t where t.cc_form_instanceid='")
					.append(fcpubdata.other_form_instanceid)
					.append("' and t.djid='").append(fcpubdata.other_djid)
					.append("' and t.ctrlid='").append(id).append("'")
					.toString();
			fcpubdata.mRecordID = SqlToField(strsql_record);
			// alert("1 查出来的文档id111：" + fcpubdata.mRecordID);
		} else if (fcpubdata.other_officeid != "") {
			// 将传进来的other_officeid作为文档id
			fcpubdata.mRecordID = fcpubdata.other_officeid;
			// alert("1 查出来的文档id222：" + fcpubdata.mRecordID);
		}

		fcpubdata.mIsFirstLoad = "false";

		if (other_aswfdoc == "true") { // 作为流程中的文档。
			var new_cc_form_instanceid = fcpubdata.cc_form_instanceid;
			if (fcpubdata.cc_form_instanceid == "clear") {
				new_cc_form_instanceid = getNewCc_form_instanceid("true",
						"false");
				fcpubdata.cc_form_instanceid = new_cc_form_instanceid;
				fcpubdata.newccid = true;
			}
			// 将新生成的cc_form_instanceid或者是已有的cc_form_instanceid和文档id、当前表单id写入数据库
			var strsql_insert = new StringBuffer()
					.append("insert into tb_ctrl_office_run t (t.djid,t.ctrlid,t.cc_form_instanceid,t.ctrl_insid,t.status) values ('")
					.append(fcpubdata.djid).append("','").append(id)
					.append("','").append(new_cc_form_instanceid).append("','")
					.append(fcpubdata.mRecordID).append("',0)").toString();
			// alert("insert:"+strsql_insert);
			InsertSql(strsql_insert);
		} else {// 不是作为流程中的文档就不自动加载，需要手动加载。
			fcpubdata.mIsAutoLoadWord = "false";
		}

		var strsql_document = new StringBuffer()
				.append("select t.template,t.filetype,t.recordid||t.filetype as filename from ")
				.append(appUserName)
				.append("td_octl_document t where t.recordid='")
				.append(fcpubdata.mRecordID).append("'").toString();
		var sXml_document = SelectSql(strsql_document, 1, 5);
		if (sXml_document == "<root></root>") {// 从数据库中查出来的记录为空。
			// alert("1 document中的记录为空！");
			fcpubdata.allowLoad = "false";
			// 该文档不存在，不允许加载。
		} else {
			var oXml = SetDom(sXml_document);
			fcpubdata.mTemplate = oXml.documentElement.childNodes[0].childNodes[0].text;
			fcpubdata.mFileType = oXml.documentElement.childNodes[0].childNodes[1].text;
			fcpubdata.mFileName = oXml.documentElement.childNodes[0].childNodes[2].text;
		}
	} else {
		if (fcpubdata.cc_form_instanceid == "clear") {// 代表启动流程的时候
			fcpubdata.cc_form_instanceid = getNewCc_form_instanceid("true");
			fcpubdata.newccid = true;
			fcpubdata.mRecordID = creator_getCtrlInsid(id,
					fcpubdata.office_isBindForm);
		} else {
			fcpubdata.mRecordID = creator_getCtrlInsid(id,fcpubdata.office_isBindForm);
		}

		var strsql_document = new StringBuffer()
				.append("select t.template,t.filetype,t.recordid||t.filetype as filename from ")
				.append(appUserName)
				.append("td_octl_document t where t.recordid='")
				.append(fcpubdata.mRecordID).append("'").toString();
		var sXml_document = SelectSql(strsql_document, 1, 5);
		if (sXml_document == "<root></root>") {// 从数据库中查出来的记录为空。
			// alert("2 document中记录为空！");
			fcpubdata.mIsFirstLoad = "true";
			fcpubdata.mTemplate = "";
			fcpubdata.mFileType = ".doc";
			fcpubdata.mFileName = fcpubdata.mRecordID + fcpubdata.mFileType;
			fcpubdata.mEditType = "1,0";
			fcpubdata.mShowType = "1";
		} else {
			fcpubdata.mIsFirstLoad = "false";
			var oXml = SetDom(sXml_document);
			fcpubdata.mTemplate = oXml.documentElement.childNodes[0].childNodes[0].text;
			fcpubdata.mFileType = oXml.documentElement.childNodes[0].childNodes[1].text;
			fcpubdata.mFileName = oXml.documentElement.childNodes[0].childNodes[2].text;
		}
	}
	// 流程中的文档自动加载，也可设置fcpubdata.mIsAutoLoadWord为false来手动加载。
	if (fcpubdata.mIsAutoLoadWord == "true" && fcpubdata.allowLoad == "true") { // mIsAutoLoadWord为"true",流程应用中使用word控件自动加载。
		setTimeout(
				"loadWebOffice(fcpubdata.mServerUrl,fcpubdata.mRecordID,fcpubdata.mTemplate,fcpubdata.mFileName,fcpubdata.mFileType,fcpubdata.mUserName,fcpubdata.mEditType,fcpubdata.mShowType)",
				1000);
	}
	if (fcpubdata.mIsAutoLoadWord == "false") { // 当值为"false"时，改为"true",使其仅起一次作用，仅在新建的时候将其改为false，手动加载；其他情况则自动加载。
		fcpubdata.mIsAutoLoadWord == "true";
	}
}

// 判断是否含有iweboffice控件，如果有就修改mIsLoad为true,并初始化打开控件需要的参数，加载控件；没有就改为false。
function myLoadWebOffice(id) {
	var currentSystemID = creator_getSession("subsystem_id_nouse");
	var appUserName = "";
	if (!IsSpace(currentSystemID) && currentSystemID != "module") {
		appUserName = "APP_" + currentSystemID.toUpperCase() + ".";
	}

	var o = SKbillsheet.all;
	var l = o.length;
	for (var i = 0;i < l; i++) {
		if (o[i].id == id) {
			// alert("fcpubdata.cc_form_instanceid:"+fcpubdata.cc_form_instanceid);
			fcpubdata.mUserName = getSysElement("userName");

			if (fcpubdata.cc_form_instanceid != "clear"
					&& fcpubdata.cc_form_instanceid != "undefined") {
				// fcpubdata.mRecordID = fcpubdata.cc_form_instanceid;
				// modified in 2008-09-22
				// 使用新的得到office控件实例id的接口，加上office控件是否绑定表单的参数
				fcpubdata.mRecordID = creator_getCtrlInsid(id,
						fcpubdata.office_isBindForm);
				fcpubdata.mIsFirstLoad = "false";
			}
			if (fcpubdata.cc_form_instanceid == "clear") {// 代表启动流程的时候
				// 使用默认的值。新建一个word文档。
				fcpubdata.mIsFirstLoad = "true";
				var type = "";
				if (fcpubdata.cc_form_instanceid == undefined) {
					type = "false";
				} else {
					type = "true";
				}
				getNewCc_form_instanceid(type);
				// modified in 2008-09-22
				// 使用新的得到office控件实例id的接口，加上office控件是否绑定表单的参数
				fcpubdata.mRecordID = creator_getCtrlInsid(id,
						fcpubdata.office_isBindForm);
				fcpubdata.mTemplate = "";
				fcpubdata.mFileType = ".doc";
				fcpubdata.mFileName = fcpubdata.mRecordID + fcpubdata.mFileType;
				fcpubdata.mEditType = "1,0";
				fcpubdata.mShowType = "1";
			}
			if (fcpubdata.cc_form_instanceid == "undefined") {// 代表在非流程应用使用weboffice
				// 先查询表Document，看该表单是否已经有对应的recordid，如果有就直接使用这个文档，如果没有就生成一个id。
				if (noneWorkflowWordId != "") { // 必须传递参数
					var strsql_document1 = new StringBuffer()
							.append("select t.recordid,t.template,t.filetype from ")
							.append(appUserName)
							.append("td_octl_document t where t.djid=")
							.append(fcpubdata.djid).append(" and t.recordid='")
							.append(noneWorkflowWordId).append("'").toString();

					var sXml_document1 = SelectSql(strsql_document1, 1, 5);
					if (sXml_document1 == "<root></root>") {// 从数据库中查出来的记录为空,表示要新建一个文档。
						fcpubdata.mIsFirstLoad = "true";
						fcpubdata.mRecordID = noneWorkflowWordId;
						fcpubdata.mTemplate = "";
						fcpubdata.mFileType = ".doc";
						fcpubdata.mFileName = fcpubdata.mRecordID
								+ fcpubdata.mFileType;
						fcpubdata.mEditType = "1,0";
						fcpubdata.mShowType = "1";
					} else {
						fcpubdata.mIsFirstLoad = "false";
						var oXml = SetDom(sXml_document1);
						fcpubdata.mRecordID = oXml.documentElement.childNodes[0].childNodes[0].text;
						fcpubdata.mTemplate = oXml.documentElement.childNodes[0].childNodes[1].text;
						fcpubdata.mFileType = oXml.documentElement.childNodes[0].childNodes[2].text;
						fcpubdata.mFileName = fcpubdata.mRecordID
								+ fcpubdata.mFileType;
					}
				}
			} else {// 代表流程应用使用weboffice控件
				var strsql_document = new StringBuffer()
						.append("select t.template,t.filetype,t.recordid||t.filetype as filename from ")
						.append(appUserName)
						.append("td_octl_document t where t.recordid='")
						.append(fcpubdata.mRecordID).append("'").toString();
				var sXml_document = SelectSql(strsql_document, 1, 5);
				if (sXml_document == "<root></root>") {// 从数据库中查出来的记录为空。
					// 不执行任何操作
				} else {
					var oXml = SetDom(sXml_document);
					fcpubdata.mTemplate = oXml.documentElement.childNodes[0].childNodes[0].text;
					fcpubdata.mFileType = oXml.documentElement.childNodes[0].childNodes[1].text;
					fcpubdata.mFileName = oXml.documentElement.childNodes[0].childNodes[2].text;
				}
			}
			// alert("执行loadWebOffice");
			if (fcpubdata.cc_form_instanceid == "undefined"
					&& noneWorkflowWordId == "") {
				// 非流程表单使用word控件又没有传参数的情况，不加载word
				// alert("请在url后面传递wordid参数！");
			} else if (fcpubdata.cc_form_instanceid != "undefined"
					&& fcpubdata.mIsAutoLoadWord == "true") { // mIsAutoLoadWord为"true",流程应用中使用word控件自动加载，
				// 非流程使用需要手动加载。
				setTimeout(
						"loadWebOffice(fcpubdata.mServerUrl,fcpubdata.mRecordID,fcpubdata.mTemplate,fcpubdata.mFileName,fcpubdata.mFileType,fcpubdata.mUserName,fcpubdata.mEditType,fcpubdata.mShowType)",
						1000);
			}
			if (fcpubdata.mIsAutoLoadWord == "false") { // 当值为"false"时，改为"true",使其仅起一次作用，仅在新建的时候将其改为false，手动加载；其他情况则自动加载。
				fcpubdata.mIsAutoLoadWord == "true";
			}
			break;
		}
	}
}

// org递归
// 打开系统管理的五大对象的树 type:'org','user','role','group','job'
// id:接收id的text控件的id
// name:接收name的text控件的id
// isRadio:true or false true 表示前面是单选框，false表示是复选框 ；不传该参数则默认是复选框。
// showmode:static-dynamic,static
// rootId-根节点id, rootName-根节点名称, expandLevel-展开级数
var openTree_orgids = "";
var openTree_userids = "";
function openTree(type, id, name, isRadio, treeshowmode, rootId, rootName, expandLevel) {
	openTree_userids = id.value;
	openTree_names = name.value;
	var orgids = "";
	try {
		eval("orgids=creator_tree_" + id.id);
	} catch (e) {
	};

	var rootId = rootId || "0";
	var rootName = rootName || "组织机构树";
	var expandLevel = expandLevel || "1";
	
	var url = new StringBuffer().append(location.protocol).append("//")
			.append(location.host).append(fcpubdata.Path)
			.append("/systemManager/");
	if (!IsSpace(type)) {
		if (type == "org") { // 机构树 单选与多选
			if (!IsSpace(isRadio) && isRadio) {
				url.append("org_tree_radio.jsp?rootId="+rootId + "&rootName="+rootName + "&expandLevel="+expandLevel);
			} else {
				url.append("org_tree.jsp?rootId="+rootId + "&rootName="+rootName + "&expandLevel="+expandLevel);
			}
		} else if (type == "user") { // 机构用户树 单选与多选
			if (!IsSpace(isRadio) && isRadio) {
				url.append("orgUserTreeRadio.jsp?userid=").append(id.value)
						.append("&userName=").append(name.value+"&rootId="+rootId + "&rootName="+rootName + "&expandLevel="+expandLevel);
			} else {
				url.append("orgUserTree.jsp?orgid=").append(orgids+"&rootId="+rootId + "&rootName="+rootName + "&expandLevel="+expandLevel);
			}

		} else if (type == "role") { // 角色树 单选与多选
			if (!IsSpace(isRadio) && isRadio) {
				url.append("role_tree_radio.jsp");
			} else {
				url.append("role_tree.jsp");
			}

		} else if (type == "group") { // 组 单选与多选
			if (!IsSpace(isRadio) && isRadio) {
				url.append("groupTreeRadio.jsp");
			} else {
				url.append("groupTree.jsp");
			}

		} else if (type == "job") { // 工作岗位树 单选与多选
			if (!IsSpace(isRadio) && isRadio) {
				url.append("jobTreeRadio.jsp");
			} else {
				url.append("jobTree.jsp");
			}

		} else if (type == "business") { // 业务类别树 只有单选
			url.append("business_type_tree.jsp?busids=").append(id.value);

		} else if (type == "report") { // 报表树 只有单选
			url.append("reportmain.jsp");
		} else {
			url.append("org_tree_radio.jsp");
		}

	}

	var myReturn = "";
	if (type == "report") {
		myReturn = window.showModalDialog(url.toString(), window,
				"dialogWidth:600px");
	} else {
		myReturn = window.showModalDialog(url.toString(), window);
	}
	if (myReturn != "undefined" && myReturn != null) {
		var arr = myReturn.split(";");
		id.value = arr[0];
		name.value = arr[1];
		if (arr.length > 2) {
			eval("creator_tree_" + id.id + "=arr[2]");
		}

	}

}

// org,user,weibanju 不递归
// 打开系统管理的五大对象的树
// type:'org','user','role','group','job','weibanju','office','leader'
// id:接收id的text控件的id
// name:接收name的text控件的id
// isRadio:true or false true 表示前面是单选框，false表示是复选框 ；不传该参数则默认是复选框。
function open_unrecusivse_tree(type, id, name, isRadio) {

	var url = new StringBuffer().append(location.protocol).append("//")
			.append(location.host).append(fcpubdata.Path)
			.append("/systemManager/");
	if (!IsSpace(type)) {
		if (type == "org") { // 机构树 单选与多选
			if (!IsSpace(isRadio) && isRadio) {
				url.append("org_tree_radio.jsp");
			} else {
				url.append("unrecursive_org_tree.jsp?org_ids=")
						.append(id.value);
			}
		} else if (type == "user") { // 机构用户树 单选与多选
			if (!IsSpace(isRadio) && isRadio) {
				url.append("officeUserTreeRadio.jsp?userid=").append(id.value);
			} else {
				url.append("unrecursive_orgUserTree.jsp?userid=")
						.append(id.value);
			}

		} else if (type == "role") { // 角色树 单选与多选
			if (!IsSpace(isRadio) && isRadio) {
				url.append("role_tree_radio.jsp");
			} else {
				url.append("role_tree.jsp");
			}

		} else if (type == "group") { // 组 单选与多选
			if (!IsSpace(isRadio) && isRadio) {
				url.append("groupTreeRadio.jsp");
			} else {
				url.append("groupTree.jsp");
			}

		} else if (type == "job") { // 工作岗位树 单选与多选
			if (!IsSpace(isRadio) && isRadio) {
				url.append("jobTreeRadio.jsp");
			} else {
				url.append("jobTree.jsp");
			}

		} else if (type == "business") { // 业务类别树 只有单选
			url.append("business_type_tree.jsp");

		} else if (type == "weibanju") { // 委办局 只有单选
			url.append("unrecursive_weibanju_org_tree.jsp?org_ids=")
					.append(id.value);
		} else if (type == "office") { // office 只有单选
			url.append("unrecursive_office_org_tree.jsp?org_ids=")
					.append(id.value);
		} else if (type == "leader") { // 领导 只有单选
			url.append("cityLeaderTree.jsp?userid=").append(id.value);
		} else {
			url.append("org_tree_radio.jsp");
		}

	}

	var myReturn = window.showModalDialog(url.toString());
	if (myReturn != "undefined" && myReturn != null) {
		id.value = myReturn.split(";")[0];
		name.value = myReturn.split(";")[1];
	}
}

// 打开栏目树(包含公共栏目，递归)，市长专报里面使用。
function openColumnTree(id, name, has_public) {
	var userorgid = getSysElement('userorgid');
	if (IsSpace(has_public.value)) {
		has_public.value = "0";
	}
	var url = new StringBuffer().append(location.protocol).append("//")
			.append(location.host).append(fcpubdata.Path)
			.append("/systemManager/column_tree.jsp?column_ids=")
			.append(id.value).append("&userorgid=").append(userorgid)
			.append("&has_public=").append(has_public.value).toString();
	var myReturn = window.showModalDialog(url);
	if (myReturn != "undefined" && myReturn != null) {
		id.value = myReturn.split("|")[0];
		name.value = myReturn.split("|")[1];
		has_public.value = myReturn.split("|")[2];
	}
}

// 打开栏目树(包含公共栏目，不递归)，市长专报里面使用。
function openColumnTree_unrecursive(id, name, has_public) {
	var userorgid = getSysElement('userorgid');
	if (IsSpace(has_public.value)) {
		has_public.value = "0";
	}
	var url = new StringBuffer().append(location.protocol).append("//")
			.append(location.host).append(fcpubdata.Path)
			.append("/systemManager/unrecursive_column_tree.jsp?column_ids=")
			.append(id.value).append("&userorgid=").append(userorgid)
			.append("&has_public=").append(has_public.value).toString();
	var myReturn = window.showModalDialog(url);
	if (myReturn != "undefined" && myReturn != null) {
		id.value = myReturn.split("|")[0];
		name.value = myReturn.split("|")[1];
		has_public.value = myReturn.split("|")[2];
	}
}

// 打开栏目树(不包含公共栏目，递归)，市长专报里面专用
function openColumnTree2(id, name) {
	var url = new StringBuffer().append(location.protocol).append("//")
			.append(location.host).append(fcpubdata.Path)
			.append("/systemManager/szzb_org_tree.jsp?org_ids=")
			.append(id.value).toString();
	var myReturn = window.showModalDialog(url);
	if (myReturn != "undefined" && myReturn != null) {
		id.value = myReturn.split(";")[0];
		name.value = myReturn.split(";")[1];
	}
}

// 打开栏目树（不包含公共栏目，不递归），市长专报里面用
// hasAuthority:true or false true：有权限；false：无权限控制
function openColumnTree2_unrecursive(id, name, hasAuthority) {
	var userorgid = "";
	var url = new StringBuffer().append(location.protocol).append("//")
			.append(location.host).append(fcpubdata.Path)
			.append("/systemManager/szzb_un_org_tree.jsp?org_ids=")
			.append(id.value).toString();
	if (!IsSpace(hasAuthority) && hasAuthority) {
		userorgid = getSysElement('userorgid');
		url = new StringBuffer().append(location.protocol).append("//")
				.append(location.host).append(fcpubdata.Path)
				.append("/systemManager/szzb_un_auth_org_tree.jsp?org_ids=")
				.append(id.value).append("&userorgid=").append(userorgid)
				.toString();
	}
	var myReturn = window.showModalDialog(url);
	if (myReturn != "undefined" && myReturn != null) {
		id.value = myReturn.split(";")[0];
		name.value = myReturn.split(";")[1];
	}
}

// 工作流的接口
// opType: 启动流程:start; 完成活动:complete; 回退:back; 收回:recycle；暂存：tempSaveForm
// 是否显示收回：isShowRecycle
// 是否选择后续活动:isShowActSelectText
// 返回值格式为两种可能：
// isShowActSelectText:false;isShowAndActSelectText:true/false
// isShowActSelectText:true;isShowAndActSelectText:false;id1:value1;id2:value2;id3:value3
// 是否显示选择下一步执行人:isShowUserText 返回值true/false
// 是否显示回退:isShowBackButton 返回值true/false
// busiId: 业务id cc_form_instanceid
// formDefId:表单定义id djid
// sXml:控制变量组合串
// isReadOnly: 是否是办结列表 "readonly":表示办结； " "或其他值：表示非办结 "nosend"未发送列表

function workflow_operation(opType, busiId, formDefId, sXml, isReadOnly, sql) {
	var mgrName = "";
	var actInsId = "";
	var retX = "";
	var DYNAMICPERFORMER = "";
	if (!IsSpace(document.getElementById("DYNAMICPERFORMER")))
		DYNAMICPERFORMER = document.getElementById("DYNAMICPERFORMER").value;
	var ANDSPLITUSERS = "";
	if (!IsSpace(document.getElementById("ANDSPLITUSERS")))
		ANDSPLITUSERS = document.getElementById("ANDSPLITUSERS").value;
	var NEXT_ACT = "";
	if (!IsSpace(document.getElementById("workflowControl_selectAct")))
		NEXT_ACT = document.getElementById("workflowControl_selectAct").value;
	var procInsId = "";
	procInsId = creator_getQueryString("procInsId");
	if (IsSpace(procInsId))
		procInsId = "";
	if (parent && parent.parent && parent.parent.document
			&& parent.parent.document.workflowform) {
		if (parent.parent.document.workflowform.mgrNameEncode)
			mgrName = parent.parent.document.workflowform.mgrNameEncode.value;
		if (parent.parent.document.workflowform.actInsId)
			actInsId = parent.parent.document.workflowform.actInsId.value;
		if (parent.parent.document.workflowform.DYNAMICPERFORMER) {
			sXml += new StringBuffer()
					.append("<No>DYNAMICPERFORMER=")
					.append(parent.parent.document.workflowform.DYNAMICPERFORMER.value)
					.append("</No>").toString();
		}
		if (parent.parent.document.workflowform.NEXT_ACT) {
			sXml += new StringBuffer().append("<No>NEXT_ACT=")
					.append(parent.parent.document.workflowform.NEXT_ACT.value)
					.append("</No>").toString();
		}
		if (parent.parent.document.workflowform.ANDSPLITUSERS) {
			sXml += new StringBuffer()
					.append("<No>ANDSPLITUSERS=")
					.append(parent.parent.document.workflowform.ANDSPLITUSERS.value)
					.append("</No>").toString();
		}

		var tempUrl = new StringBuffer();
		tempUrl.append(location.protocol).append("//").append(location.host)
				.append(fcpubdata.servletPath).append("/WebBill")
				.append(fcpubdata.dotnetVersion);
		tempUrl.append("?moduleId=").append(fcpubdata.moduleId)
				.append("&menuModuleId=").append(fcpubdata.menuModuleId)
				.append("&djupdate&key=workFlowOperation&opType=")
				.append(opType).append("&busiId=").append(busiId)
				.append("&NEXT_ACT=").append(NEXT_ACT)
				.append("&DYNAMICPERFORMER=").append(DYNAMICPERFORMER);
		tempUrl.append("&ANDSPLITUSERS=").append(ANDSPLITUSERS)
				.append("&procInsId=").append(procInsId).append("&formDefId=")
				.append(formDefId).append("&sXml=").append(sXml)
				.append("&actInsId=").append(actInsId).append("&mgrName=")
				.append(mgrName).append("&operType=").append(isReadOnly)
				.append("&login_orgid=").append(fcpubdata.login_orgid)
				.append("&workflow_orgid=").append(fcpubdata.workflow_orgid);
		retX = SendHttp(tempUrl.toString(), sql);

		retVar = retX.split('@');
		if (retVar[0] == 'BBB')
			retX = retVar[1];

	} else {
		retX = "failure"
	}
	return retX;
}

// 挂起流程
function workflow_suspendProcesses(procInsId) {
	return sendWorkflowOperationRequest("suspend", procInsId);
}
// 恢复
function workflow_resumeProcesses(procInsId) {
	return sendWorkflowOperationRequest("resume", procInsId);
}
// 终止流程
function workflow_terminateProcesses(procInsId) {
	return sendWorkflowOperationRequest("terminateFlow", procInsId);
}
function sendWorkflowOperationRequest(opType, procInsId) {
	var retX = "";
	var sXml = "";
	retX = SendHttp(new StringBuffer().append(location.protocol).append("//")
			.append(location.host).append(fcpubdata.servletPath)
			.append("/WorkflowOperationServlet")
			.append(fcpubdata.dotnetVersion).append("?opType=").append(opType)
			.append("&procInsId=").append(procInsId).toString(), sXml);
	return retX;
}

// 根据流程定义id获取该流程是否保存表单的历史记录。返回值：0，不保存；1，保存；-1;没找到记录。
function creator_getEformHistory() {
	var workflowId = fcpubdata.workflowId;
	var strsql = "select t.issaveactdata from tb_process t where t.p_name like '%#"
			+ workflowId + "'";
	var ret = SqlToField(strsql);
	if (!IsSpace(ret)) {
		return ret;
	} else {
		return -1;
	}
}
function workflow_getProcInsId(actInsId) {
	var opType = "getProcInsId";
	var sXml = "";
	var retX = SendHttp(new StringBuffer().append(location.protocol)
			.append("//").append(location.host).append(fcpubdata.servletPath)
			.append("/WorkflowOperationServlet")
			.append(fcpubdata.dotnetVersion).append("?opType=").append(opType)
			.append("&actInsId=").append(actInsId).toString(), sXml);
	return retX;
}

// 选执行人按钮调用函数
// 示例：
// <INPUT type="button" class="input" value="选执行人" onclick="adduser()">
// <input type="text" name="DYNAMICPERFORMER" size="50" value=""
// readonly="true"> 接收用户登录名
// <input type="text" name="DYNAMICPERFORMER_NAME" size="50" value=""
// readonly="true"> 接收用户实名
// 注意：名为DYNAMICPERFORMER的文本框必须加，而且名字不能改变
function adduser() {
	var actDefId = "";
	var type = "";
	var actInsId = "";
	var users = "";
	if (parent.parent.document.getElementById("actInsId")) {
		actInsId = parent.parent.document.getElementById("actInsId").value;
		type = "common";
	}
	// modify by yaohui.luo 2008-8-26
	else {
		type = "first";
	}
	// alert(document.getElementById("workflowControl_selectAct").value);
	var workflowControl_select = document
			.getElementById("workflowControl_selectAct");
	if (!IsSpace(workflowControl_select)
			&& workflowControl_select.style.display != "none") {
		actDefId = document.getElementById("workflowControl_selectAct").value;
		type = "act";
	}
	if (document.all.item("DYNAMICPERFORMER")) {
		users = document.all.item("DYNAMICPERFORMER").value;
	}
	var mgrName = parent.parent.document.getElementById("mgrName").value;
	var arr = new Array();

	arr = mgrName.split("#");
	var ret = showModalDialog(new StringBuffer()
			.append('../../../common_workflow/select_user_modal.jsp?moduleId=')
			.append(fcpubdata.moduleId).append('&pkgId=').append(arr[0])
			.append('&version=').append(arr[1]).append('&procDefId=')
			.append(arr[2]).append('&actDefId=').append(actDefId)
			.append('&type=').append(type).append('&actInsId=')
			.append(actInsId).append('&users=').append(users).toString(), null,
			'status:no;resizable:no;dialogHeight:510px;dialogWidth:580px;unadorne:no')
	// var ret =
	// showModalDialog('../../../common_workflow/select_user_modal.jsp?pkgId='+arr[0]+'&version='+arr[1]+'&procDefId='+arr[2]+'&actDefId='
	// +actDefId+'&type='+type,null,'status:no;resizable:no;dialogHeight:510px;dialogWidth:580px;unadorne:no')
	if (!IsSpace(ret)) {
		document.all.item("DYNAMICPERFORMER").value = ret.split("|")[0];
		document.all.item("DYNAMICPERFORMER_NAME").value = ret.split("|")[1];
	}
	/*
	 * window.open('../../../common_workflow/select_user.jsp?pkgId='+arr[0]+'&version='+arr[1]+'&procDefId='+arr[2]+'&actDefId='
	 * +actDefId+'&type='+type ,'newWin'
	 * ,'scrollbars=no,status=no,titlebar=no,toolbar=no,z-lock=yes,width=616,height=500,top=150,left=250');
	 */
}

// 与分支选执行人按钮调用函数
// 示例：
// <INPUT type="button" class="input" value="选执行人" onclick="addAndUser()">
// <input type="hidden" name="ANDSPLITUSERS" >
// <input type="hidden" name="ANDSPLITUSERS_NAME" > //接收用户实名
// <input type="text" name="ANDSPLITUSERS_ACTNAME" size="80" value=""
// readonly="true">
// 注意：名为ANDSPLITUSERS_ACTNAME的文本框和名为ANDSPLITUSERS的隐藏域必须加，而且名字不能改变
function addAndUser() {
	// modified by yaohui.luo 2008-10-22
	var andusers = "";
	var andusers_name = "";
	if (document.all.item("ANDSPLITUSERS")) {
		andusers = document.all.item("ANDSPLITUSERS").value;
	}
	if (document.all.item("ANDSPLITUSERS_ACTNAME")) {
		andusers_name = document.all.item("ANDSPLITUSERS_ACTNAME").value;
	}
	andusers = andusers == null || andusers == 'null' ? "" : andusers;
	andusers_name = andusers_name == null || andusers_name == 'null'
			? ""
			: andusers_name;

	var ret = "";
	var actInsId = parent.parent.document.getElementById("actInsId");
	if (actInsId) {

		ret = showModalDialog(
				new StringBuffer()
						.append("../../../common_workflow/select_andsplit_user.jsp?moduleId=")
						.append(fcpubdata.moduleId).append("&actInsId=")
						.append(actInsId.value).append("&andusers=")
						.append(andusers).append("&andusers_name=")
						.append(andusers_name).toString(), window,
				"status:no;resizable:no;dialogHeight:510px;dialogWidth:580px;unadorne:no");
	} else {
		var mgrName = parent.parent.document.getElementById("mgrName").value;
		var arr = new Array();
		arr = mgrName.split("#");
		ret = showModalDialog(
				new StringBuffer()
						.append("../../../common_workflow/select_andsplit_user.jsp?moduleId=")
						.append(fcpubdata.moduleId).append("&pkgId=")
						.append(arr[0]).append("&version=").append(arr[1])
						.append("&procDefId=").append(arr[2])
						.append("&andusers=").append(andusers)
						.append("&andusers_name=").append(andusers_name)
						.toString(), window,
				"status:no;resizable:no;dialogHeight:510px;dialogWidth:580px;unadorne:no");
	}

	if (ret != null) {
		var str1 = ret.split("#")[0];
		var str2 = ret.split("#")[1];
		var str3 = ret.split("#")[2];
		document.all.item("ANDSPLITUSERS").value = str1;
		document.all.item("ANDSPLITUSERS_ACTNAME").value = str2;

		var selectAct = document.all.item("workflowControl_selectAct");
		// 清空下拉框
		selectAct.options.length = 0
		// 给下拉框赋值
		var oOption = document.createElement("option");
		oOption.value = str3;
		oOption.text = str3;
		selectAct.options.add(oOption);
		selectAct.selectedIndex = 0

		document.all.item("workflowControl_selectAct").value = str3;
	}
}

// grid控件分页功能调用的函数，在打开表单的时候会调用
function creator_gridpage() {
	var str = SKbillsheet.creator_pagination;
	if (str != undefined) {
		var strtemp = str.split(";");
		var contxml = SKbillsheet.contxml;
		var grididlist = contxml.substring(contxml.indexOf("<grid>"), contxml
				.indexOf("</grid>"));
		while (grididlist.substring(grididlist.indexOf("</id>")) != "") {
			grididname = grididlist.substring(grididlist.indexOf("<id>") + 4,
					grididlist.indexOf("</id>"));
			for (var i = 0;i < strtemp.length; i++) {
				var strtemp1 = strtemp[i].split(",");
				var str = "firstpage" + strtemp1[0];
				if (strtemp1[2] == "" && strtemp1[0] == grididname) {
					var firstpageobj = document.getElementById("firstpage"
							+ strtemp1[0]);
					var prevpageobj = document.getElementById("prevpage"
							+ strtemp1[0]);
					var nextpageobj = document.getElementById("nextpage"
							+ strtemp1[0]);
					var lastpageobj = document.getElementById("lastpage"
							+ strtemp1[0]);
					if (firstpageobj != null && prevpageobj != null
							&& nextpageobj != null && lastpageobj != null) {
						firstpageobj.style.display = "none";
						prevpageobj.style.display = "none";
						nextpageobj.style.display = "none";
						lastpageobj.style.display = "none";
					}
				}
				if (strtemp1[2] != "" && strtemp1[0] == grididname) {
					if (strtemp1[1] != "") {
						var obj = document.getElementById(strtemp1[1]);
						obj.PageSize = strtemp1[2];
						obj.BeforeOpen = obj + ".PageSize=" + strtemp1[2];
						var pagemessage = "pageInfo" + strtemp1[0];
						buttonevent(strtemp1[0], "firstpage");
					}
				}
			}
			grididlist = grididlist.substring(grididlist.indexOf("</id>") + 5);
		}
	}
}

// 20080813新增，tab页签的点击事件
// modified by zhou.luo 2008-10-18 这个地方不能使用setDom,不知道什么原因。不过这里应该还是可以使用正则表达式优化。
// modified by zhou.luo 2008-10-20 添加一个tab页签点击事件的接口，让应用组来实现这个函数，用于引用控件的动态加载。
// mofified by zhou.luo 2008-11-12 该函数不仅在点击页签的时候调用，而且还在tab控件的上一页和下一页的函数中调用。
function PubClickPageControl(index, creator_tabid) {
	
	var allTab = SKbillsheet.creator_allTab;
	var tabGrids = "";
	var tabIframes = "";
	if (!IsSpace(allTab)) {
		if (allTab.indexOf(creator_tabid) != -1) {
			allTab = allTab.substring(allTab.indexOf(creator_tabid));
			allTab = allTab.substring(0, allTab.indexOf("</tab>"));
			if (allTab.indexOf("<index>" + index + "</index>") != -1) {
				allTab = allTab.substring(allTab.indexOf("<index>" + index+ "</index>"));
				tabGrids = allTab.substring(allTab.indexOf("<gridid>") + 8,allTab.indexOf("</gridid>"));
				tabIframes = allTab.substring(allTab.indexOf("<iframeid>") + 10, allTab.indexOf("</iframeid>"));
			}
		}
	}
	creator_tabSetIframe(tabIframes); // 点击tab页签的时候，设置该tab页签下的iframe的src。

	eval("try{creator_clickPageControl('" + creator_tabid + "'," + index
			+ ");}catch(e){}");

	// 刷新该tab页签下所有的grid的数据（即刷新绑定到该grid的数据集。）
	// creator_gotofirstpage('',tabGrids);//解决grid响应滚动条的问题。
	// modified by zhou.luo 2008-11-11 解决grid响应滚动条的问题。
	creator_pubclickPageControl(tabGrids);

	// 2008-11-10
	// 下面的代码，刷新该tab页签下的所有iframe里面的grid的数据(即刷新绑定到该grid的数据集。)解决grid第一行勾选不中和响应滚动条的问题。
	var array_iframe = [];
	if (tabIframes.indexOf(",") != -1) {
		array_iframe = tabIframes.split(",");
	} else if (tabIframes.trim() != "") {
		array_iframe[0] = tabIframes;
	}
	for (var iframe_i = 0;iframe_i < array_iframe.length; iframe_i++) {
		window.frames[array_iframe[iframe_i]]
				.creator_iframePubclickPageControl();
	}

}

// added by zhou.luo 2008-11-11
// tab页签的点击事件，点击该tab页签时，重算该tab页签下的grid的滚动条就可以正常显示。以前的做法是刷新grid的数据集，这种做法太耗资源。
function creator_pubclickPageControl(tabGridIds) {
	if (tabGridIds != "") {
		if (tabGridIds.indexOf(",") != -1) {
			var arrGrids = tabGridIds.split(",");
			for (var j = 0;j < arrGrids.length; j++) {
				var oGrid = eval(arrGrids[j]);
				// alert("重算滚动条："+oGrid.id);
				// oGrid.ParentPos = "相对" ;
				// oGrid.hideVscroll = true ;
				// oGrid.hideHscroll = true ;
				oGrid.HScroll(); // 重算滚动条
				oGrid.VScroll();
			}
		} else {
			var oGrid = eval(tabGridIds);
			// alert("重算滚动条："+oGrid.id);
			// oGrid.ParentPos = "相对" ;
			// oGrid.hideVscroll = true ;
			// oGrid.hideHscroll = true ;
			oGrid.HScroll(); // 重算滚动条
			oGrid.VScroll();
			// oGrid.setFocus();
		}
	}
}

// added by zhou.luo 2008-11-19 作用：点击tab页签的时候重算tab页签下的引用控件的页面的grid的滚动条。
// 当iframe放置于tab控件的第二个页签当中时，grid就不能够正常显示，需要重算一下滚动条。
function creator_iframePubclickPageControl() {
	var oContDom = SetDom(SKbillsheet.contxml);
	var oNode = oContDom.documentElement.selectSingleNode("grid");
	if (oNode != null) {
		var gridids = "";
		for (var i = 0;i < oNode.childNodes.length; i++) {
			gridids = gridids + oNode.childNodes[i].text + ",";
		}
		if (gridids.indexOf(",") != -1) {
			gridids = gridids.substring(0, gridids.length - 1);
		}
		creator_pubclickPageControl(gridids);
	}
}

// 20080813新增，解决grid响应滚动条的问题，刷新grid的数据集的方式，现在不采用。
// 当传递一个dataset时，用来设置grid的分页信息。
function creator_gotofirstpage(obj_dataset, tabGrids) {
	if (typeof(SKbillsheet) != "undefined") {
		var pagination = SKbillsheet.creator_pagination;
		if (!IsSpace(pagination)) {
			var pageArray = pagination.split(";");
			for (var i = 0;i < pageArray.length; i++) {
				if (pageArray[i] != null && pageArray[i] != ""
						&& pageArray[i] != " ") {
					var dsArray = pageArray[i].split(",");
					if (dsArray.length != 3) {
						continue;
					}
					var mygridid = dsArray[0];
					var mydatasetid = dsArray[1];
					if (!IsSpace(obj_dataset)) {
						if (mydatasetid == obj_dataset.id) {
							var pagemessage = "pageInfo" + mygridid;
							if (!IsSpace($(pagemessage))) {
								if (obj_dataset.PageCount == 0) {
									// $(pagemessage).innerHTML = "第0/" +
									// obj_dataset.PageCount + "页";
									$(pagemessage).innerHTML = "";
								} else {
									$(pagemessage).innerHTML = new StringBuffer()
											.append("第")
											.append(obj_dataset.PageNo)
											.append("/")
											.append(obj_dataset.PageCount)
											.append("页").toString();
								}
							}
						}
					} else {
						// alert("i"+i);
						// alert("mygridid:"+mygridid);
						if (tabGrids != "") {
							if (tabGrids.indexOf(",") != -1) {
								var arrGrids = tabGrids.split(",");
								for (var j = 0;j < arrGrids.length; j++) {
									if (mygridid == arrGrids[j]) {
										// alert("执行"+mygridid);
										buttonevent(mygridid, 'firstpage');
									}
								}
							} else {
								if (tabGrids == mygridid) {
									buttonevent(mygridid, 'firstpage');
								}
							}
						}
					}
				}
			}
		}
	}
}

// grid控件分页按钮的响应事件
function buttonevent(gridid, type) {
	var str = SKbillsheet.creator_pagination;
	var strtemp = str.split(";");
	for (var i = 0;i < strtemp.length; i++) {
		var strtemp1 = strtemp[i].split(",");
		if (gridid == strtemp1[0]) {
			var obj = document.getElementById(strtemp1[1]);
			var pagemessage = "pageInfo" + gridid;
			if (!IsSpace($(pagemessage))) {
				if (type == "firstpage") {
					obj.FirstPage();
					if (obj.PageCount == 0) {
						// $(pagemessage).innerHTML = "第0/" + obj.PageCount +
						// "页";
						$(pagemessage).innerHTML = "";
					} else {
						$(pagemessage).innerHTML = new StringBuffer()
								.append("第").append(obj.PageNo).append("/")
								.append(obj.PageCount).append("页").toString();
					}
				}
				if (type == "prevpage") {
					if (obj.PageNo == 1) {
						alert("已经是首页");
						return;
					}
					obj.PrevPage();
					if (obj.PageCount == 0) {
						// $(pagemessage).innerHTML = "第0/" + obj.PageCount +
						// "页";
						$(pagemessage).innerHTML = "";
					} else {
						$(pagemessage).innerHTML = new StringBuffer()
								.append("第").append(obj.PageNo).append("/")
								.append(obj.PageCount).append("页").toString();
					}
				}
				if (type == "nextpage") {
					if (obj.PageNo == obj.PageCount) {
						alert("已经是最后一页");
						return;
					}
					obj.NextPage();
					if (obj.PageCount == 0) {
						// $(pagemessage).innerHTML = "第0/" + obj.PageCount +
						// "页";
						$(pagemessage).innerHTML = "";
					} else {
						$(pagemessage).innerHTML = new StringBuffer()
								.append("第").append(obj.PageNo).append("/")
								.append(obj.PageCount).append("页").toString();
					}
				}
				if (type == "lastpage") {
					obj.LastPage();
					if (obj.PageCount == 0) {
						// $(pagemessage).innerHTML = "第0/" + obj.PageCount +
						// "页";
						$(pagemessage).innerHTML = "";
					} else {
						$(pagemessage).innerHTML = new StringBuffer()
								.append("第").append(obj.PageNo).append("/")
								.append(obj.PageCount).append("页").toString();
					}
				}
			}
		}
	}
}

// 20080814新增，判断word控件是否已经加载完成，true：加载完成；false：加载未完成或加载失败。
function wordHasLoaded() {
	if (fcpubdata.webOfficeLoadOk == "1") {
		return true;
	} else {
		return false;
	}
}

// 20080814新增，判断word控件是否已经成功套红， true：成功套红；false：还未套红或套红失败
function wordHasTaohong() {
	if (fcpubdata.webOfficeHadTaohong == "1") {
		return true;
	} else {
		return false;
	}
}

// 20080818新增，判断是否已经选择执行人。
// 返回值：true：已经选择或者不需要选择；false：需要选择而没有选择
function hasSelectUser(opType) {
	if (opType == '启动流程' || opType == '完成活动' || opType == 'start'
			|| opType == 'complete') {
		var workflowControl_selectUser = document
				.getElementById('workflowControl_selectUser');
		if (!IsSpace(workflowControl_selectUser)) {
			if (workflowControl_selectUser.style.display != "none") {
				var performerId = document.all.item("DYNAMICPERFORMER").value;
				if (IsSpace(performerId)) {
					// alert("请先选择执行人！");
					return false;
				}
			}
		}
	}
	return true;
}

// 20080819新增，是否由用户控制已办结的表单的元素的显示的开关是否打开。true:打开，false:关闭
function creator_hasElementSwitch() {
	if (fcpubdata.wf_isReadOnly == 'readonly'
			&& fcpubdata.elementAuthoritySwitch == '是') {
		return true;
	} else {
		return false;
	}
}

// 20080826，改变工作流控件状态——业务定制
function changeWorkflowControlStatus() {
	var workflowControl_selectAct = document
			.getElementById("workflowControl_selectAct");
	var workflowControl_selectAct_div = document
			.getElementById("workflowControl_selectAct_div");
	if (workflowControl_selectAct_div != null
			&& workflowControl_selectAct != null) {
		workflowControl_selectAct_div.style.display = workflowControl_selectAct.style.display;
	}
}

// 20080826，更换活动清空执行人并判断是否为路由、下一个活动的执行人是否只有一个人。
function changeSelectActor() {
	var DYNAMICPERFORMER = document.getElementById("DYNAMICPERFORMER");
	var DYNAMICPERFORMER_NAME = document
			.getElementById("DYNAMICPERFORMER_NAME");
	if (!IsSpace(DYNAMICPERFORMER_NAME) && !IsSpace(DYNAMICPERFORMER)) {
		DYNAMICPERFORMER.value = "";
		DYNAMICPERFORMER_NAME.value = "";
	}
	workflow_isRoute();
	workflow_hasOnlyOnePerformer();
}

// 2008-09-24 封装的选执行人的函数
function selectActors() {
	adduser();
}
// 2008-09-24 封装的与分支选执行人
function selectAndActors() {
	addAndUser();
}

// 判断是否是路由，如果为路由就隐藏选执行人的select。
function workflow_isRoute() {
	// modified by yaohui.luo 2009-2-24
	var ret = creator_djsave('isShowUserText', false, false);
	var mgrName = parent.parent.document.getElementById("mgrNameEncode").value;
	if (IsSpace(document.getElementById("workflowControl_selectAct")))
		return;
	var actDefId = document.getElementById("workflowControl_selectAct").value;
	// modified by yaohui.luo 2009-3-12
	if (IsSpace(actDefId)) {
		return;
	}
	var retX = workflow_sendWorkflowOperationRequest('isRoute', mgrName,
			actDefId);
	var workflowControl_selectUser = document
			.getElementById('workflowControl_selectUser');
	if (retX == '1') {
		if (!IsSpace(workflowControl_selectUser)) {
			workflowControl_selectUser.style.display = "none";
		}
	} else if (retX != "false") {
		if (!IsSpace(workflowControl_selectUser) && ret == 'true') {
			workflowControl_selectUser.style.display = "block";
		}
	}
	return retX;
}

// 判断当前选择的活动是否只有一个执行人
function workflow_hasOnlyOnePerformer() {
	var mgrName = parent.parent.document.getElementById("mgrNameEncode").value;
	if (IsSpace(document.getElementById("workflowControl_selectAct")))
		return;
	var actDefId = document.getElementById("workflowControl_selectAct").value;
	var actInsId = "";
	if (!IsSpace(parent.parent.document.getElementById("actInsId"))) {
		actInsId = parent.parent.document.getElementById("actInsId").value;
	}
	// modified by yaohui.luo 2009-3-12
	if (IsSpace(actDefId)) {
		return;
	}
	var retX = workflow_sendWorkflowOperationRequest('hasOnlyOnePerformer',
			mgrName, actDefId, actInsId);
	// alert("onlyOne 返回值:"+retX);
	if (retX == "") {
	} else if (retX != "false") {
		// modified by yaohui.luo 2008-12-19
		var userRealName = retX.split(",")[1];
		var userName = retX.split(",")[0];
		DYNAMICPERFORMER.value = userName;
		DYNAMICPERFORMER_NAME.value = userRealName;
	}
	return retX;
}

// 20080826，opType:hasOnlyOnePerformer
// 当前选择的活动是否只有一个执行人。有多个执行人，返回"";只有一个执行人，返回"userAccount,userRealName"
// isRoute 当前选择的活动是否是路由。是路由，返回"1";不是路由，返回"0";异常返回"false"
function workflow_sendWorkflowOperationRequest(opType, mgrName, actDefId,
		actInsId) {
	var retX = "";
	var sXml = "";
	retX = SendHttp(new StringBuffer().append(location.protocol).append("//")
			.append(location.host).append(fcpubdata.servletPath)
			.append("/WorkflowOperationServlet")
			.append(fcpubdata.dotnetVersion).append("?moduleId=")
			.append(fcpubdata.moduleId).append("&opType=").append(opType)
			.append("&mgrName=").append(mgrName).append("&actDefId=")
			.append(actDefId).append("&actInsId=").append(actInsId).toString(),
			sXml);
	return retX;
}

// added by zhou.luo 2008-10-23
// 用于在onload的时候将父页面的参数传给引用页面。重新设置iframe的url。如果是自动加载就将url赋给src。
function creator_setIframesSrc() {
	var index = 0;
	var frame_id_load_arr = [];
	var frame_id_arr = [];
	var frame_url_arr = [];

	// 得到父页面的查询条件
	var cur_search = (location.search.length > 1) ? location.search.substring(
			1, location.search.length) : "";
	var cur_search_arr = [];
	if (cur_search != "" && cur_search.indexOf("&") != -1) {
		cur_search_arr = cur_search.split("&");
	} else {
		cur_search_arr[0] = cur_search;
	}
	// 预处理父页面的参数，djid以引用页面的为准，故在此去掉。cc_form_instanceid从session中取，也要去掉。
	for (var ii = 0;ii < cur_search_arr.length; ii++) {
		if (cur_search_arr[ii].indexOf("=") != -1) {
			if (cur_search_arr[ii].split("=")[0] == "cc_form_instanceid"
					|| cur_search_arr[ii].split("=")[0] == "djid") {
				cur_search_arr[ii] = "";
			}
		}
	}
	var oIframes = document.all.tags("iframe");
	// alert(oIframes.length);
	// for(var i=0;i<oIframes.length;i++)
	// alert(oIframes[i].autoload);
	var cc_form_id = "";
	for (var i = 0;i < oIframes.length; i++) {
		var iframe_search_arr = [];
		if (!IsSpace(oIframes[i].controltype)
				&& oIframes[i].controltype == "creatorSubForm") {
			// 得到引用页面的查询条件
			var url = oIframes[i].url;
			var iframe_search = "";
			var new_search = new StringBuffer();
			if (url.indexOf("?") != -1) {
				iframe_search = url.substring(url.indexOf("?") + 1, url.length);
				if (iframe_search.indexOf("&") != -1) {
					iframe_search_arr = iframe_search.split("&");
				} else {
					iframe_search_arr[0] = iframe_search;
				}
			}
			// 预处理引用页面的参数，oid和workflowId以父页面为准，故在此去掉。cc_form_instanceid从session中取，也要去掉。
			for (var jj = 0;jj < iframe_search_arr.length; jj++) {
				if (iframe_search_arr[jj].indexOf("=") != -1) {
					if (iframe_search_arr[jj].split("=")[0] == "cc_form_instanceid"
							|| iframe_search_arr[jj].split("=")[0] == "oid"
							|| iframe_search_arr[jj].split("=")[0] == "workflowId") {
						iframe_search_arr[jj] = "";
					}
				}
			}
			// 其他同名的参数以引用页面为准
			for (var j = 0;j < iframe_search_arr.length; j++) {
				for (var k = 0;k < cur_search_arr.length; k++) {
					if (iframe_search_arr[j].indexOf("=") != -1
							&& cur_search_arr[k].indexOf("=") != -1) {
						if (iframe_search_arr[j].split("=")[0] == cur_search_arr[k]
								.split("=")[0]) {
							cur_search_arr[k] = "";
						}
					}
				}
			}
			// 构造新的查询条件,合并两个数组的非空元素。
			for (var m = 0;m < iframe_search_arr.length; m++) {
				if (iframe_search_arr[m] != "") {
					new_search.append(iframe_search_arr[m]).append("&");
				}
			}
			for (var n = 0;n < cur_search_arr.length; n++) {
				if (cur_search_arr[n] != "") {
					new_search.append(cur_search_arr[n]).append("&");
				}
			}
			new_search = new_search.toString();
			// modified by zhou.luo 去掉最后的"&"
			if (new_search != "") {
				new_search = new_search.substring(0, new_search.length - 1);
			}
			// modified by zhou.luo 2008-12-09
			// 动态加载的iframe在页面初始化的时候不传递cc_form_instanceid，在点击tab页签的时候再传递
			if (oIframes[i].autoload == "yes") {
				if (cc_form_id == "") {
					cc_form_id = fcpubdata.cc_form_instanceid;
				}
				if (new_search != "") {
					new_search = new StringBuffer().append("?")
							.append(new_search).append("&cc_form_instanceid=")
							.append(cc_form_id).toString();
				} else {
					new_search = new StringBuffer()
							.append("?cc_form_instanceid=").append(cc_form_id)
							.toString();
				}
			} else {
				if (new_search != "") {
					new_search = "?" + new_search;
				}
			}

			if (oIframes[i].url.indexOf("?") == -1) {
				oIframes[i].url = oIframes[i].url + new_search;
			} else {
				oIframes[i].url = oIframes[i].url.substring(0, oIframes[i].url
						.indexOf("?"))
						+ new_search;
			}
			// 自动加载的页面指定其src
			if (oIframes[i].autoload == "yes") {
				// oIframes[i].src = oIframes[i].url;
				frame_id_load_arr[index] = oIframes[i].id_load;
				frame_id_arr[index] = oIframes[i].id;
				frame_url_arr[index] = oIframes[i].url;
				index++;
			}

		}
	}
	BubbleSort(); // 冒泡排序
	setIframeSrc_inOrder() // 按排列好的顺序加载src指定的页面

	function Pause(obj, iMinSecond) // 程序暂停函数
	{
		if (window.eventList == null)
			window.eventList = new Array();
		var ind = -1;
		for (var i = 0;i < window.eventList.length; i++) {
			if (window.eventList[i] == null) {
				window.eventList[i] = obj;
				ind = i;
				break;
			}
		}

		if (ind == -1) {
			ind = window.eventList.length;
			window.eventList[ind] = obj;
		}
		setTimeout("GoOn(" + ind + ")", iMinSecond);
	}

	function setIframeSrc_inOrder() {
		var obj;
		for (i = 0;i < frame_id_load_arr.length; i++) {
			if (oIframes[frame_id_arr[i]].src == "") {
				// alert(frame_id_arr[i]);
				oIframes[frame_id_arr[i]].src = frame_url_arr[i];
				obj = document.getElementById(frame_id_arr[i]);
				// alert(obj.id + " " +obj.readyState);
				Pause(this, 1000); // 给一个固定时间让本页面加载数据
				break;
			}
		}

		this.NextStep = function() {
			if (obj.readyState == 'complete') // 若页面加载完毕则加载下一页面
			{
				// alert(obj.id +" "+ obj.readyState);
				setIframeSrc_inOrder();
			} else // 若页面加载未完毕则等待一定时间后再来判断
			{
				// alert(obj.id +" "+ obj.readyState);
				Pause(this, 50);
			}
		};
	}

	function BubbleSort() {
		/*
		 * for(var i=0; i<frame_id_load_arr.length;i++) {
		 * alert("frame_id_load_arr["+i+"]:"+frame_id_load_arr[i]+"
		 * frame_id_arr["+i+"]:"+frame_id_arr[i]); }
		 */
		if (frame_id_load_arr.length > 0) {
			var i, j, temp;

			for (i = 0;i < frame_id_load_arr.length - 1; i++)
				for (j = frame_id_load_arr.length - 2;j >= i; j--)
					if (parseInt(frame_id_load_arr[j]) > parseInt(frame_id_load_arr[j
							+ 1])) {
						temp = frame_id_load_arr[j];
						frame_id_load_arr[j] = frame_id_load_arr[j + 1];
						frame_id_load_arr[j + 1] = temp;

						temp = frame_id_arr[j];
						frame_id_arr[j] = frame_id_arr[j + 1];
						frame_id_arr[j + 1] = temp;

						temp = frame_url_arr[j];
						frame_url_arr[j] = frame_url_arr[j + 1];
						frame_url_arr[j + 1] = temp;

					}
		}

		/*
		 * for(var i=0; i<frame_id_load_arr.length;i++) { alert(" oder
		 * frame_id_load_arr["+i+"]:"+frame_id_load_arr[i]+"
		 * frame_id_arr["+i+"]:"+frame_id_arr[i]); }
		 */
	}
}

function GoOn(ind) {
	var obj = window.eventList[ind];
	window.eventList[ind] = null;
	if (obj.NextStep)
		obj.NextStep();
	// else obj();
}

// added by zhou.luo 2008-10-24
// 点击tab页签的时候自动加载当前页签的iframe。参数iframe_ids：为当前tab页签的iframe的ids
function creator_tabSetIframe(iframe_ids) {
	var array_iframe = [];
	if (iframe_ids.indexOf(",") != -1) {
		array_iframe = iframe_ids.split(",");
	} else {
		array_iframe[0] = iframe_ids;
	}

	var oIframes = document.all.tags("iframe");
	for (var i = 0;i < oIframes.length; i++) {
		if (!IsSpace(oIframes[i].controltype)
				&& oIframes[i].controltype == "creatorSubForm") {
			for (var ii = 0;ii < array_iframe.length; ii++) {
				if (oIframes[i].id == array_iframe[ii] && oIframes[i].src == ""
						&& oIframes[i].autoload == "no") {
					// modified by zhou.luo 2008-12-09 在此传递cc_form_instanceid
					var cc_form_instanceid = fcpubdata.cc_form_instanceid;
					if (oIframes[i].url.indexOf("?") == -1) {
						oIframes[i].url += "?cc_form_instanceid="
								+ cc_form_instanceid;
					} else {
						oIframes[i].url += "&cc_form_instanceid="
								+ cc_form_instanceid;
					}
					oIframes[i].src = oIframes[i].url;
				}
			}
		}
	}

}

/**
 * 简单HashMap
 * 
 */
function HashMap() {
	data = {};
	var size = 0;
	// 清除所有的属性
	this.clear = function() {
		data = {};
		size = 0;
	}

	/**
	 * 判断key是否存在
	 * 
	 * @param key
	 * @return Boolean
	 */
	this.containsKey = function() {
		return Boolean(arguments[0] in data);
	}
	/**
	 * 判断值是否存在
	 * 
	 * @param value
	 * @return Boolean
	 */
	this.containsValue = function() {
		for (var i in data) {
			if (data[i] == arguments[0]) {
				return true;
			}
		}
		return false;
	}
	/**
	 * 返回key对应的v
	 */
	this.get = function() {
		if (Boolean(arguments[0] in data))
			return data[arguments[0]];
		else
			return null;
	}
	/**
	 * 判断是否为空
	 * 
	 * @return Boolean
	 */
	this.isEmpty = function() {
		return size == 0 ? true : false;
	}
	/**
	 * 取出所有的key
	 * 
	 * @return Array()
	 */
	this.keySet = function() {
		var arr = new Array();
		for (var i in data) {
			arr.push(i);
		}
		return arr;
	}
	/**
	 * 将key，value放入对象
	 * 
	 * @param key
	 * @param value
	 */
	this.put = function() {
		data[arguments[0]] = [arguments[1]];
		if (!this.containsKey(arguments[0])) {
			size++;
		}

	}
	/**
	 * 将另外一个HashMap 复制到此Map
	 * 
	 * @param map
	 */
	this.putAll = function() {
		data = arguments[0].getData();
	}
	/**
	 * 删除key对应的value
	 * 
	 * @param key
	 * @return value与 key 关联的旧值
	 */
	this.remove = function() {
		var o = this.get(arguments[0]);
		if (o) {
			delete data[o];
			return o;
		} else {
			return null;
		}
	}
	/**
	 * 返回此HashMap的大小
	 * 
	 * @reaturn Int
	 */
	this.size = function() {
		return size;
	}
	/**
	 * 返回此map所有的value集合
	 * 
	 * @return Connections
	 */
	this.values = function() {
		var arr = new Array();
		for (var i in data) {
			arr.push(data[i])
		}
		return arr;
	}
	this.getData = function() {
		return data;
	}

}

/**
 * modified by zhiwu.chen 2009-07-29 通过EFORM查询数据库 返回值：如果为空则返回空数组，否则返回二维数组
 * 描述：执行sql语句返回二维数组。一维索引表示记录索引，二维索引表示记录中字段索引。index表示数据库中数据开始的索引，从1开始。offset表示步长，即查询同时查询多少条数据。如果要查询所有数据，这时可以通过SqlToField函数查询数据总量。比如：executeSelect("select *
 * from table",1,SqlToField("select count(*) from table"))
 */

function executeSelect(sql, index, offset) {
	try {
		var result = new Array();
		var s = SelectSql(sql, index, offset);
		if (s == "<root></root>") {
			return result;
		} else {
			var x = SetDom(s);
			var rowCount = x.childNodes[0].childNodes.length - 1;
			var colCount = x.childNodes[0].childNodes[0].childNodes.length;
			for (var i = 0;i < rowCount; i++) {
				var col = new Array();
				for (var j = 0;j < colCount; j++) {
					col[j] = x.childNodes[0].childNodes[i].childNodes[j].text;
				}
				result[i] = col;
			}
			return result;
		}
	} catch (e) {
		alert("SQL:" + sql + "\r\ne:" + e);
		return new Array();
	}
}
// 用于子表单之间通信的公共对象，所有子表单都可以直接使用。
// modified by zhou.luo 2009-03-03 增加当对象引用失败时，重新创建对象。
function getPublicObj() {
	var doc = window.top.document;
	if (IsSpace(doc.creator_publicDataShare)) {
		// alert("对象为空时创建，window.top.location:"+window.top.location);
		doc.creator_publicDataShare = new HashMap();
	} else {
		try {
			doc.creator_publicDataShare.size();
		} catch (e) {
			// alert("对象引用失败时创建，window.top.location:"+window.top.location);
			doc.creator_publicDataShare = new HashMap();
		}
	}
	return doc.creator_publicDataShare;
}
try {
	getPublicObj();
} catch (e) {
}

// add by zuojian.xiang 2009-5-15
var DataStore = function() {
	// datastore发送请求之后的回调函数
	this.callback = null;
	// 发送的数据
	this.requestsJson = [];
	// dataset委托请求的方法
	this.regRequest = function(dataset) {
		dataset.DID = dataset.id;
		dataset.datastore = this;
	}
	// 返回的数据
	this.retXmlData = null;
	// 返回数据的Document对象
	this.xmlDataDom = null;
	// 返回数据之后自动填充数据,执行各个dataset的回调函数
	this.autoSetData = true;
	var varthis = this;

	this.runflag = false;

	// 重置
	this.reset = function() {
		this.runflag = false;
		this.retXmlData = null;
		this.xmlDataDom = null;
		this.requestsJson = [];
	};

	var _defaultProcessServlet = "/WebBill";
	var _xmlDom = new ActiveXObject("Microsoft.XMLDOM");
	var _autoSetData = function() {
		var list = varthis.xmlDataDom.firstChild.childNodes;
		for (var i = 0;i < list.length; ++i) {
			var datasetId = list[i].getAttribute('id');
			var sql = list[i].getAttribute('sql');
			var callback = list[i].getAttribute('callback');
			var key = list[i].getAttribute('key');
			var dataset = document.getElementById(datasetId);
			var xml = varthis.getDataById(datasetId);
			dataset.forDatastoreCallback( {
				sql : sql,
				callback : callback,
				key : key,
				xml : xml,
				result : {
					error : null,
					value : xml
				}
			});
		}
	};
	this.SendAllRequest = function() {
		var xmlstr = new StringBuffer().append("<root>");
		for (var i = 0;i < this.requestsJson.length; i++) {
			xmlstr.append("<dataset id='").append(this.requestsJson[i].dataset)
					.append("' callback=\"")
					.append(this.requestsJson[i].callback).append("\" sql=\"")
					.append(this.requestsJson[i].sql).append("\"><requeststr>")
					.append(this.requestsJson[i].requeststr)
					.append("</requeststr><key>")
					.append(this.requestsJson[i].key)
					.append("</key></dataset>");
		}
		xmlstr.append("</root>");
		xmlstr = xmlstr.toString();
		if (this.callback != null) {
			this.retXmlData = SendHttp(new StringBuffer()
					.append(location.protocol).append("//")
					.append(location.host).append(fcpubdata.servletPath)
					.append(_defaultProcessServlet).append("?datastore")
					.toString(), xmlstr, this.callback);
		} else {
			this.retXmlData = SendHttp(new StringBuffer()
					.append(location.protocol).append("//")
					.append(location.host).append(fcpubdata.servletPath)
					.append(_defaultProcessServlet).append("?datastore")
					.toString(), xmlstr);
		}
		_xmlDom.loadXML(this.retXmlData);
		this.xmlDataDom = _xmlDom;
		if (this.autoSetData) {
			_autoSetData();
		}
		this.runflag = true;
	};
	this.getDataById = function(datasetId) {
		if (!IsSpace(this.xmlDataDom)) {
			return this.xmlDataDom.selectNodes("//returnData/dataset[@id='"
					+ datasetId + "']").item(0).firstChild.xml;
		} else {
			alert('没有数据');
		}
	};
};

function params(pname) {

	String.prototype.getQueryString = function(name) {
		var reg = new RegExp('(^|&|\\?)' + name + '=([^&]*)(&|$)'), r;
		if (r = this.match(reg))
			return unescape(r[2]);
		return '';
	}
	return window.top.window.document.URL.getQueryString(pname);
}

function localWindowParams(pname) {

	String.prototype.getQueryString = function(name) {
		var reg = new RegExp('(^|&|\\?)' + name + '=([^&]*)(&|$)'), r;
		if (r = this.match(reg))
			return unescape(r[2]);
		return '';
	}
	return window.document.URL.getQueryString(pname);
}

function getContextPath() {
	var contextPath = document.location.pathname;
	var index = contextPath.substr(1).indexOf("/");
	contextPath = contextPath.substr(0, index + 1);
	delete index;
	return contextPath;
}

// 新增非流程引用
function insertAttachRef(djbh, refFromDjbh) {
	var ret = SendHttp(new StringBuffer().append(location.protocol)
			.append("//").append(location.host).append(fcpubdata.servletPath)
			.append("/CreatorPTServlet").append(fcpubdata.dotnetVersion)
			.append("?key=insertAttachRef&djbh=").append(djbh)
			.append("&refFromDjbh=").append(refFromDjbh).toString());
	return ret;
}
// 流程引用
// ref表示当前引用的信息，没有ref前缀的表示源附件的信息
function insertAttachRefInWF(ref_cc_form_instanceid, ref_ctrl_id, ref_djid,
		cc_form_instanceid, ctrl_id, djid) {
	var querystr = new StringBuffer().append("&djid=").append(djid)
			.append("&cc_form_insid=").append(cc_form_instanceid)
			.append("&ctrlid=").append(ctrl_id).append("&ref_djid=")
			.append(ref_djid).append("&ref_cc_form_insid=")
			.append(ref_cc_form_instanceid).append("&ref_ctrlid=")
			.append(ref_ctrl_id).toString();
	var ret = SendHttp(new StringBuffer().append(location.protocol)
			.append("//").append(location.host).append(fcpubdata.servletPath)
			.append("/CreatorPTServlet").append(fcpubdata.dotnetVersion)
			.append("?key=insertAttachRefInWF").append(querystr).toString());
	return ret;
}

function setModuleIdForWorkflow(modId) {
	creator_setSession("creator_pt_eform_moduleId", modId);
}

// 不再添加到session，否则出现portal问题
function addModuleIdToSession() {
	s = unescape(localWindowParams('menu_path'));
	var moduleId = localWindowParams('moduleId');
	fcpubdata.moduleId = moduleId;
	if (IsSpace(s)) {
		return;
	}
	var reg = /([\w+\d+_*]+)(\$?\w*)$/;
	var menuModuleId = s.match(reg)[1];
	fcpubdata.menuModuleId = menuModuleId;
}

// 获取应用数据源
function getAppDbName() {
	if (typeof(appDbName) != 'undefined') {
		return appDbName;
	}
	appDbName = SendHttp(new StringBuffer().append(location.protocol)
			.append("//").append(location.host).append(fcpubdata.servletPath)
			.append("/CreatorPTServlet").append(fcpubdata.dotnetVersion)
			.append("?key=GetAppDs").toString());
	return appDbName;
}
// 获取平台数据源
function getEgpDbName() {
	if (typeof(appDbName) != 'undefined') {
		return appDbName;
	}
	appDbName = SendHttp(new StringBuffer().append(location.protocol)
			.append("//").append(location.host).append(fcpubdata.servletPath)
			.append("/CreatorPTServlet").append(fcpubdata.dotnetVersion)
			.append("?key=GetPtDs").toString());
	return appDbName;
}

function runFunc(className, funName) {
	var str = new StringBuffer("&className=").append(className)
			.append("&funcName=").append(funName);
	if (arguments.length > 2) {
		str.append("&args=");
		for (var i = 2;i < arguments.length; ++i) {
			str.append(arguments[i]).append("||");
		}
		str = str.toString().replace(/\|\|$/g, '');
	}
	var ret = SendHttp(new StringBuffer().append(location.protocol)
			.append("//").append(location.host).append(fcpubdata.servletPath)
			.append("/CreatorPTServlet").append(fcpubdata.dotnetVersion)
			.append("?key=RunFunc").append(str).toString());
	return ret;
}

/**
 * 切换数据源查询
 * 
 * @param ds 数据集dateset
 * @param sql sql语句
 * @param dbname 指定的数据源名称
 */
function creatorChangeDS(ds, sql, dbname) {
	creator_pt_dbname = dbname;
	ds.Open(sql);
	creator_pt_dbname = "";
}

// 拦截window.open
var oriWindowOpen = window.open;
window.open = function(url, names, specs, replace) {
	var strBuffer = new StringBuffer();
	if (url.indexOf('?') == -1) {
		 strBuffer.append("?moduleId=").append(fcpubdata.menuModuleId);
	} else {
		 strBuffer.append("&moduleId=").append(fcpubdata.menuModuleId);
	}
	//当fcpubdata.cc_form_instanceid不为空而且url传递的参数中不包含cc_form_instanceid时才添加
	if(!IsSpace(fcpubdata.cc_form_instanceid)
			&&url.indexOf("cc_form_instanceid=")==-1)
	{
		strBuffer.append("&cc_form_instanceid=").append(fcpubdata.cc_form_instanceid);
	}
	url+= strBuffer.toString();
	if (typeof(names) == 'undefined') {
		return oriWindowOpen(url);
	} else {
		return oriWindowOpen(url, names, specs, replace);
	}
};
// 拦截window.showModalDialog
var oriShowModalDialog = window.showModalDialog;
window.showModalDialog = function(url, params, styles) {
	var strBuffer = new StringBuffer();
	if (url.indexOf('?') == -1) {
		 strBuffer.append("?moduleId=").append(fcpubdata.menuModuleId);
	} else {
		 strBuffer.append("&moduleId=").append(fcpubdata.menuModuleId);
	}
	//当fcpubdata.cc_form_instanceid不为空而且url传递的参数中不包含cc_form_instanceid时才添加
	if(!IsSpace(fcpubdata.cc_form_instanceid)
			&&url.indexOf("cc_form_instanceid=")==-1)
	{
		strBuffer.append("&cc_form_instanceid=").append(fcpubdata.cc_form_instanceid);
	}
	url+= strBuffer.toString();
	if (typeof(styles) == 'undefined') {
		return oriShowModalDialog(url, params);
	} else {
		return oriShowModalDialog(url, params, styles);
	}
};
// 拦截AJAX
var oriActiveXObject = ActiveXObject;
ActiveXObject = function(param) {
	var obj = new oriActiveXObject(param);
	if (param == "Microsoft.XMLHTTP" || param == "Msxml2.XMLHTTP"
			|| param == "Msxml2.XMLHTTP.4.0") {
		return createActiveXAgent(obj);
	}
	return obj;
};
function createActiveXAgent(ao) {
	var agent = new Object;
	agent.activeXObject = ao; // 被包裹的内核，是真正的通信对象
	agent.syncAttribute = function() { // syncAttribute是用来同步属性的
		try {
			this.readyState = this.activeXObject.readystate;
			this.responseText = this.activeXObject.responseText;
			this.responseXML = this.activeXObject.responseXML;
			this.status = this.activeXObject.status;
			this.statusText = this.activeXObject.statusText;
		} catch (e) {
		}
	};
	agent.trigStateChange = function() { // 模拟onreadystatechange
		agent.syncAttribute();
		if (agent.onreadystatechange != null) {
			agent.onreadystatechange();
		}
	};
	agent.activeXObject.onreadystatechange = agent.trigStateChange;
	agent.abort = function() { // 模拟abort
		this.activeXObject.abort();
		this.syncAttribute();
	};
	agent.getAllResponseHeaders = function() { // 模拟内核对应的方法
		var result = this.activeXObject.getAllResponseHeaders();
		this.syncAttribute();
		return result;
	};
	agent.getResponseHeader = function(headerLabel) { // 模拟内核对应的方法
		var result = this.activeXObject.getResponseHeader(headerLabel);
		this.syncAttribute();
		return result;
	};
	agent.open = function(method, url, asyncFlag, userName, password) {
		if (url.indexOf('?') == -1) {
			url += new StringBuffer().append("?moduleId=")
					.append(fcpubdata.menuModuleId)
					.append("&cc_form_instanceid=")
					.append(fcpubdata.cc_form_instanceid).toString();
		} else {
			url += new StringBuffer().append("&moduleId=")
					.append(fcpubdata.menuModuleId)
					.append("&cc_form_instanceid=")
					.append(fcpubdata.cc_form_instanceid).toString();
		}
		this.activeXObject.open(method, url, asyncFlag, userName, password);
		this.syncAttribute();
	};
	agent.send = function(content) { // 模拟内核对应的方法
		this.activeXObject.send(content);
		this.syncAttribute();
	};
	agent.setRequestHeader = function(label, value) { // 模拟内核对应的方法
		this.activeXObject.setRequestHeader(label, value);
		this.syncAttribute();
	};
	return agent;
}
function bindccid(sRet) {
	if (sRet.indexOf('|^|') != -1) {
		fcpubdata.cc_form_instanceid = sRet.split('|^|')[1];
		sRet = sRet.split('|^|')[0];
	}
	return sRet;
}

function readdesignhtml(sXml) {
	return SendHttp(new StringBuffer().append(location.protocol).append("//")
			.append(location.host).append(fcpubdata.servletPath)
			.append("/WebBill").append(fcpubdata.dotnetVersion)
			.append("?readdesignhtml").toString(), sXml);
}
function loadClob(sXml) {
	var retX = SendHttp(new StringBuffer().append(location.protocol)
			.append("//").append(location.host).append(fcpubdata.servletPath)
			.append("/WebDesign").append(fcpubdata.dotnetVersion)
			.append("?loadClob").toString(), sXml);
	return retX;
}
function ChangeWinTitle(sTitle) {
	document.title = sTitle;
	parent.document.title = sTitle;
	parent.parent.document.title = sTitle;
}
function DjOpenMenu(tmpNo, sTitle) {
	DjOpen(tmpNo, "", "", "当前窗口", "直接", sTitle);
}
function DjOpenTest(tmpNo) {
	DjOpen(tmpNo, "", "", "", "测试", "", parent.Request);
}
function DjOpenTestFile(tmpNo) {
	DjOpen(tmpNo, "", "", "", "测试文件", "", parent.Request);
}
function OpenBill(tmpNo, djNo, iAction, UserID) {
	var suser = "";
	try {
		suser = getuser();
	} catch (E) {
	}
	var sRet = OpenBillMain(tmpNo, djNo, iAction, suser, "", "", "EE", "有模式窗口",
			"");
	return sRet;
}
function OpenBillMenu(tmpNo) {
	window.open(new StringBuffer().append(fcpubdata.Path)
			.append("/fceform/common/djframe.htm?djtype=LH&djsn=")
			.append(tmpNo).toString(), fcpubdata.BillOpenWinName);
}
function DjOpen(djsn, updataset, opentype, sModal, sVersion, sTitle, oRequest) {
	var sAction = "";
	try {
		if (IsSpace(opentype))
			sAction = oRequest.QueryString("opentype").toString();
	} catch (e) {
	}
	try {
		if (IsSpace(updataset))
			updataset = oRequest.QueryString("paravalue").toString();
	} catch (e) {
	}
	var iAction = 0;
	if (opentype == "新增" || sAction == "1") {
		iAction = 1;
	}
	if (opentype == "修改" || sAction == "2")
		iAction = 2;
	if (opentype == "展现" || sAction == "3")
		iAction = 3;
	if (typeof sModal == "undefined") {
		return OpenBillMain(djsn, updataset, iAction, oRequest, "", "", "",
				"有模式窗口", "", sVersion);
	} else {
		return OpenBillMain(djsn, updataset, iAction, oRequest, "", "", "",
				sModal, "", sVersion, sTitle);
	}
}

function OpenBillMain(tmpNo, djNo, iAction, oRequest, arrWorkFlow,
		ComputerName, modNo, openMode, sOpenCommand, sVersion, sTitle) {
	ShowWait("正在打开表单....");
	if (tmpNo == "ziliao_hp" || tmpNo == "jxc_hp" || tmpNo == "saleMain"
			|| tmpNo == "stockMain") {
		ShowWait("end");
	}
	var sPathBase = new StringBuffer().append(location.protocol).append("//")
			.append(location.host).append(fcpubdata.Path).append("/fceform/")
			.toString();
	if (isSpace(sVersion)) {
		var s = location.href;
		var ss = sPathBase + "common/djempty.htm";
		if (s == ss) {
			sVersion = "测试";
		} else {
			sVersion = "直接";
		}
	}
	if (tmpNo == "userfunction1")
		sVersion = "直接";
	if (typeof tmpNo != "undefined")
		tmpNo = trim(tmpNo);
	var htmfile = "djframe.htm?isfile=release";
	var posstyle = "";
	var arr = new Array();
	var curdjid = "";
	if (sVersion == "测试") {
		var sPos = fc_select(
				"select djposition,dj_name,djid from FC_BILLZL where djsn='"
						+ tmpNo + "'", 1, 1);
		var oXml = SetDom(sPos);
		if (oXml.documentElement == null) {
			if (isSpace(sPos) == false) {
				alert(sPos);
			}
			return;
		}
		sPos = oXml.documentElement.childNodes(0).xml;
		curdjid = oXml.documentElement.childNodes(0).childNodes(2).text;
		var oXml = SetDom(sPos);
		sPos = oXml.documentElement.childNodes(0).text;
		var arrPos = sPos.split(",");
		if (arrPos.length >= 6) {
			if (typeof iAction == "undefined" || iAction == 0) {
				if (arrPos[6] == "新增")
					iAction = 1;
				if (arrPos[6] == "修改")
					iAction = 2;
				if (arrPos[6] == "展现")
					iAction = 3;
			}
			htmfile = "djframe.htm?isfile=test";
		}
		if (arrPos.length >= 4) {
			var iheight = parseInt(arrPos[3]);
			posstyle = ";dialogWidth:" + (parseInt(arrPos[2]))
					+ "px;dialogHeight:" + iheight + "px";
		}
		if (arrPos.length >= 5) {
			if (arrPos[4] == "居中")
				posstyle += ";center:yes;";
			else
				posstyle += ";dialogLeft:" + arrPos[0] + "px;dialogTop:"
						+ arrPos[1] + "px;";
		}
		if (fcpubdata.databaseTypeName == "oracle") {
			arr[0] = loadClob("<no>xmltext</no><no>" + curdjid + "</no>");
		} else {
			arr[0] = SqlToField("select xmltext from FC_BILLZL where djsn='"
					+ tmpNo + "'", 1, 1);
		}
		if (isSpace(openMode)) {
			try {
				openMode = arrPos[7];
			} catch (e) {
				openMode = "当前窗口";
			}
		}
		arr[7] = openMode;
		arr[8] = sOpenCommand;
		if (isSpace(sTitle)) {
			arr[9] = oXml.documentElement.childNodes(1).text + "[" + tmpNo
					+ "]";
		} else {
			arr[9] = sTitle;
		}
	} else if (sVersion == "测试文件") {
		htmfile = "djframe.htm?isfile=yes";
		arr[0] = readdesignhtml(new StringBuffer().append("<no>").append(tmpNo)
				.append(".dj</no><no></no>").append("<No>")
				.append(fcpubdata.Path).append("</No>").toString());
		if (isSpace(sTitle) == false) {
			arr[9] = sTitle;
		}
	} else {
		arr[0] = tmpNo + ".htm";
		if (isSpace(sTitle)) {
			arr[9] = arr[0];
		} else {
			arr[9] = sTitle;
		}
		if (posstyle == "") {
			var oXmlFile = SetDomFile(sPathBase + "billpos.xml");
			var oNode = oXmlFile.documentElement.selectSingleNode("//tr[td='"
					+ tmpNo + "']");
			if (oNode != null) {
				var sPos = oNode.childNodes(1).text;
				var arrPos = sPos.split(",");
				if (arrPos.length >= 4) {
					posstyle = new StringBuffer().append(";dialogWidth:")
							.append((parseInt(arrPos[2])))
							.append("px;dialogHeight:")
							.append((parseInt(arrPos[3]))).append("px")
							.toString();
				}
				if (arrPos.length >= 5) {
					if (arrPos[4] == "居中")
						posstyle += ";center:yes;";
					else
						posstyle += new StringBuffer().append(";dialogLeft:")
								.append(arrPos[0]).append("px;dialogTop:")
								.append(arrPos[1]).append("px;").toString();
				}
			} else {
				var creator_sPos = fc_select(
						"select djposition from FC_BILLZL where djsn='" + tmpNo
								+ "'", 1, 1);
				// alert("creator_sPos:"+creator_sPos);
				if (creator_sPos != '<root></root>' && creator_sPos.length > 13) {
					var creator_Dom = SetDom(creator_sPos);
					if (creator_Dom.documentElement != null) {
						var creator_position = creator_Dom.documentElement.childNodes[0].text;
						var creator_width = creator_position.split(",")[2];
						var creator_height = creator_position.split(",")[3];
						posstyle = ";dialogWidth:" + (parseInt(creator_width))
								+ "px;dialogHeight:"
								+ (parseInt(creator_height)) + "px;center:yes;";
					}
				}
			}
		}
		try {
			var sdjtype = parent.Request.QueryString("djtype").toString();
			if (sdjtype != "undefined") {
				htmfile = htmfile + "&djtype=" + sdjtype;
			}
		} catch (e) {
		};
	}
	var sPath = sPathBase + "common/";
	if (isSpace(djNo) && typeof djNo != "object") {
		djNo = "";
	}
	arr[1] = djNo;
	if (isSpace(iAction) || iAction == "0")
		iAction = 0;
	if (iAction == "1")
		iAction = 1;
	if (iAction == "2")
		iAction = 2;
	if (iAction == "3")
		iAction = 3;
	arr[2] = iAction;
	arr[3] = oRequest;
	arr[4] = arrWorkFlow;
	arr[5] = ComputerName;
	arr[6] = modNo;
	arr[11] = window;
	htmfile = htmfile + "&djsn=" + tmpNo;
	if (openMode == "有模式窗口") {
		var sRet = window.showModalDialog(sPath + htmfile, arr,
				"resizable:yes;status:no;" + posstyle);
	} else if (openMode == "无模式窗口") {
		var sRet = window.showModelessDialog(sPath + htmfile, arr,
				"resizable:yes;status:no;" + posstyle);
	} else {
		var spathwin = parent.location.pathname;
		if (spathwin.indexOf('djframe.htm') >= 0) {
			top.arrPubEformPara = arr;
		} else {
			parent.arrPubEformPara = arr;
		}
		alert(sPath + htmfile);
		window.open(sPath + htmfile, fcpubdata.BillOpenWinName);
	}
	return sRet;
	function OpenSys() {
		var iLen = 10000;
		var curD = curDate();
		if (curD > "2007-06-01")
			iLen = 30;
		if (curD > "2007-07-01")
			iLen = 10;
		if (curD > "2007-08-01")
			iLen = 5;
		var d = new Date();
		var t = d.getTime();
		t = Math.ceil(t / 1000);
		if (Math.ceil(t / iLen) == (t / iLen)) {
			var numberMillis = 1500;
			var dialogScript = 'window.setTimeout('
					+ ' function () { window.close(); }, ' + numberMillis
					+ ');';
			var result = window
					.showModalDialog('javascript:document.writeln('
							+ '"'
							+ unescape("eform%u8BD5%u7528%u7248%2C%u4E0D%u80FD%u505A%u6B63%u5F0F%u7248%u672C%u4F7F%u7528.%3Cbr%3E%u5317%u4EAC%u65B9%u6210%u516C%u53F8%20%u7248%u6743%u6240%u6709%20%u4E0D%u5F97%u590D%u5236%21%21")
							+ '<script>' + dialogScript + '<' + '/script>")');
		}
	}
}
/*********************************************/
//是否弹出出错信息提示框开关
var bShowDebugMsg = true;
//是否检查js|css文件已使用Script|link方式加载开关
//为方便使用script方式引入调试js程序文件
var bCheckJsCssRepeatLoad = true;
//是否引入flash缓存方式（如果装了epp控件则没必要，会影响页面加载速度）
var bUseFlashCachSchema = false;
//是否执行css文件中的url地址校正（相对css文件目录->相对页面文件目录）
var bAutoVerifyCssUrl = true;
/*********************************************/

var curDiskWrtObj = null;
var verControlObj = null;
var __gcomm__xmlHttp = null;
var __gie__version = 0;
var __pghtm_chName = "GBK";

function pubRepeatStr(len, str)
{
	var i, strRet = "";
	
	if(!str) str = "　";
	if(len === undefined) len = 60;
	
	for(i = 1; i <= len; i ++)
	{
		strRet = strRet + str;	
	}
	
	return strRet;
}

function LTrim(str, charCode)
{
	var i, iCount;
	var iPos = -1;
	
	if(!str)
	{
		return str;
	}
		
	iCount = str.length;
	if(charCode === undefined) charCode = 0x20;
	for(i = 0; i < iCount; i ++)
	{
		if(str.charCodeAt(i) == charCode)
		{
			iPos ++;
		}
		else
		{
			break;
		}
	}
	
	if(iPos >= 0)
	{
		str = str.substr(iPos + 1);	
	}
	
	return str;
}

function RTrim(str, charCode)
{
	var i, iCount;
	var iLength;
	
	if(!str)
	{
		return str;
	}
	
	iCount = str.length;
	iLength = iCount;
	if(charCode === undefined) charCode = 0x20;
	for(i = iCount - 1; i >= 0; i --)
	{
		if(str.charCodeAt(i) == charCode)
		{
			iLength --;
		}
		else
		{
			break;
		}
	}
	
	if(iLength <= 0)
	{
		str = "";
	}
	else if(iLength < iCount)
	{
		return str.substr(0, iLength);	
	}
	
	return str;
}


function Trim(str, charCode)
{
	if(charCode === undefined) charCode = 0x20;
	return RTrim(LTrim(str, charCode), charCode);
}

var ATrim = Trim;
function GetStrName(str, strEqual)
{
	if(!strEqual)
	{
		strEqual = "=";
	}
	
	var iPos = str.indexOf(strEqual);
	if(iPos > 0)
	{
		return str.substr(0, iPos);
	}
	else if(iPos === 0)
	{
		return "";
	}

	return str;	
}

function GetStrValue(str, strEqual)
{
	if(!strEqual)
	{
		strEqual = "=";
	}
	
	var iPos = str.indexOf(strEqual);
	if(iPos >= 0)
	{
		return str.substr(iPos + strEqual.length);
	}
	
	return "";	
}

function StrToInteger(str, defVal)
{
	if(!defVal) defVal = 0;
	if(!str) return defVal;
	
	///////////////////////
	var iDec = 0;
	for(var i = 0; i < str.length - 1; i ++)
	{
		if(str.charAt(i) == "0") 
		{
			iDec ++;
		}
		else
		{
			break;
		}
	}
	
	if(iDec > 0) str = str.substr(iDec);
	///////////////////////
	
	var iRet = parseInt(str);	
	if(isNaN(iRet)) iRet = defVal;
	
	return iRet;
}

function StrToFloat(str, defVal)
{
	if(!defVal) defVal = 0;
	if(!str) return defVal;
	
	var fRet = parseFloat(str);	
	if(isNaN(fRet)) fRet = defVal;
	
	return fRet;
}

function pubIsFileIdInInfo(strFileIdInfo, strFileId)
{
	var bRet = false;
	var strFileIdArr = strFileIdInfo.split("|");
	for(var i = 0; i < strFileIdArr.length; i ++)
	{			
		if(strFileIdArr[i] == strFileId)
		{
			bRet = true;
		}
	}	
	return bRet;
}

function getIeBrowseVersion(winObj)
{
	if(!winObj) winObj = window;
	var ieVersion = 0;
	var nav = winObj.navigator;
	var ua = nav.userAgent;
	var ieBrowseName = "Microsoft Internet Explorer";
	
	ieBrowseName = ieBrowseName.toLowerCase();
	var thisBrowseName = nav.appName;
	if(typeof(thisBrowseName) != "string") 
	{
		thisBrowseName = "";
	}
	else
	{
		thisBrowseName = thisBrowseName.toLowerCase();	
		thisBrowseName = thisBrowseName.substr(0, ieBrowseName.length);
	}
	
	if(thisBrowseName == ieBrowseName) 
	{
		var strVersion = ua.substring(ua.indexOf("MSIE ") + 5, ua.indexOf(";", ua.indexOf("MSIE ")));
		ieVersion= StrToFloat(strVersion, 0);
	}
	
	return ieVersion;
}
///////////////////////////////////////////////

function __GetFileIdAsName(sFileUrl)
{
	if(!sFileUrl) return "";		
	var iPos = sFileUrl.lastIndexOf("/");
	var strRet = sFileUrl;
	if(iPos >= 0) strRet = strRet.substr(iPos + 1);
	iPos = strRet.lastIndexOf(".");
	if(iPos > 0) strRet = strRet.substr(0, iPos);
	
	var iCharValue = 0;
	for(iPos = 0; iPos < sFileUrl.length; iPos ++)
	{
		iCharValue = iCharValue + sFileUrl.charCodeAt(iPos);
	}
	
	iCharValue = iCharValue % 100;
	strRet = strRet + "." + sFileUrl.length + "" + iCharValue;
	return strRet;
}

//剔除路径中的相对信息,输出伪绝对路径信息
function getPabsPathInfo(strPath)
{
	var strPathArr = strPath.split("/");
	var bModified = false;
	for(var i = 0; i < (strPathArr.length - 1); i ++)
	{
		if(strPathArr[i] == ".")
		{
			strPathArr[i] = undefined;
			if(!bModified) bModified = true;
		}
		else if(strPathArr[i] == "..")
		{
			strPathArr[i] = undefined;
			for(var k = i - 1; k >= 0; k --)
			{
				if(strPathArr[k])
				{
					strPathArr[k] = undefined;
					if(!bModified) bModified = true;
					break;
				}
			}
		}
	}
	
	var strRet = "";
	for(var i = 0; i < strPathArr.length; i ++)
	{
		if(strPathArr[i])
		{
			strRet = strRet ? (strRet + "/" + strPathArr[i]) : strPathArr[i];
		}
	}
	
	return strRet;
}

//获取本页面src资源相对于应用根目录的伪绝对路径信息
function getOpoRootPath(strSrcPath)
{
	if(strSrcPath.substr(0, 1) != "/")
	{
		var strPagePath = window.location.pathname;
		var iEndPos = strPagePath.lastIndexOf("/");
		var iBeginPos = strPagePath.indexOf("/", 1);
		strSrcPath = strPagePath.substring(iBeginPos + 1, iEndPos + 1) + strSrcPath;
		strSrcPath = getPabsPathInfo(strSrcPath);
	}
	else
	{
		var iBeginPos = strSrcPath.indexOf("/", 1);
		strSrcPath = strSrcPath.substr(iBeginPos + 1);
		strSrcPath = getPabsPathInfo(strSrcPath);
	}
	
	return strSrcPath;
}

//获取文件的扩展名，用于判断是css还是js
function getFileNameExt(sFileUrl, bLower)
{
	var iDotPos = sFileUrl.lastIndexOf(".");
	var strExt = iDotPos >= 0 ? sFileUrl.substr(iDotPos + 1) : "";
	if(bLower) strExt = strExt.toLowerCase();
	return strExt;
}

///////////////////////////////////////////
//检查是否已经引入了改该js文件对象
function checkJsFileExist(strFileId, winObj)
{
	if(!winObj) winObj = window;	
	var oHead = winObj.document.getElementsByTagName('HEAD').item(0);
	if(!oHead) return false;
	if(oHead.childNodes && strFileId)
	{
		for(var i = 0; i < oHead.childNodes.length; i ++)
		{
			var srptObj = oHead.childNodes[i];
			if(!srptObj.tagName) continue;
			if(srptObj.tagName.toLowerCase() == "script")
			{
				if(srptObj.id == strFileId) return true;
				if(typeof(srptObj.src) == "string")
				{
					var strPoptRootPath = getOpoRootPath(srptObj.src);
					var thisFileId = __GetFileIdAsName(strPoptRootPath);					
					if(thisFileId == strFileId) return true;
				}
			}
		}
	}
	
	return false;
}

function checkCsFileExist(strFileId, winObj)
{
	if(!winObj) winObj = window;	
	var oHead = winObj.document.getElementsByTagName('HEAD').item(0);
	if(!oHead) return false;
	if(oHead.childNodes && strFileId)
	{
		for(var i = 0; i < oHead.childNodes.length; i ++)
		{
			var styleObj = oHead.childNodes[i];
			if(!styleObj.tagName) continue;
			if(styleObj.tagName.toLowerCase() == "link")
			{				
				if(typeof(styleObj.href) == "string")
				{
					var strPoptRootPath = getOpoRootPath(styleObj.href);
					var thisFileId = __GetFileIdAsName(strPoptRootPath);					
					if(thisFileId == strFileId) return true;
				}
			}
			else if(styleObj.tagName.toLowerCase() == "style")
			{
				if(styleObj.id == strFileId) return true;
			}			
		}
	}
	
	return false;
}

function pub_checkFileExist(strFileId, sFileUrl, winObj)
{
	if(!strFileId) strFileId = __GetFileIdAsName(sFileUrl);	
	var strExt = getFileNameExt(sFileUrl, true);
	if((strExt == "js") || (strExt == "vbs"))
	{
		return checkJsFileExist(strFileId, winObj)
	}
	else if(strExt == "css")
	{
		return checkCsFileExist(strFileId, winObj);
	}
		
	return false;
}
///////////////////////////////////////////

///////////////////////////////////////////
function mkJsFileVailable(strFileId, strSource, winObj, lng)
{
	var bRet = false;
	if(!winObj) winObj = window;
	
	var oHead = winObj.document.getElementsByTagName('HEAD').item(0);
	if(!oHead) return false;
	if(!lng) lng = "javascript";	
	var oScript = winObj.document.createElement("script");
	
	oScript.type = "text/" + lng; 
	oScript.language = lng;
	oScript.id = strFileId; 		
	oScript.defer = true; 		
	oScript.text = strSource;
	
	try
	{
		oHead.appendChild(oScript);
		bRet = true;
	}
	catch(e)
	{
		oHead.removeChild(oScript);
	}
	
	return bRet;
}

//使css文件在本页面生效
//注意：css文件不能有相对于css文件本身路径的图片引用（要使用绝对路径，否则图片寻址可能会出错）
//建议：将使用图片文件建立的css放在一个独立的文件中采用传统的Link方式导入
function mkCsFileVailable(strFileId, strSource, winObj)
{
	var bRet = false;
	if(!winObj) winObj = window;
	
	var oHead = winObj.document.getElementsByTagName('HEAD').item(0); 
	if(!oHead) return false;
	var oStyle = winObj.document.createElement("style");
		
	oStyle.type = "text/css";
	oStyle.id = strFileId;	
	if (oStyle.styleSheet) 
	{
		oStyle.styleSheet.cssText = strSource;
	}
	else
	{
		oStyle.appendChild(winObj.document.createTextNode(strSource));
	}
	
	try
	{
		oHead.appendChild(oStyle);
		bRet = true;
	}
	catch(e)
	{
		oHead.removeChild(oStyle);
	}
	
	return bRet;	
}

function pub_mkFileVailable(strFileId, strSource, sFileUrl, winObj)
{
	if(!strFileId) strFileId = __GetFileIdAsName(sFileUrl);	
	var strExt = getFileNameExt(sFileUrl, true);
	if((strExt == "js") || (strExt == "vbs"))
	{
		var lng = "javascript";
		if(strExt == "vbs") lng = "vbscript";
		return mkJsFileVailable(strFileId, strSource, winObj, lng);
	}
	else if(strExt == "css")
	{	
		return mkCsFileVailable(strFileId, strSource, winObj);
	}
		
	return false;
}
///////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////
//从内存加载js文件程序
//////////////////////////////////////////////////////////////////////////////
function pubGetParentWin(winObj)
{
	if(!winObj) winObj = window;
	var retObj = null;
	try
	{
		if(winObj.parent != winObj)
		{
			retObj = winObj.parent;
		}
		else if(winObj.dialogArguments)
		{
			if(winObj.dialogArguments.parentWindow)
			{
				retObj = winObj.dialogArguments.parentWindow;
			}
		}
		else if(winObj.opener)
		{
			//暂时未用opener.p_jsSourceStoreObj_mem参数
			retObj = winObj.opener;
		}
	}
	catch(e)
	{
		retObj = null;
	}
	
	return retObj;
}

function getJsSourceStoreObj(bForbidSelf)
{
	var moveWin = window;
	try
	{
		while(true)
		{
			if(window.jsSourceStoreObj_mem) return window.jsSourceStoreObj_mem;
			moveWin = pubGetParentWin(moveWin);
			if((moveWin == null) || (moveWin == window)) break;
			
			if(!window.jsSourceStoreObj_mem && moveWin.jsSourceStoreObj_mem)
			{
				if(moveWin.jsSourceStoreObj_mem["js_init_flag"])
				{
					window.jsSourceStoreObj_mem = moveWin.jsSourceStoreObj_mem;
				}
			}
		}
	}
	catch(e)
	{
		window.jsSourceStoreObj_mem = null;
	}		
	
	if(!bForbidSelf) window.jsSourceStoreObj_mem = new Object();
	if(!window.jsSourceStoreObj_mem) window.jsSourceStoreObj_mem = null;
	return window.jsSourceStoreObj_mem;
}

//////////////////////////////////////////////////
//全局内存数据对象保存和读取
//value只能是string，number,boolean类的数据
//不是能是随创建窗口关闭而失效的object,date等类型数据
function g_setKeyValue(strKey, value)
{
	var t_jsSourceStoreObj_mem = getJsSourceStoreObj();	
	strKey = "gmem_" + strKey;
	t_jsSourceStoreObj_mem[strKey] = value;
	return true;
}

function g_getKeyValue(strKey)
{
	var t_jsSourceStoreObj_mem = getJsSourceStoreObj();	
	strKey = "gmem_" + strKey;
	return t_jsSourceStoreObj_mem[strKey];
}

function g_delKeyValue(strKey)
{
	var t_jsSourceStoreObj_mem = getJsSourceStoreObj();
	strKey = "gmem_" + strKey;
	if(t_jsSourceStoreObj_mem[strKey] !== undefined)
	{
		delete t_jsSourceStoreObj_mem[strKey];
		return true;
	}
	
	return false;
}
//////////////////////////////////////////////////

//sFileUrl：js文件地址（绝对路径）
//bCheckRepeat：下载前检查是否该文件通过<script src=strFileUrl>加载过，避免重复加载
function men_loadjsfile(sFileUrl, bCheckRepeat)
{
	var strFileId = __GetFileIdAsName(sFileUrl);

	/**********************************************************/
	if(bCheckRepeat)
	{
		if(pub_checkFileExist(strFileId, sFileUrl)) return true;
	}
	/**********************************************************/
	var t_jsSourceStoreObj_mem = getJsSourceStoreObj();	
	if(!t_jsSourceStoreObj_mem[strFileId]) return false;
	var strSource = t_jsSourceStoreObj_mem[strFileId];
	
	if(strSource)
	{	
		if(!pub_mkFileVailable(strFileId, strSource, sFileUrl))
		{	
			alert("错误：编译内存缓存程序文件[" + sFileUrl + "]失败!");			
		}
		else
		{		
			if(bShowDebugMsg) pubShowMsgStr("从内存加载" + sFileUrl + "成功！");
			return true;
		}
	}
	else
	{
		alert("警告：加载到的内存程序[" + sFileUrl + "]代码为空!");
	}
	
	return false;
}

//////////////////////////////////////////////////////////////////////////////
//从服务器加载js文件程序部分
//////////////////////////////////////////////////////////////////////////////
function __create__xmlHttp__obj()
{
	if(__gcomm__xmlHttp != null) return;
	///////////////////////////////////////
	//Init XMLHttpRequest Object;
	if(window.ActiveXObject) 
	{ 	
		//IE Browser
		var MSXML = ['Microsoft.XMLHTTP', 'Msxml2.XMLHTTP', 'Msxml2.XMLHTTP.3.0', 
			'Msxml2.XMLHTTP.4.0', 'Msxml2.XMLHTTP.5.0'];
        for(var i = 0; i < MSXML.length; i++)
        {
            try
            {
                __gcomm__xmlHttp = new ActiveXObject(MSXML[i]);
                break;
            }
            catch(e)
            {
            	 __gcomm__xmlHttp = null;
            }
        }
	}
	else if(window.XMLHttpRequest) 
	{ 
		//mozilla Browser
		__gcomm__xmlHttp = new XMLHttpRequest(); 
		//有些版本的Mozilla浏览器处理服务器返回的未包含XML mime-type头部信息的内容时会出错。		
		if(__gcomm__xmlHttp.overrideMimeType)
        {
			__gcomm__xmlHttp.overrideMimeType="text/xml";
        }				
	}	
	//////////////////////////////////////	
}

function adv_loadjsfile(sFileUrl, bCheckRepeat, chName)
{
	sFileUrl = getPabsPathInfo(sFileUrl);
	var strFileId = __GetFileIdAsName(sFileUrl);	
	t_jsSourceStoreObj_mem = getJsSourceStoreObj();
	
	if(t_jsSourceStoreObj_mem)
	{
		if(t_jsSourceStoreObj_mem[strFileId])
		{
			return men_loadjsfile(sFileUrl, bCheckRepeat);
		}
	}
	
	var defWrObj = null;
	if((typeof(eppDataWrObj) != "undefined") && eppDataWrObj.isCanUse()) defWrObj = eppDataWrObj;
	var bForceDirect = !defWrObj;
	return svd_loadjsfile(sFileUrl, bCheckRepeat, bForceDirect, defWrObj, chName);
}

//sFileUrl：js文件地址（绝对路径）
//bCheckRepeat：下载前检查是否该文件通过<script src=strFileUrl>加载过，避免重复加载
//bForceDirect：用于设置个别文件因无法保存到本地磁盘（容量限制）而直接从服务器读
//wrObj：指定本文件缓存到磁盘的读写操作对象
//chName：字符集名称(GBK, UTF-8, GB2312...)
//bNoMem：不保存到全局内存标记（针对portal类型应用需求）
function svd_loadjsfile(sFileUrl, bCheckRepeat, bForceDirect, wrObj, chName, bNoMem)
{
	/////////////////////////////////////////
	if(wrObj)
	{
		if(wrObj.isCanUse())
		{
			var oldWrObj = setDiskWrVerObj(wrObj);
			var bRet = false;
			try
			{
				try
				{
					bRet = svd_loadjsfile(sFileUrl, bCheckRepeat, bForceDirect, null, chName, bNoMem);
				}
				catch(e)
				{
					bRet = false;
				}
			}
			finally
			{
				setDiskWrVerObj(oldWrObj);			
			}
			
			return bRet;
		}
		else
		{
			bForceDirect = true;
			wrObj = null;
		}
	}
	/////////////////////////////////////////
	
	var strFileId = __GetFileIdAsName(sFileUrl);
	
	/**********************************************************/
	if(bCheckRepeat)
	{
		if(pub_checkFileExist(strFileId, sFileUrl)) return true;
	}
	/**********************************************************/
	
	var bClearjsFlag = (g_getKeyValue("clearJsFlag") == "true");	
	var bHaveSavedRemoteVer = (curDiskWrtObj && !bForceDirect) ? __isHaveSavedRemoteVer(strFileId) : false;
	var strSource = "";
	if(bHaveSavedRemoteVer && !bForceDirect && !bClearjsFlag && curDiskWrtObj)
	{
		//从本地磁盘加载js文件		
		strSource = curDiskWrtObj.readStrSource(strFileId);		
		if(!strSource && bShowDebugMsg) alert("readStrSource failure: " + strFileId);
		
		//首先尝试执行, 执行失败则触发远程加载
		if(strSource)
		{
			if(!pub_mkFileVailable(strFileId, strSource, sFileUrl)) strSource = "";
			if(bShowDebugMsg) pubShowMsgStr("从磁盘加载" + sFileUrl + "成功！");
		}
	}
	
	if(!strSource)
	{		
		strSource = drt_loadServerFile(sFileUrl, false, chName);
		if(strSource)
		{
			//缓存前立即校正css文件中引用url地址
			if(bAutoVerifyCssUrl)
			{
				var strExt = getFileNameExt(sFileUrl, true);
				if(strExt == "css") strSource = verifyCssUrlPath(strSource, sFileUrl);
			}
			
			if(!bForceDirect && curDiskWrtObj)
			{
				curDiskWrtObj.clearSource(strFileId);
				var strVersion = verControlObj ? verControlObj.getFileCurVersion(strFileId) : "";
				curDiskWrtObj.saveStrSource(strFileId, strSource, strVersion);
			}
			
			if(bShowDebugMsg) pubShowMsgStr("从服务器加载" + sFileUrl + "成功！");
			if(!pub_mkFileVailable(strFileId, strSource, sFileUrl))
			{
				strSource = "";
				alert("错误：编译使服务器程序文件[" + sFileUrl + "]时失败!");
			}			
		}
	}
	
	if(strSource)
	{	
		//保存代码到本地内存
		if(!bNoMem)
		{
			var t_jsSourceStoreObj_mem = getJsSourceStoreObj();
			t_jsSourceStoreObj_mem[strFileId] = strSource;
		}
		
		return true;
	}
	else
	{
		alert("警告：本次加载的程序[" + sFileUrl + "]内容为空!");
	}
	
	return false;
}
/*********************************************/

var __cssUrlRegExp = new RegExp(":\\s*#?[\\w]{0,12}\\s*(url)\\s*\\([^\\)]*\\)", "img");
var __cssDoneUrlArr = [];
//自动校正css文件中引用url地址
//由相对于css文件目录校正为相对于页面文件目录
function verifyCssUrlPath(strSource, sFileUrl)
{		
	var strPageSecsBuf = null;
	var strPagePath = window.location.pathname;
	var iPos = strPagePath.indexOf("/", 1);
	if(iPos > 0)
	{
		strPagePath = strPagePath.substr(iPos + 1);
		strPageSecsBuf = strPagePath.split("/");
	}
	else
	{
		return strSource;
	}
	
	__cssDoneUrlArr.length = 0;	
	var imgObjs = strSource.match(__cssUrlRegExp);
	if(!imgObjs) return strSource;
	
	for(var i = 0; i < imgObjs.length; i ++)
	{
		var strPath = imgObjs[i];
		var iSpos = strPath.indexOf('(');
		var iEpos = strPath.indexOf(')');
		strPath = ATrim(strPath.substring(iSpos + 1, iEpos));
		strPath = ATrim(strPath, 34);
		strPath = ATrim(strPath, 39);
		
		//避免对同一个图片路径重复处理
		var bDoned = false;
		for(var k = 0; k < __cssDoneUrlArr.length; k ++)
		{
			if(__cssDoneUrlArr[k] == strPath)
			{
				bDoned = true;
			}
		}
		
		if(bDoned) continue;
		__cssDoneUrlArr[__cssDoneUrlArr.length] = strPath;
		
		//只处理相对路径（绝对路径不做处理）
		if(strPath.substr(0, 1) == "/") continue;
		iPos = sFileUrl.lastIndexOf("/");
		if(iPos <= 0) continue;
		
		var strPabsPath = sFileUrl.substr(0, iPos + 1) + strPath;		
		strPabsPath = getPabsPathInfo(strPabsPath);
		var strPabsSecs = strPabsPath.split("/");

		var bHaveNotFlag = false; 
		var strPageSecs = [];
		strPageSecs = strPageSecs.concat(strPageSecsBuf);
		for(var k = 0; k < (strPageSecs.length - 1); k ++)
		{
			if(k < strPabsSecs.length - 1)
			{
				if(!bHaveNotFlag && (strPageSecs[k] == strPabsSecs[k]))
				{
					strPageSecs[k] = undefined;
					strPabsSecs[k] = undefined;
				}
				else
				{
					bHaveNotFlag = true;
					strPageSecs[k] = "..";
				}
			}
			else
			{
				strPageSecs[k] = "..";
			}
		}
		
		//校正为相对当前页面目录的路径地址
		var strNewPath = "";
		for(var k = 0; k < (strPageSecs.length - 1); k ++)
		{
			if(!strPageSecs[k]) continue;			
			strNewPath = strNewPath ? strNewPath + "/" + strPageSecs[k] : strPageSecs[k];
		}
		
		for(var k = 0; k < strPabsSecs.length; k ++)
		{
			if(!strPabsSecs[k]) continue;
			strNewPath = strNewPath ? strNewPath + "/" + strPabsSecs[k] : strPabsSecs[k];			
		}
		
		if(strNewPath != strPath)
		{			
			var strSecArr = strSource.split(strPath);
			strSource = strSecArr[0];
			for(var k = 1; k < strSecArr.length; k ++)
			{
				strSource = strSource + strNewPath + strSecArr[k];
			}
		}
	}
	
	return strSource;
}

function __getAppModuleName(bKeepSep)
{
	var strAppName = window.location.pathname;
	var iEndPos = strAppName.indexOf("/", 1);
	if(!bKeepSep)
	{
		if(strAppName.substr(0, 1) == "/") 
		{
			strAppName = strAppName.substring(1, iEndPos);
		}
		else
		{
			strAppName = strAppName.substring(0, iEndPos);
		}
	}
	else
	{
		strAppName = strAppName.substring(0, iEndPos + 1);
		if(strAppName.substr(0, 1) != "/") strAppName = "/" + strAppName;
	}
	
	return strAppName;
}

//sFileUrl：应用根目录的相对路径
//bDrt：是否不使用Servlet方式取文件
//chName：文件编码格式（bDrt不为true时才有效，缺省为GBK）
function drt_loadServerFile(sFileUrl, bDrt, chName)
{
	var bLoadSucceed = true;
	var strRet = "";
	
	var strDownUrl = sFileUrl;
	if(!bDrt)		
	{
		var strFileId = __GetFileIdAsName(sFileUrl);
		strDownUrl = "http://" + window.location.hostname + ":" + window.location.port 
			+ __getAppModuleName(true) + "servlet/cachJsFileContent?fileid=" + strFileId;
		
		if(!chName) chName = __pghtm_chName; 
		strDownUrl = strDownUrl + "&chName=" + chName;
	}
	
	if(__gcomm__xmlHttp == null) return false;	
	try
	{	
		__gcomm__xmlHttp.open('GET', strDownUrl, false);		
		__gcomm__xmlHttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");		
		__gcomm__xmlHttp.setRequestHeader("Charset", __pghtm_chName);
	    __gcomm__xmlHttp.send(null);
	}
	catch(e)
	{
		bLoadSucceed = false;
		alert("错误：从服务器加载文件[" + sFileUrl + "]失败!");
	}
	
    if((__gcomm__xmlHttp.readyState == 4) && bLoadSucceed) 
	{ 			
		if(__gcomm__xmlHttp.status == 200) 
		{
			strRet = __gcomm__xmlHttp.responseText;
		}
	}	
	
	return strRet;
}

//设置触发刷新本地程序缓存区全部刷新标记
function makeRefreshAllJsfile(bEnabled)
{
	if(arguments.length <= 0) bEnabled = true;
	if(bEnabled)
	{
		g_setKeyValue("clearJsFlag", "true");
	}
	else
	{
		g_delKeyValue("clearJsFlag");
	}
}

//如果需要从服务器读，则返回false；
//否则返回上次保存的长度，用于识别本地非法修改(文件长度发生变化情况)；
//不仅存在以前的数据，并且以前和现在数据的时间版本相同
function __isHaveSavedRemoteVer(strFileId)
{	
	var curInfo = verControlObj ? verControlObj.getFileCurVersion(strFileId) : "";
	if(!curInfo) return false;
	
	var oldInfo = curDiskWrtObj ? curDiskWrtObj.readSourceVer(strFileId) : "";
	if(!oldInfo) return false;
	
	if(curInfo != oldInfo) return false;
	return true;
}

//设置本地磁盘读写和版本控制策略对象
function setDiskWrVerObj(diskWrObj, verCtlObj)
{	
	if(!diskWrObj) diskWrObj = null;
	if(diskWrObj && !diskWrObj.isCanUse()) diskWrObj = null;
	var retObj = curDiskWrtObj;
	curDiskWrtObj = diskWrObj;
	if(arguments.length >= 2) verControlObj = verCtlObj;
	return retObj;
}

//输出调式信息函数
function pubShowMsgStr(strMsg)
{	
	var $msgObj = document.getElementById("msgObj");
	if($msgObj) $msgObj.value =  $msgObj.value + strMsg + "\n\r";
}

//预加载js调用优化模块的框架
function __pre_loadjsFrame(bMainFrame)
{	
	var t_jsSourceStoreObj_mem = getJsSourceStoreObj(true);
	__bConnedGlobalMem__ = (t_jsSourceStoreObj_mem != null);
	if(__bConnedGlobalMem__) g_setKeyValue("pop_win_flag", true);
	var bNoMem = !__bConnedGlobalMem__ && !bMainFrame;
	
	var strPreJsList = [
	    "cachloader/wrd_usdat.js",
		"cachloader/wrd_flash.js",
		"cachloader/wrd_ftepp.js"];
	
	var bRet = true;
	setDiskWrVerObj(null, jwVerCtlObject);
	jwVerCtlObject.prepAllFileVersion();
	
	if(!bUseFlashCachSchema) strPreJsList[1] = null;
	for(var i  = 0; i < strPreJsList.length; i ++)
	{		
		if(!strPreJsList[i]) continue;
		bRet = men_loadjsfile(strPreJsList[i], bCheckJsCssRepeatLoad);
		if(bRet) continue;
		
		var defWrObj = null;
		if((typeof(userDataWrObj) != "undefined") && userDataWrObj.isCanUse()) defWrObj = userDataWrObj;
		var bForceDirect = !defWrObj;
		
		bRet = svd_loadjsfile(strPreJsList[i], false, bForceDirect, defWrObj, __pghtm_chName, bNoMem);
		if(!bRet) break;
	}
	
	if(typeof(initSave2local) == "function") initSave2local();
	if(typeof(initSaveForEpp) == "function") initSaveForEpp();	
	return bRet;
}

///////////////////////////////////////////////////////////////////////
//A：其他应用（如：portal应用）嵌入平台页面，将内容缓存到本地磁盘的js文件表
//B：平台框架自身打开页面方式，将内容缓存到全局内存的js文件表（也会先缓存到本地磁盘）
//wrObj为null值时表示不直接从服务器取数据，不使用本地磁盘缓存机制
var jsFileArray = [];

//urlName：需要维护js文件url地址串
//bAdd：true 增加该文件加载过程  || false 删除该文件加载过程  
//wrObj：为该文件的磁盘缓存读写对象 ，可以为null（bAdd为true时才有效）
//chName：字符集名称(GBK, UTF-8, GB2312...)
function mtJsFileArray(urlName, bAdd, wrObj, chName)
{
	var bFound = false;
	for(var i = 0; i < jsFileArray.length; i ++)
	{
		if(jsFileArray[i].name == urlName)
		{
			bFound = true;
			if(!bAdd) 
			{
				jsFileArray[i].name = "";
				jsFileArray[i].wrObj = null;
				jsFileArray[i].chName = "";
			}
			else
			{
				if(arguments.length > 2) jsFileArray[i].wrObj = wrObj;
				if(arguments.length > 3) jsFileArray[i].chName = chName;			
			}
			
			break;
		}
	}
	
	if(!bFound && bAdd)
	{
		jsFileArray[jsFileArray.length] = 
			{name:urlName, wrObj:wrObj, chName:chName};
	}
}

//兼容其他应用嵌入平台页面和平台框架自身打开页面两种加载方式
function prePageInit(bMainFrame, bKeepWr)
{	
	var bRootWinFlag = !__bConnedGlobalMem__ || bMainFrame;
	var bNoMem = !__bConnedGlobalMem__ && !bMainFrame;
	var defWrObj = null;
	if((typeof(eppDataWrObj) != "undefined") && eppDataWrObj.isCanUse()) defWrObj = eppDataWrObj;
	setDiskWrVerObj(defWrObj, jwVerCtlObject);
	
	var bRet = true;
	for(var i = 0; i < jsFileArray.length; i ++)
	{
		if(!jsFileArray[i] || !jsFileArray[i].name) continue;
		
		var tmpWrObj = (jsFileArray[i].wrObj && jsFileArray[i].wrObj.isCanUse()) ? jsFileArray[i].wrObj : null;			
		tmpWrObj = tmpWrObj ? tmpWrObj : defWrObj;
		var bForceDirect = !tmpWrObj;
		
		if(!__bConnedGlobalMem__ || bMainFrame)
		{	
			bRet = svd_loadjsfile(jsFileArray[i].name, bCheckJsCssRepeatLoad, bForceDirect, tmpWrObj, jsFileArray[i].chName, bNoMem);			
		}
		else
		{			
			bRet = men_loadjsfile(jsFileArray[i].name, bCheckJsCssRepeatLoad);
			if(!bRet) bRet = svd_loadjsfile(jsFileArray[i].name, false, bForceDirect, tmpWrObj, jsFileArray[i].chName, bNoMem);	
		}
		
		if(!bRet) break;
	}
	
	if(bRootWinFlag)
	{		
		t_jsSourceStoreObj_mem = getJsSourceStoreObj(true);
		if(t_jsSourceStoreObj_mem) t_jsSourceStoreObj_mem["js_init_flag"] = true;		
	}
	
	if(!bKeepWr)
	{
		if(typeof(clearSave2local) == "function") clearSave2local();
		clearSaveForEpp();
	}
	
	return bRet;
}
/////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////////
//版本控制模块
var jwVerCtlObject =
{
	//从服务器获取所有js文件的版本
	prepAllFileVersion: function()
	{
		var t_jsSourceStoreObj_mem = getJsSourceStoreObj();
		var strJsFilesVersion = t_jsSourceStoreObj_mem["jsFileVerListInfo"];
		if(strJsFilesVersion) return strJsFilesVersion;
	
		var strVerDataUrl = "/" + __getAppModuleName() + "/js_version.dat";
		strJsFilesVersion = drt_loadServerFile(strVerDataUrl, true);				
		t_jsSourceStoreObj_mem["jsFileVerListInfo"] = strJsFilesVersion;
		return strJsFilesVersion;
	},
	
	//从内存获取一个文件的当前版本
	getFileCurVersion: function(strFileId)
	{		
		var jsFileVerObjList = null;		
		if(typeof(__jsFileVerObjList_optm__) == "object")
		{
			jsFileVerObjList = __jsFileVerObjList_optm__;
		}
		else
		{		
			var strJsFilesVersion = this.prepAllFileVersion();
			if(strJsFilesVersion) jsFileVerObjList = strJsFilesVersion.split("|");
			if(jsFileVerObjList) __jsFileVerObjList_optm__ = jsFileVerObjList;
		}
				
		if(!jsFileVerObjList) return "";
		var strRet = "";
		
		//格式：id:time
		for(var i = 0; i < jsFileVerObjList.length; i ++)
		{
			var strTemp = jsFileVerObjList[i];
			var strTempId = GetStrName(strTemp, ":");
			if(strTempId == strFileId)
			{
				strRet = GetStrValue(strTemp, ":");
				break;
			}
		}
		
		return strRet;
	}
};
/////////////////////////////////////////////////////////////////////

__create__xmlHttp__obj();
__gie__version = getIeBrowseVersion();
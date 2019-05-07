var flashWrObj =
{
	MAX_UNIT_LEN: 2048,
	VER_INFO_LEN: 80,
	isCanUse: function()
	{
		return document.body && (saveFileDivObj != null);
	},
	
	saveStrSource: function(strFileId, strSource, strVer)
	{
		var MAX_UNIT_LEN = flashWrObj.MAX_UNIT_LEN;
		var iFullPageCount = Math.floor(strSource.length / MAX_UNIT_LEN);
		var iLastPageSize = strSource.length % MAX_UNIT_LEN;
		
		var iSaveCount = ((iLastPageSize > 0) ? 1 : 0) + iFullPageCount;
		if(!__F__saveStrSource(strFileId, "count", "")) return false;
		
		//维护文件列表，方便全部清除
		var strFileIdInfo = __F__readStrSource("files", "id");
		if(strFileIdInfo) strFileIdInfo = RTrim(strFileIdInfo);
		if(!pubIsFileIdInInfo(strFileIdInfo, strFileId)) strFileIdInfo = strFileIdInfo + strFileId + "|";
		var iVerLen = strFileIdInfo.length;
		if(iVerLen < flashWrObj.VER_INFO_LEN) strFileIdInfo = strFileIdInfo + pubRepeatStr(flashWrObj.VER_INFO_LEN - iVerLen, " ");
		__F__saveStrSource("files", "id", strFileIdInfo);
		
		for(var i = 0; i < iFullPageCount; i ++)
		{
			if(!__F__saveStrSource(strFileId, "" + i, strSource.substr(MAX_UNIT_LEN * i, MAX_UNIT_LEN))) return false;
		}
		
		if(iLastPageSize > 0)
		{
			if(!__F__saveStrSource(strFileId, "" + iFullPageCount, strSource.substr(MAX_UNIT_LEN * iFullPageCount))) return false;
			iFullPageCount = iFullPageCount + 1;
		}
		
		var strInfo = iSaveCount + ":" + strVer;
		if(!__F__saveStrSource(strFileId, "count", strInfo)) return false;
	},
	
	readStrSource: function(strFileId)
	{
		var strTemp, strRet = "";
		var iPageCount = __F__readStrSource(strFileId, "count");
		
		if(iPageCount) iPageCount = GetStrName(iPageCount, ":");
		iPageCount = StrToInteger(iPageCount, 0);	
		for(var i = 0; i < iPageCount; i ++)
		{
			strTemp = __F__readStrSource(strFileId, "" + i);
			if(!strTemp) return "";
			strRet = strRet + strTemp;
		}

		return strRet;
	},
	
	readSourceVer: function(strFileId)
	{		
		var strRet = __F__readStrSource(strFileId, "count");
		if(strRet) strRet = GetStrValue(strRet, ":");
		return strRet;
	},
	
	clearSource: function(strFileId)
	{
		var iPageCount = __F__readStrSource(strFileId, "count");
		iPageCount = GetStrName(iPageCount, ":");
		iPageCount = StrToInteger(iPageCount, 0);
		
		if(iPageCount)
		{
			__F__saveStrSource(strFileId, "count", "");		
			for(var i = 0; i < iPageCount; i ++)
			{
				__F__saveStrSource(strFileId, "" + i, "");
			}
		}
		
		return iPageCount;
	},
		
	clearAllSource: function()
	{
		if(!flashWrObj.isCanUse()) return;
		var strFileIdInfo = __F__readStrSource("files", "id");
		strFileIdInfo = RTrim(strFileIdInfo);
		strFileIdInfo = strFileIdInfo.split("|");
		for(var i = 0; i < strFileIdInfo.length; i ++)
		{			
			if(strFileIdInfo[i]) flashWrObj.clearSource(strFileIdInfo[i]);
		}
		
		__F__saveStrSource("files", "id", "");
	}
};

function __F__saveStrSource(strName, strKey, strSource, bEscape)
{
	if(!flashWrObj.isCanUse()) return false;
	var bRet = false;
	try
	{
		bRet = save2local.saveKeyData(strName, strKey, strSource, bEscape);
	}
	catch(e)
	{
		bRet = false;
	}
	
	if(!bRet && bShowDebugMsg && strSource) alert("保存数据[" + strName + "." + strKey + ", 长度：" + strSource.length + "]失败！！");	
	return bRet;
}

function __F__readStrSource(strName, strKey, bEscape)
{	
	if(!flashWrObj.isCanUse()) return "";
	try
	{
		var strRet = save2local.loadKeyData(strName, strKey, bEscape);
		return strRet;
	}
	catch(e)
	{
		//暂时约定在上层调用readStrSource后弹出错误信息
		//if(bShowDebugMsg) alert("读取数据[" + strName + "." + strKey + "]失败！！");		
	}
	
	return "";
}

//数据存放位置：Application Data\Macromedia\Flash Player\#SharedObjects
var save2local = 
{
    version: '1.000',
    swf_path: __getAppModuleName(true) + 'cachloader/save2local.swf',
    objid: 'save2local_objid',
    divid: 'save2local_divid',
    swf: undefined,
    object: null,
    
    getObj: function() 
    {
    	if(save2local.object) return save2local.object;
        var id = this.objid;
        var bMicrosoft = (navigator.appName.indexOf("Microsoft") != -1);
        save2local.object = bMicrosoft ? window[id] : document[id];
        return save2local.object;
    },
    
    saveKeyData: function(name, key, dat, bEscape) 
    {    	
        var wrObj = this.getObj();
        if(wrObj && wrObj.saveKeyData) 
        {
        	if(bEscape) dat = escape(dat);
        	wrObj.saveKeyData(name, key, dat);
        	return true;
        }
        
        return false;
    },
    
    loadKeyData: function(name, key, bEscape) 
    {
        var wrObj = this.getObj();
        if(wrObj && wrObj.loadKeyData) 
        {
        	var dat = wrObj.loadKeyData(name, key);
        	if(dat && (dat != "null"))
        	{
				if(bEscape) dat = unescape(dat);
	        	return dat;        	
        	}
        }
        
        return "";
    }
};

var SWFObject = null;
var saveFileDivObj = null;
//一般应在window.document.body.onload事件中调用该函数初始化Flash存储对象
//strSwfpath：存放save2local.swf文件路径名称，为空时使用缺省值
function initSave2local(strSwfpath)
{
	var bRet = false;
	if(SWFObject == null) 
	{
		try{ initSWFObject(); }
		catch(e){ SWFObject = null; }
	}
	
	if(arguments.length >= 1) save2local.swf_path = strSwfpath;
	if((saveFileDivObj == null) && (SWFObject != null))
	{
		saveFileDivObj = document.createElement("div");
		saveFileDivObj.id = save2local.divid;
		document.body.appendChild(saveFileDivObj);
		
		save2local.swf  = new SWFObject(save2local.swf_path, save2local.objid, "1", "1", "8", "white");
		save2local.swf.write(save2local.divid);
		saveFileDivObj.style.display = "none";
		bRet = true;
	}
	
	return bRet;
}

function clearSave2local()
{
	if(saveFileDivObj)
	{
		document.body.removeChild(saveFileDivObj);
		delete saveFileDivObj;
		saveFileDivObj = null;
		return true;
	}
	return false;
}

//////////////////////////////////////////////////////////////
//flash write&read file object definition.
function initSWFObject()
{
if(typeof deconcept=="undefined"){var deconcept=new Object();}
if(typeof deconcept.util=="undefined"){deconcept.util=new Object();}
if(typeof deconcept.SWFObjectUtil=="undefined"){deconcept.SWFObjectUtil=new Object();}
deconcept.SWFObject=function(_1,id,w,h,_5,c,_7,_8,_9,_a,_b){
if(!document.getElementById){return;}
this.DETECT_KEY=_b?_b:"detectflash";
this.skipDetect=deconcept.util.getRequestParameter(this.DETECT_KEY);
this.params=new Object();
this.variables=new Object();
this.attributes=new Array();
if(_1){this.setAttribute("swf",_1);}
if(id){this.setAttribute("id",id);}
if(w){this.setAttribute("width",w);}
if(h){this.setAttribute("height",h);}
if(_5){this.setAttribute("version",new deconcept.PlayerVersion(_5.toString().split(".")));}
this.installedVer=deconcept.SWFObjectUtil.getPlayerVersion();
if(c){this.addParam("bgcolor",c);}
var q=_8?_8:"high";
this.addParam("quality",q);
this.setAttribute("useExpressInstall",_7);
this.setAttribute("doExpressInstall",false);
var _d=(_9)?_9:window.location;
this.setAttribute("xiRedirectUrl",_d);
this.setAttribute("redirectUrl","");
if(_a){this.setAttribute("redirectUrl",_a);}};
deconcept.SWFObject.prototype={setAttribute:function(_e,_f){
this.attributes[_e]=_f;
},getAttribute:function(_10){
return this.attributes[_10];
},addParam:function(_11,_12){
this.params[_11]=_12;
},getParams:function(){
return this.params;
},addVariable:function(_13,_14){
this.variables[_13]=_14;
},getVariable:function(_15){
return this.variables[_15];
},getVariables:function(){
return this.variables;
},getVariablePairs:function(){
var _16=new Array();
var key;
var _18=this.getVariables();
for(key in _18){_16.push(key+"="+_18[key]);}
return _16;},getSWFHTML:function(){var _19="";
if(navigator.plugins&&navigator.mimeTypes&&navigator.mimeTypes.length){
if(this.getAttribute("doExpressInstall")){
this.addVariable("MMplayerType","PlugIn");}
_19="<embed type=\"application/x-shockwave-flash\" src=\""+this.getAttribute("swf")+"\" width=\""+this.getAttribute("width")+"\" height=\""+this.getAttribute("height")+"\"";
_19+=" id=\""+this.getAttribute("id")+"\" name=\""+this.getAttribute("id")+"\" ";
var _1a=this.getParams();
for(var key in _1a){_19+=[key]+"=\""+_1a[key]+"\" ";}
var _1c=this.getVariablePairs().join("&");
if(_1c.length>0){_19+="flashvars=\""+_1c+"\"";}_19+="/>";
}else{if(this.getAttribute("doExpressInstall")){this.addVariable("MMplayerType","ActiveX");}
_19="<object id=\""+this.getAttribute("id")+"\" classid=\"clsid:D27CDB6E-AE6D-11cf-96B8-444553540000\" width=\""+this.getAttribute("width")+"\" height=\""+this.getAttribute("height")+"\">";
_19+="<param name=\"movie\" value=\""+this.getAttribute("swf")+"\" />";
var _1d=this.getParams();
for(var key in _1d){_19+="<param name=\""+key+"\" value=\""+_1d[key]+"\" />";}
var _1f=this.getVariablePairs().join("&");
if(_1f.length>0){_19+="<param name=\"flashvars\" value=\""+_1f+"\" />";}_19+="</object>";}
return _19;
},write:function(_20){
if(this.getAttribute("useExpressInstall")){
var _21=new deconcept.PlayerVersion([6,0,65]);
if(this.installedVer.versionIsValid(_21)&&!this.installedVer.versionIsValid(this.getAttribute("version"))){
this.setAttribute("doExpressInstall",true);
this.addVariable("MMredirectURL",escape(this.getAttribute("xiRedirectUrl")));
document.title=document.title.slice(0,47)+" - Flash Player Installation";
this.addVariable("MMdoctitle",document.title);}}
if(this.skipDetect||this.getAttribute("doExpressInstall")||this.installedVer.versionIsValid(this.getAttribute("version"))){
var n=(typeof _20=="string")?document.getElementById(_20):_20;
n.innerHTML=this.getSWFHTML();return true;
}else{if(this.getAttribute("redirectUrl")!=""){document.location.replace(this.getAttribute("redirectUrl"));}}
return false;}};
deconcept.SWFObjectUtil.getPlayerVersion=function(){
var _23=new deconcept.PlayerVersion([0,0,0]);
if(navigator.plugins&&navigator.mimeTypes.length){
var x=navigator.plugins["Shockwave Flash"];
if(x&&x.description){_23=new deconcept.PlayerVersion(x.description.replace(/([a-zA-Z]|\s)+/,"").replace(/(\s+r|\s+b[0-9]+)/,".").split("."));}
}else{try{var axo=new ActiveXObject("ShockwaveFlash.ShockwaveFlash.7");}
catch(e){try{var axo=new ActiveXObject("ShockwaveFlash.ShockwaveFlash.6");
_23=new deconcept.PlayerVersion([6,0,21]);axo.AllowScriptAccess="always";}
catch(e){if(_23.major==6){return _23;}}try{axo=new ActiveXObject("ShockwaveFlash.ShockwaveFlash");}
catch(e){}}if(axo!=null){_23=new deconcept.PlayerVersion(axo.GetVariable("$version").split(" ")[1].split(","));}}
return _23;};
deconcept.PlayerVersion=function(_27){
this.major=_27[0]!=null?parseInt(_27[0]):0;
this.minor=_27[1]!=null?parseInt(_27[1]):0;
this.rev=_27[2]!=null?parseInt(_27[2]):0;
};
deconcept.PlayerVersion.prototype.versionIsValid=function(fv){
if(this.major<fv.major){return false;}
if(this.major>fv.major){return true;}
if(this.minor<fv.minor){return false;}
if(this.minor>fv.minor){return true;}
if(this.rev<fv.rev){
return false;
}return true;};
deconcept.util={getRequestParameter:function(_29){
var q=document.location.search||document.location.hash;
if(q){var _2b=q.substring(1).split("&");
for(var i=0;i<_2b.length;i++){
if(_2b[i].substring(0,_2b[i].indexOf("="))==_29){
return _2b[i].substring((_2b[i].indexOf("=")+1));}}}
return "";}};
deconcept.SWFObjectUtil.cleanupSWFs=function(){if(window.opera||!document.all){return;}
var _2d=document.getElementsByTagName("OBJECT");
for(var i=0;i<_2d.length;i++){_2d[i].style.display="none";for(var x in _2d[i]){
if(typeof _2d[i][x]=="function"){_2d[i][x]=function(){};}}}};
deconcept.SWFObjectUtil.prepUnload=function(){__flash_unloadHandler=function(){};
__flash_savedUnloadHandler=function(){};
if(typeof window.onunload=="function"){
var _30=window.onunload;
window.onunload=function(){
deconcept.SWFObjectUtil.cleanupSWFs();_30();};
}else{window.onunload=deconcept.SWFObjectUtil.cleanupSWFs;}};
if(typeof window.onbeforeunload=="function"){
var oldBeforeUnload=window.onbeforeunload;
window.onbeforeunload=function(){
deconcept.SWFObjectUtil.prepUnload();
oldBeforeUnload();};
}else{window.onbeforeunload=deconcept.SWFObjectUtil.prepUnload;}
if(Array.prototype.push==null){
Array.prototype.push=function(_31){
this[this.length]=_31;
return this.length;};}
//var getQueryParamValue=deconcept.util.getRequestParameter;
//var FlashObject=deconcept.SWFObject;
SWFObject=deconcept.SWFObject;
}
//////////////////////////////////////////////////////////////
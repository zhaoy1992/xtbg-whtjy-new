var eppDataWrObj =
{
	MAX_UNIT_LEN: 1024 * 1024,	
	isCanUse: function()
	{
		return (document.body && (saveForEppObj != null) && (typeof(saveForEppObj.ReadStrSource) != "undefined"));
	},
	
	saveStrSource: function(strFileId, strSource, strVer)
	{
		var MAX_UNIT_LEN = eppDataWrObj.MAX_UNIT_LEN;
		var iFullPageCount = Math.floor(strSource.length / MAX_UNIT_LEN);
		var iLastPageSize = strSource.length % MAX_UNIT_LEN;
		
		var iSaveCount = ((iLastPageSize > 0) ? 1 : 0) + iFullPageCount;
		if(!__E__saveStrSource(strFileId + ".count", "")) return false;
		
		//维护文件列表，方便全部清除
		var strFileIdInfo = __E__readStrSource("files.id");
		if(!pubIsFileIdInInfo(strFileIdInfo, strFileId)) strFileIdInfo = strFileIdInfo + strFileId + "|";		
		__E__saveStrSource("files.id", strFileIdInfo);
		
		for(var i = 0; i < iFullPageCount; i ++)
		{
			if(!__E__saveStrSource(strFileId + "." + i, strSource.substr(MAX_UNIT_LEN * i, MAX_UNIT_LEN))) return false;
		}
		
		if(iLastPageSize > 0)
		{
			if(!__E__saveStrSource(strFileId + "." + iFullPageCount, strSource.substr(MAX_UNIT_LEN * iFullPageCount))) return false;
			iFullPageCount = iFullPageCount + 1;
		}
		
		var strInfo = iSaveCount + ":" + strVer;
		if(!__E__saveStrSource(strFileId + ".count", strInfo)) return false;
	},
	
	readStrSource: function(strFileId)
	{
		var strTemp, strRet = "";
		var iPageCount = __E__readStrSource(strFileId + ".count");
		
		if(iPageCount) iPageCount = GetStrName(iPageCount, ":");
		iPageCount = StrToInteger(iPageCount, 0);
		for(var i = 0; i < iPageCount; i ++)
		{
			strTemp = __E__readStrSource(strFileId + "." + i);
			if(!strTemp) return ""
			if(strTemp) strRet = strRet + strTemp;
		}
	
		return strRet;
	},
	
	readSourceVer: function(strFileId)
	{
		var strRet = "";
		strRet = __E__readStrSource(strFileId + ".count");
		if(strRet) strRet = GetStrValue(strRet, ":");
		return strRet;
	},
	
	clearSource: function(strFileId)
	{	
		var iPageCount = __E__readStrSource(strFileId + ".count");
		iPageCount = GetStrName(iPageCount, ":");
		iPageCount = StrToInteger(iPageCount, 0);
		
		if(iPageCount)
		{
			__E__saveStrSource(strFileId + ".count", "");	
			for(var i = 0; i < iPageCount; i ++)
			{
				__E__saveStrSource(strFileId + "." + i, "");
			}
		}
		
		return iPageCount;
	},
	
	clearAllSource: function()
	{
		if(!eppDataWrObj.isCanUse()) return;
		var strFileIdInfo = __E__readStrSource("files.id");		
		strFileIdInfo = strFileIdInfo.split("|");
		for(var i = 0; i < strFileIdInfo.length; i ++)
		{			
			if(strFileIdInfo[i]) eppDataWrObj.clearSource(strFileIdInfo[i]);
		}
		
		__E__saveStrSource("files.id", "");
	}
};

function __E__saveStrSource(strFileId, strSource)
{
	if(!eppDataWrObj.isCanUse()) return false;
	
	try
	{		
		return saveForEppObj.SaveStrSource(strFileId, strSource);
	}
	catch(e)
	{
		if(bShowDebugMsg && strSource) alert("保存数据[" + strFileId + ", 长度：" + strSource.length + "]失败！！");		
	}
	
	return false;
}

function __E__readStrSource(strFileId)
{
	if(!eppDataWrObj.isCanUse()) return "";
	
	try
	{		
		var strSource = saveForEppObj.ReadStrSource(strFileId);
		return strSource;
	}
	catch(e)
	{
		//if(bShowDebugMsg) alert("读取数据[" + strFileId + "]失败！！");		
	}
	
	return "";
}

//数据存放位置：Local Settings\Temp
var saveForEppObj = null;
function initSaveForEpp()
{
	if(saveForEppObj != null) return true;
	var strSaveForEpp = '<object id="save_for_epp" classid="clsid:fcb523dc-a773-4285-8cac-468c8ebb3298" '
		+ 'width="0px" height="0px" style="display:none" codebase="' + __getAppModuleName(true) + 'cachloader/extforepp.cab#version=1,0,0,0"></object>';
	document.body.insertAdjacentHTML("beforeEnd", strSaveForEpp);
	saveForEppObj = document.getElementById("save_for_epp");	
	return saveForEppObj != null;
}

function clearSaveForEpp()
{
	if(saveForEppObj)
	{
		document.body.removeChild(saveForEppObj);
		delete saveForEppObj;
		saveForEppObj = null;
		return true;
	}
	
	return false;
}

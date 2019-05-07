var userDataWrObj =
{
	MAX_UNIT_LEN: 4096,
	VER_INFO_LEN: 320,
	isCanUse: function()
	{
		return document.body && (__gie__version >= 5.5);
	},
	
	saveStrSource: function(strFileId, strSource, strVer)
	{
		var MAX_UNIT_LEN = userDataWrObj.MAX_UNIT_LEN;
		var iFullPageCount = Math.floor(strSource.length / MAX_UNIT_LEN);
		var iLastPageSize = strSource.length % MAX_UNIT_LEN;
		
		var iSaveCount = ((iLastPageSize > 0) ? 1 : 0) + iFullPageCount;
		if(!__P__saveStrSource(strFileId + ".count", "")) return false;
		
		//维护文件列表，方便全部清除
		var strFileIdInfo = __P__readStrSource("files.id");
		if(strFileIdInfo) strFileIdInfo = RTrim(strFileIdInfo);
		if(!pubIsFileIdInInfo(strFileIdInfo, strFileId)) strFileIdInfo = strFileIdInfo + strFileId + "|";
		var iVerLen = strFileIdInfo.length;
		if(iVerLen < userDataWrObj.VER_INFO_LEN) strFileIdInfo = strFileIdInfo + pubRepeatStr(userDataWrObj.VER_INFO_LEN - iVerLen, " ");
		__P__saveStrSource("files.id", strFileIdInfo);
		
		for(var i = 0; i < iFullPageCount; i ++)
		{
			if(!__P__saveStrSource(strFileId + "." + i, strSource.substr(MAX_UNIT_LEN * i, MAX_UNIT_LEN))) return false;
		}
		
		if(iLastPageSize > 0)
		{
			if(!__P__saveStrSource(strFileId + "." + iFullPageCount, strSource.substr(MAX_UNIT_LEN * iFullPageCount))) return false;
			iFullPageCount = iFullPageCount + 1;
		}
		
		var strInfo = iSaveCount + ":" + strVer;
		if(!__P__saveStrSource(strFileId + ".count", strInfo)) return false;
	},
	
	readStrSource: function(strFileId)
	{
		var strTemp, strRet = "";
		var iPageCount = __P__readStrSource(strFileId + ".count");
		
		if(iPageCount) iPageCount = GetStrName(iPageCount, ":");
		iPageCount = StrToInteger(iPageCount, 0);
		for(var i = 0; i < iPageCount; i ++)
		{
			strTemp = __P__readStrSource(strFileId + "." + i);
			if(!strTemp) return ""
			if(strTemp) strRet = strRet + strTemp;
		}
	
		return strRet;
	},
	
	readSourceVer: function(strFileId)
	{
		var strRet = "";
		strRet = __P__readStrSource(strFileId + ".count");
		if(strRet) strRet = GetStrValue(strRet, ":");
		return strRet;
	},
	
	clearSource: function(strFileId)
	{	
		var iPageCount = __P__readStrSource(strFileId + ".count");
		iPageCount = GetStrName(iPageCount, ":");
		iPageCount = StrToInteger(iPageCount, 0);
		
		if(iPageCount)
		{
			__P__saveStrSource(strFileId + ".count", "");	
			for(var i = 0; i < iPageCount; i ++)
			{
				__P__saveStrSource(strFileId + "." + i, "");
			}
		}
		
		return iPageCount;
	},
	
	clearAllSource: function()
	{
		if(!userDataWrObj.isCanUse()) return;
		var strFileIdInfo = __P__readStrSource("files.id");
		strFileIdInfo = RTrim(strFileIdInfo);
		strFileIdInfo = strFileIdInfo.split("|");
		for(var i = 0; i < strFileIdInfo.length; i ++)
		{			
			if(strFileIdInfo[i]) userDataWrObj.clearSource(strFileIdInfo[i]);
		}
		
		__P__saveStrSource("files.id", "");
	}
};

//数据存放位置：Application Data\Microsoft\Internet Explorer\UserData
function __P__saveStrSource(strFileId, strSource)
{
	try
	{
		var inputGetfileObj = document.createElement("INPUT");		
		inputGetfileObj.type = "hidden";
		inputGetfileObj.style.behavior = "url('#default#userdata')";		
		inputGetfileObj.id = strFileId;
		
		document.body.appendChild(inputGetfileObj);
		inputGetfileObj.setAttribute("strSource", strSource);
		inputGetfileObj.save(strFileId);
		document.body.removeChild(inputGetfileObj);
		
		delete inputGetfileObj;
		return true;
	}
	catch(e)
	{
		if(bShowDebugMsg && strSource) alert("保存数据[" + strFileId + ", 长度：" + strSource.length + "]失败！！");		
	}
	
	return false;
}

function __P__readStrSource(strFileId)
{
	try
	{
		var inputGetfileObj = document.createElement("INPUT");
		inputGetfileObj.type = "hidden";
		inputGetfileObj.style.behavior = "url('#default#userdata')";
		inputGetfileObj.id = strFileId;

		document.body.appendChild(inputGetfileObj);
		inputGetfileObj.load(strFileId);
		var strSource = inputGetfileObj.getAttribute("strSource");		
		document.body.removeChild(inputGetfileObj);
		
		delete inputGetfileObj;
		if(!strSource) strSource = "";
		return strSource;
	}
	catch(e)
	{
		//if(bShowDebugMsg) alert("读取数据[" + strFileId + "]失败！！");		
	}
	
	return "";
}
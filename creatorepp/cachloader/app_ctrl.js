///////////////////////////////////////////////////////////////////////
//A：其他应用（如：portal应用）嵌入平台页面，将内容缓存到本地磁盘的js文件表
//B：平台框架自身打开页面方式，将内容缓存到全局内存的js文件表（也会先缓存到本地磁盘）
//wrObj为null值时表示不直接从服务器取数据，不使用本地磁盘缓存机制
var jsFileArray = 
[  
	{name:"cachloader/xop_window.js", wrObj:userDataWrObj},
	{name:"jstst_2/comm.2.js", wrObj:flashWrObj},
	{name:"jstst_1/ccpub.js", wrObj:eppDataWrObj},
	{name:"jstst_1/fcpub.js", wrObj:userDataWrObj},
	{name:"jstst_1/fctoolbar.js", wrObj:eppDataWrObj, chName:"GBK"}	
];

//urlName：需要维护js文件url地址串
//bAdd：true 增加该文件加载过程  || false 删除该文件加载过程  
//wrObj：为该文件的磁盘缓存读写对象 ，可以为null（bAdd为true时才有效）
function mtJsFileArray(urlName, bAdd, wrObj, chName)
{
	var bFound = false;
	for(var i = 0; i < jsFileArray.length; i ++)
	{
		if(jsFileArray[i].name == urlName)
		{
			bFound = true;
			if(!bAdd) jsFileArray[i].name = "";
			break;
		}
	}
	
	if(!bFound && bAdd)
	{
		jsFileArray[jsFileArray.length] = {name:urlName, wrObj:wrObj, chName:chName};
	}
}

var __b_all_js_loaded__ = false;
//兼容其他应用嵌入平台页面和平台框架自身打开页面两种加载方式
function prePageInit(bEppPre, bKeepWr)
{	
	var t_jsSourceStoreObj_mem = getJsSourceStoreObj(true);
	var bConnedGlobalMem = (t_jsSourceStoreObj_mem != null);
	
	var bInitWrFlag = false;	
	if(!bConnedGlobalMem || bEppPre)
	{
		initSave2local();
		initSaveForEpp();
		bInitWrFlag = true;
		jwVerCtlObject.prepAllFileVersion();
	}
		
	var defWrObj = null;
	if((typeof(eppDataWrObj) == "object") && eppDataWrObj.isCanUse()) defWrObj = eppDataWrObj;
	setDiskWrVerObj(defWrObj, jwVerCtlObject);
	
	var bRet = true;
	for(var i = 0; i < jsFileArray.length; i ++)
	{
		if(!jsFileArray[i] || !jsFileArray[i].name) continue;
		if(!bConnedGlobalMem || bEppPre)
		{	
			var tmpWrObj = (jsFileArray[i].wrObj && jsFileArray[i].wrObj.isCanUse()) ? jsFileArray[i].wrObj : null;			
			tmpWrObj = tmpWrObj ? tmpWrObj : defWrObj;
			var bForceDirect = !tmpWrObj;
			bRet = svd_loadjsfile(jsFileArray[i].name, false, bForceDirect, tmpWrObj, jsFileArray[i].chName);			
		}
		else
		{			
			bRet = men_loadjsfile(jsFileArray[i].name, false);
			if(!bRet) bRet = svd_loadjsfile(jsFileArray[i].name, false, true, null, jsFileArray[i].chName);	
		}
		
		if(!bRet) break;
	}
	
	if(bInitWrFlag)
	{		
		t_jsSourceStoreObj_mem = getJsSourceStoreObj(true);
		if(t_jsSourceStoreObj_mem) t_jsSourceStoreObj_mem["js_init_flag"] = true;
		if(!bKeepWr)
		{
			clearSave2local();
			clearSaveForEpp();
		}
	}
		
	__b_all_js_loaded__ = bRet;
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
		var strVerDataUrl = "/" + __getAppModuleName() + "/js_version.dat";
		var strJsFilesVersion = drt_loadServerFile(strVerDataUrl, true);
		var jsFileVerObjList = strJsFilesVersion.split("|");
		var t_jsSourceStoreObj_mem = getJsSourceStoreObj();
		t_jsSourceStoreObj_mem["jsFileVerObjList"] = jsFileVerObjList;
	},
	
	//从内存获取一个文件的当前版本
	getFileCurVersion: function(strFileId)
	{		
		var jsFileVerObjList = null;
		var t_jsSourceStoreObj_mem = getJsSourceStoreObj();
		if(t_jsSourceStoreObj_mem) jsFileVerObjList = t_jsSourceStoreObj_mem["jsFileVerObjList"];
		
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
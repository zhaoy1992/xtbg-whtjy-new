///////////////////////////////////////////////////////////////////////
//A������Ӧ�ã��磺portalӦ�ã�Ƕ��ƽ̨ҳ�棬�����ݻ��浽���ش��̵�js�ļ���
//B��ƽ̨��������ҳ�淽ʽ�������ݻ��浽ȫ���ڴ��js�ļ���Ҳ���Ȼ��浽���ش��̣�
//wrObjΪnullֵʱ��ʾ��ֱ�Ӵӷ�����ȡ���ݣ���ʹ�ñ��ش��̻������
var jsFileArray = 
[  
	{name:"cachloader/xop_window.js", wrObj:userDataWrObj},
	{name:"jstst_2/comm.2.js", wrObj:flashWrObj},
	{name:"jstst_1/ccpub.js", wrObj:eppDataWrObj},
	{name:"jstst_1/fcpub.js", wrObj:userDataWrObj},
	{name:"jstst_1/fctoolbar.js", wrObj:eppDataWrObj, chName:"GBK"}	
];

//urlName����Ҫά��js�ļ�url��ַ��
//bAdd��true ���Ӹ��ļ����ع���  || false ɾ�����ļ����ع���  
//wrObj��Ϊ���ļ��Ĵ��̻����д���� ������Ϊnull��bAddΪtrueʱ����Ч��
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
//��������Ӧ��Ƕ��ƽ̨ҳ���ƽ̨��������ҳ�����ּ��ط�ʽ
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
//�汾����ģ��
var jwVerCtlObject =
{
	//�ӷ�������ȡ����js�ļ��İ汾
	prepAllFileVersion: function()
	{
		var strVerDataUrl = "/" + __getAppModuleName() + "/js_version.dat";
		var strJsFilesVersion = drt_loadServerFile(strVerDataUrl, true);
		var jsFileVerObjList = strJsFilesVersion.split("|");
		var t_jsSourceStoreObj_mem = getJsSourceStoreObj();
		t_jsSourceStoreObj_mem["jsFileVerObjList"] = jsFileVerObjList;
	},
	
	//���ڴ��ȡһ���ļ��ĵ�ǰ�汾
	getFileCurVersion: function(strFileId)
	{		
		var jsFileVerObjList = null;
		var t_jsSourceStoreObj_mem = getJsSourceStoreObj();
		if(t_jsSourceStoreObj_mem) jsFileVerObjList = t_jsSourceStoreObj_mem["jsFileVerObjList"];
		
		if(!jsFileVerObjList) return "";
		var strRet = "";
		
		//��ʽ��id:time
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
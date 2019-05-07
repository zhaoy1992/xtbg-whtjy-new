var str_nps_pub_0001 = "打开窗口失败，连接服务器异常或浏览器弹出式窗口选项被禁止!!";
var str_nps_pub_0002 = "打开窗口失败，连接服务器异常或浏览器不支持打开一个新窗口!!";

//创建一个模态弹出式窗口
//posCont：用于定位创建窗口左上角位置的控件对象
//tWidth: 窗口初始宽度
//tHeight：窗口初始高度
//bResize：是否可以拖动设置窗口大小
function showWindow(strUrl, paramOb, posCont, tWidth, tHeight, bResize)
{
	var strArg = "";
	if(posCont)
	{
		var win_left = window.screenLeft + posCont.offsetLeft - 2;
		var win_top = window.screenTop + posCont.offsetTop;		
		strArg = "dialogTop=" + win_top + "px;" + "dialogLeft=" + win_left + "px;";
	}
	else
	{
		strArg = "center=yes;";
	}
	
	if(!tWidth) tWidth = 463;
	if(!tHeight) tHeight = 363;
	
	////////////////////////////
	//用于调整窗口尺寸
	//bResize = true;
	////////////////////////////	
	strArg = strArg + "dialogWidth=" + tWidth + "px;dialogHeight=" + tHeight + "px;";
	strArg = strArg + "status=no;scroll=no;help=no;";
	if(bResize)
	{
		//调试时设置为yes用于手工调整窗口尺寸
		strArg = strArg + "resizable=yes;";
	}
	else
	{
		//发布应用时将resizable设置为no
		strArg = strArg + "resizable=no;";
	}
	
	try
	{
		var bTempParamOb = (paramOb == null);
		if(bTempParamOb) paramOb = new Object();
		paramOb.jsSourceStoreObj_mem = getJsSourceStoreObj(true);
		paramOb.parentWindow = window;
		g_setKeyValue("pop_win_flag", false);
			
		var retObj = window.showModalDialog(strUrl, paramOb, strArg);		
		if(bTempParamOb) delete paramOb;
		return retObj;
	}
	catch(e)
	{
		if(!g_getKeyValue("pop_win_flag"))
		{
			alert(str_nps_pub_0001);	
		}
		else
		{
			alert("弹出窗口中的程序模块运行出错，请把情况反馈给开发商!!");
		}
	}	
	
	return false;
}

//创建一个非模态弹出式窗口
//posCont：用于定位创建窗口左上角位置的控件对象
//tWidth: 窗口初始宽度
//tHeight：窗口初始高度
//bResize：是否可以拖动设置窗口大小
function openWindow(strUrl, strName, posCont, tWidth, tHeight, bResize)
{
	var strArg = "";		
	if(!tWidth) tWidth = 463;
	if(!tHeight) tHeight = 363;
		
	var win_left, win_top;
	if(posCont)
	{
		win_left = window.screenLeft + posCont.offsetLeft - 2;
		win_top = window.screenTop + posCont.offsetTop;		
	}
	else
	{
		win_left = (window.screen.availWidth - tWidth) / 2;
		win_top = (window.screen.availHeight - tHeight) / 2;
	}
	
	strArg = "top=" + win_top + ",left=" + win_left + ",";
	////////////////////////////
	//用于调整窗口尺寸
	//bResize = true;
	////////////////////////////	
	strArg = strArg + "width=" + tWidth + ",height=" + tHeight + ",";
	strArg = strArg + "status=no,toolbar=no,menubar=no,location=no,scrollbars=no,";
	if(bResize)
	{
		//调试时设置为yes用于手工调整窗口尺寸
		strArg = strArg + "resizable=yes";
	}
	else
	{
		//发布应用时将resizable设置为no
		strArg = strArg + "resizable=no";
	}
	
	var winObj = null;
	try
	{
		g_setKeyValue("pop_win_flag", false);
		if(!strName) strName = null;
	
		winObj = window.open(strUrl, strName, strArg);
		if(winObj) winObj.p_jsSourceStoreObj_mem = getJsSourceStoreObj(true);
	}
	catch(e)
	{
		winObj = null;
		alert(str_nps_pub_0002);
	}
	
	return winObj;
}

/*************************************/
//根据标题栏调整自动调整窗口高度
var g_dlgHeight = undefined;
function __autoAdjustHeight()
{
	if(!g_dlgHeight) 
	{
		return;
	}
	
	var iOffHeight = g_dlgHeight - window.document.body.offsetHeight;
	//说明：25为JHW-HOME机器开发环境的偏差（桌面窗口标题栏高度为18）
	iOffHeight = iOffHeight - 25;
	if(iOffHeight !== 0)
	{
		g_dlgHeight = g_dlgHeight + iOffHeight;
		if(g_dlgHeight < 25) g_dlgHeight = 25;
		window.dialogHeight = g_dlgHeight + "px";
	}
	
	g_dlgHeight = undefined;
}
/*************************************/

///////////////////////////////////////
//设置浏览器窗口的大小
function resizeDlg(dlgWidth, dlgHeight)
{
	if(window.dialogWidth)
	{					
		window.dialogWidth = dlgWidth + "px";
		
		if(dlgHeight)
		{
			window.dialogHeight = dlgHeight + "px";
			g_dlgHeight = dlgHeight;
			window.setTimeout("__autoAdjustHeight()", 2);
		}
	}
	else
	{
		window.resizeTo(dlgWidth, dlgHeight);
	}
}
///////////////////////////////////////

//关闭当前浏览器窗口
function closeWindow(winObj)
{
	if(!winObj) winObj = window;
	var ieVersion = getIeBrowseVersion(winObj);
	
	if(ieVersion > 0)
	{	
		if(ieVersion < 5.5)
		{ 
			var strCloseObj = '<object id="closeObj" classid="clsid:adb880a6-d8ff-11cf-9377-00aa003b7a11" ' + 
				'style="display:none" width="0px" height="0px">';
			strCloseObj = strCloseObj + '<param name="Command" value="Close"></object>';
			winObj.document.body.insertAdjacentHTML("beforeEnd", strCloseObj);
			var CloseObject = winObj.document.getElementById("closeObj");
			if(CloseObject) CloseObject.Click();
		}
		else
		{    			  			
   			winObj.opener = null;
   			if(ieVersion >= 7.0) winObj.open("", "_self");
   			winObj.close();
   		}
   	}
   	else
   	{
   		winObj.close();
   	}
}
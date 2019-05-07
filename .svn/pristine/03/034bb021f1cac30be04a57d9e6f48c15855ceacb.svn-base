<%--
　　描述：模板正文页面
　　作者：黄艺平
　　版本：1.0
　　日期：2013-07-31
--%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.OASystemCache" %>
<%
	String template_id_th = StringUtil.deNull(request.getParameter("template_id_th"));
	String cebversion = OASystemCache.getContextProperty("cebversion");
%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%><html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title></title>
<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script src="../../resources/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-min.1.1.js" ></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js" ></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js" ></script>
<script language="javascript" src="js/wordtemplateutil.js"></script>
<script type="text/javascript">
var iWebOffice = null;
var template_id_th = "<%=template_id_th %>";//模版ID

window.attachEvent("onload", function () {
    init();
});

var appUserName = "";

/*
	函数：init
	描述：初始化方法
	参数：
	返回值：
*/
function init() {
    iWebOffice = document.getElementsByName("WebOffice")[0];
    var weburltemp = "../../resources/plug/iWebOffice2009/OfficeServer.jsp";
    iWebOffice.WebUrl = weburltemp; //设置控件与服务器交互的url地址
    iWebOffice.Template = "th"+template_id_th;
    iWebOffice.FileType = ".doc"; //设置文件类型，确定控件开发的应用程序
    iWebOffice.EditType = "1,0"; //设置编辑状态
    iWebOffice.ShowType = "1"; //设置显示状态
    iWebOffice.ShowToolBar = "0"; //是否显示工具栏 0不显示 1显示
    iWebOffice.ShowMenu = "0"; //是否显示菜单 0不显示 1显示
    iWebOffice.MaxFileSize = 64 * 1024; //设置文件最大值
    iWebOffice.Language="CH"; //设置界面显示语言
    iWebOffice.UserName = ""; //设置用户名
    combakTemplet();
}

/*
	函数：combakTemplet
	描述：打开word编辑器
	参数：
	返回值：
*/
function combakTemplet() {
    iWebOffice.Template = "th"+template_id_th; //这是模板id
    iWebOffice.WebOpen();
}

/*
	函数：giveVariablesValue
	描述：给变量赋值
	参数：
	返回值：
*/
function giveVariablesValue() {
    if(template_id_th == "") {
        template_id_th = parent.frames["rightFrame"].$("#template_id_th").val();
    }
    return template_id_th;
}

/**
 * 给一个新文档
 */
function createOrUpdateWordReport() {
	iWebOffice.Template = "th"+template_id_th; //这是模板id
    if (!iWebOffice.WebLoadTemplate()) { //加载对应的Word模板
        iWebOffice.CreateFile(); //容错处理，默认创建一个文档
    }
}
 /*
	函数：saveTemplet
	描述：保存文档
	参数：
	返回值：
*/
function saveTemplet(para) {
	template_id_th = giveVariablesValue();
	if(para) {
		 $("#WebOffice1").hide();
		 iWebOffice.Template = "th"+template_id_th; //这是模板id
		 iWebOffice.FileName = template_id_th+ ".doc"; //设置文件名
		 var msg = iWebOffice.WebSaveTemplate(true);//平台方法
	} else {
	    if(template_id_th == "" || template_id_th == "null") {
	    	$("#WebOffice1").hide();
	    	var okF=function(){
	    		$("#WebOffice1").show();
	        }
	    		
	    	var p={
	    		headerText:'提示',
	    		okName:'确认',
	    		okFunction:okF
	    	};
	    	alert("模版基本信息未保存，请先保存",p);
	        return;
	    }
	    $("#WebOffice1").hide();
	    iWebOffice.Template = "th"+template_id_th; //这是模板id
	    iWebOffice.FileName = template_id_th+ ".doc"; //设置文件名
	     var msg = iWebOffice.WebSaveTemplate(true);//平台方法
	    if(msg) {
	    	var okF=function(){
	    		$("#WebOffice1").show();
	        }
	    		
	    	var p={
	    		headerText:'提示',
	    		okName:'确认',
	    		okFunction:okF
	    	};
	    	alert("套红模版保存成功",p)
	
	    } else {
	        alert("套红模版保存失败");
	    }
	}
}

 /*
	函数：saveTempletFromRight
	描述：保存文档,保存规则项目时调用
	参数：
	返回值：
*/
function saveTempletFromRight() {
    iWebOffice.Template = "th"+template_id_th; //这是模板id
    iWebOffice.FileName = template_id_th+ ".doc"; //设置文件名
    iWebOffice.WebSaveTemplate(true);//平台方法
}

/*
	函数：checkTemplet
	描述：预览文档
	参数：
	返回值：
*/
function checkTemplet() {
    var template_id_th = giveVariablesValue(); //模版基础信息ID
    if(IsSpace(template_id_th)){
    	$("#WebOffice1").hide();
    	var okF=function(){
    		$("#WebOffice1").show();
        }
    		
    	var p={
    		headerText:'提示',
    		okName:'确认',
    		okFunction:okF
    	};
        alert("请先保存模板",p);
        return;
    }
    var url = "thpreviewwordtemplate.jsp?template_id_th="+template_id_th+"&abc=1507,1508,1509";
    
    var width = window.screen.availWidth;
    var height = window.screen.availHeight;
    var tempPara="dialogWidth:"+width+"px;dialogHeight:"+height+"px;";
    window.showModalDialog(url,window,tempPara);
}

//textInput属性对话框
function textInputWindow() {
  var url = "ccapp/oa/process/wordtemplate/thwordparam.jsp?template_id="+template_id_th+"&kj_type=textInput&window_source=1";
  //features = "dialogWidth:450px;dialogHeight:410px;";
  //var returnValue = window.showModalDialog(url,window,features);
	parent.frames["mainFrame"].$("#WebOffice1").hide();
    //var tempPara="dialogWidth:450px;dialogHeight:410px;";
	//window.showModalDialog(url,window,tempPara);
  openAlertWindows('windowId1',url+'&windowsId=windowId1','选择输入框','420px','350px','25%','25%',closeAlertWindowFun);
  
}
function closeAlertWindowFun(){
	parent.frames["mainFrame"].$("#WebOffice1").show();
}



/*
	函数：close_window
	描述：关闭窗口
	参数：
	返回值：
*/
function close_window(){
	var obj = getParentWindow('windowId');
	obj.userSearch();
	var windowId = 'windowId1';
	removeAlertWindowByWindowID(windowId);
	removeAlertWindows('windowId',false,true,'',false,'',true);
}

</script>	
</head>
<body>
<form action="" name="form1" method="post">
<div class="content_02_top" style="margin-bottom: 10px;" id="_top">
		<input id="saveButton" name="saveButton" type="button" class="but_y_01" value="保存模板" onClick="saveTemplet();" />
		<input class=but_y_01 type="button" id=btnSave onclick="textInputWindow()" value="输入框"> 
		<!-- <input id="saveButton" name="saveButton" type="button" class="but_y_01" value="预览" onClick="checkTemplet();" /> --> 
		<input id="saveButton" name="saveButton" type="button" class="but_y_01" value="关闭" onClick="close_window();" /> 
</div>
<table height="100%" width="100%" border="0">
	<tr>
		<td>
		<div id="WebOffice1" style="BORDER-RIGHT: black 0px solid; BORDER-TOP: black 1px solid; LEFT: 0px; OVERFLOW: auto; BORDER-LEFT: black 0px solid; WIDTH: 100%; BORDER-BOTTOM: black 0px solid; TOP: 0px; HEIGHT: 100%; BACKGROUND-COLOR: #ffffff">
		<OBJECT
			id="WebOffice_WebOffice1"
			style="LEFT: 0px; WIDTH: 100%; POSITION: absolute; TOP: -22px; HEIGHT: 100%" codeBase="../../resources/plug/iWebOffice2009/<%=cebversion %>"
			classid="clsid:8B23EA28-2009-402F-92C4-59BE0E063499" name="WebOffice">
			<PARAM NAME="Visible" VALUE="-1">
			<PARAM NAME="Caption" VALUE="HandWriteCtrl">
			<PARAM NAME="Color" VALUE="4278190095">
			<PARAM NAME="Font" VALUE="MS Sans Serif">
			<PARAM NAME="HelpFile" VALUE="">
			<PARAM NAME="Enabled" VALUE="-1">
			<PARAM NAME="RecordID" VALUE="">
			<PARAM NAME="UserName" VALUE="未定义">
			<PARAM NAME="EditType" VALUE="">
			<PARAM NAME="PenColor" VALUE="#FF0000">
			<PARAM NAME="PenWidth" VALUE="2">
			<PARAM NAME="Print" VALUE="0">
			<PARAM NAME="ExtParam" VALUE="">
			<PARAM NAME="ShowTools" VALUE="-1">
			<PARAM NAME="HideName" VALUE="">
			<PARAM NAME="Template" VALUE="">
			<PARAM NAME="FileName" VALUE="">
			<PARAM NAME="FileType" VALUE=".doc">
			<PARAM NAME="Status" VALUE="">
			<PARAM NAME="Copyright" VALUE="iWebOffice 9.3.2.0-vfC48b/GvLxpV2ViT2ZmaWNlMjAwNltWUNHdyr6w5lY5LjMuMi4wQ107MjAxMjsxOzI7Mzs0OzU7Njs3Ozg7OTtFWD1ERU1PX1ZQX1VDX0FTXzQ7VlA9VHJ1ZTtVQz1UcnVlO1U4PUZhbHNlO1JNPUZhbHNlO01UPUZhbHNlO0FTPVRydWU7RkM9NDs=">
			<PARAM NAME="ShowMenu" VALUE="-1">
			<PARAM NAME="Modify" VALUE="0">
			<PARAM NAME="CopyType" VALUE="-1">
			<PARAM NAME="ShowToolBar" VALUE="-1">
			<PARAM NAME="ShowTitle" VALUE="-1">
			<PARAM NAME="BodyStyle" VALUE="1">
			<PARAM NAME="InputText" VALUE="">
			<PARAM NAME="Zoom" VALUE="100">
			<PARAM NAME="ClearType" VALUE="0">
			<PARAM NAME="EnablePrint" VALUE="-1">
			<PARAM NAME="ShowType" VALUE="1">
			<PARAM NAME="ToolsSpace" VALUE="-1">
			<PARAM NAME="ClearPages" VALUE="-1">
			<PARAM NAME="Compressed" VALUE="0">
			<PARAM NAME="MaxFileSize" VALUE="8192">
			<PARAM NAME="ShowUsers" VALUE="-1">
			<PARAM NAME="ShowWindow" VALUE="0">
			<PARAM NAME="ShowAllUsers" VALUE="-1">
			<PARAM NAME="Office2007Ribbon" VALUE="4">
			<PARAM NAME="RibbonUIXml" VALUE="">
			<PARAM NAME="ShortCutKey" VALUE="CTRL+S">
			<PARAM NAME="ChangeSize" VALUE="-1">
			<PARAM NAME="Encrypted" VALUE="0">
			<PARAM NAME="Binary" VALUE="">
			<PARAM NAME="PopInputWindow" VALUE="0">
			<PARAM NAME="FontName" VALUE="宋体">
			<PARAM NAME="FontSize" VALUE="12">
			<PARAM NAME="FontColor" VALUE="255">
			<PARAM NAME="ShowPages" VALUE="">
			<PARAM NAME="PreviewEnable" VALUE="-1">
			<PARAM NAME="UIType" VALUE="-1">
			<PARAM NAME="InputSign" VALUE="">
			<PARAM NAME="UserConfig" VALUE="0">
			<PARAM NAME="AllowEmpty" VALUE="-1">
		</OBJECT>
		</div>
		</td>
	</tr>
</table>
</form>
</body>
</html>
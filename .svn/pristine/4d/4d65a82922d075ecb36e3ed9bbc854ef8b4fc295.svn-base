<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
	
<%
	String template_id = StringUtil.deNull(request.getParameter("template_id"));
%>

<%@page import="com.chinacreator.xtbg.pub.util.StringUtil"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<title></title>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>

<!-- 引入其它 -->
<script src="../../js/util/public.js" type="text/javascript"></script>
<script src="../../js/common/commoncss.js" type="text/javascript"></script>
	
<!-- 引入其它 -->
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-min.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<script type="text/javascript">

var iWebOffice = null;
var template_id = "<%=template_id %>";//模版ID
window.attachEvent("onload", function () {
	/*
    $("#WebOffice1").attachEvent("onresize", function() {
        var WebOfficeDiv = $("#WebOffice1");
        WebOfficeDiv.firstChild.style.height = parseInt(WebOfficeDiv.offsetHeight) - parseInt(WebOfficeDiv.firstChild.style.top) - 1 + "px";
        WebOfficeDiv.firstChild.style.width = parseInt(WebOfficeDiv.offsetWidth) + "px";
    });*/
    init();
});
var appUserName = "";
function init() {
    iWebOffice = document.getElementsByName("WebOffice")[0];
    var weburltemp = "../../../../../servlet/officeServer";
    iWebOffice.WebUrl = weburltemp; //设置控件与服务器交互的url地址
    iWebOffice.Template = "word"+template_id;
    iWebOffice.FileType = ".doc"; //设置文件类型，确定控件开发的应用程序
    iWebOffice.EditType = "1,0"; //设置编辑状态
    iWebOffice.ShowType = "1"; //设置显示状态
    iWebOffice.ShowToolBar = "0"; //是否显示工具栏 0不显示 1显示
    iWebOffice.ShowMenu = "0"; //是否显示菜单 0不显示 1显示
    iWebOffice.MaxFileSize = 64 * 1024; //设置文件最大值
    iWebOffice.Language="CH"; //设置界面显示语言
    iWebOffice.UserName = ""; //设置用户名
    /*
    var currentSystemID = creator_getSession("subsystem_id"); //设置应用id
    if (!IsSpace(currentSystemID) && currentSystemID != "module") {
        appUserName = "APP_" + currentSystemID.toUpperCase() + ".";
    }
    return;
    //-------------------------------------------------------
    //查询Word报表实例是否存在
    if(IsSpace(appUserName)){
        appUserName = "app_xzsp.";
    }
    var mbCount = DBUtil.SqlToField("select count(recordid) from " + appUserName + "td_octl_template_file where recordid='word"+template_id+"'");
    if(mbCount == 0) {
        createOrUpdateWordReport();
    } else {
        combakTemplet();
    }  
    */  
    //createOrUpdateWordReport();
    combakTemplet();
}

function combakTemplet() {
    iWebOffice.Template = "word"+template_id; //这是模板id
    iWebOffice.WebOpen();
}

/**
 * 给变量赋值
 */
function giveVariablesValue() {
    if(template_id == "") {
        template_id = parent.frames["rightFrame"].$("#template_id").val();
    }
    return template_id;
}

/**
 * 给一个新文档
 */
function createOrUpdateWordReport() {
	iWebOffice.Template = "word"+template_id; //这是模板id
    if (!iWebOffice.WebLoadTemplate()) { //加载对应的Word模板
        iWebOffice.CreateFile(); //容错处理，默认创建一个文档
    }
}

/**
 * 保存文档
 */
function saveTemplet() {
    template_id = giveVariablesValue();

    if(template_id == "" || template_id == "null") {
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
    iWebOffice.Template = "word"+template_id; //这是模板id
    iWebOffice.FileName = template_id+ ".doc"; //设置文件名
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
    	alert("模版保存成功",p)

    } else {
        alert("模版保存失败");
    }
}
/**
 * 保存文档,保存规则项目时调用
 */
function saveTempletFromRight() {
    iWebOffice.Template = "word"+template_id; //这是模板id
    iWebOffice.FileName = template_id+ ".doc"; //设置文件名
    iWebOffice.WebSaveTemplate(true);//平台方法
}

/**
 * 预览文档
 */
function checkTemplet() {
    var template_id = giveVariablesValue(); //模版基础信息ID
    if(IsSpace(template_id)){
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
    var url = "previewwordtemplate.jsp?template_id="+template_id+"&abc=1507,1508,1509";
    
//    var url = "20101124143257625133.jsp?template_id="+template_id+"";
//    url += "&abc=1507,1508,1509";
    var width = window.screen.availWidth;
    var height = window.screen.availHeight;
    var tempPara="dialogWidth:"+width+"px;dialogHeight:"+height+"px;";
    window.showModalDialog(url,window,tempPara);
}

function close_window(){
	var obj = getParentWindow('windowId');
	obj.userSearch();
	var windowId = 'windowId1';
	removeAlertWindowByWindowID(windowId);
	removeAlertWindows('windowId',false,true,'',false,'',true);

	//parent.closeWin();
    //window.close();
}
</script>	
</head>
<body>
<form action="" name="form1" method="post">
<TABLE height="100%" width="100%" border=0>
	<TBODY>
		<TR>
			<TD>
			<DIV id=WebOffice1 style="BORDER-RIGHT: black 0px solid; BORDER-TOP: black 1px solid; LEFT: 0px; OVERFLOW: auto; BORDER-LEFT: black 0px solid; WIDTH: 100%; BORDER-BOTTOM: black 0px solid; TOP: 0px; HEIGHT: 100%; BACKGROUND-COLOR: #ffffff">
			<OBJECT
				id=WebOffice_WebOffice1
				style="LEFT: 0px; WIDTH: 100%; POSITION: absolute; TOP: -22px; HEIGHT: 100%"
				codeBase=../iWebOffice2009/iWebOffice2009.cab#version=10,5,0,0
				classid=clsid:8B23EA28-2009-402F-92C4-59BE0E063499 name=WebOffice>
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
				<PARAM NAME="WebUrl"
					VALUE="../../../../../eformsys/fceform/design/">
				<PARAM NAME="ExtParam" VALUE="">
				<PARAM NAME="ShowTools" VALUE="-1">
				<PARAM NAME="HideName" VALUE="">
				<PARAM NAME="Template" VALUE="">
				<PARAM NAME="FileName" VALUE="">
				<PARAM NAME="FileType" VALUE=".doc">
				<PARAM NAME="Status" VALUE="">
				<PARAM NAME="Copyright"
					VALUE="iWebOffice 9.3.2.0-vfC48b/GvLxpV2ViT2ZmaWNlMjAwNltWUNHdyr6w5lY5LjMuMi4wQ107MjAxMjsxOzI7Mzs0OzU7Njs3Ozg7OTtFWD1ERU1PX1ZQX1VDX0FTXzQ7VlA9VHJ1ZTtVQz1UcnVlO1U4PUZhbHNlO1JNPUZhbHNlO01UPUZhbHNlO0FTPVRydWU7RkM9NDs=">
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
			</OBJECT></DIV>
			</TD>
		</TR>
		<TR>
			<TD height=40 align=center>
			 <div >
				<table  border="0" cellspacing="0" cellpadding="0"  >
				 
				 <TR>
						<TD  align=center>
						<input id=cButton_4text type="button" onclick="saveTemplet()" class=but_y_01 value="保存模板"/>
						<input id=cButton_3text type="button" onclick="checkTemplet()" class=but_y_01 value="预览"/>
						<input id=cButton_3text type="button" onclick="close_window()" class=but_y_01 value="关闭"/>
						</TD>
					</TR>
				</table>
			</div>
			
			</TD>
		</TR>
	</TBODY>
</TABLE>

</form>
</body>
</html>
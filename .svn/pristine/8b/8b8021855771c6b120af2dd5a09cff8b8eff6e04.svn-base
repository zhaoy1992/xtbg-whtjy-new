<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.OASystemCache" %>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%
	String template_id = request.getParameter("template_id");
	WordTemplateServiceIfc wordTemplate = new  WordTemplateServiceImpl();
	//request.setAttribute("datasetSqlValue",wordTemplate.getDatasetSqlValue(template_id));
	String cebversion = OASystemCache.getContextProperty("cebversion");
%>	

<%@page import="com.chinacreator.xtbg.core.common.iweboffice.service.WordTemplateServiceIfc"%>
<%@page import="com.chinacreator.xtbg.core.common.iweboffice.service.impl.WordTemplateServiceImpl"%><html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<title>预览word模板</title>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<!-- 引入其它 -->
<script src="../../resources/util/public.js" type="text/javascript"></script>
<script language="javascript" src="js/wordtemplateutil.js"> </script>
	
<script type="text/javascript">
var template_id = "<%=template_id%>";//模版ID
var FINGERPRINT = "74826222436241851208";
//autoUrlParam(); //解析Url传递的参数


function init() {
    iWebOffice = document.getElementsByName("WebOffice")[0];
    iWebOffice.WebUrl = "../../resources/plug/iWebOffice2009/OfficeServer.jsp"; //设置控件与服务器交互的url地址
    iWebOffice.FileType = ".doc"; //设置文件类型，确定控件开发的应用程序
    iWebOffice.EditType = "1,0"; //设置编辑状态
    iWebOffice.ShowType = "1"; //设置显示状态
    iWebOffice.ShowToolBar = "0"; //是否显示工具栏 0不显示 1显示
    iWebOffice.ShowMenu = "0"; //是否显示菜单 0不显示 1显示
    iWebOffice.MaxFileSize = 64 * 1024; //设置文件最大值
    iWebOffice.Language="CH"; //设置界面显示语言
    iWebOffice.UserName = ""; //设置用户名

    combakTemplet();
    checkTemplet();  
}

function combakTemplet() {
	iWebOffice = document.getElementsByName("WebOffice")[0];
    iWebOffice.Template = "word"+trim(template_id); //这是模板id
    iWebOffice.WebOpen();
}

/**
 * 预览文档
 */
function checkTemplet() {
	
	var rowcount = document.getElementsByName("rowcount");
	var idObj = document.getElementsByName("id");
	
	var kjNameObj = document.getElementsByName("name");
	var valueObj = document.getElementsByName("value");
	var valueTypeObj = document.getElementsByName("value_type");
	var kjTypeObj = document.getElementsByName("kj_type");
	var blNameObj = document.getElementsByName("value_name");
	var defaultValueObj = document.getElementsByName("default_value");
	

    var iWebOffice = document.getElementsByName("WebOffice")[0];

    for(var i=0; i<rowcount.length; i++) {
        var kjName = kjNameObj[i].value;
        var value = valueObj[i].value;
        var valueType = valueTypeObj[i].value;
        var kjType = kjTypeObj[i].value;//kj_type
        var blName = blNameObj[i].value;
        var name = "";
    	var blValue = "    ";
        
        if(kjType == "textInput") { //如果控件是输入文本
              if(valueType =="变量") {
                  blValue = defaultValueObj[i].value;
	              name = "ti_"+kjName;
            } else if (valueType =="数据集") {
                name = "ti_"+kjName;
            }
            setTextInputValue(iWebOffice.WebObject,name,blValue); //设置输入文本域的值
         }
        
    }
    documentProtect(iWebOffice.WebObject, FINGERPRINT);
}

function getdata(){
	var iWebOffice = document.getElementsByName("WebOffice")[0];
	var values = getTextInputValue(iWebOffice.WebObject,'OA_TEST_FORM__TITEL');
	alert(values);
}
</script>
</head>
<body onload = "init()">
<form action="" name="form1" method="post">
<TABLE height="100%" width="100%" border="0">
	<TBODY>
		<TR>
			<TD>
			<DIV id="WebOffice1" style="BORDER-RIGHT: black 0px solid; BORDER-TOP: black 1px solid; LEFT: 0px; OVERFLOW: auto; BORDER-LEFT: black 0px solid; WIDTH: 100%; BORDER-BOTTOM: black 0px solid; TOP: 0px; HEIGHT: 100%; BACKGROUND-COLOR: #ffffff">
			<OBJECT
				id="WebOffice_WebOffice1"
				style="LEFT: 0px; WIDTH: 100%; POSITION: absolute; TOP: -22px; HEIGHT: 100%"
				codeBase="../../resources/plug/iWebOffice2009/<%=cebversion %>"
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
			<TD height="40">
			<DIV align="center">
			<BUTTON id="btnClose" onclick="window.close()" class ="cButton">关闭</BUTTON>
			<BUTTON id="btnClose" onclick="getdata()" class ="cButton">获取数据</BUTTON>
			</DIV>
			</TD>
		</TR>
	</TBODY>
</TABLE>

</form>
</body>
</html>
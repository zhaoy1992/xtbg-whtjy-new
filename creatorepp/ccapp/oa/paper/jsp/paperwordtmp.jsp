<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.OASystemCache" %>
<%
	String p_rep_contents = StringUtil.deNull(request.getParameter("p_rep_contents"));
	String cebversion = OASystemCache.getContextProperty("cebversion");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=gbk">
	<title></title>
	<!-- 引入jQuery -->
	<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
	<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
	<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
	<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js"></script>
	<script type="text/javascript" src="../../resources/util/public.js"></script>
	<script type="text/javascript">
	/*
	函数：init
	描述：初始化方法
	*/
	function init(p_rep_contents) {
		iWebOffice = document.getElementsByName("WebOffice")[0];
		var weburltemp = "../../resources/plug/iWebOffice2009/OfficeServer.jsp";
		iWebOffice.WebUrl = weburltemp; //设置控件与服务器交互的url地址
		iWebOffice.FileType = ".doc"; //设置文件类型，确定控件开发的应用程序
		iWebOffice.EditType = "1,0"; //设置编辑状态
		iWebOffice.ShowType = "1"; //设置显示状态
		iWebOffice.ShowToolBar = "0"; //是否显示工具栏 0不显示 1显示
		iWebOffice.ShowMenu = "0"; //是否显示菜单 0不显示 1显示
		iWebOffice.MaxFileSize = 64 * 1024; //设置文件最大值
		iWebOffice.Language="CH"; //设置界面显示语言
		iWebOffice.UserName = ""; //设置用户名
		iWebOffice.RecordID = p_rep_contents;
		combakTemplet();
	}
	/*
	函数：saveWORD
	描述：保存WORD文件
	*/
	var saveWORD = function(p_rep_contents){
		iWebOffice.RecordID = p_rep_contents;
		iWebOffice.WebSave();
	}
	/*
	函数：combakTemplet
	描述：打开word编辑器
	*/
	function combakTemplet() {
		//iWebOffice.Template = "word"+template_id; //这是模板id
		iWebOffice.WebOpen();
	}
	</script>
</head>
<body>

<table>
	<tr>
		<td width="98%" align="left" valign="top">
			<OBJECT
				id="WebOffice_WebOffice1"
				style="LEFT: 0px; WIDTH: 100%; HEIGHT: 100%" codeBase="../../resources/plug/iWebOffice2009/<%=cebversion %>"
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
		</td>
	</tr>
</table>
</html>

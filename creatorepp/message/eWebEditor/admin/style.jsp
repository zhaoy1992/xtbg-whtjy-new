<%@ page contentType="text/html;charset=gb2312" pageEncoding="gb2312" session="true"%>
<%request.setCharacterEncoding("gb2312");%>
<%@ include file="private.jsp"%>
<%@ include file="button.jsp"%>
<%
/*
*######################################
* eWebEditor v4.00 - Advanced online web based WYSIWYG HTML editor.
* Copyright (c) 2003-2007 eWebSoft.com
*
* For further information go to http://www.ewebsoft.com/
* This copyright notice MUST stay intact for use.
*######################################
*/


String sStyleID = "", sStyleName = "", sStyleDir = "", sStyleCSS = "", sStyleUploadDir = "", sStyleWidth = "", sStyleHeight = "", sStyleMemo = "", sStyleStateFlag = "", sStyleDetectFromWord = "", sStyleInitMode = "", sStyleBaseUrl = "", sStyleUploadObject = "", sStyleAutoDir = "", sStyleBaseHref = "", sStyleContentPath = "", sStyleAutoRemote = "", sStyleShowBorder = "", sStyleAllowBrowse = "";
String sSLTFlag = "", sSLTMinSize = "", sSLTOkSize = "", sSYWZFlag = "", sSYText = "", sSYFontColor = "", sSYFontSize = "", sSYFontName = "", sSYPicPath = "", sSLTSYObject = "", sSLTSYExt = "", sSYWZMinWidth = "", sSYShadowColor = "", sSYShadowOffset = "", sSYWZMinHeight = "", sSYWZPosition = "", sSYWZTextWidth = "", sSYWZTextHeight = "", sSYWZPaddingH = "", sSYWZPaddingV = "", sSYTPFlag = "", sSYTPMinWidth = "", sSYTPMinHeight = "", sSYTPPosition = "", sSYTPPaddingH = "", sSYTPPaddingV = "", sSYTPImageWidth = "", sSYTPImageHeight = "", sSYTPOpacity = "", sCusDirFlag = "";
String sStyleFileExt = "", sStyleFlashExt = "", sStyleImageExt = "", sStyleMediaExt = "", sStyleRemoteExt = "", sStyleLocalExt = "", sStyleFileSize = "", sStyleFlashSize = "", sStyleImageSize = "", sStyleMediaSize = "", sStyleRemoteSize = "", sStyleLocalSize = "";
String sToolBarID = "", sToolBarName = "", sToolBarOrder = "", sToolBarButton = "";

int nStyleID = 0, nToolBarID = 0;

sPosition = sPosition + "��ʽ����";

// Init Style
if (sAction.equals("STYLEPREVIEW") || sAction.equals("COPY") || sAction.equals("STYLESET") || sAction.equals("STYLEDEL") || sAction.equals("CODE") || sAction.equals("TOOLBAR") || sAction.equals("TOOLBARADD") || sAction.equals("TOOLBARMODI") || sAction.equals("TOOLBARDEL") || sAction.equals("BUTTONSET") || sAction.equals("BUTTONSAVE")){
	boolean b = false;
	sStyleID = dealNull(request.getParameter("id"));
	if (isNumber(sStyleID)){
		nStyleID = Integer.valueOf(sStyleID).intValue();
		if (nStyleID < aStyle.size()){
			String[] aCurrStyle = split(aStyle.get(nStyleID).toString(), "|||");
			sStyleName = aCurrStyle[0];
			sStyleDir = aCurrStyle[1];
			sStyleCSS = aCurrStyle[2];
			sStyleUploadDir = aCurrStyle[3];
			sStyleBaseHref = aCurrStyle[22];
			sStyleContentPath = aCurrStyle[23];
			sStyleWidth = aCurrStyle[4];
			sStyleHeight = aCurrStyle[5];
			sStyleMemo = aCurrStyle[26];
			sStyleFileExt = aCurrStyle[6];
			sStyleFlashExt = aCurrStyle[7];
			sStyleImageExt = aCurrStyle[8];
			sStyleMediaExt = aCurrStyle[9];
			sStyleRemoteExt = aCurrStyle[10];
			sStyleFileSize = aCurrStyle[11];
			sStyleFlashSize = aCurrStyle[12];
			sStyleImageSize = aCurrStyle[13];
			sStyleMediaSize = aCurrStyle[14];
			sStyleRemoteSize = aCurrStyle[15];
			sStyleStateFlag = aCurrStyle[16];
			sStyleAutoRemote = aCurrStyle[24];
			sStyleShowBorder = aCurrStyle[25];
			sStyleUploadObject = aCurrStyle[20];
			sStyleAutoDir = aCurrStyle[21];
			sStyleDetectFromWord = aCurrStyle[17];
			sStyleInitMode = aCurrStyle[18];
			sStyleBaseUrl = aCurrStyle[19];
			sSLTFlag = aCurrStyle[29];
			sSLTMinSize = aCurrStyle[30];
			sSLTOkSize = aCurrStyle[31];
			sSYWZFlag = aCurrStyle[32];
			sSYText = aCurrStyle[33];
			sSYFontColor = aCurrStyle[34];
			sSYFontSize = aCurrStyle[35];
			sSYFontName = aCurrStyle[36];
			sSYPicPath = aCurrStyle[37];
			sSLTSYObject = aCurrStyle[38];
			sSLTSYExt = aCurrStyle[39];
			sSYWZMinWidth = aCurrStyle[40];
			sSYShadowColor = aCurrStyle[41];
			sSYShadowOffset = aCurrStyle[42];
			sStyleAllowBrowse = aCurrStyle[43];
			sStyleLocalExt = aCurrStyle[44];
			sStyleLocalSize = aCurrStyle[45];
			sSYWZMinHeight = aCurrStyle[46];
			sSYWZPosition = aCurrStyle[47];
			sSYWZTextWidth = aCurrStyle[48];
			sSYWZTextHeight = aCurrStyle[49];
			sSYWZPaddingH = aCurrStyle[50];
			sSYWZPaddingV = aCurrStyle[51];
			sSYTPFlag = aCurrStyle[52];
			sSYTPMinWidth = aCurrStyle[53];
			sSYTPMinHeight = aCurrStyle[54];
			sSYTPPosition = aCurrStyle[55];
			sSYTPPaddingH = aCurrStyle[56];
			sSYTPPaddingV = aCurrStyle[57];
			sSYTPImageWidth = aCurrStyle[58];
			sSYTPImageHeight = aCurrStyle[59];
			sSYTPOpacity = aCurrStyle[60];
			sCusDirFlag = aCurrStyle[61];
			b = true;
		}
	}
	if (!b){
		out.print(getError("��Ч����ʽID�ţ���ͨ��ҳ���ϵ����ӽ��в�����"));
		return;
	}
}


if (sAction.equals("STYLEPREVIEW")){
	out.print("<html><head>"
		+ "<title>��ʽԤ��</title>"
		+ "<meta http-equiv='Content-Type' content='text/html; charset=gb2312'>"
		+ "</head><%@ include file="/epp/css/cssControl.jsp"%><body>"
		+ "<input type=hidden name=content1  value=''>"
		+ "<iframe ID='eWebEditor1' src='../ewebeditor.htm?id=content1&style=" + sStyleName + "' frameborder=0 scrolling=no width='" + sStyleWidth + "' HEIGHT='" + sStyleHeight + "'></iframe>"
		+ "</body></html>");
	return;
}

out.print(Header());

out.print("<table border=0 cellspacing=1 align=center class=navi>"
	+"<tr><th>" + sPosition + "</th></tr>"
	+"<tr><td align=center>[<a href='?'>������ʽ�б�</a>]&nbsp;&nbsp;&nbsp;&nbsp;[<a href='?action=styleadd'>�½�һ��ʽ</a>]&nbsp;&nbsp;&nbsp;&nbsp;[<a href='?action=updateconfig'>����������ʽ��ǰ̨�����ļ�</a>]&nbsp;&nbsp;&nbsp;&nbsp;[<a href='#' onclick='history.back()'>����ǰһҳ</a>]</td></tr>"
	+"</table><br>");

// Init Toolbar
if (sAction.equals("BUTTONSET") || sAction.equals("BUTTONSAVE")){
	boolean b = false;
	sToolBarID = dealNull(request.getParameter("toolbarid"));
	if (isNumber(sToolBarID)){
		nToolBarID = Integer.valueOf(sToolBarID).intValue();
		if ((nToolBarID < aToolbar.size()) && (nToolBarID >= 0)){
			String[] aCurrToolbar = split(aToolbar.get(nToolBarID).toString(), "|||");
			sToolBarName = aCurrToolbar[2];
			sToolBarOrder = aCurrToolbar[3];
			sToolBarButton = aCurrToolbar[1];
			b = true;
		}
	}
	if (!b){
		out.print(getError("��Ч�Ĺ�����ID�ţ���ͨ��ҳ���ϵ����ӽ��в�����"));
		return;
	}

}


if(sAction.equals("UPDATECONFIG")){

	WriteConfig(eWebEditorPath, sUsername, sPassword, aStyle, aToolbar);
	for(int i=0; i<aStyle.size(); i++){
		WriteStyle(eWebEditorPath, aStyle, aToolbar, i);
	}
	out.print(GetMessage("<b><span class=red>������ʽ��ǰ̨�����ļ����²����ɹ���</span></b><li><a href='?'>����������ʽ�б�</a>"));

}else if(sAction.equals("STYLEADD") || sAction.equals("STYLESET")){

	String s_Title, s_Action;
	String s_FormStateFlag, s_FormDetectFromWord, s_FormInitMode, s_FormBaseUrl, s_FormUploadObject, s_FormAutoDir, s_FormAutoRemote, s_FormShowBorder, s_FormSLTFlag, s_FormSYWZFlag, s_FormSLTSYObject, s_FormAllowBrowse, s_FormSYTPFlag, s_FormSYWZPosition, s_FormSYTPPosition, s_FormCusDirFlag;
	
	if(sAction.equals("STYLEADD")){
		sStyleID = "";
		sStyleName = "";
		sStyleDir = "blue";
		sStyleCSS = "coolblue";
		sStyleUploadDir = "uploadfile/";
		sStyleBaseHref = "";
		sStyleContentPath = "";
		sStyleWidth = "550";
		sStyleHeight = "350";
		sStyleMemo = "";
		s_Title = "������ʽ";
		s_Action = "StyleAddSave";
		sStyleFileExt = "rar|zip|exe|doc|xls|chm|hlp";
		sStyleFlashExt = "swf";
		sStyleImageExt = "gif|jpg|jpeg|bmp";
		sStyleMediaExt = "rm|mp3|wav|mid|midi|ra|avi|mpg|mpeg|asf|asx|wma|mov";
		sStyleRemoteExt = "gif|jpg|bmp";
		sStyleFileSize = "500";
		sStyleFlashSize = "100";
		sStyleImageSize = "100";
		sStyleMediaSize = "100";
		sStyleRemoteSize = "100";
		sStyleStateFlag = "1";
		sStyleAutoRemote = "1";
		sStyleShowBorder = "0";
		sStyleAllowBrowse = "0";
		sStyleUploadObject = "0";
		sStyleAutoDir = "0";
		sStyleDetectFromWord = "1";
		sStyleInitMode = "EDIT";
		sStyleBaseUrl = "1";
		sSLTFlag = "0";
		sSLTMinSize = "300";
		sSLTOkSize = "120";
		sSYWZFlag = "0";
		sSYText = "��Ȩ����...";
		sSYFontColor = "000000";
		sSYFontSize = "12";
		sSYFontName = "����";
		sSYPicPath = "";
		sSLTSYObject = "0";
		sSLTSYExt = "bmp|jpg|jpeg|gif";
		sSYWZMinWidth = "100";
		sSYShadowColor = "FFFFFF";
		sSYShadowOffset = "1";
		sStyleLocalExt = "gif|jpg|bmp|wmz";
		sStyleLocalSize = "100";
		sSYWZMinHeight = "100";
		sSYWZPosition = "1";
		sSYWZTextWidth = "66";
		sSYWZTextHeight = "17";
		sSYWZPaddingH = "5";
		sSYWZPaddingV = "5";
		sSYTPFlag = "0";
		sSYTPMinWidth = "100";
		sSYTPMinHeight = "100";
		sSYTPPosition = "1";
		sSYTPPaddingH = "5";
		sSYTPPaddingV = "5";
		sSYTPImageWidth = "88";
		sSYTPImageHeight = "31";
		sSYTPOpacity = "1";
		sCusDirFlag = "0";
	}else{
		sStyleName = htmlEncode(sStyleName);
		sStyleDir = htmlEncode(sStyleDir);
		sStyleCSS = htmlEncode(sStyleCSS);
		sStyleUploadDir = htmlEncode(sStyleUploadDir);
		sStyleBaseHref = htmlEncode(sStyleBaseHref);
		sStyleContentPath = htmlEncode(sStyleContentPath);
		sStyleMemo = htmlEncode(sStyleMemo);
		sSYText = htmlEncode(sSYText);
		sSYFontColor = htmlEncode(sSYFontColor);
		sSYFontSize = htmlEncode(sSYFontSize);
		sSYFontName = htmlEncode(sSYFontName);
		sSYPicPath = htmlEncode(sSYPicPath);
		s_Title = "������ʽ";
		s_Action = "StyleSetSave";
	}

	s_FormStateFlag = GetSelect("d_stateflag", split("��ʾ|����ʾ", "|"), split("1|0", "|"), sStyleStateFlag, "");
	s_FormAutoRemote = GetSelect("d_autoremote", split("�Զ��ϴ�|���Զ��ϴ�", "|"), split("1|0", "|"), sStyleAutoRemote, "");
	s_FormShowBorder = GetSelect("d_showborder", split("Ĭ����ʾ|Ĭ�ϲ���ʾ", "|"), split("1|0", "|"), sStyleShowBorder, "");
	s_FormAllowBrowse = GetSelect("d_allowbrowse", split("��,����|��,�ر�", "|"), split("1|0", "|"), sStyleAllowBrowse, "");
	
	s_FormUploadObject = GetSelect("d_uploadobject", split("jspSmartUpload", "|"), split("0", "|"), sStyleUploadObject, "");
	s_FormAutoDir = GetSelect("d_autodir", split("��ʹ��|��Ŀ¼|����Ŀ¼|������Ŀ¼", "|"), split("0|1|2|3", "|"), sStyleAutoDir, "");
	s_FormDetectFromWord = GetSelect("d_detectfromword", split("�Զ��������ʾ|���Զ����", "|"), split("1|0", "|"), sStyleDetectFromWord, "");
	s_FormInitMode = GetSelect("d_initmode", split("����ģʽ|�༭ģʽ|�ı�ģʽ|Ԥ��ģʽ", "|"), split("CODE|EDIT|TEXT|VIEW", "|"), sStyleInitMode, "");
	s_FormBaseUrl = GetSelect("d_baseurl", split("���·��|���Ը�·��|����ȫ·��", "|"), split("0|1|2", "|"), sStyleBaseUrl, "");

	s_FormSLTFlag = GetSelect("d_sltflag", split("ʹ��|��ʹ��", "|"), split("1|0", "|"), sSLTFlag, "");
	s_FormSYWZFlag = GetSelect("d_sywzflag", split("ʹ��|��ʹ��", "|"), split("1|0", "|"), sSYWZFlag, "");
	s_FormSLTSYObject = GetSelect("d_sltsyobject", split("JDK1.4 ImageIO", "|"), split("0", "|"), sSLTSYObject, "");

	s_FormSYTPFlag = GetSelect("d_sytpflag", split("ʹ��|��ʹ��", "|"), split("1|0", "|"), sSYTPFlag, "");
	s_FormSYWZPosition = GetSelect("d_sywzposition", split("����|����|����|����|����|����|����|����|����", "|"), split("1|2|3|4|5|6|7|8|9", "|"), sSYWZPosition, "");
	s_FormSYTPPosition = GetSelect("d_sytpposition", split("����|����|����|����|����|����|����|����|����", "|"), split("1|2|3|4|5|6|7|8|9", "|"), sSYTPPosition, "");
	s_FormCusDirFlag = GetSelect("d_cusdirflag", split("����|����", "|"), split("0|1", "|"), sCusDirFlag, "");
	
	out.print("<table border=0 cellpadding=0 cellspacing=1 align=center class=form>" +
			"<form action='?action=" + s_Action + "&id=" + sStyleID + "' method=post name=myform>" +
			"<tr><th colspan=4>&nbsp;&nbsp;" + s_Title + "������Ƶ������ɿ�˵������*��Ϊ�����</th></tr>" +
			"<tr><td width='15%'>��ʽ���ƣ�</td><td width='35%'><input type=text class=input size=20 name=d_name title='���ô���ʽ�����֣���Ҫ���������' value=\"" + sStyleName + "\"> <span class=red>*</span></td><td width='15%'>��ʼģʽ��</td><td width='35%'>" + s_FormInitMode + " <span class=red>*</span></td></tr>" +
			"<tr><td width='15%'>ͼƬĿ¼��</td><td width='35%'><input type=text class=input size=20 name=d_dir title='��Ŵ���ʽͼƬ�ļ���Ŀ¼����������ButtonImage��' value=\"" + sStyleDir + "\"> <span class=red>*</span></td><td width='15%'>��ʽĿ¼��</td><td width='35%'><input type=text class=input size=20 name=d_css title='��Ŵ���ʽcss�ļ���Ŀ¼����������CSS��' value=\"" + sStyleCSS + "\"> <span class=red>*</span></td></tr>" +
			"<tr><td width='15%'>��ѿ�ȣ�</td><td width='35%'><input type=text class=input name=d_width size=20 title='�������Ч���Ŀ�ȣ�������' value='" + sStyleWidth + "'> <span class=red>*</span></td><td width='15%'>��Ѹ߶ȣ�</td><td width='35%'><input type=text class=input name=d_height size=20 title='�������Ч���ĸ߶ȣ�������' value='" + sStyleHeight + "'> <span class=red>*</span></td></tr>" +
			"<tr><td width='15%'>״ ̬ ����</td><td width='35%'>" + s_FormStateFlag + " <span class=red>*</span></td><td width='15%'>Wordճ����</td><td width='35%'>" + s_FormDetectFromWord + " <span class=red>*</span></td></tr>" +
			"<tr><td width='15%'>Զ���ļ���</td><td width='35%'>" + s_FormAutoRemote + " <span class=red>*</span></td><td width='15%'>ָ�����룺</td><td width='35%'>" + s_FormShowBorder + " <span class=red>*</span></td></tr>" +
			"<tr><td>��ע˵����</td><td colspan=3><input type=text name=d_memo size=90 title='����ʽ��˵�����������ڵ���' value=\"" + sStyleMemo + "\"></td></tr>" + 
			"<tr><td colspan=4><span class=red>&nbsp;&nbsp;&nbsp;�ϴ�������ã�ֻ����ʹ�����·��ģʽʱ����Ҫ������ʾ·��������·������</span></td></tr>" +
			"<tr><td width='15%'>�ϴ������</td><td width='35%'>" + s_FormUploadObject + " <span class=red>*</span></td><td width='15%'>�������Զ�Ŀ¼��</td><td width='35%'>" + s_FormAutoDir + " <span class=red>*</span></td></tr>" +
			"<tr><td width='15%'>�ϴ��ļ������</td><td width='35%'>" + s_FormAllowBrowse + " <span class=red>*</span></td><td width='15%'>�Զ��ϴ�·���ӿڣ�</td><td width='35%'>" + s_FormCusDirFlag + "</td></tr>" +
			"<tr><td width='15%'>·��ģʽ��</td><td width='35%'>" + s_FormBaseUrl + " <span class=red>*</span> <a href='#baseurl'>˵��</a></td><td width='15%'>�ϴ�·����</td><td width='35%'><input type=text class=input size=20 name=d_uploaddir title='�ϴ��ļ������·�������eWebEditor��Ŀ¼�ļ���·��' value=\"" + sStyleUploadDir + "\"> <span class=red>*</span></td></tr>" +
			"<tr><td width='15%'>��ʾ·����</td><td width='35%'><input type=text class=input size=20 name=d_basehref title='��ʾ����ҳ�����·����������&quot;/&quot;��ͷ' value=\"" + sStyleBaseHref + "\"></td><td width='15%'>����·����</td><td width='35%'><input type=text class=input size=20 name=d_contentpath title='ʵ�ʱ����������е�·���������ʾ·����·����������&quot;/&quot;��ͷ' value=\"" + sStyleContentPath + "\"></td></tr>" +
			"<tr><td colspan=4><span class=red>&nbsp;&nbsp;&nbsp;�����ϴ��ļ����ͼ��ļ���С���ã��ļ���С��λΪKB��0��ʾ��������</span></td></tr>" +
			"<tr><td width='15%'>ͼƬ���ͣ�</td><td width='35%'><input type=text class=input name=d_imageext size=20 title='����ͼƬ��ص��ϴ�' value='" + sStyleImageExt + "'></td><td width='15%'>ͼƬ���ƣ�</td><td width='35%'><input type=text class=input name=d_imagesize size=20 title='�����ͣ���λKB' value='" + sStyleImageSize + "'></td></tr>" +
			"<tr><td width='15%'>Flash���ͣ�</td><td width='35%'><input type=text class=input name=d_flashext size=20 title='���ڲ���Flash����' value='" + sStyleFlashExt + "'></td><td width='15%'>Flash���ƣ�</td><td width='35%'><input type=text class=input name=d_flashsize size=20 title='�����ͣ���λKB' value='" + sStyleFlashSize + "'></td></tr>" +
			"<tr><td width='15%'>ý�����ͣ�</td><td width='35%'><input type=text class=input name=d_mediaext size=20 title='���ڲ���ý���ļ�' value='" + sStyleMediaExt + "'></td><td width='15%'>ý�����ƣ�</td><td width='35%'><input type=text class=input name=d_mediasize size=20 title='�����ͣ���λKB' value='" + sStyleMediaSize + "'></td></tr>" +
			"<tr><td width='15%'>�������ͣ�</td><td width='35%'><input type=text class=input name=d_fileext size=20 title='���ڲ��������ļ�' value='" + sStyleFileExt + "'></td><td width='15%'>�������ƣ�</td><td width='35%'><input type=text class=input name=d_filesize size=20 title='�����ͣ���λKB' value='" + sStyleFileSize + "'></td></tr>" +
			"<tr><td width='15%'>Զ�����ͣ�</td><td width='35%'><input type=text class=input name=d_remoteext size=20 title='�����Զ��ϴ�Զ���ļ�' value='" + sStyleRemoteExt + "'></td><td width='15%'>Զ�����ƣ�</td><td width='35%'><input type=text class=input name=d_remotesize size=20 title='�����ͣ���λKB' value='" + sStyleRemoteSize + "'></td></tr>" +
			"<tr><td width='15%'>�������ͣ�</td><td width='35%'><input type=text class=input name=d_localext size=20 title='�����Զ��ϴ������ļ�' value='" + sStyleLocalExt + "'></td><td width='15%'>�������ƣ�</td><td width='35%'><input type=text class=input name=d_localsize size=20 title='�����ͣ���λKB' value='" + sStyleLocalSize + "'>KB</td></tr>" +
			"<tr><td colspan=4><span class=red>&nbsp;&nbsp;&nbsp;����ͼ��ˮӡ������ã�</span></td></tr>" +
			"<tr><td width='15%'>ͼ�δ��������</td><td width='35%'>" + s_FormSLTSYObject + "</td><td width='15%'>����ͼ����չ����</td><td width='35%'><input type=text name=d_sltsyext size=20 class=input value=\"" + sSLTSYExt + "\"></td></tr>" +
			"<tr><td width='15%'>����ͼʹ��״̬��</td><td width='35%'>" + s_FormSLTFlag + "</td><td width='15%'>����ͼ��������</td><td width='35%'><input type=text name=d_sltminsize size=20 class=input title='ͼ�εĳ���ֻ�дﵽ����С����Ҫ��ʱ�Ż���������ͼ��������' value='" + sSLTMinSize + "'>px</td></tr>" +
			"<tr><td width='15%'>����ͼ���ɳ��ȣ�</td><td width='35%'><input type=text name=d_sltoksize size=20 class=input title='���ɵ�����ͼ����ֵ��������' value='" + sSLTOkSize + "'>px</td><td width='15%'>&nbsp;</td><td width='35%'>&nbsp;</td></tr>" +
			"<tr><td width='15%'>����ˮӡʹ��״̬��</td><td width='35%'>" + s_FormSYWZFlag + "</td><td width='15%'>����ˮӡ����������</td><td width='35%'>��:<input type=text name=d_sywzminwidth size=4 class=input title='ͼ�εĿ��ֻ�дﵽ����С���Ҫ��ʱ�Ż�����ˮӡ��������' value='" + sSYWZMinWidth + "'>px&nbsp; ��:<input type=text name=d_sywzminheight size=4 class=input title='ͼ�εĸ߶�ֻ�дﵽ����С�߶�Ҫ��ʱ�Ż�����ˮӡ��������' value='" + sSYWZMinHeight + "'>px</td></tr>" +
			"<tr><td width='15%'>����ˮӡ���ݣ�</td><td width='35%'><input type=text name=d_sytext size=20 class=input title='��ʹ������ˮӡʱ����������' value=\"" + sSYText + "\"></td><td width='15%'>����ˮӡ������ɫ��</td><td width='35%'><input type=text name=d_syfontcolor size=20 class=input title='��ʹ������ˮӡʱ���ֵ���ɫ' value=\"" + sSYFontColor + "\"></td></tr>" +
			"<tr><td width='15%'>����ˮӡ��Ӱ��ɫ��</td><td width='35%'><input type=text name=d_syshadowcolor size=20 class=input title='��ʹ������ˮӡʱ��������Ӱ��ɫ' value=\"" + sSYShadowColor + "\"></td><td width='15%'>����ˮӡ��Ӱ��С��</td><td width='35%'><input type=text name=d_syshadowoffset size=20 class=input title='��ʹ������ˮӡʱ���ֵ���Ӱ��С' value=\"" + sSYShadowOffset + "\">px</td></tr>" +
			"<tr><td width='15%'>����ˮӡ�����С��</td><td width='35%'><input type=text name=d_syfontsize size=20 class=input title='��ʹ������ˮӡʱ���ֵ������С' value=\"" + sSYFontSize + "\">px</td><td width='15%'>����ˮӡ�������ƣ�</td><td width='35%'><input type=text name=d_syfontname size=20 class=input title='��ʹ������ˮӡʱ���ֵ�������' value=\"" + sSYFontName + "\"></td></tr>" +
			"<tr><td width='15%'>����ˮӡλ�ã�</td><td width='35%'>" + s_FormSYWZPosition + "</td><td width='15%'>����ˮӡ�߾ࣺ</td><td width='35%'>����:<input type=text name=d_sywzpaddingh size=4 class=input title='����ʱ����Ϊ��߾࣬����ʱ����Ϊ�ұ߾࣬������' value='" + sSYWZPaddingH + "'>px&nbsp; ����:<input type=text name=d_sywzpaddingv size=4 class=input title='����ʱ����Ϊ�ϱ߾࣬����ʱ����Ϊ�±߹�������' value='" + sSYWZPaddingV + "'>px</td></tr>" +
			"<tr><td width='15%'>����ˮӡ����ռλ��</td><td width='35%'>��:<input type=text name=d_sywztextwidth size=4 class=input title='ˮӡ���ֵ�ռλ��ȣ��������������С�����õ�Ч��ȷ����������' value='" + sSYWZTextWidth + "'>px&nbsp; ��:<input type=text name=d_sywztextheight size=4 class=input title='ˮӡ���ֵ�ռλ�߶ȣ��������������С�����õ�Ч��ȷ����������' value='" + sSYWZTextHeight + "'>px&nbsp; <input type=button value='�����' onclick='doCheckWH(1)'></td><td width='15%'></td><td width='35%'></td></tr>" +
			"<tr><td width='15%'>ͼƬˮӡʹ��״̬��</td><td width='35%'>" + s_FormSYTPFlag + "</td><td width='15%'>ͼƬˮӡ����������</td><td width='35%'>��:<input type=text name=d_sytpminwidth size=4 class=input title='ͼ�εĿ��ֻ�дﵽ����С���Ҫ��ʱ�Ż�����ˮӡ��������' value='" + sSYTPMinWidth + "'>px&nbsp; ��:<input type=text name=d_sytpminheight size=4 class=input title='ͼ�εĸ߶�ֻ�дﵽ����С�߶�Ҫ��ʱ�Ż�����ˮӡ��������' value='" + sSYTPMinHeight + "'>px</td></tr>" +
			"<tr><td width='15%'>ͼƬˮӡλ�ã�</td><td width='35%'>" + s_FormSYTPPosition + "</td><td width='15%'>ͼƬˮӡ�߾ࣺ</td><td width='35%'>����:<input type=text name=d_sytppaddingh size=4 class=input title='����ʱ����Ϊ��߾࣬����ʱ����Ϊ�ұ߾࣬������' value='" + sSYTPPaddingH + "'>px&nbsp; ����:<input type=text name=d_sytppaddingv size=4 class=input title='����ʱ����Ϊ�ϱ߾࣬����ʱ����Ϊ�±߹�������' value='" + sSYTPPaddingV + "'>px</td></tr>" +
			"<tr><td width='15%'>ͼƬˮӡͼƬ·����</td><td width='35%'><input type=text name=d_sypicpath size=20 class=input title='��ʹ��ͼƬˮӡʱͼƬ��·��' value=\"" + sSYPicPath + "\"></td><td width='15%'>ͼƬˮӡ͸���ȣ�</td><td width='35%'><input type=text name=d_sytpopacity size=20 class=input title='0��1������֣���0.5��ʾ��͸��' value=\"" + sSYTPOpacity + "\"></td></tr>" +
			"<tr><td width='15%'>ͼƬˮӡͼƬռλ��</td><td width='35%'>��:<input type=text name=d_sytpimagewidth size=4 class=input title='ˮӡͼƬ�Ŀ�ȣ�������' value='" + sSYTPImageWidth + "'>px&nbsp; ��:<input type=text name=d_sytpimageheight size=4 class=input title='ˮӡͼƬ�ĸ߶ȣ�������' value='" + sSYTPImageHeight + "'>px&nbsp; <input type=button value='�����' onclick='doCheckWH(2)'></td><td width='15%'></td><td width='35%'></td></tr>" +
			"<tr><td width='15%'>ˮӡ��߼������</td><td width='85%' colspan=3><span id=tdPreview></span></td></tr>" +	
			"<tr><td align=center colspan=4><input type=submit value='  �ύ  ' align=absmiddle>&nbsp;<input type=reset name=btnReset value='  ����  '></td></tr>" +
			"</form>" +
			"</table><br>");

	String s_Msg = "<a name=baseurl></a><p><span class=blue><b>·��ģʽ����˵����</b></span><br>" +
		"<b>���·����</b>ָ���е�����ϴ����Զ������ļ�·�����༭����\"UploadFile/...\"��\"../UploadFile/...\"��ʽ���֣���ʹ�ô�ģʽʱ����ʾ·��������·�������ʾ·��������\"/\"��ͷ�ͽ�β������·�������в�����\"/\"��ͷ��<br>" +
		"<b>���Ը�·����</b>ָ���е�����ϴ����Զ������ļ�·�����༭����\"/eWebEditor/UploadFile/...\"������ʽ���֣���ʹ�ô�ģʽʱ����ʾ·��������·�������<br>" +
		"<b>����ȫ·����</b>ָ���е�����ϴ����Զ������ļ�·�����༭����\"http://xxx.xxx.xxx/eWebEditor/UploadFile/...\"������ʽ���֣���ʹ�ô�ģʽʱ����ʾ·��������·�������</p>";

	out.print(GetMessage(s_Msg));


}else if(sAction.equals("STYLEADDSAVE") || sAction.equals("STYLESETSAVE")){


	sStyleName = dealNull(request.getParameter("d_name"));
	sStyleDir = dealNull(request.getParameter("d_dir"));
	sStyleCSS = dealNull(request.getParameter("d_css"));
	sStyleUploadDir = dealNull(request.getParameter("d_uploaddir"));
	sStyleBaseHref = dealNull(request.getParameter("d_basehref"));
	sStyleContentPath = dealNull(request.getParameter("d_contentpath"));
	sStyleWidth = dealNull(request.getParameter("d_width"));
	sStyleHeight = dealNull(request.getParameter("d_height"));
	sStyleMemo = dealNull(request.getParameter("d_memo"));
	sStyleImageExt = dealNull(request.getParameter("d_imageext"));
	sStyleFlashExt = dealNull(request.getParameter("d_flashext"));
	sStyleMediaExt = dealNull(request.getParameter("d_mediaext"));
	sStyleRemoteExt = dealNull(request.getParameter("d_remoteext"));
	sStyleFileExt = dealNull(request.getParameter("d_fileext"));
	sStyleImageSize = dealNull(request.getParameter("d_imagesize"));
	sStyleFlashSize = dealNull(request.getParameter("d_flashsize"));
	sStyleMediaSize = dealNull(request.getParameter("d_mediasize"));
	sStyleRemoteSize = dealNull(request.getParameter("d_remotesize"));
	sStyleFileSize = dealNull(request.getParameter("d_filesize"));
	sStyleStateFlag = dealNull(request.getParameter("d_stateflag"));
	sStyleAutoRemote = dealNull(request.getParameter("d_autoremote"));
	sStyleShowBorder = dealNull(request.getParameter("d_showborder"));
	sStyleAllowBrowse = dealNull(request.getParameter("d_allowbrowse"));
	sStyleUploadObject = dealNull(request.getParameter("d_uploadobject"));
	sStyleAutoDir = dealNull(request.getParameter("d_autodir"));
	sStyleDetectFromWord = dealNull(request.getParameter("d_detectfromword"));
	sStyleInitMode = dealNull(request.getParameter("d_initmode"));
	sStyleBaseUrl = dealNull(request.getParameter("d_baseurl"));
	sSLTFlag = dealNull(request.getParameter("d_sltflag"));
	sSLTMinSize = dealNull(request.getParameter("d_sltminsize"));
	sSLTOkSize = dealNull(request.getParameter("d_sltoksize"));
	sSYWZFlag = dealNull(request.getParameter("d_sywzflag"));
	sSYText = dealNull(request.getParameter("d_sytext"));
	sSYFontColor = dealNull(request.getParameter("d_syfontcolor"));
	sSYFontSize = dealNull(request.getParameter("d_syfontsize"));
	sSYFontName = dealNull(request.getParameter("d_syfontname"));
	sSYPicPath = dealNull(request.getParameter("d_sypicpath"));
	sSLTSYObject = dealNull(request.getParameter("d_sltsyobject"));
	sSLTSYExt = dealNull(request.getParameter("d_sltsyext"));
	sSYWZMinWidth = dealNull(request.getParameter("d_sywzminwidth"));
	sSYShadowColor = dealNull(request.getParameter("d_syshadowcolor"));
	sSYShadowOffset = dealNull(request.getParameter("d_syshadowoffset"));
	sStyleLocalExt = dealNull(request.getParameter("d_localext"));
	sStyleLocalSize = dealNull(request.getParameter("d_localsize"));
	sSYWZMinHeight = dealNull(request.getParameter("d_sywzminheight"));
	sSYWZPosition = dealNull(request.getParameter("d_sywzposition"));
	sSYWZTextWidth = dealNull(request.getParameter("d_sywztextwidth"));
	sSYWZTextHeight = dealNull(request.getParameter("d_sywztextheight"));
	sSYWZPaddingH = dealNull(request.getParameter("d_sywzpaddingh"));
	sSYWZPaddingV = dealNull(request.getParameter("d_sywzpaddingv"));
	sSYTPFlag = dealNull(request.getParameter("d_sytpflag"));
	sSYTPMinWidth = dealNull(request.getParameter("d_sytpminwidth"));
	sSYTPMinHeight = dealNull(request.getParameter("d_sytpminheight"));
	sSYTPPosition = dealNull(request.getParameter("d_sytpposition"));
	sSYTPPaddingH = dealNull(request.getParameter("d_sytppaddingh"));
	sSYTPPaddingV = dealNull(request.getParameter("d_sytppaddingv"));
	sSYTPImageWidth = dealNull(request.getParameter("d_sytpimagewidth"));
	sSYTPImageHeight = dealNull(request.getParameter("d_sytpimageheight"));
	sSYTPOpacity = dealNull(request.getParameter("d_sytpopacity"));
	sCusDirFlag = dealNull(request.getParameter("d_cusdirflag"));

	sStyleUploadDir = replace(sStyleUploadDir, "\\", "/");
	sStyleBaseHref = replace(sStyleBaseHref, "\\", "/");
	sStyleContentPath = replace(sStyleContentPath, "\\", "/");

	int nStrLen = 0;
	if (!sStyleUploadDir.equals("")){
		nStrLen = sStyleUploadDir.length();
		if (!sStyleUploadDir.substring(nStrLen-1, nStrLen).equals("/")){
			sStyleUploadDir += "/";
		}
	}
	if (!sStyleBaseHref.equals("")){
		nStrLen = sStyleBaseHref.length();
		if (!sStyleBaseHref.substring(nStrLen-1, nStrLen).equals("/")){
			sStyleBaseHref += "/";
		}
	}
	if (!sStyleContentPath.equals("")){
		nStrLen = sStyleContentPath.length();
		if (!sStyleContentPath.substring(nStrLen-1, nStrLen).equals("/")){
			sStyleContentPath += "/";
		}
	}

	if (sStyleName.equals("")) {
		out.print(getError("��ʽ������Ϊ�գ�"));
		return;
	}
	if (!IsSafeStr(sStyleName)){
		out.print(getError("��ʽ��������������ַ���"));
		return;
	}
	if (sStyleDir.equals("")) {
		out.print(getError("��ťͼƬĿ¼������Ϊ�գ�"));
		return;
	}
	if (!IsSafeStr(sStyleDir)) {
		out.print(getError("��ťͼƬĿ¼��������������ַ���"));
		return;
	}
	if (sStyleCSS.equals("")) {
		out.print(getError("��ʽCSSĿ¼������Ϊ�գ�"));
		return;
	}
	if (!IsSafeStr(sStyleCSS)) {
		out.print(getError("��ʽCSSĿ¼��������������ַ���"));
		return;
	}

	if (sStyleUploadDir.equals("")) {
		out.print(getError("�ϴ�·������Ϊ�գ�"));
		return;
	}
	if (!IsSafeStr(sStyleUploadDir)) {
		out.print(getError("�ϴ�·��������������ַ���"));
		return;
	}
	if (sStyleBaseUrl.equals("0")){
		if (sStyleBaseHref.equals("")) {
			out.print(getError("��ʹ�����·��ģʽʱ����ʾ·������Ϊ�գ�"));
			return;
		}
		if (!IsSafeStr(sStyleBaseHref)) {
			out.print(getError("��ʹ�����·��ģʽʱ����ʾ·��������������ַ���"));
			return;
		}
		if (!sStyleBaseHref.substring(0, 1).equals("/")) {
			out.print(getError("��ʹ�����·��ģʽʱ����ʾ·��������&quot;/&quot;��ͷ��"));
			return;
		}

		if (sStyleContentPath.equals("")) {
			out.print(getError("��ʹ�����·��ģʽʱ������·������Ϊ�գ�"));
			return;
		}
		if (!IsSafeStr(sStyleContentPath)) {
			out.print(getError("��ʹ�����·��ģʽʱ������·��������������ַ���"));
			return;
		}
		if (sStyleContentPath.substring(0, 1).equals("/")){
			out.print(getError("��ʹ�����·��ģʽʱ������·��������&quot;/&quot;��ͷ��"));
			return;
		}
	}else if (sStyleBaseUrl.equals("1") || sStyleBaseUrl.equals("2")){
		sStyleBaseHref = "";
		sStyleContentPath = "";
	}
	
	if (!isNumber(sStyleWidth)) {
		out.print(getError("����д��Ч��������ÿ�ȣ�"));
		return;
	}
	if (!isNumber(sStyleHeight)) {
		out.print(getError("����д��Ч��������ø߶ȣ�"));
		return;
	}

	if (!isNumber(sStyleImageSize)) {
		out.print(getError("����д��Ч��ͼƬ���ƴ�С��"));
		return;
	}
	if (!isNumber(sStyleFlashSize)) {
		out.print(getError("����д��Ч��Flash���ƴ�С��"));
		return;
	}
	if (!isNumber(sStyleMediaSize)) {
		out.print(getError("����д��Ч��ý���ļ����ƴ�С��"));
		return;
	}
	if (!isNumber(sStyleFileSize)) {
		out.print(getError("����д��Ч�������ļ����ƴ�С��"));
		return;
	}
	if (!isNumber(sStyleRemoteSize)) {
		out.print(getError("����д��Ч��Զ���ļ����ƴ�С��"));
		return;
	}
	if (!isNumber(sStyleLocalSize)) {
		out.print(getError("����д��Ч�ı����ļ����ƴ�С��"));
		return;
	}

	if (!isNumber(sSLTMinSize)) {
		out.print(getError("����д��Ч������ͼʹ����С��������������Ϊ�գ���Ϊ�����ͣ�"));
	}
	if (!isNumber(sSLTOkSize)) {
		out.print(getError("����д��Ч������ͼ���ɳ��ȣ�����Ϊ�գ���Ϊ�����ͣ�"));
	}

	if (!isNumber(sSYWZMinWidth)){
		out.print(getError("����д��Ч������ˮӡ���õ���С�������������Ϊ�գ���Ϊ�����ͣ�"));
	}
	if (!isNumber(sSYWZMinHeight)){
		out.print(getError("����д��Ч������ˮӡ���õ���С�߶�����������Ϊ�գ���Ϊ�����ͣ�"));
	}
	if (sSYText.equals("")){
		out.print(getError("����д��Чˮӡ�������ݣ�����Ϊ�գ�"));
	}
	if (!isValidColor(sSYFontColor)){
		out.print(getError("����д��Ч��ˮӡ������ɫ��6λ���ȣ����ɫ��000000��"));
	}
	if (!isValidColor(sSYShadowColor)){
		out.print(getError("����д��Ч��ˮӡ������Ӱ��ɫ��6λ���ȣ����ɫ��FFFFFF��"));
	}
	if (!isNumber(sSYShadowOffset)){
		out.print(getError("����д��Ч��ˮӡ������Ӱ��С������Ϊ�գ���Ϊ�����ͣ�"));
	}
	if (!isNumber(sSYFontSize)){
		out.print(getError("����д��Ч��ˮӡ���ִ�С������Ϊ�գ���Ϊ�����ͣ�"));
	}
	if (sSYFontName.equals("")){
		out.print(getError("����дˮӡ�����������ƣ�����Ϊ�գ�"));
	}

	if (!isNumber(sSYWZPaddingH)){
		out.print(getError("����д��Ч������ˮӡ���ұ߾࣬����Ϊ�գ���Ϊ�����ͣ�"));
	}
	if (!isNumber(sSYWZPaddingV)){
		out.print(getError("����д��Ч������ˮӡ���±߾࣬����Ϊ�գ���Ϊ�����ͣ�"));
	}
	if (!isNumber(sSYWZTextWidth)){
		out.print(getError("����д��Ч������ˮӡ���ֿ�ռλ������Ϊ�գ���Ϊ�����ͣ�"));
	}
	if (!isNumber(sSYWZTextHeight)){
		out.print(getError("����д��Ч������ˮӡ���ָ�ռλ������Ϊ�գ���Ϊ�����ͣ�"));
	}
	if (!isNumber(sSYTPMinWidth)){
		out.print(getError("����д��Ч��ͼƬˮӡ���õ���С�������������Ϊ�գ���Ϊ�����ͣ�"));
	}
	if (!isNumber(sSYTPMinHeight)){
		out.print(getError("����д��Ч��ͼƬˮӡ���õ���С�߶�����������Ϊ�գ���Ϊ�����ͣ�"));
	}
	if (!isNumber(sSYTPPaddingH)){
		out.print(getError("����д��Ч��ͼƬˮӡ���ұ߾࣬����Ϊ�գ���Ϊ�����ͣ�"));
	}
	if (!isNumber(sSYTPPaddingV)){
		out.print(getError("����д��Ч��ͼƬˮӡ���±߾࣬����Ϊ�գ���Ϊ�����ͣ�"));
	}
	if (!isFloat(sSYTPOpacity)){
		out.print(getError("����д��Ч��ͼƬˮӡ͸���ȣ�����Ϊ�գ���Ϊ0��1�����֣�"));
	}
	if (!isNumber(sSYTPImageWidth)){
		out.print(getError("����д��Ч��ͼƬˮӡ���ֿ�ռλ������Ϊ�գ���Ϊ�����ͣ�"));
	}
	if (!isNumber(sSYTPImageHeight)){
		out.print(getError("����д��Ч��ͼƬˮӡ���ָ�ռλ������Ϊ�գ���Ϊ�����ͣ�"));
	}

	if(sAction.equals("STYLEADDSAVE")){

		if (StyleName2ID(sStyleName, aStyle) != -1) {
			out.print(getError("����ʽ���Ѿ����ڣ�������һ����ʽ����"));
			return;
		}

		aStyle.add(sStyleName + "|||" + sStyleDir + "|||" + sStyleCSS + "|||" + sStyleUploadDir + "|||" + sStyleWidth + "|||" + sStyleHeight + "|||" + sStyleFileExt + "|||" + sStyleFlashExt + "|||" + sStyleImageExt + "|||" + sStyleMediaExt + "|||" + sStyleRemoteExt + "|||" + sStyleFileSize + "|||" + sStyleFlashSize + "|||" + sStyleImageSize + "|||" + sStyleMediaSize + "|||" + sStyleRemoteSize + "|||" + sStyleStateFlag + "|||" + sStyleDetectFromWord + "|||" + sStyleInitMode + "|||" + sStyleBaseUrl + "|||" + sStyleUploadObject + "|||" + sStyleAutoDir + "|||" + sStyleBaseHref + "|||" + sStyleContentPath + "|||" + sStyleAutoRemote + "|||" + sStyleShowBorder + "|||" + sStyleMemo + "|||1|||zh-cn|||" + sSLTFlag + "|||" + sSLTMinSize + "|||" + sSLTOkSize + "|||" + sSYWZFlag + "|||" + sSYText + "|||" + sSYFontColor + "|||" + sSYFontSize + "|||" + sSYFontName + "|||" + sSYPicPath + "|||" + sSLTSYObject + "|||" + sSLTSYExt + "|||" + sSYWZMinWidth + "|||" + sSYShadowColor + "|||" + sSYShadowOffset + "|||" + sStyleAllowBrowse + "|||" + sStyleLocalExt + "|||" + sStyleLocalSize + "|||" + sSYWZMinHeight + "|||" + sSYWZPosition + "|||" + sSYWZTextWidth + "|||" + sSYWZTextHeight + "|||" + sSYWZPaddingH + "|||" + sSYWZPaddingV + "|||" + sSYTPFlag + "|||" + sSYTPMinWidth + "|||" + sSYTPMinHeight + "|||" + sSYTPPosition + "|||" + sSYTPPaddingH + "|||" + sSYTPPaddingV + "|||" + sSYTPImageWidth + "|||" + sSYTPImageHeight + "|||" + sSYTPOpacity + "|||" + sCusDirFlag);

		WriteConfig(eWebEditorPath, sUsername, sPassword, aStyle, aToolbar);
		WriteStyle(eWebEditorPath, aStyle, aToolbar, aStyle.size()-1);

		out.print(GetMessage("<b><span class=red>��ʽ���ӳɹ���</span></b><li><a href='?action=toolbar&id=" + String.valueOf(aStyle.size()-1) + "'>���ô���ʽ�µĹ�����</a>"));

	}else if(sAction.equals("STYLESETSAVE")){

		String s_OldStyleName = "";
		sStyleID = dealNull(request.getParameter("id"));
		if (isNumber(sStyleID)) {
			int n_SN2ID = StyleName2ID(sStyleName, aStyle);
			if (!String.valueOf(n_SN2ID).equals(sStyleID) && (n_SN2ID != -1)) {
				out.print(getError("����ʽ���Ѿ����ڣ�������һ����ʽ����"));
				return;
			}
			
			nStyleID = Integer.valueOf(sStyleID).intValue();
			if ((nStyleID < 1) && (nStyleID>=aStyle.size())) {
				out.print(getError("��Ч����ʽID�ţ���ͨ��ҳ���ϵ����ӽ��в�����"));
				return;
			}

			s_OldStyleName = split(aStyle.get(nStyleID).toString(), "|||")[0];

			aStyle.remove(nStyleID);
			aStyle.add(nStyleID, sStyleName + "|||" + sStyleDir + "|||" + sStyleCSS + "|||" + sStyleUploadDir + "|||" + sStyleWidth + "|||" + sStyleHeight + "|||" + sStyleFileExt + "|||" + sStyleFlashExt + "|||" + sStyleImageExt + "|||" + sStyleMediaExt + "|||" + sStyleRemoteExt + "|||" + sStyleFileSize + "|||" + sStyleFlashSize + "|||" + sStyleImageSize + "|||" + sStyleMediaSize + "|||" + sStyleRemoteSize + "|||" + sStyleStateFlag + "|||" + sStyleDetectFromWord + "|||" + sStyleInitMode + "|||" + sStyleBaseUrl + "|||" + sStyleUploadObject + "|||" + sStyleAutoDir + "|||" + sStyleBaseHref + "|||" + sStyleContentPath + "|||" + sStyleAutoRemote + "|||" + sStyleShowBorder + "|||" + sStyleMemo + "|||1|||zh-cn|||" + sSLTFlag + "|||" + sSLTMinSize + "|||" + sSLTOkSize + "|||" + sSYWZFlag + "|||" + sSYText + "|||" + sSYFontColor + "|||" + sSYFontSize + "|||" + sSYFontName + "|||" + sSYPicPath + "|||" + sSLTSYObject + "|||" + sSLTSYExt + "|||" + sSYWZMinWidth + "|||" + sSYShadowColor + "|||" + sSYShadowOffset + "|||" + sStyleAllowBrowse + "|||" + sStyleLocalExt + "|||" + sStyleLocalSize + "|||" + sSYWZMinHeight + "|||" + sSYWZPosition + "|||" + sSYWZTextWidth + "|||" + sSYWZTextHeight + "|||" + sSYWZPaddingH + "|||" + sSYWZPaddingV + "|||" + sSYTPFlag + "|||" + sSYTPMinWidth + "|||" + sSYTPMinHeight + "|||" + sSYTPPosition + "|||" + sSYTPPaddingH + "|||" + sSYTPPaddingV + "|||" + sSYTPImageWidth + "|||" + sSYTPImageHeight + "|||" + sSYTPOpacity + "|||" + sCusDirFlag);

		}else{
			out.print(getError("��Ч����ʽID�ţ���ͨ��ҳ���ϵ����ӽ��в�����"));
			return;
		}

		WriteConfig(eWebEditorPath, sUsername, sPassword, aStyle, aToolbar);
		if (!s_OldStyleName.toLowerCase().equals(sStyleName.toLowerCase())) {
			DeleteFile(eWebEditorPath+"style"+sFileSeparator+s_OldStyleName.toLowerCase()+".js");
		}
		WriteStyle(eWebEditorPath, aStyle, aToolbar, nStyleID);

		out.print(GetMessage("<b><span class=red>��ʽ�޸ĳɹ���</span></b><li><a href='?action=stylepreview&id=" + sStyleID + "' target='_blank'>Ԥ������ʽ</a><li><a href='?action=toolbar&id=" + sStyleID + "'>���ô���ʽ�µĹ�����</a>"));

	}

}else if(sAction.equals("CODE")){

	out.print("<table border=0 cellspacing=1 align=center class=list>" +
		"<tr><th>��ʽ��" + htmlEncode(sStyleName) + "������ѵ��ô������£�����XXX��ʵ�ʹ����ı�������޸ģ���</th></tr>" +
		"<tr><td><textarea rows=5 cols=65 style='width:100%'><IFRAME ID=\"eWebEditor1\" SRC=\"ewebeditor.htm?id=XXX&style=" + sStyleName + "\" FRAMEBORDER=\"0\" SCROLLING=\"no\" WIDTH=\"" + sStyleWidth + "\" HEIGHT=\"" + sStyleHeight + "\"></IFRAME></textarea></td></tr>" +
		"</table>");


}else if(sAction.equals("BUTTONSET")){

	for(int nLoop=0; nLoop<1; nLoop++){

		out.print(GetMessage("<b class=blue>��ǰ��ʽ��<span class=red>" + htmlEncode(sStyleName) + "</span>&nbsp;&nbsp;��ǰ��������<span class=red>" + htmlEncode(sToolBarName) + "</span></b>"));

		String s_Option1 = "";
		for(int i=1; i<aButton.length; i++){
			if (aButton[i][8].equals("1")){
				s_Option1 = s_Option1 + "<option value='" + aButton[i][1] + "'>" + aButton[i][2] + "</option>";
			}
		}

		String[] aSelButton = split(sToolBarButton, "|");
		String s_Option2 = "";
		for(int i=0; i<aSelButton.length; i++){
			String s_Temp = Code2Title(aSelButton[i]);
			if (!s_Temp.equals("")) {
				s_Option2 = s_Option2 + "<option value='" + aSelButton[i] + "'>" + s_Temp + "</option>";
			}
		}

		%>

		<script language=javascript>
		function Add() {
			var sel1=document.myform.d_b1;
			var sel2=document.myform.d_b2;
			if (sel1.selectedIndex<0) {
				alert("��ѡ��һ����ѡ��ť��");
				return;
			}
			sel2.options[sel2.length]=new Option(sel1.options[sel1.selectedIndex].innerHTML,sel1.options[sel1.selectedIndex].value);
		}

		function Del() {
			var sel=document.myform.d_b2;
			var nIndex = sel.selectedIndex;
			var nLen = sel.length;
			if (nLen<1) return;
			if (nIndex<0) {
				alert("��ѡ��һ����ѡ��ť��");
				return;
			}
			for (var i=nIndex;i<nLen-1;i++) {
				sel.options[i].value=sel.options[i+1].value;
				sel.options[i].innerHTML=sel.options[i+1].innerHTML;
			}
			sel.length=nLen-1;
		}

		function Up() {
			var sel=document.myform.d_b2;
			var nIndex = sel.selectedIndex;
			var nLen = sel.length;
			if ((nLen<1)||(nIndex==0)) return;
			if (nIndex<0) {
				alert("��ѡ��һ��Ҫ�ƶ�����ѡ��ť��");
				return;
			}
			var sValue=sel.options[nIndex].value;
			var sHTML=sel.options[nIndex].innerHTML;
			sel.options[nIndex].value=sel.options[nIndex-1].value;
			sel.options[nIndex].innerHTML=sel.options[nIndex-1].innerHTML;
			sel.options[nIndex-1].value=sValue;
			sel.options[nIndex-1].innerHTML=sHTML;
			sel.selectedIndex=nIndex-1;
		}

		function Down() {
			var sel=document.myform.d_b2;
			var nIndex = sel.selectedIndex;
			var nLen = sel.length;
			if ((nLen<1)||(nIndex==nLen-1)) return;
			if (nIndex<0) {
				alert("��ѡ��һ��Ҫ�ƶ�����ѡ��ť��");
				return;
			}
			var sValue=sel.options[nIndex].value;
			var sHTML=sel.options[nIndex].innerHTML;
			sel.options[nIndex].value=sel.options[nIndex+1].value;
			sel.options[nIndex].innerHTML=sel.options[nIndex+1].innerHTML;
			sel.options[nIndex+1].value=sValue;
			sel.options[nIndex+1].innerHTML=sHTML;
			sel.selectedIndex=nIndex+1;
		}

		function checkform() {
			var sel=document.myform.d_b2;
			var nLen = sel.length;
			var str="";
			for (var i=0;i<nLen;i++) {
				if (i>0) str+="|";
				str+=sel.options[i].value;
			}
			document.myform.d_button.value=str;
			return true;
		}

		</script>

		<%

		String s_SubmitButton = "<input type=submit name=b value=' �������� '>";

		out.print("<table border=0 cellpadding=5 cellspacing=0 align=center>" +
			"<form action='?action=buttonsave&id=" + sStyleID + "&toolbarid=" + sToolBarID + "' method=post name=myform onsubmit='return checkform()'>" +
			"<tr align=center><td>��ѡ��ť</td><td></td><td>��ѡ��ť</td><td></td></tr>" +
			"<tr align=center>" +
				"<td><select name='d_b1' size=20 style='width:250px' ondblclick='Add()'>" + s_Option1 + "</select></td>" +
				"<td><input type=button name=b1 value=' �� ' onclick='Add()'><br><br><input type=button name=b1 value=' �� ' onclick='Del()'></td>" +
				"<td><select name='d_b2' size=20 style='width:250px' ondblclick='Del()'>" + s_Option2 + "</select></td>" +
				"<td><input type=button name=b3 value='��' onclick='Up()'><br><br><br><input type=button name=b4 value='��' onclick='Down()'></td>" +
			"</tr>" +
			"<input type=hidden name='d_button' value=''>" +
			"<tr><td colspan=4 align=right>" + s_SubmitButton + "</td></tr>" +
			"</form></table>");

		out.print("<table border=0 cellspacing=1 align=center class=list>" +
			"<tr><th colspan=4>�����ǰ�ťͼƬ���ձ���������������ⰴť����ûͼ����</th></tr>");

		int n = 0;
		int m = 0;
		for(int i=1; i<aButton.length; i++){
			if (aButton[i][8].equals("1")) {
				m = m + 1;
				n = m % 4;
				if (n == 1) {
					out.print("<tr>");
				}
				out.print("<td>");
				if (!aButton[i][3].equals("")) {
					out.print("<img border=0 align=absmiddle src='../buttonimage/" + sStyleDir + "/" + aButton[i][3] + "'>");
				}
				out.print(aButton[i][2]);
				out.print("</td>");
				if (n == 0){
					out.print("</tr>");
				}
			}
		}
		if (n > 0) {
			for(int i=0; i<4-n; i++){
				out.print("<td>&nbsp;</td>");
			}
			out.print("</tr>");
		}
		out.print("</table>");

	}

}else if(sAction.equals("BUTTONSAVE")){

	String s_Button = dealNull(request.getParameter("d_button"));
	String[] aCurrToolbar = split(aToolbar.get(nToolBarID).toString(), "|||");
	aToolbar.remove(nToolBarID);
	aToolbar.add(nToolBarID, aCurrToolbar[0] + "|||" + s_Button + "|||" + aCurrToolbar[2] + "|||" + aCurrToolbar[3]);

	WriteConfig(eWebEditorPath, sUsername, sPassword, aStyle, aToolbar);
	WriteStyle(eWebEditorPath, aStyle, aToolbar, nStyleID);

	out.print(GetMessage("<b><span class=red>��������ť���ñ���ɹ���</span></b><li><a href='?action=stylepreview&id=" + sStyleID + "' target='_blank'>Ԥ������ʽ</a><li><a href='?action=toolbar&id=" + sStyleID + "'>���ع���������</a><li><a href='?action=buttonset&id=" + sStyleID + "&toolbarid=" + sToolBarID + "'>�������ô˹������µİ�ť</a>"));


}else if(sAction.equals("TOOLBAR") || sAction.equals("TOOLBARADD") || sAction.equals("TOOLBARMODI") || sAction.equals("TOOLBARDEL")){

	if(sAction.equals("TOOLBARADD")){

		String sToolbarAdd_Name = dealNull(request.getParameter("d_name"));
		String sToolbarAdd_Order = dealNull(request.getParameter("d_order"));
		if (sToolbarAdd_Name.equals("")) {
			out.print(getError("������������Ϊ�գ�"));
			return;
		}
		if (!isNumber(sToolbarAdd_Order)) {
			out.print(getError("��Ч�Ĺ���������ţ�����ű���Ϊ���֣�"));
			return;
		}

		aToolbar.add(sStyleID + "||||||" + sToolbarAdd_Name + "|||" + sToolbarAdd_Order);

		WriteConfig(eWebEditorPath, sUsername, sPassword, aStyle, aToolbar);
		WriteStyle(eWebEditorPath, aStyle, aToolbar, nStyleID);

		out.print("<script language=javascript>alert(\"��������" + htmlEncode(sToolbarAdd_Name) + "�����Ӳ����ɹ���\");</script>");
		out.print(GetGoUrl("?action=toolbar&id=" + sStyleID));
		return;

	}else if(sAction.equals("TOOLBARMODI")){

		for(int i=0; i<aToolbar.size(); i++){
			String[] aCurrToolbar = split(aToolbar.get(i).toString(), "|||");
			if (aCurrToolbar[0].equals(sStyleID)) {
				String s_Name = dealNull(request.getParameter("d_name"+String.valueOf(i)));
				String s_Order = dealNull(request.getParameter("d_order"+String.valueOf(i)));
				if (s_Name.equals("") || !isNumber(s_Order)) {
					aCurrToolbar[0] = "";
					s_Name = "";
				}
				aToolbar.remove(i);
				aToolbar.add(i, aCurrToolbar[0] + "|||" + aCurrToolbar[1] + "|||" + s_Name + "|||" + s_Order);
			}
		}

		WriteConfig(eWebEditorPath, sUsername, sPassword, aStyle, aToolbar);
		WriteStyle(eWebEditorPath, aStyle, aToolbar, nStyleID);

		out.print("<script language=javascript>alert('�������޸Ĳ����ɹ���');</script>");
		out.print(GetGoUrl("?action=toolbar&id=" + sStyleID));
		return;
		
	}else if(sAction.equals("TOOLBARDEL")){

		String s_DelID = dealNull(request.getParameter("delid"));
		if (isNumber(s_DelID)) {
			aToolbar.remove(Integer.valueOf(s_DelID).intValue());
			WriteConfig(eWebEditorPath, sUsername, sPassword, aStyle, aToolbar);
			WriteStyle(eWebEditorPath, aStyle, aToolbar, nStyleID);
			out.print("<script language=javascript>alert('��������ID��" + s_DelID + "��ɾ�������ɹ���');</script>");
			out.print(GetGoUrl("?action=toolbar&id=" + sStyleID));
			return;
		}

	}


	// Show Toolbar List

	out.print(GetMessage("<b class=blue>��ʽ��" + htmlEncode(sStyleName) + "���µĹ���������</b>"));

	int n_ToolbarMaxOrder = 0;
	for(int i=0; i<aToolbar.size(); i++){
		String[] aCurrToolbar = split(aToolbar.get(i).toString(), "|||");
		if (aCurrToolbar[0].equals(sStyleID)){
			if (Integer.valueOf(aCurrToolbar[3]).intValue() > n_ToolbarMaxOrder){
				n_ToolbarMaxOrder = Integer.valueOf(aCurrToolbar[3]).intValue();
			}
		}
	}
	n_ToolbarMaxOrder = n_ToolbarMaxOrder + 1;

	out.print("<hr width='80%' align=center size=1><table border=0 cellpadding=4 cellspacing=0 align=center>" +
		"<form action='?id=" + sStyleID + "&action=toolbaradd' name='addform' method=post>" +
		"<tr><td>����������<input type=text name=d_name size=20 class=input value='������" + String.valueOf(n_ToolbarMaxOrder) + "'> ����ţ�<input type=text name=d_order size=5 value='" + String.valueOf(n_ToolbarMaxOrder) + "' class=input> <input type=submit name=b1 value='����������'></td></tr>" +
		"</form></table><hr width='80%' align=center size=1>");

	out.print("<form action='?id=" + sStyleID + "&action=toolbarmodi' name=modiform method=post>" +
		"<table border=0 cellpadding=0 cellspacing=1 align=center class=form>" +
		"<tr align=center><th>ID</th><th>��������</th><th>�����</th><th>����</th></tr>");

	for (int i=0; i<aToolbar.size(); i++){
		String[] aCurrToolbar = split(aToolbar.get(i).toString(), "|||");
		if (aCurrToolbar[0].equals(sStyleID)){
			String s_Manage = "<a href='?id=" + sStyleID + "&action=buttonset&toolbarid=" + String.valueOf(i) + "'>��ť����</a>";
			s_Manage = s_Manage + "|<a href='?id=" + sStyleID + "&action=toolbardel&delid=" + String.valueOf(i) + "'>ɾ��</a>";
			out.print("<tr align=center>" +
				"<td>" + String.valueOf(i) + "</td>" +
				"<td><input type=text name='d_name" + String.valueOf(i) + "' value=\"" + htmlEncode(aCurrToolbar[2]) + "\" size=30 class=input></td>" +
				"<td><input type=text name='d_order" + String.valueOf(i) + "' value='" + aCurrToolbar[3] + "' size=5 class=input></td>" +
				"<td>" + s_Manage + "</td>" +
				"</tr>");
		}
	}

	out.print("<tr><td colspan=4 align=center><input type=submit name=b1 value='  �޸�  '></td></tr>");
	out.print("</table></form>");

}else{
	if(sAction.equals("COPY")){
		
		String sNewName = "";
		int n_CopyID = 0;
		boolean b = false;
		while(!b){
			n_CopyID = n_CopyID + 1;
			sNewName = sStyleName + String.valueOf(n_CopyID);
			if (StyleName2ID(sNewName, aStyle) == -1) {
				b = true;
			}
		}

		aStyle.add(sNewName + aStyle.get(nStyleID).toString().substring(sStyleName.length(), aStyle.get(nStyleID).toString().length()));

		int nToolbarNum = aToolbar.size();
		for (int i=0; i<nToolbarNum; i++){
			String[] aCurrToolbar = split(aToolbar.get(i).toString(), "|||");
			if (aCurrToolbar[0].equals(sStyleID)) {
				aToolbar.add(String.valueOf(aStyle.size()-1) + "|||" + aCurrToolbar[1] + "|||" + aCurrToolbar[2] + "|||" + aCurrToolbar[3]);
			}
		}

		WriteConfig(eWebEditorPath, sUsername, sPassword, aStyle, aToolbar);
		WriteStyle(eWebEditorPath, aStyle, aToolbar, aStyle.size()-1);
		out.print(GetGoUrl("?"));
		return;
		

	}else if(sAction.equals("STYLEDEL")){

		aStyle.remove(nStyleID);
		aStyle.add(nStyleID, "");
		WriteConfig(eWebEditorPath, sUsername, sPassword, aStyle, aToolbar);
		DeleteFile(eWebEditorPath+"\\style\\"+sStyleName.toLowerCase()+".js");
		out.print(GetGoUrl("?"));
		return;
	}
	

	// Show Style List
	out.print(GetMessage("<b class=blue>����Ϊ��ǰ������ʽ�б�</b>"));

	out.print("<table border=0 cellpadding=0 cellspacing=1 class=list align=center>" + 
		"<form action='?action=del' method=post name=myform>" + 
		"<tr align=center>" +
			"<th width='10%'>��ʽ��</th>" +
			"<th width='10%'>��ѿ��</th>" +
			"<th width='10%'>��Ѹ߶�</th>" +
			"<th width='45%'>˵��</th>" +
			"<th width='25%'>����</th>" +
		"</tr>");

	for(int i=0; i<aStyle.size(); i++){
		String[] aCurrStyle = split(aStyle.get(i).toString(), "|||");
		String sManage = "<a href='?action=stylepreview&id=" + String.valueOf(i) + "' target='_blank'>Ԥ��</a>|<a href='?action=code&id=" + String.valueOf(i) + "'>����</a>|<a href='?action=styleset&id=" + String.valueOf(i) + "'>����</a>|<a href='?action=toolbar&id=" + String.valueOf(i) + "'>������</a>|<a href='?action=copy&id=" + String.valueOf(i) + "'>����</a>|<a href='?action=styledel&id=" + String.valueOf(i) + "' onclick=\"return confirm('��ʾ����ȷ��Ҫɾ������ʽ��')\">ɾ��</a>";
		out.print("<tr align=center>" +
			"<td>" + htmlEncode(aCurrStyle[0]) + "</td>" +
			"<td>" + aCurrStyle[4] + "</td>" +
			"<td>" + aCurrStyle[5] + "</td>" +
			"<td align=left>" + htmlEncode(aCurrStyle[26]) + "</td>" +
			"<td>" + sManage + "</td>" +
			"</tr>");
	}
	
	out.print("</table><br>");

	out.print(GetMessage("<b class=blue>��ʾ��</b>�����ͨ����������һ��ʽ�Դﵽ�����½���ʽ��Ŀ�ġ�"));

}


out.print(Footer());


%>
<%!
static String Code2HTML(String s_Code, String s_ButtonDir){
	String s_Result = "";
	for(int i=1; i<aButton.length; i++){
		if (aButton[i][1].toUpperCase().equals(s_Code.toUpperCase())){
			if(aButton[i][5].equals("0")){
				s_Result = "<DIV CLASS=" + aButton[i][7] + " TITLE='\"+lang[\"" + aButton[i][1] + "\"]+\"' onclick=\\\"" + aButton[i][6] + "\\\"><IMG CLASS=Ico SRC='buttonimage/" + s_ButtonDir + "/" + aButton[i][3] + "'></DIV>";
			}else if(aButton[i][5].equals("1")){
				if (!aButton[i][4].equals("")){
					s_Result = "<SELECT CLASS=" + aButton[i][7] + " onchange=\\\"" + aButton[i][6] + "\\\">" + aButton[i][4] + "</SELECT>";
				}else{
					s_Result = "<SELECT CLASS=" + aButton[i][7] + " onchange=\\\"" + aButton[i][6] + "\\\">\"+lang[\"" + aButton[i][1] + "\"]+\"</SELECT>";
				}
			}else if(aButton[i][5].equals("2")){
				s_Result = "<DIV CLASS=" + aButton[i][7] + ">" + aButton[i][4] + "</DIV>";
			}
			return s_Result;
		}
	}
	return s_Result;
}

static int StyleName2ID(String str, ArrayList a_Style){
	for (int i=0; i<a_Style.size(); i++){
		if (split(a_Style.get(i).toString(), "|||")[0].toLowerCase().equals(str.toLowerCase())){
			return i;
		}
	}
	return -1;
}

static String Code2Title(String s_Code){
	for (int i=1; i<aButton.length; i++){
		if (aButton[i][1].toUpperCase().equals(s_Code.toUpperCase())) {
			return aButton[i][2];
		}
	}
	return "";
}

static String GetSelect(String s_FieldName, String[] a_Name, String[] a_Value, String s_InitValue, String s_AllName){
	String s_Result = "";
	s_Result += "<select name='" + s_FieldName + "' size=1>";
	if (!s_AllName.equals("")) {
		s_Result += "<option value=''>" + s_AllName + "</option>";
	}
	for(int i=0; i<a_Name.length; i++){
		s_Result += "<option value=\"" + htmlEncode(a_Value[i]) + "\"";
		if (a_Value[i].equals(s_InitValue)) {
			s_Result += " selected";
		}
		s_Result += ">" + htmlEncode(a_Name[i]) + "</option>";
	}
	s_Result += "</select>";
	return s_Result;
}

static void WriteStyle(String s_eWebEditorPath, ArrayList a_Style, ArrayList a_Toolbar, int n_StyleID){
	String sConfig = "";
	String[] aTmpStyle = split(a_Style.get(n_StyleID).toString(), "|||");
	sConfig = sConfig + "config.ButtonDir = \"" + aTmpStyle[1] + "\";" + "\r\n";
	sConfig = sConfig + "config.StyleUploadDir = \"" + aTmpStyle[3] + "\";" + "\r\n";
	sConfig = sConfig + "config.InitMode = \"" + aTmpStyle[18] + "\";" + "\r\n";
	sConfig = sConfig + "config.AutoDetectPasteFromWord = \"" + aTmpStyle[17] + "\";" + "\r\n";
	sConfig = sConfig + "config.BaseUrl = \"" + aTmpStyle[19] + "\";" + "\r\n";
	sConfig = sConfig + "config.BaseHref = \"" + aTmpStyle[22] + "\";" + "\r\n";
	sConfig = sConfig + "config.AutoRemote = \"" + aTmpStyle[24] + "\";" + "\r\n";
	sConfig = sConfig + "config.ShowBorder = \"" + aTmpStyle[25] + "\";" + "\r\n";
	sConfig = sConfig + "config.StateFlag = \"" + aTmpStyle[16] + "\";" + "\r\n";
	sConfig = sConfig + "config.CssDir = \"" + aTmpStyle[2] + "\";" + "\r\n";
	sConfig = sConfig + "config.AllowBrowse = \"" + aTmpStyle[43] + "\";" + "\r\n";
	sConfig = sConfig + "config.AllowImageSize = \"" + aTmpStyle[13] + "\";" + "\r\n";
	sConfig = sConfig + "config.AllowFlashSize = \"" + aTmpStyle[12] + "\";" + "\r\n";
	sConfig = sConfig + "config.AllowMediaSize = \"" + aTmpStyle[14] + "\";" + "\r\n";
	sConfig = sConfig + "config.AllowFileSize = \"" + aTmpStyle[11] + "\";" + "\r\n";
	sConfig = sConfig + "config.AllowRemoteSize = \"" + aTmpStyle[15] + "\";" + "\r\n";
	sConfig = sConfig + "config.AllowLocalSize = \"" + aTmpStyle[45] + "\";" + "\r\n";
	sConfig = sConfig + "\r\n";
	sConfig = sConfig + "function showToolbar(){" + "\r\n";
	sConfig = sConfig + "\r\n";

	sConfig = sConfig + "  document.write (\"";
	sConfig = sConfig + "<table border=0 cellpadding=0 cellspacing=0 width='100%' class='Toolbar' id='eWebEditor_Toolbar'>";

	String s_Order = "";
	String s_ID = "";
	for (int n=0; n<a_Toolbar.size(); n++){
		if (!a_Toolbar.get(n).toString().equals("")){
			String[] aTmpToolbar = split(a_Toolbar.get(n).toString(), "|||");
			if (aTmpToolbar[0].equals(String.valueOf(n_StyleID))) {
				if (!s_ID.equals("")){
					s_ID = s_ID + "|";
					s_Order = s_Order + "|";
				}
				s_ID = s_ID + String.valueOf(n);
				s_Order = s_Order + aTmpToolbar[3];
			}
		}
	}

	if (!s_ID.equals("")){
		String[] a_ID = split(s_ID, "|");
		String[] a_Order = split(s_Order, "|");
		a_ID = Sort(a_ID, a_Order);
		for(int n=0; n<a_ID.length; n++){
			String[] aTmpToolbar = split(a_Toolbar.get(Integer.valueOf(a_ID[n]).intValue()).toString(), "|||");
			String[] aTmpButton = split(aTmpToolbar[1], "|");

			sConfig = sConfig + "<tr><td><div class=yToolbar>";
			for(int i=0; i<aTmpButton.length; i++){
				if (aTmpButton[i].toUpperCase().equals("MAXIMIZE")){
					sConfig = sConfig + "\");" + "\r\n";
					sConfig = sConfig + "\r\n";

					sConfig = sConfig + "  if (sFullScreen==\"1\"){" + "\r\n";
					sConfig = sConfig + "    document.write (\"" + Code2HTML("Minimize", aTmpStyle[1]) + "\");" + "\r\n";
					sConfig = sConfig + "  }else{" + "\r\n";
					sConfig = sConfig + "    document.write (\"" + Code2HTML(aTmpButton[i], aTmpStyle[1]) + "\");" + "\r\n";
					sConfig = sConfig + "  }" + "\r\n";
					sConfig = sConfig + "\r\n";

					sConfig = sConfig + "  document.write (\"";
				}else{
					sConfig = sConfig + Code2HTML(aTmpButton[i], aTmpStyle[1]);
				}
			}
			sConfig = sConfig + "</div></td></tr>";
		}
	}else{
		sConfig = sConfig + "<tr><td></td></tr>";
	}

	sConfig = sConfig + "</table>\");" + "\r\n";
	sConfig = sConfig + "\r\n";
	sConfig = sConfig + "}" + "\r\n";


	if (s_eWebEditorPath.indexOf("/") != -1) {
		WriteFile(s_eWebEditorPath+"style/"+aTmpStyle[0].toLowerCase()+".js", sConfig);
	}else{
		WriteFile(s_eWebEditorPath+"style\\"+aTmpStyle[0].toLowerCase()+".js", sConfig);
	}

}

static boolean isValidColor(String str){
	Pattern p = Pattern.compile("[A-Fa-f0-9]{6}");
	Matcher m = p.matcher(str);
	return m.matches();
}

%>

function GetAllDjFileName(sPath) {
	if (typeof sPath == "undefined") {
		sPath = "";
	}
	return SendHttp(new StringBuffer().append(location.protocol ).append( "//" ).append( location.host ).append( fcpubdata.servletPath ).append( "/PathFile" ).append( fcpubdata.dotnetVersion ).append( "?GetAllDjFileName", "<vpath>" ).append( fcpubdata.Path ).append( "</vpath>" ).append( "<subpath>" ).append( sPath ).append( "</subpath>").toString());
}
function GetBillType() {
	var oXml = SetDomFile(fcpubdata.Path + "/fceform/billtype.xml");
	var sRet = new StringBuffer();
	if (oXml.documentElement != null) {
		var l = oXml.documentElement.childNodes.length - 1;
		for (var i = 0; i < l; i++) {
			var stext = oXml.documentElement.childNodes(i).childNodes(1).text;
			var svalue = oXml.documentElement.childNodes(i).childNodes(2).text;
			var spath = oXml.documentElement.childNodes(i).childNodes(3).text;
			var sextname = oXml.documentElement.childNodes(i).childNodes(4).text;
			sRet.append("<option value=\"" ).append( svalue ).append( "\" extname=\"" ).append( sextname ).append( "\" path=\"" ).append( spath ).append( "\">" ).append( stext ).append( "</option>");
		}
	}
	return sRet.toString();
}
function BillTypeNameToPath(name) {
	var oXml = SetDomFile(fcpubdata.Path + "/fceform/billtype.xml");
	var oRet = Object();
	if (oXml.documentElement != null) {
		var l = oXml.documentElement.childNodes.length - 1;
		for (var i = 0; i < l; i++) {
			var svalue = oXml.documentElement.childNodes(i).childNodes(2).text;
			var spath = oXml.documentElement.childNodes(i).childNodes(3).text;
			var extname = oXml.documentElement.childNodes(i).childNodes(4).text;
			if (svalue == name) {
				oRet.path = spath;
				oRet.extname = extname;
				break;
			}
		}
	}
	return oRet;
}
function contselfield(arr) {
	if (arr.length == 0) {
		alert("\u8bf7\u589e\u52a0\u4e86\u6570\u636e\u96c6\u540e\u518d\u8bd5!");
		return;
	}
	var sRet = DjOpen("fieldsel", arr, "\u5c55\u73b0", "\u6709\u6a21\u5f0f\u7a97\u53e3", "\u76f4\u63a5", "\u9009\u62e9\u5b57\u6bb5");
	if (typeof sRet != "undefined") {
		var arr1 = sRet.split(",");
		return arr1;
	}
}
function SelColor(obj) {
	var oFont = $("displayfont");
	if (typeof obj != "undefined") {
		oFont = $(obj.id);
	}
	var sInitColor = oFont.style.backgroundColor;
	var sColor;
	if (isSpace(sInitColor)) {
		sColor = dlgHelper.ChooseColorDlg();
	} else {
		sColor = dlgHelper.ChooseColorDlg(sInitColor);
	}
	sColor = sColor.toString(16);
	if (sColor.length < 6) {
		var sTempString = "000000".substring(0, 6 - sColor.length);
		sColor = sTempString.concat(sColor);
	}
	oFont.style.backgroundColor = sColor;
	oFont.changebg = "\u662f";
}
function SelFgColor(obj) {
	var oFont = $("displayfont");
	if (typeof obj != "undefined") {
		oFont = $(obj.id);
	}
	var sInitColor = oFont.style.color;
	var sColor;
	if (isSpace(sInitColor)) {
		sColor = dlgHelper.ChooseColorDlg();
	} else {
		sColor = dlgHelper.ChooseColorDlg(sInitColor);
	}
	sColor = sColor.toString(16);
	if (sColor.length < 6) {
		var sTempString = "000000".substring(0, 6 - sColor.length);
		sColor = sTempString.concat(sColor);
	}
	oFont.style.color = sColor;
}
function SelFunction(obj) {
	var arr = new Array();
	arr[0] = pubDataSet[5];
	try {
		arr[1] = arrRegFuncList;
	}
	catch (e) {
	}
	var sRet = DjOpen("funclist", arr, "\u5c55\u73b0", "\u6709\u6a21\u5f0f\u7a97\u53e3", "\u76f4\u63a5", "\u9009\u62e9\u51fd\u6570");
	if (isSpace(sRet) == false) {
		obj.value = sRet;
	}
}
function GridChangeRow(up, ogrid1) {
	var ogrid;
	if (typeof ogrid1 == "undefined") {
		ogrid = SKBILLgrid1;
	} else {
		ogrid = ogrid1;
	}
	var ods = eval(ogrid.dataset);
	if ((up && ods.RecNo == 0) || (up == false && ods.RecNo >= ods.RecordCount - 1)) {
		return;
	}
	var oP = ods.oDom.documentElement;
	var oNode, oNode1;
	if (up) {
		if (ogrid.TopRow > 0 && ogrid.Row == ogrid.TopRow + 1) {
			ogrid.VscrollTo(ogrid.TopRow - 1);
		}
		oNode = oP.childNodes(ods.RecNo).cloneNode(true);
		oNode1 = oP.childNodes(ods.RecNo - 1).cloneNode(true);
		oP.replaceChild(oNode1, oP.childNodes(ods.RecNo));
		oP.replaceChild(oNode, oP.childNodes(ods.RecNo - 1));
	} else {
		if (ogrid.Vmax > 0 && ogrid.TopRow < ogrid.Vmax && ogrid.Row > ogrid.TopRow + 1) {
			ogrid.VscrollTo(ogrid.TopRow + 1);
		}
		oNode = oP.childNodes(ods.RecNo).cloneNode(true);
		oNode1 = oP.childNodes(ods.RecNo + 1).cloneNode(true);
		oP.replaceChild(oNode1, oP.childNodes(ods.RecNo));
		oP.replaceChild(oNode, oP.childNodes(ods.RecNo + 1));
	}
	if (up) {
		ogrid.tab.rows(ods.RecNo + 1).swapNode(ogrid.tab.rows(ods.RecNo));
		ods.RecNo--;
	} else {
		ogrid.tab.rows(ods.RecNo + 1).swapNode(ogrid.tab.rows(ods.RecNo + 2));
		ods.RecNo++;
	}
}

function BillEventHeadOpen(svalue, obj) {
	var s = svalue;
	var ilen = 14;
	if (typeof s == "function") {
		var s = s.toString();
		ilen = BillEventHeadOpenTmp(s);
		
		//修复不同ie浏览器下不兼容的问题
		//修改[2011-05-03]解决combobox改变事件函数，每次保存表单以后，会删除函数的第一个字母
		//obj.value = s.substring(ilen + 22, s.length - 4);
		//obj.value = s.substring(ilen + 23, s.length - 4);
		obj.value = s.substring(s.indexOf("bill_onclick(\"")+14, s.length - 4);
	} else {
		if (IsSpace(s)) {
			obj.value = "";
		} else {
			ilen = BillEventHeadOpenTmp(s);
			obj.value = s.substring(ilen, s.length - 2);
		}
	}
}
function BillEventHeadOpenTmp(s) {
	var iRet = 14;
	if (s.indexOf("bill_ondblclick") >= 0) {
		iRet = 17;
	} else {
		if (s.indexOf("bill_onexit") >= 0) {
			iRet = 13;
		} else {
			if (s.indexOf("bill_onkeydown") >= 0) {
				iRet = 16;
			}
		}
	}
	return iRet;
}
function SetPasswordEdit(SKDBedit2) {
	var s1 = SKDBedit2.outerHTML;
	var sRet = repStr(s1, "<INPUT ", "<INPUT type=password ");
	SKDBedit2.outerHTML = sRet;
}
function SaveFile(sFile, sHtml) {
	try {
		var fso = new ActiveXObject("Scripting.FileSystemObject");
	}
	catch (e) {
		alert("\u56e0\u5f53\u524dIE\u7981\u6b62\u8fd0\u884cActiveX\u63a7\u4ef6,\u8bf7\u8c03\u4f4eIE\u7684\u5b89\u5168\u5c5e\u6027\u540e\u518d\u8fd0\u884c\u6b64\u529f\u80fd!");
		return;
	}
	var char1 = unescape("%5C");
	var sFile1 = repStr(sFile, char1, char1 + char1);
	try {
		var a = fso.CreateTextFile(sFile1, false);
	}
	catch (e) {
		alert("\u6587\u4ef6" + sFile + "\u5df2\u5b58\u5728.");
		return;
	}
	var s1 = "";
	if (typeof sHtml == "undefined") {
		s1 = t.outerHTML;
	} else {
		s1 = sHtml;
	}
	a.WriteLine(s1);
	a.Close();
	alert("\u6587\u4ef6\u6210\u529f\u4fdd\u5b58\u5230: " + sFile);
}
function loadhtml(sql, djsn, typePath, extname, callback, context) {
	var isprotect = 0;
	if (IsSpace(SKbillsheet.isprotect)) {
		isprotect = 0;
	} else {
		if (SKbillsheet.isprotect == "\u662f") {
			isprotect = 1;
		} else {
			if (SKbillsheet.isprotect == "\u5426") {
				isprotect = 0;
			}
		}
	}
	var sXml = new StringBuffer().append("<No>" ).append( RepXml(sql) ).append( "</No>" ).append( "<No>" ).append( djsn ).append( "</No>" ).append( "<No>" ).append( fcpubdata.databaseTypeName ).append( "</No>" ).append( "<No>" ).append( fcpubdata.Path ).append( "</No>" ).append( "<typepath>" ).append( typePath ).append( "</typepath>" ).append( "<extname>" ).append( extname ).append( "</extname>" ).append( "<no>" ).append( isprotect ).append( "</no>").toString();
	return SendHttp( new StringBuffer().append(location.protocol ).append( "//" ).append( location.host ).append( fcpubdata.servletPath ).append( "/WebDesign" ).append( fcpubdata.dotnetVersion ).append( "?loadhtml").toString(), sXml, callback, context);
}
function CheckContSameName(oContXml, sid, obj, SKbillsheet) {
	var oldid = obj.id;
	sid = trim(sid);
	var re = /\W/g;
	if (re.test(sid)) {
		sRet = "\u63a7\u4ef6\u540d\u79f0\u53ea\u80fd\u4e3aa-z\u6216A-Z\u62160-9\u6216_";
		return sRet;
	}
	var sRet = "";
	var oList = oContXml.documentElement.selectNodes("//id[. ='" + sid + "']");
	if (oList.length > 0) {
		sRet = sid + "\u63a7\u4ef6\u540d\u79f0\u91cd\u590d! \u8bf7\u53e6\u5916\u8f93\u5165\u4e00\u4e2a\u540d\u79f0! ";
	} else {
		if (oList.length <= 0) {
			var oNode = oContXml.documentElement.selectSingleNode("//id[. ='" + oldid + "']");
			if (oNode != null) {
				oNode.text = sid;
				obj.id = sid;
				SKbillsheet.ownerDocument.parentWindow.parent.objlist.execScript("objlist_edit('" + oldid + "','" + sid + "')");
			}
			var sxml = SKbillsheet.billtaborder;
			if (isSpace(sxml) == false) {
				var oXml = SetDom(sxml);
				var oNode = oXml.documentElement.selectSingleNode("//taborder[. ='" + oldid + "']");
				if (oNode != null) {
					oNode.text = sid;
					SKbillsheet.billtaborder = oXml.documentElement.xml;
				}
			}
		}
	}
	return sRet;
}
function SetTextValue(oP, oCont) {
	if (IsSpace(oP)) {
		oCont.value = "";
	} else {
		oCont.value = oP;
	}
}
function SetCheckBoxPutValue(oP, oCont) {
	if (IsSpace(oP)) {
		SetCheckBoxValue(oCont, "\u5426");
	} else {
		SetCheckBoxValue(oCont, oP);
	}
}
function e_SetCheckBoxValue(value, oCont) {
	if (IsSpace(value) == false) {
		SetCheckBoxValue(oCont, value);
	}
}
function e_SetComboValue(value, oCont) {
	if (IsSpace(value) == false) {
		oCont.value = value;
	}
}
function e_SetRadioValue(value, oCont) {
	if (IsSpace(value) == false) {
		SetRadioValue(oCont, value);
	}
}
function e_SetPropValue(obj, propName, value) {
	if (IsSpace(value)) {
		obj.removeAttribute(propName);
	} else {
		obj.setAttribute(propName, value);
	}
}
function SetPosOnChange(oCont, pos) {
	var obj = event.srcElement;
	if (obj.value == txtLeft.value) {
		oCont.style.left = obj.value;
	}
	if (obj.value == txtTop.value) {
		oCont.style.top = obj.value;
	}
	if (obj.value == txtWidth.value) {
		oCont.style.width = obj.value;
	}
	if (obj.value == txtHeight.value) {
		oCont.style.height = obj.value;
	}
}
function RepDqMarks(obj) {
	if (obj.value.indexOf("\"") != -1) {
		return false;
	}
}
function IsCheckDataField(obj1, obj2) {
	if (IsSpace(obj1.value) == false && IsSpace(obj2.value) == true || IsSpace(obj1.value) == true && IsSpace(obj2.value) == false) {
		return false;
	}
}
function ListValueOption(stext, svalue) {
	var stxt = stext.split("\r\n");
	var sval = svalue.split("\r\n");
	var sHtml = "";
	if (IsSpace(stext) == false) {
		for (var i = 0; i < stxt.length; i++) {
			try {
				s1 = stxt[i];
				s2 = sval[i];
				if (typeof s1 == "undefined") {
					s1 = "";
				}
				if (typeof s2 == "undefined") {
					s2 = "";
				}
			}
			catch (e) {
				s1 = "";
				s2 = "";
			}
			if (sHtml == "") {
				sHtml = new StringBuffer().append("<option value='" ).append( s2 ).append( "'>" ).append( s1 ).append( "</option>").toString();
			} else {
				sHtml = new StringBuffer().append(sHtml ).append( "<option value='" ).append( s2 ).append( "'>" ).append( s1 ).append( "</option>").toString();
			}
		}
	}
	return sHtml;
}
function DropDownValueOption(stext, svalue) {
	var stxt = stext.split("\r\n");
	var sval = svalue.split("\r\n");
	var sHtml = "";
	for (var i = 0; i < stxt.length; i++) {
		try {
			s1 = stxt[i];
			s2 = sval[i];
			if (typeof s1 == "undefined") {
				s1 = "";
			}
			if (typeof s2 == "undefined") {
				s2 = "";
			}
		}
		catch (e) {
			s1 = "";
			s2 = "";
		}
		if (IsSpace(svalue)) {
			sHtml = new StringBuffer().append(sHtml ).append( "<tr><td height='16'>" ).append( s1 ).append( "</td></tr>").toString();
		} else {
			sHtml = new StringBuffer().append(sHtml ).append( "<tr><td height='16px'>" ).append( s1 ).append( "</td><td height='16px'>" ).append( s2 ).append( "</td></tr>").toString();
		}
	}
	return sHtml;
}
function PropWinDisplayAction(obj, chkObj) {
	if (chkObj.value == "\u5426") {
		obj.style.display = "none";
	} else {
		obj.style.cssText = RepStr(obj.style.cssText, "DISPLAY: none;", "");
	}
}
function PropWinFontAction(obj, obj1) {
	if (obj1.change == "\u662f") {
		obj.style.color = obj1.style.color;
		obj.style.fontStyle = obj1.style.fontStyle;
		obj.style.textDecoration = obj1.style.textDecoration;
		obj.style.fontFamily = obj1.style.fontFamily;
		obj.style.fontSize = obj1.style.fontSize;
		obj.style.fontWeight = obj1.style.fontWeight;
	}
}
function PropWinChangePosition() {
	if (cboPosition.value != "absolute") {
		txtLeft.value = "";
		txtTop.value = "";
	}
	if (cboPosition.value != "absolute") {
		txtLeft.disabled = true;
		txtTop.disabled = true;
	} else {
		txtLeft.disabled = false;
		txtTop.disabled = false;
	}
}
function PropWinClickTermStyle() {
	var arr1 = new Array();
	var obj = pubDataSet[0];
	arr1[0] = pubDataSet[1];
	arr1[1] = obj.termStyle;
	var sxml = DjOpen("termcard", arr1, "\u5c55\u73b0", "\u6709\u6a21\u5f0f\u7a97\u53e3", "\u76f4\u63a5", "\u6761\u4ef6\u683c\u5f0f");
	if (typeof (sxml) == "undefined") {
		return;
	}
	obj.termStyle = sxml;
}
function PropWinSelField() {
	var arrtmp = contselfield(pubDataSet[1]);
	if (typeof arrtmp != "undefined") {
		txtDataset.value = arrtmp[0];
		txtField.value = arrtmp[1];
		txtFieldChn.value = arrtmp[2];
	}
}
function PropWinChangeDs() {
	if (rdoDs.value != "2") {
		rdoDs.value = 1;
	}
	if (rdoDs.value == "2") {
		txtListText.style.width = 0;
		txtListValue.style.width = 0;
		lblListValue.style.width = 0;
		txtListSql.style.width = 315;
	} else {
		txtListText.style.width = 138;
		txtListValue.style.width = 138;
		lblListValue.style.width = 50;
		txtListSql.style.width = 0;
	}
}
function PropWinOnload() {
	var obj = pubDataSet[0];
	if (typeof displayfont == "object") {
		var obj1 = displayfont;
		if (obj.style.backgroundColor == "") {
			obj1.style.backgroundColor = "#ffffff";
		} else {
			obj1.style.backgroundColor = obj.style.backgroundColor;
		}
		obj1.style.color = obj.style.color;
		obj1.style.fontStyle = obj.style.fontStyle;
		obj1.style.textDecoration = obj.style.textDecoration;
		obj1.style.fontFamily = obj.style.fontFamily;
		obj1.style.fontSize = obj.style.fontSize;
		obj1.style.fontWeight = obj.style.fontWeight;
	}
	SetTextValue(obj.id, txtId);
	if (typeof cmdBgcolor == "object") {
		SetButtonImage(cmdBgcolor, "../images/ef_run_button_color.gif");
	}
	if (typeof cmdFont == "object") {
		SetButtonImage(cmdFont, "../images/ef_run_button_font.gif");
	}
	SetButtonImage(cmdOk, "../images/ef_run_button_ok.gif");
	SetButtonImage(cmdClose, "../images/ef_run_button_close.gif");
	if (typeof chkLeftLine == "object") {
		CheckBoxPutValue(obj.style.borderLeft, chkLeftLine, "0px");
	}
	if (typeof chkTopLine == "object") {
		CheckBoxPutValue(obj.style.borderTop, chkTopLine, "0px");
	}
	if (typeof chkBottomLine == "object") {
		CheckBoxPutValue(obj.style.borderBottom, chkBottomLine, "0px");
	}
	if (typeof chkRightLine == "object") {
		CheckBoxPutValue(obj.style.borderRight, chkRightLine, "0px");
	}
	if (typeof chkDisplay == "object") {
		CheckBoxPutValue(obj.style.display, chkDisplay, "none");
	}
	SetTextValue(obj.style.width, txtWidth);
	SetTextValue(obj.style.height, txtHeight);
	SetTextValue(obj.style.top, txtTop);
	SetTextValue(obj.style.left, txtLeft);
	txtId.onchange = function uf_id_onchange() {
		var sR = CheckContSameName(pubDataSet[3], txtId.value, obj, pubDataSet[2]);
		if (sR != "") {
			alert(sR);
			event.returnValue = false;
		}
	};
	if (typeof chkDisabled == "object") {
		if (obj.disabled == false) {
			SetCheckBoxValue(chkDisabled, "\u662f");
		} else {
			SetCheckBoxValue(chkDisabled, "\u5426");
		}
	}
	cboPosition.value = obj.style.position;
	var tmpB = true;
	if (obj.style.position == "absolute") {
		tmpB = false;
	}
	txtLeft.disabled = tmpB;
	txtTop.disabled = tmpB;
	if (typeof txtValue == "object") {
		SetTextValue(obj.value, txtValue);
	}
	if (typeof txtDataset == "object") {
		SetTextValue(obj.dataset, txtDataset);
	}
	if (typeof txtField == "object") {
		SetTextValue(obj.field, txtField);
	}
	if (typeof txtFieldChn == "object") {
		SetTextValue(obj.china, txtFieldChn);
	}
	if (typeof txtEclick == "object") {
		BillEventHeadOpen(obj.fc_onclick, txtEclick);
	}
	if (typeof txtEdblclick == "object") {
		BillEventHeadOpen(obj.fc_ondblclick, txtEdblclick);
	}
	if (typeof txtEfocus == "object") {
		BillEventHeadOpen(obj.fc_onfocus, txtEfocus);
	}
	if (typeof txtEblur == "object") {
		BillEventHeadOpen(obj.fc_onblur, txtEblur);
	}
	if (typeof txtEkey == "object") {
		BillEventHeadOpen(obj.fc_onkeydown, txtEkey);
	}
	if (typeof txtEchange == "object") {
		BillEventHeadOpen(obj.onchange, txtEchange);
	}
	if (typeof chkReadOnly == "object") {
		if (obj.readOnly == true) {
			SetCheckBoxValue(chkReadOnly, "\u662f");
		} else {
			SetCheckBoxValue(chkReadOnly, "\u5426");
		}
	}
	if (typeof chkNotBg == "object") {
		if (IsSpace(obj.NotBg)) {
			SetCheckBoxValue(chkNotBg, "\u5426");
		} else {
			SetCheckBoxValue(chkNotBg, obj.NotBg);
		}
	}
	if (typeof cboAlign == "object") {
		cboAlign.value = obj.style.textAlign;
	}
	if (typeof txtListText == "object") {
		SetTextValue(obj.temptext, txtListText);
	}
	if (typeof txtListValue == "object") {
		SetTextValue(obj.tempvalue, txtListValue);
	}
	if (typeof txtListSql == "object") {
		SetTextValue(obj.sql, txtListSql);
	}
	if (typeof rdoDs == "object") {
		SetRadioValue(rdoDs, obj.check);
	}
	function CheckBoxPutValue(oP, oCont, vValue) {
		if (oP == vValue) {
			SetCheckBoxValue(oCont, "\u5426");
		} else {
			SetCheckBoxValue(oCont, "\u662f");
		}
	}
}
function PropWinClickOk() {
	var obj = pubDataSet[0];
	if (typeof displayfont == "object") {
		var obj1 = displayfont;
		if (obj1.changebg == "\u662f") {
			obj.style.backgroundColor = obj1.style.backgroundColor;
		}
		PropWinFontAction(obj, obj1);
	}
	if (typeof txtValue == "object") {
		obj.value = txtValue.value;
	}
	if (typeof chkDisabled == "object") {
		if (chkDisabled.value == "\u5426") {
			obj.disabled = true;
		} else {
			obj.disabled = false;
		}
	}
	if (typeof chkDisplay == "object") {
		PropWinDisplayAction(obj, chkDisplay);
	}
	if (typeof chkNotBg == "object") {
		obj.NotBg = chkNotBg.value;
		if (chkNotBg.value == "\u662f") {
			obj.style.backgroundColor = "";
		}
	}
	if (typeof chkLeftLine == "object") {
		if (chkLeftLine.value == "\u5426") {
			obj.style.borderLeft = "0px";
		} else {
			obj.style.cssText = RepStr(obj.style.cssText, "BORDER-LEFT: 0px;", "");
			if (obj.tagName == "DIV") {
				obj.style.borderLeft = "1px solid black";
			}
		}
	}
	if (typeof chkTopLine == "object") {
		if (chkTopLine.value == "\u5426") {
			obj.style.borderTop = "0px";
		} else {
			obj.style.cssText = RepStr(obj.style.cssText, "BORDER-TOP: 0px;", "");
			if (obj.tagName == "DIV") {
				obj.style.borderTop = "1px solid black";
			}
		}
	}
	if (typeof chkBottomLine == "object") {
		if (chkBottomLine.value == "\u5426") {
			obj.style.borderBottom = "0px";
		} else {
			obj.style.cssText = RepStr(obj.style.cssText, "BORDER-BOTTOM: 0px;", "");
			if (obj.tagName == "DIV") {
				obj.style.borderBottom = "1px solid black";
			}
		}
	}
	if (typeof chkRightLine == "object") {
		if (chkRightLine.value == "\u5426") {
			obj.style.borderRight = "0px";
		} else {
			obj.style.cssText = RepStr(obj.style.cssText, "BORDER-RIGHT: 0px;", "");
			if (obj.tagName == "DIV") {
				obj.style.borderRight = "1px solid black";
			}
		}
	}
	obj.style.position = cboPosition.value;
	if (typeof txtFieldChn == "object") {
		obj.china = txtFieldChn.value;
	}
	var sMsg = "\u4e0d\u652f\u6301\u53cc\u5f15\u53f7!";
	if (typeof txtEclick == "object") {
		if (RepDqMarks(txtEclick) == false) {
			alert(sMsg);
			return true;
		}
	}
	if (typeof txtEdblclick == "object") {
		if (RepDqMarks(txtEdblclick) == false) {
			alert(sMsg);
			return true;
		}
	}
	if (typeof txtEfocus == "object") {
		if (RepDqMarks(txtEfocus) == false) {
			alert(sMsg);
			return true;
		}
	}
	if (typeof txtEblur == "object") {
		if (RepDqMarks(txtEblur) == false) {
			alert(sMsg);
			return true;
		}
	}
	if (typeof txtEkey == "object") {
		if (RepDqMarks(txtEkey) == false) {
			alert(sMsg);
			return true;
		}
	}
	if (typeof txtEchange == "object") {
		if (RepDqMarks(txtEchange) == false) {
			alert(sMsg);
			return true;
		}
	}
	if (typeof txtDataset == "object" && typeof txtField == "object") {
		if (IsCheckDataField(txtDataset, txtField) == false) {
			alert("\u6570\u636e\u96c6\u548c\u5b57\u6bb5\u540d\u79f0\u4e0d\u80fd\u4e3a\u7a7a\uff0c\u8bf7\u9009\u62e9\uff01");
			return true;
		}
	}
	var s = "";
	if (typeof txtEclick == "object") {
		s = Trim(txtEclick.value);
		if (s == "") {
			obj.removeAttribute("fc_onclick");
		} else {
			obj.fc_onclick = "bill_onclick(\"" + s + "\")";
		}
	}
	if (typeof txtEchange == "object") {
		s = Trim(txtEchange.value);
		if (s == "") {
			obj.removeAttribute("onchange");
		} else {
			obj.onchange = "bill_onclick(\"" + s + "\")";
		}
	}
	if (typeof txtEdblclick == "object") {
		s = Trim(txtEdblclick.value);
		if (s == "") {
			obj.removeAttribute("fc_ondblclick");
		} else {
			obj.fc_ondblclick = "bill_ondblclick(\"" + s + "\")";
		}
	}
	if (typeof txtEfocus == "object") {
		s = Trim(txtEfocus.value);
		if (s == "") {
			obj.removeAttribute("fc_onfocus");
		} else {
			obj.fc_onfocus = "bill_onenter(\"" + s + "\")";
		}
	}
	if (typeof txtEblur == "object") {
		s = Trim(txtEblur.value);
		if (s == "") {
			obj.removeAttribute("fc_onblur");
		} else {
			obj.fc_onblur = "bill_onexit(\"" + s + "\")";
		}
	}
	if (typeof txtEkey == "object") {
		s = Trim(txtEkey.value);
		if (s == "") {
			obj.removeAttribute("fc_onkeydown");
		} else {
			obj.fc_onkeydown = "bill_onkeydown(\"" + s + "\")";
		}
	}
	if (typeof txtDataset == "object") {
		s = Trim(txtDataset.value);
		if (s == "") {
			obj.removeAttribute("dataset");
		} else {
			obj.dataset = s;
		}
	}
	if (typeof txtField == "object") {
		s = Trim(txtField.value);
		if (s == "") {
			obj.removeAttribute("field");
		} else {
			obj.field = s;
		}
	}
	if (typeof txtFieldChn == "object") {
		s = Trim(txtFieldChn.value);
		if (s == "") {
			obj.removeAttribute("china");
		} else {
			obj.china = s;
		}
	}
	if (typeof cboAlign == "object") {
		obj.style.textAlign = cboAlign.value;
	}
	if (typeof chkReadOnly == "object") {
		if (chkReadOnly.value == "\u662f") {
			obj.readOnly = true;
		} else {
			obj.readOnly = false;
			obj.removeAttribute("readOnly");
		}
	}
	if (typeof rdoDs == "object" && typeof txtListText == "object" && typeof txtListValue == "object" && typeof txtListSql == "object") {
		if (rdoDs.value == "2") {
			obj.check = 2;
		} else {
			obj.check = 1;
		}
		var stxt = txtListText.value.split("\r\n");
		var sval = txtListValue.value.split("\r\n");
		var sHtml = "";
		if (IsSpace(txtListText.value) == false) {
			for (var i = 0; i < stxt.length; i++) {
				try {
					s1 = stxt[i];
					s2 = sval[i];
					if (typeof s1 == "undefined") {
						s1 = "";
					}
					if (typeof s2 == "undefined") {
						s2 = "";
					}
				}
				catch (e) {
					s1 = "";
					s2 = "";
				}
				var sSel = "";
				if (typeof txtValue == "object") {
					if (s2 == txtValue.value) {
						sSel = " selected ";
					}
				}
				sHtml = new StringBuffer().append(sHtml).append("<option value='" ).append( s2).append( "'" ).append(sSel ).append( ">" ).append( s1 ).append( "</option>").toString();
			}
		}
		var slen = stxt.length;
		var lent = sval.length;
		if (IsSpace(txtListText.value) == false && IsSpace(txtListValue.value) == false) {
			if (slen != lent) {
				alert("\u663e\u793a\u503c\u548c\u53d6\u503c\u7684\u957f\u5ea6\u4e0d\u76f8\u7b49,\u8bf7\u4fee\u6539!");
				return true;
			}
		}
		if (IsSpace(txtListText.value) == false && IsSpace(txtListValue.value) == true) {
			txtListValue.value = txtListText.value;
		}
		obj.tempvalue = txtListValue.value;
		obj.temptext = txtListText.value;
		obj.sql = txtListSql.value;
		obj.options.length = 0;
		obj.outerHTML = SelectAddOption(obj, sHtml);
	}
	return false;
}
function GetCreateTable(stablename, sfieldxml, bAddGzid, bAll, sField) {
	var sNewLine = "\r\n";
	var sRet =new StringBuffer();;
	var oXml = SetDom(sfieldxml);
	var l = oXml.documentElement.childNodes.length - 1;
	if (bAll) {
		l++;
	}
	var sF =new StringBuffer();
	var autoFieldName = "";
	if (SKbillsheet.idtype == "2") {
		var oDsMain = GetDsMainObj();
		if (oDsMain != null) {
			if (oDsMain.saveastable == stablename) {
				autoFieldName = SKbillsheet.keyfield;
			}
		}
	}
	for (var j = 0; j < l; j++) {
		sF.append(oXml.documentElement.childNodes(j).childNodes(0).text);
		var stype = oXml.documentElement.childNodes(j).childNodes(2).text;
		var slen = oXml.documentElement.childNodes(j).childNodes(3).text;
		var sDot = oXml.documentElement.childNodes(j).childNodes(4).text;
		if (oXml.documentElement.childNodes(j).childNodes(0).text == autoFieldName && autoFieldName != "") {
			sF.append(" int IDENTITY (1, 1) NOT NULL , ");
		} else {
			if (stype == "\u6574\u6570") {
				sF.append(" integer null ,");
			} else {
				if (stype == "\u5b9e\u6570") {
					sF.append(" decimal(").append(slen).append(",").append(sDot).append(") null ,");
				} else {
					if (stype == "\u6587\u672c") {
						sF.append(" text null ,");
					} else {
						if (stype == "\u56fe\u8c61") {
							sF .append(" image null ,");
						} else {
							if (stype == "\u65e5\u671f") {
								sF.append(" datetime null ,");
							} else {
								sF.append(" varchar(").append( slen).append(") null ,");
							}
						}
					}
				}
			}
		}
	}
	if (IsSpace(sField) == false) {
		sF.append(sField);
	}
	if (bAddGzid) {
		sF.append("GZID varchar(11) null ");
	} else {
	    sF = sF.toString();
		sF = sF.substring(0, sF.length - 1) + sNewLine;
	}
	sRet.append("if exists(select * from sysobjects where name='" ).append( stablename ).append( "')" ).append( sNewLine);
	sRet.append(" drop table " ).append( stablename ).append( " " ).append( sNewLine ).append( ";");
	sRet.append("create table " ).append( stablename ).append( " (" ).append( sNewLine);
	sRet.append(sF).append( ")" ).append( sNewLine);
	return sRet;
}
function DsCreateTable(oDs, sField) {
	var DsMain = $("DsMain");
	if (typeof oDs != "undefined") {
		DsMain = oDs;
	}
	var sql = GetCreateTable(DsMain.saveastable, DsMain.formatxml, false, true, sField);
	var arr = sql.split(";");
	var l = arr.length;
	var sRet =new StringBuffer();
	for (var i = 0; i < l; i++) {
		var s1 = Trim(arr[i]);
		if (IsSpace(s1) == false) {
			sRet.append("<no>").append(s1).append("</no>");
		}
	}
	sRet=sRet.toString();
	if (sRet != "") {
		var s = InsertSqls(sRet);
		if (IsSpace(s)) {
			return "";
		} else {
			return s;
		}
	}
}
function e_ConvertDataTypeToValue(chnName) {
	var ret = 9;
	switch (chnName) {
	  case "\u6574\u6570":
		ret = 17;
		break;
	  case "\u5b9e\u6570":
		ret = 19;
		break;
	  case "\u5b57\u7b26\u4e32":
		ret = 6;
		break;
	  case "\u65e5\u671f":
		ret = 2;
		break;
	  case "\u65f6\u95f4":
		ret = 3;
		break;
	  case "\u65e5\u671f\u65f6\u95f4":
		ret = 4;
		break;
	  case "\u5e03\u5c14":
		ret = 5;
		break;
	  case "\u6574\u6570\u7ec4":
		ret = 273;
		break;
	  case "\u5b9e\u6570\u7ec4":
		ret = 275;
		break;
	  case "\u5b57\u7b26\u4e32\u7ec4":
		ret = 262;
		break;
	  case "\u9ed8\u8ba4":
		ret = 9;
		break;
	  default:
		ret = chnName;
		break;
	}
	return ret;
}
function e_ConvertDataTypeToName(ivalue) {
	var ret = "\u9ed8\u8ba4";
	switch (ivalue) {
	  case "17":
		ret = "\u6574\u6570";
		break;
	  case "19":
		ret = "\u5b9e\u6570";
		break;
	  case "6":
		ret = "\u5b57\u7b26\u4e32";
		break;
	  case "2":
		ret = "\u65e5\u671f";
		break;
	  case "3":
		ret = "\u65f6\u95f4";
		break;
	  case "4":
		ret = "\u65e5\u671f\u65f6\u95f4";
		break;
	  case "5":
		ret = "\u5e03\u5c14";
		break;
	  case "273":
		ret = "\u6574\u6570\u7ec4";
		break;
	  case "275":
		ret = "\u5b9e\u6570\u7ec4";
		break;
	  case "262":
		ret = "\u5b57\u7b26\u4e32\u7ec4";
		break;
	  case "9":
		ret = "\u9ed8\u8ba4";
		break;
	}
	return ret;
}
function e_GetFieldName(sSql, callback, context) {
	if (typeof sSql == "undefined" || sSql == "undefined") {
		return "";
	}
	var sXml = new StringBuffer().append("<No>" ).append( RepXml(sSql) ).append( "</No>").toString();
	var retX = SendHttp(new StringBuffer().append(location.protocol ).append( "//" ).append( location.host ).append( fcpubdata.servletPath ).append( "/WebBill" ).append( fcpubdata.dotnetVersion ).append( "?GetFieldName").toString(), sXml, callback, context);
	return retX;
}
function e_PropWinOnload() {
	if (typeof cmdOk == "object") {
		e_SetButtonImage(cmdOk, "../images/ef_run_button_ok1.gif");
	}
	if (typeof cmdClose == "object") {
		e_SetButtonImage(cmdClose, "../images/ef_run_button_close1.gif");
	}
	if (typeof cmdAdd == "object") {
		e_SetButtonImage(cmdAdd, "../images/ef_run_button_add.gif");
	}
	if (typeof cmdDel == "object") {
		e_SetButtonImage(cmdDel, "../images/ef_run_button_del.gif");
	}
	if (typeof cmdAdd1 == "object") {
		e_SetButtonImage(cmdAdd1, "../images/ef_run_button_add.gif");
	}
	if (typeof cmdDel1 == "object") {
		e_SetButtonImage(cmdDel1, "../images/ef_run_button_del.gif");
	}
	if (typeof cmdEdit == "object") {
		e_SetButtonImage(cmdEdit, "../images/ef_run_button_edit.gif");
	}
}
function e_SetButtonImage(sbutton, spathgif) {
	var obutton = eval(sbutton);
	obutton.style.backgroundImage = "url(" + spathgif + ")";
	obutton.style.cursor = "hand";
	obutton.style.borderTop = "";
	obutton.style.borderBottom = "";
	obutton.style.borderLeft = "";
	obutton.style.borderRight = "";
}
function EbiaoRunQuery() {
	var owin;
	var owin1 = window.dialogArguments;
	var s1 = "";
	if (typeof owin1 != "undefined") {
		s1 = owin1.sPubDjContent;
	}
	if (IsSpace(s1)) {
		owin = parent;
	} else {
		owin = owin1;
	}
	if (ActEbiaoPara(owin) == false) {
		return;
	}
	owin.toolbar.execScript("RunReport(curPageNo,'\u4ece\u53c2\u6570\u8868\u5355\u4e0a\u8fd0\u884c');");
	if (IsSpace(s1) == false) {
		window.close();
	}
}
function ActEbiaoPara(oWin) {
	if (typeof oWin == "undefined") {
		oWin = parent;
	}
	var sxml = oWin.oPubXmlFile.documentElement.getAttribute("e_argsbak");
	if (IsSpace(sxml)) {
		alert("\u6ca1\u6709\u62a5\u8868\u53c2\u6570!");
		return false;
	}
	var oX = SetDom("<root>" + unescape(sxml) + "</root>");
	var newPara = "";
	var basePara = oWin.toolbar.pubBasePara;
	var sMsg = "";
	for (var i = 0; i < oX.documentElement.childNodes.length; i++) {
		var objid = oX.documentElement.childNodes(i).childNodes(4).text;
		var curParaValue = oX.documentElement.childNodes(i).childNodes(5).text;
		if (IsSpace(objid) == false) {
			var objValue = "";
			try {
				objValue = eval(objid).value;
			}
			catch (e) {
			}
			if (typeof objValue == "undefined") {
				objValue = "";
			}
			switch (oX.documentElement.childNodes(i).childNodes(2).text) {
			  case "\u6574\u6570":
				if (IsInt(objValue) == false) {
					sMsg = oX.documentElement.childNodes(i).childNodes(1).text + "\u7684\u503c\u4e0d\u662f\u6574\u6570!";
					alert(sMsg);
					return false;
				}
				break;
			  case "\u5b9e\u6570":
				if (IsNum(objValue) == false) {
					sMsg = oX.documentElement.childNodes(i).childNodes(1).text + "\u7684\u503c\u4e0d\u662f\u5b9e\u6570!";
					alert(sMsg);
					return false;
				}
				break;
			  case "\u5b57\u7b26\u4e32":
				var swidth = oX.documentElement.childNodes(i).childNodes(3).text;
				if (IsSpace(swidth) == false) {
					if (objValue.length > ToInt(swidth)) {
						sMsg = oX.documentElement.childNodes(i).childNodes(1).text + "\u7684\u957f\u5ea6\u8d85\u957f!";
						alert(sMsg);
						return false;
					}
				}
				break;
			}
			curParaValue = objValue;
		}
		var tmp1 = "&" + oX.documentElement.childNodes(i).childNodes(0).text + "=";
		if (basePara.indexOf(tmp1) < 0) {
			newPara += tmp1 + escape(curParaValue);
		}
	}
	oWin.toolbar.pubPara = newPara;
	oWin.toolbar.cacheId = "";
	return true;
}
function ClearBgColor(obj) {
	obj.style.backgroundColor = "transparent";
}
function ActionQueryCond() {
	var sql = "";
	for (var i = 0; i < DsMain.Fields.Field.length; i++) {
		if (IsSpace(DsMain.Fields.Field[i].Value) == false) {
			sql += DsMain.Fields.Field[i].FieldName + "='" + DsMain.Fields.Field[i].Value + "' and ";
		}
	}
	if (sql != "") {
		sql = " where " + sql.substring(0, sql.length - 4);
	}
	PubQueryGridDs.opensql = "select * from " + DsMain.saveastable + sql;
}


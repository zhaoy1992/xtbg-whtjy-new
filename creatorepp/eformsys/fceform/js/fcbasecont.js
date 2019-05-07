function SetRadioValue(r1, sValue) {
	r1.value = sValue;
	for (var i = 1;i < r1.childNodes.length; i++) {
		if (typeof r1.childNodes(i).tagName != "undefined") {
			if (r1.childNodes(i).tagName.toUpperCase() == "INPUT") {
				if (r1.childNodes(i).value == r1.value) {
					r1.childNodes(i).checked = true;
					break;
				}
			}
		}
	}
}
function SetCheckBoxValue(obj, sValue) {
	if (obj.truevalue == sValue) {
		obj.children[0].checked = true;
	} else {
		obj.children[0].checked = false;
	}
	obj.value = sValue;
}

/* 得到选中的单选框值 2010-1-14 add by chenzhwu */
function getRadioValue(RadioName) {
	RadioName = "RG" + RadioName;
	var radioItem = document.getElementsByName(RadioName);
	for (i = 0;i < radioItem.length; i++) {
		if (radioItem[i].checked) {
			return radioItem[i].value;
		}
	}
}

function fillcombox(sSql, callback, context) {
	if (typeof sSql == "undefined" || sSql == "undefined") {
		return "";
	}
	sSql = RepOpenSql(sSql);
	var sXml = new StringBuffer().append("<No>").append(RepXml(sSql))
			.append("</No>").toString();
	var retX = SendHttp(new StringBuffer().append(location.protocol)
			.append("//").append(location.host).append(fcpubdata.servletPath)
			.append("/WebBill").append(fcpubdata.dotnetVersion)
			.append("?fillcombox").toString(), sXml, callback, context);
	return retX;
}
function fillcomboxForDbName(sSql, dbName) {
	if (typeof sSql == "undefined" || sSql == "undefined") {
		return "";
	}
	sSql = RepOpenSql(sSql);
	var sXml = new StringBuffer().append("<No>").append(RepXml(sSql))
			.append("</No>").toString();
	var retX = SendHttp(new StringBuffer().append(location.protocol)
			.append("//").append(location.host).append(fcpubdata.servletPath)
			.append("/WebBill").append(fcpubdata.dotnetVersion)
			.append("?fillcombox&key=fillcombox&dbName=").append(dbName)
			.toString(), sXml);
	return retX;
}
function SelectAddOption(obj, sHtml) {
	var ss = obj.outerHTML;
	return ss.substring(0, ss.length - 9) + sHtml + "</select>";
}
function sqlcombox(obj, sql) {
	if (typeof obj != "object")
		obj = eval(obj);
	if (isSpace(sql) == false)
		obj.sql = sql;
	if (isSpace(obj.sql) == false) {
		var s1 = "";
		if (isSpace(obj.dbName) == false) {
			s1 = fillcomboxForDbName(obj.sql, obj.dbName);
		} else {
			s1 = fillcombox(obj.sql);
		}
		if (isSpace(s1) == false) {
			obj.outerHTML = SelectAddOption(obj, s1);
		}
	}
}
function SqlCombo(obj, sql) {
	sqlcombox(obj, sql);
}
function SetComboText(obj, sText) {
	l = obj.options.length;
	for (var i = 0;i < l; i++) {
		if (obj.options(i).text == sText) {
			obj.selectedIndex = i;
			return
		}
	}
}
function DivRadioInitLoad(obj) {
	if (isSpace(obj.sqltrans))
		return;
	var strsql = UnSqlPropTrans(obj.sqltrans);
	var strReturn = SelectSql(strsql, 1, 100);
	var sfont = obj.style.fontSize;
	var sfontstyle = obj.style.fontStyle;
	var sfontweight = obj.style.fontWeight;
	var sColor = obj.style.color;
	var oXml = new ActiveXObject("Microsoft.XMLDOM");
	oXml.async = false;
	oXml.loadXML(strReturn);
	var sLen = oXml.documentElement.childNodes.length;
	if (sLen > 0) {
		var strX = new StringBuffer()
				.append("<table border=0 width='100%' style='font-size:")
				.append(sfont).append("; font-Style:").append(sfontstyle)
				.append("; font-Weight:").append(sfontweight)
				.append("; color:").append(sColor + "'><tr>");
		var j = 0;
		var s = obj.rows - 1;
		for (var i = 0;i < sLen - 1; i++) {
			sdwid = oXml.documentElement.childNodes(i).childNodes(0).text;
			sdwname = oXml.documentElement.childNodes(i).childNodes(1).text;
			strX.append("<td><input type='radio' name='radio' value='")
					.append(sdwid).append("' text='").append(sdwname)
					.append("'>").append(sdwname).append("</td>");
			j = j + 1;
			if (j > s) {
				strX.append("</tr><tr>");
				j = 0;
			}
		}
		strX.append("</tr></table>");
	}
	obj.innerHTML = strX.toString();
}
function DivCheckBoxInitLoad(obj) {
	if (isSpace(obj.sqltrans))
		return;
	var strsql = UnSqlPropTrans(obj.sqltrans);
	var strReturn = SelectSql(strsql, 1, 1000);
	var sfontsize = obj.style.fontSize;
	var sfontstyle = obj.style.fontStyle;
	var sfontweight = obj.style.fontWeight;
	var sColor = obj.style.color;
	var oXml = new ActiveXObject("Microsoft.XMLDOM");
	oXml.async = false;
	oXml.loadXML(strReturn);
	var sLen = oXml.documentElement.childNodes.length;
	if (sLen > 0) {
		var strX = new StringBuffer()
				.append("<table border=0 width='100%' style='font-size:")
				.append(sfontsize).append("; font-style:").append(sfontstyle)
				.append(" ; font-weight:").append(sfontweight)
				.append("; color:").append(sColor).append("'><tr>");
		var j = 0;
		var s = obj.rows - 1;
		for (var i = 0;i < sLen - 1; i++) {
			sdwid = oXml.documentElement.childNodes(i).childNodes(0).text;
			sdwname = oXml.documentElement.childNodes(i).childNodes(1).text;
			strX.append("<td><input type='checkbox' id='check' value='")
					.append(sdwid).append("' text='").append(sdwname)
					.append("'>").append(sdwname).append("</td>");
			j = j + 1;
			if (j > s) {
				strX.append("</tr><tr>");
				j = 0;
			}
		}
		strX.append("</tr></table>");
	}
	obj.innerHTML = strX.toString();
}
function GetDivRadioValue(obj, isText) {
	var t = obj.children[0];
	for (var i = 0;i < t.rows.length; i++) {
		for (var j = 0;j < t.rows(i).cells.length; j++) {
			if (t.rows(i).cells(j).childNodes(0).checked) {
				if (typeof isText == "undefined" || isText == '')
					return t.rows(i).cells(j).childNodes(0).value;
				else
					return t.rows(i).cells(j).childNodes(0).text;
			}
		}
	}
	return "";
}
function GetDivCheckBoxValue(obj, isText) {
	var strX = "";
	var t = obj.children[0];
	for (var i = 0;i < t.rows.length; i++) {
		for (var j = 0;j < t.rows(i).cells.length; j++) {
			if (t.rows(i).cells(j).childNodes(0).checked) {
				if (typeof isText == "undefined" || isText == '')
					strX = strX + t.rows(i).cells(j).childNodes(0).value + ",";
				else
					strX = strX + t.rows(i).cells(j).childNodes(0).text + ",";
			}
		}
	}
	var ll = strX.length;
	strX = strX.substring(0, ll - 1);
	return strX;
}
function SetDivRadioValue(obj, vValue, isText) {
	var strX = "";
	var t = obj.children[0];
	for (var i = 0;i < t.rows.length; i++) {
		for (var j = 0;j < t.rows(i).cells.length; j++) {
			var s = t.rows(i).cells(j).childNodes(0).text;
			if (typeof isText == "undefined" || isText == "")
				s = t.rows(i).cells(j).childNodes(0).value;
			if (s == vValue) {
				t.rows(i).cells(j).childNodes(0).checked = true;
			}
		}
	}
}
function SetDivCheckBoxValue(obj, strX, isText) {
	if (typeof strX == "undefined" || strX == "")
		return;
	var arr = strX.split(",");
	var t = obj.children[0];
	for (var i = 0;i < t.rows.length; i++) {
		for (var j = 0;j < t.rows(i).cells.length; j++) {
			for (var k = 0;k < arr.length; k++) {
				var s = t.rows(i).cells(j).childNodes(0).text;
				if (typeof isText == "undefined" || isText == "")
					s = t.rows(i).cells(j).childNodes(0).value;
				if (s == arr[k]) {
					t.rows(i).cells(j).childNodes(0).checked = true;
					break;
				}
			}
		}
	}
}
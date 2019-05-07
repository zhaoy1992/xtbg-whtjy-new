
/*
*######################################
* eWebEditor v6.8 - Advanced online web based WYSIWYG HTML editor.
* Copyright (c) 2003-2009 eWebSoft.com
*
* For further information go to http://www.ewebsoft.com/
* This copyright notice MUST stay intact for use.
*######################################
*/
String.prototype.Contains = function (s) {
	return (this.indexOf(s) > -1);
};
String.prototype.StartsWith = function (s) {
	return (this.substr(0, s.length) == s);
};
String.prototype.EndsWith = function (s, ignoreCase) {
	var L1 = this.length;
	var L2 = s.length;
	if (L2 > L1) {
		return false;
	}
	if (ignoreCase) {
		var mK = new RegExp(s + "$", "i");
		return mK.test(this);
	} else {
		return (L2 == 0 || this.substr(L1 - L2, L2) == s);
	}
};
Array.prototype.IndexOf = function (s) {
	for (var i = 0; i < this.length; i++) {
		if (this[i] == s) {
			return i;
		}
	}
	return -1;
};
(function () {
	var ng = /()??/.exec("")[1] === undefined;
	var kj = function () {
		var x = /^/g;
		x.test("");
		return !x.lastIndex;
	}();
	var eL = {exec:RegExp.prototype.exec, match:String.prototype.match, replace:String.prototype.replace, split:String.prototype.split, test:RegExp.prototype.test};
	var mE = function (jj, item, oO) {
		for (var i = oO || 0; i < jj.length; i++) {
			if (jj[i] === item) {
				return i;
			}
		}
		return -1;
	};
	var mw = function (bM) {
		return (bM.global ? "g" : "") + (bM.ignoreCase ? "i" : "") + (bM.multiline ? "m" : "") + (bM.extended ? "x" : "") + (bM.sticky ? "y" : "");
	};
	var jd = function (o) {
		return Object.prototype.toString.call(o) === "[object RegExp]";
	};
	RegExp.prototype.exec = function (H) {
		var match = eL.exec.apply(this, arguments), name, r2;
		if (match) {
			if (!ng && match.length > 1 && mE(match, "") > -1) {
				r2 = RegExp("^" + this.source + "$(?!\\s)", mw(this));
				eL.replace.call(match[0], r2, function () {
					for (var i = 1; i < arguments.length - 2; i++) {
						if (arguments[i] === undefined) {
							match[i] = undefined;
						}
					}
				});
			}
			if (!kj && this.global && this.lastIndex > (match.index + match[0].length)) {
				this.lastIndex--;
			}
		}
		return match;
	};
	if (!kj) {
		RegExp.prototype.test = function (H) {
			var match = eL.exec.call(this, H);
			if (match && this.global && this.lastIndex > (match.index + match[0].length)) {
				this.lastIndex--;
			}
			return !!match;
		};
	}
	String.prototype.match = function (bM) {
		if (!jd(bM)) {
			bM = RegExp(bM);
		}
		if (bM.global) {
			var result = eL.match.apply(this, arguments);
			bM.lastIndex = 0;
			return result;
		}
		return bM.exec(this);
	};
	String.prototype.split = function (s, limit) {
		if (!jd(s)) {
			return eL.split.apply(this, arguments);
		}
		var H = this + "", output = [], lastLastIndex = 0, match, lastLength;
		if (limit === undefined || +limit < 0) {
			limit = Infinity;
		} else {
			limit = Math.floor(+limit);
			if (!limit) {
				return [];
			}
		}
		while (match = s.exec(H)) {
			if (s.lastIndex > lastLastIndex) {
				output.push(H.slice(lastLastIndex, match.index));
				if (match.length > 1 && match.index < H.length) {
					Array.prototype.push.apply(output, match.slice(1));
				}
				lastLength = match[0].length;
				lastLastIndex = s.lastIndex;
				if (output.length >= limit) {
					break;
				}
			}
			if (!match[0].length) {
				s.lastIndex++;
			}
		}
		if (lastLastIndex === H.length) {
			if (!eL.test.call(s, "") || lastLength) {
				output.push("");
			}
		} else {
			output.push(H.slice(lastLastIndex));
		}
		return output.length > limit ? output.slice(0, limit) : output;
	};
})();
var myParam = new Object();
np();
function np() {
	var URLParams = new Object();
	var dz = document.location.search.substr(1).split("&");
	for (i = 0; i < dz.length; i++) {
		var dq = dz[i].split("=");
		URLParams[dq[0]] = dq[1];
	}
	myParam.LinkField = URLParams["id"];
	myParam.LinkOriginalFileName = URLParams["originalfilename"];
	myParam.LinkSaveFileName = URLParams["savefilename"];
	myParam.LinkSavePathFileName = URLParams["savepathfilename"];
	myParam.ExtCSS = URLParams["extcss"];
	myParam.FullScreen = URLParams["fullscreen"];
	myParam.StyleName = (URLParams["style"]) ? URLParams["style"] : "coolblue";
	myParam.CusDir = (URLParams["cusdir"]) ? URLParams["cusdir"] : "";
	myParam.Skin = (URLParams["skin"]) ? URLParams["skin"] : "";
	myParam.FixWidth = (URLParams["fixwidth"]) ? URLParams["fixwidth"] : "";
	myParam.AreaCssMode = (URLParams["areacssmode"] == "1") ? "1" : "";
	myParam.ReadOnly = (URLParams["readonly"]) ? URLParams["readonly"] : "";
	myParam.SKey = (URLParams["skey"]) ? URLParams["skey"] : "";
}
var config = new Object();
config.StyleName = myParam.StyleName;
config.CusDir = myParam.CusDir;
config.SKey = myParam.SKey;
var myBrowser = new Object();
hA();
function hA() {
	var s = navigator.userAgent.toLowerCase();
	myBrowser.IsIE = s.Contains("msie");
	myBrowser.IsIE7 = s.Contains("msie 7");
	myBrowser.IsIE8 = s.Contains("msie 8");
	myBrowser.IsSP2 = s.Contains("sv1");
	myBrowser.IsGecko = s.Contains("gecko/");
	myBrowser.IsSafari = s.Contains("safari");
	myBrowser.IsOpera = s.Contains("opera");
	myBrowser.IsMac = s.Contains("macintosh");
	myBrowser.IsCompatible = hz();
	if (!myBrowser.IsCompatible) {
		var a = parent.document.getElementsByTagName("IFRAME");
		for (var i = 0; i < a.length; i++) {
			if (a[i].contentWindow == window) {
				a[i].style.display = "none";
				parent.document.getElementsByName(myParam.LinkField)[0].style.display = "";
			}
		}
	}
}
function hz() {
	if (myBrowser.IsIE && !myBrowser.IsMac && !myBrowser.IsOpera) {
		var hC = navigator.appVersion.match(/MSIE (.\..)/)[1];
		return (hC >= 5.5);
	}
	return false;
}
var lang = new Object();
lang.as = function (targetDocument) {
	var cJ = targetDocument.getElementsByTagName("INPUT");
	for (i = 0; i < cJ.length; i++) {
		if (cJ[i].getAttribute("lang")) {
			cJ[i].value = lang[cJ[i].getAttribute("lang")];
		}
	}
	var cL = targetDocument.getElementsByTagName("SPAN");
	for (i = 0; i < cL.length; i++) {
		if (cL[i].getAttribute("lang")) {
			cL[i].innerHTML = lang[cL[i].getAttribute("lang")];
		}
	}
	var cI = targetDocument.getElementsByTagName("OPTION");
	for (i = 0; i < cI.length; i++) {
		if (cI[i].getAttribute("lang")) {
			cI[i].innerHTML = lang[cI[i].getAttribute("lang")];
		}
	}
};
var myEditor = new Object();
function nK() {
	if (!config.L) {
		return;
	}
	myEditor.av = null;
	myEditor.IsEditMode = null;
	myEditor.LinkField = null;
	if (!myBrowser.IsCompatible) {
		return;
	}
	var s = document.location.pathname;
	myEditor.RootPath = s.substr(0, s.length - 15);
	myEditor.BaseHref = "";
	if (config.BaseHref != "") {
		myEditor.BaseHref = "<base href='" + fh() + config.BaseHref + "'>";
	}
	if (myParam.ExtCSS) {
		myEditor.ExtCSS = "<link href='" + og(myParam.ExtCSS) + "' type='text/css' rel='stylesheet'>";
	} else {
		myEditor.ExtCSS = "";
	}
	if (myParam.Skin) {
		config.Skin = myParam.Skin;
	}
	if (myParam.FixWidth) {
		config.FixWidth = myParam.FixWidth;
	}
	if (myParam.AreaCssMode) {
		config.AreaCssMode = myParam.AreaCssMode;
	}
	if (myParam.ReadOnly) {
		config.InitMode = "VIEW";
		if (myParam.ReadOnly == "2") {
			config.StateFlag = "";
		} else {
			config.SBCode = "";
			config.SBEdit = "";
			config.SBText = "";
			config.SBView = "";
		}
	}
	config.HttpBlankUrl = kL();
	config.SendUrl = fh() + myEditor.RootPath + "/" + config.ServerExt + "/upload." + config.ServerExt + "?action=local&type=local&style=" + config.StyleName + "&cusdir=" + config.CusDir + "&sparams=" + config.SParams;
	document.oncontextmenu = ei;
	document.ondragstart = ei;
	document.onselectstart = ei;
	document.onselect = ei;
	nN();
}
function D() {
	return gl().document;
}
function gl() {
	return document.getElementById("eWebEditor").contentWindow;
}
var bInitialized = false;
window.onload = function () {
	if (!config.L) {
		return;
	}
	if (bInitialized) {
		return;
	}
	bInitialized = true;
	if (!myBrowser.IsCompatible) {
		return;
	}
	myEditor.LinkField = parent.document.getElementsByName(myParam.LinkField)[0];
	mf();
	nG();
	for (var i = 0; i < document.all.length; i++) {
		document.all[i].unselectable = "on";
	}
	document.getElementById("eWebEditor").unselectable = "off";
	if ((!myEditor.LinkField) && (config.ServerExt == "aspx")) {
		myEditor.LinkField = jv("input");
		if (!myEditor.LinkField) {
			myEditor.LinkField = jv("textarea");
		}
	}
	if (!myBrowser.IsCompatible) {
		config.InitMode = "TEXT";
	}
	if (ContentFlag.value == "0") {
		ContentEdit.value = myEditor.LinkField.value;
		ContentLoad.value = myEditor.LinkField.value;
		ModeEdit.value = config.InitMode;
		ContentFlag.value = "1";
	}
	setMode(ModeEdit.value);
	or();
};
function jv(fy) {
	var gF = parent.document.getElementsByTagName(fy);
	for (var i = 0; i < gF.length; i++) {
		var ct = gF[i].getAttribute("name");
		var n = ct.lastIndexOf("$");
		if (n < 0) {
			n = ct.lastIndexOf(":");
		}
		if (n >= 0) {
			ct = ct.substr(n + 1);
			if (ct == myParam.LinkField) {
				return gF[i];
			}
		}
	}
	return null;
}
function hu(html) {
	if (config.FixWidth) {
		var U = new RegExp("<div (.*?)id=eWebEditor_FixWidth_DIV(.*?)>", "gi");
		if (!U.test(html)) {
			return "<div id=eWebEditor_FixWidth_DIV style='width:" + config.FixWidth + ";height:100%' unselectable>" + html + "</div>";
		}
	}
	return html;
}
function kS(cZ) {
	cZ.onmouseover = mY;
	cZ.onmouseout = mq;
	cZ.onmousedown = mp;
	cZ.onmouseup = mZ;
	cZ.ondragstart = ei;
	cZ.onselectstart = ei;
	cZ.onselect = ei;
	cZ.YINITIALIZED = true;
	return true;
}
function ei() {
	event.returnValue = false;
	event.cancelBubble = true;
	return false;
}
function gf() {
	var el = event.srcElement;
	if (el.tagName == "IMG") {
		el = el.parentNode;
	}
	if (el.className == "TB_Btn_Image") {
		el = el.parentNode;
	}
	return el;
}
mY = function () {
	var el = gf();
	el.className = "TB_Btn_Over";
};
mq = function () {
	var el = gf();
	if (el.QCV) {
		el.className = "TB_Btn_Down";
	} else {
		el.className = "TB_Btn";
	}
};
mp = function () {
	var el = gf();
	el.className = "TB_Btn_Down";
};
mZ = function () {
	var el = gf();
	if (el.className = "TB_Btn_Down") {
		el.className = "TB_Btn_Over";
	} else {
		if (el.QCV) {
			el.className = "TB_Btn_Down";
		} else {
			el.className = "TB_Btn";
		}
	}
};
function nG(y) {
	var i, gF, el, p;
	p = document.getElementById("eWebEditor_Toolbar");
	gF = p.getElementsByTagName("div");
	for (i = 0; i < gF.length; i++) {
		el = gF[i];
		if (el.className == "TB_Btn") {
			if (el.YINITIALIZED == null) {
				if (!kS(el)) {
					alert("Problem initializing:" + el.id);
					return false;
				}
			}
		}
	}
	return true;
}
function eH() {
	if (myEditor.av != "EDIT") {
		return;
	}
	var b = (D().selection.type == "Control") ? true : false;
	mo(b);
	mn(b);
}
var eV = new Object;
eV.Loaded = false;
function mo(gd) {
	var gG = ["Bold", "Italic", "UnderLine", "StrikeThrough", "SuperScript", "SubScript", "JustifyLeft", "JustifyCenter", "JustifyRight", "JustifyFull"];
	if (!eV.Loaded) {
		var gF = document.getElementById("eWebEditor_Toolbar").getElementsByTagName("DIV");
		for (var i = 0; i < gG.length; i++) {
			var bS = gG[i];
			eV[bS] = new Array();
			for (var j = 0; j < gF.length; j++) {
				var el = gF[j];
				if (el.getAttribute("name") == "TB_Name_" + bS) {
					eV[bS][eV[bS].length] = el;
				}
			}
		}
	}
	var K = D().selection.createRange();
	for (var i = 0; i < gG.length; i++) {
		var bS = gG[i];
		var v = K.queryCommandValue(bS);
		var gF = eV[bS];
		for (var j = 0; j < gF.length; j++) {
			var el = gF[j];
			el.QCV = v;
			if (gd) {
				el.className = "TB_Btn";
			} else {
				if (v) {
					el.className = "TB_Btn_Down";
				} else {
					el.className = "TB_Btn";
				}
			}
		}
	}
}
function mn(gd) {
	var cW, v;
	var K = D().selection.createRange();
	cW = "FontName";
	if (gd) {
		v = "";
	} else {
		v = K.queryCommandValue(cW);
	}
	ji(cW, v);
	cW = "FontSize";
	if (gd) {
		v = "";
	} else {
		v = K.queryCommandValue(cW);
		if (v) {
			v = jN(v);
		} else {
			v = lc(K);
		}
	}
	ji(cW, v);
}
function ji(cW, v) {
	var gF = document.getElementsByName("TB_Name_" + cW);
	for (var i = 0; i < gF.length; i++) {
		var el = gF[i];
		if (v) {
			v = v.toLowerCase();
			var b = false;
			for (var j = 0; j < el.options.length; j++) {
				if (el.options[j].value.toLowerCase() == v) {
					el.selectedIndex = j;
					b = true;
					break;
				}
			}
			if (!b) {
				el.options[el.options.length] = new Option(v, v);
				el.selectedIndex = el.options.length - 1;
			}
		} else {
			el.selectedIndex = 0;
		}
	}
}
function lc(K) {
	if (K.text.length <= 1) {
		return K.parentElement().currentStyle.fontSize;
	}
	var html = K.htmlText;
	html = html.replace(/<[^>]+>/gi, " ");
	html = html.replace(/(&nbsp\;|\s)+/gi, " ");
	html = html.replace(/(^\s*)|(\s*$)/gi, "");
	var ho = html.split(" ");
	var r = "";
	var mr = K.getBookmark();
	K.collapse();
	for (var i = 0; i < ho.length; i++) {
		if (!ho[i]) {
			continue;
		}
		var b = K.findText(ho[i]);
		if (b) {
			var v = K.parentElement().currentStyle.fontSize;
			if ((r != "") && (r != v)) {
				r = "";
				break;
			}
			r = v;
			K.collapse(false);
		} else {
			break;
		}
	}
	K.moveToBookmark(mr);
	return r;
}
function or() {
	if (!myEditor.LinkField) {
		return;
	}
	var aI = myEditor.LinkField.form;
	if (!aI) {
		return;
	}
	aI.attachEvent("onsubmit", iA);
	if (!aI.submitEditor) {
		aI.submitEditor = new Array();
	}
	aI.submitEditor[aI.submitEditor.length] = iA;
	if (!aI.originalSubmit) {
		aI.originalSubmit = aI.submit;
		aI.submit = function () {
			if (this.submitEditor) {
				for (var i = 0; i < this.submitEditor.length; i++) {
					this.submitEditor[i]();
				}
			}
			this.originalSubmit();
		};
	}
	aI.attachEvent("onreset", iK);
	if (!aI.resetEditor) {
		aI.resetEditor = new Array();
	}
	aI.resetEditor[aI.resetEditor.length] = iK;
	if (!aI.originalReset) {
		aI.originalReset = aI.reset;
		aI.reset = function () {
			if (this.resetEditor) {
				for (var i = 0; i < this.resetEditor.length; i++) {
					this.resetEditor[i]();
				}
			}
			this.originalReset();
		};
	}
}
function iA() {
	var aI = myEditor.LinkField.form;
	if (!aI) {
		return;
	}
	var html = getHTML();
	if (config.PaginationMode != "0" && config.PaginationAutoFlag != "0") {
		if (myEditor.av != "EDIT") {
			setMode("EDIT");
		}
		var b = true;
		if (config.PaginationAutoFlag == "1") {
			var gF = D().getElementsByTagName("IMG");
			for (var i = 0; i < gF.length; i++) {
				var bV = gF[i].getAttribute("eWebEditorFake", 2);
				if (bV) {
					if (bV.toLowerCase() == "pagination") {
						b = false;
						break;
					}
				}
			}
		}
		if (b) {
			jw(config.PaginationAutoNum);
			html = getHTML();
		}
	}
	ContentEdit.value = html;
	if (myEditor.av == "TEXT") {
		html = dv(html);
	}
	iR(myEditor.LinkField, html);
}
function lV() {
	var aI = myEditor.LinkField.form;
	if (!aI) {
		return;
	}
	aI.submit();
}
function iK() {
	if (myEditor.IsEditMode) {
		D().body.innerHTML = ContentLoad.value;
	} else {
		D().body.innerText = ContentLoad.value;
	}
}
function nr() {
	ad("about.htm");
	return false;
}
var bK;
function nx() {
	if (myEditor.av == "VIEW" || myEditor.av == "EDIT") {
		return false;
	}
	if (!myHistory.ax) {
		saveHistory();
	}
	D().selection.createRange().pasteHTML(dv(clipboardData.getData("Text")));
	saveHistory();
	return false;
}
function iU() {
	if (myEditor.av != "EDIT") {
		return false;
	}
	if (config.AutoDetectPaste == "1") {
		if (!bY(true)) {
			return false;
		}
		var aJ = eWebEditorActiveX.GetClipboardFlag();
		eWebEditorActiveX = null;
		var gA = aJ.split("|");
		if (gA[5] == "1") {
			bK = D().selection.createRange().getBookmark();
			window.setTimeout("hD()", 10);
			try {
				gl().event.returnValue = false;
			}
			catch (e) {
			}
			return false;
		} else {
			if (gA[5] == "2") {
				bK = D().selection.createRange().getBookmark();
				window.setTimeout("nz()", 10);
				try {
					gl().event.returnValue = false;
				}
				catch (e) {
				}
				return false;
			} else {
				if (gA[0] == "1" || gA[3] == "1") {
					bK = D().selection.createRange().getBookmark();
					window.setTimeout("nu('" + aJ + "')", 10);
					try {
						gl().event.returnValue = false;
					}
					catch (e) {
					}
					return false;
				}
			}
		}
	}
	var an = jP();
	D().selection.createRange().pasteHTML(an);
	hH();
	return false;
}
function nu(aJ) {
	if (bK) {
		var K = D().selection.createRange();
		K.moveToBookmark(bK);
		K.select();
	}
	var P = showModalDialog("dialog/paste.htm?flag=" + aJ, window, "dialogWidth:0px;dialogHeight:0px;help:no;scroll:no;status:no");
	if (P) {
		switch (P) {
		  case "html":
			var bt = jP();
			D().selection.createRange().pasteHTML(bt);
			hH();
			break;
		  case "text":
			jH();
			break;
		}
	}
	bK = "";
}
function hD() {
	if (bK) {
		var K = D().selection.createRange();
		K.moveToBookmark(bK);
		K.select();
	}
	ad("importword.htm?action=paste", true);
	bK = "";
}
function nz() {
	if (bK) {
		var K = D().selection.createRange();
		K.moveToBookmark(bK);
		K.select();
	}
	ad("importexcel.htm?action=paste", true);
	bK = "";
}
function kW() {
	if (!bY(true)) {
		return;
	}
	eWebEditorActiveX.Capture("");
	window.setTimeout("ie()", 100);
}
function ie() {
	try {
		if (eWebEditorActiveX.Status != "ok") {
			window.setTimeout("ie()", 100);
			return;
		}
	}
	catch (e) {
		return;
	}
	if (eWebEditorActiveX.Error == "cancel") {
		return;
	}
	if (cO()) {
		return;
	}
	var bt = eWebEditorActiveX.Body;
	insertHTML(bt);
	hH();
	eWebEditorActiveX = null;
}
function nm(event) {
	var aX = event.keyCode;
	var aN = String.fromCharCode(aX).toUpperCase();
	if (event.ctrlKey || ((aX >= 33) && (aX <= 40)) || (aX == 13) || (aX == 8) || (aX == 46)) {
		eH();
	}
}
function nl(event) {
	var aX = event.keyCode;
	var aN = String.fromCharCode(aX).toUpperCase();
	if (aX == 113) {
		hM();
		return false;
	}
	if (event.ctrlKey) {
		if (aX == 13) {
			lV();
			return false;
		}
		if (aX == 187) {
			eq(300);
			return false;
		}
		if (aX == 189) {
			eq(-300);
			return false;
		}
		if (aN == "1") {
			setMode("CODE");
			return false;
		}
		if (aN == "2") {
			setMode("EDIT");
			return false;
		}
		if (aN == "3") {
			setMode("TEXT");
			return false;
		}
		if (aN == "4") {
			setMode("VIEW");
			return false;
		}
		if (aN == "A") {
			if ((myEditor.av != "CODE") && (config.FixWidth)) {
				jT();
			} else {
				aY();
				if (!history.ax) {
					saveHistory();
				}
				D().execCommand("SelectAll");
				saveHistory();
				aY();
			}
			return false;
		}
	}
	switch (myEditor.av) {
	  case "VIEW":
		return true;
		break;
	  case "EDIT":
		if (event.ctrlKey) {
			if (aN == "D") {
				hD();
				return false;
			}
			if (aN == "R") {
				jb();
				return false;
			}
			if (aN == "Z") {
				ey(-1);
				return false;
			}
			if (aN == "Y") {
				ey(1);
				return false;
			}
			if (aN == "V") {
				iU();
				return false;
			}
		} else {
			if ((config.EnterMode == "2") && (aX == 13)) {
				if (!myHistory.ax) {
					saveHistory();
				}
				myHistory.ax = false;
				var K = D().selection.createRange();
				if (event.shiftKey) {
					var p = K.parentElement();
					if (p.tagName != "P" || p.innerHTML == "") {
						K.pasteHTML("&nbsp;");
						K.select();
						K.collapse(false);
					}
					try {
						K.pasteHTML("</P><P id=eWebEditor_Temp_P>");
					}
					catch (e) {
						return false;
					}
					event.cancelBubble = true;
					event.returnValue = false;
					var el = D().getElementById("eWebEditor_Temp_P");
					if (el.innerHTML == "") {
						el.innerHTML = "&nbsp;";
					}
					K.moveToElementText(el);
					K.select();
					K.collapse(false);
					K.select();
					el.removeAttribute("id");
				} else {
					try {
						K.pasteHTML("<br>");
					}
					catch (e) {
						return false;
					}
					event.cancelBubble = true;
					event.returnValue = false;
					K.select();
					K.moveEnd("character", 1);
					K.moveStart("character", 1);
					K.collapse(false);
				}
				return false;
			}
		}
		break;
	  default:
		if (aX == 13) {
			if (!myHistory.ax) {
				saveHistory();
			}
			myHistory.ax = false;
			var G = D().selection.createRange();
			G.pasteHTML("<BR>");
			event.cancelBubble = true;
			event.returnValue = false;
			G.select();
			G.moveEnd("character", 1);
			G.moveStart("character", 1);
			G.collapse(false);
			return false;
		}
		if (event.ctrlKey) {
			if ((aN == "B") || (aN == "I") || (aN == "U")) {
				return false;
			}
			if (aN == "Z") {
				ey(-1);
				return false;
			}
			if (aN == "Y") {
				ey(1);
				return false;
			}
		}
		break;
	}
	if ((aX == 13) || (aX == 8) || (aX == 46)) {
		if (!myHistory.ax) {
			saveHistory();
		}
		myHistory.ax = false;
	} else {
		if ((aX >= 33) && (aX <= 40)) {
			if (!myHistory.ax) {
				saveHistory();
			}
		} else {
			if (!((event.ctrlKey && aN == "A") || (event.ctrlKey && aN == "F"))) {
				myHistory.ax = false;
			}
		}
	}
	return true;
}
var bX = new Object;
function nn() {
	if (myEditor.av != "EDIT") {
		return;
	}
	bX.oJ = null;
	if (D().selection.type == "Control") {
		var dD = D().selection.createRange();
		bX.oJ = dD(0);
		bX.w = bX.oJ.style.width;
		bX.h = bX.oJ.style.height;
	}
	if (!myHistory.ax) {
		saveHistory();
	}
}
function ns() {
	if (myEditor.av != "EDIT") {
		return;
	}
	if (bX.oJ) {
		if ((bX.oJ.style.width != bX.w) || (bX.oJ.style.height != bX.h)) {
			saveHistory();
		}
	}
	eH();
}
function lE() {
	if (myEditor.av != "EDIT") {
		return true;
	}
	if (!myHistory.ax) {
		saveHistory();
	}
	var Q = D().selection.createRange();
	var aE = D().selection.type;
	if (aE == "Control") {
		var A = Q.item(0);
		if (A.tagName == "IMG") {
			A.src = hX(A.getAttribute("src", 2));
		}
	}
	if (aE == "Text") {
		var gF = D().body.getElementsByTagName("IMG");
		var aK = D().body.createTextRange();
		for (var i = 0; i < gF.length; i++) {
			aK.moveToElementText(gF[i]);
			if (Q.inRange(aK)) {
				gF[i].src = hX(gF[i].getAttribute("src", 2));
			}
		}
	}
	saveHistory();
	return true;
}
function hH() {
	var gF = D().body.getElementsByTagName("IMG");
	for (var i = 0; i < gF.length; i++) {
		gF(i).src = hX(gF(i).getAttribute("src", 2));
	}
}
function hX(url) {
	if (url.indexOf("://") < 0) {
		return url;
	}
	var gx = fh();
	if (url.indexOf(gx) < 0) {
		return url;
	}
	switch (config.BaseUrl) {
	  case "0":
		var eE;
		eE = gx + config.BaseHref;
		if (url.toLowerCase().indexOf(eE.toLowerCase()) == 0) {
			return url.substr(eE.length);
		}
		eE = gx + myEditor.RootPath + "/";
		if (url.toLowerCase().indexOf(eE.toLowerCase()) == 0) {
			return url.substr(eE.length);
		}
		return url;
		break;
	  case "1":
		return url.substr(gx.length);
		break;
	  case "2":
	  case "3":
		return url;
		break;
	}
}
function fh() {
	return document.location.protocol + "//" + document.location.host;
}
function jP() {
	var gh = document.getElementById("eWebEditor_Temp_HTML");
	gh.innerHTML = "";
	var ir = document.body.createTextRange();
	ir.moveToElementText(gh);
	ir.execCommand("Paste");
	var kT = gh.innerHTML;
	gh.innerHTML = "";
	return kT;
}
function insertHTML(html) {
	if (jA()) {
		return false;
	}
	aY();
	if (D().selection.type.toLowerCase() != "none") {
		D().selection.clear();
	}
	if (myEditor.av != "EDIT") {
		html = dv(html);
	}
	D().selection.createRange().pasteHTML(html);
	eH();
}
function setHTML(html, ms) {
	ContentEdit.value = html;
	switch (myEditor.av) {
	  case "CODE":
		D().designMode = "On";
		D().open();
		D().write(gI());
		D().body.innerText = html;
		D().close();
		D().body.contentEditable = "true";
		myEditor.IsEditMode = false;
		break;
	  case "EDIT":
		D().designMode = "On";
		D().open();
		D().write(gI() + hu(html) + "</body>");
		D().execCommand("2D-Position", true, true);
		D().execCommand("MultipleSelection", true, true);
		D().execCommand("LiveResize", true, true);
		D().close();
		if (config.FixWidth) {
			D().body.contentEditable = "false";
			D().getElementById("eWebEditor_FixWidth_Div").contentEditable = "true";
		} else {
			D().body.contentEditable = "true";
		}
		fW(gX);
		myEditor.IsEditMode = true;
		break;
	  case "TEXT":
		D().designMode = "On";
		D().open();
		D().write(gI());
		if (config.FixWidth) {
			eWebEditor_Temp_HTML.innerText = html;
			html = eWebEditor_Temp_HTML.innerHTML;
			D().body.innerHTML = hu(html);
		} else {
			D().body.innerText = html;
		}
		D().close();
		if (config.FixWidth) {
			D().body.contentEditable = "false";
			D().getElementById("eWebEditor_FixWidth_Div").contentEditable = "true";
		} else {
			D().body.contentEditable = "true";
		}
		myEditor.IsEditMode = false;
		break;
	  case "VIEW":
		D().designMode = "off";
		D().open();
		D().write(gI() + hu(html));
		D().close();
		if (config.FixWidth) {
			D().body.contentEditable = "false";
			D().getElementById("eWebEditor_FixWidth_Div").contentEditable = "false";
		} else {
			D().body.contentEditable = "false";
		}
		myEditor.IsEditMode = false;
		break;
	}
	D().body.onpaste = nx;
	D().body.onhelp = nr;
	D().body.ondragend = new Function("return lE();");
	D().onkeydown = new Function("return nl(eWebEditor.event);");
	D().onkeyup = new Function("return nm(eWebEditor.event);");
	D().oncontextmenu = new Function("return on(eWebEditor.event);");
	D().onmousedown = new Function("return nn();");
	D().onmouseup = new Function("return ns();");
	if ((config.ShowBorder != "0") && myEditor.IsEditMode) {
		config.ShowBorder = "0";
		hM();
	}
	if (!ms) {
		saveHistory();
	}
}
function getHTML() {
	var html;
	if ((myEditor.av == "EDIT") || (myEditor.av == "VIEW")) {
		iX();
		if (config.FixWidth) {
			html = D().getElementById("eWebEditor_FixWidth_DIV").innerHTML;
		} else {
			html = D().body.innerHTML;
		}
		html = iQ(html);
	} else {
		html = D().body.innerText;
	}
	if (myEditor.av != "TEXT") {
		if ((html.toLowerCase() == "<p>&nbsp;</p>") || (html.toLowerCase() == "<p></p>")) {
			html = "";
		}
	}
	return html;
}
function appendHTML(html) {
	if (jA()) {
		return false;
	}
	if (myEditor.av == "EDIT") {
		D().body.innerHTML += html;
	} else {
		D().body.innerText += html;
	}
}
function jH() {
	if (!cE()) {
		return;
	}
	aY();
	if (!myHistory.ax) {
		saveHistory();
	}
	var bo = dv(clipboardData.getData("Text"));
	insertHTML(bo);
	saveHistory();
	aY();
}
function cE() {
	if (myEditor.av == "EDIT") {
		return true;
	}
	alert(lang["MsgOnlyInEditMode"]);
	aY();
	return false;
}
function jA() {
	if (myEditor.av == "VIEW") {
		alert(lang["MsgCanotSetInViewMode"]);
		return true;
	}
	return false;
}
function al(af, opt) {
	if (!cE()) {
		return;
	}
	aY();
	if (!myHistory.ax) {
		saveHistory();
	}
	if (opt == "RemoveFormat") {
		af = opt;
		opt = null;
	}
	if (opt == null) {
		var s = "";
		switch (af.toLowerCase()) {
		  case "justifyleft":
			s = "left";
			break;
		  case "justifycenter":
			s = "center";
			break;
		  case "justifyright":
			s = "right";
			break;
		  case "justifyfull":
			s = "justify";
			break;
		}
		var b = false;
		if (s == "left" || s == "center" || s == "right") {
			var G = D().selection.createRange();
			G.type = D().selection.type;
			if (G.type == "Control") {
				var A = G.item(0);
				try {
					if (s == "center") {
						A.align = "";
						A.style.display = "block";
						A.style.margin = "0px auto";
						A.style.textAlign = s;
					} else {
						A.align = s;
						A.style.display = "";
						A.style.margin = "";
						A.style.textAlign = "";
					}
					b = true;
				}
				catch (e) {
				}
			}
		}
		if (!b) {
			if ((af.toLowerCase() == "selectall") && (config.FixWidth)) {
				jT();
			} else {
				D().execCommand(af);
			}
			if (s) {
				var G = D().selection.createRange();
				var p = ja("P");
				if (!p) {
					p = ja("DIV");
				}
				if (p) {
					p.style.textAlign = s;
					if (s == "justify") {
						p.style.textJustify = "inter-ideograph";
					} else {
						p.style.textJustify = "";
					}
				}
			}
		}
	} else {
		D().execCommand(af, "", opt);
	}
	saveHistory();
	aY();
	eH();
}
function jT() {
	var r = D().body.createTextRange();
	r.moveToElementText(D().getElementById("eWebEditor_FixWidth_DIV"));
	r.select();
}
function jJ(af) {
	aY();
	var G = D().selection;
	if (G.type != "Text") {
		return;
	}
	if (!myHistory.ax) {
		saveHistory();
	}
	var K = G.createRange();
	var r = D().body.createTextRange();
	var jX = 0;
	while (r.compareEndPoints("StartToStart", K) < 0) {
		r.moveStart("character", 1);
		jX++;
	}
	var dk = 0;
	while (r.compareEndPoints("EndToEnd", K) > 0) {
		r.moveEnd("character", -1);
		dk--;
	}
	var a = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"];
	var l, u, hy, hF;
	for (var i = 0; i < 26; i++) {
		l = a[i];
		u = a[i].toUpperCase();
		switch (af) {
		  case "uppercase":
			hy = l;
			hF = u;
			break;
		  case "lowercase":
			hy = u;
			hF = l;
			break;
		}
		r = K.duplicate();
		while (r.findText(hy, 0, 4)) {
			r.text = hF;
			r = K.duplicate();
		}
	}
	r = D().body.createTextRange();
	r.moveStart("character", jX);
	r.moveEnd("character", dk);
	r.select();
	saveHistory();
}
function dU(af, v) {
	aY();
	var gr = D().selection.type.toLowerCase();
	if (gr != "text") {
		return;
	}
	if (!myHistory.ax) {
		saveHistory();
	}
	var r = D().selection.createRange();
	var bk = r.getBookmark();
	D().execCommand("fontname", "", "eWebEditor_Temp_FontName");
	var hi = D().body.getElementsByTagName("FONT");
	var P = new Array();
	for (var i = 0; i < hi.length; i++) {
		var ck = hi[i];
		if (ck.getAttribute("face") == "eWebEditor_Temp_FontName") {
			P[P.length] = hi[i];
		}
	}
	for (var i = 0; i < P.length; i++) {
		var ck = P[i];
		jR(ck, af);
		hl(ck);
		iY(ck, af, v);
		ck.removeAttribute("face");
		var db = ck.parentElement;
		if (db.tagName == "FONT") {
			js(db);
		}
		if ((db.tagName == "FONT") || (db.tagName == "SPAN")) {
			if (db.innerText == ck.innerText) {
				db.style.cssText = db.style.cssText + ";" + ck.style.cssText;
				db.innerHTML = ck.innerHTML;
				continue;
			}
		}
	}
	r.moveToBookmark(bk);
	r.select();
	saveHistory();
}
function jL(B, af, v) {
	try {
		switch (af) {
		  case "face":
			B.style.fontFamily = v;
			break;
		  case "size":
			B.style.fontSize = v;
			break;
		  case "color":
			B.style.color = v;
			break;
		  default:
			break;
		}
	}
	catch (e) {
	}
}
function jR(B, af) {
	jL(B, af, "");
	var be = B.children;
	for (var j = 0; j < be.length; j++) {
		jR(be[j], af);
		if (be[j].tagName == "FONT") {
			js(be[j]);
		}
	}
}
function iY(B, af, v) {
	jL(B, af, v);
	var be = B.children;
	for (var j = 0; j < be.length; j++) {
		if ((be[j].tagName == "SPAN") || (be[j].tagName == "FONT")) {
			iY(be[j], af, v);
		}
	}
}
function hl(B) {
	var be = B.children;
	for (var j = 0; j < be.length; j++) {
		hl(be[j]);
		if ((be[j].tagName == "FONT") || (be[j].tagName == "SPAN")) {
			if ((be[j].style.cssText == "") || (be[j].innerHTML == "")) {
				be[j].removeNode(false);
				hl(B);
				return;
			}
		}
	}
}
function js(el) {
	if (el.style.fontFamily == "") {
		var s = el.getAttribute("face");
		if (s) {
			el.style.fontFamily = s;
		}
	}
	el.removeAttribute("face");
	if (el.style.fontSize == "") {
		var s = el.getAttribute("size");
		s = jN(s);
		if (s) {
			el.style.fontSize = s;
		}
	}
	el.removeAttribute("size");
	if (el.style.color == "") {
		var s = el.getAttribute("color");
		if (s) {
			el.style.color = s;
		}
	}
	el.removeAttribute("color");
}
function jN(s) {
	var r;
	switch (s + "") {
	  case "1":
		r = "8pt";
		break;
	  case "2":
		r = "10pt";
		break;
	  case "3":
		r = "12pt";
		break;
	  case "4":
		r = "14pt";
		break;
	  case "5":
		r = "18pt";
		break;
	  case "6":
		r = "24pt";
		break;
	  case "7":
		r = "36pt";
		break;
	  default:
		r = "";
		break;
	}
	return r;
}
function setMode(bx) {
	if (bx == myEditor.av) {
		return;
	}
	if (!myBrowser.IsCompatible) {
		if ((bx == "CODE") || (bx == "EDIT") || (bx == "VIEW")) {
			alert(lang["MsgNotCompatibleHtml"]);
			return false;
		}
	}
	if (bx == "TEXT") {
		if (myEditor.av == ModeEdit.value) {
			if (!confirm(lang["MsgHtmlToText"])) {
				return false;
			}
		}
	}
	var aP = "";
	switch (myEditor.av) {
	  case "CODE":
		if (bx == "TEXT") {
			eWebEditor_Temp_HTML.innerHTML = D().body.innerText;
			aP = eWebEditor_Temp_HTML.innerText;
		} else {
			aP = D().body.innerText;
			aP = iP(aP);
		}
		break;
	  case "TEXT":
		aP = D().body.innerText;
		aP = dv(aP);
		break;
	  case "EDIT":
	  case "VIEW":
		if (bx == "TEXT") {
			aP = D().body.innerText;
		} else {
			iX();
			if (config.FixWidth) {
				aP = D().getElementById("eWebEditor_FixWidth_DIV").innerHTML;
			} else {
				aP = D().body.innerHTML;
			}
			aP = iQ(aP);
		}
		break;
	  default:
		aP = ContentEdit.value;
		if (bx == "EDIT" || bx == "VIEW") {
			aP = iP(aP);
		}
		break;
	}
	try {
		document.getElementById("eWebEditor_CODE").className = "SB_Mode_BtnOff";
	}
	catch (e) {
	}
	try {
		document.getElementById("eWebEditor_EDIT").className = "SB_Mode_BtnOff";
	}
	catch (e) {
	}
	try {
		document.getElementById("eWebEditor_TEXT").className = "SB_Mode_BtnOff";
	}
	catch (e) {
	}
	try {
		document.getElementById("eWebEditor_VIEW").className = "SB_Mode_BtnOff";
	}
	catch (e) {
	}
	try {
		document.getElementById("eWebEditor_" + bx).className = "SB_Mode_BtnOn";
	}
	catch (e) {
	}
	myEditor.av = bx;
	ModeEdit.value = bx;
	setHTML(aP);
	var oTR = document.getElementById("eWebEditor_ToolarTR");
	if (bx == "EDIT") {
		oTR.style.display = "";
	} else {
		oTR.style.display = "none";
	}
}
function lh(B) {
	if (B) {
		B.disabled = (!myEditor.IsEditMode);
		for (var i = 0; i < B.children.length; i++) {
			lh(B.children[i]);
		}
	}
}
function ad(url, mL) {
	if (url.indexOf(".") < 0) {
		url = url + ".htm";
	}
	url = "dialog/" + url;
	url = url.toLowerCase();
	if (mL) {
		if (!cE()) {
			return;
		}
	}
	aY();
	if (!myHistory.ax) {
		saveHistory();
	}
	var P = showModalDialog(url, window, "dialogWidth:0px;dialogHeight:0px;help:no;scroll:no;status:no");
	saveHistory();
	aY();
	eH();
}
function lk() {
	if (!cE()) {
		return;
	}
	saveHistory();
	window.open("dialog/fullscreen.htm?style=" + myParam.StyleName, "FullScreen", "toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbars=yes,resizable=yes,fullscreen=yes");
}
function op() {
	if (!cE()) {
		return;
	}
	if (D().selection.type == "Control") {
		var dD = D().selection.createRange();
		if (dD(0).tagName.toUpperCase() != "IMG") {
			alert(lang["MsgHylnkLimit"]);
			return;
		}
	}
	ad("hyperlink.htm", true);
}
function dv(text) {
	if (text == null) {
		return "";
	}
	text = text.replace(/&/g, "&amp;");
	text = text.replace(/\"/g, "&quot;");
	text = text.replace(/</g, "&lt;");
	text = text.replace(/>/g, "&gt;");
	text = text.replace(/\n/g, "<br>");
	return text;
}
function kV(text) {
	if (text == null) {
		return "";
	}
	text = text.replace(/&quot;/g, "\"");
	text = text.replace(/&lt;/g, "<");
	text = text.replace(/&gt;/g, ">");
	text = text.replace(/&amp;/g, "&");
	return text;
}
function insert(af) {
	if (!cE()) {
		return;
	}
	aY();
	saveHistory();
	var G = D().selection.createRange();
	switch (af) {
	  case "nowdate":
		var d = new Date();
		insertHTML(d.toLocaleDateString());
		break;
	  case "nowtime":
		var d = new Date();
		insertHTML(d.toLocaleTimeString());
		break;
	  case "br":
		insertHTML("<br>");
		break;
	  case "code":
		insertHTML("<table width=95% border=\"0\" align=\"Center\" cellpadding=\"6\" cellspacing=\"0\" style=\"border: 1px Dotted #CCCCCC; TABLE-LAYOUT: fixed\"><tr><td bgcolor=#FDFDDF style=\"WORD-WRAP: break-word\"><font style=\"color: #990000;font-weight:bold\">" + lang["HtmlCode"] + "</font><br>" + dv(G.text) + "</td></tr></table>");
		break;
	  case "quote":
		insertHTML("<table width=95% border=\"0\" align=\"Center\" cellpadding=\"6\" cellspacing=\"0\" style=\"border: 1px Dotted #CCCCCC; TABLE-LAYOUT: fixed\"><tr><td bgcolor=#F3F3F3 style=\"WORD-WRAP: break-word\"><font style=\"color: #990000;font-weight:bold\">" + lang["HtmlQuote"] + "</font><br>" + dv(G.text) + "</td></tr></table>");
		break;
	  case "big":
		insertHTML("<big>" + G.text + "</big>");
		break;
	  case "small":
		insertHTML("<small>" + G.text + "</small>");
		break;
	  case "printbreak":
		insertHTML("<div style=\"FONT-SIZE: 1px; PAGE-BREAK-BEFORE: always; VERTICAL-ALIGN: middle; HEIGHT: 1px; BACKGROUND-COLOR: #c0c0c0\">&nbsp; </div>");
		break;
	  default:
		alert(lang["ErrParam"]);
		break;
	}
	G = null;
}
function hM() {
	if (!cE()) {
		return;
	}
	var hs = D().getElementsByTagName("FORM");
	var cH = D().body.getElementsByTagName("INPUT");
	var fT = D().body.getElementsByTagName("TABLE");
	var aS = D().body.getElementsByTagName("A");
	for (a = 0; a < hs.length; a++) {
		if (config.ShowBorder == "0") {
			hs[a].runtimeStyle.border = "1px dotted #FF0000";
		} else {
			hs[a].runtimeStyle.cssText = "";
		}
	}
	for (b = 0; b < cH.length; b++) {
		if (config.ShowBorder == "0") {
			if (cH[b].type.toUpperCase() == "HIDDEN") {
				cH[b].runtimeStyle.border = "1px dashed #000000";
				cH[b].runtimeStyle.width = "15px";
				cH[b].runtimeStyle.height = "15px";
				cH[b].runtimeStyle.backgroundColor = "#FDADAD";
				cH[b].runtimeStyle.color = "#FDADAD";
			}
		} else {
			if (cH[b].type.toUpperCase() == "HIDDEN") {
				cH[b].runtimeStyle.cssText = "";
			}
		}
	}
	for (i = 0; i < fT.length; i++) {
		if (config.ShowBorder == "0") {
			fT[i].runtimeStyle.border = "1px dotted #BFBFBF";
		} else {
			fT[i].runtimeStyle.cssText = "";
		}
		ar = fT[i].rows;
		for (y = 0; y < ar.length; y++) {
			dO = ar[y].cells;
			for (x = 0; x < dO.length; x++) {
				if (config.ShowBorder == "0") {
					dO[x].runtimeStyle.border = "1px dotted #BFBFBF";
				} else {
					dO[x].runtimeStyle.cssText = "";
				}
			}
		}
	}
	for (a = 0; a < aS.length; a++) {
		if (config.ShowBorder == "0") {
			if (aS[a].href.toUpperCase() == "") {
				aS[a].runtimeStyle.borderBottom = "1px dashed #000000";
			}
		} else {
			aS[a].runtimeStyle.cssText = "";
		}
	}
	if (config.ShowBorder == "0") {
		config.ShowBorder = "1";
	} else {
		config.ShowBorder = "0";
	}
	oe();
}
function oe() {
	eWebEditor.scrollBy(0, 0);
}
var gX = 100;
var cQ = new Array(10, 25, 50, 75, 100, 150, 200, 500);
function fW(size) {
	D().body.runtimeStyle.zoom = size + "%";
	gX = size;
}
function jb() {
	ad("findreplace.htm", true);
}
function lI() {
	var cS = null;
	var hZ = D().selection.type;
	if (hZ != "Control") {
		return;
	}
	var fH = D().selection.createRange();
	for (var i = 0; i < fH.length; i++) {
		cS = fH.item(i);
		if (cS.style.position != "relative") {
			cS.style.position = "relative";
		} else {
			cS.style.position = "static";
		}
	}
}
function zIndex(action) {
	var cS = null;
	var hZ = D().selection.type;
	if (hZ != "Control") {
		return;
	}
	var fH = D().selection.createRange();
	for (var i = 0; i < fH.length; i++) {
		cS = fH.item(i);
		if (action == "forward") {
			cS.style.zIndex += 1;
		} else {
			cS.style.zIndex -= 1;
		}
		cS.style.position = "relative";
	}
}
function hG(tag, attrName, kt) {
	if (tag) {
		var G = D().selection;
		if (G.type == "Control") {
			var K = G.createRange();
			var el = K(0);
			if (el.tagName.toUpperCase() == tag) {
				if ((attrName) && (kt)) {
					if (el.getAttribute(attrName, 2).toLowerCase() == kt.toLowerCase()) {
						return true;
					}
				} else {
					return true;
				}
			}
		}
	}
	return false;
}
function kD() {
	var K = D().selection.createRange();
	var el = K(0);
	return el.getAttribute("eWebEditorFake", 2);
}
function ja(tag) {
	var el = null;
	if (D().selection.type != "Control") {
		el = D().selection.createRange().parentElement();
		while (el.tagName.toUpperCase() != tag) {
			el = el.parentElement;
			if (el == null) {
				break;
			}
		}
	}
	return el;
}
function eq(size) {
	if (!myBrowser.IsCompatible) {
		alert(lang["MsgNotCompatibleFunc"]);
		return false;
	}
	for (var i = 0; i < parent.frames.length; i++) {
		if (parent.frames[i].document == self.document) {
			var B = parent.frames[i].frameElement;
			var height = parseInt(B.offsetHeight);
			if (height + size >= 300) {
				B.height = height + size;
			}
			break;
		}
	}
}
function jF() {
	if (!cE()) {
		return;
	}
	saveHistory();
	var b = false;
	if (D().selection.type == "Control") {
		var dD = D().selection.createRange();
		if (dD(0).tagName.toUpperCase() == "IMG") {
			b = true;
		}
	}
	if (!b) {
		alert(lang["MsgMapLimit"]);
		return;
	}
	window.open("dialog/map.htm", "jF" + myParam.LinkField, "toolbar=no,location=no,directories=no,status=not,menubar=no,scrollbars=no,resizable=yes,width=450,height=300");
}
function ny() {
	if (!cE()) {
		return;
	}
	aY();
	if (!hn("P")) {
		alert(lang["MsgNotParagraph"]);
		return;
	}
	ad("paragraph.htm", true);
}
function hn(tag) {
	var G = D().selection.createRange();
	G.type = D().selection.type;
	if (G.type != "Control") {
		var fq = D().body;
		var cU = fq.getElementsByTagName(tag);
		var ai = new Array();
		var aK = fq.createTextRange();
		for (var i = 0; i < cU.length; i++) {
			aK.moveToElementText(cU(i));
			if (G.inRange(aK)) {
				ai[ai.length] = cU[i];
			} else {
				if (((G.compareEndPoints("StartToEnd", aK) < 0) && (G.compareEndPoints("StartToStart", aK) > 0)) || ((G.compareEndPoints("EndToStart", aK) > 0) && (G.compareEndPoints("EndToEnd", aK) < 0))) {
					ai[ai.length] = cU[i];
				}
			}
		}
		if (ai.length > 0) {
			return true;
		}
	}
	return false;
}
function addUploadFile(nf, nJ, nI) {
	hb(myParam.LinkOriginalFileName, nf);
	hb(myParam.LinkSaveFileName, nJ);
	hb(myParam.LinkSavePathFileName, nI);
}
function hb(iJ, iF) {
	if (iF == "") {
		return;
	}
	if (iJ) {
		var dA = parent.document.getElementsByName(iJ)[0];
		if (dA) {
			if (dA.value != "") {
				dA.value = dA.value + "|";
			}
			dA.value = dA.value + iF;
			dA.fireEvent("onchange");
		}
	}
}
function iR(cl, html) {
	cl.value = html;
	if (config.ServerExt != "asp") {
		return;
	}
	var gZ = cl.name;
	var mR = cl.form;
	var gO = cl.document;
	var oK = 50000;
	for (var i = 1; i < gO.getElementsByName(gZ).length; i++) {
		gO.getElementsByName(gZ)[i].value = "";
	}
	if (html.length > oK) {
		cl.value = html.substr(0, oK);
		html = html.substr(oK);
		while (html.length > 0) {
			var hf = gO.createElement("<TEXTAREA NAME='" + gZ + "'></TEXTAREA>");
			hf.style.display = "none";
			hf.value = html.substr(0, oK);
			mR.appendChild(hf);
			html = html.substr(oK);
		}
	}
}
var hj;
function remoteUpload(lJ) {
	if (config.AutoRemote != "1") {
		return;
	}
	if (myEditor.av == "TEXT") {
		return;
	}
	hj = lJ;
	var cl = document.getElementsByName("eWebEditor_UploadText")[0];
	iR(cl, getHTML());
	jc(lang["MsgRemoteUploading"]);
	eWebEditor_UploadForm.submit();
}
function remoteUploadOK() {
	divProcessing.style.display = "none";
	if (myEditor.LinkField) {
		if (hj) {
			eval("parent." + hj);
		}
	}
}
function nM() {
	if (myEditor.av == "TEXT") {
		return;
	}
	if (!bY(true)) {
		return;
	}
	jc(lang["MsgLocalUploading"]);
	var bt = getHTML();
	eWebEditorActiveX.LocalUpload(bt);
	window.setTimeout("jG()", 100);
}
function jG() {
	if (eWebEditorActiveX.Status != "ok") {
		window.setTimeout("jG()", 100);
		return;
	}
	if (cO()) {
		divProcessing.style.display = "none";
		return;
	}
	var cv = eWebEditorActiveX.OriginalFiles;
	var dm = eWebEditorActiveX.SavedFiles;
	if (cv) {
		var bP = cv.split("|");
		var aQ = dm.split("|");
		for (var i = 0; i < bP.length; i++) {
			if (aQ[i]) {
				var dJ = bP[i];
				var dP = aQ[i].substr(aQ[i].lastIndexOf("/") + 1);
				var dQ = aQ[i];
				addUploadFile(dJ, dP, dQ);
			}
		}
	}
	var bt = eWebEditorActiveX.Body;
	setHTML(bt, true);
	eWebEditorActiveX = null;
	divProcessing.style.display = "none";
}
function jc(msg) {
	nc.innerHTML = msg;
	divProcessing.style.top = (document.body.clientHeight - parseFloat(divProcessing.style.height)) / 2;
	divProcessing.style.left = (document.body.clientWidth - parseFloat(divProcessing.style.width)) / 2;
	divProcessing.style.display = "";
}
var myHistory = new Object;
myHistory.data = [];
myHistory.position = 0;
myHistory.cu = [];
myHistory.ax = false;
function saveHistory() {
	myHistory.ax = true;
	var html = getHTML();
	if (myHistory.data[myHistory.position] != html) {
		var mH = myHistory.data.length;
		var mU = myHistory.data.length - myHistory.position;
		for (var i = 1; i < mU; i++) {
			myHistory.data.pop();
			myHistory.cu.pop();
		}
		myHistory.data[myHistory.data.length] = html;
		if (D().selection.type != "Control") {
			try {
				myHistory.cu[myHistory.cu.length] = D().selection.createRange().getBookmark();
			}
			catch (e) {
				myHistory.cu[myHistory.cu.length] = "";
			}
		} else {
			var nd = D().selection.createRange();
			var el = nd.item(0);
			myHistory.cu[myHistory.cu.length] = "[object]|" + el.tagName + "|" + kF(el);
		}
		if (mH != 0) {
			myHistory.position++;
		}
	}
}
function kF(el) {
	var gF = D().body.getElementsByTagName(el.tagName);
	for (var i = 0; i < gF.length; i++) {
		if (gF[i] == el) {
			return i;
		}
	}
	return null;
}
function mf() {
	myHistory.data.length = 0;
	myHistory.cu.length = 0;
	myHistory.position = 0;
	myHistory.ax = false;
}
function ey(value) {
	if (!myHistory.ax) {
		saveHistory();
	}
	if (value == -1) {
		if (myHistory.position > 0) {
			myHistory.position = myHistory.position - 1;
			setHTML(myHistory.data[myHistory.position], true);
			jO();
		}
	} else {
		if (myHistory.position < myHistory.data.length - 1) {
			myHistory.position = myHistory.position + 1;
			setHTML(myHistory.data[myHistory.position], true);
			jO();
		}
	}
	aY();
	eH();
}
function jO() {
	var hP = myHistory.cu[myHistory.position];
	if (hP) {
		eWebEditor_Layout.focus();
		if (hP.substring(0, 8) != "[object]") {
			r = D().body.createTextRange();
			if (r.moveToBookmark(myHistory.cu[myHistory.position])) {
				r.select();
			}
		} else {
			if (myEditor.av == "EDIT") {
				r = D().body.createControlRange();
				var a = hP.split("|");
				var gF = D().body.getElementsByTagName(a[1]);
				var el = gF[a[2]];
				r.addElement(el);
				r.select();
			}
		}
	}
}
function gI() {
	var ds = "<head>";
	ds += "<link href='" + myEditor.RootPath + "/skin/" + config.Skin + "/editorarea.css' type='text/css' rel='stylesheet'>";
	switch (myEditor.av) {
	  case "CODE":
		ds += "<link href='" + myEditor.RootPath + "/skin/" + config.Skin + "/editorarea.code.css' type='text/css' rel='stylesheet'>";
		break;
	  case "TEXT":
		ds += "<link href='" + myEditor.RootPath + "/skin/" + config.Skin + "/editorarea.text.css' type='text/css' rel='stylesheet'>";
		break;
	  case "EDIT":
	  case "VIEW":
		if (config.AreaCssMode != "1") {
			ds += "<link href='" + myEditor.RootPath + "/skin/" + config.Skin + "/editorarea.edit.css' type='text/css' rel='stylesheet'>";
		}
		ds += myEditor.ExtCSS;
		break;
	}
	ds += myEditor.BaseHref + "</head>";
	var cd = "<body>";
	if ((config.FixWidth) && (myEditor.av != "CODE")) {
		cd = "<body class='eWebEditor_FixWidth_BODY'>";
	}
	return ds + cd;
}
function getCount(gL) {
	var H = getText();
	H = H.replace(/\n/g, "");
	H = H.replace(/\r/g, "");
	var l = H.length;
	var n = 0;
	for (var i = 0; i < l; i++) {
		if (H.charCodeAt(i) < 0 || H.charCodeAt(i) > 255) {
			if (gL != 0) {
				n++;
				if (gL == 3) {
					n++;
				}
			}
		} else {
			if (gL != 1) {
				n++;
			}
		}
	}
	return n;
}
function getText() {
	var s = getHTML();
	if (myEditor.av != "TEXT") {
		eWebEditor_Temp_HTML.innerHTML = s;
		s = eWebEditor_Temp_HTML.innerText;
	}
	return s;
}
function nU() {
	try {
		var na = new ActiveXObject("ieSpell.ieSpellExtension");
		na.CheckAllLinkedDocuments(D());
	}
	catch (exception) {
		if (confirm(lang["MsgIeSpellDownload"])) {
			window.open("http://www.iespell.com/download.php", "IeSpellDownload");
		}
	}
}
var iu, ak, iM, il, dc;
var myMenu = new Object();
function nN() {
	iM = "<table border=0 cellpadding=0 cellspacing=0 class='Menu_Box' id=Menu_Box><tr><td class='Menu_Box'><table border=0 cellpadding=0 cellspacing=0 class='Menu_Table'>";
	ak = "<tr><td class='Menu_Sep'><table border=0 cellpadding=0 cellspacing=0 class='Menu_Sep'><tr><td></td></tr></table></td></tr>";
	il = "</table></td></tr></table>";
	iu = "<head>" + "<link href='" + myEditor.RootPath + "/skin/" + config.Skin + "/menuarea.css' type='text/css' rel='stylesheet'>" + "</head>" + "<body scroll='no' onConTextMenu='event.returnValue=false;' ondragstart='event.returnValue=false;' onselectstart='event.returnValue=false;' onselect='event.returnValue=false;'>";
	dc = window.createPopup();
	var doc = dc.document;
	doc.open();
	doc.write(iu);
	doc.close();
}
function cV(am, mD, gm, mv) {
	var dy = "";
	if (am == "") {
		dy += "<tr><td class='Menu_Item'><table border=0 cellpadding=0 cellspacing=0 width='100%'><tr><td valign=middle class=MouseOut onMouseOver=\"this.className='MouseOver'\" onMouseOut=\"this.className='MouseOut'\" onclick=\"parent." + mD + ";parent.dc.hide();\">";
	} else {
		dy += "<tr><td class='Menu_Item'><table border=0 cellpadding=0 cellspacing=0 width='100%'><tr><td valign=middle class=MouseDisabled>";
	}
	am = (am) ? "_Disabled" : "";
	dy += "<table border=0 cellpadding=0 cellspacing=0><tr><td class=Menu_Image_TD>";
	if (typeof (gm) == "number") {
		var cA = "skin/" + config.Skin + "/buttons.gif";
		var fc = 16 - gm * 16;
		dy += "<div class='Menu_Image" + am + "'><img src='" + cA + "' style='top:" + fc + "px'></div>";
	} else {
		if (gm != "") {
			var cA = "skin/" + config.Skin + "/" + gm;
			dy += "<img class='Menu_Image" + am + "' src='" + cA + "'>";
		}
	}
	dy += "</td><td class='Menu_Label" + am + "'>" + mv + "</td></tr></table>";
	dy += "</td></tr></TABLE></td></tr>";
	return dy;
}
function F(am, aG, fF) {
	var co = Buttons[aG];
	if (!fF) {
		fF = lang[aG];
	} else {
		fF = lang[fF];
	}
	return cV(am, co[1], co[0], fF);
}
function ao(aG, bS) {
	var am = "";
	if (!bS) {
		bS = aG;
	}
	if (!D().queryCommandEnabled(bS)) {
		am = "disabled";
	}
	return F(am, aG);
}
function eo(af) {
	var aZ = "";
	var am = "disabled";
	switch (af) {
	  case "TableInsert":
		if (!gi()) {
			am = "";
		}
		aZ += F(am, "TableInsert");
		break;
	  case "TableProp":
		if (gi() || bf()) {
			am = "";
		}
		aZ += F(am, "TableProp");
		break;
	  case "TableCell":
		if (bf()) {
			am = "";
		}
		aZ += F(am, "TableCellProp");
		aZ += F(am, "TableCellSplit");
		aZ += ak;
		aZ += F(am, "TableRowProp");
		aZ += F(am, "TableRowInsertAbove");
		aZ += F(am, "TableRowInsertBelow");
		aZ += F(am, "TableRowMerge");
		aZ += F(am, "TableRowSplit");
		aZ += F(am, "TableRowDelete");
		aZ += ak;
		aZ += F(am, "TableColInsertLeft");
		aZ += F(am, "TableColInsertRight");
		aZ += F(am, "TableColMerge");
		aZ += F(am, "TableColSplit");
		aZ += F(am, "TableColDelete");
		break;
	}
	return aZ;
}
function on(event) {
	if (!myEditor.IsEditMode) {
		return false;
	}
	var C = "";
	C += ao("Cut");
	C += ao("Copy");
	C += F("", "Paste");
	C += ao("Delete");
	C += ao("SelectAll");
	C += ak;
	if (bf()) {
		C += eo("TableProp");
		C += eo("TableCell");
		C += ak;
	}
	if (hG("TABLE")) {
		C += eo("TableProp");
		C += ak;
	}
	if (hG("IMG")) {
		if (!kD()) {
			C += F("", "Image", "CMenuImg");
			C += ak;
			C += F("", "zIndexForward");
			C += F("", "zIndexBackward");
			C += ak;
		}
	}
	if (hG("OBJECT", "classid", "clsid:d27cdb6e-ae6d-11cf-96b8-444553540000")) {
		C += F("", "Flash", "CMenuFlash");
		C += ak;
	}
	if (hn("P")) {
		C += F("", "ParagraphAttr", "CMenuParagraph");
		C += ak;
	}
	C += F("", "FindReplace");
	myMenu.x = event.clientX;
	myMenu.y = event.clientY;
	myMenu.ew = 0;
	myMenu.html = C;
	myMenu.rel = D().body;
	myMenu.show();
	return false;
}
function bj(menu) {
	if (!myEditor.IsEditMode) {
		return false;
	}
	aY();
	var C = "";
	switch (menu) {
	  case "font":
		C += ao("Bold");
		C += ao("Italic");
		C += ao("UnderLine");
		C += ao("StrikeThrough");
		C += ak;
		C += ao("SuperScript");
		C += ao("SubScript");
		C += ak;
		C += F("", "UpperCase");
		C += F("", "LowerCase");
		C += ak;
		C += F("", "ForeColor");
		C += F("", "BackColor");
		C += ak;
		C += F("", "Big");
		C += F("", "Small");
		break;
	  case "paragraph":
		C += ao("JustifyLeft");
		C += ao("JustifyCenter");
		C += ao("JustifyRight");
		C += ao("JustifyFull");
		C += ak;
		C += ao("OrderedList", "insertorderedlist");
		C += ao("UnOrderedList", "insertunorderedlist");
		C += ao("Indent");
		C += ao("Outdent");
		C += ak;
		C += ao("Paragraph", "insertparagraph");
		C += F("", "BR");
		C += ak;
		C += F((hn("P")) ? "" : "disabled", "ParagraphAttr", "CMenuParagraph");
		break;
	  case "edit":
		var am = "";
		if (myHistory.data.length <= 1 || myHistory.position <= 0) {
			am = "disabled";
		}
		C += F(am, "UnDo");
		if (myHistory.position >= myHistory.data.length - 1 || myHistory.data.length == 0) {
			am = "disabled";
		}
		C += F(am, "ReDo");
		C += ak;
		C += ao("Cut");
		C += ao("Copy");
		C += F("", "Paste");
		C += F("", "PasteText");
		C += F("", "PasteWord");
		C += ak;
		C += ao("Delete");
		C += ao("RemoveFormat");
		C += ak;
		C += ao("SelectAll");
		C += ao("UnSelect");
		C += ak;
		C += F("", "FindReplace");
		C += F("", "QuickFormat");
		break;
	  case "object":
		C += F("", "BgColor");
		C += F("", "BackImage");
		C += ak;
		C += F("", "absolutePosition");
		C += F("", "zIndexForward");
		C += F("", "zIndexBackward");
		C += ak;
		C += F("", "ShowBorders");
		C += ak;
		C += F("", "Quote");
		C += F("", "Code");
		break;
	  case "component":
		C += F("", "Image");
		C += F("", "Flash");
		C += F("", "Media");
		C += F("", "File");
		C += ak;
		C += F("", "RemoteUpload");
		C += F("", "LocalUpload");
		C += ak;
		C += F("", "Fieldset");
		C += F("", "Iframe");
		C += ao("HorizontalRule", "InsertHorizontalRule");
		C += F("", "Marquee");
		C += ak;
		C += F("", "CreateLink");
		C += F("", "Anchor");
		C += F("", "Map");
		C += ao("Unlink");
		break;
	  case "tool":
		C += F("", "Template");
		C += F("", "Symbol");
		C += F("", "Excel");
		C += F("", "Emot");
		C += ak;
		C += F("", "EQ");
		C += F("", "Art");
		C += ak;
		C += F("", "NowDate");
		C += F("", "NowTime");
		C += ak;
		C += F("", "ImportWord");
		C += F("", "ImportExcel");
		C += F("", "Capture");
		C += ak;
		C += F("", "Pagination");
		C += F("", "PaginationInsert");
		break;
	  case "file":
		C += F("", "Refresh");
		C += ak;
		C += F("", "ModeCode");
		C += F("", "ModeEdit");
		C += F("", "ModeText");
		C += F("", "ModeView");
		C += ak;
		C += F("", "SizePlus");
		C += F("", "SizeMinus");
		C += ak;
		C += F("", "Print");
		C += ak;
		C += F("", "About");
		C += F("", "Site");
		height = 208;
		break;
	  case "table":
		C += eo("TableInsert");
		C += eo("TableProp");
		C += ak;
		C += eo("TableCell");
		break;
	  case "form":
		C += ao("FormText", "InsertInputText");
		C += ao("FormTextArea", "InsertTextArea");
		C += ao("FormRadio", "InsertInputRadio");
		C += ao("FormCheckbox", "InsertInputCheckbox");
		C += ao("FormDropdown", "InsertSelectDropdown");
		C += ao("FormButton", "InsertButton");
		break;
	  case "gallery":
		C += F("", "GalleryImage");
		C += F("", "GalleryFlash");
		C += F("", "GalleryMedia");
		C += F("", "GalleryFile");
		break;
	  case "zoom":
		for (var i = 0; i < cQ.length; i++) {
			if (cQ[i] == gX) {
				C += cV("", "fW(" + cQ[i] + ")", 120, cQ[i] + "%");
			} else {
				C += cV("", "fW(" + cQ[i] + ")", 119, cQ[i] + "%");
			}
		}
		break;
	  case "fontsize":
		var v = nv();
		for (var i = 0; i < lang["FontSizeItem"].length; i++) {
			if (lang["FontSizeItem"][i][0] == v) {
				C += cV("", "dU('size','" + lang["FontSizeItem"][i][0] + "')", 120, lang["FontSizeItem"][i][1]);
			} else {
				C += cV("", "dU('size','" + lang["FontSizeItem"][i][0] + "')", 119, lang["FontSizeItem"][i][1]);
			}
		}
		break;
	  case "fontname":
		var v = D().queryCommandValue("FontName");
		for (var i = 0; i < lang["FontNameItem"].length; i++) {
			if (lang["FontNameItem"][i] == v) {
				C += cV("", "dU('face','" + lang["FontNameItem"][i] + "')", 120, lang["FontNameItem"][i]);
			} else {
				C += cV("", "dU('face','" + lang["FontNameItem"][i] + "')", 119, lang["FontNameItem"][i]);
			}
		}
		break;
	  case "formatblock":
		var v = D().queryCommandValue("FormatBlock");
		if (v) {
			v = v.toLowerCase();
		} else {
			v = "";
		}
		for (var i = 0; i < lang["FormatBlockItem"].length; i++) {
			if (lang["FormatBlockItem"][i][0].toLowerCase() == v) {
				C += cV("", "al('FormatBlock','" + lang["FormatBlockItem"][i][0] + "')", 120, lang["FormatBlockItem"][i][1]);
			} else {
				C += cV("", "al('FormatBlock','" + lang["FormatBlockItem"][i][0] + "')", 119, lang["FormatBlockItem"][i][1]);
			}
		}
		break;
	}
	var e = event.srcElement;
	var x = event.clientX - event.offsetX;
	var y = event.clientY - event.offsetY;
	if (e.style.top) {
		y = y - parseInt(e.style.top);
	}
	if (e.tagName.toLowerCase() == "img") {
		e = e.parentNode;
		x = x - e.offsetLeft - e.clientLeft;
		y = y - e.offsetTop - e.clientTop;
	}
	if (e.className == "TB_Btn_Image") {
		e = e.parentNode;
		x = x - e.offsetLeft - e.clientLeft;
		y = y - e.offsetTop - e.clientTop;
	}
	y = y + e.offsetHeight;
	var ew = parseInt(e.offsetWidth);
	myMenu.x = x;
	myMenu.y = y;
	myMenu.ew = ew;
	myMenu.html = C;
	myMenu.rel = document.body;
	myMenu.show();
	aY();
	return false;
}
myMenu.show = function () {
	var doc = dc.document;
	doc.body.innerHTML = iM + this.html + il;
	dc.show(0, 0, 0, 0, this.rel);
	this.jn();
};
myMenu.jn = function () {
	var iB = dc.document;
	if (!this.mF()) {
		window.setTimeout("myMenu.jn()", 50);
		return;
	}
	var w = iB.body.scrollWidth;
	var h = iB.body.scrollHeight;
	if (this.x + w > document.body.clientWidth) {
		this.x = this.x - w + this.ew;
	}
	dc.show(this.x, this.y, w, h, this.rel);
};
myMenu.mF = function () {
	var doc = dc.document;
	if (doc.readyState != "complete" && doc.readyState != "interactive") {
		return false;
	}
	if (doc.images) {
		for (var i = 0; i < doc.images.length; i++) {
			var img = doc.images[i];
			if (img.readyState != "complete") {
				return false;
			}
		}
	}
	return true;
};
function nv() {
	var v = "";
	if (D().selection.type != "Control") {
		var G = D().selection.createRange();
		var aK = D().body.createTextRange();
		var el = G.parentElement();
		v = el.style.fontSize;
		var gF = el.childNodes;
		for (var i = 0; i < gF.length; i++) {
			if (gF[i].nodeType == 1) {
				aK.moveToElementText(gF[i]);
				if (((G.compareEndPoints("StartToEnd", aK) < 0) && (G.compareEndPoints("StartToStart", aK) > 0)) || ((G.compareEndPoints("EndToStart", aK) > 0) && (G.compareEndPoints("EndToEnd", aK) < 0))) {
					if (gF[i].style.fontSize != v) {
						v = "";
						break;
					}
				}
			}
		}
	}
	return v;
}
var az;
var aB;
var ix;
var bI;
function nY() {
	if (!gi()) {
		ad("table.htm", true);
	}
}
function nZ() {
	if (gi() || bf()) {
		ad("table.htm?action=modify", true);
	}
}
function nR() {
	if (bf()) {
		ad("tablecell.htm", true);
	}
}
function nV() {
	if (bf()) {
		ad("tablecellsplit.htm", true);
	}
}
function mu() {
	if (bf()) {
		ad("tablecell.htm?action=row", true);
	}
}
function mx() {
	if (!bf()) {
		return;
	}
	if (!myHistory.ax) {
		saveHistory();
	}
	var cn = 0;
	bQ = aB.cells;
	for (var i = 0; i < bQ.length; i++) {
		cn = cn + bQ[i].getAttribute("colSpan");
	}
	var fJ = bI.insertRow(aB.rowIndex);
	for (i = 0; i < cn; i++) {
		bG = fJ.insertCell();
		bG.innerHTML = "&nbsp;";
		if (config.ShowBorder == "yes") {
			bG.runtimeStyle.border = "1px dotted #BFBFBF";
		}
	}
	saveHistory();
}
function my() {
	if (!bf()) {
		return;
	}
	if (!myHistory.ax) {
		saveHistory();
	}
	var cn = 0;
	bQ = aB.cells;
	for (var i = 0; i < bQ.length; i++) {
		cn = cn + bQ[i].getAttribute("colSpan");
	}
	var fJ = bI.insertRow(aB.rowIndex + 1);
	for (i = 0; i < cn; i++) {
		bG = fJ.insertCell();
		bG.innerHTML = "&nbsp;";
		if (config.ShowBorder == "yes") {
			bG.runtimeStyle.border = "1px dotted #BFBFBF";
		}
	}
	saveHistory();
}
function mz() {
	if (!bf()) {
		return;
	}
	if (!myHistory.ax) {
		saveHistory();
	}
	var rowSpanTD = az.getAttribute("rowSpan");
	ar = bI.rows;
	if (aB.rowIndex + 1 != ar.length) {
		var mi = ar[aB.rowIndex + az.rowSpan].cells;
		var hw = mi[az.cellIndex].getAttribute("rowSpan");
		var moveTo = az.rowSpan;
		if (!hw) {
			hw = 1;
		}
		az.rowSpan = az.rowSpan + hw;
		ar[aB.rowIndex + moveTo].deleteCell(az.cellIndex);
	}
	saveHistory();
}
function iT(jY) {
	if (!bf()) {
		return;
	}
	if (jY < 2) {
		return;
	}
	if (!myHistory.ax) {
		saveHistory();
	}
	var mh = jY - 1;
	var hv = mh;
	var fn = 0;
	for (var i = 0; i < az.cellIndex; i++) {
		fn += aB.cells[i].colSpan;
	}
	var ar = bI.rows;
	while (az.rowSpan > 1 && hv > 0) {
		var gY = ar[aB.rowIndex + az.rowSpan - 1];
		az.rowSpan -= 1;
		var fe = 0;
		var position = -1;
		for (var n = 0; n < gY.cells.length; n++) {
			fe += gY.cells[n].getAttribute("colSpan");
			if (fe > fn) {
				position = n;
				break;
			}
		}
		var bG = gY.insertCell(position);
		bG.innerHTML = "&nbsp;";
		if (config.ShowBorder == "yes") {
			bG.runtimeStyle.border = "1px dotted #BFBFBF";
		}
		hv -= 1;
	}
	for (var n = 0; n < hv; n++) {
		var cn = 0;
		bQ = aB.cells;
		for (var i = 0; i < bQ.length; i++) {
			cn = cn + bQ[i].getAttribute("colSpan");
		}
		var fJ = bI.insertRow(aB.rowIndex + 1);
		for (var j = 0; j < aB.rowIndex; j++) {
			for (var k = 0; k < ar[j].cells.length; k++) {
				if ((ar[j].cells[k].rowSpan > 1) && (ar[j].cells[k].rowSpan >= aB.rowIndex - ar[j].rowIndex + 1)) {
					ar[j].cells[k].rowSpan += 1;
				}
			}
		}
		for (i = 0; i < bQ.length; i++) {
			if (i != az.cellIndex) {
				aB.cells[i].rowSpan += 1;
			} else {
				bG = fJ.insertCell();
				bG.colSpan = az.colSpan;
				bG.innerHTML = "&nbsp;";
				if (config.ShowBorder == "yes") {
					bG.runtimeStyle.border = "1px dotted #BFBFBF";
				}
			}
		}
	}
	saveHistory();
}
function nk() {
	if (!bf()) {
		return;
	}
	if (!myHistory.ax) {
		saveHistory();
	}
	bI.deleteRow(aB.rowIndex);
	saveHistory();
}
function ob() {
	if (!bf()) {
		return;
	}
	if (!myHistory.ax) {
		saveHistory();
	}
	moveFromEnd = (aB.cells.length - 1) - (az.cellIndex);
	ar = bI.rows;
	for (i = 0; i < ar.length; i++) {
		rowCount = ar[i].cells.length - 1;
		position = rowCount - moveFromEnd;
		if (position < 0) {
			position = 0;
		}
		bz = ar[i].insertCell(position);
		bz.innerHTML = "&nbsp;";
		if (config.ShowBorder == "yes") {
			bz.runtimeStyle.border = "1px dotted #BFBFBF";
		}
	}
	saveHistory();
}
function oc() {
	if (!bf()) {
		return;
	}
	if (!myHistory.ax) {
		saveHistory();
	}
	moveFromEnd = (aB.cells.length - 1) - (az.cellIndex);
	ar = bI.rows;
	for (i = 0; i < ar.length; i++) {
		rowCount = ar[i].cells.length - 1;
		position = rowCount - moveFromEnd;
		if (position < 0) {
			position = 0;
		}
		bz = ar[i].insertCell(position + 1);
		bz.innerHTML = "&nbsp;";
		if (config.ShowBorder == "yes") {
			bz.runtimeStyle.border = "1px dotted #BFBFBF";
		}
	}
	saveHistory();
}
function nX() {
	if (!bf()) {
		return;
	}
	if (!myHistory.ax) {
		saveHistory();
	}
	var nb = az.getAttribute("colSpan");
	bQ = aB.cells;
	if (az.cellIndex + 1 != aB.cells.length) {
		var mg = bQ[az.cellIndex + 1].getAttribute("colSpan");
		az.colSpan = nb + mg;
		aB.deleteCell(az.cellIndex + 1);
	}
	saveHistory();
}
function oa() {
	if (!bf()) {
		return;
	}
	if (!myHistory.ax) {
		saveHistory();
	}
	moveFromEnd = (aB.cells.length - 1) - (az.cellIndex);
	ar = bI.rows;
	for (var i = 0; i < ar.length; i++) {
		oQ = ar[i].cells.length - 1;
		position = oQ - moveFromEnd;
		if (position < 0) {
			position = 0;
		}
		dO = ar[i].cells;
		if (dO[position].colSpan > 1) {
			dO[position].colSpan = dO[position].colSpan - 1;
		} else {
			ar[i].deleteCell(position);
		}
	}
	saveHistory();
}
function iS(kf) {
	if (!bf()) {
		return;
	}
	if (kf < 2) {
		return;
	}
	if (!myHistory.ax) {
		saveHistory();
	}
	var ml = kf - 1;
	var gE = ml;
	var bz;
	var fn = 0;
	var he = 0;
	for (var i = 0; i < az.cellIndex; i++) {
		fn += aB.cells[i].colSpan;
		if (aB.cells[i].rowSpan > 1) {
			he += 1;
		}
	}
	var ar = bI.rows;
	while (az.colSpan > 1 && gE > 0) {
		bz = aB.insertCell(az.cellIndex + 1);
		bz.innerHTML = "&nbsp;";
		if (config.ShowBorder == "yes") {
			bz.runtimeStyle.border = "1px dotted #BFBFBF";
		}
		az.colSpan -= 1;
		gE -= 1;
	}
	for (i = 0; i < ar.length; i++) {
		var fe = 0;
		var position = -1;
		for (var n = 0; n < ar[i].cells.length; n++) {
			fe += ar[i].cells[n].getAttribute("colSpan");
			if (fe + he > fn) {
				position = n;
				break;
			}
		}
		if (aB.rowIndex != i) {
			if (position != -1) {
				ar[i].cells[position + he].colSpan += gE;
			}
		} else {
			for (var n = 0; n < gE; n++) {
				bz = ar[i].insertCell(az.cellIndex + 1);
				bz.innerHTML = "&nbsp;";
				bz.rowSpan = az.rowSpan;
				if (config.ShowBorder == "yes") {
					bz.runtimeStyle.border = "1px dotted #BFBFBF";
				}
			}
		}
	}
	saveHistory();
}
function gi() {
	if (D().selection.type == "Control") {
		var dD = D().selection.createRange();
		if (dD(0).tagName.toUpperCase() == "TABLE") {
			bI = D().selection.createRange()(0);
			return true;
		}
	}
	return false;
}
function bf() {
	if (D().selection.type != "Control") {
		var el = D().selection.createRange().parentElement();
		while (el.tagName.toUpperCase() != "TD" && el.tagName.toUpperCase() != "TH") {
			el = el.parentElement;
			if (el == null) {
				break;
			}
		}
		if (el) {
			az = el;
			aB = az.parentElement;
			ix = aB.parentElement;
			bI = ix.parentElement;
			return true;
		}
	}
	return false;
}
function og(url) {
	if (url.indexOf("://") >= 0) {
		return url;
	}
	if (url.substr(0, 1) == "/") {
		return url;
	}
	var fY = myEditor.RootPath;
	while (url.substr(0, 3) == "../") {
		url = url.substr(3);
		fY = fY.substring(0, fY.lastIndexOf("/"));
	}
	return fY + "/" + url;
}
function fO(url) {
	document.write("<scr" + "ipt type=\"text/javascript\" src=\"" + url + "\" onerror=\"alert('Error loading ' + this.src);\"></scr" + "ipt>");
}
function nS() {
	if (!config.L) {
		document.write("<table style='width:100%;height:100%;border-collapse:collapse' borderColor=#999999 bgColor=#ffffff border=1><tr><td align=center style='font-size:9pt'>eWebEditor!<br><br>" + lang["ErrLicense"] + "</td></tr></table>");
		return;
	}
	document.write("<table id=eWebEditor_Layout border=0 cellpadding=0 cellspacing=0 width='100%' height='100%'>");
	document.write("<tr id='eWebEditor_ToolarTR' style='display:none'><td>");
	nT();
	document.write("</td></tr>");
	document.write("<tr><td height='100%'>");
	document.write("\t<input type='hidden' ID='ContentEdit' value=''>");
	document.write("\t<input type='hidden' ID='ModeEdit' value=''>");
	document.write("\t<input type='hidden' ID='ContentLoad' value=''>");
	document.write("\t<input type='hidden' ID='ContentFlag' value='0'>");
	document.write("\t<input type='hidden' ID='PaginationTitle' value=''>");
	document.write("\t<iframe class='Composition' ID='eWebEditor' style='width:100%;height:100%' marginwidth=1 marginheight=1 scrolling='yes' frameborder='0' src='" + config.HttpBlankUrl + "'></iframe>");
	document.write("</td></tr>");
	if (config.StateFlag) {
		document.write("<tr><td class=SB>");
		document.write("\t<TABLE border='0' cellPadding='0' cellSpacing='0' width='100%' class=SB>");
		document.write("\t<TR valign=middle>");
		document.write("\t<td>");
		document.write("\t\t<table border=0 cellpadding=0 cellspacing=0 class=SB_Mode>");
		document.write("\t\t<tr>");
		document.write("\t\t<td class=SB_Mode_Left></td>");
		if (config.SBCode) {
			document.write("\t\t<td class=SB_Mode_BtnOff id=eWebEditor_CODE onclick=\"setMode('CODE')\" unselectable=on><table border=0 cellpadding=0 cellspacing=0><tr><td class=SB_Mode_Btn_Img>" + eR("ModeCode") + "</td><td class=SB_Mode_Btn_Text>" + lang["StatusModeCode"] + "</td></tr></table></td>");
			document.write("\t\t<td class=SB_Mode_Sep></td>");
		}
		if (config.SBEdit) {
			document.write("\t\t<td class=SB_Mode_BtnOff id=eWebEditor_EDIT onclick=\"setMode('EDIT')\" unselectable=on><table border=0 cellpadding=0 cellspacing=0><tr><td class=SB_Mode_Btn_Img>" + eR("ModeEdit") + "</td><td class=SB_Mode_Btn_Text>" + lang["StatusModeEdit"] + "</td></tr></table></td>");
			document.write("\t\t<td class=SB_Mode_Sep></td>");
		}
		if (config.SBText) {
			document.write("\t\t<td class=SB_Mode_BtnOff id=eWebEditor_TEXT onclick=\"setMode('TEXT')\" unselectable=on><table border=0 cellpadding=0 cellspacing=0><tr><td class=SB_Mode_Btn_Img>" + eR("ModeText") + "</td><td class=SB_Mode_Btn_Text>" + lang["StatusModeText"] + "</td></tr></table></td>");
			document.write("\t\t<td class=SB_Mode_Sep></td>");
		}
		if (config.SBView) {
			document.write("\t\t<td class=SB_Mode_BtnOff id=eWebEditor_VIEW onclick=\"setMode('VIEW')\" unselectable=on><table border=0 cellpadding=0 cellspacing=0><tr><td class=SB_Mode_Btn_Img>" + eR("ModeView") + "</td><td class=SB_Mode_Btn_Text>" + lang["StatusModeView"] + "</td></tr></table></td>");
		}
		document.write("\t\t</tr>");
		document.write("\t\t</table>");
		document.write("\t</td>");
		if (myParam.FullScreen != "1" && config.SBSize) {
			document.write("\t<td align=right>");
			document.write("\t\t<table border=0 cellpadding=0 cellspacing=0 class=SB_Size>");
			document.write("\t\t<tr>");
			document.write("\t\t<td class=SB_Size_Btn onclick='eq(300)' title='" + lang["SizePlus"] + "'>" + eR("SizePlus") + "</td>");
			document.write("\t\t<td class=SB_Size_Sep></td>");
			document.write("\t\t<td class=SB_Size_Btn onclick='eq(-300)' title='" + lang["SizeMinus"] + "'>" + eR("SizeMinus") + "</td>");
			document.write("\t\t<td class=SB_Size_Right></td>");
			document.write("\t\t</tr>");
			document.write("\t\t</table>");
			document.write("\t</td>");
		}
		document.write("\t</TR>");
		document.write("\t</Table>");
		document.write("</td></tr>");
	}
	document.write("</table>");
	document.write("<div id='eWebEditor_Temp_HTML' style='visibility:hidden;overflow:hidden;position:absolute;width:1px;height:1px'></div>");
	document.write("<div style='position:absolute;display:none'>");
	document.write("<form id='eWebEditor_UploadForm' action='" + config.ServerExt + "/upload." + config.ServerExt + "?action=remote&type=remote&style=" + myParam.StyleName + "&cusdir=" + myParam.CusDir + "&skey=" + myParam.SKey + "' method='post' target='eWebEditor_UploadTarget'>");
	document.write("<input type='hidden' name='eWebEditor_UploadText'>");
	document.write("</form>");
	document.write("<iframe name='eWebEditor_UploadTarget' width=0 height=0 src='" + config.HttpBlankUrl + "'></iframe>");
	document.write("</div>");
	document.write("<div id=divProcessing style='width:200px;height:30px;position:absolute;display:none'>");
	document.write("<table border=0 cellpadding=0 cellspacing=1 bgcolor='#000000' width='100%' height='100%'><tr><td bgcolor=#3A6EA5><marquee id='nc' align='middle' behavior='alternate' scrollamount='5' style='font-size:9pt;color:#ffffff'></marquee></td></tr></table>");
	document.write("</div>");
}
function nT() {
	var result = "<table border=0 cellpadding=0 cellspacing=0 width='100%' id='eWebEditor_Toolbar' unselectable>";
	for (var i = 0; i < config.Toolbars.length; i++) {
		result += "<tr><td class=TB_Left></td><td class=TB_Center><table border=0 cellpadding=0 cellspacing=0><tr>";
		var tb = config.Toolbars[i];
		for (var j = 0; j < tb.length; j++) {
			var aG = tb[j];
			if ((aG == "Maximize") && (myParam.FullScreen == "1")) {
				aG = "Minimize";
			}
			var co = Buttons[aG];
			if (aG == "TBSep") {
				result += "<td class=TB_Btn_Padding><div class='TB_Sep'></div></td>";
			} else {
				if (co[3] == 0) {
					result += "<td class=TB_Btn_Padding><div class='TB_Btn' name='TB_Name_" + aG + "' title=\"" + lang[aG] + "\" onclick=\"" + co[1] + "\">";
					if (typeof (co[0]) == "number") {
						var cA = "skin/" + config.Skin + "/buttons.gif";
						var fc = 16 - co[0] * 16;
						result += "<div class='TB_Btn_Image'><img src='" + cA + "' style='top:" + fc + "px'></div>";
					} else {
						var cA = "skin/" + config.Skin + "/" + co[0];
						result += "<img class='TB_Btn_Image' src='" + cA + "'>";
					}
					result += "</div></td>";
				} else {
					if (co[3] == 1) {
						var fi = "";
						var cY = "";
						switch (aG) {
						  case "FontName":
							fi = " style='width:115px'";
							for (var k = 0; k < lang[aG + "Item"].length; k++) {
								cY += "<option value='" + lang[aG + "Item"][k] + "'>" + lang[aG + "Item"][k] + "</option>";
							}
							break;
						  case "FontSize":
							fi = " style='width:55px'";
							for (var k = 0; k < lang[aG + "Item"].length; k++) {
								cY += "<option value='" + lang[aG + "Item"][k][0] + "'>" + lang[aG + "Item"][k][1] + "</option>";
							}
							break;
						  case "FormatBlock":
							fi = " style='width:90px'";
							for (var k = 0; k < lang[aG + "Item"].length; k++) {
								cY += "<option value='" + lang[aG + "Item"][k][0] + "'>" + lang[aG + "Item"][k][1] + "</option>";
							}
							break;
						  case "ZoomSelect":
							fi = " style='width:55px'";
							for (var k = 0; k < cQ.length; k++) {
								cY += "<option value='" + cQ[k] + "'>" + cQ[k] + "%</option>";
							}
							break;
						}
						result += "<td class=TB_Btn_Padding><select name='TB_Name_" + aG + "' onchange=\"" + co[1] + "\" size=1 " + fi + "><option selected>" + lang[aG] + "</option>" + cY + "</select></td>";
					}
				}
			}
		}
		result += "</tr></table></td><td class=TB_Right></td></tr>";
	}
	result += "</table>";
	document.write(result);
}
function eR(aG, oz) {
	var mG = Buttons[aG];
	var fc = 16 - mG[0] * 16;
	var cA = "skin/" + config.Skin + "/buttons.gif";
	return "<div><img src='" + cA + "' style='top:" + fc + "px'></div>";
}
function aY() {
	if ((myEditor.av != "CODE") && (config.FixWidth)) {
		if (document.activeElement.id != "eWebEditor") {
			eWebEditor.focus();
		}
		try {
			var K = D().selection.createRange();
			if (K.parentElement().tagName == "BODY") {
				D().getElementById("eWebEditor_FixWidth_DIV").focus();
			} else {
				K.select();
			}
		}
		catch (e) {
		}
	} else {
		eWebEditor.focus();
	}
}
var eWebEditorActiveX;
config.jf = 2400;
function bY(hO) {
	if (eWebEditorActiveX) {
		eWebEditorActiveX = null;
	}
	var b = false;
	try {
		eWebEditorActiveX = new ActiveXObject("eWebSoft.eWebEditorActiveX");
		var hE = eWebEditorActiveX.Version;
		if (parseFloat(hE.replace(/[^0123456789]+/gi, "")) >= config.jf) {
			eWebEditorActiveX.Lang = "zh-cn";
			eWebEditorActiveX.SendUrl = config.SendUrl;
			eWebEditorActiveX.LocalSize = config.AllowLocalSize;
			eWebEditorActiveX.LocalExt = config.AllowLocalExt;
			b = true;
		}
	}
	catch (e) {
	}
	if (!b && hO) {
		ad("installactivex.htm", true);
	}
	return b;
}
function cO() {
	var bR = eWebEditorActiveX.Error;
	if (bR != "") {
		var dG, dC;
		if (bR.indexOf(":") >= 0) {
			var a = bR.split(":");
			dG = a[0];
			dC = a[1];
		} else {
			dG = bR;
			dC = "";
		}
		switch (dG) {
		  case "L":
			alert(lang["ErrLicense"]);
			break;
		  case "InvalidFile":
			alert(lang["ErrInvalidFile"] + ":" + dC);
			break;
		  default:
			alert(bR);
		}
		return true;
	}
	return false;
}
function PaginationInsert() {
	if (config.PaginationMode == "0") {
		return false;
	}
	aY();
	var el = lS();
	if (!el) {
		insertHTML("</P><P id=eWebEditor_Temp_P>");
		var p = D().getElementById("eWebEditor_Temp_P");
		p.removeAttribute("id");
		er(p, "beforeBegin");
	} else {
		er(el, "afterEnd");
	}
}
function er(el, ij) {
	var ku = false;
	if (ij == "afterEnd" && (!el.nextSibling)) {
		ku = true;
	}
	var B = D().createElement("img");
	B.className = "eWebEditor_Pagination";
	B.setAttribute("eWebEditorFake", "pagination");
	el.insertAdjacentElement(ij, B);
	if (ku) {
		var p = D().createElement("p");
		el.parentElement.appendChild(p);
	}
}
function lS() {
	var el = null;
	var p = null;
	var K = D().selection.createRange();
	if (D().selection.type != "Control") {
		p = K.parentElement();
	} else {
		p = K(0);
	}
	return iW(p);
}
function iW(el) {
	var cb = null;
	if (config.FixWidth) {
		while (!((el.tagName.toUpperCase() == "DIV") && (el.getAttribute("id") == "eWebEditor_FixWidth_DIV"))) {
			cb = el;
			el = el.parentElement;
			if (el == null) {
				break;
			}
		}
	} else {
		while (el.tagName.toUpperCase() != "BODY") {
			cb = el;
			el = el.parentElement;
			if (el == null) {
				break;
			}
		}
	}
	return cb;
}
function jw(nQ) {
	if (config.PaginationMode == "0") {
		return false;
	}
	jz();
	var gP = parseInt(nQ);
	if (gP < 1) {
		return false;
	}
	if (getCount(2) <= gP) {
		return false;
	}
	if (!myEditor.IsEditMode) {
		setMode("EDIT");
	}
	var gK;
	if (config.FixWidth) {
		gK = D().getElementById("eWebEditor_FixWidth_DIV");
	} else {
		gK = D().body;
	}
	var ky = gK.childNodes;
	var l = 0;
	for (var i = 0; i < ky.length; i++) {
		var node = ky[i];
		if (node.nodeType == 1) {
			if (node.innerText) {
				var s = node.innerText;
				l += s.length;
			}
		} else {
			if (node.nodeType == 3) {
				l += node.length;
			}
		}
		if (l >= gP) {
			if (node.nextSibling) {
				if (node.nodeType == 1) {
					er(node, "afterEnd");
				} else {
					er(node.nextSibling, "beforeBegin");
				}
				l = 0;
			}
		}
	}
}
function jz() {
	if (config.PaginationMode == "0") {
		return text;
	}
	var gF = D().getElementsByTagName("IMG");
	for (var i = gF.length - 1; i >= 0; i--) {
		var el = gF[i];
		var bV = el.getAttribute("eWebEditorFake", 2);
		if (bV) {
			if (bV.toLowerCase() == "pagination") {
				el.removeNode(true);
			}
		}
	}
}
function iX() {
	if (config.PaginationMode == "0") {
		return false;
	}
	var gF = D().getElementsByTagName("IMG");
	for (var i = gF.length - 1; i >= 0; i--) {
		var el = gF[i];
		var bV = el.getAttribute("eWebEditorFake", 2);
		if (bV) {
			if (bV.toLowerCase() == "pagination") {
				var cb = iW(el);
				if (cb) {
					var b = false;
					if (cb.tagName == "DIV" || cb.tagName == "P") {
						if (cb.innerText == "") {
							b = true;
							er(cb, "beforeBegin");
							cb.removeNode(true);
						}
					}
					if (!b) {
						er(cb, "afterEnd");
						el.removeNode(true);
					}
				}
			}
		}
	}
}
function iQ(html) {
	if (config.PaginationMode == "0") {
		return html;
	}
	var bi = html;
	var a = html.split(/<img [^>]*?eWebEditorFake=\"pagination\"[^>]*?>/gi);
	if (a.length > 1) {
		if (config.PaginationMode == "1") {
			bi = "";
			var fg = document.getElementById("PaginationTitle").value.split("\r\n");
			for (var i = 0; i < a.length; i++) {
				var bF = "";
				if (fg[i]) {
					bF = dv(fg[i]);
				}
				bi += "<!--ewebeditor:page title=\"" + bF + "\"-->\r\n";
				bi += a[i] + "\r\n";
				bi += "<!--/ewebeditor:page-->\r\n\r\n";
			}
		} else {
			bi = a[0];
			for (var i = 1; i < a.length; i++) {
				bi += "\r\n" + config.PaginationKey + "\r\n" + a[i];
			}
		}
	}
	return bi;
}
function iP(html) {
	if (config.PaginationMode == "0") {
		return html;
	}
	var bi = "";
	var bF = "";
	if (config.PaginationMode == "1") {
		bi = "";
		var U = /<!--ewebeditor:page title=\"([^\">]*)\"-->((?:[^a]|a)+?)<!--\/ewebeditor:page-->/gi;
		var m;
		var fD = 0;
		while ((m = U.exec(html)) != null) {
			fD++;
			bF += kV(m[1]) + "\r\n";
			if (bi != "") {
				bi += "<img class=\"eWebEditor_Pagination\" eWebEditorFake=\"pagination\">";
			}
			bi += m[2];
		}
		if (fD == 0) {
			bi = html;
		}
	} else {
		var U = new RegExp(config.PaginationKey.replace(/([\[\]\{\}\.\(\)\*\+\?])/gi, "\\$1"), "gi");
		bi = html.replace(U, "<img class=\"eWebEditor_Pagination\" eWebEditorFake=\"pagination\">");
	}
	document.getElementById("PaginationTitle").value = bF;
	return bi;
}
function kL() {
	if (myBrowser.IsIE7 || !myBrowser.IsIE6) {
		return "";
	} else {
		return "javascript: '';";
	}
}


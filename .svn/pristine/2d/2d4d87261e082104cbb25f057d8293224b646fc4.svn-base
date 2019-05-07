var is_editable = true;
var inlinePopup = [ {
		popup_id : "area_search_replace",
		icon_id : "search"
	}, {
		popup_id : "edit_area_help",
		icon_id : "help"
	} ];
var last_selection = {};
var tab_nb_char = 6;
var tabulation = "";
for ( var i = 0; i < tab_nb_char; i++)
	tabulation += " ";
var EA_keys = {
	8 : "Retour arriere",
	9 : "Tabulation",
	12 : "Milieu(pave numerique)",
	13 : "Entrer",
	16 : "Shift",
	17 : "Ctrl",
	18 : "Alt",
	19 : "Pause",
	20 : "Verr Maj",
	27 : "Esc",
	32 : "Space",
	33 : "Page up",
	34 : "Page down",
	35 : "End",
	36 : "Begin",
	37 : "Left",
	38 : "Up",
	39 : "Right",
	40 : "Down",
	44 : "Impr ecran",
	45 : "Inser",
	46 : "Suppr",
	91 : "Menu Demarrer Windows / touche pomme Mac",
	92 : "Menu Demarrer Windows",
	93 : "Menu contextuel Windows",
	112 : "F1",
	113 : "F2",
	114 : "F3",
	115 : "F4",
	116 : "F5",
	117 : "F6",
	118 : "F7",
	119 : "F8",
	120 : "F9",
	121 : "F10",
	122 : "F11",
	123 : "F12",
	144 : "Verr Num",
	145 : "Arret defil"
};

function keyDown(e) {
	if (!e) {
		e = event;
	}
	var target_id = (e.target || e.srcElement).id;
	var use = false;
	if (EA_keys[e.keyCode])
		letter = EA_keys[e.keyCode];
	else
		letter = String.fromCharCode(e.keyCode);
	var low_letter = letter.toLowerCase();
	if (letter == "Page up" ) {
		
		use = true;
	} else if (letter == "Page down" ) {
		
		use = true;
	} else if (is_editable == false) {
		return true;
	} else if (letter == "Tabulation" && target_id == "SKDBMemo1"
			&& !CtrlPressed(e) && !AltPressed(e)) {
		if (ShiftPressed(e))
				{}
		else{}
			
		use = true;
		//if (eA.isOpera || (eA.isFirefox && eA.isMac))
			
	} else if (letter == "Entrer" && target_id == "SKDBMemo1") {
		
	} else if (letter == "Entrer" && target_id == "area_search") {
		area_search();
		use = true;
	} else if (letter == "Esc") {
		//close_all_inline_popup(e);
		use = true;
	} else if (CtrlPressed(e) && !AltPressed(e) && !ShiftPressed(e)) {
		switch (low_letter) {
		case "f":
			area_search();
			use = true;
			break;
		case "r":
			//eA.execCommand("area_replace");
			use = true;
			break;
		case "q":
			//eA.execCommand("close_all_inline_popup", e);
			use = true;
			break;
		case "h":
			//eA.execCommand("change_highlight");
			use = true;
			break;
		case "g":
			//setTimeout("eA.execCommand('go_to_line');", 5);
			use = true;
			break;
		case "e":
			//eA.execCommand("show_help");
			use = true;
			break;
		case "z":
			use = true;
			//eA.execCommand("undo");
			break;
		case "y":
			use = true;
			//eA.execCommand("redo");
			break;
		default:
			break;
		}
	}
	//if (eA.next.length > 0) {
	//	setTimeout("eA.check_redo();", 10);
	//}
	//setTimeout("eA.check_file_changes();", 10);
	if (use) {
		return false;
	}
	return true;
};












function AltPressed(e) {
	if (window.event) {
		return (window.event.altKey);
	} else {
		if (e.modifiers)
			return (e.altKey || (e.modifiers % 2));
		else
			return e.altKey;
	}
}
function CtrlPressed(e) {
	if (window.event) {
		return (window.event.ctrlKey);
	} else {
		return (e.ctrlKey || (e.modifiers == 2) || (e.modifiers == 3) || (e.modifiers > 5));
	}
}
function ShiftPressed(e) {
	if (window.event) {
		return (window.event.shiftKey);
	} else {
		return (e.shiftKey || (e.modifiers > 3));
	}
}


/**
²éÕÒÌæ»»º¯Êý
*/
function area_search(mode) {
	if (!mode)
		mode = "search";
	area_search_msg.innerHTML = "";
	var search = area_search.value;
	SKbillsheet.focus();
	//this.SKDBMemo1.textareaFocused = true;
	var infos = this.get_selection_infos();
	var start = infos["selectionStart"];
	var pos = -1;
	var pos_begin = -1;
	var length = search.length;
	if (area_search_replace.style.visibility != "visible") {
		//this.show_search();
		area_search_replace.style.visibility = "visible"
		return;
	}
	if (search.length == 0) {
		area_search_msg.innerHTML = this
				.get_translation("search_field_empty");
		return;
	}
	if (mode != "replace") {
		if (_$("area_search_reg_exp").checked)
			start++;
		else
			start += search.length;
	}
	if (_$("area_search_reg_exp").checked) {
		var opt = "m";
		if (!_$("area_search_match_case").checked)
			opt += "i";
		var reg = new RegExp(search, opt);
		pos = infos["full_text"].substr(start).search(reg);
		pos_begin = infos["full_text"].search(reg);
		if (pos != -1) {
			pos += start;
			length = infos["full_text"].substr(start).match(reg)[0].length;
		} else if (pos_begin != -1) {
			length = infos["full_text"].match(reg)[0].length;
		}
	} else {
		if (_$("area_search_match_case").checked) {
			pos = infos["full_text"].indexOf(search, start);
			pos_begin = infos["full_text"].indexOf(search);
		} else {
			pos = infos["full_text"].toLowerCase().indexOf(
					search.toLowerCase(), start);
			pos_begin = infos["full_text"].toLowerCase().indexOf(
					search.toLowerCase());
		}
	}
	if (pos == -1 && pos_begin == -1) {
		_$("area_search_msg").innerHTML = "<strong>" + search + "</strong> "
				+ this.get_translation("not_found");
		return;
	} else if (pos == -1 && pos_begin != -1) {
		begin = pos_begin;
		_$("area_search_msg").innerHTML = this
				.get_translation("restart_search_at_begin");
	} else
		begin = pos;
	if (mode == "replace" && pos == infos["indexOfCursor"]) {
		var replace = _$("area_replace").value;
		var new_text = "";
		if (_$("area_search_reg_exp").checked) {
			var opt = "m";
			if (!_$("area_search_match_case").checked)
				opt += "i";
			var reg = new RegExp(search, opt);
			new_text = infos["full_text"].substr(0, begin)
					+ infos["full_text"].substr(start).replace(reg, replace);
		} else {
			new_text = infos["full_text"].substr(0, begin) + replace
					+ infos["full_text"].substr(begin + length);
		}
		this.SKDBMemo1.value = new_text;
		this.area_select(begin, length);
		this.area_search();
	} else
		this.area_select(begin, length);
}
function area_replace() {
	area_search("replace");
}
function area_replace_all() {
	var base_text = SKDBMemo1.value;
	var search = area_search.value;
	var replace = area_replace.value;
	if (search.length == 0) {
		area_search_msg.innerHTML = get_translation("search_field_empty");
		return;
	}
	var new_text = "";
	var nb_change = 0;
	if (area_search_reg_exp.checked) {
		var opt = "mg";
		if (!area_search_match_case.checked)
			opt += "i";
		var reg = new RegExp(search, opt);
		nb_change = infos["full_text"].match(reg).length;
		new_text = infos["full_text"].replace(reg, replace);
	} else {
		if (area_search_match_case.checked) {
			var tmp_tab = base_text.split(search);
			nb_change = tmp_tab.length - 1;
			new_text = tmp_tab.join(replace);
		} else {
			var lower_value = base_text.toLowerCase();
			var lower_search = search.toLowerCase();
			var start = 0;
			var pos = lower_value.indexOf(lower_search);
			while (pos != -1) {
				nb_change++;
				new_text += this.SKDBMemo1.value.substring(start, pos) + replace;
				start = pos + search.length;
				pos = lower_value.indexOf(lower_search, pos + 1);
			}
			new_text += this.SKDBMemo1.value.substring(start);
		}
	}
	if (new_text == base_text) {
		area_search_msg.innerHTML = "<strong>" + search + "</strong> "
				+ this.get_translation("not_found");
	} else {
		this.SKDBMemo1.value = new_text;
		area_search_msg.innerHTML = "<strong>" + nb_change + "</strong> "
				+ this.get_translation("occurrence_replaced");
		setTimeout("SKDBMemo1.focus();SKDBMemo1.textareaFocused=true;", 100);
	}
}



function show_search() {
	if (area_search_replace.style.visibility == "visible") {
		this.hidden_search();
	} else {
		this.open_inline_popup("area_search_replace");
		var text = this.area_get_selection();
		var search = text.split("\n")[0];
		area_search.value = search;
		area_search.focus();
	}
}

function hidden_search() {
	this.close_inline_popup("area_search_replace");
}

//this.open_inline_popup("area_search_replace");
function open_inline_popup(popup_id) {
	this.close_all_inline_popup();
	var popup = popup_id;
	//var editor = _$("editor;
	for ( var i = 0; i < inlinePopup.length; i++) {
		if (inlinePopup[i]["popup_id"] == popup_id) {
			var icon = _$(inlinePopup[i]["icon_id"]);
			if (icon) {
				switchClassSticky(icon, 'editAreaButtonSelected', true);
				break;
			}
		}
	}
	popup.style.height = "auto";
	popup.style.overflow = "visible";
	if (document.body.offsetHeight < popup.offsetHeight) {
		popup.style.height = (document.body.offsetHeight - 10) + "px";
		popup.style.overflow = "auto";
	}
	if (!popup.positionned) {
		var new_left = editor.offsetWidth / 2 - popup.offsetWidth / 2;
		var new_top = editor.offsetHeight / 2 - popup.offsetHeight / 2;
		popup.style.left = new_left + "px";
		popup.style.top = new_top + "px";
		popup.positionned = true;
	}
	popup.style.visibility = "visible";
}
function replace_tab(text) {
	return text.replace(/((\n?)([^	\n]*)	)/gi, smartTab);
}
function get_selection_infos() {
	var sel = {}, start, end, len, str;
	getIESelection();
	start = SKDBMemo1.selectionStart;
	end = SKDBMemo1.selectionEnd;
	if (last_selection["selectionStart"] == start
			&& last_selection["selectionEnd"] == end
			&& last_selection["full_text"] == SKDBMemo1.value) {
		return last_selection;
	}
	if (tabulation != "	" && SKDBMemo1.value.indexOf("	") != -1) {
		len = SKDBMemo1.value.length;
		SKDBMemo1.value = replace_tab(SKDBMemo1.value);
		start = end = start + (SKDBMemo1.value.length - len);
		area_select(start, 0);
	}
	sel["selectionStart"] = start;
	sel["selectionEnd"] = end;
	sel["full_text"] = SKDBMemo1.value;
	sel["line_start"] = 1;
	sel["line_nb"] = 1;
	sel["curr_pos"] = 0;
	sel["curr_line"] = "";
	sel["indexOfCursor"] = 0;
	sel["selec_direction"] = last_selection["selec_direction"];
	var splitTab = sel["full_text"].split("\n");
	var nbLine = Math.max(0, splitTab.length);
	var nbChar = Math.max(0, sel["full_text"].length - (nbLine - 1));
	if (sel["full_text"].indexOf("\r") != -1)
		nbChar = nbChar - (nbLine - 1);
	sel["nb_line"] = nbLine;
	sel["nb_char"] = nbChar;
	if (start > 0) {
		str = sel["full_text"].substr(0, start);
		sel["curr_pos"] = start - str.lastIndexOf("\n");
		sel["line_start"] = Math.max(1, str.split("\n").length);
	} else {
		sel["curr_pos"] = 1;
	}
	if (end > start) {
		sel["line_nb"] = sel["full_text"].substring(start, end).split("\n").length;
	}
	sel["indexOfCursor"] = start;
	sel["curr_line"] = splitTab[Math.max(0, sel["line_start"] - 1)];
	if (sel["selectionStart"] == this.last_selection["selectionStart"]) {
		if (sel["selectionEnd"] > this.last_selection["selectionEnd"])
			sel["selec_direction"] = "down";
		else if (sel["selectionEnd"] == this.last_selection["selectionStart"])
			sel["selec_direction"] = this.last_selection["selec_direction"];
	} else if (sel["selectionStart"] == this.last_selection["selectionEnd"]
			&& sel["selectionEnd"] > this.last_selection["selectionEnd"]) {
		sel["selec_direction"] = "down";
	} else {
		sel["selec_direction"] = "up";
	}
	_$("nbLine").innerHTML = nbLine;
	_$("nbChar").innerHTML = nbChar;
	_$("linePos").innerHTML = sel["line_start"];
	_$("currPos").innerHTML = sel["curr_pos"];
	return sel;
}


function getIESelection() {
	var selectionStart, selectionEnd, range, stored_range;
	//SKDBMemo1.wrap = 'on';
	try {
		range = document.selection.createRange();
		stored_range = range.duplicate();
		stored_range.moveToElementText(SKDBMemo1);
		stored_range.setEndPoint('EndToEnd', range);
		if (stored_range.parentElement() != SKDBMemo1)
			throw "invalid focus";
		var scrollTop = result.scrollTop + document.body.scrollTop;
		var relative_top = range.offsetTop
				- parent.calculeOffsetTop(SKDBMemo1) + scrollTop;
		var line_start = Math.round((relative_top / this.lineHeight) + 1);
		var line_nb = Math.round(range.boundingHeight / this.lineHeight);
		selectionStart = stored_range.text.length - range.text.length;
		selectionStart += (line_start - SKDBMemo1.value.substr(0,
				selectionStart).split("\n").length) * 2;
		selectionStart -= (line_start - SKDBMemo1.value.substr(0,
				selectionStart).split("\n").length) * 2;
		selectionEnd = selectionStart + range.text.length;
		selectionEnd += (line_start + line_nb - 1 - SKDBMemo1.value.substr(
				0, selectionEnd).split("\n").length) * 2;
		SKDBMemo1.selectionStart = selectionStart;
		SKDBMemo1.selectionEnd = selectionEnd;
	} catch (e) {
	}
	//SKDBMemo1.wrap = 'soft';
}

function close_inline_popup(popup_id) {
	var popup = popup_id;
	for ( var i = 0; i < inlinePopup.length; i++) {
		if (inlinePopup[i]["popup_id"] == popup_id) {
			var icon = inlinePopup[i]["icon_id"];
			if (icon) {
				switchClassSticky(icon, 'editAreaButtonNormal', false);
				break;
			}
		}
	}
	popup.style.visibility = "hidden";
}
function close_all_inline_popup(e) {
	for ( var i = 0; i < this.inlinePopup.length; i++) {
		close_inline_popup(inlinePopup[i]["popup_id"]);
	}
	SKDBMemo1.focus();
}
function show_help() {
	this.open_inline_popup("edit_area_help");
}


function switchClassSticky(element, class_name, lock_state) {
	var lockChanged = false;
	if (typeof (lock_state) != "undefined" && element != null) {
		element.classLock = lock_state;
		lockChanged = true;
	}
	if (element != null && (lockChanged || !element.classLock)) {
		element.className = class_name;
		element.oldClassName = class_name;
	}
}

function smartTab() {
	val = "                   ";
	return smartTab.arguments[2]
			+ smartTab.arguments[3]
			+ val.substr(0, tab_nb_char
					- (smartTab.arguments[3].length)
					% tab_nb_char);
}


function area_select(start, length) {
	this.textarea.focus();
	start = Math.max(0, Math.min(SKDBMemo1.value.length, start));
	end = Math.max(start, Math.min(SKDBMemo1.value.length, start + length));
	
		SKDBMemo1.selectionStart = start;
		SKDBMemo1.selectionEnd = end;
		setIESelection();
		SKDBMemo1.setSelectionRange(start, end);
	}
	check_line_selection();
}
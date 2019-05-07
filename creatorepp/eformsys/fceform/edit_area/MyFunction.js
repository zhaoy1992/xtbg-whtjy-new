function EA() {
	var t = this;
	t.error = false;
	t.inlinePopup = [ {
		popup_id : "area_search_replace",
		icon_id : "search"
	}, {
		popup_id : "edit_area_help",
		icon_id : "help"
	} ];
	t.plugins = {};
	t.line_number = 0;
	parent.eAL.set_browser_infos(t);
	if (t.isIE >= 8)
		t.isIE = 7;
	t.last_selection = {};
	t.last_text_to_highlight = "";
	t.last_hightlighted_text = "";
	t.syntax_list = [];
	t.allready_used_syntax = {};
	t.check_line_selection_timer = 50;
	t.textareaFocused = false;
	t.highlight_selection_line = null;
	t.previous = [];
	t.next = [];
	t.last_undo = "";
	t.files = {};
	t.filesIdAssoc = {};
	t.curr_file = '';
	t.assocBracket = {};
	t.revertAssocBracket = {};
	t.assocBracket["("] = ")";
	t.assocBracket["{"] = "}";
	t.assocBracket["["] = "]";
	for ( var index in t.assocBracket) {
		t.revertAssocBracket[t.assocBracket[index]] = index;
	}
	t.is_editable = true;
	t.lineHeight = 16;
	t.tab_nb_char = 8;
	if (t.isOpera)
		t.tab_nb_char = 6;
	t.is_tabbing = false;
	t.fullscreen = {
		'isFull' : false
	};
	t.isResizing = false;
	t.id = area_id;
	t.settings = eAs[t.id]["settings"];
	if (("" + t.settings['replace_tab_by_spaces']).match(/^[0-9]+$/)) {
		t.tab_nb_char = t.settings['replace_tab_by_spaces'];
		t.tabulation = "";
		for ( var i = 0; i < t.tab_nb_char; i++)
			t.tabulation += " ";
	} else {
		t.tabulation = "	";
	}
	if (t.settings["syntax_selection_allow"]
			&& t.settings["syntax_selection_allow"].length > 0)
		t.syntax_list = t.settings["syntax_selection_allow"].replace(/ /g, "")
				.split(",");
	if (t.settings['syntax'])
		t.allready_used_syntax[t.settings['syntax']] = true;
};
EA.prototype.init = function() {
	var t = this, a, s = t.settings;
	t.textarea = _$("textarea");
	t.container = _$("container");
	t.result = _$("result");
	t.content_highlight = _$("content_highlight");
	t.selection_field = _$("selection_field");
	t.selection_field_text = _$("selection_field_text");
	t.processing_screen = _$("processing");
	t.editor_area = _$("editor");
	t.tab_browsing_area = _$("tab_browsing_area");
	t.test_font_size = _$("test_font_size");
	a = t.textarea;
	if (!s['is_editable'])
		t.set_editable(false);
	t.set_show_line_colors(s['show_line_colors']);
	if (syntax_selec = _$("syntax_selection")) {
		for ( var i = 0; i < t.syntax_list.length; i++) {
			var syntax = t.syntax_list[i];
			var option = document.createElement("option");
			option.value = syntax;
			if (syntax == s['syntax'])
				option.selected = "selected";
			option.innerHTML = t.get_translation("syntax_" + syntax, "word");
			syntax_selec.appendChild(option);
		}
	}
	spans = parent.getChildren(_$("toolbar_1"), "span", "", "", "all", -1);
	for ( var i = 0; i < spans.length; i++) {
		id = spans[i].id.replace(/tmp_tool_(.*)/, "$1");
		if (id != spans[i].id) {
			for ( var j in t.plugins) {
				if (typeof (t.plugins[j].get_control_html) == "function") {
					html = t.plugins[j].get_control_html(id);
					if (html != false) {
						html = t.get_translation(html, "template");
						var new_span = document.createElement("span");
						new_span.innerHTML = html;
						var father = spans[i].parentNode;
						spans[i].parentNode.replaceChild(new_span, spans[i]);
						break;
					}
				}
			}
		}
	}
	if (s["debug"]) {
		t.debug = parent.document.getElementById("edit_area_debug_" + t.id);
	}
	if (_$("redo") != null)
		t.switchClassSticky(_$("redo"), 'editAreaButtonDisabled', true);
	if (typeof (parent.eAL.syntax[s["syntax"]]) != "undefined") {
		for ( var i in parent.eAL.syntax) {
			if (typeof (parent.eAL.syntax[i]["styles"]) != "undefined") {
				t.add_style(parent.eAL.syntax[i]["styles"]);
			}
		}
	}
	if (t.isOpera)
		_$("editor").onkeypress = keyDown;
	else
		_$("editor").onkeydown = keyDown;
	for ( var i = 0; i < t.inlinePopup.length; i++) {
		if (t.isOpera)
			_$(t.inlinePopup[i]["popup_id"]).onkeypress = keyDown;
		else
			_$(t.inlinePopup[i]["popup_id"]).onkeydown = keyDown;
	}
	if (s["allow_resize"] == "both" || s["allow_resize"] == "x"
			|| s["allow_resize"] == "y")
		t.allow_resize(true);
	parent.eAL.toggle(t.id, "on");
	t.change_smooth_selection_mode(eA.smooth_selection);
	t.execCommand("change_highlight", s["start_highlight"]);
	t.set_font(eA.settings["font_family"], eA.settings["font_size"]);
	children = parent
			.getChildren(document.body, "", "selec", "none", "all", -1);
	for ( var i = 0; i < children.length; i++) {
		if (t.isIE)
			children[i].unselectable = true;
		else
			children[i].onmousedown = function() {
				return false
			};
	}
	a.spellcheck = s["gecko_spellcheck"];
	if (t.isFirefox >= '3') {
		t.content_highlight.style.paddingLeft = "1px";
		t.selection_field.style.paddingLeft = "1px";
		t.selection_field_text.style.paddingLeft = "1px";
	}
	if (t.isIE && t.isIE < 8) {
		a.style.marginTop = "-1px";
	}
	if (t.isSafari) {
		t.editor_area.style.position = "absolute";
		a.style.marginLeft = "-3px";
		if (t.isSafari < 3.2)
			a.style.marginTop = "1px";
	}
	parent.eAL.add_event(t.result, "click", function(e) {
		if ((e.target || e.srcElement) == eA.result) {
			eA.area_select(eA.textarea.value.length, 0);
		}
	});
	if (s['is_multi_files'] != false)
		t.open_file( {
			'id' : t.curr_file,
			'text' : ''
		});
	t.set_word_wrap(s['word_wrap']);
	setTimeout("eA.focus();eA.manage_size();eA.execCommand('EA_load');", 10);
	t.check_undo();
	t.check_line_selection(true);
	t.scroll_to_view();
	for ( var i in t.plugins) {
		if (typeof (t.plugins[i].onload) == "function")
			t.plugins[i].onload();
	}
	if (s['fullscreen'] == true)
		t.toggle_full_screen(true);
	parent.eAL.add_event(window, "resize", eA.update_size);
	parent.eAL.add_event(parent.window, "resize", eA.update_size);
	parent.eAL.add_event(top.window, "resize", eA.update_size);
	parent.eAL.add_event(window, "unload", function() {
		if (parent.eAL) {
			parent.eAL.remove_event(parent.window, "resize", eA.update_size);
			parent.eAL.remove_event(top.window, "resize", eA.update_size);
		}
		if (eAs[eA.id] && eAs[eA.id]["displayed"]) {
			eA.execCommand("EA_unload");
		}
	});
};
EA.prototype.update_size = function() {
	var d = document, pd = parent.document, height, width, popup, maxLeft, maxTop;
	if (typeof eAs != 'undefined' && eAs[eA.id]
			&& eAs[eA.id]["displayed"] == true) {
		if (eA.fullscreen['isFull']) {
			pd.getElementById("frame_" + eA.id).style.width = pd
					.getElementsByTagName("html")[0].clientWidth
					+ "px";
			pd.getElementById("frame_" + eA.id).style.height = pd
					.getElementsByTagName("html")[0].clientHeight
					+ "px";
		}
		if (eA.tab_browsing_area.style.display == 'block'
				&& (!eA.isIE || eA.isIE >= 8)) {
			eA.tab_browsing_area.style.height = "0px";
			eA.tab_browsing_area.style.height = (eA.result.offsetTop
					- eA.tab_browsing_area.offsetTop - 1)
					+ "px";
		}
		height = d.body.offsetHeight - eA.get_all_toolbar_height() - 4;
		eA.result.style.height = height + "px";
		width = d.body.offsetWidth - 2;
		eA.result.style.width = width + "px";
		for (i = 0; i < eA.inlinePopup.length; i++) {
			popup = _$(eA.inlinePopup[i]["popup_id"]);
			maxLeft = d.body.offsetWidth - popup.offsetWidth;
			maxTop = d.body.offsetHeight - popup.offsetHeight;
			if (popup.offsetTop > maxTop)
				popup.style.top = maxTop + "px";
			if (popup.offsetLeft > maxLeft)
				popup.style.left = maxLeft + "px";
		}
		eA.manage_size(true);
		eA.fixLinesHeight(eA.textarea.value, 0, -1);
	}
};
EA.prototype.manage_size = function(onlyOneTime) {
	if (!eAs[this.id])
		return false;
	if (eAs[this.id]["displayed"] == true && this.textareaFocused) {
		var area_height, resized = false;
		if (!this.settings['word_wrap']) {
			var area_width = this.textarea.scrollWidth;
			area_height = this.textarea.scrollHeight;
			if (this.isOpera && this.isOpera < 9.6) {
				area_width = 10000;
			}
			if (this.textarea.previous_scrollWidth != area_width) {
				this.container.style.width = area_width + "px";
				this.textarea.style.width = area_width + "px";
				this.content_highlight.style.width = area_width + "px";
				this.textarea.previous_scrollWidth = area_width;
				resized = true;
			}
		}
		if (this.settings['word_wrap']) {
			newW = this.textarea.offsetWidth;
			if (this.isFirefox || this.isIE)
				newW -= 2;
			if (this.isSafari)
				newW -= 6;
			this.content_highlight.style.width = this.selection_field_text.style.width = this.selection_field.style.width = this.test_font_size.style.width = newW
					+ "px";
		}
		if (this.isOpera || this.isFirefox || this.isSafari) {
			area_height = this
					.getLinePosTop(this.last_selection["nb_line"] + 1);
		} else {
			area_height = this.textarea.scrollHeight;
		}
		if (this.textarea.previous_scrollHeight != area_height) {
			this.container.style.height = (area_height + 2) + "px";
			this.textarea.style.height = area_height + "px";
			this.content_highlight.style.height = area_height + "px";
			this.textarea.previous_scrollHeight = area_height;
			resized = true;
		}
		if (this.last_selection["nb_line"] >= this.line_number) {
			var newLines = '', destDiv = _$("line_number"), start = this.line_number, end = this.last_selection["nb_line"] + 100;
			for (i = start + 1; i < end; i++) {
				newLines += '<div id="line_' + i + '">' + i + "</div>";
				this.line_number++;
			}
			destDiv.innerHTML = destDiv.innerHTML + newLines;
			this.fixLinesHeight(this.textarea.value, start, -1);
		}
		this.textarea.scrollTop = "0px";
		this.textarea.scrollLeft = "0px";
		if (resized == true) {
			this.scroll_to_view();
		}
	}
	if (!onlyOneTime)
		setTimeout("eA.manage_size();", 100);
};
EA.prototype.execCommand = function(cmd, param) {
	for ( var i in this.plugins) {
		if (typeof (this.plugins[i].execCommand) == "function") {
			if (!this.plugins[i].execCommand(cmd, param))
				return;
		}
	}
	switch (cmd) {
	case "save":
		if (this.settings["save_callback"].length > 0)
			eval("parent." + this.settings["save_callback"] + "('" + this.id
					+ "',eA.textarea.value);");
		break;
	case "load":
		if (this.settings["load_callback"].length > 0)
			eval("parent." + this.settings["load_callback"] + "('" + this.id
					+ "');");
		break;
	case "onchange":
		if (this.settings["change_callback"].length > 0)
			eval("parent." + this.settings["change_callback"] + "('" + this.id
					+ "');");
		break;
	case "EA_load":
		if (this.settings["EA_load_callback"].length > 0)
			eval("parent." + this.settings["EA_load_callback"] + "('" + this.id
					+ "');");
		break;
	case "EA_unload":
		if (this.settings["EA_unload_callback"].length > 0)
			eval("parent." + this.settings["EA_unload_callback"] + "('"
					+ this.id + "');");
		break;
	case "toggle_on":
		if (this.settings["EA_toggle_on_callback"].length > 0)
			eval("parent." + this.settings["EA_toggle_on_callback"] + "('"
					+ this.id + "');");
		break;
	case "toggle_off":
		if (this.settings["EA_toggle_off_callback"].length > 0)
			eval("parent." + this.settings["EA_toggle_off_callback"] + "('"
					+ this.id + "');");
		break;
	case "re_sync":
		if (!this.do_highlight)
			break;
	case "file_switch_on":
		if (this.settings["EA_file_switch_on_callback"].length > 0)
			eval("parent." + this.settings["EA_file_switch_on_callback"]
					+ "(param);");
		break;
	case "file_switch_off":
		if (this.settings["EA_file_switch_off_callback"].length > 0)
			eval("parent." + this.settings["EA_file_switch_off_callback"]
					+ "(param);");
		break;
	case "file_close":
		if (this.settings["EA_file_close_callback"].length > 0)
			return eval("parent." + this.settings["EA_file_close_callback"]
					+ "(param);");
		break;
	default:
		if (typeof (eval("eA." + cmd)) == "function") {
			if (this.settings["debug"])
				eval("eA." + cmd + "(param);");
			else
				try {
					eval("eA." + cmd + "(param);");
				} catch (e) {
				}
			;
		}
	}
};
EA.prototype.get_translation = function(word, mode) {
	if (mode == "template")
		return parent.eAL.translate(word, this.settings["language"], mode);
	else
		return parent.eAL.get_word_translation(word, this.settings["language"]);
};
EA.prototype.add_plugin = function(plug_name, plug_obj) {
	for ( var i = 0; i < this.settings["plugins"].length; i++) {
		if (this.settings["plugins"][i] == plug_name) {
			this.plugins[plug_name] = plug_obj;
			plug_obj.baseURL = parent.eAL.baseURL + "plugins/" + plug_name
					+ "/";
			if (typeof (plug_obj.init) == "function")
				plug_obj.init();
		}
	}
};
EA.prototype.load_css = function(url) {
	try {
		link = document.createElement("link");
		link.type = "text/css";
		link.rel = "stylesheet";
		link.media = "all";
		link.href = url;
		head = document.getElementsByTagName("head");
		head[0].appendChild(link);
	} catch (e) {
		document.write("<link href='" + url
				+ "' rel='stylesheet' type='text/css' />");
	}
};
EA.prototype.load_script = function(url) {
	try {
		script = document.createElement("script");
		script.type = "text/javascript";
		script.src = url;
		script.charset = "UTF-8";
		head = document.getElementsByTagName("head");
		head[0].appendChild(script);
	} catch (e) {
		document.write("<script type='text/javascript' src='" + url
				+ "' charset=\"UTF-8\"><" + "/script>");
	}
};
EA.prototype.add_lang = function(language, values) {
	if (!parent.eAL.lang[language])
		parent.eAL.lang[language] = {};
	for ( var i in values)
		parent.eAL.lang[language][i] = values[i];
};
function _$(id) {
	return document.getElementById(id);
};
var eA = new EA();
parent.eAL.add_event(window, "load", init);
function init() {
	setTimeout("eA.init();", 10);
};
EA.prototype.focus = function() {
	this.textarea.focus();
	this.textareaFocused = true;
};
EA.prototype.check_line_selection = function(timer_checkup) {
	var changes, infos, new_top, new_width, i;
	var t1 = t2 = t2_1 = t3 = tLines = tend = new Date().getTime();
	if (!eAs[this.id])
		return false;
	if (!this.smooth_selection && !this.do_highlight) {
	} else if (this.textareaFocused && eAs[this.id]["displayed"] == true
			&& this.isResizing == false) {
		infos = this.get_selection_infos();
		changes = this.checkTextEvolution(
				typeof (this.last_selection['full_text']) == 'undefined' ? ''
						: this.last_selection['full_text'], infos['full_text']);
		t2 = new Date().getTime();
		if (this.last_selection["line_start"] != infos["line_start"]
				|| this.last_selection["line_nb"] != infos["line_nb"]
				|| infos["full_text"] != this.last_selection["full_text"]
				|| this.reload_highlight
				|| this.last_selection["selectionStart"] != infos["selectionStart"]
				|| this.last_selection["selectionEnd"] != infos["selectionEnd"]
				|| !timer_checkup) {
			new_top = this.getLinePosTop(infos["line_start"]);
			new_width = Math.max(this.textarea.scrollWidth,
					this.container.clientWidth - 50);
			this.selection_field.style.top = this.selection_field_text.style.top = new_top
					+ "px";
			if (!this.settings['word_wrap']) {
				this.selection_field.style.width = this.selection_field_text.style.width = this.test_font_size.style.width = new_width
						+ "px";
			}
			if (this.do_highlight == true) {
				var curr_text = infos["full_text"].split("\n");
				var content = "";
				var start = Math.max(0, infos["line_start"] - 1);
				var end = Math.min(curr_text.length, infos["line_start"]
						+ infos["line_nb"] - 1);
				for (i = start; i < end; i++) {
					content += curr_text[i] + "\n";
				}
				selLength = infos['selectionEnd'] - infos['selectionStart'];
				content = content.substr(0, infos["curr_pos"] - 1) + "\r\r"
						+ content.substr(infos["curr_pos"] - 1, selLength)
						+ "\r\r"
						+ content.substr(infos["curr_pos"] - 1 + selLength);
				content = '<span>' + content.replace(/&/g, "&amp;").replace(
						/</g, "&lt;").replace(/>/g, "&gt;").replace("\r\r",
						'</span><strong>').replace("\r\r", '</strong><span>') + '</span>';
				if (this.isIE || (this.isOpera && this.isOpera < 9.6)) {
					this.selection_field.innerHTML = "<pre>"
							+ content.replace(/^\r?\n/, "<br>") + "</pre>";
				} else {
					this.selection_field.innerHTML = content;
				}
				this.selection_field_text.innerHTML = this.selection_field.innerHTML;
				t2_1 = new Date().getTime();
				if (this.reload_highlight
						|| (infos["full_text"] != this.last_text_to_highlight && (this.last_selection["line_start"] != infos["line_start"]
								|| this.show_line_colors
								|| this.settings['word_wrap']
								|| this.last_selection["line_nb"] != infos["line_nb"] || this.last_selection["nb_line"] != infos["nb_line"]))) {
					this.maj_highlight(infos);
				}
			}
		}
		t3 = new Date().getTime();
		if (this.settings['word_wrap']
				&& infos["full_text"] != this.last_selection["full_text"]) {
			if (changes.newText.split("\n").length == 1
					&& this.last_selection['nb_line']
					&& infos['nb_line'] == this.last_selection['nb_line']) {
				this.fixLinesHeight(infos['full_text'], changes.lineStart,
						changes.lineStart);
			} else {
				this.fixLinesHeight(infos['full_text'], changes.lineStart, -1);
			}
		}
		tLines = new Date().getTime();
		if (infos["line_start"] != this.last_selection["line_start"]
				|| infos["curr_pos"] != this.last_selection["curr_pos"]
				|| infos["full_text"].length != this.last_selection["full_text"].length
				|| this.reload_highlight || !timer_checkup) {
			var selec_char = infos["curr_line"].charAt(infos["curr_pos"] - 1);
			var no_real_move = true;
			if (infos["line_nb"] == 1
					&& (this.assocBracket[selec_char] || this.revertAssocBracket[selec_char])) {
				no_real_move = false;
				if (this.findEndBracket(infos, selec_char) === true) {
					_$("end_bracket").style.visibility = "visible";
					_$("cursor_pos").style.visibility = "visible";
					_$("cursor_pos").innerHTML = selec_char;
					_$("end_bracket").innerHTML = (this.assocBracket[selec_char] || this.revertAssocBracket[selec_char]);
				} else {
					_$("end_bracket").style.visibility = "hidden";
					_$("cursor_pos").style.visibility = "hidden";
				}
			} else {
				_$("cursor_pos").style.visibility = "hidden";
				_$("end_bracket").style.visibility = "hidden";
			}
			this.displayToCursorPosition("cursor_pos", infos["line_start"],
					infos["curr_pos"] - 1, infos["curr_line"], no_real_move);
			if (infos["line_nb"] == 1
					&& infos["line_start"] != this.last_selection["line_start"])
				this.scroll_to_view();
		}
		this.last_selection = infos;
	}
	tend = new Date().getTime();
	if (timer_checkup) {
		setTimeout("eA.check_line_selection(true)",
				this.check_line_selection_timer);
	}
};
EA.prototype.get_selection_infos = function() {
	var sel = {}, start, end, len, str;
	this.getIESelection();
	start = this.textarea.selectionStart;
	end = this.textarea.selectionEnd;
	if (this.last_selection["selectionStart"] == start
			&& this.last_selection["selectionEnd"] == end
			&& this.last_selection["full_text"] == this.textarea.value) {
		return this.last_selection;
	}
	if (this.tabulation != "	" && this.textarea.value.indexOf("	") != -1) {
		len = this.textarea.value.length;
		this.textarea.value = this.replace_tab(this.textarea.value);
		start = end = start + (this.textarea.value.length - len);
		this.area_select(start, 0);
	}
	sel["selectionStart"] = start;
	sel["selectionEnd"] = end;
	sel["full_text"] = this.textarea.value;
	sel["line_start"] = 1;
	sel["line_nb"] = 1;
	sel["curr_pos"] = 0;
	sel["curr_line"] = "";
	sel["indexOfCursor"] = 0;
	sel["selec_direction"] = this.last_selection["selec_direction"];
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
};
EA.prototype.getIESelection = function() {
	var selectionStart, selectionEnd, range, stored_range;
	if (!this.isIE)
		return false;
	if (this.settings['word_wrap'])
		this.textarea.wrap = 'off';
	try {
		range = document.selection.createRange();
		stored_range = range.duplicate();
		stored_range.moveToElementText(this.textarea);
		stored_range.setEndPoint('EndToEnd', range);
		if (stored_range.parentElement() != this.textarea)
			throw "invalid focus";
		var scrollTop = this.result.scrollTop + document.body.scrollTop;
		var relative_top = range.offsetTop
				- parent.calculeOffsetTop(this.textarea) + scrollTop;
		var line_start = Math.round((relative_top / this.lineHeight) + 1);
		var line_nb = Math.round(range.boundingHeight / this.lineHeight);
		selectionStart = stored_range.text.length - range.text.length;
		selectionStart += (line_start - this.textarea.value.substr(0,
				selectionStart).split("\n").length) * 2;
		selectionStart -= (line_start - this.textarea.value.substr(0,
				selectionStart).split("\n").length) * 2;
		selectionEnd = selectionStart + range.text.length;
		selectionEnd += (line_start + line_nb - 1 - this.textarea.value.substr(
				0, selectionEnd).split("\n").length) * 2;
		this.textarea.selectionStart = selectionStart;
		this.textarea.selectionEnd = selectionEnd;
	} catch (e) {
	}
	if (this.settings['word_wrap'])
		this.textarea.wrap = 'soft';
};
EA.prototype.setIESelection = function() {
	var a = this.textarea, nbLineStart, nbLineEnd, range;
	if (!this.isIE)
		return false;
	nbLineStart = a.value.substr(0, a.selectionStart).split("\n").length - 1;
	nbLineEnd = a.value.substr(0, a.selectionEnd).split("\n").length - 1;
	range = document.selection.createRange();
	range.moveToElementText(a);
	range.setEndPoint('EndToStart', range);
	range.moveStart('character', a.selectionStart - nbLineStart);
	range.moveEnd('character', a.selectionEnd - nbLineEnd
			- (a.selectionStart - nbLineStart));
	range.select();
};
EA.prototype.checkTextEvolution = function(lastText, newText) {
	var ch = {}, baseStep = 200, cpt = 0, end, step, tStart = new Date()
			.getTime();
	end = Math.min(newText.length, lastText.length);
	step = baseStep;
	while (cpt < end && step >= 1) {
		if (lastText.substr(cpt, step) == newText.substr(cpt, step)) {
			cpt += step;
		} else {
			step = Math.floor(step / 2);
		}
	}
	ch.posStart = cpt;
	ch.lineStart = newText.substr(0, ch.posStart).split("\n").length - 1;
	cpt_last = lastText.length;
	cpt = newText.length;
	step = baseStep;
	while (cpt >= 0 && cpt_last >= 0 && step >= 1) {
		if (lastText.substr(cpt_last - step, step) == newText.substr(
				cpt - step, step)) {
			cpt -= step;
			cpt_last -= step;
		} else {
			step = Math.floor(step / 2);
		}
	}
	ch.posNewEnd = cpt;
	ch.posLastEnd = cpt_last;
	if (ch.posNewEnd <= ch.posStart) {
		if (lastText.length < newText.length) {
			ch.posNewEnd = ch.posStart + newText.length - lastText.length;
			ch.posLastEnd = ch.posStart;
		} else {
			ch.posLastEnd = ch.posStart + lastText.length - newText.length;
			ch.posNewEnd = ch.posStart;
		}
	}
	ch.newText = newText.substring(ch.posStart, ch.posNewEnd);
	ch.lastText = lastText.substring(ch.posStart, ch.posLastEnd);
	ch.lineNewEnd = newText.substr(0, ch.posNewEnd).split("\n").length - 1;
	ch.lineLastEnd = lastText.substr(0, ch.posLastEnd).split("\n").length - 1;
	ch.newTextLine = newText.split("\n").slice(ch.lineStart, ch.lineNewEnd + 1)
			.join("\n");
	ch.lastTextLine = lastText.split("\n").slice(ch.lineStart,
			ch.lineLastEnd + 1).join("\n");
	return ch;
};
EA.prototype.tab_selection = function() {
	if (this.is_tabbing)
		return;
	this.is_tabbing = true;
	this.getIESelection();
	var start = this.textarea.selectionStart;
	var end = this.textarea.selectionEnd;
	var insText = this.textarea.value.substring(start, end);
	var pos_start = start;
	var pos_end = end;
	if (insText.length == 0) {
		this.textarea.value = this.textarea.value.substr(0, start)
				+ this.tabulation + this.textarea.value.substr(end);
		pos_start = start + this.tabulation.length;
		pos_end = pos_start;
	} else {
		start = Math.max(0, this.textarea.value.substr(0, start).lastIndexOf(
				"\n") + 1);
		endText = this.textarea.value.substr(end);
		startText = this.textarea.value.substr(0, start);
		tmp = this.textarea.value.substring(start, end).split("\n");
		insText = this.tabulation + tmp.join("\n" + this.tabulation);
		this.textarea.value = startText + insText + endText;
		pos_start = start;
		pos_end = this.textarea.value.indexOf("\n", startText.length
				+ insText.length);
		if (pos_end == -1)
			pos_end = this.textarea.value.length;
	}
	this.textarea.selectionStart = pos_start;
	this.textarea.selectionEnd = pos_end;
	if (this.isIE) {
		this.setIESelection();
		setTimeout("eA.is_tabbing=false;", 100);
	} else {
		this.is_tabbing = false;
	}
};
EA.prototype.invert_tab_selection = function() {
	var t = this, a = this.textarea;
	if (t.is_tabbing)
		return;
	t.is_tabbing = true;
	t.getIESelection();
	var start = a.selectionStart;
	var end = a.selectionEnd;
	var insText = a.value.substring(start, end);
	var pos_start = start;
	var pos_end = end;
	if (insText.length == 0) {
		if (a.value.substring(start - t.tabulation.length, start) == t.tabulation) {
			a.value = a.value.substr(0, start - t.tabulation.length)
					+ a.value.substr(end);
			pos_start = Math.max(0, start - t.tabulation.length);
			pos_end = pos_start;
		}
	} else {
		start = a.value.substr(0, start).lastIndexOf("\n") + 1;
		endText = a.value.substr(end);
		startText = a.value.substr(0, start);
		tmp = a.value.substring(start, end).split("\n");
		insText = "";
		for (i = 0; i < tmp.length; i++) {
			for (j = 0; j < t.tab_nb_char; j++) {
				if (tmp[i].charAt(0) == "	") {
					tmp[i] = tmp[i].substr(1);
					j = t.tab_nb_char;
				} else if (tmp[i].charAt(0) == " ")
					tmp[i] = tmp[i].substr(1);
			}
			insText += tmp[i];
			if (i < tmp.length - 1)
				insText += "\n";
		}
		a.value = startText + insText + endText;
		pos_start = start;
		pos_end = a.value.indexOf("\n", startText.length + insText.length);
		if (pos_end == -1)
			pos_end = a.value.length;
	}
	a.selectionStart = pos_start;
	a.selectionEnd = pos_end;
	if (t.isIE) {
		t.setIESelection();
		setTimeout("eA.is_tabbing=false;", 100);
	} else
		t.is_tabbing = false;
};
EA.prototype.press_enter = function() {
	if (!this.smooth_selection)
		return false;
	this.getIESelection();
	var scrollTop = this.result.scrollTop;
	var scrollLeft = this.result.scrollLeft;
	var start = this.textarea.selectionStart;
	var end = this.textarea.selectionEnd;
	var start_last_line = Math.max(0, this.textarea.value.substring(0, start)
			.lastIndexOf("\n") + 1);
	var begin_line = this.textarea.value.substring(start_last_line, start)
			.replace(/^([ 	]*).*/gm, "$1");
	var lineStart = this.textarea.value.substring(0, start).split("\n").length;
	if (begin_line == "\n" || begin_line == "\r" || begin_line.length == 0) {
		return false;
	}
	if (this.isIE || (this.isOpera && this.isOpera < 9.6)) {
		begin_line = "\r\n" + begin_line;
	} else {
		begin_line = "\n" + begin_line;
	}
	this.textarea.value = this.textarea.value.substring(0, start) + begin_line
			+ this.textarea.value.substring(end);
	this.area_select(start + begin_line.length, 0);
	if (this.isIE) {
		this.result.scrollTop = scrollTop;
		this.result.scrollLeft = scrollLeft;
	}
	return true;
};
EA.prototype.findEndBracket = function(infos, bracket) {
	var start = infos["indexOfCursor"];
	var normal_order = true;
	if (this.assocBracket[bracket])
		endBracket = this.assocBracket[bracket];
	else if (this.revertAssocBracket[bracket]) {
		endBracket = this.revertAssocBracket[bracket];
		normal_order = false;
	}
	var end = -1;
	var nbBracketOpen = 0;
	for ( var i = start; i < infos["full_text"].length && i >= 0;) {
		if (infos["full_text"].charAt(i) == endBracket) {
			nbBracketOpen--;
			if (nbBracketOpen <= 0) {
				end = i;
				break;
			}
		} else if (infos["full_text"].charAt(i) == bracket)
			nbBracketOpen++;
		if (normal_order)
			i++;
		else
			i--;
	}
	if (end == -1)
		return false;
	var endLastLine = infos["full_text"].substr(0, end).lastIndexOf("\n");
	if (endLastLine == -1)
		line = 1;
	else
		line = infos["full_text"].substr(0, endLastLine).split("\n").length + 1;
	var curPos = end - endLastLine - 1;
	var endLineLength = infos["full_text"].substring(end).split("\n")[0].length;
	this.displayToCursorPosition("end_bracket", line, curPos,
			infos["full_text"].substring(endLastLine + 1, end + endLineLength));
	return true;
};
EA.prototype.displayToCursorPosition = function(id, start_line, cur_pos,
		lineContent, no_real_move) {
	var elem, dest, content, posLeft = 0, posTop, fixPadding, topOffset, endElem;
	elem = this.test_font_size;
	dest = _$(id);
	content = "<span id='test_font_size_inner'>"
			+ lineContent.substr(0, cur_pos).replace(/&/g, "&amp;").replace(
					/</g, "&lt;")
			+ "</span><span id='endTestFont'>"
			+ lineContent.substr(cur_pos).replace(/&/g, "&amp;").replace(/</g,
					"&lt;") + "</span>";
	if (this.isIE || (this.isOpera && this.isOpera < 9.6)) {
		elem.innerHTML = "<pre>" + content.replace(/^\r?\n/, "<br>") + "</pre>";
	} else {
		elem.innerHTML = content;
	}
	endElem = _$('endTestFont');
	topOffset = endElem.offsetTop;
	fixPadding = parseInt(this.content_highlight.style.paddingLeft.replace(
			"px", ""));
	posLeft = 45 + endElem.offsetLeft
			+ (!isNaN(fixPadding) && topOffset > 0 ? fixPadding : 0);
	posTop = this.getLinePosTop(start_line) + topOffset;
	if (this.isIE && cur_pos > 0 && endElem.offsetLeft == 0) {
		posTop += this.lineHeight;
	}
	if (no_real_move != true) {
		dest.style.top = posTop + "px";
		dest.style.left = posLeft + "px";
	}
	dest.cursor_top = posTop;
	dest.cursor_left = posLeft;
};
EA.prototype.getLinePosTop = function(start_line) {
	var elem = _$('line_' + start_line), posTop = 0;
	if (elem)
		posTop = elem.offsetTop;
	else
		posTop = this.lineHeight * (start_line - 1);
	return posTop;
};
EA.prototype.getTextHeight = function(text) {
	var t = this, elem, height;
	elem = t.test_font_size;
	content = text.replace(/&/g, "&amp;").replace(/</g, "&lt;");
	if (t.isIE || (this.isOpera && this.isOpera < 9.6)) {
		elem.innerHTML = "<pre>" + content.replace(/^\r?\n/, "<br>") + "</pre>";
	} else {
		elem.innerHTML = content;
	}
	height = elem.offsetHeight;
	height = Math.max(1, Math.floor(elem.offsetHeight / this.lineHeight))
			* this.lineHeight;
	return height;
};
EA.prototype.fixLinesHeight = function(textValue, lineStart, lineEnd) {
	var aText = textValue.split("\n");
	if (lineEnd == -1)
		lineEnd = aText.length - 1;
	for ( var i = Math.max(0, lineStart); i <= lineEnd; i++) {
		if (elem = _$('line_' + (i + 1))) {
			elem.style.height = typeof (aText[i]) != "undefined" ? this
					.getTextHeight(aText[i])
					+ "px" : this.lineHeight;
		}
	}
};
EA.prototype.area_select = function(start, length) {
	this.textarea.focus();
	
	start = Math.max(0, Math.min(this.textarea.value.length, start));
	end = Math.max(start, Math.min(this.textarea.value.length, start + length));
	if (this.isIE) {
		this.textarea.selectionStart = start;
		this.textarea.selectionEnd = end;
		this.setIESelection();
	} else {
		if (this.isOpera && this.isOpera < 9.6) {
			this.textarea.setSelectionRange(0, 0);
		}
		this.textarea.setSelectionRange(start, end);
	}
	this.check_line_selection();
};
EA.prototype.area_get_selection = function() {
	var text = "";
	if (document.selection) {
		var range = document.selection.createRange();
		text = range.text;
	} else {
		text = this.textarea.value.substring(this.textarea.selectionStart,
				this.textarea.selectionEnd);
	}
	return text;
};
EA.prototype.replace_tab = function(text) {
	return text.replace(/((\n?)([^	\n]*)	)/gi, eA.smartTab);
};
EA.prototype.smartTab = function() {
	val = "                   ";
	return EA.prototype.smartTab.arguments[2]
			+ EA.prototype.smartTab.arguments[3]
			+ val.substr(0, eA.tab_nb_char
					- (EA.prototype.smartTab.arguments[3].length)
					% eA.tab_nb_char);
};
EA.prototype.show_waiting_screen = function() {
	width = this.editor_area.offsetWidth;
	height = this.editor_area.offsetHeight;
	if (!(this.isIE && this.isIE < 6)) {
		width -= 2;
		height -= 2;
	}
	this.processing_screen.style.display = "block";
	this.processing_screen.style.width = width + "px";
	this.processing_screen.style.height = height + "px";
	this.waiting_screen_displayed = true;
};
EA.prototype.hide_waiting_screen = function() {
	this.processing_screen.style.display = "none";
	this.waiting_screen_displayed = false;
};
EA.prototype.add_style = function(styles) {
	if (styles.length > 0) {
		newcss = document.createElement("style");
		newcss.type = "text/css";
		newcss.media = "all";
		if (newcss.styleSheet) {
			newcss.styleSheet.cssText = styles;
		} else {
			newcss.appendChild(document.createTextNode(styles));
		}
		document.getElementsByTagName("head")[0].appendChild(newcss);
	}
};
EA.prototype.set_font = function(family, size) {
	var t = this, a = this.textarea, s = this.settings, elem_font, i, elem;
	var elems = [ "textarea", "content_highlight", "cursor_pos", "end_bracket",
			"selection_field", "selection_field_text", "line_number" ];
	if (family && family != "")
		s["font_family"] = family;
	if (size && size > 0)
		s["font_size"] = size;
	if (t.isOpera && t.isOpera < 9.6)
		s['font_family'] = "monospace";
	if (elem_font = _$("area_font_size")) {
		for (i = 0; i < elem_font.length; i++) {
			if (elem_font.options[i].value
					&& elem_font.options[i].value == s["font_size"])
				elem_font.options[i].selected = true;
		}
	}
	if (t.isFirefox) {
		var nbTry = 3;
		do {
			var div1 = document.createElement('div'), text1 = document
					.createElement('textarea');
			var styles = {
				width : '40px',
				overflow : 'scroll',
				zIndex : 50,
				visibility : 'hidden',
				fontFamily : s["font_family"],
				fontSize : s["font_size"] + "pt",
				lineHeight : t.lineHeight + "px",
				padding : '0',
				margin : '0',
				border : 'none',
				whiteSpace : 'nowrap'
			};
			var diff, changed = false;
			for (i in styles) {
				div1.style[i] = styles[i];
				text1.style[i] = styles[i];
			}
			text1.wrap = 'off';
			text1.setAttribute('wrap', 'off');
			t.container.appendChild(div1);
			t.container.appendChild(text1);
			div1.innerHTML = text1.value = 'azertyuiopqsdfghjklm';
			div1.innerHTML = text1.value = text1.value + 'wxcvbn^p*��$!:;,,';
			diff = text1.scrollWidth - div1.scrollWidth;
			if (Math.abs(diff) >= 2) {
				s["font_size"]++;
				changed = true;
			}
			t.container.removeChild(div1);
			t.container.removeChild(text1);
			nbTry--;
		} while (changed && nbTry > 0);
	}
	elem = t.test_font_size;
	elem.style.fontFamily = "" + s["font_family"];
	elem.style.fontSize = s["font_size"] + "pt";
	elem.innerHTML = "0";
	t.lineHeight = elem.offsetHeight;
	for (i = 0; i < elems.length; i++) {
		elem = _$(elems[i]);
		elem.style.fontFamily = s["font_family"];
		elem.style.fontSize = s["font_size"] + "pt";
		elem.style.lineHeight = t.lineHeight + "px";
	}
	t.add_style("pre{font-family:" + s["font_family"] + "}");
	if ((t.isOpera && t.isOpera < 9.6) || t.isIE >= 8) {
		var parNod = a.parentNode, nxtSib = a.nextSibling, start = a.selectionStart, end = a.selectionEnd;
		parNod.removeChild(a);
		parNod.insertBefore(a, nxtSib);
		t.area_select(start, end - start);
	}
	this.focus();
	this.update_size();
	this.check_line_selection();
};
EA.prototype.change_font_size = function() {
	var size = _$("area_font_size").value;
	if (size > 0)
		this.set_font("", size);
};
EA.prototype.open_inline_popup = function(popup_id) {
	this.close_all_inline_popup();
	alert(" here is key 1111");
	var popup = _$(popup_id);
	var editor = _$("editor");
	for ( var i = 0; i < this.inlinePopup.length; i++) {
		if (this.inlinePopup[i]["popup_id"] == popup_id) {
			var icon = _$(this.inlinePopup[i]["icon_id"]);
			if (icon) {
				this.switchClassSticky(icon, 'editAreaButtonSelected', true);
				break;
			}
		}
	}
	alert(" here is key 2222");
	popup.style.height = "auto";
	popup.style.overflow = "visible";
	if (document.body.offsetHeight < popup.offsetHeight) {
		popup.style.height = (document.body.offsetHeight - 10) + "px";
		alert(" here is key 3333");
		popup.style.overflow = "auto";
	}
	if (!popup.positionned) {
		var new_left = editor.offsetWidth / 2 - popup.offsetWidth / 2;
		var new_top = editor.offsetHeight / 2 - popup.offsetHeight / 2;
		popup.style.left = new_left + "px";
		popup.style.top = new_top + "px";
		popup.positionned = true;
		alert(" here is key 4444");
	}
	popup.style.visibility = "visible";
};
EA.prototype.close_inline_popup = function(popup_id) {
	var popup = _$(popup_id);
	for ( var i = 0; i < this.inlinePopup.length; i++) {
		if (this.inlinePopup[i]["popup_id"] == popup_id) {
			var icon = _$(this.inlinePopup[i]["icon_id"]);
			if (icon) {
				this.switchClassSticky(icon, 'editAreaButtonNormal', false);
				break;
			}
		}
	}
	popup.style.visibility = "hidden";
};
EA.prototype.close_all_inline_popup = function(e) {
	for ( var i = 0; i < this.inlinePopup.length; i++) {
		this.close_inline_popup(this.inlinePopup[i]["popup_id"]);
	}
	if (_$("area_search_replace").style.visibility == "visible") {
		this.textarea.focus();
	}
};
EA.prototype.show_help = function() {
	this.open_inline_popup("edit_area_help");
};
EA.prototype.new_document = function() {
	this.textarea.value = "";
	this.area_select(0, 0);
};
EA.prototype.get_all_toolbar_height = function() {
	var area = _$("editor");
	var results = parent.getChildren(area, "div", "class", "area_toolbar",
			"all", "0");
	var height = 0;
	for ( var i = 0; i < results.length; i++) {
		height += results[i].offsetHeight;
	}
	return height;
};
EA.prototype.go_to_line = function(line) {
	if (!line) {
		var icon = _$("go_to_line");
		if (icon != null) {
			this.restoreClass(icon);
			this.switchClassSticky(icon, 'editAreaButtonSelected', true);
		}
		line = prompt(this.get_translation("go_to_line_prompt"));
		if (icon != null)
			this.switchClassSticky(icon, 'editAreaButtonNormal', false);
	}
	if (line && line != null && line.search(/^[0-9]+$/) != -1) {
		var start = 0;
		var lines = this.textarea.value.split("\n");
		if (line > lines.length)
			start = this.textarea.value.length;
		else {
			for ( var i = 0; i < Math.min(line - 1, lines.length); i++)
				start += lines[i].length + 1;
		}
		this.area_select(start, 0);
	}
};
EA.prototype.change_smooth_selection_mode = function(setTo) {
	if (this.do_highlight)
		return;
	if (setTo != null) {
		if (setTo === false)
			this.smooth_selection = true;
		else
			this.smooth_selection = false;
	}
	var icon = _$("change_smooth_selection");
	this.textarea.focus();
	if (this.smooth_selection === true) {
		this.switchClassSticky(icon, 'editAreaButtonNormal', false);
		this.smooth_selection = false;
		this.selection_field.style.display = "none";
		_$("cursor_pos").style.display = "none";
		_$("end_bracket").style.display = "none";
	} else {
		this.switchClassSticky(icon, 'editAreaButtonSelected', false);
		this.smooth_selection = true;
		this.selection_field.style.display = "block";
		_$("cursor_pos").style.display = "block";
		_$("end_bracket").style.display = "block";
	}
};
EA.prototype.scroll_to_view = function(show) {
	var zone, lineElem;
	if (!this.smooth_selection)
		return;
	zone = _$("result");
	var cursor_pos_top = _$("cursor_pos").cursor_top;
	if (show == "bottom") {
		cursor_pos_top += this.getLinePosTop(this.last_selection['line_start']
				+ this.last_selection['line_nb'] - 1);
	}
	var max_height_visible = zone.clientHeight + zone.scrollTop;
	var miss_top = cursor_pos_top + this.lineHeight - max_height_visible;
	if (miss_top > 0) {
		zone.scrollTop = zone.scrollTop + miss_top;
	} else if (zone.scrollTop > cursor_pos_top) {
		zone.scrollTop = cursor_pos_top;
	}
	var cursor_pos_left = _$("cursor_pos").cursor_left;
	var max_width_visible = zone.clientWidth + zone.scrollLeft;
	var miss_left = cursor_pos_left + 10 - max_width_visible;
	if (miss_left > 0) {
		zone.scrollLeft = zone.scrollLeft + miss_left + 50;
	} else if (zone.scrollLeft > cursor_pos_left) {
		zone.scrollLeft = cursor_pos_left;
	} else if (zone.scrollLeft == 45) {
		zone.scrollLeft = 0;
	}
};
EA.prototype.check_undo = function(only_once) {
	if (!eAs[this.id])
		return false;
	if (this.textareaFocused && eAs[this.id]["displayed"] == true) {
		var text = this.textarea.value;
		if (this.previous.length <= 1)
			this.switchClassSticky(_$("undo"), 'editAreaButtonDisabled', true);
		if (!this.previous[this.previous.length - 1]
				|| this.previous[this.previous.length - 1]["text"] != text) {
			this.previous.push( {
				"text" : text,
				"selStart" : this.textarea.selectionStart,
				"selEnd" : this.textarea.selectionEnd
			});
			if (this.previous.length > this.settings["max_undo"] + 1)
				this.previous.shift();
		}
		if (this.previous.length >= 2)
			this.switchClassSticky(_$("undo"), 'editAreaButtonNormal', false);
	}
	if (!only_once)
		setTimeout("eA.check_undo()", 3000);
};
EA.prototype.undo = function() {
	if (this.previous.length > 0) {
		this.getIESelection();
		this.next.push( {
			"text" : this.textarea.value,
			"selStart" : this.textarea.selectionStart,
			"selEnd" : this.textarea.selectionEnd
		});
		var prev = this.previous.pop();
		if (prev["text"] == this.textarea.value && this.previous.length > 0)
			prev = this.previous.pop();
		this.textarea.value = prev["text"];
		this.last_undo = prev["text"];
		this.area_select(prev["selStart"], prev["selEnd"] - prev["selStart"]);
		this.switchClassSticky(_$("redo"), 'editAreaButtonNormal', false);
		this.resync_highlight(true);
		this.check_file_changes();
	}
};
EA.prototype.redo = function() {
	if (this.next.length > 0) {
		var next = this.next.pop();
		this.previous.push(next);
		this.textarea.value = next["text"];
		this.last_undo = next["text"];
		this.area_select(next["selStart"], next["selEnd"] - next["selStart"]);
		this.switchClassSticky(_$("undo"), 'editAreaButtonNormal', false);
		this.resync_highlight(true);
		this.check_file_changes();
	}
	if (this.next.length == 0)
		this.switchClassSticky(_$("redo"), 'editAreaButtonDisabled', true);
};
EA.prototype.check_redo = function() {
	if (eA.next.length == 0 || eA.textarea.value != eA.last_undo) {
		eA.next = [];
		eA.switchClassSticky(_$("redo"), 'editAreaButtonDisabled', true);
	} else {
		this.switchClassSticky(_$("redo"), 'editAreaButtonNormal', false);
	}
};
EA.prototype.switchClass = function(element, class_name, lock_state) {
	var lockChanged = false;
	if (typeof (lock_state) != "undefined" && element != null) {
		element.classLock = lock_state;
		lockChanged = true;
	}
	if (element != null && (lockChanged || !element.classLock)) {
		element.oldClassName = element.className;
		element.className = class_name;
	}
};
EA.prototype.restoreAndSwitchClass = function(element, class_name) {
	if (element != null && !element.classLock) {
		this.restoreClass(element);
		this.switchClass(element, class_name);
	}
};
EA.prototype.restoreClass = function(element) {
	if (element != null && element.oldClassName && !element.classLock) {
		element.className = element.oldClassName;
		element.oldClassName = null;
	}
};
EA.prototype.setClassLock = function(element, lock_state) {
	if (element != null)
		element.classLock = lock_state;
};
EA.prototype.switchClassSticky = function(element, class_name, lock_state) {
	var lockChanged = false;
	if (typeof (lock_state) != "undefined" && element != null) {
		element.classLock = lock_state;
		lockChanged = true;
	}
	if (element != null && (lockChanged || !element.classLock)) {
		element.className = class_name;
		element.oldClassName = class_name;
	}
};
EA.prototype.scroll_page = function(params) {
	var dir = params["dir"], shift_pressed = params["shift"];
	var lines = this.textarea.value.split("\n");
	var new_pos = 0, length = 0, char_left = 0, line_nb = 0, curLine = 0;
	var toScrollAmount = _$("result").clientHeight - 30;
	var nbLineToScroll = 0, diff = 0;
	if (dir == "up") {
		nbLineToScroll = Math.ceil(toScrollAmount / this.lineHeight);
		for (i = this.last_selection["line_start"]; i - diff > this.last_selection["line_start"]
				- nbLineToScroll; i--) {
			if (elem = _$('line_' + i)) {
				diff += Math.floor((elem.offsetHeight - 1) / this.lineHeight);
			}
		}
		nbLineToScroll -= diff;
		if (this.last_selection["selec_direction"] == "up") {
			for (line_nb = 0; line_nb < Math.min(
					this.last_selection["line_start"] - nbLineToScroll,
					lines.length); line_nb++) {
				new_pos += lines[line_nb].length + 1;
			}
			char_left = Math.min(
					lines[Math.min(lines.length - 1, line_nb)].length,
					this.last_selection["curr_pos"] - 1);
			if (shift_pressed)
				length = this.last_selection["selectionEnd"] - new_pos
						- char_left;
			this.area_select(new_pos + char_left, length);
			view = "top";
		} else {
			view = "bottom";
			for (line_nb = 0; line_nb < Math.min(
					this.last_selection["line_start"]
							+ this.last_selection["line_nb"] - 1
							- nbLineToScroll, lines.length); line_nb++) {
				new_pos += lines[line_nb].length + 1;
			}
			char_left = Math.min(
					lines[Math.min(lines.length - 1, line_nb)].length,
					this.last_selection["curr_pos"] - 1);
			if (shift_pressed) {
				start = Math.min(this.last_selection["selectionStart"], new_pos
						+ char_left);
				length = Math.max(new_pos + char_left,
						this.last_selection["selectionStart"])
						- start;
				if (new_pos + char_left < this.last_selection["selectionStart"])
					view = "top";
			} else
				start = new_pos + char_left;
			this.area_select(start, length);
		}
	} else {
		var nbLineToScroll = Math.floor(toScrollAmount / this.lineHeight);
		for (i = this.last_selection["line_start"]; i + diff < this.last_selection["line_start"]
				+ nbLineToScroll; i++) {
			if (elem = _$('line_' + i)) {
				diff += Math.floor((elem.offsetHeight - 1) / this.lineHeight);
			}
		}
		nbLineToScroll -= diff;
		if (this.last_selection["selec_direction"] == "down") {
			view = "bottom";
			for (line_nb = 0; line_nb < Math.min(
					this.last_selection["line_start"]
							+ this.last_selection["line_nb"] - 2
							+ nbLineToScroll, lines.length); line_nb++) {
				if (line_nb == this.last_selection["line_start"] - 1)
					char_left = this.last_selection["selectionStart"] - new_pos;
				new_pos += lines[line_nb].length + 1;
			}
			if (shift_pressed) {
				length = Math.abs(this.last_selection["selectionStart"]
						- new_pos);
				length += Math.min(
						lines[Math.min(lines.length - 1, line_nb)].length,
						this.last_selection["curr_pos"]);
				this
						.area_select(
								Math.min(this.last_selection["selectionStart"],
										new_pos), length);
			} else {
				this.area_select(new_pos + char_left, 0);
			}
		} else {
			view = "top";
			for (line_nb = 0; line_nb < Math.min(
					this.last_selection["line_start"] + nbLineToScroll - 1,
					lines.length, lines.length); line_nb++) {
				if (line_nb == this.last_selection["line_start"] - 1)
					char_left = this.last_selection["selectionStart"] - new_pos;
				new_pos += lines[line_nb].length + 1;
			}
			if (shift_pressed) {
				length = Math.abs(this.last_selection["selectionEnd"] - new_pos
						- char_left);
				length += Math.min(
						lines[Math.min(lines.length - 1, line_nb)].length,
						this.last_selection["curr_pos"])
						- char_left - 1;
				this.area_select(Math.min(this.last_selection["selectionEnd"],
						new_pos + char_left), length);
				if (new_pos + char_left > this.last_selection["selectionEnd"])
					view = "bottom";
			} else {
				this.area_select(new_pos + char_left, 0);
			}
		}
	}
	this.check_line_selection();
	this.scroll_to_view(view);
};
EA.prototype.start_resize = function(e) {
	parent.eAL.resize["id"] = eA.id;
	parent.eAL.resize["start_x"] = (e) ? e.pageX : event.x
			+ document.body.scrollLeft;
	parent.eAL.resize["start_y"] = (e) ? e.pageY : event.y
			+ document.body.scrollTop;
	if (eA.isIE) {
		eA.textarea.focus();
		eA.getIESelection();
	}
	parent.eAL.resize["selectionStart"] = eA.textarea.selectionStart;
	parent.eAL.resize["selectionEnd"] = eA.textarea.selectionEnd;
	parent.eAL.start_resize_area();
};
EA.prototype.toggle_full_screen = function(to) {
	var t = this, p = parent, a = t.textarea, html, frame, selStart, selEnd, old, icon;
	if (typeof (to) == "undefined")
		to = !t.fullscreen['isFull'];
	old = t.fullscreen['isFull'];
	t.fullscreen['isFull'] = to;
	icon = _$("fullscreen");
	selStart = t.textarea.selectionStart;
	selEnd = t.textarea.selectionEnd;
	html = p.document.getElementsByTagName("html")[0];
	frame = p.document.getElementById("frame_" + t.id);
	if (to && to != old) {
		t.fullscreen['old_overflow'] = p.get_css_property(html, "overflow");
		t.fullscreen['old_height'] = p.get_css_property(html, "height");
		t.fullscreen['old_width'] = p.get_css_property(html, "width");
		t.fullscreen['old_scrollTop'] = html.scrollTop;
		t.fullscreen['old_scrollLeft'] = html.scrollLeft;
		t.fullscreen['old_zIndex'] = p.get_css_property(frame, "z-index");
		if (t.isOpera) {
			html.style.height = "100%";
			html.style.width = "100%";
		}
		html.style.overflow = "hidden";
		html.scrollTop = 0;
		html.scrollLeft = 0;
		frame.style.position = "absolute";
		frame.style.width = html.clientWidth + "px";
		frame.style.height = html.clientHeight + "px";
		frame.style.display = "block";
		frame.style.zIndex = "999999";
		frame.style.top = "0px";
		frame.style.left = "0px";
		frame.style.top = "-" + p.calculeOffsetTop(frame) + "px";
		frame.style.left = "-" + p.calculeOffsetLeft(frame) + "px";
		t.switchClassSticky(icon, 'editAreaButtonSelected', false);
		t.fullscreen['allow_resize'] = t.resize_allowed;
		t.allow_resize(false);
		if (t.isFirefox) {
			p.eAL.execCommand(t.id, "update_size();");
			t.area_select(selStart, selEnd - selStart);
			t.scroll_to_view();
			t.focus();
		} else {
			setTimeout("p.eAL.execCommand('" + t.id
					+ "','update_size();');eA.focus();", 10);
		}
	} else if (to != old) {
		frame.style.position = "static";
		frame.style.zIndex = t.fullscreen['old_zIndex'];
		if (t.isOpera) {
			html.style.height = "auto";
			html.style.width = "auto";
			html.style.overflow = "auto";
		} else if (t.isIE && p != top) {
			html.style.overflow = "auto";
		} else {
			html.style.overflow = t.fullscreen['old_overflow'];
		}
		html.scrollTop = t.fullscreen['old_scrollTop'];
		html.scrollLeft = t.fullscreen['old_scrollLeft'];
		p.eAL.hide(t.id);
		p.eAL.show(t.id);
		t.switchClassSticky(icon, 'editAreaButtonNormal', false);
		if (t.fullscreen['allow_resize'])
			t.allow_resize(t.fullscreen['allow_resize']);
		if (t.isFirefox) {
			t.area_select(selStart, selEnd - selStart);
			setTimeout("eA.scroll_to_view();", 10);
		}
	}
};
EA.prototype.allow_resize = function(allow) {
	var resize = _$("resize_area");
	if (allow) {
		resize.style.visibility = "visible";
		parent.eAL.add_event(resize, "mouseup", eA.start_resize);
	} else {
		resize.style.visibility = "hidden";
		parent.eAL.remove_event(resize, "mouseup", eA.start_resize);
	}
	this.resize_allowed = allow;
};
EA.prototype.change_syntax = function(new_syntax, is_waiting) {
	if (new_syntax == this.settings['syntax'])
		return true;
	var founded = false;
	for ( var i = 0; i < this.syntax_list.length; i++) {
		if (this.syntax_list[i] == new_syntax)
			founded = true;
	}
	if (founded == true) {
		if (!parent.eAL.load_syntax[new_syntax]) {
			if (!is_waiting)
				parent.eAL.load_script(parent.eAL.baseURL + "reg_syntax/"
						+ new_syntax + ".js");
			setTimeout("eA.change_syntax('" + new_syntax + "',true);", 100);
			this.show_waiting_screen();
		} else {
			if (!this.allready_used_syntax[new_syntax]) {
				parent.eAL.init_syntax_regexp();
				this.add_style(parent.eAL.syntax[new_syntax]["styles"]);
				this.allready_used_syntax[new_syntax] = true;
			}
			var sel = _$("syntax_selection");
			if (sel && sel.value != new_syntax) {
				for ( var i = 0; i < sel.length; i++) {
					if (sel.options[i].value
							&& sel.options[i].value == new_syntax)
						sel.options[i].selected = true;
				}
			}
			this.settings['syntax'] = new_syntax;
			this.resync_highlight(true);
			this.hide_waiting_screen();
			return true;
		}
	}
	return false;
};
EA.prototype.set_editable = function(is_editable) {
	if (is_editable) {
		document.body.className = "";
		this.textarea.readOnly = false;
		this.is_editable = true;
	} else {
		document.body.className = "non_editable";
		this.textarea.readOnly = true;
		this.is_editable = false;
	}
	if (eAs[this.id]["displayed"] == true)
		this.update_size();
};
EA.prototype.toggle_word_wrap = function() {
	this.set_word_wrap(!this.settings['word_wrap']);
};
EA.prototype.set_word_wrap = function(to) {
	var t = this, a = t.textarea;
	if (t.isOpera) {
		this.settings['word_wrap'] = false;
		t.switchClassSticky(_$("word_wrap"), 'editAreaButtonDisabled', true);
		return false;
	}
	if (to) {
		wrap_mode = 'soft';
		this.container.className += ' word_wrap';
		this.container.style.width = "";
		this.content_highlight.style.width = "";
		a.style.width = "100%";
		if (t.isIE && t.isIE < 7) {
			a.style.width = (a.offsetWidth - 5) + "px";
		}
		t.switchClassSticky(_$("word_wrap"), 'editAreaButtonSelected', false);
	} else {
		wrap_mode = 'off';
		this.container.className = this.container.className.replace(
				/word_wrap/g, '');
		t.switchClassSticky(_$("word_wrap"), 'editAreaButtonNormal', true);
	}
	this.textarea.previous_scrollWidth = '';
	this.textarea.previous_scrollHeight = '';
	a.wrap = wrap_mode;
	a.setAttribute('wrap', wrap_mode);
	if (!this.isIE) {
		var start = a.selectionStart, end = a.selectionEnd;
		var parNod = a.parentNode, nxtSib = a.nextSibling;
		parNod.removeChild(a);
		parNod.insertBefore(a, nxtSib);
		this.area_select(start, end - start);
	}
	this.settings['word_wrap'] = to;
	this.focus();
	this.update_size();
	this.check_line_selection();
};
EA.prototype.open_file = function(settings) {
	if (settings['id'] != "undefined") {
		var id = settings['id'];
		var new_file = {};
		new_file['id'] = id;
		new_file['title'] = id;
		new_file['text'] = "";
		new_file['last_selection'] = "";
		new_file['last_text_to_highlight'] = "";
		new_file['last_hightlighted_text'] = "";
		new_file['previous'] = [];
		new_file['next'] = [];
		new_file['last_undo'] = "";
		new_file['smooth_selection'] = this.settings['smooth_selection'];
		new_file['do_highlight'] = this.settings['start_highlight'];
		new_file['syntax'] = this.settings['syntax'];
		new_file['scroll_top'] = 0;
		new_file['scroll_left'] = 0;
		new_file['selection_start'] = 0;
		new_file['selection_end'] = 0;
		new_file['edited'] = false;
		new_file['font_size'] = this.settings["font_size"];
		new_file['font_family'] = this.settings["font_family"];
		new_file['word_wrap'] = this.settings["word_wrap"];
		new_file['toolbar'] = {
			'links' : {},
			'selects' : {}
		};
		new_file['compare_edited_text'] = new_file['text'];
		this.files[id] = new_file;
		this.update_file(id, settings);
		this.files[id]['compare_edited_text'] = this.files[id]['text'];
		var html_id = 'tab_file_' + encodeURIComponent(id);
		this.filesIdAssoc[html_id] = id;
		this.files[id]['html_id'] = html_id;
		if (!_$(this.files[id]['html_id']) && id != "") {
			this.tab_browsing_area.style.display = "block";
			var elem = document.createElement('li');
			elem.id = this.files[id]['html_id'];
			var close = "<img src=\""
					+ parent.eAL.baseURL
					+ "images/close.gif\" title=\""
					+ this.get_translation('close_tab', 'word')
					+ "\" onclick=\"eA.execCommand('close_file',eA.filesIdAssoc['"
					+ html_id
					+ "']);return false;\" class=\"hidden\" onmouseover=\"this.className=''\" onmouseout=\"this.className='hidden'\" />";
			elem.innerHTML = "<a onclick=\"javascript:eA.execCommand('switch_to_file',eA.filesIdAssoc['"
					+ html_id
					+ "']);\" selec=\"none\"><b><span><strong class=\"edited\">*</strong>"
					+ this.files[id]['title'] + close + "</span></b></a>";
			_$('tab_browsing_list').appendChild(elem);
			var elem = document.createElement('text');
			this.update_size();
		}
		if (id != "")
			this.execCommand('file_open', this.files[id]);
		this.switch_to_file(id, true);
		return true;
	} else
		return false;
};
EA.prototype.close_file = function(id) {
	if (this.files[id]) {
		this.save_file(id);
		if (this.execCommand('file_close', this.files[id]) !== false) {
			var li = _$(this.files[id]['html_id']);
			li.parentNode.removeChild(li);
			if (id == this.curr_file) {
				var next_file = "";
				var is_next = false;
				for ( var i in this.files) {
					if (is_next) {
						next_file = i;
						break;
					} else if (i == id)
						is_next = true;
					else
						next_file = i;
				}
				this.switch_to_file(next_file);
			}
			delete (this.files[id]);
			this.update_size();
		}
	}
};
EA.prototype.save_file = function(id) {
	var t = this, save, a_links, a_selects, save_butt, img, i;
	if (t.files[id]) {
		var save = t.files[id];
		save['last_selection'] = t.last_selection;
		save['last_text_to_highlight'] = t.last_text_to_highlight;
		save['last_hightlighted_text'] = t.last_hightlighted_text;
		save['previous'] = t.previous;
		save['next'] = t.next;
		save['last_undo'] = t.last_undo;
		save['smooth_selection'] = t.smooth_selection;
		save['do_highlight'] = t.do_highlight;
		save['syntax'] = t.settings['syntax'];
		save['text'] = t.textarea.value;
		save['scroll_top'] = t.result.scrollTop;
		save['scroll_left'] = t.result.scrollLeft;
		save['selection_start'] = t.last_selection["selectionStart"];
		save['selection_end'] = t.last_selection["selectionEnd"];
		save['font_size'] = t.settings["font_size"];
		save['font_family'] = t.settings["font_family"];
		save['word_wrap'] = t.settings["word_wrap"];
		save['toolbar'] = {
			'links' : {},
			'selects' : {}
		};
		a_links = _$("toolbar_1").getElementsByTagName("a");
		for (i = 0; i < a_links.length; i++) {
			if (a_links[i].getAttribute('fileSpecific') == 'yes') {
				save_butt = {};
				img = a_links[i].getElementsByTagName('img')[0];
				save_butt['classLock'] = img.classLock;
				save_butt['className'] = img.className;
				save_butt['oldClassName'] = img.oldClassName;
				save['toolbar']['links'][a_links[i].id] = save_butt;
			}
		}
		a_selects = _$("toolbar_1").getElementsByTagName("select");
		for (i = 0; i < a_selects.length; i++) {
			if (a_selects[i].getAttribute('fileSpecific') == 'yes') {
				save['toolbar']['selects'][a_selects[i].id] = a_selects[i].value;
			}
		}
		t.files[id] = save;
		return save;
	}
	return false;
};
EA.prototype.update_file = function(id, new_values) {
	for ( var i in new_values) {
		this.files[id][i] = new_values[i];
	}
};
EA.prototype.display_file = function(id) {
	var t = this, a = t.textarea, new_file, a_lis, a_selects, a_links, a_options, i, j;
	if (id == '') {
		a.readOnly = true;
		t.tab_browsing_area.style.display = "none";
		_$("no_file_selected").style.display = "block";
		t.result.className = "empty";
		if (!t.files['']) {
			t.open_file( {
				id : ''
			});
		}
	} else if (typeof (t.files[id]) == 'undefined') {
		return false;
	} else {
		t.result.className = "";
		a.readOnly = !t.is_editable;
		_$("no_file_selected").style.display = "none";
		t.tab_browsing_area.style.display = "block";
	}
	t.check_redo(true);
	t.check_undo(true);
	t.curr_file = id;
	a_lis = t.tab_browsing_area.getElementsByTagName('li');
	for (i = 0; i < a_lis.length; i++) {
		if (a_lis[i].id == t.files[id]['html_id'])
			a_lis[i].className = 'selected';
		else
			a_lis[i].className = '';
	}
	new_file = t.files[id];
	a.value = new_file['text'];
	t.set_font(new_file['font_family'], new_file['font_size']);
	t.area_select(new_file['last_selection']['selection_start'],
			new_file['last_selection']['selection_end']
					- new_file['last_selection']['selection_start']);
	t.manage_size(true);
	t.result.scrollTop = new_file['scroll_top'];
	t.result.scrollLeft = new_file['scroll_left'];
	t.previous = new_file['previous'];
	t.next = new_file['next'];
	t.last_undo = new_file['last_undo'];
	t.check_redo(true);
	t.check_undo(true);
	t.execCommand("change_highlight", new_file['do_highlight']);
	t.execCommand("change_syntax", new_file['syntax']);
	t.execCommand("change_smooth_selection_mode", new_file['smooth_selection']);
	t.execCommand("set_word_wrap", new_file['word_wrap']);
	a_links = new_file['toolbar']['links'];
	for (i in a_links) {
		if (img = _$(i).getElementsByTagName('img')[0]) {
			img.classLock = a_links[i]['classLock'];
			img.className = a_links[i]['className'];
			img.oldClassName = a_links[i]['oldClassName'];
		}
	}
	a_selects = new_file['toolbar']['selects'];
	for (i in a_selects) {
		a_options = _$(i).options;
		for (j = 0; j < a_options.length; j++) {
			if (a_options[j].value == a_selects[i])
				_$(i).options[j].selected = true;
		}
	}
};
EA.prototype.switch_to_file = function(file_to_show, force_refresh) {
	if (file_to_show != this.curr_file || force_refresh) {
		this.save_file(this.curr_file);
		if (this.curr_file != '')
			this.execCommand('file_switch_off', this.files[this.curr_file]);
		this.display_file(file_to_show);
		if (file_to_show != '')
			this.execCommand('file_switch_on', this.files[file_to_show]);
	}
};
EA.prototype.get_file = function(id) {
	if (id == this.curr_file)
		this.save_file(id);
	return this.files[id];
};
EA.prototype.get_all_files = function() {
	tmp_files = this.files;
	this.save_file(this.curr_file);
	if (tmp_files[''])
		delete (this.files['']);
	return tmp_files;
};
EA.prototype.check_file_changes = function() {
	var id = this.curr_file;
	if (this.files[id] && this.files[id]['compare_edited_text'] != undefined) {
		if (this.files[id]['compare_edited_text'].length == this.textarea.value.length
				&& this.files[id]['compare_edited_text'] == this.textarea.value) {
			if (this.files[id]['edited'] != false)
				this.set_file_edited_mode(id, false);
		} else {
			if (this.files[id]['edited'] != true)
				this.set_file_edited_mode(id, true);
		}
	}
};
EA.prototype.set_file_edited_mode = function(id, to) {
	if (this.files[id] && _$(this.files[id]['html_id'])) {
		var link = _$(this.files[id]['html_id']).getElementsByTagName('a')[0];
		if (to == true) {
			link.className = 'edited';
		} else {
			link.className = '';
			if (id == this.curr_file)
				text = this.textarea.value;
			else
				text = this.files[id]['text'];
			this.files[id]['compare_edited_text'] = text;
		}
		this.files[id]['edited'] = to;
	}
};
EA.prototype.set_show_line_colors = function(new_value) {
	this.show_line_colors = new_value;
	if (new_value)
		this.selection_field.className += ' show_colors';
	else
		this.selection_field.className = this.selection_field.className
				.replace(/ show_colors/g, '');
};
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
	for ( var i in eA.plugins) {
		if (typeof (eA.plugins[i].onkeydown) == "function") {
			if (eA.plugins[i].onkeydown(e) === false) {
				if (eA.isIE)
					e.keyCode = 0;
				return false;
			}
		}
	}
	var target_id = (e.target || e.srcElement).id;
	var use = false;
	if (EA_keys[e.keyCode])
		letter = EA_keys[e.keyCode];
	else
		letter = String.fromCharCode(e.keyCode);
	var low_letter = letter.toLowerCase();
	if (letter == "Page up" && !eA.isOpera) {
		eA.execCommand("scroll_page", {
			"dir" : "up",
			"shift" : ShiftPressed(e)
		});
		use = true;
	} else if (letter == "Page down" && !eA.isOpera) {
		eA.execCommand("scroll_page", {
			"dir" : "down",
			"shift" : ShiftPressed(e)
		});
		use = true;
	} else if (eA.is_editable == false) {
		return true;
	} else if (letter == "Tabulation" && target_id == "textarea"
			&& !CtrlPressed(e) && !AltPressed(e)) {
		if (ShiftPressed(e))
			eA.execCommand("invert_tab_selection");
		else
			eA.execCommand("tab_selection");
		use = true;
		if (eA.isOpera || (eA.isFirefox && eA.isMac))
			setTimeout("eA.execCommand('focus');", 1);
	} else if (letter == "Entrer" && target_id == "textarea") {
		if (_$("area_search_replace").style.visibility == "visible")
		{
			eA.execCommand("area_search");
			use = true;

		}
		else if (eA.press_enter())
			use = true;
	} else if (letter == "Entrer" && target_id == "area_search") {
		eA.execCommand("area_search");
		use = true;
	} else if (letter == "Esc") {
		eA.execCommand("close_all_inline_popup", e);
		use = true;
	} else if (CtrlPressed(e) && !AltPressed(e) && !ShiftPressed(e)) {
		switch (low_letter) {
		case "f":
			eA.execCommand("area_search");
			use = true;
			break;
		case "r":
			eA.execCommand("area_replace");
			use = true;
			break;
		case "q":
			eA.execCommand("close_all_inline_popup", e);
			use = true;
			break;
		case "h":
			eA.execCommand("change_highlight");
			use = true;
			break;
		case "g":
			setTimeout("eA.execCommand('go_to_line');", 5);
			use = true;
			break;
		case "e":
			eA.execCommand("show_help");
			use = true;
			break;
		case "z":
			use = true;
			eA.execCommand("undo");
			break;
		case "y":
			use = true;
			eA.execCommand("redo");
			break;
		default:
			break;
		}
	}
	if (eA.next.length > 0) {
		setTimeout("eA.check_redo();", 10);
	}
	setTimeout("eA.check_file_changes();", 10);
	if (use) {
		if (eA.isIE)
			e.keyCode = 0;
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
};
function CtrlPressed(e) {
	if (window.event) {
		return (window.event.ctrlKey);
	} else {
		return (e.ctrlKey || (e.modifiers == 2) || (e.modifiers == 3) || (e.modifiers > 5));
	}
};
function ShiftPressed(e) {
	if (window.event) {
		return (window.event.shiftKey);
	} else {
		return (e.shiftKey || (e.modifiers > 3));
	}
};
EA.prototype.show_search = function() {
	if (_$("area_search_replace").style.visibility == "visible") {
		this.hidden_search();
	} else {
		this.open_inline_popup("area_search_replace");
		var text = this.area_get_selection();
		var search = text.split("\n")[0];
		_$("area_search").value = search;
		_$("area_search").focus();
	}
};
EA.prototype.hidden_search = function() {
	this.close_inline_popup("area_search_replace");
};
EA.prototype.area_search = function(mode) {
	if (!mode)
		mode = "search";
	_$("area_search_msg").innerHTML = "";
	var search = _$("area_search").value;
	if (_$("area_search_replace").style.visibility != "visible") {
		this.show_search();
		return;
	}
	this.textarea.focus();
	this.textarea.textareaFocused = true;

	var infos = this.get_selection_infos();
	var start = infos["selectionStart"];
	var pos = -1;
	var pos_begin = -1;
	var length = search.length;
	
	if (search.length == 0) {
		_$("area_search_msg").innerHTML = this
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
		this.textarea.value = new_text;
		this.area_select(begin, length);
		this.area_search();
	} else
		this.area_select(begin, length);
};
EA.prototype.area_replace = function() {
	this.area_search("replace");
};
EA.prototype.area_replace_all = function() {
	var base_text = this.textarea.value;
	var search = _$("area_search").value;
	var replace = _$("area_replace").value;
	if (search.length == 0) {
		_$("area_search_msg").innerHTML = this
				.get_translation("search_field_empty");
		return;
	}
	var new_text = "";
	var nb_change = 0;
	if (_$("area_search_reg_exp").checked) {
		var opt = "mg";
		if (!_$("area_search_match_case").checked)
			opt += "i";
		var reg = new RegExp(search, opt);
		nb_change = infos["full_text"].match(reg).length;
		new_text = infos["full_text"].replace(reg, replace);
	} else {
		if (_$("area_search_match_case").checked) {
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
				new_text += this.textarea.value.substring(start, pos) + replace;
				start = pos + search.length;
				pos = lower_value.indexOf(lower_search, pos + 1);
			}
			new_text += this.textarea.value.substring(start);
		}
	}
	if (new_text == base_text) {
		_$("area_search_msg").innerHTML = "<strong>" + search + "</strong> "
				+ this.get_translation("not_found");
	} else {
		this.textarea.value = new_text;
		_$("area_search_msg").innerHTML = "<strong>" + nb_change + "</strong> "
				+ this.get_translation("occurrence_replaced");
		setTimeout("eA.textarea.focus();eA.textarea.textareaFocused=true;", 100);
	}
};
EA.prototype.change_highlight = function(change_to) {
	if (this.settings["syntax"].length == 0 && change_to == false) {
		this.switchClassSticky(_$("highlight"), 'editAreaButtonDisabled', true);
		this.switchClassSticky(_$("reset_highlight"), 'editAreaButtonDisabled',
				true);
		return false;
	}
	if (this.do_highlight == change_to)
		return false;
	this.getIESelection();
	var pos_start = this.textarea.selectionStart;
	var pos_end = this.textarea.selectionEnd;
	if (this.do_highlight === true || change_to == false)
		this.disable_highlight();
	else
		this.enable_highlight();
	this.textarea.focus();
	this.textarea.selectionStart = pos_start;
	this.textarea.selectionEnd = pos_end;
	this.setIESelection();
};
EA.prototype.disable_highlight = function(displayOnly) {
	var t = this, a = t.textarea, new_Obj, old_class, new_class;
	t.selection_field.innerHTML = "";
	t.selection_field_text.innerHTML = "";
	t.content_highlight.style.visibility = "hidden";
	new_Obj = t.content_highlight.cloneNode(false);
	new_Obj.innerHTML = "";
	t.content_highlight.parentNode.insertBefore(new_Obj, t.content_highlight);
	t.content_highlight.parentNode.removeChild(t.content_highlight);
	t.content_highlight = new_Obj;
	old_class = parent.getAttribute(a, "class");
	if (old_class) {
		new_class = old_class.replace("hidden", "");
		parent.setAttribute(a, "class", new_class);
	}
	a.style.backgroundColor = "transparent";
	t.switchClassSticky(_$("highlight"), 'editAreaButtonNormal', true);
	t.switchClassSticky(_$("reset_highlight"), 'editAreaButtonDisabled', true);
	t.do_highlight = false;
	t.switchClassSticky(_$("change_smooth_selection"),
			'editAreaButtonSelected', true);
	if (typeof (t.smooth_selection_before_highlight) != "undefined"
			&& t.smooth_selection_before_highlight === false) {
		t.change_smooth_selection_mode(false);
	}
};
EA.prototype.enable_highlight = function() {
	var t = this, a = t.textarea, new_class;
	t.show_waiting_screen();
	t.content_highlight.style.visibility = "visible";
	new_class = parent.getAttribute(a, "class") + " hidden";
	parent.setAttribute(a, "class", new_class);
	if (t.isIE)
		a.style.backgroundColor = "#FFFFFF";
	t.switchClassSticky(_$("highlight"), 'editAreaButtonSelected', false);
	t.switchClassSticky(_$("reset_highlight"), 'editAreaButtonNormal', false);
	t.smooth_selection_before_highlight = t.smooth_selection;
	if (!t.smooth_selection)
		t.change_smooth_selection_mode(true);
	t.switchClassSticky(_$("change_smooth_selection"),
			'editAreaButtonDisabled', true);
	t.do_highlight = true;
	t.resync_highlight();
	t.hide_waiting_screen();
};
EA.prototype.maj_highlight = function(infos) {
	var debug_opti = "", tps_start = new Date().getTime(), tps_middle_opti = new Date()
			.getTime();
	var t = this, hightlighted_text, updated_highlight;
	var textToHighlight = infos["full_text"], doSyntaxOpti = false, doHtmlOpti = false, stay_begin = "", stay_end = "", trace_new, trace_last;
	if (t.last_text_to_highlight == infos["full_text"]
			&& t.resync_highlight !== true)
		return;
	if (t.reload_highlight === true) {
		t.reload_highlight = false;
	} else if (textToHighlight.length == 0) {
		textToHighlight = "\n ";
	} else {
		changes = t.checkTextEvolution(t.last_text_to_highlight,
				textToHighlight);
		trace_new = t.get_syntax_trace(changes.newTextLine).replace(/\r/g, '');
		trace_last = t.get_syntax_trace(changes.lastTextLine)
				.replace(/\r/g, '');
		doSyntaxOpti = (trace_new == trace_last);
		if (!doSyntaxOpti && trace_new == "\n" + trace_last
				&& /^[ 	s]*\n[ 	s]*$/.test(changes.newText.replace(/\r/g, ''))
				&& changes.lastText == "") {
			doSyntaxOpti = true;
		}
		if (doSyntaxOpti) {
			tps_middle_opti = new Date().getTime();
			stay_begin = t.last_hightlighted_text.split("\n").slice(0,
					changes.lineStart).join("\n");
			if (changes.lineStart > 0)
				stay_begin += "\n";
			stay_end = t.last_hightlighted_text.split("\n").slice(
					changes.lineLastEnd + 1).join("\n");
			if (stay_end.length > 0)
				stay_end = "\n" + stay_end;
			if (stay_begin.split('<span').length != stay_begin.split('</span').length
					|| stay_end.split('<span').length != stay_end
							.split('</span').length) {
				doSyntaxOpti = false;
				stay_end = '';
				stay_begin = '';
			} else {
				if (stay_begin.length == 0 && changes.posLastEnd == -1)
					changes.newTextLine += "\n";
				textToHighlight = changes.newTextLine;
			}
		}
		if (t.settings["debug"]) {
			var ch = changes;
			debug_opti = (doSyntaxOpti ? "Optimisation" : "No optimisation")
					+ " start:" + ch.posStart + "(" + ch.lineStart + ")"
					+ " end_new:" + ch.posNewEnd + "(" + ch.lineNewEnd + ")"
					+ " end_last:" + ch.posLastEnd + "(" + ch.lineLastEnd + ")"
					+ "\nchanged_text:" + ch.newText + "=> trace:" + trace_new
					+ "\nchanged_last_text:" + ch.lastText + "=> trace:"
					+ trace_last + "\nchanged_line:" + ch.newTextLine
					+ "\nlast_changed_line:" + ch.lastTextLine
					+ "\nstay_begin:" + stay_begin.slice(-100) + "\nstay_end:"
					+ stay_end.substr(0, 100);
			+"\n";
		}
	}
	tps_end_opti = new Date().getTime();
	updated_highlight = t.colorize_text(textToHighlight);
	tpsAfterReg = new Date().getTime();
	if (doSyntaxOpti) {
		try {
			var replacedBloc, i, nbStart = '', nbEnd = '', newHtml, lengthOld, lengthNew;
			replacedBloc = t.last_hightlighted_text.substring(
					stay_begin.length, t.last_hightlighted_text.length
							- stay_end.length);
			lengthOld = replacedBloc.length;
			lengthNew = updated_highlight.length;
			for (i = 0; i < lengthOld && i < lengthNew
					&& replacedBloc.charAt(i) == updated_highlight.charAt(i); i++) {
			}
			nbStart = i;
			for (i = 0; i + nbStart < lengthOld
					&& i + nbStart < lengthNew
					&& replacedBloc.charAt(lengthOld - i - 1) == updated_highlight
							.charAt(lengthNew - i - 1); i++) {
			}
			nbEnd = i;
			lastHtml = replacedBloc.substring(nbStart, lengthOld - nbEnd);
			newHtml = updated_highlight.substring(nbStart, lengthNew - nbEnd);
			if (newHtml.indexOf('<span') == -1
					&& newHtml.indexOf('</span') == -1
					&& lastHtml.indexOf('<span') == -1
					&& lastHtml.indexOf('</span') == -1) {
				var beginStr, nbOpendedSpan, nbClosedSpan, nbUnchangedChars, span, textNode;
				doHtmlOpti = true;
				beginStr = t.last_hightlighted_text.substr(0, stay_begin.length
						+ nbStart);
				nbOpendedSpan = beginStr.split('<span').length - 1;
				nbClosedSpan = beginStr.split('</span').length - 1;
				span = t.content_highlight.getElementsByTagName('span')[nbOpendedSpan];
				parentSpan = span;
				maxStartOffset = maxEndOffset = 0;
				if (nbOpendedSpan == nbClosedSpan) {
					while (parentSpan.parentNode != t.content_highlight
							&& parentSpan.parentNode.tagName != 'PRE') {
						parentSpan = parentSpan.parentNode;
					}
				} else {
					maxStartOffset = maxEndOffset = beginStr.length + 1;
					nbClosed = beginStr.substr(
							Math.max(0, beginStr.lastIndexOf('<span',
									maxStartOffset - 1))).split('</span').length - 1;
					while (nbClosed > 0) {
						nbClosed--;
						parentSpan = parentSpan.parentNode;
					}
					while (parentSpan.parentNode != t.content_highlight
							&& parentSpan.parentNode.tagName != 'PRE'
							&& (tmpMaxStartOffset = Math.max(0, beginStr
									.lastIndexOf('<span', maxStartOffset - 1))) < (tmpMaxEndOffset = Math
									.max(0, beginStr.lastIndexOf('</span',
											maxEndOffset - 1)))) {
						maxStartOffset = tmpMaxStartOffset;
						maxEndOffset = tmpMaxEndOffset;
					}
				}
				if (parentSpan.parentNode == t.content_highlight
						|| parentSpan.parentNode.tagName == 'PRE') {
					maxStartOffset = Math.max(0, beginStr.indexOf('<span'));
				}
				if (maxStartOffset == beginStr.length) {
					nbSubSpanBefore = 0;
				} else {
					lastEndPos = Math.max(0, beginStr.lastIndexOf('>',
							maxStartOffset));
					nbSubSpanBefore = beginStr.substr(lastEndPos)
							.split('<span').length - 1;
				}
				if (nbSubSpanBefore == 0) {
					textNode = parentSpan.firstChild;
				} else {
					lastSubSpan = parentSpan.getElementsByTagName('span')[nbSubSpanBefore - 1];
					while (lastSubSpan.parentNode != parentSpan) {
						lastSubSpan = lastSubSpan.parentNode;
					}
					if (lastSubSpan.nextSibling == null
							|| lastSubSpan.nextSibling.nodeType != 3) {
						textNode = document.createTextNode('');
						lastSubSpan.parentNode.insertBefore(textNode,
								lastSubSpan.nextSibling);
					} else {
						textNode = lastSubSpan.nextSibling;
					}
				}
				nbUnchangedChars = beginStr.length
						- Math.max(0, beginStr.lastIndexOf('>') + 1);
				if (t.isIE) {
					nbUnchangedChars -= (beginStr.substr(
							beginStr.length - nbUnchangedChars).split("\n").length - 1);
					textNode.replaceData(nbUnchangedChars, lastHtml.replace(
							/\n/g, '').length, newHtml.replace(/\n/g, ''));
				} else {
					textNode.replaceData(nbUnchangedChars, lastHtml.length,
							newHtml);
				}
			}
		} catch (e) {
			doHtmlOpti = false;
		}
	}
	tpsAfterOpti2 = new Date().getTime();
	hightlighted_text = stay_begin + updated_highlight + stay_end;
	if (!doHtmlOpti) {
		var new_Obj = t.content_highlight.cloneNode(false);
		if ((t.isIE && t.isIE < 8) || (t.isOpera && t.isOpera < 9.6))
			new_Obj.innerHTML = "<pre><span class='" + t.settings["syntax"]
					+ "'>" + hightlighted_text + "</span></pre>";
		else
			new_Obj.innerHTML = "<span class='" + t.settings["syntax"] + "'>"
					+ hightlighted_text + "</span>";
		t.content_highlight.parentNode.replaceChild(new_Obj,
				t.content_highlight);
		t.content_highlight = new_Obj;
	}
	t.last_text_to_highlight = infos["full_text"];
	t.last_hightlighted_text = hightlighted_text;
	tps3 = new Date().getTime();
	if (t.settings["debug"]) {
		t.debug.value = "Tps optimisation " + (tps_end_opti - tps_start)
				+ " | tps reg exp:" + (tpsAfterReg - tps_end_opti)
				+ " | tps opti HTML:" + (tpsAfterOpti2 - tpsAfterReg) + ' '
				+ (doHtmlOpti ? 'yes' : 'no')
				+ " | tps update highlight content:" + (tps3 - tpsAfterOpti2)
				+ " | tpsTotal:" + (tps3 - tps_start) + "(" + tps3 + ")\n"
				+ debug_opti;
	}
};
EA.prototype.resync_highlight = function(reload_now) {
	this.reload_highlight = true;
	this.last_text_to_highlight = "";
	this.focus();
	if (reload_now)
		this.check_line_selection(false);
};
EA.prototype.comment_or_quote = function() {
	var new_class = "", close_tag = "", sy, arg, i;
	sy = parent.eAL.syntax[eA.current_code_lang];
	arg = EA.prototype.comment_or_quote.arguments[0];
	for (i in sy["quotes"]) {
		if (arg.indexOf(i) == 0) {
			new_class = "quotesmarks";
			close_tag = sy["quotes"][i];
		}
	}
	if (new_class.length == 0) {
		for ( var i in sy["comments"]) {
			if (arg.indexOf(i) == 0) {
				new_class = "comments";
				close_tag = sy["comments"][i];
			}
		}
	}
	if (close_tag == "\n") {
		return "��__" + new_class + "__��"
				+ arg.replace(/(\r?\n)?$/m, "��_END_��$1");
	} else {
		reg = new RegExp(parent.eAL.get_escaped_regexp(close_tag) + "$", "m");
		if (arg.search(reg) != -1)
			return "��__" + new_class + "__��" + arg + "��_END_��";
		else
			return "��__" + new_class + "__��" + arg;
	}
};
EA.prototype.get_syntax_trace = function(text) {
	if (this.settings["syntax"].length > 0
			&& parent.eAL.syntax[this.settings["syntax"]]["syntax_trace_regexp"])
		return text
				.replace(
						parent.eAL.syntax[this.settings["syntax"]]["syntax_trace_regexp"],
						"$3");
};
EA.prototype.colorize_text = function(text) {
	text = " " + text;
	if (this.settings["syntax"].length > 0)
		text = this.apply_syntax(text, this.settings["syntax"]);
	return text.substr(1).replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(
			/>/g, "&gt;").replace(/��_END_��/g, "</span>").replace(
			/��__([a-zA-Z0-9]+)__��/g, "<span class='$1'>");
};
EA.prototype.apply_syntax = function(text, lang) {
	var sy;
	this.current_code_lang = lang;
	if (!parent.eAL.syntax[lang])
		return text;
	sy = parent.eAL.syntax[lang];
	if (sy["custom_regexp"]['before']) {
		for ( var i in sy["custom_regexp"]['before']) {
			var convert = "$1��__" + sy["custom_regexp"]['before'][i]['class']
					+ "__��$2��_END_��$3";
			text = text.replace(sy["custom_regexp"]['before'][i]['regexp'],
					convert);
		}
	}
	if (sy["comment_or_quote_reg_exp"]) {
		text = text.replace(sy["comment_or_quote_reg_exp"],
				this.comment_or_quote);
	}
	if (sy["keywords_reg_exp"]) {
		for ( var i in sy["keywords_reg_exp"]) {
			text = text.replace(sy["keywords_reg_exp"][i],
					'��__' + i + '__��$2��_END_��');
		}
	}
	if (sy["delimiters_reg_exp"]) {
		text = text.replace(sy["delimiters_reg_exp"],
				'��__delimiters__��$1��_END_��');
	}
	if (sy["operators_reg_exp"]) {
		text = text
				.replace(sy["operators_reg_exp"], '��__operators__��$1��_END_��');
	}
	if (sy["custom_regexp"]['after']) {
		for ( var i in sy["custom_regexp"]['after']) {
			var convert = "$1��__" + sy["custom_regexp"]['after'][i]['class']
					+ "__��$2��_END_��$3";
			text = text.replace(sy["custom_regexp"]['after'][i]['regexp'],
					convert);
		}
	}
	return text;
};
var editArea = eA;
EditArea = EA;
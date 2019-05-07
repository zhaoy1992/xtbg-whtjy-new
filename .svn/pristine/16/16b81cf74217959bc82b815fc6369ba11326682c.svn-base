
function rq_mousedown(div) {
	if (event.button != 1) {
		return;
	}
	var o = rq_getDragSource(event.srcElement);
	if (o != null && o != div) {
		o.dragDrop();
		event.returnValue = false;
		event.cancelBubble = true;
	}
}
function rq_getCood(obj) {
	var x = obj.offsetLeft;
	var y = obj.offsetTop;
	var obj = obj.offsetParent;
	while (obj.tagName != "BODY") {
		x += obj.offsetLeft + obj.clientLeft;
		y += obj.offsetTop + obj.clientTop;
		obj = obj.offsetParent;
	}
	return new Array(x, y);
}

//div是整个olap区域
function rq_dragstart(div) {
	var o = rq_getDragSource(event.srcElement);
	if (o == null || o == div) {
		event.returnValue = false;
		return;
	}
	div.ondragend = new Function("rq_dragend(this);");
	div.ondragenter = new Function("rq_dragenter(this);");
	div.ondragover = new Function("rq_dragover(this);");
	div.ondragleave = new Function("rq_dragleave(this);");
	div.ondrop = new Function("rq_drop(this);");
	if (o.getAttribute("tips") != null) {
		var tip = document.getElementById("dragTip_" + div.id);
		tip.innerText = o.getAttribute("tips");
		div.dragTip = tip;
		rq_displayTip(div);
	} else {
		div.dragTip = null;
	}
	div.dragSrc = o;
	event.dataTransfer.setData("Text", "");
	event.dataTransfer.effectAllowed = "move";
}
function rq_getDragSource(o) {
	for (var p = o; p != null; p = p.parentElement) {
		var a = p.getAttribute("dds");
		if (a != null && a.length > 0) {
			return p;
		}
	}
	return null;
}
function rq_displayTip(div) {
	var tip = div.dragTip;
	if (tip != null) {
		var C = rq_getCood(div);
		var c = rq_getCood(event.srcElement);
		var y = event.offsetY;
		var x = event.offsetX;
		x = x + c[0];
		y = y + c[1];
		var pdiv = event.srcElement;
		while (pdiv.tagName != "DIV") {
			pdiv = pdiv.parentElement;
		}
		if (pdiv.id) {
			if (pdiv.id.indexOf("_topdiv") > 0 || pdiv.id.indexOf("_leftdiv") > 0 || pdiv.id.indexOf("_contentdiv") > 0) {
				x -= pdiv.scrollLeft;
				y -= pdiv.scrollTop;
			}
		}
		if (y < C[1] || x < C[0] || y > C[1] + div.offsetHeight || x > C[0] + div.offsetWidth) {
			tip.style.display = "none";
		} else {
			tip.style.display = "";
			tip.style.top = y + 10;
			tip.style.left = x + 15;
		}
	}
}
function rq_dragenter(div) {
	if (div.dragSrc == null) {
		return;
	}
	var mark = document.getElementById("dropMark_" + div.id);
	if (event.srcElement == mark) {
		event.dataTransfer.dropEffect = "move";
		event.returnValue = false;
		return;
	}
	var dt = rq_getDropTarget(event.srcElement);
	if (dt == null || dt == div) {
		rq_hideDropMark(mark);
		return;
	}
	div.dropTarget = dt;
	rq_showDropMark(div, dt, mark);
	event.returnValue = false;
	event.dataTransfer.dropEffect = "move";
}
function rq_getDropTarget(o) {
	for (var p = o; p != null; p = p.parentElement) {
		var a = p.getAttribute("dds");
		if (a != null) {
			return p;
		}
	}
	return null;
}
function rq_showDropMark(div, dt, mark) {
	if (dt == null || dt == div) {
		return;
	}
	var t = dt.parentElement;
	while (t.tagName != "TABLE") {
		t = t.parentElement;
	}
	var tc = rq_getCood(t);
	var type = dt.getAttribute("ddtype");
	var dds = dt.getAttribute("dds");
	var src = event.srcElement;
	var c = rq_getCood(src);
	if (type == "1") {   //添加到列
		var topDiv = document.getElementById(div.id + "_topdiv");
		var w = t.offsetWidth;
		var w1 = topDiv.offsetWidth;
		w = w > w1 ? w1 : w;
		mark.style.width = w;
		mark.style.height = 4;
		mark.style.left = tc[0];
		if (src.offsetHeight / 2 > event.offsetY) {   //在前插入
			dt.insPos = "q";
			mark.style.top = c[1] - 2;
		} else {
			dt.insPos = "h";
			mark.style.top = c[1] + src.offsetHeight - 2;
		}
	} else {
		if (type == "2") {   //添加到行
			var leftDiv = document.getElementById(div.id + "_leftdiv");
			var h = t.offsetHeight;
			var h1 = leftDiv.offsetHeight;
			h = h > h1 ? h1 : h;
			mark.style.height = h;
			mark.style.width = 4;
			mark.style.top = tc[1];
			if (src.offsetWidth / 2 > event.offsetX) {   //在前插入
				dt.insPos = "q";
				mark.style.left = c[0] - 2;
			} else {
				dt.insPos = "h";
				mark.style.left = c[0] + src.offsetWidth - 2;
			}
		} else {
			if (type == "3") {   //添加到维列表
				mark.style.width = t.offsetWidth;
				mark.style.height = 4;
				mark.style.left = tc[0];
				if (dds.length > 0) {   //在维上
					if (src.offsetHeight / 2 > event.offsetY) {   //在前插入
						dt.insPos = "q";
						mark.style.top = c[1] - 2;
					} else {
						dt.insPos = "h";
						mark.style.top = c[1] + src.offsetHeight - 2;
					}
				} else {  //在可选维标题上
					mark.style.top = c[1] + src.offsetHeight - 2;
				}
			}
		}
	}
	mark.style.display = "";
}
function rq_hideDropMark(mark) {
	mark.style.display = "none";
}
function rq_dragover(div) {
	if (div.dragSrc == null) {
		return;
	}
	rq_displayTip(div);
	var mark = document.getElementById("dropMark_" + div.id);
	if (event.srcElement == mark) {
		event.dataTransfer.dropEffect = "move";
		event.returnValue = false;
		return;
	}
	var dt = rq_getDropTarget(event.srcElement);
	rq_showDropMark(div, dt, mark);
	if (dt == null) {
		event.dataTransfer.dropEffect = "none";
	} else {
		event.dataTransfer.dropEffect = "move";
	}
	event.returnValue = false;
}
function rq_dragend(div) {
	if (div.dragTip != null) {
		div.dragTip.style.display = "none";
	}
	rq_hideDropMark(document.getElementById("dropMark_" + div.id));
	div.dragSrc = null;
	div.dropTarget = null;
	div.ondragend = null;
	div.ondragenter = null;
	div.ondragover = null;
	div.ondragleave = null;
	div.ondrop = null;
}
function rq_dragleave(div) {
	rq_hideDropMark(document.getElementById("dropMark_" + div.id));
}
function rq_drop(div) {
	var src = div.dragSrc;
	var t = div.dropTarget;
	if (src == null || t == null) {
		return;
	}
	if (src == t) {
		return;
	}
	var sdds = src.getAttribute("dds");
	var tdds = t.getAttribute("dds");
	if (sdds == tdds) {
		return;
	}
	var st = src.getAttribute("ddtype");
	var tt = t.getAttribute("ddtype");
	var olap = eval(div.id + "_olap");
	if (st == "1") {
		var dims = olap.colDims;
		if (tt == "1") {
			dims = rq_removeItem(dims, sdds);
			dims = rq_insItem(dims, tdds, sdds, t.insPos);
			if (dims == olap.colDims) {
				return;
			}
			olap.colDims = dims;
			rq_expandDim(tdds, t.getAttribute("value"), olap);
			rq_requestOlap(div);
			return;
		} else {
			if (tt == "2") {
				var rdims = olap.rowDims;
				dims = rq_removeItem(dims, sdds);
				rdims = rq_insItem(rdims, tdds, sdds, t.insPos);
				rq_expandDim(tdds, t.getAttribute("value"), olap);
				olap.colDims = dims;
				olap.rowDims = rdims;
				rq_requestOlap(div);
				return;
			} else {
				if (tt == "3") {
					dims = rq_removeItem(dims, sdds);
					olap.colDims = dims;
					rq_requestOlap(div);
					return;
				}
			}
		}
	} else {
		if (st == "2") {
			var dims = olap.rowDims;
			if (tt == "1") {
				var cdims = olap.colDims;
				dims = rq_removeItem(dims, sdds);
				cdims = rq_insItem(cdims, tdds, sdds, t.insPos);
				rq_expandDim(tdds, t.getAttribute("value"), olap);
				olap.colDims = cdims;
				olap.rowDims = dims;
				rq_requestOlap(div);
				return;
			} else {
				if (tt == "2") {
					dims = rq_removeItem(dims, sdds);
					dims = rq_insItem(dims, tdds, sdds, t.insPos);
					if (dims == olap.rowDims) {
						return;
					}
					rq_expandDim(tdds, t.getAttribute("value"), olap);
					olap.rowDims = dims;
					rq_requestOlap(div);
					return;
				} else {
					if (tt == "3") {
						dims = rq_removeItem(dims, sdds);
						olap.rowDims = dims;
						rq_requestOlap(div);
						return;
					}
				}
			}
		} else {
			if (st == "3") {
				if (tt == "1") {
					var cdims = olap.colDims;
					cdims = rq_insItem(cdims, tdds, sdds, t.insPos);
					rq_expandDim(tdds, t.getAttribute("value"), olap);
					olap.colDims = cdims;
					rq_requestOlap(div);
					return;
				} else {
					if (tt == "2") {
						var rdims = olap.rowDims;
						rdims = rq_insItem(rdims, tdds, sdds, t.insPos);
						rq_expandDim(tdds, t.getAttribute("value"), olap);
						olap.rowDims = rdims;
						rq_requestOlap(div);
						return;
					}
				}
			}
		}
	}
}
function rq_removeItem(s1, s2) {
	if (s1 == "") {
		return "";
	}
	var a = s1.split(",");
	for (var i = 0; i < a.length; i++) {
		if (s2 == a[i]) {
			a.splice(i, 1);
			break;
		}
	}
	var s = "";
	for (var i = 0; i < a.length; i++) {
		if (s.length > 0) {
			s += ",";
		}
		s += a[i];
	}
	return s;
}
function rq_insItem(s1, s2, s3, flag) {
	if (s1 == "") {
		return s3;
	}
	if (s2 == "") {
		if (flag == "q") {
			s1 = s3 + "," + s1;
		} else {
			s1 += "," + s3;
		}
	} else {
		s1 = "," + s1 + ",";
		var s4 = "," + s2 + ",";
		var pos = s1.indexOf(s4);
		if (pos >= 0) {
			if (flag == "q") {
				s1 = s1.substring(0, pos) + "," + s3 + s1.substring(pos);
			} else {
				pos += s4.length;
				s1 = s1.substring(0, pos) + s3 + "," + s1.substring(pos);
			}
		}
		s1 = s1.substring(1);
		s1 = s1.substring(0, s1.length - 1);
	}
	return s1;
}
function rq_expandDim(dim, value, olap) {
	if (dim == "" || dim == null) {
		return;
	}
	if (value == null || value == "") {
		return;
	}
	var s = olap.expandInfo;
	if (s == "") {
		s = dim + "," + value;
	} else {
		if ((";" + s + ";").indexOf(";" + dim + "," + value + ";") < 0) {
			s += ";" + dim + "," + value;
		}
	}
	olap.expandInfo = s;
}
var rq_onloadMethods = new Array();
var rq_onloadTimer = setInterval("rq_executeOnloadMethods()", 200);
function rq_addOnloadMethod(m) {
	rq_onloadMethods[rq_onloadMethods.length] = m;
}
function rq_executeOnloadMethods() {
	if (document.readyState == "complete") {
		clearInterval(rq_onloadTimer);
		if (rq_onloadMethods.length == 0) {
			return;
		}
		for (var i = 0; i < rq_onloadMethods.length; ) {
			var m = rq_onloadMethods[i];
			rq_onloadMethods.splice(i, 1);
			eval(m);
		}
	}
}
function rq_initOlapSize(divName) {
	var div = document.getElementById(divName);
	var W = div.clientWidth;
	var H = div.clientHeight;
        var __W = -1;
        var __H = -1;
	if ( W == 0 ){
               __W = W;
               W = document.getElementById( divName + "_dimTitle" ).offsetWidth  +
                   document.getElementById( divName + "_topdiv" ).offsetWidth  +
                   document.getElementById( divName + "_corner" ).offsetWidth ;
	}
	if ( H == 0 ){
               __H = H;
               H = document.getElementById( divName + "_contentdiv" ).offsetHeight +
                   document.getElementById( divName + "_topdiv" ).offsetHeight ;
        }

	var dimTitle = document.getElementById(divName + "_dimTitle");
	var dimListTbl = document.getElementById(divName + "_dimListTbl");
	if (dimListTbl != null) {
		var dimW = dimTitle.offsetWidth;
		var dimW1 = dimListTbl.offsetWidth;
		if (dimW > dimW1) {
			dimListTbl.style.width = dimW;
		} else {
			dimTitle.style.width = dimW1;
		}
	}
	var title = document.getElementById(divName + "_title");
	var dimDiv = document.getElementById(divName + "_dimList");
	var dimDivH = H - dimTitle.offsetHeight;
	if (title != null) {
		dimDivH -= title.offsetHeight;
	}
        if ( __W != 0 || __H !=0 ){  ///////////////////////////////////////////////////////
	    dimDiv.style.height = dimDivH;
	    dimDiv.style.width = dimTitle.offsetWidth;
            dimTitle.parentElement.style.width = dimTitle.offsetWidth;
        }

	var contentTbl = document.getElementById(divName + "_content");
	var topTbl = document.getElementById(divName + "_top");
	var leftTbl = document.getElementById(divName + "_left");
	var cornerTbl = document.getElementById(divName + "_corner");
	var row = contentTbl.rows[0];
	var contentTblW = 0;
	for (var c = 0; c < row.cells.length; c++) {
		var topCell = document.getElementById(divName + "_topcol" + c);
		var w1 = topCell.offsetWidth;
		topCell.initWidth = w1;
	}
	for (var c = 0; c < row.cells.length; c++) {
		var cell = row.cells[c];
		var w = cell.offsetWidth;
		var topCell = document.getElementById(divName + "_topcol" + c);//rq_lookupTopCell( topTbl, c );
		var w1 = topCell.initWidth;
		//alert( w1 );
		if (w > w1) {
			topCell.style.width = w;
			cell.style.width = w;
			contentTblW += w;
		} else {
			cell.style.width = w1;
			topCell.style.width = w1;
			contentTblW += w1;
		}
	}
        if ( __W != 0 || __H !=0 ){  /////////////////////////////////////////////////////
            topTbl.style.width = contentTblW;
        }
        contentTbl.style.width = contentTblW;
        cornerTbl.style.height = topTbl.offsetHeight;

	var cw = cornerTbl.offsetWidth;
	var lw = leftTbl.offsetWidth;
	var cornerCol = document.getElementById(divName + "_cornerCol");
	if (cw > lw) {
		cornerCol.style.width = cw - 8;
		cornerTbl.style.width = cw;
		leftTbl.style.width = cw;
	} else {
		cornerCol.style.width = lw - 8;
		cornerTbl.style.width = lw;
		leftTbl.style.width = lw;
	}
	for (var c = 0; ; c++) {
		var leftCol = document.getElementById(divName + "_leftcol" + c);
		if (leftCol == null) {
			break;
		}
		var leftColW = leftCol.offsetWidth - 8;
		if (leftColW < 0) {
			leftColW = 0;
		}
		leftCol.style.width = leftColW;
	}
        if ( __W != 0 || __H !=0 ){  /////////////////////////////////////////////////////
                leftTbl.style.width = leftTbl.offsetWidth;
        }

	for (var r = 0; r < contentTbl.rows.length; r++) {
		row = contentTbl.rows[r];
		var leftRow = leftTbl.rows[r];
		var h = row.offsetHeight;
		var h1 = leftRow.offsetHeight;
		if (h > h1) {
			leftRow.style.height = h;
			row.style.height = h;
		} else {
			row.style.height = h1;
			leftRow.style.height = h1;
		}
	}
	topTbl.style.tableLayout = "fixed";
	leftTbl.style.tableLayout = "fixed";
	contentTbl.style.tableLayout = "fixed";
	cornerTbl.style.tableLayout = "fixed";
	var mainW = W - dimTitle.parentElement.offsetWidth;
	var mainH = H;
	if (title != null) {
		mainH -= title.offsetHeight;
	}
	var contentW = contentTbl.offsetWidth;
	var contentH = contentTbl.offsetHeight;
	var contentDiv = document.getElementById(divName + "_contentdiv");
	var topDiv = document.getElementById(divName + "_topdiv");
	var leftDiv = document.getElementById(divName + "_leftdiv");
	var leftW = leftDiv.offsetWidth;
	var topH = topDiv.offsetHeight;
	var topW = mainW - leftW;
	if (mainH - topH < contentH) {
		topW -= 16;
	}
	if (topW < 0) {
		topW = 0;
	}
        if ( __W != 0 || __H !=0 ){  /////////////////////////////////////////////////////
                topDiv.style.width = topW;
        }

	var leftH = mainH - topH;
	if (mainW - leftW < contentW) {
		leftH -= 16;
	}
	if (leftH < 0) {
		leftH = 0;
	}
        if ( __W != 0 || __H !=0 ){  /////////////////////////////////////////////////////
               leftDiv.style.height = leftH;
        }

	var cw = mainW - leftW < 0 ? 0 : mainW - leftW;
        if ( __W != 0 || __H !=0 ){  /////////////////////////////////////////////////////
                contentDiv.style.width = cw;
                contentDiv.style.height = mainH - topH < 0 ? 0 : mainH - topH;
        }
}
function RQOlap(exp, field) {
	this.exp = exp;
	this.field = field;
	this.rowDims = "";
	this.colDims = "";
	this.hideInfo = "";
	this.expandInfo = "";
	this.dimValues = "";
}
function rq_doubleClick(div) {
	var src = event.srcElement;
	while (src.tagName != "TD") {
		src = src.parentElement;
	}
	var olap = eval(div.id + "_olap");
	var expand = src.getAttribute("expand");
	if (expand != null) {
		var dimName = src.getAttribute("dds");
		var value = src.getAttribute("value");
		if (expand == "0") {
			if (olap.expandInfo.length > 0) {
				olap.expandInfo += ";";
			}
			olap.expandInfo += dimName + "," + value;
			rq_requestOlap(div);
			return;
		} else {
			olap.expandInfo = rq_rmDimValue(olap.expandInfo, dimName, value);
			rq_requestOlap(div);
			return;
		}
	} else {
		if (src.getAttribute("isCorner") == 1) {
			rq_showExpMenu(div, src);
		} else {
			var rowNo = src.getAttribute("rowNo");
			var colNo = src.getAttribute("colNo");
			if (rowNo != null && colNo != null) {
				var form = document.getElementById(div.id + "_detailform");
				form.action.value = "19";
				form.olap_expandInfo.value = olap.expandInfo;
				form.olap_hideInfo.value = olap.hideInfo;
				form.olap_rowDims.value = olap.rowDims;
				form.olap_colDims.value = olap.colDims;
				form.rowNo.value = rowNo;
				form.colNo.value = colNo;
				form.submit();
			}
		}
	}
}
function rq_rmDimValue(s, dim, value) {
	var tmp = s.split(";");
	for (var i = 0; i < tmp.length; i++) {
		if (dim + "," + value == tmp[i]) {
			tmp.splice(i, 1);
			break;
		}
	}
	var s = "";
	for (var i = 0; i < tmp.length; i++) {
		if (s.length > 0) {
			s += ";";
		}
		s += tmp[i];
	}
	return s;
}
function rq_requestOlap(div) {
	var mb = document.getElementById(div.id + "_mengban");
	var c = rq_getCood(div);
	mb.style.left = c[0];
	mb.style.top = c[1];
	mb.style.width = div.offsetWidth;
	mb.style.height = div.offsetHeight;
	mb.style.paddingTop = div.offsetHeight / 2;
	mb.style.display = "";
	var form = document.getElementById(div.id + "_form");
	var olap = eval(div.id + "_olap");
	form.olap_exp.value = olap.exp;
	form.olap_field.value = olap.field;
	form.olap_rowDims.value = olap.rowDims;
	form.olap_colDims.value = olap.colDims;
	form.olap_expandInfo.value = olap.expandInfo;
	form.olap_hideInfo.value = olap.hideInfo;
	form.submit();
}
function rq_olapScroll(name) {
	var contentDiv = document.getElementById(name + "_contentdiv");
	var topDiv = document.getElementById(name + "_topdiv");
	topDiv.scrollLeft = contentDiv.scrollLeft;
	var leftDiv = document.getElementById(name + "_leftdiv");
	leftDiv.scrollTop = contentDiv.scrollTop;
}
function rq_contextMenu(div) {
	var src = event.srcElement;
	if (src.getAttribute("isCorner") == 1) {
		rq_showExpMenu(div, src);
	} else {
		if (src.tagName == "NOBR") {
			src = src.parentElement;
		}
		var dim = src.getAttribute("dds");
		var ddtype = src.getAttribute("ddtype");
		if (dim != null && dim != "" && ddtype != "3") {
			rq_showHideValuesMenu(div, src, dim);
		}
	}
	return false;
}
function rq_showExpMenu(div, src) {
	var menu = document.getElementById(div.id + "_expmenu");
	var c = rq_getCood(src);
	menu.style.top = c[1] + event.offsetY + 10;
	menu.style.left = c[0] + event.offsetX + 10;
	menu.style.display = "";
}
function rq_hideExpMenu(divName) {
	var menu = document.getElementById(divName + "_expmenu");
	menu.style.display = "none";
}
function rq_statisticChanged(divName) {
	rq_hideExpMenu(divName);
	var div = document.getElementById(divName);
	var box = document.getElementById(divName + "_expbox");
        var cols = document.getElementById(divName + "_expcol");
        if ( cols == null ) {
                return;
        }
	//var cols = eval(divName + "_expcol");
	var col = "";
	if (cols.length) {
		for (var i = 0; i < cols.length; i++) {
			if (cols[i].checked) {
				col = cols[i].getAttribute("value");
				break;
			}
		}
	} else {
		col = cols.getAttribute("value");
	}
	var olap = eval(divName + "_olap");
	if (olap.exp.toLowerCase() == box.value && olap.field == col) {
		return;
	}
	olap.exp = box.value;
	olap.field = col;
	rq_requestOlap(div);
}
function rq_showHideValuesMenu(div, src, dim) {
	var menu = document.getElementById(div.id + "_hidevaluesmenu");
	var olap = eval(div.id + "_olap");
	var list;
	var values = olap.dimValues.split(";");

	for (var i = 0; i < values.length; i++) {
		list = values[i].split(",");
		if (list[0] == dim) {
			break;
		}
	}
	var s = "<table cellSpacing=0 cellPadding=2 border=0>";
	for (var i = 1; i < list.length; i++) {
		var value = list[i];
                var real;
                var dis;
                if(value.indexOf(":")>0){
                    var tmps=value.split(":");
                    real=tmps[0];
                    dis=tmps[1];
                }
                else{
                    real=value;
                    dis=value;
                }

		s += "<tr><td style=\"font-size:12px\"><input type=checkbox value=\""+real+"\" style=\"vertical-align:middle\"";
		if ((";" + olap.hideInfo + ";").indexOf(";" + dim + "," + real + ";") < 0) {
			s += " checked";
		}
		s += ">" + dis + "</td></tr>";
	}
	s += "</table>";

	menu.childNodes[0].outerHTML = s;
	menu.dim = dim;
	var c = rq_getCood(src);
	var x = c[0] + event.offsetX;
	var y = c[1] + event.offsetY;
	var pdiv = src;
	while (pdiv.tagName != "DIV") {
		pdiv = pdiv.parentElement;
	}
	if (pdiv.id) {
		x -= pdiv.scrollLeft;
		y -= pdiv.scrollTop;
	}
	menu.style.top = y + 10;
	menu.style.left = x + 10;
	menu.style.display = "";
}
function rq_hideValuesMenu(divName) {
	var menu = document.getElementById(divName + "_hidevaluesmenu");
	menu.style.display = "none";
}
function rq_hideValuesChanged(divName) {
	rq_hideValuesMenu(divName);
	var menu = document.getElementById(divName + "_hidevaluesmenu");
	var dim = menu.dim;
	var olap = eval(divName + "_olap");
	var table = menu.childNodes[0];
	for (var i = 0; i < table.rows.length; i++) {
		var cell = table.rows[i].childNodes[0];
		var box = cell.childNodes[0];
		//var value = cell.innerText;
                var value=box.value;
		if (box.checked) {
			olap.hideInfo = rq_rmDimValue(olap.hideInfo, dim, value);
		} else {
			if ((";" + olap.hideInfo + ";").indexOf(";" + dim + "," + value + ";") < 0) {
				if (olap.hideInfo.length > 0) {
					olap.hideInfo += ";";
				}
				olap.hideInfo += dim + "," + value;
			}
		}
	}
	rq_requestOlap(document.getElementById(divName));
}
function rq_showGraph(divName, type) {
	var form = document.getElementById(divName + "_detailform");
	var olap = eval(divName + "_olap");
	form.action.value = "20";
	form.olap_expandInfo.value = olap.expandInfo;
	form.olap_hideInfo.value = olap.hideInfo;
	form.olap_rowDims.value = olap.rowDims;
	form.olap_colDims.value = olap.colDims;
	form.olap_exp.value = olap.exp;
	form.olap_field.value = olap.field;
	form.graphType.value = type;
	form.submit();
}


var autoCalcOnlyOnSubmit = false;
// BEGIN
var __AA = "请";
var __BB = "请在";
var __DD = "单元格";
var __EE = "输入数字值！";
var __CC = "输入整数值！";
var __FF = "输入有效的日期！";
var __GG = "输入全是由数字组成的字符串！";
var __HH = "输入正确的Email地址！";
var __II = "数据不满足有效性要求！";
var __JJ = "关键字段取值单元格";
var __KK = "不存在！请检查更新设置";
var __LL = "关键字段单元格";
var __MM = "未输入值！";
var __NN = "字段取值单元格";
var __OO = "不存在！请检查更新设置";
var __PP = "双击上载文件";
var __QQ = "switchCase函数参数太少，至少应有4个参数，正确格式为：\n\nswitchCase( 变量或常量, 值1, 返回值1, [值2, 返回值2, ......]缺省返回值 )";
var __RR = "switchCase函数参数个数错误，应为双数，正确格式为：\n\nswitchCase( 变量或常量, 值1, 返回值1, [值2, 返回值2, ......]缺省返回值 )";
var __SS = "输入文件路径";
var __TT = "无法保存文件";


// END

function _initInput( table ) {
	table.currEditor = null;
	document.body.onkeydown = function(){ if( event.keyCode == 8 && !( event.srcElement.tagName == "INPUT" && ( event.srcElement.type == "text" || event.srcElement.type == "file" || event.srcElement.type == "password" ) ) && event.srcElement.tagName != "TEXTAREA" ) return false;};
        _initInputVar();//init
}

function _getReportName( table ) {
	var pos = table.id.indexOf( "_$_" );
	if( pos < 0 ) return table.id;
	else return table.id.substring( 0, pos );
}

function _submitEditor2( table ) {
	var editor = table.currEditor;
	var valueChanged = true;
	if( editor != null && editor.editingCell != null ) {
		var disp = editor.value;
		var value = editor.value;
		switch( editor.editingCell.editStyle ) {
			case "1":
				if( editor.editingCell.digits != null ) {
					var i = 0;
					while( i < value.length ) {
						var ch = value.charAt( i );
						if( ch == "," || ch == "$" || ch == "%" || ch == "￥" ) value = value.substring( 0, i ) + value.substring( i + 1 );
						else i++;
					}
				}
				var inputDataType = editor.editingCell.inputDataType;
				if( ! _checkDataType( inputDataType, value, "" ) ) return false;
				if( value == editor.oldValue ) {
					value = editor.editingCell.value;
					valueChanged = false;
				}
				editor.style.display = "none";
				break;
			case "2":
			case "3":
				if( editor.selectedIndex < 0 ) {
					disp = editor.editingCell.innerText;
					value = editor.editingCell.value;
				}
				else {
					value = editor.getValue();
					disp = editor.getDisp();
				}
				editor.Table.style.display = "none";
				break;
			case "9":
				disp = "";
				for( var k = 0; k < value.length; k++ ) disp += "*";
				editor.style.display = "none";
				break;
			default:
				editor.style.display = "none";
		}
		editor.editingCell.innerText = disp;
		editor.editingCell.value = value;
		if( editor.editingCell.editStyle == "1" || editor.editingCell.editStyle == "2" || editor.editingCell.editStyle == "3" || editor.editingCell.editStyle == "0" || editor.editingCell.editStyle == "9" ) {
			var dataValid = editor.editingCell.dataValid;
			if( dataValid != null && dataValid.length > 0 ) {
				if( table.isli ) {
					li_currTbl = table;
					li_currCell = editor.editingCell;
				}
				if( ! eval( dataValid ) ) {
					editor.oldValue = value;
					if( editor.style ) editor.style.display = "block";
					else editor.Table.style.display = "block";
					return false;
				}
			}
			var cellName = editor.editingCell.id;
			cellName = cellName.substring( cellName.lastIndexOf( "_" ) + 1 );
			if( valueChanged && !autoCalcOnlyOnSubmit ) {
				if( !table.isli ) eval( _getReportName( table ) + "_autoCalc( '" + cellName + "' )" );
			}
			if( valueChanged ) {
				table.changed = true;
				var filterCells = editor.editingCell.filterCells;
				if( filterCells != null ) {
					var fcs = filterCells.split( "," );
					for( var i = 0; i < fcs.length; i++ ) {
						var fc = document.getElementById( fcs[i] );
						var ds = eval( fc.dataSet );
						fc.editConfig = ds.filter( fc.filterExp );
						fc.value = "";
						fc.innerHTML = "";
					}
				}
				if( table.isli ) {
					var editingRow = editor.editingCell.parentElement;
					if( editingRow.status == "0" ) editingRow.status = "1";
					else if( editingRow.status == "2" ) editingRow.status = "3";
					_calcTbl( table, editor.editingCell );
				}
			}
		}
		editor.editingCell = null;
		table.currEditor = null;
		_formatData( table );
	}
	return true;
}

function _setEditingValue( editingObj, value, disp ) {
	if( editingObj.tagName == "TD" ) {
		var table = _lookupTable( editingObj );
		var valueChanged = false;
		if( value != editingObj.value ) valueChanged = true;
		editingObj.innerText = disp;
		editingObj.value = value;
		var dataValid = editingObj.dataValid;
		if( dataValid != null && dataValid.length > 0 ) {
			if( table.isli ) {
				li_currTbl = table;
				li_currCell = editingObj;
			}
			if( ! eval( dataValid ) ) {
				editingObj.innerText = "";
				editingObj.value = "";
				return false;
			}
		}
		var cellName = editingObj.id;
		cellName = cellName.substring( cellName.lastIndexOf( "_" ) + 1 );
		if( valueChanged && !autoCalcOnlyOnSubmit ) {
			if( !table.isli ) eval( _getReportName( table ) + "_autoCalc( '" + cellName + "' )" );
		}
		if( valueChanged ) {
			table.changed = true;
			if( table.isli ) {
				var editingRow = editingObj.parentElement;
				if( editingRow.status == "0" ) editingRow.status = "1";
				else if( editingRow.status == "2" ) editingRow.status = "3";
				_calcTbl( table, editingObj );
			}
		}
	}
	else if( editingObj.tagName == "INPUT" ) {
		editingObj.value = value;
    	var dataValid = editingObj.dataValid;
    	if( dataValid != null && dataValid.length > 0 ) {
    		if( ! eval( dataValid ) ) {
    			editingObj.value = "";
    			return false;
    		}
    	}
	}
	return true;
}

function _submitEditor( table ) {
	if( !_submitEditor2( table ) ) return false;
	var name = _getReportName( table );
	var otherTable = document.getElementById( name + "_$_corner" );
	if( otherTable != null && otherTable != table ) {
		if( !_submitEditor2( otherTable ) ) return false;
	}
	otherTable = document.getElementById( name + "_$_top" );
	if( otherTable != null && otherTable != table ) {
		if( !_submitEditor2( otherTable ) ) return false;
	}
	otherTable = document.getElementById( name + "_$_left" );
	if( otherTable != null && otherTable != table ) {
		if( !_submitEditor2( otherTable ) ) return false;
	}
	otherTable = document.getElementById( name );
	if( otherTable != null && otherTable != table ) {
		if( !_submitEditor2( otherTable ) ) return false;
	}
	return true;
}

function _checkDataType( type, value, cellName ) {
	if( value.length == 0 ) return true;
	if( cellName.length > 0 ) cellName = __BB + cellName + __DD;
	else cellName = __AA;
	switch( type ) {
		case "1": return true;
		case "2":
			if( isNaN( value ) ) {
				alert( cellName + __EE );
				return false;
			}
			return true;
		case "3":
			var r = value.match(/^(\d{1,4})(-|\/)(\d{1,2})\2(\d{1,2})$/);
   			if( r == null ) {
   				alert( cellName + __FF );
   				return false;
   			}
   			var d = new Date( r[1], r[3]-1, r[4] );
   			if( ! ( d.getFullYear() == r[1] && ( d.getMonth()+1 ) == r[3] && d.getDate() == r[4] ) ) {
				alert( cellName + __FF );
   				return false;
   			}
			return true;
		case "4":
			if( isNaN( value ) ) {
				alert( cellName + __GG );
				return false;
			}
			return true;
		case "5":
			var pos = value.indexOf( "@" );
			if( pos < 1 || pos == value.length - 1 ) {
				alert( cellName + __HH  );
				return false;
			}
			return true;
		case "6":
			if( isNaN( value ) || value.indexOf( "." ) >= 0 ) {
				alert( cellName + __CC );
				return false;
			}
			return true;
	}
	return true;
}

function _hideEditor() {
	var cell = event.srcElement;
	var table = _lookupTable( cell );
	_submitEditor( table );
	try {
		_hiddenCalendar();
	}catch( e ) {}
	try {
		tree_hide();
	}catch( e ) {}
	if( document.body._jsHideFuncs != null ) {   //隐藏自定义编辑控件
		for( var i = 0; i < document.body._jsHideFuncs.length; i++ ) {
			try { eval( document.body._jsHideFuncs[i] ); }catch( e ) {}
		}
	}
}

function _displayEditor() {
	try {
		_hiddenCalendar();
	}catch( e ) {}
	try {
		tree_hide();
	}catch( e ) {}
	var cell = event.srcElement;
	_bindingEditor( cell );
}

function _bindingEditor( cell ) {
	var table = _lookupTable( cell );
	if( ! _submitEditor( table ) ) return;
	var editor = _lookupEditor( table, cell );
	table.currEditor = editor;
	_setRowColBackColor( cell );
	_setEditorStyle( editor, cell );
}

function _setRowColBackColor( cell ) {
	var rowbkcolor = "#d1f2fe", colbkcolor = "";
	try { rowbkcolor = _editingRowBackColor; } catch(e){}
	try { colbkcolor = _editingColBackColor; } catch(e){}
	var table = _lookupTable( cell );
	_setTableEditingFlag( table, cell, rowbkcolor, colbkcolor );
	var name = _getReportName( table );
	var otherTable = document.getElementById( name + "_$_corner" );
	if( otherTable != null && otherTable != table ) _setTableEditingFlag( otherTable, null, rowbkcolor, colbkcolor );
	otherTable = document.getElementById( name + "_$_top" );
	if( otherTable != null && otherTable != table ) _setTableEditingFlag( otherTable, null, rowbkcolor, colbkcolor );
	otherTable = document.getElementById( name + "_$_left" );
	if( otherTable != null && otherTable != table ) _setTableEditingFlag( otherTable, null, rowbkcolor, colbkcolor );
	otherTable = document.getElementById( name );
	if( otherTable != null && otherTable != table ) _setTableEditingFlag( otherTable, null, rowbkcolor, colbkcolor );
}

function  _setTableEditingFlag( table, cell, rowbkcolor, colbkcolor ) {
	if( table.currCell != null ) {   //将原光标所在行列的背景色恢复
		var c = table.currCell;
		if( rowbkcolor != "" ) {
			var r = c.parentElement;
			for( var i = 0; i < r.cells.length; i++ ) {
				var tmpCell = r.cells[i];
				if( tmpCell.oldBkcolor != null ) {
					tmpCell.style.backgroundColor = tmpCell.oldBkcolor;
				}
			}
		}
		if( colbkcolor != "" ) {
			var s = c.id.substring( c.id.lastIndexOf( "_" ) + 1 );
			var rc = _toRowCol( s );
			var col = rc[1];
			for( var i = 0; i < table.rows.length; i++ ) {
				var tmpCell = null;
				try { tmpCell = eval( _getReportName( table ) + "_" + _toExcelNotation( i + rc[0] - r.rowIndex, col ) ); }catch(e){}
				if( tmpCell != null && tmpCell.oldBkcolor != null ) tmpCell.style.backgroundColor = tmpCell.oldBkcolor;
			}
		}
	}
	if( cell != null ) {    //设置新光标所在行列的背景色
		if( rowbkcolor != "" ) {
			var r = cell.parentElement;
			for( var i = 0; i < r.cells.length; i++ ) {
				var tmpCell = r.cells[i];
				if( tmpCell != cell ) {
					tmpCell.oldBkcolor = tmpCell.currentStyle.backgroundColor;
					tmpCell.style.backgroundColor = rowbkcolor;
				}
			}
		}
		if( colbkcolor != "" ) {
			var s = cell.id.substring( cell.id.lastIndexOf( "_" ) + 1 );
			var rc = _toRowCol( s );
			var col = rc[1];
			for( var i = 0; i < table.rows.length; i++ ) {
				var tmpCell = null;
				try { tmpCell = eval( _getReportName( table ) + "_" + _toExcelNotation( i + rc[0] - r.rowIndex, col ) ); }catch(e){}
				if( tmpCell != null && tmpCell != cell ) {
					tmpCell.oldBkcolor = tmpCell.currentStyle.backgroundColor;
					tmpCell.style.backgroundColor = colbkcolor;
				}
			}
		}
	}
	table.currCell = cell;
}

function _lookupTable( cell ) {
	var table = cell;
	while( table.tagName != "TABLE" ) {
		table = table.parentElement;
	}
	return table;
}

function _lookupEditor( table, cell ) {
	if( !cell.writable ) return null;
	var editStyle = cell.editStyle;
	if( editStyle == null ) editStyle = "1";
	var editor = null;
	switch( editStyle ) {
		case "0":
			try {
				editor = eval( table.id + "_textArea" );
			}catch( exception ) {
				var border = "";
				try {
					border += "border-left:" + _editorBorderLeft;
					border += ";border-right:" + _editorBorderRight;
					border += ";border-top:" + _editorBorderTop;
					border += ";border-bottom:" + _editorBorderBottom;
				}catch( e ) {
					border = "border: 1px solid red";
				}
				document.body.insertAdjacentHTML( "AfterBegin", "<textArea id=\"" + table.id + "_textArea\" style=\"position:absolute;" + border + ";display:none;zIndex:100\" ></textArea>" );
				editor = eval( table.id + "_textArea" );
				editor.onkeyup = _editorKeyPress;
			}
			editor.value = cell.value;
			editor.style.display = "block";
			if( table.selectText != null ) editor.select();
			break;
		case "2":
		case "3":
			editor = eval( table.id + "_listBox" );
			if( editor.TitleTable.cells(0) == null ) {
				editor = SS_write( "<select style='width:10px'><option></option></select>" );
			}
			if( cell.editConfig != null ) {
				var configs = cell.editConfig;
				if( configs.indexOf( "ref:" ) == 0 ) {
					if( cell.dataSet ) configs = "";
					else configs = eval( configs.substring( 4 ) ).editConfig;
				}
				if( configs == "" && cell.dataSet ) {
					var ds = eval( cell.dataSet );
					cell.editConfig = ds.filter( cell.filterExp );
					configs = cell.editConfig;
				}
				if( editor.configs != configs ) {
					editor.configs = configs;
					editor.clearOptions();
					var items = configs.split( ";" );
					editor.length = items.length;
					for( var i = 0; i < items.length; i++ ) {
						var item = items[i];
						var pos = item.indexOf( "," );
						var value = item.substring( 0, pos );
						var disp = item.substring( pos + 1 );
						var sync = false;
						if( i == items.length - 1 ) sync = true;
						editor.insertOption( value, disp, -1, sync );
					}
				}
			}
			editor.setValue( cell.value );
			editor.Table.style.display = "block";
			break;
		case "9":
			try {
				editor = eval( table.id + "_pwdBox" );
			}catch( exception ) {
				var border = "";
				try {
					border += "border-left:" + _editorBorderLeft;
					border += ";border-right:" + _editorBorderRight;
					border += ";border-top:" + _editorBorderTop;
					border += ";border-bottom:" + _editorBorderBottom;
				}catch( e ) {
					border = "border: 1px solid red";
				}
				document.body.insertAdjacentHTML( "AfterBegin", "<input type=password id=\"" + table.id + "_pwdBox\" style=\"position:absolute;" + border + ";display:none;zIndex:100\" >" );
				editor = eval( table.id + "_pwdBox" );
				editor.onkeyup = _editorKeyPress;
			}
			editor.value = cell.value;
			editor.oldValue = cell.value;
			editor.style.display = "block";
			if( table.selectText != null ) editor.select();
			break;
		default:
			try {
				editor = eval( table.id + "_editBox" );
			}catch( exception ) {
				var border = "";
				try {
					border += "border-left:" + _editorBorderLeft;
					border += ";border-right:" + _editorBorderRight;
					border += ";border-top:" + _editorBorderTop;
					border += ";border-bottom:" + _editorBorderBottom;
				}catch( e ) {
					border = "border: 1px solid red";
				}
				document.body.insertAdjacentHTML( "AfterBegin", "<input type=text id=\"" + table.id + "_editBox\" style=\"position:absolute;" + border + ";display:none;zIndex:100\" >" );
				editor = eval( table.id + "_editBox" );
				editor.onkeyup = _editorKeyPress;
			}
			editor.value = cell.innerText;
			editor.oldValue = cell.innerText;
			editor.style.display = "block";
			if( table.selectText != null ) editor.select();
	}
	editor.editingCell = cell;
	return editor;
}

function _setEditorStyle( editor, cell ) {
	if( editor == null ) return;
	var x = cell.offsetLeft, y = cell.offsetTop;
	var obj = cell.offsetParent;
	while( obj.tagName != 'BODY' ) {
		x += obj.offsetLeft + obj.clientLeft;
		y += obj.offsetTop + obj.clientTop;
		obj = obj.offsetParent;
	}
	var dx, dy;
	var isScroll = document.getElementById( cell.id.substring( 0, cell.id.lastIndexOf( "_" ) ) + "_contentdiv" ) != null;
	if( isScroll ) {
		var div = cell.parentElement;
		while( div.tagName != "DIV" || div.id == "div_" + cell.id.substring( 0, cell.id.lastIndexOf( "_" ) ) ) div = div.parentElement;
		x = x - div.scrollLeft;
		y = y - div.scrollTop;
		dx = div.offsetLeft;
		dy = div.offsetTop;
		obj = div.offsetParent;
		while( obj.tagName != 'BODY' ) {
			dx += obj.offsetLeft + obj.clientLeft;
			dy += obj.offsetTop + obj.clientTop;
			obj = obj.offsetParent;
		}
	}
	switch( cell.editStyle ) {
		case "2":
		case "3":
			if( cell.currentStyle.backgroundColor != "transparent" ) editor.setBackColor( cell.currentStyle.backgroundColor );
			else editor.setBackColor( "white" );
			editor.setFontWeight( cell.currentStyle.fontWeight );
			editor.setFontColor( cell.currentStyle.color );
			editor.setFontFace( cell.currentStyle.fontFamily );
			editor.setFontItalic( cell.currentStyle.fontStyle );
			editor.setFontSize( cell.currentStyle.fontSize );
			editor.setLeft( x );
			editor.setTop( y );
			editor.setWidth( cell.offsetWidth + 1 );
			editor.setHeight( cell.offsetHeight + 1 );
			break;
		default:
			editor.style.textAlign = cell.currentStyle.textAlign;
			if( cell.currentStyle.backgroundColor != "transparent" ) editor.style.backgroundColor = cell.currentStyle.backgroundColor;
			else editor.style.backgroundColor = "white";
			editor.style.paddingLeft = cell.currentStyle.paddingLeft;
			editor.style.paddingRight = cell.currentStyle.paddingRight;
			editor.style.fontWeight = cell.currentStyle.fontWeight;
			editor.style.color = cell.currentStyle.color;
			editor.style.fontFamily = cell.currentStyle.fontFamily;
			editor.style.fontStyle = cell.currentStyle.fontStyle;
			editor.style.fontSize = cell.currentStyle.fontSize;
			editor.style.textDecoration = cell.currentStyle.textDecoration;
			editor.style.verticalAlign = cell.currentStyle.verticalAlign;
			editor.style.left = x;
			editor.style.top = y;
			editor.style.width = cell.offsetWidth + 1;
			editor.style.height = cell.offsetHeight + 1;
			editor.focus();
	}
	if( isScroll ) {
		if( y < dy || y + cell.offsetHeight > dy + div.offsetHeight - 16 ) {
			cell.scrollIntoView( false );
			_reportScroll( cell.id.substring( 0, cell.id.lastIndexOf( "_" ) ) );
		}
		if( x < dx ) {
			div.scrollLeft -= dx - x + 1;
			_reportScroll( cell.id.substring( 0, cell.id.lastIndexOf( "_" ) ) );
		}
		if( x + cell.offsetWidth > dx + div.offsetWidth - 16 ) {
			div.scrollLeft += x + cell.offsetWidth - dx - div.offsetWidth + 17;
			_reportScroll( cell.id.substring( 0, cell.id.lastIndexOf( "_" ) ) );
		}
	}
}

function _editorKeyPress() {
	var keyCode = event.keyCode;
	var flag = -1;
	var gotoNext = false;
	var editor = event.srcElement;
	if( keyCode == 39 && event.ctrlKey ) {  //right
		flag = 3;
		gotoNext = true;
	}
	if( keyCode == 13 ) {
		flag = 3;
		gotoNext = true;
		if( editor.tagName == "TEXTAREA" && !event.ctrlKey ) gotoNext = false;
	}
	if( keyCode == 37 && event.ctrlKey ) {  //left
		flag = 1;
		gotoNext = true;
	}
	if( keyCode == 9 ) {
		flag = event.shiftKey ? 1 : 3;
		gotoNext = true;
	}
	if( keyCode == 38 || keyCode == 40 ) {
		if( keyCode == 38 ) flag = 2;
		if( keyCode == 40 ) flag = 4;
		gotoNext = true;
		if( editor.tagName == "TEXTAREA" && !event.ctrlKey ) gotoNext = false;
	}
	if( gotoNext ) {
		var cell = _lookupNextCell( editor.editingCell, flag );
		if( cell != null ) _bindingEditor( cell );
	}
	if( keyCode == 9 ) return false;
	return true;
}

function _lookupNextCell( cell, flag ) {
	var table = _lookupTable( cell );
	var nextCell = null;
	var rows = table.rowCount;
	if( flag == 1 || flag == 3 ) {  //left || right
		var delta = 1;
		if( flag == 1 ) delta = -1;
		var row = cell.parentElement.rowIndex + 1, col = parseInt( cell.colNo );
		if( flag == 3 ) col = col + cell.colSpan - 1;
		var cols = table.cols;
		while( true ) {
			col += delta;
			if( col < 1 ) {
				col = cols;
				row = row - 1;
				if( row < 1 ) return null;
			}
			if( col > cols ) {
				col = 1;
				row = row + 1;
				if( row > rows ) return null;
			}
			var tmpCell = _getMergeCell( table, row, col );
			if( tmpCell == null ) return null;
			if( ! tmpCell.writable || tmpCell.style.display == "none" || tmpCell.parentElement.style.display == "none" ) {
				if( flag == 3 ) col = col + tmpCell.colSpan - 1;
				if( flag == 1 ) col = col - tmpCell.colSpan + 1;
			}
			else {
				nextCell = tmpCell;
				break;
			}
		}
	}
	else {  //2-up  4-down
		var delta = 1;
		if( flag == 2 ) delta = -1;
		var row = cell.parentElement.rowIndex + 1, col = parseInt( cell.colNo );
		if( flag == 4 ) row = row + cell.rowSpan - 1;
		while( true ) {
			row += delta;
			if( row < 1 || row > rows ) return null;
			var tmpCell = _getMergeCell( table, row, col );
			if( tmpCell == null ) return null;
			if( ! tmpCell.writable || tmpCell.style.display == "none" || tmpCell.parentElement.style.display == "none" ) {
				if( flag == 4 ) row = row + tmpCell.rowSpan - 1;
				if( flag == 2 ) row = row - tmpCell.rowSpan + 1;
			}
			else {
				nextCell = tmpCell;
				break;
			}
		}
	}
	return nextCell;
}

function _getMergeCell( table, row, col ) {  //返回包含(row,col)的单元格或合并格
	for( var i = row - 1; i >= 0; i-- ) {
		var r = table.rows[i];
		for( var j = 0; j < r.cells.length; j++ ) {
			var c = r.cells[j];
			var row1 = i + 1, col1 = parseInt( c.colNo );
			if( row1 <= row && row1 + c.rowSpan > row && col1 <= col && col1 + c.colSpan > col ) return c;
		}
	}
	return null;
}

function _toExcelNotation( row, col ) {
	var s = "";
	do {
		col--;
		var c = col % 26 + "A".charCodeAt(0);
		s = String.fromCharCode( c ) + s;
		col = Math.floor( col / 26 );
	} while ( col > 0 );
	return s + row;
}

function _toRowCol( s ) {
	var len = s.length;
	var row = 0, col = 0;
	var i = 0;
	while( i < len ) {
		var ch = s.charAt(i);
		if ( ch >= 'A' && ch <= 'Z' )
			col = col * 26 + ch.charCodeAt(0) - 'A'.charCodeAt(0) + 1;
		else break;
		i++;
	}
	row = parseInt( s.substring( i ) );
	var rc = new Array(2);
	rc[0] = row;
	rc[1] = col;
	return rc;
}

function _submitTable( table, resultInfoPage ) {
	if( ! _submitEditor( table ) ) return false;
	if( ! eval( table.id + "_checkValid()" ) ) {  //数据有效性检查
		try {
			if( batImport ) {
				parent.getResultInfo( "error", __II );
			}
		}catch(ex){}
		return false;
	}
	try {
		if( ! eval( table.id + "_userDefineValidScript()" ) ) return false;
	}catch( exception ) {}
	if( autoCalcOnlyOnSubmit ) eval( table.id + "_autoCalc( '' )" );
	var form = eval( table.id + "_submitForm" );
	var data = "";
	var otherTable = document.getElementById( table.id + "_$_corner" );
	if( otherTable != null ) {
		data = _getTableData( otherTable, data );
	}
	otherTable = document.getElementById( table.id + "_$_top" );
	if( otherTable != null ) {
		data = _getTableData( otherTable, data );
	}
	otherTable = document.getElementById( table.id + "_$_left" );
	if( otherTable != null ) {
		data = _getTableData( otherTable, data );
	}
	if( table != null ) {
		data = _getTableData( table, data );
	}
	form.data.value = data;
	try {
		if( batImport ) {
			form.pageUrl.value = resultInfoPage;
			form.backAndRefresh.value = "batImport";
		}
	}catch( e ) {}
	form.submit();
	return true;
}

function _getTableData( table, data ) {
	for( var row = 0; row < table.rows.length; row++ ) {
		var currRow = table.rows[ row ];
		for( var col = 0; col < currRow.cells.length; col++ ) {
			var currCell = currRow.cells[ col ];
			var name = currCell.id;
			name = name.substring( name.lastIndexOf( "_" ) + 1 );
			var value = currCell.value;
			if( value == null ) value = "";
			var needSubmit = false;
			switch( table.submitCells ) {
				case "0": if( currCell.updatable ) needSubmit = true; break;
				case "1": if( currCell.updatable || currCell.modifiable ) needSubmit = true; break;
				case "2": needSubmit = true; break;
			}
			if( needSubmit ) {
				if( data.length > 0 ) data += ";";
				data += name + "=" + _addEscape( value );
			}
		}
	}
	return data;
}

function _submitReport( table ) {
	if( ! _submitEditor( table ) ) return false;
	if( autoCalcOnlyOnSubmit ) eval( table.id + "_autoCalc( '' )" );
	var form = eval( table.id + "_submitForm" );
	var data = "";
	var otherTable = document.getElementById( table.id + "_$_corner" );
	if( otherTable != null ) {
		data = _getTableData( otherTable, data );
	}
	otherTable = document.getElementById( table.id + "_$_top" );
	if( otherTable != null ) {
		data = _getTableData( otherTable, data );
	}
	otherTable = document.getElementById( table.id + "_$_left" );
	if( otherTable != null ) {
		data = _getTableData( otherTable, data );
	}
	if( table != null ) {
		data = _getTableData( table, data );
	}
	form.data.value = data;
	form.submit();
	return true;
}

function _addEscape( src ) {
	try {
		var re = /\\/g;
		src = src.replace( re, "\\\\" );
		re = /\"/g;
		src = src.replace( re, "\\\"" );
		return "\"" + src + "\"";
	}catch( exception ) {
		return "\"" + src + "\"";
	}
}

function _parseValue( cell ) {
	var value = parseFloat( cell.value );
	if( cell.digits != null ) {
		if( ! isNaN( value ) ) value = parseFloat( value.toFixed( parseInt( cell.digits ) ) );
	}
	return isNaN( value ) ? 0 : value;
}

function _formatData( table ) {
	if( autoCalcOnlyOnSubmit ) return;
	for( var row = 0; row < table.rows.length; row++ ) {
		var currRow = table.rows[ row ];
		for( var col = 0; col < currRow.cells.length; col++ ) {
			var currCell = currRow.cells[ col ];
			if( currCell.digits != null ) {
				var value = parseFloat( currCell.value );
				if( ! isNaN( value ) ) {
					value = value.toFixed( parseInt( currCell.digits ) );
					currCell.value = value + "";
					//currCell.innerText = value;
				}
			}
		}
	}
}

function _formatCalcValue( cell ) {
	if( cell.digits != null ) {
		var value = parseFloat( cell.value );
		if( ! isNaN( value ) ) {
			value = value.toFixed( parseInt( cell.digits ) );
			//cell.value = value + "";
			cell.innerText = value;
		}
	}
}

function _uploadFile( url, table, ds, tblName, keyCols, keyCells, origins, fields, valueCells, currCell, ext ) {
	_submitEditor( table );
	var data = "";
	var keys = keyCells.split( "," );
	for( var i = 0; i < keys.length; i++ ) {
		var key = keys[i];
		var cell = null;
		try { cell = eval( _getReportName( table ) + "_" + key ); }
		catch( e ) {
			alert( __JJ + key + __KK );
			return;
		}
		if( cell.value.length == 0 ) {
			alert( __LL + key + __MM );
			return;
		}
	}
	var cols = valueCells.split( "," );
	for( var i = 0; i < cols.length; i++ ) {
		var col = cols[i].toUpperCase();
		var cell = null;
		try { cell = eval( _getReportName( table ) + "_" + col ); }
		catch( e ) {
			alert( __NN + col + __OO );
			return;
		}
		if( data.length > 0 ) data += ";";
		data += col + "=" + _addEscape( cell.value );
	}
	url += "&ds=" + _urlEncode( ds ) + "&data=" + _urlEncode( data ) + "&originData=" + _urlEncode( origins ) + "&ext=" + _urlEncode( ext )
			+ "&tbl=" + _urlEncode( tblName ) + "&keys=" + _urlEncode( keyCols ) + "&cols=" + _urlEncode( fields )
			+ "&cells=" + _urlEncode( valueCells ) + "&currCell=" + currCell + "&keyCells=" + keyCells;
	window.open( url, null, "left=200, top=250, height=180, width=400, status=no, resizable=yes" );
}

function _uploadPrompt( display, event ) {
	var promptBox = null;
	try {
		promptBox = eval( "___promptBox" );
	}catch( e ) {
		document.body.insertAdjacentHTML( "AfterBegin", "<table id=___promptBox style=\"display:none; BACKGROUND-COLOR: mistyrose; BORDER: blue 1px solid; FONT-FAMILY: 宋体; FONT-SIZE: 13px; HEIGHT: 26px; POSITION: absolute; WIDTH: 90px\">" +
											"<tr><td align=middle>" + __PP + "</td></tr></table>" );
		promptBox = eval( "___promptBox" );
	}
	var cell = event.srcElement;
	var x = cell.offsetLeft, y = cell.offsetTop;
	var obj = cell.offsetParent;
	while( obj.tagName != 'BODY' ) {
		x += obj.offsetLeft;
		y += obj.offsetTop;
		obj = obj.offsetParent;
	}
	promptBox.style.left = x + event.offsetX + 10;
	promptBox.style.top = y + event.offsetY + 5;
	promptBox.style.display = display;
}

function _urlEncode( str )
{
	var dst = "";
	for ( var i = 0; i < str.length; i++ )
	{
		switch ( str.charAt( i ) )
		{
			case ' ':
				dst += "+";
				break;
			case '!':
				dst += "%21";
				break;
			case '\"':
				dst += "%22";
				break;
			case '#':
				dst += "%23";
				break;
			case '$':
				dst += "%24";
				break;
			case '%':
				dst += "%25";
				break;
			case '&':
				dst += "%26";
				break;
			case '\'':
				dst += "%27";
				break;
			case '(':
				dst += "%28";
				break;
			case ')':
				dst += "%29";
				break;
			case '+':
				dst += "%2B";
				break;
			case ',':
				dst += "%2C";
				break;
			case '/':
				dst += "%2F";
				break;
			case ':':
				dst += "%3A";
				break;
			case ';':
				dst += "%3B";
				break;
			case '<':
				dst += "%3C";
				break;
			case '=':
				dst += "%3D";
				break;
			case '>':
				dst += "%3E";
				break;
			case '?':
				dst += "%3F";
				break;
			case '@':
				dst += "%40";
				break;
			case '[':
				dst += "%5B";
				break;
			case '\\':
				dst += "%5C";
				break;
			case ']':
				dst += "%5D";
				break;
			case '^':
				dst += "%5E";
				break;
			case '`':
				dst += "%60";
				break;
			case '{':
				dst += "%7B";
				break;
			case '|':
				dst += "%7C";
				break;
			case '}':
				dst += "%7D";
				break;
			case '~':
				dst += "%7E";
				break;
			default:
				dst += str.charAt( i );
				break;
		}
	}
	return dst;
}

function switchCase() {
	var len = arguments.length;
	if( len < 4 ) {
		alert( __QQ );
		return;
	}
	if( arguments[0] == arguments[1] ) return arguments[2];
	if( len > 4 ) {
		if( len % 2 == 1 ) {
			alert( __RR );
			return;
		}
		var i = 3;
		while( true ) {
			if( arguments[i] != null && arguments[i+1] != null ) {
				if( arguments[0] == arguments[i] ) return arguments[i+1];
			}
			else break;
			i += 2;
		}

	}
	return arguments[ len - 1 ];
}

function _getScriptFunctions() {
	var html = "<script language=javascript>\n";
	if( autoCalcOnlyOnSubmit ) html += "\tvar autoCalcOnlyOnSubmit = true;\n";
	else html += "\tvar autoCalcOnlyOnSubmit = false;\n";
        //add var
        html += "\tvar __AA ;\n";
        html += "\tvar __BB ;\n";
        html += "\tvar __CC ;\n";
        html += "\tvar __DD ;\n";
        html += "\tvar __EE ;\n";
        html += "\tvar __FF ;\n";
        html += "\tvar __GG ;\n";
        html += "\tvar __HH ;\n";
        html += "\tvar __II ;\n";
        html += "\tvar __JJ ;\n";
        html += "\tvar __KK ;\n";
        html += "\tvar __LL ;\n";
        html += "\tvar __MM ;\n";
        html += "\tvar __NN ;\n";
        html += "\tvar __OO ;\n";
        html += "\tvar __PP ;\n";
        html += "\tvar __QQ ;\n";
        html += "\tvar __RR ;\n";
        html += "\tvar __SS ;\n";
        html += "\tvar __TT ;\n";
        html += _initInputVar.toString() + "\n";//替换变量

	html += _initInput.toString() + "\n";
	html += _getReportName.toString() + "\n";
	html += _submitEditor.toString() + "\n";
	html += _submitEditor2.toString() + "\n";
	html += _setEditingValue.toString() + "\n";
	html += _checkDataType.toString() + "\n";
	html += _hideEditor.toString() + "\n";
	html += _displayEditor.toString() + "\n";
	html += _bindingEditor.toString() + "\n";
	html += _setRowColBackColor.toString() + "\n";
	html += _setTableEditingFlag.toString() + "\n";
	html += _lookupTable.toString() + "\n";
	html += _lookupEditor.toString() + "\n";
	html += _setEditorStyle.toString() + "\n";
	html += _editorKeyPress.toString() + "\n";
	html += _lookupNextCell.toString() + "\n";
	html += _getMergeCell.toString() + "\n";
	html += _toExcelNotation.toString() + "\n";
	html += _toRowCol.toString() + "\n";
	html += _submitTable.toString() + "\n";
	html += _getTableData.toString() + "\n";
	html += _submitReport.toString() + "\n";
	html += _addEscape.toString() + "\n";
	html += _parseValue.toString() + "\n";
	html += _formatData.toString() + "\n";
	html += _formatCalcValue.toString() + "\n";
	html += _uploadFile.toString() + "\n";
	html += _uploadPrompt.toString() + "\n";
	html += _urlEncode.toString() + "\n";
	html += switchCase.toString() + "\n";
	html += _getScriptFunctions.toString() + "\n";
	html += _saveToLocal.toString() + "\n";
	html += _tabClicked.toString() + "\n";
	html += _submitSheets.toString() + "\n";
	html += _saveSheetsToLocal.toString() + "\n";
	html += _toDate.toString() + "\n";
	try {
		SS_create.toString();
		html += "\t\tif( SS_VAR == null ) {\n";
		html += "\t\t\tvar SS_VAR = new Object();\n";
		html += "\t\t\tSS_VAR.DivDummy = document.createElement(\"DIV\");\n";
		html += "\t\t\tSS_VAR.SelectList = new Array();\n";
		html += "\t\t\tSS_VAR.bEventAttached = false;\n";
		html += "\t\t\tvar SS_CreatedElements = new Object();\n";
		html += "\t\t\tattachEvent( \"onunload\", _unloadObjects );\n";
		html += "\t\t}\n";
		html += _unloadObjects.toString() + "\n";
		html += SS_create.toString() + "\n";
		html += SS_getValue.toString() + "\n";
		html += SS_setValue.toString() + "\n";
		html += SS_getDisp.toString() + "\n";
		html += SS_setHeight.toString() + "\n";
		html += SS_setWidth.toString() + "\n";
		html += SS_setLeft.toString() + "\n";
		html += SS_setTop.toString() + "\n";
		html += SS_setFontFace.toString() + "\n";
		html += SS_setFontColor.toString() + "\n";
		html += SS_setFontSize.toString() + "\n";
		html += SS_setFontWeight.toString() + "\n";
		html += SS_setFontItalic.toString() + "\n";
		html += SS_setBackColor.toString() + "\n";
		html += SS_display.toString() + "\n";
		html += SS_write.toString() + "\n";
		html += SS_insertOption.toString() + "\n";
		html += SS_clearOptions.toString() + "\n";
		html += SS_changeOption.toString() + "\n";
		html += SS_cancelEvent.toString() + "\n";
		html += SS_isThisEventToBeCanceled.toString() + "\n";
		html += SS_createElement.toString() + "\n";
		html += SS_blurExcept.toString() + "\n";
		html += SS_syncSelectedIndex.toString() + "\n";
		html += SS_toggleTitle.toString() + "\n";
		html += SS_toggleOptions.toString() + "\n";
		html += SS_handlePropertychange.toString() + "\n";
		html += SS_handleMousewheel.toString() + "\n";
		html += SS_handleOverTitle.toString() + "\n";
		html += SS_handleOutTitle.toString() + "\n";
		html += SS_handleOverOption.toString() + "\n";
		html += SS_turnOnOption.toString() + "\n";
		html += SS_turnOffOption.toString() + "\n";
		html += SS_adjustOptionsDiv.toString() + "\n";
		html += SS_syncOptions.toString() + "\n";
		html += SS_pressTitle.toString() + "\n";
		html += SS_releaseTitle.toString() + "\n";
		html += SS_pressOption.toString() + "\n";
		html += SS_moveOption.toString() + "\n";
		html += SS_releaseOption.toString() + "\n";
		html += SS_createTable.toString() + "\n";
		html += SS_createTitleDiv.toString() + "\n";
		html += SS_createOptionsDiv.toString() + "\n";
		html += SS_createOptionTr.toString() + "\n";
	} catch( e ) {}
	try {
                //ADD VAR
                html += "\tvar __time ;\n";
                html += "\tvar __year ;\n";
                html += "\tvar __month ;\n";
                html += "\tvar __date ;\n";
                html += "\tvar __hour ;\n";
                html += "\tvar __minute ;\n";
                html += "\tvar __second ;\n";
                html += "\tvar __prevYear ;\n";
                html += "\tvar __nextYear ;\n";
                html += "\tvar __prevMonth ;\n";
                html += "\tvar __nextMonth ;\n";
                html += "\tvar __prevHour ;\n";
                html += "\tvar __nextHour ;\n";
                html += "\tvar __prevMinutes ;\n";
                html += "\tvar __nextMinutes ;\n";
                html += "\tvar __prevSeconds ;\n";
                html += "\tvar __nextSeconds ;\n";
                html += "\tvar __funMonthSelect ;\n";
                html += "\tvar __Sunday ;\n";
                html += "\tvar __Monday ;\n";
                html += "\tvar __Tuesday ;\n";
                html += "\tvar __Wednesday ;\n";
                html += "\tvar __Thursday ;\n";
                html += "\tvar __Friday ;\n";
                html += "\tvar __Saturday ;\n";
                html += "\tvar __clear ;\n";
                html += "\tvar __close ;\n";
                html += "\tvar __fontFamily ;\n";

                html += _initCalJsVar.toString() + "\n";//替换变量
		html += _createRunqianCalendar.toString() + "\n";
		html += _createIframeSyntax.toString() + "\n";
		html += _showCalendar.toString() + "\n";
		html += _funMonthSelect.toString() + "\n";
		html += _prevMonth.toString() + "\n";
		html += _nextMonth.toString() + "\n";
		html += _prevYear.toString() + "\n";
		html += _nextYear.toString() + "\n";
		html += _hiddenSelect.toString() + "\n";
		html += _hiddenCalendar.toString() + "\n";
		html += _appendZero.toString() + "\n";
		html += _trimString.toString() + "\n";
		html += _dayMouseOver.toString() + "\n";
		html += _dayMouseOut.toString() + "\n";
		html += _writeCalendar.toString() + "\n";
		html += _returnDate.toString() + "\n";
		html += _changeYear.toString() + "\n";
                html += _getDateWithFormat() + "\n";
	} catch( e ) {}
	try {
		html += tree_iconClick.toString() + "\n";
		html += tree_mouseOver.toString() + "\n";
		html += tree_mouseOut.toString() + "\n";
		html += tree_select.toString() + "\n";
		html += tree_show.toString() + "\n";
		html += tree_hide.toString() + "\n";
	} catch( e ) {}
	try {
		html += _reportScroll.toString() + "\n";
		html += _tableScrolling.toString() + "\n";
		html += _resizeScroll.toString() + "\n";
		html += _lookupDiv.toString() + "\n";
	} catch( e ) {}
	try {
		html += _rqDataSet.toString() + "\n";
		html += _setRQColNames.toString() + "\n";
		html += _setRQColTypes.toString() + "\n";
		html += _appendRQData.toString() + "\n";
		html += _filterRQDS.toString() + "\n";
	} catch( e ) {}
	html += "</scr" + "ipt>\n";
	return html;
}

function _saveToLocal( table, name ) {
	if( ! _submitEditor( table ) ) return;
	var html = "<html>\n<body>\n";
	html += _getScriptFunctions();
	try {
		while( my___select.length ) {
			my___select[0].outerHTML = "";
		}
		my___select.outerHTML = "";
	}catch( e ) {}
	try {
		while( _runqianCalendar.length ) {
			_runqianCalendar[0].outerHTML = "";
		}
		_runqianCalendar.outerHTML = "";
	}catch( e ) {}
	var div = document.getElementById( "div_" + table.id );
	if( div != null ) html += div.outerHTML + "\n";
	else html += document.body.innerHTML + "\n";
	html += "<SCRIPT language=javascript>\n";
	html += "\tvar batImport = document.location.href.indexOf( \"?batImport\" ) > 0;\n";
	html += "\tvar resultInfoPage = parent.location.href.substring( 0, parent.location.href.lastIndexOf( \"/\" ) ) + \"/getResultInfo.html\";\n";
	html += "\tif( batImport ) _submitTable( " + table.id + ", resultInfoPage );\n";
	html += "</SCR" + "IPT>\n";
	html += "</body>\n</html>";
	try {
		var fso = new ActiveXObject( "Scripting.FileSystemObject" );
		var fileDialog;
		try {
			fileDialog = eval( "_fileDialog" );
		}catch( exception ) {
			document.body.insertAdjacentHTML( "AfterBegin", "<object id=\"_fileDialog\" width=\"0px\" height=\"0px\" classid=\"clsid:F9043C85-F6F2-101A-A3C9-08002B2F49FB\" codebase=\"http://activex.microsoft.com/controls/vb5/comdlg32.cab\"></object>" );
			fileDialog = eval( "_fileDialog" );
		}
	  	fileDialog.Filter = "HTML Files (*.html) | *.html";
		fileDialog.filename = name;
		try {
			fileDialog.ShowSave();
		}catch( e ) {
			fileDialog.filename = window.prompt( __SS, name );
		}
		try {
			var f = fso.CreateTextFile( fileDialog.filename, true );
			f.writeLine( html );
			f.Close();
		}catch( e ) { alert( __TT + fileDialog.filename ); }
	}catch( exception ) {
		var form = eval( table.id + "_saveToLocalForm" );
		form.fileContent.value = html;
		form.saveAsName.value = name;
		form.submit();
	}
}

function _tabClicked( tab, sheetName ) {
	var tabs = eval( "tabs_" + sheetName );
	var currTab = eval( tabs.currTab );
	if( ! _submitEditor( eval( currTab.report ) ) ) return;
	currTab.style.backgroundColor = tabs.bkColor;
	currTab.style.color = tabs.fontColor;
	tab.style.backgroundColor = tabs.bkHLColor;
	tab.style.color = tabs.fontHLColor;
	eval( "div_" + currTab.report ).style.display = "none";
	eval( "div_" + tab.report ).style.display = "block";
	tabs.currTab = tab.id;
}

function _submitSheets( sheets, resultInfoPage ) {
	var tabs = eval( "tabs_" + sheets.id );
	if( ! _submitEditor( eval( eval( tabs.currTab ).report ) ) ) return;
	var tables = sheets.tables.split( "," );
	for( var i = 0; i < tables.length; i++ ) {
		if( ! eval( tables[i] + "_checkValid()" ) ) {  //各表数据有效性检查
			try {
				if( batImport ) {
					parent.getResultInfo( "error", __II );
				}
			}catch(ex){}
			return;
		}
	}
	try {
		if( ! eval( sheets.id + "_sheetsValid()" ) ) {   //表间数据有效性检查
			try {
				if( batImport ) {
					parent.getResultInfo( "error", __II );
				}
			}catch(ex){}
			return;
		}
	}catch( exception ) {}
	try {    //用户自定义有效性检查
		if( ! eval( sheets.id + "_userDefineValidScript()" ) ) return;
	}catch( exception ) {}

	var form = eval( sheets.id + "_submitForm" );
	for( var i = 0; i < tables.length; i++ ) {
		var table = eval( tables[i] );
		var data = "", originData = "";
		for( var row = 0; row < table.rows.length; row++ ) {
			var currRow = table.rows[ row ];
			for( var col = 0; col < currRow.cells.length; col++ ) {
				var currCell = currRow.cells[ col ];
				var name = currCell.id;
				name = name.substring( name.lastIndexOf( "_" ) + 1 );
				var value = currCell.value;
				if( value == null ) value = "";
				if( currCell.keyCell ) {
					if( data.length > 0 ) data += ";";
					data += name + "=" + _addEscape( value );
					var origin = currCell.originValue;
					if( origin == null ) origin = "";
					if( originData.length > 0 ) originData += ";";
					originData += name + "=" + _addEscape( origin );
				}
				else {
					var needSubmit = false;
					switch( table.submitCells ) {
						case "0": if( currCell.updatable ) needSubmit = true; break;
						case "1": if( currCell.updatable || currCell.modifiable ) needSubmit = true; break;
						case "2": needSubmit = true; break;
					}
					if( needSubmit ) {
						if( data.length > 0 ) data += ";";
						data += name + "=" + _addEscape( value );
					}
				}
			}
		}
		form.item( tables[i] + "_data" ).value = data;
		form.item( tables[i] + "_originData" ).value = originData;
	}
	try {
		if( batImport ) {
			form.pageUrl.value = resultInfoPage;
			form.backAndRefresh.value = "batImport";
		}
	}catch( e ) {}
	form.submit();
}

function _saveSheetsToLocal( sheets, name ) {
	var tabs = eval( "tabs_" + sheets.id );
	if( ! _submitEditor( eval( eval( tabs.currTab ).report ) ) ) return;
	var html = "<html>\n<body>\n";
	html += _getScriptFunctions();
	try {
		while( my___select.length ) {
			my___select[0].outerHTML = "";
		}
		my___select.outerHTML = "";
	}catch( exception ) {}
	html += sheets.outerHTML + "\n";
	html += "<SCRIPT language=javascript>\n";
	html += "\tvar batImport = document.location.href.indexOf( \"?batImport\" ) > 0;\n";
	html += "\tvar resultInfoPage = parent.location.href.substring( 0, parent.location.href.lastIndexOf( \"/\" ) ) + \"/getResultInfo.html\";\n";
	html += "\tif( batImport ) _submitSheets( " + sheets.id + ", resultInfoPage );\n";
	html += "</SCR" + "IPT>\n";
	html += "</body>\n</html>";
	try {
		var fso = new ActiveXObject( "Scripting.FileSystemObject" );
		var fileDialog;
		try {
			fileDialog = eval( "_fileDialog" );
		}catch( exception ) {
			document.body.insertAdjacentHTML( "AfterBegin", "<object id=\"_fileDialog\" width=\"0px\" height=\"0px\" classid=\"clsid:F9043C85-F6F2-101A-A3C9-08002B2F49FB\" codebase=\"http://activex.microsoft.com/controls/vb5/comdlg32.cab\"></object>" );
			fileDialog = eval( "_fileDialog" );
		}
	  	fileDialog.Filter = "HTML Files (*.html)|*.html";
		fileDialog.filename = name;
		try {
			fileDialog.ShowSave();
		}catch( e ) {
			fileDialog.filename = window.prompt( __SS, name );
		}
		try {
			var f = fso.CreateTextFile( fileDialog.filename, true );
			f.writeLine( html );
			f.Close();
		}catch( e ) { alert( __TT + fileDialog.filename ); }
	}catch( exception ) {
		var form = eval( sheets.id + "_saveToLocalForm" );
		form.fileContent.value = html;
		form.saveAsName.value = name;
		form.submit();
	}
}

function _toDate( s ) {
	var re = /\./g;
	s = s.replace( re, "/" );
	re = /-/g;
	s = s.replace( re, "/" );
	var ymr = s.split( "/" );
	return new Date( ymr[1] + "-" + ymr[2] + "-" + ymr[0] );
}

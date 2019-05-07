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
		switch( editor.editingCell.attributes.getNamedItem( "editStyle" ).value ) {
			case "1":
				if( editor.editingCell.attributes.getNamedItem( "digits" ) != null ) {
					var i = 0;
					while( i < value.length ) {
						var ch = value.charAt( i );
						if( ch == "," || ch == "$" || ch == "%" || ch == "￥" ) value = value.substring( 0, i ) + value.substring( i + 1 );
						else i++;
					}
				}
				var inputDataType = editor.editingCell.attributes.getNamedItem( "inputDataType" ).value;
				if( ! _checkDataType( inputDataType, value, "" ) ) return false;
				if( value == editor.oldValue ) {
					value = editor.editingCell.attributes.getNamedItem( "value" ).value;
					valueChanged = false;
				}
				editor.style.display = "none";
				break;
			case "2":
			case "3":
				if( editor.selectedIndex < 0 ) {
					disp = editor.editingCell.innerHTML;
					value = editor.editingCell.attributes.getNamedItem( "value" ).value;
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
		editor.editingCell.innerHTML = _convert( disp, 1 );
		editor.editingCell.attributes.getNamedItem( "value" ).value = value;
		if( editor.editingCell.attributes.getNamedItem( "editStyle" ).value == "1"
			|| editor.editingCell.attributes.getNamedItem( "editStyle" ).value == "0"
			|| editor.editingCell.attributes.getNamedItem( "editStyle" ).value == "9"
			|| editor.editingCell.attributes.getNamedItem( "editStyle" ).value == "2"
			|| editor.editingCell.attributes.getNamedItem( "editStyle" ).value == "3" ) {
			var attr = editor.editingCell.attributes.getNamedItem( "dataValid" );
			if( attr != null && attr.value.length > 0 ) {
				if( ! eval( attr.value ) ) {
					editor.oldValue = value;
					editor.style.display = "block";
					return false;
				}
			}
			var cellName = editor.editingCell.id;
			cellName = cellName.substring( cellName.lastIndexOf( "_" ) + 1 );
			if( valueChanged && !autoCalcOnlyOnSubmit ) eval( _getReportName( table ) + "_autoCalc( '" + cellName + "' )" );
			if( valueChanged ) {
				table.changed = true;
				var filterCells = editor.editingCell.filterCells;
				if( filterCells != null ) {
					var fcs = filterCells.split( "," );
					for( var i = 0; i < fcs.length; i++ ) {
						var fc = document.getElementById( fcs[i] );
						var ds = eval( fc.attributes.getNamedItem( "dataSet" ).value );
						fc.attributes.getNamedItem( "editConfig" ).value = ds.filter( fc.attributes.getNamedItem( "filterExp" ).value );
						var valueAttr = fc.attributes.getNamedItem( "value" );
						if( valueAttr != null ) valueAttr.value = "";
						else fc.value = "";
						fc.innerHTML = "";
					}
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
		editingObj.innerHTML = _convert( disp, 1 );
		editingObj.attributes.getNamedItem( "value" ).value = value;
		var attr = editingObj.attributes.getNamedItem( "dataValid" );
		if( attr != null && attr.value.length > 0 ) {
			if( ! eval( attr.value ) ) {
				editingObj.innerHTML = "";
				editingObj.attributes.getNamedItem( "value" ).value = "";
				return false;
			}
		}
		var cellName = editingObj.id;
		cellName = cellName.substring( cellName.lastIndexOf( "_" ) + 1 );
		if( valueChanged && !autoCalcOnlyOnSubmit ) eval( _getReportName( table ) + "_autoCalc( '" + cellName + "' )" );
		if( valueChanged ) {
			table.changed = true;
		}
	}
	else if( editingObj.tagName == "INPUT" ) {
		editingObj.value = value;
    	var dataValid = editingObj.attributes.getNamedItem( "dataValid" );
    	if( dataValid != null && dataValid.value.length > 0 ) {
    		if( ! eval( dataValid.value ) ) {
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
				alert( cellName + __HH );
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

function _hideEditor( event ) {
	var cell = event.target;
	var table = _lookupTable( cell );
	_submitEditor( table );
	try {
		_hiddenCalendar();
	}catch( e ) {}
	try {
		tree_hide();
	}catch( e ) {}
	if( document.body._jsHideFuncs != null ) {
		for( var i = 0; i < document.body._jsHideFuncs.length; i++ ) {
			try { eval( document.body._jsHideFuncs[i] ); }catch( e ) {}
		}
	}
}

function _displayEditor( event ) {
	try {
		_hiddenCalendar();
	}catch( e ) {}
	try {
		tree_hide();
	}catch( e ) {}
	var cell = event.target;
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
			var r = c.parentNode;
			while( r.tagName != "TR" ) r = r.parentNode;
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
				try { tmpCell = document.getElementById( _getReportName( table ) + "_" + _toExcelNotation( i + rc[0] - r.rowIndex, col ) ); }catch(e){}
				if( tmpCell != null && tmpCell.oldBkcolor != null ) tmpCell.style.backgroundColor = tmpCell.oldBkcolor;
			}
		}
	}
	if( cell != null ) {    //设置新光标所在行列的背景色
		if( rowbkcolor != "" ) {
			var r = cell.parentNode;
			while( r.tagName != "TR" ) r = r.parentNode;
			for( var i = 0; i < r.cells.length; i++ ) {
				var tmpCell = r.cells[i];
				if( tmpCell != cell ) {
					var currentStyle = null ;
					for( var k = 0; k < document.styleSheets.length; k++ ) {
						for( var j = 0; j < document.styleSheets[k].cssRules.length; j++ ) {
							if( document.styleSheets[k].cssRules[j].selectorText == "." + tmpCell.className ) {
								currentStyle = document.styleSheets[k].cssRules[j].style;
								break;
							}
						}
						if( currentStyle != null ) break;
					}
					tmpCell.oldBkcolor = currentStyle.backgroundColor;
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
				try { tmpCell = document.getElementById( _getReportName( table ) + "_" + _toExcelNotation( i + rc[0] - r.rowIndex, col ) ); }catch(e){}
				if( tmpCell != null && tmpCell != cell ) {
					var currentStyle = null ;
					for( var k = 0; k < document.styleSheets.length; k++ ) {
						for( var j = 0; j < document.styleSheets[k].cssRules.length; j++ ) {
							if( document.styleSheets[k].cssRules[j].selectorText == "." + tmpCell.className ) {
								currentStyle = document.styleSheets[k].cssRules[j].style;
								break;
							}
						}
						if( currentStyle != null ) break;
					}
					tmpCell.oldBkcolor = currentStyle.backgroundColor;
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
		table = table.parentNode;
	}
	return table;
}

function _lookupEditor( table, cell ) {
	var editStyle = "1";
	var attr = cell.attributes.getNamedItem( "editStyle" );
	if( attr != null ) editStyle = attr.value;
	var editor = null;
	switch( editStyle ) {
		case "0":
			editor = document.getElementById( table.id + "_textArea" );
			if( editor == null ) {
				var border = "";
				try {
					border += "border-left:" + _editorBorderLeft;
					border += ";border-right:" + _editorBorderRight;
					border += ";border-top:" + _editorBorderTop;
					border += ";border-bottom:" + _editorBorderBottom;
				}catch( e ) {
					border = "border: 1px solid red";
				}
				var tmpDiv = document.createElement( "div" );
				document.body.appendChild( tmpDiv );
				tmpDiv.innerHTML = "<textArea id=\"" + table.id + "_textArea\" style=\"position:absolute;" + border +
					";display:none;zIndex:100\" onkeyup=\"_editorKeyPress( event )\"></textArea>";
				editor = document.getElementById( table.id + "_textArea" );
			}
			editor.value = cell.attributes.getNamedItem( "value" ).value;
			editor.style.display = "block";
			if( table.attributes.getNamedItem( "selectText" ) != null ) editor.select();
			break;
		case "2":
		case "3":
			editor = eval( table.id + "_listBox" );
			if( editor.TitleTable.rows[0].cells[0] == null ) {
				editor = SS_write( "<select style='width:10px'><option></option></select>" );
			}
			attr = cell.attributes.getNamedItem( "editConfig" );
			if( attr != null && attr.value != null ) {
				var configs = attr.value;
				if( configs.indexOf( "ref:" ) == 0 ) {
					if( cell.attributes.getNamedItem( "dataSet" ) != null ) configs = "";
					else configs = document.getElementById( configs.substring( 4 ) ).attributes.getNamedItem( "editConfig" ).value;
				}
				if( configs == "" && cell.attributes.getNamedItem( "dataSet" ) != null ) {
					var ds = eval( cell.attributes.getNamedItem( "dataSet" ).value );
					attr.value = ds.filter( cell.attributes.getNamedItem( "filterExp" ).value );
					configs = attr.value;
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
			editor.setValue( cell.attributes.getNamedItem( "value" ).value );
			editor.Table.style.display = "block";
			break;
		case "9":
			editor = document.getElementById( table.id + "_pwdBox" );
			if( editor == null ) {
				var border = "";
				try {
					border += "border-left:" + _editorBorderLeft;
					border += ";border-right:" + _editorBorderRight;
					border += ";border-top:" + _editorBorderTop;
					border += ";border-bottom:" + _editorBorderBottom;
				}catch( e ) {
					border = "border: 1px solid red";
				}
				var tmpDiv = document.createElement( "div" );
				document.body.appendChild( tmpDiv );
				tmpDiv.innerHTML = "<input type=password id=\"" + table.id + "_pwdBox\" style=\"position:absolute;" + border +
					";display:none;zIndex:100\" onkeyup=\"_editorKeyPress( event )\">";
				editor = document.getElementById( table.id + "_pwdBox" );
			}
			editor.value = cell.attributes.getNamedItem( "value" ).value;
			editor.oldValue = cell.attributes.getNamedItem( "value" ).value;
			editor.style.display = "block";
			if( table.attributes.getNamedItem( "selectText" ) != null ) editor.select();
			break;
		default:
			editor = document.getElementById( table.id + "_editBox" );
			if( editor == null ) {
				var border = "";
				try {
					border += "border-left:" + _editorBorderLeft;
					border += ";border-right:" + _editorBorderRight;
					border += ";border-top:" + _editorBorderTop;
					border += ";border-bottom:" + _editorBorderBottom;
				}catch( e ) {
					border = "border: 1px solid red";
				}
				var tmpDiv = document.createElement( "div" );
				document.body.appendChild( tmpDiv );
				tmpDiv.innerHTML = "<input type=text id=\"" + table.id + "_editBox\" style=\"position:absolute;" + border +
					";display:none;zIndex:100\" onkeyup=\"_editorKeyPress( event )\">";
				editor = document.getElementById( table.id + "_editBox" );
			}
			editor.value = _convert( cell.innerHTML, 2 );
			editor.oldValue = _convert( cell.innerHTML, 2 );
			editor.style.display = "block";
			if( table.attributes.getNamedItem( "selectText" ) != null ) editor.select();
	}
	editor.editingCell = cell;
	return editor;
}

function _convert( s, flag ) {
	var re;
	if( flag == 1 ) {
		re = /&/g;
		s = s.replace( re, "&amp;" );
		re = /</g;
		s = s.replace( re, "&lt;" );
		re = />/g;
		s = s.replace( re, "&gt;" );
		re = / /g;
		s = s.replace( re, "&nbsp;" );
		re = /\n/g;
		s = s.replace( re, "<br>" );
	}
	else if( flag == 2 ) {
		re = /&nbsp;/g;
		s = s.replace( re, " " );
		re = /&lt;/g;
		s = s.replace( re, "<" );
		re = /&gt;/g;
		s = s.replace( re, ">" );
		re = /&amp;/g;
		s = s.replace( re, "&" );
	}
	return s;
}

function _setEditorStyle( editor, cell ) {
	var x = cell.offsetLeft, y = cell.offsetTop;
	var obj = cell.offsetParent;
	while( obj.tagName != 'BODY' ) {
		x += obj.offsetLeft;
		y += obj.offsetTop;
		obj = obj.offsetParent;
	}
	var dx, dy;
	var isScroll = document.getElementById( cell.id.substring( 0, cell.id.lastIndexOf( "_" ) ) + "_contentdiv" ) != null;
	if( isScroll ) {
		var div = cell.parentNode;
		while( div.tagName != "DIV" || div.id == "div_" + cell.id.substring( 0, cell.id.lastIndexOf( "_" ) ) ) div = div.parentNode;
		x = x - div.scrollLeft;
		y = y - div.scrollTop;
		dx = div.offsetLeft;
		dy = div.offsetTop;
		obj = div.offsetParent;
		while( obj.tagName != 'BODY' ) {
			dx += obj.offsetLeft;
			dy += obj.offsetTop;
			obj = obj.offsetParent;
		}
	}
	var currentStyle = null ;
	for( var i = 0; i < document.styleSheets.length; i++ ) {
		for( var j = 0; j < document.styleSheets[i].cssRules.length; j++ ) {
			if( document.styleSheets[i].cssRules[j].selectorText == "." + cell.className ) {
				currentStyle = document.styleSheets[i].cssRules[j].style;
				break;
			}
		}
		if( currentStyle != null ) break;
	}
	switch( cell.attributes.getNamedItem( "editStyle" ).value ) {
		case "2":
		case "3":
			editor.setBackColor( currentStyle.backgroundColor );
			editor.setFontWeight( currentStyle.fontWeight );
			editor.setFontColor( currentStyle.color );
			editor.setFontFace( currentStyle.fontFamily );
			editor.setFontItalic( currentStyle.fontStyle );
			editor.setFontSize( currentStyle.fontSize );
			editor.setLeft( x );
			editor.setTop( y );
			editor.setWidth( cell.offsetWidth );
			editor.setHeight( cell.offsetHeight );
			break;
		default:
			editor.style.textAlign = currentStyle.textAlign;
			editor.style.backgroundColor = currentStyle.backgroundColor;
			editor.style.paddingLeft = currentStyle.paddingLeft;
			editor.style.paddingRight = currentStyle.paddingRight;
			editor.style.fontWeight = currentStyle.fontWeight;
			editor.style.color = currentStyle.color;
			editor.style.fontFamily = currentStyle.fontFamily;
			editor.style.fontStyle = currentStyle.fontStyle;
			editor.style.fontSize = currentStyle.fontSize;
			editor.style.textDecoration = currentStyle.textDecoration;
			editor.style.verticalAlign = currentStyle.verticalAlign;
			editor.style.left = x - 1;
			editor.style.top = y - 1;
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

function _editorKeyPress( event ) {
	var keyCode = event.keyCode;
	var flag = -1;
	var gotoNext = false;
	var editor = event.target;
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
	var rows = table.attributes.getNamedItem( "rowCount" ).value;
	if( flag == 1 || flag == 3 ) {  //left || right
		var delta = 1;
		if( flag == 1 ) delta = -1;
		var s = cell.id.substring( cell.id.lastIndexOf( "_" ) + 1 );
		var rc = _toRowCol( s );
		var row = rc[0], col = rc[1];
		if( flag == 3 ) col = col + cell.colSpan - 1;
		var cols = table.attributes.getNamedItem( "cols" ).value;
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
			var tmpCell = null;
			tmpCell = document.getElementById( _getReportName( table ) + "_" + _toExcelNotation( row, col ) );
			if( tmpCell == null ) {
				tmpCell = _getMergeCell( table, row, col );
				if( tmpCell == null ) return null;
			}
			var attr = tmpCell.attributes.getNamedItem( "writable" );
			if( ! ( attr != null && attr.value ) || tmpCell.style.display == "none" || tmpCell.parentNode.style.display == "none" ) {
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
		var s = cell.id.substring( cell.id.lastIndexOf( "_" ) + 1 );
		var rc = _toRowCol( s );
		var row = rc[0], col = rc[1];
		if( flag == 4 ) row = row + cell.rowSpan - 1;
		while( true ) {
			row += delta;
			if( row < 1 || row > rows ) return null;
			var tmpCell = null;
			tmpCell = document.getElementById( _getReportName( table ) + "_" + _toExcelNotation( row, col ) );
			if( tmpCell == null ) {
				tmpCell = _getMergeCell( table, row, col );
				if( tmpCell == null ) return null;
			}
			var attr = tmpCell.attributes.getNamedItem( "writable" );
			if( ! ( attr != null && attr.value ) || tmpCell.style.display == "none" || tmpCell.parentNode.style.display == "none" ) {
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

function _getMergeCell( table, row, col ) {  //返回包含(row,col)单元格的合并格
	for( var i = 0; i < table.rows.length; i++ ) {
		var r = table.rows[i];
		for( var j = 0; j < r.cells.length; j++ ) {
			var c = r.cells[j];
			if( c.colSpan == 1 && c.rowSpan == 1 ) continue;
			var s = c.id.substring( c.id.lastIndexOf( "_" ) + 1 );
			var rc = _toRowCol( s );
			var row1 = rc[0], col1 = rc[1];
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
	var form = document.getElementById( table.id + "_submitForm" );
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
			var attr = currCell.attributes.getNamedItem( "value" );
			var value = "";
			if( attr != null ) value = attr.value;
			else value = currCell.value;
			if( value == null ) value = "";
			var needSubmit = false;
			switch( table.attributes.getNamedItem( "submitCells" ).value ) {
				case "0": if( currCell.attributes.getNamedItem( "updatable" ) != null ) needSubmit = true; break;
				case "1": if( currCell.attributes.getNamedItem( "updatable" ) != null || currCell.attributes.getNamedItem( "modifiable" ) != null ) needSubmit = true; break;
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
	var form = document.getElementById( table.id + "_submitForm" );
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
	var value = "";
	attr = cell.attributes.getNamedItem( "value" );
	if( attr != null ) value = parseFloat( attr.value );
	else {
		try { value = parseFloat( cell.value ); } catch(e){}
	}
	attr = cell.attributes.getNamedItem( "digits" );
	if( attr != null ) {
		if( ! isNaN( value ) ) value = parseFloat( value.toFixed( parseInt( attr.value ) ) );
	}
	return isNaN( value ) ? 0 : value;
}

function _formatData( table ) {
	if( autoCalcOnlyOnSubmit ) return;
	for( var row = 0; row < table.rows.length; row++ ) {
		var currRow = table.rows[ row ];
		for( var col = 0; col < currRow.cells.length; col++ ) {
			var currCell = currRow.cells[ col ];
			var attr = currCell.attributes.getNamedItem( "digits" );
			if( attr != null ) {
				var attr1 = currCell.attributes.getNamedItem( "value" );
				var value = "";
				if( attr1 != null ) value = parseFloat( attr1.value );
				else {
					try { value = parseFloat( currCell.value ); }catch(e){}
				}
				if( ! isNaN( value ) ) {
					value = value.toFixed( parseInt( attr.value ) );
					if( attr1 != null ) attr1.value = value + "";
					else currCell.value = value + "";
					//currCell.innerHTML = value;
				}
			}
		}
	}
}

function _formatCalcValue( cell ) {
	var attr = cell.attributes.getNamedItem( "digits" );
	if( attr != null ) {
		var attr1 = cell.attributes.getNamedItem( "value" );
		var value = "";
		if( attr1 != null ) value = parseFloat( attr1.value );
		else {
			try { value = parseFloat( cell.value ); }catch(e){}
		}
		if( ! isNaN( value ) ) {
			value = value.toFixed( parseInt( attr.value ) );
			//if( attr1 != null ) attr1.value = value + "";
			//else cell.value = value + "";
			cell.innerHTML = value;
		}
	}
}

function _uploadFile( url, table, ds, tblName, keyCols, keyCells, origins, fields, valueCells, currCell, ext ) {
	_submitEditor( table );
	var data = "";
	var keys = keyCells.split( "," );
	for( var i = 0; i < keys.length; i++ ) {
		var key = keys[i];
		var cell = document.getElementById( _getReportName( table ) + "_" + key );
		if( cell == null ) {
			alert( __JJ + key + __KK );
			return;
		}
		var attr = cell.attributes.getNamedItem( "value" );
		if( attr == null || attr.value.length == 0 ) {
			alert( __LL + key + __MM );
			return;
		}
	}
	var cols = valueCells.split( "," );
	for( var i = 0; i < cols.length; i++ ) {
		var col = cols[i].toUpperCase();
		var cell = null;
		var cell = document.getElementById( _getReportName( table ) + "_" + col );
		if( cell == null ) {
			alert( __NN + col + __OO );
			return;
		}
		attr = cell.attributes.getNamedItem( "value" );
		var value = "";
		if( attr != null ) value = attr.value;
		else value = cell.value;
		if( value == null ) value = "";
		if( data.length > 0 ) data += ";";
		data += col + "=" + _addEscape( value );
	}
	url += "&ds=" + _urlEncode( ds ) + "&data=" + _urlEncode( data ) + "&originData=" + _urlEncode( origins ) + "&ext=" + _urlEncode( ext )
			+ "&tbl=" + _urlEncode( tblName ) + "&keys=" + _urlEncode( keyCols ) + "&cols=" + _urlEncode( fields )
			+ "&cells=" + _urlEncode( valueCells ) + "&currCell=" + currCell + "&keyCells=" + keyCells;
	window.open( url, null, "left=200, top=250, height=180, width=400, status=no, resizable=yes" );
}

function _uploadPrompt( display, event ) {
	var promptBox = document.getElementById( "___promptBox" );
	if( promptBox == null ) {
		var tmpDiv = document.createElement( "div" );
		document.body.appendChild( tmpDiv );
		tmpDiv.innerHTML = "<table id=___promptBox style=\"display:none; BACKGROUND-COLOR: mistyrose; BORDER: blue 1px solid; FONT-FAMILY: 宋体; FONT-SIZE: 13px; HEIGHT: 26px; POSITION: absolute; WIDTH: 90px\">" +
							"<tr><td align=middle>" + __PP + "</td></tr></table>";
		promptBox = document.getElementById( "___promptBox" );
	}
	promptBox.style.left = event.pageX + 10;
	promptBox.style.top = event.pageY + 5;
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
	html += _convert.toString() + "\n";
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
		html += "\t\t}\n";
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
		html += _runqianCalendar.toString() + "\n";
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
	html += eval( "div_" + table.id ).outerHTML + "\n";
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
		fileDialog.ShowSave();
		var f = fso.CreateTextFile( fileDialog.filename, true );
		f.writeLine( html );
		f.Close();
	}catch( exception ) {
		var form = eval( table.id + "_saveToLocalForm" );
		form.fileContent.value = html;
		form.saveAsName.value = name;
		form.submit();
	}
}

function _tabClicked( tab, sheetName ) {
	var tabs = document.getElementById( "tabs_" + sheetName );
	var currTab = document.getElementById( tabs.attributes.getNamedItem( "currTab" ).value );
	if( ! _submitEditor( document.getElementById( currTab.attributes.getNamedItem( "report" ).value ) ) ) return;
	currTab.style.backgroundColor = tabs.attributes.getNamedItem( "bkColor" ).value;
	currTab.style.color = tabs.attributes.getNamedItem( "fontColor" ).value;
	tab.style.backgroundColor = tabs.attributes.getNamedItem( "bkHLColor" ).value;
	tab.style.color = tabs.attributes.getNamedItem( "fontHLColor" ).value;
	document.getElementById( "div_" + currTab.attributes.getNamedItem( "report" ).value ).style.display = "none";
	document.getElementById( "div_" + tab.attributes.getNamedItem( "report" ).value ).style.display = "";
	tabs.attributes.getNamedItem( "currTab" ).value = tab.id;
}

function _submitSheets( sheets ) {
	var tabs = document.getElementById( "tabs_" + sheets.id );
	var currTab = document.getElementById( tabs.attributes.getNamedItem( "currTab" ).value );
	if( ! _submitEditor( document.getElementById( currTab.attributes.getNamedItem( "report" ).value ) ) ) return;
	var tables = sheets.attributes.getNamedItem( "tables" ).value.split( "," );
	for( var i = 0; i < tables.length; i++ ) {
		if( ! eval( tables[i] + "_checkValid()" ) ) {  //各表数据有效性检查
			return;
		}
	}
	try {
		if( ! eval( sheets.id + "_sheetsValid()" ) ) {   //表间数据有效性检查
			return;
		}
	}catch( exception ) {}
	try {    //用户自定义有效性检查
		if( ! eval( sheets.id + "_userDefineValidScript()" ) ) return;
	}catch( exception ) {}

	var form = document.getElementById( sheets.id + "_submitForm" );
	for( var i = 0; i < tables.length; i++ ) {
		var table = document.getElementById( tables[i] );
		var data = "", originData = "";
		for( var row = 0; row < table.rows.length; row++ ) {
			var currRow = table.rows[ row ];
			for( var col = 0; col < currRow.cells.length; col++ ) {
				var currCell = currRow.cells[ col ];
				var name = currCell.id;
				name = name.substring( name.lastIndexOf( "_" ) + 1 );
				var attr = currCell.attributes.getNamedItem( "value" );
				var value = "";
				if( attr != null ) value = attr.value;
				else value = currCell.value;
				if( value == null ) value = "";
				attr = currCell.attributes.getNamedItem( "keyCell" );
				if( attr != null && attr.value ) {
					if( data.length > 0 ) data += ";";
					data += name + "=" + _addEscape( value );
					attr = currCell.attributes.getNamedItem( "originValue" );
					var origin = "";
					if( attr != null ) origin = attr.value;
					if( originData.length > 0 ) originData += ";";
					originData += name + "=" + _addEscape( origin );
				}
				else {
					var needSubmit = false;
					switch( table.attributes.getNamedItem( "submitCells" ).value ) {
						case "0": if( currCell.attributes.getNamedItem( "updatable" ) != null ) needSubmit = true; break;
						case "1": if( currCell.attributes.getNamedItem( "updatable" ) != null || currCell.attributes.getNamedItem( "modifiable" ) != null ) needSubmit = true; break;
						case "2": needSubmit = true; break;
					}
					if( needSubmit ) {
						if( data.length > 0 ) data += ";";
						data += name + "=" + _addEscape( value );
					}
				}
			}
		}
		form.elements[ tables[i] + "_data" ].value = data;
		form.elements[ tables[i] + "_originData" ].value = originData;
	}
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
	}catch( exception ){}
	html += sheets.outerHTML + "\n";
	html += "<SCRIPT language=javascript>\n";
	html += "\tvar batImport = document.location.href.indexOf( \"?batImport\" ) > 0;\n";
	html += "\tif( batImport ) _submitSheets( " + sheets.id + " );\n";
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
		fileDialog.ShowSave();
		var f = fso.CreateTextFile( fileDialog.filename, true );
		f.writeLine( html );
		f.Close();
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

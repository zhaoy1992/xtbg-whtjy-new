var __DDD = "请输入数字值！";
var __EEE = "请输入有效的日期！";
var __FFF = "请输入全是由数字组成的字符串！";
var __GGG = "请输入正确的Email地址！";
var __HHH = "请输入整数值！";


_initParamFormVar();
function _checkDataType4Form( type, value ) {
	if( value.length == 0 ) return true;
	switch( type ) {
		case "1": return true;
		case "2":
			if( isNaN( value ) ) {
				alert( __DDD );
				return false;
			}
			return true;
		case "3":
			var r = value.match(/^(\d{1,4})(-|\/)(\d{1,2})\2(\d{1,2})$/);
   			if( r == null ) {
				alert( __EEE );
   				return false;
   			}
   			var d = new Date( r[1], r[3]-1, r[4] );
   			if( ! ( d.getFullYear() == r[1] && ( d.getMonth()+1 ) == r[3] && d.getDate() == r[4] ) ) {
				alert( __EEE );
   				return false;
   			}
			return true;
		case "4":
			if( isNaN( value ) ) {
				alert( __FFF );
				return false;
			}
			return true;
		case "5":
			var pos = value.indexOf( "@" );
			if( pos < 1 || pos == value.length - 1 ) {
				alert( __GGG );
				return false;
			}
			return true;
		case "6":
			if( isNaN( value ) || value.indexOf( "." ) >= 0 ) {
				alert( __HHH );
				return false;
			}
			return true;
	}
	return true;
}

function _submit( form ) {
	_processMultiSelect( form, form );
	if( ! eval( form.id + "_checkValid()" ) ) return;
	form.submit();
}

function _processMultiSelect( selectObj, form ) {
	var len = selectObj.childNodes.length;
	if( len == 0 ) return;
	for( var i = 0; i < len; i++ ) {
		var obj = selectObj.childNodes[i];
		if( obj.tagName == "SELECT" ) {
			var name = obj.id;
			if( name.indexOf( "multi_" ) == 0 ) {
				name = name.substring( 6 );
				var s = _getSelectedValues( obj );
				form.elements[ name ].value = s;
			}
		}
		else _processMultiSelect( obj, form );
	}
}

function _getSelectedValues( selectObj ) {
	if( selectObj.tagName != "SELECT" ) return "";
	var s = "";
	for( var i = 0; i < selectObj.length; i++ ) {
		var obj = selectObj.item( i );
		if( obj.selected ) s += "," + obj.value;
	}
	if( s.length > 0 ) s = s.substring( 1 );
	return s;
}

function _hideDropDown() {
	try {
		_hiddenCalendar();
	}catch( e ) {}
	try {
		tree_hide();
	}catch( e ) {}
}

function _onFilter() {
	var obj;
	if( document.all ) obj = event.srcElement;
	else obj = arguments[0].target;
	var filterCells = obj.filterCells;
	if( filterCells != null ) {
		var fcs = filterCells.split( "," );
		for( var i = 0; i < fcs.length; i++ ) {
			var fc = document.getElementById( fcs[i] ).childNodes[0];
			var ds = eval( fc.attributes.getNamedItem( "dataSet" ).value );
			var editConfig = ds.filter( fc.attributes.getNamedItem( "filterExp" ).value );
			fc.options.length = 0;
			fc.options.add( new Option( "", "", false, false ), 0 );
			var configs = editConfig.split( ";" );
			for( var j = 0; j < configs.length; j++ ) {
				var s = configs[j].split( "," );
				var idx = fc.options.length;
				var NewOption = new Option( s[1], s[0], false, false );
				fc.options.add( NewOption, idx );
			}
			fc.value = "";
		}
	}
}

function _filterOnload( obj ) {  //参数表单页面显示时的动态过滤
	var filterCells = obj.filterCells;
	if( filterCells != null ) {
		var fcs = filterCells.split( "," );
		for( var i = 0; i < fcs.length; i++ ) {
			var fc = document.getElementById( fcs[i] ).childNodes[0];
			var ds = eval( fc.attributes.getNamedItem( "dataSet" ).value );
			var editConfig = ds.filter( fc.attributes.getNamedItem( "filterExp" ).value );
			var fcValue = fc.value;
			fc.options.length = 0;
			fc.options.add( new Option( "", "", false, false ), 0 );
			var configs = editConfig.split( ";" );
			for( var j = 0; j < configs.length; j++ ) {
				var s = configs[j].split( "," );
				var idx = fc.options.length;
				var NewOption = new Option( s[1], s[0], false, false );
				fc.options.add( NewOption, idx );
			}
			fc.value = fcValue;
		}
	}
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


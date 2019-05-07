if( SS_VAR == null ) {
	var SS_VAR = new Object();
	SS_VAR.DivDummy = document.createElement("DIV");
	SS_VAR.SelectList = new Array();
	SS_VAR.bEventAttached = false;
	var SS_CreatedElements = new Object();
	attachEvent( "onunload", _unloadObjects );
}

function _unloadObjects() {
 	try {
	  	if ( SS_VAR && SS_VAR.SelectList ) {
	   		for ( key in SS_VAR.SelectList ) {
				if ( SS_VAR.SelectList[key] ) {
	 				try {
	  					SS_VAR.SelectList[key].select.setAttribute( 'SS', 0 );
	 				} catch (e) {};
	 				delete SS_VAR.SelectList[key];
				}
	   		}
	  	}
 	} catch (e) {};
}

function SS_create( srcHTML, ListMax, bAutoDetect ) {
	this.ssID = SS_VAR.SelectList.length;
	this.CR_ReverseBackground = '#E2519C';
	this.CR_ReverseText = 'white';
	this.CR_Border = '#ff0000';

	this.IE_Version = new Number(((window.navigator.appVersion.split('; '))[1].split(' '))[1]);
	this.bOriginalSelect = ( bAutoDetect && this.IE_Version < 5.5 );
	this.select = SS_createElement( srcHTML );
	this.select.style.position = "absolute";
	this.selectedIndex = this.select.selectedIndex;
	this.options = this.select.options;
	this.width = parseInt( this.select.style.width );
	this.height = ( this.select.style.height ) ? parseInt( this.select.style.height ) : 22;
	this.OptionHeight = this.height - 4;
	this.bListDown = ( ListMax && '-' == ListMax.toString().substr(0, 1 ) ) ? false : true;
	this.ListMax = ( ! isNaN( parseInt( ListMax ) ) ) ? Math.abs( ListMax ) : 12;
	
	this.Table;
	this.TitleDiv;
	this.TitleTable;
	this.TitleWrapper;
	this.OptionsDiv;
	this.OptionsTable;
	this.bFocused = false;
	this.bExpanded = false;
	this.bReverse = false;
	
	// private method
	this.isThisEventToBeCanceled = SS_isThisEventToBeCanceled;
	this.toggleTitle = SS_toggleTitle;
	this.syncSelectedIndex = SS_syncSelectedIndex;
	this.toggleOptions = SS_toggleOptions;
	this.turnOnOption = SS_turnOnOption;
	this.turnOffOption = SS_turnOffOption;
	this.handleMousewheel = SS_handleMousewheel;
	this.handleOverTitle = SS_handleOverTitle;
	this.handleOutTitle = SS_handleOutTitle;
	this.handleOverOption = SS_handleOverOption;
	this.createTable = SS_createTable;
	this.createTitleDiv = SS_createTitleDiv;
	this.createOptionsDiv = SS_createOptionsDiv;
	this.createOptionTr = SS_createOptionTr;
	this.adjustOptionsDiv = SS_adjustOptionsDiv;
	this.syncOptions = SS_syncOptions;
	this.pressOption = SS_pressOption;
	this.moveOption = SS_moveOption;
	this.releaseOption = SS_releaseOption;
	this.pressTitle = SS_pressTitle;
	this.releaseTitle = SS_releaseTitle;
	this.display = SS_display;
	
	// public method
	this.insertOption = SS_insertOption;
	this.clearOptions = SS_clearOptions;
	this.changeOption = SS_changeOption;
	this.setHeight = SS_setHeight;
	this.setWidth = SS_setWidth;
	this.setLeft = SS_setLeft;
	this.setTop = SS_setTop;
	this.setFontFace = SS_setFontFace;
	this.setFontColor = SS_setFontColor;
	this.setFontSize = SS_setFontSize;
	this.setFontWeight = SS_setFontWeight;
	this.setFontItalic = SS_setFontItalic;
	this.setBackColor = SS_setBackColor;
	this.getValue = SS_getValue;
	this.setValue = SS_setValue;
	this.getDisp = SS_getDisp;
	
	// initiate
	this.createTable();
	this.select.setAttribute( 'SS', this );
	if ( ! this.bOriginalSelect ) this.select.onpropertychange = SS_handlePropertychange;
	SS_VAR.SelectList[ this.ssID ] = this;
}

function SS_getValue() {
	return this.select.value;
}

function SS_setValue( value ) {
	this.select.value = value;
}

function SS_getDisp() {
	return this.select.options[ this.select.selectedIndex ].text;
}

function SS_setHeight( height ) {
	this.height = height;
	if( !this.bOriginalSelect ) {
		this.Table.style.height = height;
		this.TitleTable.style.height = height;
		this.TitleWrapper.style.height = height;
	}
	else this.select.style.height = height;
}

function SS_setWidth( width ) {
	this.width = width;
	if( !this.bOriginalSelect ) {
		this.Table.style.width = width;
		this.TitleTable.style.width = width;
		this.TitleWrapper.style.width = width;
	}
	else this.select.style.width = width;
}

function SS_setLeft( left ) {
	if( !this.bOriginalSelect )	this.Table.style.left = left;
	else this.select.style.left = left;
}

function SS_setTop( top ) {
	if( !this.bOriginalSelect ) this.Table.style.top = top;
	else this.select.style.top = top;
}

function SS_setFontFace( face ) {
	if( !this.bOriginalSelect ) {
		this.TitleTable.style.fontFamily = face;
		this.OptionsTable.style.fontFamily = face;
		this.TitleWrapper.style.height = this.TitleTable.offsetHeight;
	}
	else this.select.style.fontFamily = face;
}

function SS_setFontColor( color ) {
	if( !this.bOriginalSelect ) {
		this.TitleTable.style.color = color;
		this.OptionsTable.style.color = color;
	}
	else this.select.style.color = color;
}

function SS_setFontSize( size ) {
	if( !this.bOriginalSelect ) {
		this.TitleTable.style.fontSize = size;
		this.OptionsTable.style.fontSize = size;
		document.body.insertAdjacentHTML( "beforeEnd", "<div id=__tmpdiv style='font-size:" + this.TitleTable.style.fontSize + "'>A</div>" );
		this.OptionHeight = __tmpdiv.offsetHeight;
		__tmpdiv.outerHTML = "";
		if( this.OptionHeight < 20 ) this.OptionHeight = 20;
		this.TitleWrapper.style.height = this.TitleTable.offsetHeight;
	}
	else this.select.style.fontSize = size;
}

function SS_setFontWeight( weight ) {
	if( !this.bOriginalSelect ) {
		this.TitleTable.cells[0].style.fontWeight = weight;
		this.OptionsTable.style.fontWeight = weight;
		this.TitleWrapper.style.height = this.TitleTable.offsetHeight;
	}
	else this.select.style.fontWeight = weight;
}

function SS_setFontItalic( italic ) {
	if( !this.bOriginalSelect ) {
		this.TitleTable.cells[0].style.fontStyle = italic;
		this.OptionsTable.style.fontStyle = italic;
		this.TitleWrapper.style.height = this.TitleTable.offsetHeight;
	}
	else this.select.style.fontStyle = italic;
}

function SS_setBackColor( color ) {
	if( !this.bOriginalSelect ) {
		this.TitleTable.style.backgroundColor = color;
		this.OptionsTable.style.backgroundColor = color;
	}
	else this.select.style.backgroundColor = color;
}

function SS_display() {
	var boxDiv;
	try {
		boxDiv = eval( "SS_TempDiv" );
	}catch( e ) {
		document.body.insertAdjacentHTML( "AfterBegin", "<div id=SS_TempDiv></div>\n" );
		boxDiv = eval( "SS_TempDiv" );
	}
 	boxDiv.appendChild( this.Table );
 	boxDiv.removeNode();
}

function SS_write( srcHTML, ListMax, bAutoDetect ) {
	var oSS = new SS_create( srcHTML, ListMax, bAutoDetect );
	oSS.display();
	return oSS;
}

function SS_insertOption( value, innerText, idx, sync ) {
	if( idx < 0 ) idx = this.options.length;
	var NewOption = document.createElement( "OPTION" );
	SS_CreatedElements[SS_CreatedElements.length] = NewOption;
	this.options.add( NewOption, idx );
	NewOption.innerText = innerText;
	NewOption.value = value;
	
	if( !this.bOriginalSelect ) this.createOptionTr(idx);
	if( sync ) {
		this.syncOptions();
		this.adjustOptionsDiv();
		this.syncSelectedIndex();
	}
}

function SS_clearOptions() {
	for( var i = this.options.length - 1; i >= 0; i-- ) {
		this.options.remove( i );
		if( !this.bOriginalSelect )	this.OptionsTable.deleteRow( i );
	}
	this.select.selectedIndex = -1;
	this.syncOptions();
	this.adjustOptionsDiv();
	this.syncSelectedIndex();
}

function SS_changeOption( idx, value, innerText ) {
	this.options[idx].value = value;
	this.options[idx].innerText = innerText;
	this.syncOptions();
	this.syncSelectedIndex();
}

function SS_cancelEvent( event ) {
	event.cancelBubble = true;
	event.returnValue = false;
}

function SS_isThisEventToBeCanceled( event ) {
	if( 'object' == typeof( event ) ) {
		switch( event.type ) {
			case 'mousedown':
				if( !( event.button & 1 ) ) return true;
				break;
			case 'mouseup':
				if( !( event.button & 1 ) ) return true;
				if( this.IE_Version >= 5.5 && event.srcElement != this.srcElementOfLastMousedown && this.srcElementOfLastMousedown != null ) {
				 	this.srcElementOfLastMousedown = null;
				 	return true;
				}
				break;
			case 'mouseout':
				if( !(this.IE_Version < 5.5 && event.srcElement == this.srcElementOfLastMousedown ) )
				return true;
				break;
			case 'mousemove':
				if( this.IE_Version >= 5.5 && event.srcElement != this.srcElementOfLastMousedown && this.srcElementOfLastMousedown != null)
			 	return true;
				break;
		}
	}
	return false;
}

function SS_createElement( html ) {
	SS_VAR.DivDummy.insertAdjacentHTML( 'afterBegin', html );
	var oEl = SS_VAR.DivDummy.children( 0 );
	while( SS_VAR.DivDummy.children.length > 0 ) {
		SS_VAR.DivDummy.removeChild( SS_VAR.DivDummy.children(0) );
	}
	return oEl;
}

function SS_blurExcept( except ) {
	SS_cancelEvent( window.event );
	except = ( 'number' == typeof( except ) ) ? except : -1;
	var bHasToDetachEvent = true;
	for( var i=0; i < SS_VAR.SelectList.length; i++ ) {
		if( -1 == except && SS_VAR.SelectList[i].bFocused && SS_VAR.SelectList[i].bExpanded ) {
			SS_VAR.SelectList[i].toggleOptions(false, true);
			SS_VAR.SelectList[i].toggleTitle(true);
			bHasToDetachEvent = false;
		}
		else if( i != except ) {
			if( SS_VAR.SelectList[i].bExpanded ) SS_VAR.SelectList[i].toggleOptions( false, true );
			if( SS_VAR.SelectList[i].bReverse ) SS_VAR.SelectList[i].toggleTitle( false );
			SS_VAR.SelectList[i].bFocused = false;
		}
	}
	if( SS_VAR.bEventAttached && bHasToDetachEvent ) {
		document.detachEvent( 'onmousedown', SS_blurExcept );
		document.detachEvent( 'ondblclick', SS_blurExcept );
		SS_VAR.bEventAttached = false;
	}
}

function SS_syncSelectedIndex() {
	this.selectedIndex = this.select.selectedIndex;
	if( this.bOriginalSelect ) return;
	if( this.selectedIndex < 0 ) {
		this.TitleTable.cells(0).childNodes(0).innerText = " ";
		return;
	}
	if( this.TitleTable.cells(0).childNodes(0).innerText != this.options[this.selectedIndex].innerText )
		this.TitleTable.cells(0).childNodes(0).innerText = this.options[this.selectedIndex].innerText;
	if( this.bExpanded ) this.toggleOptions( false );
}

function SS_toggleTitle( bReverse ) {
	this.bReverse = ( 'undefined' != typeof( bReverse ) ) ? bReverse: ( !this.bReverse );
	this.TitleTable.cells(0).style.backgroundColor = this.bReverse ? this.CR_ReverseBackground : '';
	this.TitleTable.cells(0).style.color = this.bReverse ? this.CR_ReverseText : '';
}

function SS_toggleOptions( bExpanded, bStrict ) {
	if( !bStrict && !this.bFocused ) {
		SS_blurExcept( this.ssID );
	}
	this.bExpanded = ( 'undefined' != typeof( bExpanded ) ) ? bExpanded: ( !this.bExpanded );
	if( this.bExpanded ) {
		this.adjustOptionsDiv();
		var w = this.width;
		var h = Math.min( this.options.length, this.ListMax ) * this.OptionHeight + 2;
		this.OptionsDiv.show( 0, this.height, w, h, this.Table );
		var w1 = this.OptionsTable.offsetWidth + 1;
		if( this.options.length > this.ListMax ) {
			if( w < w1 + 16 ) w = w1 + 16;
		}
		else if( w1 > w ) w = w1;
		this.OptionsDiv.show( 0, this.height, w, h, this.Table );
		if( !bStrict ) {
			this.toggleTitle( false );
			this.handleOverOption( this.selectedIndex );
		}
		this.handleOutTitle();
	}
	else {
		this.OptionsDiv.hide();
		if( !bStrict ) {
			this.toggleTitle( true );
		}
	}
	if( !bStrict ) {
		this.bFocused = true;
		if( !SS_VAR.bEventAttached ) {
			document.attachEvent( 'onmousedown', SS_blurExcept );
			document.attachEvent( 'ondblclick', SS_blurExcept );
			SS_VAR.bEventAttached = true;
		}
	}
}

function SS_handlePropertychange() {
	if( 'propertychange' == window.event.type && 'selectedIndex' == window.event.propertyName ) {
		var oSS = window.event.srcElement.SS;
		oSS.syncSelectedIndex();
		if( null != oSS.select.onchange ) oSS.select.onchange();
	}
}

function SS_handleMousewheel( event ) {
	var idx = this.selectedIndex;
	if( 'mousewheel' == event.type && this.bFocused && this.bReverse ) {
		for( var i=0; i < event.wheelDelta; i += 120 ) idx--;
		for( var i=0; i > event.wheelDelta; i -= 120) idx++;
	}
	idx = Math.max( idx, 0 );
	idx = Math.min( idx, this.options.length - 1 );
	this.select.selectedIndex = idx;
}

function SS_handleOverTitle() {
	if( this.bExpanded ) return;
	this.TitleTable.cells(1).style.display = 'none';
	this.TitleTable.cells(2).style.display = 'block';
}

function SS_handleOutTitle() {
	 this.TitleTable.cells(2).style.display = 'none';
	 this.TitleTable.cells(1).style.display = 'block';
}

function SS_handleOverOption( idx ) {
	if( idx < 0 ) return;
	for( var i=0; i < this.options.length; i++ ) {
		if( i == idx ) this.turnOnOption( i );
		else this.turnOffOption( i );
	}
}

function SS_turnOnOption( idx ) {
	this.OptionsTable.cells( idx ).style.color = this.CR_ReverseText;
	this.OptionsTable.cells( idx ).style.backgroundColor = this.CR_ReverseBackground;
}

function SS_turnOffOption( idx ) {
	this.OptionsTable.cells( idx ).style.color = '';
	this.OptionsTable.cells( idx ).style.backgroundColor = '';
}

function SS_adjustOptionsDiv() {
	if( this.bOriginalSelect ) return;
	//this.OptionsDiv.style.width = this.width;
	if( this.options.length == 0 ) return;
	//this.OptionsDiv.style.height = Math.min( this.options.length, this.ListMax ) * this.OptionHeight + 2;
	//this.OptionsDiv.style.overflowY = ( this.options.length > this.ListMax ) ? 'scroll' : '';
	for( var i = 0; i < this.OptionsTable.cells.length; i++ ) {
		this.OptionsTable.cells[i].style.height = this.OptionHeight;
	}
	this.TitleWrapper.style.top = 0;
	this.TitleWrapper.style.left = 0;
}

function SS_syncOptions() {
	if( this.bOriginalSelect ) return;
	for( var i=0; i < this.options.length; i++ ) {
		this.OptionsTable.cells(i).setAttribute( 'index', i );
		if( this.OptionsTable.cells(i).childNodes(0).innerText != this.options[i].innerText )
			this.OptionsTable.cells(i).childNodes(0).innerText = this.options[i].innerText;
	}
}

function SS_pressTitle( event ) {
	SS_cancelEvent(event);
	this.srcElementOfLastMousedown = event.srcElement;
	this.toggleOptions();
}

function SS_releaseTitle( event ) {
	SS_cancelEvent( event );
	if( this.isThisEventToBeCanceled( event ) ) return;
	this.srcElementOfLastMousedown = null;
}

function SS_pressOption( event ) {
	SS_cancelEvent( event );
	this.srcElementOfLastMousedown = event.srcElement;
}

function SS_moveOption( event ) {
	for( var i = 0; i < this.OptionsTable.cells.length; i++ ) {
		var cell = this.OptionsTable.cells( i );
		if( cell == event.srcElement || cell == event.srcElement.parentElement ) {
			this.handleOverOption( i );
		}
	}
}

function SS_releaseOption( event ) {
	this.srcElementOfLastMousedown = null;
	this.toggleOptions( false );
	for( var i = 0; i < this.OptionsTable.cells.length; i++ ) {
		var cell = this.OptionsTable.cells( i );
		if( cell == event.srcElement || cell == event.srcElement.parentElement )
		this.select.selectedIndex = i;
	}
}

function SS_createTable() {
	this.Table = SS_createElement( ""
		+ "<table id=my___select border=0 cellpadding=0 cellspacing=0 style='position:absolute;cursor:default;display:none;z-index:5'>"
		+ "<tr><td height=100%></td></tr>"
		+ "</table>"
	);
	if ( !isNaN( this.width ) )	this.Table.style.width = this.width;
	this.Table.style.height = this.height;
	
	if ( !this.bOriginalSelect ) {
		this.createTitleDiv();
		this.createOptionsDiv();
		this.Table.cells(0).appendChild( this.TitleDiv );
		//this.Table.cells(0).appendChild( this.OptionsDiv );
	}
	else {
		this.Table.cells(0).appendChild( this.select );
	}
}

function SS_createTitleDiv () {
	var border = "";
	try {
		border += "border-left:" + _editorBorderLeft;
		border += ";border-right:" + _editorBorderRight;
		border += ";border-top:" + _editorBorderTop;
		border += ";border-bottom:" + _editorBorderBottom;
	}catch( e ) {
		border = "border: 1px solid " + this.CR_Border;
	}
	this.TitleDiv = SS_createElement(""
		+ "<div style='position:relative; top:0; left:0;'>"
		+ " <table border=0 cellpadding=0 cellspacing=0"
		+ "  height=" + this.height
		+ "  bgcolor=white"
		+ "  style='table-layout:fixed; " + border + ";font-family:宋体;font-size:13px;'"
		+ "  onmouseover='SS_VAR.SelectList[" + this.ssID + "].adjustOptionsDiv()'"
		+ " >"
		+ " <tr>"
		+ "  <td><nobr style='text-oveflow:hidden;'></nobr></td>"
		+ "  <td width=16 align=center style='FONT-FAMILY: 宋体; FONT-SIZE: 9px; color:black;word-wrap:normal;background-color:lightgrey;border:1px solid gray'>▼</td>"
		+ "  <td width=16 align=center style='display:none;FONT-FAMILY: 宋体; FONT-SIZE: 9px; color:black;word-wrap:normal;" + 
					"BACKGROUND-COLOR: lightgrey; BORDER-BOTTOM: #666666 2px solid; BORDER-LEFT: ghostwhite 2px solid; BORDER-RIGHT: #666666 2px solid; BORDER-TOP: ghostwhite 2px solid;'>▼</td>"
		+ "  <td style='display:none'></td>"
		+ " </tr>"
		+ " </table>"
		+ "</div>"
	);
	this.TitleTable = this.TitleDiv.childNodes(0);
	this.TitleTable.cells(0).childNodes(0).innerText = this.options[this.selectedIndex].innerText;
	this.TitleTable.cells(3).appendChild( this.select );
	this.TitleWrapper = document.createElement(""
		+ "<div style='position:absolute;overflow-x:hidden;overflow-y:hidden;top:0; left:0; z-index:2;font-size:50px;width:" + this.width + "; height:" + this.height + ";'"
		+ " onmouseover='SS_VAR.SelectList[" + this.ssID + "].handleOverTitle()'"
		+ " onmouseout='SS_VAR.SelectList["+this.ssID+"].handleOutTitle(); SS_VAR.SelectList["+this.ssID+"].releaseTitle(window.event);'"
		+ " onmousedown='SS_VAR.SelectList["+this.ssID+"].pressTitle(window.event)'"
		+ " ondblclick='SS_VAR.SelectList["+this.ssID+"].pressTitle(window.event); SS_VAR.SelectList["+this.ssID+"].releaseTitle(window.event);'"
		+ " onmouseup='SS_VAR.SelectList["+this.ssID+"].releaseTitle(window.event)'"
		+ " onmousewheel='SS_VAR.SelectList["+this.ssID+"].handleMousewheel(window.event)'"
		+ " ondragstart='SS_cancelEvent(window.event)'"
		+ " onselectstart='return false;'"
		+ "></div>"
	);
	this.TitleWrapper.innerHTML = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br>"
								+ "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br>"
								+ "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br>"
								+ "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br>";
	SS_CreatedElements[SS_CreatedElements.length] = this.TitleWrapper;
	this.TitleDiv.appendChild( this.TitleWrapper );
}

function SS_createOptionsDiv () {
	var border = "";
	try {
		border += "border-left:" + _editorBorderLeft;
		border += ";border-right:" + _editorBorderRight;
		border += ";border-top:" + _editorBorderTop;
		border += ";border-bottom:" + _editorBorderBottom;
	}catch( e ) {
		border = "border: 1px solid " + this.CR_Border;
	}
	this.OptionsDiv = window.createPopup();
	var oPopBody = this.OptionsDiv.document.body;
	oPopBody.style.border = "solid 1px " + this.TitleTable.style.borderLeftColor;
	oPopBody.style.overflowX = "hidden";
	oPopBody.style.overflowY = "auto";
	oPopBody.style.margin = "0";
	this.OptionsTable = this.OptionsDiv.document.createElement( "<table border=0 cellpadding=0 cellspacing=0 width=100% style='font-family:宋体;font-size:13px;'></table>" );
	oPopBody.appendChild( this.OptionsTable );
	document.body.insertAdjacentHTML( "beforeEnd", "<div id=__tmpdiv style='font-size:" + this.TitleTable.style.fontSize + "'>aaa</div>" );
	this.OptionHeight = __tmpdiv.offsetHeight;
	__tmpdiv.outerHTML = "";
	if( this.OptionHeight < 20 ) this.OptionHeight = 20;
	for( var i=0; i < this.options.length; i++ ) {
		this.createOptionTr(i);
	}
	this.syncOptions();
}

function SS_createOptionTr( idx ) {
	idx = ('undefined' != typeof(idx)) ? idx : this.options.length - 1;
	var OptionTr = this.OptionsTable.insertRow( -1 );
	var OptionTd = this.OptionsDiv.document.createElement( "<td height=" + this.OptionHeight
		+ " onmousedown='parent.SS_VAR.SelectList[" + this.ssID + "].pressOption(window.event)'"
		+ " onmousemove='parent.SS_VAR.SelectList[" + this.ssID + "].moveOption(window.event)'"
		+ " onmouseup='parent.SS_VAR.SelectList[" + this.ssID + "].releaseOption(window.event)'"
		+ " onmousewheel='parent.SS_VAR.SelectList["+this.ssID+"].handleMousewheel(window.event)'"
		+ " ondragstart='parent.SS_cancelEvent(window.event)'"
		+ " onselectstart='return false;'"
		+ "></td>" );
	SS_CreatedElements[SS_CreatedElements.length] = this.OptionsTd;
	OptionTd.appendChild( this.OptionsDiv.document.createElement( "<nobr></nobr>") );
	OptionTr.appendChild( OptionTd );
}

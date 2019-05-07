if( SS_VAR == null ) {
	var SS_VAR = new Object();
	SS_VAR.DivDummy = document.createElement("DIV");
	SS_VAR.SelectList = new Array();
	SS_VAR.bEventAttached = false;
}

function SS_create( srcHTML, ListMax, bAutoDetect ) {
	this.ssID = SS_VAR.SelectList.length;
	this.CR_ReverseBackground = '#E2519C';
	this.CR_ReverseText = 'white';
	this.CR_Border = '#ff0000';

	this.bOriginalSelect = bAutoDetect;
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
	SS_VAR.SelectList[ this.ssID ] = this;
}

function SS_getValue() {
	return this.select.value;
}

function SS_setValue( value ) {
	this.select.value = value;
	this.syncSelectedIndex();
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
		var tmp_div = document.createElement( "div" );
		document.body.appendChild( tmp_div );
		tmp_div.innerHTML = "<div id=__tmpdiv style='font-size:" + this.TitleTable.style.fontSize + "'>A</div>";
		var __tmpdiv = document.getElementById( "__tmpdiv" );
		this.OptionHeight = __tmpdiv.offsetHeight;
		tmp_div.removeChild( __tmpdiv );
		document.body.removeChild( tmp_div );
		if( this.OptionHeight < 20 ) this.OptionHeight = 20;
		this.TitleWrapper.style.height = this.TitleTable.offsetHeight;
	}
	else this.select.style.fontSize = size;
}

function SS_setFontWeight( weight ) {
	if( !this.bOriginalSelect ) {
		this.TitleTable.rows[0].cells[0].style.fontWeight = weight;
		this.OptionsTable.style.fontWeight = weight;
		this.TitleWrapper.style.height = this.TitleTable.offsetHeight;
	}
	else this.select.style.fontWeight = weight;
}

function SS_setFontItalic( italic ) {
	if( !this.bOriginalSelect ) {
		this.TitleTable.rows[0].cells[0].style.fontStyle = italic;
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
	var boxDiv = document.createElement( "div" );
	document.body.appendChild( boxDiv );
 	boxDiv.appendChild( this.Table );
}

function SS_write( srcHTML, ListMax, bAutoDetect ) {
	var oSS = new SS_create( srcHTML, ListMax, bAutoDetect );
	oSS.display();
	return oSS;
}

function SS_insertOption( value, innerText, idx, sync ) {
	if( idx < 0 ) idx = this.options.length;
	var NewOption = new Option( innerText, value, false, false );
	this.options.add( NewOption, idx );
	
	if( !this.bOriginalSelect ) this.createOptionTr(idx);
	if( sync ) {
		this.syncOptions();
		this.adjustOptionsDiv();
		this.syncSelectedIndex();
	}
}

function SS_clearOptions() {
	for( var i = this.options.length - 1; i >= 0; i-- ) {
		this.options[i] = null;
		if( !this.bOriginalSelect )	this.OptionsTable.deleteRow( i );
	}
	this.select.selectedIndex = -1;
	this.syncOptions();
	this.adjustOptionsDiv();
	this.syncSelectedIndex();
}

function SS_changeOption( idx, value, innerText ) {
	this.options[idx].value = value;
	this.options[idx].innerHTML = innerText;
	this.syncOptions();
	this.syncSelectedIndex();
}

function SS_cancelEvent( event ) {
	try {
		event.cancelBubble = true;
		event.returnValue = false;
	}catch( e ){}
}

function SS_isThisEventToBeCanceled( event ) {
	if( 'object' == typeof( event ) ) {
		switch( event.type ) {
			case 'mousedown':
				if( !( event.button & 1 ) ) return true;
				break;
			case 'mouseup':
				if( !( event.button & 1 ) ) return true;
				if( event.target != this.srcElementOfLastMousedown && this.srcElementOfLastMousedown != null ) {
				 	this.srcElementOfLastMousedown = null;
				 	return true;
				}
				break;
			case 'mouseout':
				if( !( event.target == this.srcElementOfLastMousedown ) )
				return true;
				break;
			case 'mousemove':
				if( event.target != this.srcElementOfLastMousedown && this.srcElementOfLastMousedown != null)
			 	return true;
				break;
		}
	}
	return false;
}

function SS_createElement( html ) {
	SS_VAR.DivDummy.innerHTML = html;
	var oEl = SS_VAR.DivDummy.childNodes[0];
	while( SS_VAR.DivDummy.childNodes.length > 0 ) {
		SS_VAR.DivDummy.removeChild( SS_VAR.DivDummy.childNodes[0] );
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
		document.removeEventListener( 'mousedown', SS_blurExcept, false );
		document.removeEventListener( 'ondblclick', SS_blurExcept, false );
		SS_VAR.bEventAttached = false;
	}
}

function SS_syncSelectedIndex() {
	this.selectedIndex = this.select.selectedIndex;
	if( this.bOriginalSelect ) return;
	if( this.selectedIndex < 0 ) {
		this.TitleTable.rows[0].cells[0].childNodes[0].innerHTML = "";
		return;
	}
	if( this.TitleTable.rows[0].cells[0].childNodes[0].innerHTML != this.options[this.selectedIndex].innerHTML )
		this.TitleTable.rows[0].cells[0].childNodes[0].innerHTML = this.options[this.selectedIndex].innerHTML;
	if( this.bExpanded ) this.toggleOptions( false );
}

function SS_toggleTitle( bReverse ) {
	this.bReverse = ( 'undefined' != typeof( bReverse ) ) ? bReverse: ( !this.bReverse );
	this.TitleTable.rows[0].cells[0].style.backgroundColor = this.bReverse ? this.CR_ReverseBackground : '';
	this.TitleTable.rows[0].cells[0].style.color = this.bReverse ? this.CR_ReverseText : '';
}

function SS_toggleOptions( bExpanded, bStrict ) {
	if( !bStrict && !this.bFocused ) {
		SS_blurExcept( this.ssID );
	}
	this.bExpanded = ( 'undefined' != typeof( bExpanded ) ) ? bExpanded: ( !this.bExpanded );
	if( this.bExpanded ) {
		this.adjustOptionsDiv();
		this.OptionsDiv.style.display = '';
		if( !bStrict ) {
			this.toggleTitle( false );
			this.handleOverOption( this.selectedIndex );
		}
		this.handleOutTitle();
	}
	else {
		this.OptionsDiv.style.display = 'none';
		if( !bStrict ) {
			this.toggleTitle( true );
		}
	}
	if( !bStrict ) {
		this.bFocused = true;
		if( !SS_VAR.bEventAttached ) {
			document.addEventListener( 'mousedown', SS_blurExcept, false );
			document.addEventListener( 'dblclick', SS_blurExcept, false );
			SS_VAR.bEventAttached = true;
		}
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
	this.TitleTable.rows[0].cells[1].style.display = 'none';
	this.TitleTable.rows[0].cells[2].style.display = '';
}

function SS_handleOutTitle() {
	 this.TitleTable.rows[0].cells[2].style.display = 'none';
	 this.TitleTable.rows[0].cells[1].style.display = '';
}

function SS_handleOverOption( idx ) {
	if( idx < 0 ) return;
	for( var i=0; i < this.options.length; i++ ) {
		if( i == idx ) this.turnOnOption( i );
		else this.turnOffOption( i );
	}
}

function SS_turnOnOption( idx ) {
	this.OptionsTable.rows[ idx ].cells[0].style.color = this.CR_ReverseText;
	this.OptionsTable.rows[ idx ].cells[0].style.backgroundColor = this.CR_ReverseBackground;
}

function SS_turnOffOption( idx ) {
	this.OptionsTable.rows[ idx ].cells[0].style.color = '';
	this.OptionsTable.rows[ idx ].cells[0].style.backgroundColor = '';
}

function SS_adjustOptionsDiv() {
	if( this.bOriginalSelect ) return;
	this.OptionsDiv.style.width = this.width;
	if( this.options.length == 0 ) return;
	this.OptionsDiv.style.height = Math.min( this.options.length, this.ListMax ) * this.OptionHeight + 2;
	this.OptionsDiv.style.overflow = ( this.options.length > this.ListMax ) ? 'auto' : '';
	for( var i = 0; i < this.OptionsTable.rows.length; i++ ) {
		this.OptionsTable.rows[i].cells[0].style.height = this.OptionHeight;
	}
	this.TitleWrapper.style.top = 0;
	this.TitleWrapper.style.left = 0;
}

function SS_syncOptions() {
	if( this.bOriginalSelect ) return;
	for( var i=0; i < this.options.length; i++ ) {
		this.OptionsTable.rows[i].cells[0].setAttribute( 'index', i );
		if( this.OptionsTable.rows[i].cells[0].childNodes[0].innerHTML != this.options[i].innerHTML )
			this.OptionsTable.rows[i].cells[0].childNodes[0].innerHTML = this.options[i].innerHTML;
	}
}

function SS_pressTitle( event ) {
	SS_cancelEvent(event);
	this.srcElementOfLastMousedown = event.target;
	this.toggleOptions();
}

function SS_releaseTitle( event ) {
	SS_cancelEvent( event );
	if( this.isThisEventToBeCanceled( event ) ) return;
	this.srcElementOfLastMousedown = null;
}

function SS_pressOption( event ) {
	SS_cancelEvent( event );
	this.srcElementOfLastMousedown = event.target;
}

function SS_moveOption( event ) {
	for( var i = 0; i < this.OptionsTable.rows.length; i++ ) {
		var cell = this.OptionsTable.rows[i].cells[0];
		if( cell == event.target || cell == event.target.parentNode ) {
			this.handleOverOption( i );
		}
	}
}

function SS_releaseOption( event ) {
	this.srcElementOfLastMousedown = null;
	this.toggleOptions( false );
	for( var i = 0; i < this.OptionsTable.rows.length; i++ ) {
		var cell = this.OptionsTable.rows[i].cells[0];
		if( cell == event.target || cell == event.target.parentNode ) 
			this.select.selectedIndex = i;
	}
	this.syncSelectedIndex();
}

function SS_createTable() {
	this.Table = SS_createElement( ""
		+ "<table id=my___select border=0 cellpadding=0 cellspacing=0 style='position:absolute;cursor:default;left:20px;top:30px;display:none;z-index:5'>"
		+ "<tr><td height=100%></td></tr>"
		+ "</table>"
	);
	if ( !isNaN( this.width ) )	this.Table.style.width = this.width;
	this.Table.style.height = this.height;
	
	if ( !this.bOriginalSelect ) {
		this.createTitleDiv();
		this.createOptionsDiv();
		this.Table.rows[0].cells[0].appendChild( this.TitleDiv );
		this.Table.rows[0].cells[0].appendChild( this.OptionsDiv );
	}
	else {
		this.Table.rows[0].cells[0].appendChild( this.select );
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
		+ "<table border=0 cellpadding=0 cellspacing=0"
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
		+ "</table>"
		+ "</div>"
	);
	this.TitleTable = this.TitleDiv.childNodes[0];
	this.TitleTable.rows[0].cells[0].childNodes[0].innerHTML = this.options[this.selectedIndex].innerHTML;
	this.TitleTable.rows[0].cells[3].appendChild( this.select );
	this.TitleWrapper = SS_createElement(""
		+ "<div style='position:absolute;overflow-x:hidden;overflow-y:hidden;top:0; left:0; z-index:2;font-size:50px;width:" + this.width + "; height:" + this.height + ";'"
		+ " onmouseover='SS_VAR.SelectList[" + this.ssID + "].handleOverTitle()'"
		+ " onmouseout='SS_VAR.SelectList["+this.ssID+"].handleOutTitle(); SS_VAR.SelectList["+this.ssID+"].releaseTitle(event);'"
		+ " onmousedown='SS_VAR.SelectList["+this.ssID+"].pressTitle(event)'"
		+ " ondblclick='SS_VAR.SelectList["+this.ssID+"].pressTitle(event); SS_VAR.SelectList["+this.ssID+"].releaseTitle(event);'"
		+ " onmouseup='SS_VAR.SelectList["+this.ssID+"].releaseTitle(event)'"
		+ " onmousewheel='SS_VAR.SelectList["+this.ssID+"].handleMousewheel(event)'"
		+ " ondragstart='SS_cancelEvent(event)'"
		+ " onselectstart='return false;'"
		+ "></div>"
	);
	this.TitleWrapper.innerHTML = "";
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
	this.OptionsDiv = SS_createElement(""
		+ "<div style='display:none;"
		+ " z-index:10;"
		+ " position:absolute;"
		+ " " + border + ";"
		+ " background-color:white;"
		+ " scrollbar-face-color:#D4D0C8;"
		+ " scrollbar-shadow-color:white;"
		+ " scrollbar-highlight-color:#F6F5F4;"
		+ " scrollbar-3dlight-color:white"
		+ " scrollbar-darkshadow-color:#86837E;"
		+ " scrollbar-track-color:#F6F5F4;"
		+ " scrollbar-arrow-color:#86837E;'"		
		+ " onscroll='SS_VAR.SelectList[" + this.ssID + "].moveOption( event )'"
		+ " onmousedown='SS_cancelEvent( event )'"
		+ ">"
		+ "<table border=0 cellpadding=0 cellspacing=0 width=100% style='font-family:宋体;font-size:13px;'>"
		+ " </table>"
		+ "</div>"
	);
	this.OptionsTable = this.OptionsDiv.childNodes[0];
	var div_tmp = document.createElement( "div" );
	document.body.appendChild( div_tmp );
	div_tmp.innerHTML = "<div id=__tmpdiv style='font-size:" + this.TitleTable.style.fontSize + "'>aaa</div>";
	var __tmpdiv = document.getElementById( "__tmpdiv" );
	this.OptionHeight = __tmpdiv.offsetHeight;
	div_tmp.removeChild( __tmpdiv );
	document.body.removeChild( div_tmp );
	if( this.OptionHeight < 20 ) this.OptionHeight = 20;
	for( var i=0; i < this.options.length; i++ ) {
		this.createOptionTr(i);
	}
	this.syncOptions();
}

function SS_createOptionTr( idx ) {
	idx = ('undefined' != typeof(idx)) ? idx : this.options.length - 1;
	var OptionTr = this.OptionsTable.insertRow( -1 );
	OptionTr.innerHTML = "<td height=" + this.OptionHeight
		+ " onmousedown='SS_VAR.SelectList[" + this.ssID + "].pressOption(event)'"
		+ " onmousemove='SS_VAR.SelectList[" + this.ssID + "].moveOption(event)'"
		+ " onclick='SS_VAR.SelectList[" + this.ssID + "].releaseOption(event)'"
		+ " onmousewheel='SS_VAR.SelectList["+this.ssID+"].handleMousewheel(event)'"
		+ " ondragstart='SS_cancelEvent(event)'"
		+ " onselectstart='return false;'"
		+ "></td>";
	OptionTr.cells[0].appendChild( SS_createElement( "<nobr></nobr>") );
}

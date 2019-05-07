function t_ic( obj, subdiv ) {   //tree_iconClick
   	var nodeValue = obj.attributes.getNamedItem( "nv" );
   	var oldnodevalue = nodeValue.value;
   	if( oldnodevalue == "0" || oldnodevalue == "2" )
      	subdiv.style.display = "";
   	if( oldnodevalue == "0" ) {
      	nodeValue.value = "1";      
      	obj.src = obj.src.substring( 0, obj.src.indexOf( "plus.gif" ) ) + "minus.gif";
   	}
   	if( oldnodevalue == "2" ) {
      	nodeValue.value = "3";      
      	obj.src = obj.src.substring( 0, obj.src.indexOf( "lastplus.gif" ) ) + "lastminus.gif";
   	}
   	if( oldnodevalue == "1" || oldnodevalue == "3" )
      	subdiv.style.display = "none";
   	if( oldnodevalue == "1" ) {
      	nodeValue.value = "0";      
      	obj.src = obj.src.substring( 0, obj.src.indexOf( "minus.gif" ) ) + "plus.gif";
   	}
   	if( oldnodevalue == "3" ) {
      	nodeValue.value = "2";      
      	obj.src = obj.src.substring( 0, obj.src.indexOf( "lastminus.gif" ) ) + "lastplus.gif";
   	}
}

function t_mov( obj ) {  //tree_mouseOver
	obj.style.backgroundColor = "darkBlue";
	obj.style.color = "white";
}

function t_mou( obj ) {  //tree_mouseOut
	obj.style.backgroundColor = "";
	obj.style.color = "";
}

function t_s( obj, treeWinId ) {  //tree_select
	var treeWin = document.getElementById( treeWinId );
	var target = treeWin.target;
	var code = obj.attributes.getNamedItem( "code" ).value;
	if( target.tagName == "TD" ) {
		target.innerHTML = obj.innerHTML;
		var attr = target.attributes.getNamedItem( "value" );
		var valueChanged = false;
		if( attr != null ) {
			valueChanged = attr.value != code;
			attr.value = code;
		}
		if( valueChanged ) {
			var obj = target;
			while( obj.tagName != "TABLE" ) obj = obj.parentNode;
			obj.changed = true;
		}
	}
	else if( target.tagName == "INPUT" ) {
		target.value = obj.innerHTML;
		var pos = target.id.lastIndexOf( "_text" );
		var hiddenInput = document.getElementById( target.id.substring( 0, pos ) );
		hiddenInput.value = code;
	}
	treeWin.style.display = "none";
}

function tree_clearSelect( treeWinId ) {
	var treeWin = document.getElementById( treeWinId );
	var target = treeWin.target;
	if( target.tagName == "TD" ) {
		target.innerHTML = "";
		var attr = target.attributes.getNamedItem( "value" );
		if( attr != null ) attr.value = "";
		var obj = target;
		while( obj.tagName != "TABLE" ) obj = obj.parentNode;
		obj.changed = true;
	}
	else if( target.tagName == "INPUT" ) {
		target.value = "";
		var pos = target.id.lastIndexOf( "_text" );
		var hiddenInput = document.getElementById( target.id.substring( 0, pos ) );
		hiddenInput.value = "";
	}
	treeWin.style.display = "none";
}

function tree_show( obj, treeWinId ) {
	var treeWin = document.getElementById( treeWinId );
	treeWin.target = obj;
	var x = obj.offsetLeft, y = obj.offsetTop;
	var o = obj.offsetParent;
	var isScroll = document.getElementById( obj.id.substring( 0, obj.id.lastIndexOf( "_" ) ) + "_contentdiv" ) != null;
	if( isScroll ) {
		while( o.tagName != 'DIV' && o.tagName != 'BODY' ) {
			x += o.offsetLeft;
			y += o.offsetTop;
			o = o.offsetParent;
		}
		var div = obj.parentNode;
		while( div.tagName != "DIV" ) div = div.parentNode;
		x = x - div.scrollLeft;
		y = y - div.scrollTop;
	}
	else {
		while( o.tagName != 'BODY' ) {
			x += o.offsetLeft;
			y += o.offsetTop;
			o = o.offsetParent;
		}
	}
	treeWin.style.left = x;
	treeWin.style.top = y + 2 + obj.offsetHeight;
	treeWin.style.display = "";
}	

function tree_hide() {
	var trees = document.body.runqianTrees.split( "," );
	for( var i = 0; i < trees.length; i++ ) {
		document.getElementById( trees[i] ).style.display = "none";
	}
}
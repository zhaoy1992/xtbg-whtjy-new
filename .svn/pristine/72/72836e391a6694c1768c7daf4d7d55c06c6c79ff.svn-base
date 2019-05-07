
            //定义 国际化需替换部分 默认中文
            var __time = "时间";
            var __year = "年";
            var __month = "月";
            var __date = "日";
            var __hour = "时";
            var __minute = "分";
            var __second = "秒";
            var __prevYear = "向前翻1年";
            var __nextYear = "向后翻1年";
            var __prevMonth = "向前翻1月";
            var __nextMonth = "向后翻1月";
            var __prevHour = "向前翻1个小时";
            var __nextHour = "向后翻1个小时";
            var __prevMinutes = "向前翻1分钟";
            var __nextMinutes = "向后翻1分钟";
            var __prevSeconds = "向前翻1秒";
            var __nextSeconds = "向后翻1秒";
            var __funMonthSelect = "点击此处选择月份";
            var __Sunday = "周日";
            var __Monday = "周一";
            var __Tuesday = "周二";
            var __Wednesday = "周三";
            var __Thursday = "周四";
            var __Friday = "周五";
            var __Saturday = "周六";
            var __clear = "清除";
            var __close = "关闭";
            var __fontFamily = "宋体";
            // over








function _createRunqianCalendar() {
    var obj = document.getElementById("_runqianCalendar");
    if( obj == null ) {
		document.body.insertAdjacentHTML( 'afterBegin', "<div id=_runqianCalendar style='position: absolute; z-index: 7777; width: 145px; height: 175px; display: none'>" +
				"</div>" );
    	_runqianCalendar.iframe = window.createPopup();
	    _runqianCalendar.daysMonth  = new Array(31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
	    _runqianCalendar.day        = new Array(38);
	    _runqianCalendar.dayObj     = new Array(38);
	    _runqianCalendar.objExport  = null;
	    _runqianCalendar.eventSrc   = null;
	    _runqianCalendar.inputDate  = null;
	    _runqianCalendar.thisYear   = new Date().getFullYear();
	    _runqianCalendar.thisMonth  = new Date().getMonth()+ 1;
	    _runqianCalendar.thisDay    = new Date().getDate();
	    _runqianCalendar.thisHour   = new Date().getHours();
	    _runqianCalendar.thisMinutes= new Date().getMinutes();
	    _runqianCalendar.thisSeconds= new Date().getSeconds();
      _runqianCalendar.dateFormat = "yyyy-MM-dd HH:mm:ss";


	    _runqianCalendar.today      = _runqianCalendar.thisDay +"/"+ _runqianCalendar.thisMonth +"/"+ _runqianCalendar.thisYear+"/"+_runqianCalendar.thisHour+"/"+_runqianCalendar.thisMinutes;
	    _runqianCalendar.darkColor  = "#fa8072";      //主面板背景颜色
	    try{ _runqianCalendar.darkColor = _calendarMainBackColor; }catch(e){}
	    _runqianCalendar.lightColor = "#FFFFFF";      //亮边框线颜色
	    _runqianCalendar.wordColor  = "#000040";      //日期文字颜色
	    try{ _runqianCalendar.wordColor = _calendarDayColor; }catch(e){}
	    _runqianCalendar.wordDark   = "#DCDCDC";      //非本月日期文字颜色
	    _runqianCalendar.dayBgColor = "#ffe4e1";      //日期面板背景色
	    try{ _runqianCalendar.dayBgColor = _calendarDayBackColor; }catch(e){}
	    _runqianCalendar.todayColor = "#4682b4";      //今天日期文字颜色
	    _runqianCalendar.DarkBorder = "#a9a9a9";      //日期暗边框线颜色
	    _runqianCalendar.weekColor  = "#FFFFFF";      //周文字颜色
	    try{ _runqianCalendar.weekColor = _calendarWeekColor; }catch(e){}
	    _runqianCalendar.type = "day";//07-7-17新增两种类型 XXXX-XX-XX XX:XX:XX;
	    _runqianCalendar.separator = "-";//停用
            _initCalJsVar();

    	    _createIframeSyntax();
    }
}

function _createIframeSyntax() {
    var str = "<html><head><meta http-equiv='Content-Type' content='text/html; charset=gb2312'><style>"+
    "*{font-size: 12px; font-family:" + __fontFamily + "}"+
    ".bg{  color: "+ _runqianCalendar.lightColor +"; cursor: default; background-color: "+ _runqianCalendar.darkColor +";}"+
    "table#tableWeek td{ color: "+ _runqianCalendar.weekColor +";}"+
    "table#tableDay  td{ font-weight: bold;}"+
    ".over { text-align: center; border-top: 1px solid "+ _runqianCalendar.DarkBorder +"; border-left: 1px solid "+ _runqianCalendar.DarkBorder +";"+
    "border-right: 1px solid "+ _runqianCalendar.lightColor +"; border-bottom: 1px solid "+ _runqianCalendar.lightColor +";}"+
    ".out{ text-align: center; border-top: 1px solid #FFFFFF; border-left: 1px solid #FFFFFF;"+
    "border-bottom: 1px solid "+ _runqianCalendar.DarkBorder +"; border-right: 1px solid "+ _runqianCalendar.DarkBorder +"}"+
    "</style></head><body style='margin: 0px;overflow:hidden;border:none' oncontextmenu='return false' onkeydown=\"if( event.keyCode == 8 && !( event.srcElement.tagName == 'INPUT' && ( event.srcElement.type == 'text' || event.srcElement.type == 'file' || event.srcElement.type == 'password' ) ) && event.srcElement.tagName != 'TEXTAREA' ) return false;\">";

    str += "<table id=tableMain class=bg border=0 cellspacing=2 cellpadding=0 onmousedown='if( event.srcElement != tmpMonthSelect ) parent._hiddenSelect(tmpMonthSelect)'>"+
    "<tr><td height=18 bgcolor='"+ _runqianCalendar.lightColor +"'>"+
    "    <table id=tableHead width=200 border=0 cellspacing=1 cellpadding=0><tr align=center>"+
    "    <td width=12 height=18 class=bg title=" + __prevYear + " onselectstart='return false' style='cursor: hand' onclick='parent._prevYear()'><b>&lt;</b></td>"+
    "    <td width=30 align=right><INPUT id=yearInput onkeydown='parent._changeYear(event.keyCode)' onclick='this.select()' maxLength=4 oldValue='' style='width:30px;height:18px;border:none'></td>"+
    "    <td width=12 align=left onselectstart='return false'>" + __year + "</td>"+
    "    <td width=12 class=bg title=" + __nextYear + " onselectstart='return false' onclick='parent._nextYear()' style='cursor: hand'><b>&gt;</b></td>"+
    "    <td width=12 class=bg title=" + __prevMonth + " onselectstart='return false' style='cursor: hand' onclick='parent._prevMonth()'><b>&lt;</b></td>"+
    "    <td width=45 id=runqianYearMonth title=" + __funMonthSelect + "><span onselectstart='return false' onclick='parent._funMonthSelect()'></span>" +
    "<select id=tmpMonthSelect style='width:45px;display:none'"+
    " onchange='parent._runqianCalendar.thisMonth=this.value; parent._hiddenSelect(this);'>" +
    "<option value=1>1"+ __month +"</option><option value=2>2"+ __month +"</option><option value=3>3"+ __month +"</option><option value=4>4"+ __month +"</option><option value=5>5"+ __month +"</option><option value=6>6"+ __month +"</option>" +
    "<option value=7>7"+ __month +"</option><option value=8>8"+ __month +"</option><option value=9>9"+ __month +"</option><option value=10>10"+ __month +"</option><option value=11>11"+ __month +"</option><option value=12>12"+ __month +"</option>" +
    "</select></td>"+
    "    <td width=12 class=bg title=" + __nextMonth + " onselectstart='return false' onclick='parent._nextMonth()' style='cursor: hand'><b>&gt;</b></td></tr></table>"+
    "</td></tr><tr><td height=20><table id=tableWeek onselectstart='return false' border=1 width=200 cellpadding=0 cellspacing=0 ";
    str += " borderColorLight='"+ _runqianCalendar.darkColor +"' borderColorDark='"+ _runqianCalendar.lightColor +"'>"+
    "    <tr align=center><td height=20>" + __Sunday + "</td><td>" + __Monday + "</td><td>" + __Tuesday + "</td><td>" + __Wednesday + "</td><td>" + __Thursday + "</td><td>" + __Friday + "</td><td>" + __Saturday + "</td></tr></table>"+
    "</td></tr><tr><td valign=top width=200 bgcolor='"+ _runqianCalendar.lightColor +"'>"+
    "    <table id=tableDay onselectstart='return false' height=120 width=200 border=1 cellspacing=1 cellpadding=0>";
         for(var x=0; x<5; x++){ str += "<tr>";
         for(var y=0; y<7; y++)  str += "<td class=out id='runqianDay"+ (x*7+y) +"'></td>"; str += "</tr>";}
         str += "<tr>";
         for(var x=35; x<38; x++) str += "<td class=out id='runqianDay"+ x +"'></td>";
         str +="<td colspan=2 class=out ><input style=' background-color: "+
         _runqianCalendar.dayBgColor +";cursor: hand; padding-top: 4px; width: 100%; height: 100%; border: 0' onfocus='this.blur()'"+
         " type=button value=" + __clear + " onclick=\"parent._runqianCalendar.separator='';parent._returnDate('//')\"></td>";
         str +="<td colspan=2 class=out ><input style=' background-color: "+
         _runqianCalendar.dayBgColor +";cursor: hand; padding-top: 4px; width: 100%; height: 100%; border: 0' onfocus='this.blur()'"+
         " type=button value=" + __close + " onclick='parent._hiddenCalendar()'></td></tr></table>"+
    "</td></tr>";

    	str += "<tr id=timeTr><td id=timeTd style='height:20px' bgcolor='"+ _runqianCalendar.lightColor +"'><div id=timeDiv style='visibility:hidden' ><table id=timeTable width=200 border=0 border=0 cellspacing=1 cellpadding=0><tr>"+
			         "<td style='height:18px;align:right' class=bg align=left>" + __time + ":</td>"+
			           "<td style='cursor: hand' title=" + __prevHour + " onselectstart='return false' onclick='parent._prevHour()' width=12 height=18 class=bg><b>&lt;</b></td>"+
			           "<td><input type=text id=hour  onkeydown=\"parent._changeTime(event.keyCode,'hour')\" style='width:15px;height:15px;border:none'>" + __hour + " </td>"+
			           "<td style='cursor: hand' title=" + __nextHour + " onselectstart='return false' onclick='parent._nextHour()'width=12 height=18 class=bg><b>&gt;</b></td>"+

			           "<td style='cursor: hand' title=" + __prevMinutes + " onselectstart='return false'  onclick='parent._prevMinutes()' width=12 height=18 class=bg><b>&lt;</b></td>"+
			           "<td><input type=text id=minute onkeydown=\"parent._changeTime(event.keyCode,'minute')\" style='width:15px;height:15px;border:none'>" + __minute + "</td>"+
			           "<td style='cursor: hand' title=" + __nextMinutes + " onselectstart='return false'  onclick='parent._nextMinutes()' width=12 height=18 class=bg><b>&gt;</b></td>"+

			           "<td style='cursor: hand' title=" + __prevSeconds + " onselectstart='return false'    onclick='parent._prevSeconds()' width=12 height=18 class=bg><b>&lt;</b></td>"+
			           "<td><input type=text id=second onkeydown=\"parent._changeTime(event.keyCode,'second')\" style='width:15px;height:15px;border:none'>" + __second + "</td>"+
			           "<td style='cursor: hand' title=" + __nextSeconds + " onselectstart='return false'    onclick='parent._nextSeconds()' width=12 height=18 class=bg><b>&gt;</b></td>"+
					    "</tr></table></div></td></tr>";

    str += "</table></body></html>";

    _runqianCalendar.iframe.document.writeln(str);
    for(var i=0; i<38; i++)
    {
        _runqianCalendar.dayObj[i] = _runqianCalendar.iframe.document.getElementById("runqianDay"+ i);
        _runqianCalendar.dayObj[i].onmouseover = _dayMouseOver;
        _runqianCalendar.dayObj[i].onmouseout  = _dayMouseOut;
        _runqianCalendar.dayObj[i].onclick     = _returnDate;
    }
}

function _showCalendar() {
  if ( _runqianCalendar.type == 'date' || _runqianCalendar.type == 'time' ){
  	 _runqianCalendar.iframe.document.getElementById("timeDiv").style.visibility = "visible";
   }
  else{
  	var tmp = _runqianCalendar.iframe.document.getElementById("tableMain");
  	if ( tmp.rows.length ==4 ){
  		  tmp.deleteRow(3);
  		}
   }
    var e = window.event.srcElement;
    _runqianCalendar.eventSrc = e;
	if (arguments.length == 0) _runqianCalendar.objExport = e;
    else _runqianCalendar.objExport = eval(arguments[0]);
    //_runqianCalendar.iframe.show( 0, e.offsetHeight, 205, 196, e );
    	if ( _runqianCalendar.type == 'date' || _runqianCalendar.type == 'time' ){
    		_runqianCalendar.iframe.show( 0, e.offsetHeight, 204, 195, e );
    	}
    	else{
                _runqianCalendar.iframe.show( 0, e.offsetHeight, 204, 172, e );
    	}

    var value = _runqianCalendar.objExport.value;

    if( _runqianCalendar.objExport.tagName == "TD" ) value = _runqianCalendar.objExport.innerText;
    value = _trimString( value );
    _runqianCalendar.oldValue = value;
    if ( value != ""){
    	if ( _runqianCalendar.dateFormat.length == value.length ){
		    if ( _runqianCalendar.dateFormat .indexOf( 'yyyy' ) >= 0 ){
		    	 var fl = _runqianCalendar.dateFormat.indexOf( 'y' );
		    	 var ll = _runqianCalendar.dateFormat.lastIndexOf( 'y' );
		    	 _runqianCalendar.thisYear = value.substring( fl , ll + 1 );
		    }
		    if ( _runqianCalendar.dateFormat .indexOf( 'MM' ) >= 0 ){
		    	 var fl = _runqianCalendar.dateFormat.indexOf( 'M' );
		    	 var ll = _runqianCalendar.dateFormat.lastIndexOf( 'M' );
		    	 _runqianCalendar.thisMonth = value.substring( fl , ll + 1 );
		    }
		    if ( _runqianCalendar.dateFormat .indexOf( 'dd' ) >= 0 ){
		    	 var fl = _runqianCalendar.dateFormat.indexOf( 'd' );
		    	 var ll = _runqianCalendar.dateFormat.lastIndexOf( 'd' );
		    	 _runqianCalendar.thisDay = value.substring( fl , ll + 1 );
		    }
		    if ( _runqianCalendar.dateFormat .indexOf( 'HH' ) >= 0 ){
		    	 var fl = _runqianCalendar.dateFormat.indexOf( 'H' );
		    	 var ll = _runqianCalendar.dateFormat.lastIndexOf( 'H' );
		    	 _runqianCalendar.thisHour = value.substring( fl , ll + 1 );
		    }
		    if ( _runqianCalendar.dateFormat .indexOf( 'mm' ) >= 0 ){
		    	 var fl = _runqianCalendar.dateFormat.indexOf( 'm' );
		    	 var ll = _runqianCalendar.dateFormat.lastIndexOf( 'm' );
		    	 _runqianCalendar.thisMinutes = value.substring( fl , ll + 1 );
		    }
		    if ( _runqianCalendar.dateFormat .indexOf( 'ss' ) >= 0 ){
		    	 var fl = _runqianCalendar.dateFormat.indexOf( 's' );
		    	 var ll = _runqianCalendar.dateFormat.lastIndexOf( 's' );
		    	 _runqianCalendar.thisSeconds = value.substring( fl , ll + 1 );
		    }

		  }
				var y = _runqianCalendar.thisYear;
				var m = _runqianCalendar.thisMonth;
				var d = _runqianCalendar.thisDay;
				var h = _runqianCalendar.thisHour;
				var mi= _runqianCalendar.thisMinutes;
				var s = _runqianCalendar.thisSeconds;

        if( !isNaN( y ) && y > 1970 && y < 2050) _runqianCalendar.thisYear   = parseInt( y, 10 );
        else _runqianCalendar.thisYear = new Date().getFullYear();

        if( !isNaN( m ) && m >= 1 && m <= 12 ) _runqianCalendar.thisMonth  = parseInt( m, 10 );
        else _runqianCalendar.thisMonth = new Date().getMonth()+ 1;

        if( !isNaN( d ) ) _runqianCalendar.thisDay  = parseInt( d, 10 );

        if( !isNaN( h ) && h >= 0 && h <= 23) _runqianCalendar.thisHour    = parseInt( h, 10 );
        else _runqianCalendar.thisHour = new Date().getHours();

        if( !isNaN( mi ) && mi >= 0 && mi <= 59 ) _runqianCalendar.thisMinutes    = parseInt( mi, 10 );
        else _runqianCalendar.thisMinutes = new Date().getMinutes();

        if( !isNaN( s ) && s >= 0 && s <= 59 ) _runqianCalendar.thisSeconds    = parseInt( s, 10 );
	      else _runqianCalendar.thisSeconds = new Date().getSeconds();

        _runqianCalendar.inputDate  = parseInt(_runqianCalendar.thisDay, 10) +"/"+ parseInt(_runqianCalendar.thisMonth, 10) +"/"+
            parseInt(_runqianCalendar.thisYear, 10);
        if ( _runqianCalendar.type == 'date' || _runqianCalendar.type == 'time' ){
        	  _runqianCalendar.inputDate += "/"+ parseInt(_runqianCalendar.thisHour, 10) +"/"+
        	   parseInt(_runqianCalendar.thisMinutes, 10) + "/" +
        	   parseInt(_runqianCalendar.thisSeconds, 10);
        }
    }
    _writeCalendar();
}

function _funMonthSelect() {
    var m = isNaN(parseInt(_runqianCalendar.thisMonth, 10)) ? new Date().getMonth() + 1 : parseInt(_runqianCalendar.thisMonth);
    var e = _runqianCalendar.iframe.document.getElementById( "tmpMonthSelect" );
    e.parentElement.childNodes[0].innerText = "";
    e.style.display = ""; e.value = m;
}

function _prevHour(){
	  _runqianCalendar.thisDay = 1;
	  if (_runqianCalendar.thisHour==0){
	  	_runqianCalendar.thisHour=23;
	  	_runqianCalendar.hour=23;
	  }
	  else {
		  _runqianCalendar.thisHour--;
		  _runqianCalendar.hour--;
	  }
	  _writeCalendar();
}

function _nextHour(){
	  _runqianCalendar.thisDay = 1;
	  if (_runqianCalendar.thisHour==23){
	  	_runqianCalendar.thisHour=0;
	  	_runqianCalendar.hour=0;
	  }
	  else {
		  _runqianCalendar.thisHour++;
		  _runqianCalendar.hour++;
	  }
	  _writeCalendar();
}

function _prevMinutes(){
	  _runqianCalendar.thisDay = 1;
	  if (_runqianCalendar.thisMinutes==0){
	  	_runqianCalendar.thisMinutes=59;
	  	_runqianCalendar.minute=59;
	  }
	  else {
		  _runqianCalendar.thisMinutes--;
		  _runqianCalendar.minute--;
	  }
	  _writeCalendar();
}

function _nextMinutes(){
	  _runqianCalendar.thisDay = 1;
	  if (_runqianCalendar.thisMinutes==59){
	  	_runqianCalendar.thisMinutes=0;
	  	_runqianCalendar.minute=0;
	  }
	  else {
		  _runqianCalendar.thisMinutes++;
		  _runqianCalendar.minute++;
	  }
	  _writeCalendar();
}

function _prevSeconds(){
	  _runqianCalendar.thisDay = 1;
	  if (_runqianCalendar.thisSeconds==0){
	  	_runqianCalendar.thisSeconds=59;
	  	_runqianCalendar.hour=59;
	  }
	  else {
		  _runqianCalendar.thisSeconds--;
		  _runqianCalendar.hour--;
	  }
	  _writeCalendar();
}

function _nextSeconds(){
	  _runqianCalendar.thisDay = 1;
	  if (_runqianCalendar.thisSeconds==59){
	  	_runqianCalendar.thisSeconds=0;
	  	_runqianCalendar.second=0;
	  }
	  else {
		  _runqianCalendar.thisSeconds++;
		  _runqianCalendar.second++;
	  }
	  _writeCalendar();
}





function _prevMonth() {
    _runqianCalendar.thisDay = 1;
    if (_runqianCalendar.thisMonth==1)
    {
        _runqianCalendar.thisYear--;
        _runqianCalendar.thisMonth=13;
    }
    _runqianCalendar.thisMonth--; _writeCalendar();
}

function _nextMonth() {
    _runqianCalendar.thisDay = 1;
    if (_runqianCalendar.thisMonth==12)
    {
        _runqianCalendar.thisYear++;
        _runqianCalendar.thisMonth=0;
    }
    _runqianCalendar.thisMonth++; _writeCalendar();
}

function _prevYear(){
	_runqianCalendar.thisDay = 1;
	_runqianCalendar.thisYear--;
	_writeCalendar();
}

function _nextYear(){
	_runqianCalendar.thisDay = 1;
	_runqianCalendar.thisYear++;
	_writeCalendar();
}

function _hiddenSelect(e){
	e.style.display="none";
	_writeCalendar();
}

function _hiddenCalendar(){
	_runqianCalendar.iframe.hide();
}

function _appendZero(n){
	if( n == "" ) return n;
	return(("00"+ n).substr(("00"+ n).length-2));
}

function _trimString( s ) {
	return s.replace(/(^\s*)|(\s*$)/g,"");
}

function _dayMouseOver() {
    this.className = "over";
    this.style.backgroundColor = _runqianCalendar.darkColor;
    if(_runqianCalendar.day[this.id.substr(10)].split("/")[1] == _runqianCalendar.thisMonth)
    this.style.color = _runqianCalendar.lightColor;
}

function _dayMouseOut() {
    this.className = "out"; var d = _runqianCalendar.day[this.id.substr(10)], a = d.split("/");
    this.style.removeAttribute('backgroundColor');
    if(a[1] == _runqianCalendar.thisMonth && d != _runqianCalendar.today)
    {
        this.style.color = _runqianCalendar.wordColor;
    }
}

function _writeCalendar() {
    var y = _runqianCalendar.thisYear;
    var m = _runqianCalendar.thisMonth;
    var d = _runqianCalendar.thisDay;
		var h = _runqianCalendar.thisHour;
		var mi= _runqianCalendar.thisMinutes;
		var s = _runqianCalendar.thisSeconds;



    _runqianCalendar.iframe.document.getElementById( "yearInput" ).value = y;
    _runqianCalendar.iframe.document.getElementById( "runqianYearMonth" ).childNodes[0].innerText = parseInt(m, 10) +" 月";
    _runqianCalendar.daysMonth[1] = (0==y%4 && (y%100!=0 || y%400==0)) ? 29 : 28;
    if(_runqianCalendar.type == 'date' || _runqianCalendar.type == 'time'){
    	  _runqianCalendar.iframe.document.getElementById( "hour" ).value = h;
    	  _runqianCalendar.iframe.document.getElementById( "minute" ).value = mi;
    	  _runqianCalendar.iframe.document.getElementById( "second" ).value = s;
    }
    var w = new Date(y, m-1, 1).getDay();
    var prevDays = m==1  ? _runqianCalendar.daysMonth[11] : _runqianCalendar.daysMonth[m-2];
    for( var i=(w-1); i>=0; i--) {
        _runqianCalendar.day[i] = prevDays +"/"+ (parseInt(m, 10)-1) +"/"+ y +"/" +h +"/"+mi +"/"+s;
        if(m==1) _runqianCalendar.day[i] = prevDays +"/"+ 12 +"/"+ (parseInt(y, 10)-1) +"/" +h +"/"+mi +"/"+s;
        prevDays--;
    }
    for(var i=1; i<=_runqianCalendar.daysMonth[m-1]; i++) _runqianCalendar.day[i+w-1] = i +"/"+ m +"/"+ y +"/" +h +"/"+mi +"/"+s;
    for(var i=1; i<38-w-_runqianCalendar.daysMonth[m-1]+1; i++) {
        _runqianCalendar.day[_runqianCalendar.daysMonth[m-1]+w-1+i] = i +"/"+ (parseInt(m, 10)+1) +"/"+ y +"/" +h +"/"+mi +"/"+s;
        if(m==12) _runqianCalendar.day[_runqianCalendar.daysMonth[m-1]+w-1+i] = i +"/"+ 1 +"/"+ (parseInt(y, 10)+1) +"/" +h +"/"+mi +"/"+s;
    }
    for(var i=0; i<38; i++) {
        var a = _runqianCalendar.day[i].split("/");
        _runqianCalendar.dayObj[i].innerText    = a[0];
        _runqianCalendar.dayObj[i].title        = _getDateWithFormat( _runqianCalendar.dateFormat , a[2] , _appendZero(a[1]) , _appendZero(a[0]) , _appendZero(a[3]) , _appendZero(a[4]) , _appendZero(a[5]) );//a[2] +_runqianCalendar.separator+ _appendZero(a[1]) +_runqianCalendar.separator+ _appendZero(a[0])+" "+_appendZero(a[3])+":"+_appendZero(a[4])+":"+_appendZero(a[5]);
        _runqianCalendar.dayObj[i].bgColor      = _runqianCalendar.dayBgColor;
        _runqianCalendar.dayObj[i].style.color  = _runqianCalendar.wordColor;
        _runqianCalendar.dayObj[i].className = "out";
    	_runqianCalendar.dayObj[i].style.removeAttribute('backgroundColor');
        if ((i<10 && parseInt(_runqianCalendar.day[i], 10)>20) || (i>27 && parseInt(_runqianCalendar.day[i], 10)<12))
            _runqianCalendar.dayObj[i].style.color = _runqianCalendar.wordDark;
        if ( _runqianCalendar.inputDate == _runqianCalendar.day[i]) {
        	_runqianCalendar.dayObj[i].bgColor = _runqianCalendar.darkColor;
        	_runqianCalendar.dayObj[i].style.color = _runqianCalendar.lightColor;
        }
        if (_runqianCalendar.day[i] == _runqianCalendar.today) {
        	_runqianCalendar.dayObj[i].bgColor = _runqianCalendar.todayColor;
        	_runqianCalendar.dayObj[i].style.color = _runqianCalendar.lightColor;
        }
    }
}

function _returnDate() {
    if( _runqianCalendar.objExport ) {
        var returnValue = "";
        var a = (arguments.length==0) ? _runqianCalendar.day[this.id.substr(10)].split("/") : arguments[0].split("/");
        if (a == ",,"){
                returnValue = "";
        }
        if( _runqianCalendar.type == "day"  && a !=",," ){
                   returnValue = _getDateWithFormat( _runqianCalendar.dateFormat , a[2] , _appendZero(a[1]) , _appendZero(a[0]));
        }
        else if( _runqianCalendar.type == "month"  && a !=",," ) {
        	   returnValue = _getDateWithFormat( _runqianCalendar.dateFormat , a[2] , _appendZero(a[1]) );
        }
        else if( _runqianCalendar.type == "year" ) returnValue = a[2];
        else if( _runqianCalendar.type == "date" && a !=",,"){
        	   returnValue = _getDateWithFormat( _runqianCalendar.dateFormat , a[2] , _appendZero(a[1]) , _appendZero(a[0]) , _appendZero(a[3]) , _appendZero(a[4]) , _appendZero(a[5]) );
        	}

        else if( _runqianCalendar.type == "time" && a !=",,"){
        	   returnValue = _getDateWithFormat( _runqianCalendar.dateFormat , a[2] , _appendZero(a[1]) , _appendZero(a[0]) ,_appendZero(a[3]) , _appendZero(a[4]) , _appendZero(a[5]) );
        	}

        var valueChanged = _runqianCalendar.oldValue != returnValue;
        _runqianCalendar.objExport.value = returnValue;
        if( _runqianCalendar.objExport.tagName == "TD" ) {
        	_runqianCalendar.objExport.innerText = returnValue;
			var table = _runqianCalendar.objExport;
			while( table.tagName != "TABLE" ) table = table.parentElement;
        	var dataValid = _runqianCalendar.objExport.dataValid;
        	if( dataValid != null && dataValid.length > 0 ) {
				if( table.isli ) {
					li_currTbl = table;
					li_currCell = _runqianCalendar.objExport;
	        		if( ! eval( dataValid ) ) {
	        			_runqianCalendar.objExport.value = "";
	        			_runqianCalendar.objExport.innerText = "";
	        			return;
	        		}
				}
				else {
	        		if( ! eval( dataValid ) ) {
	        			_runqianCalendar.objExport.value = "";
	        			_runqianCalendar.objExport.innerText = "";
	        			return;
	        		}
	        	}
        	}
        	if( valueChanged ) {
				table.changed = true;
				if( !autoCalcOnlyOnSubmit ) {  //自动计算
					var cellName = _runqianCalendar.objExport.id;
					var pos = cellName.lastIndexOf( "_" );
					var tableId = cellName.substring( 0, pos );
					cellName = cellName.substring( pos + 1 );
					if( !table.isli ) {
						eval( _getReportName( document.getElementById( tableId ) ) + "_autoCalc( '" + cellName + "' )" );
					}
				}
				if( table.isli ) {
					var editingRow = _runqianCalendar.objExport.parentElement;
					if( editingRow.status == "0" ) editingRow.status = "1";
					else if( editingRow.status == "2" ) editingRow.status = "3";
					_calcTbl( table, _runqianCalendar.objExport );
				}
			}
        }
        else if( _runqianCalendar.objExport.tagName == "INPUT" ) {
        	var dataValid = _runqianCalendar.objExport.dataValid;
        	if( dataValid != null && dataValid.length > 0 ) {
        		if( ! eval( dataValid ) ) {
        			_runqianCalendar.objExport.value = "";
        			return;
        		}
        	}
        }
        _hiddenCalendar();
    }
}

function _changeYear( c ) {
	var obj = _runqianCalendar.iframe.document.getElementById( "yearInput" );
	if( c >= 96 && c <= 105 ){   //小键盘0-9
		c -= 96 - 48;
	}
	if( ( c >= 48 && c <= 57 ) ) {   //数字
		if( _runqianCalendar.iframe.document.selection.type != "None" ) {
			obj.value = "";
			_runqianCalendar.iframe.document.selection.empty();
		}
		if( obj.value.length == 4 ) return;
		obj.value += String.fromCharCode(c);
	}else if( c == 8 ){   //Back
		if( _runqianCalendar.iframe.document.selection.type != "None" ) obj.value = "";
		else obj.value = obj.value.slice( 0, -1 );
	}else if( c == 46 ){   //Del
		if( _runqianCalendar.iframe.document.selection.type != "None" ) obj.value = "";
		else obj.value = obj.value.slice(1);
	}
	var y = obj.value;
	if( isNaN( y ) || obj.oldValue == y ) return;
	obj.oldValue = y;
	var value = 0;
	try { value = parseInt( y ); } catch( e ) {}
	if( value > 999 && value < 10000 ) {
		_runqianCalendar.thisYear = value;
		_writeCalendar();
	}
}

function _changeTime( c , _type){
  	var obj = _runqianCalendar.iframe.document.getElementById( _type );
		if( c >= 96 && c <= 105 ){   //小键盘0-9
			c -= 96 - 48;
		}
		if( ( c >= 48 && c <= 57 ) ) {   //数字
			if( _runqianCalendar.iframe.document.selection.type != "None" ) {
				obj.value = "";
				_runqianCalendar.iframe.document.selection.empty();
			}
			if( obj.value.length == 2 ) return;
			obj.value += String.fromCharCode(c);
		}else if( c == 8 ){   //Back
			if( _runqianCalendar.iframe.document.selection.type != "None" ) obj.value = "";
			else obj.value = obj.value.slice( 0, -1 );
		}else if( c == 46 ){   //Del
			if( _runqianCalendar.iframe.document.selection.type != "None" ) obj.value = "";
			else obj.value = obj.value.slice(1);
		}
		var y = obj.value;
		if( isNaN( y ) || obj.oldValue == y ) return;
		obj.oldValue = y;
		var value = 0;
		try { value = parseInt( y ); } catch( e ) {}
		if (_type == 'hour'){
			if( value >= 0 && value <=23 ) {
				_runqianCalendar.thisHour = value;
				_writeCalendar();
			}
		}
		else if(_type == 'second') {
			if( value >= 0 && value <=59 ) {
				_runqianCalendar.thisSeconds = value;
				_writeCalendar();
			}
		}
		else if( _type == 'minute') {
			if( value >= 0 && value <=59 ) {
				_runqianCalendar.thisMinutes = value;
				_writeCalendar();
			}
		}
}

function trim(str) {
	str = str.replace(/^\s*(.*)/, "$1");
	str = str.replace(/(.*?)\s*$/, "$1");
	return str;
}


function _getDateWithFormat( fmt , y , M , d , H , m , s ){
		    if ( fmt .indexOf( 'yyyy' ) >= 0 ){
		    	fmt = fmt.replace( "yyyy" , y );
		    }
		    if ( fmt .indexOf( 'MM' ) >= 0 ){
		    	fmt = fmt.replace( "MM" , M );//月
		    }
		    if ( fmt .indexOf( 'dd' ) >= 0 ){
		    	fmt = fmt.replace( "dd" , d);//日
		    }
		    if ( fmt .indexOf( 'HH' ) >= 0 ){
		    	fmt = fmt.replace( "HH" , H );//小时
		    }
		    if ( fmt .indexOf( 'mm' ) >= 0 ){
		    	fmt = fmt.replace( "mm" , m );//分
		    }
		    if ( fmt .indexOf( 'ss' ) >= 0 ){
		    	fmt = fmt.replace( "ss" , s );//秒
		    }
		return fmt;
}

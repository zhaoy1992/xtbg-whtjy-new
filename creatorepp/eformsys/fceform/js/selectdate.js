
var _g_dt2_imgCBB = "images/cbb_drop.gif";
var _g_dt2_imgCurDay = "images/curDayTip.gif";
var _g_dt2_imgSelDay = "images/selDayBg.gif";

var _g_dt2_ShowingDTPicker = null;
var _g_dt2_theMonths = new Array("一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月", "十一月", "十二月");
var _g_dt2_theWeeks = new Array("日", "一", "二", "三", "四", "五", "六");
var _g_dt2_days = new Array(42);

var objTxt =null; //txt对象
var txtname = "";
function DateControl20(ctn) {
	if(typeof ctn =="object"){
		objTxt=ctn;
		_dt2_drawDTPicker("txtname"); 

	}else {
		objTxt=document.all(ctn);
		_dt2_drawDTPicker(ctn); 
	}
}

function _dt2_drawDTPicker(ctn) {
	txtname=ctn;
	if ( document.all("div_dtTable_" + ctn) == null )
	{
		document.body.insertAdjacentHTML("BeforeEnd", "<div id='div_dtTable_" + ctn + "' style='position:absolute; visibility:hidden; left:0;  top:22; z-index:2;'></div>");
	}

	_dt2_showDTTable(ctn);
}

function _dt2_drawDTTable(ctn) {
	var strHTML;
	if( objTxt.value == "" ) {
		var now = new Date();
		var year = now.getYear();
		var month = now.getMonth()+1;
		var day = now.getDate();
		if(month<10) {
		   var smonth="0"+month;
		}else{
		   var smonth=month;
		}
		if(day<10) {
		   var sday="0"+day;
		}else{
		   var sday=day;
		}
		//给当前日期作初值      
		objTxt.value =year+"-"+smonth+"-"+sday;
	}else {
		var year = _dt2_getDTYear(ctn);
		var month = _dt2_getDTMonth(ctn);
		var day = _dt2_getDTDay(ctn);
	}
	
	var i = 0;
	document.all("div_dtTable_" + ctn).innerHTML = "<iframe src='' name='_dt2_iframe_" + ctn + "' width='200' height='140' border=0 NORESIZE=NORESIZE SCROLLING=no MARGINWIDTH=0 MARGINHEIGHT=0 FRAMESPACING=0 FRAMEBORDER=0></iframe>";

	strHTML = "<html><head></head><body leftmargin=0 topmargin=0 style='font-size:9pt; font-family:宋体; border-width:1px; border-style:solid; border-color:#000000'><table border='0' width='100%' height='100%' cellpadding='0' cellspacing='0' style='font-size:9pt;' bgcolor='#ffffff'>";
	strHTML += "<tr>";
	strHTML += "<td valign='top'>";
	strHTML += "<table border='0' width='100%' height='25' cellpadding='0' cellspacing='0' bgcolor='#004080'> ";

	//draw year and month
	strHTML += "<tr align='right'><td width=3></td><td align='left' style='font-size:9pt'><input type='button' style='height:18px; width:24px;font-size:9pt' value='《 ' onclick=\"javascript:window.parent._dt2_subMonth('" + ctn + "');\"></td>";
	strHTML += "<td style='font-size:9pt; color:#ffffff;'><input id='dt2_input_year_" + ctn + "' type='text' size='4' key='false' minLength='0' maxLength='4' value='" + year + "' style='font-size:9pt;text-align:right; width:32px; border-left: #000000 solid 1; border-right: #000000 solid 1; border-top: #000000 solid 1; border-bottom: #000000 solid 1;' onblur=\"javascript:window.parent._dt2_onYearChange('" + ctn + "');\"></td>";
	strHTML += "<td align='left' width='20'><input type='button' value='▲' onClick=\"window.parent._dt2_addYear('" + ctn + "')\" style='height:10;width:17;font-size:4pt'><br><input type='button' value='▼' onClick=\"window.parent._dt2_subYear('" + ctn + "')\" style='height:10;width:17;font-size:4pt'>";
	strHTML += "<td align='center'><select id='dt2_cbb_month_" + ctn + "' onchange=\"javascript:window.parent._dt2_onMonthChange('" + ctn + "');\" style='width:60px; font-size:9pt'>";

	for ( i = 0; i < 12; i ++ ) {
		strHTML += "<option value='" + (i+1) + "'";
		if ( i+1 == month )
			strHTML += " selected";
		strHTML +=">" + _g_dt2_theMonths[i] + "</option>";
	}
	strHTML += "</select></td><td style='font-size:9pt'><input type='button'  style='height:18px; width:24px;font-size:9pt' value=' 》' onclick=\"javascript:window.parent._dt2_addMonth('" + ctn + "');\">&nbsp;</td><td align='right'><input type='button'  style='height:18px; width:18px;font-size:7pt' onclick='javascript:window.parent._dt2_closeDTTable(\"" + ctn + "\");' value='X' title='关闭'></td><td width=2></td></tr>";
	strHTML += "</table></td></tr><tr><td>";
	
	//draw weeks
	strHTML += "<table id='_dt2_dttable_" + ctn + "' style='font-size:9pt' border='0' width='100%' height='100%' cellpadding='0' cellspacing='0' > ";
	strHTML += "<thead><tr>";
	for ( i = 0; i < 7; i ++ )
		strHTML += "<td valign='bottom' align='center' height='16' style='font-size:9pt; color:#004080;'>" + _g_dt2_theWeeks[i] + "</td>";
	strHTML += "</tr><tr><td height='1' colspan='7' bgcolor='#000000'></td></tr>";
	strHTML += "</thead>";
	strHTML += "<tbody></tbody>";
	strHTML += "<tfoot><tr><tr><td colspan='7' height='1' bgcolor='#000000'></td></tr>";
	var curDay = new Date();
	strHTML += "<tr><td valign='bottom' colspan='7' style='font-color:#000000; font-weight:bold; font-size:9pt; verical-align:bottom;'>&nbsp;今天:" + curDay.getFullYear() + "-" + ((curDay.getMonth() < 9) ? "0" + (curDay.getMonth() + 1) : (curDay.getMonth() + 1)) + "-" + ((curDay.getDate() < 10) ? "0" + curDay.getDate() : curDay.getDate()) +"&nbsp;&nbsp;&nbsp;&nbsp;<span onclick='javascript:window.parent.clearText()' style='font-size:9pt; color:green;' align=right>日期清空</span></td></tr>";
	strHTML += "</tfoot></table></body></html>";
	window.frames("_dt2_iframe_" + ctn).document.open();
	window.frames("_dt2_iframe_" + ctn).document.write(strHTML);
	window.frames("_dt2_iframe_" + ctn).document.close();
	_dt2_drawDTDays(ctn, year, month, day);
}
function clearText(){
  objTxt.value="";
}

function _dt2_showDTTable(ctn) {
	if ( _g_dt2_ShowingDTPicker != null ) {
		if( ctn != _g_dt2_ShowingDTPicker ) {
			document.all("div_dtTable_" + _g_dt2_ShowingDTPicker).innerHTML = "";
			document.all("div_dtTable_" + _g_dt2_ShowingDTPicker).style.visibility = "hidden";
		}
	}

	ct = document.all("div_dtTable_" + ctn);
	if ( ct.style.visibility == "hidden") {
		_dt2_drawDTTable(ctn);
		ct.style.visibility = "visible";
		//alert(document.body.scrollLeft + "  " + document.body.scrollTop )
		 x = window.event.clientX - window.event.offsetX - 4  ;
		 y = window.event.clientY - window.event.offsetY + 17 ;
		//一个编辑框边加上一个参照按钮
		try{ 
			if(window.event.srcElement.type=="button"){
				x=x-objTxt.offsetWidth+4;
			}
		}catch(E){}
		/*
		if(window.event.srcElement.tagName == "fc_code"){
			if(window.event.srcElement.parentNode.tagName == "webgrid"){
				x = getAbsLeft(window.event.srcElement.parentNode.curTD)
				x = getAbsTop(window.event.srcElement.parentNode.curTD)
				window.event.srcElement.parentNode.hide()
			}
		
			//x = getPosLeft(window.event.srcElement)
			//y = getPosTop(window.event.srcElement)
		}
		*/
		clWidth = window.document.body.clientWidth;
		if ( clWidth < 200 ) {
			x = 1 + document.body.scrollLeft ;
		} else if ( x + 200 + 1 > clWidth) {
			x = clWidth - 200 - 1 + document.body.scrollLeft ;
		} else {
			x = x + document.body.scrollLeft ;
		}
		clHeight = window.document.body.clientHeight;
		var y1 = y + 140 + 1 - clHeight ;
		if (clHeight < 140) {	//窗口的高度小于日历窗口的高度,所以top=1
			y = 1 + document.body.scrollTop;
		} else if ( y + 140 + 1 > clHeight){	//当日历窗口在控件的下面显示不下时.要移到上面显示
			y = clHeight - 140 - 1 + document.body.scrollTop ;
		} else {	//直接在下面显示日历窗口
			y = y + document.body.scrollTop ;	
		}
		
		ct.style.left = x + "px";
		ct.style.top = y + "px";
		_g_dt2_ShowingDTPicker = ctn;
	} else {
		_dt2_closeDTTable(ctn);
	}
}

function _dt2_closeDTTable(ctn) {
	ct = document.all("div_dtTable_" + ctn);
	ct.innerHTML = "";
	ct.style.visibility = "hidden";
	_g_dt2_ShowingDTPicker = null;
	if(objTxt.id=="txtMyGrid"){
		var oGrid=objTxt.parentNode.parentNode;
		//var o=window.document.all.tags("webgrid")
  		//for(var ii=0;ii<o.length;ii++){
			oGrid.txtTotd();
		//}
		//eval('txtMyGrid.style.display="block";txtMyGrid.focus();txtMyGrid.parentNode.parentNode.Act_onDataChange("强行发生数据改变事件");')
		objTxt.style.display="block";
		objTxt.focus();
		oGrid.Act_onDataChange("强行发生数据改变事件");
	}else{
		objTxt.focus();
		//强行发生改变事件，以便向fset传值
		var sDs=objTxt.dataset;
		if(typeof sDs != "undefined" && sDs != null && sDs != ""){
			var oDs=eval(sDs);
			oDs.Fields.Field[objTxt.field].Value=objTxt.value;
			//oDs.cont1_onblur(objTxt)
		}
	}
	
	
}

function _dt2_getDTYear(ctn) {
	if ( objTxt.value.length > 0 ) {
		year = parseInt(objTxt.value.substr(0, 4));
		if ( !isNaN(year) ) 
			return year;
	}
	return 1900;
}

function _dt2_getDTMonth(ctn) {
	var value = objTxt.value;
	if ( value.length > 0 ) {
		pos = value.indexOf('-');
		if ( pos > 0 ) {
			if ( value.substr(pos+1, 1) == '0' ) {
				month = parseInt(value.substr(pos+2, 1));
			} else {
				month = parseInt(value.substr(pos+1, 2));
			}
			//alert(month)
			//month = parseInt(value.substr(pos+1, 2));
			if ( !isNaN(month) )
				return month;
		}
	}
	return 1;
}

function _dt2_getDTDay(ctn) {
	var value = objTxt.value;
	if ( value.length > 0 ) {
		pos = value.indexOf('-');
		if ( pos > 0 ) {
			dpos = value.indexOf('-', pos+1);
			if (dpos > 0) {
				if ( value.substr(dpos+1, 1) == '0' ) {
					day = parseInt(value.substr(dpos+2, 1));
				} else {
					day = parseInt(value.substr(dpos+1, 2));
				}
				
				//day = parseInt(value.substr(dpos+1, 2));
				if ( !isNaN(day) )
					return day;
			}
		}
	}
	return 1;
//	var dt = new Date(_dt2_GetStdDate(objTxt.value).replace("-", "/"))
//	return dt.getDate();
}

function _dt2_setDTYear(ctn, year) {
	_dt2_setDT(ctn, year, _dt2_getDTMonth(ctn), _dt2_getDTDay(ctn));
}
function _dt2_setDTMonth(ctn, month) {
	var year = _dt2_getDTYear(ctn);
	var day = _dt2_getDTDay(ctn);
	var maxDays = _dt2_getDayCount(year, month);
	day = day < maxDays ? day : maxDays;
	_dt2_setDT(ctn, year, month, day);
}
function _dt2_setDTDay(ctn, day) {
	_dt2_setDT(ctn, _dt2_getDTYear(ctn), _dt2_getDTMonth(ctn), day);
}

function _dt2_setDT(ctn, year, month, day) {
	objTxt.value = _dt2_GetStdDate(year + "/" + (month < 10 ? "0" + month : month) + "/" + (day < 10 ? "0" + day : day));
}
function _dt2_onYearChange(ctn) {
	var year = parseInt(window.frames("_dt2_iframe_" + ctn).document.all("dt2_input_year_" + ctn).value);
	if (!isNaN(year)) {
		_dt2_setDTYear(ctn, year);
		_dt2_drawDTDays(ctn, year, _dt2_getDTMonth(ctn), _dt2_getDTDay(ctn));
	} else {
		alert("非法的年份格式，请重新输入年份");
			window.frames("_dt2_iframe_" + ctn).document.all("dt2_input_year_" + ctn).focus();
	}
}

function _dt2_onMonthChange(ctn) {
	var month = parseInt(window.frames("_dt2_iframe_" + ctn).document.all("dt2_cbb_month_" + ctn).value);
	if (month == 0)
		return;
	if ( !isNaN(month) )	{
		_dt2_setDTMonth(ctn, month);
		_dt2_drawDTDays(ctn, _dt2_getDTYear(ctn), month, _dt2_getDTDay(ctn));
	}
}

function _dt2_addYear(ctn) {
	var year = parseInt(window.frames("_dt2_iframe_" + ctn).document.all("dt2_input_year_" + ctn).value);
	if (isNaN(year)) {
		alert("非法的年份格式，请重新输入年份");
		window.frames("_dt2_iframe_" + ctn).document.all("dt2_input_year_" + ctn).focus();
		return;
	}
	window.frames("_dt2_iframe_" + ctn).document.all("dt2_input_year_" + ctn).value = year + 1;
	_dt2_setDTYear(ctn, year+1);
	_dt2_drawDTDays(ctn, year + 1, _dt2_getDTMonth(ctn), _dt2_getDTDay(ctn));
}

function _dt2_subYear(ctn) {
	var year = parseInt(window.frames("_dt2_iframe_" + ctn).document.all("dt2_input_year_" + ctn).value);
	if (isNaN(year)) {
		alert("非法的年份格式，请重新输入年份");
		window.frames("_dt2_iframe_" + ctn).document.all("dt2_input_year_" + ctn).focus();
		return;
	}
	window.frames("_dt2_iframe_" + ctn).document.all("dt2_input_year_" + ctn).value = year - 1;
	_dt2_setDTYear(ctn, year-1);
	_dt2_drawDTDays(ctn, year - 1, _dt2_getDTMonth(ctn), _dt2_getDTDay(ctn));
}

function _dt2_addMonth(ctn) {
	var month = parseInt(window.frames("_dt2_iframe_" + ctn).document.all("dt2_cbb_month_" + ctn).value);
	var year = parseInt(window.frames("_dt2_iframe_" + ctn).document.all("dt2_input_year_" + ctn).value);

	if ( isNaN(year) || isNaN(month) )
		return;

	if ( month == 12 ) {
		year ++;
		month = 1;
		_dt2_addYear(ctn);
	} else {
		month ++;
	}
	window.frames("_dt2_iframe_" + ctn).document.all("dt2_cbb_month_" + ctn).value = month;
	_dt2_setDT(ctn, year, month, _dt2_getDTDay(ctn));
	_dt2_drawDTDays(ctn, year, month, _dt2_getDTDay(ctn));
}

function _dt2_subMonth(ctn) {
	var month = parseInt(window.frames("_dt2_iframe_" + ctn).document.all("dt2_cbb_month_" + ctn).value);
	var year = parseInt(window.frames("_dt2_iframe_" + ctn).document.all("dt2_input_year_" + ctn).value);

	if ( isNaN(year) || isNaN(month) )
		return;

	if ( month == 1 ) {
		year --;
		month = 12;
		_dt2_subYear(ctn);
	} else {
		month --;
	}
	window.frames("_dt2_iframe_" + ctn).document.all("dt2_cbb_month_" + ctn).value = month;
	_dt2_setDT(ctn, year, month, _dt2_getDTDay(ctn));
	_dt2_drawDTDays(ctn, year, month, _dt2_getDTDay(ctn));
}
function _dt2_drawDTDays(ctn, year, month, day) {
	var dayCount = _dt2_getDayCount(year, month);
	var dayIndex = 0;
	var preMonthDayCount = 0, preMonthShowDayCount = 0, nextMonthShowDayCount = 0;
	var startDate;
	var table = window.frames("_dt2_iframe_" + ctn).document.all("_dt2_dttable_" + ctn).tBodies[0];

	if (month > 1)	{
		startDate = new Date(year, month-1, 1);
		preMonthDayCount = _dt2_getDayCount(year, month-1);
	} else {
		startDate = new Date(year-1, 12, 1);
		preMonthDayCount = _dt2_getDayCount(year-1, 12);
	}
	var week = startDate.getDay();
	var strHTML = "";

	preMonthShowDayCount = week;
	if ( week > 0 ) { 	
		if (month == 1) {			
			for ( i = week; i > 0; i -- )
				_g_dt2_days[dayIndex++] = 31 - i + 1;
		} else {
			for ( i = week; i > 0; i -- )
					_g_dt2_days[dayIndex++] = preMonthDayCount - i + 1;
		}
	}
	for ( i = 0; i < dayCount; i ++ ) {
		_g_dt2_days[dayIndex++] = i + 1;
	}
	nextMonthShowDayCount = 42 - dayIndex;
	for ( i = 0; i < nextMonthShowDayCount; i ++ ) {
		_g_dt2_days[dayIndex++] = i + 1;
	}

	//clear all rows
	while ( table.rows.length > 0 ) {
		table.deleteRow();
	}

	for ( i = 0; i < 6; i++ ) {
		aRow = table.insertRow();
		for ( j = 0; j < 7; j++ ) {
			cell = aRow.insertCell();
			cell.align = "center";
			cell.onmousemove = new Function("this.style.cursor='hand'; if ( this.style.color != '#ffffff' ) this.style.backgroundColor='#4aff73';");
			cell.onmouseout = new Function("if ( this.style.color != '#ffffff' ) this.style.backgroundColor='#ffffff';");
			cell.style.fontSize="9pt";
			
			if ( (i*7 + j) < preMonthShowDayCount ) {
				cell.style.color = "#808080";
				cell.onclick = new Function("_dt2_on_selectDay('" + ctn + "', -1, " + _g_dt2_days[i*7 + j] + ");");
			}
			else if ( (42 - (i*7 + j)) <= nextMonthShowDayCount ) {
				cell.style.color = "#909090";
				cell.onclick = new Function("_dt2_on_selectDay('" + ctn + "', 1, " + _g_dt2_days[i*7 + j] + ");");
			}
			else if ( _g_dt2_days[i*7 + j] == day ) {
				cell.style.color = "#ffffff";
				cell.style.backgroundColor = "#004080";
				cell.onclick = new Function("_dt2_closeDTTable('" + ctn + "');");
				//cell.style.backgroundImage="url('" + _g_dt2_imgSelDay + "')";
			}
			else {
				cell.style.color = (j == 0 || j == 6) ? "#f00000" : "#000000";
				cell.onclick = new Function("_dt2_on_selectDay('" + ctn + "', 0, " + _g_dt2_days[i*7 + j] + ");");
			}
			cell.innerText = _g_dt2_days[i*7 + j];
		}
	}
	
	//return strHTML;
}

function _dt2_on_selectDay(ctn, flag, day) {
	var year = parseInt(window.frames("_dt2_iframe_" + ctn).document.all("dt2_input_year_" + ctn).value);
	var month = parseInt(window.frames("_dt2_iframe_" + ctn).document.all("dt2_cbb_month_" + ctn).value);
	if ( isNaN(year) || isNaN(month) )
		return;
	//alert(year+month)
	if ( flag == -1 ) {
		if ( month == 1 ) {
			year --;
			month = 12;
		} else {
			month --;
		}
	}
	else if ( flag == 1 ) {
		if ( month == 12 ) {
			year ++;
			month = 1;
		} else {
			month ++;
		}
	}
	_dt2_setDT(ctn, year, month, day);
	_dt2_closeDTTable(ctn);
	//alert(txtMyGrid.value)
		//alert(eval(ctn+".outerHTML"))
	
}

function _dt2_getDayCount(year, month) {
	switch(month) { 
	case 1:case 3:case 5:case 7:case 8:case 10:case 12:
		return 31;
	case 4:case 6:case 9:case 11:
		return 30;
	case 2:
		return (((year%4)==0) && ((year%10)!=0) ) || ((year%100)==0) ? 29 : 28;
	default:
		return 31;
	}
}

function _dt2_check(ctn) {
	if ( !_dt2_CheckDate( objTxt.value ) ) {
		objTxt.focus();
	}
}

function _dt2_CheckDate( dateStr ) {
	var standStr;
	var newDateObj;
	var strErr, idxMonth, idxDay;
	var year, month, day;

	strErr1 = "标准的日期格式如：\r\n    短日期格式：2000-02-21 \r\n    长日期格式：2000-02-21 21:01:20 或 2000-02-21 21:01\r\n";
	if ( dateStr.length == 0 ) {	
		alert("错误：日期不能为空，请输入标准格式的日期\r\n\r\n" + strErr1 );
		return false;
	}
	standStr = dateStr.replace("-","/");
	if ( dateStr.indexOf("-", 0) != 2 && dateStr.indexOf("-", 0) != 4 )	{
		alert("错误：日期输入不规范！\r\n\r\n" + strErr1);
		return false;
	}
	idxMonth = dateStr.indexOf("-", 0) + 1;
	idxDay = dateStr.indexOf("-", idxMonth) + 1;

	year = dateStr.substring(0, idxMonth - 1);
	month = dateStr.substring(idxMonth, idxDay - 1);
	if ( month < 1 || month > 12 ) {
		alert("错误：输入的月份无效\r\n");
		return false;
	}	
	if (dateStr.indexOf(" ", idxDay) != -1){
		day = dateStr.substring(idxDay, dateStr.indexOf(" ", idxDay));
	}else{
		day = dateStr.substring(idxDay);
	}
	newDateObj = new Date( standStr );
	if ( newDateObj == "NaN" ) {
		alert("错误：日期输入不规范！中间可能有空格或者字符\r\n\r\n" + strErr1);
		return false;
	}
	if ( day != newDateObj.getDate()) {
		alert("错误：日期不是正常公历日期！\r\n\r\n     公元" + parseInt(year) + "年" + parseInt(month) + "月没有" + day + "号！");
		return false;
	}
	return true;
}
function _dt2_GetStdDate( dateStr ) {
	var newDateObj;
	var month, day;

	newDateObj = new Date( dateStr.replace("-", "/") );
	if ( newDateObj == "NaN" )
		return dateStr;

	month = newDateObj.getMonth() + 1;
	day = newDateObj.getDate();

	return newDateObj.getFullYear() + "-" + (month < 10 ? "0" + month : month) + "-" + (day < 10 ? "0" + day : day);
}

/**
	//进入日期参照
*@param obj 输入日期的文本框对象
**/
function SelectDate(obj) {
	var ctrlName;
	if (typeof obj =="undefined"){
		if(event.srcElement.tagName.toUpperCase()=="TD"){
			try {
				var oGrid=txtMyGrid.parentNode.parentNode;
			}catch(E){
				try {
					var oGrid=event.srcElement.parentNode.parentNode.parentNode.parentNode.parentNode;
				}catch(E){
					var oGrid=eval("SKBILLgrid1");
				}
			}
			oGrid.moveedit(event.srcElement);
			ctrlName=oGrid.txt;   //"txtMyGrid"
		//}else if(event.srcElement.tagName == "fc_code"){
		//	ctrlName=event.srcElement.txt
		}else{
			ctrlName=event.srcElement;
		}
	}else if(typeof obj =="object"){
		ctrlName=obj;
	}else {
		ctrlName=eval(obj);
	}
	new DateControl20(ctrlName);
//	alert(event.srcElement.value)
}
function   document.onclick()   //任意点击时关闭该控件 //ie6的情况可以由下面的切换焦点处理代替 
{ 
    with(window.event)
    {
    	//if   (srcElement.getAttribute( "Author ")==null   &&   srcElement   !=   outObject   &&   srcElement   !=   outButton) 
    	//_dt2_closeDTTable(ctn); 
    	if(srcElement!=objTxt &&objTxt !=null){
    		_dt2_closeDTTable(txtname);
    		objTxt = null;
    		txtname = "";
    	}
    } 
} 

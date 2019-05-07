_pub = {// 公共方法封装对象
	lang : {// 语言工具类
		zwzm : function(zw){// 中文转码
			return escape(escape(zw));
		}	
	},
	json : {},
	ajax : {},
	util : {}
};
//用于比较目标字符串在源字符串中是否存在
_pub.util.isContainStr = function(sourceStr,descStr){
	if((","+sourceStr+",").indexOf(","+descStr+",") != -1)
		return true;
	return false;
}


//通过ajax执行sql，支持insert,update,delete
_pub.ajax.ExecuteSqlAjax = function (executeSql){
	var url = getContextPath()+"/ccapp/xtbg/public/util/jsp/executeSqlAjax.jsp";
	var issucess = false;
	params = {
			executeSql : executeSql
			 };
	jQuery.ajax({
		url: url,
		type: 'POST',
		dataType: 'json',
		data: params,
		async : false,
		success: function(data){
			issucess = data.issucess;
		},
		error: function(jqXHR, textStatus, errorThrown){
			//alert("操作失败！");
		}
	});
	return issucess;
}

//通过ajax查询sql，支持select
_pub.ajax.SelectSqlAjax = function (selectSqls){
	var url = getContextPath()+"/ccapp/xtbg/public/util/jsp/selectSqlAjax.jsp";
	var result = "";
	params = {
			selectSql : selectSqls
			 };
	jQuery.ajax({
		url: url,
		type: 'POST',
		dataType: 'json',
		data: params,
		async : false,
		success: function(data){
			result = data.result;
		},
		error: function(jqXHR, textStatus, errorThrown){
			//alert("操作失败！");
			//alert(jqXHR.status)
		}
	});
	return result;
}

_pub.json.formToJSON = function formToJSON(f) {// 转换的主要函数
	var form = $(f);

	json = '{';
	isarray = false;
	for (i = 0, max = form.elements.length; i < max; i++) {
		e = form.elements[i];
		name = e.name;
		if (name.substring(name.length - 2) == '[]') {
			name = name.substring(0, name.length - 2);
			lastarr = name;
			if (isarray == false) {
				json += '"' + name + '":[';
			}
			isarray = true;
		} else {
			if (isarray) {
				json = json.substring(0, json.length - 1) + '],';
			}
			isarray = false;
		}// end else

		switch (e.type) {
		case 'checkbox':
		case 'radio':
			if (!e.checked) {
				break;
			}
		case 'hidden':
		case 'password':
		case 'file':
		case 'text':
			if (!isarray) {
				json += '"' + name + '":';
			}
			json += '"' + e.value.replace(new RegExp('(["\\\\])', 'g'), '\\$1') + '",';
			break;

		case 'button':
		case 'image':
		case 'reset':
		case 'submit':
		default:
		}// end switch
	}
	;// end for

	return json.substring(0, json.length - 1) + '}';
}




// 清空字符串两边的空白
function trim(strMain) {
	if (strMain == null) {
		return "";
	}
	strMain = strMain + "";
	return strMain.replace(/(^\s*)|(\s*$)/g, "");
}

// 为数组去重
Array.prototype.unique = function(){
	var newArray = [],
		temp = {};
	jQuery(this).each(function(){
		temp[typeof(this)+this] = this;
	})
	for(var j in temp){
		newArray.push(temp[j]);
	}
	return newArray;
};
/**
 * 转换该字符串的换行符号为\n
 * 
 * @param str
 * @return
 */
function changeTextareaChar2n(str){
	return str.replaceAll('&#13;&#10;','\n');
}
/**
 * 转换该字符串的换行符号为&#13;&#10;
 * 
 * @param str
 * @return
 */
function changeTextareaChar2special(str){
	return str.replaceAll('\n','&#13;&#10;');
}




/**
 * 对字符串中的某些特定字符进行转义
 * 
 * @param str
 * @return
 */
function descape(str){
	  if(/{\'/.test(str)){
		  str = str.replace("{'","chr(41)");
	  }
	  if(/\'}/.test(str)){
		  str = str.substring(0, str.length - 2) + str.substring(str.length -2, str.length).replace("'}","chr(42)");
	  }
	  if(/\}/.test(str)){
		  str = str.replaceAll("}","chr(46)");
	  }
	  if(/\{/.test(str)){
		  str = str.replaceAll("{","chr(47)");
	  }
	  if(/\'\,\'/.test(str)){
		  str = str.replaceAll("','","chr(43)");
	  }
	  if(/\':\'/.test(str)){
		  str = str.replaceAll("':'","chr(44)");
	  }
	  if(/\#/.test(str)){
		 str = str.replaceAll("#","chr(50)");
	  }
	  if(/\'/.test(str)){
		str = str.replaceAll("'","chr(39)")
	  }
	  if(/\"/.test(str)){
			str = str.replaceAll('"',"chr(45)")
		  }
	  if(/\&/.test(str)){
		str = str.replaceAll("&","chr(38)")
	  }
	  if(/\</.test(str)){
		str = str.replaceAll("<","chr(60)")
	  }
	  if(/\>/.test(str)){
		str = str.replaceAll(">","chr(62)")
	  }
	  if(/\%/.test(str)){
		 str = str.replaceAll("%","chr(37)")
	  }

	  if(/\r\n/.test(str)){
		  str = str.replaceAll("\r\n","chr(64)")
	  } 
	  while(/\\/.test(str)){
		  str = str.replace("\\","chr(40)");
	  }
	  return str;
	}


String.prototype.replaceAll = function (AFindText,ARepText){
  raRegExp = new RegExp(AFindText,"g");
  return this.replace(raRegExp,ARepText);
}

/**
 * 获取当前应用上下文路径
 * 
 * @param str
 * @return
 */
/**
 * 获取当前应用上下文路径
 * @param str
 * @return
 */
function getContextPath() { 
	var contextPath = getCookie("OACONTEXTPATH");//cookie 中获取上下文路径
	
	var curWwwPath = window.document.location.href;
    var pathName = window.document.location.pathname;
    var pos = curWwwPath.indexOf(pathName);
    var localhostPaht = curWwwPath.substring(0,pos);
    var projectName = pathName.substring(0,pathName.substr(1).indexOf('/')+1);
    var fullpath = localhostPaht+projectName;
	
	if(contextPath == "无"){
		//modfi by shuqi.liu 2013-08-26 返回的路径加上projectName
		//return localhostPaht;
		return fullpath;
	}else{
		if(contextPath == null || contextPath == ""){
			$.ajax({
				type : "GET",
				url : fullpath+"/getcontextpath.jsp",
				data : "",
				async:false,
				dataType: "text", 
				contentType : "application/x-www-form-urlencoded; charset=utf-8",
				success : function(msg) {
					contextPath = trim(msg);
					setCookie("OACONTEXTPATH",fullpath,"","",null);
				},
				error: function(XMLHttpRequest, textStatus, errorThrown) {
		           //alert(XMLHttpRequest.status);
		           //alert(XMLHttpRequest.readyState);
		           //alert(textStatus);
					if(XMLHttpRequest.status == 404){
						setCookie("OACONTEXTPATH","无","","",null);
					}
		        }
			});
		}
	}
	return contextPath; 
}

//清空字符串两边的空白
function trim(strMain) {
	if (strMain == null) {
		return "";
	}
	strMain = strMain + "";
	return strMain.replace(/(^\s*)|(\s*$)/g, "");
}

//根据name从cookie中取出值
function getCookie(c_name) {
	if (document.cookie.length > 0) {
		var c_start = document.cookie.indexOf(c_name + "=")
		if (c_start != -1) { 
			c_start = c_start + c_name.length + 1;
			var c_end = document.cookie.indexOf("^",c_start);
			if (c_end==-1) {
				c_end=document.cookie.length;
			}
			return unescape(document.cookie.substring(c_start,c_end));
		} 
	}
	return "";
}

//设置cookie
function setCookie(c_name, n_value, p_name, p_value, expiredays) {
	var exdate = new Date();
	exdate.setDate(exdate.getDate() + expiredays);
	document.cookie = c_name + "=" + escape(n_value) + "^" + p_name + "=" + escape(p_value) 
		+ ((expiredays == null) ? "" : "^;expires=" + exdate.toGMTString());
}

// 判断字符串是否为空
function IsSpace(strMain) {
	var strComp = strMain;
	try {
		if (strComp == "  " || strComp == "" || strComp == " "
				|| strComp == null || strComp == "null" || strComp.length == 0
				|| typeof strMain == "undefined" || strMain == "undefined") {
			return true;
		} else {
			return false;
		}
	} catch (e) {
		return false;
	}
}

function isSpace(strMain){
	return IsSpace(strMain);
}

function delSpace(strMain){
	var strComp = strMain;
	if (strComp == "  " || strComp == "" || strComp == " "  || trim(strComp) == " "
		|| strComp == null || strComp == "null" || strComp.length == 0
		|| typeof strMain == "undefined" || strMain == "undefined") {
		strMain="";
	} 
	return strMain;
}


/**
 * 页面上的字段组装成VO对象
 * 
 * @param vo对像
 * @return
 */
/*
 * function getVoFromPage(vo){ for(var name in vo ){ var obj =
 * document.getElementById(name.toUpperCase()); if(obj){ var vo_node=
 * eval("vo."+name); var vo_value = eval(vo.name); if(vo_node!=null ){
 * eval("vo."+name+".value = trim(obj.value)") ; }else{ eval("vo."+name+" =
 * trim(obj.value)") ; } }else{ var vo_node= eval("vo."+name);
 * if(vo_node!=null){ if(eval("vo."+name+".value")){ }else{ //eval("vo."+name+" =
 * undefined") ;//modifyby yi.yang vo有默认值情况 } }else{ eval("vo."+name+" =
 * undefined"); } } } return vo; }
 */

// 根据value值自动选中select控件中的选项 需要JQuery的支持
function setSelectValue(selectId,selectValue){
	if(!IsSpace(selectValue)){
		jQuery("#"+selectId+" option").each(function(){
			if(jQuery(this).val()==selectValue){
				jQuery(this).attr("selected","true");
			}
		});
	}
}


/* 展示办件历史的公共方法 */

showFlowHistoryByInsId = function(insid){
	var url = getContextPath()+"/ccapp/oa/process/flowprocessing/jsp/showflowhistorytiaozhuan.jsp?insid="+insid;
	var winwidth=(screen.width - 920)/2;
	var winheight=(screen.height - 700)/2-30;
	var freatrues = "height=700,width=920,top="+winheight+"px,left="+winwidth+"px,status=yes,toolbar=no,menubar=no,location=no";

	window.open(url,"",freatrues ); 
}

// 自动根据iframe尺寸调节tab尺寸
function autoSetTabSize(framename){var iframeHeight = jQuery('#' + framename).contents().find("body").attr('scrollHeight');if(iframeHeight > 180){jQuery('#' + framename).height(iframeHeight);}}
/*
 * 函数功能: 初始化年度数据 参数: 控件id 返回值:
 */
function initYearData(obj)
{
    var os = new Array(getLocalDate().substring(0,4),parseInt(getLocalDate().substring(0,4)) - 1 + "",parseInt(getLocalDate().substring(0,4)) - 2 + "",parseInt(getLocalDate().substring(0,4)) - 3 + "",parseInt(getLocalDate().substring(0,4)) - 4 + "",parseInt(getLocalDate().substring(0,4)) - 5 + "");
	addOptions(obj,os,os);
}

/*
 * 函数功能: 默认选中下拉框第一项 需要传入JQuery对象; 参数: 返回值: 无
 */
function initFirstOption(obj)
{
obj.get(0).options[0].selected = true;
}

/*
 * 函数功能: 改变日期的数字 参数: 返回值: 无
 */
function changeDateNum(num){ 
if(num<10)
{
	return "0"+num; 
}else
{
	return num; 
}
} 

/*
 * 函数功能: 获取本地日期 参数: 返回值: 无
 */
function getLocalDate()
{
var date = new Date();
var fullyear = date.getFullYear();
var month = date.getMonth()+1;
month = changeDateNum(month);
var day = date.getDate();	// 之前为getDay(),不能获取正确日期，修改人：陈建华
day = changeDateNum(day);
return fullyear + "-" + month + "-" + day;
}

/**
 * addOptions(selectId,values,innerTexts) 需要传入Jquery对象;
 * 描述：给selectId对象添加选项，values包含选项的值，innerTexts包含选项显示的值。values与innerTexts一一对应。
 */
function addOptions(selectIdObj,values,innerTexts) {
if (values.length != innerTexts.length)
	return;
for (var i = 0; i < values.length; i++) {
	var option = document.createElement("OPTION");
	selectIdObj.get(0).options.add(option);
	option.innerText = innerTexts[i];
	option.value = values[i];
}
}

/*
 * 函数功能: 将对象Obj下拉框中的选项删除. 参数: obj控件对象; needClearAll:是否需要全部清空 返回值: 无
 */
function RemoveOptions(selectObj,needClearAll){
	needClearAll = IsSpace(needClearAll) ? false : needClearAll;
	var optionIndex = selectObj.options.length;
	if (needClearAll)
	{
		for(;optionIndex>=0;optionIndex--){
			selectObj.options.remove(optionIndex);
		}
	} else	
	{
		for(;optionIndex>=1;optionIndex--){
			selectObj.options.remove(optionIndex);
		}
	}
}


/*
 * 函数功能: 获取选中的checkbox的值 参数: name:元素的name; splitString:分隔标识; 返回值:
 * 返回checkbox值的组合. 以此种形式: '111','2222'
 */
function getSelectedCheckboxVal(name,splitString)
{
splitString = (splitString == undefined) ? "," : splitString;
var objChe = document.getElementsByName(name);
var tempVal = "";
for(var i=0;i<objChe.length;i++)
{
	if(objChe[i].checked)
	{
		tempVal += objChe[i].value+ splitString ;    				
	}
}
if(!IsSpace(tempVal))
{
	tempVal = tempVal.substring(0,tempVal.length-1);
}
return tempVal;	
}


/*
 * 函数功能: 初始化月份数据 参数: 控件id 返回值:
 */
function initYFdata(obj)
{
var os_val = new Array("01","02","03","04","05","06","07","08","09","10","11","12");
var os_showVal = new Array("1","2","3","4","5","6","7","8","9","10","11","12");
addOptions(obj,os_val,os_showVal);
obj.value = getLocalDate().substr(5,2)    
}



/*
 * 函数功能: 处理数字 参数: 返回值: 整数数据
 */
function buildData(val)
{
if(isNaN(val)||IsSpace(val))
{
    val = 0;
}
return val;
}

/*
 * 函数功能: 数字的四舍五入 参数: value:值; e精确到小数点后多少位; 返回值: 转换后的数据
 */
function  roundData(value,e)   
{   
var t=1;   
for(;e>0;t*=10,e--);   
for(;e<0;t/=10,e++);   
return   Math.round(value*t)/t;   
}


/*
 * 函数功能: 转换整数 参数: 返回值: 无
 */
function changeToInt(value)
{
var result =  parseInt(value);
if (isNaN(result) || result == "" || result < 1)
{
	return 0;
} else {
	return result;
}	
}

/*
 * 函数功能: 获取临时使用的ID 参数: 返回值: 临时id
 */
function getTempId() {
var date = new Date();
var temp = "$" + date.getTime();	
return temp;
}

/*
 * 函数功能: 获取下拉框的显示值或真实值. 参数: 返回值: 无
 */

function getSelectedOptionValue(obj,type)
{
type = (IsSpace(type)) ? "0" : type;

var returnVal = "";
if (type == "0") // 返回文本值;
{
	returnVal = obj.options[obj.selectedIndex].innerText;    		
}else if(type == "1") { // 返回真实值;
	returnVal = obj.options[obj.selectedIndex].value;    				
}
return returnVal;
}

// 特殊数字处理;如传入08 返回8;
function rebuildString(str)
{
var tmp = str;
if(!IsSpace(tmp))
{
    if(parseInt(tmp) ==0&&tmp.length==2)    
    {
        var v = parseInt(tmp.substring(1,2));
        return v;
    }else{
        return parseInt(tmp);   
    }
} 
}



// 计算两个日期的间隔天数
function DateDiff(sDate1, sDate2){ // sDate1和sDate2是2002-12-18格式
var aDate, oDate1, oDate2, iDays ;
aDate = sDate1.split("-") ;
oDate1 = new Date(aDate[1] + '-' + aDate[2] + '-' + aDate[0]); // 转换为12-18-2002格式
aDate = sDate2.split("-") ;
oDate2 = new Date(aDate[1] + '-' + aDate[2] + '-' + aDate[0]); 
iDays = parseInt(Math.abs(oDate1 - oDate2) / 1000 / 60 / 60 /24); // 把相差的毫秒数转换为天数
return iDays ;
} 

/*
 * 函数功能: 列出两个日期间的所有日期 参数: 返回值: 无
 */
function DateDiffAll(year1,month1,day1,year2,month2,day2)
{
	var s = [];
	if(year1==year2&&month1==month2&&day1==day2)
	{
		s.push(year1+"-"+month1+"-"+day1);
	}else{
		month1 = rebuildString(month1);
		month2 = rebuildString(month1);
		day1 = rebuildString(day1);
		day2 = rebuildString(day2);
		var d1 = new Date(year1,month1,day1);
		var d2 = new Date(year2,month2,day2);
		
		var days = (Date.parse(d2)-Date.parse(d1))/1000/60/60/24;
		
		for(var i = 0;i<=days;i++)
		{
			var d =  new Date(year1,month1,parseInt(day1)+i);
			
			var current_month = "";
			if ((d.getMonth()) >= 10 ) 
			{ 
				current_month += (d.getMonth()) ; 
			} 
			else 
			{ 
				current_month += "0" + (d.getMonth()) ; 
			} 
			var current_day = "";
			if ((d.getDate()) >= 10 ) 
			{ 
				current_day += (d.getDate()) ; 
			} 
			else 
			{ 
				current_day += "0" + (d.getDate()) ; 
			} 
			
			var d = d.getFullYear() + "-" + current_month + "-" + current_day;
			s.push(d)
		}
	}
		return s;
}


/*
 * 函数功能: 返回元素在数组中的位置; 参数: 返回值: 无
 */
function getArrayPosition(value,array){
for(var i in array){
 if(array[i]==value){return i;break;}
}
}


/*
 * 函数功能: 打开用户树 参数: type:org/user.
 * text_id_obj:树id。text_name_obj：树名字。resources：权限，resourcesLogo.properties中。flag：多选单选。
 * 返回值: 无
 */
function openTree(type,text_id_obj,text_name_obj,flag,resources){
type = (type == undefined)? "user": type;
flag = (flag == undefined)? true: flag;
var url;
if(type=="user")
{
	url = "../../tree/jsp/orguserroletree.jsp?ischeck="+flag+"&resourceType="+resources+"&backchooseuserids="+document.getElementById(text_id_obj).value;
}else if(type=="org") {
	var url = "../../tree/jsp/orgroletree.jsp?ischeck="+flag+"&resourceType="+resources;
}
 var treeObj = window.showModalDialog(url,"","dialogWidth=286px;dialogHeight=580px;center:yes;scroll:no");
 if(!IsSpace(treeObj)){
	 document.getElementById(text_id_obj).value=treeObj.id;
	 document.getElementById(text_name_obj).value=treeObj.name; 
	 // text_id_obj.val(treeObj.id);
	// text_name_obj.val(treeObj.name);
 }
}


/*
 * 函数功能: 参数: 返回值: 无
 */
function getCountStringNum(mainString,regString)
{
var mainStringObj = mainString.split(",");
var count = 0;
for(var i=0;i<mainStringObj.length;i++)
{
	if (mainStringObj[i]==regString)
	{
		count++;
	}
}
return count;
}

function getCheckBoxsValue(name) {
	var chk_value = [];
	jQuery('input[name="'+name+'"]:checked').each(function(){    
		chk_value.push(jQuery(this).val());    
	});
	return chk_value.join(",");
}

// 获得url后面的某个参数的值。
function creator_getQueryString(item) {
	var svalue = location.search.match(new RegExp("[\?\&]"+item+"=([^\&]*)(\&?)","i"));
	return svalue ? svalue[1] : svalue;
}

var hiddenOrShowSelArea = function(id,imgId) {
	var none = jQuery("#" + id).css('display');
	if(none == "none"){
		jQuery("#" + id).show();
		jQuery("#" + id).focus();
		jQuery("#" + imgId).removeClass('all_search_condition');
		jQuery("#" + imgId).addClass('all_search_condition_up');
	} else{
		jQuery("#" + id).hide();
		jQuery("#" + imgId).removeClass('all_search_condition_up');
		jQuery("#" + imgId).addClass('all_search_condition');
	 }
}
/**
 * 设置输入框的格式及初始值
 * 
 * @param showValue
 *            输入框默认展示的值
 * @param inputId
 *            输入框的id（示例 #name）
 */
function defaultValueControl(showValue,inputId,defaultColor,normalColor){
	this.showValue = showValue ? showValue : "搜索";
	this.inputId = inputId ? inputId : "" ;
	this.normalColor = normalColor?normalColor : "black";
	this.defaultColor = defaultColor ? defaultColor : "#666666";
	
	// 用于防止闭包导致的作用域替换问题
    var This = this;
		
	this.setBlurValue = function(){
	   // 如果用户没有输入任何值，则设置为默认值
	   if(!jQuery(This.inputId).val() || jQuery(This.inputId).val()==This.showValue){		   
		 // 设置默认颜色为灰色
        jQuery(This.inputId).css('color',This.defaultColor);
        jQuery(This.inputId).val(This.showValue);        
        jQuery(This.inputId).attr("val",This.showValue);
	   }
	};

	this.setFocusValue = function(){
        if(This.showValue == jQuery(This.inputId).val()){
        	jQuery(This.inputId).val("");
        	jQuery(This.inputId).css('color',This.normalColor);
    		jQuery(This.inputId).attr("val","");
        }		
	};

	this.init = function(){
        // 绑定事件
		jQuery(this.inputId).bind('blur',this.setBlurValue);
		jQuery(this.inputId).bind("focus",this.setFocusValue);
		// 初始设值
		this.setBlurValue();
	};
	/**
	 * 获得搜索框的值
	 */
	this.val = function(){
		var value = jQuery(this.inputId).val();
		if(value == this.showValue){
		  return "";	
		}
		return value;
	};	
}
	/**
	 * 设置输入框的格式及初始值
	 * 
	 * @param TextValue
	 *            输入的模糊查询的值
	 * 
	 */
	function selectText(TextValue){
		 var txt=new RegExp("[ ,\\`,\\！,\\￥,\\【,\\】,\\~,\\!,\\@,\#,\\$,\\%,\\^,\\+,\\*,\\&,\\\\,\\/,\\?,\\|,\\:,\\.,\\<,\\>,\\{,\\},\\(,\\),\\',\\;,\\=,\"]");
		 var flag = true;
		 var arr = new Array();// 取数组
		 arr = TextValue.split(",");
		 for(var i = 0; i < arr.length ; i++){
			flag =  txt.test(arr[i]);
			 if(flag){
				 alert("请不要输入特殊字符!"); 
				 
				 return false;
			 }
		 }
		 return true;
	}


/*
 * 函数: elementReadOnly 说明: 页面元素只读，此方法需引入HTMLUtil.js 参数: elements 需要只读的对象的ID的数组
 * 作者： 何世星
 */
function elementReadOnly(elements){
	if(!IsSpace(elements)){
		for(var i = 0;i < elements.length;i++){
			try{
				if(elements[i] == "regTime") {
					continue;
				}
			    HTMLUtil.readOnly(document.getElementById(elements[i]),"commonReadOnly");
		    }catch(e){}
		}
	}
}

/**
 * 获得文档对象的高度
 * 
 * @param num
 *            减掉的高度
 * @return
 */
function getDocumentHeight(num){
	   var subtractHeight = num ? num : 0;     
	   return document.body.clientHeight>100?document.body.clientHeight-subtractHeight: 100;
}

/*
函数:   getCurrentFilePath
说明:   根据location.pathname当前文件URL的域名（域名IP）后的部分来截取当前文件上下文路径     hai.huang 2013-06-07
参数:   无
返回值: 返回上下文路径  如： /工程名/目录名/……/目录名/
*/
function getCurrentFilePath() {
	pathname=location.pathname;
	return pathname.substring(0,pathname.lastIndexOf("/")+1);
}
/*
函数:   isNumber
说明:   是否为正整数    hai.huang 2013-06-17
参数:   str
返回值: true or false
*/
function isNumber(str) {
    var type = "^[0-9]*[1-9][0-9]*$";
    var re = new RegExp(type);
    if (str.match(re) == null) {
        return false;
    }
    return true;
}

/*
 * 获取当前时间
 */
function getCurrentTime(){
	var date = new Date();
	return date.toLocaleTimeString();
}
/*
 * 标签通用设置配置的隐藏域
 */
function setHiddenValue(e,hiddenName){
	jQuery("#"+hiddenName).val(trim(delSpace(jQuery(e).children('option:selected').text())));
}
/*
 * 得到时分秒
 */
function getNowTime(){   
    var now= new Date();   
    var hour=now.getHours();   
    var minute=now.getMinutes();   
    var second=now.getSeconds(); 
    if(hour.length==1) hour="0"+hour;
    if(minute.length==1) minute="0"+minute;
    if(second.length==1) second="0"+second;
    var nowdate=hour+":"+minute+":"+second; 
    return nowdate;
}
/*
 * 得到年月日 时分秒
 */
function getNowDateTime(){   
    var now= new Date();   
    var hour=now.getHours();   
    var minute=now.getMinutes();   
    var second=now.getSeconds();   
    var nowdate=getLocalDate()+" "+hour+":"+minute+":"+second; 
    return nowdate;
}

/*
 * 前台对应解反义的JS方法
 */
function decoding4jQuery(s){
	s=s.replaceAll("&quot;","\"");
	s=s.replaceAll("&apos;","\'");
	return s;
}
 
//检测输入字符,若含非法字符,自动去除
 function checkInsert(e) {
 	var val = e.value.replace(/['"\<\>\/]+/img, "");
 	if(e.value!=val)
 	    e.value = val;
 }
 //检测粘贴字符串,若含非法字符,自动去除
 function checkPaste() {
     // add by 陈志武   添加判断  解决 当粘贴板为空的情况下 clipboardData.getData报错 2010-3-31
     if(!clipboardData){
 		clipboardData.setData("text", clipboardData.getData("text").replace(/['"\<\>\/]+/img, ""));
 	}
 }
 
 //返回只有年月日的日期 yyyy-mm-dd
function getFormatterDate(str){
	var r="";
	if(!isSpace(str)){
		r=str.substring(0,10);
	}
	return r;
}
/*
财政厅专用:取数据的时候替换的内容
*/
function getreplacecontent(oldcontent,AFindText,ARepText){
	if(IsSpace(oldcontent)){
		return "";
	}
	var newcontent = "";
	newcontent = oldcontent.replaceAll(AFindText,ARepText);
	return newcontent;
}

 
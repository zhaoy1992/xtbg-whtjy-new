/**
 * 沈联成 2012-8-15 added
 */
Array.prototype.remove = function(from, to) {
	var rest = this.slice((to || from) + 1 || this.length);
	this.length = from < 0 ? this.length + from : from;
	return this.push.apply(this, rest);
};

(function($) {
	$._pageCache = function() {
	};
	$.extend($._pageCache, {
		cacheID : null
	/* 树ID */}, {
		cacheValue : null
	/* 树ID */});
})(jQuery);

var pageCache = new Array();/* 页面控件缓存 */

var styleID = "";// 样式切换
/**
 * 此处加配置
 */
var setStyle = function(styleName) {
	styleID = styleName;
}
var getStyle = function(styleName) {
	return styleName + styleID;
}
function addStyle(o, c) {
	jQuery(o).addClass(c + styleID);
}

function findPageCacheName(name) {
	var object = null;
	jQuery.each(pageCache, function(key, val) {
		if (val.cacheID == name) {
			object = val.cacheValue;
		}
	});
	return object;
}
function findPageCacheNameToIndex(name) {
	var object = null;
	var _key = -1;
	jQuery.each(pageCache, function(key, val) {
		if (val.cacheID == name) {
			_key = key;
		}
	});
	return _key;
}
function removePageCache(name) {

	var key = findPageCacheNameToIndex(name);
	if (-1 != key) {
		pageCache.remove(key);
	}
}
function pushPageCache(name, value) {
	removePageCache(name);
	var c = new jQuery._pageCache();
	c.cacheID = name;
	c.cacheValue = value;
	pageCache.push(c);
}

var createDiv = function(id, className) {
	var div = window.top.document.createElement("div");
	jQuery(div).attr("id", id);
	addStyle(div, className);
	return div;
}

function sleep(n) {
	var start = new Date().getTime();
	while (true)
		if (new Date().getTime() - start > n)
			break;
}
(function($) {

	$.lockDiv = function() {
		var lockdivObj;
		this.init = function() {
			lockdivObj = createDiv('', "_lock_div");
			if(this.zindex){
				$(lockdivObj).css("z-index",this.zindex);
			}
			$(window.top.document.body).append($(lockdivObj));
			$(lockdivObj).focus();
			//$(lockdivObj).append('<iframe id="DivFrm" src="" scrolling="no" frameborder="0" style="position: absolute;top: 0px; left: 0px; display: none;"></iframe>');
			 $(lockdivObj).append('<iframe frameborder="0" id="_DivFrm" style="position:absolute; visibility:inherit; top:0px; left:0px; width:100%; height:100%; z-index:-1; filter=Alpha(style=0,opacity=0);"></iframe>');
		};
		this.remove = function() {
			try{
				window.top.$("#_DivFrm").remove();
			}catch(error){$("#_DivFrm").remove();}
			$(lockdivObj).remove();
			
		};
	};
	$.extend($.lockDiv, {});
})(jQuery);

(function($) {
	$.alertDiv = function(msg,isAddTopObjectFlag) {
		var alertObject;
		var lock;
		this.init = function() {
			alertObject = createDiv("", "_alert_div_root");
			if(isAddTopObjectFlag)
			$(window.top.document.body).append($(alertObject));
			else
				$(document.body).append($(alertObject));
			lock = new $.lockDiv();
			lock.init();
			var title = createDiv("_alert_div_title", "_alert_div_title");
			$(alertObject).append($(title));
			var titleText = createDiv("_alert_div_title_text",
					"_alert_div_title_text");
			var titleImg = createDiv("_alert_div_title_img",
					"_alert_div_title_img");
			var close = createDiv("_alert_div_title_close",
					"_alert_div_title_close");
			$(title).append($(close));
			$(title).append($(titleImg));
			$(title).append($(titleText));
			$(titleText).html("提示");
			var text = createDiv("_alert_div_text", "_alert_div_text");
			$(alertObject).append($(text));
			var foot = createDiv("_alert_div_edit", "_alert_div_edit");
			$(alertObject).append($(foot));
			var butOk = document.createElement("input");
			$(butOk).attr("type", "button");
			$(butOk).val('确定');
			$(butOk).addClass("_alert_div_edit_ok");
			$(foot).append($(butOk));
			$(butOk).click(function() {
				lock.remove();
				$(alertObject).remove();
			});
			$(text).html(msg);
			$(close).click(function() {
				$(alertObject).remove();
				lock.remove();
			});
			$(butOk).focus();
		};
		this.remove = function() {
			$(alertObject).remove();
			lock.remove();
		};
	};
	$.extend($.alertDiv, {});
})(jQuery);

(function($) {
	$.alert = function(msg, openObject, p) {
		var alertObject;
		var lock;
		this.init = function() {
			alertObject = createDiv("", "_alert_div_root");
			$(window.top.document.body).append($(alertObject));
			lock = new $.lockDiv();
			lock.init();
			var title = createDiv("_alert_div_title", "_alert_div_title");
			$(alertObject).append($(title));
			var titleText = createDiv("_alert_div_title_text",
					"_alert_div_title_text");

			var titleImg = createDiv("_alert_div_title_img",
					"_alert_div_title_img");
			var close = createDiv("_alert_div_title_close",
					"_alert_div_title_close");
			$(title).append($(titleImg));
			$(title).append($(titleText));
			$(title).append($(close));
			$(titleText).html(p.headerText);
			var text = createDiv("_alert_div_text", "_alert_div_text");
			$(alertObject).append($(text));
			var foot = createDiv("_alert_div_edit", "_alert_div_edit");
			$(alertObject).append($(foot));
			$(close).click(function() {
				if (!(p.NoName||p.cancelName)&& p.okFunction) {
					p.okFunction(p.okParam);
				}
				$(alertObject).remove();
				lock.remove();
			});

			if (p.NoName) {
				var butNo = document.createElement("input");
				$(butNo).attr("type", "button");
				$(butNo).val(p.NoName);
				$(butNo).addClass("_z_tree_edit_clear");
				$(foot).append($(butNo));
				$(butNo).click(function() {
					lock.remove();
					$(alertObject).remove();
					if (p.NoFunction) {
						p.NoFunction(p.NoParam);
					}
				});
			}

			if (p.cancelName) {
				var cancel = document.createElement("input");
				$(cancel).attr("type", "button");
				$(cancel).val(p.cancelName);
				$(cancel).addClass("_z_tree_edit_clear");
				$(foot).append($(cancel));
				$(cancel).click(function() {
					lock.remove();
					$(alertObject).remove();
					if (p.cancelFunction) {
						p.cancelFunction(p.cancelParam);
					}
				});
			}
			if (p.okName) {
				var butOk = document.createElement("input");
				$(butOk).attr("type", "button");
				$(butOk).val(p.okName);
				$(butOk).addClass("_alert_div_edit_ok");
				$(foot).append($(butOk));
				$(butOk).click(function() {
					lock.remove();
					$(alertObject).remove();
					if (p.okFunction) {
						p.okFunction(p.okParam);
					}
				});
				$(butOk).focus();
			}

			$(text).html(msg);
		};
		this.remove = function() {
			if (p.okFunction) {
				p.okFunction(p.okParam);
			}
			$(alertObject).remove();
			lock.remove();
		};
	};
	$.extend($.alertDiv, {});
})(jQuery);

(function($) {
	$.alertWindows = function(windowId, urlorHtml, headerText, width, height,
			top, left, type, Function, sueprwindow,isLogin) {
		var win;
		var lock;
		this.init = function() {
			win = createDiv("_win_div_root" + windowId, "_win_div_root");
			type = type ? type : 'url';
			if(isLogin){
				$("body").append($(win));
			}else
			$(window.top.document.body).append($(win));
			lock = new $.lockDiv();
			lock.init();
			if (width && '' != width) {
				$(win).width(width)
			}
			if (height && '' != height) {
				$(win).height(height)
				$(win).height($(win).height()+2)
			}
			if (top) {
				$(win).css("top", top);
			}
			if (left) {
				$(win).css("left", left);
			}
			var title = createDiv("_win_div_title" + windowId, "_win_div_title");
			$(win).append($(title));
			var titleImg = createDiv("_win_div_title_img" + windowId,
					"_win_div_title_img");
			var titleText = createDiv("_win_div_title_text" + windowId,
					"_win_div_title_text");

			var close = createDiv("_win_div_title_close" + windowId,
					"_win_div_title_close");

			$(titleText).html(headerText);
			$(title).append($(titleImg));
			$(title).append($(titleText));
			$(title).append($(close));
			var obj = new Object();
			obj.superwindow = sueprwindow;
			obj.window = this;
			pushPageCache(windowId, obj);
			$(close).click(function() {
				if (Function)
					Function();
				$(win).remove();
				lock.remove();
				removePageCache(windowId);
			});
			var doc = createDiv("_win_document_" + windowId, "_win_document");
			$(doc).height($(win).height() - $(title).height());
			$(doc).width($(win).width());
			$(win).append($(doc));
			var subWin;
			if ('url' == type) {
				var iframe = document.createElement("iframe");
				$(iframe).addClass("_win_document_body");
				$(iframe).attr('id', "_win_document_body_" + windowId);
				$(iframe).width($(doc).width());
				$(iframe).height($(doc).height());
				$(iframe).attr("src", urlorHtml);
				$(iframe).attr("marginheight", "0");
				$(iframe).attr("marginwidth", "0");
				$(iframe).attr("broder", "0");
				$(iframe).attr("frameborder", "0");
				$(doc).append($(iframe));
				var onloadifr = function() {

				}
				function load() {
					iframe.onload = iframe.onreadystatechange = iframeload;
				}
				function iframeload() {
					/*if (!iframe.readyState || iframe.readyState == "complete") {
						/*$(iframe)
								.contents()
								.find("body")
								.attr(
										"style",
										"overflow:auto;scrollbar-arrow-color: #75571F;scrollbar-face-color: #FDEDC1;scrollbar-3dlight-color: #fff;scrollbar-highlight-color: #FFF9EB;scrollbar-shadow-color: #E0C07F;scrollbar-darkshadow-color: #FDEDC1;scrollbar-track-color: #FAFAFD;scrollbar-base-color: #F1C555;");
					}*/
					return;

				}
				$(iframe).attr("onload", load);
				subWin = $(iframe.window);
			} else {
				$(doc).append(urlorHtml);
			}
			return subWin;

		};
		this.remove = function() {
			$(win).remove();
			lock.remove();
		};
	};
	$.extend($.alertDiv, {});
})(jQuery);

// 根据大小月份取得天数
function getMaxDayOfDate(y1, m1) {
	var maxDay;
	if (m1 == 1 || m1 == 3 || m1 == 5 || m1 == 7 || m1 == 8 || m1 == 10
			|| m1 == 12) {
		maxDay = 31;
	} else if (m1 == 4 || m1 == 6 || m1 == 9 || m1 == 11) {
		maxDay = 30;
	} else if (m1 == 2 && isRunYear(y1)) {
		maxDay = 29;
	} else if (m1 == 2) {
		maxDay = 28;
	}
	return maxDay;
}

// 根据传入的年份参数，判断是否是润年，即能够被4整除，但不能被100整除，同时满足时；或者能被400整除；
function isRunYear(y) {
	if (y % 4 == 0 && y % 100 != 0) {
		return true;
	} else if (y % 400 == 0) {
		return true;
	} else {
		return false;
	}
}

//提示层
function loadCreatDiv(){
		var ajax= createDiv("_div_flow","_div_flow");
	    if(true){
	    	var count=0;
	    	function load(){
	    		if(count%3==0){
	    			jQuery(ajax).html("正文正在加载中，请稍等..");
	    		}else if(count%3==1){
	    			jQuery(ajax).html("正文正在加载中，请稍等.....");
	    		}else if(count%3==2){
	    			jQuery(ajax).html("正文正在加载中，请稍等.......");
	    		}
	    		count++;
	    	}
	    	jQuery(ajax).html("正文正在加载中，请稍等...");
	    	jQuery(ajax).css("width","1200px");
	    	jQuery(ajax).css("height","1200px");
	    	jQuery(ajax).css("z-index","10000");
	    	interval = parent.setInterval(load, 500);
	        window.top.jQuery("body").append(jQuery(ajax));
	    } 
} 

//提示层删除
function RemovLoadDiv(){
	window.top.jQuery("._div_flow").remove();
} 



function ajaxTools(req,hideLoading) {
    var ajax= createDiv("_ajax","_ajax");
    var interval = null;
    if(!hideLoading){
    	var count=0;
    	function load(){
    		if(count%3==0){
    			jQuery(ajax).html("Loading..");
    		}else if(count%3==1){
    			jQuery(ajax).html("Loading....");
    		}else if(count%3==2){
    			jQuery(ajax).html("Loading......");
    		}
    		count++;
    	}
    	jQuery(ajax).html("loading...");
    	interval = setInterval(load, 500);
        window.top.jQuery("body").append(jQuery(ajax));
    }
    
	jQuery.ajax({
		type : req.type ? data.type : "post",// 使用get方法访问后台
		dataType : req.dataType ? req.dataType : "script",// 返回script格式的数据
		url : req.url,// 要访问的后台地址
		data :"data="+req.data+"&classID="+req.classID+"&method="+req.method,// 要发送的数据
		complete : function() {
			clearInterval(interval);
			window.top.jQuery("._ajax").remove();
		},
		success :function(){
			clearInterval(interval);
			window.top.jQuery("._ajax").remove();
			if(json.error){
				alert(json.error);
			}else{
				req.success();
			}
			
		},
		error:function(){
			clearInterval(interval);
			window.top.jQuery("._ajax").remove();
			//alert("您离开太长时间，请刷新重新登陆!");
			window.top.location.reload();
			if(req.error){
				req.error();
			}
		}
	});
}

function ajaxCommit(req,hideLoading) {
    var ajax= createDiv("_ajax","_ajax");
    var interval = null;
    if(!hideLoading){
    	var count=0;
    	function load(){
    		if(count%3==0){
    			jQuery(ajax).html("Loading..");
    		}else if(count%3==1){
    			jQuery(ajax).html("Loading....");
    		}else if(count%3==2){
    			jQuery(ajax).html("Loading......");
    		}
    		count++;
    	}
    	jQuery(ajax).html("loading...");
    	interval = setInterval(load, 500);
        window.top.jQuery("body").append(jQuery(ajax));
    }
    
	jQuery.ajax({
		type : req.type ? data.type : "post",// 使用get方法访问后台
		url : req.url,// 要访问的后台地址
		data :"data="+req.data+"&classID="+req.classID+"&method="+req.method,// 要发送的数据
		complete : function() {
			clearInterval(interval);
			window.top.jQuery("._ajax").remove();
		},
		success :function(ss){
			clearInterval(interval);
			window.top.jQuery("._ajax").remove();
			req.success(ss);
			
		},
		error:function(){
			clearInterval(interval);
			window.top.jQuery("._ajax").remove();
			alert("error:Leave time is too long, please refresh the entire webpage!");
			if(req.error){
				req.error();
			}
		}
	});
}

//得到每周的最后一天(周日)

function getLastDateOfWeek(theDate){
	var firstDateOfWeek=cloneDate(theDate);;
	firstDateOfWeek.setDate(theDate.getDate() - theDate.getDay()+7); 
	return firstDateOfWeek;	
}
//得到每周的第一天(周一)
function getFirstDateOfWeek(theDate){
	var lastDateOfWeek=cloneDate(theDate);
	lastDateOfWeek.setDate(theDate.getDate() - theDate.getDay()+1); 
	return lastDateOfWeek;	
}
// 时间比较的方法，如果d1时间比d2时间大，则返回true   
function compareDate(d1, d2) {
	  return Date.parse(d1.replace(/-/g, "/")) >= Date.parse(d2.replace(/-/g, "/"))   
}
//时间比较的方法，如果d1时间比d2时间小，则返回true   
function compareDate2(d1, d2) {
	  return Date.parse(d1.replace(/-/g, "/")) < Date.parse(d2.replace(/-/g, "/"))   
}
//yyyy-mm-dd HH:SS
function stringToDate(str) {
	str = str.replace(":", "-").replace(" ", "-");
	var arr = str.split("-");
	var m = arr[1];
	if(m.indexOf("0")==0){
		 m = m.replace("0","");
	}
	m = parseInt(m) - 1;
    var dd = new Date(arr[0], m, arr[2], arr[3], arr[4]);
	return dd;
}

function cloneDate(date){
	var cloneDatev =new Date(date.getFullYear(),date.getMonth(),date.getDate(),date.getHours(),date.getMinutes(),date.getSeconds()); 
	return cloneDatev;
}
/**
 * 获取当前应用上下文路径
 * @param str
 * @return
 */
function getContextPath() { 
	var contextPath = document.location.pathname;

	if(contextPath.substr(0,1) != "/"){
		contextPath="/"+contextPath;
	}
	var index =contextPath.substr(1).indexOf("/"); contextPath = contextPath.substr(0,index+1); 
	delete index;
	return contextPath; 
}

function loadCss(p,win){
	   win = win?win:window;
		var link = null;
		for (var i = 0, count = p.length; i < count; i++) {
			link = win.document.createElement("link");
			$(link).attr("type", "text/css");
			$(link).attr("rel", "stylesheet");
			$(link).attr("href", getContextPath() + "/" +  p[i]);
			win.document.getElementsByTagName("head")[0].appendChild(link);
		}
		link = null;
}

function readyCookie(name){
	return $.cookie(name); 
}

function getSystemStyle(defStyle){
	defStyle =defStyle?defStyle:'';
	var style = readyCookie("myStyel");
	if(null == style){
		style = defStyle;
	}
	$.cookie("myStyel",style,{expires:8});
	return style;
}

jQuery.cookie = function(name, value, options) { 
    if (typeof value != 'undefined') { 
              options = options || {}; 
              if (value === null) { 
                        value = ''; 
                        options = $.extend({}, options); 
                        options.expires = -1; 
              } 
              var expires = ''; 
              if (options.expires && (typeof options.expires == 'number' || options.expires.toUTCString)) { 
                        var date; 
                        if (typeof options.expires == 'number') { 
                                  date = new Date(); 
                                  date.setTime(date.getTime() + (options.expires * 24 * 60 * 60 * 1000)); 
                        } else { 
                                  date = options.expires; 
                        } 
                        expires = '; expires=' + date.toUTCString(); 
              } 
              var path = options.path ? '; path=' + (options.path) : ''; 
              var domain = options.domain ? '; domain=' + (options.domain) : ''; 
              var secure = options.secure ? '; secure' : ''; 
              document.cookie = [name, '=', encodeURIComponent(value), expires, path, domain, secure].join(''); 
    } else { 
              var cookieValue = null; 
              if (document.cookie && document.cookie != '') { 
                        var cookies = document.cookie.split(';'); 
                        for (var i = 0; i < cookies.length; i++) { 
                                  var cookie = jQuery.trim(cookies[i]); 
                                  if (cookie.substring(0, name.length + 1) == (name + '=')) { 
                                            cookieValue = decodeURIComponent(cookie.substring(name.length + 1)); 
                                            break; 
                                  } 
                        } 
              } 
              return cookieValue; 
    } 
}; 
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    
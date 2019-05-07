
GDNetMenuDown.spacerGif = "image/x.gif"; 
GDNetMenuDown.dingbatOn = "images/expand-1.gif"; 
GDNetMenuDown.dingbatOff = "images/expand-0.gif"; 
GDNetMenuDown.dingbatSize = 10; 
GDNetMenuDown.menuPadding = 1; 
GDNetMenuDown.itemPadding = 1; 
GDNetMenuDown.shadowSize = 2; 
GDNetMenuDown.shadowOffset = 3; 
GDNetMenuDown.shadowColor = "#000000"; 
GDNetMenuDown.backgroundColor = "#E8F2DB"; 
GDNetMenuDown.hideDelay = 200; 
GDNetMenuDown.slideTime = 600; 

GDNetMenuDown.reference = {topLeft:1,topRight:2,bottomLeft:3,bottomRight:4};
GDNetMenuDown.direction = {down:1,right:2};
GDNetMenuDown.registry = [];
GDNetMenuDown._maxZ = 100;

GDNetMenuDown.isSupported = function() {
if (typeof GDNetMenuDown.isSupported.r == "boolean") 
return GDNetMenuDown.isSupported.r;
var ua = navigator.userAgent.toLowerCase();
var an = navigator.appName;
var r = false;
if (ua.indexOf("gecko") > -1) r = true; 
else if (an == "Microsoft Internet Explorer") {
if (document.getElementById) r = true; 
}
GDNetMenuDown.isSupported.r = r;
return r;
}

GDNetMenuDown.initialize = function() {
for (var i = 0, menu = null; menu = this.registry[i]; i++) {
menu.initialize();
}
}

GDNetMenuDown.renderAll = function() {
var aMenuHtml = [];
for (var i = 0, menu = null; menu = this.registry[i]; i++) {
aMenuHtml[i] = menu.toString();
}
document.write(aMenuHtml.join(""));
}

function GDNetMenuDown(oActuator, iDirection, iLeft, iTop, iReferencePoint, parentMenuSet) {

this.addItem = addItem;
this.addMenu = addMenu;
this.toString = toString;
this.initialize = initialize;
this.isOpen = false;
this.show = show;
this.hide = hide;
this.items = [];

this.onactivate = new Function(); 
this.ondeactivate = new Function(); 
this.onmouseover = new Function(); 
this.onqueue = new Function(); 

this.index = GDNetMenuDown.registry.length;
GDNetMenuDown.registry[this.index] = this;
var id = "GDNetMenuDown" + this.index;
var contentHeight = null;
var contentWidth = null;
var childMenuSet = null;
var animating = false;
var childMenus = [];
var slideAccel = -1;
var elmCache = null;
var ready = false;
var _this = this;
var a = null;
var pos = iDirection == GDNetMenuDown.direction.down ? "top" : "left";
var dim = null;

function addItem(sText, sUrl, sOpenWin) {
var item = new GDNetMenuDownItem(sText, sUrl, sOpenWin, this);
item._index = this.items.length;
this.items[item._index] = item;
}
function addMenu(oMenuItem) {
if (!oMenuItem.parentMenu == this) throw new Error("Cannot add a menu here");
if (childMenuSet == null) childMenuSet = new GDNetMenuDownSet(GDNetMenuDown.direction.right, -5, 2, GDNetMenuDown.reference.topRight);
var m = childMenuSet.addMenu(oMenuItem);
childMenus[oMenuItem._index] = m;
m.onmouseover = child_mouseover;
m.ondeactivate = child_deactivate;
m.onqueue = child_queue;
return m;
}
function initialize() {
initCache();
initEvents();
initSize();
ready = true;
}
function show() {

if (ready) {
_this.isOpen = true;
animating = true;
setContainerPos();
elmCache["clip"].style.visibility = "visible";
elmCache["clip"].style.zIndex = GDNetMenuDown._maxZ++;

slideStart();
_this.onactivate();
}
}
function hide() {
if (ready) {
_this.isOpen = false;
animating = true;
for (var i = 0, item = null; item = elmCache.item[i]; i++) 
dehighlight(item);
if (childMenuSet) childMenuSet.hide();
slideStart();
_this.ondeactivate();
}
}
function setContainerPos() {
var sub = oActuator.constructor == GDNetMenuDownItem; 
var act = sub ? oActuator.parentMenu.elmCache["item"][oActuator._index] : oActuator; 
var el = act;
var x = 0;
var y = 0;
var minX = 0;
var maxX = (window.innerWidth ? window.innerWidth : document.body.clientWidth) - parseInt(elmCache["clip"].style.width);
var minY = 0;
var maxY = (window.innerHeight ? window.innerHeight : document.body.clientHeight) - parseInt(elmCache["clip"].style.height);

while (sub ? el.parentNode.className.indexOf("GDNetMenuDownMenu") == -1 : el.offsetParent) {
x += el.offsetLeft;
y += el.offsetTop;
if (el.scrollLeft) x -= el.scrollLeft;
if (el.scrollTop) y -= el.scrollTop;
el = el.offsetParent;
}
if (oActuator.constructor == GDNetMenuDownItem) {
x += parseInt(el.parentNode.style.left);
y += parseInt(el.parentNode.style.top);
}
switch (iReferencePoint) {
case GDNetMenuDown.reference.topLeft:
break;
case GDNetMenuDown.reference.topRight:
x += act.offsetWidth;
break;
case GDNetMenuDown.reference.bottomLeft:
y += act.offsetHeight;
break;
case GDNetMenuDown.reference.bottomRight:
x += act.offsetWidth;
y += act.offsetHeight;
break;
}
x += iLeft;
y += iTop;
x = Math.max(Math.min(x, maxX), minX);
y = Math.max(Math.min(y, maxY), minY);
elmCache["clip"].style.left = x + "px";
elmCache["clip"].style.top = y + "px";
}
function slideStart() {
var x0 = parseInt(elmCache["content"].style[pos]);
var x1 = _this.isOpen ? 0 : -dim;
if (a != null) a.stop();
a = new Accelimation(x0, x1, GDNetMenuDown.slideTime, slideAccel);
a.onframe = slideFrame;
a.onend = slideEnd;
a.start();
}
function slideFrame(x) {
elmCache["content"].style[pos] = x + "px";
}
function slideEnd() {
if (!_this.isOpen) elmCache["clip"].style.visibility = "hidden";
animating = false;
}
function initSize() {

var ow = elmCache["items"].offsetWidth;
var oh = elmCache["items"].offsetHeight;
var ua = navigator.userAgent.toLowerCase();

elmCache["clip"].style.width = ow + GDNetMenuDown.shadowSize + 2 + "px";
elmCache["clip"].style.height = oh + GDNetMenuDown.shadowSize + 2 + "px";

elmCache["content"].style.width = ow + GDNetMenuDown.shadowSize + "px";
elmCache["content"].style.height = oh + GDNetMenuDown.shadowSize + "px";
contentHeight = oh + GDNetMenuDown.shadowSize;
contentWidth = ow + GDNetMenuDown.shadowSize;
dim = iDirection == GDNetMenuDown.direction.down ? contentHeight : contentWidth;

elmCache["content"].style[pos] = -dim - GDNetMenuDown.shadowSize + "px";
elmCache["clip"].style.visibility = "hidden";

if (ua.indexOf("mac") == -1 || ua.indexOf("gecko") > -1) {

elmCache["background"].style.width = ow + "px";
elmCache["background"].style.height = oh + "px";
elmCache["background"].style.backgroundColor = GDNetMenuDown.backgroundColor;

elmCache["shadowRight"].style.left = ow + "px";
elmCache["shadowRight"].style.height = oh - (GDNetMenuDown.shadowOffset - GDNetMenuDown.shadowSize) + "px";
elmCache["shadowRight"].style.backgroundColor = GDNetMenuDown.shadowColor;



elmCache["shadowBottom"].style.top = oh + "px";
elmCache["shadowBottom"].style.width = ow - GDNetMenuDown.shadowOffset + "px";
elmCache["shadowBottom"].style.backgroundColor = GDNetMenuDown.shadowColor;
}

else {

elmCache["background"].firstChild.src = GDNetMenuDown.backgroundPng;
elmCache["background"].firstChild.width = ow;
elmCache["background"].firstChild.height = oh;

elmCache["shadowRight"].firstChild.src = GDNetMenuDown.shadowPng;
elmCache["shadowRight"].style.left = ow + "px";
elmCache["shadowRight"].firstChild.width = GDNetMenuDown.shadowSize;
elmCache["shadowRight"].firstChild.height = oh - (GDNetMenuDown.shadowOffset - GDNetMenuDown.shadowSize);



elmCache["shadowBottom"].firstChild.src = GDNetMenuDown.shadowPng;
elmCache["shadowBottom"].style.top = oh + "px";
elmCache["shadowBottom"].firstChild.height = GDNetMenuDown.shadowSize;
elmCache["shadowBottom"].firstChild.width = ow - GDNetMenuDown.shadowOffset;
}
}
function initCache() {
var menu = document.getElementById(id);
var all = menu.all ? menu.all : menu.getElementsByTagName("*"); 
elmCache = {};
elmCache["clip"] = menu;
elmCache["item"] = [];
for (var i = 0, elm = null; elm = all[i]; i++) {
switch (elm.className) {
case "items":
case "content":
case "background":
case "shadowRight":
case "shadowBottom":
elmCache[elm.className] = elm;
break;
case "item":
elm._index = elmCache["item"].length;
elmCache["item"][elm._index] = elm;
break;
}
}

_this.elmCache = elmCache;
}
function initEvents() {

for (var i = 0, item = null; item = elmCache.item[i]; i++) {
item.onmouseover = item_mouseover;
item.onmouseout = item_mouseout;
item.onclick = item_click;
}

if (typeof oActuator.tagName != "undefined") {
oActuator.onmouseover = actuator_mouseover;
oActuator.onmouseout = actuator_mouseout;
}

elmCache["content"].onmouseover = content_mouseover;
elmCache["content"].onmouseout = content_mouseout;
}
function highlight(oRow) {
oRow.className = "item hover";
if (childMenus[oRow._index]) 
oRow.lastChild.firstChild.src = GDNetMenuDown.dingbatOn;
}
function dehighlight(oRow) {
oRow.className = "item";
if (childMenus[oRow._index]) 
oRow.lastChild.firstChild.src = GDNetMenuDown.dingbatOff;
}
function item_mouseover() {
if (!animating) {
highlight(this);
if (childMenus[this._index]) 
childMenuSet.showMenu(childMenus[this._index]);
else if (childMenuSet) childMenuSet.hide();
}
}
function item_mouseout() {
if (!animating) {
if (childMenus[this._index])
childMenuSet.hideMenu(childMenus[this._index]);
else 
dehighlight(this);
}
}
function item_click() {
if (!animating) {
	if (_this.items[this._index].url){ 
		if (_this.items[this._index].openwin)
			window.open( _this.items[this._index].url);
		else
			location.href = _this.items[this._index].url;
	}
}
}
function actuator_mouseover() {
parentMenuSet.showMenu(_this);
}
function actuator_mouseout() {
parentMenuSet.hideMenu(_this);
}
function content_mouseover() {
if (!animating) {
parentMenuSet.showMenu(_this);
_this.onmouseover();
}
}
function content_mouseout() {
if (!animating) {
parentMenuSet.hideMenu(_this);
}
}
function child_mouseover() {
if (!animating) {
parentMenuSet.showMenu(_this);
}
}
function child_deactivate() {
for (var i = 0; i < childMenus.length; i++) {
if (childMenus[i] == this) {
dehighlight(elmCache["item"][i]);
break;
}
}
}
function child_queue() {
parentMenuSet.hideMenu(_this);
}
function toString() {
var aHtml = [];
var sClassName = "GDNetMenuDownMenu" + (oActuator.constructor != GDNetMenuDownItem ? " top" : "");
for (var i = 0, item = null; item = this.items[i]; i++) {
aHtml[i] = item.toString(childMenus[i]);
}
return '<div id="' + id + '" class="' + sClassName + '">' + 
'<div class="content"><table class="items" cellpadding="0" cellspacing="0" border="0">' + 
'<tr><td colspan="2"><img src="' + GDNetMenuDown.spacerGif + '" width="1" height="' + GDNetMenuDown.menuPadding + '"></td></tr>' + 
aHtml.join('') + 
'<tr><td colspan="2"><img src="' + GDNetMenuDown.spacerGif + '" width="1" height="' + GDNetMenuDown.menuPadding + '"></td></tr></table>' + 
'<div class="shadowBottom"><img src="' + GDNetMenuDown.spacerGif + '" width="1" height="1"></div>' + 
'<div class="shadowRight"><img src="' + GDNetMenuDown.spacerGif + '" width="1" height="1"></div>' + 
'<div class="background"><img src="' + GDNetMenuDown.spacerGif + '" width="1" height="1"></div>' + 
'</div></div>';
}
}

GDNetMenuDownSet.registry = [];
function GDNetMenuDownSet(iDirection, iLeft, iTop, iReferencePoint) {

this.addMenu = addMenu;
this.showMenu = showMenu;
this.hideMenu = hideMenu;
this.hide = hide;

var menus = [];
var _this = this;
var current = null;
this.index = GDNetMenuDownSet.registry.length;
GDNetMenuDownSet.registry[this.index] = this;

function addMenu(oActuator) {
var m = new GDNetMenuDown(oActuator, iDirection, iLeft, iTop, iReferencePoint, this);
menus[menus.length] = m;
return m;
}
function showMenu(oMenu) {
if (oMenu != current) {

if (current != null) hide(current); 

current = oMenu;

oMenu.show();
}
else {

cancelHide(oMenu);
}
}
function hideMenu(oMenu) {

if (current == oMenu && oMenu.isOpen) {

if (!oMenu.hideTimer) scheduleHide(oMenu);
}
}
function scheduleHide(oMenu) {

oMenu.onqueue();
oMenu.hideTimer = window.setTimeout("GDNetMenuDownSet.registry[" + _this.index + "].hide(GDNetMenuDown.registry[" + oMenu.index + "])", GDNetMenuDown.hideDelay);
}
function cancelHide(oMenu) {

if (oMenu.hideTimer) {
window.clearTimeout(oMenu.hideTimer);
oMenu.hideTimer = null;
}
}
function hide(oMenu) { 
if (!oMenu && current) oMenu = current;
if (oMenu && current == oMenu && oMenu.isOpen) {

cancelHide(oMenu);
current = null;
oMenu.hideTimer = null;
oMenu.hide();
}
}
}








function GDNetMenuDownItem(sText, sUrl, sOpenWin, oParent) {
this.toString = toString;
this.text = sText;
this.url = sUrl;
this.openwin = sOpenWin;
this.parentMenu = oParent;
function toString(bDingbat) {
var sDingbat = bDingbat ? GDNetMenuDown.dingbatOff : GDNetMenuDown.spacerGif;
var iEdgePadding = GDNetMenuDown.itemPadding + GDNetMenuDown.menuPadding;
var sPaddingLeft = "padding:" + GDNetMenuDown.itemPadding + "px; padding-left:" + iEdgePadding + "px;"
var sPaddingRight = "padding:" + GDNetMenuDown.itemPadding + "px; padding-right:" + iEdgePadding + "px;"
return '<tr class="item"><td height="22" nowrap style="' + sPaddingLeft + '">' + 
sText + '</td><td width="14" style="' + sPaddingRight + '">'+ 
'<img src="' + sDingbat + '" width="14" height="14"></td></tr>';
}
}

function Accelimation(from, to, time, zip) {
if (typeof zip == "undefined") zip = 0;
if (typeof unit == "undefined") unit = "px";
this.x0 = from;
this.x1 = to;
this.dt = time;
this.zip = -zip;
this.unit = unit;
this.timer = null;
this.onend = new Function();
this.onframe = new Function();
}




Accelimation.prototype.start = function() {
this.t0 = new Date().getTime();
this.t1 = this.t0 + this.dt;
var dx = this.x1 - this.x0;
this.c1 = this.x0 + ((1 + this.zip) * dx / 3);
this.c2 = this.x0 + ((2 + this.zip) * dx / 3);
Accelimation._add(this);
}

Accelimation.prototype.stop = function() {
Accelimation._remove(this);
}




Accelimation.prototype._paint = function(time) {
if (time < this.t1) {
var elapsed = time - this.t0;
this.onframe(Accelimation._getBezier(elapsed/this.dt,this.x0,this.x1,this.c1,this.c2));
}
else this._end();
}

Accelimation.prototype._end = function() {
Accelimation._remove(this);
this.onframe(this.x1);
this.onend();
}




Accelimation._add = function(o) {
var index = this.instances.length;
this.instances[index] = o;

if (this.instances.length == 1) {
this.timerID = window.setInterval("Accelimation._paintAll()", this.targetRes);
}
}

Accelimation._remove = function(o) {
for (var i = 0; i < this.instances.length; i++) {
if (o == this.instances[i]) {
this.instances = this.instances.slice(0,i).concat( this.instances.slice(i+1) );
break;
}
}

if (this.instances.length == 0) {
window.clearInterval(this.timerID);
this.timerID = null;
}
}

Accelimation._paintAll = function() {
var now = new Date().getTime();
for (var i = 0; i < this.instances.length; i++) {
this.instances[i]._paint(now);
}
}

Accelimation._B1 = function(t) { return t*t*t }
Accelimation._B2 = function(t) { return 3*t*t*(1-t) }
Accelimation._B3 = function(t) { return 3*t*(1-t)*(1-t) }
Accelimation._B4 = function(t) { return (1-t)*(1-t)*(1-t) }

Accelimation._getBezier = function(percent,startPos,endPos,control1,control2) {
return endPos * this._B1(percent) + control2 * this._B2(percent) + control1 * this._B3(percent) + startPos * this._B4(percent);
}



Accelimation.instances = [];
Accelimation.targetRes = 10;
Accelimation.timerID = null;

function openWindow(page,w,h){ window.open(page,"a",'top=0,left=0,height='+h+',width='+w+',toolbar=no,menubar=no,scrollbars=no,resizable=no,status=no'); 

}
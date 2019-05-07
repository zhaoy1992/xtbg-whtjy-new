// JavaScript Document
//提交后页面变灰
function G(id){
    return document.getElementById(id);
};
function GC(t){
   return document.createElement(t);
};
String.prototype.trim = function(){
          return this.replace(/(^\s*)|(\s*$)/g, '');
};
function isIE(){
      return (document.all && window.ActiveXObject && !window.opera) ? true : false;
} 


//这个函数返回一个长度为四的数组{页面宽，页面高，窗口宽，窗口高}
//在这做了一下改动，只返回页面高
function getPageSize(){

var xScroll, yScroll;

if (window.innerHeight && window.scrollMaxY) { 
xScroll = document.body.scrollWidth;
yScroll = window.innerHeight + window.scrollMaxY;
} else if (document.body.scrollHeight > document.body.offsetHeight){ // all but Explorer Mac
xScroll = document.body.scrollWidth;
yScroll = document.body.scrollHeight;
} else { // Explorer Mac...would also work in Explorer 6 Strict, Mozilla and Safari
xScroll = document.body.offsetWidth;
yScroll = document.body.offsetHeight;
}

var windowWidth, windowHeight;
if (self.innerHeight) { // all except Explorer
windowWidth = self.innerWidth;
windowHeight = self.innerHeight;
} else if (document.documentElement && document.documentElement.clientHeight) { // Explorer 6 Strict Mode
windowWidth = document.documentElement.clientWidth;
windowHeight = document.documentElement.clientHeight;
} else if (document.body) { // other Explorers
windowWidth = document.body.clientWidth;
windowHeight = document.body.clientHeight;
} 

// for small pages with total height less then height of the viewport
if(yScroll < windowHeight){
pageHeight = windowHeight;
} else { 
pageHeight = yScroll;
}
// for small pages with total width less then width of the viewport
if(xScroll < windowWidth){ 
pageWidth = windowWidth;
} else {
pageWidth = xScroll;
}

//数组{页面宽，页面高，窗口宽，窗口高}
arrayPageSize = new Array(pageWidth,pageHeight,windowWidth,windowHeight) 
return pageHeight;
}
 
function cancelSign(){
    G("sign_div").style.display = 'none';
    G("cover_div").style.display = 'none';
   document.body.style.overflow = '';
};

function popCoverDiv(){
   if (G("cover_div")) {
    G("cover_div").style.display = '';
   } else {
    var coverDiv = GC('div');
    document.body.appendChild(coverDiv);
    coverDiv.id = 'cover_div';
    with(coverDiv.style) {
     position = 'absolute';
     background = '#CCCCCC';
     left = '0px';
     top = '0px';
     var bodySize = getBodySize();
     width = bodySize[0] + 'px'
     height = getPageSize() + 'px';
     zIndex = 98;
     if (isIE()) {
      filter = "Alpha(Opacity=60)";
     } else {
      opacity = 0.6;
     }
    }
   }
}
function getBodySize(){
   var bodySize = [];
   with(document.documentElement) {
    bodySize[0] = (scrollWidth>clientWidth)?scrollWidth:clientWidth;
    bodySize[1] = (scrollHeight>clientHeight)?scrollHeight:clientHeight;
   }
   return bodySize;
}
function popSign(az_id){
   var loginDivWidth = 400;
   var sign_in_flow = 
   		'<div>' +
   		'<table border=0 cellpadding=0 cellspacing=1 bgcolor="#000000" width="100%" height="100%">' +
   		'<tr>' +
   		'<td bgcolor=#3A6EA5 align="center">' +
   		'<br/>' +
   		'<br/>' +
   		//'<marquee align="middle" behavior="alternate" scrollamount="5">' +
   		'<font color=#FFFFFF>...处理中...请等待...</font>' +
   		'<br/>' +
   		'<img src="../../../../../sysmanager/style/blue/images/jindutiao.gif">' +
   		//'</marquee>' +
   		'<br/>' +
   		'<br/>' +   		
   		'<div id="showLogDiv" align="left" style="width: 350px;height: 200;overflow:scroll;background-color: white;display: none;"></div>'+
   		'<br/>' +   		
   		'<input id="showLogSub" type="button" class="input" value="完  成" onClick=document.location="'+az_id+'"; style="display: none;">'+
   		'<input id="showLogRes" type="button" class="input" value="完  成" onClick="cancelSign();"; style="display: none;">'+
   		'</td>' +
   		'</tr>' +
   		'</table>' +   		
   		'</div>';

   if (G("sign_div")) {
    G("sign_div").style.display = '';
   } else {
    var signDiv = GC('div');
    document.body.appendChild(signDiv);
    signDiv.id = 'sign_div';
    signDiv.align = "center";  
  
    with (signDiv.style) {   
     
     position = 'absolute';
     left = (document.body.clientWidth - loginDivWidth)/2 + 'px';
     top = (getPageSize()-200)/2 + 'px';     
     width = loginDivWidth + 'px'; 
     height = '80px'    
     zIndex = 99;
     background = '#F5F5F5';
     
     border = '#233850 solid 1px';
    }
   }
    G("sign_div").innerHTML = sign_in_flow; 
  
}
function popSignFlow(az_id) {
   popCoverDiv(); 
   popSign(az_id);  
      
}

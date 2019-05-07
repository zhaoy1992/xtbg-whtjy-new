var w;
var s;
var w2;
$(function(){
	if($(window).width() > 0){
		window.top.FRISTWINDOWWIDTH = $(window).width();
	}
	
	w  = window.top.FRISTWINDOWWIDTH *0.97;
	s = parseInt(window.top.FRISTWINDOWWIDTH -w);
	w2 = parseInt(w/2);
	welcomeTime();
	$("#peningfrist").width(w2);
	$("#piningtd").width(s);
	$("#pininglast").width(w2);
	setInterval("welcomeTime()",300000);
	reloadThread();
});
var $onclick=new Object();
var $showItem = new Object();

var welcomeTime = function(){
	var today = new Date();
	var hours= today.getHours();
	var welcome="";
	if(hours>=5&&hours<8){
		welcome="早上好";
	}else if(hours>=8&&hours<12){
		welcome="上午好";
	}else if(hours>=12&&hours<13){
		welcome="中午好";
	}else if(hours>=13&&hours<19){
		welcome="下午好";
	}else if(hours>=19&&hours<=24){
		welcome="晚上好";
	}else if(hours<5){
		welcome="晚上好";
	}
	$("#welcomeTime").html(welcome);
}

$successful.init=function(response){
	if(!response.result){return;}
	var param = "userID="+response.result.userID+"&userName="+response.result.userName+"&userRealName="+response.result.userRealName+"&orgID="+response.result.orgID;
	try{
		window.TOTAL =response.result.waitingTotal;
		window.top.$("#workCount").html(response.result.waitingTotal);
	}catch(error){}
	$.each(response.result,function(key,val){
		if(!$.isArray(val)){
			var obj = $("*[name='"+key+"']");
			if(null != obj){
				if(key == "userName"){
					$(obj).html(response.result.userRealName+response.result.pauseSymbolFollowUsername);
				}else{
					$(obj).html(val);
				}
				
			}
		}else{
			if(key == "item"){
				$("#itemList").html('');
				initItem(val,param);
			}else{
				if(key =="pending"){
					$("#penging").html('');
					initpending(val,param);
				}
			}
		}
	});
	if(response.result.weatherURL){
		$("#weatherForecast").attr("src",response.result.weatherURL);
	}else{
		$("#weatherForecast").hide();
	}
}
var initItem=function(item,urlParam){
	if(null == item || item.length == 0) return;
	//生成表格
	
	var row = parseInt(item.length/2);
	if(row%2!=0 || row ==0){
		row=row+1;
	}
	
	for(var i=0;i<row;i++){
		$("#itemList").append("<tr><td width='"+w2+"px' valign='top' id='item"+i+0+"'></td><td width='"+s+"px'></td><td width='"+w2+"px' valign='top'  id='item"+i+1+"'></td>")
	}
	$.each(item,function(key,val){
		var itemId = "item" + parseInt(key/2%2)+(key%2);
		if(val.moreUrl.indexOf("?")<0){
			val.moreUrl = val.moreUrl+"?"+urlParam;
		}else{
			val.moreUrl  =val.moreUrl+"&"+urlParam;
		}
		if(val.url.indexOf("?")<0){
			val.url = val.url+"?"+urlParam;
		}else{
			val.url  =val.url+"&"+urlParam;
		}
		if(!val.viewType || val.viewType == null || "" == val.viewType){
			$showItem.defaultFun(val,itemId,urlParam);
		}else{
			if($.isFunction($showItem[val.viewType])){
				$showItem[val.viewType](val,itemId,urlParam);
			}else{
				$showItem.defaultFun(val,itemId,urlParam);
			}
		}
	});
}
window.TOTAL = 0;
var initpending=function(pending,urlParam){
	if(null == pending || pending.length == 0) return;
	$.each(pending,function(key,val){
		var span = document.createElement("span");
		$("#penging").append($(span));
    	$(span).append("<span class=fontf00>" +val.total+"</span>条 <a>"+val.name+"</a>");
    	if(val.url.indexOf("?")<0){
			val.url = val.url+"?"+urlParam;
		}else{
			val.url  = val.url+"&"+urlParam;
		}
    	if(null != val.param && "" != $.trim(val.param)){
			var param = val.param.split(",");
			for(var i=0;i<param.length;i++){
				val.url+="&"+param[i]+"="+val[param[i]];
			}
		}
    	$(span).click(function(){
    		
    		if(!val.clickType || val.clickType == null || "" == val.clickType){
    			$onclick.newwin(val.url,val.name,val.id);
    		}else{
    			if($.isFunction($onclick[val.clickType])){
    				$onclick[val.clickType](val.url,val.name,val.id);
    			}else{
    				$onclick.newwin(val.url,val.name,val.id);
    			}
    		}
    	});
    	if(key != pending.length-1)
    	$("#penging").append("|");
	});
}

$onclick.newwin = function(url,name,id,subId){
	subId = subId?id+subId:id;
	url+="&windowId="+subId;
	openWindows(subId,name,url,'_firstPagerAAAS',false,window,false,true);
}
$onclick.nowwin = function(){
	openWindows(id,name,url,'_firstPagerAAAS',false,window,false,true);
}
$onclick.notopen = function(){
	
}


$showItem.defaultFun=function(item,itemID,urlParam){
	//生成结构
	var className ="row"+itemID;
	var html = '<table border="0" cellpadding="0" cellspacing="0" class="main_table">';
	html+='<tr><td height="29" class="main_table_hong">';
    html+='<table width="100%" border="0" cellspacing="0" cellpadding="0"><tr><td height="28" align="left" class="main_table_hong_zi"><a>&nbsp;'
    html+=item.name+'</a></td><td class="main_table_hong_pic">&nbsp;</td>';
    html+='<td class="main_table_hong_more" id="more'+itemID+'"></td></tr></table>';
    var more = document.createElement("a");
    $(more).html('更多>>');
    $(more).click(function(){
    	if(!item.clickType || item.clickType == null || "" == item.clickType){
			$onclick.newwin(item.moreUrl,item.name,item.id);
		}else{
			if($.isFunction($onclick[item.clickType])){
				$onclick[val.clickType](item.moreUrl,item.name,item.id);
			}else{
				$onclick.newwin(item.moreUrl,item.name,item.id);
			}
		}
    });
	html+='</td></tr>';
	var dataRow = 0;
   if(null != item.itemList){
	   dataRow = item.itemList.length;
   }
	var row = item.row >1 ?item.row:5 ;
	//if(row < 5) row =5;

	html+='<tr><td><table width="100%" border="0" cellspacing="0" cellpadding="0" class="main_hui">';
	var showType= item.showType.split(",");
	var param = null;
	if(item.param &&  "" != $.trim(item.param)){
		param = item.param.split(",");
	}
	
	for(var i=0;i<row;i++){
		if(i < dataRow){
			var url = item.url;
			if(null != param){
				for(var c = 0;c<param.length;c++){
					url +="&"+param[c]+"="+item.itemList[i][param[c]];
				}
			}
			var c = "itemclickTyle="+item.clickType+" itemurl="+url+" itemname="+item.name+" itemid="+item.id+" rowid="+i;
               
			html+="<tr "+c+" onclick=rowTrClick(this) >";
			
			for(var j=0;j< showType.length;j++){
				if(showType.length-1 == j){
					html+='<td class="td'+className+showType.length+'" height="30" ><div  class="'+className+showType.length+' rrrrrrright"><a>&nbsp;&nbsp;'+item.itemList[i][showType[j]]+"</a></div></td>";
				}else{
					html+='<td class="td'+className+showType.length+'" height="30"><div  class="'+className+showType.length+'"><a>&nbsp;&nbsp;'+item.itemList[i][showType[j]]+"</a></div></td>";
				}
				
			}
		}else{
			html+="<tr>";
			for(var j=0;j< showType.length;j++){
				
				html+='<td class="td'+className+showType.length+'" height="30"><div  class="'+className+'">&nbsp<div></td>';
			}
		}
		html+="</tr>";
		
	}
    html+='</table></td></tr></table>';
	$("#"+itemID).append(html);  
	$("#more"+itemID).append($(more));
	$("."+className).attr("style","white-space: nowrap;overflow:hidden;text-overflow: ellipsis;");
	$(".rrrrrrright").css("text-align" ,"right");
	$(".td" + className+showType.length).width(parseInt(w2/showType.length));
	$(".td" + className+showType.length).css("border-bottom","1px solid #fff")
	if (!window.top.FRISTWIDTH || $(".td" + className+showType.length).width() > 0) {
		window.top.FRISTWIDTH = parseInt(w2/showType.length)-s-2;
	}
	$("." + className+showType.length).width(parseInt(window.top.FRISTWIDTH));
	$("." + className+showType.length).css({"white-space":"nowrap","overflow":"hidden","text-overflow":"ellipsis"});
}
var trOnclick =function(clickType,url,name,id,subId){
	if(!clickType || clickType == null || "" == clickType){
		$onclick.newwin(url,name,id,subId);
	}else{
		if($.isFunction($onclick[clickType])){
			$onclick[clickType](url,name,id,subId);
		}else{
			$onclick.newwin(url,name,id,subId);
		}
	}
}
function loginsView(){
	openAlertWindows('windowId','../../../public/home/jsp/loginViewMain.jsp','查看详情','335px','477px','10%','40%',function(){
		location.reload();
	});
}

function rowTrClick(o){
	trOnclick($(o).attr("itemclickTyle"),$(o).attr("itemurl"),$(o).attr("itemname"),$(o).attr("itemid"),/*$(o).attr("rowid")*/false);
}
$showItem.grid = function(item,itemID,urlParam){
	$(window).width()
	var html = '<table border="0" cellpadding="0" cellspacing="0" class="main_table"><tr><td>';
	html+='<tr><td height="28" class="main_table_hong">';
    html+='<table width="100%" border="0" cellspacing="0" cellpadding="0"><tr><td height="28" align="left" class="main_table_hong_zi"><a>&nbsp;'
    html+=item.name+'</td></a><td class="main_table_hong_pic">&nbsp;</td>';
    html+='<td class="main_table_hong_more" id="more'+itemID+'"></td></tr></table></tr></td><tr><td>';
    var more = document.createElement("a");
    $(more).html('更多>>');
    $(more).click(function(){
    	if(!item.clickType || item.clickType == null || "" == item.clickType){
			$onclick.newwin(item.moreUrl,item.name,item.id);
		}else{
			if($.isFunction($onclick[item.clickType])){
				$onclick[item.clickType](item.moreUrl,item.name,item.id);
			}else{
				$onclick.newwin(item.moreUrl,item.name,item.id);
			}
		}
    });
	html += '<table width="100%" border="0" cellspacing="10" cellpadding="0">'
	html+='<tr><td width="25%" ><div class="lingdao_pic" id="grid0">&nbsp;</div></td>'
    html+='<td width="25%"><div class="lingdao_pic" id="grid1">&nbsp;</div></td>'
	html+='<td width="25%"><div class="lingdao_pic" id="grid2">&nbsp;</div></td>'
	html+='<td width="25%"><div class="lingdao_pic" id="grid3">&nbsp;</div></td></tr>';
	html += '<table width="100%" border="0" cellspacing="10" cellpadding="0">'
		html+='<tr><td width="25%"><div class="lingdao_pic" id="grid4">&nbsp;</div></td>'
	    html+='<td width="25%"><div class="lingdao_pic" id="grid5">&nbsp;</div></td>'
		html+='<td width="25%"><div class="lingdao_pic" id="grid6">&nbsp;</div></td>'
		html+='<td width="25%"><div class="lingdao_pic" id="grid7">&nbsp;</div></td></tr>';
	html+=' </table></td></tr></table>';
	 $("#"+itemID).append(html);  
	  $("#more"+itemID).append($(more));
	  
	       if(null != item.itemList){
		   var param = null;
			if(item.param &&  "" != $.trim(item.param)){
				param = item.param.split(",");
			}
			var showType= item.showType;
		   $.each(item.itemList,function(key,val){
			   var url = item.url;
				if(null != param){
					for(var c = 0;c<param.length;c++){
						url +="&"+param[c]+"="+item.itemList[key][param[c]];
					}
				}
			   $("#grid"+key).html(val[showType]);
			   $("#grid"+key).click(function(){
				   //window.top.SYSUSERID = val.user_id
				   if(!item.clickType || item.clickType == null || "" == item.clickType){
						$onclick.newwin(url,'日程管理',val.id);
					}else{
						if($.isFunction($onclick[item.clickType])){
							$onclick[item.clickType](url,'日程管理',item.id);
						}else{
							$onclick.newwin(url,'日程管理',item.id);
						}
					}
			   });
		   });
	   }
	
 
}

function reloadThread(){
	$("#fristInit").click();
	try{
		window.opetDate = new Date();
		jQuery("#mian").mouseover(function(){
			window.opetDate = new Date();
		});
		if(!window.intervalCount){
			window.intervalCount=30000;
		}
		window.interObject =  setInterval("fristInit()",window.intervalCount);
	}catch(error){}
}

function fristInit(){
	var count= (new Date())-window.opetDate;
	count = Math.floor((count%3600000)/60000);
	if(count >30){
		window.top.window.location.href = window.top.getContextPath()+"/login.jsp";
		return false;
	}
	$("#fristInit").click();
}


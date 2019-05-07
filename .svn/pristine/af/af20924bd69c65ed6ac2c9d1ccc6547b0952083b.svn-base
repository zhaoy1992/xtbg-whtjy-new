/**
 * fileName: workbench.js
 * version: 1.0
 * author: 王博
 * date: 2013-06-27
 * description: 工作台使用的js函数
 */


var w;
var s = 20;
var w2;
$(function(){
	if($(window).width() > 0){
		window.top.FRISTWINDOWWIDTH = $(window).width();
	}
	
	w  = window.top.FRISTWINDOWWIDTH *0.97;
	//s = parseInt(window.top.FRISTWINDOWWIDTH -w);
	w2 = parseInt(w/2)-10;
	
	$("#peningfrist").width(w2);
	$("#piningtd").width(s);
	$("#pininglast").width(w2);
	
});


/**
 * 工作台欢迎词
 */
function welcomeTime() {
	var today = new Date();
	var hours = today.getHours();
	var welcome = "";
	if (hours >= 5 && hours < 8) {
		welcome = "早上好";
	} else if (hours >= 8 && hours < 12) {
		welcome = "上午好";
	} else if (hours >= 12 && hours < 13) {
		welcome = "中午好";
	} else if (hours >= 13 && hours < 19) {
		welcome = "下午好";
	} else if (hours >= 19 && hours <= 24) {
		welcome = "晚上好";
	} else if (hours < 5) {
		welcome = "晚上好";
	}
	$("#welcomeTime").html(welcome);
}

var TOTAL = 0;
/**
 * 异步加载待办统计数据
 */
function loadWaitTask(ajaxUrl) {
	$.ajax({
		type : "GET",
		url : ajaxUrl,
		data : "action=pending_action",
		dataType: "json", 
		contentType : "application/x-www-form-urlencoded; charset=utf-8",
		success : function(msg) {
			if(msg == null || msg == ""){
				window.location.reload();
			}else{
				$("#waitingTotal").html(msg.total);
				window.top.$("#workCount").html(msg.total);
				window.TOTAL = msg.total;
				var pendingList = msg.list;
				var i=1;
				if(pendingList != null && pendingList.length > 0){
					$("#penging").html("");
					$.each(pendingList, function() {
						var span = document.createElement("span");
						$("#penging").append($(span));
						if(i < pendingList.length){
							$(span).append("<a>"+this.name+"</a>"+"<span class=fontf00>" +this.count+"</span>条 "+"|");
						}else{
							$(span).append("<a>"+this.name+"</a>"+"<span class=fontf00>" +this.count+"</span>条");
						}
						
				    	var clickurl = this.clickurl;
				    	var name = this.name;
				    	var id = this.id;
				    	$(span).click(function(){
				    		newwin(clickurl,name,id);
				    	});
				    	i++;
					});
				}
			}
		},
		error: function(XMLHttpRequest, textStatus, errorThrown) {
           //alert(XMLHttpRequest.status);
           //alert(XMLHttpRequest.readyState);
           //alert(textStatus);
        }
	});
}


/**
 * 异步加载在线用户数据和最高在线用户数
 */
function loadOnlineUser(ajaxUrl) {
	$.ajax({
		type : "GET",
		url : ajaxUrl,
		data : "action=online_user_action",
		dataType: "json", 
		contentType : "application/x-www-form-urlencoded; charset=utf-8",
		success : function(msg) {
			if(msg == null || msg == ""){
				window.location.reload();
			}else{
				$("#inSystemTotal").html(msg[0]);
				$("#topInSysTotal").html(msg[1]);
			}
		},
		error: function(XMLHttpRequest, textStatus, errorThrown) {
           //alert(XMLHttpRequest.status);
           //alert(XMLHttpRequest.readyState);
           //alert(textStatus);
        }
	});
}

/**
 * 异步加载模块数据
 */
function loadShowItem(ajaxUrl) {
	$("td[name='showItem']").each(function() {//遍历页面中每个模块
		$(this).width(w2);
		var itemID = this.id;//显示的块id
		var itemName = this.title;//显示块名称
		$.ajax({
			type : "GET",
			url : ajaxUrl,
			data : "action=show_item_action&itemID="+itemID,
			dataType: "json", 
			contentType : "application/x-www-form-urlencoded; charset=utf-8",
			success : function(msg) {
				if(msg == null || msg == ""){
					window.location.reload();
				}else{
					var html = "";
					var showColumnCount = 10;//显示的列数
					var showMaxRowNum = msg.showMaxRowNum;//显示最大行数
					var rowNum = 0;//数据行计数器
					var rowList = msg.list;
					if(rowList != null && rowList.length > 0){
						$.each(rowList, function() {
							rowNum++;
							var columnWidths = this.cloumnWidth.split(",");//各字段显示宽度百分比
							var valueList = this.valueList;
							showColumnCount = valueList.length;
							
							/*if(itemID=="gwdy" || itemID=="dbrw"|| itemID=="gwcg" || itemID=="ybrw"){//add by jie.xiao　点击首页为弹出框时的列表名称为标题
								var newitemName=valueList[0].showValue;
								html += "<tr clickUrl="+this.clickUrl+" itemName="+itemName+" itemID="+itemID+" moreUrl="+this.moreUrl+" onclick='tronclick(\""+this.clickUrl+"\",\""+newitemName+"\",\""+itemID+"\",\""+this.moreUrl+"\");'>";
							}else{*/
								html += "<tr clickUrl="+this.clickUrl+" itemName="+itemName+" itemID="+itemID+" moreUrl="+this.moreUrl+" onclick='tronclick(\""+this.clickUrl+"\",\""+itemName+"\",\""+itemID+"\",\""+this.moreUrl+"\");'>";
							//}
							for(var count=0 ; count< showColumnCount ; count++){
								var value = valueList[count].value;
								var showValue = valueList[count].showValue;
								var floatss = columnWidths[count].substr(0,2);
								var divwidth = w2*parseFloat(floatss)/100;
								var replaceValue = replaceTitle(divwidth,value,14);
//								if(showValue != null){
//									showValue = showValue.replace(value,replaceValue);
//								}
								
								if(count < showColumnCount-1){
									html += "<td nowrap style='border-bottom: 1px solid #fff;height: 30px;width:"+divwidth+"px' title='"+value+"'><div style='width:"+divwidth+"px'><a href='javascript:void(0)'>&nbsp;&nbsp;"+showValue+"</a></div></td>";
								}else{
									html += "<td nowrap style='border-bottom: 1px solid #fff;height: 30px;width:"+divwidth+"px' title='"+value+"'><div align='right' style='width:"+divwidth+"px'><a href='javascript:void(0)'>"+showValue+"&nbsp;&nbsp;</a></div></td>";
								}
								
							}
							html += "</tr>";
						});
					}
					
					if(rowNum < showMaxRowNum){//少于最大行，用空行补充
						for(var i = 0 ;i < (showMaxRowNum-rowNum) ; i++){
							html += "<tr><td style='border-bottom: 1px solid #fff;height: 30px;' colspan='"+showColumnCount+"'>&nbsp;&nbsp;</td></tr>";
						}
					}
					$("#itemList_"+itemID).html("");
					$("#itemList_"+itemID).html(html);
				}
			},
			error: function(XMLHttpRequest, textStatus, errorThrown) {
	           //alert(XMLHttpRequest.status);
	           //alert(XMLHttpRequest.readyState);
	           //alert(textStatus);
	        }
		});
	});
	
	$("td[name='piningtd1']").each(function() {//遍历页面中每个模块
		$(this).width(s);
	});
}

 /*
 函数:  replaceTitle
 说明:  超过长度替换成...
 参数:   无
 */
 function replaceTitle(weight, text, oneTextWeight) {
 	var str = "";
 	var textCount = getByteLen(text) / 2;//text.length;
 	if((textCount  * oneTextWeight) > weight) {
 		str = text.substring(0,(parseInt(weight/oneTextWeight, 10) - 2)) + "...";
 	} else {
 		str = text;
 	}
 	return str;
 }

 /*
 函数:  getByteLen
 说明:  记数字符的长度
 参数:   无
 */
 function getByteLen(val) { 
 	var len = 0; 
 	for (var i = 0; i < val.length - 1; i++) {
 		var str = val.substring(i,i+1);
 		if(str != null && str != '') {
	 		if (str.match(/[^x00-xff]/ig) != null){
	 			len += 2; 
	 		}else{ 
	 			len += 1; 
	 		} 
 		}
 	}
 	return len;
 } 

function tronclick(clickUrl, itemName, itemID, moreUrl){
	//var clickUrl = obj.clickUrl;
	//var itemName = obj.itemName;
	//var itemID = obj.itemID;
	//var moreUrl = obj.moreUrl;
	//传阅性公文要求弹出窗体
	if(itemID=="gwdy" || itemID=="dbrw"|| itemID=="gwcg" || itemID=="ybrw" || itemID=="cywj" || itemID=="shdb"){//add by shuqi.liu　点击首页为弹出框时的列表URL
		alertwin(clickUrl,itemName,itemID,'',moreUrl);
	}else{
		newwin(clickUrl,itemName,itemID);
	}
}

function newwin(url,name,id,subId){
	subId = subId?id+subId:id;
	if(url.indexOf("?") > -1){
		url+="&windowId="+subId;
	}else{
		url+="?windowId="+subId;
	}
	openWindows(subId,name,url,'_firstPagerAAAS',false,window,false,true);
}

//全屏弹出页面
function alertwin(url,name,id,subId,moreUrl){
		subId = subId?id+subId:id;
		if(moreUrl.indexOf("?") > -1){
			moreUrl+="&windowsId="+subId;
		}else{
			moreUrl+="?windowsId="+subId;
		}
		//var height = window.screen.availHeight;
		//var width = window.screen.availWidth;
		var width = jQuery(window.top).width();//界面宽度
		var height = jQuery(window.top).height();//界面高度
		url= url+"&height="+height+"&width="+width+"&windowsId="+subId;
		//openWindows(subId,name,moreUrl,'_firstPagerAAAS',false,window,false,true);
		//弹出款TOP下移，空出标签页及以上位置，165为TOP图片高度，暂时写死，应该是根据TOP的页面高度去动态获取
		openAlertWindows(subId,url,name,width,height-86,86,'0%','','',true);
		
}

/**
 * 异步加载模块数据  院内简报通知
 */
function loadShowhostNoticItem(params) {
	    var itemID = "hostNotic";//显示的块id
		var itemName = "湖南特检简报";//显示块名称
		var url="getIfm_hostnoticData.jsp";
		jQuery.ajax({
			url: url,
			type: 'POST',
			dataType:'json',
			data: params,
			async:false,
			success: function(msg){
				if(msg == null || msg == ""){
					window.location.reload();
				} else {
						var html = "";
						var showColumnCount;//显示的列数
						var showMaxRowNum = msg.showMaxRowNum;//显示最大行数
						var rowNum = 0;//数据行计数器
						var rowList = msg.list;
						if(rowList != null && rowList.length > 0){
							jQuery.each(rowList, function() {
								rowNum++;
								var valueList = this.valueList;
								showColumnCount = valueList.length;
								var divwidth = parseInt(1013/showMaxRowNum)-30;
								for(var count=0 ; count< showColumnCount ; count++){
									var value = valueList[count].value;
									var showValue = valueList[count].showValue;
									var replaceValue = replaceTitle(divwidth,value,15);
									if(showValue != null){
										showValue = showValue.replace(value,replaceValue);
									}
									html += "<td nowrap style='border-bottom: 1px solid #fff;height: 30px;width:"+divwidth+"px' title='"+value+"' clickUrl='"+this.clickUrl+"' itemName='"+itemName+"' itemID='"+itemID+"' onclick='tronclick(\""+this.clickUrl+"\",\""+itemName+"\",\""+itemID+"\",\""+this.moreUrl+"\");'><div align='left'><a href='javascript:void(0)'>&nbsp;&nbsp;"+showValue+"</a></div></td>";
									
								}
							});
						}
						
						if(rowNum < showMaxRowNum){//少于最大行，用空行补充
							for(var i = 0 ;i < (showMaxRowNum-rowNum) ; i++){
								html += "<td style='border-bottom: 1px solid #fff;height: 30px;' colspan='"+showColumnCount+"'>&nbsp;&nbsp;</td>";
							}
						}
						jQuery("#notic_trid").html("");
						jQuery("#notic_trid").html(html);
					}
				},
				error: function(XMLHttpRequest, textStatus, errorThrown) {
		           //alert(XMLHttpRequest.status);
		           //alert(XMLHttpRequest.readyState);
		           //alert(textStatus);
		        }
	});
}
var MSG1;
//持证预警提醒
function loadWorkMessage(userid){
	var showFalg = false;
	$.ajax({
		type : "post",
		url : "holderlastdatedo.jsp",
		data : {"userid":userid},
		dataType: "json", 
		async:false,
		success : function(amount){
			if(amount==null ||amount=="0"){
				//window.location.reload();
			} else {
				$("#amount").html(amount);
				$("#message_div").slideDown(500);
				
				setTimeout(function(){
					$("#message_div").slideUp(500);	
				},10000);
				$("#message_close").on("click",function(){
					$("#message_div").slideUp(500);	
				})
				$("#message_href").on("click",function(){
					var url = "ccapp/oa/personholder/jsp/holderyujing.jsp";
					newwin(url,"预警信息","110");
				})
			}
		},
		error: function(XMLHttpRequest, textStatus, errorThrown) {
	           //alert(XMLHttpRequest.status);
	           //alert(XMLHttpRequest.readyState);
	           //alert(textStatus);
	        }
	});
}
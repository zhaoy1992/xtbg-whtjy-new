/**
 * 档案管理首页
 * @author 戴连春
 * @date 2013-10-22
 */

var w;
var s = 20;
var w2;
$(function(){
	if($(window).width() > 0){
		window.top.FRISTWINDOWWIDTH = $(window).width();
	}	
	w  = window.top.FRISTWINDOWWIDTH *0.97;
	w2 = parseInt(w/2)-10;	
	$("#peningfrist").width(w2);
	$("#piningtd").width(s);
	$("#pininglast").width(w2);
	
});


/**
 * 异步加载模块数据
 */
function loadShowItem(ajaxUrl,nowUserId) {
	$("td[name='showItem']").each(function() {//遍历页面中每个模块
		$(this).width(w2);
		var itemID = this.id;//显示的块id
		var itemName = this.title;//显示块名称
		$.ajax({
			type : "GET",
			url : ajaxUrl,
			data : {
			   itemId : itemID,
			   userId : nowUserId
		    },
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
					var columHtml = "";
					var showColumnsTitle = msg.showColumnsTitle.split(",");
					var columnTitleWidths = msg.cloumnWidth.split(",");//各字段显示宽度百分比
					var showColumnsTileLocation = msg.showColumnsTileLocation.split(",");//各列头字段显示的位置
					if(showColumnsTitle.length > 0) {
						columHtml += "<tr>";
						for(var i = 0; i < showColumnsTitle.length; i++) {
							var titlefloatss = columnTitleWidths[i].substr(0,2);
							var titledivwidth = w2*parseFloat(titlefloatss)/100;
							columHtml += "<td nowrap style='border-bottom: 1px solid #fff;height: 30px;width:"+titledivwidth+"px' ><div style='width:"+titledivwidth+"px;text-align:"+showColumnsTileLocation[i]+"'>&nbsp;&nbsp;<strong>"+showColumnsTitle[i]+"&nbsp;&nbsp;</strong></div></td>";
						}
						columHtml += "</tr>";
						html += columHtml;
					}
					if(rowList != null && rowList.length > 0){
						$.each(rowList, function() {
							rowNum++;
							html += "<tr clickUrl='"+this.clickUrl+"' itemName='"+itemName+"' itemID="+itemID+" onclick='tronclick(\""+this.clickUrl+"\",\""+itemName+"\",\""+itemID+"\");'>";
							
							var columnWidths = this.cloumnWidth.split(",");//各字段显示宽度百分比
							var valueList = this.valueList;
							showColumnCount = valueList.length;
							for(var count=0 ; count< showColumnCount ; count++){
								var value = valueList[count].value;
								var showValue = valueList[count].showValue;
								var floatss = columnWidths[count].substr(0,2);
								var divwidth = w2*parseFloat(floatss)/100;
								var replaceValue = replaceTitle(divwidth,value,14);
								if(showValue != null){
									showValue = showValue.replace(value,replaceValue);
								}
								
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

function tronclick(clickUrl, itemName, itemID){
	newAlertWin(clickUrl,itemName,itemID);
}

function newwin(url,name,id,subId){
	subId = subId?id+subId:id;
	if(url.indexOf("?") > -1){
		url+="&windowId="+subId;
	}else{
		url+="?windowId="+subId;
	}
	openWindows(subId,name,url,'_firstPagerFileFirstAAAS',false,window,false,true);
}

function newAlertWin(url,name,id,subId){
	subId = subId?id+subId:id;
	if(url.indexOf("?") > -1){
		url+="&windowId="+subId;
	}else{
		url+="?windowId="+subId;
	}
	 var width = jQuery(document).width();
     var height = window.top.findPageCacheName("_documentBodyHeight")?window.top.findPageCacheName("_documentBodyHeight"):400;
     openAlertWindows(subId
             ,url,                            
             name,width,height,'5%','10%');
	
}

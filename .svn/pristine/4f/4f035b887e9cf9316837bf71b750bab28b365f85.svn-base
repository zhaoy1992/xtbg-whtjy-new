var sysdate=new Date();
var selectFlag="MONTH";
var Alluserhtml="";
var singleuserhtml="";
var allids = "";
var thisHTML ="";
var selectValue=["",""];
var selectids =["",""];
var thisSelectValue=["",""];
var selectID="";
var showNameFlag = true;
var setSelectUserId = "";
var userIds = ["",""];
$(function() {
	setSelectUserId = creator_getQueryString("user_id");
	$("#day_tr").hide();
	$("#week_tr").hide();
	$("#myschedule_locket").hide();
	$("#show_users_div").hide();
	$("#thisday_but").attr("disabled","disabled");
	$("#add_schedule").hide();
	$("#show_schedule").hide();
	$("#show_schedule_log").hide();


	newCalendar();
	$("#show_date").html(getMonthDate(sysdate));
	var styleTd = "style=z-index:1";
	for(var i=0;i<24;i++){
		if(i!=0) styleTd="";
		$("#day_table").append('<tr><td rowspan="2" align="center" width="30" id="day'+i+'">'+i+'点</td><td height="30" colspan="7"  class="tdhui" id="day'+i+'1" '+styleTd+' valign="top" oncontextmenu="showmenu(null,this);return false;"></td></tr><tr><td height="30" oncontextmenu="showmenu(null,this);return false;" colspan="7" class="tdhui" id="day'+i+'2" valign="top"></td></tr>');
	}
	var nowdate = new Date();
	var weekday = nowdate.getDay();
	styleTd = "style=z-index:1";
	for(var i=0;i<24;i++){
		if(i!=0) styleTd="";
		var daystr ='<tr><td rowspan="2" width="30" align="center" id="time'+i+'">'+i+'点</td></td>';
		for(var j=0;j<7;j++){
			daystr+='<td height="30" valign="top" oncontextmenu="showmenu(null,this);return false;" id="time_'+j+i+'1" '+styleTd+'>&nbsp;</td>';
		}
		daystr+="</tr><tr>";
		for(var j=0;j<7;j++){
			daystr+='<td height="30" valign="top" oncontextmenu="showmenu(null,this);return false;" id="time_'+j+i+'2">&nbsp;</td>';
		}
		daystr+="</tr>"
		$("#week_table").append(daystr);
	}

	sysdate = new Date();
	$("#month_but").click(function() {
		selectids = userIds;
		$("#day_tr").hide();
		$("#week_tr").hide();
		$("#month_tr").show();
		//$("#showName").html(Alluserhtml); 2012.2.22 by 夏天 点击今天按钮时 人员选择框不能切换成所有人
		sysdate = new Date();
		selectFlag="MONTH";
		$("#show_date").html(getMonthDate(sysdate));
		newCalendar(sysdate);
		setNowDayMonth(sysdate);
		$("#thisday_but").attr("disabled","disabled");
		$("#showName_but").val("欢迎您："+thisSelectValue[1]);
		selectids = allids;
		showNameFlag = true;
	    $("#modflyUserID").val(selectValue[0]);
	});
	$("#day_but").click(function() {
		$("#month_tr").hide();
		$("#week_tr").hide();
		$("#day_tr").show();
		selectFlag="DAY";
		sysdate = new Date();
		//$("#showName").html(singleuserhtml);2012.2.22 by 夏天 点击今天按钮时 人员选择框不能切换成所有人
		$("#show_date").html(getDayDate(sysdate));
		addDayNowLine(sysdate);
		$("#add_schedule").hide();
		$("#thisday_but").attr("disabled","disabled");
		$("#showName_but").val("欢迎您："+thisSelectValue[1]);
		selectValue = thisSelectValue;
		selectids = allids;
		$("#modflyUserID").val(selectValue[0]);
		
	});
	$("#week_but").click(function() {
		$("#month_tr").hide();
		$("#day_tr").hide();
		$("#week_tr").show();
		sysdate = new Date();
		selectFlag="WEEK";
		//$("#showName").html(singleuserhtml);2012.2.22 by 夏天 点击今天按钮时 人员选择框不能切换成所有人
		$("#show_date").html(getWeekDate(sysdate));
		addWeekNowLine(sysdate);
		$("#thisday_but").attr("disabled","disabled");
		$("#showName_but").val("欢迎您："+thisSelectValue[1]);
		selectValue = thisSelectValue;
		selectids = allids;
		$("#modflyUserID").val(selectValue[0]);
	});
	$("#last_but").click(function(){
		switch (selectFlag) {
		case 'MONTH':
			sysdate.setMonth(sysdate.getMonth()-1);
			newCalendar(sysdate);
			setNowDayMonth(sysdate);
			$("#show_date").html(getMonthDate(sysdate));
			break;
		case 'WEEK':
			sysdate.setDate(sysdate.getDate()-7);
			$("#show_date").html(getWeekDate(sysdate));
			addWeekNowLine(sysdate);
			break;
		case 'DAY':
			sysdate.setDate(sysdate.getDate()-1);
			addDayNowLine(sysdate);
			$("#show_date").html(getDayDate(sysdate));
			break;
		default:
			
		}
		showThisdaybtByCurrday(selectFlag);
	});
	
	$("#next_but").click(function(){
		switch (selectFlag) {
		case 'MONTH':
			sysdate.setMonth(sysdate.getMonth()+1);
			newCalendar(sysdate);
			setNowDayMonth(sysdate);
			$("#show_date").html(getMonthDate(sysdate));
			break;
		case 'WEEK':
			sysdate.setDate(sysdate.getDate()+7);
			$("#show_date").html(getWeekDate(sysdate));
			addWeekNowLine(sysdate);
			break;
		case 'DAY':
			sysdate.setDate(sysdate.getDate()+1);
			addDayNowLine(sysdate);
			$("#show_date").html(getDayDate(sysdate));
			break;
		default:
			
		}
		showThisdaybtByCurrday(selectFlag);
	});
	
	$("#thisday_but").click(function(){
		sysdate = new Date();
		switch (selectFlag) {
		case 'MONTH':
			$("#month_but").click();
			break;
		case 'WEEK':
			$("#week_but").click();
			break;
		case 'DAY':
			$("#day_but").click();
			break;
		default:
		}
		$("#thisday_but").attr("disabled","disabled");
	});
	
	$("#showName_but").click(function(){
		$("#show_users_div").width($("#showName_but").width());
		if(showNameFlag){
			$("#show_users_div").show();
			$("#showName_but").val("点击此确认查询")
			showNameFlag = false;
		}else{
			$("#show_users_div").hide();
			reloadDate();
			if(selectValue[0] == thisSelectValue[0]){
				$("#showName_but").val("欢迎您："+selectValue[1]);
			}else{
				$("#showName_but").val("您正在查看："+selectValue[1]);
			}
			$("#modflyUserID").val(selectValue[0]);
			showNameFlag = true;
		}
	});
	$("#clear").click(function(){
		$("#add_schedule").hide();
		$("#myschedule_locket").hide();
	});
	$("#close").click(function(){
		$("#show_schedule").hide();
		$("#myschedule_locket").hide();
	})
	$("#modify").click(function(){
		$("#inqueryAddTypetr").hide();
		$("#show_schedule").hide();
		$("#add_title").html("修改日程");
		$("#add_but").attr("methodName","update");
		$("#add_but").attr("successful","updatesuccessful");
		$("#add_but").val("修改");
		clearAddDiv();
		$("#add_schedule").show();
		if(selectValue[0]== thisSelectValue[0]){
			$("input[name='addType'][value='1']").click();
		}else{
			$("input[name='addType'][value='2']").click();
		}
		initModfiyVal();
		$("#myschedule_locket").show();
		
	});
	$("#seelog").click(function(){
		$("#inqueryAddTypetr").hide();
		$("#show_schedule").hide();
		$("#myschedule_locket").show();
		$("#show_schedule_log").show();
		$("#logseeinput").click();
	});
	$("#close_log").click(function(){
		//$("#myschedule_locket").hide();
		$("#show_schedule_log").hide();
		$("#show_schedule").show();
	});
	$("#delete").click(function(){
		alert("您是否确认删除！",{headerText:'确认框', okName:'确认',okFunction:function(){$("#deleteSchedule").click();$("#myschedule_locket").hide();},cancelName:'取消'});
	});
	$("input[name='addType'").click();
	$("input[name='addType']").click(function(){
		if($(this).val()==2){
			$("#personNamestr").show();
			$("#personNames").val("");
			$("#personIds").val("");
		}else{
			$("#personNamestr").hide();
			$("#personNames").val(thisSelectValue[1]);
			$("#personIds").val(thisSelectValue[0]);
		}
	});
	$("#showName_td").hover(function(){
		if(showNameFlag) return;
		$("#showName_but").click();
	})
});

/*
 * 根据当前时间来决定是否显示【今天】按钮 ,compare_model为指定要比较的时间段可为：MONTH,DAY,WEEK
 * 2013.2.22 by 夏天
 * */
function showThisdaybtByCurrday(compare_model){
	
	var is_today = false;//是否是今天

	switch(compare_model){
		case "MONTH":
			if((new Date().getYear() == sysdate.getYear()) && (new Date().getMonth() == sysdate.getMonth()))
				is_today = true;
			break;
		case "WEEK":
			if((new Date().getYear() == sysdate.getYear()) && (new Date().getMonth() == sysdate.getMonth()) && (new Date().getDate() <= sysdate.getDate()+6 && new Date().getDate() >= sysdate.getDate()))
				is_today = true;
			break;
		case "DAY":
			if((new Date().getYear() == sysdate.getYear()) && (new Date().getMonth() == sysdate.getMonth()) && (new Date().getDate() == sysdate.getDate()))
				is_today = true;
			break;
		default:
			break;
	}
	
	if(!is_today)
		$("#thisday_but").removeAttr("disabled","disabled");
	else
		$("#thisday_but").attr("disabled","disabled");
}

//生成日历
function newCalendar(date){
	$(".month_rowtd").remove();
	if(!date){
		date = new Date();
	}
	var nowDay = date.getDate();
	date.setDate(1);
	//最小天的星期
	var nowFarstWeek = date.getDay();
	var nowMonth = getMonth(date);
	date.setMonth(date.getMonth()+1);
	var nextMonth = getMonth(date);
	date.setDate(date.getDate()-1);
	var nowMaxDay = date.getDate();
	date.setDate(1);
	date.setDate(date.getDate()-1);
	var lastMaxDay =  date.getDate();
	var lastMonth = getMonth(date);
	date.setDate(date.getDate()+1);
	
	var maxRow = parseInt(((7-(nowMaxDay+nowFarstWeek)%7)+nowMaxDay+nowFarstWeek)/7)
    var gridNumber = 0;
	var monthString="";
	for(var i = 0;i < maxRow ; i++){
		monthString+="<tr class='month_rowtd'>";
		for(var j = 0;j<7;j++){
			gridNumber=gridNumber+1;
			if(gridNumber > (nowMaxDay+nowFarstWeek) || gridNumber <= nowFarstWeek){
				if(gridNumber > nowMaxDay ){
					monthString+='<td><div class="l_shuzikong"><div class="l_smallhui">'+nextMonth+'月'+(gridNumber-nowMaxDay-nowFarstWeek)+'日</div></div></td>'
				}else{
					monthString+='<td><div class="l_shuzikong"><div class="l_smallhui">'+lastMonth+'月'+(lastMaxDay+gridNumber-nowFarstWeek)+'日</div></div></td>'
				}
				
			}else{
				monthString+='<td   oncontextmenu="showmenu('+(gridNumber-nowFarstWeek)+',this);return false;"><div class="l_shuzi"><div class="l_small" >'+(gridNumber-nowFarstWeek)+'</div><div class="month_day" id="month_'+nowMonth+(gridNumber-nowFarstWeek)+'"></div></div></td>'
			}
		}
		monthString+="</tr>";
	}
	$("#month").append(monthString);
	setNowDayMonth(date);
	$(".month_day").width($(".l_small").width());
	inquiryMonth();
}
function setNowDayMonth(date){
	$(".today_style").removeClass("today_style");
	var now = new Date();
	if(now.getFullYear() != date.getFullYear() || now.getMonth() != date.getMonth()) return;
	$("#month_"+now.getDate()).addClass("today_style");
}
function getMonth(date){
	return date.getMonth()+1;
}

function getYear(date){
	return date.getFullYear();
}

function getMonthDate(date){
	return "&nbsp;"+getYear(date)+"年"+getMonth(date)+"月&nbsp;";
}
function getWeekDate(date){
	date.setDate(date.getDate() - date.getDay());
	var weekstr=getYear(date)+"年"+getMonth(date)+"月"+date.getDate();
	date.setDate(sysdate.getDate() - sysdate.getDay()+6);
	weekstr+="/"+getYear(date)+"年"+getMonth(date)+"月"+date.getDate();
	return weekstr;
}
function getDayDate(date){
	return "&nbsp;"+getYear(date)+"年"+getMonth(date)+"月"+date.getDate()+"日 &nbsp;";
}
function addDayNowLine(date){
	var height = window.top.findPageCacheName("_documentBodyHeight")-$("#header_td").height()-$("#day_header_table").height()-2;
	$("#day_div").height(height);
	$("#day_header_table").width($("#day_table").width());
	$("#nowdayline").remove();
	inqueryDay();
	var now = new Date();
	$("#day_div").scrollTop(0);
	if(now.getFullYear() != date.getFullYear() || now.getMonth() != date.getMonth() || now.getDate() != date.getDate()) return;
	var hh = now.getHours();
	var m = now.getMinutes();
	if(m==0) m =1;
	var height = $("#day"+hh).height();
	var h = parseInt(height/2/30*(m%30));
	var div = document.createElement("div");
	$(div).attr("id","nowdayline");
	$(div).css("margin-top",h+"px");
	$(div).addClass("l_honglink");
    if(m >= 30){
    	$("#day"+hh+2).append($(div));
	}else{
		$("#day"+hh+1).append($(div));
	}
    $("#day_div").scrollTop($(div).offset().top-$("#day0").offset().top);
}

function addWeekNowLine(date){
	$("#week_div").scrollTop(0);
	var height = window.top.findPageCacheName("_documentBodyHeight")-$("#header_td").height()-$("#week_header_table").height()-2;
	$("#week_div").height(height);
	$("#week_header_table").width($("#week_table").width());
	$("#nowweekline").remove();
	inqueryWeek();
	$("td [id*='time_']").removeClass("tdhui");
	var now = new Date();
	date.setDate(date.getDate()-date.getDay());
	now.setDate(now.getDate()-now.getDay());
	if(now.getFullYear() != date.getFullYear() || now.getMonth() != date.getMonth() || now.getDate() != date.getDate()) return;
	now = new Date();
	var hh = now.getHours();
	var m = now.getMinutes();
	var week = now.getDay();
	if(m==0) m =1;
	var height = $("#time"+hh).height();
	var h = parseInt(height/2/30*(m%30));
	var div = document.createElement("div");
	$(div).attr("id","nowweekline");
	$(div).css("margin-top",h+"px");
	$(div).addClass("l_honglink");
    if(m >= 30){
    	$("#time_"+week+hh+2).append($(div));
	}else{
		$("#time_"+week+hh+1).append($(div));
	}
    $("td [id*='time_"+week+"']").addClass("tdhui");
    $("#week_div").scrollTop($(div).offset().top-$("#time0").offset().top);
}

//初始化成功
$successful.initsucessful=function(response){
	//加载可管理的用户数据
	if(!response.result || ""==response.result || null == response.result ) return;
	if(setSelectUserId){
		 Alluserhtml ="<div>"+"<input type='checkbox'  id='checkboxalluser' onclick=selectAllUser(this) /> &nbsp;全选</div>";
	}else{
		Alluserhtml ="<div>"+"<input type='checkbox'  id='checkboxalluser' onclick=selectAllUser(this)  checked='checked'/> &nbsp;全选</div>";
	}

    singleuserhtml="";
	$.each(response.result, function(key, val){
		if(val.isThis){
			thisHTML = "欢迎您："+val.userRealName;
			selectValue =[val.userID,val.userRealName];
			$("#modflyUserID").val(selectValue[0]);
			thisSelectValue = [val.userID,val.userRealName];
		}
		if(setSelectUserId){
			if(val.userID == setSelectUserId){
				 Alluserhtml+="<div>"+"<input type='checkbox' name='userRules' onclick=changeAllUser(this) value="+val.userID+"  checked='checked'/> &nbsp;"+val.userRealName+"</div>";
				 selectids+=setSelectUserId; 
			}else{
				 Alluserhtml+="<div>"+"<input type='checkbox' name='userRules' onclick=changeAllUser(this) value="+val.userID+" /> &nbsp;"+val.userRealName+"</div>";
			}
		   
		}else{
			Alluserhtml+="<div>"+"<input type='checkbox' name='userRules' onclick=changeAllUser(this) value="+val.userID+"  checked='checked'/> &nbsp;"+val.userRealName+"</div>";
			selectids+=val.userID+","; 
		}
		singleuserhtml+="<div onclick=showSingleUser(this,'"+val.userID+"','"+val.userRealName+"')>&nbsp;"+val.userRealName+"</div>";
		
	});
	allids = selectids;
	$("#showName_but").val(thisHTML);
	$("#showName").html(Alluserhtml);
	inquiryMonth();
	inqueryWeek();
	inqueryDay();
}

function changeAllUser(obj){
	if(!obj.checked){
		$("#checkboxalluser").removeAttr('checked');
	}
	selectids = "";
	var list = $("input[name='userRules']:checked");
	if(list !=null){
		for(var i=0;i<list.length;i++){
			selectids+=$(list[i]).val()+",";
		}
	}
}
function selectAllUser(obj){
	if(obj.checked){
		$("input[name='userRules']").attr("checked","checked");
	}else{
		$("input[name='userRules']").removeAttr('checked');
	}
	changeAllUser(obj);
	
}

var showSingleUser=function(obj,id,name){
	$(".select_singleUser").removeClass("select_singleUser");
	selectValue = [id,name];
	$(obj).addClass("select_singleUser");
}

var inquiryMonth = function(){
	userIds = selectids;
	$("#monthdate").val(getYear(sysdate)+"-"+getMonth(sysdate));
	$("#userIDs").val(selectids);
	$("#initMonths").click();
}
var inqueryWeek = function(){
	sysdate.setDate(sysdate.getDate() - sysdate.getDay()+6);
	$("#_endtime").val(getYear(sysdate)+"-"+getMonth(sysdate)+"-"+sysdate.getDate()+" 23:59");
	sysdate.setDate(sysdate.getDate() - sysdate.getDay());
	$("#_starttime").val(getYear(sysdate)+"-"+getMonth(sysdate)+"-"+sysdate.getDate()+" 00:00");
	$("#userIDs").val(selectids);
	$("#modflyUserID").val(selectValue[0]);
	$("#initWeek").click();
}
var inqueryDay = function(){
	$("#_endtime").val(getYear(sysdate)+"-"+getMonth(sysdate)+"-"+sysdate.getDate()+" 23:59");
	$("#_starttime").val(getYear(sysdate)+"-"+getMonth(sysdate)+"-"+sysdate.getDate()+" 00:00");
	$("#userIDs").val(selectids);
	$("#modflyUserID").val(selectValue[0]);
	$("#initDay").click();
}

function inqueryAddUser(){
	 var s = new jQuery.z_tree_leftRigth();
	  s.treeID='button_envelop_username';
	  s.isShowSeacher="aa";
	  s.treeName="选取人员";
	  s.headerName="选取人员";
	  s.titelText = "选择人员";
	  s.rightHeaderText="已添加机构和人员";
	  s.treeList=
			  [{
				  leftHeaderText:'按人员选择',
				  valueKey:'person',
				  selectedIds:$("#personIds").val(),
				  type:'{"type":"21"}'
		}];
	   s.returnFunction=function(object){
		   if(IsSpace(object.person) || null ==object.person )
 		  	{
			   $("#personIds").val('');
			    $("#personNames").val(''); 
 			 }else{
 				$("#personIds").val(object.person.id);
 			    $("#personNames").val(object.person.name); 
 			 }
	 }
	  s.init();
}

$successful.initMonth=function(response){
	$.each(response.result, function(key, val){
		   var day = val.day.split("-")[2]*1;
		   var month = val.day.split("-")[1]*1;
		   var count = $("#month_"+month+day +" ").children(".itinerary_txt").length;
		   if(count==2){
			   var moer = document.createElement("div");
			   $(moer).addClass("date_moer");
			   $(moer).html("<a>更多</a>");
			   $("#month_"+month+day +" ").append( $(moer));
			   $(moer).click(function(){
				   $("#month_"+month+day +" ").children(".itinerary_txt").show();
				   $("#month_"+month+day).css("background","#fff");
				   $("#month_"+month+day).css("z-index","8");
				   $(moer).hide();
			   });
			   $("#month_"+month+day +" ").hover(function(){
				  $("#month_"+month+day +" ").children(".moer_item").hide();
				  $(moer).show();
				  $("#month_"+month+day).css("background","none");
				  $("#month_"+month+day).css("z-index","0");
			   });
		   }
		   var item = document.createElement("div");
		   $(item).attr("title",val.remark);
		   $(item).append(val.userRealName + "("+val.count+")");
		   $(item).addClass("itinerary_txt");
		   if(count >=2){
			   $(item).addClass("moer_item");
		   }
		   $("#month_"+month+day).append($(item));
		   $(item).click(function(){
			   selectValue = [val.userID,val.userRealName]; 
			   showNameFlag = false;
			   $("#showName_but").click();
			   sysdate=stringToDate(val.day+" 00:00");
			   $("#month_tr").hide();
				$("#week_tr").hide();
				$("#day_tr").show();
				selectFlag="DAY";
				$("#showName").html(singleuserhtml);
				$("#show_date").html(getDayDate(sysdate));
				//
				selectids = selectValue[0];
				addDayNowLine(sysdate);
				showThisdaybtByCurrday(selectFlag);
		   });
	});
	$(".moer_item").hide();
}
$successful.initDay=function(response){
	var height = $("#day0").height();
	var daywidth = $("#day01").width()-40;
	var height = parseInt(height/60);
	if(height == 0) height =1;
	var nowStartTime=getYear(sysdate)+"-"+getMonth(sysdate)+"-"+sysdate.getDate()+" 00:00";
	var nowEndTime=getYear(sysdate)+"-"+getMonth(sysdate)+"-"+sysdate.getDate()+" 23:59";
	$(".day_item_text_all").remove();
	$(".day_item_text").remove();
	$.each(response.result, function(key, val){
		//计算位置
		var item = document.createElement("div");
		$(item).attr("title",val.theme+"\n"+val.startTime+" - " +val.endTime);
		if(compareIsAllDay(val.startTime,val.endTime,nowStartTime,nowEndTime)|| compareDate(nowStartTime,val.startTime)||compareDate(val.endTime,nowEndTime))
		{
			$(item).addClass('day_item_text_all');
			$(item).append("<div>"+val.theme+"</div><div>"+val.startTime.split(" ")[0]+"/"+val.endTime.split(" ")[0]+"</div>")
			$("#day_remark").append($(item));
		}else{
		var startTime = val.startTime;
		if (compareDate(nowStartTime, startTime)) {
			startTime = nowStartTime;
		}
		var endTime = val.endTime;
		if (compareDate(endTime, nowEndTime)) {
			endTime = nowEndTime;
		}
		var startHours = startTime.split(" ")[1];
		var endHours = endTime.split(" ")[1];
		var minute = startHours.split(":")[1]*1;
		var startHour = startHours.split(":")[0]*1;
		var endHour = endHours.split(":")[0]*1;
		var endminute = endHours.split(":")[1]*1;
			$(item).addClass("day_item_text");
			$(item).append("  <div>&nbsp;"+startHours+" - "+endHours+"</div>  <div>&nbsp;"+val.theme+"</div>");
			$(item).height(TimeDifference(startTime,endTime)*height);
			$(item).css("margin-top",minute+startHour*60+startHour*2+"px")
			$("#day01").append($(item));
			for ( var i = startHour; i <= endHour;i++) {
				if (endHour == i && (endminute == 0 || endminute==30))
					break;
				if(i==startHour && minute >30){
					$(item).addClass("c" + i + 2);
				}else if(i==endHour && endminute < 30){
					$(item).addClass("c" + i + 1);
				}else{
					$(item).addClass("c" + i + 2);
					$(item).addClass("c" + i + 1);
				}
			}
		}
		$(item).click(function(){
			showRemark(val)
		});
	});
	var allwidth = $("#day_remark").width()-40;;
	var length = $("#day_remark").children(".day_item_text_all").length;
	var all = $("#day_remark").children(".day_item_text_all");
	for(var kkc = 0;kkc<all.length;kkc++){
		$(all[kkc]).css("margin-left",parseInt(daywidth/all.length-2)*kkc+"px");
	}
	$("#day_remark").children(".day_item_text_all").width(parseInt(allwidth/length)-5);
	for(var i=0;i<24;i++){
		   var obj = $("#day01").children(".c"+i+1);
			var ww = daywidth / obj.length - 1;
			for ( var j = 0; j < obj.length; j++) {
				if (!$(obj[j]).attr("rowss")
						|| obj.length > $(obj[j]).attr("rowss") * 1) {
					$(obj[j]).width(ww - 5);
					$(obj[j]).attr("rowss", obj.length);
					$(obj[j]).css("margin-left", ww * j + "px");
				}
			}
			 obj = $("#day01").children(".c" + i + 2);
			 ww = daywidth / obj.length - 1;
			for ( var j = 0; j < obj.length; j++) {
				if (!$(obj[j]).attr("rowss")
						|| obj.length > $(obj[j]).attr("rowss") * 1) {
					$(obj[j]).width(ww - 5);
					$(obj[j]).attr("rowss", obj.length);
					$(obj[j]).css("margin-left", ww * j + "px");
				}
			}
		}
}
$successful.deleteSucessful =function(response){
	alert("删除成功！");
	reloadDate();
	$("#myschedule_locket").hide();
	$("#show_schedule").hide();
}

$successful.updatesuccessful=function(response){
	alert("修改成功！");
	reloadDate();
	$("#myschedule_locket").hide();
	$("#add_schedule").hide();
	clearAddDiv();
}
$successful.addsuccessful=function(response){
	alert("添加成功！");
	reloadDate();
	$("#myschedule_locket").hide();
	$("#add_schedule").hide();
	clearAddDiv();
}
$successful.initWeek=function(response){
	var height = $("#time_0").height();
	var daywidth = $("#time_011").width();
	var height = parseInt(height/60);
	if(height == 0) height =1;
	$(".day_item_text_all").remove();
	$(".day_item_text").remove();
	var nowStartTime;
	var nowEndTime;
	var mydate=cloneDate(sysdate);
	mydate.setDate(mydate.getDate() - mydate.getDay());
	for(var day=0;day<7;day++){
		nowStartTime=getYear(mydate)+"-"+getMonth(mydate)+"-"+mydate.getDate()+" 00:00";
		nowEndTime=getYear(mydate)+"-"+getMonth(mydate)+"-"+mydate.getDate()+" 23:59";
		$.each(response.result, function(key, val){
			if(!compareIsNowDay(val.startTime,val.endTime,nowStartTime,nowEndTime)) return;
			//计算位置
			var item = document.createElement("div");
			$(item).attr("title",val.theme+"\n"+val.startTime+" - " +val.endTime);
			if(compareIsAllDay(val.startTime,val.endTime,nowStartTime,nowEndTime) || compareDate(nowStartTime,val.startTime)||compareDate(val.endTime,nowEndTime))
			{
				$(item).addClass('day_item_text_all');
				$(item).append("<div>"+val.theme+"</div><div>"+val.startTime.split(" ")[0]+"/"+val.endTime.split(" ")[0]+"</div>")
				$("#time_"+day).append($(item));
			}
 			else {
								var startTime = val.startTime;
								if (compareDate(nowStartTime, startTime)) {
									startTime = nowStartTime;
								}
								var endTime = val.endTime;
								if (compareDate(endTime, nowEndTime)) {
									endTime = nowEndTime;
								}
								var startHours = startTime.split(" ")[1];
								var endHours = endTime.split(" ")[1];
								var minute = startHours.split(":")[1] * 1;
								var startHour = startHours.split(":")[0] * 1;
								var endHour = endHours.split(":")[0] * 1;
								var endminute = endHours.split(":")[1] * 1;
								$(item).addClass("day_item_text");
								$(item).append(
										     "  <div>&nbsp;" 
										        + startHours + " - "
												+ endHours
												+ "</div>  <div>&nbsp;"
												+ val.theme + "</div>");
								$(item).height(TimeDifference(startTime, endTime)* height);
								$(item).css("margin-top",minute + startHour * 60 + "px");
								$("#time_" + day + 0 + 1).append($(item));
								
								for ( var i = startHour; i <= endHour;i++) {
									if (endHour == i && (endminute == 0 || endminute==30))
										break;
									if(i==startHour && minute >30){
										$(item).addClass("c" + i + 2+day);
									}else if(i==endHour && endminute < 30){
										$(item).addClass("c" + i + 1+day);
									}else{
										$(item).addClass("c" + i + 2+day);
										$(item).addClass("c" + i + 1+day);
									}
								}
							}
			$(item).click(function(){
				showRemark(val)
			});
		});
		mydate.setDate(mydate.getDate()+1);
	}
	
	for(var day = 0;day<7;day++){
		var all = $("#time_"+day).children(".day_item_text_all");
		$("#time_"+day).width(daywidth);
		for(var kkc = 0;kkc<all.length;kkc++){
			$(all[kkc]).css("margin-left",parseInt(daywidth/all.length-2)*kkc+"px");
		}
		$("#time_"+day).children(".day_item_text_all").width(parseInt(daywidth/all.length-5));
		for(var i=0;i<24;i++){
			var obj = $("#time_"+day+0+1).children(".c"+i+1+day);
			if(obj.length > 0){
				var ww = daywidth/obj.length-1;
				for(var j =0;j<obj.length;j++){
					if(!$(obj[j]).attr("rowss") || obj.length > parseInt($(obj[j]).attr("rowss"))){
						$(obj[j]).width(ww-5);
						$(obj[j]).attr("rowss",obj.length);
						$(obj[j]).css("margin-left",ww*j+"px");
					}
				}
			}
		   obj = $("#time_"+day+0+1).children(".c"+i+2+day);
			if(obj.length > 0){
				var ww = daywidth/obj.length-1;
				for(var j =0;j<obj.length;j++){
					if(!$(obj[j]).attr("rowss") || obj.length > parseInt($(obj[j]).attr("rowss"))){
						$(obj[j]).width(ww-5);
						$(obj[j]).attr("rowss",obj.length);
						$(obj[j]).css("margin-left",ww*j+"px");
					}
				}
			}
			
		}
	}
	
}
function compareIsAllDay(dataSatrtTime,dataEndTime,nowStartTime,nowEndTime){
	if (compareDate(nowStartTime,dataSatrtTime)
			&& compareDate(dataEndTime, nowEndTime)) {
		return true;
	}
	return false;
}

function compareIsNowDay(dataSatrtTime,dataEndTime,nowStartTime,nowEndTime){
	if(compareDate(dataEndTime,nowStartTime)  && compareDate(nowEndTime,dataSatrtTime)){
		return true;
	}
	return false;
}

function TimeDifference(start,end){
	var startHours = start.split(" ")[1].split(":");
	var endHours =end.split(" ")[1].split(":");
	var startH = startHours[0]*1;
	var startM = startHours[1]*1;
	var endH = endHours[0]*1;
	var endM = endHours[1]*1;
	h = (endH - startH) * 60-startM+endM+(endH-startH)*2;
	if(h < 30){
		h =28;
	}
	return h;
}
var WEEK=["星期日","星期一","星期二","星期三","星期四","星期五","星期六"];
function showRemark(obj){
	$("#remarkLevle").html(getLevel(obj.level));
	$("#remarkHeader").html(obj.theme);
	$("#remarkUser").html(obj.userName);
    $("#remarkAddress").html(obj.address);
	$("#remarkTime").html(obj.startTime+"("+WEEK[stringToDate(obj.startTime).getDay()]+") - "+obj.endTime+"("+WEEK[stringToDate(obj.endTime).getDay()]+")");
	$("#remarkBody").html(obj.remark);
	$("#remarkLog").html(obj.log);
	$("#deleteID").val(obj.id);
	thisObject =obj;
	$("#myschedule_locket").show();
	$("#ruleModfiy").click();
	
}
var thisObject = null;
function getLevel(level){
	switch (level) {
	case '1':
		return '【重要】';
	case '3':
		return '【紧急】'
	case '2':
		return '【一般】'
	default:
	}
		return "";
}
function clearAddDiv(){
	$(".add[type='text']").val("");
	$(".add[name='level']:eq(2)").attr("checked","'checked'");
	//$(".add[name='isCall']:eq(1)").attr("checked","checked");
	$(".add[name='callType']").removeAttr("checked");
	$(".add[name='remark']").val("");
	$("#personIds").val("");
}

function showmenu(day,obj){
	$(".menu_div").remove();
	var mouseleft=0;
	var mousetop=0;
	if (!document.all) {
		mouseleft = e.pageX;
		mousetop = e.pageY;
	} else {
		mouseleft = document.body.scrollLeft
				+ event.clientX;
		mousetop = document.body.scrollTop
				+ event.clientY;
	}
	var menu = document.createElement("div");
	$(menu).addClass("menu_div");
	var item = document.createElement("div");
	$(item).append("新增日程");
	$(menu).append($(item));
	if(day == null){
		mousetop= mousetop-$(obj).offset().top;
		mouseleft = mouseleft-$(obj).offset().left;
	}
	$(menu).css("top",mousetop);
	$(menu).css("left",mouseleft);
	
	$(item).click(function(){
		$("#inqueryAddTypetr").show();
		$("#add_schedule").show();
		$(".menu_div").remove();
		$("#myschedule_locket").show();
		$("#add_title").html("新增日程");
		$("#add_but").val("新增");
		$("#add_but").attr("methodName","insertSchedule");
		$("#add_but").attr("successful","addsuccessful");
		clearAddDiv();
		if(selectValue[0]== thisSelectValue[0]){
			$("input[name='addType'][value='1']").click();
		}else{
			$("input[name='addType'][value='2']").click();
		}
	});
	$(obj).append($(menu));
	$(obj).hover(function(){
		$(".menu_div").remove();
	})
}
function initModfiyVal(){
	for(var key in thisObject){
		var list = $(".add[name='"+key+"']");
		if(null != list && list.length >0){
			for(var i=0;i<list.length;i++){
			     if($(list[i]).attr("type")=="radio" || $( list[i]).attr("type")=="checkbox"){
			    	 var vals =thisObject[key].split(",");
			    	
			    	 $(".add[name='"+key+"']").removeAttr("checked");
			    	 for(var j = 0 ; j < vals.length ; j++){
			    		 $(".add[name='"+key+"'][value='"+vals[j]+"']").attr("checked","checked");
			    	 }
			     }else{
			    	 $(list[i]).val(thisObject[key]);
			     }
			}
		}
		
	}
}
$successful.ruleSucessful=function(response){
	$("#modify").show();
	$("#delete").show();
	if(response.result ==0){
		$("#modify").hide();
		$("#delete").hide();
	}
	$("#show_schedule").show();
}

var reloadDate = function(){
	switch (selectFlag) {
	case 'MONTH':
		newCalendar(sysdate);
		setNowDayMonth(sysdate);
		$("#show_date").html(getMonthDate(sysdate));
		break;
	case 'WEEK':
		addWeekNowLine(sysdate);
		$("#show_date").html(getWeekDate(sysdate));
		break;
	case 'DAY':
		addDayNowLine(sysdate);
		$("#show_date").html(getDayDate(sysdate));
		break;
	default:
		
	}
}
$successful.logSucessful=function(response){
	$("#logui").html("");
	$.each(response.result,function(key,val){
		var li = document.createElement("li");
		$(li).append(val.text);
		$(li).attr("title",val.title);
		$("#logui").append($(li));
	});
}

/**********************************************
 * table扩展方法
 **********************************************/

/**
 * 选择所有列
 */
function selectAll(){
  var headerCheck = document.getElementById('headerCheck');
  headerCheck.selected = !headerCheck.selected;
  if(headerCheck.selected){
      jQuery("#gridTable :checkbox").each(function(i){
        this.checked = true;
      });
  }else{
      jQuery("#gridTable :checkbox").each(function(i){
        this.checked = false;
      });
  }
}

/**
 * 初始化调整列方法
 */
//改用新调整列同名方法
/**
function initCols(uuid){
	//隐藏参数，用于导出时获取uuid
	$("<input type='hidden' id='uuid' name='uuid' value='"+uuid+"'/>").insertAfter('#gridTable');
	
	jQuery('body').append('<div id="dialog_cols" title="调整列"><div style="padding:5px;heihgt:300px"><ul id="colUL"></ul></div></div>');
	
	var texts = jQuery('#gridTable').flexColTexts();
	
	var visableTexts = jQuery('#gridTable').flexVisibleColTexts();
	
	for(i = 0; i < texts.length; i++){
		var tmpLi = null;
		if(jQuery.inArray(texts[i],visableTexts) != -1){
			tmpLi = "<li style='height: 20px;'><input type='checkbox' id='check_"+i+"' style='cursor:pointer;' checked='true' value='" + i + "'/>&nbsp;&nbsp;<a href='#' onclick='toggleCheck("+i+");'>" + texts[i] + "</a></li>";
		}else{
			tmpLi = "<li style='height: 20px;'><input type='checkbox' id='check_"+i+"' style='cursor:pointer;' value='" + i + "'/>&nbsp;&nbsp;<a href='#' onclick='toggleCheck("+i+");'>" + texts[i] + "</a></li>";
		}
		
		jQuery('#colUL').append(tmpLi);
	}
	jQuery('#colUL input').click(function(){
		jQuery('#gridTable').flexToggleCol(this.value);
	})
	
	jQuery('#dialog_cols').dialog({
        autoOpen: false,
        width   : 250,
        height  : 300,
        //bgiframe : true,
        //show    : 'slide',
        modal	: true,
        hide    : 'explode',
        buttons : {
          "关闭" : function() { 
                jQuery(this).dialog("close"); 
              } 
        }
    });
}
toggleCheck = function(i){
	var thisCheck = $("#check_"+i);
	if(thisCheck.attr('checked')){
		thisCheck.attr('checked',false);
	}else{
		thisCheck.attr('checked',true);
	}
	jQuery('#gridTable').flexToggleCol(thisCheck.val());
}*/
/**
 * 新调整列使用
 * 因为老调整列方法屏蔽，新调整列initNewCols方法更名为老调整列同名(initCols)方法
 */
function initCols(uuid){
	//隐藏参数，用于导出时获取uuid
	$("<input type='hidden' id='uuid' name='uuid' value='"+uuid+"'/>").insertAfter('#gridTable');
	
	jQuery('body').append('<div id="re_cols" title="调整列"><div style="padding:5px;heihgt:300px;"><table border="0" text-align="center" width="390" id="reloadCols"></table></div></div>');
	
	jQuery('#reloadCols').append('<tr><td width="150"><CENTER style="font-size:13px;color:#2F4F4F;font-family:宋体;font-weight:bold;height:20px;line-height:20px;">隐藏列</CENTER></td><td width="40">&nbsp;</td><td width="150"><CENTER style="font-size:13px;font-family:宋体;font-weight:bold;color:#2F4F4F;height:20px;line-height:20px;">显示列</CENTER></td><td width="40">&nbsp;</td></tr>');
	
	jQuery('#reloadCols').append('<tr><td><CENTER><select multiple name="leftSel" id="leftSel" size="10" style="width:130px;" ondblclick="moveOption(1)"></select></CENTER></td>'
		+ '<td><CENTER><input type="button" value=" >> " id="allToRight" onclick="moveAllOption(1)"></CENTER><br><CENTER><input type="button" value=" > " id="toRight" onclick="moveOption(1)"></CENTER><br><br>'
		+ '<CENTER><input type="button" value=" < " id="toLeft" onclick="moveOption(2)"></CENTER><br><CENTER><input type="button" value=" << " id="allToLeft" onclick="moveAllOption(2)"></CENTER></td>'
		+ '<td><CENTER><select multiple name="rightSel" id="rightSel" size="10" style="width:130px;" ondblclick="moveOption(2)"></select></CENTER></td>'
		+ '<td><CENTER><INPUT TYPE="button" value="置顶" id="toTop" onclick="moveTop()"></CENTER><br><CENTER><INPUT TYPE="button" value="上移" id="toUp" onclick="moveUp()"></CENTER><br><br>'
		+ '<CENTER><INPUT TYPE="button" value="下移" id="toDown" onclick="moveDown()"></CENTER><br><CENTER><INPUT TYPE="button" value="置底" id="toBottom" onclick="moveBottom()"></CENTER></td></tr>');
/*
	var texts = jQuery('#gridTable').flexColTexts();
	
	var visableTexts = jQuery('#gridTable').flexVisibleColTexts();
	for(i = 0; i < texts.length; i++){
		var temLeft = null;
		var temRight = null;
		if(jQuery.inArray(texts[i],visableTexts) != -1){
			//可见列
			temRight = "<option value='"+i+"'>"+texts[i]+"</option>";
			jQuery('#rightSel').append(temRight);
		}else{
			//隐藏列
			temLeft = "<option value='"+i+"'>"+texts[i]+"</option>";
			jQuery('#leftSel').append(temLeft);
		}
	}
	initAdjustBtn();*/
	
	jQuery('#re_cols').dialog({
        autoOpen: false,
        width   : 468,
        height  : 300,
        //bgiframe : true,
        //show    : 'slide',
        modal	: true,
        hide    : 'explode',
        buttons : {
        	"确定" : doAdjustCols,
			"取消" : function() { 
				jQuery(this).dialog("close"); 
			} 
        }
    });
}
/**
 * 初始化调整列按钮状态
 */
function initAdjustBtn(){
	//左边选择框
	var leftS = $("#leftSel");
	//右边选择框
	var rightS = $("#rightSel");
	//全向右按钮
	var allToRightBtn = $("#allToRight");
	//向右按钮
	var toRightBtn = $("#toRight");
	//向左按钮
	var toLeftBtn = $("#toLeft");
	//全向左按钮
	var allToLeftBtn = $("#allToLeft");
	//置顶按钮
	var toTopBtn = $("#toTop");
	//上移按钮
	var toUpBtn = $("#toUp");
	//下移按钮
	var toDownBtn = $("#toDown");
	//置底按钮
	var toBottomBtn = $("#toBottom");
	//初始化时下列按钮应该是不可用的
	toRightBtn.attr("disabled",true);
	toLeftBtn.attr("disabled",true);
	toTopBtn.attr("disabled",true);
	toUpBtn.attr("disabled",true);
	toDownBtn.attr("disabled",true);
	toBottomBtn.attr("disabled",true);
	//左边是否有可选节点
	if(leftS.find("option").length){
		//有，则allToRight按钮可用
		allToRightBtn.attr("disabled",false);
	}else{
		allToRightBtn.attr("disabled",true);
	}
	//右边是否有可选节点
	if(rightS.find("option").length){
		//有，则allToLeft按钮可用
		allToLeftBtn.attr("disabled",false);
	}else{
		allToLeftBtn.attr("disabled",true);
	}
	//1、注册左边点击事件
	leftS.click(function(){
		//1.1如果左边有被选中的节点,IE6需用延时处理
		setTimeout(function(){if(leftS.find("option:selected").length!=0){
			//1.1.1有则toRight按钮可用
			toRightBtn.attr("disabled",false);
		}},1);
	});
	//2、注册右边点击事件
	rightS.click(function(){
		//2.1判断右边是否有被选中的节点,IE6需用延时处理
		setTimeout(function(){if(rightS.find("option:selected").length!=0){
			var selectedNodes = rightS.find("option:selected");
			//2.1.1有,则toLeft按钮可用
			toLeftBtn.attr("disabled",false);
			//2.1.2判断选中节点中最前一个节点前是否存在未被选中节点
			if(selectedNodes.first().prevAll("option").length){
				//2.1.2.1 存在，则toTop和toUp按钮可用
				toTopBtn.attr("disabled",false);
				toUpBtn.attr("disabled",false);
			}else{
				//2.1.2.2 不存在，则toTop和toUp按钮不可用
				toTopBtn.attr("disabled",true);
				toUpBtn.attr("disabled",true);
			}
			//2.1.3判断选中节点中最后一个节点后是否存在未被选中节点
			if(selectedNodes.last().nextAll("option").length){
				//2.1.3.1 存在，则toDown和toBottom按钮可用
				toDownBtn.attr("disabled",false);
				toBottomBtn.attr("disabled",false);
			}else{
				//2.1.3.2 不存在，则toDown和toBottom按钮不可用
				toDownBtn.attr("disabled",true);
				toBottomBtn.attr("disabled",true);
			}
		}},1);
	});
}
/**
 * 移动
 * @param 1表示从左移到右，其他的表示从右移到左
 */
function moveOption(param){
	//左选择框
	var leftS = $("#leftSel");
	//右选择框
	var rightS = $("#rightSel");
	//全向右按钮
	var allToRightBtn = $("#allToRight");
	//向右按钮
	var toRightBtn = $("#toRight");
	//向左按钮
	var toLeftBtn = $("#toLeft");
	//全向左按钮
	var allToLeftBtn = $("#allToLeft");
	//置顶按钮
	var toTopBtn = $("#toTop");
	//上移按钮
	var toUpBtn = $("#toUp");
	//下移按钮
	var toDownBtn = $("#toDown");
	//置底按钮
	var toBottomBtn = $("#toBottom");
	if(param==1){
		//判断向右移时，是否存在被选中节点
		var leftSelecteds = leftS.find("option:selected");
		if(leftSelecteds.length){
			leftSelecteds.each(function(){
				$(this).remove().appendTo(rightS);
			});
			if(toLeftBtn.attr("disabled")){
				toLeftBtn.attr("disabled",false);
				allToLeftBtn.attr("disabled",false);
			}
			toRightBtn.attr("disabled",true);
			//判断左选择框中是否存在可选节点
			if(!leftS.find("option").length){
				//不存在，则全向右按钮不可用
				allToRightBtn.attr("disabled",true);
			}
			//判断右选择框中已选中节点中最前一个节点前是否存在未被选中节点
			if(rightS.find("option:selected").first().prevAll("option").length){
				//若存在，toTop、toUp按钮可用
				toTopBtn.attr("disabled",false);
				toUpBtn.attr("disabled",false);
			}
			//因为是追加到右边选择框的最后面，toBottom、toDown按钮不可用
			toDownBtn.attr("disabled",true);
			toBottomBtn.attr("disabled",true);
		}
	}else{
		//判断向左移时，是否存在被选中节点
		var rightSelecteds = rightS.find("option:selected");
		if(rightSelecteds.length){
			rightSelecteds.each(function(){
				$(this).remove().appendTo(leftS);
			});
			toTopBtn.attr("disabled",true);
			toUpBtn.attr("disabled",true);
			toDownBtn.attr("disabled",true);
			toBottomBtn.attr("disabled",true);
			
			if(toRightBtn.attr("disabled")){
				toRightBtn.attr("disabled",false);
				allToRightBtn.attr("disabled",false);
			}
			toLeftBtn.attr("disabled",true);
			//判断右选择框中是否存在可选节点
			if(!rightS.find("option").length){
				//不存在，刚全向左按钮不可用
				allToLeftBtn.attr("disabled",true);
			}
		}
	}
}

/**
 * 移动全部
 * @param 1表示从左移到右，其他的表示从右移到左
 */
function moveAllOption(param){
	//左备选框
	var leftS = $("#leftSel");
	//右备选框
	var rightS = $("#rightSel");
	//全向右按钮
	var allToRightBtn = $("#allToRight");
	//向右按钮
	var toRightBtn = $("#toRight");
	//向左按钮
	var toLeftBtn = $("#toLeft");
	//全向左按钮
	var allToLeftBtn = $("#allToLeft");
	//置顶按钮
	var toTopBtn = $("#toTop");
	//上移按钮
	var toUpBtn = $("#toUp");
	//下移按钮
	var toDownBtn = $("#toDown");
	//置底按钮
	var toBottomBtn = $("#toBottom");
	if(param==1){
		leftS.find("option").each(function(){
			$(this).remove().appendTo(rightS);
		});
		var selectedRNodes = rightS.find("option:selected");
		//判断右选择框中是否存在选中节点，且向左按钮不可用
		if(selectedRNodes.length){
			toLeftBtn.attr("disabled",false);
			//判断右选择框中已选中节点中最前一个节点前是否存在未被选中节点
			if(selectedRNodes.first().prevAll("option").length){
				//若存在，toTop、toUp按钮可用
				toTopBtn.attr("disabled",false);
				toUpBtn.attr("disabled",false);
			}
			//判断右选择框中已选中节点中最后一个节点后是否存在未被选中节点
			if(selectedRNodes.last().nextAll("option").length){
				//若存在，toDown、toBottom按钮可用
				toDownBtn.attr("disabled",false);
				toBottomBtn.attr("disabled",false);
			}
		}
		allToLeftBtn.attr("disabled",false);
		toRightBtn.attr("disabled",true);
		allToRightBtn.attr("disabled",true);
	}else{
		rightS.find("option").each(function(){
			$(this).remove().appendTo(leftS);
		});
		var selectedLNodes = leftS.find("option:selected");
		//判断左选择框中是否存在已选择节点，且向右按钮不可用
		if(selectedLNodes.length){
			toRightBtn.attr("disabled",false);
		}
		allToRightBtn.attr("disabled",false);
		toLeftBtn.attr("disabled",true);
		allToLeftBtn.attr("disabled",true);
		toTopBtn.attr("disabled",true);
		toUpBtn.attr("disabled",true);
		toDownBtn.attr("disabled",true);
		toBottomBtn.attr("disabled",true);
	}
}
/**
 * 置顶
 */
function moveTop(){
	var rightS = $("#rightSel");
	var toBottomBtn = $("#toBottom");
	var firstNode = rightS.find("option").first();
	if(!firstNode.attr("selected")){
		rightS.find("option:selected").insertBefore(firstNode);
	}
	if(toBottomBtn.attr("disabled")){
		$("#toDown").attr("disabled",false);
		toBottomBtn.attr("disabled",false);
	}
	$("#toTop").attr("disabled",true);
	$("#toUp").attr("disabled",true);
}
/**
 * 上移
 */
function moveUp(){
	var selectedRNodes = $("#rightSel").find("option:selected");
	// 在右显示框中有记录被选中时上移按钮才成为有效状态，下面的rightS.length可以省略
	if(selectedRNodes.length){
		var prevNode = selectedRNodes.first().prev("option");
		var prevNodes = selectedRNodes.first().prevAll("option");
		if(prevNode.length){
			selectedRNodes.insertBefore(prevNode);
		}
		var toBottomBtn = $("#toBottom");
		if(toBottomBtn.attr("disabled")){
			$("#toDown").attr("disabled",false);
			toBottomBtn.attr("disabled",false);
		}
		if(prevNodes.length==1){
			$("#toTop").attr("disabled",true);
			$("#toUp").attr("disabled",true);
		}
	}
}
/**
 * 下移
 */
function moveDown(){
	var selectedRNodes = $("#rightSel").find("option:selected");
	// 在右显示框中有记录被选中时下移按钮才成为有效状态，下面的rightS.length可以省略
	if(selectedRNodes.length){
		var nextNode = selectedRNodes.last().next("option");
		var nextNodes = selectedRNodes.last().nextAll("option");
		if(nextNode.length){
			selectedRNodes.insertAfter(nextNode);
		}
		var toTopBtn = $("#toTop");
		if(toTopBtn.attr("disabled")){
			toTopBtn.attr("disabled",false);
			$("#toUp").attr("disabled",false);
		}
		if(nextNodes.length==1){
			$("#toDown").attr("disabled",true);
			$("#toBottom").attr("disabled",true);
		}
	}
}
/**
 * 置底
 */
function moveBottom(){
	var rightS = $("#rightSel");
	var lastNode = rightS.find("option").last();
	if(!lastNode.attr("selected")){
		rightS.find("option:selected").insertAfter(lastNode);
	}
	var toTopBtn = $("#toTop");
	if(toTopBtn.attr("disabled")){
		toTopBtn.attr("disabled",false);
		$("#toUp").attr("disabled",false);
	}
	$("#toDown").attr("disabled",true);
	$("#toBottom").attr("disabled",true);
}
/**
 * 调整可见列
 */
function doAdjustCols(){
	var obj = $("#gridTable");
	var rightS = $("#rightSel");
	var vTexts = [];
	var vNum = [];
	rightS.find("option").each(function(){
		vTexts.push($(this).text());
		vNum.push($(this).val());
	});
	vTexts.join(",");
	vNum.join(",");
	var texts = obj.flexColTexts();
	var names = obj.flexColTokens();
	for(var i=vNum.length-1;i>=0;i--){
		obj.flexReSortCol(names[vNum[i]]);
	}
	for(var i=0;i<texts.length;i++){
		var colN = $("th[col="+names[i]+"]").attr("axis");
//		if(!colN){
//			alert(names[i]);
//		}
		colN = colN.replace("col","");
		if(jQuery.inArray(texts[i],vTexts) != -1){
			//可见列
			obj.flexToggleCol(colN,true);
		}else{
			//隐藏列
			obj.flexToggleCol(colN,false);
		}
	}
	
    jQuery("#re_cols").dialog("close"); 
}
/**
 * 重载列顺序
 */
function reloadVisibleCols(){
	var visibleTexts = $('#gridTable').flexVisibleColTexts();
	var texts = $('#gridTable').flexColTexts();
	var rightS = $("#rightSel");
	var leftS = $("#leftSel");
	rightS.empty();
	leftS.empty();
	for(i = 0; i < texts.length; i++){
		var temLeft = null;
		var temRight = null;
		if(jQuery.inArray(texts[i],visibleTexts) != -1){
			//可见列
			temRight = "<option value='"+i+"'>"+texts[i]+"</option>";
			rightS.append(temRight);
		}else{
			//隐藏列
			temLeft = "<option value='"+i+"'>"+texts[i]+"</option>";
			leftS.append(temLeft);
		}
	}
	initAdjustBtn();
}
/**
 * 初始化查询方法
 */
function initQuery(){

	jQuery('body').append('<div id="dialog_query" title="查询"><input type="hidden" id="temp_val"/><div id="queDiv" style="padding:5px;heihgt:300px"><ul id="queUL"></ul></div></div>');
	var texts = jQuery('#gridTable').flexColTexts();
	var names = jQuery('#gridTable').flexColTokens();
	var visableTexts = jQuery('#gridTable').flexVisibleColTexts();
	$("#temp_val").data("visableParam",visableTexts);
	var forbidenCol = "id,action,ID,ACTION";
	jQuery('#queDiv').append('<ul id="queUL"></ul>');
	for(i = 0; i < texts.length; i++){
		var tmpLi = "";
		if(jQuery.inArray(texts[i],visableTexts) != -1&&jQuery.inArray(names[i],forbidenCol) == -1){
			tmpLi = "<div style='float:right;'><input type='text' id='"+names[i]+"_Que' class='inputText60' /><select id='select"+i+"' class='inputText20'><option value='and'>且</option><option value='or'>或</option></select></div><li style='height: 25px;'><div style='height: 25px;vertical-align:bottom;margin-top:8px;'>&nbsp;" + texts[i] + "</div></li>";
		}
		jQuery('#queUL').append(tmpLi);
	}
	
	jQuery('#dialog_query').dialog({
        autoOpen: false,
        width   : 250,
        height  : 300,
        //bgiframe : true,
        //show    : 'slide',
        hide    : 'slide',
        modal	: true,
        buttons : {
          "清空" : clearQueryCondition,
          "查询" : queryEvent
        }
    });
    
    jQuery('#dialog_query').keydown(function(e){
		if (e.keyCode == 13){
			queryEvent();
		}
	});
}
/**
 * 清空查询条件数据
 */
function clearQueryCondition() { 
	$("#condition").empty();
	var texts = jQuery('#gridTable').flexColTexts();
	var names = jQuery('#gridTable').flexColTokens();
	var visableTexts = jQuery('#gridTable').flexVisibleColTexts();
	var forbidenCol = "id,action,ID,ACTION";
	jQuery('#queUL').remove();
	jQuery('#queDiv').append('<ul id="queUL"></ul>');
	for(i = 0; i < texts.length; i++){
		var tmpLi = "";
		if(jQuery.inArray(texts[i],visableTexts) != -1&&jQuery.inArray(names[i],forbidenCol) == -1){
			tmpLi = "<div style='float:right;'><input type='text' id='"+names[i]+"_Que' class='inputText60' /><select id='select"+i+"' class='inputText20'><option value='and'>且</option><option value='or'>或</option></select></div><li style='height: 25px;'><div style='height: 25px;vertical-align:bottom;margin-top:8px;'>&nbsp;" + texts[i] + "</div></li>";
		}
		jQuery('#queUL').append(tmpLi);
	}
}
/**
 * 重载查询条件
 */
function queryReload(){
	var visableTexts = jQuery('#gridTable').flexVisibleColTexts();
	var temp_val = $("#temp_val");
	var visableData = temp_val.data("visableParam");
	if(visableData){
		if(!equal(visableTexts,visableData)){
			temp_val.data("visableParam",visableTexts);
			clearQueryCondition();
		}
	}else{
		temp_val.data("visableParam",visableTexts);
		clearQueryCondition();
	}
}
/**
 * 点击查询
 */
function queryEvent() {
	var names = jQuery('#gridTable').flexColTokens();
	var condition = "";
	for(i = 0;i<names.length;i++){
		var tt = $("#"+names[i]+"_Que").val();
		var ss = $("#select"+i).val();
		if(tt){
			if(condition==""){
				condition += "(instr("+names[i]+",'"+tt+"')>0 ";
			}else{
				condition += ss+" instr("+names[i]+",'"+tt+"')>0 ";
			}
		}
	}
	if(condition != ""){
		condition += ")";
	}
	$("#condition").val(condition);
	var url = $("#gridTable").flexUrl();
    jQuery("#dialog_query").dialog("close");
	queryByForm("searchForm",url,"mytable");
}
/**
 * 导出Excel
 */
function doExport(uuid){

	var txt = $('.pPageStat').text();
	
	if('没有数据存在!' == txt){
		alert('没有数据，不需要导出。');
		return;
	}

	//如果有选中checkbox的话，提示选导选中的，没有则提示是否导出全部
	var items = jQuery('#gridTable').flexSelectedItems();
	if(items.length != 0){
		if(confirm("是否导出选择的数据？")){
		    //导出选中数据 
			doClientExport();
			return;
		}else{
			//取消，直接退出
			return;
		}
	}else{
		if(!confirm("是否导出全部数据？")){
			return;	    
	    }
	}
	//导出全部数据
	if(uuid == null || uuid == '' || uuid == '${uuid}' || uuid == 'undefined'){
		//当无uuid时，调用页面上的单独导出方法-不使用内存保存数据
		privateExport();
		return;
	}else{
		//使用session保留数据
		var param = new Object();
		param.uuid = uuid;
		exportExcel('exportExcel.do',param,'mytable');
	}
}

/**
 * 客户端导出Excel
 */
function doClientExport(){
	var items = jQuery('#gridTable').flexSelectedItems();
	if(items.length == 0){
		alert('请选择数据！');
		return;
	}
	
	var tItems = '';
	for(i = 0; i < items.length; i++){
		tItems += (items[i] + ';');
	}
	var param = new Object();
	param.selectedItems = tItems + '';
	exportExcel('exportExcelByClient.do',param,'mytable');
}

/**
 * 
 * */
 function exportExcel(url,param,flexigridID){
	 
		jQuery.blockUI("<h1 style='font-size:12px;padding:5px'><img src='images/busy.gif' />　正在提交表单，请稍等...</h1>");
		var tokens = jQuery('#'+flexigridID).flexVisibleColTokens();
		var texts = jQuery('#'+flexigridID).flexVisibleColTexts();
		var title  = $(".formHeader").text();
		
		if(title == null || title == ''){
	      	title = '双软报表导出';
	    }
		
		param.colTexts = texts+'';
		param.colTokens = tokens+'';
		param.title = title;
		
		var params = $.param(param);
	    
		var pageParams = $('#'+flexigridID).getPageBarParam();
		params += '&'+$.param(pageParams);
	      
		//jQuery.post(url, {colTexts:texts + '', colTokens:tokens + '',uuid:uuid, selectedItems:items, title:title}, function(data){
		jQuery.post(url,params, function(data){
			jQuery.unblockUI();

	        if(data.errorMsg != null)
	        {
	          alert("操作失败！原因：" + data.errorMsg);
	          return;
	        }

	        if(title == null||title==''){
	        	title = '双软报表导出';
	        }
	        //对中文名进行转义
	        var filename =escape(escape(title+'.xls'));
	        window.location.href = 'downloadAttachment?name='+filename+'&filePath=' + data;
		});
 }
/**
 * 查询数据
 */
function doQuery(){
	queryReload();
	
	jQuery('#dialog_query').dialog('open');
	if ($.browser.msie) {         
        $("#dialog_query").css("height", 300);
    } 
}
/**
 * 删除表格中选中的数据
 * 
 * @param url
 */
function doDelete(url){
	if(jQuery("#gridTable input[@type=checkbox][@checked]").size()==0){
		alert("请选择要删除的节点！");
	}
	else if(window.confirm('是否删除所选节点？')){
	  jQuery.blockUI("<h1 style='font-size:12px;padding:5px'><img src='images/busy.gif' />　正在提交表单，请稍等...</h1>");
	  jQuery("#gridTable").attr("action", url);
	  jQuery("#gridTable").submit();
    }
}

/**
 * 删除某条数据
 * 
 * @param url
 * @param id
 */
function doDeleteById(url, id){
	if(window.confirm('是否删除当前节点？')){
	  jQuery.blockUI("<h1 style='font-size:12px;padding:5px'><img src='images/busy.gif' />　正在提交表单，请稍等...</h1>");
	  window.location.href = url + '?id=' + id;
    }
}

/**
 * 通过form进行提交查询条件
 * 
 * @param formID 需要提交的form的ID
 * @param url    需要提交到action的url
 * @param flexigridID 所展示的flexigrid的table ID
 */
function queryByForm(formID,url,flexigridID){
	jQuery.blockUI("<h1 style='font-size:12px;padding:5px'><img src='images/busy.gif' />　正在加载数据，请稍等...</h1>");		
	var param = jQuery('#'+formID).serialize();
	//添加获取pageBar的信息
	var pageParams = $('#'+flexigridID).getPageBarParam();
	param += '&'+$.param(pageParams);
	 
	jQuery.ajax({url:url,
		data:param,
		dataType:'json',
		type:'POST',
		success: function(data){
			jQuery.unblockUI();
			$('#'+flexigridID).flexAddData(data);
		},
		error : function(data){
			jQuery.unblockUI();
			
			//jQuery.alert("出错了");
		}
	});
}
 
//---------------------------用于封装参数 start-------------------------------------------//
 
/**
 * ColumnModel对象 并初始化部分参数
 */
 function ColumnModel() {
	 this.sortable = true;
	 this.align = 'center';
	 this.hide = false;
	 this.width = 100;
 }
 
 /***
  * 用于设置 显示名、实体属性名、宽度三个常用参数
  * @param display 显示名
  * @param name 实体属性名
  * @param width 列的显示宽度
  */
 ColumnModel.prototype.setDisplayNameWidth = function(display,name,width){
	 this.display = display;
	 this.name = name;
	 this.width = width;
 }
 
 /***
  * 用于设置 显示名、实体属性名 二个常用参数
  * @param display 显示名
  * @param name 实体属性名
  */
 ColumnModel.prototype.setDisplayName = function(display,name){
	 this.display = display;
	 this.name = name;
 }
 
 /**
  * 设置显示名
  * */
 ColumnModel.prototype.setDisplay = function(display){
	 this.display = display;
 }
 
 /**
  * 获取显示名
  * */
 ColumnModel.prototype.getDisplay = function(){
	 return this.display;
 }
 
 /**
  * 设置实体属性名
  * */
 ColumnModel.prototype.setName = function(name){
	 this.name = name;
 }
 
 /**
  * 获取实体属性名
  * */
 ColumnModel.prototype.getName = function(){
	 return this.name;
 }
 
 /**
  * 设置宽度
  * */
 ColumnModel.prototype.setWidth = function(width){
	 this.width = width;
 }
 
 /**
  * 获取宽度
  * */
 ColumnModel.prototype.getWidth = function(){
	 return this.width;
 }
 
 /**
  * 设置是否排序
  * */
 ColumnModel.prototype.setSortable = function(sortable){
	 this.sortable = sortable;
 }
 
 /**
  * 设置是否排序
  * */
 ColumnModel.prototype.getWidth = function(){
	 return this.sortable;
 }
 
 /**
  * 设置对齐方式
  * */
 ColumnModel.prototype.setAlign = function(align){
	 this.align = align;
 }
 
 /**
  * 获取对齐方式
  * */
 ColumnModel.prototype.getAlign = function(){
	 return this.align;
 }
 
 /**
  * 设置是否隐藏
  * */
 ColumnModel.prototype.setHide = function(hide){
	 this.hide = hide;
 }
 
 /**
  * 获取是否隐藏
  * */
 ColumnModel.prototype.getHide = function(){
	 return this.hide;
 }
 
 /**
  * 设置是否action
  * */
 ColumnModel.prototype.setAction = function(action){
	 this.action = action;
 }

 /**
  * 获取action
  * */
 ColumnModel.prototype.getAction = function(){
	 return this.action;
 }
 
 /**
  * 定义第一组ColumnModel数组来保存数据
  * */
 var tmpColumnModels = new Array();
 
 /**
  * 将ColumnModel存入第一组ColumnModel数组
  * */
 function pushColModel(columnModel){
	 tmpColumnModels[tmpColumnModels.length] = columnModel;
 }
 
 /**
  * 获取第一组ColumnModel数组的数据
  * */
 function getColModels(){
		return tmpColumnModels;	
 }
 
 /**
  * 定义第二组ColumnModel数组来保存数据
  * */
 var tmpColumnModels2 = new Array();
 
 /**
  * 将ColumnModel存入第二组ColumnModel数组
  * */
 function pushColModelTwo(columnModel){
	 tmpColumnModels2[tmpColumnModels2.length] = columnModel;
 }
 
 /**
  *  获取第二组ColumnModel数组的数据
  * */
 function getColModelsTwo(){
		return tmpColumnModels2;	
 }
 
//-------------------------------用于封装参数 end---------------------------------------//
 
//--------------------------------封装 action 操作 start-------------------------------------------------//
 /**
  * 用于统一处理action操作的显示
  * @param showModify 是否显示编辑按钮
  * @param showView   是否显示查看按钮
  * @param showDelete 是否显示删除按钮
  * @param showMove   是否显示上下移动按钮
  * @param editRight  是否有权限
  * @param row        数据
  * */
 function initAction(showMove,showModify,showView,showDelete,editRight,row,moveUrl){
	var action = '';
	var id = row.id;
	if(id == '' || id == 'undefined' || id == null){
		id = row.ID;
	}
    	
	if(editRight=='YES')
	{
		//显示下移
		if(row.afterId!=0 && showMove)
		{
			action += '<a href="#" onclick="doSubmit(\''+moveUrl+'?id='+id+'&direction=down&afterId='+row.afterId+'\')"><img border="0" alt="下移" src="images/downButton.gif"/></a>';
		}
	    //显示上移
		if(row.preId!=0 && showMove)
		{
			action += '<a href="#" onclick="doSubmit(\''+moveUrl+'?id='+id+'&direction=up&preId='+row.preId+'\')"><img border="0" alt="上移" src="images/upButton.gif"/></a>';
		}
	    
		//显示修改
		if(showModify){
			action +='<a href="javascript:doModityMT('+id+')" onclick=""><img border="0" alt="修改" src="images/icon/page_edit.gif"/></a>';
		}
	}
	//显示查看
	if(showView){
		action += '<a href="javascript:doViewMT('+id+')" ><img border="0" alt="查看" src="images/icon/page.gif"/></a>';  
	}
	//显示删除
	if(showDelete){
		action += '<a href="javascript:doDeleteMT('+id+')" onclick=""><img border="0" alt="删除" src="images/icon/del.gif"/></a>';  
	}	
	 
	 return action;
 }
//--------------------------------封装 action 操作 end-------------------------------------------------//

//--------------------------------封装 菜单 操作 Start -------------------------------------------------//
 
 /**
  * Menu对象 并初始化部分参数
  */
  function Menu() {
 	 this.name = null;
 	 this.bclass = null;
 	 this.onpress = null;
 	 this.param = null;
  }
  
  /***
   * 用于设置 菜单显示名、菜单按钮样式、按钮处理方法三个常用参数
   * @param name 菜单显示名
   * @param bclass 菜单按钮样式
   * @param onpress 按钮处理方法
   */
  Menu.prototype.setNameBclassOnPress = function(name,bclass,onpress){
 	 this.name = name;
 	 this.bclass = bclass;
 	 this.onpress = onpress;
  }
  
  /***
   * 用于设置 菜单显示名
   * @param name 菜单显示名
   */
  Menu.prototype.setName = function(name){
 	 this.name = name;
  }
  
  /**
   * 设置菜单显示名
   * */
  Menu.prototype.getName = function(){
 	 return this.name;
  }

  /***
   * 用于设置 菜单按钮样式
   * @param name 菜单按钮样式
   */
  Menu.prototype.setBclass = function(bclass){
 	 this.bclass = bclass;
  }
  
  /**
   * 菜单按钮样式
   * */
  Menu.prototype.getBclass = function(){
 	 return this.bclass;
  }
  
  /***
   * 用于设置 按钮处理方法
   * @param onpress 按钮处理方法
   */
  Menu.prototype.setOnpress = function(onpress){
 	 this.onpress = onpress;
  }
  
  /**
   * 设置按钮处理方法
   * */
  Menu.prototype.getOnpress = function(){
 	 return this.onpress;
  }
  
    /***
   * 用于设置 按钮处理方法
   * @param param 按钮处理方法
   */
  Menu.prototype.setParam = function(param){
 	 this.param = param;
  }
  
  /**
   * 设置按钮处理方法
   * */
  Menu.prototype.getParam = function(){
 	 return this.param;
  }

  /***
   * 用于设置 分隔符
   * @param separator 分隔符
   */
  Menu.prototype.setSeparator = function(separator){
 	 this.separator = separator;
  }
  
  /***
   * 用于获取 分隔符
   */
  Menu.prototype.getSeparator = function(){
 	 return this.separator;
  }
  
  /**
   * 定义第一组Menu数组来保存数据
   * */
  var tmpMenus = new Array();
  
  /**
   * 将Menu存入第一组Menu数组
   * */
  function pushMenu(menu){
	  tmpMenus[tmpMenus.length] = menu;
  }
  
  /**
   * 获取第一组Menu数组的数据
   * */
  function getMenus(){
 		return tmpMenus;	
  }
  
  /**
   * 定义第二组Menu数组来保存数据
   * */
  var tmpMenusTwo = new Array();
  
  /**
   * 将Menu存入第二组Menu数组
   * */
  function pushMenuTwo(menu){
	  tmpMenusTwo[tmpMenusTwo.length] = menu;
  }
  
  /**
   * 获取第二组Menu数组的数据
   * */
  function getMenusTwo(){
 		return tmpMenusTwo;	
  }
  
  /**
   * 用于统一处理action操作的显示
   * @param showAdd    是否显示新增按钮
   * @param showDelete 是否显示删除按钮
   * @param showAdjustment 是否显示调整列按钮
   * @param showExport  是否显示导出按钮
   * @param showQuery   是否显示查询按钮
   * @param addParam    用于新增方法的参数
   * */
  function initMenu(showAdd,showDelete,showAdjustment,showExport,showQuery,addParam,showAdjust){
	  
	  var menu = null;
	  var obj = new Object();
	  if(showAdd){
		  menu = new Menu();
		  menu.setParam(addParam);
		  menu.setNameBclassOnPress('新增', 'add', action);
		  tmpMenus[tmpMenus.length] = menu;
		  
		  obj = new Object();
		  obj.separator = true;
		  tmpMenus[tmpMenus.length] = obj;
	  }
	  
	  if(showDelete){
		  menu = new Menu();
		  menu.setNameBclassOnPress('删除', 'delete', action);
		  tmpMenus[tmpMenus.length] = menu;
		  
		  obj = new Object();
		  obj.separator = true;
		  tmpMenus[tmpMenus.length] = obj;
	  }

	  if(showAdjustment){
		  menu = new Menu();
		  menu.setNameBclassOnPress('调整列', 'adjustment', action);
		  tmpMenus[tmpMenus.length] = menu; 
		  
		  obj = new Object();
		  obj.separator = true;
		  tmpMenus[tmpMenus.length] = obj;
	  }
	  
	  if(showExport){
		  menu = new Menu();
		  menu.setNameBclassOnPress('导出', 'export', action);
		  tmpMenus[tmpMenus.length] = menu;
		  
		  obj = new Object();
		  obj.separator = true;
		  tmpMenus[tmpMenus.length] = obj;
	  }
	  
	  if(showQuery){
		  menu = new Menu();
		  menu.setNameBclassOnPress('查询', 'query', action);
		  tmpMenus[tmpMenus.length] = menu;
		  
		  obj = new Object();
		  obj.separator = true;
		  tmpMenus[tmpMenus.length] = obj;
	  }
	  
	  if(showAdjust){
		  menu = new Menu();
		  menu.setNameBclassOnPress('新调整列', 'adjustment', action);
		  tmpMenus[tmpMenus.length] = menu; 
		  
		  obj = new Object();
		  obj.separator = true;
		  tmpMenus[tmpMenus.length] = obj;
	  }
	  
	  //默认显示刷新
	  menu = new Menu();
	  menu.setNameBclassOnPress('刷新', 'refresh', action);
	  tmpMenus[tmpMenus.length] = menu;
	  
	  obj = new Object();
	  obj.separator = true;
	  tmpMenus[tmpMenus.length] = obj;
	  
	  return tmpMenus;
  } 
  
 function action(com, grid,param) {
	    switch (com) {
		    case '新增' :
		    	doNewMT(param);
			    break;
		    case '删除' :
		    	dodelete();
			    break;
			case  '老调整列':
				jQuery('#dialog_cols').dialog('open');
				if ($.browser.msie) {         
		            $("#dialog_cols").css("height", 300);              
		        } 
				break;
		    case  '导出' :
		    	var uuid = $('#uuid').val();
		    	doExport(uuid);			    	 
			    break;
			case  '刷新':
				$('#gridTable').flexReload();
				break;
			case  '查询':
				doQuery();
				break;
			case  '调整列':
				reloadVisibleCols();
				jQuery('#re_cols').dialog('open');
				if ($.browser.msie) {         
		            $("#re_cols").css("height", 230);              
		        }
				break;
	    }
 }
/**
 * 比较两个参数是否相等
 */
function equal(objA, objB)
{
    if (typeof objA != typeof objB)
        return false;    
    //数组
    if (objA instanceof Array)
    {
        if (objA.length != objB.length)
            return false;
        
        var allElementsEqual = true;
        for (var i = 0; i < objA.length; ++i)
        {
            if (typeof objA[i] != typeof objB[i])
                return false;            
            if (typeof objA[i] == 'number' && typeof objB[i] == 'number')
                allElementsEqual = (objA[i] == objB[i]);
            else
                allElementsEqual = arguments.callee(objA[i], objB[i]);            //递归判断对象是否相等                
        }
        return allElementsEqual;
    }
    
    //对象
    if (objA instanceof Object && objB instanceof Object)
    {
        var result = true;
        var attributeLengthA = 0, attributeLengthB = 0;
        for (var o in objA)
        {
            //判断两个对象的同名属性是否相同（数字或字符串）
            if (typeof objA[o] == 'number' || typeof objA[o] == 'string')
                result = eval("objA['" + o + "'] == objB['" + o + "']");
            else {
                //如果对象的属性也是对象，则递归判断两个对象的同名属性
                //if (!arguments.callee(arguments[0][o], arguments[1][o]))
                if (!arguments.callee(eval("objA['" + o + "']"), eval("objB['" + o + "']")))
                {
                    result = false;
                    return result;
                }
            }
            ++attributeLengthA;
        }
        
        for (var o in objB) {
            ++attributeLengthB;
        }
        
        //如果两个对象的属性数目不等，则两个对象也不等
        if (attributeLengthA != attributeLengthB)
            result = false;
        return result;
    }
    return objA == objB;
}
//--------------------------------封装 菜单 操作 End -------------------------------------------------// 

$(document).ready(function(){
	//$("<input type='text' id='uuid' name='uuid' value='${uuid}' />").insertAfter('#gridTable');
});


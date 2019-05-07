/**********************************************
 * table扩展方法
 **********************************************/

/**
 * 显示列使用
 */
function initCols(tableId,colNum){
	if(!colNum)return;
	jQuery('body').append('<div id="re_cols" title="显示/隐藏列"><input type="hidden" id="v_tableId" value="'+tableId+'"/><input type="hidden" id="v_colNum" value="'+colNum+'"/><div style="padding:5px;heihgt:240px;"><table border="0" text-align="center" width="390" id="reloadCols"></table></div></div>');
	
	jQuery('#reloadCols').append('<tr><td width="150"><CENTER style="font-size:13px;color:#2F4F4F;font-family:宋体;font-weight:bold;height:20px;line-height:20px;">隐藏列</CENTER></td><td width="40">&nbsp;</td><td width="150"><CENTER style="font-size:13px;font-family:宋体;font-weight:bold;color:#2F4F4F;height:20px;line-height:20px;">显示列</CENTER></td></tr>');//<td width="40">&nbsp;</td></tr>');
	
	jQuery('#reloadCols').append('<tr><td><CENTER><select multiple name="leftSel" id="leftSel" size="10" style="width:130px;" ondblclick="moveOption(1)"></select></CENTER></td>'
		+ '<td><CENTER><input type="button" value=" >> " id="allToRight" onclick="moveAllOption(1)"></CENTER><br><CENTER><input type="button" value=" > " id="toRight" onclick="moveOption(1)"></CENTER><br><br>'
		+ '<CENTER><input type="button" value=" < " id="toLeft" onclick="moveOption(2)"></CENTER><br><CENTER><input type="button" value=" << " id="allToLeft" onclick="moveAllOption(2)"></CENTER></td>'
		+ '<td><CENTER><select multiple name="rightSel" id="rightSel" size="10" style="width:130px;" ondblclick="moveOption(2)"></select></CENTER></td></tr>');
		//+ '<td><CENTER><INPUT TYPE="button" value="置顶" id="toTop" onclick="moveTop()"></CENTER><br><CENTER><INPUT TYPE="button" value="上移" id="toUp" onclick="moveUp()"></CENTER><br><br>'
		//+ '<CENTER><INPUT TYPE="button" value="下移" id="toDown" onclick="moveDown()"></CENTER><br><CENTER><INPUT TYPE="button" value="置底" id="toBottom" onclick="moveBottom()"></CENTER></td></tr>');

	var texts = jQuery("#"+tableId).jqGrid('getGridParam','colNames');
	var names = jQuery("#"+tableId).jqGrid('getGridParam','colModel');
	var n = texts.length - colNum;
	if(n>0){
		texts.splice(0,n);
		names.splice(0,n);
	}
	
	for(i = 0; i < texts.length; i++){
		var temLeft = null;
		var temRight = null;
		if(names[i].hidden){
			//隐藏列
			temRight = "<option value='"+names[i]+"'>"+texts[i]+"</option>";
			jQuery('#leftSel').append(temRight);
		}else{
			//可见列
			temLeft = "<option value='"+names[i]+"'>"+texts[i]+"</option>";
			jQuery('#rightSel').append(temLeft);
		}
	}
	initAdjustBtn();
	
	jQuery('#re_cols').dialog({
        autoOpen: false,
        width   : 420,
        height  : 240,
        //bgiframe : true,
        show    : 'fade',
        modal	: true,
        hide    : 'fade',
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
	//参数先写固定值
	var tableId = $("#v_tableId").val();
	var colNum = $("#v_colNum").val();
	var obj = $("#"+tableId);
	var rightS = $("#rightSel");
	var vTexts = [];
	var vNum = [];
	rightS.find("option").each(function(){
		vTexts.push($(this).text());
		vNum.push($(this).val());
	});
	vTexts.join(",");
	vNum.join(",");
	var texts = jQuery("#"+tableId).jqGrid('getGridParam','colNames');
	var names = jQuery("#"+tableId).jqGrid('getGridParam','colModel');
	var n = texts.length - colNum;
	if(n>0){
		texts.splice(0,n);
		names.splice(0,n);
	}
	
	//用于列顺序的重新排列
	/**for(var i=vNum.length-1;i>=0;i--){
		obj.flexReSortCol(names[vNum[i]]);
	}*/
	for(var i=0;i<texts.length;i++){
		if(jQuery.inArray(texts[i],vTexts) != -1){
			//可见列
			jQuery("#"+tableId).jqGrid('showCol',names[i].name);
		}else{
			//隐藏列
			jQuery("#"+tableId).jqGrid('hideCol',names[i].name);
		}
	}
	//jQuery("#gridTable").trigger("reloadGrid", [{}]);
    jQuery("#re_cols").dialog("close"); 
}
/**
 * 重载列顺序
 */
function reloadVisibleCols(){
	var visibleTexts = $('#mytable').flexVisibleColTexts();
	var texts = $('#mytable').flexColTexts();
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

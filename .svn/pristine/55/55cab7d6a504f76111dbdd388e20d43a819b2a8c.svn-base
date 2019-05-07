/**
	函数:  getF_FILE_NO
	说明:  生成档号。全宗号_档案分类号_保管期限_案卷号_件号。
**/
function getF_FILE_NO(){
	var sF_FILE_NO="";
	var qzh = "";//全宗号  
	var sF_TYPENO = delSpace(jQuery("#"+tableName+"F_TYPENO").val());//档案分类号
	var sF_DOC_DEADLINE = delSpace(jQuery("#"+tableName+"F_DOC_DEADLINE").val());//保管期限
	var ajh = "";//案卷号    
	var sF_DOC_NUM = delSpace(jQuery("#"+tableName+"F_DOC_NUM").val());//件号
	
	sF_FILE_NO = qzh+"_"+sF_TYPENO+"_"+sF_DOC_DEADLINE+"_"+ajh+"_"+sF_DOC_NUM+"";
	return sF_FILE_NO;
}


/**
	函数:  setF_FILE_NO
	说明:  设置档号
**/
function setF_FILE_NO(){
	jQuery("#"+tableName+"F_FILE_NO").val(getF_FILE_NO());
}

//提交保存
function saved(){
	//自动校验
	var isFlag = jQuery('#form1').validationEngine('validate'); //是否全部验证通过
	if (!isFlag){
		return isFlag;	
	}
    var okF = function(){
    	var fm = document.getElementById("form1");
        fm.action = getCurrentFilePath()+"filedocdetaildo.jsp";
        jQuery('#form1').submit();
	}
	var p={
		headerText:'提示',
		okName:'确认',
	    okFunction:okF,
	    cancelFunction:function(){
            jQuery("#form1").resetSubmit(false);
        },
	    cancelName:'取消'
	};
	alert('确定保存吗？',p);
}

function resetSubmit(){
	jQuery("#form1").resetSubmit(false);
}

var filedocJS={};
//初始化页面时获取数据填充
filedocJS.initData=function(config){
	//actionURL:request,actionData:request data,actionCallBack:do other
	//dataTypeList:init page input config
 	var actionURL = config.actionURL;
 	var actionData = config.actionData;
 	var actionCallBack = config.actionCallBack;
 	var dataTypeList = config.dataTypeList;
 	//1:get data
 	jQuery.ajax({
         type: "post",
         url: config.actionURL,
         contentType: "application/x-www-form-urlencoded; charset=utf-8",
         data : config.actionData,
         dataType: "json", 
         success: function (data) {
			//2:get data in to input by the role of dataTypeList
             if(data&&dataTypeList){
                 for(var dataTypeName in dataTypeList){
                 	dataTypeValue= dataTypeList[dataTypeName];
                 	var value = data[dataTypeValue[0]];
                 	if(value){
                 		if(dataTypeValue[1]&&(typeof dataTypeValue[1]=="function")){
                 			var newValue = dataTypeValue[1](value,data);
                 			if(newValue){
                 				jQuery("#"+dataTypeName).val(newValue);
                 			}
                 		}else{
                 			jQuery("#"+dataTypeName).val(value);
                 		}
                 	}
                 }
             }
             //3:do other
             if(actionCallBack&&(typeof actionCallBack=="function")){
             	try{
             		actionCallBack(data);
             	}catch(e){alert('filedocJS.initData.actionCallBack error');}
             }
         }, 
         error: function (XMLHttpRequest, textStatus, errorThrown) {
         	//DO NO THING
         }
	});
};
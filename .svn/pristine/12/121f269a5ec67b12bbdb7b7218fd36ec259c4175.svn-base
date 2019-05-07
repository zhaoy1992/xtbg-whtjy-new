/*
	文件：commonflowend.js
	描述：公共流程处理办结页面的js处理文件
	作者：黄艺平
	日期：2012-2-1
*/

/*
	函数:   init
	说明:   初始化公共流程处理开始页面
	参数:   无
	返回值: 无
*/
	
jQuery(function() {
	jQuery("#insname_rule").val(parms.flowParmJson.insname_rule);
});

/*
函数:   doFinishWorkflow
说明:   办结活动
参数:   无
返回值: 无
*/
function doFinishWorkflow(){
	if(form1.WebOffice){//保存正文信息
		form1.WebOffice.WebSave(true)
	}
	if(typeof setInputValue == "function"){//如果存在设置隐藏域方法
		  setInputValue();
	}
	if(jQuery("#tabs1")){//TODO 此处跳转至tabs-1进行验证。
		jQuery("#tabs1").tabs('select','tabs-1');
	}
	var isFlag = jQuery('#form1').validationEngine('validate'); //是否全部验证通过
	if(!isFlag){
		return false;
	}
		jQuery("#flowData").val(getFlowData());	//流程数据    
		//var inputDatas = subFrame.getInputData()
		//$("#classNameId").val(inputDatas[0]);	//操作类ID
		//$("#busiData").val(inputDatas[1]);	//业务数据
		jQuery("#action_handeridea").val("YY"); //处理意见
		//$("#bigColumnsValue").val(inputDatas[3]); //大字段数据
		document.all.form1.action = parms.flowParmJson.basePath + "ccapp/oa/process/flowprocessing/jsp/commondo.jsp?operationType=dofinishworkflow&entrance="+parms.flowParmJson.entrance;
		document.all.form1.target = "frame1";
		document.all.form1.submit();

	
		/*
		
		var p={
				headerText:'提示',
				okName:'确认',
		        okFunction:okF,
		        cancelName:'取消'
		};
		alert("您确定要办结吗？",p);*/
	
	
}




/**
	函数:   getFlowData
	说明:   获取流程信息
	参数:   无
	返回值: 流程数据
*/
function getFlowData(){
    var remoteAddr = location.host;
    if(remoteAddr.indexOf("localhost") != -1){
        remoteAddr = "127.0.0.1";
    }else{
        remoteAddr = remoteAddr.substr(0,remoteAddr.indexOf(":"));
    }
    var flowData = {
    	"userName": parms.flowParmJson.userName,
        "mgrName" : parms.flowParmJson.mgrName,
        "action_form" : parms.flowParmJson.action_form,
        "action_defid" : parms.flowParmJson.action_defid,
        "actInsId" : parms.flowParmJson.actInsId,
        "remoteAddr" : remoteAddr,
        "cc_form_instanceid" : parms.flowParmJson.cc_form_instanceid,
        "accepter_id" : parms.flowParmJson.user_id,
        "accepter" : parms.flowParmJson.userRealName,
        "flow_id" : parms.flowParmJson.flow_id,
        "org_id" : parms.flowParmJson.orgId,
        "action_id" : parms.flowParmJson.action_id,
        "action_name" : parms.flowParmJson.action_name,
        "ins_code" : parms.flowParmJson.ins_code,
        "status_code" : parms.flowParmJson.status_code,
        "busi_id" : parms.flowParmJson.busi_id,
        "def_id" : parms.flowParmJson.def_id,
        "ins_id" : parms.flowParmJson.ins_id,
        "procId" : parms.flowParmJson.procId,
        "busitype_code" : parms.flowParmJson.busitype_code,
        "template_id" : parms.flowParmJson.template_id
    }
    return getJsonString(flowData);
    
}

function doReturnOK() {
	window.location.href = "mainwork.jsp";
}
function doReturnOK1() {
	
	var v = window.top.getIFrameWindow("_document_body_miansub_main_todowork");
	v.location.href = "../../../../public/home/jsp/todoworktabs.jsp?pagefrom=tabs-4&entrance=homepage";
	
}

//打开分发窗口
function dispenseend(){
	var busiTypeCode = jQuery("#busiTypeCode").val();
	var template_id = jQuery("#template_id").val();
	var p = {
			busi_id : parms.flowParmJson.busi_id,
			ins_id : parms.flowParmJson.ins_id,
			action_form : parms.flowParmJson.action_form,
			title : '',
			busiTypeCode:busiTypeCode,
			template_id:template_id
	};
	var path =  getCurrentFilePath()+"circularize.jsp?"+jQuery.param(p);
	openAlertWindows('windowId',path,'文件传阅',800,200,'25%','25%');
	//openAlertWindows('windowId','../../../huaihua/workflow/receipt/jsp/Jykys_Circularize.jsp?'+jQuery.param(p),wP.wName,wP.wWidth,wP.wHeight,wP.wTop,wP.wLeft);
}
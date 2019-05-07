/*
	函数:   init
	说明:   初始化公共流程处理页面
	参数:   无
	返回值: 无
*/
	
jQuery(function() {
	jQuery("#insname_rule").val(parms.flowParmJson.insname_rule);
	jQuery("#views").val(views);
});


/*
	函数:   doTemp
	说明:   暂存操作
	参数:   无
	返回值: 无
*/
function doTemp(){
	if(form1.WebOffice){//保存正文信息
		form1.WebOffice.WebSave(true);
		//特检院OA 2014-01-13  保存正文为图片  start 
		//form1.WebOffice.WebSaveImage();
		//特检院OA 2014-01-13  保存正文为图片  end
	}
	jQuery("#flowData").val(getFlowData());	//流程数据
	var windowsId = jQuery("#windowsId").val();
    document.all.form1.action = parms.flowParmJson.basePath + "ccapp/oa/process/flowprocessing/jsp/commondo.jsp?operationType=dotemp&windowsId="+windowsId;
    document.all.form1.target = "frame1";
    window.setTimeout("document.all.form1.submit()", 300);
}
/*
函数:   doTemp
说明:   暂存操作
参数:   无
返回值: 无
*/
function overcommondo(){
if(form1.WebOffice){//保存正文信息
	form1.WebOffice.WebSave(true);
	//特检院OA 2014-01-13  保存正文为图片  start 
	//form1.WebOffice.WebSaveImage();
	//特检院OA 2014-01-13  保存正文为图片  end
}
var ins_id = parms.flowParmJson.ins_id;
jQuery("#flowData").val(getFlowData());	//流程数据
var windowsId = jQuery("#windowsId").val();
var circularize_id = jQuery("#circularize_id").val();

document.all.form1.action = parms.flowParmJson.basePath + "ccapp/oa/process/flowprocessing/jsp/commondo.jsp?operationType=overcommondo&windowsId="+windowsId+"&ins_id="+ins_id+"&circularize_id="+circularize_id;
document.all.form1.target = "frame1";
window.setTimeout("document.all.form1.submit()", 300);
}
/*
函数:   doTerminationFlow
说明:   终止流程操作
参数:   无
返回值: 无
*/
function doTerminationFlow(){
	var ins_id = parms.flowParmJson.ins_id;
	var procId = parms.flowParmJson.procId;
	if(IsSpace(ins_id)||IsSpace(procId)){
		alert("流程未启动！");
		return false;
	}
	var okF = function() {
		jQuery("#flowData").val(getFlowData());	//流程数据
		var windowsId = jQuery("#windowsId").val();
		document.all.form1.action = parms.flowParmJson.basePath + "ccapp/oa/process/flowprocessing/jsp/commondo.jsp?operationType=doterminationflow&windowsId="+windowsId;
		document.all.form1.target = "frame1";
		window.setTimeout("document.all.form1.submit()", 300);
	}
	var p={
			headerText:'提示',
			okName:'确定',
	        okFunction:okF,
	        cancelName:'取消'
	};
	alert("流程终止后将无法追回，您确定要终止吗？",p);
}

/**
函数:   doFlow
说明:   启动流程,送后续环节
参数:   无
返回值: 无
*/
function doFlow(){
	var SaveSuccess = true;
	if(form1.WebOffice){//保存正文信息
		SaveSuccess = form1.WebOffice.WebSave(true);
		//特检院OA 2014-01-13  保存正文为图片  start 
		if(SaveSuccess==true){
			//form1.WebOffice.WebSaveImage();
		}
		//特检院OA 2014-01-13  保存正文为图片  end
	}
	if(SaveSuccess==false){
		alert("正文保存失败！");
		return false;
	}
    jQuery("#flowData").val(getFlowData());	//流程数据    
	var initType = jQuery("#initType").val();
	var operationType = ""; //操作类型 比如 暂存，受理，办结
	//根据不同的环节
	if(initType==1){
		jQuery("#flowTache").val("start");
		operationType = "dostartflow";
	}else if(initType==2){
		jQuery("#flowTache").val("middle");
		operationType = "docompleteworkflow";
	}else if(initType==3){
		operationType = "dofinishworkflow";
	}
	var nextActId = getNextActId(jQuery("#xzspWorkflowType").val(),jQuery("#flowTache").val());
	jQuery("#nextActId").val(nextActId);
	var initType = jQuery("#initType").val();
	var windowsId = jQuery("#windowsId").val();
    document.all.form1.action = parms.flowParmJson.basePath + "ccapp/oa/process/flowprocessing/jsp/commondo.jsp?operationType="+operationType+"&windowsId="+windowsId;
    document.all.form1.target = "frame1";
    window.setTimeout("document.all.form1.submit()", 300);
    
}

/**
函数:   doFlowBack
说明:   回退流程
参数:   entrance
*/
function doFlowBack() {
	var okF = function() {
		if(form1.WebOffice){//保存正文信息
			form1.WebOffice.WebSave(true);
			//特检院OA 2014-01-13  保存正文为图片  start 
			//form1.WebOffice.WebSaveImage();
			//特检院OA 2014-01-13  保存正文为图片  end
		}
		//if(typeof setInputValue == "function"){//如果存在设置隐藏域方法
		//  setInputValue();
		//}
		if(jQuery("#tabs1")){//TODO 此处跳转至tabs-1进行验证。
			jQuery("#tabs1").tabs('select','tabs-1');
		}
		var isFlag = jQuery('#form1').validationEngine('validate'); //是否全部验证通过
		if(!isFlag){
			return false;
		}
		
		jQuery("#flowData").val(getFlowData());	
		var windowsId = jQuery("#windowsId").val();
		document.all.form1.action = parms.flowParmJson.basePath + "ccapp/oa/process/flowprocessing/jsp/commondo.jsp?operationType=doflowback&windowsId="+windowsId;
		document.all.form1.target = "frame1";
		document.all.form1.submit();
	}
	var p={
			headerText:'提示',
			okName:'确定',
	        okFunction:okF,
	        cancelName:'取消'
	};
	alert("您确定要回退流程吗？",p);
}

/**
函数:   doFlowSave
说明:   办结并存档
参数:   entrance
*/
function doFlowSave() {
	/*var hasText = jQuery("#hasText").val();//是否有整理后的正文
	if(hasText=="false"){
		alert("整理之前不可存档！");
		return ;
	}*/
	var okF = function() {
		var initType = jQuery("#initType").val();
		if(initType!=3){
			alert("不是办结环节不能进行该操作！")
			return false;
		}
		if(form1.WebOffice){//保存正文信息
			form1.WebOffice.WebSave(true);
			//特检院OA 2014-01-13  保存正文为图片  start 
			//form1.WebOffice.WebSaveImage();
			//特检院OA 2014-01-13  保存正文为图片  end
		}
		//if(typeof setInputValue == "function"){//如果存在设置隐藏域方法
		//  setInputValue();
		//}
		if(jQuery("#tabs1")){//TODO 此处跳转至tabs-1进行验证。
			jQuery("#tabs1").tabs('select','tabs-1');
		}
		var isFlag = jQuery('#form1').validationEngine('validate'); //是否全部验证通过
		if(!isFlag){
			return false;
		}
		//表单转为附件图片 start
		formBodyToattach();
		//表单转为附件图片 end

		jQuery("#flowData").val(getFlowData());	
		jQuery("#saveData").val(getSaveData());	
		jQuery("#isSaveData").val("true");	
		var windowsId = jQuery("#windowsId").val();
		document.all.form1.action = parms.flowParmJson.basePath + "ccapp/oa/process/flowprocessing/jsp/commondo.jsp?operationType=dofinishworkflow&windowsId"+windowsId;
		document.all.form1.target = "frame1";
		document.all.form1.submit();
	}
	var okC = function() {
		jQuery("#webofficDiv").show();
	}
	
	var p={
			headerText:'提示',
			okName:'确定',
	        okFunction:okF,
	        cancelName:'取消',
	        cancelFunction:okC
	};
	alert("您确定要办结并且存档吗？",p);
}

//表单内容转为附件图片
function formBodyToattach(){
	//收文转图片
	if(typeof(window.formToattach) == "function"){
		var drag_in_title_input = jQuery("#field_drag_in_title").val();
		var title = jQuery("#"+drag_in_title_input).val();

		var drag_in_attach_input = jQuery("#field_drag_in_attach").val();
		var attachId = jQuery("#"+drag_in_attach_input).val();
 		window.formToattach(attachId,title);
 	} 
}
//获取存档内容
function getSaveData(){
	var attach_id_name=jQuery("#attach_id_name").val();//附件ID名称
	var n_attach_id =  jQuery("#"+attach_id_name).val();
	var mRecordID = jQuery("#mRecordID").val();
    var saveData = {
    	"F_ID": "F_ID",	  //ID
        "F_TITLE" : "F_TITLE",  //标题
        "F_FILE_NO" : "", //文号
        "F_ARCHIVE_TYPE" : "1",	   //'归档类型1:公文归档';(目前公文均为 1) 
        "F_ORG_ID":parms.flowParmJson.unitId,	   //信息所属机构ID
        "F_ORG_NAME" :parms.flowParmJson.unitName,  //信息所属机构名
        "F_DEPT_ID" :parms.flowParmJson.orgId, //信息所属部门ID
        "F_DEPT_NAME" :parms.flowParmJson.orgName,		//所属部门=归档部门
        "F_OLDFILE_CONTENT" : mRecordID, //原文内容
        "F_OLDFILE_TYPE" : ".doc",							//原文文件类型
        "F_MAINFILE_CONTENT" : "text"+mRecordID, //正文内容
        "F_MAINFILE_TYPE" : ".doc",							//正文文件类型
        "F_ATTACH_ID" : n_attach_id, //附件ID
        "F_CREATE_USER_ID" : parms.flowParmJson.user_id,							//创建人
        "F_CREATE_DATE" : "", //创建时间
        "F_ARCHIVE_USER_ID" : "",	//归档人
        "F_ARCHIVE_DATE" : "", //归档时间
        "F_IS_ARCHIVED" : "0",							//是否已经归档0:否,1:是';    (只填 0)
        "F_MAINQIAN_CONTENT" : "singn"+mRecordID, //面签内容
        "F_MAINQIAN_TYPE" : ".doc"					//面签文件类型
    }
    return getJsonString(saveData);
    
}

//将选择的人员回填至隐藏域
function setFlowInfo(DYNAMICPERFORMER_ID,DYNAMICPERFORMER_REALNAME,DYNAMICPERFORMER,ret ){
	jQuery('#DYNAMICPERFORMER_ID').val(DYNAMICPERFORMER_ID);
	jQuery('#DYNAMICPERFORMER_REALNAME').val(DYNAMICPERFORMER_REALNAME);
	jQuery('#DYNAMICPERFORMER').val(DYNAMICPERFORMER);
	
	jQuery("#xzspWorkflowType").val(ret["xzspWorkflowType"]);
    jQuery("#isDynamicSelectAct").val(ret["isDynamicSelectAct"]);
    jQuery("#isDynamicSelectUser").val(ret["isDynamicSelectUser"]);
    jQuery("#isDynamicSelectAndAct").val(ret["isDynamicSelectAndAct"]);
    jQuery("#nextActList").val(ret["nextActList"]);

    jQuery("#xzsp_workflowControl_selectAct").val(ret["xzsp_workflowControl_selectAct"]); //环节ID
    //启动流程
    doFlow();
}

//取得下一活动ID
function getNextActId(xzspWorkflowType, flowTache){
	  var nextActId = jQuery('#xzsp_workflowControl_selectAct').val(); 
	  return nextActId;
}

/*
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
        "remoteAddr" : parms.remoteAddr,
        "cc_form_instanceid" : parms.flowParmJson.cc_form_instanceid,
        "busitype_code" : parms.flowParmJson.busiTypeCode,
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
        "template_id" : parms.flowParmJson.template_id,
        "procId" : parms.flowParmJson.procId,
        "parent_ins_id" : parms.flowParmJson.parent_ins_id
    }
    return getJsonString(flowData);
    
}

function doReturnOK(indexReturn) {
	window.location.href = "mainwork.jsp?indexReturn="+indexReturn;
}

function doReturnOK1() {
	
	var v = window.top.getIFrameWindow("_document_body_miansub_main_todowork");
	v.location.href = "todoworktabs.jsp?pagefrom=tabs-4&entrance=homepage";
	
}
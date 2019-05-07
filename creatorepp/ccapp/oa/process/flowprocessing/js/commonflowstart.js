/*
	文件：commonflowstart.js
	描述：公共流程处理开始页面的js处理文件
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
	init();
	jQuery("#insname_rule").val(parms.flowParmJson.insname_rule);
	//jQuery("#isDynamicSelectUser").val(parms.flowParmJson.isDynamicSelectUser);
});


function init() {
	initByListType();
	initDynamicWorkflow();
	initDynamicSelectUser();
	
	var nextActId = getNextActId(jQuery("#xzspWorkflowType").val(),jQuery("#flowTache").val());
	jQuery("#nextActId").val(nextActId);
}

/* 初始化动态选择执行人和动态选择执行活动，视情况隐藏或展示 */
function initDynamicWorkflow(){
    var ret = initDynamicWorkflowSet(parms.flowParmJson.flowinfo,"start", parms.flowParmJson.actionAliasAndOrderStr,parms.flowParmJson.actUsertList);//初始化动态选择
    jQuery("#xzspWorkflowType").val(ret["xzspWorkflowType"]);
    jQuery("#isDynamicSelectAct").val(ret["isDynamicSelectAct"]);
    //jQuery("#isDynamicSelectUser").val(ret["isDynamicSelectUser"]);
    jQuery("#isDynamicSelectAndAct").val(ret["isDynamicSelectAndAct"]);
    jQuery("#nextActList").val(ret["nextActList"]);
}

function initDynamicSelectUser() {
	//initDynamicSelectUserSet(parms.flowParmJson.isDynamicSelectUser);
}
//回调函数
function showWeb(){
	if(jQuery("#webofficDiv")){
		//jQuery("#webofficDiv").show();
	}
}

var chooseReportUnits = function(){
		if(jQuery("#webofficDiv")){
			//jQuery("#webofficDiv").hide();
		}
		 var s = new jQuery.z_tree_leftRigth();
		  s.treeID='button_envelop_username';
		  s.isShowSeacher="aa";
		  s.treeName="选取人员";
		  s.headerName="选取人员";
		  s.titelText = "选择人员";
		  s.rightHeaderText="已添加机构和人员";
		  s.callbackok= showWeb;  //确定回调函数
		  s.callbackcancel= showWeb; //取消关闭回调函数
		  s.returnFunction=function(orgObj){
			  if(IsSpace(orgObj.ps) || null ==orgObj.ps ){
				  	  jQuery('#DYNAMICPERFORMER_ID').val('');
				  	  jQuery('#DYNAMICPERFORMER_REALNAME').val('');
				  	  jQuery('#DYNAMICPERFORMER').val('');
			  }else{
					  jQuery('#DYNAMICPERFORMER_ID').val(deemphasisStr(orgObj.ps.id,orgObj.rudata.id));
					  jQuery('#DYNAMICPERFORMER_REALNAME').val(deemphasisStr(orgObj.ps.name,orgObj.rudata.name));
					  jQuery('#DYNAMICPERFORMER').val(deemphasisStr(orgObj.ps.user_name,orgObj.rudata.user_name));
			 }
		  }
		  s.treetypestr = jQuery('#TREE_NODETYPE').val(); //单选或复选
		  var type = "";
		  if(jQuery('#TREE_ROLE').val()=="configPeople"){//配置用户树
			  type = "AUSER"; 
		  }else{										//全选树
			  type= "APERSON";
		  }
		  s.treeList=[{
					  leftHeaderText:'按人员选择',
					  valueKey:'ps',
					  selectedIds:jQuery('#DYNAMICPERFORMER_ID').val(),
					  type: type,
					  user_ids:jQuery('#SELECT_USER_ID_LIST').val()
			},
			{
				  leftHeaderText:'按最近选择的人员选择',
				  isType:'person',
				  valueKey:'rudata',
				  selectedIds:jQuery('#DYNAMICPERFORMER_ID').val(),
				  type: "AUSER",
				  ru_logn:jQuery('#nextActId').val()
			}];
		  s.init();
}


/*
	 函数:   initByListType
	 说明:   根据不同的列表类别做界面控件的隐藏或显示
	 参数:   无
	 返回值: 无
	 */
function initByListType(){
	try{
	   if(parms.flowParmJson.operType == "nosend"){ // 暂存
	
	   }else if(parms.flowParmJson.operType == "daiban"){ // 回退到受理
	       initFromBack();
	   }else if(parms.flowParmJson.operType == "readonly"){
	      
	   }
	}catch(error){}
}

/**
 * 初始化：退回到受理
 */
function initFromBack(){
   jQuery('#btnTemp').hide(); 
   jQuery("#startflaw").text("完成活动");
}
/*
 * 校验动态选择执行人
 */
function checkDynamicexecutor(){
	var showandnone = document.getElementById("xzsp_workflowControl_selectUser").style.display;
	if(showandnone != "none"){
		if(IsSpace(jQuery("#DYNAMICPERFORMER_REALNAME").val())){
		 alert("请指定下一活动执行人！");
		 return;
	   }
	}
}


/*
	函数:   doTemp
	说明:   暂存操作
	参数:   无
	返回值: 无
*/
function doTemp(){
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



	jQuery("#action_handeridea").val("dd"); //处理意见
	//jQuery("#bigColumnsValue").val(inputDatas[3]); //大字段数据
	
    document.all.form1.action = parms.flowParmJson.basePath + "ccapp/oa/process/flowprocessing/jsp/commondo.jsp?operationType=dotemp&indexReturn=2&entrance="+parms.flowParmJson.entrance;
    document.all.form1.target = "frame1";
    window.setTimeout("document.all.form1.submit()", 300);
    
    /*
	var okF = function(){
		jQuery("#flowData").val(getFlowData());	//流程数据
		subFrame.getAttach();
		
		var inputDatas = subFrame.getInputData()
		//alert(inputDatas);
		jQuery("#classNameId").val(inputDatas[0]);	//操作类ID
		jQuery("#busiData").val(inputDatas[1]);	//业务数据
		jQuery("#action_handeridea").val(inputDatas[2]); //处理意见
		jQuery("#bigColumnsValue").val(inputDatas[3]); //大字段数据
		
	    document.all.form1.action = "commondo.jsp?operationType=dotemp&indexReturn=2&entrance="+parms.flowParmJson.entrance;
	    document.all.form1.target = "frame1";
	    //document.all.form1.submit();
	    window.setTimeout("document.all.form1.submit()", 300);
	}
	var p={
			headerText:'提示',
			okName:'确认',
	        okFunction:okF,
	        cancelName:'取消'
	};
	alert("您确定要暂存吗？",p);*/
}


/**
函数:   doStartFlow
说明:   启动流程
参数:   无
返回值: 无
*/
function doStartFlow(){
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
	var showandnone = document.getElementById("xzsp_workflowControl_selectUser").style.display;
	
	if(showandnone != "none"){
		if(IsSpace(jQuery("#DYNAMICPERFORMER_REALNAME").val())){
		 alert("请指定下一活动执行人！");
		 return;
	   }
	}

    jQuery("#flowData").val(getFlowData());	//流程数据    
	jQuery("#flowTache").val("start");
	var nextActId = getNextActId(jQuery("#xzspWorkflowType").val(),jQuery("#flowTache").val());
	jQuery("#nextActId").val(nextActId);
	jQuery("#action_handeridea").val("aa"); //处理意见
	//jQuery("#bigColumnsValue").val(inputDatas[3]); //大字段数据
    document.all.form1.action = parms.flowParmJson.basePath + "ccapp/oa/process/flowprocessing/jsp/commondo.jsp?operationType=dostartflow&indexReturn=3&entrance="+parms.flowParmJson.entrance;
    document.all.form1.target = "frame1";
    window.setTimeout("document.all.form1.submit()", 300);
    
    	/*
	var okF = function okF(){
		jQuery("#flowData").val(getFlowData());	//流程数据    
		subFrame.getAttach();
		jQuery("#flowTache").val("start");
		var nextActId = getNextActId(jQuery("#xzspWorkflowType").val(),jQuery("#flowTache").val());
		jQuery("#nextActId").val(nextActId);
		
		var inputDatas = subFrame.getInputData();
		jQuery("#classNameId").val(inputDatas[0]);	//操作类ID
		jQuery("#busiData").val(inputDatas[1]);	//业务数据
		jQuery("#action_handeridea").val(inputDatas[2]); //处理意见
		jQuery("#bigColumnsValue").val(inputDatas[3]); //大字段数据
		
	    document.all.form1.action = "../process/flowprocessing/jsp/commondo.jsp?operationType=dostartflow&indexReturn=3&entrance="+parms.flowParmJson.entrance;
	    document.all.form1.target = "frame1";
	    //document.all.form1.submit();
	    //if(subFrame.getAttach()){
	    	window.setTimeout("document.all.form1.submit()", 300);
	    //}else{
	    //	document.all.form1.submit();
	    //}
	}
	var p={
			headerText:'提示',
			okName:'确认',
	        okFunction:okF,
	        cancelName:'取消'
	};
	alert("您确定要启动流程吗？",p);*/
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
        "template_id" : parms.flowParmJson.template_id
        
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
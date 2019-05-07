jQuery(function() {
	init();
	jQuery("#insname_rule").val(parms.flowParmJson.insname_rule);
	//jQuery("#isDynamicSelectUser").val(parms.flowParmJson.isDynamicSelectUser);
});

function init() {
	initDynamicWorkflow();
	initDynamicSelectUser();
	initBotton();
	
	var nextActId = getNextActId(jQuery("#xzspWorkflowType").val(),jQuery("#flowTache").val());
	jQuery("#nextActId").val(nextActId);
}

function initBotton() {
	jQuery("#btnCompleteAct").val("完成" + parms.flowParmJson.action_name);
	jQuery("#terminationFlow").val("终止" + parms.flowParmJson.action_name);
}

/* 初始化动态选择执行人和动态选择执行活动，视情况隐藏或展示 */
function initDynamicWorkflow(){
    var ret = initDynamicWorkflowSet(parms.flowParmJson.flowinfo,"middle", parms.flowParmJson.actionAliasAndOrderStr,parms.flowParmJson.actUsertList); //初始化动态选择
    jQuery("#xzspWorkflowType").val(ret["xzspWorkflowType"]);
    jQuery("#isDynamicSelectAct").val(ret["isDynamicSelectAct"]);
    jQuery("#isDynamicSelectAndAct").val(ret["isDynamicSelectAndAct"]);
    jQuery("#nextActList").val(ret["nextActList"]);
}

function initDynamicSelectUser() {
	//initDynamicSelectUserSet(parms.flowParmJson.isDynamicSelectUser,parms.flowParmJson.isShowBack);
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
	  s.treeName="选取人员1";
	  s.headerName="选取人员1";
	  s.titelText = "选择人员1";
	  s.rightHeaderText="已添加机构和人员1";
	  s.callbackok= showWeb;
	  s.callbackcancel= showWeb;
	  s.returnFunction=function(orgObj){
		  if(IsSpace(orgObj.ps) || null ==orgObj.ps )
		  	{
			  	  jQuery('#DYNAMICPERFORMER_ID').val('');
			  	  jQuery('#DYNAMICPERFORMER_REALNAME').val('');
			  		jQuery('#DYNAMICPERFORMER').val('');
			 }else
			 {
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
	  s.treeList=
			  [{
				  leftHeaderText:'按人员选择',
				  valueKey:'ps',
				  selectedIds:jQuery('#DYNAMICPERFORMER_ID').val(),
				  type:type,
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

function doCompleteWorkflow(entrance){
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

	jQuery("#flowData").val(getFlowDatas());	
	
	var nextActId = getNextActId(jQuery("#xzspWorkflowType").val(),jQuery("#flowTache").val());
	jQuery("#nextActId").val(nextActId);
	
	jQuery("#action_handeridea").val("");
	jQuery("#bigColumnsValue").val(""); 
	

	
	document.all.form1.action = parms.flowParmJson.basePath + "ccapp/oa/process/flowprocessing/jsp/commondo.jsp?operationType=docompleteworkflow&entrance1="+parms.flowParmJson.entrance;
	document.all.form1.target = "frame1";
	document.all.form1.submit();
	/*
	var okF = function() {
		
		jQuery("#flowData").val(getFlowDatas());	
		subFrame.getAttach();
		
		var nextActId = getNextActId(jQuery("#xzspWorkflowType").val(),jQuery("#flowTache").val());
		jQuery("#nextActId").val(nextActId);
		
		var inputDatas = subFrame.getInputData()
		jQuery("#classNameId").val(inputDatas[0]);	
		jQuery("#busiData").val(inputDatas[1]);	
		jQuery("#action_handeridea").val(inputDatas[2]);
		jQuery("#bigColumnsValue").val(inputDatas[3]); 
		
	
		
		document.all.form1.action = "commondo.jsp?operationType=docompleteworkflow&entrance1="+entrance;
		document.all.form1.target = "frame1";
		document.all.form1.submit();
	}
	var p={
			headerText:'提示',
			okName:'确定',
	        okFunction:okF,
	        cancelName:'取消'
	};
	alert("您确定要完成活动吗？",p);*/
}

//移民局在秘书核搞环节暂存，(除第一环节外的暂存)
function doTemporarySave(){
	if(typeof(subFrame.jQuery('#tabs').tabs) == "function"){
		subFrame.jQuery('#tabs').tabs("select","tabs-1");
	}
	//if(!subFrame.checkByDataset()){	//验证业务数据
	//   return;
	//}
	var okF = function(){
		jQuery("#flowData").val(getFlowDatas());	//流程数据
		subFrame.getAttach();
		
		var inputDatas = subFrame.getInputData()
		//alert(inputDatas);
		jQuery("#classNameId").val(inputDatas[0]);	//操作类ID
		jQuery("#busiData").val(inputDatas[1]);	//业务数据
		jQuery("#action_handeridea").val(inputDatas[2]); //处理意见
		jQuery("#bigColumnsValue").val(inputDatas[3]); //大字段数据
		
	    document.all.form1.action = "commondo.jsp?operationType=doTemporarySave";
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
	alert("您确定要暂存吗？",p);
}


function doTerminationFlow(entrance) {
	var okF = function(){
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
		jQuery("#flowData").val(getFlowDatas());	
		var nextActId = getNextActId(jQuery("#xzspWorkflowType").val(),jQuery("#flowTache").val());
		jQuery("#nextActId").val(nextActId);
	
		jQuery("#action_handeridea").val(""); 
		jQuery("#bigColumnsValue").val(""); 
		
		
		document.all.form1.action = parms.flowParmJson.basePath + "ccapp/oa/process/flowprocessing/jsp/commondo.jsp?operationType=doterminationflow&entrance="+parms.flowParmJson.entrance;
		document.all.form1.target = "frame1";
		document.all.form1.submit();
	}
	var p={
			headerText:'提示',
			okName:'确定',
	        okFunction:okF,
	        cancelName:'取消'
	};
	alert("您确定要终止流程吗？",p);
	
	/*
	var okF = function(){
		jQuery("#flowData").val(getFlowDatas());	
		//alert(getFlowDatas());
		var nextActId = getNextActId(jQuery("#xzspWorkflowType").val(),jQuery("#flowTache").val());
		jQuery("#nextActId").val(nextActId);
		
		var inputDatas = subFrame.getInputData()
		jQuery("#classNameId").val(inputDatas[0]);	
		jQuery("#busiData").val(inputDatas[1]);	
		jQuery("#action_handeridea").val(inputDatas[2]); 
		jQuery("#bigColumnsValue").val(inputDatas[3]); 
		
		
		document.all.form1.action = "commondo.jsp?operationType=doterminationflow&entrance="+entrance;
		document.all.form1.target = "frame1";
		document.all.form1.submit();
	}
	var p={
			headerText:'提示',
			okName:'确定',
	        okFunction:okF,
	        cancelName:'取消'
	};
	alert("您确定要终止流程吗？",p);*/
}


function doFlowBack(entrance) {

	jQuery("#flowData").val(getFlowDatas());	

	jQuery("#action_handeridea").val("");
	jQuery("#bigColumnsValue").val(""); 
	
	document.all.form1.action = parms.flowParmJson.basePath + "ccapp/oa/process/flowprocessing/jsp/commondo.jsp?operationType=doflowback&entrance="+parms.flowParmJson.entrance;
	document.all.form1.target = "frame1";
	document.all.form1.submit();
	
	/*
	var okF = function() {
		jQuery("#flowData").val(getFlowDatas());	
		var inputDatas = subFrame.getInputData()
		jQuery("#classNameId").val(inputDatas[0]);
		jQuery("#busiData").val(inputDatas[1]);	
		jQuery("#action_handeridea").val(inputDatas[2]);
		jQuery("#bigColumnsValue").val(inputDatas[3]); 
		
		document.all.form1.action = "commondo.jsp?operationType=doflowback&entrance="+entrance;
		document.all.form1.target = "frame1";
		document.all.form1.submit();
	}
	var p={
			headerText:'提示',
			okName:'确定',
	        okFunction:okF,
	        cancelName:'取消'
	};
	alert("您确定要回退流程吗？",p);*/
}

function getFlowDatas(){
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
	window.top.getIFrameDOM("_document_body_mian_firstPagerAAAS").location.reload();
	
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
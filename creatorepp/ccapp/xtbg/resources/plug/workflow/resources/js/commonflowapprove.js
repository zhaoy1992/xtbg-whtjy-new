

function doCompleteWorkflow(entrance){
	//流程通知接收人
	var notify_UserId=""; 
	if(wf.isEx() && !IsSpace(parms.flowParmJson.isSignJoinByOrder) && 'N' != parms.flowParmJson.isSignJoinByOrder){
		var checkIsAllSignJoin = wf_Ex.newModel.checkIsAllSignJoin(parms.flowParmJson.ins_id,parms.flowParmJson.action_id,parms.flowParmJson.user_id,parms.flowParmJson.isSignJoinByOrder);
		if((IsSpace(checkIsAllSignJoin.isAllSignJoin)||"false"==checkIsAllSignJoin.isAllSignJoin)&&!IsSpace(checkIsAllSignJoin.readSignUsers)){
			alert("在您之前还有"+checkIsAllSignJoin.readSignUsers+"未处理！");
			return ;
		}
		notify_UserId = checkIsAllSignJoin.signjoin_handlerids;
	}
	if(IsSpace(parms.flowParmJson.isSignJoinByOrder) || 'N' == parms.flowParmJson.isSignJoinByOrder){//如果当前环节不为会签环节，则做执行人验证
		if(!wf.checkDynamicexecutor()){
			return;
		}
	}else{//否则把执行人清空
		setDynamicperformer();
	}
	if(!subFrame.checkByDataset()){
        return;
    }
	var okF = function() {
		
		jQuery("#flowData").val(getFlowDatas());	
		subFrame.getAttach();
		
		//屏蔽完成活动按钮
		jQuery(jQuery("#btnCompleteAct")).attr({"disabled":"disabled"});
		jQuery(jQuery("#btnBack")).attr({"disabled":"disabled"});
		jQuery(jQuery("#btnreturn")).attr({"disabled":"disabled"});
		var nextActId = getNextActId(jQuery("#xzspWorkflowType").val(),jQuery("#flowTache").val());
		jQuery("#nextActId").val(nextActId);
		
		var inputDatas = subFrame.getInputData()
		jQuery("#classNameId").val(inputDatas[0]);	
		jQuery("#busiData").val(inputDatas[1]);	
		jQuery("#action_handeridea").val(inputDatas[2]);
		jQuery("#bigColumnsValue").val(inputDatas[3]); 
		jQuery("#end_type").val(inputDatas[4]);
		jQuery("#receive_userid").val(inputDatas[5]);
		jQuery("#notify_UserId").val(notify_UserId);
		var operationType = jQuery("#submitType").val();
	
		
		document.all.form1.action = "commondo.jsp?operationType="+operationType+"&entrance1="+entrance;
		document.all.form1.target = "frame1";
		document.all.form1.submit();
	}
	var p={
			headerText:'提示',
			okName:'确定',
	        okFunction:okF,
	        cancelName:'取消'
	};
	alert("您确定要完成活动吗？",p);
}

//移民局在秘书核搞环节暂存，(除第一环节外的暂存)
function doTemporarySave(){
	if(typeof(subFrame.isSelectedTable)== "function" && subFrame.isSelectedTable() ){
		subFrame.isSelectedTable();
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
	if(typeof(subFrame.jQuery('#tabs').tabs) == "function"){
		subFrame.jQuery('#tabs').tabs("select","tabs-1");
	}
	//if(!subFrame.checkByDataset()){
     //   return;
    //}
	var inputDatas = subFrame.getInputData();
	var okF = function(){
		jQuery("#flowData").val(getFlowDatas());	
		//alert(getFlowDatas());
		var nextActId = getNextActId(jQuery("#xzspWorkflowType").val(),jQuery("#flowTache").val());
		jQuery("#nextActId").val(nextActId);
		jQuery("#classNameId").val(inputDatas[0]);	
		jQuery("#busiData").val(inputDatas[1]);	
		jQuery("#action_handeridea").val(inputDatas[2]); 
		jQuery("#bigColumnsValue").val(inputDatas[3]); 
		jQuery("#end_type").val(inputDatas[4]);
		jQuery("#receive_userid").val(inputDatas[5]);
		
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
	var end_type=inputDatas[4];
	if("sendgwcs"==end_type){
		alert("您确定要办结吗？",p);
	}else if("sendgwcsandMark"==end_type){
		alert("您确定要送往公文传输并办结吗？",p);
	} else {
		alert("流程将被终止，终止后将不能继续办理此事项，您确定要终止流程吗？",p);
	}
}


function doFlowBack(entrance) {
	//if(!subFrame.checkByDataset()){
   //     return;
   // }

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
	alert("您确定要回退流程吗？",p);
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
        "busitype_code" : parms.flowParmJson.busitype_code
        
    }
   // alert(flowData.procId);
    return getJsonString(flowData);
    
}

function doReturnOK(indexReturn,act_name,actionPage) {
	if(actionPage == 'qingjia'){
		window.location.href = "../../../../chenzhou/leaveManage/jsp/leaveMain.jsp?indexReturn="+indexReturn;
	}else{
		window.location.href = "../../../../public/workflow/jsp/mainwork.jsp?indexReturn="+indexReturn;
	}
}

function doReturnOK1() {
	
	var v = window.top.getIFrameWindow("_document_body_miansub_main_todowork");
	v.location.href = "../../../../public/home/jsp/todoworktabs.jsp?pagefrom=tabs-4&entrance=homepage";
	window.top.getIFrameDOM("_document_body_mian_firstPagerAAAS").location.reload();
	
}
/*
	文件：commonflowstart.js
	描述：公共流程处理开始页面的js处理文件
	作者：黄艺平
	日期：2012-2-1
*/


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
	函数:   doTemp
	说明:   暂存操作
	参数:   无
	返回值: 无
*/
function doTemp(entrance,act_name,actionPage){
	/*var showandnone = document.getElementById("xzsp_workflowControl_selectUser").style.display;
	if(showandnone != "none"){
		if(IsSpace(jQuery("#DYNAMICPERFORMER_REALNAME").val())){
		 alert("请指定下一活动执行人！");
		 return;
	   }
	}*/
	if(!subFrame.checkByDataset()){	//验证业务数据
	    return;
	}
	
	/**
	* 点击暂存时，向子界面做数据赋值，子页面实现此js方法就可以了
	* 请不要删除，此方法我有特殊用途
	* add by 陈建华
	*/
	if(typeof(subFrame.myDoTemp) === "function"){
		subFrame.myDoTemp();
	}
	
	var okF = function(){
		jQuery("#flowData").val(getFlowData());	//流程数据
		subFrame.getAttach();
		
		var inputDatas = subFrame.getInputData()
		//alert(inputDatas);
		jQuery("#classNameId").val(inputDatas[0]);	//操作类ID
		jQuery("#busiData").val(inputDatas[1]);	//业务数据
		jQuery("#action_handeridea").val(inputDatas[2]); //处理意见
		jQuery("#bigColumnsValue").val(inputDatas[3]); //大字段数据
	    document.all.form1.action = "commondo.jsp?operationType=dotemp&indexReturn=2&entrance="+entrance+"&act_name="+act_name;
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



/*
函数:   doStartFlow
说明:   启动流程
参数:   无
返回值: 无
*/
function doStartFlow(entrance,act_name,actionPage){
	if(subFrame.isSelectedTable&&typeof(subFrame.isSelectedTable) == "function"){
		subFrame.isSelectedTable();
	}
	if(!wf.checkDynamicexecutor()){
		return;
	}
	if(!subFrame.checkByDataset()){
        return;
    }
	
	var okF = function okF(){
		//屏蔽开始流程按钮
		jQuery(jQuery("#btnTemp")).attr({"disabled":"disabled"});
		jQuery(jQuery("#startflaw")).attr({"disabled":"disabled"});
		jQuery(jQuery("#btnreturn")).attr({"disabled":"disabled"});
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
		
	    document.all.form1.action = "commondo.jsp?operationType=dostartflow&indexReturn=3&entrance="+entrance+"&act_name="+act_name;
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
	alert("您确定要启动流程吗？",p);
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
        "ins_id" : parms.flowParmJson.ins_id

        
    }
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
	
}
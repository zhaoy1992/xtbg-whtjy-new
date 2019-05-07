/*
	文件：commonflowend.js
	描述：公共流程处理办结页面的js处理文件
	作者：黄艺平
	日期：2012-2-1
*/

/*
函数:   doFinishWorkflow
说明:   办结活动
参数:   无
返回值: 无
*/
function doFinishWorkflow(entrance,userArea){
	if(!subFrame.checkByDataset()){
        return;
    }
	var okF = function(){
		jQuery(jQuery("#startflaw")).attr({"disabled":"disabled"});
		jQuery(jQuery("#btnreturn")).attr({"disabled":"disabled"});
		if("431003"==userArea){
			jQuery(jQuery("#startflaw")).attr({"disabled":"disabled"});
			jQuery(jQuery("#btnreturn")).attr({"disabled":"disabled"});
			loadCreatDiv(jQuery("#startflaw").val());
		}
		
		jQuery("#flowData").val(getFlowData());	//流程数据    
		var inputDatas = subFrame.getInputData();
		jQuery("#classNameId").val(inputDatas[0]);	//操作类ID
		jQuery("#busiData").val(inputDatas[1]);	//业务数据
		jQuery("#action_handeridea").val(inputDatas[2]); //处理意见
		jQuery("#bigColumnsValue").val(inputDatas[3]); //大字段数据
		jQuery("#end_type").val(inputDatas[4]);
		jQuery("#receive_userid").val(inputDatas[5]);
		document.all.form1.action = "commondo.jsp?operationType=dofinishworkflow&entrance1="+entrance;
		document.all.form1.target = "frame1";
		document.all.form1.submit();
	}
	
	//移民局的办结处理
	if("421000"==userArea){
		//检索是否归档
		subFrame.checkFileExit();
		var fileExit =  subFrame.checkFile;
		if(!fileExit ){
			var p={
					headerText:'提示',
					okName:'确认',
			        okFunction:okF,
			        cancelName:'取消'
			};
			alert("您确定还没有归档就进行办结吗？",p);
	       
	    } else {
	    	var p={
					headerText:'提示',
					okName:'确认',
			        okFunction:okF,
			        cancelName:'取消'
			};
			alert("您确定要办结吗？",p);
	    }
		
	//其它地区
	} else {
		if("431003"==userArea){
			var p={
					headerText:'提示',
					okName:'确认',
			        okFunction:okF,
			        cancelName:'取消'
			};
			alert("您确定要归档吗？",p);
		}else{
			var p={
					headerText:'提示',
					okName:'确认',
			        okFunction:okF,
			        cancelName:'取消'
			};
			alert("您确定要办结吗？",p);
		}
	}
	
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
var interval = null;
function loadCreatDiv(butName){
	    var ajax= createDiv("_div_flow","_div_flow");
	    if(true){
	    	var count=0;
	    	function load(){
	    		if(count%3==0){
	    			jQuery(ajax).html("公文正在"+butName+"中，请稍等..");
	    		}else if(count%3==1){
	    			jQuery(ajax).html("公文正在"+butName+"中，请稍等.....");
	    		}else if(count%3==2){
	    			jQuery(ajax).html("公文正在"+butName+"中，请稍等.......");
	    		}
	    		count++;
	    	}
	    	jQuery(ajax).html("公文正在"+butName+"中，请稍等...");
	    	interval = parent.setInterval(load, 500);
	        window.top.jQuery("body").append(jQuery(ajax));
	    } 
}
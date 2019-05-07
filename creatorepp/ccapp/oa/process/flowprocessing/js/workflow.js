/*************************流程界面初始化：这里面有部分代码跟界面耦合*****************************/
var userList =  new Array(); //下环节用户,选择执行人,配置,add by shuqi.liu 全局变量
/* 流程界面初始化：根据是否动态选择执行人及动态选择执行活动来控制界面展示 */
function initDynamicWorkflowSet(flowret, flowTache, actionAliasAndOrderStr,actUsertList){
	
	var xzspWorkflowType = "1";  //流程类别，默认是普通流程
	var isDynamicSelectAct = false; //是否动态选择下一步或活动
	var isDynamicSelectUser = false; //是否动态选择执行人
	var isDynamicSelectAndAct = false;  //是否动态选择下一步与活动
    var SPLIT_CHAR = "@";
   // alert("flowret="+flowret);
    var flowDatas = flowret.split(SPLIT_CHAR);
    //alert("flowDatas="+flowDatas);
    var dynamicActInfo = flowDatas[0]; //包括是否动态选择活动、是否动态选择与活动、与活动是否动态选择执行人
    var dynamicList = getDynamicList(dynamicActInfo);//将3项数据解出来
  //解析各种参数
    var isShowActSelectText = dynamicList["isShowActSelectText"]; //是否动态选择下一步活动
    var isShowAndActSelectText = dynamicList["isShowAndActSelectText"]; //是否动态选择与活动（否则就是或活动）
    var isShowAndActSelectUserText = dynamicList["isShowAndActSelectUserText"]; //与活动是否动态选择执行人 
    var isShowUserText = flowDatas[1];  //是否动态选择执行人
    var isShowBackButton = flowDatas[2];  //是否有回退功能
    var isShowCompleteWorkflow = flowDatas[4];  //是否有完成活动功能
    var isShowTempSaveForm = flowDatas[5];  //是否有暂存功能    
    var isShowTerminate = flowDatas[6];  //是否有流程终止功能
    var nextActList = parseActList(flowDatas[flowDatas.length-1],actionAliasAndOrderStr); //获得下一步活动列表
    userList =  parseUserList(actUsertList); //下环节用户,选择执行人,配置
    var iReject = isRejectActContained(nextActList); //判断是否存在退窗活动
    ///界面控制
    if(nextActList.length >= 2){//如果下环节个数大于1
    	showSelectOrAct();  //显示或活动选择框
    	isDynamicSelectUser  =  initCreateActCombo(nextActList,userList); //生成活动列表
    	xzspWorkflowType = "2";
    	isDynamicSelectAct = true;
    }else{
    	processActInfoWhenOnlyOne(flowTache,nextActList[0]); //设置唯一活动的属性到相应的按钮上
    	isDynamicSelectUser = DySelectUserContorl(userList[0]);//加载第一个
    	xzspWorkflowType = "1";
    	isDynamicSelectAct = false;
    }
    
   /* //alert(isShowActSelectText);
    debugger;
    if(isShowActSelectText == "true"){  //如果是动态选择下一步活动
        isDynamicSelectAct = true;
        if(isShowAndActSelectText == "false"){  //如果不是与分支，则肯定是或分支
        	  isDynamicSelectUser = (isShowUserText == "true") ? true : false ; //是否动态选择执行人
        	  if(flowTache == "middle"){
        	  	  nextActList = extroProcessForReject(nextActList); //中间环节要处理退窗按钮
        	  }
        	  if(nextActList.length >= 2){ //如果有2个以上活动
        	  	showSelectOrAct();  //显示或活动选择框
                initCreateActCombo(nextActList,userList); //生成活动列表
                xzspWorkflowType = "2";
            }else{  //否则：如果是第一个活动，则将活动信息设置受理按钮的属性，如果是中间活动，则设置到完成活动按钮
                processActInfoWhenOnlyOne(flowTache,nextActList[0]); //设置唯一活动的属性到相应的按钮上
                xzspWorkflowType = "1";
            }     
        }else{  //是与活动（与分支活动的动态选执行人在与活动选择页面）
            isDynamicSelectAndAct = true;
            isDynamicSelectUser = (isShowAndActSelectUserText == "true") ? true : false; //与活动选执行人
            xzspWorkflowType = "3";
            if(flowTache == "middle"){
        	  	  nextActList = extroProcessForReject(nextActList); //中间环节要处理退窗按钮
        	  }
        	  if(!isAndActAllNoCond(nextActList)){ //如果存在有条件的与选择（一般都是无条件的）
                showSelectAndAct();//显示与活动选择框
                if(isShowAndActSelectUserText == "true"){
                	  document.getElementById("xzsp_selectAndAct_memo").innerHTML = "请选择下一步环节及执行人";
                }
            }else{//如果所有与分支都是无条件的
            	  if(isShowAndActSelectUserText == "true"){ //但是与活动可动态选择执行人
                    showSelectAndAct(); //则显示与活动选择框，且改变提示信息
                    document.getElementById("xzsp_selectAndAct_memo").innerHTML = "请选择下一步环节执行人";
                }else{  //所有与分支都无条件，且不用动态选执行人，则隐藏选择下一步活动按钮。
                	  PageParms.nextSelectedActList = nextActList;
                	  var actNameList = new Array();
                	  for(var i=0; i<nextActList.length; i++){
                	  	  actNameList.push(nextActList[i][1]);
                	  }
                	  jQuery('XZSPNEXTACT_NAME').value = actNameList.join(",");
                }
            }
        }
    }else{  //普通流程
     	isDynamicSelectUser = (isShowUserText == "true") ? true : false ; //是否动态选择执行人 
        processActInfoWhenOnlyOne(flowTache,nextActList[0]); //设置唯一活动的属性到相应的按钮上
        xzspWorkflowType = "1";
    } */
    var ret = new Array();
    ret["xzspWorkflowType"] = xzspWorkflowType;
    ret["isDynamicSelectAct"] = isDynamicSelectAct;
    ret["isDynamicSelectUser"] = isDynamicSelectUser;
    ret["isDynamicSelectAndAct"] = isDynamicSelectAndAct;
    ret["nextActList"] = nextActList;
    
    return ret;
}

//选择下一步环节的ONCHANGE事件，用来控制下一步执行人是否显示，人员的加载 add by shuqi.liu
function changeSelectAct(){ 
	var items = jQuery("#xzsp_workflowControl_selectAct").val(); 
	jQuery("#DYNAMICPERFORMER_REALNAME").val(""); 
	 for(var j=0; j<userList.length; j++){
		  if(userList[j][0]==items){//如果是当前的环节
			  DySelectUserContorl(userList[j]);
		  }
	 }
	var nextActId = getNextActId(jQuery("#xzspWorkflowType").val(),jQuery("#flowTache").val());
	jQuery("#nextActId").val(nextActId);
}

//是否动态选择执行人。
function DySelectUserContorl(userListInfo){
	if(IsSpace(userListInfo)){
		return false;
	}
	if(userListInfo[2]=="Y"){//如果显示动态执行人
		  showSelectUser();
		  jQuery('#DYNAMICPERFORMER_ID').val(""); //清空下环节用户列表
	  	  jQuery('#DYNAMICPERFORMER_REALNAME').val("");
	  	  jQuery('#DYNAMICPERFORMER').val(""); 
	  	  jQuery('#isDynamicSelectUser').val("true");
		  jQuery('#SELECT_USER_ID_LIST').val(userListInfo[1][0]); //将下环节的人员赋值到隐藏域，在加载在用户机构树的时候用到。
	  	  jQuery('#TREE_ROLE').val(userListInfo[3]); //下环节的人员机构树类型。
	  	  jQuery('#TREE_NODETYPE').val(userListInfo[4]);//下环节的人员机构树类型。
	  	  return true;
	}else{
		  hideSelectUser();//隐藏动态执行人
		  jQuery('#SELECT_USER_ID_LIST').val(""); //清空机构树用户列表
		  jQuery('#TREE_ROLE').val(""); //清空配置树类型
	  	  jQuery('#TREE_NODETYPE').val(""); //清空树类型
		  jQuery('#DYNAMICPERFORMER_ID').val(userListInfo[1][0]); //将下环节的人员赋值到隐藏域，在加载在用户机构树的时候用到。
	  	  jQuery('#DYNAMICPERFORMER_REALNAME').val(userListInfo[1][2]);
	  	  jQuery('#DYNAMICPERFORMER').val(userListInfo[1][1]);
	  	  return false;
	}
}
//动态显示活动执行人
function initDynamicSelectUserSet(isDynamicSelectUser,isShowBack) {
	if('true' == isDynamicSelectUser) {
		showSelectUser();
	}
	if('true' == isShowBack) {
		jQuery('#btnBack').show();
	}
	
}

//获取用户及下环节是否动态选择配置
function parseUserList(actUsertList){
	var usertList = new Array();
	var actUsertLists = actUsertList.split("@");
	for(var i=0; i<actUsertLists.length; i++){
	    if(IsSpace(actUsertLists[i])){
	        continue;
	    }
	    var temAct = new Array();
	    temAct[0] = actUsertLists[i].split("#")[0];//环节ID
	    temAct[1] = actUsertLists[i].split("#")[1];//用户组
	    //获取用户ID ，登录名，真实姓名
	    var usertArrayLists = temAct[1].split(",");
	    var userArray = new Array();
	    var userIdStr = "";
	    var userNameStr = "";
	    var userRealnameStr = "";
	    for(var j=0; j<usertArrayLists.length; j++){
	    	if(IsSpace(usertArrayLists[j])){
		        continue;
		    }
	    	if(j!=usertArrayLists.length-1){
	    		userIdStr = userIdStr+usertArrayLists[j].split("|")[0]+",";//用户ID
		    	userNameStr = userNameStr+usertArrayLists[j].split("|")[1]+",";//用户登录名
		    	userRealnameStr = userRealnameStr+usertArrayLists[j].split("|")[2]+",";//用户真实姓名	
	    	}else{
	    		userIdStr = userIdStr+usertArrayLists[j].split("|")[0];//用户ID
		    	userNameStr = userNameStr+usertArrayLists[j].split("|")[1];//用户登录名
		    	userRealnameStr = userRealnameStr+usertArrayLists[j].split("|")[2];//用户真实姓名	
	    	}
	    }
	    userArray[0] = userIdStr;//用户ID
    	userArray[1] = userNameStr;//用户登录名
    	userArray[2] = userRealnameStr;//用户真实姓名
	    temAct[1] = userArray;
	    temAct[2] = actUsertLists[i].split("#")[2];//是否手动选择人员
	    temAct[3] = actUsertLists[i].split("#")[3];//用户树是 configPeople配置树  allPeople 全树
	    temAct[4] = actUsertLists[i].split("#")[4];//用户树类型 checkbox 复选 radio 单选
	    usertList[i] = temAct;
	}
	//alert(usertList+"");
	return usertList;
}

//获得下一步活动列表：解析过程
function parseActList(actListStr, actionAliasAndOrderStr){
	
  var nextActList = new Array();
  var tmpActList = actListStr.split(",");
  var tmpactAliasAndOrder = actionAliasAndOrderStr.split(",");
  for(var i=0; i<tmpActList.length; i++){
      if(IsSpace(tmpActList[i])){
          continue;
      }
      var temAct = new Array();
      
      temAct[0] = tmpActList[i].split("#")[0];
      temAct[1] = tmpactAliasAndOrder[i].split("#")[0];//活动别名
      temAct[2] = tmpActList[i].split("#")[2]; //到此活动路由是否是有条件的(true|false)
      temAct[3] = tmpActList[i].split("#")[1]; //记录流程模板里的活动名称
      var actionOrder = tmpactAliasAndOrder[i].split("#")[1];
      temAct.push(actionOrder);
      nextActList[i] = temAct;
  }
  nextActList =  sortActList(nextActList)
  return nextActList;
}

//对下一步活动列表排序 2009.12.24 quan.zhou
function sortActList(actionList){
	  var actList = actionList;
		for(var i=0;i<actList.length-1;i++)
		{
				for(var j=i+1;j<actList.length;j++)
				{
						if(actList[i][4]<actList[j][4])
						{
							var temp = actList[i];
					  	actList[i]= actList[j];
					  	actList[j]=temp;
						}
				}
		}
		return actList;
}


//动态选择活动与动态选择执行人扩展属性等
function getDynamicList(dynamicActInfo){
  var dynamicList = new Array();
  if(!IsSpace(dynamicActInfo)) {
	  var actInfos = dynamicActInfo.split(";");
	  dynamicList["isShowActSelectText"] = actInfos[0].split(":")[1];
	  dynamicList["isShowAndActSelectText"] = actInfos[1].split(":")[1];    
	  dynamicList["isShowAndActSelectUserText"] = actInfos[2].split(":")[1]; 
	  
  }
  return dynamicList;
}



//中间环节（有退窗）的额外处理工作
function extroProcessForReject(nextActList){
  var iReject = isRejectActContained(nextActList); //判断是否存在退窗活动
  if(iReject != -1){  //若有一个名字是“退窗”，则生成完成活动与退窗2个按钮
      //showRejectButton(); //显示退窗按钮
      nextActList = processRejectAct(nextActList,iReject); //移除退窗活动
  }
  return nextActList;
}


//显示退窗按钮
function showRejectButton(){
  jQuery('#btnReject').show(); 	
}

//显示请选择或活动区域
function showSelectOrAct(){
  jQuery('#xzsp_workflowControl_selectOrAct').show(); 	
}


//显示动态选择执行人
function showSelectUser(){
  jQuery('#xzsp_workflowControl_selectUser').show(); 	
}
//隐藏动态选择执行人
function hideSelectUser(){
  jQuery('#xzsp_workflowControl_selectUser').hide(); 	
}

//显示请选择或活动区域
function showSelectAndAct(){
  jQuery('#xzsp_workflowControl_selectAndAct').show(); 	
}


//把退窗活动解出来
function processRejectAct(nextActList,iReject){
  var oReject = nextActList[iReject];
  jQuery('#btnReject').attr("actid",oReject[0]); //将退窗活动ID暂时存起来
  jQuery('#btnReject').attr("actname",oReject[1]); 
  nextActList = removeRejectAct(nextActList,iReject); //移除退窗活动
  return nextActList;
}

//当（除退窗外）只有一个活动时，将该活动的属性设置到相应的按钮上
function processActInfoWhenOnlyOne(flowTache,oNextAct){ 
	  if(flowTache == "middle"){   //设置到完成活动按钮
		  jQuery('#btnCompleteAct').attr("actid",oNextAct[0]); 
        if(oNextAct[1] == "" || oNextAct[1] == null){
        	oNextAct[1] = oNextAct[3];
        }
        jQuery('#btnCompleteAct').attr("actname",oNextAct[1]);
    }else if(flowTache == "start"){ //设置到受理按钮
    	if(!IsSpace(oNextAct)) {
    		jQuery("#startflaw").attr("actid",oNextAct[0]);
	        jQuery("#startflaw").attr("actname",oNextAct[1]);
    	}
    }
}


//判断活动列表中是否有退窗活动
function isRejectActContained(nextActList){
    for(var i=0; i<nextActList.length; i++){
        if(nextActList[i][3].indexOf("退窗")!=-1){
            return i;
        }
    }
    return -1;
}

//把退窗活动从活动列表中移出来，指定退窗在哪个位置
function removeRejectAct(nextActList, rPoint){
  if(rPoint == 0){
      oRejectAct = nextActList[0];
      nextActList.shift();
  }else if(rPoint == nextActList.length-1){
      nextActList.pop();
  }else{
      nextActList = nextActList.slice(0,rPoint).concat(nextActList.slice(rPoint+1));
  }
  return nextActList;
}

//创建或活动下拉菜单
function initCreateActCombo(nextActList,usertList){
  var oCombo = jQuery('#xzsp_workflowControl_selectAct');
  var t = Array();
  for(var i = 0; i < nextActList.length -1 ; i++) {
	  for(var j = i+1;j < nextActList.length; j++)   {    
		  var i_num = nextActList[i][0].substring(nextActList[i][0].indexOf("_act")+4,nextActList[i][0].length);
		  var j_num = nextActList[j][0].substring(nextActList[j][0].indexOf("_act")+4,nextActList[j][0].length);
		  //冒泡数组的交换
			if(parseInt(i_num) > parseInt(j_num)){
				//nextActList[i][0]  = yimjfaw_wp1_act5 机要职责     
				//这时候 nextActList[i][0]；nextActList[i][1]；已成空
				t[0]=nextActList[i][0];//将二维数据里的第一个值放到t数组中     yimjfaw_wp1_act5
				t[1]=nextActList[i][1];//将二维数据里的第一个值放到t数组中     机要职责  
				
				//进行交换 把小的与大交换位置  nextActList[j][0];赋值给nextActList[i][0];
				nextActList[i][0]=nextActList[j][0];
				nextActList[i][1]=nextActList[j][1];
				
				//这时候nextActList[j][0]  nextActList[j][1] 已成空
				//再把t[0] t[1] 赋值给 nextActList[j][0]  nextActList[j][1] 完成冒泡的排序
				nextActList[j][0]=t[0];
				nextActList[j][1]=t[1];
   
			}  
		} 
  }
  var flag = false;//是否动态选择执行人
  for(var i = 0; i < nextActList.length; i++){
	  if(i==0){//如果是加载的默认选项，第一个 add by shuqi.liu控制初始化
		  for(var j=0; j<usertList.length; j++){
			  if(usertList[j][0]==nextActList[i][0]){//如果是当前的环节
				   flag =  DySelectUserContorl(usertList[j]);//是否动态选择执行人
			  }
		  } 
	  }
	  oCombo.append("<option value='"+nextActList[i][0]+"'>"+nextActList[i][1]+"</option>");
  }
  return flag;
}
//取得下一活动ID
function getNextActId(xzspWorkflowType, flowTache){
	debugger;
	  var nextActId = null;
	  if(xzspWorkflowType == "1"){  //普通流程
    	  if(flowTache == "middle"){
            nextActId = jQuery('#btnCompleteAct').attr("actid");
        }else if(flowTache == "start"){
        	nextActId = jQuery('#startflaw').attr("actid");
        }
    }else if(xzspWorkflowType == "2"){ //动态选择下一或活动（且除退窗外有多于等于2个活动选项）
        nextActId = jQuery('#xzsp_workflowControl_selectAct').val(); 
    }else{
    	nextActId = jQuery('#XZSPNEXTACT').val();//取得用户选择的与活动ID（多个活动ID之间用逗号隔开）
    }
    return nextActId;
}

/* 环节扩展属性初始化：启动流程环节 */
function initActionExtForStart(){
    if(pageParms.isShowUser){ //如果外围配置了是动态选择执行人
        if(!pageParms.isDynamicSelectAndAct){ //如果不是与分支，则显示动态选择执行人
            jQuery('xzsp_workflowControl_selectUser').style.display = "";
        }
    }else{ //如果外围没配置动态选择执行人
    	  if(pageParms.isDynamicSelectAndAct){ //要与分支的显示界面（把执行人去掉）
            document.getElementById("xzsp_selectAndAct_memo").innerHTML = "请选择下一步环节";
        }
    }
    pageParms.isDynamicSelectUser = pageParms.isShowUser; //是否动态选择执行人以外围配置为准
}


/* 环节扩展属性初始化：审批环节 */
function initActionExtForApprove(){

    if(pageParms.isShowUser){
        if(!pageParms.isDynamicSelectAndAct){ //如果不是与分支，则显示动态选择执行人
            jQuery('xzsp_workflowControl_selectUser').style.display = "";
        }
    }else{ //如果外围没配置动态选择执行人
    	  if(pageParms.isDynamicSelectAndAct){ //要与分支的显示界面（把执行人去掉）
            document.getElementById("xzsp_selectAndAct_memo").innerHTML = "请选择下一步环节";
        }
    }
    if(pageParms.isShowBack){
        jQuery('btnBack').style.display = "";
    }
    if(pageParms.isShowReject){
        jQuery('btnReject').style.display = "";
    }
    if(pageParms.isShowSuspend){
        jQuery('btnSpecialApply').style.display = "";
    }
    pageParms.isDynamicSelectUser = pageParms.isShowUser; //是否动态选择执行人以外围配置为准
}

/**
 * 初始化(隐藏动态选择执行人等)
 */
function initHideDynamic(){
    jQuery('xzsp_workflowControl_selectOrAct').style.display = "none"; 
    jQuery('xzsp_workflowControl_selectUser').style.display = "none"; 
    jQuery('xzsp_workflowControl_selectAndAct').style.display = "none"; 
}

/* 判断是否选择了活动或人 */
function isDynamicActAndUserSelected(){
	  //如果是动态选择下一步与分支活动，则验证
    if(pageParms.isDynamicSelectAndAct){
        if(IsSpace(jQuery('XZSPNEXTACT_NAME').value)){
            alert("请选择下一步活动");
            return false;
        }
    }
    //如果是动态选执行人且不是动态选与活动，则一定要选择下一活动执行人
    if(pageParms.isDynamicSelectUser && !pageParms.isDynamicSelectAndAct){ 
        if(IsSpace(jQuery('DYNAMICPERFORMER').value)){
            alert("请选择下一活动执行人");
            return false;
        }
    }
    return true;
}

/* 构造启动流程或完成活动的流程控制参数 */
function buildFlowCtrlMap(paraMap, flowTache){
	  var xzspWorkflowType = pageParms.xzspWorkflowType; 
	  var isDynamicSelectUser = pageParms.isDynamicSelectUser;
	  var flowId = pageParms.flowId;
	  var nextActList = pageParms.nextActList;
	  //var countryId = paraMap["countryId"];  //乡镇ID quan.zhou 2010.3.23
	  
    var nextActId = "";
    var actUser = "";
    var andSplitUsers = "";
    var nextActId = getNextActId(xzspWorkflowType,flowTache);
    if(xzspWorkflowType == "1"){   //普通流程  
        actUser = getActUserForNotAndSelect(flowId,nextActId,countryId);  //根据活动ID取得下一活动的参与者 quan.zhou 2010.3.23
    }else if(xzspWorkflowType == "2"){ //动态选择下一或活动（且除退窗外有多于等于2个活动选项）
        //actUser = getActUserForNotAndSelect(flowId,nextActId); 
        actUser = getActUserForNotAndSelect(flowId,nextActId,countryId);  //quan.zhou 2010.3.23
    }else{  //动态选择下一与活动
        andSplitUsers = getActUserForAndSelect(flowId,isDynamicSelectUser,PageParms.nextSelectedActList);
    }
    var flowCtrlData = {
        "NEXT_ACT" : nextActId,  //下一步执行活动ID（多个活动ID之间用逗号隔开）
        "DYNAMICPERFORMER" : actUser,  //下一步活动执行人ID（多个活动ID之间用逗号隔开）
        "ANDSPLITUSERS" : andSplitUsers  //下一步与活动执行人ID（多个活动ID之间用逗号隔开） 
    }
    return flowCtrlData;	  
}


//获取下一或活动的参与者
function getActUserForNotAndSelect(flowId, nextActId,countryId){
    if(PageParms.isDynamicSelectUser){  //是动态选择执行人
        return  jQuery('DYNAMICPERFORMER').value; //取得用户选择的执行人的ID（多个用户ID之间用逗号隔开）
    }else{
        return xzsp.api.BaseService2InstanceAPI.getNextActUser(flowId,nextActId,countryId);//否则去环节用户配置中去查询
    }
}
//根据活动ID和用户选择信息，取得与活动的执行人
//nextActList数组元素组成：活动定义ID、活动定义名称、执行人帐号、执行人姓名（如果不是动态选择则为null）
function getActUserForAndSelect(flowId, isDynamicSelectUser, nextActList){
  var actUser = new Array();
  for(var i=0; i<nextActList.length; i++){
      actUser.push(nextActList[i][0]);
      actUser.push(":");
      if(isDynamicSelectUser){ //是动态选择执行人
          actUser.push(nextActList[i][2]);
      }else{ //如果不是，则从环节用户映射关系取
          actUser.push(xzsp.api.BaseService2InstanceAPI.getNextActUser(flowId,nextActList[i][0]));
      }
      if(i != nextActList.length-1){
          actUser.push(";");
      }
  }
  return actUser.join("");
}


/*************************动态选择执行人和动态选择与活动*****************************/

//打开用户选择树型（多选）
function openSelectUserTree(oUserId, oUserName, oUserRealName, isRadio, isFilter, flowId, actDefId, countryId){
  var openURL = new Array();
  openURL.push(getContextPath());
  if(!IsSpace(isRadio) && isRadio){
      openURL.push("/kcapp/xzsp/jsp/tree/orgUserTreeRadio.jsp?flowId=");
  }else{
      openURL.push("/kcapp/xzsp/jsp/tree/orgUserTree.jsp?flowId=");
  }
  openURL.push(flowId);
  openURL.push("&actionDefid=");
  openURL.push(actDefId);
  openURL.push("&userid=");
  openURL.push(oUserId.value);
  openURL.push("&isFilter=");
  openURL.push(isFilter);
  /*乡镇审批添加代码块 quan.zhou 2009.11.06  开始*/
  /*
  openURL.push("&countryId=");
  if(arguments.length<=7)
  {
  	  var actDefId = creator_getQueryString("actDefId");
  	  if(IsSpace(actDefId)){
  	  	actDefId = creator_getQueryString("actdef_id");
  	  }
  	  openURL.push(xzsp.api.BaseService2InstanceAPI.getUserCountryId(flowId,actDefId));
  }else{
  		openURL.push(countryId);
  }*/
  
  
  /*****************乡镇审批添加代码块 结束********************/
  var rtn = window.showModalDialog(openURL.join(""));
  if(!IsSpace(rtn)){
      oUserId.value = rtn.split(";")[0];
      oUserName.value = rtn.split(";")[1];
      oUserRealName.value = rtn.split(";")[2];
  }
	
}


var chooseOrgUser = function (){
	var url = "../../../../tree/jsp/orgusertree.jsp?ischeck=true";

	 var userObj= null;
	 userObj = window.showModalDialog(url,"","dialogWidth=286px;dialogHeight=600px;center:yes");
	 if(!IsSpace(userObj)){
		 jQuery('#DYNAMICPERFORMER_REALNAME').val(userObj.name);
		 jQuery('#DYNAMICPERFORMER_ID').val(userObj.id);
		 jQuery('#DYNAMICPERFORMER').val(userObj.user_name);
	 }
}

function returnPage() {
	/*
	if(IsSpace(parms.flowParmJson.entrance)) {
			try{
			  var okF = function(){
				    if(!IsSpace(parms.flowParmJson.fromPage)) {
				    	window.location.href = parms.flowParmJson.basePath  + "ccapp/oa/process/flowprocessing/jsp/mainwork.jsp?pagefrom=" + parms.flowParmJson.fromPage;
				    } else  {
				    	alert(2);
				    	window.history.go(-1);
				    }
			    }
			}catch(error){}
	}
	
	if(!IsSpace(parms.flowParmJson.entrance)) {
		window.location.href = parms.flowParmJson.basePath  + "ccapp/oa/process/flowprocessing/jsp/todoworktabs.jsp?pagefrom=tabs-4&entrance="+parms.flowParmJson.entrance;
	}
	
	if(!IsSpace(parms.flowParmJson.openFlag)) {
		removeWindows("gwcs",true,false,false);
	}*/
	//TODO 这里的返回页面做成配置
	var okF = function(){
		if(form1.WebOffice){
				form1.WebOffice.WebClose();
		}
		removeAlertWindows("newwindows", false, true, "操作成功", true, parms.flowParmJson.basePath+"/ccapp/oa/process/flowprocessing/jsp/mainwork.jsp",true);
		//window.location.href = parms.flowParmJson.basePath  + "ccapp/oa/process/flowprocessing/jsp/mainwork.jsp?pagefrom=";
	}
		
		var p={
			      	headerText:'提示',
			      	okName:'确认',
			        okFunction:okF,
			        cancelName:'取消'
			    };
		alert('返回该页,未保存的信息将会丢失 '+'<br>'+'确定返回？',p);
	
	
	
}


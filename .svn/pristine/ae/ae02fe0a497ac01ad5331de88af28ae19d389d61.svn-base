/*************************流程初始化界面*****************************/
/* 流程环节用户信息初始化 */
function initActUser(parms){ 
	var xzspWorkflowType = "1";  //流程类别，默认是普通流程
	var isDynamicSelectAct = false; //是否动态选择下一步或活动
	var isDynamicSelectUser = false; //是否动态选择执行人
	var isDynamicSelectAndAct = false;  //是否动态选择下一步与活动
	
	var flowret = parms.flowParmJson.flowinfo;
	var actUsertList = parms.flowParmJson.actUsertList;//下一环节配置人员
	var actionAliasAndOrderStr  = parms.flowParmJson.actionAliasAndOrderStr;
	var SPLIT_CHAR = "@";
	var flowDatas = flowret.split(SPLIT_CHAR);
	
	var nextActList = parseActList(flowDatas[flowDatas.length-1],actionAliasAndOrderStr); //获得下一步活动列表
	userList =  parseUserList(actUsertList); //下环节用户,选择执行人,配置
	//showSelectOrAct();  //显示或活动选择框
	initCreateActCombo(nextActList,userList); //生成活动列表
	if(nextActList.length >= 2){//如果下环节个数大于1
    	xzspWorkflowType = "2";
    	isDynamicSelectAct = true;
    }else{
    	xzspWorkflowType = "1";
    	isDynamicSelectAct = false;
    }
	jQuery("#xzspWorkflowType").val(xzspWorkflowType);
    jQuery("#isDynamicSelectAct").val(isDynamicSelectAct);
    jQuery("#isDynamicSelectAndAct").val(isDynamicSelectAndAct);
    jQuery("#nextActList").val(nextActList);
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
		  //hideSelectUser();//隐藏动态执行人
		  jQuery('#SELECT_USER_ID_LIST').val(userListInfo[1][0]); //清空机构树用户列表
		  jQuery('#TREE_ROLE').val(userListInfo[3]); //清空配置树类型
	  	  jQuery('#TREE_NODETYPE').val(userListInfo[4]); //清空树类型
	  	  jQuery('#isDynamicSelectUser').val("true");
		  jQuery('#DYNAMICPERFORMER_ID').val(userListInfo[1][0]); //将下环节的人员赋值到隐藏域，在加载在用户机构树的时候用到。
	  	  jQuery('#DYNAMICPERFORMER_REALNAME').val(userListInfo[1][2]);
	  	  jQuery('#DYNAMICPERFORMER').val(userListInfo[1][1]);
	  	  return false;
	}
}

//显示动态选择执行人
function showSelectUser(){
  jQuery('#xzsp_workflowControl_selectUser').show(); 	
}
//隐藏动态选择执行人
function hideSelectUser(){
  jQuery('#xzsp_workflowControl_selectUser').hide(); 	
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
	var nextActId = nextActId = jQuery('#xzsp_workflowControl_selectAct').val(); 
    return nextActId;
}

function returnPage() {
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


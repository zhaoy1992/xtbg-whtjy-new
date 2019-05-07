/**
 * create by tian.xia 2013.4.10
 * workflow扩展类 ，提供 公共的公文传输获取
 */
wf_Ex = {
		gwcs : {
				dataset : function(data){alert("未设置数据展示器")},//数据展示器！可以根据各个不同的地方，编写不同的展示器传入
				sys  : "",
				init : function(dataset){//初始化方法
						if(dataset){//初始化公文传输的数据展示器
							wf_Ex.gwcs.dataset = dataset;
						}
						var printBut = jQuery(['<div style="float:left;padding-right: 15px;padding-left: 10px;margin-top: 2px;">',
							                   	'<input class="but_y_06" onMouseOver=javascript:jQuery(this).attr("class","but_y_07");',
												' onMouseOut=javascript:jQuery(this).attr("class","but_y_06"); ',
												' id="getGwcsBut"  type="button" value="从公文传输获取"></input>',
							                   	'</div>'].join(''));
						if(!jQuery('#getGwcsBut',parent.document.body).attr("id")){
							jQuery(printBut).insertBefore(jQuery('#btnTemp',parent.document.body).first());//将打印按钮动态绑定到流程页面的返回按钮后面
							jQuery(printBut).find("#getGwcsBut").bind("click",wf_Ex.gwcs.showGwcsReceiveList);
						}
						
				},
				showGwcsReceiveList : function(){//显示公文落地的数据列表
					var url = getContextPath()+"/ccapp/xtbg/resources/plug/workflow/jsp/receivefromgwcslist.jsp";
					
					 var returnObj= null;
					 returnObj = window.showModalDialog(url,"","dialogWidth=1000px;dialogHeight=596px;center:yes;scroll:no");
					 if(!IsSpace(returnObj)){
						 var url = getContextPath()+"/ccapp/xtbg/resources/plug/workflow/jsp/getgwcsinfobyajax.jsp";
							params = {gwreceive_id:returnObj.gwreceive_id};
							
							jQuery.ajax({
								url: url,
								type: 'POST',
								dataType: 'json',
								data: params,
								success: function(data){
									wf_Ex.gwcs.dataset(data);
								},
								error: function(jqXHR, textStatus, errorThrown){
									alert(jqXHR);
									alert(textStatus);
									alert(errorThrown);
								}
							});
					 }
				},
				sendToGwcs : function(send_id,user_id){//送公文传输
					jQuery.post(getContextPath()+"/ccapp/xtbg/resources/plug/workflow/jsp/sendToGwcs.jsp",{busi_id:send_id,user_id:user_id},
							function(data){
								if(data.issucess){
									alert("发送成功！");
								}else{
									alert("发送失败！");
								}
							},
							'json')
				}	
		},
		gwcs_dataset : {
			
		},
		newModel : {//流程运转的新模式
		},
		newUserTree : {//选择动态执行人是当前部门的
			isSelfOrg : "action_id#action_id"
		}
		
		
		
}
wf_Ex.gwcs_dataset.ymjsw = function(data){//移民局收文的数据展示器
	jQuery('#receive_org').val(data.receiveGwcsBean.recv_org_name);//来文单位
	jQuery('#receive_num').val(data.receiveGwcsBean.serial_number);//文号
	jQuery('#receive_date').val(data.receiveGwcsBean.send_date);//收文日期
	jQuery('#receive_secret').val(data.receiveGwcsBean.urgency_grade);//密级
	jQuery('#receive_title').val(data.receiveGwcsBean.title);//收文标题
	
	uuid = data.receiveGwcsBean.attach_id;
	jQuery('#receive_affix').val(data.receiveGwcsBean.attach_id);
	jQuery('#gwreceive_id').val(data.receiveGwcsBean.gwreceive_id);

	jQuery('#is_gwcs').val('Y');
	MyFancyupload.createUpload('_fileshow', '#_filebut', getContextPath(), getContextPath()+'/servlet/FileUpload?buessid='+uuid, true, uuid);
	jQuery('#filetitleshow').attr("title","本文件含有"+data.fileCountNum+"个附件!");
	alert("获取数据成功");
	jQuery('#filespan').html(data.fileCountNum);
};

wf_Ex.gwcs_dataset.hhsw = function(data){//怀化收文的数据展示器
	jQuery('#receive_org').val(data.receiveGwcsBean.recv_org_name);
	jQuery('#receive_num').val(data.receiveGwcsBean.prefix+data.receiveGwcsBean.symbol+data.receiveGwcsBean.serial_number);
	jQuery('#receive_secret').val(data.receiveGwcsBean.urgency_grade);
	jQuery('#receipt_date').val(data.receiveGwcsBean.send_date);
	jQuery('#file_title').val(data.receiveGwcsBean.title);
	uuid = data.receiveGwcsBean.attach_id;
	jQuery('#receive_affix').val(data.receiveGwcsBean.attach_id);
	jQuery('#gwreceive_id').val(data.receiveGwcsBean.gwreceive_id);

	jQuery('#is_gwcs').val('Y');
	MyFancyupload.createUpload('_fileshow', '#_filebut', getContextPath(), getContextPath()+'/servlet/FileUpload?buessid='+uuid, true, uuid);
	alert("获取数据成功");
};

wf_Ex.gwcs_dataset.jyksy = function(data){//教育考试院收文的数据展示器
	jQuery('#receive_title').val(data.receiveGwcsBean.title); //来文标题
	jQuery('#receive_org').val(data.receiveGwcsBean.recv_org_name);
	jQuery('#receive_num').val(data.receiveGwcsBean.prefix+data.receiveGwcsBean.symbol+data.receiveGwcsBean.serial_number);//文号
	jQuery('#receive_secret').val(data.receiveGwcsBean.urgency_grade);
	jQuery('#receive_date').val(data.receiveGwcsBean.send_date);
	//jQuery('#file_title').val(data.receiveGwcsBean.title);
	uuid = data.receiveGwcsBean.attach_id;
	jQuery('#receive_affix').val(data.receiveGwcsBean.attach_id);
	jQuery('#gwreceive_id').val(data.receiveGwcsBean.gwreceive_id);

	jQuery('#is_gwcs').val('Y');
	MyFancyupload.createUpload('_fileshow', '#_filebut', getContextPath(), getContextPath()+'/servlet/FileUpload?buessid='+uuid, true, uuid);
	alert("获取数据成功");
};

wf_Ex.gwcs_dataset.jyksy_draft = function(data){//教育考试院请批件的数据展示器
	//jQuery('#receive_org').val(data.receiveGwcsBean.recv_org_name);
	//jQuery('#receive_num').val(data.receiveGwcsBean.prefix+data.receiveGwcsBean.symbol+data.receiveGwcsBean.serial_number);//文号
	//jQuery('#receive_secret').val(data.receiveGwcsBean.urgency_grade);
	//jQuery('#receive_date').val(data.receiveGwcsBean.send_date);
	jQuery('#draft_title').val(data.receiveGwcsBean.title);
	uuid = data.receiveGwcsBean.attach_id;
	jQuery('#draft_accessory').val(data.receiveGwcsBean.attach_id);
	
	jQuery('#gwreceive_id').val(data.receiveGwcsBean.gwreceive_id);
	jQuery('#is_gwcs').val('Y');
	MyFancyupload.createUpload('_fileshow', '#_filebut', getContextPath(), getContextPath()+'/servlet/FileUpload?buessid='+uuid, true, uuid);
	alert("获取数据成功");
};

(function($) {
	this.nextActListConfigInfos = null;
	this.nextactname = null;//下一环节名
	
	$.init = function(){
		$.initDynamicSelectAct();
	}

	/**
	 * 初始化动态选择环节下拉框的相关属性
	 * @return
	 */
	$.initDynamicSelectAct = function(){
		this.nextActListConfigInfos = $.parseNextActListConfigInfos(actionAliasAndOrderStr);//解析下一环节集合字符串为对象集合
		nextactname = actionAliasAndOrderStr.split("#")[0];
		$.bandingTreeChooseFun(true);
		$.initSelectUserDivByCurrSelectedText();
		/**********替换掉旧模式中的人员选择树*************/
		$.chooseReportUnitsTemp = chooseReportUnits;
		chooseReportUnits = function(){
			//是否是当前部门的执行人
			var is_selforg = false;
			var NextAction_Name = $.getCurr_NextActObj().actionName;
			var selActionName = wf_Ex.newUserTree.isSelfOrg;
			if(selActionName.indexOf(NextAction_Name)>-1){
				is_selforg = true;
			}
			$.chooseReportUnitsTemp($.getCurrNextActActionIdForTree(),$.getCurr_NextActObj().tree_nodetype,is_selforg);
		}
		/**********替换掉旧模式中的动态执行人验证方法****************/
		wf.checkDynamicexecutor = function (){
			/*
			 * 校验动态选择执行人
			 */
			var showandnone = document.getElementById("xzsp_workflowControl_selectUser").style.display;
			//if(showandnone != "none"){
				if(IsSpace(jQuery("#DYNAMICPERFORMER_REALNAME").val())){
					var notice_message = "请指定下一活动执行人！";
					if(IsSpace($.getCurr_NextActObj().UserId)){//当动态选择执行人为空时，要检查是否后台没有配置人，给与提示
						notice_message = "请到【流程配置】中配置下一环节执行人！";
					}
					alert(notice_message);
					return false;
				}
				return true;
			//}
		}
		
		
		jQuery("#xzsp_workflowControl_selectAct").change(function(){
			$.initSelectUserDivByCurrSelectedText();
		})
	}
	$.checkIsAllSignJoin = function(ins_id,action_id,curr_userid,order){
		/**
		 * 检查是否在当前用户之前的人全部会签完毕了
		 * @return
		 */
		var dataTemp;
		jQuery.ajax({
		      url: getContextPath()+"/ccapp/xtbg/resources/plug/workflow/jsp/checkIsAllSignJoin.jsp",
		      type: "POST",
		      data: {ins_id:"'"+ins_id+"'",action_id:"'"+action_id+"'",curr_userid:curr_userid,order:order},
		      dataType: "json",
		      async:false,//必须为同步执行
		      success: function(data){
		    	  dataTemp = data;
		      }
		   });

		return dataTemp;
	}

	$.getActionHandler = function(dataObj){
		var action_Obj = {action_userid:'',action_username:'',action_userrealname:''};
		jQuery.ajax({
		      url: getContextPath()+"/ccapp/xtbg/resources/plug/workflow/jsp/getActionHandler.jsp",
		      type: "POST",
		      data: dataObj,
		      dataType: "json",
		      async:false,//必须为同步执行
		      success: function(data){
				action_Obj.action_userid = data.action_userid;
				action_Obj.action_username = data.action_username;
				action_Obj.action_userrealname = data.action_userrealname;
		      }
		   });
		return action_Obj;
	}




	/**
	 * 解析下一环节集合的配置信息
	 * @param actionAliasAndOrderStr 下一环节信息拼接字符串
	 * @return
	 */
	$.parseNextActListConfigInfos = function(actionAliasAndOrderStr){
		var configInfolist = new Object();
		var tempArry = actionAliasAndOrderStr.split(",");
		for(var i = 0 ; i < tempArry.length ; i ++){
			if(!IsSpace(tempArry[i])){
				//tempArry[i].split("#")[0]:环节名称
				configInfolist[tempArry[i].split("#")[0]] = new Object();
				configInfolist[tempArry[i].split("#")[0]].actionName = tempArry[i].split("#")[0];//环节名称，也是action_name
				configInfolist[tempArry[i].split("#")[0]].actionId = tempArry[i].split("#")[1];//环节顺序号，也是action_id
				configInfolist[tempArry[i].split("#")[0]].isShowUser = tempArry[i].split("#")[2];//是否动态选择执行人
				configInfolist[tempArry[i].split("#")[0]].UserRealName = tempArry[i].split("#")[3].split("@")[0].replaceAll(":",",");//该环节的流程配置用户名称
				configInfolist[tempArry[i].split("#")[0]].UserId = tempArry[i].split("#")[3].split("@")[1].replaceAll(":",",");//该环节的流程配置用户id
				configInfolist[tempArry[i].split("#")[0]].UserName = tempArry[i].split("#")[3].split("@")[2].replaceAll(":",",");//该环节的流程配置用户名
				configInfolist[tempArry[i].split("#")[0]].tree_role = tempArry[i].split("#")[4];//树的内容权限
				configInfolist[tempArry[i].split("#")[0]].tree_nodetype = tempArry[i].split("#")[5];//树的节点类型
				configInfolist[tempArry[i].split("#")[0]].autoassignment = tempArry[i].split("#")[6];//前置活动的action_defid
				configInfolist[tempArry[i].split("#")[0]].autoassignmentUserId = tempArry[i].split("#")[7].split("@")[0];//前置活动的执行人user_id
				configInfolist[tempArry[i].split("#")[0]].autoassignmentUserName = tempArry[i].split("#")[7].split("@")[1];//前置活动的执行人user_name
				configInfolist[tempArry[i].split("#")[0]].autoassignmentUserRealName = tempArry[i].split("#")[7].split("@")[2];//前置活动的执行人user_realname
			}
		}
		return configInfolist;
	}
	

	/**
	 * 处室话动态选择执行人的区域根据当前环节
	 * @return
	 */
	$.initSelectUserDivByCurrSelectedText = function(){
		var curr_actobj = $.getCurr_NextActObj();
		$.showOrHideSelectUserDiv(curr_actobj.isShowUser,curr_actobj.UserId,curr_actobj.UserRealName,curr_actobj.UserName);
	}
	/**
	 * 获取当前选中的下一环节对象
	 * @param obj
	 * @return
	 */
	$.getCurr_NextActObj = function(){
		var currSelectedText = jQuery("#xzsp_workflowControl_selectAct").find("option:selected").text();
		if(IsSpace(currSelectedText)){
			currSelectedText = nextactname;
		}
		var curr_actobj = $.nextActListConfigInfos[currSelectedText];
		return curr_actobj;
	}

	/**
	 * 为动态选择人框绑定树方法
	 * @param flag 是否绑定
	 */
	$.bandingTreeChooseFun = function(flag){
		jQuery("#DYNAMICPERFORMER_REALNAME").unbind("click");
		if(!IsSpace(flag) && flag){
			jQuery("#DYNAMICPERFORMER_REALNAME").bind("click",function(){chooseReportUnits()});
		}
	}

	/**
	 * 显示或者隐藏动态选择执行人的区域
	 * @param flag
	 * @return
	 */
	$.showOrHideSelectUserDiv = function(flag,UserId,UserRealName,UserName){
		if("Y" == flag){//显示动态选择执行人区域
			if(UserId.split(",").length == 1 && $.getCurr_NextActObj().tree_role != "allPeople"){//如果只有唯一的执行人id,并且树类型不是全选树，则直接填入到动态选择人框中
				setDynamicperformer(UserId,UserRealName,UserName);
				jQuery(".but_x").hide();
				$.bandingTreeChooseFun(false);
			}else{
				jQuery(".but_x").show();
				setDynamicperformer();
				$.bandingTreeChooseFun(true);
			}
			jQuery("#xzsp_workflowControl_selectUser").show();
		}else{
			if(!IsSpace($.getCurr_NextActObj().autoassignment) && "N" != $.getCurr_NextActObj().autoassignment){//看是否是要使用前置活动执行人
				var data_obj = {ins_id:parms.flowParmJson.ins_id,action_defid:$.getCurr_NextActObj().autoassignment}
				var action_handlerObj = $.getActionHandler(data_obj);
				setDynamicperformer(action_handlerObj.action_userid,action_handlerObj.action_userrealname,action_handlerObj.action_username);
			}else{
				setDynamicperformer(UserId,UserRealName,UserName);
			}
			jQuery("#xzsp_workflowControl_selectUser").hide();
		}
		jQuery("#isDynamicSelectUser").val("true");//所有的当前环节全部切换到动态选择执行人
	}

	/**
	 * 获取当前下一环节的环节id，仅用于树的构造参数
	 * @return
	 */
	$.getCurrNextActActionIdForTree = function(){
		if($.getCurr_NextActObj().tree_role == "allPeople"){
			return "";
		}else{
			return $.getCurr_NextActObj().actionId;
		}
	}
	
})(wf_Ex.newModel);
 












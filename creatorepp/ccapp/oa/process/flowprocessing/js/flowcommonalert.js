/**
 * 表单版本控制JS
 */
//送后续环节
function sendNext(){
	
	var action_defid =  parms.flowParmJson.action_defid;
	if(action_defid == "clwx_wp1_act1"){
		del_edit_info();
	}
	
	if(!checkDataBeforeRunFlow()){
		return false;
	}
	
	
	
	//短信配置
	var msg_txt_config = jQuery("#msg_txt_config").val(); //获取页面隐藏域里的内容 （此处有问题，如果暂存将无法保存短信配置。）
	var isdxtx = jQuery("#isdxtx").val();
	var isjsxx = jQuery("#isjsxx").val();
	var isyj = jQuery("#isyj").val();
	var isznxx = jQuery("#isznxx").val();
	var busi_id = jQuery("#busi_id").val();
	var url = jQuery("#path").val()+'/ccapp/oa/archive/sendnext.jsp?windowsId=windowIds&busi_id='+busi_id+'&msg_txt='+msg_txt_config+'&isdxtx='+isdxtx+'&isjsxx='+isjsxx+'&isyj='+isyj+'&isznxx='+isznxx;
	openAlertWindows('windowIds',url,'送后续环节',800,220,'25%','25%',resetSubmit);
}

/**
 * 暂存
 * 依赖:doTemp()[commonflowdo.js]
 * 
 * @returns
 */
function formdotemp(){
	if(!checkDataBeforeRunFlow()){
		return false;
	}
	var ins_id = parms.flowParmJson.ins_id;
	if(IsSpace(ins_id)){//如果流程ID为空，那么新建一个流程ID
		parms.flowParmJson.ins_id = Math.uuidCompact();
		doTemp();
	}else{
		var doTempState = jQuery("#doTempState");
		if(doTempState){
			//表示第二次暂存
			jQuery("#doTempState").val("1");
		}
		doTemp();//如果是二次发起，status_code为04时不会发起流程。common.do 的回调resetOptType 会修改status_code 和 actInsId的值
	}
	//TODO 第二次暂存问题
}

function overcommon(){
	if(!checkDataBeforeRunFlow()){
		return false;
	}
	var ins_id = parms.flowParmJson.ins_id;
	overcommondo();
}
/**
 * 在 点击按钮"后续环节","暂存"的时候,校验页面的tabs1标签页的form1
 * 在 sendNext()与formdotemp() 中调用
 * 
 * 需要进行特殊校验的页面 可在嵌入该文件后,重新定义Fn对象checkDataBeforeRunFlow
 * @returns {Boolean}
 * 
 */
function checkDataBeforeRunFlow(){
	var flag = false;
	jQuery("#tabs1").tabs('select','tabs-1');//此处跳转至tabs-1进行验证。
	flag = jQuery('#form1').validationEngine('validate'); //是否全部验证通过
	if(!flag){
		resetSubmit();
	}
	return flag;
}

//短信配置回填
function msgConfigReset(isdxtx,isyj,isznxx,isjsxx,msg_txt){
	jQuery("#isdxtx").val(isdxtx);
	jQuery("#isyj").val(isyj);
	jQuery("#isznxx").val(isznxx);
	jQuery("#isjsxx").val(isjsxx);
	jQuery("#msg_txt").val(msg_txt);
}

//公文编号
function serialNumber(){
	var busi_id = jQuery("#busi_id").val();
	var url = jQuery("#path").val()+'/ccapp/oa/archive/serialnumber.jsp?windowsId=windowIds&busi_id='+busi_id;
	openAlertWindows('windowIds',url,'公文编号',800,240,'25%','25%',closeAlertWindow);
}

//流水号编号
function serialLSH(sernumrule,serId){
	var busi_id = jQuery("#busi_id").val();
	var url = jQuery("#path").val()+'/ccapp/oa/archive/serialnum.jsp?windowsId=windowIds&sernumrule='+sernumrule+"&serId="+serId;
	openAlertWindows('windowIds',url,'流水号',800,240,'25%','25%',closeAlertWindow);
}

//流水号重置
function serNumReset(s_code,s_time,s_lsh,s_allcode,serId){
	var serialNumberBeanStr = jQuery("#serialNumberBeanStr").val();
	serialNumberBeanStr = eval("(" + serialNumberBeanStr+ ")"); 
	serialNumberBeanStr.s_code = s_code;
	serialNumberBeanStr.s_time = s_time;
	serialNumberBeanStr.s_lsh = s_lsh;
	serialNumberBeanStr.s_allcode = s_allcode;
	serialNumberBeanStr = JSON.stringify(serialNumberBeanStr); //json串化
	jQuery("#serialNumberBeanStr").val(serialNumberBeanStr);
	jQuery("#"+serId).val(s_allcode);
	
}

//公文编号赋值
function setNumber(txtValue){
	var number_name = jQuery("#field_drag_in_number").val();
	jQuery("#"+number_name).val(txtValue);
}

//.do页面的回调函数，将验证框架里的isSubmit重置，用来防止提交失败后再提交失效。
function resetSubmit(){
	jQuery("#form1").resetSubmit(false);
	//jQuery("#webofficDiv").show();
}

//打开分发窗口
function dispenseend(){
	var ins_id = parms.flowParmJson.ins_id;
	var busiTypeCode = jQuery("#busiTypeCode").val();
	var template_id = jQuery("#template_id").val();
	var busi_id = parms.flowParmJson.busi_id;
	//正文处理
	var drag_in_webtext_input = jQuery("#field_drag_in_webtext").val();
	var	mRecordID = jQuery("#"+drag_in_webtext_input).val();
	//标题处理
	var drag_in_title_input = jQuery("#field_drag_in_title").val();
	var archiveTitle = jQuery("#"+drag_in_title_input).val();
	//附件处理
	var drag_in_attach_input = jQuery("#field_drag_in_attach").val();
	var n_attach_id=jQuery("#"+drag_in_attach_input).val();//附件ID名称
	if(IsSpace(n_attach_id)){
		//TODO 如果附件ID为空，回填到attach_id_name 并且传到附件页面
		n_attach_id =  Math.uuidCompact();
		jQuery("#"+drag_in_attach_input).val(n_attach_id);
	}
	var p = {
			busi_id : busi_id,
			ins_id : ins_id,
			title : archiveTitle,
			busiTypeCode:busiTypeCode,
			template_id:template_id,
			n_attach_id:n_attach_id,
			mRecordID:mRecordID
	};
	var path =  jQuery("#path").val()+"/ccapp/oa/archive/wordarchive/sendarchive.jsp?windowsId=windowIds&"+jQuery.param(p);
	//jQuery("#webofficDiv").hide();
	openAlertWindows('windowIds',path,'公文分发',900,500,'25%','25%',closeAlertWindow);

}

//盖章（送公文传输,上传文件，获取ID，然后打开公文传输盖章页面）
function sendToArchive(){
	var uuid = "";
	var mRecordID = do_recordID;
	var ins_id = parms.flowParmJson.ins_id;
	var ajaxurl=jQuery("#path").val()+"/ccapp/oa/archive/wordarchive/sendtoarchivedo.jsp"
	var params = {'ins_id':ins_id,'mRecordID':mRecordID,'optType':'getArchiveUUID'};
	jQuery.ajax({//AJAX将WORD正文上传至公文传输
		url: ajaxurl,
		type: 'POST',
		dataType:'json',
		data: params,
		async:false,
		success: function(data){
			
			//打开公文传输UUID页面
			uuid = data.uuid
			if(!IsSpace(uuid)&& uuid!="erro"){
				var url = data.gwcsjspaddress+"&type=stamp&id="+uuid;
				var winwidth=(screen.width - 920)/2;
				var winheight=(screen.height - 700)/2-30;
				var freatrues = "height=700,width=920,top="+winheight+"px,left="+winwidth+"px,status=yes,toolbar=no,menubar=no,location=no";
				window.open(url,"",freatrues ); 
			}else{
				alert("未能正确获取公文传输返回的UUID！");
			}
			
		},
		error: function(jqXHR, textStatus, errorThrown){
			alert("获取公文传输返回的UUID失败！")
		}
	})
}

//打开内部分送窗口
function isnbfs(){
	var busiTypeCode = jQuery("#busiTypeCode").val();
	var template_id = jQuery("#template_id").val();
	//标题处理
	var drag_in_title_input = jQuery("#field_drag_in_title").val();
	var archiveTitle = jQuery("#"+drag_in_title_input).val();
	var p = {
			busi_id : parms.flowParmJson.busi_id,
			ins_id : parms.flowParmJson.ins_id,
			action_form : parms.flowParmJson.action_form,
			title : descape(escape(archiveTitle)),
			busiTypeCode:busiTypeCode,
			template_id:template_id
	};
	var path =  jQuery("#path").val()+"/ccapp/oa/archive/circularize.jsp?windowsId=windowIds&"+jQuery.param(p);
	//jQuery("#webofficDiv").hide();
	openAlertWindows('windowIds',path,'内部分送',800,200,'25%','25%',closeAlertWindow);

}

//将页面的操作类型修改，比如暂存成功后，不关闭页面的情况下需要将操作类型修改为upadate
function resetOptType(opt_type){
	jQuery("#opt_type").val(opt_type);
	var ins_id = parms.flowParmJson.ins_id;
	if(ins_id){
		var ajaxurl=jQuery("#path").val()+"/ccapp/oa/archive/wordarchive/sendtoarchivedo.jsp";
		jQuery.ajax({//AJAX将WORD正文上传至公文传输
			url: ajaxurl,
			type: 'POST',
			dataType:'text',
			data: {
				"ins_id":ins_id,
				"optType":"getTempActionId"
			},
			success: function(data){
				if(data){
					parms.flowParmJson.status_code = "04";
					parms.flowParmJson.actInsId = trim(data);
				}
			},
			error: function(jqXHR, textStatus, errorThrown){
			}
		})
	}
}

//查看流程
function showFlowHistory(){
	var ins_id = parms.flowParmJson.ins_id;
	if(IsSpace(ins_id)){
		alert("流程未启动！");
		return false;
	}
	var url = jQuery("#path").val()+"/ccapp/oa/process/flowprocessing/jsp/showflowhistorytiaozhuan.jsp?insid="+ins_id;
	var winwidth=(screen.width - 920)/2;
	var winheight=(screen.height - 700)/2-30;
	var freatrues = "height=700,width=920,top="+winheight+"px,left="+winwidth+"px,status=yes,toolbar=no,menubar=no,location=no";
	window.open(url,"",freatrues ); 
}

//回退到指定的环节
function doBackNext(){
	var isSignCount = parms.flowParmJson.isSignCount;
	if(!IsSpace(isSignCount) && isSignCount!="false"){
		alert("会签环节不可回退！");
		return ;
	}
	var initType = parms.flowParmJson.initType;
	if(initType==3) {
		doFlowBack();
	} else {
		var busi_id = jQuery("#busi_id").val();
		
		//短信配置
		var msg_txt_config = jQuery("#msg_txt_config").val(); //获取页面隐藏域里的内容 （此处有问题，如果暂存将无法保存短信配置。）
		var isdxtx = jQuery("#isdxtx").val();
		var isjsxx = jQuery("#isjsxx").val();
		var isyj = jQuery("#isyj").val();
		var isznxx = jQuery("#isznxx").val();
		
		var url = jQuery("#path").val()+'/ccapp/oa/archive/dobacknext.jsp?windowsId=windowIds&busi_id='+busi_id+'&msg_txt='+msg_txt_config+'&isdxtx='+isdxtx+'&isjsxx='+isjsxx+'&isyj='+isyj+'&isznxx='+isznxx;
		//jQuery("#webofficDiv").hide();
		openAlertWindows('windowIds',url,'回退',800,340,'25%','25%',closeAlertWindow);
	}
}

//返回页面
function returnPage(indexReturn) {
	//TODO 这里的返回页面做成配置
	if("3"==indexReturn){//如果是已办列表，直接返回
		if(!checkDataBeforeRunFlow()){
			return false;
		}
		removeAlertWindows(jQuery("#windowsId").val(), false, true, "操作成功", true, parms.flowParmJson.basePath+"/ccapp/oa/process/flowprocessing/jsp/mainwork.jsp?indexReturn="+indexReturn,true);
	}else if(("1"==indexReturn) || ("2"==indexReturn)){//如果是暂存，代办列表，提示返回
		var okF = function(){
			if(form1.WebOffice){
					form1.WebOffice.WebClose();
			}
			if(!checkDataBeforeRunFlow()){
				return false;
			}
			removeAlertWindows(jQuery("#windowsId").val(), false, true, "操作成功", true, parms.flowParmJson.basePath+"/ccapp/oa/process/flowprocessing/jsp/mainwork.jsp?indexReturn="+indexReturn,true);
			//window.location.href = parms.flowParmJson.basePath  + "ccapp/oa/process/flowprocessing/jsp/mainwork.jsp?pagefrom=";
		}
		var p={
			      	headerText:'提示',
			      	okName:'确认',
			        okFunction:okF,
			        cancelName:'取消'
			    };
		alert('返回该页,未保存的信息将会丢失 '+'<br>'+'确定返回？',p);
	} else if("cywj"==indexReturn){
		removeAlertWindows("cywj",true);
	}else{
		//URL为空，会自动reload父页面
		if(!checkDataBeforeRunFlow()){
			return false;
		}
		removeAlertWindows(jQuery("#windowsId").val(), false, true, "操作成功", true, '',true);

	}
}



//打开查看历史窗口
function isckls(){
	var busiTypeCode = jQuery("#busiTypeCode").val();
	var template_id = jQuery("#template_id").val();
	var titleName = jQuery("#titleName").val();
	var archiveTitle =  jQuery("#"+titleName).val();
	var p = {
			busi_id : parms.flowParmJson.busi_id,
			ins_id : parms.flowParmJson.ins_id,
			action_form : parms.flowParmJson.action_form,
			title : archiveTitle,
			busiTypeCode:busiTypeCode,
			template_id:template_id
	};
	var path =  jQuery("#path").val()+"/ccapp/oa/archive/findlslist.jsp?windowsId=windowIds&"+jQuery.param(p);
	//jQuery("#webofficDiv").hide();
	openAlertWindows('windowIds',path,'查看历史',810,400,'25%','25%',closeAlertWindow);

}

//显示金格控件
function closeAlertWindow(){
	//jQuery("#webofficDiv").show();
}
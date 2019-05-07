//打印
function printText(){
	webform.WebOffice.WebOpenPrint();
}

//拆分指标文
function opentSplitPage(){
	var ins_id = parms.flowParmJson.ins_id;
	if(typeof ins_id == "undefined" || ins_id == "undefined" || ins_id == ""){
		alert("未取到流程ID，第一个环节不能拆分指标文！");
	} else {
		var file_code = parms.flowParmJson.busi_id;
		file_code = encodeURI(encodeURI(file_code));
		var path =  jQuery("#path").val()+"/ccapp/oa/archive/split/jsp/budgetfileimport.jsp?subid=import_file_from_iweb&bus_id="+ins_id+"&file_code="+file_code;
		jQuery("#webofficDiv").hide();
		openAlertWindows('import_file_from_iweb',path,'指标文拆分',600,450,'25%','25%',closeAlertWindow);
	}
}
//盖章（送公文传输,上传文件，获取ID，然后打开公文传输盖章页面）
function sendToArchive(){
	var hasText = jQuery("#hasText").val();//是否有整理后的正文
	if(hasText=="false"){
		alert("整理之前不可盖章！");
		return ;
	}
	var uuid = "";
	var mRecordID = "text"+do_recordID;
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

//是否公开选择
function isPublicSel(){
	var ins_id = parms.flowParmJson.ins_id;
	var is_open = jQuery("#is_open").val();
	var info_type = jQuery("#info_type").val();
	var url = jQuery("#path").val()+'/ccapp/oa/archive/wordarchive/ispublic.jsp?windowsId=windowIds&ins_id='+ins_id+"&is_public="+is_open+"&info_type="+info_type;
	jQuery("#webofficDiv").hide();
	openAlertWindows('windowIds',url,'信息设置',800,140,'25%','25%',closeAlertWindow);
}
/*//是否信息分类
function isInfotypeSel(){
	var ins_id = parms.flowParmJson.ins_id;
	var info_type = jQuery("#info_type").val();
	var url = jQuery("#path").val()+'/ccapp/oa/archive/wordarchive/isinfotype.jsp?windowsId=windowIds&ins_id='+ins_id+"&info_type="+info_type;
	jQuery("#webofficDiv").hide();
	openAlertWindows('windowIds',url,'信息分类',800,140,'25%','25%',closeAlertWindow);
}*/
//是否督办
function ischief(){
	var ins_id = parms.flowParmJson.ins_id;
	var chief_endtime = jQuery("#chief_endtime").val();
	var url = jQuery("#path").val()+'/ccapp/oa/archive/wordarchive/ischief.jsp?windowsId=windowIds&ins_id='+ins_id+"&chief_endtime="+chief_endtime;
	jQuery("#webofficDiv").hide();
	openAlertWindows('windowIds',url,'督办',600,140,'25%','25%',closeAlertWindow);
}

//保存文件
function saveWord(){
	if(typeof setInputValue == "function"){//如果存在设置隐藏域方法
		  setInputValue();
		  var flag=isTitleNull();
			if(!flag){
				alert("标题不能为空！");
				return false;
			}
	}
	var ins_id = parms.flowParmJson.ins_id;
	if(IsSpace(ins_id)){//如果流程ID为空，那么新建一个流程ID
		parms.flowParmJson.ins_id = Math.uuidCompact();
		doTemp();
	}else{
		doTemp();//如果是二次发起，status_code为04时不会发起流程。common.do 的回调resetOptType 会修改status_code 和 actInsId的值
	}
}

//保存WORD文档
function saveText(){
	var flag = webform.WebOffice.WebSave(true);
	 if (flag){
		 alert("保存成功！");
	 }else{
		 alert("保存失败！");
	}
}

//校对
function jiaodui(){
	var hasText = jQuery("#hasText").val();//是否有整理后的正文
	if(hasText=="false"){
		alert("整理之前不可校对！");
		return ;
	}
	var recordIDs = "text"+do_recordID; 
	var height = window.screen.availHeight;
	var width = window.screen.availWidth;
	var url = jQuery("#path").val()+"/ccapp/oa/archive/iwebofficequery.jsp?windowsId=windowId1&opentype=jiaodui&RecordID="+recordIDs;
	openAlertWindows('windowId2',url,'公文整理',width,height,'0%','0%',closeAlertWindowAndReLoad);
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

//打开内部分送窗口
function isnbfs(){
	var hasText = jQuery("#hasText").val();//是否有整理后的正文
	if(hasText=="false"){
		alert("整理之前不可内部分送！");
		return ;
	}
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
	var path =  jQuery("#path").val()+"/ccapp/oa/archive/circularize.jsp?windowsId=windowIds&"+jQuery.param(p);
	jQuery("#webofficDiv").hide();
	openAlertWindows('windowIds',path,'内部分送',800,145,'25%','25%',closeAlertWindow);

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
	jQuery("#webofficDiv").hide();
	openAlertWindows('windowIds',path,'查看历史',810,400,'25%','25%',closeAlertWindow);

}

//打开分发窗口
function dispenseend(){
	var hasText = jQuery("#hasText").val();//是否有整理后的正文
	if(hasText=="false"){
		alert("整理之前不可分发公文！");
		return ;
	}
	var ins_id = parms.flowParmJson.ins_id;
	var busiTypeCode = jQuery("#busiTypeCode").val();
	var template_id = jQuery("#template_id").val();
	var titleName = jQuery("#titleName").val();
	var archiveTitle =  jQuery("#"+titleName).val();
	var busi_id = parms.flowParmJson.busi_id;
	var mRecordID = "text"+do_recordID;
	//附件处理
	var attach_id_name=jQuery("#attach_id_name").val();//附件ID名称
	if(IsSpace(attach_id_name)){
		alert("没有取到附件ID，请检查WORD模板配置中是否正确配置附件ID！");
		return false;
	}
	var n_attach_id =  jQuery("#"+attach_id_name).val();
	if(IsSpace(n_attach_id)){
		//TODO 如果附件ID为空，回填到attach_id_name 并且传到附件页面
		n_attach_id =  Math.uuidCompact();
		jQuery("#"+attach_id_name).val(n_attach_id);
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
	jQuery("#webofficDiv").hide();
	openAlertWindows('windowIds',path,'公文分发',900,500,'25%','25%',closeAlertWindow);

}

//送后续环节
function sendNext(){
	if(typeof setInputValue == "function"){//如果存在设置隐藏域方法
		var hasText = jQuery("#hasText").val();//是否有整理后的正文
		if(hasText!="true"){
		  setInputValue();
		  var flag=isTitleNull();
			if(!flag){
				alert("标题不能为空！");
				return false;
			}
		}
	}
	var busi_id = jQuery("#busi_id").val();
	
	//短信配置
	var msg_txt_config = jQuery("#msg_txt_config").val(); //获取页面隐藏域里的内容 （此处有问题，如果暂存将无法保存短信配置。）
	var isdxtx = jQuery("#isdxtx").val();
	var isjsxx = jQuery("#isjsxx").val();
	var isyj = jQuery("#isyj").val();
	var isznxx = jQuery("#isznxx").val();
	
	var url = jQuery("#path").val()+'/ccapp/oa/archive/sendnext.jsp?windowsId=windowIds&busi_id='+busi_id+'&msg_txt='+msg_txt_config+'&isdxtx='+isdxtx+'&isjsxx='+isjsxx+'&isyj='+isyj+'&isznxx='+isznxx;
	jQuery("#webofficDiv").hide();
	openAlertWindows('windowIds',url,'送后续环节',800,220,'25%','25%',closeAlertWindow);
}

//回退到指定的环节
function doBackNext(){
	var hasText = jQuery("#hasText").val();//是否有整理后的正文
	if(hasText=="true"){
		alert("整理之后不可回退！");
		return ;
	}
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
		jQuery("#webofficDiv").hide();
		openAlertWindows('windowIds',url,'回退',800,340,'25%','25%',closeAlertWindow);
	}
}

function getParms(){
	alert("获取属性");
}

//打开文档
function queryWord(type){
	var hasText = jQuery("#hasText").val();//是否有整理后的正文
	if(hasText=="false" && (type=="singn"||type == "text")){
		alert("整理之前不可查看面签，或者正文！");
		return false;
	}
	var recordIDs = do_recordID; 
	var EditType = "1,1";//查看原文需要带痕迹
	var titleName = jQuery("#titleName").val();
	var archiveTitle =  jQuery("#"+titleName).val();
	var title = "";
	if(type == "text"){//组装正文ID
		recordIDs = "text"+recordIDs;
		title= "正文（"+archiveTitle+"）";
	}else if(type == "singn"){//组装面签ID
		recordIDs = "singn"+recordIDs;
		title= "面签（"+archiveTitle+"）";
	}else{
		recordIDs = recordIDs;
		EditType = "3,0";
		title= "原文（"+archiveTitle+"）";
	}
	var height = window.screen.availHeight;
	var width = window.screen.availWidth;
	var url = jQuery("#path").val()+"/ccapp/oa/archive/iwebofficequery.jsp?windowsId=windowId1&RecordID="+recordIDs+"&EditType="+EditType+"&mFileName="+title;
	openAlertWindows('windowId2',url,title,width,height,'0%','0%',closeAlertWindow);
}

//整理文档
function doWord(){
	var height = window.screen.availHeight;
	var width = window.screen.availWidth;
	var mTemplateid = jQuery("#mTemplate").val();//模板ID
	var recordIDs = do_recordID; //正文ID
	var url = jQuery("#path").val()+"/ccapp/oa/archive/iweboffice2009.jsp?windowsId=windowId2&RecordID="+recordIDs+"&mTemplateid="+mTemplateid;
	openAlertWindows('windowId2',url,'公文整理',width,height,'0%','0%',closeAlertWindowAndReLoad);

}

//显示控件，并且重新加载
function closeAlertWindowAndReLoad(){
	jQuery("#webofficDiv").show();
	webform.WebOffice.RecordID = "text"+do_recordID;
	webform.WebOffice.EditType = "4,0";//如果整理过后，那么打开是只读
	var flag = webform.WebOffice.WebOpen(false);
    if(flag==false){//如果正文不存在，那么打开原文
    	webform.WebOffice.EditType=jQuery("#mEditType").val();
    	webform.WebOffice.RecordID = do_recordID;		
    	webform.WebOffice.WebOpen(true);//如果原文也没有，那么加载模板
    }else{
    	jQuery("#hasText").val("true");
    }
}

//弹出签名（非控件自带签名）
function wordSing(){
	var hasText = jQuery("#hasText").val();//是否有整理后的正文
	if(hasText=="true"){
		alert("整理之后不可签字！");
		return ;
	}
	var busi_id = jQuery("#busi_id").val();
	var url = jQuery("#path").val()+'/ccapp/oa/archive/wordsign.jsp?windowsId=windowId1&busi_id='+busi_id;
	jQuery("#webofficDiv").hide();
	openAlertWindows('windowId1',url,'签字',800,240,'25%','25%',closeAlertWindow);
}
//签名
function wordSingname(){
	var hasText = jQuery("#hasText").val();//是否有整理后的正文
	if(hasText=="true"){
		alert("整理之后不可签名！");
		return ;
	}
	var username=jQuery("#mUserName").val();
	//window.setSelectionValue(username);
	var iWebOffice = document.getElementsByName("WebOffice")[0];
	var i = iWebOffice.WebObject.Tables.Count;
	var tables = iWebOffice.WebObject.Tables.Item(1);
	if(tables!=null){
		var selection = tables.Application.selection;//获取光标单元格
		selection.Text = selection.Text.replace(/<\?.+?>/g,"").replace(/[\r\n]/g, "")+username;
	}else{
		alert("找不到表格，请把光标放到表格内！");
	}

}

//公文编号
function serialNumber(){
	var busi_id = jQuery("#busi_id").val();
	var url = jQuery("#path").val()+'/ccapp/oa/archive/serialnumber.jsp?windowsId=windowIds&busi_id='+busi_id;
	jQuery("#webofficDiv").hide();
	openAlertWindows('windowIds',url,'公文编号',800,240,'25%','25%',closeAlertWindow);

}

//配置短信
function msgConfig(msg_txt_config){
	var msg_txt  = "";
	msg_txt = jQuery("#msg_txt").val(); //获取页面隐藏域里的内容 （此处有问题，如果暂存将无法保存短信配置。）
	if(IsSpace(msg_txt)){//如果为空，那么加载环节配置里的短信内容
		msg_txt = msg_txt_config;
	}
	var isdxtx = jQuery("#isdxtx").val();
	var isjsxx = jQuery("#isjsxx").val();
	var isyj = jQuery("#isyj").val();
	var isznxx = jQuery("#isznxx").val();
	jQuery("#webofficDiv").hide();
	var url = jQuery("#path").val()+'/ccapp/oa/archive/msgconfig.jsp?windowsId=windowId&msg_txt='+msg_txt+'&isdxtx='+isdxtx+'&isjsxx='+isjsxx+'&isyj='+isyj+'&isznxx='+isznxx
	openAlertWindows('windowId',url,'短信配置',800,240,'25%','25%',closeAlertWindow);
}
//处理附件
function optAttachment(){
	var attach_id_name=jQuery("#attach_id_name").val();//附件ID名称
	if(IsSpace(attach_id_name)){
		alert("没有取到附件ID，请检查WORD模板配置中是否正确配置附件ID！");
		return false;
	}
	var n_attach_id =  jQuery("#"+attach_id_name).val();
	if(IsSpace(n_attach_id)){
		//TODO 如果附件ID为空，回填到attach_id_name 并且传到附件页面
		n_attach_id =  Math.uuidCompact();
		jQuery("#"+attach_id_name).val(n_attach_id);
	}
	var is_attachment=jQuery("#is_attachment").val();//是否处理附件
	jQuery("#webofficDiv").hide();
	openAlertWindows('windowId',jQuery("#path").val()+'/ccapp/oa/archive/optattachment.jsp?windowsId=windowId&n_attach_id='+n_attach_id+"&is_attachment="+is_attachment,'附件信息',800,240,'25%','25%',closeAlertWindow);
}

//处理参阅件
function optAttachment1(){
	var attach_id_name=jQuery("#attach_id_name").val();//附件ID名称
	if(IsSpace(attach_id_name)){
		alert("没有取到附件ID，请检查WORD模板配置中是否正确配置附件ID！");
		return false;
	}
	var n_attach_id =  jQuery("#"+attach_id_name).val();
	if(IsSpace(n_attach_id)){
		//TODO 如果附件ID为空，回填到attach_id_name 并且传到附件页面
		n_attach_id =  Math.uuidCompact();
		jQuery("#"+attach_id_name).val(n_attach_id);
	}
	var is_attachment=jQuery("#is_attachment").val();//是否处理附件
	jQuery("#webofficDiv").hide();
	openAlertWindows('windowId',jQuery("#path").val()+'/ccapp/oa/archive/wordarchive/optattachment1.jsp?windowsId=windowId&n_attach_id='+n_attach_id+"&is_attachment="+is_attachment,'参阅件信息',800,240,'25%','25%',closeAlertWindow);
}

//作用：显示操作状态
function StatusMsg(mString){
  //StatusBar.innerText=mString;
}

function showGaiZhang(){
	webform.WebOffice.AppendTools("11","盖章",24);
}

//作用：退出iWebOffice
function UnLoad(){
  try{
  if (!webform.WebOffice.WebClose()){
     StatusMsg(webform.WebOffice.Status);
  }else{
     StatusMsg("关闭文档...");
  }
  }catch(e){alert(e.description);}
}

//作用：打开文档
function LoadDocument(){
  StatusMsg("正在打开文档...");
  if (!webform.WebOffice.WebOpen()){  	//打开该文档    交互OfficeServer的OPTION="LOADFILE"
     StatusMsg(webform.WebOffice.Status);
  }else{
     StatusMsg(webform.WebOffice.Status);
  }
}

//作用：保存文档
function SaveDocument(){//webform.WebOffice.WebSaveAsHtml()
  //webform.WebOffice.WebSetMsgByName("MyDefine1","自定义变量值1");  //设置变量MyDefine1="自定义变量值1"，变量可以设置多个  在WebSave()时，一起提交到OfficeServer中
  if(webform.WebOffice.WebSave(true) && webform.WebOffice.WebSaveAsHtml()){
	  StatusMsg(webform.WebOffice.Status);
	     return true;
  }else{
	  StatusMsg(webform.WebOffice.Status);
	     return false;
  }
}


//作用：显示或隐藏痕迹[隐藏痕迹时修改文档没有痕迹保留]  true表示隐藏痕迹  false表示显示痕迹
function ShowRevision(mValue){
  if (mValue){
	 webform.WebOffice.WebSetRevision(true,true,false,false);
     //webform.WebOffice.WebShow(true);
     StatusMsg("显示痕迹...");
  }else{
	 webform.WebOffice.WebSetRevision(false,true,false,false);
    // webform.WebOffice.WebShow(false);
     StatusMsg("隐藏痕迹...");
  }
}


//作用：显示或隐藏痕迹[隐藏痕迹时修改文档有痕迹保留]  true表示隐藏痕迹  false表示显示痕迹
function ShowRevision2(mValue){
  if (mValue){
     webform.WebOffice.WebObject.ShowRevisions=true;   //显示痕迹
  }else{
     webform.WebOffice.WebObject.ShowRevisions=false;  //隐藏痕迹
  }
}

//作用：盖公章
function AddOfficialSeal(){
	
	var validatePasswordSql = "select t.stamp_password from jyksy_user_stamp  t where t.user_id='"+jQuery("#user_id").val()+"'";
	var sealPasswordurl = "setusersealpassword.jsp"
		var sealpassword =  window.showModalDialog(sealPasswordurl,"","dialogWidth=326px;dialogHeight=110px;center:yes");
		if(_pub.ajax.SelectSqlAjax(validatePasswordSql) != sealpassword){
			alert("盖章密码不正确!");
			return false;
		}
	var imageName = "jyksy_gz5.gif";
	if(IsSpace(imageName)){
		alert("请选择公章!");
		return false;
	}
	try{
	    webform.WebOffice.WebInsertImage('Image',imageName,true,4);   //交互OfficeServer的OPTION="INSERTIMAGE"  参数1表示标签名称  参数2表示图片文件名  参数3为true透明  false表示不透明  参数4为4表示浮于文字上方  5表示衬于文字下方
	    StatusMsg(webform.WebOffice.Status);
	  }catch(e){alert(e.description);}

}

//作用：获取痕迹
function WebGetRevisions(){
  var Rev = webform.WebOffice.WebObject.Revisions;		//获取痕迹对象
  var Text="";

  for (i = 1;i <= Rev.Count;i++){
    Text=Text +"“"+ Rev.Item(i).Author+"”";
    if (Rev.Item(i).Type=="1"){
      Text=Text + '进行插入：'+Rev.Item(i).Range.Text+"\r\n";
    }else if (Rev.Item(i).Type=="2"){
      Text=Text + '进行删除：'+Rev.Item(i).Range.Text+"\r\n";
    }
	else {
      Text=Text + '进行其他操作，操作内容：“'+Rev.Item(i).Range.Text+ '”；操作：“'+Rev.Item(i).FormatDescription+"”。\r\n";
    }
  }
  alert("痕迹内容：\r\n\r\n"+Text);
}

//作用：刷新文档
function WebReFresh(){
  webform.WebOffice.WebReFresh();
  StatusMsg("文档已刷新...");
}

//作用：打开版本
function WebOpenVersion(){
  webform.WebOffice.WebOpenVersion();  	//交互OfficeServer  列出版本OPTION="LISTVERSION"     调出版本OPTION="LOADVERSION"   <参考技术文档>
  StatusMsg(webform.WebOffice.Status);
}

//作用：保存版本
function WebSaveVersion(){
  webform.WebOffice.WebSaveVersion();  	//交互OfficeServer的OPTION="SAVEVERSION"
  StatusMsg(webform.WebOffice.Status);
}

//作用：保存当前版本
function WebSaveVersionByFileID(){
  var mText=window.prompt("请输入版本说明:","版本号:V");
  if (mText==null){
     mText="已修改版本.";
  }
  webform.WebOffice.WebSaveVersionByFileID(mText);  	//交互OfficeServer的OPTION="SAVEVERSION"  同时带FileID值   <参考技术文档>
  StatusMsg(webform.WebOffice.Status);
}

//作用：填充模板
function LoadBookmarks(){
  StatusMsg("正在填充模扳...");
  if (!webform.WebOffice.WebLoadBookmarks()){  	//交互OfficeServer的OPTION="LOADBOOKMARKS"
     StatusMsg(webform.WebOffice.Status);
  }else{
     StatusMsg(webform.WebOffice.Status);
  }
}

//作用：标签管理
function WebOpenBookMarks(){
  try{
    webform.WebOffice.WebOpenBookmarks();  	//交互OfficeServer的OPTION="LISTBOOKMARKS"
    StatusMsg(webform.WebOffice.Status);
  }catch(e){alert(e.description);}
}

//作用：设置书签值  vbmName:标签名称，vbmValue:标签值   标签名称注意大小写
function SetBookmarks(vbmName,vbmValue){
  if (!webform.WebOffice.WebSetBookmarks(vbmName,vbmValue)){
     StatusMsg(webform.WebOffice.Status);
  }else{
     StatusMsg(webform.WebOffice.Status);
  }
}

//作用：根据标签名称获取标签值  vbmName:标签名称
function GetBookmarks(vbmName){
  var vbmValue;
  vbmValue=webform.WebOffice.WebGetBookmarks(vbmName);
  return vbmValue;
}
//-------------------add套红-----------
/**
**套红模版返回
**/
function backTo2(returnObj){
	 //设置金格控制可用
	 if(typeof(window.parent.editOffice)=="function"){
	    	window.parent.editOffice(webform.WebOffice);
	 }
	if(null != returnObj){//如果选择了套红模板
		var iWebOffice = document.getElementsByName("WebOffice")[0];
		var iWebOffice1=iWebOffice;
		iWebOffice.Template =  returnObj;                           //获取模板编号

		if(iWebOffice.WebLoadTemplate()){                                //加载模板
			try{
				iWebOffice.WebObject.Bookmarks.Item("ti_content").Select();
			}catch(e){}
			if(iWebOffice.WebInsertFile()){                              //插入正文到Content标签
				try{
			    	var webObject = iWebOffice.WebObject;
			    	if(typeof creator_operWebObject == "function"){			    		
			    		creator_operWebObject(webObject);
			    	}
			    	
			    }catch(e){}
				StatusMsg(iWebOffice.Status);
				//fcpubdata.webOfficeHadTaohong = "1";                     //成功套红。
			}else{
				StatusMsg(iWebOffice.Status);
			}

			if (iWebOffice.WebObject.Bookmarks.Exists("ti_fawen_hao")) {
				window.parent.docheckoffice(iWebOffice);
			}
			
		}else{
			StatusMsg(iWebOffice.Status);
		}	
	} 	
}


function wordTemplateTaohong(){
	if(confirm("您确定要套红吗？注意,多次套红不会保存修改的内容!")){
		//modified by zhou.luo in 2008-10-14 套红前不保存文档就可以在第二次套红的时候去掉第一次套的红。
		//modified by zhou.luo 2008-12-09 套红前先设置红头书签为空，再删掉红头。先注释掉                              
		//openAlertWindows('windowId',jQuery("#path").val()+'/ccapp/oa/archive/hhwordtemplateviewlist.jsp?windowsId=windowId','选择套红模版',800,340,'25%','25%',closeAlertWindow);
		openAlertWindows('windowId',jQuery("#path").val()+'/ccapp/oa/archive/thwordtemplateviewlist.jsp?windowsId=windowId','选择套红模版',800,340,'25%','25%',closeAlertWindow);
		//隐藏金格控件
		//jQuery("#webofficDiv").hide();
	}
}
//显示金格控件
function closeAlertWindow(){
	jQuery("#webofficDiv").show();
}
//-------------------end套红-----------
//作用：打印文档
function WebOpenPrint(){
  try{
    webform.WebOffice.WebOpenPrint();
    StatusMsg(webform.WebOffice.Status);
  }catch(e){alert(e.description);}
}


//作用：页面设置
function WebOpenPageSetup(){
   try{
	if (webform.WebOffice.FileType==".doc"){
	  webform.WebOffice.WebObject.Application.Dialogs(178).Show();
	}
	if(webform.WebOffice.FileType==".xls"){
	  webform.WebOffice.WebObject.Application.Dialogs(7).Show();
	}
   }catch(e){alert(e.description);}
}

//作用：插入图片
function WebOpenPicture(){
  try{
    webform.WebOffice.WebOpenPicture();
    StatusMsg(webform.WebOffice.Status);
  }catch(e){alert(e.description);}
}

//作用：签名印章
function WebOpenSignature(){
  //alert("如果你要更安全签章,建议采用金格iSignature电子签章软件进行签章:\r\n下载地址http://www.goldgrid.cn/iSignature/Download.asp\r\n\r\n该软件是支持文档完整性保护、CA证书和数字签名技术的,\r\n是通过了<国家公安部和国家保密局>双重认证的安全电子签章产品!");
  try{
    webform.WebOffice.WebOpenSignature();  	//交互OfficeServer的 A签章列表OPTION="LOADMARKLIST"    B签章调出OPTION="LOADMARKIMAGE"    C确定签章OPTION="SAVESIGNATURE"    <参考技术文档>
    StatusMsg(webform.WebOffice.Status);
  }catch(e){alert(e.description);}
}

//作用：验证印章A
function WebShowSignature(){
  try{
    webform.WebOffice.WebShowSignature();  	//交互OfficeServer的OPTION="LOADSIGNATURE"
    StatusMsg(webform.WebOffice.Status);
  }catch(e){alert(e.description);}
}

//作用：验证印章B
function WebCheckSignature(){
  try{
    var i=webform.WebOffice.WebCheckSignature();  	//交互OfficeServer的OPTION="LOADSIGNATURE"
    alert("检测结果："+i+"\r\n 注释: (=-1 有非法印章) (=0 没有任何印章) (>=1 有多个合法印章)");
    StatusMsg(i);
  }catch(e){alert(e.description);}
}

//作用：存为本地文件
function WebSaveLocal(){
  try{
    webform.WebOffice.WebSaveLocal();
    StatusMsg(webform.WebOffice.Status);
  }catch(e){alert(e.description);}
}

//作用：打开本地文件
function WebOpenLocal(){  
  try{
    webform.WebOffice.WebOpenLocal();
    StatusMsg(webform.WebOffice.Status);
  }catch(e){alert(e.description);}
}

//作用：保存为HTML文档
function WebSaveAsHtml(){
  try{
    if (webform.WebOffice.WebSaveAsHtml())  	//交互OfficeServer的OPTION="SAVEASHTML"
    {
      webform.HTMLPath.value="HTML/"+jQuery("#mRecordID").val()+".htm";
      window.open(jQuery("#mHttpUrl").val()+ webform.HTMLPath.value);
    }
    StatusMsg(webform.WebOffice.Status);
  }catch(e){alert(e.description);}
}


//作用：保存为文档图片
function WebSaveAsPage(){
  try{
    if (webform.WebOffice.WebSaveImage())  	//交互OfficeServer的OPTION="SAVEIMAGE"
    {
      webform.HTMLPath.value="HTMLIMAGE/"+jQuery("#mRecordID").val()+".htm";
      window.open(jQuery("#mHttpUrl").val()+ webform.HTMLPath.value);
    }
    StatusMsg(webform.WebOffice.Status);
  }catch(e){alert(e.description);}
}


//作用：关闭或显示工具 参数1表示工具条名称  参数2为false时，表示关闭  （名称均可查找VBA帮助）
//参数2为true时，表示显示
function WebToolsVisible(ToolName,Visible){
  try{
    webform.WebOffice.WebToolsVisible(ToolName,Visible);
    StatusMsg(webform.WebOffice.Status);
  }catch(e){alert(e.description);}
}


//作用：禁止或启用工具 参数1表示工具条名称  参数2表示工具条铵钮的编号  （名称和编号均可查找VBA帮助）
//参数3为false时，表示禁止  参数3为true时，表示启用
function WebToolsEnable(ToolName,ToolIndex,Enable){
  try{
    webform.WebOffice.WebToolsEnable(ToolName,ToolIndex,Enable);
    StatusMsg(webform.WebOffice.Status);
  }catch(e){alert(e.description);}
}

//作用：保护与解除  参数1为true表示保护文档  false表示解除保护
function WebProtect(value){
  try{
    webform.WebOffice.WebSetProtect(value,"");  //""表示密码为空
  }catch(e){alert(e.description);}
}

//作用：允许与禁止拷贝功能  参数1为true表示允许拷贝  false表示禁止拷贝
function WebEnableCopy(value){
  try{
    webform.WebOffice.CopyType=value;
  }catch(e){alert(e.description);}
}


//作用：插入远程服务器图片
function WebInsertImage(){
  try{
    webform.WebOffice.WebInsertImage('Image','GoldgridLogo.jpg',true,4);   //交互OfficeServer的OPTION="INSERTIMAGE"  参数1表示标签名称  参数2表示图片文件名  参数3为true透明  false表示不透明  参数4为4表示浮于文字上方  5表示衬于文字下方
    StatusMsg(webform.WebOffice.Status);
  }catch(e){alert(e.description);}
}


//作用：下载服务器文件到本地
function WebGetFile(){
  if (webform.WebOffice.WebGetFile("c:\\WebGetFile.doc","DownLoad.doc")){   //交互OfficeServer的OPTION="GETFILE"  参数1表示本地路径  参数2表示服务器文件名称
    StatusMsg(webform.WebOffice.Status);
  }else{
    StatusMsg(webform.WebOffice.Status);
  }
  alert(webform.WebOffice.Status+"\r\n"+"文件放在c:\\WebGetFile.doc");
}


//作用：上传本地文件到服务器
function WebPutFile(){
  var mLocalFile=webform.WebOffice.WebOpenLocalDialog();
  if (mLocalFile!=""){
    alert(mLocalFile);
    if (webform.WebOffice.WebPutFile(mLocalFile,"Test.doc")){   //交互OfficeServer的OPTION="PUTFILE"  参数1表示本地路径，可以任何格式文件  参数2表示服务器文件名称
      StatusMsg(webform.WebOffice.Status);
    }else{
      StatusMsg(webform.WebOffice.Status);
    }
    alert(webform.WebOffice.Status);
  }
}


//作用：打开远程文件
function WebDownLoadFile(){
  mResult=webform.WebOffice.WebDownLoadFile("http://www.goldgrid.com/Images/abc.doc","c:\\abc.doc");
  if (mResult){
    webform.WebOffice.WebOpenLocalFile("c:\\abc.doc");
    alert("成功");
  }else{
    alert("失败");
  }
}

//作用：取得服务器端时间，设置本地时间  [V6.0.1.5以上支持]
function WebDateTime(){
  mResult=webform.WebOffice.WebDateTime(true);   //交互OfficeServer的OPTION="DATETIME"   true表示返回并设置本地时间为服务器时间；false表示仅返回服务器时间
  alert("提示：已经设置本地时间为 "+mResult);    //该功能主要用于在痕迹保留时读取服务器时间
}


//作用：表格生成及填充
function WebSetWordTable(){
  var mText="",mName="",iColumns,iCells,iTable;
  //设置COMMAND为WORDTABLE
  webform.WebOffice.WebSetMsgByName("COMMAND","WORDTABLE");   //设置变量COMMAND="WORDTABLE"，在WebSendMessage()时，一起提交到OfficeServer中
  //发送到服务器上
  //如果没有错误
  if (webform.WebOffice.WebSendMessage()){                //交互OfficeServer的OPTION="SENDMESSAGE"
	iColumns = webform.WebOffice.WebGetMsgByName("COLUMNS");  //取得列
	iCells = webform.WebOffice.WebGetMsgByName("CELLS");      //取得行
	iTable=webform.WebOffice.WebObject.Tables.Add(webform.WebOffice.WebObject.Application.Selection.Range,iCells,iColumns);   //生成表格
	for (var i=1; i<=iColumns; i++)
	{
   	  for (var j=1; j<=iCells; j++)
	  {
		mName=i.toString()+j.toString();
		mText=webform.WebOffice.WebGetMsgByName(mName);	 //取得OfficeServer中的表格内容
		iTable.Columns(i).Cells(j).Range.Text=mText;   	//填充单元值
	   }
	}
   }
   StatusMsg(webform.WebOffice.Status);
}


//作用：获取文档Txt正文
function WebGetWordContent(){
  try{
    alert(webform.WebOffice.WebObject.Content.Text);
  }catch(e){alert(e.description);}
}

//作用：写Word内容
function WebSetWordContent(){
  var mText=window.prompt("请输入内容:","测试内容");
  if (mText==null){
     return (false);
  }
  else
  {
     //下面为显示选中的文本
     //alert(webform.WebOffice.WebObject.Application.Selection.Range.Text);
     //下面为在当前光标出插入文本
     webform.WebOffice.WebObject.Application.Selection.Range.Text= mText+"\n";
     //下面为在第一段后插入文本
     //webform.WebOffice.WebObject.Application.ActiveDocument.Range(1).Text=(mText);
  }
}


//作用：打印黑白文档
function WebWordPrintBlackAndWhile(){
   var i,n;

   //图片变黑白
   i=0;
   n=webform.WebOffice.WebObject.Shapes.Count;
   for (var i=1; i<=n; i++)
   {
      webform.WebOffice.WebObject.Shapes.Item(i).PictureFormat.ColorType=3;
   }
   i=0;
   n=webform.WebOffice.WebObject.InlineShapes.Count;
   for (var i=1; i<=n; i++)
   {
      webform.WebOffice.WebObject.InlineShapes.Item(i).PictureFormat.ColorType=3;
   }

   //文字变黑白
   webform.WebOffice.WebObject.Application.Selection.WholeStory();
   webform.WebOffice.WebObject.Application.Selection.Range.Font.Color = 0;
}

//作用：用Excel求和
function WebGetExcelContent(){
    webform.WebOffice.WebObject.Application.Sheets(1).Select;
    webform.WebOffice.WebObject.Application.Range("C5").Select;
    webform.WebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "126";
    webform.WebOffice.WebObject.Application.Range("C6").Select;
    webform.WebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "446";
    webform.WebOffice.WebObject.Application.Range("C7").Select;
    webform.WebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "556";
    webform.WebOffice.WebObject.Application.Range("C5:C8").Select;
    webform.WebOffice.WebObject.Application.Range("C8").Activate;
    webform.WebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "=SUM(R[-3]C:R[-1]C)";
    webform.WebOffice.WebObject.Application.Range("D8").Select;
    alert(webform.WebOffice.WebObject.Application.Range("C8").Text);
}


//作用：保护工作表单元
function WebSheetsLock(){
    webform.WebOffice.WebObject.Application.Sheets(1).Select;

    webform.WebOffice.WebObject.Application.Range("A1").Select;
    webform.WebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "产品";
    webform.WebOffice.WebObject.Application.Range("B1").Select;
    webform.WebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "价格";
    webform.WebOffice.WebObject.Application.Range("C1").Select;
    webform.WebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "详细说明";
    webform.WebOffice.WebObject.Application.Range("D1").Select;
    webform.WebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "库存";
    webform.WebOffice.WebObject.Application.Range("A2").Select;
    webform.WebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "书签";
    webform.WebOffice.WebObject.Application.Range("A3").Select;
    webform.WebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "毛笔";
    webform.WebOffice.WebObject.Application.Range("A4").Select;
    webform.WebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "钢笔";
    webform.WebOffice.WebObject.Application.Range("A5").Select;
    webform.WebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "尺子";

    webform.WebOffice.WebObject.Application.Range("B2").Select;
    webform.WebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "0.5";
    webform.WebOffice.WebObject.Application.Range("C2").Select;
    webform.WebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "樱花";
    webform.WebOffice.WebObject.Application.Range("D2").Select;
    webform.WebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "300";

    webform.WebOffice.WebObject.Application.Range("B3").Select;
    webform.WebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "2";
    webform.WebOffice.WebObject.Application.Range("C3").Select;
    webform.WebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "狼毫";
    webform.WebOffice.WebObject.Application.Range("D3").Select;
    webform.WebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "50";

    webform.WebOffice.WebObject.Application.Range("B4").Select;
    webform.WebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "3";
    webform.WebOffice.WebObject.Application.Range("C4").Select;
    webform.WebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "蓝色";
    webform.WebOffice.WebObject.Application.Range("D4").Select;
    webform.WebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "90";

    webform.WebOffice.WebObject.Application.Range("B5").Select;
    webform.WebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "1";
    webform.WebOffice.WebObject.Application.Range("C5").Select;
    webform.WebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "20cm";
    webform.WebOffice.WebObject.Application.Range("D5").Select;
    webform.WebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "40";

    //保护工作表
    webform.WebOffice.WebObject.Application.Range("B2:D5").Select;
    webform.WebOffice.WebObject.Application.Selection.Locked = false;
    webform.WebOffice.WebObject.Application.Selection.FormulaHidden = false;
    webform.WebOffice.WebObject.Application.ActiveSheet.Protect(true,true,true);

    alert("已经保护工作表，只有B2-D5单元格可以修改。");
}

//作用：VBA套红
function WebInsertVBA(){

	//画线
	var object=webform.WebOffice.WebObject;
	var myl=object.Shapes.AddLine(100,60,305,60)
	myl.Line.ForeColor=255;
	myl.Line.Weight=2;
	var myl1=object.Shapes.AddLine(326,60,520,60)
	myl1.Line.ForeColor=255;
	myl1.Line.Weight=2;

	//object.Shapes.AddLine(200,200,450,200).Line.ForeColor=6;
   	var myRange=webform.WebOffice.WebObject.Range(0,0);
	myRange.Select();

	var mtext="★";
	webform.WebOffice.WebObject.Application.Selection.Range.InsertAfter (mtext+"\n");
   	var myRange=webform.WebOffice.WebObject.Paragraphs(1).Range;
   	myRange.ParagraphFormat.LineSpacingRule =1.5;
   	myRange.font.ColorIndex=6;
   	myRange.ParagraphFormat.Alignment=1;
   	myRange=webform.WebOffice.WebObject.Range(0,0);
	myRange.Select();
	mtext="金格发[２００３]１５４号";
	webform.WebOffice.WebObject.Application.Selection.Range.InsertAfter (mtext+"\n");
	myRange=webform.WebOffice.WebObject.Paragraphs(1).Range;
	myRange.ParagraphFormat.LineSpacingRule =1.5;
	myRange.ParagraphFormat.Alignment=1;
	myRange.font.ColorIndex=1;

	mtext="金格电子政务文件";
	webform.WebOffice.WebObject.Application.Selection.Range.InsertAfter (mtext+"\n");
	myRange=webform.WebOffice.WebObject.Paragraphs(1).Range;
	myRange.ParagraphFormat.LineSpacingRule =1.5;

	//myRange.Select();
	myRange.Font.ColorIndex=6;
	myRange.Font.Name="仿宋_GB2312";
	myRange.font.Bold=true;
	myRange.Font.Size=50;
	myRange.ParagraphFormat.Alignment=1;

	//myRange=myRange=webform.WebOffice.WebObject.Paragraphs(1).Range;
	webform.WebOffice.WebObject.PageSetup.LeftMargin=70;
	webform.WebOffice.WebObject.PageSetup.RightMargin=70;
	webform.WebOffice.WebObject.PageSetup.TopMargin=70;
	webform.WebOffice.WebObject.PageSetup.BottomMargin=70;
}

//作用：套用模版定稿
function WebInsertFile(){
  var mDialogUrl = "Template/TemplateForm.jsp";
  var mObject = new Object();
      mObject.Template = "";
      window.showModalDialog(mDialogUrl, mObject, "dialogHeight:200px; dialogWidth:360px;center:yes;scroll:no;status:no;");

  //判断用户是否选择模板
  if (mObject.Template==""){
    StatusMsg("取消套用模");
    return false;
  }else{
    SaveDocument();    //保存当前编辑的文档
    webform.WebOffice.WebSetMsgByName("COMMAND","INSERTFILE");   //设置变量COMMAND="INSERTFILE"，在WebLoadTemplate()时，一起提交到OfficeServer中     <参考技术文档>
    webform.WebOffice.Template=mObject.Template;                 //全局变量Template赋值，此示例读取服务器目录中模板，如读取数据库中模板，Template值为数据库中的模板编号，则上句代码不需要，如Template="1050560363767"，模板名称为“Word公文模板”，注：模板中有要标签Content，区分大小写，可以自行修改
    if (webform.WebOffice.WebLoadTemplate()){                    //交互OfficeServer的OPTION="LOADTEMPLATE"
       //SetBookmarks("Title","关于中间件研发工作会议通知");     //填充模板其它基本信息，如标题，主题词，文号，主送机关等
       if (webform.WebOffice.WebInsertFile()){                   //填充公文正文   交互OfficeServer的OPTION="INSERTFILE"
         StatusMsg(webform.WebOffice.Status);
       }else{
         StatusMsg(webform.WebOffice.Status);
       }
    }else{
       StatusMsg(webform.WebOffice.Status);
    }
  }
}

//作用：保存定稿文件
function WebUpdateFile(){
  if (webform.WebOffice.WebUpdateFile()){                //交互OfficeServer的OPTION="UPDATEFILE"，类似WebSave()或WebSaveVersion()方法
     StatusMsg(webform.WebOffice.Status);
  }else{
     StatusMsg(webform.WebOffice.Status);
  }
}



//打印份数控制
function WebCopysCtrlPrint(){
	try{
	  var mCopies,objPrint;
	  objPrint = webform.WebOffice.WebObject.Application.Dialogs(88);     //打印设置对话框
	  if (objPrint.Display==-1){
	    mCopies=objPrint.NumCopies;    //取得需要打印份数
	    webform.WebOffice.WebSetMsgByName("COMMAND","COPIES");
	    webform.WebOffice.WebSetMsgByName("OFFICEPRINTS",mCopies.toString());   //设置变量OFFICEPRINTS的值，在WebSendMessage()时，一起提交到OfficeServer中
	    webform.WebOffice.WebSendMessage();                               //交互OfficeServer的OPTION="SENDMESSAGE"
	    if (webform.WebOffice.Status=="1") {
	      alert("可以允许打印，注：该实例设置总文档打印份数2份");
	      objPrint.Execute;
	    }else{
	      alert("已超出允许的打印份数");
	      return false;
	    }
	  }
	}catch(e){alert(e.description);}
}


//作用：导入Text
function WebInportText(){
    var mText;
    webform.WebOffice.WebSetMsgByName("COMMAND","INPORTTEXT");  //设置变量COMMAND="INPORTTEXT"，在WebSendMessage()时，一起提交到OfficeServer中
    if (webform.WebOffice.WebSendMessage()){                    //交互OfficeServer的OPTION="SENDMESSAGE"
      mText=webform.WebOffice.WebGetMsgByName("CONTENT");       //取得OfficeServer传递的变量CONTENT值
      webform.WebOffice.WebObject.Application.Selection.Range.Text=mText;
      alert("导入文本成功");
    }
    StatusMsg(webform.WebOffice.Status);
}


//作用：导出Text
function WebExportText(){
    var mText=webform.WebOffice.WebObject.Content.Text;
    webform.WebOffice.WebSetMsgByName("COMMAND","EXPORTTEXT");  //设置变量COMMAND="EXPORTTEXT"，在WebSendMessage()时，一起提交到OfficeServer中
    webform.WebOffice.WebSetMsgByName("CONTENT",mText);         //设置变量CONTENT="mText"，在WebSendMessage()时，一起提交到OfficeServer中，可用于实现全文检索功能，对WORD的TEXT内容进行检索
    if (webform.WebOffice.WebSendMessage()){                    //交互OfficeServer的OPTION="SENDMESSAGE"
      alert("导出文本成功");
    }
    StatusMsg(webform.WebOffice.Status);
}


//作用：获取文档页数
function WebDocumentPageCount(){
    if (webform.WebOffice.FileType==".doc"){
	var intPageTotal = webform.WebOffice.WebObject.Application.ActiveDocument.BuiltInDocumentProperties(14);
	alert("文档页总数："+intPageTotal);
    }
    if (webform.WebOffice.FileType==".wps"){
	var intPageTotal = webform.WebOffice.WebObject.PagesCount();
	alert("文档页总数："+intPageTotal);
    }
}

//作用：签章锁定文件功能
function WebSignatureAtReadonly(){
  webform.WebOffice.WebSetProtect(false,"");                  //解除文档保护
  webform.WebOffice.WebSetRevision(false,false,false,false);  //设置文档痕迹保留的状态  参数1:不显示痕迹  参数2:不保留痕迹  参数3:不打印时有痕迹  参数4:不显痕迹处理工具
  try{
    webform.WebOffice.WebOpenSignature();                     //交互OfficeServer的 A签章列表OPTION="LOADMARKLIST"    B签章调出OPTION="LOADMARKIMAGE"    C确定签章OPTION="SAVESIGNATURE"    <参考技术文档>    文档中要定义标签Manager，可以自行修改标签名称
    StatusMsg(webform.WebOffice.Status);
  }catch(e){alert(e.description);}
  webform.WebOffice.WebSetProtect(true,"");                   //锁定文档
}

//作用：客户端和服务器端信息信息交互
function WebSendInformation(){
  var info = window.prompt("请输入要传到服务器处理页面上的内容:","参数内容");
  if (info==null){return false}

  webform.WebOffice.WebSetMsgByName("COMMAND","SELFINFO");		//设置变量COMMAND="SELFINFO"，用来在服务器端做判断，以进入处理自定义参数传递的代码。
  webform.WebOffice.WebSetMsgByName("TESTINFO",info);			//自定义的一个参数"TESTINFO"，将info变量的信息设置到信息包中，以便传到后台。
  if (webform.WebOffice.WebSendMessage()){						//向后台发信息包。交互OfficeServer的OPTION="SENDMESSAGE"。
    info = webform.WebOffice.WebGetMsgByName("RETURNINFO");		//如果交互成功，接受服务器端返回的信息。
	alert(info);
  }
  else{
    StatusMsg(webform.WebOffice.Status);
  }
}

var wordiwebofficeJS = {};

wordiwebofficeJS.changeHtmlObjVal = function(objId,val){
	tmp= jQuery("#"+objId);
	if(tmp.size()==1){
		tmp.val(val);
	}else{
		alert("Element["+objId+"] undefined");
	}
};

//流程发起功能JS
wordiwebofficeJS.doFlowInFlow = {
	//初始化 在流程中发起的新流程
	initFlowInFlow:function(webform,do_recordID){
		////_fmb:在FlowMoveBean.java(createJsCode)申明
		if(typeof(_fmb)=="undefined"){
			return;
		}
		try{
			var isStartAdd = jQuery("#"+_fmb.isStartAdd).val();
			if(webform&&isStartAdd==="Y"){
				//0,read config
				var fmb_config = jQuery("#"+_fmb.fmb_config).val();
				if(!fmb_config){
					fmb_config = "1,1,1";
				}
				fmb_config = fmb_config.split(",");
				if(fmb_config[0]=="1"){
					//写入正文
					var textIdZW = jQuery("#"+_fmb.textIdZW).val();
					var textIdYW = jQuery("#"+_fmb.textIdYW).val();
					if(textIdZW){
						if(!do_recordID){
							do_recordID = jQuery("#mRecordID").val();
						}
						officeObj = webform.WebOffice;
						officeObj.RecordID = textIdZW;
						officeObj.WebInsertFile();
						officeObj.RecordID = do_recordID;
					}else{//如果没有正文，那么将原文查到指定位置
						if(!do_recordID){
							do_recordID = jQuery("#mRecordID").val();
						}
						officeObj = webform.WebOffice;
						officeObj.RecordID = textIdYW;
						officeObj.WebInsertFile();
						officeObj.RecordID = do_recordID;
					}
				}
				if(fmb_config[1]=="1"){
					//2向表格中添加数据
					var flowTitle = jQuery("#"+_fmb.flowTitle).val();
					if(typeof(selectTextInput)==="function"){
						var titleLocal = jQuery("#titleLocal").val();
						selectTextInput(titleLocal,flowTitle);
					}
				}
				if(fmb_config[2]=="1"){
					//3转移附件
					var oldAttachId = jQuery("#"+_fmb.oldAttachId).val();//原流程附件ID
					var textIdYW = jQuery("#"+_fmb.textIdYW).val();
					var textIdMQ = jQuery("#"+_fmb.textIdMQ).val();
					var textIdZBD = jQuery("#"+_fmb.textIdZBD).val();
					var attach_id = "";
					var attach_id_name=jQuery("#attach_id_name").val();//当前流程配置的存放附件ID位置的ID=attach_id_name
					if(attach_id_name){
						//3.1:获得当前流程附件
						attach_id = jQuery("#"+attach_id_name).val();
						if(!attach_id){
							attach_id = Math.uuidCompact();
							jQuery("#"+attach_id_name).val(attach_id);
						}
						
						//3.2:转移附件(原文,正文)
						var ajaxurl=jQuery("#path").val()+"/ccapp/oa/archive/wordarchive/sendtoarchivedo.jsp"
						var params = {'attach_id':attach_id
							,'flowTitle':flowTitle
							,'oldAttachId':oldAttachId
							,'textIdYW':textIdYW
							,'textIdMQ':textIdMQ
							,'textIdZBD':textIdZBD
							,'optType':'initFlowInFlow'};
						jQuery.ajax({
							url: ajaxurl,
							type: 'POST',
							dataType:'json',
							data: params,
							async:false,
							success: function(data){
								if(data&&data.attachNameList){
									fetchAttachMess(data.attachNameList);
								}
							},
							error: function(jqXHR, textStatus, errorThrown){
							}
						});
				}
				}
				//4转移其他 通过:oldInsId
				parms.flowParmJson.parent_ins_id = jQuery("#"+_fmb.oldInsId).val();
			}
		}catch(e){alert("初始化流程中启动的流程时,脚本错误");}
	},
	newFlowFnBody:function(){
		//_fmb:在FlowMoveBean.java(createJsBean)申明
		if(typeof(_fmb)=="undefined"){
			return;
		}
		//1:定义参数
		var textIdYW = "";
		var textIdZW = "";
		var textIdMQ = "";
		var textIdZBD = "";
		var flowTitle = "";
		var docNo = ""; //TODO 未完成
		var oldInsId = "";
		var oldAttachId = "";
		//2:整理参数
		//2.1 原文 正文 面签 ID
		var do_recordID = jQuery("#mRecordID").val();
		if(do_recordID){
			textIdYW = do_recordID;//2.1.1
			var hasText = jQuery("#hasText").val();//2.1.2
			if(hasText=="true"){
				textIdZW = "text" + textIdYW;
			}
			var hasTextMQ = jQuery("#hasTextMQ").val();//2.1.3
			if(hasTextMQ=="true"){
				textIdMQ = "singn" + textIdYW;
			}
			var hasTextZBD = jQuery("#hasTextZBD").val();//2.1.3
			if(hasTextZBD=="true"){
				textIdZBD = "zb_" + textIdYW;
			}
		}
		//2.2 标题
		var titleName = jQuery("#titleName").val();
		if(titleName){
			var archiveTitle = jQuery("#"+titleName).val();
			if(archiveTitle){
				flowTitle = archiveTitle;
			}
		}
		//2.3 附件
		var attach_id_name=jQuery("#attach_id_name").val();
		if(attach_id_name){
			var attach_id = jQuery("#"+attach_id_name).val();
			if(attach_id){
				oldAttachId = attach_id;
			}
		}
		//2.4 流程ID
		var ins_id = parms.flowParmJson.ins_id;
		if(ins_id){
			oldInsId = ins_id;
		}
		
		//3
		var path = [
			jQuery("#path").val()+"/ccapp/oa/archive/newflowmain.jsp",
			"?windowsId=windowIds1",
			"&"+_fmb.isStartAdd+"=Y",
			"&"+_fmb.textIdYW+"="+textIdYW,
			"&"+_fmb.textIdZW+"="+textIdZW,
			"&"+_fmb.textIdMQ+"="+textIdMQ,
			"&"+_fmb.textIdZBD+"="+textIdZBD,
			"&"+_fmb.flowTitle+"="+flowTitle,
			"&"+_fmb.docNo+"="+docNo,
			"&"+_fmb.oldInsId+"="+oldInsId,
			"&"+_fmb.oldAttachId+"="+oldAttachId
		];
		
		openAlertWindows('windowIds1',path.join(''),'选择重新发起的流程',900,480,'25%','25%',wordiwebofficeJS.doFlowInFlow.closeAlertWindow);
		jQuery("#webofficDiv").hide();
	},
	//点击"流程发起"事件处理
	newFlow:function(){
		var oldInsId = parms.flowParmJson.ins_id;
		if(oldInsId){
			this.newFlowFnBody();
		}else{
			alert("当前流程还没发起,新流程将无法与当前流程关联,确定发起新流程吗？",{
				headerText:'提示',
				okName:'确认',
		        okFunction:function(){
		        	wordiwebofficeJS.doFlowInFlow.newFlowFnBody();
		        },
		        cancelName:'取消'
			});
		}
	},
	//当关闭选择列表页面后，显示
	closeAlertWindow:function(){
		jQuery("#webofficDiv").show();
	},
	//当关闭选择列表页面后，显示
	newFlowWindowClose:function(){
		var okF = function() {
			jQuery("#webofficDiv").show();
			//组装调用办结流程
			if(typeof setInputValue == "function"){//如果存在设置隐藏域方法
				  setInputValue();
				  var flag=isTitleNull();
					if(!flag){
						alert("标题不能为空！");
						return false;
					}
			}
			var busi_id = jQuery("#busi_id").val();
			
			//短信配置
			var msg_txt_config = jQuery("#msg_txt_config").val(); //获取页面隐藏域里的内容 （此处有问题，如果暂存将无法保存短信配置。）
			var isdxtx = jQuery("#isdxtx").val();
			var isjsxx = jQuery("#isjsxx").val();
			var isyj = jQuery("#isyj").val();
			var isznxx = jQuery("#isznxx").val();
			var url = jQuery("#path").val()+'/ccapp/oa/archive/sendnext.jsp?windowsId=windowIds&busi_id='+busi_id+'&msg_txt='+msg_txt_config+'&isdxtx='+isdxtx+'&isjsxx='+isjsxx+'&isyj='+isyj+'&isznxx='+isznxx+'&ins_id='+ parms.flowParmJson.ins_id+"&nextAct=banjie";
			jQuery("#webofficDiv").hide();
			openAlertWindows('windowIds',url,'送后续环节',800,220,'25%','25%',closeAlertWindow);
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
		alert("您确定要自动办结该流程吗？",p);
	}
};
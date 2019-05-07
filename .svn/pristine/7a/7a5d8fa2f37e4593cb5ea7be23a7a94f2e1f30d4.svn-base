
//客户端转CEB，然后将CEB，附件打包，调用公文传输系统的发送接口
function save(){
	var send_org_name = jQuery("#send_org_name").val();
	if(IsSpace(send_org_name)){
		alert("请选择要分发的单位！");
		return false;
	}
	var ajaxurl="sendtoarchivedo.jsp";
	var ins_id = jQuery("#ins_id").val();
	var busi_id = jQuery("#busi_id").val();
	var mRecordID = jQuery("#mRecordID").val();
	var n_attach_id = jQuery("#n_attach_id").val();
	var params = {'ins_id':ins_id,'busi_id':busi_id,'optType':'toTempFile','mRecordID':mRecordID,'n_attach_id':n_attach_id};
	//TODO 转换CEB，将附件放入零时文件夹
	jQuery.ajax({//AJAX将WORD正文上传至公文传输
		url: ajaxurl,
		type: 'POST',
		dataType:'json',
		data: params,
		async:false,
		success: function(data){
			alert("转CEB成功！");
			if(data.flag){//如果附件，正文读取到磁盘成功转CEB
				if(TransUpload()){
					//如果转CEB成功
					//保存公文要素
					var params1 = {'ins_id':ins_id,'busi_id':busi_id,'title':jQuery("#title").val(),'optType':'saveArchiveInfo','mRecordID':mRecordID,
							      'caption':jQuery("#caption").val(),'urgency_grade':jQuery("#urgency_grade").val(),'archive_no':jQuery("#archive_no").val(),
							      'dispatch_type':jQuery("#dispatch_type").val(),'key_word':jQuery("#key_word").val(),'effect_date':jQuery("#effect_date").val(),
							      'sender':jQuery("#sender").val(),'secrecy_grade':jQuery("#secrecy_grade").val(),'send_org_id':jQuery("#send_org_id").val(),
							      'send_org_addr':jQuery("#send_org_addr").val(),'send_org_name':send_org_name,'send_attach_id':n_attach_id,
							      'create_date':jQuery("#create_date").val(),'is_sned_attach':jQuery("#is_sned_attach").val(),'isdxtx':jQuery("#isdxtx").val(),
							      'msg_txt':jQuery("#msg_txt").val(),'union_archive':jQuery("#union_archive").val(),'remark1':jQuery("#remark1").val(),'gwcs_address':jQuery("#gwcs_address").val()
								  };
					jQuery.ajax({//AJAX将WORD正文上传至公文传输
						url: ajaxurl,
						type: 'POST',
						dataType:'json',
						data: params1,
						async:false,
						success: function(data){
							if(data.returnStr=="RES000"){
								alert("分发成功！");
							}else{
								alert("分发失败！错误代码"+data.returnStr);
							}
							
						},
						error: function(jqXHR, textStatus, errorThrown){
							alert("分发失败！")
						}
					});
				}
			}
		},
		error: function(jqXHR, textStatus, errorThrown){
			alert("将正文，附件移动到磁盘失败！")
		}
	});
}

//客户端转CEB，然后将CEB，附件打包，调用公文传输系统的发送接口
function snedWordToArchive(){
	var send_org_name = jQuery("#send_org_name").val();
	if(IsSpace(send_org_name)){
		alert("请选择要分发的单位！");
		return false;
	}
	var ajaxurl="sendtoarchivedo.jsp";
	var ins_id = jQuery("#ins_id").val();
	var busi_id = jQuery("#busi_id").val();
	var mRecordID = jQuery("#mRecordID").val();
	var n_attach_id = jQuery("#n_attach_id").val();
	var params = {'ins_id':ins_id,'busi_id':busi_id,'optType':'toTempFile','mRecordID':mRecordID,'n_attach_id':n_attach_id};
	jQuery.ajax({//AJAX将WORD正文上传至公文传输
		url: ajaxurl,
		type: 'POST',
		dataType:'json',
		data: params,
		async:false,
		success: function(data){
			if(data.flag){//如果附件，正文读取到磁盘成功转CEB
				//if(TransUpload()){
					//保存公文要素
					var params1 = {'ins_id':ins_id,'busi_id':busi_id,'title':jQuery("#title").val(),'optType':'saveArchiveInfo','mRecordID':mRecordID,
							      'caption':jQuery("#caption").val(),'urgency_grade':jQuery("#urgency_grade").val(),'archive_no':jQuery("#archive_no").val(),
							      'dispatch_type':jQuery("#dispatch_type").val(),'key_word':jQuery("#key_word").val(),'effect_date':jQuery("#effect_date").val(),
							      'sender':jQuery("#sender").val(),'secrecy_grade':jQuery("#secrecy_grade").val(),'send_org_id':jQuery("#send_org_id").val(),
							      'send_org_addr':jQuery("#send_org_addr").val(),'send_org_name':send_org_name,'send_attach_id':n_attach_id,
							      'create_date':jQuery("#create_date").val(),'is_sned_attach':jQuery("#is_sned_attach").val(),'isdxtx':jQuery("#isdxtx").val(),
							      'msg_txt':jQuery("#msg_txt").val(),'union_archive':jQuery("#union_archive").val(),'remark1':jQuery("#remark1").val(),'gwcs_address':jQuery("#gwcs_address").val()
								  };
					jQuery.ajax({//AJAX将WORD正文上传至公文传输
						url: ajaxurl,
						type: 'POST',
						dataType:'json',
						data: params1,
						async:false,
						success: function(data){
							if(data.returnStr=="RES000"){
								alert("分发成功！");
							}else{
								alert("分发失败！错误代码"+data.returnStr);
							}
						},
						error: function(jqXHR, textStatus, errorThrown){
							alert("分发失败！")
						}
					});
			//}
			}
		},
		error: function(jqXHR, textStatus, errorThrown){
			alert("将正文，附件移动到磁盘失败！")
		}
	});
}

//上传WORD，如果上传成功保存公文要素，然后调用公文盖章页面，盖章成功公文回调OA，发起公文。
function sendArchive(){
	var send_org_name = jQuery("#send_org_name").val();
	if(IsSpace(send_org_name)){
		alert("请选择要分发的单位！");
		return false;
	}
	var ajaxurl="sendtoarchivedo.jsp";
	var ins_id = jQuery("#ins_id").val();
	var busi_id = jQuery("#busi_id").val();
	var mRecordID = jQuery("#mRecordID").val();
	var n_attach_id = jQuery("#n_attach_id").val();
	var params = {'ins_id':ins_id,'busi_id':busi_id,'title':jQuery("#title").val(),'optType':'saveArchiveServer','mRecordID':mRecordID,
		      'caption':jQuery("#caption").val(),'urgency_grade':jQuery("#urgency_grade").val(),'archive_no':jQuery("#archive_no").val(),
		      'dispatch_type':jQuery("#dispatch_type").val(),'key_word':jQuery("#key_word").val(),'effect_date':jQuery("#effect_date").val(),
		      'sender':jQuery("#sender").val(),'secrecy_grade':jQuery("#secrecy_grade").val(),'send_org_id':jQuery("#send_org_id").val(),
		      'send_org_addr':jQuery("#send_org_addr").val(),'send_org_name':send_org_name,'send_attach_id':n_attach_id,
		      'create_date':jQuery("#create_date").val(),'is_sned_attach':jQuery("#is_sned_attach").val(),'isdxtx':jQuery("#isdxtx").val(),
		      'msg_txt':jQuery("#msg_txt").val(),'union_archive':jQuery("#union_archive").val(),'remark1':jQuery("#remark1").val(),'gwcs_address':jQuery("#gwcs_address").val()
			  };
	//TODO 转换CEB，将附件放入零时文件夹
	jQuery.ajax({//AJAX将WORD正文上传至公文传输
		url: ajaxurl,
		type: 'POST',
		dataType:'json',
		data: params,
		async:false,
		success: function(data){
			var uuid = data.uuid
			if(!IsSpace(uuid) && uuid!="erro"){//如果附件，正文读取到磁盘成功转CEB
				var url = jQuery("#gwcsjspaddress").val()+"&type=stamp&id="+uuid;
				var winwidth=(screen.width - 920)/2;
				var winheight=(screen.height - 700)/2-30;
				var freatrues = "height=700,width=920,top="+winheight+"px,left="+winwidth+"px,status=yes,toolbar=no,menubar=no,location=no";
				window.open(url,"",freatrues ); 
			}else{
				alert("上传公文传输失败！"+data.erroInfo);
			}
		},
		error: function(jqXHR, textStatus, errorThrown){
			alert("上传公文传输失败,调用错误！")
		}
	});
}

//获取路径，组转客户端转CEB参数
function TransUpload(){
	var ins_id = jQuery("#ins_id").val();
	var mRecordID = jQuery("#mRecordID").val();
	var DocName, CebName, LogName, IniName;
	var DocNameLen;
	var DocNameWONLen;
	var cebtail;
	
	//拼接地址
	var mRecordID = jQuery("#mRecordID").val();
	var ins_id = jQuery("#ins_id").val();
	var tmp_zip_attch_path = jQuery("#tmp_zip_attch_path").val();
	DocName = tmp_zip_attch_path+mRecordID+".doc";	
	
	DocNameLen = DocName.length;
	DocNameWONLen = DocName.lastIndexOf(".") - 1;
	if (DocNameWONLen == -1)
	{
		DocNameWONLen = DocNameLen;
	}
	else
	{
		cebtail = DocName.substring(DocNameWONLen+2, DocNameLen);
	}

	if (cebtail.toLowerCase() == "ceb")
	{
		CebName = DocName;
	}
	else	
	{
		CebName = DocName.substring(0, DocNameWONLen+1) + ".ceb";
	}
	

	if (DocName != CebName)
	{
		if (!(transMaker(DocName, CebName, '', '')))	// 格式转换
		{
			alert("格式转换失败，请重试！");
			return false;
		}
		
	}
	else
	{
		alert("当前格式为ceb格式！");
	}
	
	return true;
}

//客户端转CEB方法
function transMaker(DocName, CebName, LogName, IniName){
	var DTracker;
	DTracker = new ActiveXObject("MakerCom.MakerExt");

	var nRet;
	var Error;
		
	nRet = DTracker.BeginMaker("");
	if (nRet != 0)
	{
		alert(nRet);
		alert(DTracker.GetErrorMessage(nRet));
		
		delete DTracker;
		return false;
	}
		
	nRet = DTracker.SingleFileConvert(DocName, CebName, "标准模板", LogName, IniName);
	
	if (nRet != 0)
	{
		alert(DTracker.GetErrorMessage(nRet));
		alert("MakerOcx transfer error!");
		nRet = DTracker.EndMaker();
		
		delete DTracker;
		return false;
	}

	nRet = DTracker.EndMaker();
	if (nRet != 0)
	{
		alert(nRet);
		alert("MakerOcx End error!");
		
		delete DTracker;
		return false;
	}
	delete DTracker;
	return true;
}

//发送方正公文传输接口
function sendArchiveFZ(){
	var send_org_name = jQuery("#send_org_name").val();
	if(IsSpace(send_org_name)){
		alert("请选择要分发的单位！");
		return false;
	}
	var ajaxurl="sendtoarchivedo.jsp";
	var ins_id = jQuery("#ins_id").val();
	var busi_id = jQuery("#busi_id").val();
	var mRecordID = jQuery("#mRecordID").val();
	var n_attach_id = jQuery("#n_attach_id").val();
	var params = {'ins_id':ins_id,'busi_id':busi_id,'optType':'toTempFile','mRecordID':mRecordID,'n_attach_id':n_attach_id};
	//TODO 转换CEB，将附件放入零时文件夹
	jQuery.ajax({//AJAX将WORD正文上传至公文传输
		url: ajaxurl,
		type: 'POST',
		dataType:'json',
		data: params,
		async:false,
		success: function(data){
			if(data.flag){//如果附件，正文读取到磁盘成功转CEB
				var pwindows = getParentWindow("windowIds");
				var mRecordID = jQuery("#mRecordID").val();
				var ins_id = jQuery("#ins_id").val();
				var tmp_zip_attch_path = jQuery("#tmp_zip_attch_path").val();
				var fso = new ActiveXObject("Scripting.FileSystemObject");
				if(!fso.FolderExists(tmp_zip_attch_path)){
					fso.CreateFolder(tmp_zip_attch_path);
				}	
				var ceb_file = tmp_zip_attch_path+mRecordID+".ceb";
				var doc_file = tmp_zip_attch_path+mRecordID+".doc";
				var pform = pwindows.form1;
				if( pform.WebOffice){
					//将WORD文件生成到本地磁盘
					pform.WebOffice.WebGetFile(doc_file,tmp_zip_attch_path+ins_id+"\\"+mRecordID+".doc");
				if(TransUpload()){
					//将本地的CEB上传到服务器
					pform.WebOffice.WebPutFile(ceb_file,tmp_zip_attch_path+ins_id+"\\"+mRecordID+".ceb");
					//TODO 客户端是否要保留文件
					//pform.WebOffice.WebOffice.WebDelFile(ceb_file,"");
					//pform.WebOffice.WebOffice.WebDelFile(doc_file,"");
					//保存公文要素
					var params1 = {'ins_id':ins_id,'busi_id':busi_id,'title':jQuery("#title").val(),'optType':'sendArchiveFZ','mRecordID':mRecordID,
							      'caption':jQuery("#caption").val(),'urgency_grade':jQuery("#urgency_grade").val(),'archive_no':jQuery("#archive_no").val(),
							      'dispatch_type':jQuery("#dispatch_type").val(),'key_word':jQuery("#key_word").val(),'effect_date':jQuery("#effect_date").val(),
							      'sender':jQuery("#sender").val(),'secrecy_grade':jQuery("#secrecy_grade").val(),'send_org_id':jQuery("#send_org_id").val(),
							      'send_org_addr':jQuery("#send_org_addr").val(),'send_org_name':send_org_name,'send_attach_id':n_attach_id,
							      'create_date':jQuery("#create_date").val(),'is_sned_attach':jQuery("#is_sned_attach").val(),'isdxtx':jQuery("#isdxtx").val(),
							      'msg_txt':jQuery("#msg_txt").val(),'union_archive':jQuery("#union_archive").val(),'remark1':jQuery("#remark1").val(),'gwcs_address':jQuery("#gwcs_address").val()
								  };
					jQuery.ajax({//AJAX将WORD正文上传至公文传输
						url: ajaxurl,
						type: 'POST',
						dataType:'json',
						data: params1,
						async:false,
						success: function(data){
								alert(data.returnStr);
						},
						error: function(jqXHR, textStatus, errorThrown){
							alert("分发失败！")
						}
					});
					}else{
						alert("转换CEB失败！")
					}
				}else{	 
					alert("无法获取WORD对象！")
				}
			}else{
				alert("将正文，附件移动到磁盘失败！")
			}
		},
		error: function(jqXHR, textStatus, errorThrown){
			alert("将正文，附件移动到磁盘失败！")
		}
	});
}


//有章分发，1，将WORD正文上传至公文传输。2，保存公文要素 。3，保存公文地址信息
function agentSendArchive(){
	var send_org_name = jQuery("#send_org_name").val();
	var isFlag = jQuery('#form1').validationEngine('validate'); //是否全部验证通过
	if(!isFlag){
		return false;
	}
	if(IsSpace(send_org_name)){
		alert("请选择要分发的单位！");
		return false;
	}
	var addr="";
	var msg="";
	var union_archive = jQuery("#union_archive").val();
	if(union_archive == '1'){
		var order=1;
		if(jQuery("#orglist option").length>0){
			jQuery("#orglist option").each(function(){
				addr+=this.value+","+this.title+","+order+"#";
				order++;
			});
		}else{
			alert("联合发文盖章单位不能为空！");
			return;
		}
		msg=jQuery("#lh_msg_txt").val()
	}
	var ajaxurl="sendtoarchivedo.jsp";
	var ins_id = jQuery("#ins_id").val();
	var busi_id = jQuery("#busi_id").val();
	var mRecordID = jQuery("#mRecordID").val();
	var n_attach_id = jQuery("#n_attach_id").val();
	var params = {'ins_id':ins_id,'busi_id':busi_id,'title':jQuery("#title").val(),'optType':'agentSendArchive','mRecordID':mRecordID,
		      'caption':jQuery("#caption").val(),'urgency_grade':jQuery("#urgency_grade").val(),'archive_no':jQuery("#archive_no").val(),
		      'dispatch_type':jQuery("#dispatch_type").val(),'key_word':jQuery("#key_word").val(),'effect_date':jQuery("#effect_date").val(),
		      'sender':jQuery("#sender").val(),'secrecy_grade':jQuery("#secrecy_grade").val(),'send_org_id':jQuery("#send_org_id").val(),
		      'send_org_addr':jQuery("#send_org_addr").val(),'send_org_name':send_org_name,'send_attach_id':n_attach_id,
		      'create_date':jQuery("#create_date").val(),'is_sned_attach':jQuery("#is_sned_attach").val(),'isdxtx':jQuery("#isdxtx").val(),
		      'msg_txt':jQuery("#msg_txt").val(),'union_archive':union_archive,'remark1':jQuery("#remark1").val(),
		      'gwcs_address':jQuery("#gwcs_address").val(),'union_archive_addr':addr,'union_archive_msg':msg,'send_org_config':jQuery("#send_org_config").val()
			  };
	jQuery.ajax({//AJAX将WORD正文上传至公文传输
		url: ajaxurl,
		type: 'POST',
		dataType:'json',
		data: params,
		async:false,
		success: function(data){
			var uuid = data.uuid
			if(!IsSpace(uuid) && uuid!="erro"){//如果附件，正文读取到磁盘成功转CEB
				alert("保存公文要素成功！");		
			}else{
				alert("保存公文要素失败！"+data.erroInfo);
			}
		},
		error: function(jqXHR, textStatus, errorThrown){
			alert("保存公文要素失败,调用错误！")
		}
	});
}	
	
	
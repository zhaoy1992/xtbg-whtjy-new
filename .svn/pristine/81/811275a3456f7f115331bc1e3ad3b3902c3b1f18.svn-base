/*
	文件：iwebOffice2009
	描述：正文处理JS
	作者：shuqi.liu
	日期：2013-5-27
*/
var do_recordID = "";
jQuery(function() {
	var webform  ;
	jQuery("#titleids").css('display','block');
	jQuery('#tabs1').tabs();
	
	Load(); //加载
});

/*
函数: changeIndex
说明: 用于切换正文跟基本信息
参数:   无
返回值: 无
*/
function changeIndex(index){	
	if(index == 3){
		//如果正文未加载
		if(IsSpace(do_recordID)){
			Load();
		}
	}
}


//作用：载入iWebOffice
function Load(){
  try{
	var objheight = jQuery("#objheight").val();
	var objwidth = jQuery("#objwidth").val();
	var codebase = jQuery("#codebase").val();
	jQuery('#webofficDiv').append("<OBJECT id='WebOffice' name ='WebOffice' height='"+objheight+"' width='"+objwidth+"' classid='clsid:8B23EA28-2009-402F-92C4-59BE0E063499' codebase='"+codebase+"'></OBJECT> ")
	webform = form1;
    //以下属性必须设置，实始化iWebOffice
	webform.WebOffice.WebUrl=jQuery("#mServerUrl").val();			//WebUrl:系统服务器路径，与服务器文件交互操作，如保存、打开文档，重要文件
	do_recordID = jQuery("#mRecordID").val();
	var hasText = jQuery("#hasText").val();//是否有整理后的正文
	if(hasText=="true"){
		webform.WebOffice.EditType = "4,0";//如果整理过后，那么打开是只读
		webform.WebOffice.RecordID=	"text"+do_recordID;//这里的作用是text 默认打开整理过后的正文。
	}else{
		webform.WebOffice.EditType=jQuery("#mEditType").val();	//EditType:编辑类型  方式一、方式二  <参考技术文档>
		webform.WebOffice.RecordID=	do_recordID;//这里的作用是原文。
	}
	webform.WebOffice.Template=jQuery("#mTemplate").val();	//Template:模板编号
	webform.WebOffice.FileName=jQuery("#mFileName").val();  //FileName:文档名称
	webform.WebOffice.FileType=jQuery("#mFileType").val();  //FileType:文档类型  .doc  .xls  .wps
	webform.WebOffice.UserName=jQuery("#user_name_IP").val();	//UserName:操作用户名，痕迹保留需要,加入IP
	
	//从页面隐藏域中获取配置的属性 （ArchiveWebTextTag标签自动生成隐藏域）
	var is_trace=jQuery("#is_trace").val();	//是否显示痕迹 
	var is_red=jQuery("#is_red").val();	//是否可套红
	var is_readonly=jQuery("#is_readonly").val();	//是否只读
	var is_msg=jQuery("#is_msg").val();	//是否发送短信
	var msg_txt_config = jQuery("#msg_txt_config").val();	//短信规则
	var is_sign=jQuery("#is_sign").val();	//是否可签名
	var is_keeptrace=jQuery("#is_keeptrace").val();//是否保留痕迹
	var is_attachment=jQuery("#is_attachment").val();//是否处理附件
	var is_serialnumber=jQuery("#is_serialnumber").val();//是否可编号
	var is_gwzl=jQuery("#is_gwzl").val();//是否可整理
	var is_ckcg=jQuery("#is_ckcg").val();//是否可以查看草稿
	var is_ckzw=jQuery("#is_ckzw").val();//是否可以查看正文
	var is_ckmq=jQuery("#is_ckmq").val();//是否可以查看面签
	var is_singname=jQuery("#is_singname").val();//是否签名
	var is_affix=jQuery("#is_affix").val();//是否可以盖章
	var remark1=jQuery("#remark1").val();//扩展字段
	var is_xd = jQuery("#is_xd").val();  //是否校对
	var is_gwff = jQuery("#is_gwff").val(); //是否分发公文
	var is_cd =jQuery("#is_cd").val();  //是否存档
	var is_cklc =  jQuery("#is_cklc").val();//是否查看流程
	var is_newflow = jQuery("#is_newflow").val();//是否能发起新的流程
	var is_gk = jQuery("#is_gk").val();//是否公开
	var is_print = jQuery("#is_print").val();//是否打印
	var is_split = jQuery("#is_split").val();//是否拆分
	var is_nbfs = jQuery("#is_nbfs").val();//内部分送
	var is_doback = jQuery("#is_doback").val();//内部分送

	webform.WebOffice.MaxFileSize = 16 * 1024;			//最大的文档大小控制，默认是64M，现在设置成16M。

    webform.WebOffice.ShowToolBar="1";			//ShowToolBar:是否显示工具栏:1显示,0不显示
 
    var flag = webform.WebOffice.WebOpen(true);
    
    webform.WebOffice.ShowType=1;				//文档显示方式  1:表示文字批注  2:表示手写批注  0:表示文档核稿
    webform.WebOffice.ExtParam="{_DBType:\"document_file\"}";       //夏天新增：
																	//【DBType：数据库类型，暂时只支持保存文档和读取文档方法的底层切换】
																	//可选项，document_file(默认值),fc_attach
    webform.WebOffice.VisibleTools("新建文件",false);
    //webform.WebOffice.VisibleTools("打开文件",false);
    webform.WebOffice.VisibleTools("文字批注",false);
    webform.WebOffice.VisibleTools("手写批注",false);
    webform.WebOffice.VisibleTools("文档清稿",false);
    webform.WebOffice.VisibleTools("重新批注",false);
    webform.WebOffice.VisibleTools("保存文件",false);
    //webform.WebOffice.VisibleTools("打开文件",false);
    webform.WebOffice.VisibleTools("全屏",true);
    //webform.WebOffice.VisibleTools("",false);
    var initType = parms.flowParmJson.initType;//环节类型 1为初始化环节。4为查看
    if(initType=="1" || initType=="2" || initType=="3"){//如果不是1，2，3那么不需要此菜单
	 	
		if(is_trace =="1" && is_keeptrace =="1"){//设置显示或者隐藏痕迹 
	 		webform.WebOffice.WebSetRevision(true,true,false,false);
	 		webform.WebOffice.AppendTools("7","显示痕迹",7);
	 	 	webform.WebOffice.AppendTools("8","隐藏痕迹",7);
	 	}else if(is_trace =="1"){
	 		webform.WebOffice.WebSetRevision(true,false,false,false);
	 		webform.WebOffice.AppendTools("7","显示痕迹",7);
	 	 	webform.WebOffice.AppendTools("8","隐藏痕迹",7);
	 	}else if(is_keeptrace =="1"){
	 		webform.WebOffice.WebSetRevision(false,true,false,false);
	 		webform.WebOffice.AppendTools("7","显示痕迹",7);
	 	 	webform.WebOffice.AppendTools("8","隐藏痕迹",7);
	 	}else{
	 		webform.WebOffice.WebSetRevision(false,true,false,false);
	 	}
		if(is_red =="1"){//套红
	 		webform.WebOffice.AppendTools("2","套  红",7);
	 	}
	 	//特检院 OA  2014-02-26 start
		if(is_affix=="1"){//盖萝卜章
			webform.WebOffice.AppendTools("3","盖章",7);
		}
		//特检院 OA  2014-02-26 end
		webform.WebOffice.AppendTools("1","保存文件",7);
		
		
    }
  //特检院 OA  2014-04-27
	webform.WebOffice.AppendTools("11","另存为",7);
	webform.WebOffice.ShowMenu="0";	//不显示下拉菜单
	
	//特检院 OA  2014-03-18 start 第一环节 不记录痕迹
    if(initType=="1"){
    	webform.WebOffice.WebSetRevision(false,false,false,false);	
    } else {
    	webform.WebOffice.WebSetRevision(false,true,false,false);	
    }
	//特检院 OA  2014-03-18 end  第一环节 不记录痕迹
    
    //特检院 OA 增加打印预览功能 2014-06-19 start
    if(is_print=="1"){
    	//正文打印
    	webform.WebOffice.AppendTools("16","打印预览",16);
    }
    webform.WebOffice.AppendTools("5","打   印",7);
    //特检院 OA 增加打印预览功能 2014-06-19 end
    
	webform.WebOffice.attachEvent("OnMenuClick",function(vIndex,vCaption){ 
		
	}); 
    //响应工具栏事件
	webform.WebOffice.attachEvent("OnToolsClick",function(vIndex,vCaption){ 
		
	    if (vIndex==1){
	    	saveText();//暂存或者保存正文
	    };
	    if (vIndex==2){
	    	 wordTemplateTaohong(); //套红
	    };
	    if (vIndex==7){//显示痕迹
	    	ShowRevision(true);
	    };
	    if (vIndex==8){//隐藏痕迹
	    	ShowRevision(false);
	    };
	    //特检院 OA  2014-02-26 start
	    if (vIndex==3){//显示盖章
	    	//印章列表
	    	WebOpenSignature();
	    };
	    //特检院 OA  2014-02-26 end
	    
	    if (vIndex==16){  //打印文档
	    	webform.WebOffice.WebObject.printPreview();
	     }
	    if (vIndex==5){  //打印文档
	    	webform.WebOffice.WebOpenPrint();
	     }
	    
	    //特检院 OA  2014-04-27
	    if (vIndex==11) {//另存为
	    	webform.WebOffice.WebSaveLocal();
	    }
	});
	wordiwebofficeJS.doFlowInFlow.initFlowInFlow(webform, do_recordID);
  }catch(e){
    alert(e.description);//显示出错误信息
  }		
}

//打印
function printText(){
	webform.WebOffice.WebOpenPrint();
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

//保存WORD文档
function saveText(){
	var flag = webform.WebOffice.WebSave(true);
	//保存正文为图片  start 
	if(flag==true){
		flag =webform.WebOffice.WebSaveImage();
	}
	//保存正文为图片  end
	 if (flag){
		 alert("保存成功！");
	 }else{
		 alert("保存失败！");
	}
}

//公文编号
function serialNumber(){
	var busi_id = jQuery("#busi_id").val();
	var url = jQuery("#path").val()+'/ccapp/oa/archive/serialnumber.jsp?windowsId=windowIds&busi_id='+busi_id;
	//jQuery("#webofficDiv").hide();
	openAlertWindows('windowIds',url,'公文编号',800,240,'25%','25%',closeAlertWindow);

}

//作用：显示操作状态
function StatusMsg(mString){
  //StatusBar.innerText=mString;
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

//套红
function wordTemplateTaohong(){
	//if(confirm("您确定要套红吗？注意,多次套红不会保存修改的内容!")){
		var busiTypeCode = jQuery("#busiTypeCode").val();
		openAlertWindows('windowId',jQuery("#path").val()+'/ccapp/oa/archive/thwordtemplateviewlist.jsp?windowsId=windowId&busiTypeCode='+busiTypeCode,'选择套红模版',800,340,'25%','25%',closeAlertWindow);
		//隐藏金格控件
		jQuery("#webofficDiv").hide();
	//}
}
 //特检院 OA  2014-02-26 start
//作用：签名印章
function WebOpenSignature(){
  //alert("如果你要更安全签章,建议采用金格iSignature电子签章软件进行签章:\r\n下载地址http://www.goldgrid.cn/iSignature/Download.asp\r\n\r\n该软件是支持文档完整性保护、CA证书和数字签名技术的,\r\n是通过了<国家公安部和国家保密局>双重认证的安全电子签章产品!");
  try{
	  webform.WebOffice.WebOpenSignature();  	//交互OfficeServer的 A签章列表OPTION="LOADMARKLIST"    B签章调出OPTION="LOADMARKIMAGE"    C确定签章OPTION="SAVESIGNATURE"    <参考技术文档>
	  StatusMsg(webform.WebOffice.Status);
  }catch(e){alert(e.description+"WebOpenSignature");}
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

//作用：验证印章A
function WebShowSignature(){
  try{
    webform.WebOffice.WebShowSignature();  	//交互OfficeServer的OPTION="LOADSIGNATURE"
    StatusMsg(webform.WebOffice.Status);
  }catch(e){alert(e.description);}
}

//作用：保存印章正文
function webOfficeSaveSinature(){
	try{
	     webform.WebOffice.RecordID =do_recordID;
	     var mFileType = jQuery("#mFileType").val();
		 webform.WebOffice.FileName = do_recordID+mFileType;
		 webform.WebOffice.WebSave(true);
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
//特检院 OA  2014-02-26 end

/**
**套红模版返回
**/
function backTo2(returnObj,mb_mc){

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
				//发文 第一个环节
				if(typeof creatorFwzh =="function"){
					creatorFwzh(mb_mc);
				}
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

//显示金格控件
function closeAlertWindow(){
	jQuery("#webofficDiv").show();
}

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


//作用：获取文档Txt正文
function WebGetWordContent(){
  try{
    alert(webform.WebOffice.WebObject.Content.Text);
  }catch(e){alert(e.description);}
}

//阻止浏览器关闭
window.onbeforeunload=function(event){
     return "直接关闭浏览器会丢失未保存的数据，如需退出请点击系统的退出按钮。";
}
var wordiwebofficeJS = {};

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
					if(textIdZW){
						if(!do_recordID){
							do_recordID = jQuery("#mRecordID").val();
						}
						officeObj = webform.WebOffice;
						officeObj.RecordID = textIdZW;
						officeObj.WebInsertFile();
						officeObj.RecordID = do_recordID;
					}
				}
				//其他 参见 FlowMoveBean.getJavaString
				//4转移其他 通过:oldInsId
				parms.flowParmJson.parent_ins_id = jQuery("#"+_fmb.oldInsId).val();
			}
		}catch(e){alert("初始化流程中启动的流程时,脚本错误");}
	},
	//依赖 configparm.jsp archiveform.vm FormserviceImpl.java
	newFlowFnBody:function(){
		var childWindowId = "windowIds1";
		//_fmb:在FlowMoveBean.java(createJsBean)申明
		if(typeof(_fmb)=="undefined"){
			return;
		}
		var path =  jQuery("#path").val()+"/ccapp/oa/archive/newflowmain.jsp?windowsId="+childWindowId;
		//0
		path += "&"+_fmb.isStartAdd+"=Y";
		
		//1
		var drag_in_title_input = jQuery("#field_drag_in_title").val();
		if(drag_in_title_input){
			path += "&"+_fmb.flowTitle+"="+jQuery("#"+drag_in_title_input).val();
		}
		//2
		var drag_in_webtext_input = jQuery("#field_drag_in_webtext").val();
		if(drag_in_webtext_input){
			path += "&"+_fmb.textIdZW+"="+jQuery("#"+drag_in_webtext_input).val();
		}
		//3
		var drag_in_attach_input = jQuery("#field_drag_in_attach").val();
		if(drag_in_attach_input){
			path += "&"+_fmb.oldAttachId+"="+jQuery("#"+drag_in_attach_input).val();
		}
		
		closeAlertWindow = function (){
			//jQuery("#webofficDiv").show();
		};
		openAlertWindows(childWindowId,path,'选择重新发起的流程',900,480,'25%','25%',closeAlertWindow);
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
		//jQuery("#webofficDiv").show();
	},
	//当关闭选择列表页面后，显示
	newFlowWindowClose:function(){
		var okF = function() {
			//jQuery("#webofficDiv").show();
			//组装调用办结流程
			var busi_id = jQuery("#busi_id").val();
			
			//短信配置
			var msg_txt_config = jQuery("#msg_txt_config").val(); //获取页面隐藏域里的内容 （此处有问题，如果暂存将无法保存短信配置。）
			var isdxtx = jQuery("#isdxtx").val();
			var isjsxx = jQuery("#isjsxx").val();
			var isyj = jQuery("#isyj").val();
			var isznxx = jQuery("#isznxx").val();
			var url = jQuery("#path").val()+'/ccapp/oa/archive/sendnext.jsp?windowsId=windowIds&busi_id='+busi_id+'&msg_txt='+msg_txt_config+'&isdxtx='+isdxtx+'&isjsxx='+isjsxx+'&isyj='+isyj+'&isznxx='+isznxx+'&ins_id='+ parms.flowParmJson.ins_id+"&nextAct=banjie";
			//jQuery("#webofficDiv").hide();
			openAlertWindows('windowIds',url,'送后续环节',800,220,'25%','25%',closeAlertWindow);
		}
		var okC = function() {
			//jQuery("#webofficDiv").show();
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
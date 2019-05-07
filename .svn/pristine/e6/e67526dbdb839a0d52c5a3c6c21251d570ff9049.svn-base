<%@ page contentType="text/html; charset=GBK"%>
<jsp:include page="/eformsys/fceformext/public/public.jsp"></jsp:include>
<script language="javascript" for=WebOffice event="OnMenuClick(vIndex,vCaption)">
   var iWebOffice = document.getElementsByName("WebOffice")[0];
   if (vIndex==1){  //打开本地文件
      try{		      
      	  WebOpenLocal();
      }catch(e){
          if(e.description.substring(0,16)=="Cannot open file"){
              alert("该文档已经打开，请先关闭该文档！");
          }else{
              alert(e.description);
          }
      }
   }
   if (vIndex==2){  //保存本地文件
      WebSaveLocal();
   }
   if (vIndex==3){  //保存到服务器上
       //SaveDocumentWithPrompt();    //保存正文及文档附加信息。
       SaveDocument(); 
   }
   if (vIndex==5){  //签名印章
      WebOpenSignature();
   }
   if (vIndex==6){  //签章验证A
      MyWebShowSignature();
   }
   if(vIndex==61){  //签章验证B
      MyWebCheckSignature();       
   }
   if (vIndex==8){  //保存版本
      WebSaveVersion();
   }
   if (vIndex==9){  //打开版本
      WebOpenVersion();
   }   
   if (vIndex==16){  //打印文档
      //WebOpenPrint();   这个函数没有打印份数控制。
      WebCopysCtrlPrint();
   }
   if (vIndex==17){  //隐藏手写批注
      iWebOffice.VisibleTools('手写批注',false);   //隐藏或显示iWebOffice工具栏 true显示  false隐藏
   }
   if (vIndex==18){  //显示手写批注
      iWebOffice.VisibleTools('手写批注',true);   //隐藏或显示iWebOffice工具栏 true显示  false隐藏
   }
   if (vIndex==19){  //新建word文档（空白）
   
        if(fcpubdata.cc_form_instanceid!="undefined"){
			if(fcpubdata.cc_form_instanceid=="clear"){
		    	fcpubdata.mIsFirstLoad = "true";
	   			//fcpubdata.mRecordID = getNewCc_form_instanceid("true");
	   			fcpubdata.mRecordID = creator_getCtrlInsid("WebOffice1",fcpubdata.office_isBindForm);
			}else{
				fcpubdata.mIsFirstLoad = "false";
				fcpubdata.mRecordID = fcpubdata.cc_form_instanceid;
			}
		}else{
			if(IsSpace(fcpubdata.noneWorkflowWordId)){
				//alert("请在url后面传递wordid参数！");
				return;			
			}
			fcpubdata.mRecordID = fcpubdata.noneWorkflowWordId;
		}
		
        fcpubdata.mTemplate = "";
        fcpubdata.mFileType = ".doc";
        fcpubdata.mFileName = fcpubdata.mRecordID+fcpubdata.mFileType;
        fcpubdata.mEditType = "1,0";
        fcpubdata.mShowType = "1";        
        fcpubdata.mUserName = getSysElement("userName"); 
        
        //alert("fcpubdata.mFileType"+fcpubdata.mFileType);
        //alert("fcpubdata.mTemplate"+fcpubdata.mTemplate);
        //alert("fcpubdata.mRecordID"+fcpubdata.mRecordID);
        //alert("fcpubdata.mFileName"+fcpubdata.mFileName);
        //alert("fcpubdata.mEditType"+fcpubdata.mEditType);
        //alert("fcpubdata.mShowType"+fcpubdata.mShowType);
        //alert("fcpubdata.mUserName"+fcpubdata.mUserName);
        
        loadWebOffice(fcpubdata.mServerUrl,fcpubdata.mRecordID,fcpubdata.mTemplate,fcpubdata.mFileName,fcpubdata.mFileType,fcpubdata.mUserName,fcpubdata.mEditType,fcpubdata.mShowType)
    }
    if (vIndex==77){  //新建excel文档(空白)
    
        if(fcpubdata.cc_form_instanceid!="undefined"){
			if(fcpubdata.cc_form_instanceid=="clear"){
		    	fcpubdata.mIsFirstLoad = "true";
	   			//fcpubdata.mRecordID = getNewCc_form_instanceid("true");
	   			fcpubdata.mRecordID = creator_getCtrlInsid("WebOffice1",fcpubdata.office_isBindForm);
			}else{
				fcpubdata.mIsFirstLoad = "false";
				fcpubdata.mRecordID = fcpubdata.cc_form_instanceid;
			}
		}else{
			if(IsSpace(fcpubdata.noneWorkflowWordId)){
				//alert("请在url后面传递wordid参数！");
				return;			
			}
			fcpubdata.mRecordID = fcpubdata.noneWorkflowWordId;
		}
		
        fcpubdata.mTemplate = "";
        fcpubdata.mFileType = ".xls";
        fcpubdata.mFileName = fcpubdata.mRecordID+fcpubdata.mFileType;
        fcpubdata.mEditType = "1,0";
        fcpubdata.mShowType = "1";        
        fcpubdata.mUserName = getSysElement("userName"); 
        
        //alert("fcpubdata.mFileType"+fcpubdata.mFileType);
        //alert("fcpubdata.mTemplate"+fcpubdata.mTemplate);
        //alert("fcpubdata.mRecordID"+fcpubdata.mRecordID);
        //alert("fcpubdata.mFileName"+fcpubdata.mFileName);
        //alert("fcpubdata.mEditType"+fcpubdata.mEditType);
        //alert("fcpubdata.mShowType"+fcpubdata.mShowType);
        //alert("fcpubdata.mUserName"+fcpubdata.mUserName);
        
        loadWebOffice(fcpubdata.mServerUrl,fcpubdata.mRecordID,fcpubdata.mTemplate,fcpubdata.mFileName,fcpubdata.mFileType,fcpubdata.mUserName,fcpubdata.mEditType,fcpubdata.mShowType)
    }
    if (vIndex==78){  //新建wps文档(空白)
        if(fcpubdata.cc_form_instanceid!="undefined"){
			if(fcpubdata.cc_form_instanceid=="clear"){
			    fcpubdata.mIsFirstLoad = "true";
		   		//fcpubdata.mRecordID = getNewCc_form_instanceid("true");
		   		fcpubdata.mRecordID = creator_getCtrlInsid("WebOffice1",fcpubdata.office_isBindForm);
			}else{
				fcpubdata.mIsFirstLoad = "false";
				fcpubdata.mRecordID = fcpubdata.cc_form_instanceid;
			}
		}else{
			if(IsSpace(fcpubdata.noneWorkflowWordId)){
				//alert("请在url后面传递wordid参数！");
				return;				
			}
			fcpubdata.mRecordID = fcpubdata.noneWorkflowWordId;
		}
		
        fcpubdata.mTemplate = "";
        fcpubdata.mFileType = ".wps";
        fcpubdata.mFileName = fcpubdata.mRecordID+fcpubdata.mFileType;
        fcpubdata.mEditType = "1,0";
        fcpubdata.mShowType = "1";        
        fcpubdata.mUserName = getSysElement("userName"); 
        
        //alert("fcpubdata.mFileType"+fcpubdata.mFileType);
        //alert("fcpubdata.mTemplate"+fcpubdata.mTemplate);
        //alert("fcpubdata.mRecordID"+fcpubdata.mRecordID);
        //alert("fcpubdata.mFileName"+fcpubdata.mFileName);
        //alert("fcpubdata.mEditType"+fcpubdata.mEditType);
        //alert("fcpubdata.mShowType"+fcpubdata.mShowType);
        //alert("fcpubdata.mUserName"+fcpubdata.mUserName);
        
        loadWebOffice(fcpubdata.mServerUrl,fcpubdata.mRecordID,fcpubdata.mTemplate,fcpubdata.mFileName,fcpubdata.mFileType,fcpubdata.mUserName,fcpubdata.mEditType,fcpubdata.mShowType)
    }
    if (vIndex==79){  //新建金山表格文档(空白)
        if(fcpubdata.cc_form_instanceid!="undefined"){
			if(fcpubdata.cc_form_instanceid=="clear"){
			    fcpubdata.mIsFirstLoad = "true";
		   		//fcpubdata.mRecordID = getNewCc_form_instanceid("true");
		   		fcpubdata.mRecordID = creator_getCtrlInsid("WebOffice1",fcpubdata.office_isBindForm);
			}else{
				fcpubdata.mIsFirstLoad = "false";
				fcpubdata.mRecordID = fcpubdata.cc_form_instanceid;
			}
		}else{
			if(IsSpace(fcpubdata.noneWorkflowWordId)){
				//alert("请在url后面传递wordid参数！");
				return;
			}
			fcpubdata.mRecordID = fcpubdata.noneWorkflowWordId;
		}
        fcpubdata.mTemplate = "";
        fcpubdata.mFileType = ".et";
        fcpubdata.mFileName = fcpubdata.mRecordID+fcpubdata.mFileType;
        fcpubdata.mEditType = "1,0";
        fcpubdata.mShowType = "1";        
        fcpubdata.mUserName = getSysElement("userName"); 
        
        //alert("fcpubdata.mFileType"+fcpubdata.mFileType);
        //alert("fcpubdata.mTemplate"+fcpubdata.mTemplate);
        //alert("fcpubdata.mRecordID"+fcpubdata.mRecordID);
        //alert("fcpubdata.mFileName"+fcpubdata.mFileName);
        //alert("fcpubdata.mEditType"+fcpubdata.mEditType);
        //alert("fcpubdata.mShowType"+fcpubdata.mShowType);
        //alert("fcpubdata.mUserName"+fcpubdata.mUserName);
        
        loadWebOffice(fcpubdata.mServerUrl,fcpubdata.mRecordID,fcpubdata.mTemplate,fcpubdata.mFileName,fcpubdata.mFileType,fcpubdata.mUserName,fcpubdata.mEditType,fcpubdata.mShowType)
    }
    if (vIndex==80){  //新建ppt文档(空白)
        if(fcpubdata.cc_form_instanceid!="undefined"){
			if(fcpubdata.cc_form_instanceid=="clear"){
			    fcpubdata.mIsFirstLoad = "true";
		   		//fcpubdata.mRecordID = getNewCc_form_instanceid("true");
		   		fcpubdata.mRecordID = creator_getCtrlInsid("WebOffice1",fcpubdata.office_isBindForm);
			}else{
				fcpubdata.mIsFirstLoad = "false";
				fcpubdata.mRecordID = fcpubdata.cc_form_instanceid;
			}
		}else{
			if(IsSpace(fcpubdata.noneWorkflowWordId)){
				//alert("请在url后面传递wordid参数！");
				return;				
			}
			fcpubdata.mRecordID = fcpubdata.noneWorkflowWordId;
		}
        fcpubdata.mTemplate = "";
        fcpubdata.mFileType = ".ppt";
        fcpubdata.mFileName = fcpubdata.mRecordID+fcpubdata.mFileType;
        fcpubdata.mEditType = "1,0";
        fcpubdata.mShowType = "1";        
        fcpubdata.mUserName = getSysElement("userName"); 
        
        //alert("fcpubdata.mFileType"+fcpubdata.mFileType);
        //alert("fcpubdata.mTemplate"+fcpubdata.mTemplate);
        //alert("fcpubdata.mRecordID"+fcpubdata.mRecordID);
        //alert("fcpubdata.mFileName"+fcpubdata.mFileName);
        //alert("fcpubdata.mEditType"+fcpubdata.mEditType);
        //alert("fcpubdata.mShowType"+fcpubdata.mShowType);
        //alert("fcpubdata.mUserName"+fcpubdata.mUserName);
        
        loadWebOffice(fcpubdata.mServerUrl,fcpubdata.mRecordID,fcpubdata.mTemplate,fcpubdata.mFileName,fcpubdata.mFileType,fcpubdata.mUserName,fcpubdata.mEditType,fcpubdata.mShowType)
    }
    if (vIndex==81){  //新建visio文档(空白)
        if(fcpubdata.cc_form_instanceid!="undefined"){
			if(fcpubdata.cc_form_instanceid=="clear"){
			    fcpubdata.mIsFirstLoad = "true";
		   		//fcpubdata.mRecordID = getNewCc_form_instanceid("true");
		   		fcpubdata.mRecordID = creator_getCtrlInsid("WebOffice1",fcpubdata.office_isBindForm);
			}else{
				fcpubdata.mIsFirstLoad = "false";
				fcpubdata.mRecordID = fcpubdata.cc_form_instanceid;
			}
		}else{
			if(IsSpace(fcpubdata.noneWorkflowWordId)){
				//alert("请在url后面传递wordid参数！");
				return;				
			}
			fcpubdata.mRecordID = fcpubdata.noneWorkflowWordId;
		}
        fcpubdata.mTemplate = "";
        fcpubdata.mFileType = ".vsd";
        fcpubdata.mFileName = fcpubdata.mRecordID+fcpubdata.mFileType;
        fcpubdata.mEditType = "1,0";
        fcpubdata.mShowType = "1";        
        fcpubdata.mUserName = getSysElement("userName"); 
        
        //alert("fcpubdata.mFileType"+fcpubdata.mFileType);
        //alert("fcpubdata.mTemplate"+fcpubdata.mTemplate);
        //alert("fcpubdata.mRecordID"+fcpubdata.mRecordID);
        //alert("fcpubdata.mFileName"+fcpubdata.mFileName);
        //alert("fcpubdata.mEditType"+fcpubdata.mEditType);
        //alert("fcpubdata.mShowType"+fcpubdata.mShowType);
        //alert("fcpubdata.mUserName"+fcpubdata.mUserName);
        
        loadWebOffice(fcpubdata.mServerUrl,fcpubdata.mRecordID,fcpubdata.mTemplate,fcpubdata.mFileName,fcpubdata.mFileType,fcpubdata.mUserName,fcpubdata.mEditType,fcpubdata.mShowType)
    }
    if (vIndex==20){  //从模板新建各种类型的文件
        var myReturnValue = window.showModalDialog("../../../iWebOffice2006/newDocumentFromTemplate.jsp");
        if(myReturnValue!="undefined" && myReturnValue!=null){
	        var myarr = new Array();
	        myarr = myReturnValue.split("&");        
	        if(fcpubdata.cc_form_instanceid==undefined){
	        	fcpubdata.mRecordID = fcpubdata.noneWorkflowWordId;
	        }else{
	        	fcpubdata.mRecordID = creator_getCtrlInsid("WebOffice1",fcpubdata.office_isBindForm);
	        }
	        fcpubdata.mFileType = myarr[0].substring(myarr[0].indexOf("=")+1);
	        fcpubdata.mTemplate = myarr[1].substring(myarr[0].indexOf("=")+1);	       
	        fcpubdata.mFileName = fcpubdata.mRecordID+fcpubdata.mFileType;
	        fcpubdata.mEditType = "1,0";
	        fcpubdata.mShowType = "1";      
	        fcpubdata.mUserName = getSysElement("userName");  
	        //alert("fcpubdata.mFileType"+fcpubdata.mFileType);
	        //alert("fcpubdata.mTemplate"+fcpubdata.mTemplate);
	        //alert("fcpubdata.mRecordID"+fcpubdata.mRecordID);
	        //alert("fcpubdata.mFileName"+fcpubdata.mFileName);
	        //alert("fcpubdata.mEditType"+fcpubdata.mEditType);
	        //alert("fcpubdata.mShowType"+fcpubdata.mShowType);
	        //alert("fcpubdata.mUserName"+fcpubdata.mUserName);
	        loadWebOffice(fcpubdata.mServerUrl,fcpubdata.mRecordID,fcpubdata.mTemplate,fcpubdata.mFileName,fcpubdata.mFileType,fcpubdata.mUserName,fcpubdata.mEditType,fcpubdata.mShowType)
	    }
	}
	if(vIndex==21){//表示使用模板套红。
		wordTemplateTaohong();
	}
	if(vIndex==22){//另存为html文件		
		myWebSaveAsHtml();
	}
	if(vIndex==23){//另存为html的图片
		WebSaveAsPage();
	}
	if(vIndex==24){ //显示痕迹
		ShowRevision(true);
	}
	if(vIndex==25){ //隐藏痕迹
		ShowRevision(false);
	}
	if(vIndex==26){ //关闭工具栏
	    ShowToolBar = 0;
	    WebToolsVisible('Standard',false);      //关闭常用工具
		WebToolsVisible('Formatting',false);    //关闭格式按钮	
	}
	if(vIndex==27){ //打开工具栏
		ShowToolBar = 1;
		WebToolsVisible('Standard',true);       //打开常用工具
		WebToolsVisible('Formatting',true);     //关闭格式按钮	
	}	
	if(vIndex==30){
		WebToolsEnable('Standard',2521,false);  //关闭打印按钮
	}
	if(vIndex==31){
		WebToolsEnable('Standard',2521,true);   //打开打印按钮
	}
	if(vIndex==32){  //关闭文档
		myWebClose();
	}
	
	if(vIndex==33){  //从服务器下载指定文件
	    myWebGetFile();
	}
	if(vIndex==34){  //上传文件到服务器。
	    myWebPutFile();
	}
	if(vIndex==35){  //打开远程文件
		myWebOpenRemoteFile();
	}
	if(vIndex==36){  //插入远程服务器图片
		myWebInsertImage();
	}
	if(vIndex==37){  //读取服务器时间
	   myWebDateTime(false);
	}
	if(vIndex==38){  //同步本地时间为服务器时间
		myWebDateTime(true);
	}
	
	if(vIndex==39){  //保护文档
		WebProtect(true,"");
	}
	if(vIndex==40){  //解除文档保护
		WebProtect(false,"");
	}
	if(vIndex==41){  //禁止拷贝
		WebEnableCopy(false);
	}
	if(vIndex==42){  //允许拷贝
		WebEnableCopy(true);
	}
	if(vIndex==43){  //禁止打开文件
		DisableTools('打开文件',true);  //true禁止,false启用
	}
	if(vIndex==44){  //允许打开文件
	    DisableTools('打开文件',false); //true禁止,false启用
	}
	if(vIndex==45){  //隐藏新建文件
	    VisibleTools('新建文件',false); //true显示,false隐藏
	}
	if(vIndex==46){  //显示新建文件
	   VisibleTools('新建文件',true);   //true显示,false隐藏
	}
	if(vIndex==47){  //显示当前控件版本
		alert('当前控件版本为：'+VersionEx()+Version());
	}
	if(vIndex==48){  //获取痕迹
	    WebGetRevisions();
	}
	if(vIndex==49){  //清除痕迹，接受所有痕迹
		WebObject.Application.ActiveDocument.AcceptAllRevisions();
	}
	if(vIndex==50){  //刷新文档
	    myWebReFresh();
	}
	if(vIndex==51){  //重调文档
		LoadDocument();
	}	
	if(vIndex==52){  //打开标签
	    myWebOpenBookMarks();
	}
	if(vIndex==53){  //填充模板
	    fillTemplate()
	}
	if(vIndex==54){  //保存当前版本
		myWebSaveVersionByFileID();
	}
	if(vIndex==55){  //保存定稿版本
		myWebUpdateFile();
	}
	if(vIndex==56){  //打印份数控制
		WebCopysCtrlPrint();
	}
	if(vIndex==57){  //导入text
		WebImportText();
	}
	if(vIndex==58){  //导出text
		WebExportText();
	}
	if(vIndex==59){  //插入远程表格
		WebSetWordTable();
	}
	if(vIndex==60){  //读word内容
		WebGetWordContent();	
	}
	if(vIndex==62){  //写word内容
		WebSetWordContent();
	}
	if(vIndex==63){  //word禁止拖动
		WebObject.Application.Options.AllowDragAndDrop=false;  //false禁止拖动  true允许拖动
	}
	if(vIndex==64){  //打印黑白文档
		WebWordPrintBlackAndWhile();
	}
	if(vIndex==65){  //插入页眉
		WebObject.ActiveWindow.ActivePane.View.SeekView=9;
	}
	if(vIndex==66){  //插入页码
		WebObject.Application.Dialogs(294).Show();
	}
	if(vIndex==67){  //excel求和
		WebGetExcelContent();
	}
	if(vIndex==68){  //锁定工作表
		WebSheetsLock();
	}
	if(vIndex==69){  //excel禁止拖动
		WebObject.Application.CellDragAndDrop=false;  //false禁止拖动  true允许拖动
	}
	if(vIndex==70){  //读取文档页数
		WebDocumentPageCount();
	}
	if(vIndex==71){  //签章锁定文件
		WebSignatureAtReadonly();
	}	
	if(vIndex==73){  //将文档保存为PDF文件
		myWebSaveAsPDF();
	}
	if(vIndex==74){  //快速保存文件，支持断点续传。
		myWebFastSave();
	}
	//added by zhou.luo 2008-12-09 提供给开发人员，让开发人员能够自己添加自定义的菜单，这里是点击菜单的响应事件。
	if(typeof creator_onMenuClick == "function"){
	    creator_onMenuClick(vIndex,vCaption);
	}
</script>

<SCRIPT language=javascript for=WebOffice event=OnToolsClick(vIndex,vCaption)>
    //响应工具栏事件    
    //提供空接口  OnBeforeToolsClick（）,留给应用组去实现。在工具栏事件之前调用
    // chenzhiwu  2009-7-31
     try {
		if (typeof OnBeforeToolsClick == "function") {
			if (!OnBeforeToolsClick(vIndex,vCaption)) {
				return;
			}
		}
	 } catch (e) {}
    //if (vIndex==-1){webform.WebOffice.Alert(vCaption);}             //在完成相应操作后响应iWebOffice标准工具栏操作铵钮事件，如"手写批注",vCaption="手写批注"
	if (vIndex==22){  //新建空白文档        
        if(fcpubdata.cc_form_instanceid==undefined){
        	fcpubdata.mRecordID = fcpubdata.noneWorkflowWordId;
        }else{
        	fcpubdata.mRecordID = creator_getCtrlInsid("WebOffice1",fcpubdata.office_isBindForm);
        }
        fcpubdata.mTemplate = "";
        fcpubdata.mFileType = ".doc";
        fcpubdata.mFileName = fcpubdata.mRecordID+fcpubdata.mFileType;
        fcpubdata.mEditType = "1,0";
        fcpubdata.mShowType = "1";        
        fcpubdata.mUserName = getSysElement("userName"); 
        
        //alert("fcpubdata.mFileType"+fcpubdata.mFileType);
        //alert("fcpubdata.mTemplate"+fcpubdata.mTemplate);
        //alert("fcpubdata.mRecordID"+fcpubdata.mRecordID);
        //alert("fcpubdata.mFileName"+fcpubdata.mFileName);
        //alert("fcpubdata.mEditType"+fcpubdata.mEditType);
        //alert("fcpubdata.mShowType"+fcpubdata.mShowType);
        //alert("fcpubdata.mUserName"+fcpubdata.mUserName);
        
        loadWebOffice(fcpubdata.mServerUrl,fcpubdata.mRecordID,fcpubdata.mTemplate,fcpubdata.mFileName,fcpubdata.mFileType,fcpubdata.mUserName,fcpubdata.mEditType,fcpubdata.mShowType)
    }
    if (vIndex==21){  //从模板新建各种类型的文件
        var myReturnValue = window.showModalDialog("../../../iWebOffice2006/newDocumentFromTemplate.jsp");
        if(myReturnValue!="undefined" && myReturnValue!=null){
	        var myarr = new Array();
	        myarr = myReturnValue.split("&");	        
	        if(fcpubdata.cc_form_instanceid==undefined){
	        	fcpubdata.mRecordID = fcpubdata.noneWorkflowWordId;
	        }else{
	        	 fcpubdata.mRecordID = creator_getCtrlInsid("WebOffice1",fcpubdata.office_isBindForm);
	        }
	        fcpubdata.mFileType = myarr[0].substring(myarr[0].indexOf("=")+1);
	        fcpubdata.mTemplate = myarr[1].substring(myarr[0].indexOf("=")+1);
	        fcpubdata.mFileName = fcpubdata.mRecordID+fcpubdata.mFileType;
	        fcpubdata.mEditType = "1,0";
	        fcpubdata.mShowType = "1";      
	        fcpubdata.mUserName = getSysElement("userName");  
	        //alert("fcpubdata.mFileType"+fcpubdata.mFileType);
	        //alert("fcpubdata.mTemplate"+fcpubdata.mTemplate);
	        //alert("fcpubdata.mRecordID"+fcpubdata.mRecordID);
	        //alert("fcpubdata.mFileName"+fcpubdata.mFileName);
	        //alert("fcpubdata.mEditType"+fcpubdata.mEditType);
	        //alert("fcpubdata.mShowType"+fcpubdata.mShowType);
	        //alert("fcpubdata.mUserName"+fcpubdata.mUserName);
	        loadWebOffice(fcpubdata.mServerUrl,fcpubdata.mRecordID,fcpubdata.mTemplate,fcpubdata.mFileName,fcpubdata.mFileType,fcpubdata.mUserName,fcpubdata.mEditType,fcpubdata.mShowType)
	    }
    }
    if (vIndex==23){  //保存到服务器上
        SaveDocument();    //保存正文及文档附加信息。
    }
    if (vIndex==24){   //清稿(接收所有痕迹)
        cleanDoc();
    }
    if(vIndex==25){ //显示痕迹
		ShowRevision(true);
	}
	if(vIndex==26){ //隐藏痕迹
		ShowRevision(false);
	}
	if(vIndex==27){  //模板套红
	    wordTemplateTaohong();
	}
    //只读状态，全屏的时候控制工具栏不显示  vIndex=-1表示系统工具栏  
    if (vIndex== -1 && (vCaption == '全屏' || vCaption =='返回')){ 
        if(fcpubdata.mShowType=="1" && fcpubdata.mEditType=="0,0"){ //如果是只读
	        ShowMenu="0";
	        ToolsSpace = false;
		    VisibleTools('新建文件,打开文件,保存文件,文字批注,手写批注,重新批注,文档清稿',false);
		    var CommandBars = WebObject.Application.CommandBars;
            var count = CommandBars.Count;
            for (i=1;i<count;i++){            
                WebToolsVisible(CommandBars.Item(i).Name,false);
            }
            WebToolsVisible("requirements",false);
	    }
    }
    //added by zhou.luo 2008-12-09 提供给开发人员，让开发人员能够自己添加自定义的按钮，这里是点击按钮的响应事件。
    if(typeof creator_onToolsClick == "function"){
	    creator_onToolsClick(vIndex,vCaption);
	}
    //提供空接口  OnAfterToolsClick（）,留给应用组去实现。在工具栏事件之后调用
    // chenzhiwu  2009-7-31
   try{
	 if (typeof OnAfterToolsClick == "function") {
			OnAfterToolsClick(vIndex,vCaption);
		}
	} catch (e){}
</SCRIPT>

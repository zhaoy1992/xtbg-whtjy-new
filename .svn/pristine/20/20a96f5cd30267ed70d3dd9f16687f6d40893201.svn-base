//在url中加入测试数据源
function insertDbName(url){
	var dbName=creator_getQueryString("pt_test");
	var regex1 = new RegExp("([\?]dbName=)[^\&]*");
	var regex2 = new RegExp("([\&]dbName=)[^\&]*");
	//是否设置了数据源;
	var hasPtTest =typeof(dbName) != 'undefined' && !IsSpace(dbName);
	//url是否包含dbName参数;
	var hasDbName1=regex1.test(url);
	var hasDbName2=regex2.test(url);
	if(hasPtTest){
		var tRep = "$1"+dbName;
		if(hasDbName1){
			url=url.replace(regex1,tRep);
		}else if(hasDbName2){
			url=url.replace(regex2,tRep);
		}else{
			url += "?dbName="+dbName;
		}
	}
	return url;
}

//作用：载入iWebOffice
function loadWebOffice(mServerUrl,mRecordID,mTemplate,mFileName,mFileType,mUserName,mEditType,mShowType){
   
    //alert("mServerUrl:"+mServerUrl);
    //alert("mRecordID:"+mRecordID);
    //alert("mTemplate:"+mTemplate);
    //alert("mFileName:"+mFileName);
    //alert("mFileType:"+mFileType);
    //alert("mUserName:"+mUserName);
    //alert("mEditType:"+mEditType);
    //alert("mShowType:"+mShowType);
    if(mFileType!=".doc"){ //只有doc支持showType    visio和ppt不支持状态设置。
    	mShowType = "1";
    }   
 	try{
	    //以下属性必须设置，实始化iWebOffice       
	    var iWebOffice = document.getElementsByName("WebOffice")[0];  //获取控件对象。
	    iWebOffice.WebUrl=insertDbName(mServerUrl);			    //WebUrl:系统服务器路径，与服务器文件交互操作，如保存、打开文档，重要文件
	    iWebOffice.RecordID=mRecordID;		        //RecordID:本文档记录编号
	    iWebOffice.Template=mTemplate;		        //Template:模板编号
	    iWebOffice.FileName=mFileName;		        //FileName:文档名称
	    iWebOffice.FileType=mFileType;		        //FileType:文档类型  .doc  .xls  .wps
	    iWebOffice.UserName=mUserName;		        //UserName:操作用户名，痕迹保留需要
	    iWebOffice.EditType=mEditType;		        //EditType:编辑类型  方式一、方式二  <参考技术文档>  
															//第一位可以为0,1,2,3 其中:0不可编辑;1可以编辑,无痕迹;2可以编辑,有痕迹,不能修订;3可以编辑,有痕迹,能修订；
															//第二位可以为0,1 其中:0不可批注,1可以批注。可以参考iWebOffice2006的EditType属性，详细参考技术白皮书
	    //modified by zhou.luo 2008-10-30 临时设置为30M
	    iWebOffice.MaxFileSize = 64 * 1024;			//最大的文档大小控制，默认是64M.
	    //Start  iWebOffice2006属性  以下属性可以不要
	    iWebOffice.Language="CH";					//Language:多语言支持显示选择   CH 简体 TW繁体 EN英文
	    var color1 = "#FF0000";//红色
	    var color2 = "#FF00FF";//深红色
	    var color3 = "#0000FF";//蓝色
	    var color4 = "#A020F0";//紫色
	    var color5 = "#191970";//深蓝色
	    var color6 = "#FF6100";//橙色
	    var color7 = "#228B22";//森林绿
	    var color8 = "#4169E1";//品蓝
	    var color9 = "#FF8000";//桔黄
	    var penColor = color1;
	    var color = Math.floor(Math.random()*10)+1;
	    switch(color){
	    	case 1: penColor = color1; break;
	    	case 2: penColor = color2; break;
	    	case 3: penColor = color3; break;
	    	case 4: penColor = color4; break;
	    	case 5: penColor = color5; break;
	    	case 6: penColor = color6; break;
	    	case 7: penColor = color7; break;
	    	case 8: penColor = color8; break;
	    	case 9: penColor = color9; break;
	    }
	    //iWebOffice.PenColor="#FF0000";				//PenColor:默认批注颜色
	    iWebOffice.PenColor= penColor;
	    iWebOffice.PenWidth="2";						//PenWidth:默认批注笔宽
	    iWebOffice.Print="1";						//Print:默认是否可以打印:1可以打印批注,0不可以打印批注
	    iWebOffice.ShowToolBar="1";					//ShowToolBar:是否显示工具栏:1显示,0不显示

	    
	    //让只读状态下不加载任何菜单
	    if(mShowType=="1" && mEditType=="0,0"){
	        iWebOffice.ShowMenu="0";
	    }else{
		    //参数一:Index按钮编号,参数二:Caption按钮显示内容,参数三:Icon图标名称	    
		    if(fcpubdata.mLoadTool=="false"){
		        if(fcpubdata.mIsFirstLoad=="true"){
		        	//iWebOffice.AppendTools("22","新建",22);
		         	//iWebOffice.AppendTools("21","从模板新建",21);
		    	}	    	
		    	//iWebOffice.AppendTools("23","保 存",23);
		    	//iWebOffice.AppendTools("13","-",0);		
		    	//文档核稿，文档核稿带套红，清稿有痕迹 这三种状态添加清稿的按钮
		    	//if((mEditType=="2,0" && mShowType=="0") || (mEditType=="1,0" && mShowType=="0")){ 
		        //2008-09-10 只让清稿有痕迹的状态添加清稿的按钮
		        if(mEditType=="2,0" && mShowType=="0"){
		    	    iWebOffice.AppendTools("24","清 稿",24);
		        }
		        if(mShowType=="1" && mEditType=="2,0" || mEditType=="3,0"){
		        	iWebOffice.AppendTools("25","显示痕迹",25);
		        	iWebOffice.AppendTools("26","隐藏痕迹",26);
		        }	    	
		    	fcpubdata.mLoadTool = "true";
		    }	      
		
		    //开始菜单设置
		  ///  iWebOffice.ShowMenu="1";
		    if(fcpubdata.mIsFirstLoad =="true"){   //表示第一次加载office控件的时候。
		    	iWebOffice.AppendMenu("76>","新建空白文档");
		    		iWebOffice.AppendMenu("19","新建word文档");
		    		iWebOffice.AppendMenu("77","新建excel文档");
		    		iWebOffice.AppendMenu("78","新建wps文档");
		    		iWebOffice.AppendMenu("79","新建金山表格文档");
		    		iWebOffice.AppendMenu("80","新建ppt文档");
		    		iWebOffice.AppendMenu("81","新建visio文档");
		    	iWebOffice.AppendMenu("76<","新建空白文档");
		    	iWebOffice.AppendMenu("20","从模板新建");
		    }
		    	    
		    iWebOffice.AppendMenu("3","保存文件到服务器上(&W)");
		    iWebOffice.AppendMenu("1","打开本地文件(&L)");
		    iWebOffice.AppendMenu("2","保存本地文件(&S)");
		    
		    /*不用的就注释掉
		    iWebOffice.AppendMenu("11>","其他保存方式(&O)");
		    	iWebOffice.AppendMenu("74","快速保存文件");
		    	iWebOffice.AppendMenu("22","另存为html文件");
		        iWebOffice.AppendMenu("23","另存为图片文件");
		        iWebOffice.AppendMenu("73","另存为PDF文件");
		    iWebOffice.AppendMenu("11<","其他保存方式(&O)");
		    */
		    iWebOffice.AppendMenu("7","-");
		    iWebOffice.AppendMenu("8","保存版本(&B)");
		    iWebOffice.AppendMenu("55","保存定稿版本");
		    iWebOffice.AppendMenu("9","打开版本(&D)");
		    iWebOffice.AppendMenu("10","-");		    
		    
		    iWebOffice.AppendMenu("16","打印文档(&P)");
		    iWebOffice.AppendMenu("64","打印黑白文档");  
		    iWebOffice.AppendMenu("32","关闭文档(&C)");
		    
		    iWebOffice.AppendMenu("文档管理","-");
		    //if((mShowType=="1" && mEditType=="1,0") || (fcpubdata.taohong=="1")){    //修改无痕迹和文档核稿带套红的时候显示
		    if(fcpubdata.taohong=="1"){    //文档核稿带套红的时候显示 modified 2008-08-20
		    	iWebOffice.AppendMenu("21","模板套红");
		    }
		    /*暂时先去掉签章管理的功能。modified by zhou.luo 2008-08-28
		    if(!(mShowType=="1" && mEditType=="0,0")){  //非只读状态下出现
		    	iWebOffice.AppendMenu("14>","签章管理(&Q)");
		    		iWebOffice.AppendMenu("5","签名印章");
		    		iWebOffice.AppendMenu("71","签章锁定文件");
		    		iWebOffice.AppendMenu("6","签章验证A(&Y)");
		    		iWebOffice.AppendMenu("61","签章验证B(&E)");
		    	iWebOffice.AppendMenu("14<","签章管理(&Q)");
		    }
		    */
		    
		    if(mShowType=="1" && mEditType=="3,0"){   //修改有痕迹，可修订 
		    	iWebOffice.AppendMenu("12>","痕迹管理"); 
		    		iWebOffice.AppendMenu("24","显示痕迹");
		    		iWebOffice.AppendMenu("25","隐藏痕迹");
		    		iWebOffice.AppendMenu("48","获取痕迹");
		    		iWebOffice.AppendMenu("49","清除痕迹(接受痕迹)");
		    	iWebOffice.AppendMenu("12<","痕迹管理");
		    }
		    
		    //iWebOffice.DisableMenu("宏(&M);选项(&O)...");	//禁止菜单	
		    iWebOffice.AppendMenu("50","刷新文档");
		    iWebOffice.AppendMenu("51","重调文档");   
		    
		    
		    //iWebOffice.AppendMenu("52","打开标签");     //这里不需要显示
		    //iWebOffice.AppendMenu("53","填充模板");     //这里不需要显示
		    //iWebOffice.AppendMenu("54","保存当前版本");  //与8号菜单功能相同
		    //iWebOffice.AppendMenu("56","打印份数控制");  //第16号菜单已经添加
		    
		    /*
		    iWebOffice.AppendMenu("定制功能","-"); 
		    
		    iWebOffice.AppendMenu("13>","工具栏，菜单定制");
		    	iWebOffice.AppendMenu("26","关闭工具栏");
		    	iWebOffice.AppendMenu("27","打开工具栏");
		    	iWebOffice.AppendMenu("30","关闭打印按钮");
		    	iWebOffice.AppendMenu("31","打开打印按钮");
		    	iWebOffice.AppendMenu("43","禁止打开文件");
		    	iWebOffice.AppendMenu("44","允许打开文件");
		    	iWebOffice.AppendMenu("45","隐藏新建文件");
		    	iWebOffice.AppendMenu("46","显示新建文件");
		    	iWebOffice.AppendMenu("17","隐藏手写批注(&C)");
		        iWebOffice.AppendMenu("18","显示手写批注(&O)");
		    iWebOffice.AppendMenu("13<","工具栏，菜单定制");
		    
		    if(mFileType==".doc"){
		    	iWebOffice.AppendMenu("72>","word功能");
		    		iWebOffice.AppendMenu("63","word禁止拖动");
		    		iWebOffice.AppendMenu("65","插入页眉");
		    		iWebOffice.AppendMenu("66","插入页码");
		    		iWebOffice.AppendMenu("70","获取文档页数");
		    	iWebOffice.AppendMenu("72<","word功能");
		    }
		    
		    if(mFileType==".xls"){
		    	iWebOffice.AppendMenu("75>","excel功能");
		    		iWebOffice.AppendMenu("67","excel求和");
		    		iWebOffice.AppendMenu("68","锁定excel表格");
		    		iWebOffice.AppendMenu("69","excel禁止拖动");
		    	iWebOffice.AppendMenu("75<","excel功能");
		    }
		    */
		}
	    
	    //隐藏iWebOffice的工具栏，只保留"全屏"工具按钮。
	    iWebOffice.VisibleTools('新建文件,打开文件,保存文件,文字批注,手写批注,重新批注,文档清稿',false);
	    
	    /*20080822去掉没用到的工具栏
	    if(mShowType=="1" && mEditType=="0,0"){  //设置只读状态下菜单和工具栏的隐藏。
	        iWebOffice.VisibleTools('新建文件,打开文件,保存文件,文字批注,手写批注,重新批注,文档清稿',false);
	        //iWebOffice.ShowToolBar = 0;
            //iWebOffice.WebToolsVisible('Standard',false);      //关闭常用工具
            //iWebOffice.WebToolsVisible('Formatting',false);    //关闭格式按钮      
	    }else if(mShowType=="0" && mEditType=="1,0"){
	        //iWebOffice.VisibleTools('文字批注,手写批注,重新批注',false);
	        iWebOffice.VisibleTools('新建文件,打开文件,保存文件,文字批注,手写批注,重新批注,文档清稿',false);
	    }else{
	    	//iWebOffice.VisibleTools('文字批注,手写批注,重新批注,文档清稿',false);
	    	iWebOffice.VisibleTools('新建文件,打开文件,保存文件,文字批注,手写批注,重新批注,文档清稿',false);
	    }
	    */
	    
	    /*
	     注释的菜单项为提供给开发人员使用的开发接口。
	    
	    iWebOffice.AppendMenu("33","从服务器下载指定文件");
	    iWebOffice.AppendMenu("34","上载文件到服务器上");
	    iWebOffice.AppendMenu("35","打开远程文件");
	    iWebOffice.AppendMenu("36","插入远程服务器图片");
	    iWebOffice.AppendMenu("37","读取服务器时间");
	    iWebOffice.AppendMenu("38","设置本地时间为服务器时间");
	    iWebOffice.AppendMenu("39","保护文档");
	    iWebOffice.AppendMenu("40","解除保护");
	    iWebOffice.AppendMenu("41","禁止拷贝");
	    iWebOffice.AppendMenu("42","允许拷贝"); 
	    iWebOffice.AppendMenu("47","显示控件版本");
	    iWebOffice.AppendMenu("57","导入text");
	    iWebOffice.AppendMenu("58","导出text");
	    iWebOffice.AppendMenu("59","插入远程表格");
	    iWebOffice.AppendMenu("60","读word内容");
	    iWebOffice.AppendMenu("62","写word内容");
	    */
	   
	    //End
	    if(mShowType=="1" && mEditType=="0,0"){  //设置只读状态下word工具栏的隐藏。
	        iWebOffice.ToolsSpace = false;
	    }
	    iWebOffice.WebOpen();							        //打开该文档    交互OfficeServer  调出文档OPTION="LOADFILE"    调出模板OPTION="LOADTEMPLATE"     <参考技术文档>
	    iWebOffice.ShowType=mShowType;				            //文档显示方式  1:表示文字批注  2:表示手写批注  0:表示文档核稿
	    //文档核稿，文档核稿带套红，清稿有痕迹 这三种状态默认显示用户签批列表
		if((mEditType=="2,0" && mShowType=="0") || (mEditType=="1,0" && mShowType=="0")){
	        iWebOffice.ShowUsers=true;                              
	    }
	    if(mShowType=="1" && mEditType=="0,0"){  //设置只读状态下word工具栏的隐藏。
	        creator_hideAllTools();
	    }	
	    StatusMsg(iWebOffice.Status);					        //状态信息
	    fcpubdata.webOfficeLoadOk = "1";                        //office控件加载完成。
	}catch(e){
	    //alert(e.description);									//显示出错误信息
	}
}

//创建新文档
function createWebOffice(mServerUrl,mRecordID,mTemplate,mFileName,mFileType,mUserName,mEditType,mShowType){
    if(mFileType!=".doc"){ //只有doc支持showType    visio和ppt不支持状态设置。
    	mShowType = "1";
    }   
 	try{
	    //以下属性必须设置，实始化iWebOffice       
	    var iWebOffice = document.getElementsByName("WebOffice")[0];  //获取控件对象。 
	    iWebOffice.WebUrl=insertDbName(mServerUrl);			    //WebUrl:系统服务器路径，与服务器文件交互操作，如保存、打开文档，重要文件
	    iWebOffice.RecordID=mRecordID;		        //RecordID:本文档记录编号
	    iWebOffice.Template=mTemplate;		        //Template:模板编号
	    iWebOffice.FileName=mFileName;		        //FileName:文档名称
	    iWebOffice.FileType=mFileType;		        //FileType:文档类型  .doc  .xls  .wps
	    iWebOffice.UserName=mUserName;		        //UserName:操作用户名，痕迹保留需要
	    iWebOffice.EditType=mEditType;		        //EditType:编辑类型  方式一、方式二  <参考技术文档>  
															//第一位可以为0,1,2,3 其中:0不可编辑;1可以编辑,无痕迹;2可以编辑,有痕迹,不能修订;3可以编辑,有痕迹,能修订；
															//第二位可以为0,1 其中:0不可批注,1可以批注。可以参考iWebOffice2006的EditType属性，详细参考技术白皮书
	    //modified by zhou.luo 2008-10-30 临时设置为30M
	    iWebOffice.MaxFileSize = 64 * 1024;			//最大的文档大小控制，默认是64M.
	    //Start  iWebOffice2006属性  以下属性可以不要
	    iWebOffice.Language="CH";					//Language:多语言支持显示选择   CH 简体 TW繁体 EN英文
	    var color1 = "#FF0000";//红色
	    var color2 = "#FF00FF";//深红色
	    var color3 = "#0000FF";//蓝色
	    var color4 = "#A020F0";//紫色
	    var color5 = "#191970";//深蓝色
	    var color6 = "#FF6100";//橙色
	    var color7 = "#228B22";//森林绿
	    var color8 = "#4169E1";//品蓝
	    var color9 = "#FF8000";//桔黄
	    var penColor = color1;
	    var color = Math.floor(Math.random()*10)+1;
	    switch(color){
	    	case 1: penColor = color1; break;
	    	case 2: penColor = color2; break;
	    	case 3: penColor = color3; break;
	    	case 4: penColor = color4; break;
	    	case 5: penColor = color5; break;
	    	case 6: penColor = color6; break;
	    	case 7: penColor = color7; break;
	    	case 8: penColor = color8; break;
	    	case 9: penColor = color9; break;
	    }
	    iWebOffice.PenColor= penColor;
	    iWebOffice.PenWidth="2";						//PenWidth:默认批注笔宽
	    iWebOffice.Print="1";						//Print:默认是否可以打印:1可以打印批注,0不可以打印批注
	    iWebOffice.ShowToolBar="1";					//ShowToolBar:是否显示工具栏:1显示,0不显示

	    
	    //让只读状态下不加载任何菜单
	    if(mShowType=="1" && mEditType=="0,0"){
	        iWebOffice.ShowMenu="0";
	    }else{
		    //参数一:Index按钮编号,参数二:Caption按钮显示内容,参数三:Icon图标名称	    
		    if(fcpubdata.mLoadTool=="false"){
		        if(fcpubdata.mIsFirstLoad=="true"){
		        }
		        
		        if(mEditType=="2,0" && mShowType=="0"){
		    	    iWebOffice.AppendTools("24","清 稿",24);
		        }
		        if(mShowType=="1" && mEditType=="2,0" || mEditType=="3,0"){
		        	iWebOffice.AppendTools("25","显示痕迹",25);
		        	iWebOffice.AppendTools("26","隐藏痕迹",26);
		        }	    	
		    	fcpubdata.mLoadTool = "true";
		    }	      

		    if(fcpubdata.mIsFirstLoad =="true"){   //表示第一次加载office控件的时候。
		    	iWebOffice.AppendMenu("76>","新建空白文档");
		    		iWebOffice.AppendMenu("19","新建word文档");
		    		iWebOffice.AppendMenu("77","新建excel文档");
		    		iWebOffice.AppendMenu("78","新建wps文档");
		    		iWebOffice.AppendMenu("79","新建金山表格文档");
		    		iWebOffice.AppendMenu("80","新建ppt文档");
		    		iWebOffice.AppendMenu("81","新建visio文档");
		    	iWebOffice.AppendMenu("76<","新建空白文档");
		    	iWebOffice.AppendMenu("20","从模板新建");
		    }
		    	    
		    iWebOffice.AppendMenu("3","保存文件到服务器上(&W)");
		    iWebOffice.AppendMenu("1","打开本地文件(&L)");
		    iWebOffice.AppendMenu("2","保存本地文件(&S)");

		    iWebOffice.AppendMenu("7","-");
		    iWebOffice.AppendMenu("8","保存版本(&B)");
		    iWebOffice.AppendMenu("55","保存定稿版本");
		    iWebOffice.AppendMenu("9","打开版本(&D)");
		    iWebOffice.AppendMenu("10","-");		    
		    
		    iWebOffice.AppendMenu("16","打印文档(&P)");
		    iWebOffice.AppendMenu("64","打印黑白文档");  
		    iWebOffice.AppendMenu("32","关闭文档(&C)");
		    
		    iWebOffice.AppendMenu("文档管理","-");
		    if(fcpubdata.taohong=="1"){    //文档核稿带套红的时候显示 modified 2008-08-20
		    	iWebOffice.AppendMenu("21","模板套红");
		    }
		    if(mShowType=="1" && mEditType=="3,0"){   //修改有痕迹，可修订 
		    	iWebOffice.AppendMenu("12>","痕迹管理"); 
		    		iWebOffice.AppendMenu("24","显示痕迹");
		    		iWebOffice.AppendMenu("25","隐藏痕迹");
		    		iWebOffice.AppendMenu("48","获取痕迹");
		    		iWebOffice.AppendMenu("49","清除痕迹(接受痕迹)");
		    	iWebOffice.AppendMenu("12<","痕迹管理");
		    }
		    iWebOffice.AppendMenu("50","刷新文档");
		    iWebOffice.AppendMenu("51","重调文档");   
		}
	    //隐藏iWebOffice的工具栏，只保留"全屏"工具按钮。
	    iWebOffice.VisibleTools('新建文件,打开文件,保存文件,文字批注,手写批注,重新批注,文档清稿',false);

	    //End
	    if(mShowType=="1" && mEditType=="0,0"){  //设置只读状态下word工具栏的隐藏。
	        iWebOffice.ToolsSpace = false;
	    }
	    iWebOffice.CreateFile();
	    iWebOffice.ShowType=mShowType;				            //文档显示方式  1:表示文字批注  2:表示手写批注  0:表示文档核稿
	    //文档核稿，文档核稿带套红，清稿有痕迹 这三种状态默认显示用户签批列表
		if((mEditType=="2,0" && mShowType=="0") || (mEditType=="1,0" && mShowType=="0")){
	        iWebOffice.ShowUsers=true;                              
	    }
	    if(mShowType=="1" && mEditType=="0,0"){  //设置只读状态下word工具栏的隐藏。
	        creator_hideAllTools();
	    }	
	    StatusMsg(iWebOffice.Status);					        //状态信息
	    fcpubdata.webOfficeLoadOk = "1";                        //office控件加载完成。
	}catch(e){
	    //alert(e.description);									//显示出错误信息
	}
}

//作用：显示操作状态
function StatusMsg(mString){  
  //StatusBar.innerText=mString;
  //alert(mString);
}

//作用：退出iWebOffice
function UnLoadWebOffice(){  
  try{
	  var iWebOffice = document.getElementsByName("WebOffice")[0];  //获取控件对象。 
	  if(iWebOffice=="undefined"){
	  	 return;
	  }
	  if (!iWebOffice.WebClose()){
	     StatusMsg(iWebOffice.Status);
	  }else{
	     StatusMsg("关闭文档...");
	  }
	  //modified by zhou.luo 2008-12-30
      if(document.readyState!="complete"){
      	  alert("当前文档正在加载中...");
      	  return;
      }
  }catch(e){
    //alert(e.description);
  }
}

//保存为office文档格式的文档
//modified by zhou.luo 2009-02-04 添加一个允许保存的文档大小的最大值。maxFileSize的单位是mb
function saveAsOfficeDoc(maxFileSize){
	var iWebOffice = document.getElementsByName("WebOffice")[0];  //获取控件对象。
	if(!IsSpace(iWebOffice)){
		iWebOffice.WebSetMsgByName("saveAsOfficeDoc","1");  	
		if(!IsSpace(maxFileSize)){
			iWebOffice.MaxFileSize = maxFileSize*1024;
		}
  		if (!iWebOffice.WebSave(true)){    //交互OfficeServer的OPTION="SAVEFILE"  注：WebSave()是保存复合格式文件，包括OFFICE内容和手写批注文档；如只保存成OFFICE文档格式，那么就设WebSave(true)
     		return false;
  		}else{
     		return true;   
  		}
  	}  	
}

//作用：保存文档到服务器上，正文和文档附加信息都已经保存。不过是分两步保存的。isCreateIndex:是否建索引
function SaveDocument(saveNum,isCreateIndex){
  if(IsSpace(saveNum)){
      saveNum = 2;
  }
  var iWebOffice = document.getElementsByName("WebOffice")[0];  //获取控件对象。
  iWebOffice.Compressed = true;
  iWebOffice.WebSetMsgByName("saveAsOfficeDoc","0");
  iWebOffice.WebSetMsgByName("CONTENT",WebGetWordContent());
  iWebOffice.WebSetMsgByName("isCreateIndex",isCreateIndex);
  if(typeof(saveToFile) != "undefined" && (saveToFile == "1" ||saveToFile == "2") ){
	  iWebOffice.Compressed = false;
	  iWebOffice.WebSetMsgByName("saveToFile",saveToFile);
	  if(typeof(path) != "undefined" ){
		  iWebOffice.WebSetMsgByName("path",path);
	  }
	  if(typeof(filename) != "undefined" ){
		  iWebOffice.WebSetMsgByName("filename",filename);
	  }
  }  
  if(iWebOffice.WebGetMsgByName("saveToFile")=="1"||iWebOffice.WebGetMsgByName("saveToFile")=="2"){
	  if (!iWebOffice.WebSave(true)){    //交互OfficeServer的OPTION="SAVEFILE"  注：WebSave()是保存复合格式文件，包括OFFICE内容和手写批注文档；如只保存成OFFICE文档格式，那么就设WebSave(true)
		     StatusMsg(iWebOffice.Status);
		     if(iWebOffice.Status.indexOf("文件大于设定值")!=-1){
		         alert("文件大小超过允许保存的最大值：" + (iWebOffice.MaxFileSize/1024) +"M");
		         return false;
		     }
		     var time = 1;
		     var fastRet = false;
		     while(time < saveNum && !fastRet){
		         fastRet = iWebOffice.WebFastSave();
		         time++;
		     }
		     if(!fastRet){
		         return false;
		     }
		  }else{
		     StatusMsg(iWebOffice.Status);     
		  }
  }else  if (!iWebOffice.WebSave()){    //交互OfficeServer的OPTION="SAVEFILE"  注：WebSave()是保存复合格式文件，包括OFFICE内容和手写批注文档；如只保存成OFFICE文档格式，那么就设WebSave(true)
     StatusMsg(iWebOffice.Status);
     if(iWebOffice.Status.indexOf("文件大于设定值")!=-1){
         alert("文件大小超过允许保存的最大值：" + (iWebOffice.MaxFileSize/1024) +"M");
         return false;
     }
     var time = 1;
     var fastRet = false;
     while(time < saveNum && !fastRet){
         fastRet = iWebOffice.WebFastSave();
         time++;
     }
     if(!fastRet){
         return false;
     }
  }else{
     StatusMsg(iWebOffice.Status);     
  }
  
  iWebOffice.WebSetMsgByName("Subject","主题");
  iWebOffice.WebSetMsgByName("FileDate","时间");
  iWebOffice.WebSetMsgByName("HTMLPath","HTMLPath");
  iWebOffice.WebSetMsgByName("SaveStatus","READ");
  iWebOffice.WebSetMsgByName("djid",fcpubdata.djid);
  iWebOffice.WebSetMsgByName("TEMPLATE",iWebOffice.Template);   //template本该控件本身去设，但后台取值发现没有，所以在此自己设。

  iWebOffice.WebSetMsgByName("COMMAND","saveToTableDocument");
  if(iWebOffice.WebSendMessage()){ //将文档相关的信息发送到服务器后台处理页面：OfficeServer.jsp
  	 StatusMsg(iWebOffice.Status);    
  	 return true; 
  }else{
     StatusMsg(iWebOffice.Status);
     return false;
  }
}

//added by zhou.luo 2008-10-29
//作用：将当前word文档另存为一份新的word文档保存到服务器上，正文和文档附加信息都已经保存。不过是分两步保存的。
function SaveAsOtherDocument(wordid,saveNum,isCreateIndex){
  //webform.WebOffice.WebSetMsgByName("MyDefine1","自定义变量值1");  //设置变量MyDefine1="自定义变量值1"，变量可以设置多个  在WebSave()时，一起提交到OfficeServer中
  if(IsSpace(saveNum)){
      saveNum = 2;
  }
  var iWebOffice = document.getElementsByName("WebOffice")[0];  //获取控件对象。
  var temp = iWebOffice.RecordID;
  if(!IsSpace(wordid)){
      if(wordid.substring(0,1)!="w"){
          wordid = "w" + wordid;
      }
      iWebOffice.RecordID=wordid;
  }else{
      alert('请传递wordid！');
      iWebOffice.RecordID = temp;
      return false;
  }
  iWebOffice.Compressed = true;	
  iWebOffice.WebSetMsgByName("saveAsOfficeDoc","0");
  iWebOffice.WebSetMsgByName("CONTENT",WebGetWordContent());
  iWebOffice.WebSetMsgByName("isCreateIndex",isCreateIndex);
  if (!iWebOffice.WebSave()){    //交互OfficeServer的OPTION="SAVEFILE"  注：WebSave()是保存复合格式文件，包括OFFICE内容和手写批注文档；如只保存成OFFICE文档格式，那么就设WebSave(true)
     StatusMsg(iWebOffice.Status);
     if(iWebOffice.Status.indexOf("文件大于设定值")!=-1){
         iWebOffice.RecordID = temp;
         alert("文件大小超过允许保存的最大值：" + (iWebOffice.MaxFileSize/1024) +"M");
         return false;
     }
     var time = 1;
     var fastRet = false;
     while(time < saveNum && !fastRet){
         fastRet = iWebOffice.WebFastSave();
         time++;
     }
     if(!fastRet){
     	iWebOffice.RecordID = temp;
     	return false;
     }
  }else{
     StatusMsg(iWebOffice.Status);     
  }
  
  iWebOffice.WebSetMsgByName("Subject","主题");
  iWebOffice.WebSetMsgByName("FileDate","时间");
  iWebOffice.WebSetMsgByName("HTMLPath","HTMLPath");
  iWebOffice.WebSetMsgByName("SaveStatus","READ");
  iWebOffice.WebSetMsgByName("djid",fcpubdata.djid);
  iWebOffice.WebSetMsgByName("TEMPLATE",iWebOffice.Template);   //template本该控件本身去设，但后台取值发现没有，所以在此自己设。

  iWebOffice.WebSetMsgByName("COMMAND","saveToTableDocument");
  if(iWebOffice.WebSendMessage()){ //将文档相关的信息发送到服务器后台处理页面：OfficeServer.jsp
  	 StatusMsg(iWebOffice.Status);
  	 iWebOffice.RecordID = temp;    
  	 return true; 
  }else{
     StatusMsg(iWebOffice.Status);
     iWebOffice.RecordID = temp;
     return false;
  }
}

//作用：保存版本
function WebSaveVersion(){
 var WebOffice = document.getElementsByName("WebOffice")[0];  //获取控件对象。
 WebOffice.WebSaveVersion();  	//交互OfficeServer的OPTION="SAVEVERSION"
 StatusMsg(WebOffice.Status);

}
//作用：显示或隐藏痕迹[隐藏痕迹时修改文档没有痕迹保留]  true表示隐藏痕迹  false表示显示痕迹
function ShowRevision(mValue){
  var iWebOffice = document.getElementsByName("WebOffice")[0];  //获取控件对象。
  if (mValue){
     iWebOffice.WebShow(true);
     StatusMsg("显示痕迹...");
  }else{
     iWebOffice.WebShow(false);
     StatusMsg("隐藏痕迹...");
  }
}

//作用：验证印章A
function MyWebShowSignature(){  
  try{
    var iWebOffice = document.getElementsByName("WebOffice")[0];  //获取控件对象。
    iWebOffice.WebShowSignature();  	//交互OfficeServer的OPTION="LOADSIGNATURE"
    //StatusMsg(iWebOffice.Status);
  }catch(e){
  //alert(e.description);
  }
}

//作用：验证印章B
function MyWebCheckSignature(){  
  try{
    var iWebOffice = document.getElementsByName("WebOffice")[0];  //获取控件对象。
    var i=iWebOffice.WebCheckSignature();  	//交互OfficeServer的OPTION="LOADSIGNATURE"
    var checkmsg = "";
    if(i ==0){
    	checkmsg = "当前文档没有任何印章！";
    }else if(i>=1){
    	checkmsg = "当前文档有"+i+"个合法印章。";
    }else{
        checkmsg = "当前文档存在非法印章！";
    }
    //alert("检测结果："+i+"\r\n 注释: (=-1 有非法印章) (=0 没有任何印章) (>=1 有多个合法印章)");
    alert(checkmsg);
    StatusMsg(checkmsg);
  }catch(e){
  //alert(e.description);
  }
}

//作用：保存为HTML文档
function myWebSaveAsHtml(){
  try{    
    var iWebOffice = document.getElementsByName("WebOffice")[0];  //获取控件对象。
    if (iWebOffice.WebSaveAsHtml())  	//交互OfficeServer的OPTION="SAVEASHTML"
    {
      var url = fcpubdata.mWebOfficeRoot +"HTML/"+ fcpubdata.mRecordID + ".htm";
      window.open(url);      
    }
    StatusMsg(iWebOffice.Status);
  }catch(e){
  //alert(e.description);
  }
}

//作用：保存为html文档图片
function WebSaveAsPage(){
  try{
    var iWebOffice = document.getElementsByName("WebOffice")[0];  //获取控件对象。
    if (iWebOffice.WebSaveImage())  	//交互OfficeServer的OPTION="SAVEIMAGE"
    {
      var url = fcpubdata.mWebOfficeRoot +"HTMLIMAGE/"+ fcpubdata.mRecordID + ".htm";
      window.open(url);      
    }
    StatusMsg(iWebOffice.Status);
  }catch(e){
  //alert(e.description);
  }
}

//作用：关闭或显示工具 参数1表示工具条名称  参数2为false时，表示关闭  （名称均可查找VBA帮助）
//参数2为true时，表示显示
function WebToolsVisible(ToolName,Visible){
  try{
    var iWebOffice = document.getElementsByName("WebOffice")[0];  //获取控件对象。
    iWebOffice.WebToolsVisible(ToolName,Visible);
    StatusMsg(iWebOffice.Status);
  }catch(e){
  //alert(e.description);
  }
}


//作用：禁止或启用工具 参数1表示工具条名称  参数2表示工具条铵钮的编号  （名称和编号均可查找VBA帮助）
//参数3为false时，表示禁止  参数3为true时，表示启用
function WebToolsEnable(ToolName,ToolIndex,Enable){
  try{
    var iWebOffice = document.getElementsByName("WebOffice")[0];  //获取控件对象。
    iWebOffice.WebToolsEnable(ToolName,ToolIndex,Enable);
    StatusMsg(iWebOffice.Status);
  }catch(e){
  //alert(e.description);
  }
}

//关闭office文档，不会关闭页面
function myWebClose(){
	try{
		var iWebOffice = document.getElementsByName("WebOffice")[0];  //获取控件对象。
		if (!iWebOffice.WebClose()){
     		StatusMsg(iWebOffice.Status);
 		}else{
    		StatusMsg("关闭文档...");
 		}
 	}catch(e){
 		//alert(e.description);
 	}
}

//作用：下载服务器文件到本地
function myWebGetFile(){
  var iWebOffice = document.getElementsByName("WebOffice")[0];  //获取控件对象。
  if (iWebOffice.WebGetFile("c:\\WebGetFile.doc","DownLoad.doc")){   //交互OfficeServer的OPTION="GETFILE"  参数1表示本地路径  参数2表示服务器文件名称
    StatusMsg(iWebOffice.Status);
  }else{
    StatusMsg(iWebOffice.Status);
  }
  alert(iWebOffice.Status+"\r\n"+"文件放在c:\\WebGetFile.doc");
}


//作用：上传本地文件到服务器
function myWebPutFile(){
  var iWebOffice = document.getElementsByName("WebOffice")[0];  //获取控件对象。
  var mLocalFile=iWebOffice.WebOpenLocalDialog();
  if (mLocalFile!=""){
    alert(mLocalFile);
    if (iWebOffice.WebPutFile(mLocalFile,"luozhoulrj.doc")){   //交互OfficeServer的OPTION="PUTFILE"  参数1表示本地路径，可以任何格式文件  参数2表示服务器文件名称
      StatusMsg(iWebOffice.Status);
    }else{
      StatusMsg(iWebOffice.Status);
    }
    alert(iWebOffice.Status);
  }
}


//作用：打开远程文件
function myWebOpenRemoteFile(){
  var iWebOffice = document.getElementsByName("WebOffice")[0];  //获取控件对象。
  var url = fcpubdata.mWebOfficeRoot+"Document/luozhoulrj.doc"
  //alert("路径："+url);
  mResult=iWebOffice.WebDownLoadFile(url,"c:\\abc.doc");
  if (mResult){
    iWebOffice.WebOpenLocalFile("c:\\abc.doc");
    alert("成功");
  }else{
    alert("失败");
  }
}

//作用：插入远程服务器图片
function myWebInsertImage(){
  try{
    var iWebOffice = document.getElementsByName("WebOffice")[0];  //获取控件对象。
    iWebOffice.WebInsertImage('Image','GoldgridLogo.jpg',true,5);   //交互OfficeServer的OPTION="INSERTIMAGE"  参数1表示标签名称  参数2表示图片文件名  参数3为true透明  false表示不透明  参数4为4表示浮于文字上方  5表示衬于文字下方
    StatusMsg(iWebOffice.Status);
  }catch(e){
    //alert(e.description);
  }
}

//作用：参数为true表示与服务器端时间同步，设置本地时间为服务器时间；为false，表示只取服务器时间  [V6.0.1.5以上支持]
function myWebDateTime(type){
  	var iWebOffice = document.getElementsByName("WebOffice")[0];  //获取控件对象。
  	if(type){
  		mResult=iWebOffice.WebDateTime(true);   //交互OfficeServer的OPTION="DATETIME"   true表示返回并设置本地时间为服务器时间；false表示仅返回服务器时间
  	    alert("提示：已经设置本地时间为 "+mResult);    //该功能主要用于在痕迹保留时读取服务器时间
  	}else{
		mResult=iWebOffice.WebDateTime(false);   //交互OfficeServer的OPTION="DATETIME"   true表示返回并设置本地时间为服务器时间；false表示仅返回服务器时间  	
  		alert("返回的服务器时间为："+mResult);
  	}
}

//作用：保护与解除  参数1为true表示保护文档  false表示解除保护
function WebProtect(value,password){
  if(IsSpace(password)){
  	password = "";
  }
  try{
    var iWebOffice = document.getElementsByName("WebOffice")[0];  //获取控件对象。
    iWebOffice.WebSetProtect(value,password);  //""表示密码为空
  }catch(e){
  	//alert(e.description);
  }
}

//作用：允许与禁止拷贝功能  参数1为true表示允许拷贝  false表示禁止拷贝
function WebEnableCopy(value){
  try{
    var iWebOffice = document.getElementsByName("WebOffice")[0];  //获取控件对象。
    iWebOffice.CopyType=value;
    alert("copyType:"+iWebOffice.CopyType);
  }catch(e){
    //alert(e.description);
  }
}

//作用：获取痕迹
function WebGetRevisions(){
  var iWebOffice = document.getElementsByName("WebOffice")[0];  //获取控件对象。
  var Rev = iWebOffice.WebObject.Revisions;		//获取痕迹对象
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
function myWebReFresh(){
  var iWebOffice = document.getElementsByName("WebOffice")[0];  //获取控件对象。
  iWebOffice.WebReFresh();
  StatusMsg("文档已刷新...");
}

//作用：打开文档
function LoadDocument(){
  StatusMsg("正在打开文档...");
  var iWebOffice = document.getElementsByName("WebOffice")[0];  //获取控件对象。
  if (!iWebOffice.WebOpen()){  	//打开该文档    交互OfficeServer的OPTION="LOADFILE"
     StatusMsg(iWebOffice.Status);
  }else{
     StatusMsg(iWebOffice.Status);
  }
}

//作用：标签管理 之 打开标签
function myWebOpenBookMarks(){
  try{
    var iWebOffice = document.getElementsByName("WebOffice")[0];  //获取控件对象。
    iWebOffice.WebOpenBookmarks();  	//交互OfficeServer的OPTION="LISTBOOKMARKS"
    StatusMsg(iWebOffice.Status);
  }catch(e){
    //alert(e.description);
  }
}

//作用：设置书签值  vbmName:标签名称，vbmValue:标签值   标签名称注意大小写
function SetBookmarks(vbmName,vbmValue){
	try{
  		var iWebOffice = document.getElementsByName("WebOffice")[0];  //获取控件对象。
  		if (!iWebOffice.WebSetBookmarks(vbmName,vbmValue)){
     		StatusMsg(iWebOffice.Status);
  		}else{
     		StatusMsg(iWebOffice.Status);
  		}
  	}catch(e){
  		//alert(e.description);
  	}
}

//作用：根据标签名称获取标签值  vbmName:标签名称
function GetBookmarks(vbmName){
  try{
      var vbmValue;
  	  var iWebOffice = document.getElementsByName("WebOffice")[0];  //获取控件对象。
  	  vbmValue=webform.WebOffice.WebGetBookmarks(vbmName);
  }catch(e){
  	  //alert(e.description);
  }
  return vbmValue;
}

//作用：填充模板
function fillTemplate(){
  StatusMsg("正在填充模扳...");
  try{
  	  var iWebOffice = document.getElementsByName("WebOffice")[0];  //获取控件对象。
  	  if (!iWebOffice.WebLoadBookmarks()){  	//交互OfficeServer的OPTION="LOADBOOKMARKS"
          StatusMsg(iWebOffice.Status);
      }else{
          StatusMsg(iWebOffice.Status);
      }
  }catch(e){
  	  //alert(e.description);
  }
}

//作用：保存当前版本
function myWebSaveVersionByFileID(){
  var mText=window.prompt("请输入版本说明:","版本号:V");
  if (mText==null){
     mText="已修改版本.";
  }
  var iWebOffice = document.getElementsByName("WebOffice")[0];  //获取控件对象。
  iWebOffice.WebSaveVersionByFileID(mText);  	//交互OfficeServer的OPTION="SAVEVERSION"  同时带FileID值   <参考技术文档>
  StatusMsg(iWebOffice.Status);
}

//作用：保存定稿版本
function myWebUpdateFile(){
  var iWebOffice = document.getElementsByName("WebOffice")[0];  //获取控件对象。
  if (iWebOffice.WebUpdateFile()){                //交互OfficeServer的OPTION="UPDATEFILE"，类似WebSave()或WebSaveVersion()方法
     StatusMsg(iWebOffice.Status);
  }else{
     StatusMsg(iWebOffice.Status);
  }
}

//打印份数控制
function WebCopysCtrlPrint(){
	try{
	  var mCopies,objPrint;
	  var iWebOffice = document.getElementsByName("WebOffice")[0];  //获取控件对象。
	  objPrint = iWebOffice.WebObject.Application.Dialogs(88);     //打印设置对话框
	  if (objPrint.Display==-1){
	      mCopies=objPrint.NumCopies;    //取得需要打印份数    
	      iWebOffice.WebSetMsgByName("COMMAND","COPIES");
	      iWebOffice.WebSetMsgByName("OFFICEPRINTS",mCopies+"");   //设置变量OFFICEPRINTS的值，在WebSendMessage()时，一起提交到OfficeServer中
	      iWebOffice.WebSendMessage();                              //交互OfficeServer的OPTION="SENDMESSAGE"
	      if (iWebOffice.Status=="1") {
	         // alert("可以允许打印，注：该实例设置总文档打印份数2份");
	          StatusMsg("可以允许打印，注：该实例设置总文档打印份数2份");
	          objPrint.Execute;
	      }else{
	      	  alert("已超出允许的打印份数");
	      	  StatusMsg("已超出允许的打印份数");
	      	  return false;
	      }
	  }
	}catch(e){alert(e.description);}
}

//作用：导入Text
function WebImportText(){
    var mText;
    var iWebOffice = document.getElementsByName("WebOffice")[0];  //获取控件对象。
    iWebOffice.WebSetMsgByName("COMMAND","INPORTTEXT");  //设置变量COMMAND="INPORTTEXT"，在WebSendMessage()时，一起提交到OfficeServer中
    if (iWebOffice.WebSendMessage()){                    //交互OfficeServer的OPTION="SENDMESSAGE"
      mText=iWebOffice.WebGetMsgByName("CONTENT");       //取得OfficeServer传递的变量CONTENT值
      iWebOffice.WebObject.Application.Selection.Range.Text=mText;
      alert("导入文本成功");
    }
    StatusMsg(iWebOffice.Status);
}


//作用：导出Text
function WebExportText(){
    var iWebOffice = document.getElementsByName("WebOffice")[0];  //获取控件对象。
    var mText=iWebOffice.WebObject.Content.Text;
    alert("导出的内容是："+mText);
    iWebOffice.WebSetMsgByName("COMMAND","EXPORTTEXT");  //设置变量COMMAND="EXPORTTEXT"，在WebSendMessage()时，一起提交到OfficeServer中
    iWebOffice.WebSetMsgByName("CONTENT",mText);         //设置变量CONTENT="mText"，在WebSendMessage()时，一起提交到OfficeServer中，可用于实现全文检索功能，对WORD的TEXT内容进行检索
    if (iWebOffice.WebSendMessage()){                    //交互OfficeServer的OPTION="SENDMESSAGE"
      alert("导出文本成功,可以导入到文件中，也可以导入到数据库中");
    }
    StatusMsg(iWebOffice.Status);
}

//作用：插入远程表格。  表格生成及填充
function WebSetWordTable(){
  var iWebOffice = document.getElementsByName("WebOffice")[0];  //获取控件对象。
  var mText="",mName="",iColumns,iCells,iTable;
  //设置COMMAND为WORDTABLE
  iWebOffice.WebSetMsgByName("COMMAND","WORDTABLE");   //设置变量COMMAND="WORDTABLE"，在WebSendMessage()时，一起提交到OfficeServer中
  //发送到服务器上
  //如果没有错误
  if (iWebOffice.WebSendMessage()){                //交互OfficeServer的OPTION="SENDMESSAGE"
	iColumns = iWebOffice.WebGetMsgByName("COLUMNS");  //取得列
	iCells = iWebOffice.WebGetMsgByName("CELLS");      //取得行
	iTable= iWebOffice.WebObject.Tables.Add(iWebOffice.WebObject.Application.Selection.Range,iCells,iColumns);   //生成表格
	for (var i=1; i<=iColumns; i++)
	{
   	  for (var j=1; j<=iCells; j++)
	  {
		mName=i.toString()+j.toString();
		mText=iWebOffice.WebGetMsgByName(mName);	 //取得OfficeServer中的表格内容
		iTable.Columns(i).Cells(j).Range.Text=mText;   	//填充单元值
	   }
	}
   }
   StatusMsg(iWebOffice.Status);
}

//作用：获取文档Txt正文
function WebGetWordContent(){
  try{
    var iWebOffice = document.getElementsByName("WebOffice")[0];  //获取控件对象。
    if(IsSpace(iWebOffice.WebObject.Content.Text)){
    	return "";
    }else{
    	return iWebOffice.WebObject.Content.Text;
    }
  }catch(e){
  //alert(e.description);
  }
}

//判断word文档是否有内容(检查了word中的文字和图片，表格属于文字部分)  true：有内容；false：没有
function WordHasContent(){
    var iWebOffice = document.getElementsByName("WebOffice")[0];  //获取控件对象。    
    if(iWebOffice.WebObject.Content.Text.length > 1 || iWebOffice.WebObject.Shapes.Count > 0 || iWebOffice.WebObject.InlineShapes.Count > 0){
    	return true;
    }else{
    	return false;
    }    
}

//作用：写Word内容
function WebSetWordContent(){
  var mText=window.prompt("请输入内容:","测试内容");
  var iWebOffice = document.getElementsByName("WebOffice")[0];  //获取控件对象。
  if (mText==null){
     return (false);
  }else{
     //下面为显示选中的文本
     //alert(iWebOffice.WebObject.Application.Selection.Range.Text);
     //下面为在当前光标出插入文本
     iWebOffice.WebObject.Application.Selection.Range.Text= mText+"\n";
     //下面为在第一段后插入文本
     //iWebOffice.WebObject.Application.ActiveDocument.Range(1).Text=(mText);
  }
}

//作用：打印黑白文档
function WebWordPrintBlackAndWhile(){
   var i,n;
   var iWebOffice = document.getElementsByName("WebOffice")[0];  //获取控件对象。
   //图片变黑白
   i=0;
   n=iWebOffice.WebObject.Shapes.Count;
   for (var i=1; i<=n; i++)
   {
      iWebOffice.WebObject.Shapes.Item(i).PictureFormat.ColorType=3;
   }
   i=0;
   n=iWebOffice.WebObject.InlineShapes.Count;
   for (var i=1; i<=n; i++)
   {
      iWebOffice.WebObject.InlineShapes.Item(i).PictureFormat.ColorType=3;
   }

   //文字变黑白
   iWebOffice.WebObject.Application.Selection.WholeStory();
   iWebOffice.WebObject.Application.Selection.Range.Font.Color = 0;
}

//作用：用Excel求和
function WebGetExcelContent(){
    var iWebOffice = document.getElementsByName("WebOffice")[0];  //获取控件对象。
    iWebOffice.WebObject.Application.Sheets(1).Select;
    iWebOffice.WebObject.Application.Range("C5").Select;
    iWebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "1";
    iWebOffice.WebObject.Application.Range("C6").Select;
    iWebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "2";
    iWebOffice.WebObject.Application.Range("C7").Select;
    iWebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "3";
    iWebOffice.WebObject.Application.Range("C5:C8").Select;
    iWebOffice.WebObject.Application.Range("C8").Activate;
    iWebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "=SUM(R[-3]C:R[-1]C)";
    iWebOffice.WebObject.Application.Range("D8").Select;
    alert(iWebOffice.WebObject.Application.Range("C8").Text);
}

//作用：锁定工作表，保护工作表单元
function WebSheetsLock(){
    var iWebOffice = document.getElementsByName("WebOffice")[0];  //获取控件对象。
    
    iWebOffice.WebObject.Application.Sheets(1).Select;

    iWebOffice.WebObject.Application.Range("A1").Select;
    iWebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "产品";
    iWebOffice.WebObject.Application.Range("B1").Select;
    iWebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "价格";
    iWebOffice.WebObject.Application.Range("C1").Select;
    iWebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "详细说明";
    iWebOffice.WebObject.Application.Range("D1").Select;
    iWebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "库存";
    iWebOffice.WebObject.Application.Range("A2").Select;
    iWebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "书签";
    iWebOffice.WebObject.Application.Range("A3").Select;
    iWebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "毛笔";
    iWebOffice.WebObject.Application.Range("A4").Select;
    iWebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "钢笔";
    iWebOffice.WebObject.Application.Range("A5").Select;
    iWebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "尺子";

    iWebOffice.WebObject.Application.Range("B2").Select;
    iWebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "0.5";
    iWebOffice.WebObject.Application.Range("C2").Select;
    iWebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "樱花";
    iWebOffice.WebObject.Application.Range("D2").Select;
    iWebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "300";

    iWebOffice.WebObject.Application.Range("B3").Select;
    iWebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "2";
    iWebOffice.WebObject.Application.Range("C3").Select;
    iWebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "狼毫";
    iWebOffice.WebObject.Application.Range("D3").Select;
    iWebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "50";

    iWebOffice.WebObject.Application.Range("B4").Select;
    iWebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "3";
    iWebOffice.WebObject.Application.Range("C4").Select;
    iWebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "蓝色";
    iWebOffice.WebObject.Application.Range("D4").Select;
    iWebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "90";

    iWebOffice.WebObject.Application.Range("B5").Select;
    iWebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "1";
    iWebOffice.WebObject.Application.Range("C5").Select;
    iWebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "20cm";
    iWebOffice.WebObject.Application.Range("D5").Select;
    iWebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "40";

    //保护工作表
    iWebOffice.WebObject.Application.Range("B2:D5").Select;
    iWebOffice.WebObject.Application.Selection.Locked = false;
    iWebOffice.WebObject.Application.Selection.FormulaHidden = false;
    iWebOffice.WebObject.Application.ActiveSheet.Protect(true,true,true);

    alert("已经保护工作表，只有B2-D5单元格可以修改。");
}

//作用：获取文档页数
function WebDocumentPageCount(){
    var iWebOffice = document.getElementsByName("WebOffice")[0];  //获取控件对象。
    if (iWebOffice.FileType==".doc"){
	var intPageTotal = iWebOffice.WebObject.Application.ActiveDocument.BuiltInDocumentProperties(14);
	alert("文档页总数："+intPageTotal);
    }
    if (iWebOffice.FileType==".wps"){
	var intPageTotal = iWebOffice.WebObject.PagesCount();
	alert("文档页总数："+intPageTotal);
    }
}

//作用：签章锁定文件功能
function WebSignatureAtReadonly(){
    var iWebOffice = document.getElementsByName("WebOffice")[0];  //获取控件对象。
    iWebOffice.WebSetProtect(false,"");                  //解除文档保护
    iWebOffice.WebSetRevision(false,false,false,false);  //设置文档痕迹保留的状态  参数1:不显示痕迹  参数2:不保留痕迹  参数3:打印时无痕迹  参数4:不允许复制
    try{
        iWebOffice.WebOpenSignature();                     //交互OfficeServer的 A签章列表OPTION="LOADMARKLIST"    B签章调出OPTION="LOADMARKIMAGE"    C确定签章OPTION="SAVESIGNATURE"    <参考技术文档>    文档中要定义标签Manager，可以自行修改标签名称
        StatusMsg(iWebOffice.Status);
    }catch(e){
    //alert(e.description);
    }
    iWebOffice.WebSetProtect(true,"");                   //锁定文档
}


//作用：保存为pdf文件
function myWebSaveAsPDF(){ 
	var iWebOffice = document.getElementsByName("WebOffice")[0];  //获取控件对象。
	try{
		if(iWebOffice.WebSavePDF()){
			var url = fcpubdata.mWebOfficeRoot +"PDF/"+ fcpubdata.mRecordID + ".pdf";
      		window.open(url);     
		}
		StatusMsg(iWebOffice.Status);
	}catch(e){
	//alert(e.description);
	}
}

//作用：快速保存文件，支持断点续传。先保存文件，再保存文件相关信息。
function myWebFastSave(isCreateIndex){   
	var iWebOffice = document.getElementsByName("WebOffice")[0];  //获取控件对象。
	try{
	   	iWebOffice.WebSetMsgByName("CONTENT",WebGetWordContent());
  		iWebOffice.WebSetMsgByName("isCreateIndex",isCreateIndex);
		if(iWebOffice.WebFastSave()){  //尽管是保存为一个文件，但该文件不能直接打开，打开就是乱码，
		                               //必须使用控件来加载这个文件，或者保存到数据库中去，从数据库中取。
			//var url = fcpubdata.mWebOfficeRoot +"FASTSAVE/"+ fcpubdata.mRecordID + fcpubdata.mFileType;
      		//window.open(url);     
      		iWebOffice.WebSetMsgByName("Subject","主题");
  			iWebOffice.WebSetMsgByName("FileDate","时间");
  			iWebOffice.WebSetMsgByName("HTMLPath","HTMLPath");
  			iWebOffice.WebSetMsgByName("SaveStatus","READ");
  			iWebOffice.WebSetMsgByName("djid",fcpubdata.djid);
  			iWebOffice.WebSetMsgByName("TEMPLATE",iWebOffice.Template);   //template本该控件本身去设，但后台取值发现没有，所以在此自己设。
  			iWebOffice.WebSetMsgByName("COMMAND","saveToTableDocument");
  			if(iWebOffice.WebSendMessage()){ //将文档相关的信息发送到服务器后台处理页面：OfficeServer.java
  	 			StatusMsg(iWebOffice.Status);    
  	 			return true; 
  			}else{
     			StatusMsg(iWebOffice.Status);
     			return false;
  			}
		}else{
			return false;
		}
		StatusMsg(iWebOffice.Status);
	}catch(e){
	//alert(e.description);
	}
}

/*20080617新增，iWebOffice接口，改变office控件的状态，并加载word 不推荐使用这个接口，应该使用下面这个：creator_loadWebOfficeByDocStatus*/
function creator_alterWordStatusAndLoad(mEditType,mShowType){
    fcpubdata.mIsAutoLoadWord = "false";
    if(fcpubdata.noneWorkflowWordId!="" || fcpubdata.cc_form_instanceid!="undefined"){
    	loadWebOffice(fcpubdata.mServerUrl,fcpubdata.mRecordID,fcpubdata.mTemplate,fcpubdata.mFileName,fcpubdata.mFileType,fcpubdata.mUserName,mEditType,mShowType)
	}
}

/*20080701新增,以指定状态加载office控件*/
function creator_loadWebOfficeByDocStatus(docStatus){
    fcpubdata.mIsAutoLoadWord = "false";
    setOfficeStatus(docStatus); //设置office文档的展示状态。
    if(fcpubdata.noneWorkflowWordId!="" || fcpubdata.cc_form_instanceid!="undefined"){
    	loadWebOffice(fcpubdata.mServerUrl,fcpubdata.mRecordID,fcpubdata.mTemplate,fcpubdata.mFileName,fcpubdata.mFileType,fcpubdata.mUserName,fcpubdata.mEditType,fcpubdata.mShowType)
	}
}

/*20080617新增，隐藏工具栏*/
function hiddenToolBar(){
     var iWebOffice = document.getElementsByName("WebOffice")[0];
     iWebOffice.ShowToolBar = 0;
     iWebOffice.WebToolsVisible('Standard',false);      //关闭常用工具
     iWebOffice.WebToolsVisible('Formatting',false);    //关闭格式按钮
}

/*20080623新增，iWebOffice接口，非流程里面使用word控件时，用来加载word的函数。根据wordId和显示状态参数打开word*/
function creator_loadWebOfficeByWordId(wordId,docStatus){
    setOfficeStatus(docStatus); //设置office文档的展示状态。
    if(!IsSpace(wordId)){
        wordId = "w"+wordId;
        var currentSystemID = creator_getSession("subsystem_id_nouse");
        var appUserName = "";
        if(!IsSpace(currentSystemID) && currentSystemID!="module"){
			appUserName = "APP_"+currentSystemID.toUpperCase()+".";
		}
    	var strsql_document1 = "select t.recordid,t.template,t.filetype from "
	   					          + appUserName+"td_octl_document t where "
	   					          + "t.recordid='"+wordId+"'";
	                
	    var sXml_document1 = SelectSql(strsql_document1,1,5);
	    if(sXml_document1 == "<root></root>"){//从数据库中查出来的记录为空,表示没有此文档。  				    
	   		alert("当前文档不存在!请核对wordid");		        
	    }else{   			   	    
	   		fcpubdata.mIsFirstLoad = "false";
	   		var oXml = SetDom(sXml_document1);
	   		//var len = oXml.documentElement.childNodes.length;
	   		//alert("记录条数1111："+oXml.documentElement.childNodes[len-1].text);
	   		//alert(sXml_document1);
	  		fcpubdata.mRecordID = oXml.documentElement.childNodes[0].childNodes[0].text;
	       	fcpubdata.mTemplate = oXml.documentElement.childNodes[0].childNodes[1].text;
	       	fcpubdata.mFileType = oXml.documentElement.childNodes[0].childNodes[2].text;
	       	fcpubdata.mFileName = fcpubdata.mRecordID+fcpubdata.mFileType;       				
	       	//alert("___1: "+fcpubdata.mTemplate+" ___2: "+fcpubdata.mFileType+" ___3: "+fcpubdata.mFileName);        		
            loadWebOffice(fcpubdata.mServerUrl,fcpubdata.mRecordID,fcpubdata.mTemplate,fcpubdata.mFileName,fcpubdata.mFileType,fcpubdata.mUserName,fcpubdata.mEditType,fcpubdata.mShowType);
        }
    }
}

//20080623新增，新建各种类型的空白文档的接口。
//               docType:文件类型  ".doc"; ".xls"; ".ppt"; ".visio"; ".wps"; ".et"
//               docStatus:文件的展现状态
//               wordid：非流程表单使用word控件时，需要传一个wordid，流程表单则不需要。
function creator_newWebOffice(docType,docStatus,wordid){
	setOfficeStatus(docStatus); //设置office文档的展示状态。
	
	if(fcpubdata.cc_form_instanceid!="undefined"){
		if(fcpubdata.cc_form_instanceid=="clear"){      //流程启动页面新建文档
		    fcpubdata.mIsFirstLoad = "true";
	   		//fcpubdata.mRecordID = getNewCc_form_instanceid("true");
            var session_cc_form_insid = fcpubdata.cc_form_instanceid;
            if(session_cc_form_insid=="clear"){
            	getNewCc_form_instanceid("true");
            } 
            //modify by zuojian.xiang 2009-4-15
            //将写死在程序中的weboffice1更改成变量creator_pt_webOfficeId
	   		fcpubdata.mRecordID = creator_getCtrlInsid(creator_pt_webOfficeId,fcpubdata.office_isBindForm);   
		}else{                                          //流程中新建文档  
			fcpubdata.mIsFirstLoad = "false";
			//fcpubdata.mRecordID = fcpubdata.cc_form_instanceid;
			fcpubdata.mRecordID = creator_getCtrlInsid(creator_pt_webOfficeId,fcpubdata.office_isBindForm);
		}
	}else{
		if(IsSpace(wordid)){     
			//alert("请传入wordid参数！");	
			fcpubdata.noneWorkflowWordId = "";
			return;
		}else{
		    wordid = "w" + wordid;
			fcpubdata.noneWorkflowWordId = wordid; 
		}
		fcpubdata.mRecordID = fcpubdata.noneWorkflowWordId;
	}
	fcpubdata.mTemplate = "";
	
	if(IsSpace(docType)){
		docType = ".doc";
	}
	
	fcpubdata.mFileType = docType;
	fcpubdata.mFileName = fcpubdata.mRecordID+fcpubdata.mFileType;
	var iWebOffice = document.getElementsByName("WebOffice")[0];
	if(iWebOffice.Version().substr(0,1)=='7'){
  		loadWebOffice(fcpubdata.mServerUrl,fcpubdata.mRecordID,fcpubdata.mTemplate,fcpubdata.mFileName,fcpubdata.mFileType,fcpubdata.mUserName,fcpubdata.mEditType,fcpubdata.mShowType);
  	}else{
  		createWebOffice(fcpubdata.mServerUrl,fcpubdata.mRecordID,fcpubdata.mTemplate,fcpubdata.mFileName,fcpubdata.mFileType,fcpubdata.mUserName,fcpubdata.mEditType,fcpubdata.mShowType);
  	}
}


//20080623新增，从模板新建各种类型文档的接口，需要知道templateid
//                     templateId : 模板id
//                     docType:文件类型  ".doc"; ".xls"; ".ppt"; ".visio"; ".wps"; ".et"
//                     docStatus:文件的展现状态
//                     wordid：非流程表单使用word控件时，需要传一个wordid，流程表单则不需要。
function creator_newWebOfficeFromTemplate(templateId,docType,docStatus,wordid){
	setOfficeStatus(docStatus); //设置office文档的展示状态。
	if(fcpubdata.cc_form_instanceid!="undefined"){
		if(fcpubdata.cc_form_instanceid=="clear"){      //流程启动页面新建文档
		    fcpubdata.mIsFirstLoad = "true";
	   		//fcpubdata.mRecordID = getNewCc_form_instanceid("true");
            var session_cc_form_insid = fcpubdata.cc_form_instanceid;
            if(session_cc_form_insid=="clear"){
            	getNewCc_form_instanceid("true");
            }
            //modify by zuojian.xiang 2009-4-15
            //将写死在程序中的weboffice1更改成变量creator_pt_webOfficeId
	   		fcpubdata.mRecordID = creator_getCtrlInsid(creator_pt_webOfficeId,fcpubdata.office_isBindForm);   //获取控件实例id
		}else{                                          //流程中新建文档  
			fcpubdata.mIsFirstLoad = "false";
			//fcpubdata.mRecordID = fcpubdata.cc_form_instanceid;
			fcpubdata.mRecordID = creator_getCtrlInsid(creator_pt_webOfficeId,fcpubdata.office_isBindForm);   //使用当前表单实例id所对应的控件实例id 
		}
	}else{
		if(IsSpace(wordid)){
			//alert("请传入wordid参数！");
			fcpubdata.noneWorkflowWordId = "";
			return;
		}else{
		    wordid = "w" + wordid;
			fcpubdata.noneWorkflowWordId = wordid; 
		}
		fcpubdata.mRecordID = fcpubdata.noneWorkflowWordId;
	}
	
	if(IsSpace(templateId)){
		fcpubdata.mTemplate = "";
	}else{
		fcpubdata.mTemplate = templateId;
	}
	
	if(IsSpace(docType)){
		docType = ".doc";
	}
	
	fcpubdata.mFileType = docType;
	fcpubdata.mFileName = fcpubdata.mRecordID+fcpubdata.mFileType;
	
	loadWebOffice(fcpubdata.mServerUrl,fcpubdata.mRecordID,fcpubdata.mTemplate,fcpubdata.mFileName,fcpubdata.mFileType,fcpubdata.mUserName,fcpubdata.mEditType,fcpubdata.mShowType);
	
}

//设置office文档的状态
function setOfficeStatus(docStatus){
	var mShowType = "1";
	var mEditType = "0,0"; //默认值:修改无痕迹
	if(!IsSpace(docStatus)){
	    if(docStatus=='只读' || docStatus=='readonly'){
	    	mShowType="1";
	    	mEditType = "4,0";
	    }else if(docStatus=='修改有痕迹' || docStatus=='trace'){
	        mShowType="1";
	        mEditType = "2,0";
	    }else if(docStatus=='领导手写批注' || docStatus=='endorse'){
		    mShowType="2";
		    mEditType = "3,1";
		}else if(docStatus=='文档核稿' || docStatus=='check'){
		    mShowType="0";
		    mEditType = "1,0";
		}else if(docStatus=='修改有痕迹可修订' || docStatus=='revise'){
	        mShowType="1";
	        mEditType = "3,0";
	    }else if(docStatus=='修改无痕迹' || docStatus == 'draft'){
	        mShowType="1";
	        mEditType = "1,0";
	    }else if(docStatus=='文档核稿带套红' || docStatus=='check2'){
	        mShowType="0";
	        mEditType = "1,0";
	        fcpubdata.taohong = "1";
	    }else if(docStatus == '清稿有痕迹' || docStatus == 'check3'){
	    	mShowType = "0";
	    	mEditType = "2,0";
	    }else if(docStatus == '文档核稿只读' || docStatus == 'check_readonly'){
	    	mShowType = "0";
	    	mEditType = "0,0";
	    }
	}
    fcpubdata.mShowType = mShowType;
	fcpubdata.mEditType = mEditType;
}

//20080812新增一个全屏的函数
function fullSize(){
	var iWebOffice = document.getElementsByName("WebOffice")[0];  //获取控件对象。
	iWebOffice.FullSize();
}

//20080822清稿
function cleanDoc(){
    var iWebOffice = document.getElementsByName("WebOffice")[0];  //获取控件对象。
    iWebOffice.WebObject.Application.ActiveDocument.AcceptAllRevisions();  //清稿
}

//20080826新增一个隐藏word所有工具栏的接口。
//modified by zhou.luo in 2008-10-04 保留常用工具栏。因为必须保留一个工具栏，否则会出现一个白条。
//modified by zhou.luo in 2008-10-08 更新了office控件的客户端版本，可以去掉白条。
function creator_hideAllTools(){
    var iWebOffice = document.getElementsByName("WebOffice")[0];
    var CommandBars = iWebOffice.WebObject.Application.CommandBars;
    var count = CommandBars.Count;
    for (i=1;i<count;i++){
        //alert("name:"+ CommandBars.Item(i).Name);
        //if(CommandBars.Item(i).Name=='Standard'){
            //保留一个常用工具栏
        //}else{
            iWebOffice.WebToolsVisible(CommandBars.Item(i).Name,false);
        //}
    }
    iWebOffice.WebToolsVisible("requirements",false);
    //将常用工具栏里面的一些工具栏禁用。
    //iWebOffice.WebToolsEnable('Standard','2521',false);
    //iWebOffice.WebToolsEnable('Standard','916',false);
    //iWebOffice.WebToolsEnable('Standard','204',false);
    //iWebOffice.WebToolsEnable('Standard','3900',false);
}

/* added by zhou.luo 2008-12-09
 * 提供给开发人员的接口，用于自己来控制word工具栏上面的按钮的显示*/
function creator_showTools(s_index){
	 var iWebOffice = document.getElementsByName("WebOffice")[0];
     var arr_index = new Array();
     s_index = s_index +"";
     if(s_index!=null && s_index.trim()!=""){
     	arr_index = s_index.split(",");
     }else if(s_index.trim()!=""){
         arr_index[0] = s_index;
     }
     for(var i = 0;i < arr_index.length;i++){
     	if(arr_index[i]=='24' || arr_index[i]=='清稿'){
     		 iWebOffice.AppendTools("24","清 稿",24);
     	}else if(arr_index[i]=='25' || arr_index[i]=='显示痕迹'){
     		iWebOffice.AppendTools("25","显示痕迹",25);
     	}else if(arr_index[i]=='26'|| arr_index[i]=='隐藏痕迹'){
     		iWebOffice.AppendTools("26","隐藏痕迹",26);
     	}else if(arr_index[i]=='27' || arr_index[i]=='模板套红'){
     		 iWebOffice.AppendTools("27","模板套红",27);
     	}else if(arr_index[i]=='888' || arr_index[i]=='电子印章'){
     		iWebOffice.AppendTools("888","电子印章",888);
     	}else if(arr_index[i]=='889' || arr_index[i]=='生成水印'){
     		iWebOffice.AppendTools("889","生成水印",889);
     	}
     }
}

//added by zhou.luo 2008-12-09 抽取的模板套红接口，方便加入到工具栏中。
function wordTemplateTaohong(){
   var iWebOffice = document.getElementsByName("WebOffice")[0];

    //add by chunqiu.zhao 2009-9-23
    toHome();
    iWebOffice.WebObject.Application.Selection.WholeStory();
    iWebOffice.WebObject.Application.Selection.Font.Name = "仿宋_GB2312";
	iWebOffice.WebObject.Application.Selection.Range.Font.Size = 16;
	iWebOffice.WebObject.Application.Selection.Range.ParagraphFormat.CharacterUnitFirstLineIndent = 2;
	iWebOffice.WebObject.Application.Selection.Range.ParagraphFormat.LineSpacingRule = 0;
	SaveDocument();
	//end
    
	var fileType = iWebOffice.FileType;		
	//modified by chunqiu.zhao var templateValue = window.showModalDialog("../../../iWebOffice2006/Template/Template_taoHong.jsp?fileType="+fileType,"","dialogWidth: 800px;");
	//modified by zhou.luo in 2008-10-14 套红前不保存文档就可以在第二次套红的时候去掉第一次套的红。
	//modified by zhou.luo 2008-12-09 套红前先设置红头书签为空，再删掉红头。先注释掉                              

	iWebOffice.Template = parent.templateValue;                             //获取模板编号
	if(iWebOffice.WebLoadTemplate()){                                //加载模板
		try{
			iWebOffice.WebObject.Bookmarks.Item("content").Select();
		}catch(e){}
		if(iWebOffice.WebInsertFile()){                              //插入正文到Content标签
			try{
		    	var webObject = iWebOffice.WebObject;
		    	if(typeof creator_operWebObject == "function"){			    		
		    		creator_operWebObject(webObject);
		    	}			    	
		    }catch(e){}
			StatusMsg(iWebOffice.Status);
			fcpubdata.webOfficeHadTaohong = "1";                     //成功套红。
		}else{
			StatusMsg(iWebOffice.Status);
		}
	}else{
		StatusMsg(iWebOffice.Status);
	}	
}

//added by zhou.luo 2008-12-09 用于获取word文档对象的接口
function creator_getWebObject(){
	var iWebOffice = document.getElementsByName("WebOffice")[0];
	return iWebOffice.WebObject;
}

    function creator_Pause(obj,iMinSecond)  //程序暂停函数
	{
	　　 if (window.eventList==null) window.eventList=new Array();
	　　 var ind=-1;
	　　 for (var i=0;i<window.eventList.length;i++)
	     {
	　　  if (window.eventList[i]==null)
	      {
	　　    window.eventList[i]=obj;
	　　    ind=i;
	　　    break;
	　　  }
	　　 }
	　　 
	    if (ind==-1)
	    {
	　　   ind=window.eventList.length;
	　　   window.eventList[ind]=obj;
	　　 }
	     setTimeout("GoOn(" + ind + ")",iMinSecond);
	}
	
	function GoOn(ind)
	{
	　　 var obj=window.eventList[ind];
	　　 window.eventList[ind]=null;
	　　 if (obj.NextStep) 
	       obj.NextStep();
	    //else obj();
	}
	function SaveDocumentWithPrompt()
	{
　　 	var prompt_txt = document.getElementById("prompt_txt");
		if(!IsSpace(prompt_txt))
		   	prompt_txt.style.display="block";
　　 	
		creator_Pause(this,1000);//调用暂停函数
		this.NextStep=function()
		{
　　  		var ret = SaveDocument();    //保存正文及文档附加信息。
      		if(ret==true)
      		{
      			alert("保存成功！");
      			if(!IsSpace(prompt_txt))
      				prompt_txt.style.display="none";
       		}
      		else
      		{
      			alert("保存失败！");
      			if(!IsSpace(prompt_txt))
      				prompt_txt.style.display="none";
      		}
　　 	}
　　}

//added by zhou.luo 2009-02-04
//将一个文档插入到另一个文档当前光标位置。用于做文档合并。
//返回值：true:插入成功；false：插入失败
function creator_insertFile(insertRecordId,fileName){
	var iWebOffice = document.getElementsByName("WebOffice")[0];
	var oldRecordId = iWebOffice.RecordID;
	var oldFilename = iWebOffice.FileName;
	iWebOffice.RecordID = insertRecordId;
	iWebOffice.FileName = fileName;
	var ret = iWebOffice.WebInsertFile();
	iWebOffice.RecordID = oldRecordId;
	iWebOffice.FileName = oldFilename;
	return ret;
}

//WORD文档换行
//added by zuojian.xiang 2009-03-23
function TypeParagraph(){
	var iWebOffice = document.getElementsByName("WebOffice")[0]; 
	iWebOffice.WebObject.Application.Selection.TypeParagraph();
}

//在光标位置插入并选中文本
//added by zuojian.xiang 2009-03-23
function selectText(text){
	var iWebOffice = document.getElementsByName("WebOffice")[0]; 
	iWebOffice.WebObject.Application.Selection.Text = text;
}

//对选定的内容加粗
//added by zuojian.xiang 2009-03-23
function Bold(){
	var iWebOffice = document.getElementsByName("WebOffice")[0]; 
	iWebOffice.WebObject.Application.Selection.Font.Bold="9999998";
}


//对齐方式 参数n，1为居中 2为右对齐 3为左对齐
//added by zuojian.xiang 2009-03-23
function algin(n){
	var iWebOffice = document.getElementsByName("WebOffice")[0]; 
	iWebOffice.WebObject.Application.Selection.ParagraphFormat.Alignment = n;
}

//设置选中字体大小 n越大字体越大
//added by zuojian.xiang 2009-03-23
function fontSize(n){
	var iWebOffice = document.getElementsByName("WebOffice")[0]; 
	iWebOffice.WebObject.Application.Selection.Font.Size = n;
}

//移动光标到行尾
//added by zuojian.xiang 2009-03-23
function toEnd(){
	var iWebOffice = document.getElementsByName("WebOffice")[0]; 
	iWebOffice.WebObject.Application.Selection.EndKey(5);
}

//移动光标到行头
//added by zuojian.xiang 2009-03-23
function toHome(){
	var iWebOffice = document.getElementsByName("WebOffice")[0]; 
	iWebOffice.WebObject.Application.Selection.HomeKey(5);
}

//光标向右移动,第一个表示移动的单位，"char"是1个字符，"word"是一个单词，第二个参数为移动的数量
//added by zuojian.xiang 2009-03-23
function moveRight(moveunit,num){
	var iWebOffice = document.getElementsByName("WebOffice")[0]; 
	if(moveunit=="char"){
		iWebOffice.WebObject.Application.Selection.MoveRight(1,num); 
	}
	if(moveunit=="word"){
		iWebOffice.WebObject.Application.Selection.MoveRight(2,num); 
	}
}

//光标向左移动,第一个表示移动的单位，"char"是1个字符，"word"是一个单词，第二个参数为移动的数量
//added by zuojian.xiang 2009-03-23
function moveLeft(moveunit,num){
	var iWebOffice = document.getElementsByName("WebOffice")[0]; 
	if(moveunit=="char"){
		iWebOffice.WebObject.Application.Selection.MoveLeft(1,num); 
	}
	if(moveunit=="word"){
		iWebOffice.WebObject.Application.Selection.MoveLeft(2,num); 
	}
}

//插入换页符号
//added by zuojian.xiang 2009-03-23
function insertBreak(){
	var iWebOffice = document.getElementsByName("WebOffice")[0]; 
	iWebOffice.WebObject.Application.Selection.InsertBreak(7);
}

//跳到指定位置
//added by zuojian.xiang 2009-03-23
//三个参数都为整数
//jumpUnit 1,表示为页跳转，3表示为行跳转;jumpTpye为整数 1表示绝对，2表示相对 ；num表示跳转数 
function jumpTo(jumpUnit,jumpTpye,num){
	var iWebOffice = document.getElementsByName("WebOffice")[0]; 
	iWebOffice.WebObject.Application.Selection.GoTo(jumpUnit,jumpTpye,num);  
}

//选中光标所在行
//added by zuojian.xiang 2009-03-23
function selectRow(){
	var iWebOffice = document.getElementsByName("WebOffice")[0]; 
	iWebOffice.WebObject.Application.Selection.HomeKey(5);
	iWebOffice.WebObject.Application.Selection.EndKey(5,1);
}

//改变选中字体颜色
//added by zuojian.xiang 2009-03-23
//color为CSS中去掉#号的16进制值
function changeColor(color){
	var iWebOffice = document.getElementsByName("WebOffice")[0]; 
	//var color = parseInt("&H"+colornum);
	iWebOffice.WebObject.Application.Selection.Font.Color=parseInt(color,16);  
}

//插入图片 filename为图片路径 n 4前5后
//added by zuojian.xiang 2009-03-25
function insertWebImage(fileName,n){
	var iWebOffice = document.getElementsByName("WebOffice")[0]; 
	var picture = iWebOffice.WebObject.Application.Selection.InlineShapes.AddPicture(fileName,false,true);
	picture.Select();
	var shape=picture.ConvertToShape();
	shape.WrapFormat.Type=3;
	shape.ZOrder(n);
}

//设置内置标题，方便建目录 
function setTitle(str){
	var iWebOffice = document.getElementsByName("WebOffice")[0];
	iWebOffice.WebObject.Application.Selection.Style = iWebOffice.WebObject.Styles(str);
}

//在光标位置插入目录
function generalMemu(){
	var iWebOffice = document.getElementsByName("WebOffice")[0];
	iWebOffice.WebObject.TablesOfContents.Add(iWebOffice.WebObject.Application.Selection.Range,true,1,3,true,"T",true,true,"",true,true,true);
	iWebOffice.WebObject.TablesOfContents(1).TabLeader = 1;
	iWebOffice.WebObject.TablesOfContents.Format = 0;
}

//更新目录
//added by zuojian.xiang 2009-03-30
function refreshMemu(){
	var iWebOffice = document.getElementsByName("WebOffice")[0];
	iWebOffice.WebObject.TablesOfContents(1).UpdatePageNumbers();
}

//插入二维条码接口
//rule：而为条码生成规则
//imageName：图像名称（可不填）
//added by zuojian.xiang 2009-04-28
function creatEWImage(rule,imageName){
	var data ="&ruleStr="+rule;
	if(IsSpace(imageName)!=true){
		data += "&imageName="+imageName;
	}
	SendHttp(location.protocol+"//"+location.host+ fcpubdata.servletPath + "/CreatorPTServlet?key=creatEWImage"+data,"",function(result){
		try{
			//var fileName = location.href.replace(/(http:\/\/.*?\/.*?\/)(.*)/g,"$1")+"ccapp/app_"+creator_getSession("subsystem_id_nouse")+"/EWImage/"+result.value;
			var fileName = location.href.replace(/(http:\/\/.*?\/.*?\/)(.*)/g,"$1")+"ccapp/EWImage/"+result.value;
			if(IsSpace(fileName)){
				alert("生成图片失败!");
				return;
			}
			var iWebOffice = document.getElementsByName("WebOffice")[0];
			var oframe = iWebOffice.WebObject;   
			var imgobj=  new Image(); 
			imgobj.src=fileName;
			imgobj.onload=function(){
				var imgWidth = imgobj.width;
				var imgHeight= imgobj.height;
				var myDocApp = oframe.Application;			
				var myDoc = oframe;
				var mySel = myDocApp.Selection;
				myDoc.Repaginate();	
				mySel.GoTo(1, -1,1); 
				var anchor = myDocApp.Selection.Range;
				var linktofile = false;
				var savewithdocument = true;
				var fvertical = false; 
				var myPageSetup = mySel.Paragraphs(1).Range.PageSetup;
				var left = myPageSetup.PageWidth - myPageSetup.RightMargin -myDocApp.CentimetersToPoints(4)- myPageSetup.LeftMargin-myDocApp.CentimetersToPoints(0.3);
				var top = myPageSetup.PageHeight-myPageSetup.BottomMargin-myPageSetup.TopMargin-myDocApp.CentimetersToPoints(1)-myDocApp.CentimetersToPoints(0.1);		
				var picture = myDoc.Shapes.AddPicture(fileName, linktofile, savewithdocument,left,top,imgWidth,imgHeight,anchor);	
				picture.Select();
				picture.ScaleHeight(1,true);
				picture.ScaleWidth(1,true);
				
				//删除服务器图片文件
				SendHttp(location.protocol+"//"+location.host+ fcpubdata.servletPath + "/CreatorPTServlet?key=deleteEWImage&fileName="+result.value);
			}
		}catch(e){
			alert(e.message);
		}
	},"noroot"
	);
}
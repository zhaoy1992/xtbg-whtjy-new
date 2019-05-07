<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.io.*,
				 java.sql.*,
				 java.text.SimpleDateFormat,
				 java.util.Date,
				 com.chinacreator.iWebOffice2006.iDBManager2000,
				 com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.core.process.processconfig.service.FlowInfoConfigServiceIfc"%>
<%@page import="com.chinacreator.xtbg.core.process.processconfig.service.impl.FlowInfoConfigServiceImpl"%>
<%@page import="org.apache.log4j.Logger"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.OASystemCache" %>
<%
  String windowId= request.getParameter("windowsId");
  AccessControl control = AccessControl.getInstance();
  control.checkAccess(request,response);
  String cebversion = OASystemCache.getContextProperty("cebversion");
  String currentSystemID = control.getCurrentSystemID();
  String user_id = control.getUserID();
  String appUserName = "";
  if(currentSystemID.equalsIgnoreCase("module")){
  	 appUserName = "";
  }else{
  	 appUserName = "APP_"+currentSystemID+".";
  }

%>
<%!
	public static final Logger logger = Logger.getLogger("iwebOffice2006.jsp文件:");
%>
<%
  ResultSet result=null;
  String mSubject=null;
  String mStatus=null;
  String mAuthor=null;
  String mFileName=null;
  String mFileDate=null;
  String mHTMLPath="";

  String mDisabled="";
  String mDisabledSave="";
  String mWord="";
  String mExcel="";
  
  //自动获取OfficeServer和OCX文件完整URL路径
  String mHttpUrlName=request.getRequestURI();
  String mScriptName=request.getServletPath();
  String mServerName = "OfficeServer.jsp";
  String mServerUrl="http://"+request.getServerName()+":"+request.getServerPort()+mHttpUrlName.substring(0,mHttpUrlName.lastIndexOf(mScriptName))+"/ccapp/oa/resources/plug/iWebOffice2009/"+mServerName;//取得OfficeServer文件的完整URL
  String mHttpUrl="http://"+request.getServerName()+":"+request.getServerPort()+mHttpUrlName.substring(0,mHttpUrlName.lastIndexOf(mScriptName))+"/ccapp/xtbg/resources/plug/iWebOffice2009/";

  String mRecordID=request.getParameter("RecordID");//草稿ID
  String textRecordID="text"+mRecordID;//正文ID
  String singnRecordID="singn"+mRecordID;//会签ID
  String openType = request.getParameter("openType");//打开类型
 
  String mTemplate=request.getParameter("Template");
  String mFileType=request.getParameter("FileType");
  String mEditType=request.getParameter("EditType");
  String mShowType=request.getParameter("ShowType"); 
  String _DBType=request.getParameter("DBType");
  String mUserName = control.getUserName();//request.getParameter("UserName");
  String submit_flag = request.getParameter("submit_flag");
  String ShowToolBar = request.getParameter("ShowToolBar");
  if(StringUtil.nullOrBlank(ShowToolBar)){
	  ShowToolBar = "1";
  }
  
  //取得编号
  if (mRecordID==null)
  {
     mRecordID="";	//编号为空
  }
  //取得模式
  if (mEditType==null)
  {
    mEditType="1,1";	//文档编辑类型  第一位可以为0,1,2,3 其中:0不可编辑;1可以编辑,无痕迹;2可以编辑,有痕迹,不能修订;3可以编辑,有痕迹,能修订；
                        //第二位可以为0,1 其中:0不可批注,1可以批注。可以参考iWebOffice2006的EditType属性，详细参考技术白皮书
  }
  //取得显示模式
  if (mShowType==null)
  {
    mShowType="1";	//文档显示方式  1:表示文字批注  2:表示手写批注  0:表示文档核稿
  }
  //取得类型
  if (mFileType==null)
  {
    mFileType=".doc";	// 默认为.doc文档
  }
  //取得用户名
  if (mUserName==null)
  {
    mUserName="用户名为空";
  }

  //取得模板
  if (mTemplate==null)
  {
    mTemplate="";	// 默认没有模板
  }
  //获取模板ID 这里用来获取该模板的会签内容配置
  FlowInfoConfigServiceIfc flowInfoConfigServiceIfc  = new FlowInfoConfigServiceImpl();
  String mTemplateid = request.getParameter("mTemplateid");
  mTemplateid =  mTemplateid.substring(4,mTemplateid.length());
  //获得面签配置
  String singnConfig = flowInfoConfigServiceIfc.getSingnConfig(mTemplateid);
%>
<html>
<head>
<title>在线查看</title>
<link rel='stylesheet' type='text/css' href='test.css'>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script type="text/javascript" src="../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script type="text/javascript" >jQuery.noConflict();</script>
<link rel='stylesheet' type='text/css' href='test.css'>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script type="text/javascript" src="../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>

<script language=javascript>

//作用：载入iWebOffice
function Load(){
	loadText();//加载正文
	loadSing();//加载会签
	var isMove = false;//是否移动过会签
	jQuery("#webofficDiv1").hide();
	jQuery("#webofficDiv1").show();

}
//正文初始化
function loadText(){
	try{
	    //以下属性必须设置，实始化iWebOffice
	    webform.WebOffice.WebUrl="<%=mServerUrl%>";			//WebUrl:系统服务器路径，与服务器文件交互操作，如保存、打开文档，重要文件
	    webform.WebOffice.RecordID="<%=mRecordID%>";		//打开正文
	    
	    webform.WebOffice.FileName="";		//FileName:文档名称
	    webform.WebOffice.FileType="<%=mFileType%>";		//FileType:文档类型  .doc  .xls  .wps
	    webform.WebOffice.UserName="<%=mUserName%>";		//UserName:操作用户名，痕迹保留需要
	    webform.WebOffice.EditType="<%=mEditType%>";		//EditType:编辑类型  方式一、方式二  <参考技术文档>  
															//第一位可以为0,1,2,3 其中:0不可编辑;1可以编辑,无痕迹;2可以编辑,有痕迹,不能修订;3可以编辑,有痕迹,能修订；
															//第二位可以为0,1 其中:0不可批注,1可以批注。可以参考iWebOffice2006的EditType属性，详细参考技术白皮书
	    webform.WebOffice.MaxFileSize = 64 * 1024;			//最大的文档大小控制，默认是64M，现在设置成16M。
	    //功能区最大化
		var mStatus = webform.WebOffice.Office2007Ribbon;
		if ((mStatus!=0) && (mStatus!=-1)){
			webform.WebOffice.Office2007Ribbon=0;
		}
	    webform.WebOffice.ExtParam="{_DBType:\"<%=_DBType%>\",textType:\"text\"}";       //夏天新增：
	    													//【DBType：数据库类型，暂时只支持保存文档和读取文档方法的底层切换】
	    													//可选项，document_file(默认值),fc_attach

	    var flag = webform.WebOffice.WebOpen(false);				//打开该文档    交互OfficeServer  调出文档OPTION="LOADFILE"    调出模板OPTION="LOADTEMPLATE"     <参考技术文档>
	    if(flag==false){//如果是初次整理，那么打开草稿
	    	webform.WebOffice.RecordID="<%=mRecordID%>";		//打开正文
		    webform.WebOffice.ExtParam="{_DBType:\"<%=_DBType%>\",textType:\"\"}";       //夏天新增：
	    	webform.WebOffice.WebOpen(false);
	    	isMove = false;//如果是加载的正文，那么将是否整理过设置为true
	    }else{
	    	isMove = true;//如果是加载的正文，那么将是否整理过设置为true
	    }
	    webform.WebOffice.RecordID="<%=mRecordID%>";		//打开正文
	    webform.WebOffice.ShowType=<%=mShowType%>;				//文档显示方式  1:表示文字批注  2:表示手写批注  0:表示文档核稿

		webform.WebOffice.ShowMenu="0"	//不显示下拉菜单
		webform.WebOffice.VisibleTools("新建文件",false);
	    //webform.WebOffice.VisibleTools("打开文件",false);
	    webform.WebOffice.VisibleTools("文字批注",false);
	    webform.WebOffice.VisibleTools("手写批注",false);
	    webform.WebOffice.VisibleTools("文档清稿",false);
	    webform.WebOffice.VisibleTools("重新批注",false);
	    webform.WebOffice.VisibleTools("打开文件",false);
	    webform.WebOffice.VisibleTools("保存文件",false);
	    webform.WebOffice.VisibleTools("全屏",false);
	    
	    webform.WebOffice.AppendTools("13","打印预览",7);
	    webform.WebOffice.AppendTools("12","打  印",7);
	    //webform.WebOffice.AppendTools("14","删除页面",3);
	    webform.WebOffice.AppendTools("3","删除表格",3);
	    webform.WebOffice.AppendTools("4","删除段落",4);
	    webform.WebOffice.AppendTools("5","重新加载",5);
	    //webform.WebOffice.AppendTools("6","保存修订",6);
	    //webform.WebOffice.AppendTools("7","查看版本",7);
	    //webform.WebOffice.AppendTools("8","保存图片",8);
	     webform.WebOffice.AppendTools("10","移动面签",10);
	     webform.WebOffice.AppendTools("11","保存正文",11);
	 	 webform.WebOffice.AppendTools("9","查看面签",9);
	 	  
	    //响应工具栏事件
		webform.WebOffice.attachEvent("OnToolsClick",function(vIndex,vCaption){ 
		    if (vIndex==3){
		    	delTable(webform.WebOffice); //删除表格
		    };
		    if (vIndex==4){
		    	delSection(webform.WebOffice); //删除段落
		    };
		    if(vIndex==5){
		    	reOpen();//重新加载
		    }
		    if(vIndex==6){
		    	 webform.WebOffice.WebSaveVersionByFileID("zwid_"+"<%=mRecordID%>"); //保存修订
		    }
		    if(vIndex==7){
		    	 webform.WebOffice.WebOpenVersion();//查看版本
		    }
		    if(vIndex==8){
		    	 webform.WebOffice.WebSaveImage(".jpg");//查看版本
		    }
		    if(vIndex==9){
		    	viewQuery();//查看面签
		    }
		    if(vIndex==10){
		    	moveSingn();//整理面签
		    }
		    if(vIndex==11){
		    	saveFile("text");//保存正文
		    }
		    if(vIndex==12){ //打印
		    	webform.WebOffice.WebOpenPrint();
		    }
		    if (vIndex==13){//打印预览
		    	webform.WebOffice.WebObject.printPreview();
		    };
		    if (vIndex==14){//删除页面
		    	delPage(webform.WebOffice); //删除表格
		    };
		}); 
	    
	  }catch(e){
	    alert(e.description);//显示出错误信息
	  }
}

//面签内容初始化
function loadSing(){
	try{
	    //以下属性必须设置，实始化iWebOffice
	    webform.WebOffice1.WebUrl="<%=mServerUrl%>";			//WebUrl:系统服务器路径，与服务器文件交互操作，如保存、打开文档，重要文件

	    webform.WebOffice1.RecordID="<%=mRecordID%>";		//RecordID:本文档记录编号
	    webform.WebOffice1.FileName="";		//FileName:文档名称
	    webform.WebOffice1.FileType="<%=mFileType%>";		//FileType:文档类型  .doc  .xls  .wps
	    webform.WebOffice1.UserName="<%=mUserName%>";		//UserName:操作用户名，痕迹保留需要
	    webform.WebOffice1.EditType="<%=mEditType%>";		//EditType:编辑类型  方式一、方式二  <参考技术文档>  
															//第一位可以为0,1,2,3 其中:0不可编辑;1可以编辑,无痕迹;2可以编辑,有痕迹,不能修订;3可以编辑,有痕迹,能修订；
															//第二位可以为0,1 其中:0不可批注,1可以批注。可以参考iWebOffice12006的EditType属性，详细参考技术白皮书
	    webform.WebOffice1.MaxFileSize = 16 * 1024;			//最大的文档大小控制，默认是64M，现在设置成16M。

	    webform.WebOffice1.ExtParam="{_DBType:\"<%=_DBType%>\",textType:\"singn\"}";       //夏天新增：
	    													//【DBType：数据库类型，暂时只支持保存文档和读取文档方法的底层切换】
	    													//可选项，document_file(默认值),fc_attach

	    webform.WebOffice1.WebOpen(false);							//打开该文档    交互OfficeServer  调出文档OPTION="LOADFILE"    调出模板OPTION="LOADTEMPLATE"     <参考技术文档>
	    webform.WebOffice1.ShowType=<%=mShowType%>;				//文档显示方式  1:表示文字批注  2:表示手写批注  0:表示文档核稿

		webform.WebOffice1.ShowMenu="0"	//不显示下拉菜单
		webform.WebOffice1.VisibleTools("新建文件",false);
	    //webform.WebOffice1.VisibleTools("打开文件",false);
	    webform.WebOffice1.VisibleTools("文字批注",false);
	    webform.WebOffice1.VisibleTools("手写批注",false);
	    webform.WebOffice1.VisibleTools("文档清稿",false);
	    webform.WebOffice1.VisibleTools("重新批注",false);
	    webform.WebOffice1.VisibleTools("打开文件",false);
	    webform.WebOffice1.VisibleTools("保存文件",false);
	    webform.WebOffice1.VisibleTools("全屏",false);
	    
	    webform.WebOffice1.AppendTools("3","删除表格",3);
	    webform.WebOffice1.AppendTools("4","删除段落",4);
	    //webform.WebOffice1.AppendTools("5","重新加载",5);
	    //webform.WebOffice1.AppendTools("6","保存修订",6);
	    //webform.WebOffice1.AppendTools("7","查看版本",7);
	    //webform.WebOffice1.AppendTools("8","保存图片",8);
	    webform.WebOffice1.AppendTools("11","保存面签",11);
	 	webform.WebOffice1.AppendTools("9","查看正文",9);
	 	
	    //响应工具栏事件
		webform.WebOffice1.attachEvent("OnToolsClick",function(vIndex,vCaption){ 
		    if (vIndex==3){
		    	delTable(webform.WebOffice1); //删除表格
		    };
		    if (vIndex==4){
		    	delSection(webform.WebOffice1); //删除段落
		    };
		    if(vIndex==5){
		    	reOpen();//重新加载
		    }
		    if(vIndex==6){
		    	 webform.WebOffice1.WebSaveVersionByFileID("zwid_"+"<%=mRecordID%>"); //保存修订
		    }
		    if(vIndex==7){
		    	 webform.WebOffice1.WebOpenVersion();//查看版本
		    }
		    if(vIndex==8){
		    	 webform.WebOffice1.WebSaveImage(".jpg");//查看版本
		    }
		    if(vIndex==9){
		    	viewText();//查看正文
		    }
		    if(vIndex==11){
		    	saveFile("sign");//保存面签
		    }
		}); 
	    
	  }catch(e){
	    alert(e.description);//显示出错误信息
	  }
}
//保存文件
function saveFile(type){
	if(type=="sign"){
		WebAcceptAllRevisions();
		webform.WebOffice.RecordID="<%=mRecordID%>";
		webform.WebOffice1.ExtParam="{_DBType:\"<%=_DBType%>\",textType:\"singn\"}";      
		webform.WebOffice1.WebSave(true);
		webform.WebOffice1.Alert("保存面签成功！");
		getParentWindow("<%=windowId%>").wordiwebofficeJS.changeHtmlObjVal("hasText","true");
		//2、	WebSave([Boolean])
		//保存文档到服务器端。
		//true		保存为纯Office格式的文件
		//	false	保存为“Office+全文批注”内容的复合文档格式的文件
		//	无		不带参数时默认为false。
		//此处如果不用true保存，下载或者打开会出现乱码问题
	}else if(type=="text"){
		WebAcceptAllRevisions();
	    webform.WebOffice.RecordID="<%=mRecordID%>";
		webform.WebOffice.ExtParam="{_DBType:\"<%=_DBType%>\",textType:\"text\"}";      
		webform.WebOffice.WebSave(true);
		webform.WebOffice1.Alert("保存正文成功！");
		getParentWindow("<%=windowId%>").wordiwebofficeJS.changeHtmlObjVal("hasTextMQ","true");
	}
}

//接受文档中全部痕迹(整理过后去除痕迹)
function WebAcceptAllRevisions(){
  webform.WebOffice.WebObject.Application.ActiveDocument.AcceptAllRevisions();
  var mCount = webform.WebOffice.WebObject.Application.ActiveDocument.Revisions.Count;
  if(mCount>0){
    return false;
  }else{
    return true;
  }
}

//整理面签，将面签内容移动到文档1
function moveSingn(){
	var iWebOffice = document.getElementsByName("WebOffice")[0];//获取正文对象
	var iWebOffice1 = document.getElementsByName("WebOffice1")[0];//获取面签对象
	if(isMove){
		iWebOffice.Alert("面签内容已经进行过整理，如需再移动请先重新加载！");
		return false;
	}
	var singnConfig = "<%=singnConfig%>";
	if(singnConfig){
		var singnConfigs =singnConfig.split(",");
		var paragraphs;
		var tables;
		var paragraphs1 = iWebOffice1.WebObject.Paragraphs.Item(1);//获取面签段落
		//var tables1  = iWebOffice1.WebObject.Tables.Item(1);
		for(var i=0; i< singnConfigs.length;i++){
			var singType = singnConfigs[i].substr(0,1);//获取段落或者表格标记
			var ptnum = singnConfigs[i].substr(1,singnConfigs[i].length);//获取行数或者列数
			if(singType=="#"){//如果是段落
				var pcount = iWebOffice.WebObject.Paragraphs.Count
				if(pcount>0){
					paragraphs = iWebOffice.WebObject.Paragraphs.Item(ptnum);
					paragraphs.Range.Cut();
					paragraphs1.Range.Paste();
					//paragraphs.Range.Delete();
				}
			}else if(singType=="*"){//如果是会签
				var tcount =  iWebOffice.WebObject.Tables.Count;
				if(tcount>0){
					tables  = iWebOffice.WebObject.Tables.Item(1);//参数是1，代表取当前表
					tables.Range.Cut();
					paragraphs1.Range.Paste();
					//tables.Delete();
				}
			}
		}
		
		//由于移动面签时可能出现表格删除不掉的情况(复制过来的模板可能出现该情况，新建模板无此现象)，这里移动表格后将存在的表格删除。可能当正文出现表格时会出现问题。
		/* var tcount =  iWebOffice.WebObject.Tables.Count;
		for(var j=0; j< tcount;j++){
			tables  = iWebOffice.WebObject.Tables.Item(0);
			tables.Delete();
		} */
		isMove = true;
	}else{
		alert("关联的文档模板缺少'模板内容配置'信息,无法进行'移动面签'");
	}
	
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
//查看正文
function viewText(){
	//jQuery("#WebOffice1").css('POSITION','relative');
	jQuery("#webofficDiv1").show();
	//jQuery("#WebOffice1").css('POSITION','absolute');
	jQuery("#webofficDiv").show();
}

//查看面签内容
function viewQuery(){
	//jQuery("#WebOffice").css('POSITION','relative');
	jQuery("#webofficDiv").hide();
	//jQuery("#WebOffice1").css('POSITION','absolute');
	jQuery("#webofficDiv1").show();
}

//删除段落
function delSection(webform_WebOffice){
	var iWebOffice = webform_WebOffice;
	var paragraphs = iWebOffice.WebObject.Paragraphs;
	if(paragraphs.Count>0){
		var paragraph = paragraphs.Item(1);
		paragraph.Range.Delete();
	}
}

//删除表格
function delTable(webform_WebOffice){
	var iWebOffice = webform_WebOffice;
	var tables =  iWebOffice.WebObject.Tables;
	if(tables.Count>0){
		var table = tables.Item(1);	
		table.Delete();
	}
}

//删除页面
function delPage(webform_WebOffice){
	debugger;
	var iWebOffice = webform_WebOffice;
	var pages =  iWebOffice.WebObject.Sections;
	if(pages.Count>0){
		var page = pages.Item(1);	
		page.Range.Delete();
	}
}

//还原
function reOpen(){
	webform.WebOffice.RecordID="<%=mRecordID%>";
	webform.WebOffice.EditType="1,1";		
	webform.WebOffice.ExtParam="{_DBType:\"<%=_DBType%>\",textType:\"\"}";       //夏天新增：
	webform.WebOffice.WebOpen(false);
	//webform.WebOffice.RecordID="<%=mRecordID%>";
	webform.WebOffice1.CreateFile();
	isMove = false;
}
</script>
</head>
<body bgcolor="#ffffff" onload="Load()" onunload="UnLoad()">  <!--引导和退出iWebOffice ../../../../iWebOffice2006/DocumentSave.jsp-->
  <form name="webform" id="webform" method="post" action="iwebOffice2009.jsp?submit_flag=1" onsubmit="return SaveDocument();">  <!--保存iWebOffice后提交表单信息-->
    <input type="hidden" name="RecordID" value="<%=mRecordID%>">
    <input type="hidden" name="Template" value="<%=mTemplate%>">
    <input type="hidden" name="FileType" value="<%=mFileType%>">
    <input type="hidden" name="EditType" value="<%=mEditType%>">
    <input type="hidden" name="HTMLPath" value="<%=mHTMLPath%>">
 	<div id="webofficDiv" >
 	<!-- style='POSITION: absolute;TOP: -19px;' -->
 	<OBJECT id="WebOffice" height="100%" width="100%"  classid="clsid:8B23EA28-2009-402F-92C4-59BE0E063499" codebase="../../../resources/plug/iWebOffice2009/<%=cebversion %>"></OBJECT>
	</div>
	<div id="webofficDiv1" >
 	<OBJECT id="WebOffice1" height="100%" width="100%"  classid="clsid:8B23EA28-2009-402F-92C4-59BE0E063499" codebase="../../../resources/plug/iWebOffice2009/<%=cebversion %>"></OBJECT>
	</div>
	</form>
             
            
</body> 
</html>
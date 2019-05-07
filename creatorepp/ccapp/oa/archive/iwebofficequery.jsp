<%@ page contentType="text/html; charset=gb2312" %>
<%@ page import="java.io.*,
				 java.sql.*,
				 java.text.SimpleDateFormat,
				 java.util.Date,
				 com.chinacreator.iWebOffice2006.iDBManager2000,
				 com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="org.apache.log4j.Logger"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.OASystemCache" %>
<%
  String windowId= request.getParameter("windowsId");
  AccessControl control = AccessControl.getInstance();
  control.checkAccess(request,response);
  String currentSystemID = control.getCurrentSystemID();
  String user_id = control.getUserID();
  String appUserName = "";
  if(currentSystemID.equalsIgnoreCase("module")){
  	 appUserName = "";
  }else{
  	 appUserName = "APP_"+currentSystemID+".";
  }
  String cebversion = OASystemCache.getContextProperty("cebversion");
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

  String mRecordID=request.getParameter("RecordID");
  String mTemplate=request.getParameter("Template");
  String mFileType=request.getParameter("FileType");
  String mEditType=request.getParameter("EditType");
  String mShowType=request.getParameter("ShowType"); 
  String _DBType=request.getParameter("DBType");
  String mUserName = control.getUserName();//request.getParameter("UserName");
  String submit_flag = request.getParameter("submit_flag");
  String ShowToolBar = request.getParameter("ShowToolBar");
  mFileName = StringUtil.deNull(request.getParameter("mFileName"));
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
  
  String opentype = StringUtil.deNull(request.getParameter("opentype"));
%>
<html>
<head>
<title>在线查看</title>
<link rel='stylesheet' type='text/css' href='test.css'>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script type="text/javascript" src="../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script type="text/javascript" >jQuery.noConflict();</script>
<link rel='stylesheet' type='text/css' href='test.css'>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script type="text/javascript" src="../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>

<script language=javascript>

//作用：载入iWebOffice
function Load(){
  try{
    //以下属性必须设置，实始化iWebOffice
    webform.WebOffice.WebUrl="<%=mServerUrl%>";			//WebUrl:系统服务器路径，与服务器文件交互操作，如保存、打开文档，重要文件

    webform.WebOffice.RecordID="<%=mRecordID%>";		//RecordID:本文档记录编号
    webform.WebOffice.Template="<%=mTemplate%>";		//Template:模板编号
    webform.WebOffice.FileName="<%=mFileName%>";		//FileName:文档名称
    webform.WebOffice.FileType="<%=mFileType%>";		//FileType:文档类型  .doc  .xls  .wps
    webform.WebOffice.UserName="<%=mUserName%>";		//UserName:操作用户名，痕迹保留需要
    webform.WebOffice.EditType="<%=mEditType%>";		//EditType:编辑类型  方式一、方式二  <参考技术文档>  
														//第一位可以为0,1,2,3 其中:0不可编辑;1可以编辑,无痕迹;2可以编辑,有痕迹,不能修订;3可以编辑,有痕迹,能修订；
														//第二位可以为0,1 其中:0不可批注,1可以批注。可以参考iWebOffice2006的EditType属性，详细参考技术白皮书
    webform.WebOffice.MaxFileSize = 16 * 1024;			//最大的文档大小控制，默认是64M，现在设置成16M。
 	 //功能区最大化
	var mStatus = webform.WebOffice.Office2007Ribbon;
	if ((mStatus!=0) && (mStatus!=-1)){
		webform.WebOffice.Office2007Ribbon=0;
	}
    webform.WebOffice.ExtParam="{_DBType:\"<%=_DBType%>\"}";       //夏天新增：
    													//【DBType：数据库类型，暂时只支持保存文档和读取文档方法的底层切换】
    													//可选项，document_file(默认值),fc_attach

    webform.WebOffice.WebOpen();							//打开该文档    交互OfficeServer  调出文档OPTION="LOADFILE"    调出模板OPTION="LOADTEMPLATE"     <参考技术文档>
    webform.WebOffice.ShowType=<%=mShowType%>;				//文档显示方式  1:表示文字批注  2:表示手写批注  0:表示文档核稿

	webform.WebOffice.ShowMenu="0"	//不显示下拉菜单
	webform.WebOffice.VisibleTools("新建文件",false);
    //webform.WebOffice.VisibleTools("打开文件",false);
    webform.WebOffice.VisibleTools("文字批注",false);
    webform.WebOffice.VisibleTools("手写批注",false);
    webform.WebOffice.VisibleTools("文档清稿",false);
    webform.WebOffice.VisibleTools("重新批注",false);
    webform.WebOffice.VisibleTools("打开文件",false);
	if("jiaodui"=="<%=opentype%>"){//如果是校对
		webform.WebOffice.VisibleTools("保存文件",false);
		webform.WebOffice.AppendTools("1","保存文件",7);
	}
	if("zhuanbandan"=="<%=opentype%>"){//如果是转办单
		webform.WebOffice.VisibleTools("全屏",false);
		webform.WebOffice.AppendTools("1","保  存",7);
		webform.WebOffice.AppendTools("2","打  印",7);
	}
	webform.WebOffice.AppendTools("7","显示痕迹",7);
	webform.WebOffice.AppendTools("8","隐藏痕迹",7);
	webform.WebOffice.WebSetRevision(false,true,false,false);//默认打开设置为保留痕迹，不显示痕迹
	
	//响应工具栏事件
	webform.WebOffice.attachEvent("OnToolsClick",function(vIndex,vCaption){ 
		if (vIndex==1){
	    	var flag = webform.WebOffice.WebSave(true);
	    	 if (flag){
	    		 alert("保存成功！");
	    		 getParentWindow("<%=windowId%>").wordiwebofficeJS.changeHtmlObjVal("hasTextZBD","true");
    		 }else{
    			 alert("保存失败！");
    		}
	    };
		if (vIndex==2){
			printText();
	    };
	    if (vIndex==7){//显示痕迹
	    	ShowRevision(true);
	    };
	    if (vIndex==8){//隐藏痕迹
	    	ShowRevision(false);
	    };
	});
	
  }catch(e){
    alert(e.description);									//显示出错误信息
  }
}

//作用：显示或隐藏痕迹[隐藏痕迹时修改文档没有痕迹保留]  true表示隐藏痕迹  false表示显示痕迹
function ShowRevision(mValue){
  if (mValue){
	 webform.WebOffice.WebSetRevision(true,true,false,false);
  }else{
	 webform.WebOffice.WebSetRevision(false,true,false,false);
  }
}

//打印
function printText(){
	webform.WebOffice.WebOpenPrint();
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
 	<OBJECT id="WebOffice" height="100%" width="100%" style="POSITION: absolute;TOP: -19px;" classid="clsid:8B23EA28-2009-402F-92C4-59BE0E063499" codebase="../../../resources/plug/iWebOffice2009/<%=cebversion %>"></OBJECT>
	</div>
	</form>
             
            
</body> 
</html>
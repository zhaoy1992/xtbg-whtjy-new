<%@ page contentType="text/html; charset=gb2312" %>
<%@ page import="
                 java.sql.*,
                 com.chinacreator.iWebOffice2006.iDBManager2000,
                 com.chinacreator.security.AccessControl" %>
<%@page import="java.net.URLDecoder"%>
<%!
 String  escape (String src) {
	int i;  char j;
	StringBuffer tmp = new StringBuffer();
	tmp.ensureCapacity(src.length()*6);
	for (i=0;i<src.length() ;i++ )  {
		j = src.charAt(i);
		if (Character.isDigit(j) || Character.isLowerCase(j) || Character.isUpperCase(j))
			tmp.append(j);
		else if
		(j<256)
		{    
			tmp.append( "%" );
			if (j<16)
				tmp.append( "0" );
			tmp.append( Integer.toString(j,16) );
			}    else    {
				tmp.append( "%u" );
				tmp.append( Integer.toString(j,16) );
				}
		}
	return tmp.toString();
	}
%>
<%
  AccessControl control = AccessControl.getInstance();
  control.checkAccess(request,response);
  String currentSystemID = control.getCurrentSystemID();
  String appUserName = "";
  if(currentSystemID.equalsIgnoreCase("module")){
  	 appUserName = "";
  }else{
  	 appUserName = "APP_"+currentSystemID+".";
  }

  ResultSet result=null;

  String mDescript="";
  String mFileName="";

  String mHttpUrlName=request.getRequestURI();
  String mScriptName=request.getServletPath(); 

  String mServerUrl="http://"+request.getServerName()+":"+request.getServerPort()+mHttpUrlName.substring(0,mHttpUrlName.lastIndexOf(mScriptName))+"/servlet/officeServer";

  String mRecordID=request.getParameter("RecordID");
  String mFileType=request.getParameter("FileType");
  String modify=request.getParameter("modify");
  String mEditType="1,1";
  String mUserName=control.getUserID();
  String ids_str="",names_str="",grantType="";

  //取得模式
  if (mEditType==null)
  {
    mEditType="2,1";		//2 起草
  }
  //取得类型
  if ( mFileType==null)
  {
    mFileType=".doc";	// 默认为.doc文档
  }
  //取得用户名
  if (mUserName==null)
  {
    mUserName="金格科技";
  }

  //取得模板
  if ( mRecordID==null)
  {
    mRecordID="";	// 默认没有模板
  }

  //打开数据库
  iDBManager2000 DbaObj=new iDBManager2000();
  if (DbaObj.OpenConnection())
  {
    String mSql="Select * From "+appUserName+"TD_OCTL_Template_File Where RecordID='"+ mRecordID + "'";
    try
    {
      result=DbaObj.ExecuteQuery(mSql);
      if (result.next())
      {
        mRecordID=result.getString("RecordID");
        mFileName=result.getString("FileName");
        mFileType=result.getString("FileType");
        mDescript=result.getString("Descript");
      }
      else
      {
	//取得唯一值(mRecordID)
        java.util.Date dt=new java.util.Date();
        long lg=dt.getTime();
        Long ld=new Long(lg);
	//初始化值
        mRecordID=ld.toString();
        mFileName="公文模版"+mFileType;
        mFileType=mFileType;
        mDescript="发文公文模版";
      }
      
      result = DbaObj.ExecuteQuery("SELECT user_id,user_realname,granttype,role_id,role_name FROM "+appUserName+"td_octl_template_grant WHERE recordid='"+mRecordID+"'");
      while(result.next())
      {
         grantType = result.getString("granttype");
         if("user".equalsIgnoreCase(grantType))
         {
         	ids_str += result.getString("user_id").trim() +","; 
         	names_str += result.getString("user_realname").trim() + ",";
         }
         else if("role".equalsIgnoreCase(grantType))
         {
         	ids_str += result.getString("role_id").trim() +",";
         	names_str += result.getString("role_name").trim() + ",";
         }	
      }
      
      if(ids_str.length()>0)
           	ids_str = ids_str.substring(0,ids_str.length()-1);
         		
      if(names_str.length()>0)
            names_str = escape(names_str.substring(0,names_str.length()-1));
      
            
      result.close();
    }
    catch(Exception e)
    {
      System.out.println(e.toString());
    }
    DbaObj.CloseConnection() ;
  }
   
   String curOrgID = request.getParameter("orgID"); 
   String curOrgName = request.getParameter("orgName"); 
   String initRecordID = (String)request.getParameter("recordID");
   String initFileName = (String)request.getParameter("fileName");
   String flag = request.getParameter("flag");
%>

<html>
<head>
<title>模板管理</title>
<!-- link rel='stylesheet' type='text/css' href='../test.css'-->
<link rel="stylesheet" type="text/css"
			href="<%=request.getContextPath()%>/sysmanager/css/windows.css">
		<link rel="stylesheet" type="text/css"
			href="<%=request.getContextPath()%>/sysmanager/css/contentpage.css">
		<link rel="stylesheet" type="text/css"
			href="<%=request.getContextPath()%>/sysmanager/css/tab.winclassic.css">
			
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script type="text/javascript" src="../../eformsys/fceform/js/fcpub.js"></script>
<script language="javascript" for=WebOffice event="OnMenuClick(vIndex,vCaption)">
   if (vIndex==1){  //打开本地文件
      WebOpenLocal();
   }
   if (vIndex==2){  //保存本地文件
      WebSaveLocal();
   }
   if (vIndex==4){  //保存并退出
     SaveDocument();    //保存正文
     webform.submit();  //提交表单
   }
   if (vIndex==6){  //打印文档
      WebOpenPrint();
   }
   if(vIndex==7){  //重调文档
   	  LoadDocument();
   }
   if(vIndex==8){  //刷新文档
   	  WebReFresh();
   }
</script>

<script language=javascript>

//作用：显示操作状态
function StatusMsg(mString){
  //StatusBar.innerText=mString;
}

//作用：载入iWebOffice
function Load(){
  try{
  //以下属性必须设置，实始化iWebOffice
  webform.WebOffice.WebUrl="<%=mServerUrl%>";	//WebUrl:系统服务器路径，与服务器文件交互操作，如保存、打开文档，重要文件
  webform.WebOffice.RecordID="<%=mRecordID%>";	//RecordID:本文档记录编号
  webform.WebOffice.Template="<%=mRecordID%>";	//Template:模板编号
  webform.WebOffice.FileName="<%=mFileName%>";	//FileName:文档名称
  webform.WebOffice.FileType="<%=mFileType%>";	//FileType:文档类型  .doc  .xls  .wps
  webform.WebOffice.EditType="<%=mEditType%>";	//EditType:编辑类型  方式一、方式二  <参考技术文档>
  webform.WebOffice.UserName="<%=mUserName%>";	//UserName:操作用户名
  //以下属性可以不要
  webform.WebOffice.ShowToolBar="0";		//ShowToolBar:是否显示工具栏:1显示,0不显示
  webform.WebOffice.ShowMenu="1";		//ShowMenu:1 显示菜单  0 隐藏菜单
  webform.WebOffice.AppendMenu("1","打开本地文件(&L)");
  webform.WebOffice.AppendMenu("2","保存本地文件(&S)");
  webform.WebOffice.AppendMenu("3","-");
  webform.WebOffice.AppendMenu("4","保存至服务器(&E)");
  webform.WebOffice.AppendMenu("5","-");
  webform.WebOffice.AppendMenu("6","打印文档(&P)");
  webform.WebOffice.DisableMenu("宏(&M);选项(&O)...");      //禁止菜单
  
  webform.WebOffice.AppendMenu("文档管理","-");
  webform.WebOffice.AppendMenu("7","重调文档");
  webform.WebOffice.AppendMenu("8","刷新文档");
  if("new"=="<%=flag%>"){
  		webform.WebOffice.CreateFile();
  }else{
	  	webform.WebOffice.WebOpen();	//打开该文档  交互OfficeServer的OPTION="LOADTEMPLATE"
  }
  webform.WebOffice.WebObject.Saved=true;
  webform.WebOffice.ShowType=1;			//文档显示方式  1:表示文字批注  2:表示手写批注  0:表示文档核稿
  StatusMsg(webform.WebOffice.Status);
  document.all.names.value=unescape('<%=names_str%>');
  }catch(e){}
}

//作用：退出iWebOffice
function UnLoad(){
	  try{
	  if (!webform.WebOffice.WebClose()){
	     StatusMsg(webform.WebOffice.Status);
	  }else{
	     StatusMsg("关闭文档...");
	  }
	  }catch(e){}
}

function checkDocsave(){
	var result;
	try{
		result = webform.WebOffice.WebObject.Saved;
	}catch(e){ //iweboffice如果未保存的话，会出异常
		result = false;	
	}finally{
		
	}
	if(!result){
		return "您编写的文档还未保存!";
	}
}


//作用：打开文档
function LoadDocument(){
  StatusMsg("正在打开文档...");
  if (!webform.WebOffice.WebLoadTemplate()){  //交互OfficeServer的OPTION="LOADTEMPLATE"
     StatusMsg(webform.WebOffice.Status);
  }else{
     StatusMsg(webform.WebOffice.Status);
  }
}


//作用：刷新文档
function WebReFresh(){
  webform.WebOffice.WebReFresh();
  StatusMsg("文档已刷新...");
}


//作用：保存文档
function SaveDocument(){
  webform.WebOffice.WebClearMessage();            //清空iWebOffice变量
  if ("<%=mFileType%>"==".doc"){
    if (!webform.WebOffice.WebSaveBookMarks()){    //交互OfficeServer的OPTION="SAVEBOOKMARKS"
      StatusMsg(webform.WebOffice.Status);
      return false;
    }
  }
  //webform.WebOffice.WebSetMsgByName("MyDefine1","自定义变量值1");  //设置变量MyDefine1="自定义变量值1"，变量可以设置多个  在WebSaveTemplate()时，一起提交到OfficeServer中
  if (!webform.WebOffice.WebSaveTemplate(true)){    //交互OfficeServer的OPTION="SAVETEMPLATE"，参数true表示保存OFFICE文档
     StatusMsg(webform.WebOffice.Status);
     return false;
  }else{
     StatusMsg(webform.WebOffice.Status);
     return true;
  }
}

//作用：填充模板
function LoadBookmarks(){
  StatusMsg("正在填充模扳...");
  if (!webform.WebOffice.WebLoadBookmarks()){    //交互OfficeServer的OPTION="LOADBOOKMARKS"
     StatusMsg(webform.WebOffice.Status);
  }else{
     StatusMsg(webform.WebOffice.Status);
  }
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

//作用：打印文档
function WebOpenPrint(){
  try{
    webform.WebOffice.WebOpenPrint();
    StatusMsg(webform.WebOffice.Status);
  }catch(e){}
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
   }catch(e){

   }
}

//作用：标签管理
function WebOpenBookMarks(){
  try{
    webform.WebOffice.WebOpenBookmarks();    //交互OfficeServer的OPTION="LISTBOOKMARKS"
    StatusMsg(webform.WebOffice.Status);
  }catch(e){}
}

//作用：存为本地文件
function WebSaveLocal(){
  try{
    webform.WebOffice.WebSaveLocal();
    StatusMsg(webform.WebOffice.Status);
  }catch(e){}
}

//作用：打开本地文件
function WebOpenLocal(){
  try{
    webform.WebOffice.WebOpenLocal();
    StatusMsg(webform.WebOffice.Status);
  }catch(e){}
}

function backToPriorPage()
{
	if((typeof window.opener) == 'object')
	{
	   window.close();
	}
	else
	{
	   var sUrl = '../../eformsys/fceform/WebOffice_content.jsp?orgID=<%= curOrgID%>&orgName=<%= curOrgName%>&recordID=<%= initRecordID%>&fileName=<%= initFileName%>';
	   window.location.href=sUrl;
	}
}
function checkValue()
{
	var reg = /['"]/;
    var fileName = document.getElementById('fileName').value;
    if(arr = reg.exec(fileName)!= null)
    {
    	if(RegExp.index != -1)
    	{
    	  alert("模板名称中不能包含引号");
    	  return false;
    	}
    }
    var descript = document.getElementById('descript').value;
    if(arr = reg.exec(fileName)!= null)
    {
    	if(RegExp.index != -1)
    	{
    	  alert("模板说明中不能包含引号");
    	  return false;
    	}
    }
	var names = document.getElementById('names').value;
	if(IsSpace(names))
	{
		alert("[ 权限授予 ]不能为空");
		return false;
	}
	
	if(IsSpace(fileName)){
		alert("[ 模板名称 ]不能为空");
		return false;
	}
	
	return true;
}
function getGrantData()
{

	var id,name;

	var ret = showModalDialog('TemplateGrantSelect.jsp?time='+new Date()+'ids_str='+webform.ids.value+'&selectedTabPaneId='+webform.grantType.value,webform.ids.value+';'+webform.names.value+';'+webform.grantType.value,'dialogWidth: 500px;dialogHeight: 500px');
	//var ret = showModalDialog('TemplateGrantSelect.jsp',window,'dialogWidth: 500px;dialogHeight: 500px');
	if(ret!="undefined" && ret!=null)
	{
        var ret_arr = ret.split(";");
        webform.ids.value = ret_arr[0];
        webform.names.value = ret_arr[1];
        webform.grantType.value = ret_arr[ret_arr.length-1];
    }

}

function UrlDecode(str){
	  var ret=""; 
	  for(var i=0;i<str.length;i++){ 
	  	var chr = str.charAt(i); 
	    if(chr == "+"){ 
	      ret+=" "; 
	    }else if(chr=="%"){ 
	   		var asc = str.substring(i+1,i+3); 
		    if(parseInt("0x"+asc)>0x7f){ 
		    	ret+=asc2str(parseInt("0x"+asc+str.substring(i+4,i+6))); 
		      	i+=5; 
		    }else{ 
		      	ret+=asc2str(parseInt("0x"+asc)); 
		      	i+=2; 
		    } 
	    }else{ 
	      ret+= chr; 
	    } 
	  } 
	  return ret; 
	}
</script>
</head>
<%@ include file="/epp/css/cssControl.jsp"%><body onbeforeunload="return checkDocsave();" class="contentbodymargin" scroll="no" onload="Load()" onunload="UnLoad()"> <!--引导和退出iWebOffice-->

<form name="webform" method="post" action="TemplateSave.jsp" onsubmit="return SaveDocument();"> <!--保存iWebOffice后提交表单信息-->
<input type="hidden" name="RecordID" value="<%=mRecordID%>">
<input type="hidden" name="orgID" value="<%=curOrgID%>">
<input type="hidden" name="orgName" value="<%=curOrgName%>">
 <input type="hidden" name="modify" value="<%=modify%>">
<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="1" class="thin">
<tr>
  <td align="right"  width=64>模版名</td>
  <td >
  	<input type="text" id="fileName" name="FileName" value="<%=mFileName%>" size="40">
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;说明
    <input type="text" id="descript" name="Descript" value="<%=mDescript%>" size="40">
  </td>
</tr>

<tr>
  <td align=right  width=70>权限授予</td>
  <td >
  	<input id=ids name="ids" type="hidden" value=<%= ids_str%>>
  	<input id=grantType name="grantType" type="hidden" value=<%= grantType%>>
  	<input id=names readonly id="names" name="names" type="text" size="80"  >
   	&nbsp;&nbsp;&nbsp;&nbsp;
  	<input type="button" value="选择" onclick="getGrantData()" style="WIDTH: 75px; HEIGHT: 25px" >
  </td>
</tr>

<tr>
  <!--td align=right valign=top  class="TDTitleStyle" width=64>内容</td-->
  <td align=right valign=top width=64 height=90% >
                 <!-- <input type=button value="打印文档"  onclick="WebOpenPrint()">-->
                 <input type=button value="标签管理" onclick="window.open('../BookMark/BookMarkList.jsp','_blank','height=600,width=800,left=100,top=60')"/>
                 <input type=button value="插入标签"  onclick="WebOpenBookMarks()">
                 <input type=button value="填充模版"  onclick="LoadBookmarks()">
                 <!-- <input type=button value="重调文档"  onclick="LoadDocument()">
                 <input type=button value="刷新文档"  onclick="WebReFresh()">-->
                 <!-- <input type=button value="打开文件"  onclick="WebOpenLocal()">
                 <input type=button value="保存文件"  onclick="WebSaveLocal()"-->
                 <input type=submit value="   保存   " onclick="return checkValue()">
				 <!--<input type=button value="   返回   " onclick="history.back()">-->
				 <%-- <input type=button value="   返回   " onclick="window.location.replace('TemplateList.jsp?orgId=<%= curOrgId%>')">--%>
				 <input type=button value="   返回   " onclick="backToPriorPage()">
				 注意：只有点击"保存"后，所做的操作才有效！
  </td>

  <td height=90%>
        <table border=0 cellspacing='0' cellpadding='0' width='100%' height='100%' >
        <tr>
          <td bgcolor="menu">
            <!--调用iWebOffice，注意版本号，可用于升级
            <script src="../iWebOffice2006.js"></script>-->
            <jsp:include page="../iWebOffice2006.jsp" flush="true"/>
          </td>
        </tr>
        <tr>
          <td bgcolor=menu height='20'>
		<!-- <div id=StatusBar>状态栏</div>-->
          </td>
        </tr>
        </table>
  </td>
</tr>
</table>
</form>

</body>
</html>

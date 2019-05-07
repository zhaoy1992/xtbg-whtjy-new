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

  //ȡ��ģʽ
  if (mEditType==null)
  {
    mEditType="2,1";		//2 ���
  }
  //ȡ������
  if ( mFileType==null)
  {
    mFileType=".doc";	// Ĭ��Ϊ.doc�ĵ�
  }
  //ȡ���û���
  if (mUserName==null)
  {
    mUserName="���Ƽ�";
  }

  //ȡ��ģ��
  if ( mRecordID==null)
  {
    mRecordID="";	// Ĭ��û��ģ��
  }

  //�����ݿ�
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
	//ȡ��Ψһֵ(mRecordID)
        java.util.Date dt=new java.util.Date();
        long lg=dt.getTime();
        Long ld=new Long(lg);
	//��ʼ��ֵ
        mRecordID=ld.toString();
        mFileName="����ģ��"+mFileType;
        mFileType=mFileType;
        mDescript="���Ĺ���ģ��";
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
<title>ģ�����</title>
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
   if (vIndex==1){  //�򿪱����ļ�
      WebOpenLocal();
   }
   if (vIndex==2){  //���汾���ļ�
      WebSaveLocal();
   }
   if (vIndex==4){  //���沢�˳�
     SaveDocument();    //��������
     webform.submit();  //�ύ��
   }
   if (vIndex==6){  //��ӡ�ĵ�
      WebOpenPrint();
   }
   if(vIndex==7){  //�ص��ĵ�
   	  LoadDocument();
   }
   if(vIndex==8){  //ˢ���ĵ�
   	  WebReFresh();
   }
</script>

<script language=javascript>

//���ã���ʾ����״̬
function StatusMsg(mString){
  //StatusBar.innerText=mString;
}

//���ã�����iWebOffice
function Load(){
  try{
  //�������Ա������ã�ʵʼ��iWebOffice
  webform.WebOffice.WebUrl="<%=mServerUrl%>";	//WebUrl:ϵͳ������·������������ļ������������籣�桢���ĵ�����Ҫ�ļ�
  webform.WebOffice.RecordID="<%=mRecordID%>";	//RecordID:���ĵ���¼���
  webform.WebOffice.Template="<%=mRecordID%>";	//Template:ģ����
  webform.WebOffice.FileName="<%=mFileName%>";	//FileName:�ĵ�����
  webform.WebOffice.FileType="<%=mFileType%>";	//FileType:�ĵ�����  .doc  .xls  .wps
  webform.WebOffice.EditType="<%=mEditType%>";	//EditType:�༭����  ��ʽһ����ʽ��  <�ο������ĵ�>
  webform.WebOffice.UserName="<%=mUserName%>";	//UserName:�����û���
  //�������Կ��Բ�Ҫ
  webform.WebOffice.ShowToolBar="0";		//ShowToolBar:�Ƿ���ʾ������:1��ʾ,0����ʾ
  webform.WebOffice.ShowMenu="1";		//ShowMenu:1 ��ʾ�˵�  0 ���ز˵�
  webform.WebOffice.AppendMenu("1","�򿪱����ļ�(&L)");
  webform.WebOffice.AppendMenu("2","���汾���ļ�(&S)");
  webform.WebOffice.AppendMenu("3","-");
  webform.WebOffice.AppendMenu("4","������������(&E)");
  webform.WebOffice.AppendMenu("5","-");
  webform.WebOffice.AppendMenu("6","��ӡ�ĵ�(&P)");
  webform.WebOffice.DisableMenu("��(&M);ѡ��(&O)...");      //��ֹ�˵�
  
  webform.WebOffice.AppendMenu("�ĵ�����","-");
  webform.WebOffice.AppendMenu("7","�ص��ĵ�");
  webform.WebOffice.AppendMenu("8","ˢ���ĵ�");
  if("new"=="<%=flag%>"){
  		webform.WebOffice.CreateFile();
  }else{
	  	webform.WebOffice.WebOpen();	//�򿪸��ĵ�  ����OfficeServer��OPTION="LOADTEMPLATE"
  }
  webform.WebOffice.WebObject.Saved=true;
  webform.WebOffice.ShowType=1;			//�ĵ���ʾ��ʽ  1:��ʾ������ע  2:��ʾ��д��ע  0:��ʾ�ĵ��˸�
  StatusMsg(webform.WebOffice.Status);
  document.all.names.value=unescape('<%=names_str%>');
  }catch(e){}
}

//���ã��˳�iWebOffice
function UnLoad(){
	  try{
	  if (!webform.WebOffice.WebClose()){
	     StatusMsg(webform.WebOffice.Status);
	  }else{
	     StatusMsg("�ر��ĵ�...");
	  }
	  }catch(e){}
}

function checkDocsave(){
	var result;
	try{
		result = webform.WebOffice.WebObject.Saved;
	}catch(e){ //iweboffice���δ����Ļ�������쳣
		result = false;	
	}finally{
		
	}
	if(!result){
		return "����д���ĵ���δ����!";
	}
}


//���ã����ĵ�
function LoadDocument(){
  StatusMsg("���ڴ��ĵ�...");
  if (!webform.WebOffice.WebLoadTemplate()){  //����OfficeServer��OPTION="LOADTEMPLATE"
     StatusMsg(webform.WebOffice.Status);
  }else{
     StatusMsg(webform.WebOffice.Status);
  }
}


//���ã�ˢ���ĵ�
function WebReFresh(){
  webform.WebOffice.WebReFresh();
  StatusMsg("�ĵ���ˢ��...");
}


//���ã������ĵ�
function SaveDocument(){
  webform.WebOffice.WebClearMessage();            //���iWebOffice����
  if ("<%=mFileType%>"==".doc"){
    if (!webform.WebOffice.WebSaveBookMarks()){    //����OfficeServer��OPTION="SAVEBOOKMARKS"
      StatusMsg(webform.WebOffice.Status);
      return false;
    }
  }
  //webform.WebOffice.WebSetMsgByName("MyDefine1","�Զ������ֵ1");  //���ñ���MyDefine1="�Զ������ֵ1"�������������ö��  ��WebSaveTemplate()ʱ��һ���ύ��OfficeServer��
  if (!webform.WebOffice.WebSaveTemplate(true)){    //����OfficeServer��OPTION="SAVETEMPLATE"������true��ʾ����OFFICE�ĵ�
     StatusMsg(webform.WebOffice.Status);
     return false;
  }else{
     StatusMsg(webform.WebOffice.Status);
     return true;
  }
}

//���ã����ģ��
function LoadBookmarks(){
  StatusMsg("�������ģ��...");
  if (!webform.WebOffice.WebLoadBookmarks()){    //����OfficeServer��OPTION="LOADBOOKMARKS"
     StatusMsg(webform.WebOffice.Status);
  }else{
     StatusMsg(webform.WebOffice.Status);
  }
}

//���ã�������ǩֵ  vbmName:��ǩ���ƣ�vbmValue:��ǩֵ   ��ǩ����ע���Сд
function SetBookmarks(vbmName,vbmValue){
  if (!webform.WebOffice.WebSetBookmarks(vbmName,vbmValue)){
     StatusMsg(webform.WebOffice.Status);
  }else{
     StatusMsg(webform.WebOffice.Status);
  }
}

//���ã����ݱ�ǩ���ƻ�ȡ��ǩֵ  vbmName:��ǩ����
function GetBookmarks(vbmName){
  var vbmValue;
  vbmValue=webform.WebOffice.WebGetBookmarks(vbmName);
  return vbmValue;
}

//���ã���ӡ�ĵ�
function WebOpenPrint(){
  try{
    webform.WebOffice.WebOpenPrint();
    StatusMsg(webform.WebOffice.Status);
  }catch(e){}
}

//���ã�ҳ������
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

//���ã���ǩ����
function WebOpenBookMarks(){
  try{
    webform.WebOffice.WebOpenBookmarks();    //����OfficeServer��OPTION="LISTBOOKMARKS"
    StatusMsg(webform.WebOffice.Status);
  }catch(e){}
}

//���ã���Ϊ�����ļ�
function WebSaveLocal(){
  try{
    webform.WebOffice.WebSaveLocal();
    StatusMsg(webform.WebOffice.Status);
  }catch(e){}
}

//���ã��򿪱����ļ�
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
    	  alert("ģ�������в��ܰ�������");
    	  return false;
    	}
    }
    var descript = document.getElementById('descript').value;
    if(arr = reg.exec(fileName)!= null)
    {
    	if(RegExp.index != -1)
    	{
    	  alert("ģ��˵���в��ܰ�������");
    	  return false;
    	}
    }
	var names = document.getElementById('names').value;
	if(IsSpace(names))
	{
		alert("[ Ȩ������ ]����Ϊ��");
		return false;
	}
	
	if(IsSpace(fileName)){
		alert("[ ģ������ ]����Ϊ��");
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
<%@ include file="/epp/css/cssControl.jsp"%><body onbeforeunload="return checkDocsave();" class="contentbodymargin" scroll="no" onload="Load()" onunload="UnLoad()"> <!--�������˳�iWebOffice-->

<form name="webform" method="post" action="TemplateSave.jsp" onsubmit="return SaveDocument();"> <!--����iWebOffice���ύ����Ϣ-->
<input type="hidden" name="RecordID" value="<%=mRecordID%>">
<input type="hidden" name="orgID" value="<%=curOrgID%>">
<input type="hidden" name="orgName" value="<%=curOrgName%>">
 <input type="hidden" name="modify" value="<%=modify%>">
<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="1" class="thin">
<tr>
  <td align="right"  width=64>ģ����</td>
  <td >
  	<input type="text" id="fileName" name="FileName" value="<%=mFileName%>" size="40">
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;˵��
    <input type="text" id="descript" name="Descript" value="<%=mDescript%>" size="40">
  </td>
</tr>

<tr>
  <td align=right  width=70>Ȩ������</td>
  <td >
  	<input id=ids name="ids" type="hidden" value=<%= ids_str%>>
  	<input id=grantType name="grantType" type="hidden" value=<%= grantType%>>
  	<input id=names readonly id="names" name="names" type="text" size="80"  >
   	&nbsp;&nbsp;&nbsp;&nbsp;
  	<input type="button" value="ѡ��" onclick="getGrantData()" style="WIDTH: 75px; HEIGHT: 25px" >
  </td>
</tr>

<tr>
  <!--td align=right valign=top  class="TDTitleStyle" width=64>����</td-->
  <td align=right valign=top width=64 height=90% >
                 <!-- <input type=button value="��ӡ�ĵ�"  onclick="WebOpenPrint()">-->
                 <input type=button value="��ǩ����" onclick="window.open('../BookMark/BookMarkList.jsp','_blank','height=600,width=800,left=100,top=60')"/>
                 <input type=button value="�����ǩ"  onclick="WebOpenBookMarks()">
                 <input type=button value="���ģ��"  onclick="LoadBookmarks()">
                 <!-- <input type=button value="�ص��ĵ�"  onclick="LoadDocument()">
                 <input type=button value="ˢ���ĵ�"  onclick="WebReFresh()">-->
                 <!-- <input type=button value="���ļ�"  onclick="WebOpenLocal()">
                 <input type=button value="�����ļ�"  onclick="WebSaveLocal()"-->
                 <input type=submit value="   ����   " onclick="return checkValue()">
				 <!--<input type=button value="   ����   " onclick="history.back()">-->
				 <%-- <input type=button value="   ����   " onclick="window.location.replace('TemplateList.jsp?orgId=<%= curOrgId%>')">--%>
				 <input type=button value="   ����   " onclick="backToPriorPage()">
				 ע�⣺ֻ�е��"����"�������Ĳ�������Ч��
  </td>

  <td height=90%>
        <table border=0 cellspacing='0' cellpadding='0' width='100%' height='100%' >
        <tr>
          <td bgcolor="menu">
            <!--����iWebOffice��ע��汾�ţ�����������
            <script src="../iWebOffice2006.js"></script>-->
            <jsp:include page="../iWebOffice2006.jsp" flush="true"/>
          </td>
        </tr>
        <tr>
          <td bgcolor=menu height='20'>
		<!-- <div id=StatusBar>״̬��</div>-->
          </td>
        </tr>
        </table>
  </td>
</tr>
</table>
</form>

</body>
</html>

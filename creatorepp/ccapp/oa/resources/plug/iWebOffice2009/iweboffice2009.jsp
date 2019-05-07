<!-- ��������ҳ�� -->
<%@page import="java.util.Arrays"%>
<%@page import="java.util.HashSet"%>
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
  AccessControl control = AccessControl.getInstance();
  control.checkAccess(request,response);
  String currentSystemID = control.getCurrentSystemID();
  String cebversion = OASystemCache.getContextProperty("cebversion");
  String user_id = control.getUserID();
  String appUserName = "";
  if(currentSystemID.equalsIgnoreCase("module")){
  	 appUserName = "";
  }else{
  	 appUserName = "APP_"+currentSystemID+".";
  }

%>
<%!
	public static final Logger logger = Logger.getLogger("iwebOffice2006.jsp�ļ�:");
%>
<%
  ResultSet result=null;
  String mSubject=null;
  String mStatus=null;
  String mAuthor=null;
  String mFileName="";
  String mFileDate=null;
  String mHTMLPath="";

  String mDisabled="";
  String mDisabledSave="";
  String mWord="";
  String mExcel="";
  
  //�Զ���ȡOfficeServer��OCX�ļ�����URL·��
  String mHttpUrlName=request.getRequestURI();
  String mScriptName=request.getServletPath();
  String mServerName = "OfficeServer.jsp";
  String mServerUrl="http://"+request.getServerName()+":"+request.getServerPort()+mHttpUrlName.substring(0,mHttpUrlName.lastIndexOf(mScriptName))+"/ccapp/oa/resources/plug/iWebOffice2009/"+mServerName;//ȡ��OfficeServer�ļ�������URL
  String mHttpUrl="http://"+request.getServerName()+":"+request.getServerPort()+mHttpUrlName.substring(0,mHttpUrlName.lastIndexOf(mScriptName))+"/ccapp/xtbg/resources/plug/iWebOffice2009/";

  String mRecordID=request.getParameter("RecordID");
  String mTemplate=request.getParameter("Template");
  String mFileType=request.getParameter("fileType");
  String mEditType=request.getParameter("EditType");
  String mShowType=request.getParameter("ShowType"); 
  String fileType=request.getParameter("fileType");
  String _DBType=request.getParameter("DBType");
  String mUserName = control.getUserName();//request.getParameter("UserName");
  String submit_flag = request.getParameter("submit_flag");
  String ShowToolBar = request.getParameter("ShowToolBar");
  if(StringUtil.nullOrBlank(ShowToolBar)){
	  ShowToolBar = "1";
  }
  if(mRecordID!=null&&fileType!=null){
	  mFileName = mRecordID+fileType; //��װ���������ɵ��ļ�����
  }
  //ȡ�ñ��
  if (mRecordID==null)
  {
     mRecordID="";	//���Ϊ��

  }
  //ȡ��ģʽ
  if (mEditType==null)
  {
    mEditType="1,1";	//�ĵ��༭����  ��һλ����Ϊ0,1,2,3 ����:0���ɱ༭;1���Ա༭,�޺ۼ�;2���Ա༭,�кۼ�,�����޶�;3���Ա༭,�кۼ�,���޶���
                        //�ڶ�λ����Ϊ0,1 ����:0������ע,1������ע�����Բο�iWebOffice2006��EditType���ԣ���ϸ�ο�������Ƥ��
  }
  //ȡ����ʾģʽ
  if (mShowType==null)
  {
    mShowType="1";	//�ĵ���ʾ��ʽ  1:��ʾ������ע  2:��ʾ��д��ע  0:��ʾ�ĵ��˸�
  }
  //ȡ������
  if (mFileType==null)
  {
    mFileType=".doc";	// Ĭ��Ϊ.doc�ĵ�
  }
  //ȡ���û���
  if (mUserName==null)
  {
    mUserName="�û���Ϊ��";
  }

  //ȡ��ģ��
  if (mTemplate==null)
  {
    mTemplate="";	// Ĭ��û��ģ��
  }
  
  //��ʾ��ťshowBtn=7,8  ȥ�����水ť
  String showBtn = StringUtil.deNull(request.getParameter("showBtn"));
  String[] btns = showBtn.split(",");
  HashSet<String> btnSet = new HashSet<String>(Arrays.asList(btns));
%>
<html>
<head>
<title>���߲鿴</title>
<link rel='stylesheet' type='text/css' href='test.css'>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script type="text/javascript" >jQuery.noConflict();</script>
<link rel='stylesheet' type='text/css' href='test.css'>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>

<script language=javascript>

//���ã�����iWebOffice
function Load(){
  try{
    //�������Ա������ã�ʵʼ��iWebOffice
    webform.WebOffice.WebUrl="<%=mServerUrl%>";			//WebUrl:ϵͳ������·������������ļ������������籣�桢���ĵ�����Ҫ�ļ�

    webform.WebOffice.RecordID="<%=mRecordID%>";		//RecordID:���ĵ���¼���
    webform.WebOffice.Template="<%=mTemplate%>";		//Template:ģ����
    webform.WebOffice.FileName="<%=mFileName%>";		//FileName:�ĵ�����
    webform.WebOffice.FileType="<%=mFileType%>";		//FileType:�ĵ�����  .doc  .xls  .wps
    webform.WebOffice.UserName="<%=mUserName%>";		//UserName:�����û������ۼ�������Ҫ
    webform.WebOffice.EditType="<%=mEditType%>";		//EditType:�༭����  ��ʽһ����ʽ��  <�ο������ĵ�>  
														//��һλ����Ϊ0,1,2,3 ����:0���ɱ༭;1���Ա༭,�޺ۼ�;2���Ա༭,�кۼ�,�����޶�;3���Ա༭,�кۼ�,���޶���
														//�ڶ�λ����Ϊ0,1 ����:0������ע,1������ע�����Բο�iWebOffice2006��EditType���ԣ���ϸ�ο�������Ƥ��
    webform.WebOffice.MaxFileSize = 16 * 1024;			//�����ĵ���С���ƣ�Ĭ����64M���������ó�16M��
    //���������
	var mStatus = webform.WebOffice.Office2007Ribbon;
	if ((mStatus!=0) && (mStatus!=-1)){
		webform.WebOffice.Office2007Ribbon=0;
	}
    webform.WebOffice.ExtParam="{_DBType:\"<%=_DBType%>\"}";       //����������
    													//��DBType�����ݿ����ͣ���ʱֻ֧�ֱ����ĵ��Ͷ�ȡ�ĵ������ĵײ��л���
    													//��ѡ�document_file(Ĭ��ֵ),fc_attach

    webform.WebOffice.WebOpen();							//�򿪸��ĵ�    ����OfficeServer  �����ĵ�OPTION="LOADFILE"    ����ģ��OPTION="LOADTEMPLATE"     <�ο������ĵ�>
    webform.WebOffice.ShowType=<%=mShowType%>;				//�ĵ���ʾ��ʽ  1:��ʾ������ע  2:��ʾ��д��ע  0:��ʾ�ĵ��˸�

	webform.WebOffice.ShowMenu="0"	//����ʾ�����˵�
	webform.WebOffice.VisibleTools("�½��ļ�",false);
    //webform.WebOffice.VisibleTools("���ļ�",false);
    webform.WebOffice.VisibleTools("������ע",false);
    webform.WebOffice.VisibleTools("��д��ע",false);
    webform.WebOffice.VisibleTools("�ĵ����",false);
    webform.WebOffice.VisibleTools("������ע",false);
    webform.WebOffice.VisibleTools("���ļ�",false);
    webform.WebOffice.VisibleTools("�����ļ�",false);
    webform.WebOffice.AppendTools("10","��ӡԤ��",7);
    webform.WebOffice.AppendTools("9","��  ӡ",7);
   
    <%if(showBtn.length()==0){%>
    webform.WebOffice.AppendTools("2","����༭",2);
    <%}%>
    
    <%if(btnSet.contains("7")){%>
    webform.WebOffice.AppendTools("7","��ʾ�ۼ�",7);
    <%}%>
    
    <%if(btnSet.contains("8")){%>
    webform.WebOffice.AppendTools("8","���غۼ�",7);
    <%}%>
    //webform.WebOffice.AppendTools("3","ɾ�����",3);
    //webform.WebOffice.AppendTools("4","ɾ������",4);
   

    //��Ӧ�������¼�
	webform.WebOffice.attachEvent("OnToolsClick",function(vIndex,vCaption){ 
	    if (vIndex==3){
	    	delTable(); //ɾ�����
	    };
	    if (vIndex==4){
	    	delSection(); //ɾ������
	    };
	    
	    <%if(showBtn.length()==0){%>
	    if (vIndex==2){
	    	saveModify(); //ɾ������
	    };
	    <%}%>
	    <%if(btnSet.contains("7")){%>
	    if (vIndex==7){//��ʾ�ۼ�
	    	webform.WebOffice.WebSetRevision(true,true,false,false);
	    };
	    <%}%>
	    <%if(btnSet.contains("8")){%>
	    if (vIndex==8){//���غۼ�
	    	webform.WebOffice.WebSetRevision(false,true,false,false);
	    };
	    <%}%>
	    if (vIndex==9){//��ӡ
	    	webform.WebOffice.WebOpenPrint();
	    };
	    if (vIndex==10){//��ӡԤ��
	    	if(webform.WebOffice.FileType==".xls" || webform.WebOffice.FileType==".xlsx"){
	    		webform.WebOffice.Alert("��ʱ��֧��EXCEL��ӡԤ����")
	    		//webform.WebOffice.WebObject.ActiveSheet.PrintPreview();
	    		//webform.WebOffice.WebObject.printPreview();
	    	}else{
	    		webform.WebOffice.WebObject.printPreview();
	    	}
	    };
	}); 
    
  }catch(e){
    alert(e.description);									//��ʾ��������Ϣ
  }
}


//���ã��˳�iWebOffice
function UnLoad(){
  try{
  if (!webform.WebOffice.WebClose()){
     StatusMsg(webform.WebOffice.Status);
  }else{
	  
     StatusMsg("�ر��ĵ�...");
  }
  }catch(e){alert(e.description);}
}

//����༭
function saveModify(){
	var saveFalg = webform.WebOffice.WebSave(true);
	if(saveFalg){
		webform.WebOffice.Alert("����ɹ���");
	}
}

//ɾ������
function delSection(){
	var iWebOffice = document.getElementsByName("WebOffice")[0];
	var paragraphs = iWebOffice.WebObject.Paragraphs.Item(1);
	paragraphs.Range.Delete();
}

//ɾ�����
function delTable(){
	var iWebOffice = document.getElementsByName("WebOffice")[0];
	var tables  = iWebOffice.WebObject.Tables.Item(1);
	tables.Delete();
}
</script>
</head>
<body bgcolor="#ffffff" onload="Load()" onunload="">  <!--�������˳�iWebOffice ../../../../iWebOffice2006/DocumentSave.jsp-->
  <form name="webform" id="webform" method="post" action="iwebOffice2009.jsp?submit_flag=1" onsubmit="return SaveDocument();">  <!--����iWebOffice���ύ����Ϣ-->
    <input type="hidden" name="RecordID" value="<%=mRecordID%>">
    <input type="hidden" name="Template" value="<%=mTemplate%>">
    <input type="hidden" name="FileType" value="<%=mFileType%>">
    <input type="hidden" name="EditType" value="<%=mEditType%>">
    <input type="hidden" name="HTMLPath" value="<%=mHTMLPath%>">
 	<div id="webofficDiv" >
 	<OBJECT id="WebOffice" height="100%" width="100%" classid="clsid:8B23EA28-2009-402F-92C4-59BE0E063499" codebase="../../../resources/plug/iWebOffice2009/<%=cebversion %>"></OBJECT>
	</div>
	</form>
             
            
</body> 
</html>

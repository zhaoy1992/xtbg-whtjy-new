<%@ page contentType="text/html; charset=GBK" language="java" 
import="java.util.Date,java.text.SimpleDateFormat,java.util.StringTokenizer"%>
<%@page import="com.frameworkset.common.poolman.DBUtil"%>
<%@page import="com.chinacreator.security.AccessControl,java.util.List"%>
<%@page import="com.chinacreator.cms.sitemanager.*,com.chinacreator.cms.templatemanager.*
,com.chinacreator.cms.container.Template,com.chinacreator.cms.documentmanager.*"%>
<%@page import="com.chinacreator.cms.channelmanager.*"%>
<jsp:useBean id="date" scope="page" class="net.fiyu.edit.TimeStamp"/>
<%@ taglib uri="/WEB-INF/dictionary.tld" prefix="dict"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ include file="../../sysmanager/include/global1.jsp"%>

<%
	response.setHeader("Cache-Control", "no-cache"); 
	response.setHeader("Pragma", "no-cache"); 
	response.setDateHeader("Expires", -1);  
	response.setDateHeader("max-age", 0);

	AccessControl accesscontroler = AccessControl.getInstance();
    accesscontroler.checkAccess(request, response);
    String userid = accesscontroler.getUserID();
    String ext_org = accesscontroler.getChargeOrgName();
    String orgName = accesscontroler.getChargeOrg().getRemark5();
	//��ǰʱ��
	java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); 
	java.util.Date currentTime = new java.util.Date(); 
	String riqi = formatter.format(currentTime); 
	
	String channelname = request.getParameter("channelName");
	String siteid = request.getParameter("siteid");
	String channelId = request.getParameter("channelId");
	
	ChannelManager cm = new ChannelManagerImpl();
	//��ȡ��ѡƵ����ϸ��ģ��ID
	String selecttemplateid="-1";
	
	Template selecttemplate = cm.getDetailTemplateOfChannel(channelId);
	if(selecttemplate != null)
	{
		selecttemplateid = String.valueOf(selecttemplate.getTemplateId());
	}
	
	SiteManager siteManager = new SiteManagerImpl();
	String sitename = siteManager.getSiteInfo(siteid).getName();//վ������
	//�Ϸ���
	//String docpath = cm.getFilePath(channelId);
	////����Ƶ��id��վ��id��ȡ�ĵ�����·��(�·���) ����·��=վ��·��+Ƶ��·��
	String docpath = siteManager.getSiteInfo(siteid).getSiteDir() + "/_webprj/" + cm.getChannelInfo(channelId).getChannelPath() + "/content_files";
	//System.out.println("jxw==="+docpath);
	//�ĵ���Դ�ļ���js����
   String idstr="";
   String srcnamestr="";
	List dslist=null;
	DocumentManager dmi=new DocumentManagerImpl();
	DocumentSource ds=new DocumentSource();
	dslist=dmi.getDocSourceList();
   if(dslist.size()>0)
   {
   
    for(int i=0;i<dslist.size();i++)
    {
       ds=(DocumentSource)dslist.get(i);
        if(idstr!="")
        {
        idstr=idstr+","+ds.getDocsource_id();
        srcnamestr=srcnamestr+"&"+ds.getSrcname();
        }else
        {
        idstr=String.valueOf(ds.getDocsource_id());
        srcnamestr=ds.getSrcname();
        }
    }
    
   }
   
   //��ȡ��һ���ĵ�����Ϣ�磺�ĵ���Դ 
   String docSourceName = orgName;
   String docSourceId = "";
   String ext_class = "";
   try{
	   DBUtil db = new DBUtil();
	   //String sql = "select a.DOCSOURCE_ID,a.SRCNAME,b.ext_org,b.ext_class from TD_CMS_DOCSOURCE a , TD_CMS_DOCUMENT b where a.DOCSOURCE_ID = b.DOCSOURCE_ID and rownum =1 order by b.Document_Id desc" ;
	   String sql = "select a.DOCSOURCE_ID,a.SRCNAME from TD_CMS_DOCSOURCE a where a.srcname='"+orgName+"'";
	   db.executeSelect(sql) ;
	   if(db.size()>0){
	   		docSourceId = db.getString(0,0);
	   		docSourceName = db.getString(0,1); 
	   		//ext_class = db.getString(0,3);
	   }
	}catch(Exception e){}
   
   
   
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<link href="<%=request.getContextPath()%>/cms/inc/css/cms.css" rel="stylesheet" type="text/css">
<script src="<%=request.getContextPath()%>/cms/inc/js/func.js"></script>
<script src="<%=request.getContextPath()%>/cms/inc/js/killerror.js"></script>
<script src="<%=request.getContextPath()%>/include/validateForm.js"></script>


<script src="<%=request.getContextPath()%>/cms/inc/js/killerror.js"></script>

<script type="text/javascript" src="<%=request.getContextPath()%>/public/datetime/calender.js" language="javascript"></script>
<style type="text/css">
<!--
.STYLE7 {color:#003398; font-size: 12px;}
#Layer1 {
	position:absolute;
	left:0px;
	top:0px;
	width:113px;
	height:127px;
	z-index:1;
}
.STYLE8 {color: #0000FF}
.STYLE1 {color: red}
-->
</style>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>CMS �ĵ�����</title>
</head>

<script language="javascript">
    
	//�������ڶ���
	var win = null;
	//�رն�������
	function closewin()
	{
		win.close();
	}
	//�ַ�ת��
	function HTMLEncodeCMS(text){
		//text = text.replace(/"/g, "&quot;");
		return text;
	}
	//ѡ��ͼƬ���ŵĸ���ͼƬ
	var fileFlag;
	function chooseImage(){
		fileFlag = "pic";
		openWin("<%=request.getContextPath()%>/cms/channelManage/chooseImageFrameset.jsp?fileFlag=picOrFlash",700,580);
		//openWin("<%=request.getContextPath()%>/cms/newsimage/chooseImageFrameset.jsp",700,580);
		//window.open("<%=request.getContextPath()%>/cms/channelManage/chooseImageTree.jsp");
	}
	function setImage(uri){
		if(fileFlag == "pic")
			document.all("picpath").value  = uri;
		if(fileFlag == "media")
			document.all("mediapath").value  = uri;
		if(fileFlag == "newpic")
			document.all("newpicpath").value  = uri;
	}
	//ѡ���ý���ļ�
	function choosemedia()
	{
		fileFlag = "media";
		openWin("<%=request.getContextPath()%>/cms/channelManage/chooseImageFrameset.jsp?fileFlag=media",620,580);
		//openWin("<%=request.getContextPath()%>/cms/newsimage/chooseImageFrameset.jsp?fileFlag=media",620,580);
	}
	//ѡ��newͼ���ļ�
	function choosenewpic()
	{
		fileFlag = "newpic";
		openWin("<%=request.getContextPath()%>/cms/channelManage/chooseImageFrameset.jsp?fileFlag=pic",620,580);
	}
	//Ԥ��ģ��
	function preview()
	{
		var tplId = document.all.detailtemplate_id.value;
		window.open("../templateManage/template_previewbyid.jsp?tplId=" + tplId + "&siteId=<%=siteid%>");
	}
	//��̬��ҳ�ñ�
	/**��ͼƬת���ɷ�ҳ�ñ�**/
	function setPageTagNone(){
		var arPageTags = eWebEditor1.eWebEditor.document.all("_CMSPage");
		if(arPageTags == null)return;
		if(arPageTags.length){
			for(var i =arPageTags.length-1; i>=0; i--){
				var objPageTag = arPageTags[i];
				if(objPageTag == null)continue;

				var pageTag = eWebEditor1.eWebEditor.document.createElement("CMS_PAGE_SEPARATOR");		
				//pageTag.innerHTML = "TRS��̬��ҳ�ñ�";
				objPageTag.replaceNode(pageTag);
			}
		}else{
			var pageTag = eWebEditor1.eWebEditor.document.createElement("CMS_PAGE_SEPARATOR");		
			//pageTag.innerHTML = "TRS��̬��ҳ�ñ�";
			arPageTags.replaceNode(pageTag);
		}

	}
	//վ�㴰���������У��,closeFlagΪ10��ʾ���������Ϊ11��ʾ������ύ������Ϊ12��ʾ�������������
	function saveform(closeFlag){
		//�༭�����������ģʽ
		eWebEditor1.setMode('EDIT');
		if(!validateForm(myform))
		{
			return;
		}
		var inputsource=document.all.inputdocsource.value;
		if(myform.title.value==""){
			alert("�������ĵ�����!");
			document.all.auditorDiv.innerHTML="";
			document.all.publisherDiv.innerHTML="";
			myform.title.focus();
			return false;
		}
		if(myform.subtitle.value==""){
			alert("��������ʾ����!");
			document.all.auditorDiv.innerHTML="";
			document.all.publisherDiv.innerHTML="";
			myform.subtitle.focus();
			return false;
		}
		var seq = myform.seq.value;
		if(seq!=""&&seq.search("^[0-9]*[0-9][0-9]*$")!=0)
		{
		 alert("�������������������");
		 document.all.auditorDiv.innerHTML="";
			document.all.publisherDiv.innerHTML="";
			myform.seq.focus();
		 return false;
		}
		if(seq>=999999)
		{
		  alert("��ȷ�������ΪС��999999������");	
          document.all.auditorDiv.innerHTML="";
          document.all.publisherDiv.innerHTML="";
			myform.seq.focus();
		  return false;
		}
		if(myform.keywords.value=="")
		{
			alert("������ؼ��ʻ������!");
			document.all.auditorDiv.innerHTML="";
			document.all.publisherDiv.innerHTML="";
			myform.keywords.focus();
			return false;
		}
		if(myform.ext_djh.value=="")
		{
			alert("������ǼǺ�!");
			document.all.auditorDiv.innerHTML="";
			document.all.publisherDiv.innerHTML="";
			myform.ext_djh.focus();
			return false;
		}
		if(myform.ext_class.value=="")
		{
			alert("��ѡ����Ϣ���!");
			document.all.auditorDiv.innerHTML="";
			document.all.publisherDiv.innerHTML="";
			myform.ext_index.focus();
			return false;
		}
		if(inputsource==null||inputsource=="")
		{
		  alert('��ѡ�������д�ĵ���Դ');
		  document.all.auditorDiv.innerHTML="";
		  document.all.publisherDiv.innerHTML="";
		  document.all.inputdocsource.focus();
		  return false;
		}
		else{
	
		   //�ж��Ƿ��¼ӵ��ĵ���Դ��������

		    if(document.all.docsource_id.value.length<1)
		    {
				document.all.isnewdocsource.value="1";
			}
				
			//ȡ����ĵ��б�
			var arr = new Array();
			arr = docxz.document.getElementsByName("docid");
			for(var i=0;i<arr.length;i++)
			{
				myform.doclist.value += arr[i].value +"��";
			}
			//ȡ��ظ����б�
			var arr2 = new Array();
			var arr3 = new Array();
			var arr4 = new Array();
			arr2 = docattachlist.document.getElementsByName("description");
			arr3 = docattachlist.document.getElementsByName("originalFilename");
			arr4 = docattachlist.document.getElementsByName("url");
			for(var i=0;i<arr2.length;i++)
			{
				myform.description.value += arr2[i].value + "��";
				myform.originalFilename.value += arr3[i].value + "��";
				myform.url.value += arr4[i].value + "��";
			}
			//ȡ���ͼƬ�б�
			var arr22 = new Array();
			var arr32 = new Array();
			var arr42 = new Array();
			arr22 = docattachlist2.document.getElementsByName("description");
			arr32 = docattachlist2.document.getElementsByName("originalFilename");
			arr42 = docattachlist2.document.getElementsByName("url");
			for(var i=0;i<arr22.length;i++)
			{
				myform.description2.value += arr22[i].value + "��";
				myform.originalFilename2.value += arr32[i].value + "��";
				myform.url2.value += arr42[i].value + "��";
			}
			var tempcontent = eWebEditor1.eWebEditor.document.body.innerHTML;
			setPageTagNone();
			myform.content.value = HTMLEncodeCMS(eWebEditor1.eWebEditor.document.body.innerHTML);
			
			if(myform.content.value=="")
			{
				alert("�������ĵ�����!");
				document.all.auditorDiv.innerHTML="";
				document.all.publisherDiv.innerHTML="";
				return false;
			}
			if(document.all.selecttpl[1].checked)
				myform.parentDetailTpl.value = "1";
			else
				myform.parentDetailTpl.value = "0";
			
			
			//��չ�ֶ�
			//var extfieldvalues = docextfielslist.document.getElementsByName("extfielvalue");
			var fieldis = docextfielslist.document.getElementsByName("fieldId");
			var fldtypes = docextfielslist.document.getElementsByName("fieldType");
			var fldnames = docextfielslist.document.getElementsByName("fieldName");
			myform.extfieldvalues.value = "";
			myform.fieldids.value = "";
			myform.extfieldtypes.value = "";
			myform.extfieldnames.value = "";
			
			for(var ef=0;ef<fieldis.length;ef++)
			{
				
				var tmp = new Array();
				tmp = docextfielslist.document.getElementsByName(fieldis[ef].value+"_value");
				//alert(tmp.length);
				if (tmp.length<=0)
					continue;
					
				myform.extfieldvalues.value += tmp[0].value + "��";
				myform.fieldids.value += fieldis[ef].value + "��";
				myform.extfieldtypes.value += fldtypes[ef].value + "��";
				myform.extfieldnames.value += fldnames[ef].value + "��";
			}
			//����Ҫ��(���ڵ�ֵΪ��ʱjava ��split��������)
			myform.extfieldvalues.value += "null��";
			myform.method="post";
			//�¼ӵ�ר�ⱨ��
			var specialobj=specialreportlist.document.getElementsByName("ID");
			var specialsite='';//ר�ⱨ����Ӧ��վ�㴮
			var specialchannelid='';//ר�ⱨ����Ӧ��Ƶ��id��
			for(var specialsize=0;specialsize<specialobj.length;specialsize++)
			{
			var specialarr=specialobj[specialsize].value.split('&');
			if(specialsite=='')
			  {
			     specialsite=specialarr[0];
			  }
			  else
			  {
			   specialsite=specialsite+'&'+specialarr[0];
			  }
			  if(specialchannelid=='')
			  {
			     specialchannelid=specialarr[1];
			  }
			  else
			  {
			   specialchannelid=specialchannelid+'&'+specialarr[1];
			  }
			}
			document.all('specialsiteid').value=specialsite;
			document.all('sepcialchannelid').value=specialchannelid;
			//�¼ӵ�ר�ⱨ������
			if(closeFlag==5)
			{
				myform.target = "addgather";
				myform.action="<%=request.getContextPath()%>/cms/normativeFile/previewDoc.jsp";
				win = window.open("<%=request.getContextPath()%>/cms/doing.html","doinghtml","height="+(screen.availHeight-200)+",width="+(screen.availWidth-300)+",top=100,left=150,toolbar=no,menubar=no,scrollbars=no,resizable=no,location=no,status=no");
			}
			else
			{
				myform.target = "addgather";
				myform.action = "<%=request.getContextPath()%>/cms/normativeFile/add_document.jsp?flag=" + closeFlag;
				win = window.open("<%=request.getContextPath()%>/cms/doing.html","doinghtml","height="+(screen.availHeight-200)+",width="+(screen.availWidth-300)+",top=100,left=150,toolbar=no,menubar=no,scrollbars=no,resizable=no,location=no,status=no");
			}
			
			myform.submit();
			//eWebEditor1.eWebEditor.document.body.innerHTML = tempcontent;
			//��Ҫ���þ�̬��ҳ
			eWebEditor1.setHTML(tempcontent);

			var buttons = document.getElementsByTagName("input");
			for(var i=0;i<buttons.length;i++)
			{
				buttons[i].disabled = true;
			}
			
			
			
		}
	}
	//����
	function back() {
		window.close();
	}
	
	function isnum()
	{
	  var k = window.event.keyCode;
	  if (k < 48 || k > 57){
	     alert("������Ĳ������֣�")
	     window.event.keyCode = 0 ;}
	}
	
	function init()
	{
		changtpl(1);
		myform.title.focus();
		document.all.tab1.style.color = "#FF6600";
	}
	//tab�л�
	function tabClick(i){
		if(i==1){
			document.all.docxz.style.display = "none";
			document.all.docattachlist.style.display = "none";
			document.all.docattachlist2.style.display = "none";
			document.all.specialreportlist.style.display="none";
			document.all.docextfielslist.style.display = "none";
			document.all.eWebEditor1.style.display = "";
			document.all.tab1.style.color = "#FF6600";
			document.all.tab2.style.color = "";
			document.all.tab3.style.color = "";
			document.all.tab4.style.color = "";
			document.all.tab5.style.color = "";
		}
		if(i==2){
			document.activeElement.blur();
			//myform.title.focus();//���iframe��������
			document.all.eWebEditor1.style.display = "none";
			document.all.docattachlist.style.display = "none";
			document.all.docattachlist2.style.display = "none";
			document.all.specialreportlist.style.display="none";
			document.all.docextfielslist.style.display = "none";
			document.all.docxz.style.display = "";
			document.all.docxz.style.width = "95%";
			document.all.docxz.style.height = "300px";
			document.all.tab1.style.color = "";
			document.all.tab2.style.color = "#FF6600";
			document.all.tab3.style.color = "";
			document.all.tab4.style.color = "";
			document.all.tab5.style.color = "";
		}
		if(i==3){
			document.activeElement.blur();
			//myform.title.focus();//���iframe��������
			document.all.eWebEditor1.style.display = "none";
			document.all.docxz.style.display = "none";
			document.all.docattachlist2.style.display = "none";
			document.all.specialreportlist.style.display="none";
			document.all.docextfielslist.style.display = "none";
			document.all.docattachlist.style.display = "";
			document.all.docattachlist.style.width = "95%";
			document.all.docattachlist.style.height = "300px";
			document.all.tab1.style.color = "";
			document.all.tab2.style.color = "";
			document.all.tab3.style.color = "#FF6600";
			document.all.tab4.style.color = "";
			document.all.tab5.style.color = "";
		}
		if(i==4){
			document.activeElement.blur();
			//myform.title.focus();//���iframe��������
			document.all.eWebEditor1.style.display = "none";
			document.all.docxz.style.display = "none";
			document.all.docattachlist.style.display = "none";
			document.all.specialreportlist.style.display="none";
			document.all.docextfielslist.style.display = "none";
			document.all.docattachlist2.style.display = "";
			document.all.docattachlist2.style.width = "95%";
			document.all.docattachlist2.style.height = "300px";
			document.all.tab1.style.color = "";
			document.all.tab2.style.color = "";
			document.all.tab3.style.color = "";
			document.all.tab4.style.color = "#FF6600";
			document.all.tab5.style.color = "";
		}
		if(i==5){
			document.activeElement.blur();
			//myform.title.focus();//���iframe��������
			document.all.eWebEditor1.style.display = "none";
			document.all.docxz.style.display = "none";
			document.all.docattachlist.style.display = "none";
			document.all.specialreportlist.style.display="none";
			document.all.docattachlist2.style.display = "none";
			document.all.docextfielslist.style.display = "";
			document.all.docextfielslist.style.width = "95%";
			document.all.docextfielslist.style.height = "300px";
			document.all.tab1.style.color = "";
			document.all.tab2.style.color = "";
			document.all.tab3.style.color = "";
			document.all.tab4.style.color = "";
			document.all.tab5.style.color = "#FF6600";
		}
		if(i==6){
			document.activeElement.blur();
			//myform.title.focus();//���iframe��������
			document.all.eWebEditor1.style.display = "none";
			document.all.docxz.style.display = "none";
			document.all.docattachlist.style.display = "none";
			document.all.docattachlist2.style.display = "none";
			document.all.docextfielslist.style.display = "none";
			document.all.specialreportlist.style.display = "";
			document.all.specialreportlist.style.width = "95%";
			document.all.specialreportlist.style.height = "300px";
			document.all.tab1.style.color = "";
			document.all.tab2.style.color = "";
			document.all.tab3.style.color = "";
			document.all.tab4.style.color = "";
			document.all.tab5.style.color = "#FF6600";
		}
	}
	//��Ӧrodio�¼�
	function changtpl(type)
	{
		if(type==0){
			myform.btnTemplateList.disabled = false;
			myform.tName.disabled = false;
		}else{
			myform.btnTemplateList.disabled = true;
			myform.tName.disabled = true;
		}
	}
	function changSelect(o)
	{
	   document.all.inputdocsource.value=document.all.docsource_id.options(document.all.docsource_id.selectedIndex).text;
	   document.all.inputdocsource.focus();
	   document.all.inputdocsource.select();
	}	
	function subpublish(){
		showModalDialog("../docManage/doc_PublisherList.jsp?flag=4&channelId=<%=channelId%>",window,"dialogWidth:400px;dialogHeight:500px;help:no;scroll:auto;status:no");
	}
	function publish(){
		//document.all.divProcessing.style.display="";
		saveform(12);
	}
	function deliver(){
		showModalDialog("doc_AuditorList.jsp?flag=4&channelId=<%=channelId%>",window,"dialogWidth:400px;dialogHeight:500px;help:no;scroll:auto;status:no");
	}
	//���༭���еĴ��뱣��Ϊ�ĵ�ģ��
	function saveAsTPL(){
		var tempcontent = eWebEditor1.eWebEditor.document.body.innerHTML;
		setPageTagNone();
		myform.content.value = HTMLEncodeCMS(eWebEditor1.eWebEditor.document.body.innerHTML);
		eWebEditor1.eWebEditor.document.body.innerHTML = tempcontent;
		if(myform.content.value==""){
			alert("�������ĵ�ģ������!");
			document.all.docTplName.value="";
			document.all.docTplDescription.value="";
			return false;
		}	
		var re = showModalDialog("add_one_doctpl.jsp",window,"dialogWidth:350px;dialogHeight:300px;help:no;scroll:auto;status:no");
		if(re == "cf"){
			myform.action = "doc_tpl_handle.jsp?action=add&closeRefresh=0";
			myform.target = "addgather";
			myform.submit();
		}
	}
	
	function templateChoice(){
		var w = showModalDialog("../channelManage/channel_templateSet_frameset.jsp?siteId="+
		"<%=siteid%>&channelId=<%=channelId%>&channelName=<%=channelname%>&detailTemplateName="+myform.tName.value+
		"&dtId="+myform.detailtemplate_id.value+"&type=2&action=search&isSite=doc","setChannelOutlineTemplateId",
		"dialogWidth:800px;dialogHeight:505px;help:no;scroll:yes;status:no");
		//alert(w[0]+"    "+w[1]);
		if(w!=undefined && w.length>0)
		{
			myform.detailtemplate_id.value=w[0];
			myform.tName.value=w[1];
		}
	}
	function test(){
		alert(myform.detailtemplate_id.value);
	}
var myarray=new Array();
var myarrayid=new Array();
var srcnameadd='<%=srcnamestr%>';
var srcnameidadd='<%=idstr%>'
myarray=srcnameadd.split('&');
myarrayid=srcnameidadd.split(',');
function selectvalue(selectstr,selectid)
{
  document.getElementById("inputdocsource").value=selectstr;
  document.all.isnewdocsource.value="0";
  document.all.ischecksource.value='1';
  document.all.docsource_id.value=selectid;
  divhidden();
}
function divShow() { 
var tt=document.getElementById("inputdocsource");
var  ttop    =  tt.offsetTop;          //TT�ؼ��Ķ�λ���  
var  thei    =  tt.clientHeight;    //TT�ؼ�����ĸ�  
var  tleft  =  tt.offsetLeft;        //TT�ؼ��Ķ�λ��� 
 var d=document.getElementById("id1");
while  (tt  =  tt.offsetParent){ttop+=tt.offsetTop;  tleft+=tt.offsetLeft;}
 d.style.display="block";
 d.style.pixelLeft=tleft+1;
 d.style.pixelTop=ttop+thei+4;
 
} 
function divhidden()
{


var mydiv1=document.getElementById("id1");
mydiv1.style.height="300px";
mydiv1.style.display="none";

}
var initsearch='true';
function initdiv1()
{
if(initsearch=='true'){
var mydiv1=document.getElementById("id1");
var str='<table width=120 border=0 cellpadding=1 cellspacing=1 bgcolor=#006699>';
var sr='';
 for(var i=0;i<myarray.length;i++)
{
 sr=sr+' <tr style="cursor:hand" onClick=\"selectvalue(\''+myarray[i]+'\',\''+myarrayid[i]+'\')\"><td bgcolor=#FFFFFF height=22>&nbsp;'+myarray[i]+'</td></tr>';
}
str=str+sr+'</table>';
mydiv1.innerHTML=str;
divShow();

}
else
{
initdiv();
}
}
function initdiv()
{
//���Ի�div
var t=document.getElementById("inputdocsource").value;
if(t.length<1){
var mydiv1=document.getElementById("id1");
var str='<table width=120 border=0 cellpadding=1 cellspacing=1 bgcolor=#006699>';
var sr='';
 for(var i=0;i<myarray.length;i++)
{
 sr=sr+' <tr style="cursor:hand" onClick=\"selectvalue(\''+myarray[i]+'\',\''+myarrayid[i]+'\')\"><td bgcolor=#FFFFFF height=22>&nbsp;'+myarray[i]+'</td></tr>';
}
str=str+sr+'</table>';
mydiv1.innerHTML=str;
divShow();
}
else
{
  changdiv();
}
}
function divHide(d) { 
var d=document.getElementById("id1");
if(d.style.display=='block')
 d.style.display="none";
} 
function changdiv()
{
initsearch='false';
if(document.all.ischecksource.value!='1'){
document.all.ischecksource.value='0';
document.all.docsource_id.value="";
}
var t=document.getElementById("inputdocsource").value;
if(t.length<1)
{
   initdiv();
}
else
{
//�����
   divShow();
   var patternstr=t;
   var mydiv=document.getElementById("id1");
   var sr='';
   var divstr='';
   var count=0;
   var count_1=0;
   for(var i=0;i<myarray.length;i++)
   {
   if(myarray[i].match(patternstr)!=null)
   {
	 sr=sr+' <tr style="cursor:hand" onClick=\"selectvalue(\''+myarray[i]+'\',\''+myarrayid[i]+'\')\"><td bgcolor=#FFFFFF height=22>&nbsp;'+myarray[i]+'</td></tr>';
	 count=1;
	 count_1++;
   }
   }
   if(count==1)
   {
     divstr='<table width=120 border=0 cellpadding=1 cellspacing=1 bgcolor=#006699>'+sr+'</table>'; 
   }
   else
   {
    divstr='<table width=120 border=0 cellpadding=1 cellspacing=1 bgcolor=#006699><tr><td bgcolor=#FFFFFF height=22>&nbsp;û�и�Դ</td></tr></table> ';
   }
   mydiv.style.height=count_1*24+"px"
   mydiv.innerHTML=divstr;
}
}                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 
//-->
</script>
<!--����Ĵ��� ʹ�ð� F5��ˢ��modalҳ��-->
<base target="_self">
<body  bottommargin="0" bgcolor="#F3F4F9"  onkeydown="if(event.keyCode==116){reload.click()}" rightmargin="0" leftmargin="0" topmargin="0" onLoad="init();">
<script language="javascript">
	document.write("<a id='reload' href='" + document.location.href + "' style='display:none'>reload...</a>");
</script>
<!--����Ĵ��� ʹ�ð� F5��ˢ��modalҳ��-->
<!--��������� -->
<div id="divProcessing" style="position:absolute;width:40%;height:20px;z-index:1;background-color:#F0f0f0;layer-background-color:#F0f0f0;left:22%;top:80%;display:none;"  class="font">   
	<marquee direction="left" width="250" behavior="alternate"><span class=STYLE1>���ڷ����У����Եȡ���</span></marquee>
</div>

<form target="addgather" name="myform" method="post">
	<!--�ĵ�������ύʱ����˷������б�����-->
	<div id="auditorDiv" name="auditorDiv" style="display:none;"></div>
	<div id="publisherDiv" name="publisherDiv" style="display:none;"></div>
	
	<!--�ĵ�ģ�屣��ʱ�������Ϣ��ģ������ģ������������-->
	<input name="docTplName" value="" type=hidden>
	<input name="docTplDescription" value="" type=hidden>
	
	<input name="doctype" value="0" type=hidden>
  	<input name="userid" value="<%=userid%>" type=hidden>
  	<input name="channelId" value="<%=channelId%>" type=hidden>
  	<input name="siteid" value="<%=siteid%>" type=hidden>
  	<input name="createUser" value="<%=userid%>" type=hidden>
  	<input name="isnewdocsource" value="0" type="hidden"><!--�Ƿ��¸�Դ-->
	<input name="filepaths" value="" type=hidden><!--�ļ�������ʱ�䣬��Ϊ�ļ�����ƴ��һ����-->
	<input name="ofilepaths" value="" type=hidden><!--ԭ����url-->
	<input type="hidden" id="docsource_id" name="docsource_id" value="<%=docSourceId%>"><input type="hidden" id="ischecksource">
	<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
		<tr>
			<td height="50" valign="top" background="<%=request.getContextPath()%>/cms/images/top_tile_short.jpg">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
                	<tr>
	                    <td width="200"><img src="<%=request.getContextPath()%>/cms/images/logo.jpg" width="200" height="50"></td>
	                    <td>&nbsp;&nbsp;&nbsp;&nbsp;���ݲɼ� [<%=sitename%> վ��  :  <%=channelname%> Ƶ��]</td>
	                    <td width="174"><img src="<%=request.getContextPath()%>/cms/images/Gather_top_LeftDot.jpg" width="174" height="50"></td>
                    </tr>
                </table>
            </td>
		</tr>
		<tr>
			<td height="18">
				<table width="100%" border="0" cellpadding="0" cellspacing="0">
					<tr background="<%=request.getContextPath()%>/cms/images/Gather_Content_topbg.gif">
						<td width="4%" height="35" align="right" background="<%=request.getContextPath()%>/cms/images/Gather_Content_topbg.gif">
							<img src="<%=request.getContextPath()%>/cms/images/ico_point.gif" width="25" height="25" vspace="0">						
						</td>
						<td colspan="3" class="cms_title_blue">
							<table width="100%" border="0" cellpadding="0" cellspacing="0" background="<%=request.getContextPath()%>/cms/images/Gather_Content_topbg.gif">
								<tr>
									<td width="100" height="35" class="cms_title_blue">
									�ĵ���Ϣ��д
									</td>
									<td >
									<DIV style="text-align:left">
									(<span class="red_star">*</span>Ϊ������<span class="red_star"><img src="<%=request.getContextPath()%>/cms/images/tan.gif" width="11" height="11"></span>)	
									</DIV>
									</td>
								</tr>
							</table>												
						</td>
					</tr>
					<tr>
						<td height="26">&nbsp;</td>
						<td height="23" colspan="3">
							<table border="0" cellpadding="3" cellspacing="0">
								<tr>
									<td>
									  <strong>�ĵ�����:</strong></td>
									<td>
										<div align="center">
											<img src="<%=request.getContextPath()%>/cms/images/doc_html.gif" width="20" height="20">
										</div>
									</td>
									<td align="right">
										<a  href="<%=request.getContextPath()%>/cms/docManage/doc_gather.jsp?siteid=<%=siteid%>&channelName=<%=channelname%>&channelId=<%=channelId%>">
										<font color="#FF6600">��ͨ�ĵ�</font></a>
									</td>
									<td>
										<div align="center">
											<img src="<%=request.getContextPath()%>/cms/images/doc_link.gif" width="20" height="20">
										</div>
									</td>
									<td align="right">
										<a href="<%=request.getContextPath()%>/cms/normativeFile/doc_gather_links.jsp?siteid=<%=siteid%>&channelName=<%=channelname%>&channelId=<%=channelId%>">
										<font color="#FF6600">�ⲿ����</font></a>
									</td>
									<td>
										<div align="center">
											<img src="<%=request.getContextPath()%>/cms/images/doc_aggr.gif" width="20" height="20">
										</div>														  </td>
									<td>
										<a href="<%=request.getContextPath()%>/cms/docManage/doc_gather_aggr.jsp?siteid=<%=siteid%>&channelName=<%=channelname%>&channelId=<%=channelId%>">
										<font color="#FF6600">�ۺ��ĵ�</font></a>
									</td>
								</tr>
							</table>												
						</td>
					</tr>
					<tr>
						<td height="26">&nbsp;</td>
						<td width="6%" height="23"><strong>��Ϣ����:</strong></td>
						<td width="43%">
							<span class="cms_title_blue">
								<input name="title" type="text" class="cms_text" size="60" onpropertychange="subtitle.value=this.value"/>
							</span>
							<span class="red_star">*</span>
							<span>&nbsp;&nbsp;</span>
						</td>
						<td height="23" width="*">
							<span><strong>������ɫ:</strong></span>
							<span>
								<input name="titlecolor" onClick="openWin('<%=request.getContextPath()%>/cms/inc/js/selcolor.htm?',271, 311);"  readonly="true" type="text" class="cms_text" value="#000000" size="8" maxlength="50">
							</span>												
						</td>
					</tr>
					<tr>
						<td height="26">&nbsp;</td>
						<td height="23"><strong>��ʾ����:</strong></td>
						<td height="23">
							<input name="subtitle" type="text" class="cms_text" size="60">
							<span class="red_star">*</span>
						</td>
						<td height="23">
							<label><strong>��������:</strong></label>
							<pg:pager  statement="select a.org_name,a.remark5 from td_sm_organization a , td_sm_organization b where a.parent_id=b.org_id and a.remark3='1' and a.isforeignparty=0 order by b.orgnumber,a.orgnumber,b.org_sn,a.org_sn" dbname="bspf" isList="true">
							  <select name="ext_org">
								   <pg:list>
								  	<option value="<pg:cell colName="org_name"/>" <%if(ext_org!=null&&ext_org.equals(dataSet.getString("org_name"))){out.print("selected");}%>><pg:cell colName="remark5"  defaultValue=""/></option>
								  </pg:list>
					          </select>
						  	</pg:pager><span class="red_star">*</span>
						</td>
					</tr>
					<tr>
						<td height="26">&nbsp;</td>
						<td height="23"><strong>�� �� ��:</strong></td>
						<td height="23">
							<input name="secondtitle" type="text" class="cms_text" size="60">
						</td>
						<td height="23"> 
						<span><strong><strong>�� �� ��:</strong></strong></span>
							<span>
								<input name="ext_djh" type="text" class="cms_text" value="" size="20" maxlength="50"> <span class="red_star">*</span>
							</span>	
						</td>						
					</tr>
					<tr>
						<td>&nbsp;</td>
						<input name="ext_index" type="hidden" class="cms_text" size="60">
						<td width="6%" height="23"> 
						    <strong>��Ϣ���:</strong>&nbsp;
						</td>
						<td colspan="3">
						    <pg:pager  statement="select class_name from td_comm_publicinfo_class where state=0 order by seq" dbname="bspf" isList="true">
							  <select name="ext_class">
							  		<OPTION value="">��ѡ����Ϣ���</OPTION>
								   <pg:list>
								  	<option value="<pg:cell colName="class_name"/>" <%if(ext_class!=null&&ext_class.equals(dataSet.getString("class_name"))){out.print("selected");}%>><pg:cell colName="class_name"  defaultValue=""/></option>
								  </pg:list>
					          </select>
						  	</pg:pager><span class="red_star">*</span>
						</td>						
					</tr>
					<tr>
					    <td height="26">&nbsp;</td>
					    <td height="26"><strong>�ĺ�:</strong></td>
					    <td height="26"><input name="ext_wh" type="text" class="cms_text" size="60"></td>
					    <td height="23"> 
						    <strong>���ʱ��:</strong>
						    <span class="black">
								<span class="cms_title_blue">
									<input name="docwtime" type="text" class="cms_text" onpropertychange="ordertime.value=this.value" validator="datetime" cnname="���ʱ��" value="<%=riqi%>" size="22">
								</span>
							</span>
							<input type="button" class="Channel_5wordsBtn" value="ʱ��" onClick="showdatetime(document.all('docwtime'))">
						</td>
					</tr>
					<tr>
					    <td height="26">&nbsp;</td>
					    <td height="26"><label><strong>�ĵ���Դ:</strong></label></td>
					    <td height="23">
							<span class="cms_title_blue">
							<input type="text" style="width:120px;height:21px;font-size:10pt;" id="inputdocsource" name="inputdocsource" onmouseover="initdiv1()" onpropertychange="changdiv()" onmouseout="divhidden()" value="<%=docSourceName%>">
		                    	<div id="id1" STYLE="position:absolute;display:none;z-index:100;background: #fff; overflow-y:scroll; width:100px; height:300px" onmouseover="divShow()" onmouseout="divhidden()" ></div><span class="red_star">*</span>
							
						</td>
					    <td height="23"><strong>����ʱ��:</strong>
						    <span class="black">
								<span class="cms_title_blue">
									<input name="ordertime" type="text" class="cms_text" validator="datetime" cnname="����ʱ��" value="<%=riqi%>" size="22">
								</span>
							</span>
							<input type="button" class="Channel_5wordsBtn" value="ʱ��" onClick="showdatetime(document.all('ordertime'))">
						</td>
					</tr>
					<tr>
						<td height="26">&nbsp;</td>
						<td height="23">
							<strong>����ģ��:</strong>
						</td>
						<td height="23">
							<table>
								<tr>
									<td>
										<table>
											<tr>
												<td>
												<span class="cms_title_blue">
													<input type="radio" name="selecttpl" value="0"  onClick="changtpl(0)">
													<input name="detailtemplate_id" id="detailtemplate_id" type="hidden" value="" />
													<input name="tName" id="tName" type="text" style="width:130px" value=""  class="cms_text" readonly />
													<input name="btnTemplateList" id="btnTemplateList" type="button" class="Channel_5wordsBtn" onclick="templateChoice()" value="ѡ ��"  />
												</span>
												</td>
											</tr>
											<tr>
												<td>
												<input type="radio" name="selecttpl" value="1" checked="true" onClick="changtpl(1)">
												<input type="hidden" name="parentDetailTpl"/>
												<%
												ChannelManager chnl = new ChannelManagerImpl();
												Template tp = chnl.getDetailTemplateOfChannel(channelId);
												String tname = (tp==null?"��û������":tp.getName());
												%>
												�̳�����Ƶ����ϸ��ģ��(<span class="red_star"><%=tname%></span>)
												</td>
											</tr>
										</table>
									</td>
									<td>
										<table>
											<tr>
												<td>
												<a href="#" onClick="preview()" ><u>Ԥ��</u></a>
												</td>
											</tr>
										</table>
									</td>
								</tr>
							</table>
						</td>
						<td>
							<span class="black">
							    <strong><%if(channelname.equals("�쵼����")||channelname.equals("�쵼�")){out.print("�쵼����:");}else{out.print("��������:");}%></strong>
							    <span class="cms_title_blue">
									<input name="author" type="text" class="cms_text" size="17">
								</span>
							</span>
							&nbsp;&nbsp; <strong>����:</strong>
						  	<span class="cms_title_blue">
								<select name="doc_level" class="cms_select">
									<%
									  List doclevellist = null;
									  DocumentManager impl = new DocumentManagerImpl();
									  doclevellist = impl.getDocLevelList();
									  request.setAttribute("doclevellist",doclevellist);
									%>
									<pg:list requestKey="doclevellist">
										<option value="<pg:cell colName="id"/>">
										<pg:cell colName="name"/> 
									</pg:list>
								</select>
					  	    </span>
						</td>
					</tr>
					<tr>
						<td height="26">&nbsp;</td>
						<td><strong>����ͼƬ:</strong></td>
						<td>
							<input type="text" name="picpath" value="" class="cms_text" readonly size="30"/>
							<input type="button" class="Channel_7wordsBtn" name="addpic" onClick="chooseImage()" value="ѡ��ͼƬ��flash"/>
						</td>
						<td> 
						<strong>��������:</strong>
						    <input type="text" name="publishfilename" value="" class="cms_text" size="30"/>
					  	</td>
					</tr>
					<tr>
					    <td height="26">&nbsp;</td>
					    <td><strong>��ý���ļ�:</strong></td>
					    <td>
					    	<input type="text" name="mediapath" value="" class="cms_text" readonly size="30"/>
					  		<input type="button" class="Channel_5wordsBtn" name="addmedia" onClick="choosemedia()" value="ѡ���ļ�"/>
					    </td>
					     <td><strong>�� �� ��:</strong>
						    <input type="text" name="seq"  class="cms_text" size="10"/></td>
					</tr>
					<tr>
					    <td height="26">&nbsp;</td>
					    <td colspan="3">
					    	<strong>�Ƿ���Ϊnew:</strong>&nbsp;&nbsp;
					    	<input type="checkbox" hideFocus name="isnew" value="1" class="cms_text"/>&nbsp;&nbsp;
					    	<input type="text" name="newpicpath" value="" class="cms_text" readonly size="30"/>
					  		<input type="button" class="Channel_5wordsBtn" name="default" onClick="document.all('newpicpath').value='image/new.gif'" value="ʹ��Ĭ��ֵ"/>
					  		<input type="button" class="Channel_7wordsBtn" name="addnewpic" onClick="choosenewpic()" value="ѡ��newͼ��"/>
					    </td>
					</tr>
					<tr>
						<td height="26">&nbsp;</td>
						<td height="23" colspan="3">
							<table width="100%" border="0" cellspacing="0">
	                        	<tr>
	                            	<td width="7%"><strong>ժҪ����:</strong></td>
	                            	<td>
	                            	<textarea name="docabstract" cols="70" rows="5" class="cms_textarea"></textarea>
	                            	</td>
	                        	</tr>
	                        </table>
                        </td>
					</tr>
					<tr>
						<td height="26">&nbsp;</td>
						<td height="23" colspan="3">
							<table width="100%" border="0" cellspacing="0">
	                        	<tr>
	                            	<td width="7%"><strong>�� �� ��<br>(�����):</strong></td>
	                            	<td>
	                            	<textarea name="keywords" cols="70" rows="5" class="cms_textarea"><%=request.getParameter("channelName")%></textarea>
	                            	<span class="red_star">*</span>(<span class="red_star">����ؼ���֮���ö��š�,���ָ�</span>)
	                            	</td>
	                        	</tr>
	                        </table>
                        </td>
					</tr>
					<tr>
						<td height="26">&nbsp;</td>
						<td height="23" colspan="2">
							<img align=absMiddle border=0 height=12 src="<%=request.getContextPath()%>/cms/images/text-edit.gif" width=14 >
							<a id=tab1 href="#" onclick=tabClick(1) ><u>[���ݱ༭]</u></a>&nbsp;&nbsp; 
							<img align=absMiddle border=0 height=12 src="<%=request.getContextPath()%>/cms/images/text-correlated.gif" width=14 >
							<a id=tab2 href="#" onclick=tabClick(2) ><u>[����ĵ�]</u></a>&nbsp;&nbsp;
							<img align=absMiddle border=0 height=12 src="<%=request.getContextPath()%>/cms/images/text-addons.gif" width=14 >
							<a id=tab3 href="#" onclick=tabClick(3) ><u>[�ĵ�����]</u></a>&nbsp;&nbsp;
							<img align=absMiddle border=0 height=12 src="<%=request.getContextPath()%>/cms/images/text-img.gif" width=14 >
							<a id=tab4 href="#" onclick=tabClick(4) ><u>[�ĵ�ͼƬ]</u></a>&nbsp;&nbsp;
							<img align=absMiddle border=0 height=15 src="<%=request.getContextPath()%>/cms/images/text-text.gif" width=15 >
							<a id=tab5 href="#" onclick=tabClick(5) ><u>[��չ�ֶ�]</u></a>&nbsp;&nbsp;
							<img align=absMiddle border=0 height=15 src="<%=request.getContextPath()%>/cms/images/text-text.gif" width=15 >
							<a id=tab5 href="#" onclick=tabClick(6) ><u>[ר�ⱨ��]</u></a>
						</td>
						<td width="30%" height="23" colspan="1">
							<div align="center">
								<input name="button" type="button" onClick="saveform(1)" class="cms_button"  value="����">
								<!-- <input name="button" type="button" onClick="saveAsTPL()" class="cms_button"  value="����ģ��">-->
								<input type="button" value="����Ԥ��" class="cms_button" onClick="saveform(5);">
								<%
								if((impl.canTransition(Integer.parseInt(channelId),1,2)!=-1) && 
									(accesscontroler.checkPermission(channelId,AccessControl.DELIVER_PERMISSION,AccessControl.CHANNELDOC_RESOURCE)||
										accesscontroler.checkPermission(siteid,AccessControl.DELIVER_PERMISSION,AccessControl.SITEDOC_RESOURCE))){%>
								<input type="button" value="����" class="cms_button" onClick="deliver();">
								<%}
								if((impl.canTransition(Integer.parseInt(channelId),1,11)!=-1) &&
									(accesscontroler.checkPermission(channelId,AccessControl.SUBPUBLISH_PERMISSION,AccessControl.CHANNELDOC_RESOURCE)||
										accesscontroler.checkPermission(siteid,AccessControl.SUBPUBLISH_PERMISSION,AccessControl.SITEDOC_RESOURCE))){%>
								<input type="button" value="�ύ����" class="cms_button" onClick="subpublish();">
								<%}
								if((impl.canTransition(Integer.parseInt(channelId),1,5)!=-1) &&
									(accesscontroler.checkPermission(channelId,AccessControl.DOCPUBLISH_PERMISSION,AccessControl.CHANNELDOC_RESOURCE)||
										accesscontroler.checkPermission(siteid,AccessControl.DOCPUBLISH_PERMISSION,AccessControl.SITEDOC_RESOURCE))){%>
								<input type="button" value="����" class="cms_button" onClick="publish();">
								<%}%>
								<input type="button" value="����" class="cms_button" onClick="back()">
							</div>
						</td>
					</tr>
				</table>
			</td>
		</tr>
		            
		<tr>
			<td  width="95%" height="22"  align="center" valign="top">
  				<div>
					<input type="hidden" name="content">
					<input type="hidden" name="pics">
					<input type="hidden" name="flashs">
					<input type="hidden" name="medias">
					<input type="hidden" name="files"><br/>
					<iframe id="eWebEditor1" src="<%=request.getContextPath()%>/cms/editor/eWebEditor48/ewebeditor.htm?id=content&style=coolblue&cusdir=<%=docpath%>" frameborder="0" scrolling="no" width="95%" height="460">
					</iframe>
				</div>
				<div>
					<input type="hidden" name="doclist">
					<br/><iframe id="docxz" src="<%=request.getContextPath()%>/cms/channelManage/chn_doc_xzlist.jsp?flag=1&siteid=<%=siteid%>" frameborder="0" scrolling="auto" width="0%" height="0%">
					</iframe>
				</div>
				<div>
					<input type="hidden" name="originalFilename">
					<input type="hidden" name="description">
					<input type="hidden" name="url">
					<iframe id="docattachlist" src="<%=request.getContextPath()%>/cms/docManage/doc_attach_list.jsp?type=2&docpath=<%=docpath%>" frameborder="0" scrolling="auto" width="0%" height="0%">
					</iframe>
				</div>
				<div>
					<input type="hidden" name="originalFilename2">
					<input type="hidden" name="description2">
					<input type="hidden" name="url2">
					<iframe id="docattachlist2" src="<%=request.getContextPath()%>/cms/docManage/doc_attach_list.jsp?type=3&docpath=<%=docpath%>" frameborder="0" scrolling="auto" width="0%" height="0%">
					</iframe>
				</div>
				<div>
					<input type="hidden" name="fieldids">
					<input type="hidden" name="extfieldvalues">
					<input type="hidden" name="extfieldtypes">
					<input type="hidden" name="extfieldnames">
					<iframe id="docextfielslist" src="<%=request.getContextPath()%>/cms/docManage/doc_extfield_list.jsp?type=2&id=<%=channelId%>" frameborder="0" scrolling="auto" width="0%" height="0%">
					</iframe>
				</div>
				<!-- ����ר�ⱨ��-->
				<div>
					<INPUT type="hidden" name="specialsiteid"><!-- ר��վ��id-->
					<INPUT type="hidden" name="sepcialchannelid"><!-- ר��Ƶ��id-->
					<iframe id="specialreportlist" src="<%=request.getContextPath()%>/cms/docManage/special_report_list.jsp?type=2&docpath=<%=docpath%>&channelid=<%=channelId%>&siteid=<%=siteid%>" frameborder="0" scrolling="auto" width="0%" height="0%">
					</iframe>
				</div>
			</td>
		</tr>
	</table>
	<script type="text/javascript">
	//document.all.inputdocsource.value=document.all.docsource_id.options(document.all.docsource_id.selectedIndex).text;
	</script> 
</form>

<iframe name="addgather" width="0" height="0">
</iframe>
 
</body>
</html>
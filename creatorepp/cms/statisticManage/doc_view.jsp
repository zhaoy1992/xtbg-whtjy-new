<%@ page contentType="text/html; charset=GBK" language="java"%>
<%@page import="com.frameworkset.common.poolman.DBUtil"%>
<%@page import="com.chinacreator.cms.sitemanager.*,com.chinacreator.cms.templatemanager.*
,com.chinacreator.cms.container.Template,com.chinacreator.cms.documentmanager.*"%>
<%@page import="com.chinacreator.cms.channelmanager.*"%>
<%@page import="com.chinacreator.cms.driver.htmlconverter.*"%>
<%@page import="com.chinacreator.cms.driver.i18n.*"%>
<%@page import="java.util.*"%>
<%@page import="com.chinacreator.security.AccessControl,java.util.List"%>
<%@ taglib uri="/WEB-INF/dictionary.tld" prefix="dict"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ include file="../../sysmanager/include/global1.jsp"%>
<jsp:useBean id="date" scope="page" class="net.fiyu.edit.TimeStamp"/>

<%
	response.setHeader("Cache-Control", "no-cache"); 
	response.setHeader("Pragma", "no-cache"); 
	response.setDateHeader("Expires", -1);  
	response.setDateHeader("max-age", 0);

	AccessControl accesscontroler = AccessControl.getInstance();
    accesscontroler.checkAccess(request, response);
	String userid = accesscontroler.getUserID();
   
	String docid = request.getParameter("docid");
	String channelname = request.getParameter("channelName");
	//String siteid = request.getParameter("siteid");
	String siteid = "";
	String channelId = request.getParameter("channelId");
	//����Ƶ��ID�õ�����վ��ID
	DBUtil db = new DBUtil();
	try{
		db.executeSelect("select site_id  from td_cms_channel where channel_id="+channelId);
		if(db.size()>0){
			siteid=(new Integer(db.getInt(0,"site_id"))).toString();
		}
		else{
			siteid="";
		}
	}catch(Exception e){
		e.printStackTrace();
	}
	
	DocumentManager dmi = new DocumentManagerImpl();
	ChannelManager cm = new ChannelManagerImpl();
	SiteManager siteManager = new SiteManagerImpl();
	
	
	 //�ڷ����ĵ��༭ʱ����rebound�������ʱ����audit����������Ϊ��(�����ĵ���������id��)
   	String flag =  request.getParameter("flag");
   	int taskid = 0;
   	String taskidStr="";
   	if(flag!=null && flag.equals("rebound")){
   		taskid = dmi.hasTask(Integer.parseInt(userid),Integer.parseInt(docid),2);
   	}
   	else if(flag!=null && flag.equals("audit")){
   		taskid = dmi.hasTask(Integer.parseInt(userid),Integer.parseInt(docid),1);
   		taskidStr = request.getParameter("taskidStr");
   	}

	Document document = dmi.getDoc(docid);

	String status = String.valueOf(document.getStatus());
	
	String sitename = siteManager.getSiteInfo(siteid).getName();
	String docsource = String.valueOf(document.getDocsource_id());
	String docSourceName = document.getDocsource_name();
	String tid = String.valueOf(document.getDetailtemplate_id());
	String docLevelId = String.valueOf(document.getDoc_level());//�ĵ�����
	//ͼƬ�������ȵı���·�� docpath
	String sitedir = siteManager.getSiteInfo(siteid).getSiteDir();//Ƶ�����·��
	String relativePath = cm.getChannelInfo(request.getParameter("channelId")).getChannelPath();//վ�����·��
	String docpath = siteManager.getSiteInfo(siteid).getSiteDir() + "/_webprj/uploadfiles/" + (String)date.Time_YMD().substring(0,6) ;

	//�����ĵ�����
	CmsLinkProcessor processor = new CmsLinkProcessor(request,relativePath,sitedir);
	processor.setHandletype(CmsLinkProcessor.PROCESS_READCONTENT);
	try {
		String content = processor.process(document.getContent(),CmsEncoder.ENCODING_US_GBK);
		document.setContent(content);
	} catch (Exception e) {
		e.printStackTrace();
	}

	//get�ĵ�������ĵ�����Ϣ
	String partId = "";
	String partName = "";
	String partChlName = "";
	String[] doclists =  dmi.getDocRelatedString(Integer.parseInt(docid));
	for(int i=0;i<doclists.length;i++)
	{
		String[] tem = doclists[i].split("��");
		partId += tem[0] + "��";
		partName += tem[1] + "��";
		partChlName += tem[2] + "��";
	}
	//get�ĵ�����ظ�������Ϣ
	String attId = "";
	String attDesc = "";
	String attUrl = "";
	String ofilename = "";
	String[] atts = dmi.getAllRelationOfDocument2String(Integer.parseInt(docid),2);
	for(int i=0;i<atts.length;i++)
	{
		String[] tem = atts[i].split("��");//��Ӧ��ϵ
		attId += tem[0] + "��";
		attDesc += tem[4] + "��";
		attUrl += tem[2] + "��";
		ofilename += tem[5] + "��";
	}
	//get�ĵ������ͼƬ����Ϣ
	String attId2 = "";
	String attDesc2 = "";
	String attUrl2 = "";
	String ofilename2 = "";
	String[] atts2 = dmi.getAllRelationOfDocument2String(Integer.parseInt(docid),3);
	for(int i=0;i<atts2.length;i++)
	{//System.out.println(atts2[i]);
		String[] tem = atts2[i].split("��");//��Ӧ��ϵ
		attId2 += tem[0] + "��";
		attDesc2 += tem[4] + "��";
		attUrl2 += tem[2] + "��";
		ofilename2 += tem[5] + "��";
	}
%>
<%!/**
   * ���HTML�������ַ�ת��
   * @param value String
   * @return String
   */
  String filterStr(String value) {
    if (value == null) {
      return (null);
    }
    char content[] = new char[value.length()];
    value.getChars(0, value.length(), content, 0);
    StringBuffer result = new StringBuffer(content.length + 50);
    for (int i = 0; i < content.length; i++) {
      switch (content[i]) {
        case '<':
          result.append("&lt;");
          break;
        case '>':
          result.append("&gt;");
          break;
        case '&':
          result.append("&amp;");
          break;
        case '"':
          result.append("&quot;");
          break;
        case '\'':
          result.append("&#39;");
          break;
        case '\\':
          result.append("\\\\");
          break;
        default:
          result.append(content[i]);
      }
    }
	return (result.toString());
  }
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<link href="<%=request.getContextPath()%>/cms/inc/css/cms.css" rel="stylesheet" type="text/css">
<script src="<%=request.getContextPath()%>/cms/inc/js/func.js"></script>
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

-->
</style>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>CMS �ĵ�����</title>
</head>
<script language="javascript">
	
	//�ַ�ת��
	function HTMLEncode(text){
		//text = text.replace(/"/g, "&quot;");
		return text;
	}
	//ѡ��ͼƬ���ŵĸ���ͼƬ
	var fileFlag;
	function chooseImage(){
		fileFlag = "pic";
		openWin("<%=request.getContextPath()%>/cms/channelManage/chooseImageFrameset.jsp",520,580);
	}
	function setImage(uri){
		if(fileFlag == "pic")
			document.all("picpath").value  = uri;
		if(fileFlag == "media")
			document.all("mediapath").value  = uri;
	}
	//ѡ���ý���ļ�
	function choosemedia()
	{
		fileFlag = "media";
		openWin("<%=request.getContextPath()%>/cms/channelManage/chooseImageFrameset.jsp?fileFlag=media",520,580);
	}
	//Ԥ��ģ��
	function preview()
	{
		var tplId = document.all.detailtemplate_id.value;
		window.open("<%=request.getContextPath()%>/cms/templateManage/template_previewbyid.jsp?tplId=" + tplId + "&siteId=<%=siteid%>");			
		//openWin("<%=request.getContextPath()%>/cms/templateManage/template_previewbyid.jsp?tplId=" + tplId + "&siteId=<%=siteid%>",screen.availWidth,screen.availHeight);
		return;
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
	//վ�㴰���������У��
	function saveform(closeFlag){
		if(closeFlag != 5)
		{
			if(!confirm('��ȷ���޸��ĵ���')){
				return;
			}
		}
		var inputsource=document.all.inputdocsource.value;
		//�༭�����������ģʽ
		eWebEditor1.setMode('EDIT');
		
		if(myform.title.value==""){
			alert("�������ĵ�����!");
			myform.title.focus();
			return false;
		}
		if(myform.subtitle.value==""){
			alert("��������ʾ����!");
			myform.subtitle.focus();
			return false;
		}
		if(inputsource==null||inputsource=="")
		{
		  alert('��ѡ�������д�ĵ���Դ');
		  document.all.inputdocsource.focus();
		  return false;
		}
		else{
			//�ж��Ƿ��¼ӵ��ĵ���Դ��������
		    if(inputsource!=document.all.docsource_id.options(document.all.docsource_id.selectedIndex).text)
				document.all.isnewdocsource.value="1";
			//ȡ����ĵ��б�
			var arr = new Array();
			arr = docxz.document.getElementsByName("docid");
			for(var i=0;i<arr.length;i++){
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
			myform.content.value = HTMLEncode(eWebEditor1.eWebEditor.document.body.innerHTML);
			eWebEditor1.eWebEditor.document.body.innerHTML = tempcontent;
			if(myform.content.value=="")
			{
				alert("�������ĵ�����!");
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
			myform.extfieldvalues.value = "";
			myform.fieldids.value = "";
			myform.extfieldtypes.value = "";
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
			}
			//����Ҫ��(���ڵ�ֵΪ��ʱjava ��split��������)
			myform.extfieldvalues.value += "null��";

			myform.method="post";
			if(closeFlag==5)
			{
				myform.action="<%=request.getContextPath()%>/cms/docManage/previewDoc.jsp";
			}
			else
			{
				myform.action="<%=request.getContextPath()%>/cms/docManage/update_document.jsp?closeFlag=" + closeFlag;
			}
			myform.submit();
		}
	}
	//����
	function back() {
		window.close();
	}

	
	
	//tab�л�
	function tabClick(i){
		if(i==1){
			document.all.docxz.style.display = "none";
			document.all.docattachlist.style.display = "none";
			document.all.docattachlist2.style.display = "none";
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
	}
	//��ʼ������ĵ�table��������
	function initRelatedDoc()
	{
		var part_id = "<%=partId%>";
		var part_name = "<%=filterStr(partName)%>";
		var part_ChlName = "<%=filterStr(partChlName)%>";
		
		if(part_id!=""&&part_name!="")
		{
			var ids = new Array();
			var names = new Array();
			var chlnames = new Array();
			ids = part_id.split("��");
			names = part_name.split("��");
			chlnames = part_ChlName.split("��");
			var tableatt = docxz.document.all("chndoclist");
			for(var i=0;i<ids.length-1;i++)
			{
				var row1 = tableatt.insertRow(i+1);
				var td1 = docxz.document.createElement("td");
				var td2 = docxz.document.createElement("td");
				var td3 = docxz.document.createElement("td");

				td1.innerHTML="<input type='checkBox' name='id' value="+(i+1)+" hideFocus=true onclick='checkOne(id)'/>";		 
				var docid = "<input type='hidden' name='docid' value='"+ids[i]+"' />";
				//var channelId = "<input type='hidden' name='channelId' value='"+obj[1]+"' />";
				td2.innerHTML = docid + names[i];
				td3.innerHTML = chlnames[i];
				row1.appendChild(td1);
				row1.appendChild(td2);
				row1.appendChild(td3);
			}
		}
	}
	//��ʼ����ظ���table��������
	function initAtt()
	{
		var att_id = "<%=attId%>";
		var att_desc = "<%=attDesc%>";
		var att_url = "<%=attUrl%>";
		var att_ofilename = "<%=ofilename%>";
		
		if(att_id!=""&&att_url!="")
		{
			var ids = new Array();
			var descs = new Array();
			var urls = new Array();
			var ofilenames = new Array();

			ids = att_id.split("��");
			descs = att_desc.split("��");
			urls = att_url.split("��");
			ofilenames = att_ofilename.split("��");

			var tableatt = docattachlist.document.all("doc_attach_list");
			for(var i=0;i<ids.length-1;i++)
			{
				var row1 = tableatt.insertRow(i+1);
				var td1 = docattachlist.document.createElement("td");
				var td2 = docattachlist.document.createElement("td");
				var td3 = docattachlist.document.createElement("td");

				td1.innerHTML="<input type='checkBox' name='id' value="+ids[i]+" hideFocus=true onclick='checkOne(id)'/>";		 
				td2.innerHTML = "<input type='text' name='description' value='"+descs[i]+"'/>" +
					"<input type='hidden' name='originalFilename' value='"+ofilenames[i]+"'/>"
					+ "<input type='hidden' name='url' value='"+ urls[i]+"'/>";
				td3.innerHTML = "<a href='#' onclick=downloadattrs('../siteResource/<%=docpath%>/"+urls[i]+"')>"+urls[i]+"</a>";
				row1.appendChild(td1);
				row1.appendChild(td2);
				row1.appendChild(td3);
			}
		}
	}
	//��ʼ�����ͼƬtable��������
	function initAttPic()
	{
		var att_id = "<%=attId2%>";
		var att_desc = "<%=attDesc2%>";
		var att_url = "<%=attUrl2%>";
		var att_ofilename = "<%=ofilename2%>";
		
		if(att_id!=""&&att_url!="")
		{
			var ids = new Array();
			var descs = new Array();
			var urls = new Array();
			var ofilenames = new Array();

			ids = att_id.split("��");
			descs = att_desc.split("��");
			urls = att_url.split("��");
			ofilenames = att_ofilename.split("��");

			var tableatt = docattachlist2.document.all("doc_attach_list");
			for(var i=0;i<ids.length-1;i++)
			{
				var row1 = tableatt.insertRow(i+1);
				var td1 = docattachlist2.document.createElement("td");
				var td2 = docattachlist2.document.createElement("td");
				var td3 = docattachlist2.document.createElement("td");

				td1.innerHTML="<input type='checkBox' name='id' value="+ids[i]+" hideFocus=true onclick='checkOne(id)'/>";		 
				td2.innerHTML = "<input type='text' name='description' value='"+descs[i]+"'/>" +
					"<input type='hidden' name='originalFilename' value='"+ofilenames[i]+"'/>"
					+ "<input type='hidden' name='url' value='"+ urls[i]+"'/>";
				//td3.innerHTML = "<a href='../siteResource/<%=docpath%>/"+urls[i]+"'>"+urls[i]+"</a>";
				td3.innerHTML = "<a href='#' onclick=downloadattrs('<%=request.getContextPath()%>/cms/siteResource/<%=docpath%>/"+urls[i]+"')>"+urls[i]+"</a>";
				row1.appendChild(td1);
				row1.appendChild(td2);
				row1.appendChild(td3);
			}
		}
	}
	//��ʼ�����table
	function document.onreadystatechange()
	{
		if (document.readyState!="complete") 
			return;
		initRelatedDoc();
		initAtt();
		initAttPic();
	}
	//��Ӧrodio�¼�
	function changtpl(type)
	{
		if(type==0)
			document.all.detailtemplate_id.disabled = false;
		else
			document.all.detailtemplate_id.disabled = true;
	}
	
	function seeAdvice(channelId,docid,taskid){
		openWin("<%=rootpath%>/cms/docManage/see_audit_advice.jsp?channelId=<%=channelId%>&docid=<%=docid%>&taskid=<%=taskid%>" ,400,550);
	}
	
	
	
	function changSelect(o)
	{
	   document.all.inputdocsource.value=document.all.docsource_id.options(document.all.docsource_id.selectedIndex).text;
	   document.all.inputdocsource.focus();
	   document.all.inputdocsource.select();
	}
</script>

<body  bottommargin="0"   bgcolor="#F3F4F9"  rightmargin="0" leftmargin="0" topmargin="0" >

<!--����Ĵ��� ʹ�ð� F5��ˢ��modalҳ��-->
	<form target="updategather" name="myform" >
		<input name="userid" value="<%=document.getUser_id()%>" type=hidden>
		<input name="doctype" value="0" type=hidden>
	  	<input name="docid" value="<%=docid%>" type=hidden>
	  	<input name="siteid" value="<%=siteid%>" type=hidden>
	  	<input name="channelName" value="<%=channelname%>" type=hidden>
	  	<input name="channelId" value="<%=channelId%>" type=hidden>
	  	<input name="isnewdocsource" value="0" type="hidden"><!--�Ƿ��¸�Դ-->
		<input name="filepaths" value="" type=hidden><!--�ļ�������ʱ�䣬��Ϊ�ļ�����ƴ��һ����-->
		<input name="otherfilepaths" value="" type=hidden><!--����ά������remoteͼƬ��״̬-->
		<input name="ofilepaths" value="" type=hidden><!--ԭ����url-->
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
							        <tr>
							            <td height="50" colspan="3" valign="top" background="<%=request.getContextPath()%>/cms/images/top_tile_short.jpg">
								            <table width="100%" border="0" cellpadding="0" cellspacing="0">
								                <tr>
								                	<td width="200"><img src="<%=request.getContextPath()%>/cms/images/logo.jpg" width="200" height="50"></td>
								                    <td>&nbsp; 	���ݱ༭ [<%=sitename%> վ��  :  <%=channelname%> Ƶ��]</td>
								                    <td width="53"><img src="<%=request.getContextPath()%>/cms/images/Gather_top_LeftDot.jpg" width="174" height="50"></td>
								                </tr>
								            </table>
							            </td>
						            </tr>
						            
						            <tr>
							            <td height="18" colspan="3">
								            <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
								            	<tr background="<%=request.getContextPath()%>/cms/images/Gather_Content_topbg.gif" >
								                	<td width="4%" height="35" align="right" background="<%=request.getContextPath()%>/cms/images/Gather_Content_topbg.gif">
								                  		<img src="<%=request.getContextPath()%>/cms/images/ico_point.gif" width="25" height="25">								                  	</td>
								                  	<td colspan="3" background="<%=request.getContextPath()%>/cms/images/Gather_Content_topbg.gif" class="cms_title_blue">
									                  	<table width="100%" border="0" cellpadding="0" cellspacing="0">
										                    <tr>
										                        <td height="35" class="cms_title_blue">
										                          �ĵ���Ϣ���</td>
										                    	<td width="120">
										                    	</td>
										                	</tr>
								                      </table>
							                      </td>
							                  </tr>
								                <tr>
								                	<td height="26">&nbsp;								                	</td>
								                	<td height="23" colspan="3">
								                		<table border="0" cellpadding="3" cellspacing="0">
								                    		<tr>
								                      			<td align="right">
								                      			  <strong>�ĵ�����:</strong> </td>
								                      			<td>
								                      				<img src="<%=request.getContextPath()%>/cms/images/doc_html.gif" width="20" height="20">								                      			</td>
								                      			<td>
								                      			��ͨ�ĵ�								                      			</td>
							                      			</tr>
							                  		  </table>

								                    </td>
								                </tr>
								                <tr>
								                	<td height="26">&nbsp;								                	</td>
								                  	<td width="8%" height="23" align="right">
								                  	  <strong>�ĵ�����:</strong> </td>
								                    <td width="43%">
								                    	<span class="cms_title_blue">
								                    		<label>
								                    			<input name="title" type="text" class="cms_text" size="60" value="<%=filterStr(document.getTitle())%>"  disabled=true>
								                    		</label>
								                  		</span>
								                  		<span class="STYLE7">
								                  			<label>
								                  				<span class="red_star">
								                  				*
								                  				</span>
								                  			</label>
								                  		</span>
								                  		<span>
								                  		
								                  		</span>
								                  	</td>
								                  	<td height="23">
									                  	<span> 
									                  	<strong>������ɫ:</strong>									                  	</span>
								                  		<span>
								                      		<input name="titlecolor"  value="<%=document.getTitlecolor()%>" onClick=""  readonly type="text" class="cms_text" size="8" style="color:<%=document.getTitlecolor()%>" maxlength="50">
							                  		  </span>
							                  	  </td>
								                </tr>
								                <tr>
								                	<td height="26">&nbsp;								                	</td>
								                  	<td height="23" align="right">
							                  	    <strong>��ʾ����:</strong>							                      </td>
								                  	<td height="23">
								                  		<input name="subtitle" type="text" class="cms_text" size="60" value="<%=filterStr(document.getSubtitle())%> " disabled=true>
												  		<span class="STYLE7">
									                  		<label>
									                  			<span class="red_star">
									                  			*
									                  			</span>
									                  		</label>
								                  		</span>
								                  	</td>
								                  	<td height="23">
									                  	<label>
									                  	<strong>�ĵ���Դ:</strong>									                  	</label>
								                    	<span class="cms_title_blue">
								                    	<input type="text" style="width:100px;height:21px;font-size:10pt;" id="inputdocsource" name="inputdocsource" value=<%=docSourceName%> readonly><span style="width:18px;border:0px solid red;">
								                    	
								                    		</span>
								                    	</span>
								                    </td>
								                </tr>
								                <tr>
								                	<td height="26">&nbsp;								                	</td>
								                  	<td height="23" align="right">
								                  		<span class="black">
								                  		<strong>�� �� ��:</strong></span>								                  	</td>
								                  	<td height="23">
								                  		<span class="black">
								                  			<span class="cms_title_blue">
								                    			<input name="keywords" type="text" class="cms_text" size="26" value="<%=document.getKeywords()%>" readonly>
								                  			</span>
															(<span class="red_star">����ؼ���֮����;�ָ�</span>)
								                  		</span>
								                  		
								                  	</td>
								                  	<td height="23">
								                  		<div align="left">
								                  			<strong>���ʱ��:</strong>							                  			  <span class="black">
								                  				<span class="cms_title_blue">
																	<input name="docwtime" dateformat="yyyy-MM-dd HH:mm:ss" type="text" value="<%=document.getDocwtime()%>" readonly="true">																	
																</span>
															</span>								                    	</div>
								                    </td>
								                </tr>
												<tr>
								                	<td height="26">&nbsp;								                	</td>
								                  	<td height="23" align="right">
								                  	  <strong>����ģ��:</strong> </td>
								                  	<td height="23">
														<table border="0" cellpadding="0" cellspacing="0">
															<tr>
																<td>
																	<table>
																		<tr>
																			<td>
																			<span class="cms_title_blue">
																				<input type="radio" name="selecttpl" value="0"
																				onclick="changtpl(0)">
																				<span class="cms_title_blue">
																					<select name="detailtemplate_id" class="cms_select" style="width:130px">
																						<%
																						  List list=null;
																						  TemplateManager tmi=new TemplateManagerImpl();
																						  Template template=new Template();
																						  list=tmi.getTemplateInfoListofSite(Integer.parseInt(siteid), 2);
																						  request.setAttribute("tpllist",list);
																						%>
																						<pg:list requestKey="tpllist">
																							<option value="<pg:cell colName="templateId"/>"<pg:equal colName="templateId" value="<%=tid%>">selected</pg:equal>> 
																							<pg:cell colName="name"/> 
																						</pg:list>
																					</select>
																				</span>
																		  </td>
																		</tr>
																		<tr>
																			<td>
																			<input type="radio" name="selecttpl" value="1" onClick="changtpl(1)">
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
																			<a href="#" onClick="preview()" target="_self"><u>Ԥ��</u></a>
																			</td>
																		</tr>
																	</table>
																</td>
															</tr>
													  </table>
													</td>
													<td>
														<span class="black">
								                  		    <strong>��������:</strong>								                  		<span class="cms_title_blue">
									                  			<input name="author" type="text" class="cms_text" size="17" value="<%=document.getAuthor()%>" readonly>
								                  		</span>							                  		  </span>
														&nbsp;&nbsp;<strong>����:</strong>
														<span class="cms_title_blue">
															<select name="doc_level" class="cms_select">
																<%
																  List doclevellist = null;
																  DocumentManager impl = new DocumentManagerImpl();
																  doclevellist = impl.getDocLevelList();
																  request.setAttribute("doclevellist",doclevellist);
																%>
																<pg:list requestKey="doclevellist">
																	<option value="<pg:cell colName="id"/>"<pg:equal colName="id" value="<%=docLevelId%>">selected</pg:equal>>
																	<pg:cell colName="name"/> 
																</pg:list>
															</select>
														&nbsp; 
													  </span>
											  	  </td>
								                </tr>
												<tr>
													<td height="26">&nbsp;													</td>
													<td height="23" align="right">
														<strong>����ͼƬ:</strong> </td>
													<td height="23">
														<input type="text" name="picpath" value="<%=document.getPicPath()%>" class="cms_text" readonly size="30"/>
														
													</td>
													<td height="23"> 
														<strong>��ý���ļ�:</strong>
													  <input type="text" name="mediapath" value="<%=document.getMediapath()%>" class="cms_text" readonly size="30"/>
														
												  </td>
												</tr>
												<tr>
											        <td height="26">&nbsp;												</td>
											        <td width="10%" align="right"><strong>�ĵ���������:</strong></td>
											        <td><input type="text" name="publishfilename" value="<%=document.getPublishfilename()%>" readonly class="cms_text"  size="30"/></td>
											    </tr>
								                <tr>
								                	<td height="26">&nbsp;								                	</td>
								                  	<td height="23" colspan="3">
								                  		<table width="100%" border="0" cellpadding="3" cellspacing="0">
								                    		<tr>
										                    	<td width="8%" align="right"><strong>ժҪ����:</strong></td>
										                      	<td width="92%">
									                      		<textarea name="docabstract" cols="70" rows="5" class="cms_textarea" readonly><%=document.getDocabstract()%></textarea>										                      	</td>
									                      	</tr>
								                  		</table>
								                  	</td>
								                </tr>
								                <tr>
								                	<td height="26">&nbsp;								                	</td>
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
														<a id=tab5 href="#" onclick=tabClick(5) ><u>[��չ�ֶ�]</u></a>
								                  	</td>
								                    <td width="30%" height="23">
										<div align="center">
										<%if(flag!=null && flag.equals("rebound")){%>
											<input name="button" type="button" onClick="seeAdvice();" class="cms_button"  value="�鿴���">
											
										<%}else if(flag!=null && flag.equals("audit")){%>
											
										<%}else{%>
											
											<%
											}
											%>
										
											<input type="button" value="����" class="cms_button" onClick="back()">
										</div>
									</td>
								                </tr>
						            	  </table>
						            	</td>
						            </tr>
						            <tr>
										<td  width="95%" height="22" colspan="3"  align="center" valign="top">
											<div>
												<input type="hidden" name="content" value="<%=filterStr(document.getContent())%>">
												<input type="hidden" name="pics">
												<input type="hidden" name="flashs">
												<input type="hidden" name="medias">
												<input type="hidden" name="files"><br/>
												 <iframe id="eWebEditor1" src="<%=request.getContextPath()%>/cms/editor/eWebEditor48/ewebeditor.htm?id=content&style=coolblue&cusdir=<%=docpath%>" frameborder="0" scrolling="no" width="95%" height="460">
												</iframe>
											</div>
											<div>
												<input type="hidden" name="doclist">
												<br/><iframe id="docxz" src="<%=request.getContextPath()%>/cms/statisticManage/doc_view_xgdoclist.jsp?flag=1&siteid=<%=siteid%>" frameborder="0" scrolling="auto" width="0%" height="0%">
												</iframe>
											</div>
											<div>
												<input type="hidden" name="originalFilename">
												<input type="hidden" name="description">
												<input type="hidden" name="url">
												<iframe id="docattachlist" src="<%=request.getContextPath()%>/cms/statisticManage/doc_view_attachList.jsp?type=2&docpath=<%=docpath%>" frameborder="0" scrolling="auto" width="0%" height="0%">
												</iframe>
											</div>
											<div>
												<input type="hidden" name="originalFilename2">
												<input type="hidden" name="description2">
												<input type="hidden" name="url2">
												<iframe id="docattachlist2" src="<%=request.getContextPath()%>/cms/statisticManage/doc_view_attachList.jsp?type=3&docpath=<%=docpath%>" frameborder="0" scrolling="auto" width="0%" height="0%">
												</iframe>
											</div>
											<div>
												<input type="hidden" name="fieldids">
												<input type="hidden" name="extfieldvalues">
												<input type="hidden" name="extfieldtypes">
												<iframe id="docextfielslist" src="<%=request.getContextPath()%>/cms/docManage/doc_extfield_list.jsp?type=2&id=<%=channelId%>&docid=<%=docid%>" frameborder="0" scrolling="auto" width="0%" height="0%">
												</iframe>
											</div>
										</td>
						            </tr>						            					            	          
								  <tr>
									<td>&nbsp;</td>
								  </tr>
						          <!--��Դ�ڱ����վ���и�վ��-->
						          <tr>
						              <td height="11" colspan="3" background="<%=request.getContextPath()%>/cms/images/bottom_gray.jpg">&nbsp;</td>
					              </tr>
      </table>
      
	</form>
	
</body>
</html>